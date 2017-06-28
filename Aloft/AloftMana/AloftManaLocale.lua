local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local bL = AceLibrary("AceLocale-2.2"):new("AloftManaBarOptions")

-----------------------------------------------------------------------------

local tL = AceLibrary("AceLocale-2.2"):new("AloftManaTextOptions")

-----------------------------------------------------------------------------

local dL = AceLibrary("AceLocale-2.2"):new("AloftManaDataOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
bL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Mana Bar"] = true,
	--[[ enUS ]] ["Mana Bar options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show mana bars on group member nameplates"] = true,

	--[[ enUS ]] ["Texture"] = true,
	--[[ enUS ]] ["Sets the mana bar texture"] = true,
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Sets the mana bar alpha"] = true,

	--[[ enUS ]] ["Height"] = true,
	--[[ enUS ]] ["Sets the height of the mana bar"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust the mana bar's position"] = true,
	--[[ enUS ]] ["Left Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the left of the mana bar"] = true,
	--[[ enUS ]] ["Right Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the right of the mana bar"] = true,
	--[[ enUS ]] ["Vertical Offset"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the mana bar"] = true,

	--[[ enUS ]] ["Colors"] = true,
	--[[ enUS ]] ["Customize colors"] = true,
	--[[ enUS ]] ["Backdrop Color"] = true,
	--[[ enUS ]] ["Sets the backdrop color of the mana bar"] = true,
	--[[ enUS ]] ["Mana Color"] = true,
	--[[ enUS ]] ["Sets the color for mana bars"] = true,
	--[[ enUS ]] ["Rage Color"] = true,
	--[[ enUS ]] ["Sets the color for rage bars"] = true,
	--[[ enUS ]] ["Focus Color"] = true,
	--[[ enUS ]] ["Sets the color for focus bars"] = true,
	--[[ enUS ]] ["Energy Color"] = true,
	--[[ enUS ]] ["Sets the color for energy bars"] = true,
	--[[ enUS ]] ["Happiness Color"] = true,
	--[[ enUS ]] ["Sets the color for happiness bars"] = true,
	--[[ enUS ]] ["Rune Color"] = true,
	--[[ enUS ]] ["Sets the color for rune bars"] = true,
	--[[ enUS ]] ["Runic Power Color"] = true,
	--[[ enUS ]] ["Sets the color for runic power bars"] = true,
	--[[ enUS ]] ["Reset to Defaults"] = true,
	--[[ enUS ]] ["Resets all colors to their defaults"] = true,

	--[[ enUS ]] ["Border"] = true,
	--[[ enUS ]] ["Border options"] = true,
	--[[ enUS ]] ["Target Only"] = true,
	--[[ enUS ]] ["Enables the border on the current target only"] = true,
	--[[ enUS ]] ["Border Color"] = true,
	--[[ enUS ]] ["Sets the border color of the mana bar"] = true,
	--[[ enUS ]] ["Border Style"] = true,
	--[[ enUS ]] ["Sets the style of the mana bar border"] = true,

	--[[ enUS ]] --["Always Show Target"] = true,
	--[[ enUS ]] --["Always show mana bar on active targets in combat"] = true,

	--[[ enUS ]] ["Advanced"] = true,
	--[[ enUS ]] ["Options for expert users"] = true,
	--[[ enUS ]] ["Color Format"] = true,
	--[[ enUS ]] ["Color tag"] = true,
	--[[ enUS ]] ["<Any tag string>"] = true,
} end)

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
tL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Mana Text"] = true,
	--[[ enUS ]] ["Mana text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show mana text on group member nameplates"] = true,

	--[[ enUS ]] ["Color by type"] = true,
	--[[ enUS ]] ["Color text differently for mana, energy, rage"] = true,

	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Mana text typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for mana text"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the mana text"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on mana text"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the outline for mana text"] = true,
	--[[ enUS ]] ["Mode"] = true,
	--[[ enUS ]] ["Choose what to show for mana text"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust mana text position"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the mana text"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the health bar to anchor the mana text"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the mana text"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the mana text"] = true,
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Sets the alpha of the mana text"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the mana text color"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["Percent"] = true,
	--[[ enUS ]] ["Mana"] = true,
	--[[ enUS ]] ["Mana & Percent"] = true,
	--[[ enUS ]] ["Deficit"] = true,
	--[[ enUS ]] ["Full"] = true,

	--[[ enUS ]] ["Always Show Target"] = true,
	--[[ enUS ]] ["Always show mana text on active targets in combat"] = true,

	--[[ enUS ]] ["Advanced"] = true,
	--[[ enUS ]] ["Options for expert users"] = true,
	--[[ enUS ]] ["Format"] = true,
	--[[ enUS ]] ["Mana tag"] = true,
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

dL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Unknown"] = true, -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

bL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Mana Bar"] = "마나바",
	--[[ koKR ]] ["Mana Bar options"] = "마나바 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show mana bars on group member nameplates"] = "파티원의 이름표에 마나바를 표시합니다.",

	--[[ koKR ]] ["Texture"] = "텍스쳐",
	--[[ koKR ]] ["Sets the mana bar texture"] = "마나바의 텍스쳐를 설정합니다.",
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Sets the mana bar alpha"] = "마나바의 투명도를 설정합니다.",

	--[[ koKR ]] ["Height"] = "높이",
	--[[ koKR ]] ["Sets the height of the mana bar"] = "마나바의 높이를 설정합니다.",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust the mana bar's position"] = "마나바의 위치를 조절합니다.",
	--[[ koKR ]] ["Left Offset"] = "좌측 좌표",
	--[[ koKR ]] ["Sets the offset of the left of the mana bar"] = "마나바의 좌측 좌표를 설정합니다.",
	--[[ koKR ]] ["Right Offset"] = "우측 좌표",
	--[[ koKR ]] ["Sets the offset of the right of the mana bar"] = "마나바의 우측 좌표를 설정합니다.",
	--[[ koKR ]] ["Vertical Offset"] = "수직 좌표",
	--[[ koKR ]] ["Sets the vertical offset of the mana bar"] = "마나바의 수직 좌표를 설정합니다.",

	--[[ koKR ]] ["Colors"] = "색상",
	--[[ koKR ]] ["Customize colors"] = "사용자 색상",
	--[[ koKR ]] ["Backdrop Color"] = "배경 색상",
	--[[ koKR ]] ["Sets the backdrop color of the mana bar"] = "마나바의 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Mana Color"] = "마나 색상",
	--[[ koKR ]] ["Sets the color for mana bars"] = "마나바의 색상을 설정합니다.",
	--[[ koKR ]] ["Rage Color"] = "분노 색상",
	--[[ koKR ]] ["Sets the color for rage bars"] = "분노바의 색상을 설정합니다",
	--[[ koKR ]] ["Focus Color"] = "지정 색상",
	--[[ koKR ]] ["Sets the color for focus bars"] = "지정바의 색상을 설정합니다.",
	--[[ koKR ]] ["Energy Color"] = "기력 색상",
	--[[ koKR ]] ["Sets the color for energy bars"] = "기력바의 색상을 설정합니다.",
	--[[ koKR ]] ["Happiness Color"] = "만족도 색상",
	--[[ koKR ]] ["Sets the color for happiness bars"] = "만족도바의 색상을 설정합니다.",
	--[[ koKR ]] ["Rune Color"] = "Rune Color",
	--[[ koKR ]] ["Sets the color for rune bars"] = "Sets the color for rune bars",
	--[[ koKR ]] ["Runic Power Color"] = "Runic Power Color",
	--[[ koKR ]] ["Sets the color for runic power bars"] = "Sets the color for runic power bars",
	--[[ koKR ]] ["Reset to Defaults"] = "기본값 초기화",
	--[[ koKR ]] ["Resets all colors to their defaults"] = "모든 색상을 기본값으로 초기화합니다.",

	--[[ koKR ]] ["Border"] = "Border",
	--[[ koKR ]] ["Border options"] = "Border options",
	--[[ koKR ]] ["Target Only"] = "Target Only",
	--[[ koKR ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ koKR ]] ["Border Color"] = "테두리 색상",
	--[[ koKR ]] ["Sets the border color of the mana bar"] = "Sets the border color of the mana bar",
	--[[ koKR ]] ["Border Style"] = "테두리 스타일",
	--[[ koKR ]] ["Sets the style of the mana bar border"] = "Sets the style of the mana bar border",

	--[[ koKR ]] --["Always Show Target"] = "Always Show Target",
	--[[ koKR ]] --["Always show mana bar on active targets in combat"] = "Always show mana bar on active targets in combat",

	--[[ koKR ]] ["Advanced"] = "고급",
	--[[ koKR ]] ["Options for expert users"] = "고급 사용자를 위한 설정",
	--[[ koKR ]] ["Color Format"] = "색상 형식",
	--[[ koKR ]] ["Color tag"] = "색상 태그",
	--[[ koKR ]] ["<Any tag string>"] = "<태그 문자열>",
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Mana Text"] = "마나 수치",
	--[[ koKR ]] ["Mana text options"] = "마나 수치 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show mana text on group member nameplates"] = "파티원의 이름표에 마나 수치를 표시합니다.",

	--[[ koKR ]] ["Color by type"] = "종류별 색상",
	--[[ koKR ]] ["Color text differently for mana, energy, rage"] = "각각의 마나, 기력, 분노에 따른 수치 색상",

	--[[ koKR ]] ["Typeface"] = "서체",
	--[[ koKR ]] ["Mana text typeface options"] = "마나 수치 서체 설정",
	--[[ koKR ]] ["Font"] = "글꼴",
	--[[ koKR ]] ["Sets the font for mana text"] = "마나 수치의 글꼴을 설정합니다.",
	--[[ koKR ]] ["Font Size"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the font height of the mana text"] = "마나 수치의 글꼴 높이를 설정합니다.",
	--[[ koKR ]] ["Font Shadow"] = "글꼴 그림자",
	--[[ koKR ]] ["Show font shadow on mana text"] = "마나 수치에 그림자를 표시합니다.",
	--[[ koKR ]] ["Outline"] = "테두리",
	--[[ koKR ]] ["Sets the outline for mana text"] = "마나 수치에 테두리를 설정합니다.",
	--[[ koKR ]] ["Mode"] = "모드",
	--[[ koKR ]] ["Choose what to show for mana text"] = "마나 수치의 표시 방법을 선택합니다.",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust mana text position"] = "마나 수치의 위치를 조절합니다.",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the mana text"] = "마나 수치의 앵커를 설정합니다.",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the health bar to anchor the mana text"] = "생명력바에 마나 수치의 앵커 위치를 설정합니다.",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the mana text"] = "마나 수치의 X 좌표입니다.",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the mana text"] = "마나 수치의 Y 좌표입니다.",
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Sets the alpha of the mana text"] = "마나 수치의 투명도를 설정합니다.",
	--[[ koKR ]] ["Color"] = "색상",
	--[[ koKR ]] ["Sets the mana text color"] = "마나 수치의 색상을 설정합니다.",

	--[[ koKR ]] ["None"] = "없음",
	--[[ koKR ]] ["Normal"] = "기본",
	--[[ koKR ]] ["Thick"] = "굵게",

	--[[ koKR ]] ["Percent"] = "백분율",
	--[[ koKR ]] ["Mana"] = "마나",
	--[[ koKR ]] ["Mana & Percent"] = "Mana & Percent",
	--[[ koKR ]] ["Deficit"] = "결손치",
	--[[ koKR ]] ["Full"] = "가득",

	--[[ koKR ]] ["Always Show Target"] = "Always Show Target",
	--[[ koKR ]] ["Always show mana text on active targets in combat"] = "Always show mana text on active targets in combat",

	--[[ koKR ]] ["Advanced"] = "고급",
	--[[ koKR ]] ["Options for expert users"] = "고급 사용자를 위한 설정",
	--[[ koKR ]] ["Format"] = "형식",
	--[[ koKR ]] ["Mana tag"] = "마나 태그",
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

dL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

bL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Mana Bar"] = "Полоска маны",
	--[[ ruRU ]] ["Mana Bar options"] = "Настройки полоски маны",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show mana bars on group member nameplates"] = "Отображать полоски маны на табличках участников группы",

	--[[ ruRU ]] ["Texture"] = "Текстура",
	--[[ ruRU ]] ["Sets the mana bar texture"] = "Задает текстуру полоски маны",
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Sets the mana bar alpha"] = "Задает прозрачность полоски маны",

	--[[ ruRU ]] ["Height"] = "Высота",
	--[[ ruRU ]] ["Sets the height of the mana bar"] = "Задает высоту полоски маны",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust the mana bar's position"] = "Задать место полоски маны",
	--[[ ruRU ]] ["Left Offset"] = "Смещение влево",
	--[[ ruRU ]] ["Sets the offset of the left of the mana bar"] = "Смещение полоски маны влево",
	--[[ ruRU ]] ["Right Offset"] = "Смещение вправо",
	--[[ ruRU ]] ["Sets the offset of the right of the mana bar"] = "Смещение полоски маны вправо",
	--[[ ruRU ]] ["Vertical Offset"] = "Смещение по вертикале",
	--[[ ruRU ]] ["Sets the vertical offset of the mana bar"] = "Смещение полоски маны по вертикале",

	--[[ ruRU ]] ["Colors"] = "Цвета",
	--[[ ruRU ]] ["Customize colors"] = "Настройка цветов",
	--[[ ruRU ]] ["Backdrop Color"] = "Цвет тени",
	--[[ ruRU ]] ["Sets the backdrop color of the mana bar"] = "Задает цвет тени полоски маны",
	--[[ ruRU ]] ["Mana Color"] = "Цвет маны",
	--[[ ruRU ]] ["Sets the color for mana bars"] = "Задает цвет для полосок маны",
	--[[ ruRU ]] ["Rage Color"] = "Цвет ярости",
	--[[ ruRU ]] ["Sets the color for rage bars"] = "Задает цвет для полосок ярости",
	--[[ ruRU ]] ["Focus Color"] = "Цвет фокуса",
	--[[ ruRU ]] ["Sets the color for focus bars"] = "Задает цвет полосок тонуса",
	--[[ ruRU ]] ["Energy Color"] = "Цвет энергии",
	--[[ ruRU ]] ["Sets the color for energy bars"] = "Задает цвет для полосок энергии",
	--[[ ruRU ]] ["Happiness Color"] = "Цвет счастья питомца",
	--[[ ruRU ]] ["Sets the color for happiness bars"] = "Задать цвет для полосок счастья",
	--[[ ruRU ]] ["Rune Color"] = "Цвет рун",
	--[[ ruRU ]] ["Sets the color for rune bars"] = "Установка цвета полос рун",
	--[[ ruRU ]] ["Runic Power Color"] = "Цвет силы рун",
	--[[ ruRU ]] ["Sets the color for runic power bars"] = "Установка цвета полос сылы рун",
	--[[ ruRU ]] ["Reset to Defaults"] = "Сбросить настройки",
	--[[ ruRU ]] ["Resets all colors to their defaults"] = "Сбрасывает все цвета в настройки по умолчанию",

	--[[ ruRU ]] ["Border"] = "Края",
	--[[ ruRU ]] ["Border options"] = "Настройка краёв",
	--[[ ruRU ]] ["Target Only"] = "Только цель",
	--[[ ruRU ]] ["Enables the border on the current target only"] = "Вкключить края только на текущей цели",
	--[[ ruRU ]] ["Border Color"] = "Цвет края",
	--[[ ruRU ]] ["Sets the border color of the mana bar"] = "Установка цвета края полоски маны",
	--[[ ruRU ]] ["Border Style"] = "Стиль рамки",
	--[[ ruRU ]] ["Sets the style of the mana bar border"] = "Установка стиля краёв полоски маны",

	--[[ ruRU ]] --["Always Show Target"] = "Всегда показывать цель",
	--[[ ruRU ]] --["Always show mana bar on active targets in combat"] = "В бою всегда показывать полоску маны текущей цели",

	--[[ ruRU ]] ["Advanced"] = "Дополнительно",
	--[[ ruRU ]] ["Options for expert users"] = "Настройки для опытных пользователей",
	--[[ ruRU ]] ["Color Format"] = "Формат цвета",
	--[[ ruRU ]] ["Color tag"] = "Формат цвета",
	--[[ ruRU ]] ["<Any tag string>"] = "<Любая строка формата>",
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Mana Text"] = "Текст маны",
	--[[ ruRU ]] ["Mana text options"] = "Настройки текста маны",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show mana text on group member nameplates"] = "Отображать текст маны на табличках участников группы",

	--[[ ruRU ]] ["Color by type"] = "Окрашивать в цвет типа",
	--[[ ruRU ]] ["Color text differently for mana, energy, rage"] = "Расцвечивать по разному текст для маны, ярости и энергии",

	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Mana text typeface options"] = "Настройки шрифта текста маны",
	--[[ ruRU ]] ["Font"] = "Шрифт",
	--[[ ruRU ]] ["Sets the font for mana text"] = "Задает шрифт для текста маны",
	--[[ ruRU ]] ["Font Size"] = "Размер шрифта",
	--[[ ruRU ]] ["Sets the font height of the mana text"] = "Задает высоту шрифта для текста маны",
	--[[ ruRU ]] ["Font Shadow"] = "Тень шрифта",
	--[[ ruRU ]] ["Show font shadow on mana text"] = "Отображать тень для текста маны",
	--[[ ruRU ]] ["Outline"] = "Контур",
	--[[ ruRU ]] ["Sets the outline for mana text"] = "Задает окантовку для текста маны",
	--[[ ruRU ]] ["Mode"] = "Режим",
	--[[ ruRU ]] ["Choose what to show for mana text"] = "Выбрать, что показывать в тексте маны",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust mana text position"] = "Задать место значения маны",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the mana text"] = "Задает прикрепление текста маны",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the health bar to anchor the mana text"] = "Задает точку для положения текста маны относительно полоски здоровья",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the mana text"] = "Смещение текста маны по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the mana text"] = "Смещение текста маны по Y",
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Sets the alpha of the mana text"] = "Задает прозрачность текста маны",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the mana text color"] = "Задает цвет текста маны",

	--[[ ruRU ]] ["None"] = "Нет",
	--[[ ruRU ]] ["Normal"] = "Обычно",
	--[[ ruRU ]] ["Thick"] = "Жирный",

	--[[ ruRU ]] ["Percent"] = "Проценты",
	--[[ ruRU ]] ["Mana"] = "Мана",
	--[[ ruRU ]] ["Mana & Percent"] = "Мана & Проценты",
	--[[ ruRU ]] ["Deficit"] = "Дефицит",
	--[[ ruRU ]] ["Full"] = "Полное",

	--[[ ruRU ]] ["Always Show Target"] = "Всегда показывать цель",
	--[[ ruRU ]] ["Always show mana text on active targets in combat"] = "В бою всегда показывать текст маны текущей цели",

	--[[ ruRU ]] ["Advanced"] = "Дополнительно",
	--[[ ruRU ]] ["Options for expert users"] = "Настройки для опытных пользователей",
	--[[ ruRU ]] ["Format"] = "Формат",
	--[[ ruRU ]] ["Mana tag"] = "Вид маны",
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

dL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

bL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Mana Bar"] = "法力值显示条",
	--[[ zhCN ]] ["Mana Bar options"] = "法力值显示条相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show mana bars on group member nameplates"] = "在队友的姓名板上显示法力值显示条",

	--[[ zhCN ]] ["Texture"] = "材质",
	--[[ zhCN ]] ["Sets the mana bar texture"] = "设定法力值显示条的材质",
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Sets the mana bar alpha"] = "设定法力值显示条的透明度",

	--[[ zhCN ]] ["Height"] = "高度",
	--[[ zhCN ]] ["Sets the height of the mana bar"] = "设定法力值显示条的高度",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust the mana bar's position"] = "调整法力值显示条的位置",
	--[[ zhCN ]] ["Left Offset"] = "向左偏移",
	--[[ zhCN ]] ["Sets the offset of the left of the mana bar"] = "设定法力值显示条的向左偏移量",
	--[[ zhCN ]] ["Right Offset"] = "向右偏移",
	--[[ zhCN ]] ["Sets the offset of the right of the mana bar"] = "设定法力值显示条的向右偏移量",
	--[[ zhCN ]] ["Vertical Offset"] = "垂直偏移",
	--[[ zhCN ]] ["Sets the vertical offset of the mana bar"] = "设定法力值显示条的垂直偏移量",

	--[[ zhCN ]] ["Colors"] = "颜色",
	--[[ zhCN ]] ["Customize colors"] = "自定义颜色",
	--[[ zhCN ]] ["Backdrop Color"] = "背景颜色",
	--[[ zhCN ]] ["Sets the backdrop color of the mana bar"] = "设定法力值显示条的背景颜色",
	--[[ zhCN ]] ["Mana Color"] = "法力颜色",
	--[[ zhCN ]] ["Sets the color for mana bars"] = "设定法力条的颜色",
	--[[ zhCN ]] ["Rage Color"] = "怒气颜色",
	--[[ zhCN ]] ["Sets the color for rage bars"] = "设定怒气条的颜色",
	--[[ zhCN ]] ["Focus Color"] = "集中值颜色",
	--[[ zhCN ]] ["Sets the color for focus bars"] = "设定集中值显示条的颜色",
	--[[ zhCN ]] ["Energy Color"] = "能量颜色",
	--[[ zhCN ]] ["Sets the color for energy bars"] = "设定能量条的颜色",
	--[[ zhCN ]] ["Happiness Color"] = "快乐值颜色",
	--[[ zhCN ]] ["Sets the color for happiness bars"] = "设定快乐值显示条的颜色",
	--[[ zhCN ]] ["Rune Color"] = "Rune Color",
	--[[ zhCN ]] ["Sets the color for rune bars"] = "Sets the color for rune bars",
	--[[ zhCN ]] ["Runic Power Color"] = "Runic Power Color",
	--[[ zhCN ]] ["Sets the color for runic power bars"] = "Sets the color for runic power bars",
	--[[ zhCN ]] ["Reset to Defaults"] = "重置为默认值",
	--[[ zhCN ]] ["Resets all colors to their defaults"] = "将全部颜色设定重置为默认",

	--[[ zhCN ]] ["Border"] = "Border",
	--[[ zhCN ]] ["Border options"] = "Border options",
	--[[ zhCN ]] ["Target Only"] = "Target Only",
	--[[ zhCN ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ zhCN ]] ["Border Color"] = "边框颜色",
	--[[ zhCN ]] ["Sets the border color of the mana bar"] = "Sets the border color of the mana bar",
	--[[ zhCN ]] ["Border Style"] = "边框样式",
	--[[ zhCN ]] ["Sets the style of the mana bar border"] = "Sets the style of the mana bar border",

	--[[ zhCN ]] --["Always Show Target"] = "始终显示目标",
	--[[ zhCN ]] --["Always show mana bar on active targets in combat"] = "在战斗中始终显示当前目标的法力值",

	--[[ zhCN ]] ["Advanced"] = "高级",
	--[[ zhCN ]] ["Options for expert users"] = "高级设置",
	--[[ zhCN ]] ["Color Format"] = "颜色格式",
	--[[ zhCN ]] ["Color tag"] = "颜色标签",
	--[[ zhCN ]] ["<Any tag string>"] = "<任意标签文字>",
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Mana Text"] = "法力提示文字",
	--[[ zhCN ]] ["Mana text options"] = "法力提示文字相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show mana text on group member nameplates"] = "在队友的姓名板上显示法力文字",

	--[[ zhCN ]] ["Color by type"] = "根据类型显示颜色",
	--[[ zhCN ]] ["Color text differently for mana, energy, rage"] = "根据不同的类型（法力、能量或怒气）显示颜色",

	--[[ zhCN ]] ["Typeface"] = "式样",
	--[[ zhCN ]] ["Mana text typeface options"] = "法力提示文字的式样设置",
	--[[ zhCN ]] ["Font"] = "字体",
	--[[ zhCN ]] ["Sets the font for mana text"] = "设定法力提示文字的字体",
	--[[ zhCN ]] ["Font Size"] = "字号",
	--[[ zhCN ]] ["Sets the font height of the mana text"] = "设定法力提示文字的字号",
	--[[ zhCN ]] ["Font Shadow"] = "字体阴影",
	--[[ zhCN ]] ["Show font shadow on mana text"] = "设定法力提示文字的字体阴影",
	--[[ zhCN ]] ["Outline"] = "轮廓",
	--[[ zhCN ]] ["Sets the outline for mana text"] = "设定法力提示文字的字体轮廓",
	--[[ zhCN ]] ["Mode"] = "模式",
	--[[ zhCN ]] ["Choose what to show for mana text"] = "选择在法力提示文字的显示内容",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust mana text position"] = "设定法力提示文字的位置",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the mana text"] = "设定法力提示文字的锚点",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the health bar to anchor the mana text"] = "设定法力提示文字固定在生命值显示条的相对位置",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the mana text"] = "设定法力提示文字的X轴偏移量",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the mana text"] = "设定法力提示文字的Y轴偏移量",
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Sets the alpha of the mana text"] = "设定法力提示文字的透明度",
	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the mana text color"] = "设定法力提示文字的颜色",

	--[[ zhCN ]] ["None"] = "无",
	--[[ zhCN ]] ["Normal"] = "正常",
	--[[ zhCN ]] ["Thick"] = "粗",

	--[[ zhCN ]] ["Percent"] = "百分比",
	--[[ zhCN ]] ["Mana"] = "法力",
	--[[ zhCN ]] ["Mana & Percent"] = "法力值和百分比",
	--[[ zhCN ]] ["Deficit"] = "不足额",
	--[[ zhCN ]] ["Full"] = "完全",

	--[[ zhCN ]] ["Always Show Target"] = "始终显示目标",
	--[[ zhCN ]] ["Always show mana text on active targets in combat"] = "战斗中始终显示当前目标的法力文字",

	--[[ zhCN ]] ["Advanced"] = "高级",
	--[[ zhCN ]] ["Options for expert users"] = "高级设置",
	--[[ zhCN ]] ["Format"] = "格式",
	--[[ zhCN ]] ["Mana tag"] = "法力标签",
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

dL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

bL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Mana Bar"] = "能力條",
	--[[ zhTW ]] ["Mana Bar options"] = "能力條選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show mana bars on group member nameplates"] = "在團體名牌顯示能力條",

	--[[ zhTW ]] ["Texture"] = "紋理",
	--[[ zhTW ]] ["Sets the mana bar texture"] = "能力條紋理",
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Sets the mana bar alpha"] = "能力條透明度",

	--[[ zhTW ]] ["Height"] = "高度",
	--[[ zhTW ]] ["Sets the height of the mana bar"] = "能力條高度",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust the mana bar's position"] = "能力條位置",
	--[[ zhTW ]] ["Left Offset"] = "左位移",
	--[[ zhTW ]] ["Sets the offset of the left of the mana bar"] = "能力條左位移",
	--[[ zhTW ]] ["Right Offset"] = "右位移",
	--[[ zhTW ]] ["Sets the offset of the right of the mana bar"] = "能力條右位移",
	--[[ zhTW ]] ["Vertical Offset"] = "垂直位移",
	--[[ zhTW ]] ["Sets the vertical offset of the mana bar"] = "能力條垂直位移",

	--[[ zhTW ]] ["Colors"] = "顏色",
	--[[ zhTW ]] ["Customize colors"] = "自定顏色",
	--[[ zhTW ]] ["Backdrop Color"] = "背景顏色",
	--[[ zhTW ]] ["Sets the backdrop color of the mana bar"] = "能力條背景顏色",
	--[[ zhTW ]] ["Mana Color"] = "法力顏色",
	--[[ zhTW ]] ["Sets the color for mana bars"] = "法力條顏色",
	--[[ zhTW ]] ["Rage Color"] = "怒氣顏色",
	--[[ zhTW ]] ["Sets the color for rage bars"] = "怒氣條顏色",
	--[[ zhTW ]] ["Focus Color"] = "集中值顏色",
	--[[ zhTW ]] ["Sets the color for focus bars"] = "集中值條顏色",
	--[[ zhTW ]] ["Energy Color"] = "能量顏色",
	--[[ zhTW ]] ["Sets the color for energy bars"] = "能量條顏色",
	--[[ zhTW ]] ["Happiness Color"] = "快樂值顏色",
	--[[ zhTW ]] ["Sets the color for happiness bars"] = "快樂值條顏色",
	--[[ zhTW ]] ["Rune Color"] = "Rune Color",
	--[[ zhTW ]] ["Sets the color for rune bars"] = "Sets the color for rune bars",
	--[[ zhTW ]] ["Runic Power Color"] = "Runic Power Color",
	--[[ zhTW ]] ["Sets the color for runic power bars"] = "Sets the color for runic power bars",
	--[[ zhTW ]] ["Reset to Defaults"] = "重設回預設值",
	--[[ zhTW ]] ["Resets all colors to their defaults"] = "重設全部顏色回預設值",

	--[[ zhTW ]] ["Border"] = "Border",
	--[[ zhTW ]] ["Border options"] = "Border options",
	--[[ zhTW ]] ["Target Only"] = "Target Only",
	--[[ zhTW ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ zhTW ]] ["Border Color"] = "邊框顏色",
	--[[ zhTW ]] ["Sets the border color of the mana bar"] = "Sets the border color of the mana bar",
	--[[ zhTW ]] ["Border Style"] = "邊框樣式",
	--[[ zhTW ]] ["Sets the style of the mana bar border"] = "Sets the style of the mana bar border",

	--[[ zhTW ]] --["Always Show Target"] = "始終顯示目標",
	--[[ zhTW ]] --["Always show mana bar on active targets in combat"] = "在戰斗中始終顯示當前目標的法力",

	--[[ zhTW ]] ["Advanced"] = "進階",
	--[[ zhTW ]] ["Options for expert users"] = "進階選項",
	--[[ zhTW ]] ["Color Format"] = "顏色格式",
	--[[ zhTW ]] ["Color tag"] = "顏色標籤",
	--[[ zhTW ]] ["<Any tag string>"] = "<任何標籤文字>",
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Mana Text"] = "法力文字",
	--[[ zhTW ]] ["Mana text options"] = "法力文字選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show mana text on group member nameplates"] = "在團體名牌顯示法力文字",

	--[[ zhTW ]] ["Color by type"] = "根據類型上色",
	--[[ zhTW ]] ["Color text differently for mana, energy, rage"] = "根據不同類型 (法力，能量，怒氣) 設定顏色",

	--[[ zhTW ]] ["Typeface"] = "字體",
	--[[ zhTW ]] ["Mana text typeface options"] = "法力文字字體選項",
	--[[ zhTW ]] ["Font"] = "字型",
	--[[ zhTW ]] ["Sets the font for mana text"] = "法力文字字型",
	--[[ zhTW ]] ["Font Size"] = "字型大小",
	--[[ zhTW ]] ["Sets the font height of the mana text"] = "法力文字字型大小",
	--[[ zhTW ]] ["Font Shadow"] = "字型陰影",
	--[[ zhTW ]] ["Show font shadow on mana text"] = "法力文字字型陰影",
	--[[ zhTW ]] ["Outline"] = "輪廓",
	--[[ zhTW ]] ["Sets the outline for mana text"] = "法力文字字型輪廓",
	--[[ zhTW ]] ["Mode"] = "模式",
	--[[ zhTW ]] ["Choose what to show for mana text"] = "選擇在法力文字顯示什麼",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust mana text position"] = "法力文字位置",
	--[[ zhTW ]] ["Anchor"] = "定位點",
	--[[ zhTW ]] ["Sets the anchor for the mana text"] = "法力文字定位點",
	--[[ zhTW ]] ["Anchor To"] = "固定在",
	--[[ zhTW ]] ["Sets the relative point on the health bar to anchor the mana text"] = "法力文字固定在生命力條的位置",
	--[[ zhTW ]] ["X Offset"] = "X位移",
	--[[ zhTW ]] ["X offset of the mana text"] = "法力文字X位移",
	--[[ zhTW ]] ["Y Offset"] = "Y位移",
	--[[ zhTW ]] ["Y offset of the mana text"] = "法力文字Y位移",
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Sets the alpha of the mana text"] = "法力文字透明度",
	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the mana text color"] = "法力文字顏色",

	--[[ zhTW ]] ["None"] = "無",
	--[[ zhTW ]] ["Normal"] = "正常",
	--[[ zhTW ]] ["Thick"] = "粗",

	--[[ zhTW ]] ["Percent"] = "百分比",
	--[[ zhTW ]] ["Mana"] = "法力",
	--[[ zhTW ]] ["Mana & Percent"] = "法力值和百分比",
	--[[ zhTW ]] ["Deficit"] = "不足額",
	--[[ zhTW ]] ["Full"] = "完全",

	--[[ zhTW ]] ["Always Show Target"] = "始終顯示目標",
	--[[ zhTW ]] ["Always show mana text on active targets in combat"] = "戰斗中始終顯示當前目標的法力文字",

	--[[ zhTW ]] ["Advanced"] = "進階",
	--[[ zhTW ]] ["Options for expert users"] = "進階選項",
	--[[ zhTW ]] ["Format"] = "格式",
	--[[ zhTW ]] ["Mana tag"] = "能力標籤",
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

dL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
