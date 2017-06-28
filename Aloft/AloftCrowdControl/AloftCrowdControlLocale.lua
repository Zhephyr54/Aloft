local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local bL = AceLibrary("AceLocale-2.2"):new("AloftPolymorphOptions")

-----------------------------------------------------------------------------

local iL = AceLibrary("AceLocale-2.2"):new("AloftCrowdControlSpellIconOptions")

-----------------------------------------------------------------------------

local nL = AceLibrary("AceLocale-2.2"):new("AloftCrowdControlSpellNameTextOptions")

-----------------------------------------------------------------------------

local tL = AceLibrary("AceLocale-2.2"):new("AloftCrowdControlTimeTextOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
bL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Crowd Control"] = true,
	--[[ enUS ]] ["Crowd control options"] = true,

	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Shows crowd control timers on nameplates when possible"] = true,
	--[[ enUS ]] ["Speculative Attach"] = true,
	--[[ enUS ]] ["Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"] = true,
	--[[ enUS ]] ["Texture"] = true,
	--[[ enUS ]] ["Sets the crowd control bar texture"] = true,

	--[[ enUS ]] ["Border"] = true,
	--[[ enUS ]] ["Border options"] = true,
	--[[ enUS ]] ["Target Only"] = true,
	--[[ enUS ]] ["Enables the border on the current target only"] = true,
	--[[ enUS ]] ["Border Style"] = true,
	--[[ enUS ]] ["Sets the style of the crowd control bar border"] = true,
	--[[ enUS ]] ["Border Color"] = true,
	--[[ enUS ]] ["Sets the border color of the crowd control bar"] = true,

	--[[ enUS ]] ["Colors"] = true,
	--[[ enUS ]] ["Color options"] = true,
	--[[ enUS ]] ["Bar Color"] = true,
	--[[ enUS ]] ["Sets the crowd control bar color"] = true,
	--[[ enUS ]] ["Backdrop Color"] = true,
	--[[ enUS ]] ["Sets the crowd control backdrop color"] = true,

	--[[ enUS ]] ["Height"] = true,
	--[[ enUS ]] ["Sets the height of the crowd control bar"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust the crowd control bar's position"] = true,
	--[[ enUS ]] ["Left Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the left of the crowd control bar"] = true,
	--[[ enUS ]] ["Right Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the right of the crowd control bar"] = true,
	--[[ enUS ]] ["Vertical Offset"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the crowd control bar"] = true,

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

iL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Spell Icon"] = true,
	--[[ enUS ]] ["Crowd control spell icon placement options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Enable crowd control spell icon display on the nameplate"] = true,
	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust crowd control spell icon position"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the crowd control spell icon"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the crowd control bar to anchor the spell icon"] = true,
	--[[ enUS ]] ["Size"] = true,
	--[[ enUS ]] ["Size in pixels of the crowd control spell icon"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the crowd control spell icon"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the crowd control spell icon"] = true,

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

nL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Spell Name"] = true,
	--[[ enUS ]] ["Crowd control bar spell name text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show spell name on crowd control bar"] = true,
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

tL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Time Text"] = true,
	--[[ enUS ]] ["Crowd control bar time text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show crowd control bar time text"] = true,
	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Crowd control bar time text typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for crowd control bar time text"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the crowd control bar time text"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on crowd control bar time text"] = true,
	--[[ enUS ]] ["Alignment"] = true,
	--[[ enUS ]] ["Sets the alignment of the crowd control bar time text"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the font outline for crowd control bar time text"] = true,
	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust crowd control bar time text position"] = true,
	--[[ enUS ]] ["Left Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the left of the text"] = true,
	--[[ enUS ]] ["Right Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the right of the text"] = true,
	--[[ enUS ]] ["Vertical Offset"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the text"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the crowd control bar time text color"] = true,

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

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

bL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Crowd Control"] = "Crowd Control",
	--[[ koKR ]] ["Crowd control options"] = "Crowd control options",

	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Shows crowd control timers on nameplates when possible"] = "Shows crowd control timers on nameplates when possible",
	--[[ koKR ]] ["Speculative Attach"] = "추리적인 붙이기",
	--[[ koKR ]] ["Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"] = "Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate",
	--[[ koKR ]] ["Texture"] = "텍스쳐",
	--[[ koKR ]] ["Sets the crowd control bar texture"] = "Sets the crowd control bar texture",

	--[[ koKR ]] ["Border"] = "Border",
	--[[ koKR ]] ["Border options"] = "Border options",
	--[[ koKR ]] ["Target Only"] = "Target Only",
	--[[ koKR ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ koKR ]] ["Border Color"] = "테두리 색상",
	--[[ koKR ]] ["Sets the border color of the crowd control bar"] = "Sets the border color of the crowd control bar",
	--[[ koKR ]] ["Border Style"] = "테두리 스타일",
	--[[ koKR ]] ["Sets the style of the crowd control bar border"] = "Sets the style of the crowd control bar border",

	--[[ koKR ]] ["Colors"] = "색상",
	--[[ koKR ]] ["Color options"] = "색상 설정",
	--[[ koKR ]] ["Bar Color"] = "바 색상",
	--[[ koKR ]] ["Sets the crowd control bar color"] = "Sets the crowd control bar color",
	--[[ koKR ]] ["Backdrop Color"] = "배경 색상",
	--[[ koKR ]] ["Sets the crowd control backdrop color"] = "Sets the crowd control bar color",

	--[[ koKR ]] ["Height"] = "높이",
	--[[ koKR ]] ["Sets the height of the crowd control bar"] = "Sets the height of the crowd control bar",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust the crowd control bar's position"] = "Adjust the crowd control bar's position",
	--[[ koKR ]] ["Left Offset"] = "좌측 좌표",
	--[[ koKR ]] ["Sets the offset of the left of the crowd control bar"] = "Sets the offset of the left of the crowd control bar",
	--[[ koKR ]] ["Right Offset"] = "우측 좌표",
	--[[ koKR ]] ["Sets the offset of the right of the crowd control bar"] = "Sets the offset of the right of the crowd control bar",
	--[[ koKR ]] ["Vertical Offset"] = "수직 좌표",
	--[[ koKR ]] ["Sets the vertical offset of the crowd control bar"] = "Sets the vertical offset of the crowd control bar",

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

iL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Spell Icon"] = "주문 아이콘",
	--[[ koKR ]] ["Crowd control crowd control spell icon placement options"] = "Crowd control crowd control spell icon placement options",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Enable crowd control spell icon display on the nameplate"] = "Enable crowd control spell icon display on the nameplate",
	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust crowd control spell icon position"] = "Adjust crowd control spell icon position",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the crowd control spell icon"] = "Sets the anchor for the crowd control spell icon",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the crowd control bar to anchor the spell icon"] = "Sets the relative point on the crowd control bar to anchor the spell icon",
	--[[ koKR ]] ["Size"] = "크기",
	--[[ koKR ]] ["Size in pixels of the crowd control spell icon"] = "Size in pixels of the crowd control spell icon",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the crowd control spell icon"] = "X offset of the crowd control spell icon",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the crowd control spell icon"] = "Y offset of the crowd control spell icon",

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

nL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Spell Name"] = "주문명",
	--[[ koKR ]] ["Crowd control bar spell name text options"] = "Crowd control bar spell name text options",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show spell name on crowd control bar"] = "Show spell name on crowd control bar",
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

tL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Time Text"] = "시전 시간",
	--[[ koKR ]] ["Crowd control bar time text options"] = "Crowd control bar time text options",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show crowd control bar time text"] = "Show crowd control bar time text",
	--[[ koKR ]] ["Typeface"] = "서체",
	--[[ koKR ]] ["Crowd control bar time text typeface options"] = "Crowd control bar time text typeface options",
	--[[ koKR ]] ["Font"] = "글꼴",
	--[[ koKR ]] ["Sets the font for crowd control bar time text"] = "Sets the font for crowd control bar time text",
	--[[ koKR ]] ["Font Size"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the font height of the crowd control bar time text"] = "Sets the font height of the crowd control bar time text",
	--[[ koKR ]] ["Font Shadow"] = "글꼴 그림자",
	--[[ koKR ]] ["Show font shadow on crowd control bar time text"] = "Show font shadow on crowd control bar time text",
	--[[ koKR ]] ["Alignment"] = "정렬",
	--[[ koKR ]] ["Sets the alignment of the crowd control bar time text"] = "Sets the alignment of the crowd control bar time text",
	--[[ koKR ]] ["Outline"] = "테두리",
	--[[ koKR ]] ["Sets the font outline for crowd control bar time text"] = "Sets the font outline for crowd control bar time text",
	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust crowd control bar time text position"] = "Adjust crowd control bar time text position",
	--[[ koKR ]] ["Left Offset"] = "좌측 좌표",
	--[[ koKR ]] ["Sets the offset of the left of the text"] = "시전 시간의 좌측 좌표를 설정합니다.",
	--[[ koKR ]] ["Right Offset"] = "우측 좌표",
	--[[ koKR ]] ["Sets the offset of the right of the text"] = "시전 시간의 우측 좌표를 설정합니다.",
	--[[ koKR ]] ["Vertical Offset"] = "수직 좌표",
	--[[ koKR ]] ["Sets the vertical offset of the text"] = "시전 시간의 수직 좌표를 설정합니다.",
	--[[ koKR ]] ["Color"] = "색상",
	--[[ koKR ]] ["Sets the crowd control bar time text color"] = "Sets the crowd control bar time text color",

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

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

bL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Crowd Control"] = "Контроль",
	--[[ ruRU ]] ["Crowd control options"] = "Опции контроля",

	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Shows crowd control timers on nameplates when possible"] = "Отображать таймеры кантроля на табличках если это возможно",
	--[[ ruRU ]] ["Speculative Attach"] = "Рискованное прикрепление",
	--[[ ruRU ]] ["Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"] = "Пытаться прикрепить полосу таймера контроля, когда не известно, что это правильная табличка",
	--[[ ruRU ]] ["Texture"] = "Текстура",
	--[[ ruRU ]] ["Sets the crowd control bar texture"] = "Задает текстуру полоски контроля",

	--[[ ruRU ]] ["Border"] = "Края",
	--[[ ruRU ]] ["Border options"] = "Настройки краев",
	--[[ ruRU ]] ["Target Only"] = "Только цель",
	--[[ ruRU ]] ["Enables the border on the current target only"] = "Включить края только для текущей цели",
	--[[ ruRU ]] ["Border Color"] = "Цвет рамки",
	--[[ ruRU ]] ["Sets the border color of the crowd control bar"] = "Задает цвет рамки полосы контроля",
	--[[ ruRU ]] ["Border Style"] = "Стиль рамки",
	--[[ ruRU ]] ["Sets the style of the crowd control bar border"] = "Задает стиль рамки полосы контроля",

	--[[ ruRU ]] ["Colors"] = "Цвета",
	--[[ ruRU ]] ["Color options"] = "Настройка цвета",
	--[[ ruRU ]] ["Bar Color"] = "Цвет полоски",
	--[[ ruRU ]] ["Sets the crowd control bar color"] = "Задает цвет полоски контроля",
	--[[ ruRU ]] ["Backdrop Color"] = "Цвет тени",
	--[[ ruRU ]] ["Sets the crowd control backdrop color"] = "Задает цвет тени полоски контроля",

	--[[ ruRU ]] ["Height"] = "Высота",
	--[[ ruRU ]] ["Sets the height of the crowd control bar"] = "Задает высоту полоски контроляr",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust the crowd control bar's position"] = "Задать место полоски контроля",
	--[[ ruRU ]] ["Left Offset"] = "Смещение влево",
	--[[ ruRU ]] ["Sets the offset of the left of the crowd control bar"] = "Смещение полоски контроля влево",
	--[[ ruRU ]] ["Right Offset"] = "Смещение вправо",
	--[[ ruRU ]] ["Sets the offset of the right of the crowd control bar"] = "Смещение полоски контроля вправо",
	--[[ ruRU ]] ["Vertical Offset"] = "Смещение по вертикале",
	--[[ ruRU ]] ["Sets the vertical offset of the crowd control bar"] = "Смещение полоски контроля по вертикале",

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

iL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Spell Icon"] = "Значок заклинания",
	--[[ ruRU ]] ["Crowd control spell icon placement options"] = "Настройка размещения иконки заклинания контроля",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Enable crowd control spell icon display on the nameplate"] = "Включить отображение иконки заклинания контроля на табличке",
	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust crowd control spell icon position"] = "Регулировка размещения иконки заклинания контроля",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the crowd control spell icon"] = "Установка точки прикрепления иконки заклинания контроля",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the crowd control bar to anchor the spell icon"] = "Задает точку для положения полосы контроля относительно иконки заклинания",
	--[[ ruRU ]] ["Size"] = "Размер",
	--[[ ruRU ]] ["Size in pixels of the crowd control spell icon"] = "Размер иконки заклинания контроля в пикселях",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the crowd control spell icon"] = "Смещение иконки заклинания контроля по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the crowd control spell icon"] = "Смещение иконки заклинания контроля по Y",

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

nL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Spell Name"] = "Заклинание",
	--[[ ruRU ]] ["Crowd control bar spell name text options"] = "Настройка текста заклинания полосы контроля",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show spell name on crowd control bar"] = "Отображать  название заклинания в полосе контроля",
	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Spell name typeface options"] = "Настройки шрифта названия заклинаний",
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

tL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Time Text"] = "Текст времени",
	--[[ ruRU ]] ["Crowd control bar time text options"] = "Настройки текста времени полосы контроля",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show crowd control bar time text"] = "Отображать текст времени в полосе контроля",
	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Crowd control bar time text typeface options"] = "Настройка шрифта текста времени полосы контроля",
	--[[ ruRU ]] ["Font"] = "Шрифт",
	--[[ ruRU ]] ["Sets the font for crowd control bar time text"] = "Установка шрифта времени полосы контроля",
	--[[ ruRU ]] ["Font Size"] = "Размер шрифта",
	--[[ ruRU ]] ["Sets the font height of the crowd control bar time text"] = "Установка размера шрифта текста времени полосы контроля",
	--[[ ruRU ]] ["Font Shadow"] = "Тень шрифта",
	--[[ ruRU ]] ["Show font shadow on crowd control bar time text"] = "Отображать тень шрифта текста времени полосы контроля",
	--[[ ruRU ]] ["Alignment"] = "Выравнивание",
	--[[ ruRU ]] ["Sets the alignment of the crowd control bar time text"] = "Выравнивание текста времени полосы контроля",
	--[[ ruRU ]] ["Outline"] = "Контур",
	--[[ ruRU ]] ["Sets the font outline for crowd control bar time text"] = "Установка контура текста времени полосы контроля",
	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust crowd control bar time text position"] = "Регулировка расположения текста времени полосы контроля",
	--[[ ruRU ]] ["Left Offset"] = "Смещение влево",
	--[[ ruRU ]] ["Sets the offset of the left of the text"] = "Смещение текста влево",
	--[[ ruRU ]] ["Right Offset"] = "Смещение вправо",
	--[[ ruRU ]] ["Sets the offset of the right of the text"] = "ЗСмещение текста вправо",
	--[[ ruRU ]] ["Vertical Offset"] = "Смещение по вертикале",
	--[[ ruRU ]] ["Sets the vertical offset of the text"] = "Смещение текста по вертикале",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the crowd control bar time text color"] = "Установка цвета текста времени полосы контроля",

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

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

bL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Crowd Control"] = "Crowd Control",
	--[[ zhCN ]] ["Crowd control options"] = "Crowd control options",

	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Shows crowd control timers on nameplates when possible"] = "Shows crowd control timers on nameplates when possible",
	--[[ zhCN ]] ["Speculative Attach"] = "推理依附",
	--[[ zhCN ]] ["Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"] = "Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate",
	--[[ zhCN ]] ["Texture"] = "材质",
	--[[ zhCN ]] ["Sets the crowd control bar texture"] = "Sets the crowd control bar texture",

	--[[ zhCN ]] ["Border"] = "Border",
	--[[ zhCN ]] ["Border options"] = "Border options",
	--[[ zhCN ]] ["Target Only"] = "Target Only",
	--[[ zhCN ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ zhCN ]] ["Border Color"] = "边框颜色",
	--[[ zhCN ]] ["Sets the border color of the crowd control bar"] = "Sets the border color of the crowd control bar",
	--[[ zhCN ]] ["Border Style"] = "边框样式",
	--[[ zhCN ]] ["Sets the style of the crowd control bar border"] = "Sets the style of the crowd control bar border",

	--[[ zhCN ]] ["Colors"] = "颜色",
	--[[ zhCN ]] ["Color options"] = "颜色设置",
	--[[ zhCN ]] ["Bar Color"] = "计时条颜色",
	--[[ zhCN ]] ["Sets the crowd control bar color"] = "Sets the crowd control bar color",
	--[[ zhCN ]] ["Backdrop Color"] = "背景颜色",
	--[[ zhCN ]] ["Sets the crowd control backdrop color"] = "Sets the crowd control backdrop color",

	--[[ zhCN ]] ["Height"] = "高度",
	--[[ zhCN ]] ["Sets the height of the crowd control bar"] = "Sets the height of the crowd control bar",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust the crowd control bar's position"] = "Adjust the crowd control bar's position",
	--[[ zhCN ]] ["Left Offset"] = "向左偏移",
	--[[ zhCN ]] ["Sets the offset of the left of the crowd control bar"] = "Sets the offset of the left of the crowd control bar",
	--[[ zhCN ]] ["Right Offset"] = "向右偏移",
	--[[ zhCN ]] ["Sets the offset of the right of the crowd control bar"] = "Sets the offset of the right of the crowd control bar",
	--[[ zhCN ]] ["Vertical Offset"] = "垂直偏移",
	--[[ zhCN ]] ["Sets the vertical offset of the crowd control bar"] = "Sets the vertical offset of the crowd control bar",

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

iL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Spell Icon"] = "法术图标",
	--[[ zhCN ]] ["Crowd control spell icon placement options"] = "Crowd control spell icon placement options",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Enable crowd control spell icon display on the nameplate"] = "Enable crowd control spell icon display on the nameplate",
	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust crowd control spell icon position"] = "Adjust crowd control spell icon position",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the crowd control spell icon"] = "Sets the anchor for the crowd control spell icon",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the crowd control bar to anchor the spell icon"] = "Sets the relative point on the crowd control bar to anchor the spell icon",
	--[[ zhCN ]] ["Size"] = "尺寸",
	--[[ zhCN ]] ["Size in pixels of the crowd control spell icon"] = "Size in pixels of the crowd control spell icon",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the crowd control spell icon"] = "X offset of the crowd control spell icon",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the crowd control spell icon"] = "Y offset of the crowd control spell icon",

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

nL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Spell Name"] = "法术名称",
	--[[ zhCN ]] ["Crowd control bar spell name text options"] = "Crowd control bar spell name text options",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show spell name on crowd control bar"] = "Show spell name on crowd control bar",
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

tL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Time Text"] = "计时文字",
	--[[ zhCN ]] ["Crowd control bar time text options"] = "Crowd control bar time text options",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show crowd control bar time text"] = "Show crowd control bar time text",
	--[[ zhCN ]] ["Typeface"] = "式样",
	--[[ zhCN ]] ["Crowd control bar time text typeface options"] = "Crowd control bar time text typeface options",
	--[[ zhCN ]] ["Font"] = "字体",
	--[[ zhCN ]] ["Sets the font for crowd control bar time text"] = "Sets the font for crowd control bar time text",
	--[[ zhCN ]] ["Font Size"] = "字号",
	--[[ zhCN ]] ["Sets the font height of the crowd control bar time text"] = "Sets the font height of the crowd control bar time text",
	--[[ zhCN ]] ["Font Shadow"] = "字体阴影",
	--[[ zhCN ]] ["Show font shadow on crowd control bar time text"] = "Show font shadow on crowd control bar time text",
	--[[ zhCN ]] ["Alignment"] = "对齐",
	--[[ zhCN ]] ["Sets the alignment of the crowd control bar time text"] = "Sets the alignment of the crowd control bar time text",
	--[[ zhCN ]] ["Outline"] = "轮廓",
	--[[ zhCN ]] ["Sets the font outline for crowd control bar time text"] = "Sets the font outline for crowd control bar time text",
	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust crowd control bar time text position"] = "Adjust crowd control bar time text position",
	--[[ zhCN ]] ["Left Offset"] = "向左偏移",
	--[[ zhCN ]] ["Sets the offset of the left of the text"] = "设定文字的向左偏移量",
	--[[ zhCN ]] ["Right Offset"] = "向右偏移",
	--[[ zhCN ]] ["Sets the offset of the right of the text"] = "设定文字的向右偏移量",
	--[[ zhCN ]] ["Vertical Offset"] = "垂直偏移",
	--[[ zhCN ]] ["Sets the vertical offset of the text"] = "设定文字的垂直偏移量",
	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the crowd control bar time text color"] = "Sets the crowd control bar time text color",

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

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

bL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Crowd Control"] = "Crowd Control",
	--[[ zhTW ]] ["Crowd control options"] = "Crowd control options",

	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Shows crowd control timers on nameplates when possible"] = "Shows crowd control timers on nameplates when possible",
	--[[ zhTW ]] ["Speculative Attach"] = "推理依附",
	--[[ zhTW ]] ["Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"] = "Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate",
	--[[ zhTW ]] ["Texture"] = "紋理",
	--[[ zhTW ]] ["Sets the crowd control bar texture"] = "Sets the crowd control bar texture",

	--[[ zhTW ]] ["Border"] = "Border",
	--[[ zhTW ]] ["Border options"] = "Border options",
	--[[ zhTW ]] ["Target Only"] = "Target Only",
	--[[ zhTW ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ zhTW ]] ["Border Color"] = "邊框顏色",
	--[[ zhTW ]] ["Sets the border color of the crowd control bar"] = "Sets the border color of the crowd control bar",
	--[[ zhTW ]] ["Border Style"] = "邊框樣式",
	--[[ zhTW ]] ["Sets the style of the crowd control bar border"] = "Sets the style of the crowd control bar border",

	--[[ zhTW ]] ["Colors"] = "顏色",
	--[[ zhTW ]] ["Color options"] = "顏色選項",
	--[[ zhTW ]] ["Bar Color"] = "變形條顏色",
	--[[ zhTW ]] ["Sets the crowd control bar color"] = "Sets the crowd control bar color",
	--[[ zhTW ]] ["Backdrop Color"] = "背景顏色",
	--[[ zhTW ]] ["Sets the crowd control backdrop color"] = "Sets the crowd control backdrop color",

	--[[ zhTW ]] ["Height"] = "高度",
	--[[ zhTW ]] ["Sets the height of the crowd control bar"] = "Sets the height of the crowd control bar",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust the crowd control bar's position"] = "Adjust the crowd control bar's position",
	--[[ zhTW ]] ["Left Offset"] = "左位移",
	--[[ zhTW ]] ["Sets the offset of the left of the crowd control bar"] = "Sets the offset of the left of the crowd control bar",
	--[[ zhTW ]] ["Right Offset"] = "右位移",
	--[[ zhTW ]] ["Sets the offset of the right of the crowd control bar"] = "Sets the offset of the right of the crowd control bar",
	--[[ zhTW ]] ["Vertical Offset"] = "垂直位移",
	--[[ zhTW ]] ["Sets the vertical offset of the crowd control bar"] = "Sets the vertical offset of the crowd control bar",

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

iL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Spell Icon"] = "法術圖示",
	--[[ zhTW ]] ["Crowd control spell icon placement options"] = "Crowd control spell icon placement options",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Enable crowd control spell icon display on the nameplate"] = "Enable crowd control spell icon display on the nameplate",
	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust crowd control spell icon position"] = "Adjust crowd control spell icon position",
	--[[ zhTW ]] ["Anchor"] = "定位點",
	--[[ zhTW ]] ["Sets the anchor for the crowd control spell icon"] = "Sets the anchor for the crowd control spell icon",
	--[[ zhTW ]] ["Anchor To"] = "固定在",
	--[[ zhTW ]] ["Sets the relative point on the crowd control bar to anchor the spell icon"] = "Sets the relative point on the crowd control bar to anchor the spell icon",
	--[[ zhTW ]] ["Size"] = "大小",
	--[[ zhTW ]] ["Size in pixels of the crowd control spell icon"] = "Size in pixels of the crowd control spell icon",
	--[[ zhTW ]] ["X Offset"] = "X位移",
	--[[ zhTW ]] ["X offset of the crowd control spell icon"] = "X offset of the crowd control spell icon",
	--[[ zhTW ]] ["Y Offset"] = "Y位移",
	--[[ zhTW ]] ["Y offset of the crowd control spell icon"] = "Y offset of the crowd control spell icon",

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

nL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Spell Name"] = "法術名字",
	--[[ zhTW ]] ["Crowd control bar spell name text options"] = "Crowd control bar spell name text options",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show spell name on crowd control bar"] = "Show spell name on crowd control bar",
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

tL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Time Text"] = "時間文字",
	--[[ zhTW ]] ["Crowd control bar time text options"] = "Crowd control bar time text options",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show crowd control bar time text"] = "Show crowd control bar time text",
	--[[ zhTW ]] ["Typeface"] = "字體",
	--[[ zhTW ]] ["Crowd control bar time text typeface options"] = "Crowd control bar time text typeface options",
	--[[ zhTW ]] ["Font"] = "字型",
	--[[ zhTW ]] ["Sets the font for crowd control bar time text"] = "Sets the font for crowd control bar time text",
	--[[ zhTW ]] ["Font Size"] = "字型大小",
	--[[ zhTW ]] ["Sets the font height of the crowd control bar time text"] = "Sets the font height of the crowd control bar time text",
	--[[ zhTW ]] ["Font Shadow"] = "字型陰影",
	--[[ zhTW ]] ["Show font shadow on crowd control bar time text"] = "Show font shadow on crowd control bar time text",
	--[[ zhTW ]] ["Alignment"] = "對齊",
	--[[ zhTW ]] ["Sets the alignment of the crowd control bar time text"] = "Sets the alignment of the crowd control bar time text",
	--[[ zhTW ]] ["Outline"] = "輪廓",
	--[[ zhTW ]] ["Sets the font outline for crowd control bar time text"] = "Sets the font outline for crowd control bar time text",
	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust crowd control bar time text position"] = "Adjust crowd control bar time text position",
	--[[ zhTW ]] ["Left Offset"] = "左位移",
	--[[ zhTW ]] ["Sets the offset of the left of the text"] = "文字左位移",
	--[[ zhTW ]] ["Right Offset"] = "右位移",
	--[[ zhTW ]] ["Sets the offset of the right of the text"] = "文字右位移",
	--[[ zhTW ]] ["Vertical Offset"] = "垂直位移",
	--[[ zhTW ]] ["Sets the vertical offset of the text"] = "文字垂直位移",
	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the crowd control bar time text color"] = "Sets the crowd control bar time text color",

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
