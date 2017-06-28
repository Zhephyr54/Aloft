local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local dL = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

-- short forms
--[[ enUS ]] dL["Blood Elf"]	= "BE"
--[[ enUS ]] dL["Draenei"]		= "Dr"
--[[ enUS ]] dL["Dwarf"]		= "Dw"
--[[ enUS ]] dL["Gnome"]		= "Gn"
--[[ enUS ]] dL["Human"]		= "Hu"
--[[ enUS ]] dL["Night Elf"]	= "NE"
--[[ enUS ]] dL["Orc"]			= "Or"
--[[ enUS ]] dL["Tauren"]		= "Ta"
--[[ enUS ]] dL["Troll"]		= "Tr"
--[[ enUS ]] dL["Undead"]		= "Ud"
--[[ enUS ]] dL["Worgen"]		= "Wo"
--[[ enUS ]] dL["Goblin"]		= "Go"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

-- short forms
--[[ koKR ]] dL["Blood Elf"]	= "블엘"
--[[ koKR ]] dL["Draenei"]		= "드레"
--[[ koKR ]] dL["Dwarf"]		= "드웦"
--[[ koKR ]] dL["Gnome"]		= "놈"
--[[ koKR ]] dL["Human"]		= "인간"
--[[ koKR ]] dL["Night Elf"]	= "나엘"
--[[ koKR ]] dL["Orc"]			= "오크"
--[[ koKR ]] dL["Tauren"]		= "타렌"
--[[ koKR ]] dL["Troll"]		= "트롤"
--[[ koKR ]] dL["Undead"]		= "언데"
--[[ koKR ]] dL["Worgen"]		= "Wo"
--[[ koKR ]] dL["Goblin"]		= "Go"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

-- short forms
--[[ ruRU ]] dL["Blood Elf"]	= "ЭК"
--[[ ruRU ]] dL["Draenei"]		= "Др"
--[[ ruRU ]] dL["Dwarf"]		= "Дв"
--[[ ruRU ]] dL["Gnome"]		= "Гн"
--[[ ruRU ]] dL["Human"]		= "Че"
--[[ ruRU ]] dL["Night Elf"]	= "НЭ"
--[[ ruRU ]] dL["Orc"]			= "Ор"
--[[ ruRU ]] dL["Tauren"]		= "Та"
--[[ ruRU ]] dL["Troll"]		= "Тр"
--[[ ruRU ]] dL["Undead"]		= "Не"
--[[ ruRU ]] dL["Worgen"]		= "Wo"
--[[ ruRU ]] dL["Goblin"]		= "Go"

-----------------------------------------------------------------------------

--[[ ruRU ]] --dL["Blood Elf"]	= "Эльф крови"
--[[ ruRU ]] --dL["Draenei"]	= "Дреней"
--[[ ruRU ]] --dL["Dwarf"]		= "Дворф"
--[[ ruRU ]] --dL["Gnome"]		= "Гном"
--[[ ruRU ]] --dL["Human"]		= "Человек"
--[[ ruRU ]] --dL["Night Elf"]	= "Ночной эльф"
--[[ ruRU ]] --dL["Orc"]		= "Орк"
--[[ ruRU ]] --dL["Tauren"]		= "Таурен"
--[[ ruRU ]] --dL["Troll"]		= "Тролль"
--[[ ruRU ]] --dL["Undead"]		= "Нежить"
	
-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

-- short forms
--[[ zhCN ]] dL["Blood Elf"]	= "血精灵"
--[[ zhCN ]] dL["Draenei"]		= "德莱尼"
--[[ zhCN ]] dL["Dwarf"]		= "矮人"
--[[ zhCN ]] dL["Gnome"]		= "侏儒"
--[[ zhCN ]] dL["Human"]		= "人类"
--[[ zhCN ]] dL["Night Elf"]	= "夜精灵"
--[[ zhCN ]] dL["Orc"]			= "兽人"
--[[ zhCN ]] dL["Tauren"]		= "牛头"
--[[ zhCN ]] dL["Troll"]		= "巨魔"
--[[ zhCN ]] dL["Undead"]		= "亡灵"
--[[ zhCN ]] dL["Worgen"]		= "Wo"
--[[ zhCN ]] dL["Goblin"]		= "Go"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

-- short forms
--[[ zhTW ]] dL["Blood Elf"]	= "血"
--[[ zhTW ]] dL["Draenei"]		= "萊"
--[[ zhTW ]] dL["Dwarf"]		= "矮"
--[[ zhTW ]] dL["Gnome"]		= "地"
--[[ zhTW ]] dL["Human"]		= "人"
--[[ zhTW ]] dL["Night Elf"]	= "夜"
--[[ zhTW ]] dL["Orc"]			= "獸"
--[[ zhTW ]] dL["Tauren"]		= "牛"
--[[ zhTW ]] dL["Troll"]		= "食"
--[[ zhTW ]] dL["Undead"]		= "不"
--[[ zhTW ]] dL["Worgen"]		= "狼"
--[[ zhTW ]] dL["Goblin"]		= "哥"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftRaceData = setmetatable(dL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
dL = nil

