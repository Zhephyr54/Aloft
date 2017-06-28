local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

local AloftCombatText = Aloft:NewModule("CombatText", "AceEvent-2.0")
AloftCombatText.dynamic = "AloftCombatText"

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData") -- always on
local SML = AceLibrary("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

-- needs to be maintained to match the definitions in AloftCombatTextOptions.lua; these are lifted loosely from Blizzard(tm); Interface\AddOns\Blizzard_CombatLog\Blizzard_CombatLog.lua (i.e. Blizzard combat log processing)
local SPELL_COLOR_NONE		= { 1.00, 1.00, 1.00, }	-- this is an imaginary color for spells with no known school (a medium gray)
local SPELL_COLOR_PHYSICAL	= { 0.80, 0.60, 0.40, }	-- basically the warrior class color
local SPELL_COLOR_HOLY		= { 1.00, 0.90, 0.50, }
local SPELL_COLOR_FIRE		= { 1.00, 0.00, 0.00, }	-- red
local SPELL_COLOR_NATURE	= { 0.30, 1.00, 0.30, }
local SPELL_COLOR_FROST	= { 0.50, 1.00, 1.00, }
local SPELL_COLOR_SHADOW	= { 0.50, 0.50, 1.00, }	-- basically the warlock class color
local SPELL_COLOR_ARCANE	= { 1.00, 0.50, 1.00, }
local SPELL_COLOR_HEAL		= { 1.00, 0.50, 0.00, }	-- this is an imaginary catch-all color for healing spells (yellow-orange)
local SPELL_COLOR_ENERGIZE	= { 0.41, 0.80, 0.94, }	-- for energize activity

-----------------------------------------------------------------------------

AloftCombatText.db = Aloft:AcquireDBNamespace("combatText")
Aloft:RegisterDefaults("combatText", "profile", {
	enable			= true, -- employed by Aloft:PlaceFrame(); not exposed as an option
	enableTarget	= true,
	enableGroup		= false,
	enableOther		= false,
	effectPlayer	= true,
	effectGroup		= false,
	effectOther		= false,
	overHealing		= false,
	alpha			= 0.75,
	point			= "CENTER",
	relativeToPoint	= "CENTER",
	offsetX			= 0,
	offsetY			= 0,
	font			= "Friz Quadrata TT",
	fontSize		= 16,
	shadow			= false,
	outline			= "OUTLINE",
	colors =
	{
		[1]			= SPELL_COLOR_PHYSICAL,		-- Physical
		[2]			= SPELL_COLOR_HOLY,  		-- Holy
		[4]			= SPELL_COLOR_FIRE,			-- Fire
		[8]			= SPELL_COLOR_NATURE,		-- Nature
		[16]		= SPELL_COLOR_FROST,		-- Frost,
		[32]		= SPELL_COLOR_SHADOW,		-- Shadow
		[64]		= SPELL_COLOR_ARCANE,		-- Arcane

		energize	= SPELL_COLOR_ENERGIZE,
		text		= SPELL_COLOR_NONE,
		heal		= SPELL_COLOR_HEAL,
	},
})

-----------------------------------------------------------------------------

-- local textRegionPool = { }
local updateList = { }
local profile
local colors

-----------------------------------------------------------------------------

function AloftCombatText:RegisterEvents()
	if profile and (profile.enableTarget or profile.enableGroup or profile.enableOther) then
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnPlayerTargetChanged")
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "OnCombatLogEvent")

		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	else
		self:CancelEvent("PLAYER_TARGET_CHANGED")
		self:CancelEvent("COMBAT_LOG_EVENT_UNFILTERED")

		self:CancelEvent("Aloft:OnNameplateHide")
	end
end

function AloftCombatText:RequiresData()
	if profile and profile.enableGroup then
		return "unitid"
	end
end

-----------------------------------------------------------------------------

function AloftCombatText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if profile and (profile.enableTarget or profile.enableGroup or profile.enableOther) then
			local layoutFrame = aloftData.layoutFrame
			if layoutFrame then
				local combatTextRegion = layoutFrame.combatTextRegion
				if combatTextRegion then
					self:PlaceFrame(combatTextRegion, layoutFrame, profile)
					self:PrepareText(combatTextRegion, profile)
				end
			end
		else
			self:OnNameplateHide(aloftData)
		end
	end
	for layoutFrame in pairs(Aloft.layoutFramePool) do
		local combatTextRegion = layoutFrame.combatTextRegion
		if combatTextRegion then
			self:PrepareText(combatTextRegion, profile)
			self:PlaceFrame(combatTextRegion, layoutFrame, profile)
		end
	end
	self:RegisterEvents()
end

function AloftCombatText:Update()
	local now = GetTime()

	for aloftData, startTime in pairs(updateList) do
		local layoutFrame = aloftData.layoutFrame
		local combatTextRegion = layoutFrame and layoutFrame.combatTextRegion

		if combatTextRegion then
			local elapsedTime = now - startTime
			if elapsedTime < COMBATFEEDBACK_FADEINTIME then
				combatTextRegion:SetAlpha(profile.alpha*(elapsedTime / COMBATFEEDBACK_FADEINTIME))
			elseif elapsedTime < (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME) then
				combatTextRegion:SetAlpha(profile.alpha)
			elseif elapsedTime < (COMBATFEEDBACK_FADEINTIME + COMBATFEEDBACK_HOLDTIME + COMBATFEEDBACK_FADEOUTTIME) then
				combatTextRegion:SetAlpha(profile.alpha * (1 - (elapsedTime - COMBATFEEDBACK_HOLDTIME - COMBATFEEDBACK_FADEINTIME) / COMBATFEEDBACK_FADEOUTTIME))
			else
				combatTextRegion:Hide()
				updateList[aloftData] = nil
			end
		end
	end

	if not next(updateList) then
		self:CancelScheduledEvent("AloftCombatText:Update")
	end
end

-----------------------------------------------------------------------------

function AloftCombatText:OnInitialize()
	profile = self.db.profile
	colors = profile.colors
end

function AloftCombatText:OnEnable()
	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:UpdateAll()
		end
	end)

	self:UpdateAll()
end

function AloftCombatText:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateHide(aloftData)
	end
end

-----------------------------------------------------------------------------

local playerTargetGUId = nil
function AloftCombatText:GetPlayerTargetGUId()
	if not playerTargetGUId then playerTargetGUId = UnitGUID("target") end
	return playerTargetGUId
end

function AloftCombatText:OnPlayerTargetChanged()
	playerTargetGUId = nil
end

function AloftCombatText:OnNameplateHide(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local combatTextRegion = layoutFrame and layoutFrame.combatTextRegion
	if combatTextRegion then
		combatTextRegion:Hide()
		combatTextRegion:SetText("")

		if not next(updateList) then
			self:CancelScheduledEvent("AloftCombatText:Update")
		end
	end
end

-----------------------------------------------------------------------------

function AloftCombatText:PostCombatText(aloftData, text, scale, color)
	-- if not text or not scale or not color then
		-- ChatFrame7:AddMessage("AloftCombatText:PostCombatText(): NIL " .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale) .. "/" .. tostring(color))
		-- ChatFrame7:AddMessage("AloftCombatText:PostCombatText(): " .. debugstack())
		-- return
	-- end

	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	local combatTextRegion = layoutFrame.combatTextRegion

	if not combatTextRegion then
		combatTextRegion = aloftData:CreateFontString()
		combatTextRegion:SetParent(layoutFrame)

		layoutFrame.combatTextRegion = combatTextRegion

		self:PlaceFrame(combatTextRegion, layoutFrame, profile)
	end

	-- The line below used to crash the Windows WoW client sporadically (not the Mac one). A simple SetTextHeight was used instead.
	combatTextRegion:SetFont(SML:Fetch("font", profile.font), floor((profile.fontSize * scale) + 0.5), profile.outline)
	-- combatTextRegion:SetTextHeight(profile.fontSize * scale)

	combatTextRegion:SetText(text)
	combatTextRegion:SetTextColor(unpack(color or colors.text))
	combatTextRegion:SetAlpha(0)
	combatTextRegion:Show()

	updateList[aloftData] = GetTime()
	self:ScheduleRepeatingEvent("AloftCombatText:Update", self.Update, 0.05, self)
	-- ChatFrame7:AddMessage("AloftCombatText:PostCombatText(): show " .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(layoutFrame.combatTextRegion:GetText()))
	return
end

-----------------------------------------------------------------------------

local function formatSchool(str, school)
	local color = colors[school] or colors.text
	return ("|cff%02x%02x%02x%s|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255), tostring(str))
end

local function formatDamage(str, resisted, blocked, absorbed, critical, glancing, crushing)
	local r
	local g
	local b
	local s
	if glancing == 1 then
		-- gray
		r = 127
		g = 127
		b = 127
		s = "GLANCING"
	elseif resisted == 1 then
		-- green
		r = 0
		g = 255
		b = 0
		s = "RESIST"
	elseif blocked == 1 then
		-- blue
		r = 0
		g = 0
		b = 255
		s = "BLOCK"
	elseif absorbed == 1 then
		-- cyan
		r = 0
		g = 255
		b = 255
		s = "ABSORB"
	elseif critical == 1 then
		-- magenta
		r = 255
		g = 0
		b = 255
		s = "CRITICAL"
	elseif crushing == 1 then
		-- yellow
		r = 255
		g = 255
		b = 0
		s = "CRUSHING"
	else
		-- white
		r = 255
		g = 255
		b = 255
		s = "NORMAL"
	end

	return ("|cff%02x%02x%02x%s|r"):format(r, g, b, tostring(str) .. "/" .. s)
end

local function formatMissed(str, missType)
	return ("|cff%02x%02x%02x%s|r"):format(255, 0, 0, tostring(str) .. "/" .. tostring(CombatFeedbackText[missType]))
end

-----------------------------------------------------------------------------
-- ("|cff%02x%02x%02x%s|r"):format(floor(a*255), floor(r*255), floor(g*255), floor(b*255), str)
-----------------------------------------------------------------------------

local function getDamageText(school, amount, resisted, blocked, absorbed, critical, glancing, crushing)
	-- if amount and type(amount) ~= "number" then
		-- ChatFrame7:AddMessage("AloftCombatText:getDamageText(): no amount " .. tostring(powerType) .. "/" .. tostring(critical))
		-- return nil, nil, nil
	-- end

	if amount and amount > 0 then
		if critical == 1 or crushing == 1 then
			return "-" .. tostring(amount), 1.5, (school and colors[school]) or colors.text
		elseif glancing == 1 then
			return "-" .. tostring(amount), 0.75, (school and colors[school]) or colors.text
		else
			return "-" .. tostring(amount), 1.0, (school and colors[school]) or colors.text
		end
	else
		if absorb == 1 then
			return CombatFeedbackText["ABSORB"], 0.75, colors.text
		elseif blocked == 1 then
			return CombatFeedbackText["BLOCK"], 0.75, colors.text
		elseif resisted == 1 then
			return CombatFeedbackText["RESIST"], 0.75, colors.text
		end
	end
	return nil, nil, nil
end

local function getEnergizeText(powerType, amount, critical)
	-- if not amount or type(amount) ~= "number" then
		-- ChatFrame7:AddMessage("AloftCombatText:getEnergizeText(): no amount " .. tostring(powerType) .. "/" .. tostring(critical))
		-- return nil, nil, nil
	-- end

	if critical == 1 then
		return ">" .. tostring(amount), 1.3, colors.energize
	else
		return ">" .. tostring(amount), 1.0, colors.energize
	end
	return nil, nil, nil
end

local function getHealText(school, amount, overheal, critical)
	-- if amount and type(amount) ~= "number" then
		-- ChatFrame7:AddMessage("AloftCombatText:getHealText(): no amount " .. tostring(school) .. "/" .. tostring(overheal) .. "/" .. tostring(critical))
		-- return nil, nil, nil
	-- end

	local healing = (profile.overHealing and amount) or (amount - overheal)
	if critical == 1 then
		return "+" .. tostring(healing), 1.3, colors.heal
	else
		return "+" .. tostring(healing), 1.0, colors.heal
	end
	return nil, nil, nil
end

local function getMissText(amount, missType)
	if missType ~= "IMMUNE" then
		return CombatFeedbackText[missType], 0.75, colors.text
	else
		return CombatFeedbackText["IMMUNE"], 0.75, colors.text
	end
	return nil, nil, nil
end

-----------------------------------------------------------------------------

-- determine whether we should display combat text for a log event, based on origin
local function filterEventOrigin(originGUId)
	if originGUId == Aloft:GetPlayerGUId() then
		if not profile.effectPlayer then
			return nil
		end
	elseif AloftTargetTrackingData:GetGUIdUnitid(originGUId) then
		if not profile.effectGroup then
			return nil
		end
	elseif not profile.effectOther then
		return nil
	end

	return true
end

-- determine whether we should display combat text for a log event, based on target
local function filterEventTarget(targetGUId)
	if targetGUId == AloftCombatText:GetPlayerTargetGUId() then
		if not profile.enableTarget then
			return nil
		end
	elseif AloftTargetTrackingData:GetGUIdUnitid(targetGUId) then
		if not profile.enableGroup then
			return nil
		end
	elseif not profile.enableOther then
		return nil
	end

	return true
end

-- determine whether we should display combat text for a log event, based on the type and amount of healing
local function filterEventOverhealing(amount, overhealing)
	if not profile.overHealing and amount - overhealing <= 0 then
		return nil -- the whole event was overhealing, don't show anything
	end

	return true -- either we are showing overhealing, or there was some "real" healing (it was not all overhealing)
end

-----------------------------------------------------------------------------

local function getNameplate(targetGUId, targetName, nameplateId)
	if targetGUId == AloftCombatText:GetPlayerTargetGUId() then
		return Aloft:GetTargetNameplate(targetName)
	elseif nameplateId then
		local nameplates = Aloft:GetNamedNameplates(targetName)
		if nameplates then
			for aloftData in pairs(nameplates) do
				if nameplateId == AloftTargetTrackingData:GetNameplateId(aloftData) then
					return aloftData
				end
			end
		else
			-- ChatFrame7:AddMessage("AloftCombatText:getNameplate(): no nameplates " .. tostring(targetName) .. "/" .. tostring(nameplateId))
		end
	else
		-- ChatFrame7:AddMessage("AloftCombatText:getNameplate(): no nameplateId " .. tostring(targetName))
	end
	return nil
end

-----------------------------------------------------------------------------

local function swing_damage(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	if school ~= 1 then
		ChatFrame7:AddMessage("AloftCombatText:swing_damage(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName)
			.. "/" .. formatSchool(tostring(school), school) .. "/" .. formatDamage(tostring(amount) .. "/" .. tostring(overkill), resisted, blocked, absorbed, critical, glancing, crushing)
			.. "/" .. tostring(resisted) .. "/" .. tostring(blocked) .. "/" .. tostring(absorbed) .. "/" .. tostring(critical) .. "/" .. tostring(glancing) .. "/" .. tostring(crushing))
	end

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:swing_damage(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		-- no spell used on straight swing damage; treat this as "white" damage
		local text, scale, color = getDamageText(nil, amount, resisted, blocked, absorbed, critical, glancing, crushing)
		-- ChatFrame7:AddMessage("AloftCombatText:swing_damage(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

local function swing_energize(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, amount, powerType)
	-- ChatFrame7:AddMessage("AloftCombatText:swing_energize(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. tostring(amount) .. "/" .. tostring(powerType))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:swing_energize(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getEnergizeText(powerType, amount, nil)
		-- ChatFrame7:AddMessage("AloftCombatText:swing_energize(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

local function swing_missed(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, missType, amountMissed)
	-- ChatFrame7:AddMessage("AloftCombatText:swing_missed(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName)
		-- .. "/" .. formatMissed(tostring(missType) .. "/" .. tostring(amountMissed), missType))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:swing_missed(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getMissText(amountMissed, missType)
		-- ChatFrame7:AddMessage("AloftCombatText:swing_missed(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

-----------------------------------------------------------------------------

local function range_damage(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, spellDamage, spellOverkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	if spellId ~= 5019 and school ~= 1 then
		ChatFrame7:AddMessage("AloftCombatText:range_damage(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool)
			.. "/" .. formatSchool(tostring(school), school) .. "/" .. formatDamage(tostring(spellDamage) .. "/" .. tostring(spellOverkill), resisted, blocked, absorbed, critical, glancing, crushing)
			.. "/" .. tostring(resisted) .. "/" .. tostring(blocked) .. "/" .. tostring(absorbed) .. "/" .. tostring(critical) .. "/" .. tostring(glancing) .. "/" .. tostring(crushing))
	end

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:range_damage(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		-- except for wand "shoot" (spellid 5019), it appears spell_damage/etc is used for "skills"; except for wand "shoot" (spellid 5019), treat this as "white" damage
		local text, scale, color = getDamageText((spellId == 5019 and school) or nil, spellDamage, resisted, blocked, absorbed, critical, glancing, crushing)
		-- ChatFrame7:AddMessage("AloftCombatText:range_damage(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

local function range_energize(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, amount, powerType, suffix6, suffix7, suffix8, suffix9, suffix10, suffix11, suffix12)
	-- ChatFrame7:AddMessage("AloftCombatText:range_energize(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. tostring(amount) .. "/" .. tostring(powerType)
		-- .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool) .. "/" .. tostring(suffix6) .. "/" .. tostring(suffix7) .. "/" .. tostring(suffix8) .. "/" .. tostring(suffix9) .. "/" .. tostring(suffix10) .. "/" .. tostring(suffix11) .. "/" .. tostring(suffix12))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:range_energize(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getEnergizeText(powerType, amount, nil)
		-- ChatFrame7:AddMessage("AloftCombatText:range_energize(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

local function range_missed(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, missType, amountMissed)
	-- ChatFrame7:AddMessage("AloftCombatText:range_missed(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool)
		-- .. "/" .. formatMissed(tostring(missType) .. "/" .. tostring(amountMissed), missType))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:range_missed(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getMissText(amountMissed, missType)
		-- ChatFrame7:AddMessage("AloftCombatText:range_missed(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

-----------------------------------------------------------------------------

local function spell_damage(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, spellDamage, spellOverkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	-- ChatFrame7:AddMessage("AloftCombatText:spell_damage(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool)
		-- .. "/" .. formatSchool(tostring(school), school) .. "/" .. formatDamage(tostring(spellDamage) .. "/" .. tostring(spellOverkill), resisted, blocked, absorbed, critical, glancing, crushing)
		-- .. "/" .. tostring(resisted) .. "/" .. tostring(blocked) .. "/" .. tostring(absorbed) .. "/" .. tostring(critical) .. "/" .. tostring(glancing) .. "/" .. tostring(crushing))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:spell_damage(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getDamageText(school, spellDamage, resisted, blocked, absorbed, critical, glancing, crushing)
		-- ChatFrame7:AddMessage("AloftCombatText:spell_damage(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

local function spell_energize(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, amount, powerType, suffix6, suffix7, suffix8, suffix9, suffix10, suffix11, suffix12)
	-- ChatFrame7:AddMessage("AloftCombatText:spell_energize(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. tostring(amount) .. "/" .. tostring(powerType)
		-- .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool) .. "/" .. tostring(suffix6) .. "/" .. tostring(suffix7) .. "/" .. tostring(suffix8) .. "/" .. tostring(suffix9) .. "/" .. tostring(suffix10) .. "/" .. tostring(suffix11) .. "/" .. tostring(suffix12))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:spell_energize(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getEnergizeText(powerType, amount, nil)
		-- ChatFrame7:AddMessage("AloftCombatText:spell_energize(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

local function spell_heal(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, amount, overhealing, critical)
	-- ChatFrame7:AddMessage("AloftCombatText:spell_heal(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool)
		-- .. "/" .. tostring(amount) .. "/" .. tostring(overhealing) .. "/" .. tostring(critical))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) or not filterEventOverhealing(amount, overhealing) then
		-- ChatFrame7:AddMessage("AloftCombatText:spell_heal(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getHealText(spellSchool, amount, overhealing, critical)
		-- ChatFrame7:AddMessage("AloftCombatText:spell_heal(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	else
		-- ChatFrame7:AddMessage("AloftCombatText:spell_heal(): no nameplate " .. tostring(targetName) .. "/" .. tostring(targetGUId))
	end
end

local function spell_missed(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, missType, amountMissed)
	-- ChatFrame7:AddMessage("AloftCombatText:spell_missed(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool)
		-- .. "/" .. formatMissed(tostring(missType) .. "/" .. tostring(amountMissed), missType))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:spell_missed(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getMissText(amountMissed, missType)
		-- ChatFrame7:AddMessage("AloftCombatText:spell_missed(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

-----------------------------------------------------------------------------

local function spell_periodic_damage(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, spellDamage, spellOverkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_damage(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool)
		-- .. "/" .. formatSchool(tostring(school), school) .. "/" .. formatDamage(tostring(spellDamage) .. "/" .. tostring(spellOverkill), resisted, blocked, absorbed, critical, glancing, crushing)
		-- .. "/" .. tostring(resisted) .. "/" .. tostring(blocked) .. "/" .. tostring(absorbed) .. "/" .. tostring(critical) .. "/" .. tostring(glancing) .. "/" .. tostring(crushing))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_damage(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getDamageText(school, spellDamage, resisted, blocked, absorbed, critical, glancing, crushing)
		-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_damage(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

local function spell_periodic_energize(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, amount, powerType, suffix6, suffix7, suffix8, suffix9, suffix10, suffix11, suffix12)
	-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_energize(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. tostring(amount) .. "/" .. tostring(powerType)
		-- .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool) .. "/" .. tostring(suffix6) .. "/" .. tostring(suffix7) .. "/" .. tostring(suffix8) .. "/" .. tostring(suffix9) .. "/" .. tostring(suffix10) .. "/" .. tostring(suffix11) .. "/" .. tostring(suffix12))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_energize(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getEnergizeText(powerType, amount, nil)
		-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_energize(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

local function spell_periodic_heal(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, amount, overhealing, critical)
	-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_heal(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool)
		-- .. "/" .. tostring(amount) .. "/" .. tostring(overhealing) .. "/" .. tostring(critical))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) or not filterEventOverhealing(amount, overhealing) then
		-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_heal(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getHealText(spellSchool, amount, overhealing, critical)
		-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_heal(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	else
		-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_heal(): no nameplate " .. tostring(targetName) .. "/" .. tostring(targetGUId))
	end
end

local function spell_periodic_missed(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, missType, amountMissed)
	-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_missed(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. formatSchool(tostring(spellSchool), spellSchool))
		-- .. "/" .. formatMissed(tostring(missType) .. "/" .. tostring(amountMissed), missType))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_missed(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getMissText(amountMissed, missType)
		-- ChatFrame7:AddMessage("AloftCombatText:spell_periodic_missed(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

-----------------------------------------------------------------------------

local function damage_shield(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, spellDamage, spellOverkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	-- ChatFrame7:AddMessage("AloftCombatText:damage_shield(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool)
		-- .. "/" .. formatSchool(tostring(school), school) .. "/" .. formatDamage(tostring(spellDamage) .. "/" .. tostring(spellOverkill), resisted, blocked, absorbed, critical, glancing, crushing)
		-- .. "/" .. tostring(resisted) .. "/" .. tostring(blocked) .. "/" .. tostring(absorbed) .. "/" .. tostring(critical) .. "/" .. tostring(glancing) .. "/" .. tostring(crushing))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:damage_shield(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getDamageText(school, spellDamage, resisted, blocked, absorbed, critical, glancing, crushing)
		if not text or not scale or not color then
			ChatFrame7:AddMessage("AloftCombatText:damage_shield(): ERROR ERROR ERROR " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool)
				.. "/" .. formatSchool(tostring(school), school) .. "/" .. formatDamage(tostring(spellDamage) .. "/" .. tostring(spellOverkill), resisted, blocked, absorbed, critical, glancing, crushing)
				.. "/" .. tostring(resisted) .. "/" .. tostring(blocked) .. "/" .. tostring(absorbed) .. "/" .. tostring(critical) .. "/" .. tostring(glancing) .. "/" .. tostring(crushing))
		else
			-- ChatFrame7:AddMessage("AloftCombatText:damage_shield(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
				-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
			AloftCombatText:PostCombatText(aloftData, text, scale, color)
		end
	end
end

local function damage_shield_missed(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, missType, amountMissed)
	-- ChatFrame7:AddMessage("AloftCombatText:damage_shield_missed(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool)
		-- .. "/" .. formatMissed(tostring(missType) .. "/" .. tostring(amountMissed), missType))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:damage_shield_missed(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getMissText(amountMissed, missType)
		-- ChatFrame7:AddMessage("AloftCombatText:damage_shield_missed(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

-----------------------------------------------------------------------------

-- TODO: cannot find what generates this event, some commentary on the web indicates that it is commented out in the Blizzard combat log, should research this
local function damage_split(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, spellId, spellName, spellSchool, spellDamage, spellOverkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	-- ChatFrame7:AddMessage("AloftCombatText:damage_split(): " .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. formatSchool(tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellSchool), spellSchool)
		-- .. "/" .. formatSchool(tostring(school), school) .. "/" .. formatDamage(tostring(spellDamage) .. "/" .. tostring(spellOverkill), resisted, blocked, absorbed, critical, glancing, crushing)
		-- .. "/" .. tostring(resisted) .. "/" .. tostring(blocked) .. "/" .. tostring(absorbed) .. "/" .. tostring(critical) .. "/" .. tostring(glancing) .. "/" .. tostring(crushing))

	if not filterEventOrigin(originGUId) or not filterEventTarget(targetGUId) then
		-- ChatFrame7:AddMessage("AloftCombatText:damage_split(): filtered event")
		return
	end

	local aloftData = getNameplate(targetGUId, targetName, AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, true))
	if aloftData then
		local text, scale, color = getDamageText(school, spellDamage, resisted, blocked, absorbed, critical, glancing, crushing)
		-- ChatFrame7:AddMessage("AloftCombatText:damage_split(): post " .. tostring(targetName) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(scale)
			-- .. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(color[1]*255), floor(color[2]*255), floor(color[3]*255)))
		AloftCombatText:PostCombatText(aloftData, text, scale, color)
	end
end

-----------------------------------------------------------------------------

local subtypeDispatchMethods =
{
	-- prefix: SWING_
	["SWING_DAMAGE"]			= swing_damage,
	["SWING_ENERGIZE"]			= swing_energize,
	["SWING_MISSED"]			= swing_missed,

	-- prefix: RANGE_
	["RANGE_DAMAGE"]			= range_damage,
	["RANGE_ENERGIZE"]			= range_energize,
	["RANGE_MISSED"]			= range_missed,

	-- prefix: SPELL_
	["SPELL_DAMAGE"]			= spell_damage,
	["SPELL_ENERGIZE"]			= spell_energize,
	["SPELL_HEAL"]				= spell_heal,
	["SPELL_MISSED"]			= spell_missed,

	-- prefix: SPELL_PERIODIC_
	["SPELL_PERIODIC_DAMAGE"]	= spell_periodic_damage,
	["SPELL_PERIODIC_ENERGIZE"]	= spell_periodic_energize,
	["SPELL_PERIODIC_HEAL"]		= spell_periodic_heal,
	["SPELL_PERIODIC_MISSED"]	= spell_periodic_missed,

	-- prefix: DAMAGE_
	["DAMAGE_SHIELD"]			= damage_shield,
	["DAMAGE_SHIELD_MISSED"]	= damage_shield_missed,

	-- unknown
	["DAMAGE_SPLIT"]			= damage_split,
}

-----------------------------------------------------------------------------

-- COMBAT_LOG_* event handling; this is intended to replace UNIT_COMBAT event handling at some point, at least the "WOUND" event, so we can differentiate swing/"white" damage from spell damage
function AloftCombatText:OnCombatLogEvent(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, suffix1, suffix2, suffix3, suffix4, suffix5, suffix6, suffix7, suffix8, suffix9, suffix10, suffix11, suffix12)
	-- ChatFrame7:AddMessage(("|cff%02x%02x%02x%s|r"):format(255, 255, 0, "AloftCombatText:OnCombatLogEvent(): ") .. tostring(timestamp) .. "/" .. tostring(subtype) .. "/" .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(originFlags) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. tostring(targetFlags)
		-- .. "/" .. tostring(suffix1) .. "/" .. tostring(suffix2) .. "/" .. tostring(suffix3) .. "/" .. tostring(suffix4) .. "/" .. tostring(suffix5) .. "/" .. tostring(suffix6) .. "/" .. tostring(suffix7) .. "/" .. tostring(suffix8) .. "/" .. tostring(suffix9) .. "/" .. tostring(suffix10) .. "/" .. tostring(suffix11) .. "/" .. tostring(suffix12))

	if targetGUId ~= Aloft:GetPlayerGUId() then
		dispatchMethod = subtypeDispatchMethods[subtype]
		if dispatchMethod then
			dispatchMethod(timestamp, subtype, originGUId, originName, originFlags, targetGUId, targetName, targetFlags, suffix1, suffix2, suffix3, suffix4, suffix5, suffix6, suffix7, suffix8, suffix9, suffix10, suffix11, suffix12)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCombatText:DumpOnUnitCombat(color, unit, event, flags, amount, typ)
	ChatFrame7:AddMessage("AloftCombatText:DumpOnUnitCombat(): " .. tostring(unit) .. "/" .. tostring(event) .. "/" .. tostring(flags) .. "/" .. tostring(amount) .. "/" .. tostring(typ))
	ChatFrame7:AddMessage("AloftCombatText:DumpOnUnitCombat(): " .. tostring(color[1]) .. "-" .. tostring(color[2]) .. "-" .. tostring(color[3]) .. "-" .. tostring(profile.alpha)
		.. "/" .. floor(255*color[1]) .. "." .. floor(255*color[2]) .. "." .. floor(255*color[3]) .. "." .. floor(255*profile.alpha)
		.. "/" .. ("|c%02x%02x%02x%02xcombat text|r"):format(floor(255*profile.alpha), floor(255*color[1]), floor(255*color[2]), floor(255*color[3])))
end

-----------------------------------------------------------------------------

-- Blizzard's logic from WoW 3.2 | Interface/FrameXML/CombatFeedbackText.lua (2009/10/11)
--[[
function CombatFeedback_OnCombatEvent(self, event, flags, amount, type)
	local feedbackText = self.feedbackText;
	local fontHeight = self.feedbackFontHeight;
	local text = "";
	local r = 1.0;
	local g = 1.0;
	local b = 1.0;

	if( event == "IMMUNE" ) then
		fontHeight = fontHeight * 0.5;
		text = CombatFeedbackText[event];
	elseif ( event == "WOUND" ) then
		if ( amount ~= 0 ) then
			if ( flags == "CRITICAL" or flags == "CRUSHING" ) then
				fontHeight = fontHeight * 1.5;
			elseif ( flags == "GLANCING" ) then
				fontHeight = fontHeight * 0.75;
			end
			if ( type ~= SCHOOL_MASK_PHYSICAL ) then
				r = 1.0;
				g = 1.0;
				b = 0.0;
			end
			text = amount;
		elseif ( flags == "ABSORB" ) then
			fontHeight = fontHeight * 0.75;
			text = CombatFeedbackText["ABSORB"];
		elseif ( flags == "BLOCK" ) then
			fontHeight = fontHeight * 0.75;
			text = CombatFeedbackText["BLOCK"];
		elseif ( flags == "RESIST" ) then
			fontHeight = fontHeight * 0.75;
			text = CombatFeedbackText["RESIST"];
		else
			text = CombatFeedbackText["MISS"];
		end
	elseif ( event == "BLOCK" ) then
		fontHeight = fontHeight * 0.75;
		text = CombatFeedbackText[event];
	elseif ( event == "HEAL" ) then
		text = amount;
		r = 0.0;
		g = 1.0;
		b = 0.0;
		if ( flags == "CRITICAL" ) then
			fontHeight = fontHeight * 1.5;
		end
	elseif ( event == "ENERGIZE" ) then
		text = amount;
		r = 0.41;
		g = 0.8;
		b = 0.94;
		if ( flags == "CRITICAL" ) then
			fontHeight = fontHeight * 1.5;
		end
	else
		text = CombatFeedbackText[event];
	end

	self.feedbackStartTime = GetTime();

	feedbackText:SetTextHeight(fontHeight);
	feedbackText:SetText(text);
	feedbackText:SetTextColor(r, g, b);
	feedbackText:SetAlpha(0.0);
	feedbackText:Show();
end
]]

end)
