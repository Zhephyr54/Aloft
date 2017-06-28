local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftHighlightOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Highlight"] = true,
	--[[ enUS ]] ["Mouseover highlight options"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the highlight color"] = true,
	--[[ enUS ]] ["Texture"] = true,
	--[[ enUS ]] ["Sets the highlight texture"] = true,
	--[[ enUS ]] ["Blend Mode"] = true,
	--[[ enUS ]] ["Sets the blend mode for the highlight texture"] = true,

	--[[ enUS ]] ["BLEND"] = true,
	--[[ enUS ]] ["ADD"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Highlight"] = "강조",
	--[[ koKR ]] ["Mouseover highlight options"] = "마우스 오버 시 강조 설정",
	--[[ koKR ]] ["Color"] = "색상",
	--[[ koKR ]] ["Sets the highlight color"] = "강조 색상을 설정합니다.",
	--[[ koKR ]] ["Texture"] = "텍스쳐",
	--[[ koKR ]] ["Sets the highlight texture"] = "강조 텍스쳐를 설정합니다.",
	--[[ koKR ]] ["Blend Mode"] = "혼합 모드",
	--[[ koKR ]] ["Sets the blend mode for the highlight texture"] = "강조 텍스쳐에 혼합 모드를 설정합니다.",

	--[[ koKR ]] ["BLEND"] = "혼합",
	--[[ koKR ]] ["ADD"] = "추가",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Highlight"] = "Подсветка",
	--[[ ruRU ]] ["Mouseover highlight options"] = "Настроки подсветки для цели под курсором",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the highlight color"] = "Задает цвета подсветки",
	--[[ ruRU ]] ["Texture"] = "Текстура",
	--[[ ruRU ]] ["Sets the highlight texture"] = "Задает текстуры подсветки",
	--[[ ruRU ]] ["Blend Mode"] = "Режим смешивания",
	--[[ ruRU ]] ["Sets the blend mode for the highlight texture"] = "Задает режим смешения для текстуры подсветки",

	--[[ ruRU ]] ["BLEND"] = "СМЕШИВАТЬ",
	--[[ ruRU ]] ["ADD"] = "ДОБАВИТЬ",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Highlight"] = "高亮",
	--[[ zhCN ]] ["Mouseover highlight options"] = "鼠标悬浮目标高亮相关设置",
	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the highlight color"] = "设定高亮的颜色",
	--[[ zhCN ]] ["Texture"] = "材质",
	--[[ zhCN ]] ["Sets the highlight texture"] = "设定高亮的材质",
	--[[ zhCN ]] ["Blend Mode"] = "渲染模式",
	--[[ zhCN ]] ["Sets the blend mode for the highlight texture"] = "设定高亮的材质渲染模式",

	--[[ zhCN ]] ["BLEND"] = "渲染",
	--[[ zhCN ]] ["ADD"] = "增加",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Highlight"] = "高亮",
	--[[ zhTW ]] ["Mouseover highlight options"] = "滑鼠目標高亮選項",
	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the highlight color"] = "高亮的顏色",
	--[[ zhTW ]] ["Texture"] = "紋理",
	--[[ zhTW ]] ["Sets the highlight texture"] = "高亮的紋理",
	--[[ zhTW ]] ["Blend Mode"] = "交融模式",
	--[[ zhTW ]] ["Sets the blend mode for the highlight texture"] = "高亮的紋理的交融模式",

	--[[ zhTW ]] ["BLEND"] = "混合",
	--[[ zhTW ]] ["ADD"] = "增加",
} end)

-----------------------------------------------------------------------------

end
