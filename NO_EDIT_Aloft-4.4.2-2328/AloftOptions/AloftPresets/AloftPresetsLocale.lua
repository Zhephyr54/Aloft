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

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale

--[[ enUS ]] L["Presets"] = "Presets"
--[[ enUS ]] L["Preset configurations"] = "Preset configurations"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftPresets"] = "AloftPresets"
--[[ enUS ]] mL["Enable access to preset configurations"] = "Enable access to preset configurations"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

--[[ koKR ]] L["Presets"] = "프리셋"
--[[ koKR ]] L["Preset configurations"] = "프리셋 환경설정"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftPresets"] = "AloftPresets"
--[[ koKR ]] mL["Enable access to preset configurations"] = "Enable access to preset configurations"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Presets"] = "Предустановки"
--[[ ruRU ]] L["Preset configurations"] = "Настройка предустановок"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftPresets"] = "AloftPresets"
--[[ ruRU ]] mL["Enable access to preset configurations"] = "Включает доступ к предустановкам настроек"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Presets"] = "设置预案"
--[[ zhCN ]] L["Preset configurations"] = "设置预案选项"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftPresets"] = "预设样式"
--[[ zhCN ]] mL["Enable access to preset configurations"] = "调用预设的配置文件"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Presets"] = "預先設定"
--[[ zhTW ]] L["Preset configurations"] = "預先設定"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftPresets"] = "Aloft預設樣式"
--[[ zhTW ]] mL["Enable access to preset configurations"] = "啟用存取預設的設定檔"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

AloftLocale.AloftPresetsOptions = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

-----------------------------------------------------------------------------

end)
