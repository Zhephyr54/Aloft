local Aloft = Aloft
if not Aloft or not Aloft:HasModule("ClassificationData") then return end

-----------------------------------------------------------------------------

local AloftClassificationData = Aloft:GetModule("ClassificationData")
local L = AceLibrary("AceLocale-2.2"):new("AloftClassificationDataOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.classification =
{
	type = 'toggle',
	name = L["Save Classification Data"],
	desc = L["Stores unit classification information between sessions"],
	get = function() return AloftClassificationData.db.profile.save end,
	set = AloftClassificationData.SetSaveData
}

-----------------------------------------------------------------------------
