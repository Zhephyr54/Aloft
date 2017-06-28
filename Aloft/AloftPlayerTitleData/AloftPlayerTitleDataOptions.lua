local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

local AloftPlayerTitleData = Aloft:GetModule("PlayerTitleData")
local L = AceLibrary("AceLocale-2.2"):new("AloftPlayerTitleDataOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.playerTitle =
{
	type = 'toggle',
	name = L["Save Player Title Data"],
	desc = L["Stores player title information between sessions"],
	get = function() return AloftPlayerTitleData.db.profile.save end,
	set = AloftPlayerTitleData.SetSaveData
}

-----------------------------------------------------------------------------

end)
