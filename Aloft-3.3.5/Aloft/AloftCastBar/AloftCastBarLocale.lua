local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local bL = AceLibrary("AceLocale-2.2"):new("AloftCastBarOptions")

-----------------------------------------------------------------------------

bL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Cast Bar"] = true,
	--[[ enUS ]] ["Cast bar options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Shows the current target's casting bar"] = true,
	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust cast bar position"] = true,
	--[[ enUS ]] ["Left Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the left of the cast bar"] = true,
	--[[ enUS ]] ["Right Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the right of the cast bar"] = true,
	--[[ enUS ]] ["Vertical Offset"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the cast bar"] = true,
	--[[ enUS ]] ["Height"] = true,
	--[[ enUS ]] ["Sets the height of the cast bar"] = true,

	--[[ enUS ]] ["Interruptable Cast Bar"] = true,
	--[[ enUS ]] ["Cast bar appearance for interruptable spells"] = true,
	--[[ enUS ]] ["Uninterruptable Cast Bar"] = true,
	--[[ enUS ]] ["Cast bar appearance for uninterruptable spells"] = true,

	--[[ enUS ]] ["Cast Bar Color"] = true,
	--[[ enUS ]] ["Sets the color of the cast bar"] = true,
	--[[ enUS ]] ["Backdrop Color"] = true,
	--[[ enUS ]] ["Sets the backdrop color of the cast bar"] = true,
	--[[ enUS ]] ["Border Color"] = true,
	--[[ enUS ]] ["Sets the border color of the cast bar"] = true,
	--[[ enUS ]] ["Border Style"] = true,
	--[[ enUS ]] ["Sets the style of the cast bar border"] = true,
	--[[ enUS ]] ["Texture"] = true,
	--[[ enUS ]] ["Sets the cast bar texture"] = true,
} end)

-----------------------------------------------------------------------------

local iL = AceLibrary("AceLocale-2.2"):new("AloftSpellIconOptions")

-----------------------------------------------------------------------------

iL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Spell Icon"] = true,
	--[[ enUS ]] ["Spell icon placement options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Enable spell icon display on the nameplate"] = true,
	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust spell icon position"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the spell icon"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the cast bar to anchor the spell icon"] = true,
	--[[ enUS ]] ["Size"] = true,
	--[[ enUS ]] ["Size in pixels of the spell icon"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the spell icon"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the spell icon"] = true,

	--[[ enUS ]] ["Shield"] = true,
	--[[ enUS ]] ["Shows a shield graphic around an uninterruptable spell icon"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Enables the shield graphic"] = true,
	--[[ enUS ]] ["Style"] = true,
	--[[ enUS ]] ["Sets the shield graphic style"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the shield graphic color"] = true,

	--[[ enUS ]] ["SQUARE"] = true,
	--[[ enUS ]] ["ROUND"] = true,

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

local nL = AceLibrary("AceLocale-2.2"):new("AloftSpellNameTextOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

nL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Spell Name"] = true,
	--[[ enUS ]] ["Cast bar spell name text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show spell name on cast bar"] = true,
	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Spell name typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for spell name"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the spell name"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on spell name"] = true,
	--[[ enUS ]] ["Alignment"] = true,
	--[[ enUS ]] ["Sets the alignment of the spell name"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the font outline for spell name"] = true,
	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust spell name position"] = true,
	--[[ enUS ]] ["Left Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the left of the text"] = true,
	--[[ enUS ]] ["Right Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the right of the text"] = true,
	--[[ enUS ]] ["Vertical Offset"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the text"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the spell name color"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["LEFT"] = true,
	--[[ enUS ]] ["CENTER"] = true,
	--[[ enUS ]] ["RIGHT"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local tL = AceLibrary("AceLocale-2.2"):new("AloftCastBarTimeTextOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

tL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Time Text"] = true,
	--[[ enUS ]] ["Cast bar time text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show cast bar time text"] = true,
	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Cast bar time text typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for cast bar time text"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the cast bar time text"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on cast bar time text"] = true,
	--[[ enUS ]] ["Alignment"] = true,
	--[[ enUS ]] ["Sets the alignment of the cast bar time text"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the font outline for cast bar time text"] = true,
	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust cast bar time text position"] = true,
	--[[ enUS ]] ["Left Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the left of the text"] = true,
	--[[ enUS ]] ["Right Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the right of the text"] = true,
	--[[ enUS ]] ["Vertical Offset"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the text"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the cast bar time text color"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["LEFT"] = true,
	--[[ enUS ]] ["CENTER"] = true,
	--[[ enUS ]] ["RIGHT"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

bL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Cast Bar"] = "시전바",
	--[[ koKR ]] ["Cast bar options"] = "시전바 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Shows the current target's casting bar"] = "현재 대상의 시전바를 표시합니다.",
	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust cast bar position"] = "시전바 위치 조절",
	--[[ koKR ]] ["Left Offset"] = "좌측 좌표",
	--[[ koKR ]] ["Sets the offset of the left of the cast bar"] = "시전바의 좌측 좌표를 설정합니다.",
	--[[ koKR ]] ["Right Offset"] = "우측 좌표",
	--[[ koKR ]] ["Sets the offset of the right of the cast bar"] = "시전바의 우측 좌표를 설정합니다.",
	--[[ koKR ]] ["Vertical Offset"] = "수직 좌표",
	--[[ koKR ]] ["Sets the vertical offset of the cast bar"] = "시전바의 수직 좌표를 설정합니다.",
	--[[ koKR ]] ["Height"] = "높이",
	--[[ koKR ]] ["Sets the height of the cast bar"] = "시전바의 높이를 설정합니다.",

	--[[ koKR ]] ["Interruptable Cast Bar"] = "Interruptable Cast Bar",
	--[[ koKR ]] ["Cast bar appearance for interruptable spells"] = "Cast bar appearance for interruptable spells",
	--[[ koKR ]] ["Uninterruptable Cast Bar"] = "Uninterruptable Cast Bar",
	--[[ koKR ]] ["Cast bar appearance for uninterruptable spells"] = "Cast bar appearance for uninterruptable spells",

	--[[ koKR ]] ["Cast Bar Color"] = "Cast Bar Color",
	--[[ koKR ]] ["Sets the color of the cast bar"] = "Sets the color of the cast bar",
	--[[ koKR ]] ["Backdrop Color"] = "배경 색상",
	--[[ koKR ]] ["Sets the backdrop color of the cast bar"] = "시전바의 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Border Color"] = "테두리 색상",
	--[[ koKR ]] ["Sets the border color of the cast bar"] = "Sets the border color of the cast bar",
	--[[ koKR ]] ["Border Style"] = "테두리 스타일",
	--[[ koKR ]] ["Sets the style of the cast bar border"] = "Sets the style of the cast bar border",
	--[[ koKR ]] ["Texture"] = "텍스쳐",
	--[[ koKR ]] ["Sets the cast bar texture"] = "시전바의 텍스쳐를 설정합니다.",
} end)

-----------------------------------------------------------------------------

iL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Spell Icon"] = "주문 아이콘",
	--[[ koKR ]] ["Spell icon placement options"] = "주문 아이콘 배치 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Enable spell icon display on the nameplate"] = "이름표에 주문 아이콘을 표시합니다.",
	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust spell icon position"] = "주문 아이콘 위치 조절",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the spell icon"] = "주문 아이콘의 앵커를 설정합니다.",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the cast bar to anchor the spell icon"] = "시전 바에서 주문 아이콘의 앵커 위치를 설정합니다.",
	--[[ koKR ]] ["Size"] = "크기",
	--[[ koKR ]] ["Size in pixels of the spell icon"] = "주문 아이콘의 크기입니다.",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the spell icon"] = "주문 아이콘의 X 좌표 입니다.",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the spell icon"] = "주문 아이콘의 Y 좌표 입니다.",

	--[[ koKR ]] ["Shield"] = "Shield",
	--[[ koKR ]] ["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon",
	--[[ koKR ]] ["Enable"] = "Enable",
	--[[ koKR ]] ["Enables the shield graphic"] = "Enables the shield graphic",
	--[[ koKR ]] ["Style"] = "Style",
	--[[ koKR ]] ["Sets the shield graphic style"] = "Sets the shield graphic style",
	--[[ koKR ]] ["Color"] = "Color",
	--[[ koKR ]] ["Sets the shield graphic color"] = "Sets the shield graphic color",

	--[[ koKR ]] ["SQUARE"] = "SQUARE",
	--[[ koKR ]] ["ROUND"] = "ROUND",

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

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

nL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Spell Name"] = "주문명",
	--[[ koKR ]] ["Cast bar spell name text options"] = "시전바 주문명 글자 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show spell name on cast bar"] = "시전바에 주문명을 표시합니다.",
	--[[ koKR ]] ["Typeface"] = "서체",
	--[[ koKR ]] ["Spell name typeface options"] = "주문명 서체 설정",
	--[[ koKR ]] ["Font"] = "글꼴",
	--[[ koKR ]] ["Sets the font for spell name"] = "주문명의 글꼴을 설정합니다.",
	--[[ koKR ]] ["Font Size"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the font height of the spell name"] = "주문명 글자의 높이를 설정합니다.",
	--[[ koKR ]] ["Font Shadow"] = "글꼴 그림자",
	--[[ koKR ]] ["Show font shadow on spell name"] = "주문명에 그림자를 표시합니다.",
	--[[ koKR ]] ["Alignment"] = "정렬",
	--[[ koKR ]] ["Sets the alignment of the spell name"] = "주문명의 정렬을 설정합니다.",
	--[[ koKR ]] ["Outline"] = "테두리",
	--[[ koKR ]] ["Sets the font outline for spell name"] = "주문명의 테두리를 설정합니다.",
	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust spell name position"] = "주문명 위치 조절",
	--[[ koKR ]] ["Left Offset"] = "좌측 좌표",
	--[[ koKR ]] ["Sets the offset of the left of the text"] = "글자의 좌측 좌표를 설정합니다.",
	--[[ koKR ]] ["Right Offset"] = "우측 좌표",
	--[[ koKR ]] ["Sets the offset of the right of the text"] = "글자의 우측 좌표를 설정합니다.",
	--[[ koKR ]] ["Vertical Offset"] = "수직 좌표",
	--[[ koKR ]] ["Sets the vertical offset of the text"] = "글자의 수직 좌표를 설정합니다.",
	--[[ koKR ]] ["Color"] = "색상",
	--[[ koKR ]] ["Sets the spell name color"] = "주문명의 색상을 설정합니다.",

	--[[ koKR ]] ["None"] = "없음",
	--[[ koKR ]] ["Normal"] = "기본",
	--[[ koKR ]] ["Thick"] = "굵게",

	--[[ koKR ]] ["LEFT"] = "좌측",
	--[[ koKR ]] ["CENTER"] = "가운데",
	--[[ koKR ]] ["RIGHT"] = "우측",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

tL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Time Text"] = "시전 시간",
	--[[ koKR ]] ["Cast bar time text options"] = "시전 시간 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show cast bar time text"] = "시전바에 시간을 표시합니다.",
	--[[ koKR ]] ["Typeface"] = "서체",
	--[[ koKR ]] ["Cast bar time text typeface options"] = "시전 시간 서체 설정",
	--[[ koKR ]] ["Font"] = "글꼴",
	--[[ koKR ]] ["Sets the font for cast bar time text"] = "시전 시간의 글꼴을 설정합니다.",
	--[[ koKR ]] ["Font Size"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the font height of the cast bar time text"] = "시전 시간의 높이를 설정합니다.",
	--[[ koKR ]] ["Font Shadow"] = "글꼴 그림자",
	--[[ koKR ]] ["Show font shadow on cast bar time text"] = "시전 시간에 그림자를 표시합니다.",
	--[[ koKR ]] ["Alignment"] = "정렬",
	--[[ koKR ]] ["Sets the alignment of the cast bar time text"] = "시전 시간의 정렬을 설정합니다.",
	--[[ koKR ]] ["Outline"] = "테두리",
	--[[ koKR ]] ["Sets the font outline for cast bar time text"] = "시전 시간의 테두리를 설정합니다.",
	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust cast bar time text position"] = "시전 시간 위치 조절",
	--[[ koKR ]] ["Left Offset"] = "좌측 좌표",
	--[[ koKR ]] ["Sets the offset of the left of the text"] = "시전 시간의 좌측 좌표를 설정합니다.",
	--[[ koKR ]] ["Right Offset"] = "우측 좌표",
	--[[ koKR ]] ["Sets the offset of the right of the text"] = "시전 시간의 우측 좌표를 설정합니다.",
	--[[ koKR ]] ["Vertical Offset"] = "수직 좌표",
	--[[ koKR ]] ["Sets the vertical offset of the text"] = "시전 시간의 수직 좌표를 설정합니다.",
	--[[ koKR ]] ["Color"] = "색상",
	--[[ koKR ]] ["Sets the cast bar time text color"] = "시전 시간의 색상을 설정합니다.",

	--[[ koKR ]] ["None"] = "없음",
	--[[ koKR ]] ["Normal"] = "기본",
	--[[ koKR ]] ["Thick"] = "굵게",

	--[[ koKR ]] ["LEFT"] = "좌측",
	--[[ koKR ]] ["CENTER"] = "가운데",
	--[[ koKR ]] ["RIGHT"] = "우측",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

bL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Cast Bar"] = "Полоска каста",
	--[[ ruRU ]] ["Cast bar options"] = "Настройки полоски заклинания",

	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Shows the current target's casting bar"] = "Отображает каст заклинания текущей цели",
	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust cast bar position"] = "Задать место полоски заклинания",
	--[[ ruRU ]] ["Left Offset"] = "Смещение влева",
	--[[ ruRU ]] ["Sets the offset of the left of the cast bar"] = "Задает смещение левого конца полоски заклинания",
	--[[ ruRU ]] ["Right Offset"] = "Смещение вправа",
	--[[ ruRU ]] ["Sets the offset of the right of the cast bar"] = "Задает смещение правого конца полоски заклинания",
	--[[ ruRU ]] ["Vertical Offset"] = "Смещение по вертикале",
	--[[ ruRU ]] ["Sets the vertical offset of the cast bar"] = "Задает вертикальное смещение полоски заклинания",
	--[[ ruRU ]] ["Height"] = "Высота",
	--[[ ruRU ]] ["Sets the height of the cast bar"] = "Задает высоту полоски заклинания",

	--[[ ruRU ]] ["Interruptable Cast Bar"] = "Прерываемые заклинания",
	--[[ ruRU ]] ["Cast bar appearance for interruptable spells"] = "Отображение полосы применений для прерываемых заклинаний",
	--[[ ruRU ]] ["Uninterruptable Cast Bar"] = "Непрерываемая заклинания",
	--[[ ruRU ]] ["Cast bar appearance for uninterruptable spells"] = "Отображение полосы применений для непрерываемых заклинаний",

	--[[ ruRU ]] ["Cast Bar Color"] = "Цвет полоски заклинания",
	--[[ ruRU ]] ["Sets the color of the cast bar"] = "Задает цвет полоски заклинания",
	--[[ ruRU ]] ["Backdrop Color"] = "Цвет тени",
	--[[ ruRU ]] ["Sets the backdrop color of the cast bar"] = "Задает цвет тени полоски заклинания",
	--[[ ruRU ]] ["Border Color"] = "Цвет рамки",
	--[[ ruRU ]] ["Sets the border color of the cast bar"] = "Установка цвета краев полосы применения",
	--[[ ruRU ]] ["Border Style"] = "Стиль рамки",
	--[[ ruRU ]] ["Sets the style of the cast bar border"] = "Установка стиля краев полосы применения",
	--[[ ruRU ]] ["Texture"] = "Текстура",
	--[[ ruRU ]] ["Sets the cast bar texture"] = "Задает текстуру полоски заклинания",
} end)

-----------------------------------------------------------------------------

iL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Spell Icon"] = "Значок заклинания",
	--[[ ruRU ]] ["Spell icon placement options"] = "Настройки положения значка заклинания",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Enable spell icon display on the nameplate"] = "Включить отображение значка заклинания на табличке",
	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust spell icon position"] = "Задать место иконки заклинания",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the spell icon"] = "Задает прикрепление значка заклинания",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the cast bar to anchor the spell icon"] = "Задает точку для положения значка заклинания относительно полоски здоровья",
	--[[ ruRU ]] ["Size"] = "Размер",
	--[[ ruRU ]] ["Size in pixels of the spell icon"] = "Размер значка заклинания в пикселях",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the spell icon"] = "Смещение значка заклинания по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the spell icon"] = "Смещение значка заклинания по Y",

	--[[ ruRU ]] ["Shield"] = "Щит",
	--[[ ruRU ]] ["Shows a shield graphic around an uninterruptable spell icon"] = "Показывать графику щита около иконки непрерываемой способности",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Enables the shield graphic"] = "Включить рисунок щита",
	--[[ ruRU ]] ["Style"] = "Стиль",
	--[[ ruRU ]] ["Sets the shield graphic style"] = "Установка стиля рисунка щита",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the shield graphic color"] = "Установка цвета рисунка щита",

	--[[ ruRU ]] ["SQUARE"] = "КВАДРАТ",
	--[[ ruRU ]] ["ROUND"] = "КРУГЛЫЙ",

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

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

nL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Spell Name"] = "Имя заклинания",
	--[[ ruRU ]] ["Cast bar spell name text options"] = "Настройки названия для полоске заклинания",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show spell name on cast bar"] = "Отображать название на полоске заклинания",
	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Spell name typeface options"] = "Настройки шрифта для заклинания",
	--[[ ruRU ]] ["Font"] = "Шрифт",
	--[[ ruRU ]] ["Sets the font for spell name"] = "Задает шрифт для названия заклинания",
	--[[ ruRU ]] ["Font Size"] = "Размер шрифта",
	--[[ ruRU ]] ["Sets the font height of the spell name"] = "Задает высоту шрифта для названия заклинания",
	--[[ ruRU ]] ["Font Shadow"] = "Тень шрифта",
	--[[ ruRU ]] ["Show font shadow on spell name"] = "Отображать тень для названия заклинания",
	--[[ ruRU ]] ["Alignment"] = "Выравнивание",
	--[[ ruRU ]] ["Sets the alignment of the spell name"] = "Задает выравнивание названия заклинания",
	--[[ ruRU ]] ["Outline"] = "Контур",
	--[[ ruRU ]] ["Sets the font outline for spell name"] = "Задает окантовку для названия заклинания",
	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust spell name position"] = "Задать место названия заклинания",
	--[[ ruRU ]] ["Left Offset"] = "Смещение влево",
	--[[ ruRU ]] ["Sets the offset of the left of the text"] = "Смещение текста влево",
	--[[ ruRU ]] ["Right Offset"] = "Смещение вправо",
	--[[ ruRU ]] ["Sets the offset of the right of the text"] = "Смещение текста вправо",
	--[[ ruRU ]] ["Vertical Offset"] = "Смещение по вертикале",
	--[[ ruRU ]] ["Sets the vertical offset of the text"] = "Смещение текста по вертикале",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the spell name color"] = "Задает цвет названия заклинания",

	--[[ ruRU ]] ["None"] = "Нет",
	--[[ ruRU ]] ["Normal"] = "Обычно",
	--[[ ruRU ]] ["Thick"] = "Жирный",

	--[[ ruRU ]] ["LEFT"] = "СЛЕВА",
	--[[ ruRU ]] ["CENTER"] = "ПО ЦЕНТРУ",
	--[[ ruRU ]] ["RIGHT"] = "СПРАВА",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

tL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Time Text"] = "Текст времени",
	--[[ ruRU ]] ["Cast bar time text options"] = "Настройки отображения времени заклинания",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show cast bar time text"] = "Отображать текст времени заклинания",
	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Cast bar time text typeface options"] = "Настройки шрифта для времени на полоске заклинания",
	--[[ ruRU ]] ["Font"] = "Шрифт",
	--[[ ruRU ]] ["Sets the font for cast bar time text"] = "Задает шрифт для текста времени заклинания",
	--[[ ruRU ]] ["Font Size"] = "Размер шрифта",
	--[[ ruRU ]] ["Sets the font height of the cast bar time text"] = "Задает высоту шрифта для текста времени заклинания",
	--[[ ruRU ]] ["Font Shadow"] = "Тень шрифта",
	--[[ ruRU ]] ["Show font shadow on cast bar time text"] = "Отображать тень для текста времени заклинания",
	--[[ ruRU ]] ["Alignment"] = "Выравнивание",
	--[[ ruRU ]] ["Sets the alignment of the cast bar time text"] = "Задает выравнивание текста времени на полоске заклинания",
	--[[ ruRU ]] ["Outline"] = "Контур",
	--[[ ruRU ]] ["Sets the font outline for cast bar time text"] = "Задает окантовку для текста времени заклинания",
	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust cast bar time text position"] = "Задать место времени заклинания",
	--[[ ruRU ]] ["Left Offset"] = "Смещение в лева",
	--[[ ruRU ]] ["Sets the offset of the left of the text"] = "Задает смещение левого конца текста",
	--[[ ruRU ]] ["Right Offset"] = "Смещение в права",
	--[[ ruRU ]] ["Sets the offset of the right of the text"] = "Задает смещение правого конца текста",
	--[[ ruRU ]] ["Vertical Offset"] = "Смещение по вертикале",
	--[[ ruRU ]] ["Sets the vertical offset of the text"] = "Задает вертикальное смещение текста",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the cast bar time text color"] = "Задает цвет текста полоски заклинания",

	--[[ ruRU ]] ["None"] = "Нет",
	--[[ ruRU ]] ["Normal"] = "Обычно",
	--[[ ruRU ]] ["Thick"] = "Жирный",

	--[[ ruRU ]] ["LEFT"] = "СЛЕВА",
	--[[ ruRU ]] ["CENTER"] = "ПО ЦЕНТРУ",
	--[[ ruRU ]] ["RIGHT"] = "СПРАВА",
} end)
	
-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

bL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Cast Bar"] = "施法条",
	--[[ zhCN ]] ["Cast bar options"] = "施法条相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Shows the current target's casting bar"] = "显示当前目标的施法条",
	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust cast bar position"] = "调整施法条的位置",
	--[[ zhCN ]] ["Left Offset"] = "向左偏移",
	--[[ zhCN ]] ["Sets the offset of the left of the cast bar"] = "设定施法條的向左偏移量",
	--[[ zhCN ]] ["Right Offset"] = "向右偏移",
	--[[ zhCN ]] ["Sets the offset of the right of the cast bar"] = "设定施法条的向右偏移量",
	--[[ zhCN ]] ["Vertical Offset"] = "垂直偏移",
	--[[ zhCN ]] ["Sets the vertical offset of the cast bar"] = "设定施法条的垂直偏移量",
	--[[ zhCN ]] ["Height"] = "高度",
	--[[ zhCN ]] ["Sets the height of the cast bar"] = "设置施法条的高度",

	--[[ zhCN ]] ["Interruptable Cast Bar"] = "Interruptable Cast Bar",
	--[[ zhCN ]] ["Cast bar appearance for interruptable spells"] = "Cast bar appearance for interruptable spells",
	--[[ zhCN ]] ["Uninterruptable Cast Bar"] = "Uninterruptable Cast Bar",
	--[[ zhCN ]] ["Cast bar appearance for uninterruptable spells"] = "Cast bar appearance for uninterruptable spells",

	--[[ zhCN ]] ["Cast Bar Color"] = "施法条颜色",
	--[[ zhCN ]] ["Sets the color of the cast bar"] = "设置施法条颜色",
	--[[ zhCN ]] ["Backdrop Color"] = "背景颜色",
	--[[ zhCN ]] ["Sets the backdrop color of the cast bar"] = "设定施法条的背景颜色",
	--[[ zhCN ]] ["Border Color"] = "边框颜色",
	--[[ zhCN ]] ["Sets the border color of the cast bar"] = "设置施法条边框颜色",
	--[[ zhCN ]] ["Border Style"] = "边框样式",
	--[[ zhCN ]] ["Sets the style of the cast bar border"] = "设置施法条边框样式",
	--[[ zhCN ]] ["Texture"] = "材质",
	--[[ zhCN ]] ["Sets the cast bar texture"] = "设定施法条的材质",
} end)

-----------------------------------------------------------------------------

iL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Spell Icon"] = "法术图标",
	--[[ zhCN ]] ["Spell icon placement options"] = "法术图标相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Enable spell icon display on the nameplate"] = "在姓名板上显示法术图标",
	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust spell icon position"] = "法术图标位置",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the spell icon"] = "设定法术图标的锚点",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the cast bar to anchor the spell icon"] = "设定法术图标固定在生命值显示条的相对位置",
	--[[ zhCN ]] ["Size"] = "尺寸",
	--[[ zhCN ]] ["Size in pixels of the spell icon"] = "以像素定义的法术图标尺寸",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the spell icon"] = "法术图标的X轴偏移量",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the spell icon"] = "法术图标的Y轴偏移量",

	--[[ zhCN ]] ["Shield"] = "Shield",
	--[[ zhCN ]] ["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon",
	--[[ zhCN ]] ["Enable"] = "Enable",
	--[[ zhCN ]] ["Enables the shield graphic"] = "Enables the shield graphic",
	--[[ zhCN ]] ["Style"] = "Style",
	--[[ zhCN ]] ["Sets the shield graphic style"] = "Sets the shield graphic style",
	--[[ zhCN ]] ["Color"] = "Color",
	--[[ zhCN ]] ["Sets the shield graphic color"] = "Sets the shield graphic color",

	--[[ zhCN ]] ["SQUARE"] = "SQUARE",
	--[[ zhCN ]] ["ROUND"] = "ROUND",

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

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

nL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Spell Name"] = "法术名称",
	--[[ zhCN ]] ["Cast bar spell name text options"] = "施法条法术名称文字相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show spell name on cast bar"] = "在施法条上显示法术名称",
	--[[ zhCN ]] ["Typeface"] = "字体",
	--[[ zhCN ]] ["Spell name typeface options"] = "法术名称文字式样设置",
	--[[ zhCN ]] ["Font"] = "字体",
	--[[ zhCN ]] ["Sets the font for spell name"] = "设定法术名称文字的字体",
	--[[ zhCN ]] ["Font Size"] = "字号",
	--[[ zhCN ]] ["Sets the font height of the spell name"] = "设定法术名称文字的字号",
	--[[ zhCN ]] ["Font Shadow"] = "字体阴影",
	--[[ zhCN ]] ["Show font shadow on spell name"] = "设定法术名称文字的字体阴影",
	--[[ zhCN ]] ["Alignment"] = "对齐",
	--[[ zhCN ]] ["Sets the alignment of the spell name"] = "设定法术名称文字的字体的对齐方式",
	--[[ zhCN ]] ["Outline"] = "轮廓",
	--[[ zhCN ]] ["Sets the font outline for spell name"] = "设定法术名称文字的字体轮廓",
	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust spell name position"] = "调整法术名称文字的位置",
	--[[ zhCN ]] ["Left Offset"] = "向左偏移",
	--[[ zhCN ]] ["Sets the offset of the left of the text"] = "设定法术名称文字的向左偏移量",
	--[[ zhCN ]] ["Right Offset"] = "向右偏移",
	--[[ zhCN ]] ["Sets the offset of the right of the text"] = "设定法术名称文字的向右偏移量",
	--[[ zhCN ]] ["Vertical Offset"] = "垂直位移",
	--[[ zhCN ]] ["Sets the vertical offset of the text"] = "设定法术名称文字的垂直偏移量",
	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the spell name color"] = "设定法术名称文字的颜色",

	--[[ zhCN ]] ["None"] = "无",
	--[[ zhCN ]] ["Normal"] = "正常",
	--[[ zhCN ]] ["Thick"] = "粗",

	--[[ zhCN ]] ["LEFT"] = "左",
	--[[ zhCN ]] ["CENTER"] = "中",
	--[[ zhCN ]] ["RIGHT"] = "右",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

tL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Time Text"] = "计时文字",
	--[[ zhCN ]] ["Cast bar time text options"] = "施法条计时文字相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show cast bar time text"] = "显示施法条计时文字",
	--[[ zhCN ]] ["Typeface"] = "式样",
	--[[ zhCN ]] ["Cast bar time text typeface options"] = "施法条计时文字式样设置",
	--[[ zhCN ]] ["Font"] = "字体",
	--[[ zhCN ]] ["Sets the font for cast bar time text"] = "设定施法条计时文字的字体",
	--[[ zhCN ]] ["Font Size"] = "字号",
	--[[ zhCN ]] ["Sets the font height of the cast bar time text"] = "设定施法条计时文字的字号",
	--[[ zhCN ]] ["Font Shadow"] = "字体阴影",
	--[[ zhCN ]] ["Show font shadow on cast bar time text"] = "设定施法条计时文字的字体阴影",
	--[[ zhCN ]] ["Alignment"] = "对齐",
	--[[ zhCN ]] ["Sets the alignment of the cast bar time text"] = "设定施法条计时文字的对齐方式",
	--[[ zhCN ]] ["Outline"] = "轮廓",
	--[[ zhCN ]] ["Sets the font outline for cast bar time text"] = "设定施法条计时文字的字体轮廓",
	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust cast bar time text position"] = "调整施法条计时文字的位置",
	--[[ zhCN ]] ["Left Offset"] = "向左偏移",
	--[[ zhCN ]] ["Sets the offset of the left of the text"] = "设定文字的向左偏移量",
	--[[ zhCN ]] ["Right Offset"] = "向右偏移",
	--[[ zhCN ]] ["Sets the offset of the right of the text"] = "设定文字的向右偏移量",
	--[[ zhCN ]] ["Vertical Offset"] = "垂直偏移",
	--[[ zhCN ]] ["Sets the vertical offset of the text"] = "设定文字的垂直偏移量",
	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the cast bar time text color"] = "设定施法条计时文字的颜色",

	--[[ zhCN ]] ["None"] = "无",
	--[[ zhCN ]] ["Normal"] = "正常",
	--[[ zhCN ]] ["Thick"] = "粗",

	--[[ zhCN ]] ["LEFT"] = "左",
	--[[ zhCN ]] ["CENTER"] = "中",
	--[[ zhCN ]] ["RIGHT"] = "右",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

bL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Cast Bar"] = "施法條",
	--[[ zhTW ]] ["Cast bar options"] = "施法條選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Shows the current target's casting bar"] = "顯示目前目標的施法條",
	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust cast bar position"] = "調整施法條位置",
	--[[ zhTW ]] ["Left Offset"] = "左位移",
	--[[ zhTW ]] ["Sets the offset of the left of the cast bar"] = "施法條左位移",
	--[[ zhTW ]] ["Right Offset"] = "右位移",
	--[[ zhTW ]] ["Sets the offset of the right of the cast bar"] = "施法條右位移",
	--[[ zhTW ]] ["Vertical Offset"] = "垂直位移",
	--[[ zhTW ]] ["Sets the vertical offset of the cast bar"] = "施法條垂直位移",
	--[[ zhTW ]] ["Height"] = "高度",
	--[[ zhTW ]] ["Sets the height of the cast bar"] = "施法條高度",

	--[[ zhTW ]] ["Interruptable Cast Bar"] = "Interruptable Cast Bar",
	--[[ zhTW ]] ["Cast bar appearance for interruptable spells"] = "Cast bar appearance for interruptable spells",
	--[[ zhTW ]] ["Uninterruptable Cast Bar"] = "Uninterruptable Cast Bar",
	--[[ zhTW ]] ["Cast bar appearance for uninterruptable spells"] = "Cast bar appearance for uninterruptable spells",

	--[[ zhTW ]] ["Cast Bar Color"] = "施法條顏色",
	--[[ zhTW ]] ["Sets the color of the cast bar"] = "設置施法條顏色",
	--[[ zhTW ]] ["Backdrop Color"] = "背景顏色",
	--[[ zhTW ]] ["Sets the backdrop color of the cast bar"] = "施法條背景顏色",
	--[[ zhTW ]] ["Border Color"] = "邊框顏色",
	--[[ zhTW ]] ["Sets the border color of the cast bar"] = "設置施法條邊框顏色",
	--[[ zhTW ]] ["Border Style"] = "邊框樣式",
	--[[ zhTW ]] ["Sets the style of the cast bar border"] = "設置施法條邊框樣式",
	--[[ zhTW ]] ["Texture"] = "紋理",
	--[[ zhTW ]] ["Sets the cast bar texture"] = "施法條紋理",
} end)

-----------------------------------------------------------------------------

iL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Spell Icon"] = "法術圖示",
	--[[ zhTW ]] ["Spell icon placement options"] = "法術圖示佈局選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Enable spell icon display on the nameplate"] = "在名牌顯示法術圖示",
	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust spell icon position"] = "法術圖示位置",
	--[[ zhTW ]] ["Anchor"] = "定位點",
	--[[ zhTW ]] ["Sets the anchor for the spell icon"] = "法術圖示定位點",
	--[[ zhTW ]] ["Anchor To"] = "固定在",
	--[[ zhTW ]] ["Sets the relative point on the cast bar to anchor the spell icon"] = "法術圖示固定在生命力條的位置",
	--[[ zhTW ]] ["Size"] = "大小",
	--[[ zhTW ]] ["Size in pixels of the spell icon"] = "法術圖示大小",
	--[[ zhTW ]] ["X Offset"] = "X位移",
	--[[ zhTW ]] ["X offset of the spell icon"] = "法術圖示X位移",
	--[[ zhTW ]] ["Y Offset"] = "Y位移",
	--[[ zhTW ]] ["Y offset of the spell icon"] = "法術圖示Y位移",

	--[[ zhTW ]] ["Shield"] = "Shield",
	--[[ zhTW ]] ["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon",
	--[[ zhTW ]] ["Enable"] = "Enable",
	--[[ zhTW ]] ["Enables the shield graphic"] = "Enables the shield graphic",
	--[[ zhTW ]] ["Style"] = "Style",
	--[[ zhTW ]] ["Sets the shield graphic style"] = "Sets the shield graphic style",
	--[[ zhTW ]] ["Color"] = "Color",
	--[[ zhTW ]] ["Sets the shield graphic color"] = "Sets the shield graphic color",

	--[[ zhTW ]] ["SQUARE"] = "SQUARE",
	--[[ zhTW ]] ["ROUND"] = "ROUND",

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

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

nL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Spell Name"] = "法術名字",
	--[[ zhTW ]] ["Cast bar spell name text options"] = "施法條法術名字文字選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show spell name on cast bar"] = "在施法條顯示法術名字",
	--[[ zhTW ]] ["Typeface"] = "字體",
	--[[ zhTW ]] ["Spell name typeface options"] = "法術名字字體選項",
	--[[ zhTW ]] ["Font"] = "字型",
	--[[ zhTW ]] ["Sets the font for spell name"] = "法術名字字型",
	--[[ zhTW ]] ["Font Size"] = "字型大小",
	--[[ zhTW ]] ["Sets the font height of the spell name"] = "法術名字字型大小",
	--[[ zhTW ]] ["Font Shadow"] = "字型陰影",
	--[[ zhTW ]] ["Show font shadow on spell name"] = "法術名字字型陰影",
	--[[ zhTW ]] ["Alignment"] = "對齊",
	--[[ zhTW ]] ["Sets the alignment of the spell name"] = "法術名字對齊",
	--[[ zhTW ]] ["Outline"] = "輪廓",
	--[[ zhTW ]] ["Sets the font outline for spell name"] = "法術名字字型輪廓",
	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust spell name position"] = "法術名字位置",
	--[[ zhTW ]] ["Left Offset"] = "左位移",
	--[[ zhTW ]] ["Sets the offset of the left of the text"] = "文字左位移",
	--[[ zhTW ]] ["Right Offset"] = "右位移",
	--[[ zhTW ]] ["Sets the offset of the right of the text"] = "文字右位移",
	--[[ zhTW ]] ["Vertical Offset"] = "垂直位移",
	--[[ zhTW ]] ["Sets the vertical offset of the text"] = "文字垂直位移",
	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the spell name color"] = "法術名字顏色",

	--[[ zhTW ]] ["None"] = "無",
	--[[ zhTW ]] ["Normal"] = "正常",
	--[[ zhTW ]] ["Thick"] = "粗",

	--[[ zhTW ]] ["LEFT"] = "左",
	--[[ zhTW ]] ["CENTER"] = "中",
	--[[ zhTW ]] ["RIGHT"] = "右",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

tL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Time Text"] = "時間文字",
	--[[ zhTW ]] ["Cast bar time text options"] = "施法條時間文字選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show cast bar time text"] = "顯示施法條時間文字",
	--[[ zhTW ]] ["Typeface"] = "字體",
	--[[ zhTW ]] ["Cast bar time text typeface options"] = "施法條時間文字字體選項",
	--[[ zhTW ]] ["Font"] = "字型",
	--[[ zhTW ]] ["Sets the font for cast bar time text"] = "施法條時間文字字型",
	--[[ zhTW ]] ["Font Size"] = "字型大小",
	--[[ zhTW ]] ["Sets the font height of the cast bar time text"] = "施法條時間文字字型大小",
	--[[ zhTW ]] ["Font Shadow"] = "字型陰影",
	--[[ zhTW ]] ["Show font shadow on cast bar time text"] = "施法條時間文字字型陰影",
	--[[ zhTW ]] ["Alignment"] = "對齊",
	--[[ zhTW ]] ["Sets the alignment of the cast bar time text"] = "施法條時間文字對齊",
	--[[ zhTW ]] ["Outline"] = "輪廓",
	--[[ zhTW ]] ["Sets the font outline for cast bar time text"] = "施法條時間文字字型輪廓",
	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust cast bar time text position"] = "施法條時間文字位置",
	--[[ zhTW ]] ["Left Offset"] = "左位移",
	--[[ zhTW ]] ["Sets the offset of the left of the text"] = "文字左位移",
	--[[ zhTW ]] ["Right Offset"] = "右位移",
	--[[ zhTW ]] ["Sets the offset of the right of the text"] = "文字右位移",
	--[[ zhTW ]] ["Vertical Offset"] = "垂直位移",
	--[[ zhTW ]] ["Sets the vertical offset of the text"] = "文字垂直位移",
	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the cast bar time text color"] = "施法條時間文字顏色",

	--[[ zhTW ]] ["None"] = "無",
	--[[ zhTW ]] ["Normal"] = "正常",
	--[[ zhTW ]] ["Thick"] = "粗",

	--[[ zhTW ]] ["LEFT"] = "左",
	--[[ zhTW ]] ["CENTER"] = "中",
	--[[ zhTW ]] ["RIGHT"] = "右",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
