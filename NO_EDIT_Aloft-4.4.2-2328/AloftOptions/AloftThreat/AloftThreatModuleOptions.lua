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

Aloft.Options.args.modules.args.aloftThreat =
{
	type = 'toggle',
	name = L["AloftThreat"],
	desc = L["Display threat data, bars, and text on nameplates"],
	get = function(i) return AloftModules.db.profile.AloftThreat end,
	set = function(i, v) AloftModules.db.profile.AloftThreat = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
