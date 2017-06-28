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

Aloft.Options.args.modules.args.aloftFaction =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftFaction"],
	desc = L["Gather faction data"],
	get = function(i) return AloftModules.db.profile.AloftFaction end,
	set = function(i, v) AloftModules.db.profile.AloftFaction = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
