local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local dL = AceLibrary("AceLocale-2.2"):new("AloftClassificationData")

-----------------------------------------------------------------------------

dL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["rare"]		= "Rare",
	--[[ enUS ]] ["elite"]		= "Elite",
	--[[ enUS ]] ["rareelite"]	= "Rare-Elite",
	--[[ enUS ]] ["worldboss"]	= "Boss",

	--[[ enUS ]] ["shortrare"]		= "r",
	--[[ enUS ]] ["shortelite"]		= "+",
	--[[ enUS ]] ["shortrareelite"]	= "r+",
	--[[ enUS ]] ["shortworldboss"]	= "b",

	--[[ enUS ]] ["Unknown"] = true, -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

local oL = AceLibrary("AceLocale-2.2"):new("AloftClassificationDataOptions")

-----------------------------------------------------------------------------

oL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Save Classification Data"] = true,
	--[[ enUS ]] ["Stores unit classification information between sessions"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

dL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["rare"]		= "희귀",
	--[[ koKR ]] ["elite"]		= "정예",
	--[[ koKR ]] ["rareelite"]	= "희귀-정예",
	--[[ koKR ]] ["worldboss"]	= "보스",

	--[[ koKR ]] ["shortrare"]		= "r",
	--[[ koKR ]] ["shortelite"]		= "+",
	--[[ koKR ]] ["shortrareelite"]	= "r+",
	--[[ koKR ]] ["shortworldboss"]	= "b",

	--[[ koKR ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Save Classification Data"] = "구분 데이터 저장",
	--[[ koKR ]] ["Stores unit classification information between sessions"] = "각 접속간 대상의 구분 정보를 저장합니다.",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

dL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["rare"]		= "Редкий",
	--[[ ruRU ]] ["elite"]		= "Элита",
	--[[ ruRU ]] ["rareelite"]	= "Редкий-Элита",
	--[[ ruRU ]] ["worldboss"]	= "Босс",

	--[[ ruRU ]] ["shortrare"]		= "р",
	--[[ ruRU ]] ["shortelite"]		= "+",
	--[[ ruRU ]] ["shortrareelite"]	= "р+",
	--[[ ruRU ]] ["shortworldboss"]	= "б",

	--[[ ruRU ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Save Classification Data"] = "Записать данные о классификации",
	--[[ ruRU ]] ["Stores unit classification information between sessions"] = "Сохранять данные по классификации объектов между сессиями",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["rare"]		= "稀有",
	--[[ zhCN ]] ["elite"]		= "精英",
	--[[ zhCN ]] ["rareelite"]	= "稀有精英",
	--[[ zhCN ]] ["worldboss"]	= "首领",

	--[[ zhCN ]] ["shortrare"]		= "-",
	--[[ zhCN ]] ["shortelite"]		= "+",
	--[[ zhCN ]] ["shortrareelite"]	= "++",
	--[[ zhCN ]] ["shortworldboss"]	= "boss",

	--[[ zhCN ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Save Classification Data"] = "储存分类信息",
	--[[ zhCN ]] ["Stores unit classification information between sessions"] = "在两次登录的间隔储存分类信息",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["rare"]		= "稀有",
	--[[ zhTW ]] ["elite"]		= "精英",
	--[[ zhTW ]] ["rareelite"]	= "稀有-精英",
	--[[ zhTW ]] ["worldboss"]	= "首領",

	--[[ zhTW ]] ["shortrare"]			= "稀",
	--[[ zhTW ]] ["shortelite"]		= "+",
	--[[ zhTW ]] ["shortrareelite"]	= "稀+",
	--[[ zhTW ]] ["shortworldboss"]	= "首",

	--[[ zhTW ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Save Classification Data"] = "儲存分類資料",
	--[[ zhTW ]] ["Stores unit classification information between sessions"] = "儲存分類資料",
} end)

-----------------------------------------------------------------------------

end
