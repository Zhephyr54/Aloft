local AloftLocale = AloftLocale
if not AloftLocale then return end

---------------------------------------------------------------------------

--[[
PreLoadDebugHistory = { }
table.insert(PreLoadDebugHistory, "ALOFT BEGIN")
]]

-----------------------------------------------------------------------------

local version, build, date, tocversion = GetBuildInfo()

-----------------------------------------------------------------------------

local L = AloftLocale.Aloft
if not L then return end

-- global on purpose
Aloft = LibStub("AceAddon-3.0"):NewAddon("Aloft", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

local ONUPDATE_DEFER = 0 -- how many frames to delay OnUpdate processing

local N

local Aloft = Aloft

local isConfig = false
local AceConfig = LibStub("AceConfig-3.0")

local isDialog = false
local AceDialog = LibStub("AceConfigDialog-3.0")

local isDBOpt = false
local AceDBOptions = LibStub("AceDBOptions-3.0")

local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local SML = LibStub("LibSharedMedia-3.0")

local AloftVisibility = nil
local AloftAlpha = nil

-----------------------------------------------------------------------------

Aloft.namespace = "aloft"
Aloft.defaults =
{
	profile =
	{
		configMode			= false,
		startMessageEnable	= true,
		-- TODO: dead code, delete after testing
		-- enableBloatTest		= false,
		interval			= 0.2,
		classColors =
		{
			["DRUID"]		= { RAID_CLASS_COLORS["DRUID"].r,			RAID_CLASS_COLORS["DRUID"].g,		RAID_CLASS_COLORS["DRUID"].b, },
			["HUNTER"]		= { RAID_CLASS_COLORS["HUNTER"].r,			RAID_CLASS_COLORS["HUNTER"].g,		RAID_CLASS_COLORS["HUNTER"].b, },
			["MAGE"]		= { RAID_CLASS_COLORS["MAGE"].r,			RAID_CLASS_COLORS["MAGE"].g,		RAID_CLASS_COLORS["MAGE"].b, },
			["PALADIN"]		= { RAID_CLASS_COLORS["PALADIN"].r,		RAID_CLASS_COLORS["PALADIN"].g,		RAID_CLASS_COLORS["PALADIN"].b, },
			["PRIEST"]		= { RAID_CLASS_COLORS["PRIEST"].r,			RAID_CLASS_COLORS["PRIEST"].g,		RAID_CLASS_COLORS["PRIEST"].b, },
			["ROGUE"]		= { RAID_CLASS_COLORS["ROGUE"].r,			RAID_CLASS_COLORS["ROGUE"].g,		RAID_CLASS_COLORS["ROGUE"].b, },
			["SHAMAN"]		= { RAID_CLASS_COLORS["SHAMAN"].r,			RAID_CLASS_COLORS["SHAMAN"].g,		RAID_CLASS_COLORS["SHAMAN"].b, },
			["WARLOCK"]		= { RAID_CLASS_COLORS["WARLOCK"].r,		RAID_CLASS_COLORS["WARLOCK"].g,		RAID_CLASS_COLORS["WARLOCK"].b, },
			["WARRIOR"]		= { RAID_CLASS_COLORS["WARRIOR"].r,		RAID_CLASS_COLORS["WARRIOR"].g,		RAID_CLASS_COLORS["WARRIOR"].b, },
			["DEATHKNIGHT"]	= { RAID_CLASS_COLORS["DEATHKNIGHT"].r,	RAID_CLASS_COLORS["DEATHKNIGHT"].g,	RAID_CLASS_COLORS["DEATHKNIGHT"].b, },
		},
	},
}

-----------------------------------------------------------------------------

-- key bindings; plugs into bindings.xml
BINDING_HEADER_ALOFT = L["Aloft"]
BINDING_NAME_ALOFT_SHOW_ENEMY_NAMEPLATES = L["Show Neutral/Enemy Name Plates"]
BINDING_NAME_ALOFT_SHOW_FRIEND_NAMEPLATES = L["Show Friendly Name Plates"]
BINDING_NAME_ALOFT_SHOW_ALL_NAMEPLATES = L["Show All Name Plates"]

-----------------------------------------------------------------------------

Aloft.DataAvailableMethods = { }

-----------------------------------------------------------------------------

local originalGlowTexture
local originalCastBarShieldRegion

local playerGUId
local numberOfWorldChildren = 0
local nameplateList = { }
local noTargetNameplate = false
local nameToNameplateMap = { }
local nameToNameplateMultiMap = { }
local visibleNameplateList = { }
local dataSourceList = { }
local raidColorClassMap = { }

local initializationTimer = nil

Aloft.layoutFramePool = { }

local WorldFrame = WorldFrame

local GetCVar = GetCVar
local SetCVar = SetCVar

local GetAddOnMetadata = GetAddOnMetadata

local IsResting = IsResting
local IsInInstance = IsInInstance
local GetNumPartyMembers = GetNumPartyMembers
local GetNumRaidMembers = GetNumRaidMembers

local UnitIsPlayer = UnitIsPlayer
local UnitPlayerControlled = UnitPlayerControlled
local UnitAffectingCombat = UnitAffectingCombat
local UnitIsPVP = UnitIsPVP
local UnitIsPVPFreeForAll = UnitIsPVPFreeForAll

local UnitClass = UnitClass
local UnitClassification = UnitClassification
local UnitCreatureType = UnitCreatureType
local UnitName = UnitName
local UnitRace = UnitRace

-- Since pairs and select are used often and in loops, make them upvalues rather than a global lookup
local pairs = pairs
local select = select
-- local emptyTable = { }

local horzAdjust =
{
	["TOPLEFT"]		=  1,
	["TOP"]			=  0,
	["TOPRIGHT"]	= -1,
	["LEFT"]		=  1,
	["CENTER"]		=  0,
	["RIGHT"]		= -1,
	["BOTTOMLEFT"]	=  1,
	["BOTTOM"]		=  0,
	["BOTTOMRIGHT"]	= -1,
}

local vertAdjust =
{
	["TOPLEFT"]		= -1,
	["TOP"]			= -1,
	["TOPRIGHT"]	= -1,
	["LEFT"]		=  0,
	["CENTER"]		=  0,
	["RIGHT"]		=  0,
	["BOTTOMLEFT"]	=  1,
	["BOTTOM"]		=  1,
	["BOTTOMRIGHT"]	=  1,
}


-----------------------------------------------------------------------------

-- magic Blizzard reputation strings from .../Interface/FrameXML/GlobalStrings.lua
-- for use in parsing/disambiguating tooltips
Aloft.Reputation =
{
	[FACTION_STANDING_LABEL1]			= true,
	[FACTION_STANDING_LABEL1_FEMALE]	= true,
	[FACTION_STANDING_LABEL2]			= true,
	[FACTION_STANDING_LABEL2_FEMALE]	= true,
	[FACTION_STANDING_LABEL3]			= true,
	[FACTION_STANDING_LABEL3_FEMALE]	= true,
	[FACTION_STANDING_LABEL4]			= true,
	[FACTION_STANDING_LABEL4_FEMALE]	= true,
	[FACTION_STANDING_LABEL5]			= true,
	[FACTION_STANDING_LABEL5_FEMALE]	= true,
	[FACTION_STANDING_LABEL6]			= true,
	[FACTION_STANDING_LABEL6_FEMALE]	= true,
	[FACTION_STANDING_LABEL7]			= true,
	[FACTION_STANDING_LABEL7_FEMALE]	= true,
	[FACTION_STANDING_LABEL8]			= true,
	[FACTION_STANDING_LABEL8_FEMALE]	= true,
}

--[[
FACTION_STANDING_LABEL1 = "Hated"; -- "Hated" faction standing
FACTION_STANDING_LABEL1_FEMALE = "Hated"; -- "Hated" faction standing
FACTION_STANDING_LABEL2 = "Hostile"; -- "Hostile" faction standing
FACTION_STANDING_LABEL2_FEMALE = "Hostile"; -- "Hostile" faction standing
FACTION_STANDING_LABEL3 = "Unfriendly"; -- "Unfriendly" faction standing
FACTION_STANDING_LABEL3_FEMALE = "Unfriendly"; -- "Unfriendly" faction standing
FACTION_STANDING_LABEL4 = "Neutral"; -- "Neutral" faction standing
FACTION_STANDING_LABEL4_FEMALE = "Neutral"; -- "Neutral" faction standing
FACTION_STANDING_LABEL5 = "Friendly"; -- "Friendly" faction standing
FACTION_STANDING_LABEL5_FEMALE = "Friendly"; -- "Friendly" faction standing
FACTION_STANDING_LABEL6 = "Honored"; -- "Honored" faction standing
FACTION_STANDING_LABEL6_FEMALE = "Honored"; -- "Honored" faction standing
FACTION_STANDING_LABEL7 = "Revered"; -- "Revered" faction standing
FACTION_STANDING_LABEL7_FEMALE = "Revered"; -- "Revered" faction standing
FACTION_STANDING_LABEL8 = "Exalted"; -- "Exalted" faction standing
FACTION_STANDING_LABEL8_FEMALE = "Exalted"; -- "Exalted" faction standing
]]

-----------------------------------------------------------------------------

function Aloft:UpdateAloftData(aloftData)
	for i = 1, #dataSourceList do
		dataSourceList[i]:UpdateData(aloftData)
	end
end

local function UpdateAloftTypeData(aloftData, healthBar)
	local oR, oG, oB, oA = healthBar:GetStatusBarColor()
	aloftData.originalHealthBarR = oR
	aloftData.originalHealthBarG = oG
	aloftData.originalHealthBarB = oB

	local r, g, b = floor(aloftData.originalHealthBarR * 256), floor(aloftData.originalHealthBarG*256), floor(aloftData.originalHealthBarB*256)

	if aloftData.name == L["Unknown"] or (aloftData.nameTextRegion and aloftData.nameTextRegion:GetText() ==  L["Unknown"]) then
		aloftData.type = "unknown"
		-- ChatFrame7:AddMessage("Aloft:UpdateAloftTypeData(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible()) .. " explicit")
	elseif r == 255 and g == 0 and b == 0 then -- red
		aloftData.type = "hostile"
		-- ChatFrame7:AddMessage("Aloft:UpdateAloftTypeData(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible()))
	elseif r == 0 and g == 0 and b == 255 then -- blue
		aloftData.type = "friendlyPlayer"
		aloftData.isPlayer = true
	elseif r == 0 and g == 255 and b == 0 then -- green
		aloftData.type = "friendlyNPC"
		-- ChatFrame7:AddMessage("Aloft:UpdateAloftTypeData(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible()))
	elseif r == 255 and g == 255 and b == 0 then -- yellow
		aloftData.type = "neutral"
		-- ChatFrame7:AddMessage("Aloft:UpdateAloftTypeData(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible()))
	elseif Aloft.showClassColorInVKey then
		-- assume hostile player, due to the new Blizzard "Combat>Class Colors in Nameplates" option
		aloftData.type = "hostilePlayer"
		aloftData.isPlayer = true
		-- ChatFrame7:AddMessage("Aloft:UpdateAloftTypeData(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible()) .. " class")
	else
		aloftData.type = "unknown"
		-- ChatFrame7:AddMessage("Aloft:UpdateAloftTypeData(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible()))
	end
end

function Aloft:IsConfigModeEnabled()
	return self.db.profile.configMode and not InCombatLockdown()
end

function Aloft:CancelInConfigMode()
	-- only worry about this if we are actively in config mode
	if self.db.profile.configMode then
		self.db.profile.configMode = false
		self:SendMessage("Aloft:OnConfigModeChanged")
	end

	local aloftData = self:GetTargetNameplate()
	if aloftData then
		aloftData.configMode = nil
	end
end

function Aloft:ProcessHealthBarColorChange(aloftData)
	UpdateAloftTypeData(aloftData, aloftData.healthBar)
	self:SendMessage("Aloft:OnHealthBarColorChanged", aloftData)
end

-- when we enter combat
function Aloft:OnPlayerRegenDisabled(event)
	self:CancelInConfigMode()
end

function Aloft:OnPlayerTargetChanged(event, value)
	-- ChatFrame7:AddMessage("Aloft:OnPlayerTargetChanged(): enter " .. tostring(value))
	noTargetNameplate = false

	-- self:ScheduleTimer(function(aloftData) Aloft:DoPlayerTargetChanged(aloftData) end, 0.0, aloftData) -- next frame
end

function Aloft:OnIsTargetDataChanged(message, aloftData)
	if not (aloftData.isTarget or aloftData:IsTarget()) then
		aloftData.configMode = nil
	end
end

--[[
function Aloft:DoPlayerTargetChanged()
	local aloftData = self:GetTargetNameplate()
	if aloftData then
		self:DumpNameplateHeirarchy(aloftData)
	end
end
]]

-----------------------------------------------------------------------------

function Aloft:LoadOptions()
	if Aloft.Options.args.loadOptions then
		for i = 1,GetNumAddOns() do
			if GetAddOnMetadata(i, "X-Aloft-Options") then
				LoadAddOn(i)
			end
		end
		Aloft.Options.args.loadOptions = nil
		self:SendMessage("Aloft:LoadOptions")
		collectgarbage('collect')
	end
end
-----------------------------------------------------------------------------

local versionInitialize
function Aloft:OnInitialize()
	-- ChatFrame7:AddMessage("Aloft:OnInitialize(): enter")

	if not N then N = L["Aloft"] .. "-" .. Aloft.version end

	Aloft.AloftDB = LibStub("AceDB-3.0"):New("AloftDB", nil, "Default")
	if not self.db or self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	if self.db.profile.startMessageEnable and not versionInitialize then
		DEFAULT_CHAT_FRAME:AddMessage("Aloft version " .. Aloft.version)
		versionInitialize = true
	end

	for i = 1,GetNumAddOns() do
		if GetAddOnMetadata(i, "X-Aloft-Options") then
			Aloft.Options.args.loadOptions =
			{
				type = 'execute',
				name = L["Load Options"],
				desc = L["Load options for Aloft modules"],
				func = function() Aloft:LoadOptions() end,
				order = 5
			}
			break
		end
	end

	-- ChatFrame7:AddMessage("Aloft:OnInitialize(): exit")
end

function Aloft:OnEnable()
	-- ChatFrame7:AddMessage("Aloft:OnEnable(): ----- ENTER -----")
	-- ChatFrame7:AddMessage("Aloft:OnEnable(): " .. debugstack(1, 100, 100))

	AloftVisibility = Aloft:GetModule("Visibility", true)
	AloftAlpha = Aloft:GetModule("Alpha", true)

	-- generate a class color "reverse translation" table, that will let us identify flagged enemy player classes from their "original" health bar colors
	for class, color in pairs(RAID_CLASS_COLORS) do
		-- construct a coarser approximation of thecolor; blizzard's floating-point numbers are not necessarily consistent
		local r, g, b = floor(color.r * 256), floor(color.g * 256), floor(color.b * 256)
		-- ChatFrame7:AddMessage("AloftClassData:OnEnable(): " .. ("|cff%02x%02x%02x%s|r"):format(r, g, b, class .. "-" .. tostring(r) .. "/" .. tostring(g)  .. "/" .. tostring(b)))

		-- initialize the raid color class map
		if (not raidColorClassMap[r]) then raidColorClassMap[r] = { } end
		if (not raidColorClassMap[r][g]) then raidColorClassMap[r][g] = { } end
		raidColorClassMap[r][g][b] = class

		-- ChatFrame7:AddMessage("AloftClassData:OnEnable(): " .. ("%s:%03d.%03d.%03d"):format(class, floor(color.r*100), floor(color.g*100), floor(color.b*100)))
		-- ChatFrame7:AddMessage("AloftClassData:OnEnable(): " .. ("%s:0x%02x%02x%02x"):format(class, floor(color.r*256), floor(color.g*256), floor(color.b*256)))
	end

	-- special case for old pre-2.1.0 shaman class color; magic numbers are used here, from AllPlayed (which incorporates the hex value 0x00dbba for the color) and confirmed via an old addon called ReTeal (which incorporates the table{ r = 0.00, g = 0.86, b = 0.73 })
	local r, g, b = 0x000, 0x0db, 0x0ba
	if (not raidColorClassMap[r]) then raidColorClassMap[r] = { } end
	if (not raidColorClassMap[r][g]) then raidColorClassMap[r][g] = { } end
	raidColorClassMap[r][g][b] = "SHAMAN"
	-- this probably really isn't necessary, its just here for completeness

	-- special case for old pre-3.2 shaman class color; magic numbers are used here, measured during Aloft development (the value { r = 0.14, g = 0.35, b = 1.00 })
	r, g, b = 0x023, 0x059, 0x0ff
	if (not raidColorClassMap[r]) then raidColorClassMap[r] = { } end
	if (not raidColorClassMap[r][g]) then raidColorClassMap[r][g] = { } end
	raidColorClassMap[r][g][b] = "SHAMAN"

	-- current/expected (WoW 3.2) shaman color; magic numbers are used here in case some other addon has changed RAID_CLASS_COLORS (the value { r = 0.00, g = 0.44, b = 0.87 })
	r, g, b = 0x000, 0x070, 0x0de
	if (not raidColorClassMap[r]) then raidColorClassMap[r] = { } end
	if (not raidColorClassMap[r][g]) then raidColorClassMap[r][g] = { } end
	raidColorClassMap[r][g][b] = "SHAMAN"
	-- this covers the shaman class color, in both of its historical forms, just in case an old-school die-hard is running ReTeal :-)

	if not SML:Fetch("border", "Skinner Border") then
		SML:Register("border", "Skinner Border", [[Interface\Addons\Aloft\Textures\krsnik]]) -- stick the skinner border into SharedMedia
	end
	if not SML:Fetch("statusbar", "Empty") then
		SML:Register("statusbar", "Empty", [[Interface\Addons\Aloft\Textures\Empty]]) -- stick the recount empty texture into SharedMedia
	end

	--[[
	for _, module in self:IterateModules() do
		module:Enable()
	end
	]]

	self:InitializeTimer()

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnPlayerRegenDisabled")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnPlayerTargetChanged")
	self:RegisterEvent("CVAR_UPDATE", "OnCVarUpdate")

	-- ChatFrame7:AddMessage("Aloft:OnEnable(): DetermineDataSources()")
	self:DetermineDataSources()

	-- Reinstate hooks and update data - this is for when Aloft is disbaled, and later reenabled
	for aloftData in self:IterateNameplates() do
		self:HookNameplate(aloftData)
		if aloftData:IsShown() then
			visibleNameplateList[aloftData] = true
			self:OnNameplateShow(aloftData)
		end
	end
	
	-- ChatFrame7:AddMessage("" .. tostring(N))

	if (not isConfig) then
		AceConfig:RegisterOptionsTable(N, Aloft.Options, "aloft")
		-- ChatFrame7:AddMessage("Aloft:OnEnable(): register options " .. "'" .. tostring(N) .. "'")
		isConfig = true
	end

	if (not isDialog) then
		self.optionsFrame = AceDialog:AddToBlizOptions(N, "Aloft")
		isDialog = true
	end

	if (not isDBOpt) then
		Aloft.Options.args.profiles = AceDBOptions:GetOptionsTable(Aloft.AloftDB)
		Aloft.Options.args.profiles.order = 800
		isDBOpt = true
	end

	-- force "Combat>Class Colors in Nameplates" option on
	if not self:GetNameplateCVar("ShowClassColorInNameplate") then
		DEFAULT_CHAT_FRAME:AddMessage(Aloft.version .. ": Enabling Blizzard standard 'Combat>Class Colors in Nameplates' interface option")
		self:SetNameplateCVar("ShowClassColorInNameplate", true)
	end
	self.showClassColorInVKey = self:GetNameplateCVar("ShowClassColorInNameplate")
	-- ChatFrame7:AddMessage("Aloft:OnEnable(): ShowClassColorInNameplate " .. tostring(type(self.showClassColorInVKey)) .. "/" .. tostring(self.showClassColorInVKey))

	self.db.profile.configMode = false

	--[[
	table.insert(PreLoadDebugHistory, "ALOFT END")

	for _, value in pairs(PreLoadDebugHistory) do
		ChatFrame7:AddMessage(value)
	end
	--]]

	-- ChatFrame7:AddMessage("Aloft:OnEnable(): exit")
end

function Aloft:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in self:IterateVisibleNameplates() do
		self:SendMessage("Aloft:OnNameplateHide", aloftData)
	end

	for _, module in self:IterateModules() do
		module:DisableDataSource(true)
		-- module:Disable()
	end

	-- replace the textures we zapped during normal operation
	for aloftData in self:IterateNameplates() do
		local nativeGlowRegion = aloftData.nativeGlowRegion
		if nativeGlowRegion and originalGlowTexture then
			nativeGlowRegion:SetTexture(originalGlowTexture)
		end

		local castBarShieldRegion = aloftData.castBarShieldRegion
		if castBarShieldRegion and originalCastBarShieldRegion then
			castBarShieldRegion:SetTexture(originalCastBarShieldRegion)
		end
	end

	self:RedisplayEnemyNameplates()
	self:RedisplayFriendlyNameplates()
end

function Aloft:OnProfileEnable()
	for aloftData in self:IterateVisibleNameplates() do
		self:SendMessage("Aloft:OnNameplateHide", aloftData)
	end

	for _, module in self:IterateModules() do
		if module.OnInitialize then
			module:OnInitialize()
		end
	end

	for _, module in self:IterateModules() do
		if module.OnEnable then
			module:OnEnable()
		end
	end

	self:DetermineDataSources()

	-- iterate all nameplates
	for aloftData in self:IterateNameplates() do
		self:UpdateAloftData(aloftData)
		self:SendMessage("Aloft:OnNameplateShow", aloftData)
	end
end

function Aloft:EnableOptions()
	LoadAddOn("AloftOptions")
	Aloft.Options.args.options = nil -- zap the explicit options button, it is not needed any more
end

function Aloft:InitializeTimer()
	if initializationTimer then self:CancelTimer(initializationTimer, true) end
	initializationTimer = self:ScheduleRepeatingTimer(function() self:Update() end, self.db.profile.interval)
end

-----------------------------------------------------------------------------

local function IsNameplateFrame(frame)
	local frameName = frame:GetName()
	if not frameName or not frameName:find("^NamePlate%d+") then
		-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame(): " .. tostring(frameName) .. " bad frame name ")
		return false
	end
	-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame(): " .. frameName .. " good frame name")

	--[[
	-- legacy frame identification method, presumably rendered obsolete by nameplate frame names
	local region1, region2 = frame:GetRegions()
	overlayRegion = region2
	if not overlayRegion then
		-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame(): " .. frameName .. " no overlayRegion")
		return false
	end
	-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame(): " .. frameName .. " yes overlayRegion")

	if overlayRegion:GetObjectType() ~= "Texture" then
		-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame(): " .. frameName .. " overlayRegion object type " .. tostring(overlayRegionObjectType))
		return false
	end
	-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame():  " .. frameName .. " overlayRegion object type texture")

	local overlayRegionTexture = overlayRegion:GetTexture()
	if overlayRegionTexture ~= "Interface\\Tooltips\\Nameplate-Border" then
		-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame(): " .. frameName .. " bad overlayRegion texture " .. tostring(overlayRegionTexture))
		return false
	end
	-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame(): " .. frameName .. " good overlayRegion texture " .. tostring(overlayRegionTexture))
	]]

	-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame(): " .. frameName .. " IS NAMEPLATE")
	return true
end

function Aloft:ProcessChildFrames(...)
	for i = 1, select('#', ...) do
		local frame = select(i, ...)
		if not frame.aloftData then
			if IsNameplateFrame(frame) then
				-- self:DumpObjectHeirarchy(frame)
				self:SetupNameplate(frame)
			end
		end
	end
end

local oldShowClassColorInVKey
function Aloft:Update()
	local newNumberOfWorldChildren = WorldFrame:GetNumChildren()
	-- ChatFrame7:AddMessage("Aloft:Update(): #WorldFrameChildren " .. tostring(newNumberOfWorldChildren))
	if newNumberOfWorldChildren ~= numberOfWorldChildren then
		numberOfWorldChildren = newNumberOfWorldChildren
		self:ProcessChildFrames(WorldFrame:GetChildren())
	end

	-- for aloftData in pairs(visibleNameplateList) do
	for aloftData in pairs(nameplateList) do
		local r, g, b, a

		local layoutFrame = aloftData.layoutFrame
		local deficitFrame = layoutFrame and layoutFrame.deficitFrame
		local healthRegion = deficitFrame and deficitFrame.healthRegion
		if healthRegion then
			r, g, b, a = healthRegion:GetVertexColor()
		else
			local healthBar = aloftData.healthBar
			r, g, b, a = healthBar:GetStatusBarColor()
		end

		-- local tr, tg, tb = floor(r * 256), floor(g*256), floor(b*256) -- needed for debug statements below, in the body of the if/else
		-- ChatFrame7:AddMessage("Aloft:Update(): " .. ("|cff%02x%02x%02x%s|r"):format(tr, tg, tb, tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(healthRegion == nil) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible())))

		-- An awful awful update routine to stop the game overwriting our colors sporadically; in a few cases blizzard uses the same color as Aloft does, so we need to check the CVar as well
		if ((r ~= aloftData.healthBarR or g ~= aloftData.healthBarG or b ~= aloftData.healthBarB or a ~= aloftData.healthBarA) and (self.showClassColorInVKey == oldShowClassColorInVKey)) then
			-- if the CVar has not changed; we can do this immediately
			-- ChatFrame7:AddMessage("Aloft:Update(): 1 " .. ("|cff%02x%02x%02x%s|r"):format(tr, tg, tb, tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(healthRegion == nil) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible())))
			self:ProcessHealthBarColorChange(aloftData)
		elseif (not (self.showClassColorInVKey == oldShowClassColorInVKey)) then
			-- the CVar has changed, and therefore all visible nameplates may also have changed;
			-- allow until the next frame for the display to catch up with the CVar before attempting to collect color data, or we could have errors
			-- ChatFrame7:AddMessage("Aloft:Update(): 2 " .. ("|cff%02x%02x%02x%s|r"):format(tr, tg, tb, tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(healthRegion == nil) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible())))
			self:ScheduleTimer(function(aloftData) Aloft:ProcessHealthBarColorChange(aloftData) end, 0.0, aloftData) -- next frame
		end
	end
	oldShowClassColorInVKey = self.showClassColorInVKey
end

-----------------------------------------------------------------------------

function Aloft:IterateNameplates()
	return pairs(nameplateList)
end

function Aloft:IterateVisibleNameplates()
	return pairs(visibleNameplateList)
end

function Aloft:GetNamedNameplates(name)
	return name and nameToNameplateMultiMap[name]
end

-----------------------------------------------------------------------------

local dataNameToModuleMap = { }
local moduleToModuleListMap = { }
local unavailableModuleList = { }
local dataRequiredList = { }

function Aloft:UpdateDataNameToModuleMap(module, ...)
	if not ... then return end
	for i = 1,select('#', ...) do
		-- ChatFrame7:AddMessage("Aloft:UpdateDataNameToModuleMap(): Added data module: " .. tostring(select(i, ...)) .. " (" .. tostring(module) .. ")")
		dataNameToModuleMap[select(i, ...)] = module
	end
	if not module:IsModuleDataAvailable() then
		-- ChatFrame7:AddMessage("Aloft:UpdateDataNameToModuleMap(): Flagging " .. tostring(module) .. " as unavailable")
		unavailableModuleList[module] = true
	end
end

function Aloft:UpdateModuleToModuleListMap(module, ...)
	-- ChatFrame7:AddMessage("Aloft:UpdateModuleToModuleListMap(): enter")

	local moduleList = { }
	moduleToModuleListMap[module] = moduleList

	for i = 1,select('#', ...) do
		local dataName = select(i, ...)
		local requiredModule = dataNameToModuleMap[dataName]

		-- ChatFrame7:AddMessage("Aloft:UpdateModuleToModuleListMap(): " .. tostring(module) .. " requires " .. dataName)
		if requiredModule then
			moduleList[requiredModule] = true
			dataRequiredList[dataName] = true
		else
			self:Print(L["Unable to determine module providing data: "]..dataName)
		end
	end

	-- ChatFrame7:AddMessage("Aloft:UpdateModuleToModuleListMap(): exit")
end

function Aloft:RemoveRequiredModuleFromModuleToModuleListMap(requiredModule)
	for module,moduleList in pairs(moduleToModuleListMap) do
		moduleList[requiredModule] = nil
	end
end

local cyclicWarning
function Aloft:DetermineDataSources()
	-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): ENTER")

	-- empty the data required map
	for k in pairs(dataRequiredList) do
		dataRequiredList[k] = nil
	end

	-- 1. Iterate all modules, flag them to be disabled and gather provided data
	for _,module in self:IterateModules() do
		-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): temporarily disabling " .. tostring(module))
		module.needToDisable = true
		self:UpdateDataNameToModuleMap(module, module:ProvidesData())
	end

	-- Iterate all of the modules for data that they require, resolve them to the modules that provide them
	for name,module in self:IterateModules() do
		-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): invoke module " .. tostring(module) .. " UpdateModuleToModuleListMap()")
		self:UpdateModuleToModuleListMap(module, module:RequiresData())
		-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): complete module " .. tostring(module) .. " RequiresData()")
	end

	-- Clear our old data sources
	for i = 1, #dataSourceList do
		dataSourceList[i] = nil
	end

	-- Iterate to remove purely data modules
	local iterationCount = 0	-- A safety factor
	local requiredModules = { }
	while iterationCount < 100 and next(moduleToModuleListMap) do
		-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): ITERATION")
		for module, moduleList in pairs(moduleToModuleListMap) do
			-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): considering module " .. tostring(module))
			for requiredModule in pairs(moduleList) do
				-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): "  .. tostring(module) .. " requires " .. tostring(requiredModule))
				requiredModules[requiredModule] = true
			end
		end
		local moduleRemoved = false
		for module, _ in pairs(moduleToModuleListMap) do
			if module:IsPurelyData() and not requiredModules[module] then
				-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): not required or purely data " .. tostring(module))
				moduleToModuleListMap[module] = nil
				self:RemoveRequiredModuleFromModuleToModuleListMap(module)
				moduleRemoved = true
			end
		end
		if not moduleRemoved then break end
		for k in pairs(requiredModules) do
			-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): clearing required for " .. tostring(k))
			requiredModules[k] = nil
		end
		iterationCount = iterationCount + 1
	end

	-- Iterate our moduleToModuleListMap
	iterationCount = 0	-- A safety factor
	while iterationCount < 100 and next(moduleToModuleListMap) do
		for module, moduleList in pairs(moduleToModuleListMap) do
			for requiredModule in pairs(moduleList) do
				if unavailableModuleList[requiredModule] then
					-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): required module " .. tostring(requiredModule) .. " is unavailable. Flagging module " .. tostring(module) .. " as unavailable")
					unavailableModuleList[module] = true
					moduleList[requiredModule] = nil
				elseif not moduleToModuleListMap[requiredModule] then
					-- The required module isn't dependent on anything! Put it into our dataSourceList and remove from all modules that request it
					-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): directly enabling module " .. tostring(requiredModule))
					table.insert(dataSourceList, requiredModule)
					requiredModule:EnableDataSource()
					requiredModule.needToDisable = nil
					-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): " .. #dataSourceList .. " - " .. tostring(requiredModule))
					self:RemoveRequiredModuleFromModuleToModuleListMap(requiredModule)
				end
			end
			if not next(moduleList) or unavailableModuleList[module] then
				moduleToModuleListMap[module] = nil
			end
		end
		iterationCount = iterationCount + 1
	end

	if next(moduleToModuleListMap) then
		-- self:Print(L["Internal error: Dependency list not resolved - cyclic dependency?"])
		if self.db.profile.startMessageEnable and not cyclicWarning then
			-- warn about cyclic dependencies just once, if enabled
			self:Print(L["Warning: Tag<->module dependency list not resolved - non-fatal cyclic dependency?"])
			cyclicWarning = true
		end
		for k in pairs(moduleToModuleListMap) do
			-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): cyclic dependency " .. tostring(k))
			moduleToModuleListMap[k] = nil
		end
	end

	-- Empty our maps
	for k in pairs(dataNameToModuleMap) do
		dataNameToModuleMap[k] = nil
	end
	for k in pairs(unavailableModuleList) do
		unavailableModuleList[k] = nil
	end

	for _,module in self:IterateModules() do
		if module.needToDisable then
			-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): disabled " .. tostring(module))
			module:DisableDataSource()
		end
	end

	--[[
	for i = 1, #dataSourceList do
		ChatFrame7:AddMessage("Aloft:DetermineDataSources(): enabled " .. tostring(dataSourceList[i]))
	end
	]]

	-- iterate all nameplates
	for aloftData in self:IterateNameplates() do
		self:UpdateAloftData(aloftData)
	end
end

-----------------------------------------------------------------------------


-- NOTE: the code is still here, but Aloft has abandoned the use of nameplate "original" alpha for the moment;
--       there seem to be too many race conditions, in practical use, between Aloft alpha gyrations and Blizzard
--       switching default alpha (1.0) to non-target alpha (0.6), and all the stuff Aloft has to do
--
--       this seems to confuse target nameplate selection
--
--       TODO: it should be possible, however; will revisit this later, including relying on the Alpha module (when
--             available) to set the isTarget flag

local function UseOriginalAlpha()
	return UnitExists("target") and -- only if a target exists
			AloftAlpha and AloftAlpha:IsEnabled() and --[[ AloftAlpha.db and AloftAlpha.db.profile and AloftAlpha.db.profile.targetEnable and AloftAlpha.db.profile.targetAlpha >= 1.0 ]]
			AloftVisibility and AloftVisibility:IsEnabled() and AloftVisibility.db and AloftVisibility.db.profile and AloftVisibility.db.profile.useAlpha and AloftVisibility.db.profile.target
end

function Aloft:GetTargetNameplate(unitName)
	-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): enter")

	-- if noTargetNameplate then

	local targetName, _ = UnitName("target")
	if not targetName or (unitName and unitName ~= targetName) then
		-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): no target" .. tostring(targetName) .. "/" .. tostring(unitName))
		return
	end
	-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): seek " .. (targetName or "<NOTARGET>"))

	local aloftData = self:GetNameplateByAlpha(targetName, 1, nil --[[ UseOriginalAlpha() ]])
	if (not aloftData) then
		-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): no nameplate")
		noTargetNameplate = true
	else
		-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): found nameplate " .. aloftData.name)
	end

	-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): exit")
	return aloftData
end

-- NOTE: this notion of "original" alpha does seem to work here... but it does not work in AloftIsTargetData:DoNameplateShow(); TODO: figure out why
function Aloft:GetNameplateByAlpha(unitName, nameplateAlpha, original)
	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAlpha(): enter" --[[.. debugstack()]])

	if not unitName then return end
	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAlpha(): seek " .. unitName)

	-- named nameplate search
	-- local aloftData = nameToNameplateMap[unitName]
	if (nameToNameplateMultiMap[unitName]) then
		for aloftData in pairs(nameToNameplateMultiMap[unitName]) do
			local nameplateFrame = aloftData and aloftData.nameplateFrame
			if nameplateFrame and ((original and nameplateFrame.originalAlpha == nameplateAlpha) or (nameplateFrame:GetAlpha() == nameplateAlpha)) then
				-- ChatFrame7:AddMessage("Aloft:GetNameplateByAlpha(): fast " .. tostring(aloftData) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(aloftData.nameplateFrame:GetAlpha()))
				return aloftData
			end
		end
	end

	-- full visible nameplate search
	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAlpha(): iterate visible nameplates")
	for aloftData in pairs(visibleNameplateList) do
		if aloftData.name == unitName then
			local nameplateFrame = aloftData and aloftData.nameplateFrame
			if nameplateFrame and ((original and nameplateFrame.originalAlpha == nameplateAlpha) or (nameplateFrame:GetAlpha() == nameplateAlpha)) then
				-- record it for future reference
				nameToNameplateMap[unitName] = aloftData -- most recently seen nameplate with this unit name
				if (not nameToNameplateMultiMap[unitName]) then nameToNameplateMultiMap[unitName] = { } end
				nameToNameplateMultiMap[aloftData.name][aloftData] = true
				-- ChatFrame7:AddMessage("Aloft:GetNameplateByAlpha(): slow " .. tostring(aloftData) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(aloftData.nameplateFrame:GetAlpha()))
				return aloftData
			end
		end
	end

	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAlpha(): exit/nil")
	return nil
end

function Aloft:GetNameplateByAttribute(name, class, race, creatureType, classification, isPet, showClassColorInVKey)
	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAttribute(): enter")

	--[[ ChatFrame7:AddMessage("Aloft:GetNameplateByAttribute(): " .. tostring(name) .. "/" .. tostring(class) .. "/" .. tostring(race) .. "/" ..
		tostring(creatureType) .. "/" .. tostring(classification) .. "/" .. tostring(isPet) .. "/" .. tostring(showClassColorInVKey)) ]]

	if not name then return nil end
	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAttribute(): seek " .. name)

	-- named nameplate search
	--local aloftData = nameToNameplateMap[name]
	if (nameToNameplateMultiMap[name]) then
		for aloftData in pairs(nameToNameplateMultiMap[name]) do
			if self:ValidateNameplateByAttribute(aloftData, name, class, race, creatureType, classification, isPet, showClassColorInVKey) then
				-- ChatFrame7:AddMessage("Aloft:GetNameplateByAttribute(): fast " .. tostring(aloftData.name))
				return aloftData
			end
		end
	end

	-- visible nameplate search
	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAttribute(): iterate visible nameplates")
	for aloftData in pairs(visibleNameplateList) do
		if self:ValidateNameplateByAttribute(aloftData, name, class, race, creatureType, classification, isPet, showClassColorInVKey) then
			-- record it for future reference
			nameToNameplateMap[name] = aloftData -- most recently seen nameplate with this unit name
			if (not nameToNameplateMultiMap[name]) then nameToNameplateMultiMap[name] = { } end
			nameToNameplateMultiMap[aloftData.name][aloftData] = true
			-- ChatFrame7:AddMessage("Aloft:GetNameplateByAttribute(): slow " .. tostring(aloftData.name))
			return aloftData
		end
	end

	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAttribute(): none")
	return nil
end

function Aloft:ValidateNameplateByAttribute(aloftData, name, class, race, creatureType, classification, isPet, showClassColorInVKey)
	-- broken out by line to facilitate addition/subtraction/reordering of logic
	if not aloftData then
		-- ChatFrame7:AddMessage("Aloft:ValidateNameplateByAttribute(): not aloftData")
		return nil
	end
	if aloftData.name ~= name then
		-- ChatFrame7:AddMessage("Aloft:ValidateNameplateByAttribute(): not name " .. tostring(name) .. "/" .. tostring(aloftData.name))
		return nil
	end
	if aloftData.creatureType and aloftData.creatureType ~= creatureType then
		-- ChatFrame7:AddMessage("Aloft:ValidateNameplateByAttribute(): not creatureType " .. tostring(creatureType) .. "/" .. tostring(aloftData.creatureType))
		return nil
	end
	if aloftData.classification and aloftData.classification ~= classification then
		-- ChatFrame7:AddMessage("Aloft:ValidateNameplateByAttribute(): not classification " .. tostring(classification) .. "/" .. tostring(aloftData.classification))
		return nil
	end
	if aloftData.class and aloftData.class ~= class then
		-- ChatFrame7:AddMessage("Aloft:ValidateNameplateByAttribute(): not class " .. tostring(class) .. "/" .. tostring(aloftData.class))
		return nil
	end
	if aloftData.race and aloftData.race ~= race then
		-- ChatFrame7:AddMessage("Aloft:ValidateNameplateByAttribute(): not race " .. tostring(race) .. "/" .. tostring(aloftData.race))
		return nil
	end
	if aloftData.isPet and not isPet then
		-- ChatFrame7:AddMessage("Aloft:ValidateNameplateByAttribute(): not isPet " .. tostring(isPet) .. "/" .. tostring(aloftData.isPet))
		return nil
	end
	if class and (aloftData.type == "hostilePlayer" or aloftData.type == "hostile") and showClassColorInVKey and
	   class ~= self:GetClassByColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB) then
		-- ChatFrame7:AddMessage("Aloft:ValidateNameplateByAttribute(): not class color " .. tostring(class))
		return nil
	end
	return true
end

function Aloft:GetNameplate(name)
	return nameToNameplateMap[name]
end

function Aloft:GetUnitNameplate(unitid)
	local name = unitid and UnitName(unitid)
	if name then
		local race, _ = UnitRace(unitid)
		local class
		local classification
		local creatureType
		local isPet

		if race then
			_, class = UnitClass(unitid) -- NOTE: warlock/death knight pets have a class (which we do not track)
		else
			classification = UnitClassification(unitid)
			creatureType = UnitCreatureType(unitid)
			isPet = ((UnitPlayerControlled(unitid) and not UnitIsPlayer(unitid)) and true) or nil
		end

		--[[ ChatFrame7:AddMessage("Aloft:GetUnitNameplate(): " .. tostring(unitid) .. "/" .. tostring(name) .. "/" .. tostring(class) .. "/" .. tostring(race) .. "/" ..
			tostring(creatureType) .. "/" .. tostring(classification) .. "/" .. tostring(isPet) .. "/" .. tostring(showClassColorInVKey)) ]]

		local aloftData = self:GetNameplateByAttribute(name, class, race, creatureType, classification, isPet, Aloft.showClassColorInVKey)

		--[[ ChatFrame7:AddMessage("Aloft:GetUnitNameplate(): " .. tostring(aloftData and aloftData.unitid) .. "/" .. tostring(aloftData and aloftData.name) .. "/" .. tostring(aloftData and aloftData.class) .. "/" .. tostring(aloftData and aloftData.race) .. "/" ..
			tostring(aloftData and aloftData.creatureType) .. "/" .. tostring(aloftData and aloftData.classification) .. "/" .. tostring(aloftData and aloftData.isPet) .. "/" .. tostring(showClassColorInVKey)) ]]

		return aloftData
	end
end

function Aloft:GetPlace()
	local place = nil
	local inInstance, instanceType = IsInInstance()
	if inInstance and instanceType ~= "none" then
		place = instanceType
	end

	return place
end

-----------------------------------------------------------------------------

function Aloft:OnHealthBarValueChanged(aloftData, value, maxValue)
	if aloftData.nameplateFrame:IsShown() then
		aloftData.healthBarValue = value
		aloftData.healthBarMaxValue = maxValue
		self:SendMessage("Aloft:OnHealthBarValueChanged", aloftData)
	end
end

function Aloft:OnNameplateShow(aloftData)
	-- ChatFrame7:AddMessage("Aloft:OnNameplateShow(): enter " .. tostring(aloftData.name))

	-- self:DumpNameplateHeirarchy(aloftData)

	-- configuration of the reference frame is delegated to AloftFrame:SetupFrame(); we just need it to exist, very early in the lifecycle
	self:AcquireLayoutFrame(aloftData) -- most likely redundant, this is driven in Aloft:Setupframe() as well

	-- When a nameplate is first shown, grab some data about it
	self:SetNameplateName(aloftData, nil)

	local healthBar = aloftData.healthBar
	aloftData.healthBarValue = healthBar:GetValue()
	local _, healthBarMaxValue = healthBar:GetMinMaxValues()
	aloftData.healthBarMaxValue = healthBarMaxValue

	aloftData.isTarget = nil

	local nameplateFrame = aloftData.nameplateFrame
	nameplateFrame.originalAlpha = nil

	aloftData.isBoss = aloftData.bossIconRegion:IsShown()
	aloftData.isElite = aloftData.stateIconRegion:IsVisible() -- quick way to track elites; pure rares do not have a region on the nameplate
	aloftData.level = nil -- level is initialized on the following OnUpdate

	UpdateAloftTypeData(aloftData, healthBar)

	--[[
	self:UpdateAloftData(aloftData)
	self:SendMessage("Aloft:OnNameplateShow", aloftData)
	]]

	-- hook the update script here, since this code can be reached from several points
	-- ChatFrame7:AddMessage("Aloft:OnNameplateShow(): hook update script " .. tostring(aloftData.name))
	if not aloftData.updateDefer then aloftData.updateDefer = 0 end
	if not self:IsHooked(nameplateFrame, "OnUpdate") then
		self:RawHookScript(nameplateFrame, "OnUpdate", "OnNameplateUpdateScript") -- hook to run on the next OnUpdate
	end
	-- ChatFrame7:AddMessage("Aloft:OnNameplateShow(): exit " .. tostring(aloftData.name))
end

-- only called from OnNameplateUpdateScript()
function Aloft:OnNameplateUpdate(aloftData)
	self:SetNameplateName(aloftData, nil)
	-- TODO: this repeats what is done in OnNameplateShow

	-- When a nameplate is first shown, grab some data about it
	local levelTextRegion = aloftData.levelTextRegion
	local levelText = levelTextRegion:GetText()
	local level = tonumber(levelText)

	--[[
	if aloftData.isBoss then
		ChatFrame7:AddMessage("Aloft:OnNameplateUpdate(): " .. tostring(aloftData.name) .. "/" .. tostring(levelText) .. "/" .. tostring(level) .. "/" .. tostring(levelTextRegion:IsVisible()))
	end
	]]

	if level then
		aloftData.levelTextR, aloftData.levelTextG, aloftData.levelTextB = levelTextRegion:GetTextColor()
	else
		aloftData.levelTextR, aloftData.levelTextG, aloftData.levelTextB = 1, 1, 1
	end

	if level ~= aloftData.level and not aloftData.isBoss then
		aloftData.level = level
		self:SendMessage("Aloft:OnUnitLevelChanged", aloftData)
	end

	self:UpdateAloftData(aloftData)
	-- ChatFrame7:AddMessage("Aloft:OnNameplateUpdate(): " .. tostring(aloftData.name) .. " SEND Aloft:OnNameplateShow")
	self:SendMessage("Aloft:OnNameplateShow", aloftData)
	-- ChatFrame7:AddMessage("Aloft:OnNameplateUpdate(): exit " .. tostring(aloftData.name))
end

function Aloft:OnNameplateHide(aloftData)
	self:SendMessage("Aloft:OnNameplateHide", aloftData)
	self:ReleaseReferenceFrame(aloftData)

	local name = aloftData.name
	if name and name ~= "[invalid]" then
		nameToNameplateMap[name] = nil
		if (nameToNameplateMultiMap[name]) then nameToNameplateMultiMap[name][aloftData] = nil end
	end

	aloftData.name = "[invalid]"
	aloftData.nameTextRegionText = nil
	aloftData.level = nil
	aloftData.type = "unknown"
	aloftData.isPlayer = nil
end

-- NOTE: when cast bar is disabled (i.e. via Blizzard "Combat>Cast Bar>On Nameplates"),
--       Blizzard delivers an "OnShow" event, followed immediately by an "OnHide" event, and no "OnValueChanged" events;
--       and apparently, in the process, it shows the default target spell cast icon for a few frames, and leaves it

function Aloft:OnCastBarValueChanged(aloftData, castBar, value)
	-- ChatFrame7:AddMessage("Aloft:OnCastBarValueChanged(): " .. tostring(aloftData.name))
	-- ChatFrame7:AddMessage("Aloft:OnCastBarValueChanged(): " .. tostring(aloftData.name) .. "/" .. tostring(castFrame) .. "/" .. tostring(castFrame and castFrame:IsVisible()) .. "/" .. tostring(value))
	self:SendMessage("Aloft:OnCastBarValueChanged", aloftData)
end

function Aloft:OnCastBarShow(aloftData, castBar)
	-- ChatFrame7:AddMessage("Aloft:OnCastBarShow(): " .. tostring(aloftData.name))
	if aloftData.isTarget or aloftData:IsTarget() then -- only interested in the target nameplate, if any
		local layoutFrame = aloftData.layoutFrame
		local castFrame = layoutFrame and layoutFrame.castFrame

		-- ChatFrame7:AddMessage("Aloft:OnCastBarShow(): " .. tostring(aloftData.name) .. "/" .. tostring(castFrame) .. "/" .. tostring(castFrame and castFrame:IsVisible()))

		-- trying to avoid extra work: if the castFrame is already visible, no need to post again
		if not castFrame or not castFrame:IsVisible() then
			-- ChatFrame7:AddMessage("Aloft:OnCastBarShow(): " .. tostring(aloftData.name) .. " send Aloft:OnCastBarShow")
			self:SendMessage("Aloft:OnCastBarShow", aloftData)
		end
	end
end

function Aloft:OnCastBarHide(aloftData)
	-- ChatFrame7:AddMessage("Aloft:OnCastBarHide(): " .. tostring(aloftData.name))
	self:SendMessage("Aloft:OnCastBarHide", aloftData)
end

-- NOTE: this is the FontString:SetText() hook script
function Aloft:SetNameTextRegionText(this, text)
	local aloftData = this.aloftData

	-- if aloftData.name == L["Unknown"] or aloftData.type == "unknown" then
	--	ChatFrame7:AddMessage("Aloft:SetNameTextRegionText(): WAS unknown " .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(text) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible()))
	-- end

	-- attempt at workaround for Maldazzar's name text wrap problem, 2010/10/17
	-- NOTE: doesn't really address the problem :-(
	if this.SetNonSpaceWrap then
		this:SetNonSpaceWrap(false)
		-- ChatFrame7:AddMessage("Aloft:SetNameText(): SetNonSpaceWrap " .. tostring(text))
	end

	self.hooks[this].SetText(this, text) -- delegate up to the real set text, on the actual region
	self:SetNameplateName(aloftData, text)
	aloftData.nameTextRegionText = text

	-- presumably, when Blizzard updates the nameplate unit name text on an unknown unit, we will detect it here
	if aloftData.name == L["Unknown"] or aloftData.type == "unknown" then
		self:OnNameplateShow(aloftData) -- TODO: repeats the call to Aloft:SetNameplateName()?
		self:ProcessHealthBarValueChanged(aloftData, nil, nil)
		-- ChatFrame7:AddMessage("Aloft:SetNameTextRegionText(): WAS unknown " .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(text) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible()))
	end
end

-- experiment that failed; default Blizzard UI does not set name text region color this way
--[[
function Aloft:SetNameTextRegionColor(this, r, g, b, a)
	ChatFrame7:AddMessage("Aloft:SetNameTextRegionColor(): " .. tostring(r and floor(255*r)) .. "/" .. tostring(g and floor(255*g)) .. "/" .. tostring(b and floor(255*b)) .. "/" .. tostring(a and floor(255*a)))
	return self.hooks[this].SetTextColor(this, r, g, b, a)
end
]]

function Aloft:GetNameTextRegionText(this)
	local name = this.aloftData.name
	if name ~= "[invalid]" then return name end
	return self.hooks[this].GetText(this)
end

function Aloft:GetRawNameTextRegionText(this)
	return self.hooks[this].GetText(this)
end

-----------------------------------------------------------------------------

function Aloft:OnNameplateShowScript(this)
	local aloftData = this.aloftData

	-- ChatFrame7:AddMessage("Aloft:OnNameplateShowScript(): show " .. tostring(aloftData.name))
	noTargetNameplate = false
	-- ChatFrame7:AddMessage("Aloft:OnNameplateShowScript(): clear noTargetNameplate")
	visibleNameplateList[aloftData] = true
	self:OnNameplateShow(aloftData)

	self.hooks[this]["OnShow"](this)
end

-- hooked from OnNameplateShow()
function Aloft:OnNameplateUpdateScript(this)
	local aloftData = this.aloftData

	local update = nil
	if aloftData.updateDefer then
		if aloftData.updateDefer >= ONUPDATE_DEFER then
			update = true
			aloftData.updateDefer = nil
		else
			aloftData.updateDefer = aloftData.updateDefer + 1
		end
	end
	-- ChatFrame7:AddMessage("Aloft:OnNameplateUpdateScript(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.updateDefer) .. "/" .. tostring(update))

	if update then
		self:OnNameplateUpdate(aloftData)
	end

	self.hooks[this]["OnUpdate"](this)

	if update then
		if self:IsHooked(this, "OnUpdate") then self:Unhook(this, "OnUpdate") end -- unhook if necessary, we want to run only once
		-- ChatFrame7:AddMessage("Aloft:OnNameplateUpdateScript(): unhook update " .. tostring(aloftData.name))
	end
end

function Aloft:OnNameplateHideScript(this)
	local aloftData = this.aloftData

	self:OnNameplateHide(aloftData)
	visibleNameplateList[aloftData] = nil
	aloftData.updateDefer = nil

	self.hooks[this]["OnHide"](this)
	if self:IsHooked(this, "OnUpdate") then self:Unhook(this, "OnUpdate") end -- unhook if necessary
end

function Aloft:OnHealthBarValueChangedScript(this, value)
	local _, maxValue = this:GetMinMaxValues()
	self:ProcessHealthBarValueChanged(this.aloftData, value, maxValue)
	self.hooks[this]["OnValueChanged"](this, value)
end

function Aloft:OnCastBarValueChangedScript(this, value)
	self:OnCastBarValueChanged(this.aloftData, this, value)
	self.hooks[this]["OnValueChanged"](this, value)
end

function Aloft:OnCastBarShowScript(this)
	self:OnCastBarShow(this.aloftData, this)
	self.hooks[this]["OnShow"](this)
end

function Aloft:OnCastBarHideScript(this)
	self:OnCastBarHide(this.aloftData)
	self.hooks[this]["OnHide"](this)
end

-----------------------------------------------------------------------------

function Aloft:ProcessHealthBarValueChanged(aloftData, value, maxValue)
	if value and maxValue then
		self:OnHealthBarValueChanged(aloftData, value, maxValue)
	else
		local value, maxValue = aloftData.healthBar:GetMinMaxValues()
		self:OnHealthBarValueChanged(aloftData, value, maxValue)
	end
end

function Aloft:SetNameplateName(aloftData, newNameText)
	-- if aloftData.name == L["Unknown"] or aloftData.type == "unknown" then
	--	ChatFrame7:AddMessage("Aloft:SetNameplateName(): WAS unknown " .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(newNameText) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible()))
	-- end

	local notify = nil

	if not newNameText then
		-- should only occur when a nameplate first becomes visible
		nameTextRegion = aloftData.nameTextRegion
		newNameText = self.hooks[nameTextRegion].GetText(nameTextRegion)
	end

	-- clear the old name, if any
	local name = aloftData.name
	if name and name ~= "[invalid]" then
		nameToNameplateMap[name] = nil
		if (nameToNameplateMultiMap[name]) then nameToNameplateMultiMap[name][aloftData] = nil end
	end

	if newNameText ~= name then
		-- ChatFrame7:AddMessage("Aloft:SetNameplateName(): " .. tostring(aloftData) .. "/" .. tostring(aloftData.name) .. ">" .. tostring(newNameText))
		aloftData.name = newNameText
		notify = true
	end
	if not aloftData.name then
		aloftData.name = "[invalid]"
		notify = true
	end

	-- make a record of the new name
	name = aloftData.name
	if name and name ~= "[invalid]" then
		nameToNameplateMap[name] = aloftData -- most recently seen nameplate with this unit name
		if (not nameToNameplateMultiMap[name]) then nameToNameplateMultiMap[name] = { } end
		nameToNameplateMultiMap[name][aloftData] = true
	end

	if notify then
		self:SendMessage("Aloft:OnUnitNameChanged", aloftData)
	end

	-- NOTE: aloftData.nameTextRegionText is set via the Aloft:SetNameTextRegionText() "SetText" hook
end

function Aloft:SetHealthBarColor(frame, r, g, b, a)
	-- if not frame.recurse then
	--	frame.recurse = true

		local aloftData = frame.aloftData
		-- ChatFrame7:AddMessage("Aloft:SetHealthBarColor(): " .. tostring(this) .. "/" .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.healthBar))

		self.hooks[frame].SetStatusBarColor(frame, r, g, b, a)
		-- self:ProcessHealthBarColor(aloftData) -- TODO: this is an unfortunate method name, rationalize
		self:ProcessHealthBarColorChange(aloftData) -- TODO: this is an unfortunate method name, rationalize

		local tr, tg, tb = floor(aloftData.originalHealthBarR * 256), floor(aloftData.originalHealthBarG*256), floor(aloftData.originalHealthBarB*256)
		-- ChatFrame7:AddMessage("Aloft:SetHealthBarColor(): " .. ("|cff%02x%02x%02x%s|r"):format(tr, tg, tb, tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible())))

		-- ChatFrame7:AddMessage("Aloft:SetHealthBarColor(): " .. aloftData.name)
		-- ChatFrame7:AddMessage("Aloft:SetHealthBarColor(): " .. ("|cff%02x%02x%02x%s|r"):format(aloftData.healthBarR*255, aloftData.healthBarG*255, aloftData.healthBarB*255, "health bar color"))
	--	frame.recurse = nil
	-- else
	--	ChatFrame7:AddMessage("Aloft:SetHealthBarColor(): " .. tostring(frame) .. "/" .. tostring(frame:GetObjectType()) .. "/" .. tostring(frame.aloftData.name))
	--	ChatFrame7:AddMessage("Aloft:SetHealthBarColor(): " .. debugstack(1, 100, 100))
	-- end
end

-- TODO: this is an unfortunate method name
-- TODO: this implementation does not work; if we have to read these back after setting them, do it where they are set
function Aloft:ProcessHealthBarColor(aloftData)
	local layoutFrame = aloftData and aloftData.layoutFrame
	local deficitFrame = layoutFrame and layoutFrame.deficitFrame
	local healthRegion = deficitFrame and deficitFrame.healthRegion
	if healthRegion then
		-- We read the color back, because rounding seems to kick in and prevent them from being exactly what we sent...
		-- aloftData.healthBarR, aloftData.healthBarG, aloftData.healthBarB, aloftData.healthBarA = healthBar:GetStatusBarColor()
		aloftData.healthBarR, aloftData.healthBarG, aloftData.healthBarB, aloftData.healthBarA = healthRegion:GetVertexColor()
	end
end

-----------------------------------------------------------------------------

local function AloftDataIsTarget(aloftData, name) return (aloftData.nameplateFrame:GetAlpha() == 1 and (aloftData.name == name or aloftData.name == UnitName("target"))) or nil end
local function AloftDataIsShown(aloftData) return aloftData.nameplateFrame:IsShown() end

local function AloftDataCreateFontString(aloftData) return aloftData.layoutFrame:CreateFontString(nil, "OVERLAY") end
local function AloftDataCreateTexture(aloftData) local texture = aloftData.layoutFrame:CreateTexture(nil, "OVERLAY") texture:SetBlendMode("BLEND") return texture end

function Aloft:SetupNameplate(frame)
	local aloftData = { type = "unknown", name = "[invalid]", IsTarget = AloftDataIsTarget, IsShown = AloftDataIsShown, CreateFontString = AloftDataCreateFontString, CreateTexture = AloftDataCreateTexture }
	frame.aloftData = aloftData
	nameplateList[aloftData] = true
	visibleNameplateList[aloftData] = true
	noTargetNameplate = false

	-- ChatFrame7:AddMessage("Aloft:SetupNameplate(): " .. tostring(frame) .. "/" .. tostring(aloftData))
	aloftData.nameplateFrame = frame -- NOTE: need a nameplateFrame before we can instantiate a layoutFrame

	-- obtain the children
	local healthBar, castBar = frame:GetChildren()

	-- Reference all of these now
	aloftData.healthBar = healthBar
	healthBar.aloftData = aloftData

	aloftData.castBar = castBar
	castBar.aloftData = aloftData

	-- self:DumpNameplateHeirarchy(aloftData)

	self:AcquireLayoutFrame(aloftData) -- configuration of the reference frame is delegated to AloftFrame:SetupFrame(); we just need it to exist, very early in the lifecycle

	local nativeGlowRegion, overlayRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion = self:GetNameplateRegions(aloftData)
	local castBarRegion, castBarOverlayRegion, castBarShieldRegion, spellIconRegion = self:GetCastBarRegions(aloftData)

	-- zap the Blizzard default glow region, it is not used under Aloft
	local texture = nativeGlowRegion.GetTexture and nativeGlowRegion:GetTexture()
	if not originalGlowTexture and texture ~= "" then
		originalGlowTexture = texture
	end
	if nativeGlowRegion.SetTexture then nativeGlowRegion:SetTexture("") end

	-- zap the Blizzard default cast bar shield region, it is not used under Aloft
	texture = castBarShieldRegion.GetTexture and castBarShieldRegion:GetTexture()
	if not originalCastBarShieldRegion and texture ~= "" then
		originalCastBarShieldRegion = texture
	end
	if castBarShieldRegion.SetTexture then castBarShieldRegion:SetTexture("") end

	--[[
	local r, g, b, a = stateIconRegion:GetVertexColor()
	
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): " .. tostring(nameTextRegion:GetText()) .. "/" .. tostring(stateIconRegion:IsVisible()) .. "/" .. tostring(stateIconRegion:GetTexture())
		.. "/" .. tostring(floor(r * 256)) .. "-" .. tostring(floor(g * 256))  .. "-" .. tostring(floor(b * 256))  .. "-" .. tostring(floor(a * 256)))
	]]

	--[[
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): frame #regions " .. tostring(frame:GetNumRegions()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): nativeGlowRegion " .. tostring(nativeGlowRegion:GetName()) .. "/" .. tostring(nativeGlowRegion:GetObjectType()) .. "/" .. tostring(nativeGlowRegion:GetTexture()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): overlayRegion " .. tostring(overlayRegion:GetName()) .. "/" .. tostring(overlayRegion:GetObjectType()) .. "/" .. tostring(overlayRegion:GetTexture()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): castBarOverlayRegion " .. tostring(castBarOverlayRegion:GetName()) .. "/" .. tostring(castBarOverlayRegion:GetObjectType()) .. "/" .. tostring(castBarOverlayRegion:GetTexture()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): spellIconRegion " .. tostring(spellIconRegion:GetName()) .. "/" .. tostring(spellIconRegion:GetObjectType()) .. "/" .. tostring(spellIconRegion:GetTexture()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): highlightRegion " .. tostring(highlightRegion:GetName()) .. "/" .. tostring(highlightRegion:GetObjectType()) .. "/" .. tostring(highlightRegion:GetTexture()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): nameTextRegion " .. tostring(nameTextRegion:GetName()) .. "/" .. tostring(nameTextRegion:GetObjectType()) .. "/" .. tostring(nameTextRegion:GetText()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): levelTextRegion " .. tostring(levelTextRegion:GetName()) .. "/" .. tostring(levelTextRegion:GetObjectType()) .. "/" .. tostring(levelTextRegion:GetText()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): bossIconRegion " .. tostring(bossIconRegion:GetName()) .. "/" .. tostring(bossIconRegion:GetObjectType()) .. "/" .. tostring(bossIconRegion:GetTexture()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): raidIconRegion " .. tostring(raidIconRegion:GetName()) .. "/" .. tostring(raidIconRegion:GetObjectType()) .. "/" .. tostring(raidIconRegion:GetTexture()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): stateIconRegion " .. tostring(stateIconRegion:GetName()) .. "/" .. tostring(stateIconRegion:GetObjectType()) .. "/" .. tostring(stateIconRegion:GetTexture()))
	]]

	--[[
	local point, relativeTo, relativePoint, xOfs, yOfs = stateIconRegion:GetPoint()
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): stateIconRegion point " .. tostring(point) .. "/" .. tostring(relativeTo:GetName()) .. "/" .. tostring(relativePoint) .. "/" .. tostring(xOfs) .. "/" .. tostring(yOfs))
	]]

	--[[
	local height, width = stateIconRegion:GetHeight(), stateIconRegion:GetWidth()
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): stateIconRegion size " .. tostring(height) .. "/" .. tostring(width))
	]]

	--[[
	local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy = stateIconRegion:GetTexCoord()
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): stateIconRegion coord " .. tostring(ULx) .. "/" .. tostring(ULy) .. "/" .. tostring(LLx) .. "/" .. tostring(LLy) .. "/" .. tostring(URx) .. "/" .. tostring(URy) .. "/" .. tostring(LRx) .. "/" .. tostring(LRy))
	]]

	aloftData.nativeGlowRegion = nativeGlowRegion
	aloftData.overlayRegion = overlayRegion
	aloftData.castBarOverlayRegion = castBarOverlayRegion
	aloftData.castBarShieldRegion = castBarShieldRegion
	aloftData.spellIconRegion = spellIconRegion
	aloftData.highlightRegion = highlightRegion
	aloftData.levelTextRegion = levelTextRegion
	aloftData.bossIconRegion = bossIconRegion
	aloftData.raidIconRegion = raidIconRegion
	aloftData.stateIconRegion = stateIconRegion

	nativeGlowRegion.aloftData = aloftData
	nameTextRegion.aloftData = aloftData
	levelTextRegion.aloftData = aloftData

	-- hide the original Blizzard name text region
	aloftData.nameTextRegion = nameTextRegion
	nameTextRegion:Hide()

	--[[
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): frame #children " .. tostring(frame:GetNumChildren()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): healthBar " .. tostring(healthBar:GetName()) .. "/" .. tostring(healthBar:GetObjectType()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): castBar " .. tostring(castBar:GetName()) .. "/" .. tostring(castBar:GetObjectType()))

	ChatFrame7:AddMessage("Aloft:SetupNameplate(): --- castBar frame " .. tostring(castBar:GetName()) .. "/" .. tostring(castBar:GetObjectType()))
	ChatFrame7:AddMessage("Aloft:SetupNameplate(): - castBar frame #regions " .. tostring(castBar:GetNumRegions()) .. " #children " .. tostring(castBar:GetNumChildren()))
	local castBar01, castBar02, castBar03, castBar04, castBar05 = castBar:GetRegions()
	if (castBar01) then ChatFrame7:AddMessage("Aloft:SetupNameplate(): castBar01 " .. tostring(castBar01:GetName()) .. "/" .. tostring(castBar01:GetObjectType()) .. "/" .. tostring(castBar01:GetTexture())) end
	if (castBar02) then ChatFrame7:AddMessage("Aloft:SetupNameplate(): castBar02 " .. tostring(castBar02:GetName()) .. "/" .. tostring(castBar02:GetObjectType()) .. "/" .. tostring(castBar02:GetTexture())) end
	if (castBar03) then ChatFrame7:AddMessage("Aloft:SetupNameplate(): castBar03 " .. tostring(castBar03:GetName()) .. "/" .. tostring(castBar03:GetObjectType())) end
	if (castBar04) then ChatFrame7:AddMessage("Aloft:SetupNameplate(): castBar04 " .. tostring(castBar04:GetName()) .. "/" .. tostring(castBar04:GetObjectType())) end
	if (castBar05) then ChatFrame7:AddMessage("Aloft:SetupNameplate(): castBar05 " .. tostring(castBar05:GetName()) .. "/" .. tostring(castBar05:GetObjectType())) end
`	]]

	self:HookNameplate(aloftData)

	-- ChatFrame7:AddMessage("Aloft:SetupNameplate(): trigger Aloft:SetupFrame " .. tostring(aloftData))
	self:SendMessage("Aloft:SetupFrame", aloftData)

	self:OnNameplateShow(aloftData)
	if castBar:IsShown() then
		self:OnCastBarShow(aloftData, castBar)
	end
end

function Aloft:HookNameplate(aloftData)
	local nameplateFrame = aloftData.nameplateFrame
	self:RawHookScript(nameplateFrame, "OnShow", "OnNameplateShowScript")
	self:RawHookScript(nameplateFrame, "OnHide", "OnNameplateHideScript")

	local healthBar = aloftData.healthBar
	self:RawHookScript(healthBar, "OnValueChanged", "OnHealthBarValueChangedScript")
	self:RawHook(healthBar, "SetStatusBarColor", "SetHealthBarColor", true)

	local castBar = aloftData.castBar
	self:RawHookScript(castBar, "OnShow", "OnCastBarShowScript")
	self:RawHookScript(castBar, "OnHide", "OnCastBarHideScript")
	self:RawHookScript(castBar, "OnValueChanged", "OnCastBarValueChangedScript")

	local nameTextRegion = aloftData.nameTextRegion
	-- ChatFrame7:AddMessage("Aloft:HookNameplate(): nameTextRegion object type " .. tostring(nameTextRegion:GetObjectType()))
	-- ChatFrame7:AddMessage("Aloft:HookNameplate(): nameTextRegion text  " .. tostring(nameTextRegion:GetText()))

	self:RawHook(nameTextRegion, "SetText", "SetNameTextRegionText", true)
	self:RawHook(nameTextRegion, "GetText", "GetNameTextRegionText", true)
	-- self:RawHook(nameTextRegion, "SetTextColor", "SetNameTextRegionColor", true) -- failed experiment

	-- local levelTextRegion = aloftData.levelTextRegion
	-- ChatFrame7:AddMessage("Aloft:HookNameplate(): levelTextRegion object type " .. tostring(levelTextRegion:GetObjectType()))
	-- ChatFrame7:AddMessage("Aloft:HookNameplate(): levelTextRegion text " .. tostring(levelTextRegion:GetText()))
end

-----------------------------------------------------------------------------

function Aloft:OnCVarUpdate(event, name, value)
	-- ChatFrame7:AddMessage("Aloft:OnCVarUpdate(): " .. tostring(event) .. "/" .. tostring(name) .. "/" .. tostring(type(value)) .. "/" .. tostring(value))

	if (name == "SHOW_CLASS_COLOR_IN_V_KEY") then
		-- this is a MAJOR PAIN IN THE ASS; the event name is not the same as the CVar name; had to dig in the WTF files for the CVar name

		-- local infoName, defaultValue, serverStoredAccountWide, serverStoredPerCharacter = GetCVarInfo("ShowClassColorInNameplate")
		-- ChatFrame7:AddMessage("Aloft:OnCVarUpdate(): " .. tostring(infoName) .. "/" .. tostring(defaultValue) .. "/" .. tostring(serverStoredAccountWide) .. "/" .. tostring(serverStoredPerCharacter))

		if value ~= "1" then
			-- ChatFrame7:AddMessage("Aloft:OnCVarUpdate(): off? " .. tostring(name) .. "/" .. tostring(type(value)) .. "/" .. tostring(value))

			-- self:SetNameplateCVar("ShowClassColorInNameplate", true) -- force setting
			DEFAULT_CHAT_FRAME:AddMessage("|cffff0000WARNING: |r|cffffff00Aloft STRONGLY prefers that 'Combat>Class Colors in Nameplates' remain enabled at all times|r")
			DEFAULT_CHAT_FRAME:AddMessage("|cffff0000WARNING: |r|cffffff00Use Aloft's 'Health Bar>Colors' options to control the display color of nameplates|r")
		end

		self.showClassColorInVKey = (value == "1") and true or false
		-- ChatFrame7:AddMessage("Aloft:OnCVarUpdate(): " .. tostring(name) .. "/" .. tostring(self.showClassColorInVKey))
	end

	if N then AceConfigRegistry:NotifyChange(N) end -- changes to these may affect visible options dialogs

	-- ChatFrame7:AddMessage("Aloft:OnCVarUpdate(): " .. tostring(name) .. "/" .. tostring(value))
	-- TODO: set to check the CVar for enable/disable
end

-----------------------------------------------------------------------------

function Aloft:GetNameplateDisplayState()
	local stateString
	if UnitAffectingCombat("player") then
		stateString = L["Combat"]
	elseif UnitIsPVP("player") or UnitIsPVPFreeForAll("player") then
		stateString = L["Flagged/PvP"]
	elseif IsResting() then
		stateString = L["Resting"]
	elseif (GetNumPartyMembers() > 0)  or (GetNumRaidMembers() > 0) then
		stateString = L["Group"]
	else
		stateString = L["Default"]
	end

	local placeString
	local place = self:GetPlace()
	if not place then
		placeString = L["World"]
	elseif place == "pvp" then
		placeString = L["Battleground"]
	elseif place == "arena" then
		placeString = L["Arena"]
	elseif place == "party" then
		placeString = L["5-Man Instance"]
	elseif place == "raid" then
		placeString = L["Raid Instance"]
	end

	return stateString .. "/" .. placeString
end

function Aloft:SetEnemyNameplateDisplay(value)
	-- ChatFrame7:AddMessage("Aloft:SetEnemyNameplateDisplay(): nameplateShowEnemies " .. tostring(value))
	self:SetNameplateCVar("nameplateShowEnemies", value)
end

function Aloft:SetFriendNameplateDisplay(value)
	-- ChatFrame7:AddMessage("Aloft:SetFriendNameplateDisplay(): nameplateShowFriends " .. tostring(value))
	self:SetNameplateCVar("nameplateShowFriends", value)
end

-- tired of Blizzard's evolving hodgepodge of CVar types; these read as strings ("0"/"1") but must be set as numbers (0/1)
function Aloft:GetNameplateCVar(cvar)
	local value = GetCVar(cvar)

	-- ChatFrame7:AddMessage("Aloft:GetNameplateCVar(): " .. tostring(cvar) .. "/" .. tostring(type(value)) .. "/" .. tostring(value))
	-- ChatFrame7:AddMessage("Aloft:GetNameplateCVar(): " .. debugstack(1, 4, 4))

	if value and ((type(value) == "string" and value ~= "0") or (type(value) == "number" and value ~= 0) or (type(value) == "boolean")) then
		return true
	end
	return false
end

-- "extended" version, returns the literal value (rather than reinterpreting into boolean)
function Aloft:GetNameplateCVarX(cvar)
	local value = GetCVar(cvar)

	-- ChatFrame7:AddMessage("Aloft:GetNameplateCVarX(): " .. tostring(cvar) .. "/" .. tostring(type(value)) .. "/" .. tostring(value))
	-- ChatFrame7:AddMessage("Aloft:GetNameplateCVarX(): " .. debugstack(1, 4, 4))

	return value
end

-- all nameplate-related CVars are numbers now?
function Aloft:SetNameplateCVar(cvar, value)
	-- ChatFrame7:AddMessage("Aloft:SetNameplateCVar(): enter " .. tostring(cvar) .. "/" .. tostring(Aloft:GetNameplateCVar(cvar)))

	-- ChatFrame7:AddMessage("Aloft:SetNameplateCVar(): " .. tostring(cvar) .. "/" .. tostring(value))
	-- ChatFrame7:AddMessage("Aloft:GetNameplateCVar(): " .. debugstack(1, 4, 4))	

	if value then
		SetCVar(cvar, 1)
	else
		SetCVar(cvar, 0)
	end

	-- ChatFrame7:AddMessage("Aloft:SetNameplateCVar(): exit " .. tostring(cvar) .. "/" .. tostring(Aloft:GetNameplateCVar(cvar)))
end

-- extended form
function Aloft:SetNameplateCVarX(cvar, which, value1, value2)
	-- ChatFrame7:AddMessage("Aloft:SetNameplateCVarX(): enter " .. tostring(cvar) .. "/" .. tostring(Aloft:GetNameplateCVar(cvar)))

	-- ChatFrame7:AddMessage("Aloft:SetNameplateCVarX(): " .. tostring(cvar) .. "/" .. tostring(value))
	-- ChatFrame7:AddMessage("Aloft:SetNameplateCVarX(): " .. debugstack(1, 4, 4))	

	if which then
		SetCVar(cvar, value1)
	else
		SetCVar(cvar, value2)
	end

	-- ChatFrame7:AddMessage("Aloft:SetNameplateCVarX(): exit " .. tostring(cvar) .. "/" .. tostring(Aloft:GetNameplateCVar(cvar)))
end

-----------------------------------------------------------------------------

function Aloft:GetEnemyNameplates()
	local value = self:GetNameplateCVar("nameplateShowEnemies")
	-- ChatFrame7:AddMessage("Aloft:GetEnemyNameplates(): nameplateShowEnemies " .. tostring(type(value)) .. "/" .. tostring(value))
	return value
end

function Aloft:DisplayEnemyNameplates(value)
	-- ChatFrame7:AddMessage("Aloft:DisplayEnemyNameplates(): " .. tostring(value))
	self:SetEnemyNameplateDisplay(value)
end

function Aloft:ToggleEnemyNameplates()
	local value = self:GetEnemyNameplates()
	self:DisplayEnemyNameplates(not value)
end

function Aloft:GetFriendNameplates()
	local value = self:GetNameplateCVar("nameplateShowFriends")
	-- ChatFrame7:AddMessage("Aloft:GetFriendNameplates(): nameplateShowFriends " .. tostring(type(value)) .. "/" .. tostring(value))
	return value
end

function Aloft:DisplayFriendNameplates(value)
	-- ChatFrame7:AddMessage("Aloft:DisplayFriendNameplates(): " .. tostring(value))
	self:SetFriendNameplateDisplay(value)
end

function Aloft:ToggleFriendNameplates()
	local value = self:GetFriendNameplates()
	self:DisplayFriendNameplates(not value)
end

function Aloft:ToggleAllNameplates()
	-- ChatFrame7:AddMessage("Aloft:ToggleAllNameplates(): enter")
	if (self:GetEnemyNameplates() or self:GetFriendNameplates()) then
		-- ChatFrame7:AddMessage("Aloft:ToggleAllNameplates(): disable all nameplates")
		self:DisplayEnemyNameplates(false)
		self:DisplayFriendNameplates(false)
	else
		-- ChatFrame7:AddMessage("Aloft:ToggleAllNameplates(): enable all nameplates")
		self:DisplayEnemyNameplates(true)
		self:DisplayFriendNameplates(true)
	end
	-- ChatFrame7:AddMessage("Aloft:ToggleAllNameplates(): exit")
end

-----------------------------------------------------------------------------

-- versions of redisplay functionality that bypass possibly hooked functions, since we just want to "bounce" nameplates, not affect options or issue announcements

function Aloft:BounceEnemyNameplates()
	local value = self:GetEnemyNameplates()
	self:SetNameplateCVar("nameplateShowEnemies", not value)
	self:ScheduleTimer(function(value) Aloft:DoBounceEnemyNameplates(value) end, 0.15, value)
end

function Aloft:DoBounceEnemyNameplates(value)
	self:SetNameplateCVar("nameplateShowEnemies", value)
end

function Aloft:BounceFriendNameplates()
	local value = self:GetFriendNameplates()
	self:SetNameplateCVar("nameplateShowFriends", not value)
	self:ScheduleTimer(function(value) Aloft:DoBounceFriendlyNameplates(value) end, 0.25, value)
end

function Aloft:DoBounceFriendlyNameplates(value)
	self:SetNameplateCVar("nameplateShowFriends", value)
end

-----------------------------------------------------------------------------

-- Provide these functions mainly for Visibiltiy module. ReportStatusChanges can hook them so that the log doesn't fill up
function Aloft:RedisplayEnemyNameplates()
	self:ScheduleTimer(function () Aloft:DoDisplayEnemyNameplates() end, 0.15)
end

function Aloft:DoDisplayEnemyNameplates()
	local value = self:GetEnemyNameplates()
	self:DisplayEnemyNameplates(not value)
	self:DisplayEnemyNameplates(value)
end

-- Provide these functions mainly for Visibiltiy module. ReportStatusChanges can hook them so that the log doesn't fill up
function Aloft:RedisplayFriendlyNameplates()
	self:ScheduleTimer(function () Aloft:DoDisplayFriendlyNameplates() end, 0.25)
end

function Aloft:DoDisplayFriendlyNameplates()
	local value = self:GetFriendNameplates()
	self:DisplayFriendNameplates(not value)
	self:DisplayFriendNameplates(value)
end

-----------------------------------------------------------------------------

function Aloft:IsDataAvailable(name)
	local dataAvailableMethod = Aloft.DataAvailableMethods[name]
	if dataAvailableMethod then
		-- ChatFrame7:AddMessage("Aloft:IsDataAvailable(): " .. name .. "/" .. tostring(dataAvailableMethod()))
		return dataAvailableMethod()
	end
	return true
end

function Aloft:IsDataRequired(name)
	if name then return dataRequiredList[name] end
	return nil
end

-----------------------------------------------------------------------------
--- module prototypes
-----------------------------------------------------------------------------

function Aloft:PrepareText(textFrame, data)
	-- ChatFrame7:AddMessage("Aloft:PrepareText(): enter")

	-- ChatFrame7:AddMessage("Aloft:PrepareText(): font " .. tostring(data.font) .. "/" .. tostring(data.fontSize) .. "/" .. tostring(data.outline) --[[.. "/" .. tostring(SML:Fetch("font", data.font))]])
	-- if not data.font or not data.fontSize or not data.outline then
		-- ChatFrame7:AddMessage("Aloft:PrepareText(): nil " .. debugstack())
	-- end
	textFrame:SetFont(SML:Fetch("font", data.font), data.fontSize, data.outline)
	if data.shadow then
		textFrame:SetShadowOffset(1, -1)
	else
		textFrame:SetShadowOffset(0, 0)
	end
	if data.alignment then
		textFrame:SetJustifyH(data.alignment)
	end
	if data.color then
		textFrame:SetTextColor(unpack(data.color))
	end

	-- ChatFrame7:AddMessage("Aloft:PrepareText(): exit")
end

function Aloft:PlaceFrame(frame, relativeFrame, data, xoffset, yoffset)
	if data.enable then
		frame:ClearAllPoints()
		if relativeFrame then
			frame:SetPoint(data.point, relativeFrame, data.relativeToPoint, data.offsetX + (xoffset or 0), data.offsetY + (yoffset or 0))
		end

		if data.size then
			frame:SetWidth(data.size)
			frame:SetHeight(data.size)
		else
			if data.width then
				frame:SetWidth(data.width)
			end
			if data.height then
				frame:SetHeight(data.height)
			end
		end
		frame:SetAlpha(data.alpha or 1.0)
	else
		frame:SetAlpha(0)
	end
end

function Aloft:AdjustFrame(inset, relativeToPoint)
	return inset * horzAdjust[relativeToPoint], inset * vertAdjust[relativeToPoint]
end

function Aloft:RequiresData()
	-- ChatFrame7:AddMessage("Aloft:modulePrototype:RequiresData(): enter")
	-- eg. return "class", "isPetName", "isGuildMember"
	-- ChatFrame7:AddMessage("Aloft:modulePrototype:RequiresData(): exit")
end

function Aloft:ProvidesData()
end

function Aloft:EnableDataSource()
end

function Aloft:IsPurelyData()
	return self:ProvidesData() ~= nil
end

function Aloft:IsOneOfDataListAvailable(...)
	for i=1,select('#', ...) do
		if Aloft:IsDataAvailable(select(i, ...)) then
			return true
		end
	end
	return false
end

function Aloft:IsModuleDataAvailable()
	return self:IsOneOfDataListAvailable(self:ProvidesData())
end

function Aloft:RemoveAloftData(name)
	for aloftData in Aloft:IterateNameplates() do
		aloftData[name] = nil
	end
end

function Aloft:RemoveProvidedData(...)
	for i=1,select('#', ...) do
		self:RemoveAloftData(select(i, ...))
	end
end

function Aloft:DisableDataSource(force)
	-- ChatFrame7:AddMessage("Aloft:DisableDataSource(): enter " .. tostring(self.name))

	local dataName = self:ProvidesData()
	if dataName then
		-- ChatFrame7:AddMessage("Aloft:DisableDataSource(): DISABLE " .. tostring(self.name))

		self:UnregisterAllEvents()
		self:UnregisterAllMessages()
		self:CancelAllTimers()

 		if self.UnhookAll then
			self:UnhookAll()
		end
		self:RemoveProvidedData(self:ProvidesData())

		-- ChatFrame7:AddMessage("Aloft:DisableDataSource(): disabled " .. tostring(self.name))
	end
end

function Aloft:UpdateData(aloftData)
	DEFAULT_CHAT_FRAME:AddMessage("Internal error: " .. tostring(self.name) .. " DataSource's UpdateData not overriden.")
	ChatFrame7:AddMessage("Internal error: " .. tostring(self.name) .. " DataSource's UpdateData not overriden.")
end

-- TODO Ace3: need to update this
function Aloft:CancelEvent(eventName)
	if self:IsEventRegistered(eventName) then
		self:UnregisterEvent(eventName)
	end
end

function Aloft:IsArrayEqual(a, b)
	if #a ~= #b then return false end
	for i=1,#a do
		if a[i] ~= b[i] then return false end
	end
	return true
end

-----------------------------------------------------------------------------

-- local cache of the player's GUID
function Aloft:GetPlayerGUId()
	-- OK, this is weird... apparently the unitid "player" is apparently not always valid and/or does not always have a GUID
	-- Initializing it once, up front globally on touching the LUA, it can be nil, and bad things happen; so, this initialization must be guarded
	if not playerGUId then playerGUId = UnitGUID("player") end
	return playerGUId
end

function Aloft:GetClassByColor(sbr, sbg, sbb)
	-- construct a coarser approximation of our color; blizzard's floating-point numbers are not necessarily consistent
	local r, g, b = floor(sbr * 256), floor(sbg * 256), floor(sbb * 256)

	-- ChatFrame7:AddMessage("Aloft:GetClassByColor(): " .. ("|cff%02x%02x%02x%s|r"):format(r, g, b, tostring(r) .. "/" .. tostring(g)  .. "/" .. tostring(b)))

	-- extract the class from the raid color class map; jump through hoops in case the color is not perfect/exact
	-- NOTE: this checking could be expanded to include +2/-2 and beyond, just in case
	local redColorClassMap = raidColorClassMap[r] or raidColorClassMap[r + 1] or raidColorClassMap[r - 1]
	if (redColorClassMap) then
		local grnColorClassMap = redColorClassMap[g] or redColorClassMap[g + 1] or redColorClassMap[g - 1]
		if (grnColorClassMap) then
			local class = grnColorClassMap[b] or grnColorClassMap[b + 1] or grnColorClassMap[b - 1]
			if (class) then
				-- ChatFrame7:AddMessage("Aloft:GetClassByColor(): " .. tostring(class))
				return class
			end
		end
	end
	return nil
end

-----------------------------------------------------------------------------

-- separates the name (and realm?) components of the raw unit name from the combat log
function Aloft:ParseUnitName(rawUnitName, wantRealm)
	if rawUnitName then
		local loc = rawUnitName:find("-")
		if loc and loc > 1 then
			return rawUnitName:sub(1, loc - 1), (wantRealm and rawUnitName:sub(loc + 1)) or nil
		end
	end
	return rawUnitName, nil
end

-----------------------------------------------------------------------------

function Aloft:AcquireLayoutFrame(aloftData)
	local nameplateFrame = aloftData.nameplateFrame

	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = next(self.layoutFramePool)
		if layoutFrame then
			self.layoutFramePool[layoutFrame] = nil
		else
			-- ChatFrame7:AddMessage("Aloft:AcquireLayoutFrame(): " .. tostring(aloftData.name) .. "/" .. tostring(nameplateFrame:GetFrameLevel()))
			layoutFrame = CreateFrame("StatusBar", nil, nameplateFrame) -- NOTE: needs a parent for frame layering/Frame:SetFrameLevel() to work correctly
		end

		aloftData.layoutFrame = layoutFrame
		layoutFrame.aloftData = aloftData

		layoutFrame:SetParent(nameplateFrame) -- NOTE: needs a parent for frame layering/Frame:SetFrameLevel() to work correctly
	end

	-- TODO: put this in a setup method
	layoutFrame:SetFrameLevel(nameplateFrame:GetFrameLevel() + 1)
	layoutFrame:SetStatusBarColor(0, 0, 0, 0)
	layoutFrame:Show()
	-- ChatFrame7:AddMessage("Aloft:AcquireLayoutFrame(): show layout frame " .. tostring(aloftData.name) .. "/" .. tostring(aloftData) .. "/" .. tostring(aloftData.layoutFrame))

	return layoutFrame
end

function Aloft:ReleaseReferenceFrame(aloftData)
	-- ChatFrame7:AddMessage("Aloft:ReleaseReferenceFrame(): release " .. aloftData.name)
	self:CleanupReferenceFrame(aloftData)
	self:RePoolReferenceFrame(aloftData)
end

function Aloft:CleanupReferenceFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	if layoutFrame then
	end
end

function Aloft:RePoolReferenceFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	if layoutFrame then
		layoutFrame:Hide()

		layoutFrame.aloftData = nil
		aloftData.layoutFrame = nil
		-- ChatFrame7:AddMessage("Aloft:RePoolReferenceFrame(): " .. tostring(aloftData) .. "/" .. tostring(aloftData.name))

		layoutFrame:SetParent(nil) -- probably a NOOP for reference frames
		self.layoutFramePool[layoutFrame] = true
	end
end

-----------------------------------------------------------------------------

-- changed for WoW 4.1: subordinate elements now attached directly to the cast bar
function Aloft:GetNameplateRegions(aloftData)
	-- ChatFrame7:AddMessage("Aloft:GetNameplateRegions(): VERSION " .. tostring(version) .. "/" .. tostring(build) .. "/" .. tostring(date) .. "/" .. tostring(tocversion) .. " VERSION")

	local frame = aloftData.nameplateFrame

	local  nativeGlowRegion, overlayRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion, extra09, extra10, extra11, extra12, extra13, extra14, extra15, extra16 = frame:GetRegions()

	return nativeGlowRegion, overlayRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion, extra09, extra10, extra11, extra12, extra13, extra14, extra15, extra16
end

-- changed for WoW 4.1: subordinate elements now attached directly to the cast bar
-- TODO: go through interaction on these texture regions, throughout the rest of the code, and make sure the interaction is clean
function Aloft:GetCastBarRegions(aloftData)
	-- ChatFrame7:AddMessage("Aloft:GetCastBarRegions(): VERSION " .. tostring(version) .. "/" .. tostring(build) .. "/" .. tostring(date) .. "/" .. tostring(tocversion) .. " VERSION")

	local castBar = aloftData.castBar

	local castBarRegion, castBarOverlayRegion, castBarShieldRegion, spellIconRegion, extra05, extra06, extra07, extra08 = castBar:GetRegions()

	return castBarRegion, castBarOverlayRegion, castBarShieldRegion, spellIconRegion, extra05, extra06, extra07, extra08
end

-----------------------------------------------------------------------------

--[[
function Aloft:DumpNameplateHeirarchy(aloftData)
	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): ----------- FRAME -----------")
	local frame = aloftData.nameplateFrame

	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): ----- frame #regions " .. tostring(frame:GetNumRegions()))
	local nativeGlowRegion, overlayRegion, castBarOverlayRegion, spellIconRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion, extra11, extra12, extra13, extra14, extra15, extra16, extra17, extra18, extra19 = self:GetNameplateRegions(aloftData)

	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): nativeGlowRegion " .. self:GetTextureRegionDiagnostic(nativeGlowRegion))
	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): overlayRegion " .. self:GetTextureRegionDiagnostic(overlayRegion))
	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): castBarOverlayRegion " .. self:GetTextureRegionDiagnostic(castBarOverlayRegion))
	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): spellIconRegion " .. self:GetTextureRegionDiagnostic(spellIconRegion))
	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): highlightRegion " .. self:GetTextureRegionDiagnostic(highlightRegion))
	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): nameTextRegion " .. self:GetFontStringRegionDiagnostic(nameTextRegion))
	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): levelTextRegion " .. self:GetFontStringRegionDiagnostic(levelTextRegion))
	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): bossIconRegion " .. self:GetTextureRegionDiagnostic(bossIconRegion))
	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): raidIconRegion " .. self:GetTextureRegionDiagnostic(raidIconRegion))
	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): stateIconRegion " .. self:GetTextureRegionDiagnostic(stateIconRegion))
	if (extra11) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): extra11 " .. self:GetTextureRegionDiagnostic(extra11)) end
	if (extra12) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): extra12 " .. tostring(extra12:GetName()) .. "/" .. tostring(extra12:IsVisible()) .. "/" .. tostring(extra12:GetObjectType())) end
	if (extra13) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): extra13 " .. tostring(extra13:GetName()) .. "/" .. tostring(extra13:IsVisible()) .. "/" .. tostring(extra13:GetObjectType())) end
	if (extra14) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): extra14 " .. tostring(extra14:GetName()) .. "/" .. tostring(extra14:IsVisible()) .. "/" .. tostring(extra14:GetObjectType())) end
	if (extra15) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): extra15 " .. tostring(extra15:GetName()) .. "/" .. tostring(extra15:IsVisible()) .. "/" .. tostring(extra15:GetObjectType())) end
	if (extra16) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): extra16 " .. tostring(extra16:GetName()) .. "/" .. tostring(extra16:IsVisible()) .. "/" .. tostring(extra16:GetObjectType())) end
	if (extra17) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): extra17 " .. tostring(extra17:GetName()) .. "/" .. tostring(extra17:IsVisible()) .. "/" .. tostring(extra17:GetObjectType())) end
	if (extra18) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): extra18 " .. tostring(extra18:GetName()) .. "/" .. tostring(extra18:IsVisible()) .. "/" .. tostring(extra18:GetObjectType())) end
	if (extra19) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): extra19 " .. tostring(extra19:GetName()) .. "/" .. tostring(extra19:IsVisible()) .. "/" .. tostring(extra19:GetObjectType())) end

	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): ----- frame #children " .. tostring(frame:GetNumChildren()))
	local healthBar, castBar, barA, barB, barC, barD = frame:GetChildren()

	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): --- healthBar frame " .. tostring(healthBar:GetName()) .. "/" .. tostring(healthBar:GetObjectType()))
	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): - healthBar frame #regions " .. tostring(healthBar:GetNumRegions()))
	local healthBar01, healthBar02, healthBar03, healthBar04, healthBar05, healthBar06, healthBar07, healthBar08, healthBar09, healthBar10 = healthBar:GetRegions()
	if (healthBar01) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): healthBar01 " .. tostring(healthBar01:GetName()) .. "/" .. tostring(healthBar01:GetObjectType()) .. "/" .. tostring(healthBar01:GetTexture())) end
	if (healthBar02) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): healthBar02 " .. tostring(healthBar02:GetName()) .. "/" .. tostring(healthBar02:GetObjectType()) .. "/" .. tostring(healthBar02:GetTexture())) end
	if (healthBar03) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): healthBar03 " .. tostring(healthBar03:GetName()) .. "/" .. tostring(healthBar03:GetObjectType()) .. "/" .. tostring(healthBar03:GetTexture())) end
	if (healthBar04) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): healthBar04 " .. tostring(healthBar04:GetName()) .. "/" .. tostring(healthBar04:GetObjectType()) .. "/" .. tostring(healthBar04:GetTexture())) end
	if (healthBar05) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): healthBar05 " .. tostring(healthBar05:GetName()) .. "/" .. tostring(healthBar05:GetObjectType()) .. "/" .. tostring(healthBar05:GetTexture())) end
	if (healthBar06) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): healthBar06 " .. tostring(healthBar06:GetName()) .. "/" .. tostring(healthBar06:GetObjectType()) .. "/" .. tostring(healthBar06:GetTexture())) end
	if (healthBar07) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): healthBar07 " .. tostring(healthBar07:GetName()) .. "/" .. tostring(healthBar07:GetObjectType()) .. "/" .. tostring(healthBar07:GetTexture())) end
	if (healthBar08) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): healthBar08 " .. tostring(healthBar08:GetName()) .. "/" .. tostring(healthBar08:GetObjectType()) .. "/" .. tostring(healthBar08:GetTexture())) end
	if (healthBar09) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): healthBar09 " .. tostring(healthBar09:GetName()) .. "/" .. tostring(healthBar09:GetObjectType()) .. "/" .. tostring(healthBar09:GetTexture())) end
	if (healthBar10) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): healthBar10 " .. tostring(healthBar10:GetName()) .. "/" .. tostring(healthBar10:GetObjectType()) .. "/" .. tostring(healthBar10:GetTexture())) end

	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): --- castBar frame " .. tostring(castBar:GetName()) .. "/" .. tostring(castBar:GetObjectType()))
	ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): - castBar frame #regions " .. tostring(castBar:GetNumRegions()))
	local castBar01, castBar02, castBar03, castBar04, castBar05 = castBar:GetRegions()
	if (castBar01) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): castBar01 " .. tostring(castBar01:GetName()) .. "/" .. tostring(castBar01:GetObjectType()) .. "/" .. tostring(castBar01:GetTexture())) end
	if (castBar02) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): castBar02 " .. tostring(castBar02:GetName()) .. "/" .. tostring(castBar02:GetObjectType()) .. "/" .. tostring(castBar02:GetTexture())) end
	if (castBar03) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): castBar03 " .. tostring(castBar03:GetName()) .. "/" .. tostring(castBar03:GetObjectType())) end
	if (castBar04) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): castBar04 " .. tostring(castBar04:GetName()) .. "/" .. tostring(castBar04:GetObjectType())) end
	if (castBar05) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): castBar05 " .. tostring(castBar05:GetName()) .. "/" .. tostring(castBar05:GetObjectType())) end

	if (barA) then
		ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): --- barA frame " .. tostring(barA:GetName()) .. "/" .. tostring(barA:GetObjectType()))
		ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): - barA frame #regions " .. tostring(barA:GetNumRegions()))
		local barA01, barA02, barA03, barA04, barA05, barA06, barA07, barA08, barA09, barA10 = barA:GetRegions()
		if (barA01) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barA01 " .. tostring(barA01:GetName()) .. "/" .. tostring(barA01:GetObjectType()) .. "/" .. tostring(barA01:GetTexture())) end
		if (barA02) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barA02 " .. tostring(barA02:GetName()) .. "/" .. tostring(barA02:GetObjectType()) .. "/" .. tostring(barA02:GetText())) end
		if (barA03) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barA03 " .. tostring(barA03:GetName()) .. "/" .. tostring(barA03:GetObjectType()) .. "/" .. tostring(barA03:GetText())) end
		if (barA04) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barA04 " .. tostring(barA04:GetName()) .. "/" .. tostring(barA04:GetObjectType()) .. "/" .. tostring(barA04:GetText())) end
		if (barA05) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barA05 " .. tostring(barA05:GetName()) .. "/" .. tostring(barA05:GetObjectType()) .. "/" .. tostring(barA05:GetText())) end
		if (barA06) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barA06 " .. tostring(barA06:GetName()) .. "/" .. tostring(barA06:GetObjectType()) .. "/" .. tostring(barA06:GetText())) end
		if (barA07) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barA07 " .. tostring(barA07:GetName()) .. "/" .. tostring(barA07:GetObjectType()) .. "/" .. tostring(barA07:GetTexture())) end
		if (barA08) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barA08 " .. tostring(barA08:GetName()) .. "/" .. tostring(barA08:GetObjectType()) .. "/" .. tostring(barA08:GetText())) end
		if (barA09) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barA09 " .. tostring(barA09:GetName()) .. "/" .. tostring(barA09:GetObjectType()) .. "/" .. tostring(barA09:GetTexture())) end
		if (barA10) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barA10 " .. tostring(barA10:GetName()) .. "/" .. tostring(barA10:GetObjectType()) .. "/" .. tostring(barA10:GetTexture())) end
	end

	if (barB) then
		ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): --- barB frame " .. tostring(barB:GetName()) .. "/" .. tostring(barB:GetObjectType()))
		ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): - barB frame #regions " .. tostring(barB:GetNumRegions()))
		local barB01, barB02, barB03, barB04, barB05 = barB:GetRegions()
		if (barB01) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barB01 " .. tostring(barB01:GetName()) .. "/" .. tostring(barB01:GetObjectType()) .. "/" .. tostring(barB01:GetTexture())) end
		if (barB02) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barB02 " .. tostring(barB02:GetName()) .. "/" .. tostring(barB02:GetObjectType()) .. "/" .. tostring(barB02:GetTexture())) end
		if (barB03) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barB03 " .. tostring(barB03:GetName()) .. "/" .. tostring(barB03:GetObjectType())) end
		if (barB04) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barB04 " .. tostring(barB04:GetName()) .. "/" .. tostring(barB04:GetObjectType())) end
		if (barB05) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barB05 " .. tostring(barB05:GetName()) .. "/" .. tostring(barB05:GetObjectType())) end
	end

	if (barC) then
		ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): --- barC frame " .. tostring(barC:GetName()) .. "/" .. tostring(barC:GetObjectType()))
		ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): - barC frame #regions " .. tostring(barC:GetNumRegions()))
		local barC01, barC02, barC03, barC04, barC05 = barC:GetRegions()
		if (barC01) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barC01 " .. tostring(barC01:GetName()) .. "/" .. tostring(barC01:GetObjectType()) .. "/" .. tostring(barC01:GetTexture())) end
		if (barC02) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barC02 " .. tostring(barC02:GetName()) .. "/" .. tostring(barC02:GetObjectType()) .. "/" .. tostring(barC02:GetTexture())) end
		if (barC03) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barC03 " .. tostring(barC03:GetName()) .. "/" .. tostring(barC03:GetObjectType())) end
		if (barC04) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barC04 " .. tostring(barC04:GetName()) .. "/" .. tostring(barC04:GetObjectType())) end
		if (barC05) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barC05 " .. tostring(barC05:GetName()) .. "/" .. tostring(barC05:GetObjectType())) end
	end

	if (barD) then
		ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): --- barD frame " .. tostring(barD:GetName()) .. "/" .. tostring(barD:GetObjectType()))
		ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): - barD frame #regions " .. tostring(barD:GetNumRegions()))
		local barD01, barD02, barD03, barD04, barD05 = barD:GetRegions()
		if (barD01) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barD01 " .. tostring(barD01:GetName()) .. "/" .. tostring(barD01:GetObjectType()) .. "/" .. tostring(barD01:GetTexture())) end
		if (barD02) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barD02 " .. tostring(barD02:GetName()) .. "/" .. tostring(barD02:GetObjectType()) .. "/" .. tostring(barD02:GetTexture())) end
		if (barD03) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barD03 " .. tostring(barD03:GetName()) .. "/" .. tostring(barD03:GetObjectType())) end
		if (barD04) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barD04 " .. tostring(barD04:GetName()) .. "/" .. tostring(barD04:GetObjectType())) end
		if (barD05) then ChatFrame7:AddMessage("Aloft:DumpNameplateHeirarchy(): barD05 " .. tostring(barD05:GetName()) .. "/" .. tostring(barD05:GetObjectType())) end
	end
end

function Aloft:GetRegionDiagnostic(region)
	return tostring(region:GetName()) .. "/" .. tostring(region:IsVisible()) .. "/" .. tostring(region:GetObjectType())
end

function Aloft:GetTextureRegionDiagnostic(region)
	local r, g, b, a = region:GetVertexColor()
	return tostring(region:GetName()) .. "/" .. tostring(region:IsVisible()) .. "/" .. tostring(region:GetObjectType()) .. "/" .. tostring(region:GetTexture()) .. "/" .. self:GetColorDiagnostic(r, g, b, a)
end

function Aloft:GetFontStringRegionDiagnostic(region)
	return  tostring(region:GetName()) .. "/" .. tostring(region:IsVisible()) .. "/" .. tostring(region:GetObjectType()) .. "/" .. tostring(region:GetText())
end

function Aloft:GetColorDiagnostic(r, g, b, a)
	return tostring(r) .. "-" .. tostring(g) .. "-" .. tostring(b) .. "-" .. tostring(a)
				.. "/" .. floor(255*r) .. "." .. floor(255*g) .. "." .. floor(255*b) .. "." .. floor(255*a)
				.. "/" .. ("|c%02x%02x%02x%02xcolor|r"):format(floor(255*a), floor(255*r), floor(255*g), floor(255*b))
end
]]

--[[
function Aloft:DumpObjectHeirarchy(object)
	local regionType
	local regionData

	if object.GetObjectType then
		local objectType = object:GetObjectType()
		if objectType == "Frame" then
			local numObjectRegions = object:GetNumRegions()
			local numObjectChildren = object:GetNumChildren()
			ChatFrame7:AddMessage("Aloft:DumpObjectHeirarchy(): ----- FRAME " .. tostring(object:GetName()) .. " #regions " .. tostring(numObjectRegions) .. " #children " .. tostring(numObjectChildren) .. " FRAME -----")

			self:DumpObjectRegions(object, "")
			self:DumpObjectChildren(object, "")
		else
			ChatFrame7:AddMessage("Aloft:DumpObjectHeirarchy(): ----- UNKNOWN " .. tostring(object:GetName()) .. "/" .. tostring(objectType) .. " UNKNOWN -----")
		end
	end
end

function Aloft:DumpObjectRegions(object, leader)
	local numObjectRegions = object:GetNumRegions()
	for i = 1, numObjectRegions do
		local region = select(i, object:GetRegions())
		regionType = region:GetObjectType()
		if regionType == "Texture" then
			regionData = region:GetTexture()
		elseif regionType == "FontString" then
			regionData = region:GetText()
		end
		ChatFrame7:AddMessage("Aloft:DumpObjectRegions(): " .. leader .. " region " .. tostring(region:GetName()) .. "/" .. tostring(regionType) .. "/" .. tostring(regionData))
	end
end

function Aloft:DumpObjectChildren(object, leader)
	local numObjectChildren = object:GetNumChildren()
	for i = 1, numObjectChildren do
		local child = select(i, object:GetChildren())
		ChatFrame7:AddMessage("Aloft:DumpObjectChildren(): " .. leader .. " child " .. tostring(child:GetName()))
		self:DumpObjectRegions(child, leader .. "	")
	end
end
]]

-----------------------------------------------------------------------------

--[[

-- horizontal reflection of state icon region

---

normal:

ULx, ULy, LLx, LLy, URx, URy, LRx, LRy

0.000000/0.000000 - 0.578125/0.000000
        |                   |
0.000000/0.843750 - 0.578125/0.843750

---

horizontal reflect:

URx, URy, LRx, LRy, ULx, ULy, LLx, LLy

0.578125/0.000000 - 0.000000/0.000000
       |                  |
0.578125/0.843750 - 0.000000/0.843750

---

]]
