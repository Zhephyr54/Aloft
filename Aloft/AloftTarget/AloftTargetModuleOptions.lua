local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftTarget =
{
	type = 'toggle',
	name = L["AloftTarget"],
	desc = L["Display target name and group target count on nameplates"],
	get = function() return AloftModules.db.profile.AloftTarget end,
	set = function(v) AloftModules.db.profile.AloftTarget = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
