local AloftModules = AloftModules
if (not AloftModules) then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftThreat =
{
	type = 'toggle',
	name = L["AloftThreat"],
	desc = L["Display threat data, bars, and text on nameplates"],
	get = function() return AloftModules.db.profile.AloftThreat end,
	set = function(v) AloftModules.db.profile.AloftThreat = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
