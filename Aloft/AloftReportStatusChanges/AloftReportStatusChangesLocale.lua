local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftReportStatusChanges")

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["HostileNameplatesEnabled"] = "Hostile nameplates |cff00ff00enabled|r.",
	--[[ enUS ]] ["HostileNameplatesDisabled"] = "Hostile nameplates |cffff0000disabled|r.",
	--[[ enUS ]] ["FriendlyNameplatesEnabled"] = "Friendly nameplates |cff00ff00enabled|r.",
	--[[ enUS ]] ["FriendlyNameplatesDisabled"] = "Friendly nameplates |cffff0000disabled|r.",

	--[[ enUS ]] ["Report Status Changes"] = true,
	--[[ enUS ]] ["Prints the status of nameplates whenever they change"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["HostileNameplatesEnabled"] = "적대적 대상의 이름표 : |cff00ff00표시|r.",
	--[[ koKR ]] ["HostileNameplatesDisabled"] = "적대적 대상의 이름표 : |cffff0000숨김|r.",
	--[[ koKR ]] ["FriendlyNameplatesEnabled"] = "우호적 대상의 이름표 : |cff00ff00표시|r.",
	--[[ koKR ]] ["FriendlyNameplatesDisabled"] = "우호적 대상의 이름표 : |cffff0000숨김|r.",

	--[[ koKR ]] ["Report Status Changes"] = "상태 변경 알림",
	--[[ koKR ]] ["Prints the status of nameplates whenever they change"] = "이름표의 표시 상태 변경시 대화창에 표시합니다.",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["HostileNameplatesEnabled"] = "Таблички враждебных |cff00ff00включены|r.",
	--[[ ruRU ]] ["HostileNameplatesDisabled"] = "Таблички враждебных |cffff0000отключены|r.",
	--[[ ruRU ]] ["FriendlyNameplatesEnabled"] = "Таблички дружественных |cff00ff00включены|r.",
	--[[ ruRU ]] ["FriendlyNameplatesDisabled"] = "Таблички дружественных |cffff0000отключены|r.",

	--[[ ruRU ]] ["Report Status Changes"] = "Сообщать об изменении статуса",
	--[[ ruRU ]] ["Prints the status of nameplates whenever they change"] = "Печатает статус табличек при их изменении",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["HostileNameplatesEnabled"] = "敌对姓名板|cff00ff00已启用|r。",
	--[[ zhCN ]] ["HostileNameplatesDisabled"] = "敌对姓名板|cffff0000已禁用|r。",
	--[[ zhCN ]] ["FriendlyNameplatesEnabled"] = "友方姓名板|cff00ff00已启用|r。",
	--[[ zhCN ]] ["FriendlyNameplatesDisabled"] = "友方姓名板|cffff0000已禁用|r。",

	--[[ zhCN ]] ["Report Status Changes"] = "报告状态变化",
	--[[ zhCN ]] ["Prints the status of nameplates whenever they change"] = "报告姓名板的状态变化",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["HostileNameplatesEnabled"] = "敵對名牌|cff00ff00已啟用|r。",
	--[[ zhTW ]] ["HostileNameplatesDisabled"] = "敵對名牌|cffff0000已停用|r。",
	--[[ zhTW ]] ["FriendlyNameplatesEnabled"] = "友好名牌|cff00ff00已啟用|r。",
	--[[ zhTW ]] ["FriendlyNameplatesDisabled"] = "友好名牌|cffff0000已停用|r。",

	--[[ zhTW ]] ["Report Status Changes"] = "報告狀態變化",
	--[[ zhTW ]] ["Prints the status of nameplates whenever they change"] = "報告名牌的狀態變化",
} end)

-----------------------------------------------------------------------------

end
