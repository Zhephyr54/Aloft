local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftPresets =
{
	type = 'toggle',
	name = L["AloftPresets"],
	desc = L["Enable access to preset configurations"],
	get = function() return AloftModules.db.profile.AloftPresets end,
	set = function(v) AloftModules.db.profile.AloftPresets = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
