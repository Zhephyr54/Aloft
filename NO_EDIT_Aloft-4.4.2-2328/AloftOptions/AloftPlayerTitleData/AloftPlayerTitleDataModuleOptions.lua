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

Aloft.Options.args.modules.args.aloftPlayerTitle =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftPlayerTitle"],
	desc = L["Gather and display player titles on nameplates"],
	get = function(i) return AloftModules.db.profile.AloftPlayerTitle end,
	set = function(i, v) AloftModules.db.profile.AloftPlayerTitle = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
