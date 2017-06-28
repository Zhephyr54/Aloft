local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

local bL = { }

local tL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] bL["Mana Bar"] = "Mana Bar"
--[[ enUS ]] bL["Mana Bar options"] = "Mana Bar options"
--[[ enUS ]] bL["Enable"] = "Enable"
--[[ enUS ]] bL["Show mana bars on group member nameplates"] = "Show mana bars on group member nameplates"

--[[ enUS ]] bL["Texture"] = "Texture"
--[[ enUS ]] bL["Sets the mana bar texture"] = "Sets the mana bar texture"
--[[ enUS ]] bL["Alpha"] = "Alpha"
--[[ enUS ]] bL["Sets the mana bar alpha"] = "Sets the mana bar alpha"

--[[ enUS ]] bL["Height"] = "Height"
--[[ enUS ]] bL["Sets the height of the mana bar"] = "Sets the height of the mana bar"

--[[ enUS ]] bL["Position"] = "Position"
--[[ enUS ]] bL["Adjust the mana bar's position"] = "Adjust the mana bar's position"
--[[ enUS ]] bL["Left Offset"] = "Left Offset"
--[[ enUS ]] bL["Sets the offset of the left of the mana bar"] = "Sets the offset of the left of the mana bar"
--[[ enUS ]] bL["Right Offset"] = "Right Offset"
--[[ enUS ]] bL["Sets the offset of the right of the mana bar"] = "Sets the offset of the right of the mana bar"
--[[ enUS ]] bL["Vertical Offset"] = "Vertical Offset"
--[[ enUS ]] bL["Sets the vertical offset of the mana bar"] = "Sets the vertical offset of the mana bar"

--[[ enUS ]] bL["Colors"] = "Colors"
--[[ enUS ]] bL["Customize colors"] = "Customize colors"
--[[ enUS ]] bL["Backdrop Color"] = "Backdrop Color"
--[[ enUS ]] bL["Sets the backdrop color of the mana bar"] = "Sets the backdrop color of the mana bar"
--[[ enUS ]] bL["Mana Color"] = "Mana Color"
--[[ enUS ]] bL["Sets the color for mana bars"] = "Sets the color for mana bars"
--[[ enUS ]] bL["Rage Color"] = "Rage Color"
--[[ enUS ]] bL["Sets the color for rage bars"] = "Sets the color for rage bars"
--[[ enUS ]] bL["Focus Color"] = "Focus Color"
--[[ enUS ]] bL["Sets the color for focus bars"] = "Sets the color for focus bars"
--[[ enUS ]] bL["Energy Color"] = "Energy Color"
--[[ enUS ]] bL["Sets the color for energy bars"] = "Sets the color for energy bars"
--[[ enUS ]] bL["Happiness Color"] = "Happiness Color"
--[[ enUS ]] bL["Sets the color for happiness bars"] = "Sets the color for happiness bars"
--[[ enUS ]] bL["Rune Color"] = "Rune Color"
--[[ enUS ]] bL["Sets the color for rune bars"] = "Sets the color for rune bars"
--[[ enUS ]] bL["Runic Power Color"] = "Runic Power Color"
--[[ enUS ]] bL["Sets the color for runic power bars"] = "Sets the color for runic power bars"
--[[ enUS ]] bL["Reset to Defaults"] = "Reset to Defaults"
--[[ enUS ]] bL["Resets all colors to their defaults"] = "Resets all colors to their defaults"

--[[ enUS ]] bL["Border"] = "Border"
--[[ enUS ]] bL["Border options"] = "Border options"
--[[ enUS ]] bL["Target Only"] = "Target Only"
--[[ enUS ]] bL["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ enUS ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ enUS ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ enUS ]] bL["Border Inset"] = "Border Inset"
--[[ enUS ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ enUS ]] bL["Border Color"] = "Border Color"
--[[ enUS ]] bL["Sets the border color of the mana bar"] = "Sets the border color of the mana bar"
--[[ enUS ]] bL["Border Style"] = "Border Style"
--[[ enUS ]] bL["Sets the style of the mana bar border"] = "Sets the style of the mana bar border"

--[[ enUS ]] --bL["Always Show Target"] = "Always Show Target"
--[[ enUS ]] --bL["Always show mana bar on active targets in combat"] = "Always show mana bar on active targets in combat"

--[[ enUS ]] bL["Advanced"] = "Advanced"
--[[ enUS ]] bL["Options for expert users"] = "Options for expert users"
--[[ enUS ]] bL["Color Format"] = "Color Format"
--[[ enUS ]] bL["Color tag"] = "Color tag"
--[[ enUS ]] bL["<Any tag string>"] = "<Any tag string>"

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale

--[[ enUS ]] tL["Mana Text"] = "Mana Text"
--[[ enUS ]] tL["Mana text options"] = "Mana text options"
--[[ enUS ]] tL["Enable"] = "Enable"
--[[ enUS ]] tL["Show mana text on group member nameplates"] = "Show mana text on group member nameplates"

--[[ enUS ]] tL["Color by type"] = "Color by type"
--[[ enUS ]] tL["Color text differently for mana, energy, rage"] = "Color text differently for mana, energy, rage"

--[[ enUS ]] tL["Typeface"] = "Typeface"
--[[ enUS ]] tL["Mana text typeface options"] = "Mana text typeface options"
--[[ enUS ]] tL["Font"] = "Font"
--[[ enUS ]] tL["Sets the font for mana text"] = "Sets the font for mana text"
--[[ enUS ]] tL["Font Size"] = "Font Size"
--[[ enUS ]] tL["Sets the font height of the mana text"] = "Sets the font height of the mana text"
--[[ enUS ]] tL["Font Shadow"] = "Font Shadow"
--[[ enUS ]] tL["Show font shadow on mana text"] = "Show font shadow on mana text"
--[[ enUS ]] tL["Outline"] = "Outline"
--[[ enUS ]] tL["Sets the outline for mana text"] = "Sets the outline for mana text"
--[[ enUS ]] tL["Mode"] = "Mode"
--[[ enUS ]] tL["Choose what to show for mana text"] = "Choose what to show for mana text"

--[[ enUS ]] tL["Position"] = "Position"
--[[ enUS ]] tL["Adjust mana text position"] = "Adjust mana text position"
--[[ enUS ]] tL["Anchor"] = "Anchor"
--[[ enUS ]] tL["Sets the anchor for the mana text"] = "Sets the anchor for the mana text"
--[[ enUS ]] tL["Anchor To"] = "Anchor To"
--[[ enUS ]] tL["Sets the relative point on the health bar to anchor the mana text"] = "Sets the relative point on the health bar to anchor the mana text"
--[[ enUS ]] tL["X Offset"] = "X Offset"
--[[ enUS ]] tL["X offset of the mana text"] = "X offset of the mana text"
--[[ enUS ]] tL["Y Offset"] = "Y Offset"
--[[ enUS ]] tL["Y offset of the mana text"] = "Y offset of the mana text"
--[[ enUS ]] tL["Alpha"] = "Alpha"
--[[ enUS ]] tL["Sets the alpha of the mana text"] = "Sets the alpha of the mana text"
--[[ enUS ]] tL["Color"] = "Color"
--[[ enUS ]] tL["Sets the mana text color"] = "Sets the mana text color"

--[[ enUS ]] tL["None"] = "None"
--[[ enUS ]] tL["Normal"] = "Normal"
--[[ enUS ]] tL["Thick"] = "Thick"

--[[ enUS ]] tL["Percent"] = "Percent"
--[[ enUS ]] tL["Mana"] = "Mana"
--[[ enUS ]] tL["Mana & Percent"] = "Mana & Percent"
--[[ enUS ]] tL["Deficit"] = "Deficit"
--[[ enUS ]] tL["Full"] = "Full"

--[[ enUS ]] tL["Always Show Target"] = "Always Show Target"
--[[ enUS ]] tL["Always show mana text on active targets in combat"] = "Always show mana text on active targets in combat"

--[[ enUS ]] tL["Advanced"] = "Advanced"
--[[ enUS ]] tL["Options for expert users"] = "Options for expert users"
--[[ enUS ]] tL["Format"] = "Format"
--[[ enUS ]] tL["Mana tag"] = "Mana tag"
--[[ enUS ]] tL["<Any tag string>"] = "<Any tag string>"

--[[ enUS ]] tL["TOPLEFT"] = "TOPLEFT"
--[[ enUS ]] tL["TOP"] = "TOP"
--[[ enUS ]] tL["TOPRIGHT"] = "TOPRIGHT"
--[[ enUS ]] tL["LEFT"] = "LEFT"
--[[ enUS ]] tL["CENTER"] = "CENTER"
--[[ enUS ]] tL["RIGHT"] = "RIGHT"
--[[ enUS ]] tL["BOTTOMLEFT"] = "BOTTOMLEFT"
--[[ enUS ]] tL["BOTTOM"] = "BOTTOM"
--[[ enUS ]] tL["BOTTOMRIGHT"] = "BOTTOMRIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftMana"] = "AloftMana"
--[[ enUS ]] mL["Display mana data, bars, and text on nameplates"] = "Display mana data, bars, and text on nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

--[[ koKR ]] bL["Mana Bar"] = "마나바"
--[[ koKR ]] bL["Mana Bar options"] = "마나바 설정"
--[[ koKR ]] bL["Enable"] = "사용"
--[[ koKR ]] bL["Show mana bars on group member nameplates"] = "파티원의 이름표에 마나바를 표시합니다."

--[[ koKR ]] bL["Texture"] = "텍스쳐"
--[[ koKR ]] bL["Sets the mana bar texture"] = "마나바의 텍스쳐를 설정합니다."
--[[ koKR ]] bL["Alpha"] = "투명도"
--[[ koKR ]] bL["Sets the mana bar alpha"] = "마나바의 투명도를 설정합니다."

--[[ koKR ]] bL["Height"] = "높이"
--[[ koKR ]] bL["Sets the height of the mana bar"] = "마나바의 높이를 설정합니다."

--[[ koKR ]] bL["Position"] = "위치"
--[[ koKR ]] bL["Adjust the mana bar's position"] = "마나바의 위치를 조절합니다."
--[[ koKR ]] bL["Left Offset"] = "좌측 좌표"
--[[ koKR ]] bL["Sets the offset of the left of the mana bar"] = "마나바의 좌측 좌표를 설정합니다."
--[[ koKR ]] bL["Right Offset"] = "우측 좌표"
--[[ koKR ]] bL["Sets the offset of the right of the mana bar"] = "마나바의 우측 좌표를 설정합니다."
--[[ koKR ]] bL["Vertical Offset"] = "수직 좌표"
--[[ koKR ]] bL["Sets the vertical offset of the mana bar"] = "마나바의 수직 좌표를 설정합니다."

--[[ koKR ]] bL["Colors"] = "색상"
--[[ koKR ]] bL["Customize colors"] = "사용자 색상"
--[[ koKR ]] bL["Backdrop Color"] = "배경 색상"
--[[ koKR ]] bL["Sets the backdrop color of the mana bar"] = "마나바의 배경 색상을 설정합니다."
--[[ koKR ]] bL["Mana Color"] = "마나 색상"
--[[ koKR ]] bL["Sets the color for mana bars"] = "마나바의 색상을 설정합니다."
--[[ koKR ]] bL["Rage Color"] = "분노 색상"
--[[ koKR ]] bL["Sets the color for rage bars"] = "분노바의 색상을 설정합니다"
--[[ koKR ]] bL["Focus Color"] = "지정 색상"
--[[ koKR ]] bL["Sets the color for focus bars"] = "지정바의 색상을 설정합니다."
--[[ koKR ]] bL["Energy Color"] = "기력 색상"
--[[ koKR ]] bL["Sets the color for energy bars"] = "기력바의 색상을 설정합니다."
--[[ koKR ]] bL["Happiness Color"] = "만족도 색상"
--[[ koKR ]] bL["Sets the color for happiness bars"] = "만족도바의 색상을 설정합니다."
--[[ koKR ]] bL["Rune Color"] = "Rune Color"
--[[ koKR ]] bL["Sets the color for rune bars"] = "Sets the color for rune bars"
--[[ koKR ]] bL["Runic Power Color"] = "Runic Power Color"
--[[ koKR ]] bL["Sets the color for runic power bars"] = "Sets the color for runic power bars"
--[[ koKR ]] bL["Reset to Defaults"] = "기본값 초기화"
--[[ koKR ]] bL["Resets all colors to their defaults"] = "모든 색상을 기본값으로 초기화합니다."

--[[ koKR ]] bL["Border"] = "Border"
--[[ koKR ]] bL["Border options"] = "Border options"
--[[ koKR ]] bL["Target Only"] = "Target Only"
--[[ koKR ]] bL["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ koKR ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ koKR ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ koKR ]] bL["Border Inset"] = "Border Inset"
--[[ koKR ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ koKR ]] bL["Border Color"] = "테두리 색상"
--[[ koKR ]] bL["Sets the border color of the mana bar"] = "Sets the border color of the mana bar"
--[[ koKR ]] bL["Border Style"] = "테두리 스타일"
--[[ koKR ]] bL["Sets the style of the mana bar border"] = "Sets the style of the mana bar border"

--[[ koKR ]] --bL["Always Show Target"] = "Always Show Target"
--[[ koKR ]] --bL["Always show mana bar on active targets in combat"] = "Always show mana bar on active targets in combat"

--[[ koKR ]] bL["Advanced"] = "고급"
--[[ koKR ]] bL["Options for expert users"] = "고급 사용자를 위한 설정"
--[[ koKR ]] bL["Color Format"] = "색상 형식"
--[[ koKR ]] bL["Color tag"] = "색상 태그"
--[[ koKR ]] bL["<Any tag string>"] = "<태그 문자열>"

-----------------------------------------------------------------------------

--[[ koKR ]] tL["Mana Text"] = "마나 수치"
--[[ koKR ]] tL["Mana text options"] = "마나 수치 설정"
--[[ koKR ]] tL["Enable"] = "사용"
--[[ koKR ]] tL["Show mana text on group member nameplates"] = "파티원의 이름표에 마나 수치를 표시합니다."

--[[ koKR ]] tL["Color by type"] = "종류별 색상"
--[[ koKR ]] tL["Color text differently for mana, energy, rage"] = "각각의 마나, 기력, 분노에 따른 수치 색상"

--[[ koKR ]] tL["Typeface"] = "서체"
--[[ koKR ]] tL["Mana text typeface options"] = "마나 수치 서체 설정"
--[[ koKR ]] tL["Font"] = "글꼴"
--[[ koKR ]] tL["Sets the font for mana text"] = "마나 수치의 글꼴을 설정합니다."
--[[ koKR ]] tL["Font Size"] = "글꼴 크기"
--[[ koKR ]] tL["Sets the font height of the mana text"] = "마나 수치의 글꼴 높이를 설정합니다."
--[[ koKR ]] tL["Font Shadow"] = "글꼴 그림자"
--[[ koKR ]] tL["Show font shadow on mana text"] = "마나 수치에 그림자를 표시합니다."
--[[ koKR ]] tL["Outline"] = "테두리"
--[[ koKR ]] tL["Sets the outline for mana text"] = "마나 수치에 테두리를 설정합니다."
--[[ koKR ]] tL["Mode"] = "모드"
--[[ koKR ]] tL["Choose what to show for mana text"] = "마나 수치의 표시 방법을 선택합니다."

--[[ koKR ]] tL["Position"] = "위치"
--[[ koKR ]] tL["Adjust mana text position"] = "마나 수치의 위치를 조절합니다."
--[[ koKR ]] tL["Anchor"] = "앵커"
--[[ koKR ]] tL["Sets the anchor for the mana text"] = "마나 수치의 앵커를 설정합니다."
--[[ koKR ]] tL["Anchor To"] = "앵커 위치"
--[[ koKR ]] tL["Sets the relative point on the health bar to anchor the mana text"] = "생명력바에 마나 수치의 앵커 위치를 설정합니다."
--[[ koKR ]] tL["X Offset"] = "X 좌표"
--[[ koKR ]] tL["X offset of the mana text"] = "마나 수치의 X 좌표입니다."
--[[ koKR ]] tL["Y Offset"] = "Y 좌표"
--[[ koKR ]] tL["Y offset of the mana text"] = "마나 수치의 Y 좌표입니다."
--[[ koKR ]] tL["Alpha"] = "투명도"
--[[ koKR ]] tL["Sets the alpha of the mana text"] = "마나 수치의 투명도를 설정합니다."
--[[ koKR ]] tL["Color"] = "색상"
--[[ koKR ]] tL["Sets the mana text color"] = "마나 수치의 색상을 설정합니다."

--[[ koKR ]] tL["None"] = "없음"
--[[ koKR ]] tL["Normal"] = "기본"
--[[ koKR ]] tL["Thick"] = "굵게"

--[[ koKR ]] tL["Percent"] = "백분율"
--[[ koKR ]] tL["Mana"] = "마나"
--[[ koKR ]] tL["Mana & Percent"] = "Mana & Percent"
--[[ koKR ]] tL["Deficit"] = "결손치"
--[[ koKR ]] tL["Full"] = "가득"

--[[ koKR ]] tL["Always Show Target"] = "Always Show Target"
--[[ koKR ]] tL["Always show mana text on active targets in combat"] = "Always show mana text on active targets in combat"

--[[ koKR ]] tL["Advanced"] = "고급"
--[[ koKR ]] tL["Options for expert users"] = "고급 사용자를 위한 설정"
--[[ koKR ]] tL["Format"] = "형식"
--[[ koKR ]] tL["Mana tag"] = "마나 태그"
--[[ koKR ]] tL["<Any tag string>"] = "<태그 문자열>"

--[[ koKR ]] tL["TOPLEFT"] = "좌측 상단"
--[[ koKR ]] tL["TOP"] = "상단"
--[[ koKR ]] tL["TOPRIGHT"] = "우측 상단"
--[[ koKR ]] tL["LEFT"] = "좌측"
--[[ koKR ]] tL["CENTER"] = "가운데"
--[[ koKR ]] tL["RIGHT"] = "우측"
--[[ koKR ]] tL["BOTTOMLEFT"] = "좌측 하단"
--[[ koKR ]] tL["BOTTOM"] = "하단"
--[[ koKR ]] tL["BOTTOMRIGHT"] = "우측 하단"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftMana"] = "AloftMana"
--[[ koKR ]] mL["Display mana data, bars, and text on nameplates"] = "Show mana data, bars, and text on nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] bL["Mana Bar"] = "Полоска маны"
--[[ ruRU ]] bL["Mana Bar options"] = "Настройки полоски маны"
--[[ ruRU ]] bL["Enable"] = "Включить"
--[[ ruRU ]] bL["Show mana bars on group member nameplates"] = "Отображать полоски маны на табличках участников группы"

--[[ ruRU ]] bL["Texture"] = "Текстура"
--[[ ruRU ]] bL["Sets the mana bar texture"] = "Задает текстуру полоски маны"
--[[ ruRU ]] bL["Alpha"] = "Прозрачность"
--[[ ruRU ]] bL["Sets the mana bar alpha"] = "Задает прозрачность полоски маны"

--[[ ruRU ]] bL["Height"] = "Высота"
--[[ ruRU ]] bL["Sets the height of the mana bar"] = "Задает высоту полоски маны"

--[[ ruRU ]] bL["Position"] = "Позиция"
--[[ ruRU ]] bL["Adjust the mana bar's position"] = "Задать место полоски маны"
--[[ ruRU ]] bL["Left Offset"] = "Смещение влево"
--[[ ruRU ]] bL["Sets the offset of the left of the mana bar"] = "Смещение полоски маны влево"
--[[ ruRU ]] bL["Right Offset"] = "Смещение вправо"
--[[ ruRU ]] bL["Sets the offset of the right of the mana bar"] = "Смещение полоски маны вправо"
--[[ ruRU ]] bL["Vertical Offset"] = "Смещение по вертикале"
--[[ ruRU ]] bL["Sets the vertical offset of the mana bar"] = "Смещение полоски маны по вертикале"

--[[ ruRU ]] bL["Colors"] = "Цвета"
--[[ ruRU ]] bL["Customize colors"] = "Настройка цветов"
--[[ ruRU ]] bL["Backdrop Color"] = "Цвет тени"
--[[ ruRU ]] bL["Sets the backdrop color of the mana bar"] = "Задает цвет тени полоски маны"
--[[ ruRU ]] bL["Mana Color"] = "Цвет маны"
--[[ ruRU ]] bL["Sets the color for mana bars"] = "Задает цвет для полосок маны"
--[[ ruRU ]] bL["Rage Color"] = "Цвет ярости"
--[[ ruRU ]] bL["Sets the color for rage bars"] = "Задает цвет для полосок ярости"
--[[ ruRU ]] bL["Focus Color"] = "Цвет фокуса"
--[[ ruRU ]] bL["Sets the color for focus bars"] = "Задает цвет полосок тонуса"
--[[ ruRU ]] bL["Energy Color"] = "Цвет энергии"
--[[ ruRU ]] bL["Sets the color for energy bars"] = "Задает цвет для полосок энергии"
--[[ ruRU ]] bL["Happiness Color"] = "Цвет счастья питомца"
--[[ ruRU ]] bL["Sets the color for happiness bars"] = "Задать цвет для полосок счастья"
--[[ ruRU ]] bL["Rune Color"] = "Цвет рун"
--[[ ruRU ]] bL["Sets the color for rune bars"] = "Установка цвета полос рун"
--[[ ruRU ]] bL["Runic Power Color"] = "Цвет силы рун"
--[[ ruRU ]] bL["Sets the color for runic power bars"] = "Установка цвета полос сылы рун"
--[[ ruRU ]] bL["Reset to Defaults"] = "Сбросить настройки"
--[[ ruRU ]] bL["Resets all colors to their defaults"] = "Сбрасывает все цвета в настройки по умолчанию"

--[[ ruRU ]] bL["Border"] = "Края"
--[[ ruRU ]] bL["Border options"] = "Настройка краёв"
--[[ ruRU ]] bL["Target Only"] = "Только цель"
--[[ ruRU ]] bL["Enables the border on the current target only"] = "Вкключить края только на текущей цели"
--[[ ruRU ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ ruRU ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ ruRU ]] bL["Border Inset"] = "Border Inset"
--[[ ruRU ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ ruRU ]] bL["Border Color"] = "Цвет края"
--[[ ruRU ]] bL["Sets the border color of the mana bar"] = "Установка цвета края полоски маны"
--[[ ruRU ]] bL["Border Style"] = "Стиль рамки"
--[[ ruRU ]] bL["Sets the style of the mana bar border"] = "Установка стиля краёв полоски маны"

--[[ ruRU ]] --bL["Always Show Target"] = "Всегда показывать цель"
--[[ ruRU ]] --bL["Always show mana bar on active targets in combat"] = "В бою всегда показывать полоску маны текущей цели"

--[[ ruRU ]] bL["Advanced"] = "Дополнительно"
--[[ ruRU ]] bL["Options for expert users"] = "Настройки для опытных пользователей"
--[[ ruRU ]] bL["Color Format"] = "Формат цвета"
--[[ ruRU ]] bL["Color tag"] = "Формат цвета"
--[[ ruRU ]] bL["<Any tag string>"] = "<Любая строка формата>"

-----------------------------------------------------------------------------

--[[ ruRU ]] tL["Mana Text"] = "Текст маны"
--[[ ruRU ]] tL["Mana text options"] = "Настройки текста маны"
--[[ ruRU ]] tL["Enable"] = "Включить"
--[[ ruRU ]] tL["Show mana text on group member nameplates"] = "Отображать текст маны на табличках участников группы"

--[[ ruRU ]] tL["Color by type"] = "Окрашивать в цвет типа"
--[[ ruRU ]] tL["Color text differently for mana, energy, rage"] = "Расцвечивать по разному текст для маны, ярости и энергии"

--[[ ruRU ]] tL["Typeface"] = "Шрифт"
--[[ ruRU ]] tL["Mana text typeface options"] = "Настройки шрифта текста маны"
--[[ ruRU ]] tL["Font"] = "Шрифт"
--[[ ruRU ]] tL["Sets the font for mana text"] = "Задает шрифт для текста маны"
--[[ ruRU ]] tL["Font Size"] = "Размер шрифта"
--[[ ruRU ]] tL["Sets the font height of the mana text"] = "Задает высоту шрифта для текста маны"
--[[ ruRU ]] tL["Font Shadow"] = "Тень шрифта"
--[[ ruRU ]] tL["Show font shadow on mana text"] = "Отображать тень для текста маны"
--[[ ruRU ]] tL["Outline"] = "Контур"
--[[ ruRU ]] tL["Sets the outline for mana text"] = "Задает окантовку для текста маны"
--[[ ruRU ]] tL["Mode"] = "Режим"
--[[ ruRU ]] tL["Choose what to show for mana text"] = "Выбрать, что показывать в тексте маны"

--[[ ruRU ]] tL["Position"] = "Позиция"
--[[ ruRU ]] tL["Adjust mana text position"] = "Задать место значения маны"
--[[ ruRU ]] tL["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] tL["Sets the anchor for the mana text"] = "Задает прикрепление текста маны"
--[[ ruRU ]] tL["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] tL["Sets the relative point on the health bar to anchor the mana text"] = "Задает точку для положения текста маны относительно полоски здоровья"
--[[ ruRU ]] tL["X Offset"] = "Смещение по X"
--[[ ruRU ]] tL["X offset of the mana text"] = "Смещение текста маны по X"
--[[ ruRU ]] tL["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] tL["Y offset of the mana text"] = "Смещение текста маны по Y"
--[[ ruRU ]] tL["Alpha"] = "Прозрачность"
--[[ ruRU ]] tL["Sets the alpha of the mana text"] = "Задает прозрачность текста маны"
--[[ ruRU ]] tL["Color"] = "Цвет"
--[[ ruRU ]] tL["Sets the mana text color"] = "Задает цвет текста маны"

--[[ ruRU ]] tL["None"] = "Нет"
--[[ ruRU ]] tL["Normal"] = "Обычно"
--[[ ruRU ]] tL["Thick"] = "Жирный"

--[[ ruRU ]] tL["Percent"] = "Проценты"
--[[ ruRU ]] tL["Mana"] = "Мана"
--[[ ruRU ]] tL["Mana & Percent"] = "Мана & Проценты"
--[[ ruRU ]] tL["Deficit"] = "Дефицит"
--[[ ruRU ]] tL["Full"] = "Полное"

--[[ ruRU ]] tL["Always Show Target"] = "Всегда показывать цель"
--[[ ruRU ]] tL["Always show mana text on active targets in combat"] = "В бою всегда показывать текст маны текущей цели"

--[[ ruRU ]] tL["Advanced"] = "Дополнительно"
--[[ ruRU ]] tL["Options for expert users"] = "Настройки для опытных пользователей"
--[[ ruRU ]] tL["Format"] = "Формат"
--[[ ruRU ]] tL["Mana tag"] = "Вид маны"
--[[ ruRU ]] tL["<Any tag string>"] = "<Любая строка формата>"

--[[ ruRU ]] tL["TOPLEFT"] = "ВВЕРХУ-СЛЕВА"
--[[ ruRU ]] tL["TOP"] = "ВВЕРХУ"
--[[ ruRU ]] tL["TOPRIGHT"] = "ВВЕРХУ-СПРАВА"
--[[ ruRU ]] tL["LEFT"] = "СЛЕВА"
--[[ ruRU ]] tL["CENTER"] = "ПО ЦЕНТРУ"
--[[ ruRU ]] tL["RIGHT"] = "СПРАВА"
--[[ ruRU ]] tL["BOTTOMLEFT"] = "СНИЗУ-СЛЕВА"
--[[ ruRU ]] tL["BOTTOM"] = "СНИЗУ"
--[[ ruRU ]] tL["BOTTOMRIGHT"] = "СНИЗУ-СПРАВА"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftMana"] = "AloftMana"
--[[ ruRU ]] mL["Display mana data, bars, and text on nameplates"] = "Отображает данные/тект/полосы маны"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] bL["Mana Bar"] = "法力值显示条"
--[[ zhCN ]] bL["Mana Bar options"] = "法力值显示条相关设置"
--[[ zhCN ]] bL["Enable"] = "启用"
--[[ zhCN ]] bL["Show mana bars on group member nameplates"] = "在队友的姓名板上显示法力值显示条"

--[[ zhCN ]] bL["Texture"] = "材质"
--[[ zhCN ]] bL["Sets the mana bar texture"] = "设定法力值显示条的材质"
--[[ zhCN ]] bL["Alpha"] = "透明度"
--[[ zhCN ]] bL["Sets the mana bar alpha"] = "设定法力值显示条的透明度"

--[[ zhCN ]] bL["Height"] = "高度"
--[[ zhCN ]] bL["Sets the height of the mana bar"] = "设定法力值显示条的高度"

--[[ zhCN ]] bL["Position"] = "位置"
--[[ zhCN ]] bL["Adjust the mana bar's position"] = "调整法力值显示条的位置"
--[[ zhCN ]] bL["Left Offset"] = "向左偏移"
--[[ zhCN ]] bL["Sets the offset of the left of the mana bar"] = "设定法力值显示条的向左偏移量"
--[[ zhCN ]] bL["Right Offset"] = "向右偏移"
--[[ zhCN ]] bL["Sets the offset of the right of the mana bar"] = "设定法力值显示条的向右偏移量"
--[[ zhCN ]] bL["Vertical Offset"] = "垂直偏移"
--[[ zhCN ]] bL["Sets the vertical offset of the mana bar"] = "设定法力值显示条的垂直偏移量"

--[[ zhCN ]] bL["Colors"] = "颜色"
--[[ zhCN ]] bL["Customize colors"] = "自定义颜色"
--[[ zhCN ]] bL["Backdrop Color"] = "背景颜色"
--[[ zhCN ]] bL["Sets the backdrop color of the mana bar"] = "设定法力值显示条的背景颜色"
--[[ zhCN ]] bL["Mana Color"] = "法力颜色"
--[[ zhCN ]] bL["Sets the color for mana bars"] = "设定法力条的颜色"
--[[ zhCN ]] bL["Rage Color"] = "怒气颜色"
--[[ zhCN ]] bL["Sets the color for rage bars"] = "设定怒气条的颜色"
--[[ zhCN ]] bL["Focus Color"] = "集中值颜色"
--[[ zhCN ]] bL["Sets the color for focus bars"] = "设定集中值显示条的颜色"
--[[ zhCN ]] bL["Energy Color"] = "能量颜色"
--[[ zhCN ]] bL["Sets the color for energy bars"] = "设定能量条的颜色"
--[[ zhCN ]] bL["Happiness Color"] = "快乐值颜色"
--[[ zhCN ]] bL["Sets the color for happiness bars"] = "设定快乐值显示条的颜色"
--[[ zhCN ]] bL["Rune Color"] = "Rune Color"
--[[ zhCN ]] bL["Sets the color for rune bars"] = "Sets the color for rune bars"
--[[ zhCN ]] bL["Runic Power Color"] = "Runic Power Color"
--[[ zhCN ]] bL["Sets the color for runic power bars"] = "Sets the color for runic power bars"
--[[ zhCN ]] bL["Reset to Defaults"] = "重置为默认值"
--[[ zhCN ]] bL["Resets all colors to their defaults"] = "将全部颜色设定重置为默认"

--[[ zhCN ]] bL["Border"] = "Border"
--[[ zhCN ]] bL["Border options"] = "Border options"
--[[ zhCN ]] bL["Target Only"] = "Target Only"
--[[ zhCN ]] bL["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ zhCN ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ zhCN ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ zhCN ]] bL["Border Inset"] = "Border Inset"
--[[ zhCN ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ zhCN ]] bL["Border Color"] = "边框颜色"
--[[ zhCN ]] bL["Sets the border color of the mana bar"] = "Sets the border color of the mana bar"
--[[ zhCN ]] bL["Border Style"] = "边框样式"
--[[ zhCN ]] bL["Sets the style of the mana bar border"] = "Sets the style of the mana bar border"

--[[ zhCN ]] --bL["Always Show Target"] = "始终显示目标"
--[[ zhCN ]] --bL["Always show mana bar on active targets in combat"] = "在战斗中始终显示当前目标的法力值"

--[[ zhCN ]] bL["Advanced"] = "高级"
--[[ zhCN ]] bL["Options for expert users"] = "高级设置"
--[[ zhCN ]] bL["Color Format"] = "颜色格式"
--[[ zhCN ]] bL["Color tag"] = "颜色标签"
--[[ zhCN ]] bL["<Any tag string>"] = "<任意标签文字>"

-----------------------------------------------------------------------------

--[[ zhCN ]] tL["Mana Text"] = "法力提示文字"
--[[ zhCN ]] tL["Mana text options"] = "法力提示文字相关设置"
--[[ zhCN ]] tL["Enable"] = "启用"
--[[ zhCN ]] tL["Show mana text on group member nameplates"] = "在队友的姓名板上显示法力文字"

--[[ zhCN ]] tL["Color by type"] = "根据类型显示颜色"
--[[ zhCN ]] tL["Color text differently for mana, energy, rage"] = "根据不同的类型（法力、能量或怒气）显示颜色"

--[[ zhCN ]] tL["Typeface"] = "式样"
--[[ zhCN ]] tL["Mana text typeface options"] = "法力提示文字的式样设置"
--[[ zhCN ]] tL["Font"] = "字体"
--[[ zhCN ]] tL["Sets the font for mana text"] = "设定法力提示文字的字体"
--[[ zhCN ]] tL["Font Size"] = "字号"
--[[ zhCN ]] tL["Sets the font height of the mana text"] = "设定法力提示文字的字号"
--[[ zhCN ]] tL["Font Shadow"] = "字体阴影"
--[[ zhCN ]] tL["Show font shadow on mana text"] = "设定法力提示文字的字体阴影"
--[[ zhCN ]] tL["Outline"] = "轮廓"
--[[ zhCN ]] tL["Sets the outline for mana text"] = "设定法力提示文字的字体轮廓"
--[[ zhCN ]] tL["Mode"] = "模式"
--[[ zhCN ]] tL["Choose what to show for mana text"] = "选择在法力提示文字的显示内容"

--[[ zhCN ]] tL["Position"] = "位置"
--[[ zhCN ]] tL["Adjust mana text position"] = "设定法力提示文字的位置"
--[[ zhCN ]] tL["Anchor"] = "锚点"
--[[ zhCN ]] tL["Sets the anchor for the mana text"] = "设定法力提示文字的锚点"
--[[ zhCN ]] tL["Anchor To"] = "固定在"
--[[ zhCN ]] tL["Sets the relative point on the health bar to anchor the mana text"] = "设定法力提示文字固定在生命值显示条的相对位置"
--[[ zhCN ]] tL["X Offset"] = "X轴偏移"
--[[ zhCN ]] tL["X offset of the mana text"] = "设定法力提示文字的X轴偏移量"
--[[ zhCN ]] tL["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] tL["Y offset of the mana text"] = "设定法力提示文字的Y轴偏移量"
--[[ zhCN ]] tL["Alpha"] = "透明度"
--[[ zhCN ]] tL["Sets the alpha of the mana text"] = "设定法力提示文字的透明度"
--[[ zhCN ]] tL["Color"] = "颜色"
--[[ zhCN ]] tL["Sets the mana text color"] = "设定法力提示文字的颜色"

--[[ zhCN ]] tL["None"] = "无"
--[[ zhCN ]] tL["Normal"] = "正常"
--[[ zhCN ]] tL["Thick"] = "粗"

--[[ zhCN ]] tL["Percent"] = "百分比"
--[[ zhCN ]] tL["Mana"] = "法力"
--[[ zhCN ]] tL["Mana & Percent"] = "法力值和百分比"
--[[ zhCN ]] tL["Deficit"] = "不足额"
--[[ zhCN ]] tL["Full"] = "完全"

--[[ zhCN ]] tL["Always Show Target"] = "始终显示目标"
--[[ zhCN ]] tL["Always show mana text on active targets in combat"] = "战斗中始终显示当前目标的法力文字"

--[[ zhCN ]] tL["Advanced"] = "高级"
--[[ zhCN ]] tL["Options for expert users"] = "高级设置"
--[[ zhCN ]] tL["Format"] = "格式"
--[[ zhCN ]] tL["Mana tag"] = "法力标签"
--[[ zhCN ]] tL["<Any tag string>"] = "<任意标签文字>"

--[[ zhCN ]] tL["TOPLEFT"] = "左上"
--[[ zhCN ]] tL["TOP"] = "上"
--[[ zhCN ]] tL["TOPRIGHT"] = "右上"
--[[ zhCN ]] tL["LEFT"] = "左"
--[[ zhCN ]] tL["CENTER"] = "中"
--[[ zhCN ]] tL["RIGHT"] = "右"
--[[ zhCN ]] tL["BOTTOMLEFT"] = "左下"
--[[ zhCN ]] tL["BOTTOM"] = "下"
--[[ zhCN ]] tL["BOTTOMRIGHT"] = "右下"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftMana"] = "法力值"
--[[ zhCN ]] mL["Display mana data, bars, and text on nameplates"] = "在姓名板上显示法力值数据和法力条"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] bL["Mana Bar"] = "法力條"
--[[ zhTW ]] bL["Mana Bar options"] = "法力條設定"
--[[ zhTW ]] bL["Enable"] = "啟用"
--[[ zhTW ]] bL["Show mana bars on group member nameplates"] = "在隊伍成員名牌上顯示法力條"

--[[ zhTW ]] bL["Texture"] = "材質"
--[[ zhTW ]] bL["Sets the mana bar texture"] = "設定法力條材質"
--[[ zhTW ]] bL["Alpha"] = "透明度"
--[[ zhTW ]] bL["Sets the mana bar alpha"] = "設定法力條透明度"

--[[ zhTW ]] bL["Height"] = "高度"
--[[ zhTW ]] bL["Sets the height of the mana bar"] = "設定法力條的高度"

--[[ zhTW ]] bL["Position"] = "位置"
--[[ zhTW ]] bL["Adjust the mana bar's position"] = "調整法力條的位置"
--[[ zhTW ]] bL["Left Offset"] = "左偏移"
--[[ zhTW ]] bL["Sets the offset of the left of the mana bar"] = "設定法力條的左偏移"
--[[ zhTW ]] bL["Right Offset"] = "右偏移"
--[[ zhTW ]] bL["Sets the offset of the right of the mana bar"] = "設定法力條的右偏移"
--[[ zhTW ]] bL["Vertical Offset"] = "垂直偏移"
--[[ zhTW ]] bL["Sets the vertical offset of the mana bar"] = "設定法力條的垂直偏移"

--[[ zhTW ]] bL["Colors"] = "顏色"
--[[ zhTW ]] bL["Customize colors"] = "自定顏色"
--[[ zhTW ]] bL["Backdrop Color"] = "背景顏色"
--[[ zhTW ]] bL["Sets the backdrop color of the mana bar"] = "設定法力條的背景顏色"
--[[ zhTW ]] bL["Mana Color"] = "法力顏色"
--[[ zhTW ]] bL["Sets the color for mana bars"] = "設定法力條的顏色"
--[[ zhTW ]] bL["Rage Color"] = "怒氣顏色"
--[[ zhTW ]] bL["Sets the color for rage bars"] = "設定怒氣條的顏色"
--[[ zhTW ]] bL["Focus Color"] = "集中值顏色"
--[[ zhTW ]] bL["Sets the color for focus bars"] = "設定集中值條的顏色"
--[[ zhTW ]] bL["Energy Color"] = "能量顏色"
--[[ zhTW ]] bL["Sets the color for energy bars"] = "設定能量條的顏色"
--[[ zhTW ]] bL["Happiness Color"] = "快樂值顏色"
--[[ zhTW ]] bL["Sets the color for happiness bars"] = "設定快樂值條的顏色"
--[[ zhTW ]] bL["Rune Color"] = "符文顏色"
--[[ zhTW ]] bL["Sets the color for rune bars"] = "設定符文條的顏色"
--[[ zhTW ]] bL["Runic Power Color"] = "符文能量顏色"
--[[ zhTW ]] bL["Sets the color for runic power bars"] = "設定符文能量條的顏色"
--[[ zhTW ]] bL["Reset to Defaults"] = "重置到預設"
--[[ zhTW ]] bL["Resets all colors to their defaults"] = "重置全部顏色到預設"

--[[ zhTW ]] bL["Border"] = "邊框"
--[[ zhTW ]] bL["Border options"] = "邊框設定"
--[[ zhTW ]] bL["Target Only"] = "只在目標"
--[[ zhTW ]] bL["Enables the border on the current target only"] = "啟用只在目前目標上的邊框"
--[[ zhTW ]] bL["Border Edge Size"] = "邊框邊緣大小"
--[[ zhTW ]] bL["Sets the thickness of the border"] = "設定邊框的寬度"
--[[ zhTW ]] bL["Border Inset"] = "邊框崁入"
--[[ zhTW ]] bL["Sets the padding aroundthe border"] = "設定邊框的間距範圍"
--[[ zhTW ]] bL["Border Color"] = "邊框顏色"
--[[ zhTW ]] bL["Sets the border color of the mana bar"] = "設定法力條的邊框顏色"
--[[ zhTW ]] bL["Border Style"] = "邊框樣式"
--[[ zhTW ]] bL["Sets the style of the mana bar border"] = "設定法力條邊框的樣式"

--[[ zhTW ]] --bL["Always Show Target"] = "總是顯示目標"
--[[ zhTW ]] --bL["Always show mana bar on active targets in combat"] = "在戰鬥中總是顯示活動目標的法力條"

--[[ zhTW ]] bL["Advanced"] = "進階"
--[[ zhTW ]] bL["Options for expert users"] = "熟練的使用者設定"
--[[ zhTW ]] bL["Color Format"] = "顏色格式"
--[[ zhTW ]] bL["Color tag"] = "顏色標籤"
--[[ zhTW ]] bL["<Any tag string>"] = "<任何標籤文字>"

-----------------------------------------------------------------------------

--[[ zhTW ]] tL["Mana Text"] = "法力文字"
--[[ zhTW ]] tL["Mana text options"] = "法力文字設定"
--[[ zhTW ]] tL["Enable"] = "啟用"
--[[ zhTW ]] tL["Show mana text on group member nameplates"] = "在隊伍名牌上顯示法力文字"

--[[ zhTW ]] tL["Color by type"] = "著色根據類型"
--[[ zhTW ]] tL["Color text differently for mana, energy, rage"] = "根據不同類型 (法力，能量，怒氣) 設定顏色"

--[[ zhTW ]] tL["Typeface"] = "字體"
--[[ zhTW ]] tL["Mana text typeface options"] = "法力文字字體設定"
--[[ zhTW ]] tL["Font"] = "字型"
--[[ zhTW ]] tL["Sets the font for mana text"] = "設定法力文字的字型"
--[[ zhTW ]] tL["Font Size"] = "字型大小"
--[[ zhTW ]] tL["Sets the font height of the mana text"] = "設定法力文字的字型高度"
--[[ zhTW ]] tL["Font Shadow"] = "字型陰影"
--[[ zhTW ]] tL["Show font shadow on mana text"] = "設定法力文字的字型陰影"
--[[ zhTW ]] tL["Outline"] = "輪廓"
--[[ zhTW ]] tL["Sets the outline for mana text"] = "設定法力文字的字型輪廓"
--[[ zhTW ]] tL["Mode"] = "模式"
--[[ zhTW ]] tL["Choose what to show for mana text"] = "選擇在法力文字顯示什麼"

--[[ zhTW ]] tL["Position"] = "位置"
--[[ zhTW ]] tL["Adjust mana text position"] = "調整法力文字位置"
--[[ zhTW ]] tL["Anchor"] = "錨點"
--[[ zhTW ]] tL["Sets the anchor for the mana text"] = "設定法力文字的錨點"
--[[ zhTW ]] tL["Anchor To"] = "錨點到"
--[[ zhTW ]] tL["Sets the relative point on the health bar to anchor the mana text"] = "設定在生命條上錨到法力文字的相關點"
--[[ zhTW ]] tL["X Offset"] = "X偏移"
--[[ zhTW ]] tL["X offset of the mana text"] = "法力文字的X偏移"
--[[ zhTW ]] tL["Y Offset"] = "Y偏移"
--[[ zhTW ]] tL["Y offset of the mana text"] = "法力文字的Y偏移"
--[[ zhTW ]] tL["Alpha"] = "透明度"
--[[ zhTW ]] tL["Sets the alpha of the mana text"] = "設定法力文字的透明度"
--[[ zhTW ]] tL["Color"] = "顏色"
--[[ zhTW ]] tL["Sets the mana text color"] = "設定法力文字顏色"

--[[ zhTW ]] tL["None"] = "無"
--[[ zhTW ]] tL["Normal"] = "正常"
--[[ zhTW ]] tL["Thick"] = "粗"

--[[ zhTW ]] tL["Percent"] = "百分比"
--[[ zhTW ]] tL["Mana"] = "法力"
--[[ zhTW ]] tL["Mana & Percent"] = "法力和百分比"
--[[ zhTW ]] tL["Deficit"] = "虧減"
--[[ zhTW ]] tL["Full"] = "完整"

--[[ zhTW ]] tL["Always Show Target"] = "總是顯示目標"
--[[ zhTW ]] tL["Always show mana text on active targets in combat"] = "戰鬥中總是顯示活動目標的法力文字"

--[[ zhTW ]] tL["Advanced"] = "進階"
--[[ zhTW ]] tL["Options for expert users"] = "熟練的使用者設定"
--[[ zhTW ]] tL["Format"] = "格式"
--[[ zhTW ]] tL["Mana tag"] = "法力標籤"
--[[ zhTW ]] tL["<Any tag string>"] = "<任何標籤文字>"

--[[ zhTW ]] tL["TOPLEFT"] = "上左"
--[[ zhTW ]] tL["TOP"] = "上"
--[[ zhTW ]] tL["TOPRIGHT"] = "上右"
--[[ zhTW ]] tL["LEFT"] = "左"
--[[ zhTW ]] tL["CENTER"] = "中"
--[[ zhTW ]] tL["RIGHT"] = "右"
--[[ zhTW ]] tL["BOTTOMLEFT"] = "下左"
--[[ zhTW ]] tL["BOTTOM"] = "下"
--[[ zhTW ]] tL["BOTTOMRIGHT"] = "下右"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftMana"] = "Aloft法力"
--[[ zhTW ]] mL["Display mana data, bars, and text on nameplates"] = "在名牌上顯示法力資料、條、文字"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

AloftLocale.AloftManaBarOptions = setmetatable(bL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
bL = nil

AloftLocale.AloftManaTextOptions = setmetatable(tL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
tL = nil

-----------------------------------------------------------------------------

end)

