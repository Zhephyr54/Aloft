local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftHealthText =
{
	type = 'toggle',
	name = L["AloftHealthText"],
	desc = L["Display health data and text on nameplates"],
	get = function() return AloftModules.db.profile.AloftHealthText end,
	set = function(v) AloftModules.db.profile.AloftHealthText = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
