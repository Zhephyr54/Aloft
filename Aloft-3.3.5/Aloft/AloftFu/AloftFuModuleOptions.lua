local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftFu =
{
	type = 'toggle',
	name = L["AloftFu"],
	desc = L["Provide a FuBar interface for Aloft"],
	get = function() return AloftModules.db.profile.AloftFu end,
	set = function(v) AloftModules.db.profile.AloftFu = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
