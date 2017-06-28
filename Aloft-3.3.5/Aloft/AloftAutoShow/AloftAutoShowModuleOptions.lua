local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftAutoShow =
{
	type = 'toggle',
	name = L["AloftAutoShow"],
	desc = L["Automatically show/hide nameplates based on various events and conditions"],
	get = function() return AloftModules.db.profile.AloftAutoShow end,
	set = function(v) AloftModules.db.profile.AloftAutoShow = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
