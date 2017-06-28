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

Aloft.Options.args.modules.args.AloftLDB =
{
	type = 'toggle',
	width = "full",
	name = L["AloftLDB"],
	desc = L["Provide a LibDataBroker-1.1 interface for Aloft"],
	get = function(i) return AloftModules.db.profile.AloftLDB end,
	set = function(i, v) AloftModules.db.profile.AloftLDB = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
