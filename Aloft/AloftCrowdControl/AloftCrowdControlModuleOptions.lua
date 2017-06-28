local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftCrowdControl =
{
	type = 'toggle',
	name = L["AloftCrowdControl"],
	desc = L["Display crowd control timers on nameplates when possible"],
	get = function() return AloftModules.db.profile.AloftCrowdControl end,
	set = function(v) AloftModules.db.profile.AloftCrowdControl = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
