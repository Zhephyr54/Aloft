local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftWaterfall")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Aloft"] = true,
	--[[ enUS ]] ["GUI Configuration"] = true,
	--[[ enUS ]] ["Opens the Waterfall GUI configuration menu"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Aloft"] = "Aloft",
	--[[ koKR ]] ["GUI Configuration"] = "GUI 환경설정",
	--[[ koKR ]] ["Opens the Waterfall GUI configuration menu"] = "Waterfall GUI 환경설정 메뉴를 엽니다.",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Aloft"] = "Aloft",
	--[[ ruRU ]] ["GUI Configuration"] = "Настройка GUI",						
	--[[ ruRU ]] ["Opens the Waterfall GUI configuration menu"] = "Открывает меню настройки Waterfall GUI",
} end)


-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Aloft"] = "Aloft",
	--[[ zhCN ]] ["GUI Configuration"] = "图形用户设置界面",
	--[[ zhCN ]] ["Opens the Waterfall GUI configuration menu"] = "打开Waterfall图形用户设置介面的菜单",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Aloft"] = "Aloft",
	--[[ zhTW ]] ["GUI Configuration"] = "圖形用戶介面設定",
	--[[ zhTW ]] ["Opens the Waterfall GUI configuration menu"] = "打開 Waterfall 圖形用戶介面設定選單",
} end)

-----------------------------------------------------------------------------

end
