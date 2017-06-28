local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local allowedPlayerClasses =
{
	["MAGE"]	= true,
	["PRIEST"]	= true,
	["WARLOCK"]	= true,
	["DRUID"]	= true,
	["ROGUE"]	= true,
	["SHAMAN"]	= true,
}
local _, playerClass = UnitClass("player")

if not allowedPlayerClasses[playerClass] then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData") -- always on
if not AloftTargetTrackingData then return end

local AloftClassData = Aloft:GetModule("ClassData") -- always on
if not AloftClassData then return end

AloftCrowdControl = Aloft:NewModule("CrowdControl", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftCrowdControl.dynamic = "AloftCrowdControl"

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftCrowdControl.namespace = "polymorph"
AloftCrowdControl.defaults =
{
	profile =
	{
		enable				= true,
		speculativeAttach	= true,
		texture				= "Blizzard",
		targetOnly			= true,
		border				= "None",
		borderEdgeSize		= 16,
		borderInset			= 4,
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
	},
}

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

-- TODO: doh! these are unnecessary/redundant, no way to assign a table member to nil; clean up
AloftCrowdControl.crowdControlFrame = nil
AloftCrowdControl.crowdControlExtraFrame = nil -- additional frame, a level above the crowd control bar, to which related text and icons can be attached by other modules
AloftCrowdControl.crowdControlSpellIcon = nil
AloftCrowdControl.crowdControlSpellName = nil
AloftCrowdControl.crowdControlSpellRank = nil
AloftCrowdControl.endTime = nil
AloftCrowdControl.value = nil

AloftCrowdControl.spellInfoList = { }

-- backdrop table for initializing visible nameplates
local backdropTable =
{
	-- tile = false,
	-- tileSize = 16,
	bgFile = nil,
	edgeSize = 16,
	edgeFile = nil,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

-- backdrop table for resetting nameplates when they are hidden
local defaultBackdropTable =
{
	-- tile = false,
	-- tileSize = 0,
	bgFile = nil,
	-- edgeSize = 0,
	edgeFile = nil,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
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

-- TODO: clean all this up, use spell id for basic mapping, get rid of redundant GetSpellInfo() calls, etc

local POLYMORPH_SPELL_ID = 118

local spellIdList =
{
	-- mage
	[POLYMORPH_SPELL_ID] = true,	-- Polymorph: Sheep
	[61721] = true,	-- Polymorph: Rabbit
	[28271] = true,	-- Polymorph: Turtle
	[61780] = true,	-- Polymorph: Turkey
	[28272] = true,	-- Polymorph: Pig
	[61305] = true,	-- Polymorph: Black Cat

	-- priest
	[ 9484] = true,	-- Shackle Undead

	-- warlock
	[  710] = true,	-- Banish

	-- druid
	[ 2637] = true,	-- Hibernate

	-- rogue
	[ 1833] = true,	-- Cheap Shot
	[ 2094] = true,	-- Blind
	[ 1776] = true,	-- Gouge
	[  408] = true,	-- Kidney Shot -- TODO: Improved Kidney Shot? not a duration effect
	[ 6770] = true,	-- Sap

	-- shaman
	[51514]	= true,	-- Hex: 1
}

-- is the crowd control spell cancelled on damage? (if false, it is supposed to run to its full duration)
local spellDamageCancel =
{
	[GetSpellInfo(POLYMORPH_SPELL_ID)]	= true,	-- Polymorph: Sheep
	[GetSpellInfo(61721)]	= true,	-- Polymorph: Rabbit
	[GetSpellInfo(28271)]	= true,	-- Polymorph: Turtle
	[GetSpellInfo(61780)]	= true,	-- Polymorph: Turkey
	[GetSpellInfo(28272)]	= true,	-- Polymorph: Pig
	[GetSpellInfo(61305)]	= true,	-- Polymorph: Black Cat

	[GetSpellInfo( 9484)]	= true,	-- Shackle Undead

	[GetSpellInfo(  710)]	= false,	-- Banish

	[GetSpellInfo( 2637)]	= true,	-- Hibernate

	[GetSpellInfo( 1833)]	= false,	-- Cheap Shot
	[GetSpellInfo( 2094)]	= true,	-- Blind
	[GetSpellInfo( 1776)]	= true,	-- Gouge
	[GetSpellInfo(  408)]	= false,	-- Kidney Shot
	[GetSpellInfo( 6770)]	= true,	-- Sap 4

	[GetSpellInfo(51514)]	= false,	-- Hex: 1 -- TODO: this is a "maybe", need a way to capture that
}

-- duration of last resort: hardcoded
local spellGrossDuration =
{
	[GetSpellInfo(POLYMORPH_SPELL_ID)]	= { [86] = 50, },									-- Polymorph: Sheep
	[GetSpellInfo(61721)]	= { [86] = 50, },									-- Polymorph: Rabbit
	[GetSpellInfo(28271)]	= { [86] = 50, },									-- Polymorph: Turtle
	[GetSpellInfo(61780)]	= { [86] = 50, },									-- Polymorph: Turkey
	[GetSpellInfo(28272)]	= { [86] = 50, },									-- Polymorph: Pig
	[GetSpellInfo(61305)]	= { [86] = 50, },									-- Polymorph: Black Cat

	[GetSpellInfo( 9484)]	= { [86] = 50 },									-- Shackle Undead 3

	[GetSpellInfo(  710)]	= { [86] = 30, },									-- Banish

	[GetSpellInfo( 2637)]	= { [86] = 40, },									-- Hibernate

	[GetSpellInfo( 1833)]	= { [86] = 4, },									-- Cheap Shot
	[GetSpellInfo( 2094)]	= { [86] = 10, },									-- Blind
	[GetSpellInfo( 1776)]	= { [86] = 4, },									-- Gouge
	[GetSpellInfo(  408)]	= { [86] = 2, },									-- Kidney Shot
	[GetSpellInfo( 6770)]	= { [86] = 60, },									-- Sap

	[GetSpellInfo(51514)]	= { [86] = 60, },									-- Hex
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
	self:SetupFrame(crowdControlNameplate)
	self:RegisterEvents()
end

function AloftCrowdControl:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("SharedMedia_SetGlobal", function(message, mediatype, override)
		if mediatype == "statusbar" then
			AloftCrowdControl:SetupFrame(crowdControlNameplate)
		end
	end)

	self:RegisterMessage("Aloft:SetAll", function(message, type, value)
		if AloftCrowdControl.db.profile[type] then
			AloftCrowdControl.db.profile[type] = value
			AloftCrowdControl:SetupFrame(crowdControlNameplate)
		end
	end)

	if self.db.profile and self.db.profile.enable then
		self:RegisterEvent("UNIT_SPELLCAST_SENT", "OnSpellcastSent")
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "OnSpellcastSucceeded")
		self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
		self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("Aloft:OnHealthBarValueChanged", "OnHealthBarValueChanged")
		self:RegisterMessage("Aloft:OnConfigModeChanged", "OnConfigModeChanged")
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControl:OnInitialize()
	-- ChatFrame7:AddMessage("AloftCrowdControl:OnInitialize(): enter")
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self:SetupFrame(crowdControlNameplate) -- this needs to be in OnInitialize, to enforce invocation order, since this is the "parent" module of the rest of the subsystem
	-- TODO: find a better way to do this

	self.initialized = true
end

function AloftCrowdControl:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftCrowdControl:OnInitialize(): OnEnable")

	self:RegisterEvents()

	for spellId, _ in pairs(spellIdList) do
		local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spellId)
		if not self.spellInfoList[name] then self.spellInfoList[name] = { } end
		self.spellInfoList[name][rank] = { duration = 0, icon = icon }
		-- ChatFrame7:AddMessage("AloftCrowdControl:OnEnable(): " .. tostring(name) .. "/" .. tostring(rank) .. "/" .. tostring(type(rank)) .. "/" .. tostring(self.spellInfoList[name][rank].duration) .. "/" .. tostring(self.spellInfoList[name][rank].icon))
	end
end

function AloftCrowdControl:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftCrowdControl:GetBorder(aloftData)
	if not self.db.profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		-- ChatFrame7:AddMessage("AloftCrowdControl:GetBorder(): border " .. tostring(self.db.profile.border))
		return ((self.db.profile.border ~= "None") and self.db.profile.borderInset) or 0, SML:Fetch("border", self.db.profile.border)
		-- return 0, SML:Fetch("border", "None")
	else
		return 0, SML:Fetch("border", "None")
	end
end

function AloftCrowdControl:SetupFrame(aloftData)
	-- ChatFrame7:AddMessage("AloftCrowdControl:SetupFrame(): " .. tostring(aloftData and aloftData.name) .. "/" .. tostring(self.crowdControlFrame) .. "/" .. tostring(self.crowdControlExtraFrame))
	if not self.db.profile or not self.db.profile.enable then
		self:ReleaseFrame()
		return
	end

	local texture = SML:Fetch("statusbar", self.db.profile.texture)
	local inset, edgeFile = self:GetBorder(aloftData)
	local nameplateFrame = aloftData and aloftData.nameplateFrame
	local level = nameplateFrame and nameplateFrame:GetFrameLevel()

	-- ChatFrame7:AddMessage("AloftCrowdControl:SetupFrame(): inset " .. tostring(inset))

	if not self.crowdControlFrame then
		self.crowdControlFrame = CreateFrame("Frame", nil, nil)
		self.crowdControlFrame:SetFrameLevel(level or 1)
		self.crowdControlFrame:Hide()
	end

	local crowdControlRegion = self.crowdControlFrame.crowdControlRegion
	if not crowdControlRegion then
		crowdControlRegion = self.crowdControlFrame:CreateTexture(nil, "ARTWORK")
		crowdControlRegion:SetBlendMode("BLEND")
		self.crowdControlFrame.crowdControlRegion = crowdControlRegion
	end

	if not self.crowdControlExtraFrame then
		self.crowdControlExtraFrame = CreateFrame("StatusBar", nil, self.crowdControlFrame)
		self.crowdControlExtraFrame:SetStatusBarColor(0, 0, 0, 0)
		self.crowdControlExtraFrame:Hide()
	end

	backdropTable.insets.left = inset
	backdropTable.insets.right = inset
	backdropTable.insets.top = inset
	backdropTable.insets.bottom = inset
	backdropTable.edgeFile = edgeFile
	backdropTable.edgeSize = self.db.profile.borderEdgeSize
	backdropTable.bgFile = texture

	-- ChatFrame7:AddMessage("AloftCrowdControl:SetupBar(): set backdrop " .. tostring(backdropTable.edgeFile))
	self.crowdControlFrame:SetBackdrop(backdropTable)
	self.crowdControlFrame:SetBackdropBorderColor(unpack(self.db.profile.borderColor))
	self.crowdControlFrame:SetBackdropColor(unpack(self.db.profile.backdropColor))

	-- This manipulates the crowd control background to always display above the frame background
	local _, _, _, _, backgroundRegion = self.crowdControlFrame:GetRegions()

	if backgroundRegion and backgroundRegion.SetBlendMode then
		-- NOTE: as the crowdControlFrame has regions added to it, for name text/time text, backgroundRegion will eventually appear in the correct region location
		-- TODO: kludgy, do something about this
		backgroundRegion:SetDrawLayer("BACKGROUND")
		backgroundRegion:SetBlendMode("BLEND")
		backgroundRegion:Show()
		-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): background region " .. tostring(aloftData.name) .. "/" .. tostring(backgroundRegion:GetTexture()))
	else
		-- ChatFrame7:AddMessage("AloftCastBar:UpdateCastBar(): no background region " .. tostring(aloftData.name) .. "/" .. tostring(castFrame:GetNumRegions()))
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

		self.crowdControlFrame:SetParent(layoutFrame)
		self.crowdControlFrame:SetFrameLevel(nameplateFrame:GetFrameLevel())

		self.crowdControlFrame:ClearAllPoints()
		self.crowdControlFrame:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", self.db.profile.offsets.left - inset, self.db.profile.offsets.vertical + inset)
		self.crowdControlFrame:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", self.db.profile.offsets.right + inset, self.db.profile.offsets.vertical - self.db.profile.height - inset)

		self.crowdControlExtraFrame:ClearAllPoints()
		-- self.crowdControlExtraFrame:SetPoint("TOPLEFT", self.crowdControlFrame, "TOPLEFT", inset, -inset)
		-- self.crowdControlExtraFrame:SetPoint("BOTTOMRIGHT", self.crowdControlFrame, "BOTTOMRIGHT", -inset, inset)
		self.crowdControlExtraFrame:SetPoint("TOPLEFT", self.crowdControlFrame, "TOPLEFT", 0, 0)
		self.crowdControlExtraFrame:SetPoint("BOTTOMRIGHT", self.crowdControlFrame, "BOTTOMRIGHT", 0, 0)
	end

	crowdControlRegion:SetTexture(texture)
	crowdControlRegion:SetVertexColor(unpack(self.db.profile.color))

	crowdControlRegion:ClearAllPoints()
	crowdControlRegion:SetPoint("TOPLEFT", self.crowdControlFrame, "TOPLEFT", inset, -inset)
	crowdControlRegion:SetPoint("BOTTOMLEFT", self.crowdControlFrame, "BOTTOMLEFT", inset, inset)

	crowdControlRegion:Show()
	-- ChatFrame7:AddMessage("AloftCrowdControl:SetupFrame(): show/" .. tostring(crowdControlRegion:IsVisible()))
end

function AloftCrowdControl:ReleaseFrame()
	if self.crowdControlExtraFrame then
		self.crowdControlExtraFrame:Hide()
	end
	if self.crowdControlFrame then
		self:ClearBackdrop()
		self.crowdControlFrame:Hide()
		self.crowdControlFrame:SetParent(nil)
	end
end

function AloftCrowdControl:ClearBackdrop()
	if self.crowdControlFrame then
		self.crowdControlFrame:SetBackdropColor(0, 0, 0, 0)
		self.crowdControlFrame:SetBackdropBorderColor(0, 0, 0, 0)

		-- NOTE: doing this on nameplate hide may case #132 crashes
		-- self.crowdControlFrame:SetBackdrop(defaultBackdropTable)
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControl:OnSpellcastSent(event, unitid, spellName, spellRank, targetName)
	-- ChatFrame7:AddMessage("AloftCrowdControl:OnSpellcastSent(): " .. tostring(unitid) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(targetName))
	if self.spellInfoList[spellName] and self.spellInfoList[spellName][spellRank] then
		self:CancelInConfigMode()

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

function AloftCrowdControl:OnSpellcastSucceeded(event, unitid, spellName, spellRank)
	-- ChatFrame7:AddMessage("AloftCrowdControl:OnSpellcastSucceeded(): enter " .. tostring(unitid) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(crowdControlTargetName))
	if unitid ~= "player" then return end
	if not crowdControlTargetName then return end

	-- ChatFrame7:AddMessage("AloftCrowdControl:OnSpellcastSucceeded(): schedule update " .. tostring(unitid) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(crowdControlTargetName))
	self:ScheduleTimer(function(arg) AloftCrowdControl:UpdateUnitCrowdControl(arg) end, interval --[[, { unitid = unitid, spellName = spellName, spellRank = spellRank}]]) -- after a debuff application delay
	-- ChatFrame7:AddMessage("AloftCrowdControl:OnSpellcastSucceeded(): update scheduled")
	-- TODO: the table argument to the above is only used for diagnostics at this point; could this memory-leak? CLEANUP
end

function AloftCrowdControl:CalculateFrameWidth(aloftData, duration, currentTime, endTime)
	local width = nil
	local value = nil

	if aloftData and duration and currentTime and endTime and duration > 0 and currentTime < endTime then
		local inset, _ = self:GetBorder(aloftData)
		value = endTime - currentTime
		width = (value / duration) * (self.crowdControlFrame:GetWidth() - (2 * inset))
	end

	return value, width
end

-- TODO: add a verification interval and check this during processing? would only be effective on the player's current target
function AloftCrowdControl:Update(aloftData)
	local value, width = self:CalculateFrameWidth(aloftData, crowdControlDuration, GetTime(), self.endTime)

	if width then
		self.value = value
		self.crowdControlFrame.crowdControlRegion:SetWidth(width)
		-- ChatFrame7:AddMessage("AloftCrowdControl:Update(): " .. tostring(self.crowdControlSpellName) .. "/" .. tostring(self.crowdControlSpellRank) .. "/" .. tostring(self.value) .. "/" .. tostring(crowdControlDuration) .. "/" .. tostring(width))

		self:SendMessage("Aloft:OnCrowdControlBarValueChanged")
	else
		-- ChatFrame7:AddMessage("AloftCrowdControl:Update(): finished " .. tostring(self.crowdControlSpellName) .. "/" .. tostring(self.crowdControlSpellRank) .. "/" .. tostring(min) .. "/" .. tostring(max) .. "/" .. tostring(max))
		self.value = nil
		self:CrowdControlFinished("AloftCrowdControl:Update")
	end
end

function AloftCrowdControl:UpdateUnitCrowdControl(arg)
	-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): enter " .. tostring(arg))

	local playerLevel = UnitLevel("player")

	-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): " .. tostring(arg and arg.unitid) .. "/" .. tostring(arg and arg.spellName) .. "/" .. tostring(arg and arg.spellRank) .. "/" .. tostring(crowdControlTargetName))
	crowdControlName = crowdControlTargetName
	self.crowdControlSpellName = crowdControlTargetSpellName
	self.crowdControlSpellRank = crowdControlTargetSpellRank

	local spellInfo = self.spellInfoList[self.crowdControlSpellName] and self.spellInfoList[self.crowdControlSpellName][self.crowdControlSpellRank]
	-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): " .. tostring(self.crowdControlSpellName) .. "/" .. tostring(self.crowdControlSpellRank) .. "/" .. tostring(spellInfo))
	self.crowdControlSpellIcon = spellInfo and spellInfo.icon or ""

	-- verify the presense of the effect on the target, determine the effect duration
	local valid, _, duration, _ = self:ValidateAttachCrowdControl("player", "target", self.crowdControlSpellName, self.crowdControlSpellRank)
	-- NOTE: duration here )(hopefully) subsumes both PvP diminishing returns and variation due to combo points

	-- now collect the par or "gross" duration
	local grossDuration = 600
	if spellGrossDuration[self.crowdControlSpellName] then
		for lvl, dur in pairs(spellGrossDuration[self.crowdControlSpellName]) do
			if playerLevel < lvl then
				grossDuration = dur
				-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): " .. tostring(self.crowdControlSpellName) .. "/" .. tostring(grossDuration))
				break
			end
		end
		-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): done looping player duration/level " .. tostring(#spellGrossDuration[self.crowdControlSpellName]))
	else
		-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): no player duration/level " .. tostring(#spellGrossDuration[self.crowdControlSpellName]))
	end

	if AloftClassData and AloftClassData:GetClass(crowdControlTargetName) then -- TODO: require race as well as class here?
		-- PvP target
		if valid then
			-- NOTE: PvP diminishing returns on the target (vs. focus) is handled by the duration reported by UnitAura(), via ValidateAttachCrowdControl() above
			crowdControlDuration = min(grossDuration, min(duration, 10))
		else
			crowdControlDuration = min(grossDuration, 10)
		end
		-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): gross duration " .. tostring(crowdControlTargetName) .. "/" .. tostring(crowdControlDuration))
	elseif valid then
		-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): valid duration " .. tostring(crowdControlTargetName) .. "/" .. tostring(crowdControlDuration))
		-- valid non-PvP target
		crowdControlDuration = duration
		if duration > spellInfo.duration then
			spellInfo.duration = duration
		end
	elseif spellInfo and spellInfo.duration > 0 then
		-- best guess based on last observed duration
		-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): spell info duration " .. tostring(crowdControlTargetName) .. "/" .. tostring(crowdControlDuration))
		crowdControlDuration = spellInfo.duration -- this seems to be redundant
	end
	-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): " .. tostring(self.crowdControlSpellName) .. "/" .. tostring(self.crowdControlSpellRank) .. "/" .. tostring(crowdControlDuration))

	if crowdControlDuration and crowdControlDuration > 0 then
		self.endTime = GetTime() + crowdControlDuration
		self.value = crowdControlDuration

		-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): " .. tostring(self.crowdControlSpellName) .. "/" .. tostring(self.crowdControlSpellRank) .. "/" .. tostring(self.value) .. "/" .. tostring(crowdControlDuration))

		if crowdControlTargetNameplate and valid then -- if can verify a debuff on the player's current target
			-- crowd control should be active on the current target nameplate
			-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): attach target " .. tostring(crowdControlTargetNameplate.name))
			self:AttachCrowdControl(crowdControlTargetNameplate)
			crowdControlTargetNameplate = nil
		elseif self.db.profile.speculativeAttach then -- otherwise, this is speculative
			-- we have crowd control active, on a nameplate somewhere, go through visible nameplates and see if it can be attached
			for aloftData in Aloft:IterateVisibleNameplates() do
				if aloftData.name == crowdControlName and aloftData.healthBarValue == aloftData.healthBarMaxValue then
					-- ChatFrame7:AddMessage("AloftCrowdControl:UpdateUnitCrowdControl(): attach speculative " .. tostring(aloftData.name))
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

	local value, width = self:CalculateFrameWidth(aloftData, crowdControlDuration, GetTime(), self.endTime)

	if width then
		crowdControlNameplate = aloftData
		crowdControlHealthBarValue = aloftData.healthBarValue

		self.value = value

		self:SetupFrame(crowdControlNameplate)
		self.crowdControlFrame.crowdControlRegion:SetWidth(width)
		-- ChatFrame7:AddMessage("AloftCrowdControl:AttachCrowdControl(): " .. tostring(self.crowdControlSpellName) .. "/" .. tostring(self.crowdControlSpellRank) .. "/" .. tostring(self.value) .. "/" .. tostring(crowdControlDuration))

		-- ChatFrame7:AddMessage("AloftCrowdControl:AttachCrowdControl(): show " .. tostring(aloftData.name) .. "/" .. debugstack())
		self.crowdControlFrame:Show()
		self.crowdControlExtraFrame:Show()

		-- ChatFrame7:AddMessage("AloftCrowdControl:AttachCrowdControl(): cancel " .. tostring(aloftData.name))
		self:CancelAllTimers() -- cancel existing timers

		self:ScheduleRepeatingTimer(function(aloftData) AloftCrowdControl:Update(aloftData) end, 0.05, aloftData)
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "CrowdControlFinished")

		self:SendMessage("Aloft:OnCrowdControlBarShow")

		self:Update(aloftData)
	end
end

function AloftCrowdControl:CrowdControlFinished(event)
	crowdControlName		= nil
	crowdControlNameplate	= nil
	crowdControlDuration	= 0

	self.crowdControlSpellName = nil
	self.crowdControlSpellRank = nil

	self.endTime = nil
	self.value = nil

	-- ChatFrame7:AddMessage("AloftCrowdControl:CrowdControlFinished(): cancel " .. tostring(event))
	self:CancelAllTimers() -- cancel existing timers

	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:ReleaseFrame()

	-- ChatFrame7:AddMessage("AloftCrowdControl:CrowdControlFinished(): hide/" .. tostring(event))
	self:SendMessage("Aloft:OnCrowdControlBarHide")
end

-- collects debuffs a couple of different ways
-- NOTE: this is coded this way, with a name/rank query first, and currently is generally called with a spell rank; currently, this will always find the spell in the direct name/rank query
function AloftCrowdControl:ValidateAttachCrowdControl(unitid, targetid, spellName, spellRank)
	-- ChatFrame7:AddMessage("AloftCrowdControl:ValidateAttachCrowdControl(): " .. tostring(targetid) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank))

	-- quick check via name/rank; is this any more efficient down inside Blizzard's stuff? don't know for certain...
	if spellName and spellRank then
		local name, rank, _, count, _, duration, expiration, caster, _  =  UnitAura(targetid, spellName, spellRank, "HARMFUL|PLAYER")
		-- ChatFrame7:AddMessage("AloftCrowdControl:ValidateAttachCrowdControl(): quick " .. tostring(name) .. "/" .. tostring(rank) .. "/" .. tostring(caster) .. "/" .. tostring(count) .. "/" .. tostring(duration) .. "/" .. tostring(expiration))
		if name and rank and caster and (type(caster) ~= "string" or caster == "player") and duration and name == spellName and rank == spellRank then
			-- the player has the expected debuff on the given unit
			if self.spellInfoList[name] and rank and self.spellInfoList[name][rank] then self.spellInfoList[name][rank].duration = duration end
			return true, count, duration, expiration
		end
	end

	-- slow iteration through all debuffs
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

	-- ChatFrame7:AddMessage("AloftCrowdControl:ValidateAttachCrowdControl(): none")
	return false, nil, nil, nil
end

-----------------------------------------------------------------------------

function AloftCrowdControl:OnIsTargetDataChanged(message, aloftData)
	-- if crowdControlNameplate or crowdControlName ~= aloftData.name then return end

	-- ChatFrame7:AddMessage("AloftCrowdControl:OnIsTargetDataChanged(): " .. tostring(aloftData.name))
	if Aloft:IsConfigModeEnabled() then
		self:ScheduleTimer(function(aloftData) AloftCrowdControl:OnConfigModeChanged("AloftCrowdControl:OnIsTargetDataChanged") end, 0.0)
	else
		self:ScheduleTimer(function(aloftData) AloftCrowdControl:DoNameplateShow(aloftData) end, 0.0, aloftData) -- attach on the next frame, when isTarget will be active
	end
end

function AloftCrowdControl:OnNameplateShow(message, aloftData)
	-- if crowdControlNameplate or crowdControlName ~= aloftData.name then return end

	if aloftData.isTarget or aloftData:IsTarget() then
		-- ChatFrame7:AddMessage("AloftCrowdControl:OnNameplateShow(): " .. tostring(aloftData.name))
		self:ScheduleTimer(function(aloftData) AloftCrowdControl:DoNameplateShow(aloftData) end, 0.5, aloftData) -- attach after a few frames, when isTarget will be active
	else
		self:DoNameplateShow(aloftData)
	end
end

function AloftCrowdControl:OnNameplateHide(message, aloftData)
	-- ChatFrame7:AddMessage("AloftCrowdControl:OnNameplateHide(): enter " .. tostring(aloftData.name))
	if aloftData == crowdControlNameplate then
		crowdControlNameplate = nil

		-- ChatFrame7:AddMessage("AloftCrowdControl:OnNameplateHide(): cancel " .. tostring(aloftData.name))
		self:CancelAllTimers() -- cancel existing timers

		self:ReleaseFrame()
		-- ChatFrame7:AddMessage("AloftCrowdControl:OnNameplateHide(): hide " .. tostring(aloftData.name))
	end
	if aloftData == crowdControlTargetNameplate then
		crowdControlTargetNameplate = nil
		-- ChatFrame7:AddMessage("AloftCrowdControl:OnNameplateHide(): hide target " .. tostring(aloftData.name))
	end
end

function AloftCrowdControl:OnHealthBarValueChanged(message, aloftData)
	if aloftData == crowdControlNameplate then
		if aloftData.healthBarValue < crowdControlHealthBarValue and spellDamageCancel[self.crowdControlSpellName] then
			-- ChatFrame7:AddMessage("AloftCrowdControl:OnHealthBarValueChanged(): cancel on damage")
			self:CrowdControlFinished(message)
		else
			crowdControlHealthBarValue = aloftData.healthBarValue
		end
	end
end

function AloftCrowdControl:OnConfigModeChanged(message)
	if Aloft:IsConfigModeEnabled() then
		local aloftData = Aloft:GetTargetNameplate()
		if aloftData then
			crowdControlDuration = 30

			local now = GetTime()
			local _, _, icon, _, _, _, _, _, _ = GetSpellInfo(POLYMORPH_SPELL_ID)

			self.crowdControlSpellName = "Spell Name"
			self.crowdControlSpellRank = "Rank"
			self.crowdControlSpellIcon = icon
			self.endTime = now + crowdControlDuration

			local value, width = self:CalculateFrameWidth(aloftData, crowdControlDuration, now, self.endTime)

			if width then
				self.value = ceil(value * 0.7)

				self:SetupFrame(aloftData)
				self.crowdControlFrame.crowdControlRegion:SetWidth(ceil(width * 0.7))

				self.crowdControlFrame:Show()
				self.crowdControlExtraFrame:Show()
				-- self.crowdControlFrame.crowdControlRegion:Show()
				-- ChatFrame7:AddMessage("AloftCrowdControl:OnConfigModeChanged(): show/" .. tostring(self.crowdControlFrame.crowdControlRegion:IsVisible()))

				crowdControlNameplate = aloftData

				self:SendMessage("Aloft:OnCrowdControlBarShow")

				return
			end
		end
	end

	AloftCrowdControl:CrowdControlFinished(message)
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

			-- ChatFrame7:AddMessage("AloftCrowdControl:DoNameplateShow(): cancel 1 " .. tostring(aloftData.name))
			self:CancelAllTimers() -- cancel existing timers

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

					-- ChatFrame7:AddMessage("AloftCrowdControl:DoNameplateShow(): cancel 2 " .. tostring(aloftData.name))
					self:CancelAllTimers() -- cancel existing timers

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
	elseif self.db.profile.speculativeAttach and crowdControlName == aloftData.name and aloftData.healthBarValue == aloftData.healthBarMaxValue then
		-- speculative attach
		self:AttachCrowdControl(aloftData)
		-- ChatFrame7:AddMessage("AloftCrowdControl:DoNameplateShow(): non-target/non-proxy/speculative/attached " .. tostring(aloftData.name))
		return
	end
end

-----------------------------------------------------------------------------

end)
