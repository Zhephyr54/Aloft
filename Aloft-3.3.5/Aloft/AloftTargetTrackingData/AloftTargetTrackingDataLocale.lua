local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftTargetTrackingDataOptions")

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Target Tracking"] = true,
	--[[ enUS ]] ["Various target tracking options"] = true,

	--[[ enUS ]] ["Treat Rares and Bosses as Unique (Experimental)"] = true,
	--[[ enUS ]] ["Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"] = true,

	--[[ enUS ]] ["Enable Focus Tracking"] = true,
	--[[ enUS ]] ["Enable group focus target tracking"] = true,
	--[[ enUS ]] ["Focus Tracking Update Interval"] = true,
	--[[ enUS ]] ["The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Target Tracking"] = "Target Tracking",
	--[[ koKR ]] ["Various target tracking options"] = "Various target tracking options",

	--[[ koKR ]] ["Treat Rares and Bosses as Unique (Experimental)"] = "Treat Rares and Bosses as Unique (Experimental)",
	--[[ koKR ]] ["Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"] = "Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)",

	--[[ koKR ]] ["Enable Focus Tracking"] = "Enable Focus Tracking",
	--[[ koKR ]] ["Enable group focus target tracking"] = "Enable group focus target tracking",
	--[[ koKR ]] ["Focus Tracking Update Interval"] = "Focus Tracking Update Interval",
	--[[ koKR ]] ["The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Target Tracking"] = "Отслеживание цели",
	--[[ ruRU ]] ["Various target tracking options"] = "Настройки отслеживания цели",

	--[[ ruRU ]] ["Treat Rares and Bosses as Unique (Experimental)"] = "Рассматривать редких и боссов как уникальные (Тестируется)",
	--[[ ruRU ]] ["Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"] = "Цели редких и элитных боссов (пологаясь на классификаци и уровень) отслеживаются если их имена уникальные (Тестируется)",

	--[[ ruRU ]] ["Enable Focus Tracking"] = "Включить отслеживание фокуса",
	--[[ ruRU ]] ["Enable group focus target tracking"] = "Включить отслеживание фокуса",
	--[[ ruRU ]] ["Focus Tracking Update Interval"] = "Скорость обновления отслеживания фокуса",
	--[[ ruRU ]] ["The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"] = "Значение времени в секундах, между обновлением фокуса (0.0 максимальная скорость)",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Target Tracking"] = "Target Tracking",
	--[[ zhCN ]] ["Various target tracking options"] = "Various target tracking options",

	--[[ zhCN ]] ["Treat Rares and Bosses as Unique (Experimental)"] = "Treat Rares and Bosses as Unique (Experimental)",
	--[[ zhCN ]] ["Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"] = "Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)",

	--[[ zhCN ]] ["Enable Focus Tracking"] = "Enable Focus Tracking",
	--[[ zhCN ]] ["Enable group focus target tracking"] = "Enable group focus target tracking",
	--[[ zhCN ]] ["Focus Tracking Update Interval"] = "Focus Tracking Update Interval",
	--[[ zhCN ]] ["The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Target Tracking"] = "Target Tracking",
	--[[ zhTW ]] ["Various target tracking options"] = "Various target tracking options",

	--[[ zhTW ]] ["Treat Rares and Bosses as Unique (Experimental)"] = "Treat Rares and Bosses as Unique (Experimental)",
	--[[ zhTW ]] ["Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"] = "Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)",

	--[[ zhTW ]] ["Enable Focus Tracking"] = "Enable Focus Tracking",
	--[[ zhTW ]] ["Enable group focus target tracking"] = "Enable group focus target tracking",
	--[[ zhTW ]] ["Focus Tracking Update Interval"] = "Focus Tracking Update Interval",
	--[[ zhTW ]] ["The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)",
} end)

-----------------------------------------------------------------------------

end
