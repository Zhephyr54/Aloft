local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftStateIconOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["State Icon"] = true,
	--[[ enUS ]] ["State icon placement options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Enable state icon display on the nameplate"] = true,
	--[[ enUS ]] ["Reverse"] = true,
	--[[ enUS ]] ["Reverse the state icon graphic horizontally"] = true,
	--[[ enUS ]] ["Height"] = true,
	--[[ enUS ]] ["Height in pixels of the state icon"] = true,
	--[[ enUS ]] ["Width"] = true,
	--[[ enUS ]] ["Width in pixels of the state icon"] = true,
	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust state icon position"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the state icon"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the state icon"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the state icon"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the health bar to anchor the state icon"] = true,
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Sets the state icon alpha"] = true,

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

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["State Icon"] = "보스 아이콘",
	--[[ koKR ]] ["State icon placement options"] = "보스 아이콘 배치 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Enable state icon display on the nameplate"] = "Enable state icon display on the nameplate",
	--[[ koKR ]] ["Reverse"] = "Reverse",
	--[[ koKR ]] ["Reverse the state icon graphic horizontally"] = "Reverse the state icon graphic horizontally",
	--[[ koKR ]] ["Height"] = "크기",
	--[[ koKR ]] ["Height in pixels of the state icon"] = "Height in pixels of the state icon",
	--[[ koKR ]] ["Width"] = "크기",
	--[[ koKR ]] ["Width in pixels of the state icon"] = "Width in pixels of the state icon",
	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust state icon position"] = "Adjust state icon position",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the state icon"] = "X offset of the state icon",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the state icon"] = "Y offset of the state icon",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the state icon"] = "Sets the anchor for the state icon",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the health bar to anchor the state icon"] = "Sets the relative point on the health bar to anchor the state icon",
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Sets the state icon alpha"] = "Sets the state icon alpha",

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

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["State Icon"] = "Иконка состояния",
	--[[ ruRU ]] ["State icon placement options"] = "Настрокий положения иконки состояния",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Enable state icon display on the nameplate"] = "Включает отображение иконки состояния",
	--[[ ruRU ]] ["Reverse"] = "Перевернуть",
	--[[ ruRU ]] ["Reverse the state icon graphic horizontally"] = "Переварачивает иконку состояния по горизонтале",
	--[[ ruRU ]] ["Height"] = "Высота",
	--[[ ruRU ]] ["Height in pixels of the state icon"] = "Высота иконки состояния в пикселях",
	--[[ ruRU ]] ["Width"] = "Ширина",
	--[[ ruRU ]] ["Width in pixels of the state icon"] = "Ширина иконки состояния в пикселях",
	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust state icon position"] = "Задать место иконки состояния",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the state icon"] = "Смещение значка состояния по Y",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the state icon"] = "Смещение значка состояния по Y",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the state icon"] = "Задает прикрепление значка состояния",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the health bar to anchor the state icon"] = "Задает точку для положения значка состояния относительно полоски здоровья",
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Sets the state icon alpha"] = "Задает прозрачность значка состояния",

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

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["State Icon"] = "首领图标",
	--[[ zhCN ]] ["State icon placement options"] = "首领图标位置相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Enable state icon display on the nameplate"] = "Enable state icon display on the nameplate",
	--[[ zhCN ]] ["Reverse"] = "Reverse",
	--[[ zhCN ]] ["Reverse the state icon graphic horizontally"] = "Reverse the state icon graphic horizontally",
	--[[ zhCN ]] ["Height"] = "尺寸",
	--[[ zhCN ]] ["Height in pixels of the state icon"] = "Height in pixels of the state icon",
	--[[ zhCN ]] ["Width"] = "尺寸",
	--[[ zhCN ]] ["Width in pixels of the state icon"] = "Width in pixels of the state icon",
	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust state icon position"] = "Adjust state icon position",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the state icon"] = "X offset of the state icon",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the state icon"] = "Y offset of the state icon",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the state icon"] = "Sets the anchor for the state icon",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the health bar to anchor the state icon"] = "Sets the relative point on the health bar to anchor the state icon",
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Sets the state icon alpha"] = "Sets the state icon alpha",

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

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["State Icon"] = "首領圖示",
	--[[ zhTW ]] ["State icon placement options"] = "State icon placement options",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Enable state icon display on the nameplate"] = "Enable state icon display on the nameplate",
	--[[ zhTW ]] ["Reverse"] = "Reverse",
	--[[ zhTW ]] ["Reverse the state icon graphic horizontally"] = "Reverse the state icon graphic horizontally",
	--[[ zhTW ]] ["Height"] = "大小",
	--[[ zhTW ]] ["Height in pixels of the state icon"] = "Height in pixels of the state icon",
	--[[ zhTW ]] ["Width"] = "大小",
	--[[ zhTW ]] ["Width in pixels of the state icon"] = "Width in pixels of the state icon",
	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust state icon position"] = "Adjust state icon position",
	--[[ zhTW ]] ["X Offset"] = "X位移",
	--[[ zhTW ]] ["X offset of the state icon"] = "X offset of the state icon",
	--[[ zhTW ]] ["Y Offset"] = "Y位移",
	--[[ zhTW ]] ["Y offset of the state icon"] = "Y offset of the state icon",
	--[[ zhTW ]] ["Anchor"] = "定位點",
	--[[ zhTW ]] ["Sets the anchor for the state icon"] = "Sets the anchor for the state icon",
	--[[ zhTW ]] ["Anchor To"] = "固定在",
	--[[ zhTW ]] ["Sets the relative point on the health bar to anchor the state icon"] = "Sets the relative point on the health bar to anchor the state icon",
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Sets the state icon alpha"] = "Sets the state icon alpha",

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

-----------------------------------------------------------------------------

end
