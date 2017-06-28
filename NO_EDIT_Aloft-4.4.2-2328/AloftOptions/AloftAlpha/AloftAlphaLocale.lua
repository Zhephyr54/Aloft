local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

local L = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

-- TODO: on the surface, this wastes space in the enUS locale; the metatable could just return the canonical string as the localization;
--       BUT, this serves as a default locale, and also will permit the metatable to check/notify on missing locale strings

--[[ enUS ]] L["Alpha"] = "Alpha"
--[[ enUS ]] L["Various Alpha Options"] = "Various Alpha Options"

--[[ enUS ]] L["Target Enable"] = "Target Enable"
--[[ enUS ]] L["Enable changing alpha of target"] = "Enable changing alpha of target"

--[[ enUS ]] L["Target Alpha"] = "Target Alpha"
--[[ enUS ]] L["Sets the alpha of the target's nameplate"] = "Sets the alpha of the target's nameplate"

--[[ enUS ]] L["Non-Target Enable"] = "Non-Target Enable"
--[[ enUS ]] L["Enable changing alpha of non-target"] = "Enable changing alpha of non-target"

--[[ enUS ]] L["Non-Target Alpha"] = "Non-Target Alpha"
--[[ enUS ]] L["Sets the alpha of non-target nameplates"] = "Sets the alpha of non-target nameplates"

--[[ enUS ]] L["Default Enable"] = "Default Enable"
--[[ enUS ]] L["Enable changing alpha of default nameplates"] = "Enable changing alpha of default nameplates"

--[[ enUS ]] L["Default Alpha"] = "Default Alpha"
--[[ enUS ]] L["Sets the alpha of default nameplates"] = "Sets the alpha of default nameplates"

--[[ enUS ]] L["Update Interval"] = "Update Interval"
--[[ enUS ]] L["The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"] = "The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftAlpha"] = "AloftAlpha"
--[[ enUS ]] mL["Control the relative transparency of nameplates"] = "Control the relative transparency of nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

--[[ koKR ]] L["Alpha"] = "투명도"
--[[ koKR ]] L["Various Alpha Options"] = "각각의 투명도 설정입니다."

--[[ koKR ]] L["Target Enable"] = "대상 사용"
--[[ koKR ]] L["Enable changing alpha of target"] = "대상의 투명도를 변경합니다."

--[[ koKR ]] L["Target Alpha"] = "대상 투명도"
--[[ koKR ]] L["Sets the alpha of the target's nameplate"] = "대상의 이름표의 투명도를 설정합니다."

--[[ koKR ]] L["Non-Target Enable"] = "비-대상 사용"
--[[ koKR ]] L["Enable changing alpha of non-target"] = "비-대상의 투명도를 변경합니다."

--[[ koKR ]] L["Non-Target Alpha"] = "비-대상 투명도"
--[[ koKR ]] L["Sets the alpha of non-target nameplates"] = "비-대상 이름표의 투명도를 설정합니다."

--[[ koKR ]] L["Default Enable"] = "기본 사용"
--[[ koKR ]] L["Enable changing alpha of default nameplates"] = "기본 이름표의 투명도를 변경합니다."

--[[ koKR ]] L["Default Alpha"] = "기본 투명도"
--[[ koKR ]] L["Sets the alpha of default nameplates"] = "기본 이름표의 투명도를 설정합니다."

--[[ koKR ]] L["Update Interval"] = "Update Interval"
--[[ koKR ]] L["The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"] = "The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftAlpha"] = "AloftAlpha"
--[[ koKR ]] mL["Control the relative transparency of nameplates"] = "Control the relative transparency of nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Alpha"] = "Прозрачность"
--[[ ruRU ]] L["Various Alpha Options"] = "Прочие настройки прозрачности"

--[[ ruRU ]] L["Target Enable"] = "Включить цель"
--[[ ruRU ]] L["Enable changing alpha of target"] = "Включить изменение прозрачности цели"

--[[ ruRU ]] L["Target Alpha"] = "Прозрачность цели"
--[[ ruRU ]] L["Sets the alpha of the target's nameplate"] = "Задает прозрачность таблички цели"

--[[ ruRU ]] L["Non-Target Enable"] = "Включить не цели"
--[[ ruRU ]] L["Enable changing alpha of non-target"] = "Включить изменение прозрачность для не-цели"

--[[ ruRU ]] L["Non-Target Alpha"] = "Прозрачность не целей"
--[[ ruRU ]] L["Sets the alpha of non-target nameplates"] = "Задает прозрачность табличек не-целей"

--[[ ruRU ]] L["Default Enable"] = "Включить по умолчанию"
--[[ ruRU ]] L["Enable changing alpha of default nameplates"] = "Включить изменения прозрачности для стандартных табличек"

--[[ ruRU ]] L["Default Alpha"] = "Прозрачность по умолчанию"
--[[ ruRU ]] L["Sets the alpha of default nameplates"] = "Задает прозрачность оригинальных табличек"

--[[ ruRU ]] L["Update Interval"] = "Время обновления"
--[[ ruRU ]] L["The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"] = "Время в секундах между обновленями уровня прозрачности таблички (0.0 так быстро, как может интерфейс)"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftAlpha"] = "AloftAlpha"
--[[ ruRU ]] mL["Control the relative transparency of nameplates"] = "Настройки прозрачности табличек"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Alpha"] = "透明度"
--[[ zhCN ]] L["Various Alpha Options"] = "透明度相关设置"

--[[ zhCN ]] L["Target Enable"] = "对目标启用"
--[[ zhCN ]] L["Enable changing alpha of target"] = "启用目标姓名板的透明度改变"

--[[ zhCN ]] L["Target Alpha"] = "目标透明度"
--[[ zhCN ]] L["Sets the alpha of the target's nameplate"] = "设定目标姓名板的透明度"

--[[ zhCN ]] L["Non-Target Enable"] = "对非目标启用"
--[[ zhCN ]] L["Enable changing alpha of non-target"] = "启用非目标姓名板的透明度改变"

--[[ zhCN ]] L["Non-Target Alpha"] = "非目标透明度"
--[[ zhCN ]] L["Sets the alpha of non-target nameplates"] = "设定非目标姓名板的透明度"

--[[ zhCN ]] L["Default Enable"] = "对默认启用"
--[[ zhCN ]] L["Enable changing alpha of default nameplates"] = "启用默认姓名板的透明度改变"

--[[ zhCN ]] L["Default Alpha"] = "默认透明度"
--[[ zhCN ]] L["Sets the alpha of default nameplates"] = "设定默认姓名板的透明度"

--[[ zhCN ]] L["Update Interval"] = "更新频率"
--[[ zhCN ]] L["The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"] = "姓名板透明度的更新速率，0.0秒是UI可以使用的最大值"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftAlpha"] = "透明度"
--[[ zhCN ]] mL["Control the relative transparency of nameplates"] = "控制姓名板的透明度"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Alpha"] = "透明度"
--[[ zhTW ]] L["Various Alpha Options"] = "透明度設定"

--[[ zhTW ]] L["Target Enable"] = "目標啟用"
--[[ zhTW ]] L["Enable changing alpha of target"] = "啟用改變目標名牌的透明度"

--[[ zhTW ]] L["Target Alpha"] = "目標透明度"
--[[ zhTW ]] L["Sets the alpha of the target's nameplate"] = "設定目標名牌的透明度"

--[[ zhTW ]] L["Non-Target Enable"] = "非目標啟用"
--[[ zhTW ]] L["Enable changing alpha of non-target"] = "啟用改變非目標名牌的透明度"

--[[ zhTW ]] L["Non-Target Alpha"] = "非目標透明度"
--[[ zhTW ]] L["Sets the alpha of non-target nameplates"] = "設定非目標名牌的透明度"

--[[ zhTW ]] L["Default Enable"] = "預設啟用"
--[[ zhTW ]] L["Enable changing alpha of default nameplates"] = "啟用改變預設名牌的透明度"

--[[ zhTW ]] L["Default Alpha"] = "預設透明度"
--[[ zhTW ]] L["Sets the alpha of default nameplates"] = "設定預設名牌的透明度"

--[[ zhTW ]] L["Update Interval"] = "更新頻率"
--[[ zhTW ]] L["The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"] = "姓名板透明度的更新速率，0.0秒是UI可以使用的最大值"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftAlpha"] = "Aloft透明度"
--[[ zhTW ]] mL["Control the relative transparency of nameplates"] = "控制相關名牌的透明度"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

AloftLocale.AloftAlphaOptions = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

-----------------------------------------------------------------------------

end)
