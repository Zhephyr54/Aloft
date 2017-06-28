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

Aloft.Options.args.modules.args.aloftVisibility =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftVisibility"],
	desc = L["Control the visibility of various types of nameplates"],
	get = function(i) return AloftModules.db.profile.AloftVisibility end,
	set = function(i, v) AloftModules.db.profile.AloftVisibility = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
