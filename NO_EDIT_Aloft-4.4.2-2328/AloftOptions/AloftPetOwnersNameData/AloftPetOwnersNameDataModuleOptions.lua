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

Aloft.Options.args.modules.args.aloftPetOwnersName =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftPetOwnersName"],
	desc = L["Gather and display pet owner's names on nameplates"],
	get = function(i) return AloftModules.db.profile.AloftPetOwnersName end,
	set = function(i, v) AloftModules.db.profile.AloftPetOwnersName = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
