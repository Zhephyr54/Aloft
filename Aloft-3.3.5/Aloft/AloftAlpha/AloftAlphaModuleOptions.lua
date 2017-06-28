local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftAlpha =
{
	type = 'toggle',
	name = L["AloftAlpha"],
	desc = L["Control the relative transparency of nameplates"],
	get = function() return AloftModules.db.profile.AloftAlpha end,
	set = function(v) AloftModules.db.profile.AloftAlpha = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
