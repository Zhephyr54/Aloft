local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftPlayerTitleDataOptions
if not L then return end

local AloftPlayerTitleData = Aloft:GetModule("PlayerTitleData", true)
if not AloftPlayerTitleData then return end

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.playerTitle =
{
	type = 'toggle',
	width = 'full',
	name = L["Save Player Title Data"],
	desc = L["Stores player title information between sessions"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftPlayerTitleData:IsEnabled() or not AloftPlayerTitleData.db or not AloftPlayerTitleData.db.profile end,
	get = function(i) return AloftPlayerTitleData.db.profile.save end,
	set = AloftPlayerTitleData.SetSaveData
}

-----------------------------------------------------------------------------

end)
