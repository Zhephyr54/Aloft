local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftCombatTextOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Combat Text"] = true,
	--[[ enUS ]] ["Combat text options"] = true,
	--[[ enUS ]] ["Enable Target"] = true,
	--[[ enUS ]] ["Show combat text on target nameplates"] = true,
	--[[ enUS ]] ["Enable Group"] = true,
	--[[ enUS ]] ["Show combat text on group member nameplates"] = true,
	--[[ enUS ]] ["Enable Other"] = true,
	--[[ enUS ]] ["Show combat text on other nameplates"] = true,

	--[[ enUS ]] ["Damage/Healing By Player"] = true,
	--[[ enUS ]] ["Show combat text for damage/healing done by the player"] = true,
	--[[ enUS ]] ["Damage/Healing By Group"] = true,
	--[[ enUS ]] ["Show combat text for damage/healing done by group members (including pets)"] = true,
	--[[ enUS ]] ["Damage/Healing By Other"] = true,
	--[[ enUS ]] ["Show combat text for damage/healing done by other units"] = true,
	--[[ enUS ]] ["Include Overhealing"] = true,
	--[[ enUS ]] ["Show combat text for healing that includes overhealing"] = true,

	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Combat text typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for combat text"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the combat text"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on combat text"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the outline for combat text"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust combat text position"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the combat text"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the health bar to anchor the combat text"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the combat text"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the combat text"] = true,
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Sets the alpha of the combat text"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["Colors"] = true,
	--[[ enUS ]] ["Customize colors"] = true,
	--[[ enUS ]] ["Physical"] = true,
	--[[ enUS ]] ["Sets the color for physical damage"] = true,
	--[[ enUS ]] ["Holy"] = true,
	--[[ enUS ]] ["Sets the color for holy damage"] = true,
	--[[ enUS ]] ["Fire"] = true,
	--[[ enUS ]] ["Sets the color for fire damage"] = true,
	--[[ enUS ]] ["Nature"] = true,
	--[[ enUS ]] ["Sets the color for nature damage"] = true,
	--[[ enUS ]] ["Frost"] = true,
	--[[ enUS ]] ["Sets the color for frost damage"] = true,
	--[[ enUS ]] ["Shadow"] = true,
	--[[ enUS ]] ["Sets the color for shadow damage"] = true,
	--[[ enUS ]] ["Arcane"] = true,
	--[[ enUS ]] ["Sets the color for arcane damage"] = true,
	--[[ enUS ]] ["Heal"] = true,
	--[[ enUS ]] ["Sets the color for healing"] = true,
	--[[ enUS ]] ["Text"] = true,
	--[[ enUS ]] ["Sets the color for text feedback"] = true,
	--[[ enUS ]] ["Default"] = true,
	--[[ enUS ]] ["Sets the default combat text color"] = true,
	--[[ enUS ]] ["Reset"] = true,
	--[[ enUS ]] ["Resets all of the colors to default"] = true,
	--[[ enUS ]] ["Set All"] = true,
	--[[ enUS ]] ["Sets all of the colors"] = true,

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

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Combat Text"] = "전투 텍스트",
	--[[ koKR ]] ["Combat text options"] = "전투 텍스트 설정",
	--[[ koKR ]] ["Enable Target"] = "대상 사용",
	--[[ koKR ]] ["Show combat text on target nameplates"] = "대상의 이름표에 전투 텍스트를 사용합니다.",
	--[[ koKR ]] ["Enable Group"] = "파티 사용",
	--[[ koKR ]] ["Show combat text on group member nameplates"] = "파티원의 이름표에 전투 텍스트를 표시합니다.",
	--[[ koKR ]] ["Enable Other"] = "Enable Other",
	--[[ koKR ]] ["Show combat text on other nameplates"] = "Show combat text on other nameplates",

	--[[ koKR ]] ["Damage/Healing By Player"] = "Damage/Healing By Player",
	--[[ koKR ]] ["Show combat text for damage/healing done by the player"] = "Show combat text for damage/healing done by the player",
	--[[ koKR ]] ["Damage/Healing By Group"] = "Damage/Healing By Group",
	--[[ koKR ]] ["Show combat text for damage/healing done by group members (including pets)"] = "Show combat text for damage/healing done by group members (including pets)",
	--[[ koKR ]] ["Damage/Healing By Other"] = "Damage/Healing By Other",
	--[[ koKR ]] ["Show combat text for damage/healing done by other units"] = "Show combat text for damage/healing done by other units",
	--[[ koKR ]] ["Include Overhealing"] = "Include Overhealing",
	--[[ koKR ]] ["Show combat text for healing that includes overhealing"] = "Show combat text for healing that includes overhealing",

	--[[ koKR ]] ["Typeface"] = "서체",
	--[[ koKR ]] ["Combat text typeface options"] = "전투 텍스트 서체 설정",
	--[[ koKR ]] ["Font"] = "글꼴",
	--[[ koKR ]] ["Sets the font for combat text"] = "전투 텍스트의 글꼴을 설정합니다.",
	--[[ koKR ]] ["Font Size"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the font height of the combat text"] = "전투 텍스트의 글꼴 높이를 설정합니다.",
	--[[ koKR ]] ["Font Shadow"] = "글꼴 그림자",
	--[[ koKR ]] ["Show font shadow on combat text"] = "전투 텍스트에 그림자를 표시합니다.",
	--[[ koKR ]] ["Outline"] = "테두리",
	--[[ koKR ]] ["Sets the outline for combat text"] = "전투 텍스트에 대한 테두리를 설정합니다.",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust combat text position"] = "전투 텍스트 위치 조절",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the combat text"] = "전투 텍스트의 앵커를 설정합니다.",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the health bar to anchor the combat text"] = "생명력 바에서 전투 텍스트의 앵커 위치를 설정합니다.",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the combat text"] = "전투 텍스트의 X 좌표입니다.",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the combat text"] = "전투 텍스트의 Y 좌표입니다.",
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Sets the alpha of the combat text"] = "전투 텍스트의 투명도를 설정합니다.",

	--[[ koKR ]] ["None"] = "없음",
	--[[ koKR ]] ["Normal"] = "기본",
	--[[ koKR ]] ["Thick"] = "굵게",

	--[[ koKR ]] ["Colors"] = "색상",
	--[[ koKR ]] ["Customize colors"] = "사용자 지정 색상",
	--[[ koKR ]] ["Physical"] = "물리",
	--[[ koKR ]] ["Sets the color for physical damage"] = "물리적 피해량의 색상을 설정합니다.",
	--[[ koKR ]] ["Holy"] = "신성",
	--[[ koKR ]] ["Sets the color for holy damage"] = "신성 피해량의 색상을 설정합니다.",
	--[[ koKR ]] ["Fire"] = "화염",
	--[[ koKR ]] ["Sets the color for fire damage"] = "화염 피해량의 색상을 설정합니다.",
	--[[ koKR ]] ["Nature"] = "자연",
	--[[ koKR ]] ["Sets the color for nature damage"] = "자연 피해량의 색상을 설정합니다.",
	--[[ koKR ]] ["Frost"] = "냉기",
	--[[ koKR ]] ["Sets the color for frost damage"] = "냉기 피해량의 색상을 설정합니다.",
	--[[ koKR ]] ["Shadow"] = "암흑",
	--[[ koKR ]] ["Sets the color for shadow damage"] = "암흑 피해량의 색상을 설정합니다.",
	--[[ koKR ]] ["Arcane"] = "비전",
	--[[ koKR ]] ["Sets the color for arcane damage"] = "비전 피해량의 색상을 설정합니다.",
	--[[ koKR ]] ["Heal"] = "치유",
	--[[ koKR ]] ["Sets the color for healing"] = "치유량의 색상을 설정합니다.",
	--[[ koKR ]] ["Text"] = "글자",
	--[[ koKR ]] ["Sets the color for text feedback"] = "피드백 글자의 색상을 설정합니다.",
	--[[ koKR ]] ["Default"] = "Default",
	--[[ koKR ]] ["Sets the default combat text color"] = "Sets the default combat text color",
	--[[ koKR ]] ["Reset"] = "초기화",
	--[[ koKR ]] ["Resets all of the colors to default"] = "기본 색상으로 모두 초기화합니다.",
	--[[ koKR ]] ["Set All"] = "전체 설정",
	--[[ koKR ]] ["Sets all of the colors"] = "전체 색상을 설정합니다.",

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

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Combat Text"] = "Текст боя",
	--[[ ruRU ]] ["Combat text options"] = "Настройка текста боя",
	--[[ ruRU ]] ["Enable Target"] = "Включить цель",
	--[[ ruRU ]] ["Show combat text on target nameplates"] = "Отображать текст боя на табличке цели",
	--[[ ruRU ]] ["Enable Group"] = "Включить группу",
	--[[ ruRU ]] ["Show combat text on group member nameplates"] = "Отображать текст боя на табличках участников группы",
	--[[ ruRU ]] ["Enable Other"] = "Enable Other",
	--[[ ruRU ]] ["Show combat text on other nameplates"] = "Show combat text on other nameplates",

	--[[ ruRU ]] ["Damage/Healing By Player"] = "Damage/Healing By Player",
	--[[ ruRU ]] ["Show combat text for damage/healing done by the player"] = "Show combat text for damage/healing done by the player",
	--[[ ruRU ]] ["Damage/Healing By Group"] = "Damage/Healing By Group",
	--[[ ruRU ]] ["Show combat text for damage/healing done by group members (including pets)"] = "Show combat text for damage/healing done by group members (including pets)",
	--[[ ruRU ]] ["Damage/Healing By Other"] = "Damage/Healing By Other",
	--[[ ruRU ]] ["Show combat text for damage/healing done by other units"] = "Show combat text for damage/healing done by other units",
	--[[ ruRU ]] ["Include Overhealing"] = "Include Overhealing",
	--[[ ruRU ]] ["Show combat text for healing that includes overhealing"] = "Show combat text for healing that includes overhealing",

	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Combat text typeface options"] = "Настройка шрифта текста боя",
	--[[ ruRU ]] ["Font"] = "Шрифт",
	--[[ ruRU ]] ["Sets the font for combat text"] = "Задает шрифт для текста боя",
	--[[ ruRU ]] ["Font Size"] = "Размер шрифта",
	--[[ ruRU ]] ["Sets the font height of the combat text"] = "Задает высоту шрифта для текста боя",
	--[[ ruRU ]] ["Font Shadow"] = "Тень шрифта",
	--[[ ruRU ]] ["Show font shadow on combat text"] = "Отображать тень для текста боя",
	--[[ ruRU ]] ["Outline"] = "Контур",
	--[[ ruRU ]] ["Sets the outline for combat text"] = "Задает окантовку для текста боя",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust combat text position"] = "Задать место текста боя",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the combat text"] = "Задает прикрепление текста боя",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the health bar to anchor the combat text"] = "Задает точку для положения текста боя относительно полоски здоровья",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the combat text"] = "Смещение текста боя по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the combat text"] = "Смещение текста боя по Y",
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Sets the alpha of the combat text"] = "Задает прозрачность текста боя",

	--[[ ruRU ]] ["None"] = "Нет",
	--[[ ruRU ]] ["Normal"] = "Обычно",
	--[[ ruRU ]] ["Thick"] = "Жирный",

	--[[ ruRU ]] ["Colors"] = "Цвета",
	--[[ ruRU ]] ["Customize colors"] = "Настройка цветов",
	--[[ ruRU ]] ["Physical"] = "Физическое",
	--[[ ruRU ]] ["Sets the color for physical damage"] = "Задает цвет для физического урона",
	--[[ ruRU ]] ["Holy"] = "Священная магия",
	--[[ ruRU ]] ["Sets the color for holy damage"] = "Задает цвет для урона от священной магии",
	--[[ ruRU ]] ["Fire"] = "Огонь",
	--[[ ruRU ]] ["Sets the color for fire damage"] = "Задает цвет для урона от магии огня",
	--[[ ruRU ]] ["Nature"] = "Природная магия",
	--[[ ruRU ]] ["Sets the color for nature damage"] = "Задает цвет для урона от магии природы",
	--[[ ruRU ]] ["Frost"] = "Лед",
	--[[ ruRU ]] ["Sets the color for frost damage"] = "Задать цвет для урона от магии льда",
	--[[ ruRU ]] ["Shadow"] = "Тень",
	--[[ ruRU ]] ["Sets the color for shadow damage"] = "Задает цвет для урона от теневой магии",
	--[[ ruRU ]] ["Arcane"] = "Тайная магия",
	--[[ ruRU ]] ["Sets the color for arcane damage"] = "Задает цвет для урона от тайной магии",
	--[[ ruRU ]] ["Heal"] = "Лечение",
	--[[ ruRU ]] ["Sets the color for healing"] = "Задать цвет для излечения",
	--[[ ruRU ]] ["Text"] = "Текст",
	--[[ ruRU ]] ["Sets the color for text feedback"] = "Задает цвет для текста отзыва",
	--[[ ruRU ]] ["Default"] = "По умолчанию",
	--[[ ruRU ]] ["Sets the default combat text color"] = "Задает цвет текста боя по умолчанию",
	--[[ ruRU ]] ["Reset"] = "Сброс",
	--[[ ruRU ]] ["Resets all of the colors to default"] = "Сбрасывает все цвета в настройки по умолчанию",
	--[[ ruRU ]] ["Set All"] = "Задать все",
	--[[ ruRU ]] ["Sets all of the colors"] = "Задает все цвета",

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

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Combat Text"] = "战斗信息文字",
	--[[ zhCN ]] ["Combat text options"] = "战斗信息文字相关设置",
	--[[ zhCN ]] ["Enable Target"] = "启用目标",
	--[[ zhCN ]] ["Show combat text on target nameplates"] = "在目标的姓名板上显示战斗信息文字",
	--[[ zhCN ]] ["Enable Group"] = "启用队友",
	--[[ zhCN ]] ["Show combat text on group member nameplates"] = "在队友的姓名板上显示战斗信息文字",
	--[[ zhCN ]] ["Enable Other"] = "Enable Other",
	--[[ zhCN ]] ["Show combat text on other nameplates"] = "Show combat text on other nameplates",

	--[[ zhCN ]] ["Damage/Healing By Player"] = "Damage/Healing By Player",
	--[[ zhCN ]] ["Show combat text for damage/healing done by the player"] = "Show combat text for damage/healing done by the player",
	--[[ zhCN ]] ["Damage/Healing By Group"] = "Damage/Healing By Group",
	--[[ zhCN ]] ["Show combat text for damage/healing done by group members (including pets)"] = "Show combat text for damage/healing done by group members (including pets)",
	--[[ zhCN ]] ["Damage/Healing By Other"] = "Damage/Healing By Other",
	--[[ zhCN ]] ["Show combat text for damage/healing done by other units"] = "Show combat text for damage/healing done by other units",
	--[[ zhCN ]] ["Include Overhealing"] = "Include Overhealing",
	--[[ zhCN ]] ["Show combat text for healing that includes overhealing"] = "Show combat text for healing that includes overhealing",

	--[[ zhCN ]] ["Typeface"] = "式样",
	--[[ zhCN ]] ["Combat text typeface options"] = "战斗信息文字式样设置",
	--[[ zhCN ]] ["Font"] = "字体",
	--[[ zhCN ]] ["Sets the font for combat text"] = "设定战斗信息文字的字体",
	--[[ zhCN ]] ["Font Size"] = "字号",
	--[[ zhCN ]] ["Sets the font height of the combat text"] = "设定战斗信息文字的字号",
	--[[ zhCN ]] ["Font Shadow"] = "字体阴影",
	--[[ zhCN ]] ["Show font shadow on combat text"] = "显示战斗信息文字的字体阴影",
	--[[ zhCN ]] ["Outline"] = "轮廓",
	--[[ zhCN ]] ["Sets the outline for combat text"] = "设定战斗信息文字的字体轮廓",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust combat text position"] = "调整战斗信息文字的位置",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the combat text"] = "设定战斗信息文字的锚点",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the health bar to anchor the combat text"] = "设定战斗信息文字固定在生命值显示条的相对位置",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the combat text"] = "战斗信息文字的X轴偏移量",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the combat text"] = "战斗信息文字的Y轴偏移量",
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Sets the alpha of the combat text"] = "设定战斗信息文字的透明度",

	--[[ zhCN ]] ["None"] = "无",
	--[[ zhCN ]] ["Normal"] = "正常",
	--[[ zhCN ]] ["Thick"] = "粗",

	--[[ zhCN ]] ["Colors"] = "颜色",
	--[[ zhCN ]] ["Customize colors"] = "自定义颜色",
	--[[ zhCN ]] ["Physical"] = "物理",
	--[[ zhCN ]] ["Sets the color for physical damage"] = "设定物理伤害的颜色",
	--[[ zhCN ]] ["Holy"] = "神圣",
	--[[ zhCN ]] ["Sets the color for holy damage"] = "设定神圣伤害的颜色",
	--[[ zhCN ]] ["Fire"] = "火焰",
	--[[ zhCN ]] ["Sets the color for fire damage"] = "设定火焰伤害的颜色",
	--[[ zhCN ]] ["Nature"] = "自然",
	--[[ zhCN ]] ["Sets the color for nature damage"] = "设定自然伤害的颜色",
	--[[ zhCN ]] ["Frost"] = "冰霜",
	--[[ zhCN ]] ["Sets the color for frost damage"] = "设定冰霜伤害的颜色",
	--[[ zhCN ]] ["Shadow"] = "暗影",
	--[[ zhCN ]] ["Sets the color for shadow damage"] = "设定暗影伤害的颜色",
	--[[ zhCN ]] ["Arcane"] = "奥术",
	--[[ zhCN ]] ["Sets the color for arcane damage"] = "设定奥术伤害的颜色",
	--[[ zhCN ]] ["Heal"] = "治疗",
	--[[ zhCN ]] ["Sets the color for healing"] = "设定治疗的颜色",
	--[[ zhCN ]] ["Text"] = "文字",
	--[[ zhCN ]] ["Sets the color for text feedback"] = "设定回应文字的颜色",
	--[[ zhCN ]] ["Default"] = "Default",
	--[[ zhCN ]] ["Sets the default combat text color"] = "Sets the default combat text color",
	--[[ zhCN ]] ["Reset"] = "重置",
	--[[ zhCN ]] ["Resets all of the colors to default"] = "将所有颜色设定重置为默认",
	--[[ zhCN ]] ["Set All"] = "设定全部",
	--[[ zhCN ]] ["Sets all of the colors"] = "设定全部颜色",

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

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Combat Text"] = "戰鬥文字",
	--[[ zhTW ]] ["Combat text options"] = "戰鬥文字選項",
	--[[ zhTW ]] ["Enable Target"] = "啟用目標",
	--[[ zhTW ]] ["Show combat text on target nameplates"] = "在目標名牌顯示戰鬥文字",
	--[[ zhTW ]] ["Enable Group"] = "啟用團體",
	--[[ zhTW ]] ["Show combat text on group member nameplates"] = "在團體成員名牌顯示戰鬥文字",
	--[[ zhTW ]] ["Enable Other"] = "Enable Other",
	--[[ zhTW ]] ["Show combat text on other nameplates"] = "Show combat text on other nameplates",

	--[[ zhTW ]] ["Damage/Healing By Player"] = "Damage/Healing By Player",
	--[[ zhTW ]] ["Show combat text for damage/healing done by the player"] = "Show combat text for damage/healing done by the player",
	--[[ zhTW ]] ["Damage/Healing By Group"] = "Damage/Healing By Group",
	--[[ zhTW ]] ["Show combat text for damage/healing done by group members (including pets)"] = "Show combat text for damage/healing done by group members (including pets)",
	--[[ zhTW ]] ["Damage/Healing By Other"] = "Damage/Healing By Other",
	--[[ zhTW ]] ["Show combat text for damage/healing done by other units"] = "Show combat text for damage/healing done by other units",
	--[[ zhTW ]] ["Include Overhealing"] = "Include Overhealing",
	--[[ zhTW ]] ["Show combat text for healing that includes overhealing"] = "Show combat text for healing that includes overhealing",

	--[[ zhTW ]] ["Typeface"] = "字體",
	--[[ zhTW ]] ["Combat text typeface options"] = "戰鬥文字字體選項",
	--[[ zhTW ]] ["Font"] = "字型",
	--[[ zhTW ]] ["Sets the font for combat text"] = "戰鬥文字字型",
	--[[ zhTW ]] ["Font Size"] = "字型大小",
	--[[ zhTW ]] ["Sets the font height of the combat text"] = "戰鬥文字字型大小",
	--[[ zhTW ]] ["Font Shadow"] = "字型陰影",
	--[[ zhTW ]] ["Show font shadow on combat text"] = "戰鬥文字字型陰影",
	--[[ zhTW ]] ["Outline"] = "輪廓",
	--[[ zhTW ]] ["Sets the outline for combat text"] = "戰鬥文字字型輪廓",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust combat text position"] = "戰鬥文字位置",
	--[[ zhTW ]] ["Anchor"] = "定位點",
	--[[ zhTW ]] ["Sets the anchor for the combat text"] = "戰鬥文字定位點",
	--[[ zhTW ]] ["Anchor To"] = "固定在",
	--[[ zhTW ]] ["Sets the relative point on the health bar to anchor the combat text"] = "戰鬥文字固定在生命力條的位置",
	--[[ zhTW ]] ["X Offset"] = "X位移",
	--[[ zhTW ]] ["X offset of the combat text"] = "戰鬥文字X位移",
	--[[ zhTW ]] ["Y Offset"] = "Y位移",
	--[[ zhTW ]] ["Y offset of the combat text"] = "戰鬥文字Y位移",
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Sets the alpha of the combat text"] = "戰鬥文字透明度",

	--[[ zhTW ]] ["None"] = "無",
	--[[ zhTW ]] ["Normal"] = "正常",
	--[[ zhTW ]] ["Thick"] = "粗",

	--[[ zhTW ]] ["Colors"] = "顏色",
	--[[ zhTW ]] ["Customize colors"] = "自定顏色",
	--[[ zhTW ]] ["Physical"] = "物理",
	--[[ zhTW ]] ["Sets the color for physical damage"] = "物理傷害顏色",
	--[[ zhTW ]] ["Holy"] = "神聖",
	--[[ zhTW ]] ["Sets the color for holy damage"] = "神聖傷害顏色",
	--[[ zhTW ]] ["Fire"] = "火焰",
	--[[ zhTW ]] ["Sets the color for fire damage"] = "火焰傷害顏色",
	--[[ zhTW ]] ["Nature"] = "自然",
	--[[ zhTW ]] ["Sets the color for nature damage"] = "自然傷害顏色",
	--[[ zhTW ]] ["Frost"] = "冰霜",
	--[[ zhTW ]] ["Sets the color for frost damage"] = "冰霜傷害顏色",
	--[[ zhTW ]] ["Shadow"] = "暗影",
	--[[ zhTW ]] ["Sets the color for shadow damage"] = "暗影傷害顏色",
	--[[ zhTW ]] ["Arcane"] = "秘法",
	--[[ zhTW ]] ["Sets the color for arcane damage"] = "秘法傷害顏色",
	--[[ zhTW ]] ["Heal"] = "治療",
	--[[ zhTW ]] ["Sets the color for healing"] = "治療顏色",
	--[[ zhTW ]] ["Text"] = "文字",
	--[[ zhTW ]] ["Sets the color for text feedback"] = "回應文字顏色",
	--[[ zhTW ]] ["Default"] = "Default",
	--[[ zhTW ]] ["Sets the default combat text color"] = "Sets the default combat text color",
	--[[ zhTW ]] ["Reset"] = "重設",
	--[[ zhTW ]] ["Resets all of the colors to default"] = "重設全部顏色回預設值",
	--[[ zhTW ]] ["Set All"] = "設定全部",
	--[[ zhTW ]] ["Sets all of the colors"] = "設定全部顏色",

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
