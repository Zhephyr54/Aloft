local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftCombatText =
{
	type = 'toggle',
	name = L["AloftCombatText"],
	desc = L["Display combat text on group member nameplates"],
	get = function() return AloftModules.db.profile.AloftCombatText end,
	set = function(v) AloftModules.db.profile.AloftCombatText = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
