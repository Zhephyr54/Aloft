local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftVisibility =
{
	type = 'toggle',
	name = L["AloftVisibility"],
	desc = L["Control the visibility of various types of nameplates"],
	get = function() return AloftModules.db.profile.AloftVisibility end,
	set = function(v) AloftModules.db.profile.AloftVisibility = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
