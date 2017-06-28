local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.Aloft
if not L then return end

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Class Colors"] = "Class Colors"
--[[ enUS ]] L["Customize class colors"] = "Customize class colors"
--[[ enUS ]] L["class color"] = "class color"
--[[ enUS ]] L["Reset to Defaults"] = "Reset to Defaults"
--[[ enUS ]] L["Resets all colors to their defaults"] = "Resets all colors to their defaults"

--[[ enUS ]] L["Enable Configuration Mode"] = "Enable Configuration Mode"
--[[ enUS ]] L["Enable Startup Message"] = "Enable Startup Message"
--[[ enUS ]] L["Enable \"bloattest\""] = "Enable \"bloattest\""
--[[ enUS ]] L["Perform \"/console bloattest 1\" at startup"] = "Perform \"/console bloattest 1\" at startup"

--[[ enUS ]] L["Nameplate Initialization Interval"] = "Nameplate Initialization Interval"
--[[ enUS ]] L["The amount of time, in seconds, between proactive attempts to detect nameplates that are not yet visible (0.0 is as fast as possible; CAREFUL!)"] = "The amount of time, in seconds, between proactive attempts to detect nameplates that are not yet visible (0.0 is as fast as possible; CAREFUL!)"

--[[ enUS ]] L["Data Options"] = "Data Options"
--[[ enUS ]] L["Data options"] = "Data options"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Enable Configuration Mode"] = "Enable Configuration Mode"
--[[ koKR ]] L["Enable Startup Message"] = "Enable Startup Message"
--[[ koKR ]] L["Enable \"bloattest\""] = "Enable \"bloattest\""
--[[ koKR ]] L["Perform \"/console bloattest 1\" at startup"] = "Perform \"/console bloattest 1\" at startup"

--[[ koKR ]] L["Nameplate Initialization Interval"] = "Nameplate Initialization Interval"
--[[ koKR ]] L["The amount of time, in seconds, between proactive attempts to detect nameplates that are not yet visible (0.0 is as fast as possible; CAREFUL!)"] = "The amount of time, in seconds, between proactive attempts to detect nameplates that are not yet visible (0.0 is as fast as possible; CAREFUL!)"

--[[ koKR ]] L["Class Colors"] = "Class Colors"
--[[ koKR ]] L["Customize class colors"] = "Customize class colors"
--[[ koKR ]] L["class color"] = "class color"
--[[ koKR ]] L["Reset to Defaults"] = "기본값으로 초기화"
--[[ koKR ]] L["Resets all colors to their defaults"] = "모든 색상을 기본값으로 초기화합니다."

--[[ koKR ]] L["Data Options"] = "데이터 설정"
--[[ koKR ]] L["Data options"] = "데이터에 대한 설정입니다."

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Enable Configuration Mode"] = "Enable Configuration Mode"
--[[ ruRU ]] L["Enable Startup Message"] = "Enable Startup Message"
--[[ ruRU ]] L["Enable \"bloattest\""] = "Enable \"bloattest\""
--[[ ruRU ]] L["Perform \"/console bloattest 1\" at startup"] = "Perform \"/console bloattest 1\" at startup"

--[[ ruRU ]] L["Nameplate Initialization Interval"] = "Nameplate Initialization Interval"
--[[ ruRU ]] L["The amount of time, in seconds, between proactive attempts to detect nameplates that are not yet visible (0.0 is as fast as possible; CAREFUL!)"] = "The amount of time, in seconds, between proactive attempts to detect nameplates that are not yet visible (0.0 is as fast as possible; CAREFUL!)"

--[[ ruRU ]] L["Class Colors"] = "Окраска классов"
--[[ ruRU ]] L["Customize class colors"] = "Настраивать окраски классов"
--[[ ruRU ]] L["class color"] = "class color"
--[[ ruRU ]] L["Reset to Defaults"] = "Сброс в настройки по умолчанию"
--[[ ruRU ]] L["Resets all colors to their defaults"] = "Сбрасывает все цвета в настройки по умолчанию"

--[[ ruRU ]] L["Data Options"] = "Настройка данных"
--[[ ruRU ]] L["Data options"] = "Настройка данных"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Enable Configuration Mode"] = "Enable Configuration Mode"
--[[ zhCN ]] L["Enable Startup Message"] = "Enable Startup Message"
--[[ zhCN ]] L["Enable \"bloattest\""] = "Enable \"bloattest\""
--[[ zhCN ]] L["Perform \"/console bloattest 1\" at startup"] = "Perform \"/console bloattest 1\" at startup"

--[[ zhCN ]] L["Nameplate Initialization Interval"] = "Nameplate Initialization Interval"
--[[ zhCN ]] L["The amount of time, in seconds, between proactive attempts to detect nameplates that are not yet visible (0.0 is as fast as possible; CAREFUL!)"] = "The amount of time, in seconds, between proactive attempts to detect nameplates that are not yet visible (0.0 is as fast as possible; CAREFUL!)"

--[[ zhCN ]] L["Class Colors"] = "职业颜色"
--[[ zhCN ]] L["Customize class colors"] = "自定义职业颜色"
--[[ zhCN ]] L["class color"] = "职业颜色"
--[[ zhCN ]] L["Reset to Defaults"] = "重置为默认"
--[[ zhCN ]] L["Resets all colors to their defaults"] = "将全部颜色设定重置为默认"

--[[ zhCN ]] L["Data Options"] = "数据选项"
--[[ zhCN ]] L["Data options"] = "数据选项"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Aloft"] = "Aloft"
--[[ zhTW ]] L["Unknown"] = "未知" -- unit name for "Unknown" units

--[[ zhTW ]] L["Enable Configuration Mode"] = "啟用設定模式"
--[[ zhTW ]] L["Enable Startup Message"] = "啟用啟動訊息"
--[[ zhTW ]] L["Enable \"bloattest\""] = "啟用 \"bloattest\""
--[[ zhTW ]] L["Perform \"/console bloattest 1\" at startup"] = "在啟動時執行 \"/console bloattest 1\""

--[[ zhTW ]] L["Nameplate Initialization Interval"] = "名牌初始化間隔"
--[[ zhTW ]] L["The amount of time, in seconds, between proactive attempts to detect nameplates that are not yet visible (0.0 is as fast as possible; CAREFUL!)"] = "幾秒內，在名牌尚未可見時積極嘗試檢測(0.0 是盡可能快；小心！)"

--[[ zhTW ]] L["Class Colors"] = "職業顏色"
--[[ zhTW ]] L["Customize class colors"] = "自訂職業顏色"
--[[ zhTW ]] L["class color"] = "職業顏色"
--[[ zhTW ]] L["Reset to Defaults"] = "重置到預設"
--[[ zhTW ]] L["Resets all colors to their defaults"] = "重置全部顏色到預設"

--[[ zhTW ]] L["Data Options"] = "資料設定"
--[[ zhTW ]] L["Data options"] = "資料設定"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.Aloft = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil