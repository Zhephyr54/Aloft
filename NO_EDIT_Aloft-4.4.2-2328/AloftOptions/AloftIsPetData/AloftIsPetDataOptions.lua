local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftIsPetDataOptions
if not L then return end

local AloftIsPetData = Aloft:GetModule("IsPetData")
if not AloftIsPetData then return end

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.pet =
{
	type = 'toggle',
	width = 'full',
	name = L["Save Pet Data"],
	desc = L["Stores pet information between sessions"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftIsPetData:IsEnabled() or not AloftIsPetData.db or not AloftIsPetData.db.profile end,
	get = function(i) return AloftIsPetData.db.profile.save end,
	set = AloftIsPetData.SetSaveData
}

-----------------------------------------------------------------------------
