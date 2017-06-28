local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftGuild =
{
	type = 'toggle',
	name = L["AloftGuild"],
	desc = L["Gather and display player guild names on nameplates"],
	get = function() return AloftModules.db.profile.AloftGuild end,
	set = function(v) AloftModules.db.profile.AloftGuild = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
