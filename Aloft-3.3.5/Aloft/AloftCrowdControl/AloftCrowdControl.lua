local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local _, playerClass = UnitClass("player")
if playerClass ~= "MAGE" and playerClass ~= "PRIEST" and playerClass ~= "WARLOCK" and playerClass ~= "DRUID" and playerClass ~= "ROGUE"  and playerClass ~= "SHAMAN" then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("TargetTrackingData") then return end

AloftCrowdControl = Aloft:NewModule("CrowdControl", "AceEvent-2.0")
AloftCrowdControl.dynamic = "AloftCrowdControl"

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData")
local AloftClassData = Aloft:HasModule("ClassData") and Aloft:GetModule("ClassData")
local SML = AceLibrary("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftCrowdControl.db = Aloft:AcquireDBNamespace("polymorph")
Aloft:RegisterDefaults("polymorph", "profile", {
	enable				= true,
	speculativeAttach	= true,
	texture				= "Blizzard",
	targetOnly			= true,
	border				= "None",
	borderColor			= { 1, 1, 1, 1 },
	offsets =
	{
		left			= 0,
		right			= 0,
		vertical		= -22,
	},
	height				= 10,
	color				= { 1, 1, 1, 1 },
	backdropColor		= { 0.25, 0.25, 0.25, 0.50 },
})

-----------------------------------------------------------------------------

local GetTime = GetTime
local UnitName = UnitName
local UnitLevel = UnitLevel
local UnitAura = UnitAura
local UnitDebuff = UnitDebuff
local GetSpellInfo = GetSpellInfo
local CreateFrame = CreateFrame

local interval = 0.55
local UNIT_DEBUFF_MAX = 40 -- current maximum number of debuffs

AloftCrowdControl.crowdControlStatusBar = nil
AloftCrowdControl.crowdControlExtraFrame = nil -- additional frame, a level above the crowd control bar, to which related text and icons can be attached by other modules
AloftCrowdControl.crowdControlSpellIcon = nil
AloftCrowdControl.crowdControlSpellName = nil
AloftCrowdControl.crowdControlSpellRank = nil

AloftCrowdControl.spellInfoList = { }

local backdropTable =
{
	tile = false, tileSize = 16,
	edgeSize = 16,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
}

-- used to track data active at the moment of UNIT_SPELLCAST_SENT against data active at the moment of UNIT_SPELLCAST_SUCCEEDED
local crowdControlTargetName = nil
local crowdControlTargetNameplate = nil
local crowdControlTargetSpellRank = nil
local crowdControlTargetSpellName = nil

-- used to track active crowd control data
local crowdControlName = nil
local crowdControlNameplate = nil
local crowdControlHealthBarValue = 0
local crowdControlDuration = 0

local profile

-- TODO: clean all this up, use spell id for basic mapping, get rid of redundant GetSpellInfo() calls, etc

local spellIdList =
{
	-- mage
	[  118] = true,	-- Polymorph: Sheep 1
	[12824] = true,	-- Polymorph: Sheep 2
	[12825] = true,	-- Polymorph: Sheep 3
	[12826] = true,	-- Polymorph: Sheep 4
	[28271] = true,	-- Polymorph: Turtle
	[28272] = true,	-- Polymorph: Pig
	[61025] = true,	-- Polymorph: Serpent
	[61305] = true,	-- Polymorph: Black Cat

	-- priest
	[ 9484] = true,	-- Shackle Undead: 1
	[ 9485] = true,	-- Shackle Undead: 2
	[10955] = true,	-- Shackle Undead: 3

	-- warlock
	[  710] = true,	-- Banish: 1
	[18647] = true,	-- Banish: 2

	-- druid
	[ 2637] = true,	-- Hibernate: 1
	[18657] = true,	-- Hibernate: 2
	[18658] = true,	-- Hibernate: 3

	-- rogue
	[ 1833] = true,	-- Cheap Shot
	[ 2094] = true,	-- Blind
	[ 1776] = true,	-- Gouge
	[  408] = true,	-- Kidney Shot: 1
	[ 8643] = true,	-- Kidney Shot: 2	-- TODO: Improved Kidney Shot? not a duration effect
	[ 6770] = true,	-- Sap: 1
	[ 2070] = true,	-- Sap: 2
	[11297] = true,	-- Sap: 3
	[51724] = true,	-- Sap: 4

	-- shaman
	[51514]	= true,	-- Hex: 1
}

-- is the crowd control spell cancelled on damage? (if false, it is supposed to run to its full duration)
local spellDamageCancel =
{
	[GetSpellInfo(10955)]	= true,	-- Shackle Undead 3
	[GetSpellInfo(12826)]	= true,	-- Polymorph: Sheep 4
	[GetSpellInfo(18647)]	= false,	-- Banish 2
	[GetSpellInfo(18658)]	= true,	-- Hibernate 2
	[GetSpellInfo(1833)]	= false,	-- Cheap Shot
	[GetSpellInfo(2094)]	= true,	-- Blind
	[GetSpellInfo(1776)]	= true,	-- Gouge
	[GetSpellInfo(8643)]	= false,	-- Kidney Shot 2
	[GetSpellInfo(51724)]	= true,	-- Sap 4
	[GetSpellInfo(51514)]	= false,	-- Hex: 1 -- TODO: this is a "maybe", need a way to capture that
}

-- duration of last resort: hardcoded
local spellGrossDuration =
{
	-- [GetSpellInfo(28271)] = { [81] = 50 },									-- Polymorph: Turtle
	-- [GetSpellInfo(28272)] = { [81] = 50 },									-- Polymorph: Pig
	-- [GetSpellInfo(61025)] = { [81] = 50 },									-- Polymorph: Serpent
	-- [GetSpellInfo(61305)] = { [81] = 50 },									-- Polymorph: Black Cat
	[GetSpellInfo(10955)] = { [40] = 30, [60] = 40, [81] = 50 },				-- Shackle Undead 3
	[GetSpellInfo(12826)] = { [20] = 20, [40] = 30, [60] = 40, [81] = 50 },	-- Polymorph: Sheep 4
	[GetSpellInfo(18647)] = { [48] = 20, [81] = 30, },						-- Banish 2
	[GetSpellInfo(18658)] = { [38] = 20, [58] = 30, [81] = 40, },			-- Hibernate 2
	[GetSpellInfo(51724)] = { [28] = 25, [48] = 35, [71] = 45, [81] = 60, },	-- Sap 4
	[GetSpellInfo( 1833)] = { [81] = 4, },									-- Cheap Shot
	[GetSpellInfo( 8643)] = { [50] = 5, [81] = 6, },							-- Kidney Shot: 2
	[GetSpellInfo(51514)] = { [81] = 30, },									-- Hex: 1
}

-----------------------------------------------------------------------------

--
-- Sequence goes like this:
--
-- We successfully cast a spell
-- Sometimes the nameplate hides and a new nameplate shows with the sheep
-- Other times it doesn't
--

-----------------------------------------------------------------------------

function AloftCrowdControl:UpdateAll()
	self:RegisterEvents()
	self:SetupFrame(crowdControlNameplate)
end

function AloftCrowdControl:RegisterEvents()
	self:UnregisterAllEvents()

	self:RegisterEvent("SharedMedia_SetGlobal", function(mediatype, override)
		if mediatype == "statusbar" then
			self:SetupFrame(crowdControlNameplate)
		end
	end)

	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:SetupFrame(crowdControlNameplate)
		end
	end)

	if profile and profile.enable then
		self:RegisterEvent("UNIT_SPELLCAST_SENT", "OnSpellcastSent")
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "OnSpellcastSucceeded")
		self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterEvent("Aloft:OnHealthBarValueChanged", "OnHealthBarValueChanged")
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControl:OnInitialize()
	profile = self.db.profile
end

function AloftCrowdControl:OnEnable()
	self:RegisterEvents()

	self:SetupFrame(crowdControlNameplate)

	for spellId, _ in pairs(spellIdList) do
		local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spellId)
		if not self.spellInfoList[name] then self.spellInfoList[name] = { } end
		self.spellInfoList[name][rank] = { duration = 0, icon = icon }
		-- ChatFrame7:AddMessage("AloftCrowdControl:OnEnable(): " .. tostring(name) .. "/" .. tostring(rank) .. "/" .. tostring(self.spellInfoList[name][rank].duration) .. "/" .. tostring(self.spellInfoList[name][rank].icon))
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControl:GetBorder(aloftData)
	if not profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		-- ChatFrame7:AddMessage("AloftHealthBar:GetBorder(): border " .. tostring(profile.border))
		return ((profile.border ~= "None") and 4) or 0, SML:Fetch("border", profile.border)
	else
		return 0, SML:Fetch("border", "None")
	end
end

function AloftCrowdControl:SetupFrame(aloftData)
	if not profile or not profile.enable then
		self:ReleaseFrame()
		return
	end

	local texture = SML:Fetch("statusbar", profile.texture)
	local inset, edgeFile = self:GetBorder(aloftData)
	local nameplateFrame = aloftData and aloftData.nameplateFrame
	local level = nameplateFrame and nameplateFrame:GetFrameLevel()

	-- ChatFrame7:AddMessage("AloftCrowdControl:SetupFrame(): inset " .. tostring(inset))

	if not self.crowdControlStatusBar then
		self.crowdControlStatusBar = CreateFrame("StatusBar", nil, nil)
		self.crowdControlStatusBar:SetStatusBarColor(unpack(profile.color))
		self.crowdControlStatusBar:SetFrameLevel(level or 1)
		self.crowdControlStatusBar:Hide()
	end

	if not self.crowdControlExtraFrame then
		self.crowdControlExtraFrame = CreateFrame("StatusBar", nil, self.crowdControlStatusBar)
		self.crowdControlExtraFrame:SetStatusBarColor(0, 0, 0, 0)
		self.crowdControlExtraFrame:SetFrameLevel((level and level + 1) or 2)
		self.crowdControlExtraFrame:Hide()
	end

	if aloftData then
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		if not layoutFrame then
			ChatFrame7:AddMessage("AloftCrowdControl:SetupFrame(): no layoutFrame " .. tostring(aloftData.name))
			ChatFrame7:AddMessage("AloftCrowdControl:SetupFrame(): " .. debugstack())
		end

		self.crowdControlStatusBar:SetParent(layoutFrame)

		self.crowdControlStatusBar:ClearAllPoints()
		self.crowdControlStatusBar:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", profile.offsets.left - inset, profile.offsets.vertical + inset)
		self.crowdControlStatusBar:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", profile.offsets.right + inset, profile.offsets.vertical - profile.height - inset)

		self.crowdControlExtraFrame:ClearAllPoints()
		self.crowdControlExtraFrame:SetPoint("TOPLEFT", self.crowdControlStatusBar, "TOPLEFT", inset, -inset)
		self.crowdControlExtraFrame:SetPoint("BOTTOMRIGHT", self.crowdControlStatusBar, "BOTTOMRIGHT", -inset, inset)
	end

	self.crowdControlStatusBar:SetStatusBarTexture(texture)
	-- self.crowdControlExtraFrame:SetStatusBarTexture("") -- SetTexture() takes an empty string, but apparently SetStatusBarTexture does not

	backdropTable.insets = { left = inset, right = inset, top = inset, bottom = inset }
	backdropTable.edgeFile = edgeFile
	backdropTable.bgFile = texture

	-- ChatFrame7:AddMessage("AloftCrowdControl:SetupBar(): set backdrop " .. tostring(backdropTable.edgeFile))
	self.crowdControlStatusBar:SetBackdrop(backdropTable)
	self.crowdControlStatusBar:SetBackdropBorderColor(unpack(profile.borderColor))
	self.crowdControlStatusBar:SetBackdropColor(unpack(profile.backdropColor))

	-- This manipulates the crowd control background to always display above the frame background
	local barRegion, backgroundRegion = self.crowdControlStatusBar:GetRegions()

	barRegion:ClearAllPoints()
	barRegion:SetPoint("TOPLEFT", self.crowdControlStatusBar, "TOPLEFT", inset, -inset)
	barRegion:SetPoint("BOTTOMRIGHT", self.crowdControlStatusBar, "BOTTOMRIGHT", -inset, inset)
	barRegion:SetDrawLayer("ARTWORK")
	barRegion:SetBlendMode("BLEND")
	barRegion:Show()

	backgroundRegion:SetDrawLayer("BACKGROUND")
	backgroundRegion:SetBlendMode("BLEND")
	backgroundRegion:Show()
end

function AloftCrowdControl:ReleaseFrame()
	if self.crowdControlExtraFrame then
		self.crowdControlExtraFrame:Hide()
	end
	if self.crowdControlStatusBar then
		self.crowdControlStatusBar:Hide()
		self.crowdControlStatusBar:SetParent(nil)
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControl:OnSpellcastSent(unitid, spellName, spellRank, targetName)
	-- ChatFrame7:AddMessage("AloftCrowdControl:OnSpellcastSent(): " .. tostring(unitid) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(targetName))
	if self.spellInfoList[spellName] and self.spellInfoList[spellName][spellRank] then
		-- This is in case players use [target=focus] or whatever macros
		if UnitName("target") == targetName then
			crowdControlTargetNameplate = Aloft:GetTargetNameplate()
		else
			crowdControlTargetNameplate = nil
		end

		crowdControlTargetName = targetName
		crowdControlTargetSpellName = spellName
		crowdControlTargetSpellRank = spellRank
		-- ChatFrame7:AddMessage("AloftCrowdControl:OnSpellcastSent(): good")
	else
		crowdControlTargetNameplate = nil

		crowdControlTargetName = nil
		crowdControlTargetSpellName = nil
		crowdControlTargetSpellRank = nil
	end
end

function AloftCrowdControl:OnSpellcastSucceeded(unitid, spellName, spellRank)
	-- ChatFrame7:AddMessage("AloftCrowdControl:OnSpellcastSucceeded(): enter " .. tostring(unitid) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(crowdControlTargetName))
	if unitid ~= "player" then return end
	if not crowdControlTargetName then return end

	-- ChatFrame7:AddMessage("AloftCrowdControl:OnSpellcastSucceeded(): update " .. tostring(unitid) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank))
	local eventName = "Aloft:UpdateUnitCrowdControl:" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.UpdateUnitCrowdControl, interval, self, unitid, spellName, spellRank) -- after a debuff application delay
end

-- TODO: add a verification interval and check this during processing? would only be effective on the player's current target
function AloftCrowdControl:Update()
	local currentTime = -GetTime()
	local min, max = self.crowdControlStatusBar:GetMinMaxValues()
	if currentTime < min then
		-- ChatFrame7:AddMessage("AloftCrowdControl:Update(): finished " .. tostring(self.crowdControlSpellName) .. "/" .. tostring(self.crowdControlSpellRank) .. "/" .. tostring(min) .. "/" .. tostring(max) .. "/" .. tostring(max))
		self:CrowdControlFinished()
	else
		self.crowdControlStatusBar:SetValue(currentTime)
		self:TriggerEvent("Aloft:OnCrowdControlBarValueChanged")
	end
end

function AloftCrowdControl:UpdateUnitCrowdControl(unitid, spellName, spellRank)
	local playerLevel = UnitLevel("player")

	-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): " .. tostring(unitid) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(crowdControlTargetName))
	crowdControlName = crowdControlTargetName
	self.crowdControlSpellName = crowdControlTargetSpellName
	self.crowdControlSpellRank = crowdControlTargetSpellRank

	local spellInfo = self.spellInfoList[self.crowdControlSpellName] and self.spellInfoList[self.crowdControlSpellName][self.crowdControlSpellRank]
	-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): " .. tostring(self.crowdControlSpellName) .. "/" .. tostring(self.crowdControlSpellRank) .. "/" .. tostring(spellInfo))
	self.crowdControlSpellIcon = spellInfo and spellInfo.icon or ""

	-- verify the presense of the effect on the target, determine the effect duration
	local grossDuration = 600
	local crowdControlDuration
	local valid, _, duration, _ = self:ValidateAttachCrowdControl("player", "target", self.crowdControlSpellName, self.crowdControlSpellRank)
	if spellGrossDuration[self.crowdControlSpellName] then
		for lvl, dur in pairs(spellGrossDuration[self.crowdControlSpellName]) do
			if playerLevel < lvl then
				grossDuration = dur
				break
			end
		end
	end

	if AloftClassData and AloftClassData:GetClass(crowdControlTargetName) then -- TODO: require race as well as class here?
		-- PvP target
		if valid then
			crowdControlDuration = min(grossDuration, min(duration, 10)) -- TODO: some sort of application count, for diminishing returns?
		else
			crowdControlDuration = min(grossDuration, 10)
		end
	elseif valid then
		-- valid non-PvP target
		crowdControlDuration = duration
		if duration > spellInfo.duration then
			spellInfo.duration = duration
		end
	elseif spellInfo and spellInfo.duration > 0 then
		-- best guess based on last observed duration
		crowdControlDuration = spellInfo.duration
	end
	-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): " .. tostring(self.crowdControlSpellName) .. "/" .. tostring(self.crowdControlSpellRank) .. "/" .. tostring(crowdControlDuration))

	if crowdControlDuration and crowdControlDuration > 0 then
		local currentTime = -GetTime()
		self.crowdControlStatusBar:SetMinMaxValues(currentTime - crowdControlDuration, currentTime)
		self.crowdControlStatusBar:SetValue(currentTime)
		-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): " .. tostring(self.crowdControlSpellName) .. "/" .. tostring(self.crowdControlSpellRank) .. "/" .. tostring(currentTime - countdown) .. "/" .. tostring(currentTime) .. "/" .. tostring(currentTime))

		if crowdControlTargetNameplate and valid then -- if can verify a debuff on the player's current target
			-- crowd contril should be active on the current target nameplate
			self:AttachCrowdControl(crowdControlTargetNameplate)
			crowdControlTargetNameplate = nil
		elseif profile.speculativeAttach then -- otherwise, this is speculative
			-- we have crowd control active, on a nameplate somewhere, go through visible nameplates and see if it can be attached
			for aloftData in Aloft:IterateVisibleNameplates() do
				if aloftData.name == crowdControlName and aloftData.healthBarValue == aloftData.healthBarMaxValue then
					self:AttachCrowdControl(aloftData)
					break
				end
			end
		end
	end
end

-----------------------------------------------------------------------------

-- TODO: associate text timer with debuff bar
function AloftCrowdControl:AttachCrowdControl(aloftData)
	if aloftData.name == "[invalid]" then return end -- residual nameplate, happens when the targeted nameplate disappears; we should not try to show here

	crowdControlNameplate = aloftData
	crowdControlHealthBarValue = aloftData.healthBarValue

	self:SetupFrame(crowdControlNameplate)

	-- ChatFrame7:AddMessage("AloftCrowdControl:AttachCrowdControl(): show " .. tostring(aloftData.name) .. "/" .. debugstack())
	self.crowdControlStatusBar:Show()
	self.crowdControlExtraFrame:Show()

	self:ScheduleRepeatingEvent("AloftCrowdControl:Update", self.Update, 0.05, self)
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CrowdControlFinished")

	self:TriggerEvent("Aloft:OnCrowdControlBarShow")

	self:Update()
end

function AloftCrowdControl:CrowdControlFinished()
	crowdControlName		= nil
	crowdControlNameplate	= nil
	crowdControlDuration	= 0

	AloftCrowdControl.crowdControlSpellName = nil
	AloftCrowdControl.crowdControlSpellRank = nil

	-- ChatFrame7:AddMessage("AloftCrowdControl:CrowdControlFinished(): hide")
	self:CancelScheduledEvent("AloftCrowdControl:Update")
	self:CancelEvent("PLAYER_REGEN_ENABLED")
	self:ReleaseFrame()

	self:TriggerEvent("Aloft:OnCrowdControlBarHide")
end

-- collects debuffs a couple of different ways
-- NOTE: this is coded this way, with a name/rank query first, and currently is generally called with a spell rank; currently, this will always find the spell in the direct name/rank query
function AloftCrowdControl:ValidateAttachCrowdControl(unitid, targetid, spellName, spellRank)
	-- ChatFrame7:AddMessage("AloftCrowdControl:ValidateAttachCrowdControl(): " .. tostring(targetid) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank))
	if spellName and spellRank then
		local name, rank, _, count, _, duration, expiration, caster, _  =  UnitAura(targetid, spellName, spellRank, "HARMFUL|PLAYER")
		-- ChatFrame7:AddMessage("AloftCrowdControl:ValidateAttachCrowdControl(): " .. tostring(name) .. "/" .. tostring(rank) .. "/" .. tostring(caster) .. "/" .. tostring(count) .. "/" .. tostring(duration) .. "/" .. tostring(expiration))
		if name and rank and caster and (type(caster) ~= "string" or caster == "player") and duration and name == spellName and rank == spellRank then
			-- the player has the expected debuff on the given unit
			if self.spellInfoList[name] and rank and self.spellInfoList[name][rank] then self.spellInfoList[name][rank].duration = duration end
			return true, count, duration, expiration
		end
	end
	for i = 1, UNIT_DEBUFF_MAX do
		local name, rank, _, count, _, duration, expiration, caster, _  =  UnitAura(targetid, i, "HARMFUL|PLAYER")
		-- ChatFrame7:AddMessage("AloftCrowdControl:ValidateAttachCrowdControl(): " .. tostring(name) .. "/" .. tostring(rank) .. "/" .. tostring(caster) .. "/" .. tostring(count) .. "/" .. tostring(duration) .. "/" .. tostring(expiration))
		if not name then break end -- end of debuffs has been reached
		if name and caster and (type(caster) ~= "string" or caster == "player") and duration and name == spellName and (not spellRank or rank == spellRank) then
			-- the player has the expected debuff on the given unit
			if self.spellInfoList[name] and rank and self.spellInfoList[name][rank] then self.spellInfoList[name][rank].duration = duration end
			-- ChatFrame7:AddMessage("AloftCrowdControl:ValidateAttachCrowdControl(): slow " .. tostring(name) .. "/" .. tostring(count) .. "/" .. tostring(duration) .. "/" .. tostring(expiration))
			return true, count, duration, expiration
		end
	end
	return false, nil, nil, nil
end

-----------------------------------------------------------------------------

function AloftCrowdControl:OnIsTargetDataChanged(aloftData)
	-- if crowdControlNameplate or crowdControlName ~= aloftData.name then return end

	-- ChatFrame7:AddMessage("AloftCrowdControl:OnIsTargetDataChanged(): " .. tostring(aloftData.name))
	local eventName = "AloftCrowdControl:DoNameplateShow:" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.DoNameplateShow, 0.0, self, aloftData) -- attach on the next frame, when isTarget will be active
end

function AloftCrowdControl:OnNameplateShow(aloftData)
	-- if crowdControlNameplate or crowdControlName ~= aloftData.name then return end

	if aloftData.isTarget or aloftData:IsTarget() then
		-- ChatFrame7:AddMessage("AloftCrowdControl:OnNameplateShow(): " .. tostring(aloftData.name))
		local eventName = "AloftCrowdControl:DoNameplateShow:" .. tostring(math.random(1,1000000000))
		self:ScheduleEvent(eventName, self.DoNameplateShow, 0.5, self, aloftData) -- attach after a few frames, when isTarget will be active
	else
		self:DoNameplateShow(aloftData)
	end
end

function AloftCrowdControl:OnNameplateHide(aloftData)
	-- ChatFrame7:AddMessage("AloftCrowdControl:OnNameplateHide(): enter " .. tostring(aloftData.name))
	if aloftData == crowdControlNameplate then
		crowdControlNameplate	= nil
		self:CancelScheduledEvent("AloftCrowdControl:Update")
		self:ReleaseFrame()
		-- ChatFrame7:AddMessage("AloftCrowdControl:OnNameplateHide(): hide " .. tostring(aloftData.name))
	end
	if aloftData == crowdControlTargetNameplate then
		crowdControlTargetNameplate = nil
		-- ChatFrame7:AddMessage("AloftCrowdControl:OnNameplateHide(): hide target " .. tostring(aloftData.name))
	end
end

function AloftCrowdControl:OnHealthBarValueChanged(aloftData)
	if aloftData == crowdControlNameplate then
		if aloftData.healthBarValue < crowdControlHealthBarValue and spellDamageCancel[self.crowdControlSpellName] then
			-- ChatFrame7:AddMessage("AloftCrowdControl:OnHealthBarValueChanged(): cancel on damage")
			self:CrowdControlFinished()
		else
			crowdControlHealthBarValue = aloftData.healthBarValue
		end
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControl:DoNameplateShow(aloftData)
	-- ChatFrame7:AddMessage("AloftCrowdControl:DoNameplateShow(): setup and show " .. tostring(aloftData.name))
	if aloftData.isTarget or aloftData:IsTarget() then -- the current target
		local valid, _, _, _ = self:ValidateAttachCrowdControl("player", "target", self.crowdControlSpellName, self.crowdControlSpellRank)
		if valid then -- current target, and verifiably valid
			self:AttachCrowdControl(aloftData)
			-- ChatFrame7:AddMessage("AloftCrowdControl:DoNameplateShow(): target/valid/attached " .. tostring(aloftData.name))
			return
		elseif aloftData == crowdControlNameplate then -- current target, should have crowd control, and verifiably invalid
			crowdControlNameplate = nil
			self:CancelScheduledEvent("AloftCrowdControl:Update")
			self:ReleaseFrame()
			-- ChatFrame7:AddMessage("AloftCrowdControl:DoNameplateShow(): target/invalid " .. tostring(aloftData.name))
			return
		end
	elseif AloftTargetTrackingData:IsTargetIdToNameplateIdTracking() then -- possible identifiable group/focus target
		local nameplateId = AloftTargetTrackingData:GetNameplateId(aloftData)

		-- ChatFrame7:AddMessage("AloftCrowdControl:DoNameplateShow(): nameplate " .. tostring(aloftData.name) .. "/" .. tostring(nameplateId))
		if nameplateId and AloftTargetTrackingData.nameplateIdToTargetId[nameplateId] then
			for targetid in pairs(AloftTargetTrackingData.nameplateIdToTargetId[nameplateId]) do
				local valid, _, _, _ = self:ValidateAttachCrowdControl("player", targetid, self.crowdControlSpellName, self.crowdControlSpellRank)
				if valid then -- identifiable group/focus target, and verifiably valid
					self:AttachCrowdControl(aloftData)
					-- ChatFrame7:AddMessage("AloftCrowdControl:DoNameplateShow(): proxy/valid/attached " .. tostring(aloftData.name))
					return
				elseif aloftData == crowdControlNameplate then -- identifiable group/focus target, should have crowd control, and verifiably invalid
					crowdControlNameplate = nil
					self:CancelScheduledEvent("AloftCrowdControl:Update")
					self:ReleaseFrame()
					-- ChatFrame7:AddMessage("AloftCrowdControl:DoNameplateShow(): proxy/invalid " .. tostring(aloftData.name))
					return
				end
				break -- only one friendly groupmember is needed to construct a target name, if it doesn't work, skip the rest
			end
		end
	end

	-- we are speculating
	if crowdControlNameplate then
		if aloftData == crowdControlNameplate then
			-- this is the existing crowd control nameplate, crowd control should still be showing
			self:SetupFrame(aloftData) -- adjust borders/etc
		end
	elseif profile.speculativeAttach and crowdControlName == aloftData.name and aloftData.healthBarValue == aloftData.healthBarMaxValue then
		-- speculative attach
		self:AttachCrowdControl(aloftData)
		-- ChatFrame7:AddMessage("AloftCrowdControl:DoNameplateShow(): non-target/non-proxy/speculative/attached " .. tostring(aloftData.name))
		return
	end
end

-----------------------------------------------------------------------------

end)
