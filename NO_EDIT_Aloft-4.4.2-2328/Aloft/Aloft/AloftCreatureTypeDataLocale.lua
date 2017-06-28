local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local dL = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

-- this has some obsolete values in it, pending some documentation
--[[ enUS ]] dL["Beast"]			= "Beast"
--[[ enUS ]] dL["Critter"]			= "Critter"
--[[ enUS ]] dL["Demon"]			= "Demon"
--[[ enUS ]] dL["Dragonkin"]		= "Dragonkin"
--[[ enUS ]] dL["Elemental"]		= "Elemental"
--[[ enUS ]] dL["Giant"]			= "Giant"
--[[ enUS ]] dL["Humanoid"]			= "Humanoid"
--[[ enUS ]] dL["Mechanical"]		= "Mechanical"
--[[ enUS ]] dL["Undead"]			= "Undead"

-- This is checked against when we gather data. If it's not specified, don't store it.
--[[ enUS ]] dL["Not specified"]	= "Not specified"
--[[ enUS ]] dL["Non-combat Pet"]	= "Non-combat Pet"

-- short forms
--[[ enUS ]] dL["ShortBeast"]		= "B"
--[[ enUS ]] dL["ShortCritter"]		= "c"
--[[ enUS ]] dL["ShortDemon"]		= "D"
--[[ enUS ]] dL["ShortDragonkin"]	= "K"
--[[ enUS ]] dL["ShortElemental"]	= "E"
--[[ enUS ]] dL["ShortGiant"]		= "G"
--[[ enUS ]] dL["ShortHumanoid"]	= "H"
--[[ enUS ]] dL["ShortMechanical"]	= "E"
--[[ enUS ]] dL["ShortUndead"]		= "U"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

-- this has some obsolete values in it, pending some documentation
--[[ koKR ]] dL["Beast"]			= "야수"
--[[ koKR ]] dL["Critter"]			= "동물"
--[[ koKR ]] dL["Demon"]			= "악마형"
--[[ koKR ]] dL["Dragonkin"]		= "용족"
--[[ koKR ]] dL["Elemental"]		= "정령"
--[[ koKR ]] dL["Giant"]			= "거인"
--[[ koKR ]] dL["Humanoid"]			= "인간형"
--[[ koKR ]] dL["Mechanical"]		= "기계"
--[[ koKR ]] dL["Undead"]			= "언데드"

-- This is checked against when we gather data. If it's not specified, don't store it.
--[[ koKR ]] dL["Not specified"]	= "정보 없음"
--[[ koKR ]] dL["Non-combat Pet"]	= "Non-combat Pet"

-- short forms
--[[ koKR ]] dL["ShortBeast"]		= "야수"
--[[ koKR ]] dL["ShortCritter"]		= "동물"
--[[ koKR ]] dL["ShortDemon"]		= "악마형"
--[[ koKR ]] dL["ShortDragonkin"]	= "용족"
--[[ koKR ]] dL["ShortElemental"]	= "정령"
--[[ koKR ]] dL["ShortGiant"]		= "거인"
--[[ koKR ]] dL["ShortHumanoid"]	= "인간형"
--[[ koKR ]] dL["ShortMechanical"]	= "기계"
--[[ koKR ]] dL["ShortUndead"]		= "언데드"

-----------------------------------------------------------------------------

elseif (GetLocale() == "ruRU") then

-----------------------------------------------------------------------------

-- this has some obsolete values in it, pending some documentation
--[[ ruRU ]] dL["Beast"]			= "Животное"
--[[ ruRU ]] dL["Critter"]			= "Существо"
--[[ ruRU ]] dL["Demon"]			= "Демон"
--[[ ruRU ]] dL["Dragonkin"]		= "Дракон"
--[[ ruRU ]] dL["Elemental"]		= "Элементаль"
--[[ ruRU ]] dL["Giant"]			= "Великан"
--[[ ruRU ]] dL["Humanoid"]			= "Гуманоид"
--[[ ruRU ]] dL["Mechanical"]		= "Механизм"
--[[ ruRU ]] dL["Undead"]			= "Нежить"

-- This is checked against when we gather data. If it's not specified, don't store it.
--[[ ruRU ]] dL["Not specified"]	= "Не указано"
--[[ ruRU ]] dL["Non-combat Pet"] 	= "Не боевой питомец"

-- short forms
--[[ ruRU ]] dL["ShortBeast"]		= "Жв"
--[[ ruRU ]] dL["ShortCritter"]		= "C"
--[[ ruRU ]] dL["ShortDemon"]		= "Де"
--[[ ruRU ]] dL["ShortDragonkin"]	= "Др"
--[[ ruRU ]] dL["ShortElemental"]	= "Э"
--[[ ruRU ]] dL["ShortGiant"]		= "В"
--[[ ruRU ]] dL["ShortHumanoid"]	= "Г"
--[[ ruRU ]] dL["ShortMechanical"]	= "М"
--[[ ruRU ]] dL["ShortUndead"]		= "Н"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

-- this has some obsolete values in it, pending some documentation
--[[ zhCN ]] dL["Beast"]			= "野兽"
--[[ zhCN ]] dL["Critter"]			= "小动物"
--[[ zhCN ]] dL["Demon"]			= "恶魔"
--[[ zhCN ]] dL["Dragonkin"]		= "龙类"
--[[ zhCN ]] dL["Giant"]			= "巨人"
--[[ zhCN ]] dL["Humanoid"]			= "人型生物"
--[[ zhCN ]] dL["Elemental"]		= "元素生物"
--[[ zhCN ]] dL["Mechanical"]		= "机械"
--[[ zhCN ]] dL["Undead"]			= "亡灵"

-- This is checked against when we gather data. If it's not specified, don't store it.
--[[ zhCN ]] dL["Not specified"]	= "未指定"
--[[ zhCN ]] dL["Non-combat Pet"]	= "非战斗宠物"

-- short forms
--[[ zhCN ]] dL["ShortBeast"]		= "野兽"
--[[ zhCN ]] dL["ShortCritter"]		= "小"
--[[ zhCN ]] dL["ShortDemon"]		= "恶"
--[[ zhCN ]] dL["ShortElemental"]	= "元"
--[[ zhCN ]] dL["ShortDragonkin"]	= "龙"
--[[ zhCN ]] dL["Giant"]			= "巨"
--[[ zhCN ]] dL["ShortHumanoid"]	= "人"
--[[ zhCN ]] dL["Mechanical"]		= "机"
--[[ zhCN ]] dL["ShortUndead"]		= "亡"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

-- this has some obsolete values in it, pending some documentation
--[[ zhTW ]] dL["Beast"]			= "野獸"
--[[ zhTW ]] dL["Critter"]			= "小動物"
--[[ zhTW ]] dL["Demon"]			= "惡魔"
--[[ zhTW ]] dL["Dragonkin"]		= "龍類"
--[[ zhTW ]] dL["Elemental"]		= "元素生物"
--[[ zhTW ]] dL["Giant"]			= "巨人"
--[[ zhTW ]] dL["Humanoid"]			= "人型生物"
--[[ zhTW ]] dL["Mechanical"]		= "機械"
--[[ zhTW ]] dL["Undead"]			= "不死族"

-- This is checked against when we gather data. If it's not specified, don't store it.
--[[ zhTW ]] dL["Not specified"]	= "未指定"
--[[ zhTW ]] dL["Non-combat Pet"]	= "非戰鬥寵物"

-- short forms
--[[ zhTW ]] dL["ShortBeast"]		= "野"
--[[ zhTW ]] dL["ShortCritter"]		= "小"
--[[ zhTW ]] dL["ShortDemon"]		= "惡"
--[[ zhTW ]] dL["ShortDragonkin"]	= "龍"
--[[ zhTW ]] dL["ShortElemental"]	= "元"
--[[ zhTW ]] dL["Giant"]			= "巨"
--[[ zhTW ]] dL["ShortHumanoid"]	= "人"
--[[ zhTW ]] dL["ShortUndead"]		= "死"
--[[ zhTW ]] dL["Mechanical"]		= "機"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftCreatureTypeData = setmetatable(dL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
dL = nil
