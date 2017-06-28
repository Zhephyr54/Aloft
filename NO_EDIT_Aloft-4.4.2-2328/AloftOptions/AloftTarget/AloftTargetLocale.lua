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

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

-- TODO: on the surface, this wastes space in the enUS locale; the metatable could just return the canonical string as the localization;
--       BUT, this serves as a default locale, and also will permit the metatable to check/notify on missing locale strings

--[[ enUS ]] L["Enable Target-of-Target"] = "Enable Target-of-Target"
--[[ enUS ]] L["Enable target-of-target"] = "Enable target-of-target"
--[[ enUS ]] L["Target-of-Target Update Interval"] = "Target-of-Target Update Interval"
--[[ enUS ]] L["The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftTarget"] = "AloftTarget"
--[[ enUS ]] mL["Display target name and group target count on nameplates"] = "Display target name and group target count on nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

--[[ koKR ]] L["Enable Target-of-Target"] = "Enable Target-of-Target"
--[[ koKR ]] L["Enable target-of-target"] = "Enable target-of-target"
--[[ koKR ]] L["Target-of-Target Update Interval"] = "Target-of-Target Update Interval"
--[[ koKR ]] L["The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftTarget"] = "AloftTarget"
--[[ koKR ]] mL["Display target name and group target count on nameplates"] = "Display target name and group target count on nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Enable Target-of-Target"] = "Включить цель цели"
--[[ ruRU ]] L["Enable target-of-target"] = "Включить цель цели"
--[[ ruRU ]] L["Target-of-Target Update Interval"] = "Скорость обновления цели цели"
--[[ ruRU ]] L["The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"] = "Время в секундах между обновленями цели цели (0.0 максимальная скорость)"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftTarget"] = "AloftTarget"
--[[ ruRU ]] mL["Display target name and group target count on nameplates"] = "Отображает имя цели и номер группы"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Enable Target-of-Target"] = "启用目标的目标"
--[[ zhCN ]] L["Enable target-of-target"] = "启用目标的目标"
--[[ zhCN ]] L["Target-of-Target Update Interval"] = "目标的目标更新延迟"
--[[ zhCN ]] L["The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"] = "目标的目标的更新频率 （单位秒，最低值为0.0）"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftTarget"] = "目标"
--[[ zhCN ]] mL["Display target name and group target count on nameplates"] = "在姓名板上显示目标名称和小队中选中的数量"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Enable Target-of-Target"] = "啟用目標的目標"
--[[ zhTW ]] L["Enable target-of-target"] = "啟用目標的目標"
--[[ zhTW ]] L["Target-of-Target Update Interval"] = "目標的目標更新延遲"
--[[ zhTW ]] L["The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"] = "目標的目標的更新頻率 （單位秒，最低值為0.0）"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftTarget"] = "Aloft目標"
--[[ zhTW ]] mL["Display target name and group target count on nameplates"] = "在名牌上顯示目標名稱和隊伍中選中的數量"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

AloftLocale.AloftTarget = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

end)
