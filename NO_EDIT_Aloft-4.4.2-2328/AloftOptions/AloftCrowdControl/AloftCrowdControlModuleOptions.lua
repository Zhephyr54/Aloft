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

Aloft.Options.args.modules.args.aloftCrowdControl =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftCrowdControl"],
	desc = L["Display crowd control timers on nameplates when possible"],
	get = function(i) return AloftModules.db.profile.AloftCrowdControl end,
	set = function(i, v) AloftModules.db.profile.AloftCrowdControl = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
