local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftFu")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."] = true,

	--[[ enUS ]] ["Aloft"] = true,
	--[[ enUS ]] ["Fubar Options"] = true,
	--[[ enUS ]] ["Standard FuBar options"] = true,
	--[[ enUS ]] ["Click to toggle nameplates."] = "|cffeda55fClick|r to toggle nameplates. ",
	--[[ enUS ]] ["Shift-Click to open configuration."] = "|cffeda55fShift-Click|r to open configuration. ",

	--[[ enUS ]] ["Hostile Nameplates"] = true,
	--[[ enUS ]] ["Friendly Nameplates"] = true,
	--[[ enUS ]] ["Enabled"] = "|cff00ff00Enabled|r",
	--[[ enUS ]] ["Disabled"] = "|cffff0000Disabled|r",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."] = "Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead.",

	--[[ koKR ]] ["Aloft"] = "Aloft",
	--[[ koKR ]] ["Fubar Options"] = "Fubar 설정",
	--[[ koKR ]] ["Standard FuBar options"] = "기본 FuBar 설정입니다.",
	--[[ koKR ]] ["Click to toggle nameplates."] = "이름표를 전환하려면 |cffeda55f클릭|r하세요.",
	--[[ koKR ]] ["Shift-Click to open configuration."] = "환경 설정을 열려면 |cffeda55fSHIFT-클릭|r하세요.",

	--[[ koKR ]] ["Hostile Nameplates"] = "적대적 이름표",
	--[[ koKR ]] ["Friendly Nameplates"] = "우호적 이름표",
	--[[ koKR ]] ["Enabled"] = "|cff00ff00사용|r",
	--[[ koKR ]] ["Disabled"] = "|cffff0000미사용|r",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."] = "Aloft поддержка FuBarа отключена, поскольку загружен. Будет предпринята попытка загрузить Aloft непосредственно поддержки LDB.",

	--[[ ruRU ]] ["Aloft"] = "Aloft",
	--[[ ruRU ]] ["Fubar Options"] = "Настройки Fubar",
	--[[ ruRU ]] ["Standard FuBar options"] = "Стандартные настройки FuBar",
	--[[ ruRU ]] ["Click to toggle nameplates."] = "|cffeda55fКлик|r переключает таблички. ",
	--[[ ruRU ]] ["Shift-Click to open configuration."] = "|cffeda55fShift-Клик|r открывает настройки. ",

	--[[ ruRU ]] ["Hostile Nameplates"] = "Таблички враждебных",
	--[[ ruRU ]] ["Friendly Nameplates"] = "Дружественные таблички",
	--[[ ruRU ]] ["Enabled"] = "|cff00ff00Включен|r",
	--[[ ruRU ]] ["Disabled"] = "|cffff0000Отключен|r",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."] = "Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead.",

	--[[ zhCN ]] ["Aloft"] = "Aloft",
	--[[ zhCN ]] ["Fubar Options"] = "Fubar设置",
	--[[ zhCN ]] ["Standard FuBar options"] = "标准Fubar设置",
	--[[ zhCN ]] ["Click to toggle nameplates."] = "|cffeda55f点击: |r开启或关闭姓名板",
	--[[ zhCN ]] ["Shift-Click to open configuration."] = "|cffeda55fShift+点击: |r打开设置窗口",

	--[[ zhCN ]] ["Hostile Nameplates"] = "敌对方单位姓名板",
	--[[ zhCN ]] ["Friendly Nameplates"] = "友好方单位姓名板",
	--[[ zhCN ]] ["Enabled"] = "|cff00ff00已启用|r",
	--[[ zhCN ]] ["Disabled"] = "|cffff0000已停用|r",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."] = "Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead.",

	--[[ zhTW ]] ["Aloft"] = "Aloft",
	--[[ zhTW ]] ["Fubar Options"] = "Fubar 選項",
	--[[ zhTW ]] ["Standard FuBar options"] = "標準 Fubar 選項",
	--[[ zhTW ]] ["Click to toggle nameplates."] = "|cffeda55f左擊: |r切換名牌。",
	--[[ zhTW ]] ["Shift-Click to open configuration."] = "|cffeda55fShift-左擊: |r打開設定。",

	--[[ zhTW ]] ["Hostile Nameplates"] = "敵對名牌",
	--[[ zhTW ]] ["Friendly Nameplates"] = "友好名牌",
	--[[ zhTW ]] ["Enabled"] = "|cff00ff00已啟用|r",
	--[[ zhTW ]] ["Disabled"] = "|cffff0000已停用|r",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
