local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftClassIconOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Class Icon"] = true,
	--[[ enUS ]] ["Class icon placement options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Enable class icon display on the nameplate"] = true,
	--[[ enUS ]] ["Size"] = true,
	--[[ enUS ]] ["Size in pixels of the class icon"] = true,
	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust class icon position"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the class icon"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the class icon"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the class icon"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the health bar to anchor the class icon"] = true,
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Sets the class icon alpha"] = true,

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

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Class Icon"] = "Class Icon",
	--[[ koKR ]] ["Class icon placement options"] = "Class icon placement options",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Enable class icon display on the nameplate"] = "Enable class icon display on the nameplate",
	--[[ koKR ]] ["Size"] = "크기",
	--[[ koKR ]] ["Size in pixels of the class icon"] = "Size in pixels of the class icon",
	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust class icon position"] = "Adjust class icon position",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the class icon"] = "X offset of the class icon",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the class icon"] = "Y offset of the class icon",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the class icon"] = "Sets the anchor for the class icon",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the health bar to anchor the class icon"] = "Sets the relative point on the health bar to anchor the class icon",
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Sets the class icon alpha"] = "Sets the class icon alpha",

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

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Class Icon"] = "Значок класса",
	--[[ ruRU ]] ["Class icon placement options"] = "Настройка размещения значка класса",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Enable class icon display on the nameplate"] = "Включить отображение значка класса на табличке",
	--[[ ruRU ]] ["Size"] = "Размер",
	--[[ ruRU ]] ["Size in pixels of the class icon"] = "Размер значка класса в пикселях",
	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust class icon position"] = "Задать место значка класса",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the class icon"] = "Смещение значка класса по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the class icon"] = "Смещение значка класса по Y",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the class icon"] = "Задает прикрепление значка класса",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the health bar to anchor the class icon"] = "Задает точку для положения значка класса относительно полоски здоровья",
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Sets the class icon alpha"] = "Задает прозрачность значка класса",

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

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Class Icon"] = "职业图标",
	--[[ zhCN ]] ["Class icon placement options"] = "职业图标位置选项",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Enable class icon display on the nameplate"] = "在姓名板上显示职业图标",
	--[[ zhCN ]] ["Size"] = "尺寸",
	--[[ zhCN ]] ["Size in pixels of the class icon"] = "职业图标的大小（单位为像素）",
	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust class icon position"] = "职业图标位置",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the class icon"] = "职业图标横轴偏移",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the class icon"] = "职业图标纵轴偏移",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the class icon"] = "职业图标锚点",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the health bar to anchor the class icon"] = "设置职业图标要依附到生命条的哪个位置",
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Sets the class icon alpha"] = "设置职业图标透明度",

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

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Class Icon"] = "職業圖示",
	--[[ zhTW ]] ["Class icon placement options"] = "職業圖示位置選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Enable class icon display on the nameplate"] = "在姓名板上顯示職業圖示",
	--[[ zhTW ]] ["Size"] = "尺寸",
	--[[ zhTW ]] ["Size in pixels of the class icon"] = "職業圖示的大小（單位為圖元）",
	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust class icon position"] = "職業圖示位置",
	--[[ zhTW ]] ["X Offset"] = "X軸偏移",
	--[[ zhTW ]] ["X offset of the class icon"] = "職業圖示橫軸偏移",
	--[[ zhTW ]] ["Y Offset"] = "Y軸偏移",
	--[[ zhTW ]] ["Y offset of the class icon"] = "職業圖示縱軸偏移",
	--[[ zhTW ]] ["Anchor"] = "錨點",
	--[[ zhTW ]] ["Sets the anchor for the class icon"] = "職業圖示錨點",
	--[[ zhTW ]] ["Anchor To"] = "固定在",
	--[[ zhTW ]] ["Sets the relative point on the health bar to anchor the class icon"] = "設置職業圖示要依附到生命條的哪個位置",
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Sets the class icon alpha"] = "設置職業圖示透明度",

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

end)

-----------------------------------------------------------------------------

end
