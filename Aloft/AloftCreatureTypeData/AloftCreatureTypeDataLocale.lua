local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local dL = AceLibrary("AceLocale-2.2"):new("AloftCreatureTypeData")

-----------------------------------------------------------------------------

-- this has some obsolete values in it, pending some documentation
dL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Beast"]			= true,
	--[[ enUS ]] ["Critter"]		= true,
	--[[ enUS ]] ["Demon"]			= true,
	--[[ enUS ]] ["Dragonkin"]		= true,
	--[[ enUS ]] ["Elemental"]		= true,
	--[[ enUS ]] ["Giant"]			= true,
	--[[ enUS ]] ["Humanoid"]		= true,
	--[[ enUS ]] ["Mechanical"]		= true,
	--[[ enUS ]] ["Undead"]			= true,

	-- This is checked against when we gather data. If it's not specified, don't store it.
	--[[ enUS ]] ["Not specified"]	= true,
	--[[ enUS ]] ["Non-combat Pet"]	= true,

	-- short forms
	--[[ enUS ]] ["ShortBeast"]		= "B",
	--[[ enUS ]] ["ShortCritter"]	= "c",
	--[[ enUS ]] ["ShortDemon"]		= "D",
	--[[ enUS ]] ["ShortDragonkin"]	= "K",
	--[[ enUS ]] ["ShortElemental"]	= "E",
	--[[ enUS ]] ["ShortGiant"]		= "G",
	--[[ enUS ]] ["ShortHumanoid"]	= "H",
	--[[ enUS ]] ["ShortMechanical"]	= "E",
	--[[ enUS ]] ["ShortUndead"]	= "U",
	
	--[[ enUS ]] ["Unknown"] = true, -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

local oL = AceLibrary("AceLocale-2.2"):new("AloftCreatureTypeDataOptions")

-----------------------------------------------------------------------------

oL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Save Creature Type Data"] = true,
	--[[ enUS ]] ["Stores creature type information between sessions"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

-- this has some obsolete values in it, pending some documentation
dL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Beast"]			= "야수",
	--[[ koKR ]] ["Critter"]			= "동물",
	--[[ koKR ]] ["Demon"]			= "악마형",
	--[[ koKR ]] ["Dragonkin"]		= "용족",
	--[[ koKR ]] ["Elemental"]		= "정령",
	--[[ koKR ]] ["Giant"]			= "거인",
	--[[ koKR ]] ["Humanoid"]		= "인간형",
	--[[ koKR ]] ["Mechanical"]		= "기계",
	--[[ koKR ]] ["Undead"]			= "언데드",

	-- This is checked against when we gather data. If it's not specified, don't store it.
	--[[ koKR ]] ["Not specified"]	= "정보 없음",
	--[[ koKR ]] ["Non-combat Pet"]	= "Non-combat Pet",

	-- short forms
	--[[ koKR ]] ["ShortBeast"]		= "야수",
	--[[ koKR ]] ["ShortCritter"]	= "동물",
	--[[ koKR ]] ["ShortDemon"]		= "악마형",
	--[[ koKR ]] ["ShortDragonkin"]	= "용족",
	--[[ koKR ]] ["ShortElemental"]	= "정령",
	--[[ koKR ]] ["ShortGiant"]		= "거인",
	--[[ koKR ]] ["ShortHumanoid"]	= "인간형",
	--[[ koKR ]] ["ShortMechanical"]	= "기계",
	--[[ koKR ]] ["ShortUndead"]		= "언데드",

	--[[ koKR ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Save Creature Type Data"] = "몹 종류 데이터를 저장합니다.",
	--[[ koKR ]] ["Stores creature type information between sessions"] = "접속 간 몹 종류 정보를 저장합니다.",
} end)

-----------------------------------------------------------------------------

elseif (GetLocale() == "ruRU") then

-----------------------------------------------------------------------------

-- this has some obsolete values in it, pending some documentation
dL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Beast"]			= "Животное",
	--[[ ruRU ]] ["Critter"]			= "Существо",
	--[[ ruRU ]] ["Demon"]			= "Демон",
	--[[ ruRU ]] ["Dragonkin"]		= "Дракон",
	--[[ ruRU ]] ["Elemental"]		= "Элементаль",
	--[[ ruRU ]] ["Giant"]			= "Великан",
	--[[ ruRU ]] ["Humanoid"]		= "Гуманоид",
	--[[ ruRU ]] ["Mechanical"]		= "Механизм",
	--[[ ruRU ]] ["Undead"]			= "Нежить",

	-- This is checked against when we gather data. If it's not specified, don't store it.
	--[[ ruRU ]] ["Not specified"]	= "Не указано",
	--[[ ruRU ]] ["Non-combat Pet"] = "Не боевой питомец",

	-- short forms
	--[[ ruRU ]] ["ShortBeast"]		= "Жв",
	--[[ ruRU ]] ["ShortCritter"]	= "C",
	--[[ ruRU ]] ["ShortDemon"]		= "Де",
	--[[ ruRU ]] ["ShortDragonkin"]	= "Др",
	--[[ ruRU ]] ["ShortElemental"]	= "Э",
	--[[ ruRU ]] ["ShortGiant"]		= "В",
	--[[ ruRU ]] ["ShortHumanoid"]	= "Г",
	--[[ ruRU ]] ["ShortMechanical"]	= "М",
	--[[ ruRU ]] ["ShortUndead"]	= "Н",

	--[[ ruRU ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Save Creature Type Data"] = "Записать данные о типах существ",
	--[[ ruRU ]] ["Stores creature type information between sessions"] = "Сохранять данные о типах существ между сессиями",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

-- this has some obsolete values in it, pending some documentation
dL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Beast"]			= "野兽",
	--[[ zhCN ]] ["Critter"]			= "小动物",
	--[[ zhCN ]] ["Demon"]			= "恶魔",
	--[[ zhCN ]] ["Dragonkin"]		= "龙类",
	--[[ zhCN ]] ["Giant"]			= "巨人",
	--[[ zhCN ]] ["Humanoid"]		= "人型生物",
	--[[ zhCN ]] ["Elemental"]		= "元素生物",
	--[[ zhCN ]] ["Mechanical"]		= "机械",
	--[[ zhCN ]] ["Undead"]			= "亡灵",

	-- This is checked against when we gather data. If it's not specified, don't store it.
	--[[ zhCN ]] ["Not specified"]	= "未指定",
	--[[ zhCN ]] ["Non-combat Pet"]	= "非战斗宠物",

	-- short forms
	--[[ zhCN ]] ["ShortBeast"]		= "野兽",
	--[[ zhCN ]] ["ShortCritter"]	= "小",
	--[[ zhCN ]] ["ShortDemon"]		= "恶",
	--[[ zhCN ]] ["ShortElemental"]	= "元",
	--[[ zhCN ]] ["ShortDragonkin"]	= "龙",
	--[[ zhCN ]] ["Giant"]			= "巨",
	--[[ zhCN ]] ["ShortHumanoid"]	= "人",
	--[[ zhCN ]] ["Mechanical"]		= "机",
	--[[ zhCN ]] ["ShortUndead"]	= "亡",

	--[[ zhCN ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Save Creature Type Data"] = "保存生物类型资料",
	--[[ zhCN ]] ["Stores creature type information between sessions"] = "在每次连接之间保存生物类型数据",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

-- this has some obsolete values in it, pending some documentation
dL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Beast"]			= "野獸",
	--[[ zhTW ]] ["Critter"]		= "小動物",
	--[[ zhTW ]] ["Demon"]			= "惡魔",
	--[[ zhTW ]] ["Dragonkin"]		= "龍類",
	--[[ zhTW ]] ["Elemental"]		= "元素生物",
	--[[ zhTW ]] ["Giant"]			= "巨人",
	--[[ zhTW ]] ["Humanoid"]		= "人型生物",
	--[[ zhTW ]] ["Mechanical"]	= "機械",
	--[[ zhTW ]] ["Undead"]		= "不死族",

	-- This is checked against when we gather data. If it's not specified, don't store it.
	--[[ zhTW ]] ["Not specified"]	= "未指定",
	--[[ zhTW ]] ["Non-combat Pet"]	= "非戰斗寵物",

	-- short forms
	--[[ zhTW ]] ["ShortBeast"]		= "野",
	--[[ zhTW ]] ["ShortCritter"]	= "小",
	--[[ zhTW ]] ["ShortDemon"]		= "惡",
	--[[ zhTW ]] ["ShortDragonkin"]	= "龍",
	--[[ zhTW ]] ["ShortElemental"]	= "元",
	--[[ zhTW ]] ["Giant"]			= "巨",
	--[[ zhTW ]] ["ShortHumanoid"]	= "人",
	--[[ zhTW ]] ["ShortUndead"]		= "死",
	--[[ zhTW ]] ["Mechanical"]		= "機",

	--[[ zhTW ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Save Creature Type Data"] = "存儲生物類別訊息",
	--[[ zhTW ]] ["Stores creature type information between sessions"] = "在兩次登錄間隔儲存生物類型信息",
} end)

-----------------------------------------------------------------------------

end
