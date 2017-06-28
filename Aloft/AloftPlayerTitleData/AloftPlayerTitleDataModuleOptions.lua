local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftPlayerTitle =
{
	type = 'toggle',
	name = L["AloftPlayerTitle"],
	desc = L["Gather and display player titles on nameplates"],
	get = function() return AloftModules.db.profile.AloftPlayerTitle end,
	set = function(v) AloftModules.db.profile.AloftPlayerTitle = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
