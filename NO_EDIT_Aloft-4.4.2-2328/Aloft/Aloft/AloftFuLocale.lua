local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFu", function()

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."] = "Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."

--[[ enUS ]] L["Aloft"] = "Aloft"
--[[ enUS ]] L["Fubar"] = "Fubar"
--[[ enUS ]] L["Standard FuBar options"] = "Standard FuBar options"
--[[ enUS ]] L["Click to toggle nameplates."] = "|cffeda55fClick|r to toggle nameplates. "
--[[ enUS ]] L["Right-Click to open configuration."] = "|cffeda55fRight-Click|r to open configuration. "

--[[ enUS ]] L["Hostile Nameplates"] = "Hostile Nameplates"
--[[ enUS ]] L["Friendly Nameplates"] = "Friendly Nameplates"
--[[ enUS ]] L["Enabled"] = "|cff00ff00Enabled|r"
--[[ enUS ]] L["Disabled"] = "|cffff0000Disabled|r"

--[[ enUS ]] L["Show FuBar icon"] = "Show FuBar icon"
--[[ enUS ]] L["Show the FuBar plugin's icon on the panel."] = "Show the FuBar plugin's icon on the panel."
--[[ enUS ]] L["Show FuBar text"] = "Show FuBar text"
--[[ enUS ]] L["Show the FuBar plugin's text on the panel."] = "Show the FuBar plugin's text on the panel."
--[[ enUS ]] L["Position on FuBar"] = "Position on FuBar"
--[[ enUS ]] L["Position the FuBar plugin on the panel."] = "Position the FuBar plugin on the panel."

--[[ enUS ]] L["Attach FuBar plugin to minimap"] = "Attach FuBar plugin to minimap"
--[[ enUS ]] L["Attach the FuBar plugin to the minimap instead of the panel."] = "Attach the FuBar plugin to the minimap instead of the panel."
--[[ enUS ]] L["Hide FuBar Plugin Panel/Minimap Button"] = "Hide FuBar Plugin Panel/Minimap Button"
--[[ enUS ]] L["Hide the FuBar plugin from the panel or minimap, leaving the addon running."] = "Hide the FuBar plugin from the panel or minimap, leaving the addon running."

--[[ enUS ]] L["Left"] = "Left"
--[[ enUS ]] L["Right"] = "Right"
--[[ enUS ]] L["Center"] = "Center"

--[[ enUS ]] L["Other"] = "Other"
--[[ enUS ]] L["Close"] = "Close"
--[[ enUS ]] L["Close the menu."] = "Close the menu."

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

--[[ koKR ]] L["Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."] = "Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."

--[[ koKR ]] L["Aloft"] = "Aloft"
--[[ koKR ]] L["Fubar Options"] = "Fubar 설정"
--[[ koKR ]] L["Standard FuBar options"] = "기본 FuBar 설정입니다."
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

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."] = "Aloft поддержка FuBarа отключена, поскольку загружен. Будет предпринята попытка загрузить Aloft непосредственно поддержки LDB."

--[[ ruRU ]] L["Aloft"] = "Aloft"
--[[ ruRU ]] L["Fubar Options"] = "Настройки Fubar"
--[[ ruRU ]] L["Standard FuBar options"] = "Стандартные настройки FuBar"
--[[ ruRU ]] L["Click to toggle nameplates."] = "|cffeda55fКлик|r переключает таблички. "
--[[ ruRU ]] L["Right-Click to open configuration."] = "|cffeda55fRight-Клик|r открывает настройки. "

--[[ ruRU ]] L["Hostile Nameplates"] = "Таблички враждебных"
--[[ ruRU ]] L["Friendly Nameplates"] = "Дружественные таблички"
--[[ ruRU ]] L["Enabled"] = "|cff00ff00Включен|r"
--[[ ruRU ]] L["Disabled"] = "|cffff0000Отключен|r"

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."] = "Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."

--[[ zhCN ]] L["Aloft"] = "Aloft"
--[[ zhCN ]] L["Fubar Options"] = "Fubar设置"
--[[ zhCN ]] L["Standard FuBar options"] = "标准Fubar设置"
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

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."] = "Aloft FuBar支援已禁用因為Broker2FuBar已載入。將嘗試載入Aloft而不是直接LDB支援。Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."

--[[ zhTW ]] L["Aloft"] = "Aloft"
--[[ zhTW ]] L["Fubar Options"] = "Fubar 設定"
--[[ zhTW ]] L["Standard FuBar options"] = "標準 Fubar 設定"
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

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

AloftLocale.AloftFu = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

-----------------------------------------------------------------------------

end)
