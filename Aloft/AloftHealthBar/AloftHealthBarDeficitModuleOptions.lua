local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftHealthBarDeficit =
{
	type = 'toggle',
	name = L["AloftHealthBarDeficit"],
	desc = L["Modifiy Aloft nameplate health bars to deficit form"],
	get = function() return AloftModules.db.profile.AloftHealthBarDeficit end,
	set = function(v) AloftModules.db.profile.AloftHealthBarDeficit = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
