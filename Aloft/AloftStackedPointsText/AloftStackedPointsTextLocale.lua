local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftStackedPointsTextOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Stacked Points Text"] = true,
	--[[ enUS ]] ["Stacked points (combo point/lacerate/sunder) text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show stacked points text"] = true,
	--[[ enUS ]] ["Stacked Points Update Interval"] = true,
	--[[ enUS ]] ["The amount of time, in seconds, between updates (0.0 is as fast as possible"] = true,

	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Stacked points text typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for stacked points text"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the stacked points text"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on stacked points text"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the font outline for stacked points text"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust stacked points text position"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the stacked points text"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the health bar to anchor the stacked points text"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the stacked points text"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the stacked points text"] = true,

	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the stacked points text color"] = true,
	--[[ enUS ]] ["Max Color"] = true,
	--[[ enUS ]] ["Sets the stacked points text color (maximum debuff time left)"] = true,
	--[[ enUS ]] ["Min Color"] = true,
	--[[ enUS ]] ["Sets the stacked points text color (minimum debuff time left)"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["TOPLEFT"] = true,
	--[[ enUS ]] ["TOP"] = true,
	--[[ enUS ]] ["TOPRIGHT"] = true,
	--[[ enUS ]] ["LEFT"] = true,
	--[[ enUS ]] ["CENTER"] = true,
	--[[ enUS ]] ["RIGHT"] = true,
	--[[ enUS ]] ["BOTTOMLEFT"] = true,
	--[[ enUS ]] ["BOTTOM"] = true,
	--[[ enUS ]] ["BOTTOMRIGHT"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Stacked Points Text"] = "Stacked Points Text",
	--[[ koKR ]] ["Stacked points (combo point/lacerate/sunder) text options"] = "Stacked points (stacked/lacerate/sunder) text options",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show stacked points text"] = "Show stacked points text",
	--[[ koKR ]] ["Stacked Points Update Interval"] = "Stacked Points Update Interval",
	--[[ koKR ]] ["The amount of time, in seconds, between updates (0.0 is as fast as possible"] = "The amount of time, in seconds, between updates (0.0 is as fast as possible",
	--[[ koKR ]] ["Font"] = "글꼴",
	--[[ koKR ]] ["Sets the font for stacked points text"] = "Sets the font for stacked points text",

	--[[ koKR ]] ["Typeface"] = "서체",
	--[[ koKR ]] ["Stacked points text typeface options"] = "Stacked points text typeface options",
	--[[ koKR ]] ["Font Size"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the font height of the stacked points text"] = "Sets the font height of the stacked points text",
	--[[ koKR ]] ["Font Shadow"] = "글꼴 그림자",
	--[[ koKR ]] ["Show font shadow on stacked points text"] = "Show font shadow on stacked points text",
	--[[ koKR ]] ["Outline"] = "테두리",
	--[[ koKR ]] ["Sets the font outline for stacked points text"] = "Sets the font outline for stacked points text",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust stacked points text position"] = "Adjust stacked points text position",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the stacked points text"] = "Sets the anchor for the stacked points text",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the health bar to anchor the stacked points text"] = "Sets the relative point on the health bar to anchor the stacked points text",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the stacked points text"] = "X offset of the stacked points text",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the stacked points text"] = "Y offset of the stacked points text",

	--[[ koKR ]] ["Color"] = "색상",
	--[[ koKR ]] ["Sets the stacked points text color"] = "Sets the stacked points text color",
	--[[ koKR ]] ["Max Color"] = "Max Color",
	--[[ koKR ]] ["Sets the stacked points text color (maximum debuff time left)"] = "Sets the stacked points text color (maximum debuff time left)",
	--[[ koKR ]] ["Min Color"] = "Min Color",
	--[[ koKR ]] ["Sets the stacked points text color (minimum debuff time left)"] = "Sets the stacked points text color (minimum debuff time left)",

	--[[ koKR ]] ["None"] = "없음",
	--[[ koKR ]] ["Normal"] = "기본",
	--[[ koKR ]] ["Thick"] = "굵게",

	--[[ koKR ]] ["TOPLEFT"] = "좌측 상단",
	--[[ koKR ]] ["TOP"] = "상단",
	--[[ koKR ]] ["TOPRIGHT"] = "우측 상단",
	--[[ koKR ]] ["LEFT"] = "좌측",
	--[[ koKR ]] ["CENTER"] = "가운데",
	--[[ koKR ]] ["RIGHT"] = "우측",
	--[[ koKR ]] ["BOTTOMLEFT"] = "좌측 하단",
	--[[ koKR ]] ["BOTTOM"] = "하단",
	--[[ koKR ]] ["BOTTOMRIGHT"] = "우측 하단",
} end)

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Stacked Points Text"] = "Текст стаков",
	--[[ ruRU ]] ["Stacked points (combo point/lacerate/sunder) text options"] = "Настройки текста стаков (стаки/растерзания/раскол)",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show stacked points text"] = "Показывать текст стаков",
	--[[ ruRU ]] ["Stacked Points Update Interval"] = "Скорость обновления стаков",
	--[[ ruRU ]] ["The amount of time, in seconds, between updates (0.0 is as fast as possible"] = "Значение времени в секундах, между обновлениями (0.0 максимальная скорость",
	--[[ ruRU ]] ["Font"] = "Шрифт",
	--[[ ruRU ]] ["Sets the font for stacked points text"] = "Установка шрифта текста стаков",

	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Stacked points text typeface options"] = "Настройка шрифта текста стаков",
	--[[ ruRU ]] ["Font Size"] = "Размер шрифта",
	--[[ ruRU ]] ["Sets the font height of the stacked points text"] = "Установка размера шрифта текста стаков",
	--[[ ruRU ]] ["Font Shadow"] = "Тень шрифта",
	--[[ ruRU ]] ["Show font shadow on stacked points text"] = "Отображать тень шрифта текста стаков",
	--[[ ruRU ]] ["Outline"] = "Контур",
	--[[ ruRU ]] ["Sets the font outline for stacked points text"] = "Установка контура шрифта текста стаков",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust stacked points text position"] = "Регулировка расположения текста стаков",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the stacked points text"] = "Установка точки прикрепленичя текста стаков",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the health bar to anchor the stacked points text"] = "Задает точку для положения полоски здоровья относительно тексту стаков",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the stacked points text"] = "Смещение текста стаков по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the stacked points text"] = "Смещение текста стаков по Y",

	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the stacked points text color"] = "Установка цвета текста стаков",
	--[[ ruRU ]] ["Max Color"] = "Цвет макс",
	--[[ ruRU ]] ["Sets the stacked points text color (maximum debuff time left)"] = "Установка цвета текста стаков (максимальный остаток времени дебаффа)",
	--[[ ruRU ]] ["Min Color"] = "Цвет мин",
	--[[ ruRU ]] ["Sets the stacked points text color (minimum debuff time left)"] = "Установка цвета текста стаков (минимальный остаток времени дебаффа)",

	--[[ ruRU ]] ["None"] = "Нет",
	--[[ ruRU ]] ["Normal"] = "Обычно",
	--[[ ruRU ]] ["Thick"] = "Жирный",

	--[[ ruRU ]] ["TOPLEFT"] = "ВВЕРХУ-СЛЕВА",
	--[[ ruRU ]] ["TOP"] = "ВВЕРХУ",
	--[[ ruRU ]] ["TOPRIGHT"] = "ВВЕРХУ-СПРАВА",
	--[[ ruRU ]] ["LEFT"] = "СЛЕВА",
	--[[ ruRU ]] ["CENTER"] = "ПО ЦЕНТРУ",
	--[[ ruRU ]] ["RIGHT"] = "СПРАВА",
	--[[ ruRU ]] ["BOTTOMLEFT"] = "СНИЗУ-СЛЕВА",
	--[[ ruRU ]] ["BOTTOM"] = "СНИЗУ",
	--[[ ruRU ]] ["BOTTOMRIGHT"] = "СНИЗУ-СПРАВА",
} end)

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Stacked Points Text"] = "连击点提示文字",
	--[[ zhCN ]] ["Stacked points (combo point/lacerate/sunder) text options"] = "累积点数（叠加/割裂/破甲计数）文本选项",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show stacked points text"] = "显示累积点数文本",
	--[[ zhCN ]] ["Stacked Points Update Interval"] = "累积点数更新频率",
	--[[ zhCN ]] ["The amount of time, in seconds, between updates (0.0 is as fast as possible"] = "更新速度（单位为秒，0.0为最快）",
	--[[ zhCN ]] ["Font"] = "字体",
	--[[ zhCN ]] ["Sets the font for stacked points text"] = "设置累积点数的文本",

	--[[ zhCN ]] ["Typeface"] = "式样",
	--[[ zhCN ]] ["Stacked points text typeface options"] = "累积点数文本样式选项",
	--[[ zhCN ]] ["Font Size"] = "字号",
	--[[ zhCN ]] ["Sets the font height of the stacked points text"] = "设置累积点数文本大小",
	--[[ zhCN ]] ["Font Shadow"] = "字体阴影",
	--[[ zhCN ]] ["Show font shadow on stacked points text"] = "累积点数文本显示阴影",
	--[[ zhCN ]] ["Outline"] = "轮廓",
	--[[ zhCN ]] ["Sets the font outline for stacked points text"] = "累积点数文本使用描边",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust stacked points text position"] = "调整累积点数文本位置",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the stacked points text"] = "设置累积点数文本锚点",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the health bar to anchor the stacked points text"] = "设置将累积点数附着到生命条的哪个位置",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the stacked points text"] = "累积点数水平偏移",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the stacked points text"] = "累积点数垂直偏移",

	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the stacked points text color"] = "累积点数文本颜色",
	--[[ zhCN ]] ["Max Color"] = "最大值颜色",
	--[[ zhCN ]] ["Sets the stacked points text color (maximum debuff time left)"] = "累积点数文本的颜色（最大debuff时间剩余）",
	--[[ zhCN ]] ["Min Color"] = "最小值颜色",
	--[[ zhCN ]] ["Sets the stacked points text color (minimum debuff time left)"] = "累积点数文本的颜色（最小debuff时间剩余）",

	--[[ zhCN ]] ["None"] = "无",
	--[[ zhCN ]] ["Normal"] = "正常",
	--[[ zhCN ]] ["Thick"] = "粗",

	--[[ zhCN ]] ["TOPLEFT"] = "左上",
	--[[ zhCN ]] ["TOP"] = "上",
	--[[ zhCN ]] ["TOPRIGHT"] = "右上",
	--[[ zhCN ]] ["LEFT"] = "左",
	--[[ zhCN ]] ["CENTER"] = "中",
	--[[ zhCN ]] ["RIGHT"] = "右",
	--[[ zhCN ]] ["BOTTOMLEFT"] = "左下",
	--[[ zhCN ]] ["BOTTOM"] = "下",
	--[[ zhCN ]] ["BOTTOMRIGHT"] = "右下",
} end)

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Stacked Points Text"] = "連擊點提示文字",
	--[[ zhTW ]] ["Stacked points (combo point/lacerate/sunder) text options"] = "累積點數（疊加/割裂/破甲計數）文本選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show stacked points text"] = "顯示累積點數文本",
	--[[ zhTW ]] ["Stacked Points Update Interval"] = "累積點數更新頻率",
	--[[ zhTW ]] ["The amount of time, in seconds, between updates (0.0 is as fast as possible"] = "更新速度（單位為秒，0.0為最快）",
	--[[ zhTW ]] ["Font"] = "字體",
	--[[ zhTW ]] ["Sets the font for stacked points text"] = "設置累積點數的文本",

	--[[ zhTW ]] ["Typeface"] = "式樣",
	--[[ zhTW ]] ["Stacked points text typeface options"] = "累積點數文本樣式選項",
	--[[ zhTW ]] ["Font Size"] = "字型大小",
	--[[ zhTW ]] ["Sets the font height of the stacked points text"] = "設置累積點數文本大小",
	--[[ zhTW ]] ["Font Shadow"] = "字體陰影",
	--[[ zhTW ]] ["Show font shadow on stacked points text"] = "累積點數文本顯示陰影",
	--[[ zhTW ]] ["Outline"] = "輪廓",
	--[[ zhTW ]] ["Sets the font outline for stacked points text"] = "累積點數文本使用描邊",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust stacked points text position"] = "調整累積點數文本位置",
	--[[ zhTW ]] ["Anchor"] = "錨點",
	--[[ zhTW ]] ["Sets the anchor for the stacked points text"] = "設置累積點數文本錨點",
	--[[ zhTW ]] ["Anchor To"] = "固定在",
	--[[ zhTW ]] ["Sets the relative point on the health bar to anchor the stacked points text"] = "設置將累積點數附著到生命條的哪個位置",
	--[[ zhTW ]] ["X Offset"] = "X軸偏移",
	--[[ zhTW ]] ["X offset of the stacked points text"] = "累積點數水平偏移",
	--[[ zhTW ]] ["Y Offset"] = "Y軸偏移",
	--[[ zhTW ]] ["Y offset of the stacked points text"] = "累積點數垂直偏移",

	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the stacked points text color"] = "累積點數文本顏色",
	--[[ zhTW ]] ["Max Color"] = "最大值顏色",
	--[[ zhTW ]] ["Sets the stacked points text color (maximum debuff time left)"] = "累積點數文本的顏色（最大debuff時間剩餘）",
	--[[ zhTW ]] ["Min Color"] = "最小值顏色",
	--[[ zhTW ]] ["Sets the stacked points text color (minimum debuff time left)"] = "累積點數文本的顏色（最小debuff時間剩餘）",

	--[[ zhTW ]] ["None"] = "無",
	--[[ zhTW ]] ["Normal"] = "正常",
	--[[ zhTW ]] ["Thick"] = "粗",

	--[[ zhTW ]] ["TOPLEFT"] = "左上",
	--[[ zhTW ]] ["TOP"] = "上",
	--[[ zhTW ]] ["TOPRIGHT"] = "右上",
	--[[ zhTW ]] ["LEFT"] = "左",
	--[[ zhTW ]] ["CENTER"] = "中",
	--[[ zhTW ]] ["RIGHT"] = "右",
	--[[ zhTW ]] ["BOTTOMLEFT"] = "左下",
	--[[ zhTW ]] ["BOTTOM"] = "下",
	--[[ zhTW ]] ["BOTTOMRIGHT"] = "右下",
} end)

end)

-----------------------------------------------------------------------------

end
