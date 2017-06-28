local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftTarget
if not L then return end

local AloftTargetNameData = Aloft:GetModule("TargetNameData", true)
if not AloftTargetNameData then return end

-----------------------------------------------------------------------------

-- NOTE: these options get added into another module's options

AloftTargetNameData.options = { }

AloftTargetNameData.options.enable =
{
	type = 'toggle',
	width = 'full',
	name = L["Enable Target-of-Target"],
	desc = L["Enable target-of-target"],
	order = 3,
	disabled = function(i) return not Aloft:IsEnabled() or not AloftTargetNameData:IsEnabled() or not AloftTargetNameData.db or not AloftTargetNameData.db.profile end,
	get = function(i) return AloftTargetNameData.db.profile.enable end,
	set = function(i, v) AloftTargetNameData.db.profile.enable = v Aloft:DetermineDataSources() end,
}

AloftTargetNameData.options.interval =
{
	type = 'range',
	width = 'full',
	name = L["Target-of-Target Update Interval"],
	desc = L["The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"],
	order = 4,
	min = 0.0,
	max = 5.0,
	step = 0.01,
	disabled = function(i) return not Aloft:IsEnabled() or not AloftTargetNameData:IsEnabled() or not AloftTargetNameData.db or not AloftTargetNameData.db.profile or not AloftTargetNameData.db.profile.enable end,
	get = function(i) return AloftTargetNameData.db.profile.interval end,
	set = function(i, v) AloftTargetNameData.db.profile.interval = v Aloft:DetermineDataSources() end,
}

-----------------------------------------------------------------------------

end)
