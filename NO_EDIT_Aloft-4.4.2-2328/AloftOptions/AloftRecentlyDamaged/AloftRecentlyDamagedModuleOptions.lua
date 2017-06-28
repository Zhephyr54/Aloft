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

Aloft.Options.args.modules.args.aloftRecentlyDamaged =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftRecentlyDamaged"],
	desc = L["Display recently damaged icon on nameplates"],
	get = function(i) return AloftModules.db.profile.AloftRecentlyDamaged end,
	set = function(i, v) AloftModules.db.profile.AloftRecentlyDamaged = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
