local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftStackedPointsText =
{
	type = 'toggle',
	name = L["AloftStackedPointsText"],
	desc = L["Display stacked points (combo point/lacerate/sunder counts) on nameplates"],
	get = function() return AloftModules.db.profile.AloftStackedPointsText end,
	set = function(v) AloftModules.db.profile.AloftStackedPointsText = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
