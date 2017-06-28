local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

Aloft.Options.args.modules.args.aloftPetOwnersName =
{
	type = 'toggle',
	name = L["AloftPetOwnersName"],
	desc = L["Gather and display pet owner's names on nameplates"],
	get = function() return AloftModules.db.profile.AloftPetOwnersName end,
	set = function(v) AloftModules.db.profile.AloftPetOwnersName = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
