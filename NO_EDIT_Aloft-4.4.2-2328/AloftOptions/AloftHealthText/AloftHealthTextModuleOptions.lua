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

Aloft.Options.args.modules.args.aloftHealthText =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftHealthText"],
	desc = L["Display health data and text on nameplates"],
	get = function(i) return AloftModules.db.profile.AloftHealthText end,
	set = function(i, v) AloftModules.db.profile.AloftHealthText = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
