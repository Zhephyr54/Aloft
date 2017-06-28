local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftAlphaOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Various Alpha Options"] = true,

	--[[ enUS ]] ["Target Enable"] = true,
	--[[ enUS ]] ["Enable changing alpha of target"] = true,

	--[[ enUS ]] ["Target Alpha"] = true,
	--[[ enUS ]] ["Sets the alpha of the target's nameplate"] = true,

	--[[ enUS ]] ["Non-Target Enable"] = true,
	--[[ enUS ]] ["Enable changing alpha of non-target"] = true,

	--[[ enUS ]] ["Non-Target Alpha"] = true,
	--[[ enUS ]] ["Sets the alpha of non-target nameplates"] = true,

	--[[ enUS ]] ["Default Enable"] = true,
	--[[ enUS ]] ["Enable changing alpha of default nameplates"] = true,

	--[[ enUS ]] ["Default Alpha"] = true,
	--[[ enUS ]] ["Sets the alpha of default nameplates"] = true,

	--[[ enUS ]] ["Update Interval"] = true,
	--[[ enUS ]] ["The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Various Alpha Options"] = "각각의 투명도 설정입니다.",

	--[[ koKR ]] ["Target Enable"] = "대상 사용",
	--[[ koKR ]] ["Enable changing alpha of target"] = "대상의 투명도를 변경합니다.",

	--[[ koKR ]] ["Target Alpha"] = "대상 투명도",
	--[[ koKR ]] ["Sets the alpha of the target's nameplate"] = "대상의 이름표의 투명도를 설정합니다.",

	--[[ koKR ]] ["Non-Target Enable"] = "비-대상 사용",
	--[[ koKR ]] ["Enable changing alpha of non-target"] = "비-대상의 투명도를 변경합니다.",

	--[[ koKR ]] ["Non-Target Alpha"] = "비-대상 투명도",
	--[[ koKR ]] ["Sets the alpha of non-target nameplates"] = "비-대상 이름표의 투명도를 설정합니다.",

	--[[ koKR ]] ["Default Enable"] = "기본 사용",
	--[[ koKR ]] ["Enable changing alpha of default nameplates"] = "기본 이름표의 투명도를 변경합니다.",

	--[[ koKR ]] ["Default Alpha"] = "기본 투명도",
	--[[ koKR ]] ["Sets the alpha of default nameplates"] = "기본 이름표의 투명도를 설정합니다.",

	--[[ koKR ]] ["Update Interval"] = "Update Interval",
	--[[ koKR ]] ["The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"] = "The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Various Alpha Options"] = "Прочие настройки прозрачности",

	--[[ ruRU ]] ["Target Enable"] = "Включить цель",
	--[[ ruRU ]] ["Enable changing alpha of target"] = "Включить изменение прозрачности цели",

	--[[ ruRU ]] ["Target Alpha"] = "Прозрачность цели",
	--[[ ruRU ]] ["Sets the alpha of the target's nameplate"] = "Задает прозрачность таблички цели",

	--[[ ruRU ]] ["Non-Target Enable"] = "Включить не цели",
	--[[ ruRU ]] ["Enable changing alpha of non-target"] = "Включить изменение прозрачность для не-цели",

	--[[ ruRU ]] ["Non-Target Alpha"] = "Прозрачность не целей",
	--[[ ruRU ]] ["Sets the alpha of non-target nameplates"] = "Задает прозрачность табличек не-целей",

	--[[ ruRU ]] ["Default Enable"] = "Включить по умолчанию",
	--[[ ruRU ]] ["Enable changing alpha of default nameplates"] = "Включить изменения прозрачности для стандартных табличек",

	--[[ ruRU ]] ["Default Alpha"] = "Прозрачность по умолчанию",
	--[[ ruRU ]] ["Sets the alpha of default nameplates"] = "Задает прозрачность оригинальных табличек",

	--[[ ruRU ]] ["Update Interval"] = "Время обновления",
	--[[ ruRU ]] ["The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"] = "Время в секундах между обновленями уровня прозрачности таблички (0.0 так быстро, как может интерфейс)",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Various Alpha Options"] = "透明度相关设置",

	--[[ zhCN ]] ["Target Enable"] = "对目标启用",
	--[[ zhCN ]] ["Enable changing alpha of target"] = "启用目标姓名板的透明度改变",

	--[[ zhCN ]] ["Target Alpha"] = "目标透明度",
	--[[ zhCN ]] ["Sets the alpha of the target's nameplate"] = "设定目标姓名板的透明度",

	--[[ zhCN ]] ["Non-Target Enable"] = "对非目标启用",
	--[[ zhCN ]] ["Enable changing alpha of non-target"] = "启用非目标姓名板的透明度改变",

	--[[ zhCN ]] ["Non-Target Alpha"] = "非目标透明度",
	--[[ zhCN ]] ["Sets the alpha of non-target nameplates"] = "设定非目标姓名板的透明度",

	--[[ zhCN ]] ["Default Enable"] = "对默认启用",
	--[[ zhCN ]] ["Enable changing alpha of default nameplates"] = "启用默认姓名板的透明度改变",

	--[[ zhCN ]] ["Default Alpha"] = "默认透明度",
	--[[ zhCN ]] ["Sets the alpha of default nameplates"] = "设定默认姓名板的透明度",

	--[[ zhCN ]] ["Update Interval"] = "更新频率",
	--[[ zhCN ]] ["The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"] = "姓名板透明度的更新速率，0.0秒是UI可以使用的最大值",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Various Alpha Options"] = "透明度選項",

	--[[ zhTW ]] ["Target Enable"] = "目標啟用",
	--[[ zhTW ]] ["Enable changing alpha of target"] = "啟用改變目標名牌的透明度",

	--[[ zhTW ]] ["Target Alpha"] = "目標透明度",
	--[[ zhTW ]] ["Sets the alpha of the target's nameplate"] = "設定目標名牌的透明度",

	--[[ zhTW ]] ["Non-Target Enable"] = "非目標啟用",
	--[[ zhTW ]] ["Enable changing alpha of non-target"] = "啟用改變非目標名牌的透明度",

	--[[ zhTW ]] ["Non-Target Alpha"] = "非目標透明度",
	--[[ zhTW ]] ["Sets the alpha of non-target nameplates"] = "設定非目標名牌的透明度",

	--[[ zhTW ]] ["Default Enable"] = "預設啟用",
	--[[ zhTW ]] ["Enable changing alpha of default nameplates"] = "啟用改變預設名牌的透明度",

	--[[ zhTW ]] ["Default Alpha"] = "預設透明度",
	--[[ zhTW ]] ["Sets the alpha of default nameplates"] = "設定預設名牌的透明度",

	--[[ zhTW ]] ["Update Interval"] = "更新頻率",
	--[[ zhTW ]] ["The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"] = "姓名板透明度的更新速率，0.0秒是UI可以使用的最大值",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
