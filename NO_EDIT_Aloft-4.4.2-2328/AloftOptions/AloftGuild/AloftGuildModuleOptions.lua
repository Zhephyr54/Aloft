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

Aloft.Options.args.modules.args.aloftGuild =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftGuild"],
	desc = L["Gather and display player guild names on nameplates"],
	get = function(i) return AloftModules.db.profile.AloftGuild end,
	set = function(i, v) AloftModules.db.profile.AloftGuild = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
