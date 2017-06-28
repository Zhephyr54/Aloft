local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftClassificationDataOptions
if not L then return end

local AloftClassificationData = Aloft:GetModule("ClassificationData", true)
if not AloftClassificationData then return end

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.classification =
{
	type = 'toggle',
	width = 'full',
	name = L["Save Classification Data"],
	desc = L["Stores unit classification information between sessions"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftClassificationData:IsEnabled() or not AloftClassificationData.db or not AloftClassificationData.db.profile end,
	get = function(i) return AloftClassificationData.db.profile.save end,
	set = AloftClassificationData.SetSaveData
}

-----------------------------------------------------------------------------
