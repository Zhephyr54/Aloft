local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftClassDataOptions
if not L then return end

local AloftClassData = Aloft:GetModule("ClassData")
if not AloftClassData then return  end

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.class =
{
	type = 'toggle',
	width = 'full',
	name = L["Save Class Data"],
	desc = L["Stores player class information between sessions"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftClassData:IsEnabled() or not AloftClassData.db or not AloftClassData.db.profile end,
	get = function(i) return AloftClassData.db.profile.save end,
	set = AloftClassData.SetSaveData
}

-----------------------------------------------------------------------------
