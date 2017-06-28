local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFaction", function()

local L = AloftLocale.AloftFactionDataOptions
if not L then return end

local AloftFactionData = Aloft:GetModule("FactionData", true)
if not AloftFactionData then return end

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.faction =
{
	type = 'toggle',
	width = 'full',
	name = L["Save Faction Data"],
	desc = L["Stores faction data between sessions"],
	get = function(i) return AloftFactionData.db.profile.save end,
	set = AloftFactionData.SetSaveData,
}

-----------------------------------------------------------------------------

end)
