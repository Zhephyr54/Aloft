local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

local AloftManaData = Aloft:NewModule("ManaData", "AceEvent-2.0")
AloftManaData.dynamic = "AloftMana"

local AloftManaBar = Aloft:HasModule("ManaBar") and Aloft:GetModule("ManaBar") or nil
local AloftManaText = Aloft:HasModule("ManaText") and Aloft:GetModule("ManaText") or nil

local L = AceLibrary("AceLocale-2.2"):new("AloftManaDataOptions")

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

function AloftManaData:OnInitialize()
end

function AloftManaData:OnEnable()
	Aloft:DebugRegister("ManaData")
end

function AloftManaData:OnDisable()
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
	--[[
	if ((AloftManaBar and AloftManaBar.db and AloftManaBar.db.profile.enable and AloftManaBar.db.profile.always) or
		(AloftManaText and AloftManaText.db and AloftManaText.db.profile.enable and AloftManaText.db.profile.always))
	then
		-- self:RegisterEvent("UNIT_HEALTH", "OnUnitStateChanged") -- TODO: experimental
	end
	]]

	self:RegisterEvent("UNIT_MANA", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_RAGE", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_FOCUS", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_ENERGY", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_RUNIC_POWER", "OnUnitManaChanged")
	self:RegisterEvent("UNIT_DISPLAYPOWER", "OnUnitManaChanged")

	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	self:RegisterEvent("Aloft:OnUnitidDataChanged", "OnUnitidDataChanged")
	self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
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
		self:TriggerEvent("Aloft:OnManaDataChanged", aloftData)
	end
end

function AloftManaData:SetManaData(aloftData, unitid)
	local name, _ = UnitName(unitid)
	if name ~= L["Unknown"] and aloftData.name ~= L["Unknown"] then
		local maxMana = UnitManaMax(unitid)
		-- ChatFrame7:AddMessage("AloftManaData:SetManaData(): update " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/".. tostring(maxMana))
		if ((maxMana ~= nil) and (maxMana > 0)) then
			aloftData.mana = UnitMana(unitid)
			aloftData.maxMana = maxMana
			aloftData.powerType, aloftData.powerTypeName = UnitPowerType(unitid)
			-- ChatFrame7:AddMessage("AloftManaData:SetManaData(): " .. tostring(unitid) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(aloftData.mana) .. "/" .. tostring(aloftData.maxMana) .. "/" .. tostring(aloftData.powerType) .. "/" .. tostring(aloftData.powerTypeName)) 

			-- ChatFrame7:AddMessage("AloftManaData:SetManaData(): trigger update event") 
			self:TriggerEvent("Aloft:OnManaDataChanged", aloftData)
		end
	end
end

-- experimental, want a "proactive" means of gathering mana on the target nameplate and displaying it
-- TODO: needs to be evaluated for overhead, and perhaps throttled
-- TODO: there might be a better "intermittent" event for driving this
-- TODO: can we leverage lastTarget from the IsTargetData module to avoid this lookup?
-- TODO: can we leverate targetNameplate from the AloftAlpha to avoid this lookup?
function AloftManaData:OnUnitStateChanged(unitid)
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

function AloftManaData:OnUnitManaChanged(unitid)
	-- ChatFrame7:AddMessage("AloftManaData:OnUnitManaChanged(): enter " .. unitid) 
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
function AloftManaData:OnUnitEnergyChanged(unitid)
	-- ChatFrame7:AddMessage("AloftManaData:OnUnitEnergyChanged(): " .. tostring(unitid))
	self:OnUnitManaChanged(unitid)
end
]]

--[[
function AloftManaData:OnUnitFocusChanged(unitid)
	-- ChatFrame7:AddMessage("AloftManaData:OnUnitFocusChanged(): " .. tostring(unitid))
	self:OnUnitManaChanged(unitid)
end
]]

-----------------------------------------------------------------------------

function AloftManaData:UpdateData(aloftData)
	-- ChatFrame7:AddMessage("AloftManaData:UpdateData(): enter " .. aloftData.name .. "/" .. (aloftData.unitid or "<UNKNOWN>")) 
	aloftData.mana = nil
	aloftData.maxMana = nil
	aloftData.powerType = nil

	if aloftData.isTarget or aloftData:IsTarget() then
		self:SetManaData(aloftData, "target")
	elseif aloftData.unitid then
		self:SetManaData(aloftData, aloftData.unitid)
	end
end

-----------------------------------------------------------------------------

function AloftManaData:OnNameplateShow(aloftData)
	local eventName = " Aloft:ManaDataUpdate:" .. tostring(math.random(1,1000000000))
	-- ChatFrame7:AddMessage("AloftManaData:UpdateNameplateMana(): " .. tostring(eventName) .. "/".. tostring(aloftData) .. "/".. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.maxMana)) 
	-- ChatFrame7:AddMessage("AloftManaData:UpdateNameplateMana(): " .. debugstack(1, 5, 5)) 
	self:ScheduleEvent(eventName, self.UpdateNameplate, 0.0, self, aloftData) -- update on next frame
end

-- this is the function that performs the update on the next frame
function AloftManaData:UpdateNameplate(aloftData)
	-- ChatFrame7:AddMessage("AloftManaData:UpdateNameplate(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid)) 
	if ((aloftData.maxMana == nil) or (aloftData.maxMana <= 0)) then
		if aloftData.isTarget or aloftData:IsTarget() then
			-- ChatFrame7:AddMessage("AloftManaData:UpdateNameplate(): istarget " .. aloftData.name) 
			self:SetManaData(aloftData, "target")
		elseif aloftData.unitid then
			-- ChatFrame7:AddMessage("AloftManaData:UpdateNameplate(): update " .. aloftData.name) 
			self:SetManaData(aloftData, aloftData.unitid)
		end
	else
		-- the nameplate already has mana; trigger an update to make the bar show
		self:TriggerEvent("Aloft:OnManaDataChanged", aloftData)
	end
end

function AloftManaData:OnNameplateHide(aloftData)
	-- ChatFrame7:AddMessage("AloftManaData:OnNameplateHide(): enter " .. aloftData.name) 
	self:ClearManaData(aloftData)
end

function AloftManaData:OnIsTargetDataChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftManaData:OnIsTargetDataChanged(): enter " .. aloftData.name) 
	if aloftData.isTarget or aloftData:IsTarget() then
		if ((aloftData.maxMana == nil) or (aloftData.maxMana <= 0)) then
			self:SetManaData(aloftData, "target")
		end
	elseif not aloftData.unitid then
		self:ClearManaData(aloftData)
	end

	-- ChatFrame7:AddMessage("AloftManaData:OnIsTargetDataChanged(): trigger update event " .. aloftData.name) 
	self:TriggerEvent("Aloft:OnManaDataChanged", aloftData)
end

function AloftManaData:OnUnitidDataChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftManaData:OnUnitidDataChanged(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) 
	self:UpdateData(aloftData)
	-- ChatFrame7:AddMessage("AloftManaData:OnUnitidDataChanged(): trigger update event " .. aloftData.name) 
	self:TriggerEvent("Aloft:OnManaDataChanged", aloftData)
end

-----------------------------------------------------------------------------

end)
