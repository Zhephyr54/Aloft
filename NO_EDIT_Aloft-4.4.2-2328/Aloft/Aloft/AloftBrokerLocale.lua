local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftLDB", function()

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Aloft LDB support disabled itself because Broker2FuBar is loaded. Will attempt to load Aloft direct FuBar support instead."] = "Aloft LDB support disabled itself because Broker2FuBar is loaded. Will attempt to load Aloft direct FuBar support instead."

--[[ enUS ]] L["Aloft"] = "Aloft"
--[[ enUS ]] L["Click to toggle nameplates."] = "|cffeda55fClick|r to toggle nameplates. "
--[[ enUS ]] L["Right-Click to open configuration."] = "|cffeda55fRight-Click|r to open configuration. "

--[[ enUS ]] L["Hostile Nameplates"] = "Hostile Nameplates"
--[[ enUS ]] L["Friendly Nameplates"] = "Friendly Nameplates"
--[[ enUS ]] L["Enabled"] = "|cff00ff00Enabled|r"
--[[ enUS ]] L["Disabled"] = "|cffff0000Disabled|r"

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftLDB", function()

--[[ koKR ]] L["Aloft LDB support disabled itself because Broker2FuBar is loaded. Will attempt to load Aloft direct FuBar support instead."] = "Aloft LDB support disabled itself because Broker2FuBar is loaded. Will attempt to load Aloft direct FuBar support instead."

--[[ koKR ]] L["Aloft"] = "Aloft"
--[[ koKR ]] L["Click to toggle nameplates."] = "이름표를 전환하려면 |cffeda55f클릭|r하세요."
--[[ koKR ]] L["Right-Click to open configuration."] = "환경 설정을 열려면 |cffeda55fRight-클릭|r하세요."

--[[ koKR ]] L["Hostile Nameplates"] = "적대적 이름표"
--[[ koKR ]] L["Friendly Nameplates"] = "우호적 이름표"
--[[ koKR ]] L["Enabled"] = "|cff00ff00사용|r"
--[[ koKR ]] L["Disabled"] = "|cffff0000미사용|r"

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftLDB", function()

--[[ ruRU ]] L["Aloft LDB support disabled itself because Broker2FuBar is loaded. Will attempt to load Aloft direct FuBar support instead."] = "Aloft поддержка LDB отключена, поскольку загружен Broker2FuBar. Будет предпринята попытка загрузить Aloft непосредственно поддержки FuBarа."

--[[ ruRU ]] L["Aloft"] = "Aloft"
--[[ ruRU ]] L["Click to toggle nameplates."] = "|cffeda55fКлик|r переключает таблички. "
--[[ ruRU ]] L["Right-Click to open configuration."] = "|cffeda55fRight-Клик|r открывает настройки. "

--[[ ruRU ]] L["Hostile Nameplates"] = "Таблички враждебных"
--[[ ruRU ]] L["Friendly Nameplates"] = "Дружественные таблички"
--[[ ruRU ]] L["Enabled"] = "|cff00ff00DВключен|r"
--[[ ruRU ]] L["Disabled"] = "|cffff0000Выключен|r"

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftLDB", function()

--[[ zhCN ]] L["Aloft LDB support disabled itself because Broker2FuBar is loaded. Will attempt to load Aloft direct FuBar support instead."] = "Aloft LDB support disabled itself because Broker2FuBar is loaded. Will attempt to load Aloft direct FuBar support instead."

--[[ zhCN ]] L["Aloft"] = "Aloft"
--[[ zhCN ]] L["Click to toggle nameplates."] = "|cffeda55f点击: |r开启或关闭姓名板"
--[[ zhCN ]] L["Right-Click to open configuration."] = "|cffeda55fRight-点击: |r打开设置窗口"

--[[ zhCN ]] L["Hostile Nameplates"] = "敌对方单位姓名板"
--[[ zhCN ]] L["Friendly Nameplates"] = "友好方单位姓名板"
--[[ zhCN ]] L["Enabled"] = "|cff00ff00已启用|r"
--[[ zhCN ]] L["Disabled"] = "|cffff0000已停用|r"

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftLDB", function()

--[[ zhTW ]] L["Aloft LDB support disabled itself because Broker2FuBar is loaded. Will attempt to load Aloft direct FuBar support instead."] = "Aloft LDB支援已禁用因為Broker2FuBar已載入。將嘗試載入Aloft而不是直接FuBar支援。"

--[[ zhTW ]] L["Aloft"] = "Aloft"
--[[ zhTW ]] L["Click to toggle nameplates."] = "|cffeda55f點擊: |r切換名牌。"
--[[ zhTW ]] L["Right-Click to open configuration."] = "|cffeda55f右鍵-點擊: |r開啟設定。"

--[[ zhTW ]] L["Hostile Nameplates"] = "敵對名牌"
--[[ zhTW ]] L["Friendly Nameplates"] = "友好名牌"
--[[ zhTW ]] L["Enabled"] = "|cff00ff00已啟用|r"
--[[ zhTW ]] L["Disabled"] = "|cffff0000已停用|r"

end)

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftLDB", function()

AloftLocale.AloftBroker = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

end)
