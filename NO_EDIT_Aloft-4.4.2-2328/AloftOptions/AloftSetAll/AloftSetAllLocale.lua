local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

--[[ enUS ]] L["Set All"] = "Set All"
--[[ enUS ]] L["Set all options"] = "Set all options"
--[[ enUS ]] L["Textures"] = "Textures"
--[[ enUS ]] L["Sets the texture for all status bars in Aloft"] = "Sets the texture for all status bars in Aloft"
--[[ enUS ]] L["Borders"] = "Borders"
--[[ enUS ]] L["Sets the border for all status bars in Aloft"] = "Sets the border for all status bars in Aloft"
--[[ enUS ]] L["Fonts"] = "Fonts"
--[[ enUS ]] L["Sets the font for all text in Aloft"] = "Sets the font for all text in Aloft"
--[[ enUS ]] L["Font Sizes"] = "Font Sizes"
--[[ enUS ]] L["Sets the fonts size for all text in Aloft"] = "Sets the fonts size for all text in Aloft"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Set All"] = "전체 설정"
--[[ koKR ]] L["Set all options"] = "전체 설정을 변경합니다."
--[[ koKR ]] L["Textures"] = "텍스쳐"
--[[ koKR ]] L["Borders"] = "Borders"
--[[ koKR ]] L["Sets the border for all status bars in Aloft"] = "Sets the border for all status bars in Aloft"
--[[ koKR ]] L["Sets the texture for all status bars in Aloft"] = "모든 상태바의 텍스쳐를 설정합니다."
--[[ koKR ]] L["Fonts"] = "글꼴"
--[[ koKR ]] L["Sets the font for all text in Aloft"] = "모든 글자의 글꼴을 설정합니다."
--[[ koKR ]] L["Font Sizes"] = "글꼴 크기"
--[[ koKR ]] L["Sets the fonts size for all text in Aloft"] = "모든 글자의 글꼴 크기를 설정합니다."

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Set All"] = "Задать все"
--[[ ruRU ]] L["Set all options"] = "Установить все настройки"
--[[ ruRU ]] L["Textures"] = "Текстуры"
--[[ ruRU ]] L["Sets the texture for all status bars in Aloft"] = "Задает текстуру для всех полосок состояния в Aloft"
--[[ ruRU ]] L["Borders"] = "Края"
--[[ ruRU ]] L["Sets the border for all status bars in Aloft"] = "Sets the border for all status bars in Aloft"
--[[ ruRU ]] L["Fonts"] = "Шрифты"
--[[ ruRU ]] L["Sets the font for all text in Aloft"] = "Задает шрифт для всего текста в Aloft"
--[[ ruRU ]] L["Font Sizes"] = "Размеры шрифта"
--[[ ruRU ]] L["Sets the fonts size for all text in Aloft"] = "Задает размет шрифта для всего текста Aloft"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Set All"] = "设置全部"
--[[ zhCN ]] L["Set all options"] = "设定全部选项"
--[[ zhCN ]] L["Textures"] = "材质"
--[[ zhCN ]] L["Sets the texture for all status bars in Aloft"] = "设定全部Aloft状态条的材质"
--[[ zhCN ]] L["Borders"] = "Borders"
--[[ zhCN ]] L["Sets the border for all status bars in Aloft"] = "Sets the border for all status bars in Aloft"
--[[ zhCN ]] L["Fonts"] = "字体"
--[[ zhCN ]] L["Sets the font for all text in Aloft"] = "设定全部Aloft文字的字体"
--[[ zhCN ]] L["Font Sizes"] = "字号"
--[[ zhCN ]] L["Sets the fonts size for all text in Aloft"] = "设定全部Aloft文字的字号"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Set All"] = "設定全部"
--[[ zhTW ]] L["Set all options"] = "設定全部設定"
--[[ zhTW ]] L["Textures"] = "材質"
--[[ zhTW ]] L["Sets the texture for all status bars in Aloft"] = "設定全部 Aloft 狀態條的材質"
--[[ zhTW ]] L["Borders"] = "邊框"
--[[ zhTW ]] L["Sets the border for all status bars in Aloft"] = "設定全部 Aloft 狀態條的邊框"
--[[ zhTW ]] L["Fonts"] = "字型"
--[[ zhTW ]] L["Sets the font for all text in Aloft"] = "設定全部 Aloft 文字的字型"
--[[ zhTW ]] L["Font Sizes"] = "字型大小"
--[[ zhTW ]] L["Sets the fonts size for all text in Aloft"] = "設定全部 Aloft 文字的字型大小"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftSetAll = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil
