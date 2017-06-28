local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

local AloftHealthData = Aloft:NewModule("HealthData", "AceEvent-2.0")
AloftHealthData.dynamic = "AloftHealthText"

local L = AceLibrary("AceLocale-2.2"):new("AloftHealthTextOptions")

-----------------------------------------------------------------------------

Aloft.TagData.Health =
{
	data = "health",
	events = "Aloft:OnHealthDataChanged",
	overrideEvents = "Aloft:OnHealthBarValueChanged",
	tableData = "health",
	numeric = true
}

Aloft.TagData.MaxHealth =
{
	data = "maxHealth",
	events = "Aloft:OnHealthDataChanged",
	overrideEvents = "Aloft:OnHealthBarValueChanged",
	tableData = "maxHealth",
	numeric = true
}

Aloft.TagData.HealthDeficit =
{
	data = { "health", "maxHealth" },
	events = "Aloft:OnHealthDataChanged",
	overrideEvents = "Aloft:OnHealthBarValueChanged",
	compileString = function(dataTable, prior) return string.format("data.health and %s%s(data.maxHealth - data.health)", prior or "", prior and " and " or "") end,
	numeric = true
}

Aloft.TagData.HideKnownHealth =
{
	data = "health",
	events = "Aloft:OnHealthDataChanged",
	overrideEvents = "Aloft:OnHealthBarValueChanged",
	compileString = function(dataTable, prior) return string.format("not data.health%s%s", prior and " and " or "", prior or "") end
}

-----------------------------------------------------------------------------

function AloftHealthData:OnEnable()
end

-----------------------------------------------------------------------------

function AloftHealthData:ProvidesData()
	return "health", "maxHealth"
end

-----------------------------------------------------------------------------

function AloftHealthData:EnableDataSource()
	self:RegisterEvent("Aloft:OnHealthBarValueChanged", "OnHealthBarValueChanged")
end

-----------------------------------------------------------------------------

function AloftHealthData:UpdateData(aloftData)
	aloftData.health = aloftData.healthBarValue
	aloftData.maxHealth = aloftData.healthBarMaxValue
	--if (Aloft:IsLogEnbl("HealthData", 2)) then Aloft:Log("HealthData", "UpdateData", 2, "bar health " .. aloftData.health .. " maxHealth " .. aloftData.maxHealth) end
end

-----------------------------------------------------------------------------

function AloftHealthData:OnHealthBarValueChanged(aloftData)
	if aloftData.name ~= L["Unknown"] then
		self:UpdateData(aloftData)
		self:TriggerEvent("Aloft:OnHealthDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------

end)
