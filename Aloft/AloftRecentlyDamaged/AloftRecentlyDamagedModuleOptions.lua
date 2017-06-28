local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftRecentlyDamaged =
{
	type = 'toggle',
	name = L["AloftRecentlyDamaged"],
	desc = L["Display recently damaged icon on nameplates"],
	get = function() return AloftModules.db.profile.AloftRecentlyDamaged end,
	set = function(v) AloftModules.db.profile.AloftRecentlyDamaged = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
