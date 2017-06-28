local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftModules
if not L then return end

-----------------------------------------------------------------------------

Aloft.Options.args.modules.args.aloftCastBarSpellNameText =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftCastBarSpellNameText"],
	desc = L["Display spell name on cast bar"],
	get = function(i) return AloftModules.db.profile.AloftCastBarSpellNameText end,
	set = function(i, v) AloftModules.db.profile.AloftCastBarSpellNameText = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
