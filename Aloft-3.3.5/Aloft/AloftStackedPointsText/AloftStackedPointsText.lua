local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

local _, playerClass = UnitClass("player")
-- if playerClass ~= "ROGUE" and playerClass ~= "DRUID" and playerClass ~= "WARRIOR" then return end

-----------------------------------------------------------------------------

local AloftStackedPointsText = Aloft:NewModule("StackedPointsText", "AceEvent-2.0")
AloftStackedPointsText.dynamic = "AloftStackedPointsText"

-----------------------------------------------------------------------------

-- "comboPointsText" is used for backwards compatibility with SavedVariables
AloftStackedPointsText.db = Aloft:AcquireDBNamespace("comboPointsText")
Aloft:RegisterDefaults("comboPointsText", "profile", {
	enable			= true,
	interval		= 0.33,
	font			= "Arial Narrow",
	fontSize		= 16,
	shadow			= true,
	outline			= "THICKOUTLINE",
	point			= "RIGHT",
	relativeToPoint	= "LEFT",
	offsetX			= 0,
	offsetY			= 0,
	color			= { 0, 1, 1, 1 },
	minColor		= { 1, 0, 0, 1 },
})

-----------------------------------------------------------------------------

local GetTime = GetTime
local UnitAura = UnitAura
local UnitDebuff = UnitDebuff
local GetSpellInfo = GetSpellInfo

local UNIT_DEBUFF_MAX = 40 -- current maximum number of debuffs

local sunderSpellName, _, _, _, _, _, _, _, _		= GetSpellInfo(47467) -- highest rank of sunder, c. 2008/11/25 (WoW 3.0.3)
local lacerateSpellName, _, _, _, _, _, _, _, _	= GetSpellInfo(48568) -- highest rank of lacerate, c. 2008/11/25 (WoW 3.0.3)

local comboPointsTextRegion = nil -- a singleton
local targetNameplate = nil
local profile

-----------------------------------------------------------------------------

function AloftStackedPointsText:Update()
	self:CreateFrame()
	self:RegisterEvents()

	if profile.enable then
		if targetNameplate then
			local layoutFrame = targetNameplate.layoutFrame
			if not layoutFrame then
				layoutFrame = Aloft:AcquireLayoutFrame(targetNameplate)
			end

			comboPointsTextRegion:SetParent(layoutFrame)
			self:PlaceFrame(comboPointsTextRegion, layoutFrame, profile)
		end
	end
end

-----------------------------------------------------------------------------

function AloftStackedPointsText:CreateFrame()
	if not profile.enable then
		if comboPointsTextRegion then
			comboPointsTextRegion:Hide()
		end
		return
	end

	if not comboPointsTextRegion then
		comboPointsTextRegion = UIParent:CreateFontString(nil, "OVERLAY")
	end

	self:PrepareText(comboPointsTextRegion, profile)
end

function AloftStackedPointsText:RegisterEvents()
	if profile.enable then
		-- always look at combo points, some  in-game events enable all classes to use them
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnPlayerTargetChanged")
		self:RegisterEvent("PLAYER_COMBO_POINTS", "OnPlayerComboPoints")
		self:RegisterEvent("UNIT_COMBO_POINTS", "OnUnitComboPoints")

		-- manage show/hide events
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")

		-- class-specific processing
		if playerClass == "DRUID" then
			self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "UpdateTarget")
			self:ScheduleRepeatingEvent("Aloft:UpdateDruid", self.UpdateDruid, profile.interval, self)
		elseif playerClass == "WARRIOR" then
			self:ScheduleRepeatingEvent("Aloft:UpdateWarrior", self.UpdateWarrior, profile.interval, self)
		end
	else
		self:CancelEvent("PLAYER_TARGET_CHANGED")
		self:CancelEvent("PLAYER_COMBO_POINTS")
		self:CancelEvent("UNIT_COMBO_POINTS")

		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnNameplateHide")

		if playerClass == "DRUID" then
			self:CancelEvent("UPDATE_SHAPESHIFT_FORM")
			self:CancelScheduledEvent("Aloft:UpdateDruid")
		elseif playerClass == "WARRIOR" then
			self:CancelScheduledEvent("Aloft:UpdateWarrior")
		end
	end
end

-----------------------------------------------------------------------------

function AloftStackedPointsText:OnInitialize()
	profile = self.db.profile
end

function AloftStackedPointsText:OnEnable()
	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:Update()
		end
	end)

	self:Update()
end

function AloftStackedPointsText:OnDisable()
	self:UnregisterAllEvents()

	if comboPointsTextRegion then
		comboPointsTextRegion:Hide()
	end
end

-----------------------------------------------------------------------------

-- TODO: see if we can tie this to Aloft:AloftIsTargetDataUpdate event, and determine whether to put the next frame delay there
function AloftStackedPointsText:OnPlayerTargetChanged()
	-- next frame delay
	local eventName = "Aloft:ComboPointsUpdate:" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.UpdateTarget, 0.0, self)
end

function AloftStackedPointsText:OnPlayerComboPoints(playerid)
	self:UpdateComboPoints()
end

function AloftStackedPointsText:OnUnitComboPoints(unitid)
	if (unitid == "player") then
		self:UpdateComboPoints()
	end
end

function AloftStackedPointsText:OnNameplateShow(aloftData)
	if not targetNameplate and (aloftData.isTarget or aloftData:IsTarget()) then
		targetNameplate = aloftData

		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end

		comboPointsTextRegion:SetParent(layoutFrame)
		self:PlaceFrame(comboPointsTextRegion, layoutFrame, profile)
		comboPointsTextRegion:Show()
	end
end

function AloftStackedPointsText:OnNameplateHide(aloftData)
	if targetNameplate == aloftData then
		comboPointsTextRegion:Hide()
		comboPointsTextRegion:SetText("")

		targetNameplate = nil
	end
end

-- TODO: event-drive this out of the combat log, somehow?
function AloftStackedPointsText:UpdateDruid()
	if UnitExists("target") and GetShapeshiftForm(true) == 1 then -- bear/dire bear form
		local valid, count, duration, expiration = self:ValidateStackingDebuff("player", "target", lacerateSpellName, nil)
		local color = self:GetCrowdControlColor(count, duration, expiration)
		self:UpdateText(count, color)
	end
	-- don't zap points, we could be in cat form; TODO: refactor this to take over from UpdateComboPoints()? a bit of a hodgepodge at the moment...
end

-- TODO: event-drive this out of the combat log, somehow?
function AloftStackedPointsText:UpdateWarrior()
	if UnitExists("target") then
		local valid, count, duration, expiration = self:ValidateStackingDebuff("player", "target", sunderSpellName, nil)
		local color = self:GetCrowdControlColor(count, duration, expiration)
		self:UpdateText(count, color)
	else
		self:UpdateText(0, profile.color)
	end
end

-- catch all, for when target changes
-- TODO: event-drive this out of the combat log, somehow?
function AloftStackedPointsText:UpdateTarget()
	if not self:UpdateComboPoints() then
		if playerClass == "DRUID" then
			self:UpdateDruid()
		elseif playerClass == "WARRIOR" then
			self:UpdateWarrior()
		else
			self:UpdateText(0, profile.color)
		end
	end
end

-----------------------------------------------------------------------------

-- event handler for combo-point events
-- TODO: event-drive this out of the combat log, somehow?
function AloftStackedPointsText:UpdateComboPoints()
	local points = 0
	-- TODO: refactor this?
	if UnitExists("target") and (playerClass ~= "DRUID" or GetShapeshiftForm(true) == 3) then
		points = self:GetComboPoints("player", "target")
		self:UpdateText(points, profile.color)
	else
		self:UpdateText(points, profile.color)
	end
	return points > 0
end

function AloftStackedPointsText:UpdateText(points, color)
	local newTargetNameplate = Aloft:GetTargetNameplate()

	if newTargetNameplate then
		if (newTargetNameplate ~= targetNameplate) then
			-- new target has been acquired
			targetNameplate = newTargetNameplate

			local layoutFrame = targetNameplate.layoutFrame
			if not layoutFrame then
				layoutFrame = Aloft:AcquireLayoutFrame(targetNameplate)
			end

			comboPointsTextRegion:SetParent(layoutFrame)
			self:PlaceFrame(comboPointsTextRegion, layoutFrame, profile)
		end
	else
		targetNameplate = nil
	end

	if points > 0 then
		local text = ("|c%02x%02x%02x%02x%s|r"):format(color[4]*255, color[1]*255, color[2]*255, color[3]*255, tostring(points))
		comboPointsTextRegion:SetText(text)
		comboPointsTextRegion:Show()
	else
		comboPointsTextRegion:SetText("")
		comboPointsTextRegion:Hide()
	end
end

-----------------------------------------------------------------------------

function AloftStackedPointsText:GetComboPoints(originid, targetid)
	return GetComboPoints(originid, targetid)
end

-----------------------------------------------------------------------------

-- determine some incremental intermediate color between profile.color/profile.minColor that is representative of the remaining duration of the stacking debuff
function AloftStackedPointsText:GetCrowdControlColor(count, duration, expiration)
	local fraction = 1 - ((expiration - GetTime()) / duration)
	
	local r = profile.color[1] - ((profile.color[1] - profile.minColor[1]) * fraction)
	local g = profile.color[2] - ((profile.color[2] - profile.minColor[2]) * fraction)
	local b = profile.color[3] - ((profile.color[3] - profile.minColor[3]) * fraction)
	local a = profile.color[4] - ((profile.color[4] - profile.minColor[4]) * fraction)

	return { r, g, b, a }
end

-- collects debuffs a couple of different ways
-- NOTE: this is coded this way, with a name/rank query first, but currently is not called with a non-nil spell rank; currently, this will always fall through to the 40-debuff-slot loop
function AloftStackedPointsText:ValidateStackingDebuff(unitid, targetid, spellName, spellRank)
	-- ChatFrame7:AddMessage("AloftStackedPointsText:ValidateStackingDebuff(): " .. tostring(targetid) .. "/" .. tostring(spellName))
	if spellName and spellRank then
		local name, rank, _, count, _, duration, expiration, caster, _  =  UnitAura(targetid, spellName, spellRank, "HARMFUL|PLAYER")
		-- ChatFrame7:AddMessage("AloftStackedPointsText:ValidateStackingDebuff(): " .. tostring(name) .. "/" .. tostring(caster) .. "/" .. tostring(count) .. "/" .. tostring(duration) .. "/" .. tostring(expiration))
		if name and rank and caster and (type(caster) ~= "string" or caster == "player") and duration and name == spellName and rank == spellRank then
			-- the player has the expected debuff on the given unit
			return true, count, duration, expiration
		end
	end
	for i = 1, UNIT_DEBUFF_MAX do
		local name, rank, _, count, _, duration, expiration, caster, _  =  UnitAura(targetid, i, "HARMFUL|PLAYER")
		if not name then break end -- end of debuffs has been reached
		if name and caster and (type(caster) ~= "string" or caster == "player") and duration and name == spellName and (not spellRank or rank == spellRank) then
			-- the player has the expected debuff on the given unit
			-- ChatFrame7:AddMessage("AloftStackedPointsText:ValidateStackingDebuff(): slow " .. tostring(name) .. "/" .. tostring(count) .. "/" .. tostring(duration) .. "/" .. tostring(expiration))
			return true, count, duration, expiration
		end
	end
	return false, 0, 0, 0
end

-----------------------------------------------------------------------------

end)
