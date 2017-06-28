local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftPetOwnersNameTextOptions
if not L then return end

local AloftNameText = Aloft:GetModule("NameText", true)
if not AloftNameText then return end

local AloftPetOwnersNameData = Aloft:GetModule("PetOwnersNameData", true)
if not AloftPetOwnersNameData then return end

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

Aloft.Options.args.nameText.args.petOwnersName =
{
	type = 'select',
	width = 'full',
	name = L["Pet Owner's Names"],
	desc = L["Select how to show pet owner's names"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftNameText:IsEnabled() or not AloftPetOwnersNameData:IsEnabled() or not AloftNameText.db or not AloftNameText.db.profile or not AloftNameText.db.profile.enable end,
	get = function(i) return AloftNameText.db.profile.petOwnersName or "NONE" end,
	set = function(i, v) AloftNameText.db.profile.petOwnersName = v AloftNameText:UpdateFormatTag() Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
	values = { NONE = L["NONE"], HYPHEN = L["HYPHEN"], SLASH = L["SLASH"], BRACKET = L["BRACKET"], COLON = L["COLON"] },
}

-----------------------------------------------------------------------------

local function NameTextTagModifier()
	AloftNameText.db.profile.format = AloftNameText.db.profile.format..attachFormats[AloftNameText.db.profile.petOwnersName or "NONE"]
end

AloftNameText:RegisterFormatTagModifier(2, NameTextTagModifier)

-----------------------------------------------------------------------------

end)
