---------------------------------------------------------------------------

--[[
PreLoadDebugHistory = { }
table.insert(PreLoadDebugHistory, "ALOFT BEGIN")
]]

-----------------------------------------------------------------------------

local version, build, date, tocversion = GetBuildInfo()

-----------------------------------------------------------------------------

-- global on purpose
Aloft = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "AceModuleCore-2.0", "AceHook-2.1")

local L = AceLibrary("AceLocale-2.2"):new("AloftOptions")
local SML = AceLibrary("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft:RegisterDB("AloftDB")
Aloft:RegisterDefaults("profile", {
	startMessageEnable	= true,
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
})

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

Aloft.layoutFramePool = { }

local WorldFrame = WorldFrame

local GetCVarBool = GetCVarBool
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

	if aloftData.name == L["Unknown"] then
		aloftData.type = "unknown"
		-- ChatFrame7:AddMessage("Aloft:UpdateAloftTypeData(): " .. tostring(aloftData.name) .. "/unknown")
	elseif r == 255 and g == 0 and b == 0 then -- red
		-- ChatFrame7:AddMessage("Aloft:UpdateAloftTypeData(): " .. tostring(aloftData.name) .. "/hostile")
		aloftData.type = "hostile"
	elseif r == 0 and g == 0 and b == 255 then -- blue
		aloftData.type = "friendlyPlayer"
		aloftData.isPlayer = true
	elseif r == 0 and g == 255 and b == 0 then -- green
		aloftData.type = "friendlyNPC"
	elseif r == 255 and g == 255 and b == 0 then -- yellow
		-- ChatFrame7:AddMessage("Aloft:UpdateAloftTypeData(): " .. tostring(aloftData.name) .. "/neutral")
		aloftData.type = "neutral"
	elseif Aloft.showClassColorInVKey then
		-- assume hostile player, due to the new Blizzard "Combat>Class Colors in Nameplates" option
		aloftData.type = "hostilePlayer"
		aloftData.isPlayer = true
		-- ChatFrame7:AddMessage("Aloft:UpdateAloftTypeData(): " .. tostring(aloftData.name) .. "/class hostile")
	else
		aloftData.type = "unknown"
		-- ChatFrame7:AddMessage("Aloft:UpdateAloftTypeData(): " .. tostring(aloftData.name) .. "/unknown")
	end
end

function Aloft:ProcessHealthBarColorChange(aloftData, healthBar)
	-- ChatFrame7:AddMessage("Aloft:ProcessHealthBarColorChange(): " .. tostring(aloftData.name))
	UpdateAloftTypeData(aloftData, healthBar)
	self:TriggerEvent("Aloft:OnHealthBarColorChanged", aloftData)
end

function Aloft:OnPlayerTargetChanged()
	noTargetNameplate = false

	-- self:ScheduleEvent("Aloft:DoPlayerTargetChanged", self.DoPlayerTargetChanged, 0.0, self, aloftData) -- next frame
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
		self:TriggerEvent("Aloft:LoadOptions")
		collectgarbage('collect')
	end
end

-----------------------------------------------------------------------------

function Aloft:OnInitialize()
	Aloft:RegisterChatCommand("/aloft", Aloft.Options)

	if self.db.profile.startMessageEnable then
		DEFAULT_CHAT_FRAME:AddMessage("Aloft version " .. Aloft.version)
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
end

function Aloft:OnEnable()
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

	for _, module in self:IterateModules() do
		self:ToggleModuleActive(module, true)
	end

	self:ScheduleRepeatingEvent("AloftUpdate", self.Update, 0.2, self) -- 5 times a second
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnPlayerTargetChanged")
	self:RegisterEvent("CVAR_UPDATE", "OnCVarUpdate")

	self.healthBarDB = Aloft:AcquireDBNamespace("healthBar")

	self:DetermineDataSources()

	-- Reinstate hooks and update data - this is for when Aloft is disbaled, and later reenabled
	for aloftData in self:IterateNameplates() do
		self:HookNameplate(aloftData)
		if aloftData:IsShown() then
			visibleNameplateList[aloftData] = true
			self:OnNameplateShow(aloftData)
		end
	end

	if not self:GetNameplateCVar("ShowClassColorInNameplate") then
		DEFAULT_CHAT_FRAME:AddMessage(Aloft.version .. ": Enabling Blizzard standard 'Combat>Class Colors in Nameplates' interface option")
		self:SetNameplateCVar("ShowClassColorInNameplate", true)
	end
	self.showClassColorInVKey = GetCVarBool("ShowClassColorInNameplate")

	--[[
	table.insert(PreLoadDebugHistory, "ALOFT END")

	for _, value in pairs(PreLoadDebugHistory) do
		ChatFrame7:AddMessage(value)
	end
	--]]

	-- for _, value in pairs(Aloft.IsTotemTagNames) do
		-- ChatFrame7:AddMessage("Aloft:OnEnable(): " .. tostring(value) .. "/" .. tostring(Aloft:IsDSTValue(Aloft.IsTotemTagDST, value)))
	-- end

	-- Aloft:DelDST(Aloft.IsTotemTagDST, "Searing Totem V")
	-- Aloft:DelDST(Aloft.IsTotemTagDST, "Searing Totem VIII")
	-- Aloft:DelDST(Aloft.IsTotemTagDST, "Searing Totem X")
	-- Aloft:DumpDST(Aloft.IsTotemTagDST, "")

	-- ChatFrame7:AddMessage("Aloft:OnEnable(): " .. tostring("Searing Totem") .. "/" .. tostring(Aloft:IsDSTValue(Aloft.IsTotemTagDST, "Searing Totem")))
	-- ChatFrame7:AddMessage("Aloft:OnEnable(): " .. tostring("Searing Totem V") .. "/" .. tostring(Aloft:IsDSTValue(Aloft.IsTotemTagDST, "Searing Totem V")))
	-- ChatFrame7:AddMessage("Aloft:OnEnable(): " .. tostring("Searing Totem VI") .. "/" .. tostring(Aloft:IsDSTValue(Aloft.IsTotemTagDST, "Searing Totem VI")))
	-- ChatFrame7:AddMessage("Aloft:OnEnable(): " .. tostring("Searing Totem VII") .. "/" .. tostring(Aloft:IsDSTValue(Aloft.IsTotemTagDST, "Searing Totem VII")))
	-- ChatFrame7:AddMessage("Aloft:OnEnable(): " .. tostring("Searing Totem VIII") .. "/" .. tostring(Aloft:IsDSTValue(Aloft.IsTotemTagDST, "Searing Totem VIII")))
	-- ChatFrame7:AddMessage("Aloft:OnEnable(): " .. tostring("Searing Totem IX") .. "/" .. tostring(Aloft:IsDSTValue(Aloft.IsTotemTagDST, "Searing Totem IX")))
	-- ChatFrame7:AddMessage("Aloft:OnEnable(): " .. tostring("Searing Totem X") .. "/" .. tostring(Aloft:IsDSTValue(Aloft.IsTotemTagDST, "Searing Totem X")))
end

function Aloft:OnDisable()
	self:CancelScheduledEvent("AloftUpdate")

	for aloftData in self:IterateVisibleNameplates() do
		self:TriggerEvent("Aloft:OnNameplateHide", aloftData)
	end

	for _, module in self:IterateModules() do
		self:ToggleModuleActive(module, false)
		module:DisableDataSource()
	end

	-- replace the textures we zapped during normal operation
	for aloftData in self:IterateNameplates() do
		local nativeGlowRegion = aloftData.nativeGlowRegion
		if nativeGlowRegion and originalNativeGlowRegion then
			nativeGlowRegion:SetTexture(originalNativeGlowRegion)
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
		self:TriggerEvent("Aloft:OnNameplateHide", aloftData)
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
		self:TriggerEvent("Aloft:OnNameplateShow", aloftData)
	end
end

-----------------------------------------------------------------------------

local function IsNameplateFrame(frame)
	if frame:GetName() then
		-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame(): frame name " .. frame:GetName())
		return false
	end

	local region1, region2 = frame:GetRegions()
	overlayRegion = region2
	if not overlayRegion then
		-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame(): no overlayRegion")
		return false
	end

	if overlayRegion:GetObjectType() ~= "Texture" then
		-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame(): overlayRegion object type " .. tostring(overlayRegionObjectType))
		return false
	end

	if overlayRegion:GetTexture() ~= "Interface\\Tooltips\\Nameplate-Border" then
		-- ChatFrame7:AddMessage("Aloft:IsNameplateFrame(): overlayRegion texture " .. tostring(overlayRegionTexture))
		return false
	end

	return true
end

function Aloft:ProcessChildFrames(...)
	for i = 1, select('#', ...) do
		local frame = select(i, ...)
		if not frame.aloftData then
			-- self:DumpObjectHeirarchy(frame)
			if IsNameplateFrame(frame) then
				self:SetupNameplate(frame)
			end
		end
	end
end

local oldShowClassColorInVKey
function Aloft:Update()
	local newNumberOfWorldChildren = WorldFrame:GetNumChildren()
	if newNumberOfWorldChildren ~= numberOfWorldChildren then
		numberOfWorldChildren = newNumberOfWorldChildren
		self:ProcessChildFrames(WorldFrame:GetChildren())
	end

	for aloftData in pairs(visibleNameplateList) do
		local healthBar = aloftData.healthBar
		local r, g, b, a = healthBar:GetStatusBarColor()

		-- An awful awful update routine to stop the game overwriting our colors sporadically; in a few cases blizzard uses the same color as Aloft does, so we need to check the CVar as well
		if ((r ~= aloftData.healthBarR or g ~= aloftData.healthBarG or b ~= aloftData.healthBarB or a ~= aloftData.healthBarA) and (self.showClassColorInVKey == oldShowClassColorInVKey)) then
			-- if the CVar has not changed; we can do this immediately
			self:ProcessHealthBarColorChange(aloftData, healthBar)
		elseif (not (self.showClassColorInVKey == oldShowClassColorInVKey)) then
			-- the CVar has changed, and therefore all visible nameplates may also have changed;
			-- allow until the next frame for the display to catch up with the CVar before attempting to collect color data, or we could have errors
			local eventName = "Aloft:ProcessHealthBarColorChange:" .. tostring(math.random(1,1000000000))
			self:ScheduleEvent(eventName, self.ProcessHealthBarColorChange, 0.0, self, aloftData, healthBar) -- next frame
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

function Aloft:UpdateDataNameToModuleMap(module, ...)
	if not ... then return end
	for i = 1,select('#', ...) do
		-- ChatFrame7:AddMessage("Aloft:UpdateDataNameToModuleMap(): Added data module: " .. tostring(select(i, ...)) .. " (" .. tostring(module) .. ")")
		dataNameToModuleMap[select(i, ...)] = module
	end
	if not module:IsDataAvailable() then
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

function Aloft:DetermineDataSources()
	-- 1. Iterate all modules, flag them to be disabled and gather provided data
	for _,module in self:IterateModules() do
		--- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): temporarily disabling " .. tostring(module))
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
		for module, moduleList in pairs(moduleToModuleListMap) do
			-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): considering module " .. tostring(module))
			for requiredModule in pairs(moduleList) do
				-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): setting required module for " .. tostring(requiredModule) .. " to true")
				requiredModules[requiredModule] = true
			end
		end
		local moduleRemoved = false
		for module, _ in pairs(moduleToModuleListMap) do
			if module:IsPurelyData() and not requiredModules[module] then
				-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): not required or purely data "..tostring(module))
				moduleToModuleListMap[module] = nil
				self:RemoveRequiredModuleFromModuleToModuleListMap(module)
				moduleRemoved = true
			end
		end
		if not moduleRemoved then break end
		for k in pairs(requiredModules) do
			-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): setting required for " .. tostring(k) .. " to nil")
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
					-- ChatFrame7:AddMessage("Aloft:DetermineDataSources(): enabling module " .. tostring(requiredModule) )
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
		self:Print(L["Internal error: Dependency list not resolved - cyclic dependency?"])
		for k in pairs(moduleToModuleListMap) do
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

function Aloft:GetTargetNameplate(unitName)
	-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): enter")

	if noTargetNameplate then
		-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): noTargetNameplate")
		return
	end
	-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): seek nameplate")

	if not unitName then unitName = UnitName("target") end
	-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): seek " .. (unitName or "<NOTARGET>"))

	local aloftData = self:GetNameplateByAlpha(unitName, 1)
	if (not aloftData) then
		-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): no nameplate")
		noTargetNameplate = true
	else
		-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): found nameplate " .. aloftData.name)
	end

	-- ChatFrame7:AddMessage("Aloft:GetTargetNameplate(): exit")
	return aloftData
end

function Aloft:GetNameplateByAlpha(unitName, nameplateAlpha)
	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAlpha(): enter" --[[.. debugstack()]])

	if not unitName then return end
	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAlpha(): seek " .. unitName)

	-- named nameplate search
	-- local aloftData = nameToNameplateMap[unitName]
	if (nameToNameplateMultiMap[unitName]) then
		for aloftData in pairs(nameToNameplateMultiMap[unitName]) do
			if aloftData and aloftData.nameplateFrame:GetAlpha() == nameplateAlpha then
				-- ChatFrame7:AddMessage("Aloft:GetNameplateByAlpha(): fast " .. tostring(aloftData.name))
				return aloftData
			end
		end
	end

	-- visible nameplate search
	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAlpha(): iterate visible nameplates")
	for aloftData in pairs(visibleNameplateList) do
		if aloftData.name == unitName and aloftData.nameplateFrame:GetAlpha() == nameplateAlpha then
			-- record it for future reference
			nameToNameplateMap[unitName] = aloftData -- most recently seen nameplate with this unit name
			if (not nameToNameplateMultiMap[unitName]) then nameToNameplateMultiMap[unitName] = { } end
			nameToNameplateMultiMap[aloftData.name][aloftData] = true
			-- ChatFrame7:AddMessage("Aloft:GetNameplateByAlpha(): slow " .. tostring(aloftData.name))
			return aloftData
		end
	end

	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAlpha(): exit/nil")
	return nil
end

function Aloft:GetNameplateByAttribute(unitName, class, race, creatureType, classification, isPet, showClassColorInVKey)
	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAttribute(): enter")

	--[[
	ChatFrame7:AddMessage("Aloft:GetNameplateByAttribute(): " .. tostring(unitName) .. "/" .. tostring(class) .. "/" .. tostring(race) .. "/" ..
		tostring(creatureType) .. "/" .. tostring(classification) .. "/" .. tostring(isPet) .. "/" .. tostring(showClassColorInVKey))
	]]

	if not unitName then return end
	-- ChatFrame7:AddMessage("Aloft:GetNameplateByAttribute(): seek " .. unitName)

	-- named nameplate search
	--local aloftData = nameToNameplateMap[unitName]
	if (nameToNameplateMultiMap[unitName]) then
		for aloftData in pairs(nameToNameplateMultiMap[unitName]) do
			if self:ValidateNameplateByAttribute(aloftData, unitName, class, race, creatureType, classification, isPet, showClassColorInVKey) then
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
	local name = UnitName(unitid)
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

		--[[
		ChatFrame7:AddMessage("Aloft:GetUnitNameplate(): " .. tostring(unitid) .. "/" .. tostring(name) .. "/" .. tostring(class) .. "/" .. tostring(race) .. "/" ..
			tostring(creatureType) .. "/" .. tostring(classification) .. "/" .. tostring(isPet) .. "/" .. tostring(showClassColorInVKey))
		]]

		return self:GetNameplateByAttribute(name, class, race, creatureType, classification, isPet, Aloft.showClassColorInVKey)
	end
end

-----------------------------------------------------------------------------

function Aloft:OnHealthBarValueChanged(aloftData, value, maxValue)
	if aloftData.nameplateFrame:IsShown() then
		aloftData.healthBarValue = value
		aloftData.healthBarMaxValue = maxValue
		self:TriggerEvent("Aloft:OnHealthBarValueChanged", aloftData)
	end
end

function Aloft:OnNameplateShow(aloftData)
	-- self:DumpNameplateHeirarchy(aloftData)

	-- configuration of the reference frame is delegated to AloftFrame:SetupFrame(); we just need it to exist, very early in the lifecycle
	self:AcquireLayoutFrame(aloftData) -- most likely redundant, this is driven in Aloft:Setupframe() as well

	-- When a nameplate is first shown, grab some data about it
	self:SetNameplateName(aloftData, nil)

	local healthBar = aloftData.healthBar
	aloftData.healthBarValue = healthBar:GetValue()
	local _, healthBarMaxValue = healthBar:GetMinMaxValues()
	aloftData.healthBarMaxValue = healthBarMaxValue

	aloftData.isBoss = aloftData.bossIconRegion:IsShown()

	local levelTextRegion = aloftData.levelTextRegion
	if levelTextRegion:IsShown() then
		aloftData.levelText = levelTextRegion:GetText()
		aloftData.level = tonumber(aloftData.levelText) or nil
		aloftData.levelTextR, aloftData.levelTextG, aloftData.levelTextB = levelTextRegion:GetTextColor()
	else
		aloftData.levelText = nil
		aloftData.level = nil
		aloftData.levelTextR, aloftData.levelTextG, aloftData.levelTextB = 1, 1, 1
	end

	UpdateAloftTypeData(aloftData, healthBar)
	self:UpdateAloftData(aloftData)

	self:TriggerEvent("Aloft:OnNameplateShow", aloftData)
end

function Aloft:OnNameplateHide(aloftData)
	self:TriggerEvent("Aloft:OnNameplateHide", aloftData)
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

function Aloft:OnCastBarValueChanged(aloftData, castBar)
	if castBar:IsShown() then
		self:TriggerEvent("Aloft:OnCastBarValueChanged", aloftData)
	end
end

function Aloft:OnCastBarShow(aloftData, castBar)
	self:TriggerEvent("Aloft:OnCastBarShow", aloftData)
end

function Aloft:OnCastBarHide(aloftData)
	self:TriggerEvent("Aloft:OnCastBarHide", aloftData)
end

function Aloft:SetNameTextRegionText(this, text)
	self:SetNameText(this, text)

	local aloftData = this.aloftData

	if aloftData.name == L["Unknown"] then
		self:OnNameplateShow(aloftData)
		self:ProcessHealthBarValueChanged(aloftData, nil, nil)
	end
end

function Aloft:GetNameTextRegionText(this)
	local name = this.aloftData.name
	if name ~= "[invalid]" then return name end
	return self.hooks[this].GetText(this)
end

-----------------------------------------------------------------------------

function Aloft:SetNameText(this, text)
	local aloftData = this.aloftData

	aloftData.nameTextRegionText = text
	self.hooks[this].SetText(this, text)
end

-----------------------------------------------------------------------------

function Aloft:OnNameplateShowScript(this)
	local aloftData = this.aloftData
	noTargetNameplate = false
	-- ChatFrame7:AddMessage("Aloft:OnNameplateShowScript(): clear noTargetNameplate")
	visibleNameplateList[aloftData] = true
	self:OnNameplateShow(aloftData)
	self.hooks[this]["OnShow"](this)
end

function Aloft:OnNameplateHideScript(this)
	local aloftData = this.aloftData
	self:OnNameplateHide(aloftData)
	visibleNameplateList[aloftData] = nil
	self.hooks[this]["OnHide"](this)
end

function Aloft:OnHealthBarValueChangedScript(this, value)
	local _, maxValue = this:GetMinMaxValues()
	self:ProcessHealthBarValueChanged(this.aloftData, value, maxValue)
	self.hooks[this]["OnValueChanged"](this, value)
end

function Aloft:OnCastBarValueChangedScript(this, value)
	self:OnCastBarValueChanged(this.aloftData, this)
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

	if newNameText then
		-- ChatFrame7:AddMessage("Aloft:SetNameplateName(): " .. tostring(aloftData) .. "/" .. tostring(aloftData.name) .. ">" .. tostring(newNameText))
		aloftData.name = newNameText
	end
	if not aloftData.name then aloftData.name = "[invalid]" end

	-- make a record of the new name
	name = aloftData.name
	if name and name ~= "[invalid]" then
		nameToNameplateMap[name] = aloftData -- most recently seen nameplate with this unit name
		if (not nameToNameplateMultiMap[name]) then nameToNameplateMultiMap[name] = { } end
		nameToNameplateMultiMap[name][aloftData] = true
	end

	-- NOTE: aloftData.nameTextRegionText is set via the Aloft:SetNameTextRegionText() "SetText" hook
end

function Aloft:SetHealthBarColor(this, r, g, b, a)
	local aloftData = this.aloftData
	-- ChatFrame7:AddMessage("Aloft:SetHealthBarColor(): " .. tostring(this) .. "/" .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.healthBar))

	self.hooks[this].SetStatusBarColor(this, r, g, b, a)
	self:ProcessHealthBarColor(aloftData, this)

	-- ChatFrame7:AddMessage("Aloft:SetHealthBarColor(): " .. aloftData.name)
	-- ChatFrame7:AddMessage("Aloft:SetHealthBarColor(): " .. ("|cff%02x%02x%02x%s|r"):format(aloftData.healthBarR*255, aloftData.healthBarG*255, aloftData.healthBarB*255, "health bar color"))
end

function Aloft:ProcessHealthBarColor(aloftData, healthBar)
	-- We read it back, because rounding seems to kick in and prevent them from being exactly what we sent..
	aloftData.healthBarR, aloftData.healthBarG, aloftData.healthBarB, aloftData.healthBarA = healthBar:GetStatusBarColor()
end

-----------------------------------------------------------------------------

local function AloftDataIsTarget(aloftData, name) return aloftData.nameplateFrame:GetAlpha() == 1 and (aloftData.name == name or aloftData.name == UnitName("target")) end
local function AloftDataIsShown(aloftData) return aloftData.nameplateFrame:IsShown() end

local function AloftDataCreateFontString(aloftData) return aloftData.layoutFrame:CreateFontString(nil, "OVERLAY") end
local function AloftDataCreateTexture(aloftData) local texture = aloftData.layoutFrame:CreateTexture(nil, "OVERLAY") texture:SetBlendMode("BLEND") return texture end

function Aloft:SetupNameplate(frame)
	local aloftData = { type = "unknown", name = "[invalid]", IsTarget = AloftDataIsTarget, IsShown = AloftDataIsShown, CreateFontString = AloftDataCreateFontString, CreateTexture = AloftDataCreateTexture }
	frame.aloftData = aloftData
	nameplateList[aloftData] = true
	visibleNameplateList[aloftData] = true
	noTargetNameplate = false

	aloftData.nameplateFrame = frame -- NOTE: need a nameplateFrame before we can instantiate a layoutFrame

	-- self:DumpNameplateHeirarchy(aloftData)

	self:AcquireLayoutFrame(aloftData) -- configuration of the reference frame is delegated to AloftFrame:SetupFrame(); we just need it to exist, very early in the lifecycle

	local nativeGlowRegion, overlayRegion, castBarOverlayRegion, castBarShieldRegion, spellIconRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion = self:GetNameplateRegions(aloftData)

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
	aloftData.nameTextRegion = nameTextRegion
	aloftData.levelTextRegion = levelTextRegion
	aloftData.bossIconRegion = bossIconRegion
	aloftData.raidIconRegion = raidIconRegion
	aloftData.stateIconRegion = stateIconRegion

	nativeGlowRegion.aloftData = aloftData
	nameTextRegion.aloftData = aloftData
	levelTextRegion.aloftData = aloftData

	-- zap the Blizzard default flash region, we have no way to control it, it does not seem even to generate events; it is replaced in the Glow module if the user wants it
	local texture = nativeGlowRegion:GetTexture()
	if not originalCastBarShieldRegion and texture ~= "" then
		originalCastBarShieldRegion = texture
	end
	nativeGlowRegion:SetTexture("")

	-- zap the Blizzard default cast bar shield region, it is not used under Aloft
	texture = castBarShieldRegion:GetTexture()
	if not originalCastBarShieldRegion and texture ~= "" then
		originalCastBarShieldRegion = texture
	end
	castBarShieldRegion:SetTexture("")

	local healthBar, castBar = frame:GetChildren()
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

	-- Reference all of these now
	aloftData.healthBar = healthBar
	healthBar.aloftData = aloftData

	aloftData.castBar = castBar
	castBar.aloftData = aloftData

	self:HookNameplate(aloftData)

	self:TriggerEvent("Aloft:SetupFrame", aloftData)

	self:OnNameplateShow(aloftData)
	if castBar:IsShown() then
		self:OnCastBarShow(aloftData, castBar)
	end
end

function Aloft:HookNameplate(aloftData)
	local nameplateFrame = aloftData.nameplateFrame
	self:HookScript(nameplateFrame, "OnShow", "OnNameplateShowScript")
	self:HookScript(nameplateFrame, "OnHide", "OnNameplateHideScript")

	local healthBar = aloftData.healthBar
	self:HookScript(healthBar, "OnValueChanged", "OnHealthBarValueChangedScript")
	self:Hook(healthBar, "SetStatusBarColor", "SetHealthBarColor", true)

	local castBar = aloftData.castBar
	self:HookScript(castBar, "OnShow", "OnCastBarShowScript")
	self:HookScript(castBar, "OnHide", "OnCastBarHideScript")
	self:HookScript(castBar, "OnValueChanged", "OnCastBarValueChangedScript")

	local nameTextRegion = aloftData.nameTextRegion
	-- ChatFrame7:AddMessage("Aloft:HookNameplate(): nameTextRegion object type " .. tostring(nameTextRegion:GetObjectType()))
	-- ChatFrame7:AddMessage("Aloft:HookNameplate(): nameTextRegion text  " .. tostring(nameTextRegion:GetText()))
	self:Hook(nameTextRegion, "SetText", "SetNameTextRegionText", true)
	self:Hook(nameTextRegion, "GetText", "GetNameTextRegionText", true)

	-- local levelTextRegion = aloftData.levelTextRegion
	-- ChatFrame7:AddMessage("Aloft:HookNameplate(): levelTextRegion object type " .. tostring(levelTextRegion:GetObjectType()))
	-- ChatFrame7:AddMessage("Aloft:HookNameplate(): levelTextRegion text " .. tostring(levelTextRegion:GetText()))
end

-----------------------------------------------------------------------------

function Aloft:OnCVarUpdate(name, value)
	-- ChatFrame7:AddMessage("Aloft:OnCVarUpdate(): " .. tostring(name) .. "/" .. tostring(value))

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

		self.showClassColorInVKey = (value == "1") and value or nil
		-- ChatFrame7:AddMessage("Aloft:OnCVarUpdate(): " .. tostring(name) .. "/" .. tostring(self.showClassColorInVKey))
	end

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
	local _, place = IsInInstance()
	if place == "none" then
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
	self:SetNameplateCVar("nameplateShowEnemies", value)
end

function Aloft:SetFriendNameplateDisplay(value)
	self:SetNameplateCVar("nameplateShowFriends", value)
end

function Aloft:GetNameplateCVar(cvar)
	local value = GetCVarBool(cvar)
	if value then return true else return false end
end

function Aloft:SetNameplateCVar(cvar, value)
	if value then
		SetCVar(cvar, 1)
	else
		SetCVar(cvar, 0)
	end
end

-----------------------------------------------------------------------------

function Aloft:GetEnemyNameplates()
	return GetCVarBool("nameplateShowEnemies")
end

function Aloft:DisplayEnemyNameplates(value)
	self:SetEnemyNameplateDisplay(value)
end

function Aloft:ToggleEnemyNameplates()
	local value = self:GetEnemyNameplates()
	self:DisplayEnemyNameplates(not value)
end

function Aloft:GetFriendNameplates()
	return GetCVarBool("nameplateShowFriends")
end

function Aloft:DisplayFriendNameplates(value)
	self:SetFriendNameplateDisplay(value)
end

function Aloft:ToggleFriendNameplates()
	local value = self:GetFriendNameplates()
	self:DisplayFriendNameplates(not value)
end

function Aloft:ToggleAllNameplates()
	if (self:GetEnemyNameplates() or self:GetFriendNameplates()) then
		self:DisplayEnemyNameplates(false)
		self:DisplayFriendNameplates(false)
	else
		self:DisplayEnemyNameplates(true)
		self:DisplayFriendNameplates(true)
	end
end

-----------------------------------------------------------------------------

-- versions of redisplay functionality that bypass possibly hooked functions, since we just want to "bounce" nameplates, not affect options or issue announcements

function Aloft:BounceEnemyNameplates()
	local value = self:GetEnemyNameplates()
	self:SetNameplateCVar("nameplateShowEnemies", not value)
	self:ScheduleEvent("Aloft:BounceEnemyNameplates", Aloft.DoBounceEnemyNameplates, 0.15, self, value)
end

function Aloft:DoBounceEnemyNameplates(value)
	self:SetNameplateCVar("nameplateShowEnemies", value)
end

function Aloft:BounceFriendNameplates()
	local value = self:GetFriendNameplates()
	self:SetNameplateCVar("nameplateShowFriends", not value)
	self:ScheduleEvent("Aloft:BounceFriendNameplates", Aloft.DoBounceFriendlyNameplates, 0.25, self, value)
end

function Aloft:DoBounceFriendlyNameplates(value)
	self:SetNameplateCVar("nameplateShowFriends", value)
end

-----------------------------------------------------------------------------

function Aloft.modulePrototype:PrepareText(textFrame, data)
	-- ChatFrame7:AddMessage("Aloft:PrepareText(): enter")

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

function Aloft.modulePrototype:PlaceFrame(frame, relativeFrame, data, xoffset, yoffset)
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

function Aloft.modulePrototype:AdjustFrame(inset, relativeToPoint)
	return inset * horzAdjust[relativeToPoint], inset * vertAdjust[relativeToPoint]
end

-----------------------------------------------------------------------------

-- Provide these functions mainly for Visibiltiy module. ReportStatusChanges can hook them so that the log doesn't fill up
function Aloft:RedisplayEnemyNameplates()
	self:ScheduleEvent("Aloft:RedisplayEnemyNameplates", Aloft.DoDisplayEnemyNameplates, 0.15, self)
end

function Aloft:DoDisplayEnemyNameplates()
	local value = self:GetEnemyNameplates()
	self:DisplayEnemyNameplates(not value)
	self:DisplayEnemyNameplates(value)
end

-- Provide these functions mainly for Visibiltiy module. ReportStatusChanges can hook them so that the log doesn't fill up
function Aloft:RedisplayFriendlyNameplates()
	self:ScheduleEvent("Aloft:RedisplayFriendNameplates", Aloft.DoDisplayFriendlyNameplates, 0.25, self)
end

function Aloft:DoDisplayFriendlyNameplates()
	local value = self:GetFriendNameplates()
	self:DisplayFriendNameplates(not value)
	self:DisplayFriendNameplates(value)
end

-----------------------------------------------------------------------------

function Aloft.modulePrototype:RequiresData()
	-- ChatFrame7:AddMessage("Aloft:modulePrototype:RequiresData(): enter")
	-- eg. return "class", "isPetName", "isGuildMember"
	-- ChatFrame7:AddMessage("Aloft:modulePrototype:RequiresData(): exit")
end

function Aloft.modulePrototype:ProvidesData()
end

function Aloft.modulePrototype:EnableDataSource()
end

function Aloft:IsDataAvailable(name)
	local dataAvailableMethod = Aloft.DataAvailableMethods[name]
	if dataAvailableMethod then
		-- ChatFrame7:AddMessage("Aloft:IsDataAvailable(): " .. name .. "/" .. tostring(dataAvailableMethod()))
		return dataAvailableMethod()
	end
	return true
end

function Aloft.modulePrototype:IsPurelyData()
	return self:ProvidesData() ~= nil
end

function Aloft.modulePrototype:IsOneOfDataListAvailable(...)
	for i=1,select('#', ...) do
		if Aloft:IsDataAvailable(select(i, ...)) then
			return true
		end
	end
	return false
end

function Aloft.modulePrototype:IsDataAvailable()
	return self:IsOneOfDataListAvailable(self:ProvidesData())
end

function Aloft.modulePrototype:RemoveAloftData(name)
	for aloftData in Aloft:IterateNameplates() do
		aloftData[name] = nil
	end
end

function Aloft.modulePrototype:RemoveProvidedData(...)
	for i=1,select('#', ...) do
		self:RemoveAloftData(select(i, ...))
	end
end

function Aloft.modulePrototype:DisableDataSource()
	local dataName = self:ProvidesData()
	if dataName then
		self:UnregisterAllEvents()
		self:CancelAllScheduledEvents()
 		if self.UnhookAll then
			self:UnhookAll()
		end
		self:RemoveProvidedData(self:ProvidesData())
	end
end

function Aloft.modulePrototype:UpdateData(aloftData)
	DEFAULT_CHAT_FRAME:AddMessage("Internal error: DataSource's UpdateData not overriden.")
end

function Aloft.modulePrototype:CancelEvent(eventName)
	if self:IsEventRegistered(eventName) then
		self:UnregisterEvent(eventName)
	end
end

function Aloft.modulePrototype:IsArrayEqual(a, b)
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
	level = nameplateFrame:GetFrameLevel()
	layoutFrame:SetFrameLevel(level + 1)
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

function Aloft:GetNameplateRegions(aloftData)
	-- ChatFrame7:AddMessage("Aloft:GetNameplateRegions(): VERSION " .. tostring(version) .. "/" .. tostring(build) .. "/" .. tostring(date) .. "/" .. tostring(tocversion) .. " VERSION")

	local frame = aloftData.nameplateFrame
	local nativeGlowRegion, overlayRegion, castBarOverlayRegion, castBarShieldRegion, spellIconRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion, extra12, extra13, extra14, extra15, extra16, extra17, extra18, extra19
	-- if version == "0.2.0" then
		nativeGlowRegion, overlayRegion, castBarOverlayRegion, castBarShieldRegion, spellIconRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion, extra12, extra13, extra14, extra15, extra16, extra17, extra18, extra19 = frame:GetRegions()
	-- else
	--	nativeGlowRegion, overlayRegion, castBarOverlayRegion, spellIconRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion, extra11, extra12, extra13, extra14, extra15, extra16, extra17, extra18, extra19 = frame:GetRegions()
	-- end

	return nativeGlowRegion, overlayRegion, castBarOverlayRegion, castBarShieldRegion, spellIconRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion, stateIconRegion, extra11, extra12, extra13, extra14, extra15, extra16, extra17, extra18, extra19
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

function Aloft:DumpObjectHeirarchy(object)
	local regionType
	local regionData

	if object.GetObjectType then
		local objectType = object:GetObjectType()
		if objectType == "Frame" then
			local numFrameRegions = object:GetNumRegions()
			ChatFrame7:AddMessage("Aloft:DumpObjectHeirarchy(): ----- FRAME " .. tostring(object:GetName()) .. " #regions " .. tostring(numFrameRegions) .. " FRAME -----")
			for i = 1,numFrameRegions do
				local region = select(i, object:GetRegions())
				regionType = region:GetObjectType()
				if regionType == "Texture" then
					regionData = region:GetTexture()
				elseif regionType == "FontString" then
					regionData = region:GetText()
				end
				ChatFrame7:AddMessage("Aloft:DumpObjectHeirarchy(): region " .. tostring(region:GetName()) .. "/" .. tostring(regionType) .. "/" .. tostring(regionData))
			end
		else
			ChatFrame7:AddMessage("Aloft:DumpObjectHeirarchy(): ----- UNKNOWN " .. tostring(object:GetName()) .. "/" .. tostring(objectType) .. " UNKNOWN -----")
		end
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

