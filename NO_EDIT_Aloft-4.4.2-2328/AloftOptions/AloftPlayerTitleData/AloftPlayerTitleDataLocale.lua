local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

local oL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] oL["Save Player Title Data"] = "Save Player Title Data"
--[[ enUS ]] oL["Stores player title information between sessions"] = "Stores player title information between sessions"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftPlayerTitle"] = "AloftPlayerTitle"
--[[ enUS ]] mL["Gather and display player titles on nameplates"] = "Gather and display player titles on nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

--[[ koKR ]] oL["Save Player Title Data"] = "Save Player Title Data"
--[[ koKR ]] oL["Stores player title information between sessions"] = "Stores player title information between sessions"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftPlayerTitle"] = "AloftPlayerTitle"
--[[ koKR ]] mL["Gather and display player titles on nameplates"] = "Gather and display player titles on nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] oL["Save Player Title Data"] = "Записать данные о титулах игрока"
--[[ ruRU ]] oL["Stores player title information between sessions"] = "Сохранять данные о титулах игрока между сессиями"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftPlayerTitle"] = "AloftPlayerTitle"
--[[ ruRU ]] mL["Gather and display player titles on nameplates"] = "Отображает титул игрока"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] oL["Save Player Title Data"] = "保存玩家头衔数据"
--[[ zhCN ]] oL["Stores player title information between sessions"] = "在两次登录的间隔保存玩家头衔数据"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftPlayerTitle"] = "玩家称号"
--[[ zhCN ]] mL["Gather and display player titles on nameplates"] = "在姓名板上显示玩家称号"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] oL["Save Player Title Data"] = "儲存玩家頭銜資料"
--[[ zhTW ]] oL["Stores player title information between sessions"] = "儲存玩家頭銜資訊在登錄期間"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftPlayerTitle"] = "Aloft玩家稱號"
--[[ zhTW ]] mL["Gather and display player titles on nameplates"] = "在名牌上收集和顯示玩家稱號"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

AloftLocale.AloftPlayerTitleDataOptions = setmetatable(oL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
oL = nil

-----------------------------------------------------------------------------

end)
