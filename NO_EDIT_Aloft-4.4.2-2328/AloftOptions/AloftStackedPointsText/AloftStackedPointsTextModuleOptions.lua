local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
if not AloftLocale or not AloftLocale.AloftModules then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftModules

Aloft.Options.args.modules.args.aloftStackedPointsText =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftStackedPointsText"],
	desc = L["Display stacked points (combo point/lacerate/sunder counts) on nameplates"],
	get = function(i) return AloftModules.db.profile.AloftStackedPointsText end,
	set = function(i, v) AloftModules.db.profile.AloftStackedPointsText = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
