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

Aloft.Options.args.modules.args.aloftTarget =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftTarget"],
	desc = L["Display target name and group target count on nameplates"],
	get = function(i) return AloftModules.db.profile.AloftTarget end,
	set = function(i, v) AloftModules.db.profile.AloftTarget = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
