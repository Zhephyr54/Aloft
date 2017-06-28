local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

local L = AloftLocale.Aloft
if not L then return end

local AloftHealthData = Aloft:NewModule("HealthData", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftHealthData.dynamic = "AloftHealthText"

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

function AloftHealthData:OnInitialize()
	self.initialized = true
end

function AloftHealthData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end
end

function AloftHealthData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftHealthData:ProvidesData()
	return "health", "maxHealth"
end

-----------------------------------------------------------------------------

function AloftHealthData:EnableDataSource()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("Aloft:OnHealthBarValueChanged", "OnHealthBarValueChanged")
end

-----------------------------------------------------------------------------

function AloftHealthData:UpdateData(aloftData)
	aloftData.health = aloftData.healthBarValue
	aloftData.maxHealth = aloftData.healthBarMaxValue
	-- ChatFrame7:AddMessage("AloftHealthData:UpdateData(): bar health " .. aloftData.health .. " maxHealth " .. aloftData.maxHealth)
end

-----------------------------------------------------------------------------

function AloftHealthData:OnHealthBarValueChanged(message, aloftData)
	if aloftData.name ~= L["Unknown"] then
		self:UpdateData(aloftData)
		self:SendMessage("Aloft:OnHealthDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------

end)
