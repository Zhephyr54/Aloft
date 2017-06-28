local Aloft = Aloft
if not Aloft or not Aloft:HasModule("CreatureTypeData") then return end

-----------------------------------------------------------------------------

local AloftCreatureTypeData = Aloft:GetModule("CreatureTypeData")
local L = AceLibrary("AceLocale-2.2"):new("AloftCreatureTypeDataOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.creatureType =
{
	type = 'toggle',
	name = L["Save Creature Type Data"],
	desc = L["Stores creature type information between sessions"],
	get = function() return AloftCreatureTypeData.db.profile.save end,
	set = AloftCreatureTypeData.SetSaveData
}

-----------------------------------------------------------------------------
