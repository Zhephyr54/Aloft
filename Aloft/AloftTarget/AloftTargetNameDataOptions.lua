local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("TargetNameData") then return end

local AloftTargetNameData = Aloft:GetModule("TargetNameData")
local L = AceLibrary("AceLocale-2.2"):new("AloftTargetNameDataOptions")

-----------------------------------------------------------------------------

AloftTargetNameData.options = { }

AloftTargetNameData.options.enable =
{
	type = 'toggle',
	name = L["Enable Target-of-Target"],
	desc = L["Enable target-of-target"],
	order = 3,
	get = function() return AloftTargetNameData.db.profile.enable end,
	set = function(v) AloftTargetNameData.db.profile.enable = v Aloft:DetermineDataSources() end,
}

AloftTargetNameData.options.interval =
{
	type = 'range',
	name = L["Target-of-Target Update Interval"],
	desc = L["The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"],
	order = 4,
	min = 0.0,
	max = 5.0,
	step = 0.01,
	disabled = function() return not AloftTargetNameData.db.profile.enable end,
	get = function() return AloftTargetNameData.db.profile.interval end,
	set = function(v) AloftTargetNameData.db.profile.interval = v Aloft:DetermineDataSources() end,
}

-----------------------------------------------------------------------------

end)
