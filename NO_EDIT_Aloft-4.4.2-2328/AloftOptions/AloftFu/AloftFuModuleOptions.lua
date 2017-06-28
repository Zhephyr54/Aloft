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

Aloft.Options.args.modules.args.aloftFu =
{
	type = 'toggle',
	width = "full",
	name = L["AloftFu"],
	desc = L["Provide a FuBar interface for Aloft"],
	get = function(i) return AloftModules.db.profile.AloftFu end,
	set = function(i, v) AloftModules.db.profile.AloftFu = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
