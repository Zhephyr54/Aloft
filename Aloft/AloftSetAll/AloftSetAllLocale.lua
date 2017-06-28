local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftSetAll")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Set All"] = true,
	--[[ enUS ]] ["Set all options"] = true,
	--[[ enUS ]] ["Textures"] = true,
	--[[ enUS ]] ["Sets the texture for all status bars in Aloft"] = true,
	--[[ enUS ]] ["Fonts"] = true,
	--[[ enUS ]] ["Sets the font for all text in Aloft"] = true,
	--[[ enUS ]] ["Font Sizes"] = true,
	--[[ enUS ]] ["Sets the fonts size for all text in Aloft"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Set All"] = "전체 설정",
	--[[ koKR ]] ["Set all options"] = "전체 설정을 변경합니다.",
	--[[ koKR ]] ["Textures"] = "텍스쳐",
	--[[ koKR ]] ["Sets the texture for all status bars in Aloft"] = "모든 상태바의 텍스쳐를 설정합니다.",
	--[[ koKR ]] ["Fonts"] = "글꼴",
	--[[ koKR ]] ["Sets the font for all text in Aloft"] = "모든 글자의 글꼴을 설정합니다.",
	--[[ koKR ]] ["Font Sizes"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the fonts size for all text in Aloft"] = "모든 글자의 글꼴 크기를 설정합니다.",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Set All"] = "Задать все",
	--[[ ruRU ]] ["Set all options"] = "Установить все настройки",
	--[[ ruRU ]] ["Textures"] = "Текстуры",
	--[[ ruRU ]] ["Sets the texture for all status bars in Aloft"] = "Задает текстуру для всех полосок состояния в Aloft",
	--[[ ruRU ]] ["Fonts"] = "Шрифты",
	--[[ ruRU ]] ["Sets the font for all text in Aloft"] = "Задает шрифт для всего текста в Aloft",
	--[[ ruRU ]] ["Font Sizes"] = "Размеры шрифта",
	--[[ ruRU ]] ["Sets the fonts size for all text in Aloft"] = "Задает размет шрифта для всего текста Aloft",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Set All"] = "设置全部",
	--[[ zhCN ]] ["Set all options"] = "设定全部选项",
	--[[ zhCN ]] ["Textures"] = "材质",
	--[[ zhCN ]] ["Sets the texture for all status bars in Aloft"] = "设定全部Aloft状态条的材质",
	--[[ zhCN ]] ["Fonts"] = "字体",
	--[[ zhCN ]] ["Sets the font for all text in Aloft"] = "设定全部Aloft文字的字体",
	--[[ zhCN ]] ["Font Sizes"] = "字号",
	--[[ zhCN ]] ["Sets the fonts size for all text in Aloft"] = "设定全部Aloft文字的字号",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Set All"] = "設定全部",
	--[[ zhTW ]] ["Set all options"] = "設定全部選項",
	--[[ zhTW ]] ["Textures"] = "紋理",
	--[[ zhTW ]] ["Sets the texture for all status bars in Aloft"] = "設定全部 Aloft 狀態條的紋理",
	--[[ zhTW ]] ["Fonts"] = "字型",
	--[[ zhTW ]] ["Sets the font for all text in Aloft"] = "設定全部 Aloft 文字的字型",
	--[[ zhTW ]] ["Font Sizes"] = "字型大小",
	--[[ zhTW ]] ["Sets the fonts size for all text in Aloft"] = "設定全部 Aloft 文字的字型大小",
} end)

-----------------------------------------------------------------------------

end
