-----------------------------------------------------------------------------

-- global Aloft locale "table-of-metatables"; this is allocated once here
AloftLocale = { }

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Aloft"] = "Aloft"
--[[ enUS ]] L["Unknown"] = "Unknown" -- unit name for "Unknown" units
--[[ enUS ]] L["Level"]	= "Level"

--[[ enUS ]] L["Load Options"] = "Load Options"
--[[ enUS ]] L["Load options for Aloft modules"] = "Load options for Aloft modules"
--[[ enUS ]] L["gui"] = "gui"

-- labels for keybindings; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ enUS ]] L["Show Neutral/Enemy Name Plates"] = "Show Neutral/Enemy Name Plates"
--[[ enUS ]] L["Show Friendly Name Plates"] = "Show Friendly Name Plates"
--[[ enUS ]] L["Show All Name Plates"] = "Show All Name Plates"

--[[ enUS ]] L["Unable to determine module providing data: "] = "Unable to determine module providing data: "
--[[ enUS ]] L["Internal error: Dependency list not resolved - cyclic dependency?"] = "Internal error: Dependency list not resolved - cyclic dependency?"
--[[ enUS ]] L["Warning: Tag<->module dependency list not resolved - non-fatal cyclic dependency?"] = "Warning: Tag<->module dependency list not resolved - non-fatal cyclic dependency?"

-- player states; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ enUS ]] L["Combat"] = "Combat"
--[[ enUS ]] L["Flagged/PvP"] = "Flagged/PvP"
--[[ enUS ]] L["Resting"] = "Resting"
--[[ enUS ]] L["Group"] = "Group"
--[[ enUS ]] L["Default"] = "Default"

-- player locations; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ enUS ]] L["Player Location"] = "Player Location"
--[[ enUS ]] L["World"] = "World"
--[[ enUS ]] L["Battleground"] = "Battleground"
--[[ enUS ]] L["Arena"] = "Arena"
--[[ enUS ]] L["5-Man Instance"] = "5-Man Instance"
--[[ enUS ]] L["Raid Instance"] = "Raid Instance"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Aloft"] = "Aloft"
--[[ koKR ]] L["Unknown"] = "Unknown" -- unit name for "Unknown" units
--[[ koKR ]] L["Level"] = "레벨"

--[[ koKR ]] L["Load Options"] = "불러오기 설정"
--[[ koKR ]] L["Load options for Aloft modules"] = "Aloft 모듈들에 대한 불러오기 설정입니다."
--[[ koKR ]] L["gui"] = "gui"

-- labels for keybindings; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ koKR ]] L["Show Neutral/Enemy Name Plates"] = "Show Neutral/Enemy Name Plates"
--[[ koKR ]] L["Show Friendly Name Plates"] = "Show Friendly Name Plates"
--[[ koKR ]] L["Show All Name Plates"] = "Show All Name Plates"

--[[ koKR ]] L["Unable to determine module providing data: "] = "데이터를 위한 모듈을 결정할 수 없습니다: "
--[[ koKR ]] L["Internal error: Dependency list not resolved - cyclic dependency?"] = "내부적 오류: 목록 의존성이 해결되지 않았습니다 - 순환적인 의존성?"
--[[ koKR ]] L["Warning: Tag<->module dependency list not resolved - non-fatal cyclic dependency?"] = "Warning: Tag<->module dependency list not resolved - non-fatal cyclic dependency?"

-- player states; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ koKR ]] L["Combat"] = "Combat"
--[[ koKR ]] L["Flagged/PvP"] = "Flagged/PvP"
--[[ koKR ]] L["Resting"] = "Resting"
--[[ koKR ]] L["Group"] = "Group"
--[[ koKR ]] L["Default"] = "Default"

-- player locations; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ koKR ]] L["Player Location"] = "Player Location"
--[[ koKR ]] L["World"] = "World"
--[[ koKR ]] L["Battleground"] = "Battleground"
--[[ koKR ]] L["Arena"] = "Arena"
--[[ koKR ]] L["5-Man Instance"] = "5-Man Instance"
--[[ koKR ]] L["Raid Instance"] = "Raid Instance"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Aloft"] = "Aloft"
--[[ ruRU ]] L["Unknown"] = "Unknown" -- unit name for "Unknown" units
--[[ ruRU ]] L["Level"] = "Уровень"

--[[ ruRU ]] L["Load Options"] = "Настройки загрузки"
--[[ ruRU ]] L["Load options for Aloft modules"] = "Настройки загрузки для модулей Aloft"
--[[ ruRU ]] L["gui"] = "gui"

-- labels for keybindings; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ ruRU ]] L["Show Neutral/Enemy Name Plates"] = "Отображать таблички нейтральных/враждебных"
--[[ ruRU ]] L["Show Friendly Name Plates"] = "Отображать таблички дружественных"
--[[ ruRU ]] L["Show All Name Plates"] = "Отображать все таблички"

--[[ ruRU ]] L["Unable to determine module providing data: "] = "Невозможно определить модуль, предоставляющий данные"
--[[ ruRU ]] L["Internal error: Dependency list not resolved - cyclic dependency?"] = "Внутренняя ошибка: Невозможно разрешить список зависимостей — циклическая зависимость?"
--[[ ruRU ]] L["Warning: Tag<->module dependency list not resolved - non-fatal cyclic dependency?"] = "Warning: Tag<->module dependency list not resolved - non-fatal cyclic dependency?"

-- player states; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ ruRU ]] L["Combat"] = "Бой"
--[[ ruRU ]] L["Flagged/PvP"] = "Флаг/PvP"
--[[ ruRU ]] L["Resting"] = "Отдых"
--[[ ruRU ]] L["Group"] = "Группа"
--[[ ruRU ]] L["Default"] = "По умолчанию"

-- player locations; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ ruRU ]] L["Player Location"] = "Местонахождение игрока"
--[[ ruRU ]] L["World"] = "Мир"
--[[ ruRU ]] L["Battleground"] = "Поля сражений"
--[[ ruRU ]] L["Arena"] = "Арена"
--[[ ruRU ]] L["5-Man Instance"] = "Инстансы на 5-чел"
--[[ ruRU ]] L["Raid Instance"] = "Рейдовые инстансыe"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Aloft"] = "Aloft"
--[[ zhCN ]] L["Unknown"] = "Unknown" -- unit name for "Unknown" units
--[[ zhCN ]] L["Level"] = "等级"

--[[ zhCN ]] L["Load Options"] = "加载设置"
--[[ zhCN ]] L["Load options for Aloft modules"] = "Aloft模块选项"
--[[ zhCN ]] L["gui"] = "gui"

-- labels for keybindings; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ zhCN ]] L["Show Neutral/Enemy Name Plates"] = "Show Neutral/Enemy Name Plates"
--[[ zhCN ]] L["Show Friendly Name Plates"] = "Show Friendly Name Plates"
--[[ zhCN ]] L["Show All Name Plates"] = "Show All Name Plates"

--[[ zhCN ]] L["Unable to determine module providing data: "] = "无法确认提供数据的模块"
--[[ zhCN ]] L["Internal error: Dependency list not resolved - cyclic dependency?"] = "内部错误：未找到依赖列表 - 是否遍历依赖？"
--[[ zhCN ]] L["Warning: Tag<->module dependency list not resolved - non-fatal cyclic dependency?"] = "Warning: Tag<->module dependency list not resolved - non-fatal cyclic dependency?"

-- player states; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ zhCN ]] L["Combat"] = "战斗"
--[[ zhCN ]] L["Flagged/PvP"] = "Flagged/PvP"
--[[ zhCN ]] L["Resting"] = "休息"
--[[ zhCN ]] L["Group"] = "小队"
--[[ zhCN ]] L["Default"] = "默认"

-- player locations; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ zhCN ]] L["Player Location"] = "Player Location"
--[[ zhCN ]] L["World"] = "World"
--[[ zhCN ]] L["Battleground"] = "Battleground"
--[[ zhCN ]] L["Arena"] = "Arena"
--[[ zhCN ]] L["5-Man Instance"] = "5-Man Instance"
--[[ zhCN ]] L["Raid Instance"] = "Raid Instance"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Aloft"] = "Aloft"
--[[ zhTW ]] L["Unknown"] = "未知" -- unit name for "Unknown" units
--[[ zhTW ]] L["Level"] = "等級"

--[[ zhTW ]] L["Load Options"] = "載入設定"
--[[ zhTW ]] L["Load options for Aloft modules"] = "Aloft 模組的載入設定"
--[[ zhTW ]] L["gui"] = "圖形介面"

-- labels for keybindings; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ zhTW ]] L["Show Neutral/Enemy Name Plates"] = "顯示中立/敵對名牌"
--[[ zhTW ]] L["Show Friendly Name Plates"] = "顯示友好名牌"
--[[ zhTW ]] L["Show All Name Plates"] = "顯示所有名牌"

--[[ zhTW ]] L["Unable to determine module providing data: "] = "無法決定模組提供的資料："
--[[ zhTW ]] L["Internal error: Dependency list not resolved - cyclic dependency?"] = "內部錯誤: 相依性清單未解決 - 循環相依?"
--[[ zhTW ]] L["Warning: Tag<->module dependency list not resolved - non-fatal cyclic dependency?"] = "警告: 標籤<->模組相依清單未解決 - 非致命性循環相依?"

-- player states; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ zhTW ]] L["Combat"] = "戰鬥"
--[[ zhTW ]] L["Flagged/PvP"] = "標幟/PvP"
--[[ zhTW ]] L["Resting"] = "休息"
--[[ zhTW ]] L["Group"] = "隊伍"
--[[ zhTW ]] L["Default"] = "預設"

-- player locations; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
--[[ zhTW ]] L["Player Location"] = "玩家位置"
--[[ zhTW ]] L["World"] = "世界"
--[[ zhTW ]] L["Battleground"] = "戰場"
--[[ zhTW ]] L["Arena"] = "競技場"
--[[ zhTW ]] L["5-Man Instance"] = "5人副本"
--[[ zhTW ]] L["Raid Instance"] = "團隊副本"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

-- TODO: need to rationalize this with the metatable that AloftOptions creates
AloftLocale.Aloft = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil