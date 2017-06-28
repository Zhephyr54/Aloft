local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftPresets")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Presets"] = true,
	--[[ enUS ]] ["Preset configurations"] = true,

	--[[ enUS ]] ["Default"] = true,
	--[[ enUS ]] ["Preset 1"] = true,
	--[[ enUS ]] ["Preset 2"] = true,
	--[[ enUS ]] ["Preset 3"] = true,
	--[[ enUS ]] ["Preset Acapela"] = true,
	--[[ enUS ]] ["Preset Unit Frame"] = true,
	--[[ enUS ]] ["Preset PvP"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Presets"] = "프리셋",
	--[[ koKR ]] ["Preset configurations"] = "프리셋 환경설정",

	--[[ koKR ]] ["Default"] = "기본형",
	--[[ koKR ]] ["Preset 1"] = "프리셋 1",
	--[[ koKR ]] ["Preset 2"] = "프리셋 2",
	--[[ koKR ]] ["Preset 3"] = "프리셋 3",
	--[[ koKR ]] ["Preset Acapela"] = "프리셋 Acapela",
	--[[ koKR ]] ["Preset Unit Frame"] = "프리셋 Unit Frame",
	--[[ koKR ]] ["Preset PvP"] = "프리셋 PvP",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Presets"] = "Предустановки",
	--[[ ruRU ]] ["Preset configurations"] = "Настройка предустановок",

	--[[ ruRU ]] ["Default"] = "По умолчанию",
	--[[ ruRU ]] ["Preset 1"] = "Предустановка 1",
	--[[ ruRU ]] ["Preset 2"] = "Предустановка 2",
	--[[ ruRU ]] ["Preset 3"] = "Предустановка 3",
	--[[ ruRU ]] ["Preset Acapela"] = "Предустановка Acapela",
	--[[ ruRU ]] ["Preset Unit Frame"] = "Предустановка рамок игроков/существ",
	--[[ ruRU ]] ["Preset PvP"] = "Предустановка PvP",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Presets"] = "设置预案",
	--[[ zhCN ]] ["Preset configurations"] = "设置预案选项",

	--[[ zhCN ]] ["Default"] = "默认",
	--[[ zhCN ]] ["Preset 1"] = "设置预案1",
	--[[ zhCN ]] ["Preset 2"] = "设置预案2",
	--[[ zhCN ]] ["Preset 3"] = "设置预案3",
	--[[ zhCN ]] ["Preset Acapela"] = "设置预案Acapela",
	--[[ zhCN ]] ["Preset Unit Frame"] = "设置预案Unit Frame",
	--[[ zhCN ]] ["Preset PvP"] = "设置预案PvP",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Presets"] = "預先設定",
	--[[ zhTW ]] ["Preset configurations"] = "預先設定",

	--[[ zhTW ]] ["Default"] = "預設",
	--[[ zhTW ]] ["Preset 1"] = "預先設定1",
	--[[ zhTW ]] ["Preset 2"] = "預先設定2",
	--[[ zhTW ]] ["Preset 3"] = "預先設定3",
	--[[ zhTW ]] ["Preset Acapela"] = "預先設定Acapela",
	--[[ zhTW ]] ["Preset Unit Frame"] = "預先設定Unit Frame",
	--[[ zhTW ]] ["Preset PvP"] = "預先設定PvP",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
