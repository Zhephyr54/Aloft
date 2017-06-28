local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.AloftLDB =
{
	type = 'toggle',
	name = L["AloftLDB"],
	desc = L["Provide a LibDataBroker-1.1 interface for Aloft"],
	get = function() return AloftModules.db.profile.AloftLDB end,
	set = function(v) AloftModules.db.profile.AloftLDB = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
