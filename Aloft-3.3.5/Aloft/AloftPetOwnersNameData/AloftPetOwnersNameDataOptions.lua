local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("NameText") then return end
if not Aloft:HasModule("PetOwnersNameData") then return end

local L = AceLibrary("AceLocale-2.2"):new("AloftPetOwnersNameTextOptions")

-----------------------------------------------------------------------------

local attachFormats =
{
	["NONE"]	= "",
	["HYPHEN"]	= "[PetOwnersName:Prefix(\" - \")]",
	["SLASH"]	= "[PetOwnersName:Prefix(\" / \")]",
	["BRACKET"]	= "[PetOwnersName:Surround(\" (\", \")\")]",
	["COLON"]	= "[PetOwnersName:Prefix(\" : \")]",
}

-----------------------------------------------------------------------------

local AloftNameText = Aloft:GetModule("NameText")

Aloft.Options.args.nameText.args.petOwnersName =
{
	type = 'text',
	name = L["Pet Owner's Names"],
	desc = L["Select how to show pet owner's names"],
	disabled = function() return not AloftNameText.db.profile.enable end,
	get = function() return AloftNameText.db.profile.petOwnersName or "NONE" end,
	set = function(v) AloftNameText.db.profile.petOwnersName = v AloftNameText:UpdateFormatTag() Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
	validate = { NONE = L["NONE"], HYPHEN = L["HYPHEN"], SLASH = L["SLASH"], BRACKET = L["BRACKET"], COLON = L["COLON"] },
}

-----------------------------------------------------------------------------

local function NameTextTagModifier()
	AloftNameText.db.profile.format = AloftNameText.db.profile.format..attachFormats[AloftNameText.db.profile.petOwnersName or "NONE"]
end

AloftNameText:RegisterFormatTagModifier(2, NameTextTagModifier)

-----------------------------------------------------------------------------

end)
