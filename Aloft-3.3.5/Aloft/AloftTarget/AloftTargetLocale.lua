local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftTargetNameDataOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Enable Target-of-Target"] = true,
	--[[ enUS ]] ["Enable target-of-target"] = true,
	--[[ enUS ]] ["Target-of-Target Update Interval"] = true,
	--[[ enUS ]] ["The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Enable Target-of-Target"] = "Enable Target-of-Target",
	--[[ koKR ]] ["Enable target-of-target"] = "Enable target-of-target",
	--[[ koKR ]] ["Target-of-Target Update Interval"] = "Target-of-Target Update Interval",
	--[[ koKR ]] ["The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Enable Target-of-Target"] = "Включить цель цели",
	--[[ ruRU ]] ["Enable target-of-target"] = "Включить цель цели",
	--[[ ruRU ]] ["Target-of-Target Update Interval"] = "Скорость обновления цели цели",
	--[[ ruRU ]] ["The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"] = "Время в секундах между обновленями цели цели (0.0 максимальная скорость)",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Enable Target-of-Target"] = "启用目标的目标",
	--[[ zhCN ]] ["Enable target-of-target"] = "启用目标的目标",
	--[[ zhCN ]] ["Target-of-Target Update Interval"] = "目标的目标更新延迟",
	--[[ zhCN ]] ["The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"] = "目标的目标的更新频率 （单位秒，最低值为0.0）",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Enable Target-of-Target"] = "啟用目標的目標",
	--[[ zhTW ]] ["Enable target-of-target"] = "啟用目標的目標",
	--[[ zhTW ]] ["Target-of-Target Update Interval"] = "目標的目標更新延遲",
	--[[ zhTW ]] ["The amount of time, in seconds, between target-of-target updates (0.0 is as fast as possible)"] = "目標的目標的更新頻率 （單位秒，最低值為0.0）",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
