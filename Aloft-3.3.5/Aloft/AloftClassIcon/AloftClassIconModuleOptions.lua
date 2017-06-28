local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftClassIcon =
{
	type = 'toggle',
	name = L["AloftClassIcon"],
	desc = L["Display class icons on nameplates"],
	get = function() return AloftModules.db.profile.AloftClassIcon end,
	set = function(v) AloftModules.db.profile.AloftClassIcon = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
