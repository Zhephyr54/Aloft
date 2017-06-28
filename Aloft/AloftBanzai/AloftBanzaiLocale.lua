local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftBanzaiOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftBanzai", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Banzai"] = true,
	--[[ enUS ]] ["Banzai options"] = true,

	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Highlights group members that have aggro"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the aggro color"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftBanzai", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Banzai"] = "어그로",
	--[[ koKR ]] ["Banzai options"] = "어그로에 대한 설정입니다.",

	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Highlights group members that have aggro"] = "어그로를 가진 파티원을 강조합니다.",
	--[[ koKR ]] ["Color"] = "색상",
	--[[ koKR ]] ["Sets the aggro color"] = "어그로 색상을 설정합니다.",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftBanzai", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Banzai"] = "Banzai",
	--[[ ruRU ]] ["Banzai options"] = "Настройки Banzai",

	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Highlights group members that have aggro"] = "Подсвечивает участникого группы, на котороых аггро",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the aggro color"] = "Задает цвет аггро",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftBanzai", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Banzai"] = "仇恨指示",
	--[[ zhCN ]] ["Banzai options"] = "仇恨指示相关设置",

	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Highlights group members that have aggro"] = "将获得仇恨的团队成员高亮显示",
	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the aggro color"] = "仇恨持有者的颜色",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftBanzai", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Banzai"] = "仇恨指示",
	--[[ zhTW ]] ["Banzai options"] = "仇恨指示選項",

	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Highlights group members that have aggro"] = "高亮變成被攻擊目標的團體成員",
	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the aggro color"] = "被攻擊目標的顏色",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
