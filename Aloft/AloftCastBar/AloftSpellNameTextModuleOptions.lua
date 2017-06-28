local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftCastBarSpellNameText =
{
	type = 'toggle',
	name = L["AloftCastBarSpellNameText"],
	desc = L["Display spell name on cast bar"],
	get = function() return AloftModules.db.profile.AloftCastBarSpellNameText end,
	set = function(v) AloftModules.db.profile.AloftCastBarSpellNameText = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
