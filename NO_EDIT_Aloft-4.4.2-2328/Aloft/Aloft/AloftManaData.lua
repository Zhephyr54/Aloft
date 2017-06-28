local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

local L = AloftLocale.Aloft
if not L then return end

local AloftManaData = Aloft:NewModule("ManaData", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftManaData.dynamic = "AloftMana"

local AloftManaBar -- loaded after this module, initialized in OnEnable()
local AloftManaText -- loaded after this module, initialized in OnEnable()

-----------------------------------------------------------------------------

Aloft.TagData.Mana =
{
	data = "mana",
	events = "Aloft:OnManaDataChanged",
	tableData = "mana",
	numeric = true
}

Aloft.TagData.MaxMana =
{
	data = "maxMana",
	events = "Aloft:OnManaDataChanged",
	tableData = "maxMana",
	numeric = true
}

Aloft.TagData.ManaDeficit =
{
	data = { "mana", "maxMana" },
	events = "Aloft:OnManaDataChanged",
	compileString = function(dataTable, prior) return string.format("data.mana and %s%s(data.maxMana - data.mana)", prior or "", prior and " and " or "") end,
	numeric = true
}

Aloft.TagData.ManaFraction =
{
	data = { "mana", "maxMana" },
	events = "Aloft:OnManaDataChanged",
	compileString = function(dataTable, prior) return string.format("data.mana and data.maxMana and data.maxMana > 0 and %s%s(ceil(100.0 * (data.mana / data.maxMana)) / 100.0)", prior or "", prior and " and " or "") end,
	numeric = true
}

Aloft.TagData.PowerType =
{
	data = "powerType",
	events = "Aloft:OnManaDataChanged",
	tableData = "powerType",
	numeric = true
}

Aloft.TagData.PowerTypeName =
{
	data = "powerTypeName",
	events = "Aloft:OnManaDataChanged",
	tableData = "powerTypeName",
}

local shortPowerTypeName =
{
	[0] = "M",  -- Mana
	[1] = "Rg", -- Rage
	[2] = "F",  -- Focus
	[3] = "E",  -- Energy
	[4] = "H",  -- Happiness
	[5] = "R",  -- Runes
	[6] = "RP", -- Runic Power
}

Aloft.TagData.ShortPowerTypeName =
{
	data = "powerTypeName",
	events = "Aloft:OnManaDataChanged",
	method = function(aloftData, value) return value and aloftData.powerType and shortPowerTypeName[aloftData.powerType] end,
}

local colorTable =
{
	[0] = "c0c0ff", -- Mana
	[1] = "ff8080", -- Rage
	[2] = "ffd100", -- Focus
	[3] = "ffff80", -- Energy
	[4] = "80ffff", -- Happiness
	[5] = "7f7f7f", -- Runes
	[6] = "ebebeb", -- Runic Power
}

Aloft.TagData.PowerTypeColor =
{
	data = "powerType",
	events = "Aloft:OnManaDataChanged",
	method = function(aloftData, value) return value and aloftData.powerType and ("|cff%s%s|r"):format(colorTable[aloftData.powerType], value or "") end,
	noGuaranteeChange = true
}

-----------------------------------------------------------------------------

local UnitName = UnitName
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitPowerType = UnitPowerType

-----------------------------------------------------------------------------

function AloftManaData:OnInitialize()
	AloftManaBar = Aloft:GetModule("ManaBar", true)
	AloftManaText = Aloft:GetModule("ManaText", true)

	self.initialized = true
end

function AloftManaData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end
end

function AloftManaData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftManaData:ProvidesData()
	return "mana", "maxMana", "powerType", "powerTypeName"
end

function AloftManaData:RequiresData()
	--if GetNumPartyMembers() + GetNumRaidMembers() > 0 then
		return "unitid", "isTarget"
	--else
	--	return "isTarget"
	--end
end

function AloftManaData:EnableDataSource()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	--[[
	if ((AloftManaBar and AloftManaBar.db and AloftManaBar.db.profile.enable and AloftManaBar.db.profile.always) or
		(AloftManaText and AloftManaText.db and AloftManaText.db.profile.enable and AloftManaText.db.profile.always))
	then
		-- self:RegisterEvent("UNIT_HEALTH", "OnUnitStateChanged") -- TODO: experimental
	end
	]]

	--[[ obsolete WoW 3.3 events
	self:RegisterEvent("UNIT_MANA", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_RAGE", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_FOCUS", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_ENERGY", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_RUNIC_POWER", "OnUnitManaChanged")
	]]

	-- new WoW 4.0.1+ event
	self:RegisterEvent("UNIT_POWER", "OnUnitManaChanged")

	self:RegisterEvent("UNIT_DISPLAYPOWER", "OnUnitManaChanged")

	self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
	self:RegisterMessage("Aloft:OnUnitidDataChanged", "OnUnitidDataChanged")
	self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
end

-----------------------------------------------------------------------------

function AloftManaData:ClearManaData(aloftData)
	-- ChatFrame7:AddMessage("AloftManaData:ClearManaData():  clear " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/".. tostring(aloftData.maxMana) 
	if (aloftData.maxMana ~= nil) then
		-- ChatFrame7:AddMessage("AloftManaData:ClearManaData(): clear " .. aloftData.name) 
		aloftData.mana = nil
		aloftData.maxMana = nil
		aloftData.powerType = nil
		-- ChatFrame7:AddMessage("AloftManaData:ClearManaData(): trigger update event") 
		self:SendMessage("Aloft:OnManaDataChanged", aloftData)
	end
end

function AloftManaData:SetManaData(aloftData, unitid)
	local name, _ = UnitName(unitid)
	if name ~= L["Unknown"] and aloftData.name ~= L["Unknown"] then
		local maxMana = UnitPowerMax(unitid)
		-- ChatFrame7:AddMessage("AloftManaData:SetManaData(): update " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/".. tostring(maxMana))
		if ((maxMana ~= nil) and (maxMana > 0)) then
			aloftData.mana = UnitPower(unitid)
			aloftData.maxMana = maxMana
			aloftData.powerType, aloftData.powerTypeName = UnitPowerType(unitid)
			-- ChatFrame7:AddMessage("AloftManaData:SetManaData(): " .. tostring(unitid) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(aloftData.mana) .. "/" .. tostring(aloftData.maxMana) .. "/" .. tostring(aloftData.powerType) .. "/" .. tostring(aloftData.powerTypeName)) 

			-- ChatFrame7:AddMessage("AloftManaData:SetManaData(): trigger update event") 
			self:SendMessage("Aloft:OnManaDataChanged", aloftData)
		end
	end
end

-- experimental, want a "proactive" means of gathering mana on the target nameplate and displaying it
-- TODO: needs to be evaluated for overhead, and perhaps throttled
-- TODO: there might be a better "intermittent" event for driving this
-- TODO: can we leverage lastTarget from the IsTargetData module to avoid this lookup?
-- TODO: can we leverate targetNameplate from the AloftAlpha to avoid this lookup?
function AloftManaData:OnUnitStateChanged(event, unitid)
	-- ChatFrame7:AddMessage("AloftManaData:OnUnitStateChanged(): enter " .. unitid) 
	if unitid == "target" then
		-- ChatFrame7:AddMessage("AloftManaData:OnUnitStateChanged(): find nameplate") 
		local aloftData = Aloft:GetTargetNameplate()
		if aloftData then
			-- ChatFrame7:AddMessage("AloftManaData:OnUnitStateChanged(): " .. aloftData.name) 
			self:SetManaData(aloftData, unitid)
		end
	end
end

-- the powertype argument is currently not used here, and in any event would arrive with a nil value via the UNIT_DISPLAYPOWER event
function AloftManaData:OnUnitManaChanged(event, unitid, powertype)
	-- ChatFrame7:AddMessage("AloftManaData:OnUnitManaChanged(): enter " .. tostring(event) .. "/" .. tostring(unitid))
	if unitid == "target" then
		-- ChatFrame7:AddMessage("AloftManaData:OnUnitManaChanged(): target") 
		local aloftData = Aloft:GetTargetNameplate()
		if aloftData and (aloftData.isTarget or aloftData:IsTarget()) then
			-- ChatFrame7:AddMessage("AloftManaData:OnUnitManaChanged(): " .. aloftData.name .. "/target") 
			self:SetManaData(aloftData, unitid)
		end
	else
		local aloftData = Aloft:GetUnitNameplate(unitid)
		-- ChatFrame7:AddMessage("AloftManaData:OnUnitManaChanged(): " .. tostring(unitid) .. "/" .. tostring(aloftData and aloftData.name))

		if aloftData then
			-- ChatFrame7:AddMessage("AloftManaData:OnUnitManaChanged(): " .. tostring(unitid) .. "/" .. tostring(aloftData.name))
			self:SetManaData(aloftData, unitid)
		end
	end
end

--[[
function AloftManaData:OnUnitEnergyChanged(event, unitid)
	-- ChatFrame7:AddMessage("AloftManaData:OnUnitEnergyChanged(): " .. tostring(unitid))
	self:OnUnitManaChanged(event, unitid)
end
]]

--[[
function AloftManaData:OnUnitFocusChanged(event, unitid)
	-- ChatFrame7:AddMessage("AloftManaData:OnUnitFocusChanged(): " .. tostring(unitid))
	self:OnUnitManaChanged(event, unitid)
end
]]

-----------------------------------------------------------------------------

function AloftManaData:UpdateData(aloftData)
	-- ChatFrame7:AddMessage("AloftManaData:UpdateData(): enter " .. aloftData.name .. "/" .. (aloftData.unitid or "<UNKNOWN>")) 
	self:ClearManaData(aloftData)
	self:UpdateNameplate(aloftData)
end

-- this is the function that performs the update on the next frame
function AloftManaData:UpdateNameplate(aloftData)
	-- ChatFrame7:AddMessage("AloftManaData:UpdateNameplate(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid)) 
	if aloftData.isTarget or aloftData:IsTarget() then
		-- ChatFrame7:AddMessage("AloftManaData:UpdateNameplate(): istarget " .. aloftData.name) 
		self:SetManaData(aloftData, "target")
	elseif aloftData.unitid then
		-- ChatFrame7:AddMessage("AloftManaData:UpdateNameplate(): update " .. aloftData.name) 
		self:SetManaData(aloftData, aloftData.unitid)
	else
		-- ChatFrame7:AddMessage("AloftManaData:OnIsTargetDataChanged(): unitid " .. tostring(aloftData.name) .. "/" .. tostring(unitid))
		self:ClearManaData(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftManaData:OnNameplateShow(message, aloftData)
	-- ChatFrame7:AddMessage("AloftManaData:UpdateNameplateMana(): " .. tostring(aloftData) .. "/".. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.maxMana)) 
	-- ChatFrame7:AddMessage("AloftManaData:UpdateNameplateMana(): " .. debugstack(1, 5, 5)) 
	self:ScheduleTimer(function(aloftData) AloftManaData:UpdateNameplate(aloftData) end, 0.0, aloftData) -- update on next frame
end

function AloftManaData:OnNameplateHide(message, aloftData)
	-- ChatFrame7:AddMessage("AloftManaData:OnNameplateHide(): enter " .. aloftData.name) 
	self:ClearManaData(aloftData)
end

function AloftManaData:OnIsTargetDataChanged(message, aloftData)
	self:ScheduleTimer(function(aloftData) AloftManaData:UpdateNameplate(aloftData) end, 0.0, aloftData) -- update on next frame
end

function AloftManaData:OnUnitidDataChanged(message, aloftData)
	self:UpdateNameplate(aloftData)
end

-----------------------------------------------------------------------------

end)
