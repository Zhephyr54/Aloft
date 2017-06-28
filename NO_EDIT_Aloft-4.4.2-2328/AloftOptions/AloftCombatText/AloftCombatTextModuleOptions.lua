local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftModules
if not L then return end

-----------------------------------------------------------------------------

Aloft.Options.args.modules.args.aloftCombatText =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftCombatText"],
	desc = L["Display combat text on group member nameplates"],
	get = function(i) return AloftModules.db.profile.AloftCombatText end,
	set = function(i, v) AloftModules.db.profile.AloftCombatText = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
