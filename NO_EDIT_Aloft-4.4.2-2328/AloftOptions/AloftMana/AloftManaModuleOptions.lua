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

Aloft.Options.args.modules.args.aloftMana =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftMana"],
	desc = L["Display mana data, bars, and text on nameplates"],
	get = function(i) return AloftModules.db.profile.AloftMana end,
	set = function(i, v) AloftModules.db.profile.AloftMana = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
