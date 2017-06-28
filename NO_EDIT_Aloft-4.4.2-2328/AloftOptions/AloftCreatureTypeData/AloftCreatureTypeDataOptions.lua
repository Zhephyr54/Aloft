local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftCreatureTypeDataOptions
if not L then return end

local AloftCreatureTypeData = Aloft:GetModule("CreatureTypeData", true)
if not AloftCreatureTypeData then return end

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.creatureType =
{
	type = 'toggle',
	width = 'full',
	name = L["Save Creature Type Data"],
	desc = L["Stores creature type information between sessions"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCreatureTypeData:IsEnabled() or not AloftCreatureTypeData.db or not AloftCreatureTypeData.db.profile end,
	get = function(i) return AloftCreatureTypeData.db.profile.save end,
	set = AloftCreatureTypeData.SetSaveData
}

-----------------------------------------------------------------------------
