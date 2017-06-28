local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local dL = AceLibrary("AceLocale-2.2"):new("AloftPlayerTitleData")

-----------------------------------------------------------------------------

local oL = AceLibrary("AceLocale-2.2"):new("AloftPlayerTitleDataOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["PrefixTest"] = "(.*) %s(.*)",
	--[[ enUS ]] ["SuffixTest1"] = "(.*)%s, (.*)",
	--[[ enUS ]] ["SuffixTest2"] = "(.*)%s (.*)",
	
	--[[ enUS ]] ["Unknown"] = true, -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Save Player Title Data"] = true,
	--[[ enUS ]] ["Stores player title information between sessions"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["PrefixTest"] = "(.*) %s(.*)",
	--[[ koKR ]] ["SuffixTest1"] = "(.*)%s, (.*)",
	--[[ koKR ]] ["SuffixTest2"] = "(.*)%s (.*)",

	--[[ koKR ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Save Player Title Data"] = "Save Player Title Data",
	--[[ koKR ]] ["Stores player title information between sessions"] = "Stores player title information between sessions",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["PrefixTest"] = "(.*) %s(.*)",
	--[[ ruRU ]] ["SuffixTest1"] = "(.*)%s, (.*)",
	--[[ ruRU ]] ["SuffixTest2"] = "(.*)%s (.*)",

	--[[ ruRU ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Save Player Title Data"] = "Записать данные о титулах игрока",
	--[[ ruRU ]] ["Stores player title information between sessions"] = "Сохранять данные о титулах игрока между сессиями",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["PrefixTest"] = "(.*) %s(.*)",
	--[[ zhCN ]] ["SuffixTest1"] = "(.*)%s, (.*)",
	--[[ zhCN ]] ["SuffixTest2"] = "(.*)%s (.*)",

	--[[ zhCN ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Save Player Title Data"] = "保存玩家头衔数据",
	--[[ zhCN ]] ["Stores player title information between sessions"] = "在两次登录的间隔保存玩家头衔数据",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["PrefixTest"] = "(.*) %s(.*)",
	--[[ zhTW ]] ["SuffixTest1"] = "(.*)%s, (.*)",
	--[[ zhTW ]] ["SuffixTest2"] = "(.*)%s (.*)",

	--[[ zhTW ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Save Player Title Data"] = "保存玩家頭銜數據",
	--[[ zhTW ]] ["Stores player title information between sessions"] = "登入期間保存玩家頭銜數據",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
