local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftCastBarTimeText =
{
	type = 'toggle',
	name = L["AloftCastBarTimeText"],
	desc = L["Display cast bar time text"],
	get = function() return AloftModules.db.profile.AloftCastBarTimeText end,
	set = function(v) AloftModules.db.profile.AloftCastBarTimeText = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
