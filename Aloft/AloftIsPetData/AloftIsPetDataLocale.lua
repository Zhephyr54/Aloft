local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftIsPetDataOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Save Pet Data"] = true,
	--[[ enUS ]] ["Stores pet information between sessions"] = true,
	
	--[[ enUS ]] ["Unknown"] = true, -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Save Pet Data"] = "소환수 데이터 저장",
	--[[ koKR ]] ["Stores pet information between sessions"] = "접속 간 소환수 정보를 저장합니다.",

	--[[ koKR ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Save Pet Data"] = "Записать данные о питомцах",
	--[[ ruRU ]] ["Stores pet information between sessions"] = "Сохранять данные о питомцах между сессиями",

	--[[ ruRU ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Save Pet Data"] = "储存宠物信息",
	--[[ zhCN ]] ["Stores pet information between sessions"] = "在两次登录的间隔储存宠物信息",

	--[[ zhCN ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Save Pet Data"] = "儲存寵物資料",
	--[[ zhTW ]] ["Stores pet information between sessions"] = "儲存寵物資料",

	--[[ zhTW ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

end
