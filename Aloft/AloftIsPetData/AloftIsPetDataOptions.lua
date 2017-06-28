local Aloft = Aloft
if not Aloft or not Aloft:HasModule("IsPetData") then return end

-----------------------------------------------------------------------------

local AloftIsPetData = Aloft:GetModule("IsPetData")
local L = AceLibrary("AceLocale-2.2"):new("AloftIsPetDataOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.pet =
{
	type = 'toggle',
	name = L["Save Pet Data"],
	desc = L["Stores pet information between sessions"],
	get = function() return AloftIsPetData.db.profile.save end,
	set = AloftIsPetData.SetSaveData
}

-----------------------------------------------------------------------------
