local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale

--[[ enUS ]] L["Default"] = "Default"
--[[ enUS ]] L["Preset 1"] = "Preset 1"
--[[ enUS ]] L["Preset 2"] = "Preset 2"
--[[ enUS ]] L["Preset 3"] = "Preset 3"
--[[ enUS ]] L["Preset Acapela"] = "Preset Acapela"
--[[ enUS ]] L["Preset Unit Frame"] = "Preset Unit Frame"
--[[ enUS ]] L["Preset PvP"] = "Preset PvP"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

--[[ koKR ]] L["Default"] = "기본형"
--[[ koKR ]] L["Preset 1"] = "프리셋 1"
--[[ koKR ]] L["Preset 2"] = "프리셋 2"
--[[ koKR ]] L["Preset 3"] = "프리셋 3"
--[[ koKR ]] L["Preset Acapela"] = "프리셋 Acapela"
--[[ koKR ]] L["Preset Unit Frame"] = "프리셋 Unit Frame"
--[[ koKR ]] L["Preset PvP"] = "프리셋 PvP"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Default"] = "По умолчанию"
--[[ ruRU ]] L["Preset 1"] = "Предустановка 1"
--[[ ruRU ]] L["Preset 2"] = "Предустановка 2"
--[[ ruRU ]] L["Preset 3"] = "Предустановка 3"
--[[ ruRU ]] L["Preset Acapela"] = "Предустановка Acapela"
--[[ ruRU ]] L["Preset Unit Frame"] = "Предустановка рамок игроков/существ"
--[[ ruRU ]] L["Preset PvP"] = "Предустановка PvP"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Default"] = "默认"
--[[ zhCN ]] L["Preset 1"] = "设置预案1"
--[[ zhCN ]] L["Preset 2"] = "设置预案2"
--[[ zhCN ]] L["Preset 3"] = "设置预案3"
--[[ zhCN ]] L["Preset Acapela"] = "设置预案Acapela"
--[[ zhCN ]] L["Preset Unit Frame"] = "设置预案Unit Frame"
--[[ zhCN ]] L["Preset PvP"] = "设置预案PvP"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Default"] = "預設"
--[[ zhTW ]] L["Preset 1"] = "預先設定1"
--[[ zhTW ]] L["Preset 2"] = "預先設定2"
--[[ zhTW ]] L["Preset 3"] = "預先設定3"
--[[ zhTW ]] L["Preset Acapela"] = "預先設定曙光"
--[[ zhTW ]] L["Preset Unit Frame"] = "預先設定單位框架"
--[[ zhTW ]] L["Preset PvP"] = "預先設定PvP"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

AloftLocale.AloftPresets = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

-----------------------------------------------------------------------------

end)
