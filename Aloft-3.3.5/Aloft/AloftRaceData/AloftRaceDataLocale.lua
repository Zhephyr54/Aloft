local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local dL = AceLibrary("AceLocale-2.2"):new("AloftRaceData")

-----------------------------------------------------------------------------

dL:RegisterTranslations("enUS", function() return {
	-- short forms
	--[[ enUS ]] ["Blood Elf"]	= "BE",
	--[[ enUS ]] ["Draenei"]		= "Dr",
	--[[ enUS ]] ["Dwarf"]		= "Dw",
	--[[ enUS ]] ["Gnome"]		= "Gn",
	--[[ enUS ]] ["Human"]		= "Hu",
	--[[ enUS ]] ["Night Elf"]	= "NE",
	--[[ enUS ]] ["Orc"]			= "Or",
	--[[ enUS ]] ["Tauren"]		= "Ta",
	--[[ enUS ]] ["Troll"]		= "Tr",
	--[[ enUS ]] ["Undead"]		= "Ud",

	--[[ enUS ]] ["Unknown"] = true, -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

local oL = AceLibrary("AceLocale-2.2"):new("AloftRaceDataOptions")

-----------------------------------------------------------------------------

oL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Save Race Data"] = true,
	--[[ enUS ]] ["Stores race information between sessions"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

dL:RegisterTranslations("koKR", function() return {
	-- short forms
	--[[ koKR ]] ["Blood Elf"]	= "블엘",
	--[[ koKR ]] ["Draenei"]	= "드레",
	--[[ koKR ]] ["Dwarf"]		= "드웦",
	--[[ koKR ]] ["Gnome"]		= "놈",
	--[[ koKR ]] ["Human"]		= "인간",
	--[[ koKR ]] ["Night Elf"]	= "나엘",
	--[[ koKR ]] ["Orc"]		= "오크",
	--[[ koKR ]] ["Tauren"]		= "타렌",
	--[[ koKR ]] ["Troll"]		= "트롤",
	--[[ koKR ]] ["Undead"]		= "언데",

	--[[ koKR ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Save Race Data"] = "종족 데이터 저장",
	--[[ koKR ]] ["Stores race information between sessions"] = "접속 간 종족 정보를 저장합니다.",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

dL:RegisterTranslations("ruRU", function() return {
	-- short forms
	--[[ ruRU ]] ["Blood Elf"]	= "ЭК",
	--[[ ruRU ]] ["Draenei"]	= "Др",
	--[[ ruRU ]] ["Dwarf"]		= "Дв",
	--[[ ruRU ]] ["Gnome"]		= "Гн",
	--[[ ruRU ]] ["Human"]		= "Че",
	--[[ ruRU ]] ["Night Elf"]	= "НЭ",
	--[[ ruRU ]] ["Orc"]		= "Ор",
	--[[ ruRU ]] ["Tauren"]		= "Та",
	--[[ ruRU ]] ["Troll"]		= "Тр",
	--[[ ruRU ]] ["Undead"]		= "Не",

	--[[ ruRU ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

	--[[ ruRU ]] --["Blood Elf"]	= "Эльф крови",
	--[[ ruRU ]] --["Draenei"]	= "Дреней",
	--[[ ruRU ]] --["Dwarf"]	= "Дворф",
	--[[ ruRU ]] --["Gnome"]	= "Гном",
	--[[ ruRU ]] --["Human"]	= "Человек",
	--[[ ruRU ]] --["Night Elf"]	= "Ночной эльф",
	--[[ ruRU ]] --["Orc"]		= "Орк",
	--[[ ruRU ]] --["Tauren"]	= "Таурен",
	--[[ ruRU ]] --["Troll"]		= "Тролль",
	--[[ ruRU ]] --["Undead"]	= "Нежить",

-----------------------------------------------------------------------------

oL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Save Race Data"] = "Записать данные о расах",
	--[[ ruRU ]] ["Stores race information between sessions"] = "Сохранять данные о расе между сессиями",
} end)
	
-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhCN", function() return {
	-- short forms
	--[[ zhCN ]] ["Blood Elf"]	= "血精灵",
	--[[ zhCN ]] ["Draenei"]	= "德莱尼",
	--[[ zhCN ]] ["Dwarf"]		= "矮人",
	--[[ zhCN ]] ["Gnome"]		= "侏儒",
	--[[ zhCN ]] ["Human"]		= "人类",
	--[[ zhCN ]] ["Night Elf"]	= "夜精灵",
	--[[ zhCN ]] ["Orc"]		= "兽人",
	--[[ zhCN ]] ["Tauren"]		= "牛头",
	--[[ zhCN ]] ["Troll"]		= "巨魔",
	--[[ zhCN ]] ["Undead"]		= "亡灵",

	--[[ zhCN ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Save Race Data"] = "储存种族信息",
	--[[ zhCN ]] ["Stores race information between sessions"] = "在两次登录的间隔储存种族信息",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhTW", function() return {
	-- short forms
	--[[ zhTW ]] ["Blood Elf"]	= "血",
	--[[ zhTW ]] ["Draenei"]	= "萊",
	--[[ zhTW ]] ["Dwarf"]		= "矮",
	--[[ zhTW ]] ["Gnome"]		= "地",
	--[[ zhTW ]] ["Human"]		= "人",
	--[[ zhTW ]] ["Night Elf"]	= "夜",
	--[[ zhTW ]] ["Orc"]		= "獸",
	--[[ zhTW ]] ["Tauren"]	= "牛",
	--[[ zhTW ]] ["Troll"]		= "食",
	--[[ zhTW ]] ["Undead"]	= "不",

	--[[ zhTW ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Save Race Data"] = "儲存種族資料",
	--[[ zhTW ]] ["Stores race information between sessions"] = "儲存種族資料",
} end)

-----------------------------------------------------------------------------

end
