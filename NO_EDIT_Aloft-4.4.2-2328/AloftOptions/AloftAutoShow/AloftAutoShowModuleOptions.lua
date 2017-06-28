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

Aloft.Options.args.modules.args.aloftAutoShow =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftAutoShow"],
	desc = L["Automatically show/hide nameplates based on various events and conditions"],
	get = function(i) return AloftModules.db.profile.AloftAutoShow end,
	set = function(i, v) AloftModules.db.profile.AloftAutoShow = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
