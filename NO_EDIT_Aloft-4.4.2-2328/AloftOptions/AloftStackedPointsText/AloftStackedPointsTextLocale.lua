local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
if not AloftLocale or not AloftLocale.AloftModules then return end

-----------------------------------------------------------------------------

local L = { }

local mL = AloftLocale.AloftModules

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

-- TODO: on the surface, this wastes space in the enUS locale; the metatable could just return the canonical string as the localization;
--       BUT, this serves as a default locale, and also will permit the metatable to check/notify on missing locale strings

--[[ enUS ]] L["Stacked Points Text"] = "Stacked Points Text"
--[[ enUS ]] L["Stacked points (combo point/lacerate/sunder) text options"] = "Stacked points (combo point/lacerate/sunder) text options"
--[[ enUS ]] L["Enable"] = "Enable"
--[[ enUS ]] L["Show stacked points text"] = "Show stacked points text"
--[[ enUS ]] L["Stacked Points Update Interval"] = "Stacked Points Update Interval"
--[[ enUS ]] L["The amount of time, in seconds, between updates (0.0 is as fast as possible"] = "The amount of time, in seconds, between updates (0.0 is as fast as possible"

--[[ enUS ]] L["Typeface"] = "Typeface"
--[[ enUS ]] L["Stacked points text typeface options"] = "Stacked points text typeface options"
--[[ enUS ]] L["Font"] = "Font"
--[[ enUS ]] L["Sets the font for stacked points text"] = "Sets the font for stacked points text"
--[[ enUS ]] L["Font Size"] = "Font Size"
--[[ enUS ]] L["Sets the font height of the stacked points text"] = "Sets the font height of the stacked points text"
--[[ enUS ]] L["Font Shadow"] = "Font Shadow"
--[[ enUS ]] L["Show font shadow on stacked points text"] = "Show font shadow on stacked points text"
--[[ enUS ]] L["Outline"] = "Outline"
--[[ enUS ]] L["Sets the font outline for stacked points text"] = "Sets the font outline for stacked points text"

--[[ enUS ]] L["Position"] = "Position"
--[[ enUS ]] L["Adjust stacked points text position"] = "Adjust stacked points text position"
--[[ enUS ]] L["Anchor"] = "Anchor"
--[[ enUS ]] L["Sets the anchor for the stacked points text"] = "Sets the anchor for the stacked points text"
--[[ enUS ]] L["Anchor To"] = "Anchor To"
--[[ enUS ]] L["Sets the relative point on the health bar to anchor the stacked points text"] = "Sets the relative point on the health bar to anchor the stacked points text"
--[[ enUS ]] L["X Offset"] = "X Offset"
--[[ enUS ]] L["X offset of the stacked points text"] = "X offset of the stacked points text"
--[[ enUS ]] L["Y Offset"] = "Y Offset"
--[[ enUS ]] L["Y offset of the stacked points text"] = "Y offset of the stacked points text"

--[[ enUS ]] L["Color"] = "Color"
--[[ enUS ]] L["Sets the stacked points text color"] = "Sets the stacked points text color"
--[[ enUS ]] L["Max Color"] = "Max Color"
--[[ enUS ]] L["Sets the stacked points text color (maximum debuff time left)"] = "Sets the stacked points text color (maximum debuff time left)"
--[[ enUS ]] L["Min Color"] = "Min Color"
--[[ enUS ]] L["Sets the stacked points text color (minimum debuff time left)"] = "Sets the stacked points text color (minimum debuff time left)"

--[[ enUS ]] L["None"] = "None"
--[[ enUS ]] L["Normal"] = "Normal"
--[[ enUS ]] L["Thick"] = "Thick"

--[[ enUS ]] L["TOPLEFT"] = "TOPLEFT"
--[[ enUS ]] L["TOP"] = "TOP"
--[[ enUS ]] L["TOPRIGHT"] = "TOPRIGHT"
--[[ enUS ]] L["LEFT"] = "LEFT"
--[[ enUS ]] L["CENTER"] = "CENTER"
--[[ enUS ]] L["RIGHT"] = "RIGHT"
--[[ enUS ]] L["BOTTOMLEFT"] = "BOTTOMLEFT"
--[[ enUS ]] L["BOTTOM"] = "BOTTOM"
--[[ enUS ]] L["BOTTOMRIGHT"] = "BOTTOMRIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftStackedPointsText"] = "AloftStackedPointsText"
--[[ enUS ]] mL["Display stacked points (combo point/lacerate/sunder counts) on nameplates"] = "Display stacked points (combo point/lacerate/sunder counts) on nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

--[[ koKR ]] L["Stacked Points Text"] = "Stacked Points Text"
--[[ koKR ]] L["Stacked points (combo point/lacerate/sunder) text options"] = "Stacked points (stacked/lacerate/sunder) text options"
--[[ koKR ]] L["Enable"] = "사용"
--[[ koKR ]] L["Show stacked points text"] = "Show stacked points text"
--[[ koKR ]] L["Stacked Points Update Interval"] = "Stacked Points Update Interval"
--[[ koKR ]] L["The amount of time, in seconds, between updates (0.0 is as fast as possible"] = "The amount of time, in seconds, between updates (0.0 is as fast as possible"
--[[ koKR ]] L["Font"] = "글꼴"
--[[ koKR ]] L["Sets the font for stacked points text"] = "Sets the font for stacked points text"

--[[ koKR ]] L["Typeface"] = "서체"
--[[ koKR ]] L["Stacked points text typeface options"] = "Stacked points text typeface options"
--[[ koKR ]] L["Font Size"] = "글꼴 크기"
--[[ koKR ]] L["Sets the font height of the stacked points text"] = "Sets the font height of the stacked points text"
--[[ koKR ]] L["Font Shadow"] = "글꼴 그림자"
--[[ koKR ]] L["Show font shadow on stacked points text"] = "Show font shadow on stacked points text"
--[[ koKR ]] L["Outline"] = "테두리"
--[[ koKR ]] L["Sets the font outline for stacked points text"] = "Sets the font outline for stacked points text"

--[[ koKR ]] L["Position"] = "위치"
--[[ koKR ]] L["Adjust stacked points text position"] = "Adjust stacked points text position"
--[[ koKR ]] L["Anchor"] = "앵커"
--[[ koKR ]] L["Sets the anchor for the stacked points text"] = "Sets the anchor for the stacked points text"
--[[ koKR ]] L["Anchor To"] = "앵커 위치"
--[[ koKR ]] L["Sets the relative point on the health bar to anchor the stacked points text"] = "Sets the relative point on the health bar to anchor the stacked points text"
--[[ koKR ]] L["X Offset"] = "X 좌표"
--[[ koKR ]] L["X offset of the stacked points text"] = "X offset of the stacked points text"
--[[ koKR ]] L["Y Offset"] = "Y 좌표"
--[[ koKR ]] L["Y offset of the stacked points text"] = "Y offset of the stacked points text"

--[[ koKR ]] L["Color"] = "색상"
--[[ koKR ]] L["Sets the stacked points text color"] = "Sets the stacked points text color"
--[[ koKR ]] L["Max Color"] = "Max Color"
--[[ koKR ]] L["Sets the stacked points text color (maximum debuff time left)"] = "Sets the stacked points text color (maximum debuff time left)"
--[[ koKR ]] L["Min Color"] = "Min Color"
--[[ koKR ]] L["Sets the stacked points text color (minimum debuff time left)"] = "Sets the stacked points text color (minimum debuff time left)"

--[[ koKR ]] L["None"] = "없음"
--[[ koKR ]] L["Normal"] = "기본"
--[[ koKR ]] L["Thick"] = "굵게"

--[[ koKR ]] L["TOPLEFT"] = "좌측 상단"
--[[ koKR ]] L["TOP"] = "상단"
--[[ koKR ]] L["TOPRIGHT"] = "우측 상단"
--[[ koKR ]] L["LEFT"] = "좌측"
--[[ koKR ]] L["CENTER"] = "가운데"
--[[ koKR ]] L["RIGHT"] = "우측"
--[[ koKR ]] L["BOTTOMLEFT"] = "좌측 하단"
--[[ koKR ]] L["BOTTOM"] = "하단"
--[[ koKR ]] L["BOTTOMRIGHT"] = "우측 하단"

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftStackedPointsText"] = "AloftStackedPointsText"
--[[ koKR ]] mL["Display stacked points (combo point/lacerate/sunder counts) on nameplates"] = "Display stacked points (combo point/lacerate/sunder counts) on nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Stacked Points Text"] = "Текст стаков"
--[[ ruRU ]] L["Stacked points (combo point/lacerate/sunder) text options"] = "Настройки текста стаков (стаки/растерзания/раскол)"
--[[ ruRU ]] L["Enable"] = "Включить"
--[[ ruRU ]] L["Show stacked points text"] = "Показывать текст стаков"
--[[ ruRU ]] L["Stacked Points Update Interval"] = "Скорость обновления стаков"
--[[ ruRU ]] L["The amount of time, in seconds, between updates (0.0 is as fast as possible"] = "Значение времени в секундах, между обновлениями (0.0 максимальная скорость"
--[[ ruRU ]] L["Font"] = "Шрифт"
--[[ ruRU ]] L["Sets the font for stacked points text"] = "Установка шрифта текста стаков"

--[[ ruRU ]] L["Typeface"] = "Шрифт"
--[[ ruRU ]] L["Stacked points text typeface options"] = "Настройка шрифта текста стаков"
--[[ ruRU ]] L["Font Size"] = "Размер шрифта"
--[[ ruRU ]] L["Sets the font height of the stacked points text"] = "Установка размера шрифта текста стаков"
--[[ ruRU ]] L["Font Shadow"] = "Тень шрифта"
--[[ ruRU ]] L["Show font shadow on stacked points text"] = "Отображать тень шрифта текста стаков"
--[[ ruRU ]] L["Outline"] = "Контур"
--[[ ruRU ]] L["Sets the font outline for stacked points text"] = "Установка контура шрифта текста стаков"

--[[ ruRU ]] L["Position"] = "Позиция"
--[[ ruRU ]] L["Adjust stacked points text position"] = "Регулировка расположения текста стаков"
--[[ ruRU ]] L["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] L["Sets the anchor for the stacked points text"] = "Установка точки прикрепленичя текста стаков"
--[[ ruRU ]] L["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] L["Sets the relative point on the health bar to anchor the stacked points text"] = "Задает точку для положения полоски здоровья относительно тексту стаков"
--[[ ruRU ]] L["X Offset"] = "Смещение по X"
--[[ ruRU ]] L["X offset of the stacked points text"] = "Смещение текста стаков по X"
--[[ ruRU ]] L["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] L["Y offset of the stacked points text"] = "Смещение текста стаков по Y"

--[[ ruRU ]] L["Color"] = "Цвет"
--[[ ruRU ]] L["Sets the stacked points text color"] = "Установка цвета текста стаков"
--[[ ruRU ]] L["Max Color"] = "Цвет макс"
--[[ ruRU ]] L["Sets the stacked points text color (maximum debuff time left)"] = "Установка цвета текста стаков (максимальный остаток времени дебаффа)"
--[[ ruRU ]] L["Min Color"] = "Цвет мин"
--[[ ruRU ]] L["Sets the stacked points text color (minimum debuff time left)"] = "Установка цвета текста стаков (минимальный остаток времени дебаффа)"

--[[ ruRU ]] L["None"] = "Нет"
--[[ ruRU ]] L["Normal"] = "Обычно"
--[[ ruRU ]] L["Thick"] = "Жирный"

--[[ ruRU ]] L["TOPLEFT"] = "ВВЕРХУ-СЛЕВА"
--[[ ruRU ]] L["TOP"] = "ВВЕРХУ"
--[[ ruRU ]] L["TOPRIGHT"] = "ВВЕРХУ-СПРАВА"
--[[ ruRU ]] L["LEFT"] = "СЛЕВА"
--[[ ruRU ]] L["CENTER"] = "ПО ЦЕНТРУ"
--[[ ruRU ]] L["RIGHT"] = "СПРАВА"
--[[ ruRU ]] L["BOTTOMLEFT"] = "СНИЗУ-СЛЕВА"
--[[ ruRU ]] L["BOTTOM"] = "СНИЗУ"
--[[ ruRU ]] L["BOTTOMRIGHT"] = "СНИЗУ-СПРАВА"

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftStackedPointsText"] = "AloftStackedPointsText"
--[[ ruRU ]] mL["Display stacked points (combo point/lacerate/sunder counts) on nameplates"] = "Отображает стаки (значение приёмов в серии/растерзать/раскол брони)"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Stacked Points Text"] = "连击点提示文字"
--[[ zhCN ]] L["Stacked points (combo point/lacerate/sunder) text options"] = "累积点数（叠加/割裂/破甲计数）文本选项"
--[[ zhCN ]] L["Enable"] = "启用"
--[[ zhCN ]] L["Show stacked points text"] = "显示累积点数文本"
--[[ zhCN ]] L["Stacked Points Update Interval"] = "累积点数更新频率"
--[[ zhCN ]] L["The amount of time, in seconds, between updates (0.0 is as fast as possible"] = "更新速度（单位为秒，0.0为最快）"
--[[ zhCN ]] L["Font"] = "字体"
--[[ zhCN ]] L["Sets the font for stacked points text"] = "设置累积点数的文本"

--[[ zhCN ]] L["Typeface"] = "式样"
--[[ zhCN ]] L["Stacked points text typeface options"] = "累积点数文本样式选项"
--[[ zhCN ]] L["Font Size"] = "字号"
--[[ zhCN ]] L["Sets the font height of the stacked points text"] = "设置累积点数文本大小"
--[[ zhCN ]] L["Font Shadow"] = "字体阴影"
--[[ zhCN ]] L["Show font shadow on stacked points text"] = "累积点数文本显示阴影"
--[[ zhCN ]] L["Outline"] = "轮廓"
--[[ zhCN ]] L["Sets the font outline for stacked points text"] = "累积点数文本使用描边"

--[[ zhCN ]] L["Position"] = "位置"
--[[ zhCN ]] L["Adjust stacked points text position"] = "调整累积点数文本位置"
--[[ zhCN ]] L["Anchor"] = "锚点"
--[[ zhCN ]] L["Sets the anchor for the stacked points text"] = "设置累积点数文本锚点"
--[[ zhCN ]] L["Anchor To"] = "固定在"
--[[ zhCN ]] L["Sets the relative point on the health bar to anchor the stacked points text"] = "设置将累积点数附着到生命条的哪个位置"
--[[ zhCN ]] L["X Offset"] = "X轴偏移"
--[[ zhCN ]] L["X offset of the stacked points text"] = "累积点数水平偏移"
--[[ zhCN ]] L["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] L["Y offset of the stacked points text"] = "累积点数垂直偏移"

--[[ zhCN ]] L["Color"] = "颜色"
--[[ zhCN ]] L["Sets the stacked points text color"] = "累积点数文本颜色"
--[[ zhCN ]] L["Max Color"] = "最大值颜色"
--[[ zhCN ]] L["Sets the stacked points text color (maximum debuff time left)"] = "累积点数文本的颜色（最大debuff时间剩余）"
--[[ zhCN ]] L["Min Color"] = "最小值颜色"
--[[ zhCN ]] L["Sets the stacked points text color (minimum debuff time left)"] = "累积点数文本的颜色（最小debuff时间剩余）"

--[[ zhCN ]] L["None"] = "无"
--[[ zhCN ]] L["Normal"] = "正常"
--[[ zhCN ]] L["Thick"] = "粗"

--[[ zhCN ]] L["TOPLEFT"] = "左上"
--[[ zhCN ]] L["TOP"] = "上"
--[[ zhCN ]] L["TOPRIGHT"] = "右上"
--[[ zhCN ]] L["LEFT"] = "左"
--[[ zhCN ]] L["CENTER"] = "中"
--[[ zhCN ]] L["RIGHT"] = "右"
--[[ zhCN ]] L["BOTTOMLEFT"] = "左下"
--[[ zhCN ]] L["BOTTOM"] = "下"
--[[ zhCN ]] L["BOTTOMRIGHT"] = "右下"

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftStackedPointsText"] = "累积点数文本"
--[[ zhCN ]] mL["Display stacked points (combo point/lacerate/sunder counts) on nameplates"] = "显示累积点数（连击点/割裂/破甲层数）"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Stacked Points Text"] = "累積點文字"
--[[ zhTW ]] L["Stacked points (combo point/lacerate/sunder) text options"] = "累積點（連擊點/割裂/破甲）文字設定"
--[[ zhTW ]] L["Enable"] = "啟用"
--[[ zhTW ]] L["Show stacked points text"] = "顯示累積點文字"
--[[ zhTW ]] L["Stacked Points Update Interval"] = "累積點更新頻率"
--[[ zhTW ]] L["The amount of time, in seconds, between updates (0.0 is as fast as possible"] = "更新速度（單位為秒，0.0為最快）"
--[[ zhTW ]] L["Font"] = "字型"
--[[ zhTW ]] L["Sets the font for stacked points text"] = "設定累積點的字型"

--[[ zhTW ]] L["Typeface"] = "字體"
--[[ zhTW ]] L["Stacked points text typeface options"] = "累積點文字字體設定"
--[[ zhTW ]] L["Font Size"] = "字型大小"
--[[ zhTW ]] L["Sets the font height of the stacked points text"] = "設定累積點文字的字型高度"
--[[ zhTW ]] L["Font Shadow"] = "字型陰影"
--[[ zhTW ]] L["Show font shadow on stacked points text"] = "在累積點數文字上顯示字型陰影"
--[[ zhTW ]] L["Outline"] = "輪廓"
--[[ zhTW ]] L["Sets the font outline for stacked points text"] = "設定累積點文字的字型輪廓"

--[[ zhTW ]] L["Position"] = "位置"
--[[ zhTW ]] L["Adjust stacked points text position"] = "調整累積點文字位置"
--[[ zhTW ]] L["Anchor"] = "錨點"
--[[ zhTW ]] L["Sets the anchor for the stacked points text"] = "設定累積點文字的錨點"
--[[ zhTW ]] L["Anchor To"] = "錨點到"
--[[ zhTW ]] L["Sets the relative point on the health bar to anchor the stacked points text"] = "設定在生命條上錨到累積點文字的相關點"
--[[ zhTW ]] L["X Offset"] = "X偏移"
--[[ zhTW ]] L["X offset of the stacked points text"] = "累積點文字的X偏移"
--[[ zhTW ]] L["Y Offset"] = "Y偏移"
--[[ zhTW ]] L["Y offset of the stacked points text"] = "累積點文字的Y偏移"

--[[ zhTW ]] L["Color"] = "顏色"
--[[ zhTW ]] L["Sets the stacked points text color"] = "累積點文字顏色"
--[[ zhTW ]] L["Max Color"] = "最大顏色"
--[[ zhTW ]] L["Sets the stacked points text color (maximum debuff time left)"] = "設定累積點文字的顏色（最大debuff時間剩餘）"
--[[ zhTW ]] L["Min Color"] = "最小顏色"
--[[ zhTW ]] L["Sets the stacked points text color (minimum debuff time left)"] = "設定累積點文字的顏色（最小debuff時間剩餘）"

--[[ zhTW ]] L["None"] = "無"
--[[ zhTW ]] L["Normal"] = "正常"
--[[ zhTW ]] L["Thick"] = "粗"

--[[ zhTW ]] L["TOPLEFT"] = "上左"
--[[ zhTW ]] L["TOP"] = "上"
--[[ zhTW ]] L["TOPRIGHT"] = "上右"
--[[ zhTW ]] L["LEFT"] = "左"
--[[ zhTW ]] L["CENTER"] = "中"
--[[ zhTW ]] L["RIGHT"] = "右"
--[[ zhTW ]] L["BOTTOMLEFT"] = "下左"
--[[ zhTW ]] L["BOTTOM"] = "下"
--[[ zhTW ]] L["BOTTOMRIGHT"] = "下右"

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftStackedPointsText"] = "Aloft累積點文字"
--[[ zhTW ]] mL["Display stacked points (combo point/lacerate/sunder counts) on nameplates"] = "在名牌上顯示累積點（連擊點/割裂/破甲）"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

AloftLocale.AloftStackedPointsTextOptions = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

-----------------------------------------------------------------------------

end)
