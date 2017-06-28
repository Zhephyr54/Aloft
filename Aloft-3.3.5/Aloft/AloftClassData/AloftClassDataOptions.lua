local Aloft = Aloft
if not Aloft or not Aloft:HasModule("ClassData") then return end

-----------------------------------------------------------------------------

local AloftClassData = Aloft:GetModule("ClassData")
local L = AceLibrary("AceLocale-2.2"):new("AloftClassDataOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.class =
{
	type = 'toggle',
	name = L["Save Class Data"],
	desc = L["Stores player class information between sessions"],
	get = function() return AloftClassData.db.profile.save end,
	set = AloftClassData.SetSaveData
}

-----------------------------------------------------------------------------
