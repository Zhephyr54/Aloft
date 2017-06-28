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

Aloft.Options.args.modules.args.aloftClassIcon =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftClassIcon"],
	desc = L["Display class icons on nameplates"],
	get = function(i) return AloftModules.db.profile.AloftClassIcon end,
	set = function(i, v) AloftModules.db.profile.AloftClassIcon = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
