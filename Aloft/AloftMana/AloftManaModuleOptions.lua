local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftMana =
{
	type = 'toggle',
	name = L["AloftMana"],
	desc = L["Display mana data, bars, and text on nameplates"],
	get = function() return AloftModules.db.profile.AloftMana end,
	set = function(v) AloftModules.db.profile.AloftMana = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
