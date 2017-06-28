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

Aloft.Options.args.modules.args.aloftComment =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftComment"],
	desc = L["Gather and display comment text on nameplates"],
	get = function(i) return AloftModules.db.profile.AloftComment end,
	set = function(i, v) AloftModules.db.profile.AloftComment = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
