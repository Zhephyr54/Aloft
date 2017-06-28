local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftBanzai =
{
	type = 'toggle',
	name = L["AloftBanzai"],
	desc = L["Uses LibBanzai to hightlight group member nameplates that have aggro"],
	get = function() return AloftModules.db.profile.AloftBanzai end,
	set = function(v) AloftModules.db.profile.AloftBanzai = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
