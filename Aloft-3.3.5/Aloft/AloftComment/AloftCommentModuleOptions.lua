local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftComment =
{
	type = 'toggle',
	name = L["AloftComment"],
	desc = L["Gather and display text on nameplates"],
	get = function() return AloftModules.db.profile.AloftComment end,
	set = function(v) AloftModules.db.profile.AloftComment = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
