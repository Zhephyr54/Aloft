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

Aloft.Options.args.modules.args.aloftAlpha =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftAlpha"],
	desc = L["Control the relative transparency of nameplates"],
	get = function(i) return AloftModules.db.profile.AloftAlpha end,
	set = function(i, v) AloftModules.db.profile.AloftAlpha = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
