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

Aloft.Options.args.modules.args.aloftPresets =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftPresets"],
	desc = L["Enable access to preset configurations"],
	get = function(i) return AloftModules.db.profile.AloftPresets end,
	set = function(i, v) AloftModules.db.profile.AloftPresets = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
