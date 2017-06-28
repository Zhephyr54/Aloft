local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftHealthTextOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Health Text"] = true,
	--[[ enUS ]] ["Health text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show health text on nameplates"] = true,
	--[[ enUS ]] ["Unknown"] = true, -- unit name for "Unknown" units

	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Health text typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for health text"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the health text"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on health text"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the outline for health text"] = true,
	--[[ enUS ]] ["Mode"] = true,
	--[[ enUS ]] ["Choose what to show for health text"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust health text position"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the health text"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the health bar to anchor the health text"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the health text"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the health text"] = true,
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Sets the alpha of the health text"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the health text color"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["Percent"] = true,
	--[[ enUS ]] ["Group Health"] = true,
	--[[ enUS ]] ["Group Health Deficit"] = true,
	--[[ enUS ]] ["Health"] = true,
	--[[ enUS ]] ["Health & Percent"] = true,
	--[[ enUS ]] ["Full"] = true,
	--[[ enUS ]] ["Smart"] = true,

	--[[ enUS ]] ["Advanced"] = true,
	--[[ enUS ]] ["Options for expert users"] = true,
	--[[ enUS ]] ["Format"] = true,
	--[[ enUS ]] ["Health tag"] = true,
	--[[ enUS ]] ["<Any tag string>"] = true,

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

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Health Text"] = "생명력 수치",
	--[[ koKR ]] ["Health text options"] = "생명력 수치 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show health text on nameplates"] = "이름표에 생명력 수치를 표시합니다.",
	--[[ koKR ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units

	--[[ koKR ]] ["Typeface"] = "서체",
	--[[ koKR ]] ["Health text typeface options"] = "생명력 수치 서체 설정",
	--[[ koKR ]] ["Font"] = "글꼴",
	--[[ koKR ]] ["Sets the font for health text"] = "생명력 수치의 글꼴을 설정합니다.",
	--[[ koKR ]] ["Font Size"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the font height of the health text"] = "생명력 수치의 크기를 설정합니다.",
	--[[ koKR ]] ["Font Shadow"] = "글꼴 그림자",
	--[[ koKR ]] ["Show font shadow on health text"] = "생명력 수치에 그림자를 표시합니다.",
	--[[ koKR ]] ["Outline"] = "테두리",
	--[[ koKR ]] ["Sets the outline for health text"] = "생명력 수치의 테두리를 설정합니다.",
	--[[ koKR ]] ["Mode"] = "모드",
	--[[ koKR ]] ["Choose what to show for health text"] = "생명력 수치의 표시 방법을 선택합니다.",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust health text position"] = "생명력 수치 위치 조절",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the health text"] = "생명력 수치의 앵커를 설정합니다.",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the health bar to anchor the health text"] = "생명력 바에서 생명력 수치의 앵커 위치를 설정합니다.",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the health text"] = "생명력 수치의 X 좌표 입니다.",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the health text"] = "생명력 수치의 Y 좌표 입니다.",
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Sets the alpha of the health text"] = "생명력 수치의 투명도를 설정합니다.",
	--[[ koKR ]] ["Color"] = "색상",
	--[[ koKR ]] ["Sets the health text color"] = "생명력 수치의 색상을 설정합니다.",

	--[[ koKR ]] ["None"] = "없음",
	--[[ koKR ]] ["Normal"] = "기본",
	--[[ koKR ]] ["Thick"] = "굵게",

	--[[ koKR ]] ["Percent"] = "백분율",
	--[[ koKR ]] ["Group Health"] = "파티 생명력",
	--[[ koKR ]] ["Group Health Deficit"] = "파티 생명력 결손치",
	--[[ koKR ]] ["Health"] = "생명력",
	--[[ koKR ]] ["Health & Percent"] = "생명력 & 백분율",
	--[[ koKR ]] ["Full"] = "가득",
	--[[ koKR ]] ["Smart"] = "자동",

	--[[ koKR ]] ["Advanced"] = "고급",
	--[[ koKR ]] ["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	--[[ koKR ]] ["Format"] = "형식",
	--[[ koKR ]] ["Health tag"] = "생명력 태그",
	--[[ koKR ]] ["<Any tag string>"] = "<태그 문자열>",

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

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Health Text"] = "Текст здоровья",
	--[[ ruRU ]] ["Health text options"] = "Настройка текста здоровья",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show health text on nameplates"] = "Отображать текст здоровья на табличках",
	--[[ ruRU ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units

	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Health text typeface options"] = "Настройка шрифта текста здоровья",
	--[[ ruRU ]] ["Font"] = "Шрифт",
	--[[ ruRU ]] ["Sets the font for health text"] = "Задает шрифт для текста здоровья",
	--[[ ruRU ]] ["Font Size"] = "Размер шрифта",
	--[[ ruRU ]] ["Sets the font height of the health text"] = "Задает высоту шрифта для текста здоровья",
	--[[ ruRU ]] ["Font Shadow"] = "Тень шрифта",
	--[[ ruRU ]] ["Show font shadow on health text"] = "Отображать тень для текста здоровья",
	--[[ ruRU ]] ["Outline"] = "Контур",
	--[[ ruRU ]] ["Sets the outline for health text"] = "Задает окантовку для текста здоровья",
	--[[ ruRU ]] ["Mode"] = "Режим",
	--[[ ruRU ]] ["Choose what to show for health text"] = "Выбрать, что показывать в тексте здоровья",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust health text position"] = "Задать место текста здоровья",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the health text"] = "Задает прикрепление текста здоровья",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the health bar to anchor the health text"] = "Задает точку для положения текста здоровья относительно полоски здоровья",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the health text"] = "Смещение текста здоровья по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the health text"] = "Смещение полоски здоровья по Y",
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Sets the alpha of the health text"] = "Задает прозрачность текста здоровья",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the health text color"] = "Задает цвет текста здоровья",

	--[[ ruRU ]] ["None"] = "Нет",
	--[[ ruRU ]] ["Normal"] = "Обычно",
	--[[ ruRU ]] ["Thick"] = "Жирный",

	--[[ ruRU ]] ["Percent"] = "Проценты",
	--[[ ruRU ]] ["Group Health"] = "Здоровье группы",
	--[[ ruRU ]] ["Group Health Deficit"] = "Дефицит здоровья группы",
	--[[ ruRU ]] ["Health"] = "Здоровье",
	--[[ ruRU ]] ["Health & Percent"] = "Здоровье & Проценты",
	--[[ ruRU ]] ["Full"] = "Полное",
	--[[ ruRU ]] ["Smart"] = "Умное",

	--[[ ruRU ]] ["Advanced"] = "Дополнительно",
	--[[ ruRU ]] ["Options for expert users"] = "Настройки для опытных пользователей",
	--[[ ruRU ]] ["Format"] = "Формат",
	--[[ ruRU ]] ["Health tag"] = "Вид здоровья",
	--[[ ruRU ]] ["<Any tag string>"] = "<Любая строка формата>",

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

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Health Text"] = "生命值提示文字",
	--[[ zhCN ]] ["Health text options"] = "生命值提示文字相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show health text on nameplates"] = "在姓名板上显示生命值提示文字",
	--[[ zhCN ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units

	--[[ zhCN ]] ["Typeface"] = "式样",
	--[[ zhCN ]] ["Health text typeface options"] = "生命值提示文字的式样设置",
	--[[ zhCN ]] ["Font"] = "字体",
	--[[ zhCN ]] ["Sets the font for health text"] = "设定生命值提示文字的字体",
	--[[ zhCN ]] ["Font Size"] = "字号",
	--[[ zhCN ]] ["Sets the font height of the health text"] = "设定生命值提示文字的字号",
	--[[ zhCN ]] ["Font Shadow"] = "字体阴影",
	--[[ zhCN ]] ["Show font shadow on health text"] = "显示生命值提示文字的字体阴影",
	--[[ zhCN ]] ["Outline"] = "轮廓",
	--[[ zhCN ]] ["Sets the outline for health text"] = "设定生命值提示文字的字体轮廓",
	--[[ zhCN ]] ["Mode"] = "模式",
	--[[ zhCN ]] ["Choose what to show for health text"] = "选择生命值提示文字的显示方式",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust health text position"] = "调整生命值提示文字的位置",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the health text"] = "设定生命值提示文字的锚点",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the health bar to anchor the health text"] = "设定生命值提示文字固定在生命值显示条的相对位置",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the health text"] = "生命值提示文字的X轴偏移量",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the health text"] = "生命值提示文字的Y轴偏移量",
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Sets the alpha of the health text"] = "设定生命值提示文字的透明度",
	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the health text color"] = "设定生命值提示文字的颜色",

	--[[ zhCN ]] ["None"] = "无",
	--[[ zhCN ]] ["Normal"] = "正常",
	--[[ zhCN ]] ["Thick"] = "粗",

	--[[ zhCN ]] ["Percent"] = "百分比",
	--[[ zhCN ]] ["Group Health"] = "队友生命值",
	--[[ zhCN ]] ["Group Health Deficit"] = "队友生命值不足额",
	--[[ zhCN ]] ["Health"] = "生命值",
	--[[ zhCN ]] ["Health & Percent"] = "生命值和百分比",
	--[[ zhCN ]] ["Full"] = "完全",
	--[[ zhCN ]] ["Smart"] = "智能",

	--[[ zhCN ]] ["Advanced"] = "高级",
	--[[ zhCN ]] ["Options for expert users"] = "高级设置",
	--[[ zhCN ]] ["Format"] = "格式",
	--[[ zhCN ]] ["Health tag"] = "生命值标签",
	--[[ zhCN ]] ["<Any tag string>"] = "<任意标签文字>",

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

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Health Text"] = "生命力文字",
	--[[ zhTW ]] ["Health text options"] = "生命力文字選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show health text on nameplates"] = "在名牌顯示生命力文字",
	--[[ zhTW ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units

	--[[ zhTW ]] ["Typeface"] = "字體",
	--[[ zhTW ]] ["Health text typeface options"] = "生命力文字字體選項",
	--[[ zhTW ]] ["Font"] = "字型",
	--[[ zhTW ]] ["Sets the font for health text"] = "生命力文字字型",
	--[[ zhTW ]] ["Font Size"] = "字型大小",
	--[[ zhTW ]] ["Sets the font height of the health text"] = "生命力文字字型大小",
	--[[ zhTW ]] ["Font Shadow"] = "字型陰影",
	--[[ zhTW ]] ["Show font shadow on health text"] = "生命力文字字型陰影",
	--[[ zhTW ]] ["Outline"] = "輪廓",
	--[[ zhTW ]] ["Sets the outline for health text"] = "生命力文字字型輪廓",
	--[[ zhTW ]] ["Mode"] = "模式",
	--[[ zhTW ]] ["Choose what to show for health text"] = "選擇在生命力文字顯示什麼",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust health text position"] = "生命力文字位置",
	--[[ zhTW ]] ["Anchor"] = "定位點",
	--[[ zhTW ]] ["Sets the anchor for the health text"] = "生命力文字定位點",
	--[[ zhTW ]] ["Anchor To"] = "固定在",
	--[[ zhTW ]] ["Sets the relative point on the health bar to anchor the health text"] = "生命力文字固定在生命力條的位置",
	--[[ zhTW ]] ["X Offset"] = "X位移",
	--[[ zhTW ]] ["X offset of the health text"] = "生命力文字X位移",
	--[[ zhTW ]] ["Y Offset"] = "Y位移",
	--[[ zhTW ]] ["Y offset of the health text"] = "生命力文字Y位移",
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Sets the alpha of the health text"] = "生命力文字透明度",
	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the health text color"] = "生命力文字顏色",

	--[[ zhTW ]] ["None"] = "無",
	--[[ zhTW ]] ["Normal"] = "正常",
	--[[ zhTW ]] ["Thick"] = "粗",

	--[[ zhTW ]] ["Percent"] = "百分比",
	--[[ zhTW ]] ["Group Health"] = "團體生命力",
	--[[ zhTW ]] ["Group Health Deficit"] = "團體生命力不足額",
	--[[ zhTW ]] ["Health"] = "生命力",
	--[[ zhTW ]] ["Health & Percent"] = "生命力和百分比",
	--[[ zhTW ]] ["Full"] = "完全",
	--[[ zhTW ]] ["Smart"] = "精明",

	--[[ zhTW ]] ["Advanced"] = "進階",
	--[[ zhTW ]] ["Options for expert users"] = "進階選項",
	--[[ zhTW ]] ["Format"] = "格式",
	--[[ zhTW ]] ["Health tag"] = "生命力標籤",
	--[[ zhTW ]] ["<Any tag string>"] = "<任何標籤文字>",

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
