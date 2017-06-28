local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Target Tracking"] = "Target Tracking"
--[[ enUS ]] L["Various target tracking options"] = "Various target tracking options"

--[[ enUS ]] L["Treat Rares and Bosses as Unique (Experimental)"] = "Treat Rares and Bosses as Unique (Experimental)"
--[[ enUS ]] L["Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"] = "Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"

--[[ enUS ]] L["Enable Focus Tracking"] = "Enable Focus Tracking"
--[[ enUS ]] L["Enable group focus target tracking"] = "Enable group focus target tracking"
--[[ enUS ]] L["Focus Tracking Update Interval"] = "Focus Tracking Update Interval"
--[[ enUS ]] L["The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Target Tracking"] = "Target Tracking"
--[[ koKR ]] L["Various target tracking options"] = "Various target tracking options"

--[[ koKR ]] L["Treat Rares and Bosses as Unique (Experimental)"] = "Treat Rares and Bosses as Unique (Experimental)"
--[[ koKR ]] L["Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"] = "Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"

--[[ koKR ]] L["Enable Focus Tracking"] = "Enable Focus Tracking"
--[[ koKR ]] L["Enable group focus target tracking"] = "Enable group focus target tracking"
--[[ koKR ]] L["Focus Tracking Update Interval"] = "Focus Tracking Update Interval"
--[[ koKR ]] L["The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Target Tracking"] = "Отслеживание цели"
--[[ ruRU ]] L["Various target tracking options"] = "Настройки отслеживания цели"

--[[ ruRU ]] L["Treat Rares and Bosses as Unique (Experimental)"] = "Рассматривать редких и боссов как уникальные (Тестируется)"
--[[ ruRU ]] L["Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"] = "Цели редких и элитных боссов (пологаясь на классификаци и уровень) отслеживаются если их имена уникальные (Тестируется)"

--[[ ruRU ]] L["Enable Focus Tracking"] = "Включить отслеживание фокуса"
--[[ ruRU ]] L["Enable group focus target tracking"] = "Включить отслеживание фокуса"
--[[ ruRU ]] L["Focus Tracking Update Interval"] = "Скорость обновления отслеживания фокуса"
--[[ ruRU ]] L["The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"] = "Значение времени в секундах, между обновлением фокуса (0.0 максимальная скорость)"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Target Tracking"] = "Target Tracking"
--[[ zhCN ]] L["Various target tracking options"] = "Various target tracking options"

--[[ zhCN ]] L["Treat Rares and Bosses as Unique (Experimental)"] = "Treat Rares and Bosses as Unique (Experimental)"
--[[ zhCN ]] L["Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"] = "Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"

--[[ zhCN ]] L["Enable Focus Tracking"] = "Enable Focus Tracking"
--[[ zhCN ]] L["Enable group focus target tracking"] = "Enable group focus target tracking"
--[[ zhCN ]] L["Focus Tracking Update Interval"] = "Focus Tracking Update Interval"
--[[ zhCN ]] L["The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Target Tracking"] = "目標追蹤"
--[[ zhTW ]] L["Various target tracking options"] = "各種目標追蹤設定"

--[[ zhTW ]] L["Treat Rares and Bosses as Unique (Experimental)"] = "保存稀有且唯一的首領(試驗性)"
--[[ zhTW ]] L["Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"] = "稀有菁英首領目標(基於分類和等級)被追蹤好像他們的名稱是唯一的(試驗性)"

--[[ zhTW ]] L["Enable Focus Tracking"] = "啟用專注追蹤"
--[[ zhTW ]] L["Enable group focus target tracking"] = "啟用隊伍專注目標追蹤"
--[[ zhTW ]] L["Focus Tracking Update Interval"] = "專注追蹤更新間隔"
--[[ zhTW ]] L["The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"] = "幾秒內，隊伍專注更新間隔(0.0 是盡可能快)"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftTargetTrackingData = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil