local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local dL = AceLibrary("AceLocale-2.2"):new("AloftPetOwnersNameData")

-----------------------------------------------------------------------------

local tL = AceLibrary("AceLocale-2.2"):new("AloftPetOwnersNameTextOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["PetTest"] = "(.*)'s Pet",
	--[[ enUS ]] ["MinionTest"] = "(.*)'s Minion",
	
	--[[ enUS ]] ["Unknown"] = true, -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Pet Owner's Names"] = true,
	--[[ enUS ]] ["Select how to show pet owner's names"] = true,

	--[[ enUS ]] ["NONE"]	= "None",
	--[[ enUS ]] ["HYPHEN"]	= "Pet - Owner",
	--[[ enUS ]] ["SLASH"]	= "Pet / Owner",
	--[[ enUS ]] ["BRACKET"]	= "Pet (Owner)",
	--[[ enUS ]] ["COLON"]	= "Pet : Owner",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["PetTest"] = "(.*)의 소환수",
	--[[ koKR ]] ["MinionTest"] = "(.*)의 하수인",

	--[[ koKR ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Pet Owner's Names"] = "소환수 소유자명",
	--[[ koKR ]] ["Select how to show pet owner's names"] = "소솬수 소유자명의 표시 방법을 선택합니다.",

	--[[ koKR ]] ["NONE"]	= "없음",
	--[[ koKR ]] ["HYPHEN"]	= "소환수 - 소유자",
	--[[ koKR ]] ["SLASH"]	= "소환수 / 소유자",
	--[[ koKR ]] ["BRACKET"]	= "소환수 (소유자)",
	--[[ koKR ]] ["COLON"]	= "소환수 : 소유자",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["PetTest"] = "Питомец |3-3((.*))",
	--[[ ruRU ]] ["MinionTest"] = "Прислужник |3-3((.*))",

	--[[ ruRU ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Select how to show pet owner's names"] = "Выбрать, как отображать имена владельцев питомцев",
	--[[ ruRU ]] ["Pet Owner's Names"] = "Имена владельцев питомцев",

	--[[ ruRU ]] ["NONE"]	= "Нету",
	--[[ ruRU ]] ["HYPHEN"]	= "Питомец - Хозяин",
	--[[ ruRU ]] ["SLASH"]	= "Питомец / Хозяин",
	--[[ ruRU ]] ["BRACKET"]	= "Питомец (Хозяин)",
	--[[ ruRU ]] ["COLON"]	= "Питомец : Хозяин",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["PetTest"] = "(.*)的宠物",
	--[[ zhCN ]] ["MinionTest"] = "(.*)的仆从",

	--[[ zhCN ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Pet Owner's Names"] = "宠物主人名称",
	--[[ zhCN ]] ["Select how to show pet owner's names"] = "设定宠物主人名称的显示方式",

	--[[ zhCN ]] ["NONE"]	= "无",
	--[[ zhCN ]] ["HYPHEN"]	= "宠物名 - 主人名",
	--[[ zhCN ]] ["SLASH"]	= "宠物名 / 主人名",
	--[[ zhCN ]] ["BRACKET"]	= "宠物名（主人名）",
	--[[ zhCN ]] ["COLON"]	= "宠物名 : 主人名",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["PetTest"] = "(.*)的寵物",
	--[[ zhTW ]] ["MinionTest"] = "(.*)的僕從",

	--[[ zhTW ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Pet Owner's Names"] = "寵物主人的名字",
	--[[ zhTW ]] ["Select how to show pet owner's names"] = "選擇怎樣顯示寵物主人的名字",

	--[[ zhTW ]] ["NONE"]	= "無",
	--[[ zhTW ]] ["HYPHEN"]	= "寵物 - 主人",
	--[[ zhTW ]] ["SLASH"]	= "寵物 / 主人",
	--[[ zhTW ]] ["BRACKET"]	= "寵物 (主人)",
	--[[ zhTW ]] ["COLON"]	= "寵物 : 主人",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
