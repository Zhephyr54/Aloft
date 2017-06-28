local Aloft = Aloft
if not Aloft or not Aloft:HasModule("RaceData") then return end

-----------------------------------------------------------------------------

local AloftRaceData = Aloft:GetModule("RaceData")
local L = AceLibrary("AceLocale-2.2"):new("AloftRaceDataOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.race =
{
	type = 'toggle',
	name = L["Save Race Data"],
	desc = L["Stores race information between sessions"],
	get = function() return AloftRaceData.db.profile.save end,
	set = AloftRaceData.SetSaveData
}

-----------------------------------------------------------------------------
