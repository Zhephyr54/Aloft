local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftRaceDataOptions
if not L then return end

local AloftRaceData = Aloft:GetModule("RaceData", true)
if not AloftRaceData then return end

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.race =
{
	type = 'toggle',
	width = 'full',
	name = L["Save Race Data"],
	desc = L["Stores race information between sessions"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftRaceData:IsEnabled() or not AloftRaceData.db or not AloftRaceData.db.profile end,
	get = function(i) return AloftRaceData.db.profile.save end,
	set = AloftRaceData.SetSaveData
}

-----------------------------------------------------------------------------
