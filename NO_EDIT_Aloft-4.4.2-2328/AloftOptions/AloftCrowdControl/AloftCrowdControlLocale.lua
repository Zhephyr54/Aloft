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

local iL = { }

local nL = { }

local tL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] bL["Crowd Control"] = "Crowd Control"
--[[ enUS ]] bL["Crowd control options"] = "Crowd control options"

--[[ enUS ]] bL["Enable"] = "Enable"
--[[ enUS ]] bL["Shows crowd control timers on nameplates when possible"] = "Shows crowd control timers on nameplates when possible"
--[[ enUS ]] bL["Speculative Attach"] = "Speculative Attach"
--[[ enUS ]] bL["Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"] = "Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"
--[[ enUS ]] bL["Texture"] = "Texture"
--[[ enUS ]] bL["Sets the crowd control bar texture"] = "Sets the crowd control bar texture"

--[[ enUS ]] bL["Border"] = "Border"
--[[ enUS ]] bL["Border options"] = "Border options"
--[[ enUS ]] bL["Target Only"] = "Target Only"
--[[ enUS ]] bL["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ enUS ]] bL["Border Style"] = "Border Style"
--[[ enUS ]] bL["Sets the style of the crowd control bar border"] = "Sets the style of the crowd control bar border"
--[[ enUS ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ enUS ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ enUS ]] bL["Border Inset"] = "Border Inset"
--[[ enUS ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ enUS ]] bL["Border Color"] = "Border Color"
--[[ enUS ]] bL["Sets the border color of the crowd control bar"] = "Sets the border color of the crowd control bar"

--[[ enUS ]] bL["Colors"] = "Colors"
--[[ enUS ]] bL["Color options"] = "Color options"
--[[ enUS ]] bL["Bar Color"] = "Bar Color"
--[[ enUS ]] bL["Sets the crowd control bar color"] = "Sets the crowd control bar color"
--[[ enUS ]] bL["Backdrop Color"] = "Backdrop Color"
--[[ enUS ]] bL["Sets the crowd control backdrop color"] = "Sets the crowd control backdrop color"

--[[ enUS ]] bL["Height"] = "Height"
--[[ enUS ]] bL["Sets the height of the crowd control bar"] = "Sets the height of the crowd control bar"

--[[ enUS ]] bL["Position"] = "Position"
--[[ enUS ]] bL["Adjust the crowd control bar's position"] = "Adjust the crowd control bar's position"
--[[ enUS ]] bL["Left Offset"] = "Left Offset"
--[[ enUS ]] bL["Sets the offset of the left of the crowd control bar"] = "Sets the offset of the left of the crowd control bar"
--[[ enUS ]] bL["Right Offset"] = "Right Offset"
--[[ enUS ]] bL["Sets the offset of the right of the crowd control bar"] = "Sets the offset of the right of the crowd control bar"
--[[ enUS ]] bL["Vertical Offset"] = "Vertical Offset"
--[[ enUS ]] bL["Sets the vertical offset of the crowd control bar"] = "Sets the vertical offset of the crowd control bar"

--[[ enUS ]] bL["TOPLEFT"] = "TOPLEFT"
--[[ enUS ]] bL["TOP"] = "TOP"
--[[ enUS ]] bL["TOPRIGHT"] = "TOPRIGHT"
--[[ enUS ]] bL["LEFT"] = "LEFT"
--[[ enUS ]] bL["CENTER"] = "CENTER"
--[[ enUS ]] bL["RIGHT"] = "RIGHT"
--[[ enUS ]] bL["BOTTOMLEFT"] = "BOTTOMLEFT"
--[[ enUS ]] bL["BOTTOM"] = "BOTTOM"
--[[ enUS ]] bL["BOTTOMRIGHT"] = "BOTTOMRIGHT"

-----------------------------------------------------------------------------

--[[ enUS ]] iL["Spell Icon"] = "Spell Icon"
--[[ enUS ]] iL["Crowd control spell icon placement options"] = "Crowd control spell icon placement options"
--[[ enUS ]] iL["Enable"] = "Enable"
--[[ enUS ]] iL["Enable crowd control spell icon display on the nameplate"] = "Enable crowd control spell icon display on the nameplate"
--[[ enUS ]] iL["Position"] = "Position"
--[[ enUS ]] iL["Adjust crowd control spell icon position"] = "Adjust crowd control spell icon position"
--[[ enUS ]] iL["Anchor"] = "Anchor"
--[[ enUS ]] iL["Sets the anchor for the crowd control spell icon"] = "Sets the anchor for the crowd control spell icon"
--[[ enUS ]] iL["Anchor To"] = "Anchor To"
--[[ enUS ]] iL["Sets the relative point on the crowd control bar to anchor the spell icon"] = "Sets the relative point on the crowd control bar to anchor the spell icon"
--[[ enUS ]] iL["Size"] = "Size"
--[[ enUS ]] iL["Size in pixels of the crowd control spell icon"] = "Size in pixels of the crowd control spell icon"
--[[ enUS ]] iL["X Offset"] = "X Offset"
--[[ enUS ]] iL["X offset of the crowd control spell icon"] = "X offset of the crowd control spell icon"
--[[ enUS ]] iL["Y Offset"] = "Y Offset"
--[[ enUS ]] iL["Y offset of the crowd control spell icon"] = "Y offset of the crowd control spell icon"

--[[ enUS ]] iL["TOPLEFT"] = "TOPLEFT"
--[[ enUS ]] iL["TOP"] = "TOP"
--[[ enUS ]] iL["TOPRIGHT"] = "TOPRIGHT"
--[[ enUS ]] iL["LEFT"] = "LEFT"
--[[ enUS ]] iL["CENTER"] = "CENTER"
--[[ enUS ]] iL["RIGHT"] = "RIGHT"
--[[ enUS ]] iL["BOTTOMLEFT"] = "BOTTOMLEFT"
--[[ enUS ]] iL["BOTTOM"] = "BOTTOM"
--[[ enUS ]] iL["BOTTOMRIGHT"] = "BOTTOMRIGHT"

-----------------------------------------------------------------------------

--[[ enUS ]] nL["Spell Name"] = "Spell Name"
--[[ enUS ]] nL["Crowd control bar spell name text options"] = "Crowd control bar spell name text options"
--[[ enUS ]] nL["Enable"] = "Enable"
--[[ enUS ]] nL["Show spell name on crowd control bar"] = "Show spell name on crowd control bar"
--[[ enUS ]] nL["Typeface"] = "Typeface"
--[[ enUS ]] nL["Spell name typeface options"] = "Spell name typeface options"
--[[ enUS ]] nL["Font"] = "Font"
--[[ enUS ]] nL["Sets the font for spell name"] = "Sets the font for spell name"
--[[ enUS ]] nL["Font Size"] = "Font Size"
--[[ enUS ]] nL["Sets the font height of the spell name"] = "Sets the font height of the spell name"
--[[ enUS ]] nL["Font Shadow"] = "Font Shadow"
--[[ enUS ]] nL["Show font shadow on spell name"] = "Show font shadow on spell name"
--[[ enUS ]] nL["Alignment"] = "Alignment"
--[[ enUS ]] nL["Sets the alignment of the spell name"] = "Sets the alignment of the spell name"
--[[ enUS ]] nL["Outline"] = "Outline"
--[[ enUS ]] nL["Sets the font outline for spell name"] = "Sets the font outline for spell name"
--[[ enUS ]] nL["Position"] = "Position"
--[[ enUS ]] nL["Adjust spell name position"] = "Adjust spell name position"
--[[ enUS ]] nL["Left Offset"] = "Left Offset"
--[[ enUS ]] nL["Sets the offset of the left of the text"] = "Sets the offset of the left of the text"
--[[ enUS ]] nL["Right Offset"] = "Right Offset"
--[[ enUS ]] nL["Sets the offset of the right of the text"] = "Sets the offset of the right of the text"
--[[ enUS ]] nL["Vertical Offset"] = "Vertical Offset"
--[[ enUS ]] nL["Sets the vertical offset of the text"] = "Sets the vertical offset of the text"
--[[ enUS ]] nL["Color"] = "Color"
--[[ enUS ]] nL["Sets the spell name color"] = "Sets the spell name color"

--[[ enUS ]] nL["None"] = "None"
--[[ enUS ]] nL["Normal"] = "Normal"
--[[ enUS ]] nL["Thick"] = "Thick"

--[[ enUS ]] nL["LEFT"] = "LEFT"
--[[ enUS ]] nL["CENTER"] = "CENTER"
--[[ enUS ]] nL["RIGHT"] = "RIGHT"

-----------------------------------------------------------------------------

--[[ enUS ]] tL["Time Text"] = "Time Text"
--[[ enUS ]] tL["Crowd control bar time text options"] = "Crowd control bar time text options"
--[[ enUS ]] tL["Enable"] = "Enable"
--[[ enUS ]] tL["Show crowd control bar time text"] = "Show crowd control bar time text"
--[[ enUS ]] tL["Typeface"] = "Typeface"
--[[ enUS ]] tL["Crowd control bar time text typeface options"] = "Crowd control bar time text typeface options"
--[[ enUS ]] tL["Font"] = "Font"
--[[ enUS ]] tL["Sets the font for crowd control bar time text"] = "Sets the font for crowd control bar time text"
--[[ enUS ]] tL["Font Size"] = "Font Size"
--[[ enUS ]] tL["Sets the font height of the crowd control bar time text"] = "Sets the font height of the crowd control bar time text"
--[[ enUS ]] tL["Font Shadow"] = "Font Shadow"
--[[ enUS ]] tL["Show font shadow on crowd control bar time text"] = "Show font shadow on crowd control bar time text"
--[[ enUS ]] tL["Alignment"] = "Alignment"
--[[ enUS ]] tL["Sets the alignment of the crowd control bar time text"] = "Sets the alignment of the crowd control bar time text"
--[[ enUS ]] tL["Outline"] = "Outline"
--[[ enUS ]] tL["Sets the font outline for crowd control bar time text"] = "Sets the font outline for crowd control bar time text"
--[[ enUS ]] tL["Position"] = "Position"
--[[ enUS ]] tL["Adjust crowd control bar time text position"] = "Adjust crowd control bar time text position"
--[[ enUS ]] tL["Left Offset"] = "Left Offset"
--[[ enUS ]] tL["Sets the offset of the left of the text"] = "Sets the offset of the left of the text"
--[[ enUS ]] tL["Right Offset"] = "Right Offset"
--[[ enUS ]] tL["Sets the offset of the right of the text"] = "Sets the offset of the right of the text"
--[[ enUS ]] tL["Vertical Offset"] = "Vertical Offset"
--[[ enUS ]] tL["Sets the vertical offset of the text"] = "Sets the vertical offset of the text"
--[[ enUS ]] tL["Color"] = "Color"
--[[ enUS ]] tL["Sets the crowd control bar time text color"] = "Sets the crowd control bar time text color"

--[[ enUS ]] tL["None"] = "None"
--[[ enUS ]] tL["Normal"] = "Normal"
--[[ enUS ]] tL["Thick"] = "Thick"

--[[ enUS ]] tL["LEFT"] = "LEFT"
--[[ enUS ]] tL["CENTER"] = "CENTER"
--[[ enUS ]] tL["RIGHT"] = "RIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftCrowdControl"] = "AloftCrowdControl"
--[[ enUS ]] mL["Display crowd control timers on nameplates when possible"] = "Display crowd control timers on nameplates when possible"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

--[[ koKR ]] bL["Crowd Control"] = "Crowd Control"
--[[ koKR ]] bL["Crowd control options"] = "Crowd control options"

--[[ koKR ]] bL["Enable"] = "사용"
--[[ koKR ]] bL["Shows crowd control timers on nameplates when possible"] = "Shows crowd control timers on nameplates when possible"
--[[ koKR ]] bL["Speculative Attach"] = "추리적인 붙이기"
--[[ koKR ]] bL["Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"] = "Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"
--[[ koKR ]] bL["Texture"] = "텍스쳐"
--[[ koKR ]] bL["Sets the crowd control bar texture"] = "Sets the crowd control bar texture"

--[[ koKR ]] bL["Border"] = "Border"
--[[ koKR ]] bL["Border options"] = "Border options"
--[[ koKR ]] bL["Target Only"] = "Target Only"
--[[ koKR ]] bL["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ koKR ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ koKR ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ koKR ]] bL["Border Inset"] = "Border Inset"
--[[ koKR ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ koKR ]] bL["Border Color"] = "테두리 색상"
--[[ koKR ]] bL["Sets the border color of the crowd control bar"] = "Sets the border color of the crowd control bar"
--[[ koKR ]] bL["Border Style"] = "테두리 스타일"
--[[ koKR ]] bL["Sets the style of the crowd control bar border"] = "Sets the style of the crowd control bar border"

--[[ koKR ]] bL["Colors"] = "색상"
--[[ koKR ]] bL["Color options"] = "색상 설정"
--[[ koKR ]] bL["Bar Color"] = "바 색상"
--[[ koKR ]] bL["Sets the crowd control bar color"] = "Sets the crowd control bar color"
--[[ koKR ]] bL["Backdrop Color"] = "배경 색상"
--[[ koKR ]] bL["Sets the crowd control backdrop color"] = "Sets the crowd control bar color"

--[[ koKR ]] bL["Height"] = "높이"
--[[ koKR ]] bL["Sets the height of the crowd control bar"] = "Sets the height of the crowd control bar"

--[[ koKR ]] bL["Position"] = "위치"
--[[ koKR ]] bL["Adjust the crowd control bar's position"] = "Adjust the crowd control bar's position"
--[[ koKR ]] bL["Left Offset"] = "좌측 좌표"
--[[ koKR ]] bL["Sets the offset of the left of the crowd control bar"] = "Sets the offset of the left of the crowd control bar"
--[[ koKR ]] bL["Right Offset"] = "우측 좌표"
--[[ koKR ]] bL["Sets the offset of the right of the crowd control bar"] = "Sets the offset of the right of the crowd control bar"
--[[ koKR ]] bL["Vertical Offset"] = "수직 좌표"
--[[ koKR ]] bL["Sets the vertical offset of the crowd control bar"] = "Sets the vertical offset of the crowd control bar"

--[[ koKR ]] bL["TOPLEFT"] = "좌측 상단"
--[[ koKR ]] bL["TOP"] = "상단"
--[[ koKR ]] bL["TOPRIGHT"] = "우측 상단"
--[[ koKR ]] bL["LEFT"] = "좌측"
--[[ koKR ]] bL["CENTER"] = "가운데"
--[[ koKR ]] bL["RIGHT"] = "우측"
--[[ koKR ]] bL["BOTTOMLEFT"] = "좌측 하단"
--[[ koKR ]] bL["BOTTOM"] = "하단"
--[[ koKR ]] bL["BOTTOMRIGHT"] = "우측 하단"

-----------------------------------------------------------------------------

--[[ koKR ]] iL["Spell Icon"] = "주문 아이콘"
--[[ koKR ]] iL["Crowd control spell icon placement options"] = "Crowd control spell icon placement options"
--[[ koKR ]] iL["Enable"] = "사용"
--[[ koKR ]] iL["Enable crowd control spell icon display on the nameplate"] = "Enable crowd control spell icon display on the nameplate"
--[[ koKR ]] iL["Position"] = "위치"
--[[ koKR ]] iL["Adjust crowd control spell icon position"] = "Adjust crowd control spell icon position"
--[[ koKR ]] iL["Anchor"] = "앵커"
--[[ koKR ]] iL["Sets the anchor for the crowd control spell icon"] = "Sets the anchor for the crowd control spell icon"
--[[ koKR ]] iL["Anchor To"] = "앵커 위치"
--[[ koKR ]] iL["Sets the relative point on the crowd control bar to anchor the spell icon"] = "Sets the relative point on the crowd control bar to anchor the spell icon"
--[[ koKR ]] iL["Size"] = "크기"
--[[ koKR ]] iL["Size in pixels of the crowd control spell icon"] = "Size in pixels of the crowd control spell icon"
--[[ koKR ]] iL["X Offset"] = "X 좌표"
--[[ koKR ]] iL["X offset of the crowd control spell icon"] = "X offset of the crowd control spell icon"
--[[ koKR ]] iL["Y Offset"] = "Y 좌표"
--[[ koKR ]] iL["Y offset of the crowd control spell icon"] = "Y offset of the crowd control spell icon"

--[[ koKR ]] iL["TOPLEFT"] = "좌측 상단"
--[[ koKR ]] iL["TOP"] = "상단"
--[[ koKR ]] iL["TOPRIGHT"] = "우측 상단"
--[[ koKR ]] iL["LEFT"] = "좌측"
--[[ koKR ]] iL["CENTER"] = "가운데"
--[[ koKR ]] iL["RIGHT"] = "우측"
--[[ koKR ]] iL["BOTTOMLEFT"] = "좌측 하단"
--[[ koKR ]] iL["BOTTOM"] = "하단"
--[[ koKR ]] iL["BOTTOMRIGHT"] = "우측 하단"

-----------------------------------------------------------------------------

--[[ koKR ]] nL["Spell Name"] = "주문명"
--[[ koKR ]] nL["Crowd control bar spell name text options"] = "Crowd control bar spell name text options"
--[[ koKR ]] nL["Enable"] = "사용"
--[[ koKR ]] nL["Show spell name on crowd control bar"] = "Show spell name on crowd control bar"
--[[ koKR ]] nL["Typeface"] = "서체"
--[[ koKR ]] nL["Spell name typeface options"] = "주문명 서체 설정"
--[[ koKR ]] nL["Font"] = "글꼴"
--[[ koKR ]] nL["Sets the font for spell name"] = "주문명의 글꼴을 설정합니다."
--[[ koKR ]] nL["Font Size"] = "글꼴 크기"
--[[ koKR ]] nL["Sets the font height of the spell name"] = "주문명 글자의 높이를 설정합니다."
--[[ koKR ]] nL["Font Shadow"] = "글꼴 그림자"
--[[ koKR ]] nL["Show font shadow on spell name"] = "주문명에 그림자를 표시합니다."
--[[ koKR ]] nL["Alignment"] = "정렬"
--[[ koKR ]] nL["Sets the alignment of the spell name"] = "주문명의 정렬을 설정합니다."
--[[ koKR ]] nL["Outline"] = "테두리"
--[[ koKR ]] nL["Sets the font outline for spell name"] = "주문명의 테두리를 설정합니다."
--[[ koKR ]] nL["Position"] = "위치"
--[[ koKR ]] nL["Adjust spell name position"] = "주문명 위치 조절"
--[[ koKR ]] nL["Left Offset"] = "좌측 좌표"
--[[ koKR ]] nL["Sets the offset of the left of the text"] = "글자의 좌측 좌표를 설정합니다."
--[[ koKR ]] nL["Right Offset"] = "우측 좌표"
--[[ koKR ]] nL["Sets the offset of the right of the text"] = "글자의 우측 좌표를 설정합니다."
--[[ koKR ]] nL["Vertical Offset"] = "수직 좌표"
--[[ koKR ]] nL["Sets the vertical offset of the text"] = "글자의 수직 좌표를 설정합니다."
--[[ koKR ]] nL["Color"] = "색상"
--[[ koKR ]] nL["Sets the spell name color"] = "주문명의 색상을 설정합니다."

--[[ koKR ]] nL["None"] = "없음"
--[[ koKR ]] nL["Normal"] = "기본"
--[[ koKR ]] nL["Thick"] = "굵게"

--[[ koKR ]] nL["LEFT"] = "좌측"
--[[ koKR ]] nL["CENTER"] = "가운데"
--[[ koKR ]] nL["RIGHT"] = "우측"

-----------------------------------------------------------------------------

--[[ koKR ]] tL["Time Text"] = "시전 시간"
--[[ koKR ]] tL["Crowd control bar time text options"] = "Crowd control bar time text options"
--[[ koKR ]] tL["Enable"] = "사용"
--[[ koKR ]] tL["Show crowd control bar time text"] = "Show crowd control bar time text"
--[[ koKR ]] tL["Typeface"] = "서체"
--[[ koKR ]] tL["Crowd control bar time text typeface options"] = "Crowd control bar time text typeface options"
--[[ koKR ]] tL["Font"] = "글꼴"
--[[ koKR ]] tL["Sets the font for crowd control bar time text"] = "Sets the font for crowd control bar time text"
--[[ koKR ]] tL["Font Size"] = "글꼴 크기"
--[[ koKR ]] tL["Sets the font height of the crowd control bar time text"] = "Sets the font height of the crowd control bar time text"
--[[ koKR ]] tL["Font Shadow"] = "글꼴 그림자"
--[[ koKR ]] tL["Show font shadow on crowd control bar time text"] = "Show font shadow on crowd control bar time text"
--[[ koKR ]] tL["Alignment"] = "정렬"
--[[ koKR ]] tL["Sets the alignment of the crowd control bar time text"] = "Sets the alignment of the crowd control bar time text"
--[[ koKR ]] tL["Outline"] = "테두리"
--[[ koKR ]] tL["Sets the font outline for crowd control bar time text"] = "Sets the font outline for crowd control bar time text"
--[[ koKR ]] tL["Position"] = "위치"
--[[ koKR ]] tL["Adjust crowd control bar time text position"] = "Adjust crowd control bar time text position"
--[[ koKR ]] tL["Left Offset"] = "좌측 좌표"
--[[ koKR ]] tL["Sets the offset of the left of the text"] = "시전 시간의 좌측 좌표를 설정합니다."
--[[ koKR ]] tL["Right Offset"] = "우측 좌표"
--[[ koKR ]] tL["Sets the offset of the right of the text"] = "시전 시간의 우측 좌표를 설정합니다."
--[[ koKR ]] tL["Vertical Offset"] = "수직 좌표"
--[[ koKR ]] tL["Sets the vertical offset of the text"] = "시전 시간의 수직 좌표를 설정합니다."
--[[ koKR ]] tL["Color"] = "색상"
--[[ koKR ]] tL["Sets the crowd control bar time text color"] = "Sets the crowd control bar time text color"

--[[ koKR ]] tL["None"] = "없음"
--[[ koKR ]] tL["Normal"] = "기본"
--[[ koKR ]] tL["Thick"] = "굵게"

--[[ koKR ]] tL["LEFT"] = "좌측"
--[[ koKR ]] tL["CENTER"] = "가운데"
--[[ koKR ]] tL["RIGHT"] = "우측"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftCrowdControl"] = "AloftCrowdControl"
--[[ koKR ]] mL["Display crowd control timers on nameplates when possible"] = "Display crowd control timers on nameplates when possible"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] bL["Crowd Control"] = "Контроль"
--[[ ruRU ]] bL["Crowd control options"] = "Опции контроля"

--[[ ruRU ]] bL["Enable"] = "Включить"
--[[ ruRU ]] bL["Shows crowd control timers on nameplates when possible"] = "Отображать таймеры кантроля на табличках если это возможно"
--[[ ruRU ]] bL["Speculative Attach"] = "Рискованное прикрепление"
--[[ ruRU ]] bL["Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"] = "Пытаться прикрепить полосу таймера контроля, когда не известно, что это правильная табличка"
--[[ ruRU ]] bL["Texture"] = "Текстура"
--[[ ruRU ]] bL["Sets the crowd control bar texture"] = "Задает текстуру полоски контроля"

--[[ ruRU ]] bL["Border"] = "Края"
--[[ ruRU ]] bL["Border options"] = "Настройки краев"
--[[ ruRU ]] bL["Target Only"] = "Только цель"
--[[ ruRU ]] bL["Enables the border on the current target only"] = "Включить края только для текущей цели"
--[[ ruRU ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ ruRU ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ ruRU ]] bL["Border Inset"] = "Border Inset"
--[[ ruRU ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ ruRU ]] bL["Border Color"] = "Цвет рамки"
--[[ ruRU ]] bL["Sets the border color of the crowd control bar"] = "Задает цвет рамки полосы контроля"
--[[ ruRU ]] bL["Border Style"] = "Стиль рамки"
--[[ ruRU ]] bL["Sets the style of the crowd control bar border"] = "Задает стиль рамки полосы контроля"

--[[ ruRU ]] bL["Colors"] = "Цвета"
--[[ ruRU ]] bL["Color options"] = "Настройка цвета"
--[[ ruRU ]] bL["Bar Color"] = "Цвет полоски"
--[[ ruRU ]] bL["Sets the crowd control bar color"] = "Задает цвет полоски контроля"
--[[ ruRU ]] bL["Backdrop Color"] = "Цвет тени"
--[[ ruRU ]] bL["Sets the crowd control backdrop color"] = "Задает цвет тени полоски контроля"

--[[ ruRU ]] bL["Height"] = "Высота"
--[[ ruRU ]] bL["Sets the height of the crowd control bar"] = "Задает высоту полоски контроляr"

--[[ ruRU ]] bL["Position"] = "Позиция"
--[[ ruRU ]] bL["Adjust the crowd control bar's position"] = "Задать место полоски контроля"
--[[ ruRU ]] bL["Left Offset"] = "Смещение влево"
--[[ ruRU ]] bL["Sets the offset of the left of the crowd control bar"] = "Смещение полоски контроля влево"
--[[ ruRU ]] bL["Right Offset"] = "Смещение вправо"
--[[ ruRU ]] bL["Sets the offset of the right of the crowd control bar"] = "Смещение полоски контроля вправо"
--[[ ruRU ]] bL["Vertical Offset"] = "Смещение по вертикале"
--[[ ruRU ]] bL["Sets the vertical offset of the crowd control bar"] = "Смещение полоски контроля по вертикале"

--[[ ruRU ]] bL["TOPLEFT"] = "ВВЕРХУ-СЛЕВА"
--[[ ruRU ]] bL["TOP"] = "ВВЕРХУ"
--[[ ruRU ]] bL["TOPRIGHT"] = "ВВЕРХУ-СПРАВА"
--[[ ruRU ]] bL["LEFT"] = "СЛЕВА"
--[[ ruRU ]] bL["CENTER"] = "ПО ЦЕНТРУ"
--[[ ruRU ]] bL["RIGHT"] = "СПРАВА"
--[[ ruRU ]] bL["BOTTOMLEFT"] = "СНИЗУ-СЛЕВА"
--[[ ruRU ]] bL["BOTTOM"] = "СНИЗУ"
--[[ ruRU ]] bL["BOTTOMRIGHT"] = "СНИЗУ-СПРАВА"

-----------------------------------------------------------------------------

--[[ ruRU ]] iL["Spell Icon"] = "Значок заклинания"
--[[ ruRU ]] iL["Crowd control spell icon placement options"] = "Настройка размещения иконки заклинания контроля"
--[[ ruRU ]] iL["Enable"] = "Включить"
--[[ ruRU ]] iL["Enable crowd control spell icon display on the nameplate"] = "Включить отображение иконки заклинания контроля на табличке"
--[[ ruRU ]] iL["Position"] = "Позиция"
--[[ ruRU ]] iL["Adjust crowd control spell icon position"] = "Регулировка размещения иконки заклинания контроля"
--[[ ruRU ]] iL["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] iL["Sets the anchor for the crowd control spell icon"] = "Установка точки прикрепления иконки заклинания контроля"
--[[ ruRU ]] iL["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] iL["Sets the relative point on the crowd control bar to anchor the spell icon"] = "Задает точку для положения полосы контроля относительно иконки заклинания"
--[[ ruRU ]] iL["Size"] = "Размер"
--[[ ruRU ]] iL["Size in pixels of the crowd control spell icon"] = "Размер иконки заклинания контроля в пикселях"
--[[ ruRU ]] iL["X Offset"] = "Смещение по X"
--[[ ruRU ]] iL["X offset of the crowd control spell icon"] = "Смещение иконки заклинания контроля по X"
--[[ ruRU ]] iL["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] iL["Y offset of the crowd control spell icon"] = "Смещение иконки заклинания контроля по Y"

--[[ ruRU ]] iL["TOPLEFT"] = "ВВЕРХУ-СЛЕВА"
--[[ ruRU ]] iL["TOP"] = "ВВЕРХУ"
--[[ ruRU ]] iL["TOPRIGHT"] = "ВВЕРХУ-СПРАВА"
--[[ ruRU ]] iL["LEFT"] = "СЛЕВА"
--[[ ruRU ]] iL["CENTER"] = "ПО ЦЕНТРУ"
--[[ ruRU ]] iL["RIGHT"] = "СПРАВА"
--[[ ruRU ]] iL["BOTTOMLEFT"] = "СНИЗУ-СЛЕВА"
--[[ ruRU ]] iL["BOTTOM"] = "СНИЗУ"
--[[ ruRU ]] iL["BOTTOMRIGHT"] = "СНИЗУ-СПРАВА"

-----------------------------------------------------------------------------

--[[ ruRU ]] nL["Spell Name"] = "Заклинание"
--[[ ruRU ]] nL["Crowd control bar spell name text options"] = "Настройка текста заклинания полосы контроля"
--[[ ruRU ]] nL["Enable"] = "Включить"
--[[ ruRU ]] nL["Show spell name on crowd control bar"] = "Отображать  название заклинания в полосе контроля"
--[[ ruRU ]] nL["Typeface"] = "Шрифт"
--[[ ruRU ]] nL["Spell name typeface options"] = "Настройки шрифта названия заклинаний"
--[[ ruRU ]] nL["Font"] = "Шрифт"
--[[ ruRU ]] nL["Sets the font for spell name"] = "Задает шрифт для названия заклинания"
--[[ ruRU ]] nL["Font Size"] = "Размер шрифта"
--[[ ruRU ]] nL["Sets the font height of the spell name"] = "Задает высоту шрифта для названия заклинания"
--[[ ruRU ]] nL["Font Shadow"] = "Тень шрифта"
--[[ ruRU ]] nL["Show font shadow on spell name"] = "Отображать тень для названия заклинания"
--[[ ruRU ]] nL["Alignment"] = "Выравнивание"
--[[ ruRU ]] nL["Sets the alignment of the spell name"] = "Задает выравнивание названия заклинания"
--[[ ruRU ]] nL["Outline"] = "Контур"
--[[ ruRU ]] nL["Sets the font outline for spell name"] = "Задает окантовку для названия заклинания"
--[[ ruRU ]] nL["Position"] = "Позиция"
--[[ ruRU ]] nL["Adjust spell name position"] = "Задать место названия заклинания"
--[[ ruRU ]] nL["Left Offset"] = "Смещение влево"
--[[ ruRU ]] nL["Sets the offset of the left of the text"] = "Смещение текста влево"
--[[ ruRU ]] nL["Right Offset"] = "Смещение вправо"
--[[ ruRU ]] nL["Sets the offset of the right of the text"] = "Смещение текста вправо"
--[[ ruRU ]] nL["Vertical Offset"] = "Смещение по вертикале"
--[[ ruRU ]] nL["Sets the vertical offset of the text"] = "Смещение текста по вертикале"
--[[ ruRU ]] nL["Color"] = "Цвет"
--[[ ruRU ]] nL["Sets the spell name color"] = "Задает цвет названия заклинания"

--[[ ruRU ]] nL["None"] = "Нет"
--[[ ruRU ]] nL["Normal"] = "Обычно"
--[[ ruRU ]] nL["Thick"] = "Жирный"

--[[ ruRU ]] nL["LEFT"] = "СЛЕВА"
--[[ ruRU ]] nL["CENTER"] = "ПО ЦЕНТРУ"
--[[ ruRU ]] nL["RIGHT"] = "СПРАВА"

-----------------------------------------------------------------------------

--[[ ruRU ]] tL["Time Text"] = "Текст времени"
--[[ ruRU ]] tL["Crowd control bar time text options"] = "Настройки текста времени полосы контроля"
--[[ ruRU ]] tL["Enable"] = "Включить"
--[[ ruRU ]] tL["Show crowd control bar time text"] = "Отображать текст времени в полосе контроля"
--[[ ruRU ]] tL["Typeface"] = "Шрифт"
--[[ ruRU ]] tL["Crowd control bar time text typeface options"] = "Настройка шрифта текста времени полосы контроля"
--[[ ruRU ]] tL["Font"] = "Шрифт"
--[[ ruRU ]] tL["Sets the font for crowd control bar time text"] = "Установка шрифта времени полосы контроля"
--[[ ruRU ]] tL["Font Size"] = "Размер шрифта"
--[[ ruRU ]] tL["Sets the font height of the crowd control bar time text"] = "Установка размера шрифта текста времени полосы контроля"
--[[ ruRU ]] tL["Font Shadow"] = "Тень шрифта"
--[[ ruRU ]] tL["Show font shadow on crowd control bar time text"] = "Отображать тень шрифта текста времени полосы контроля"
--[[ ruRU ]] tL["Alignment"] = "Выравнивание"
--[[ ruRU ]] tL["Sets the alignment of the crowd control bar time text"] = "Выравнивание текста времени полосы контроля"
--[[ ruRU ]] tL["Outline"] = "Контур"
--[[ ruRU ]] tL["Sets the font outline for crowd control bar time text"] = "Установка контура текста времени полосы контроля"
--[[ ruRU ]] tL["Position"] = "Позиция"
--[[ ruRU ]] tL["Adjust crowd control bar time text position"] = "Регулировка расположения текста времени полосы контроля"
--[[ ruRU ]] tL["Left Offset"] = "Смещение влево"
--[[ ruRU ]] tL["Sets the offset of the left of the text"] = "Смещение текста влево"
--[[ ruRU ]] tL["Right Offset"] = "Смещение вправо"
--[[ ruRU ]] tL["Sets the offset of the right of the text"] = "ЗСмещение текста вправо"
--[[ ruRU ]] tL["Vertical Offset"] = "Смещение по вертикале"
--[[ ruRU ]] tL["Sets the vertical offset of the text"] = "Смещение текста по вертикале"
--[[ ruRU ]] tL["Color"] = "Цвет"
--[[ ruRU ]] tL["Sets the crowd control bar time text color"] = "Установка цвета текста времени полосы контроля"

--[[ ruRU ]] tL["None"] = "Нет"
--[[ ruRU ]] tL["Normal"] = "Обычно"
--[[ ruRU ]] tL["Thick"] = "Жирный"

--[[ ruRU ]] tL["LEFT"] = "СЛЕВА"
--[[ ruRU ]] tL["CENTER"] = "ПО ЦЕНТРУ"
--[[ ruRU ]] tL["RIGHT"] = "СПРАВА"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftCrowdControl"] = "AloftCrowdControl"
--[[ ruRU ]] mL["Display crowd control timers on nameplates when possible"] = "Если это возможно, отображает таймеры контроля"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] bL["Crowd Control"] = "Crowd Control"
--[[ zhCN ]] bL["Crowd control options"] = "Crowd control options"

--[[ zhCN ]] bL["Enable"] = "启用"
--[[ zhCN ]] bL["Shows crowd control timers on nameplates when possible"] = "Shows crowd control timers on nameplates when possible"
--[[ zhCN ]] bL["Speculative Attach"] = "推理依附"
--[[ zhCN ]] bL["Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"] = "Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"
--[[ zhCN ]] bL["Texture"] = "材质"
--[[ zhCN ]] bL["Sets the crowd control bar texture"] = "Sets the crowd control bar texture"

--[[ zhCN ]] bL["Border"] = "Border"
--[[ zhCN ]] bL["Border options"] = "Border options"
--[[ zhCN ]] bL["Target Only"] = "Target Only"
--[[ zhCN ]] bL["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ zhCN ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ zhCN ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ zhCN ]] bL["Border Inset"] = "Border Inset"
--[[ zhCN ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ zhCN ]] bL["Border Color"] = "边框颜色"
--[[ zhCN ]] bL["Sets the border color of the crowd control bar"] = "Sets the border color of the crowd control bar"
--[[ zhCN ]] bL["Border Style"] = "边框样式"
--[[ zhCN ]] bL["Sets the style of the crowd control bar border"] = "Sets the style of the crowd control bar border"

--[[ zhCN ]] bL["Colors"] = "颜色"
--[[ zhCN ]] bL["Color options"] = "颜色设置"
--[[ zhCN ]] bL["Bar Color"] = "计时条颜色"
--[[ zhCN ]] bL["Sets the crowd control bar color"] = "Sets the crowd control bar color"
--[[ zhCN ]] bL["Backdrop Color"] = "背景颜色"
--[[ zhCN ]] bL["Sets the crowd control backdrop color"] = "Sets the crowd control backdrop color"

--[[ zhCN ]] bL["Height"] = "高度"
--[[ zhCN ]] bL["Sets the height of the crowd control bar"] = "Sets the height of the crowd control bar"

--[[ zhCN ]] bL["Position"] = "位置"
--[[ zhCN ]] bL["Adjust the crowd control bar's position"] = "Adjust the crowd control bar's position"
--[[ zhCN ]] bL["Left Offset"] = "向左偏移"
--[[ zhCN ]] bL["Sets the offset of the left of the crowd control bar"] = "Sets the offset of the left of the crowd control bar"
--[[ zhCN ]] bL["Right Offset"] = "向右偏移"
--[[ zhCN ]] bL["Sets the offset of the right of the crowd control bar"] = "Sets the offset of the right of the crowd control bar"
--[[ zhCN ]] bL["Vertical Offset"] = "垂直偏移"
--[[ zhCN ]] bL["Sets the vertical offset of the crowd control bar"] = "Sets the vertical offset of the crowd control bar"

--[[ zhCN ]] bL["TOPLEFT"] = "左上"
--[[ zhCN ]] bL["TOP"] = "上"
--[[ zhCN ]] bL["TOPRIGHT"] = "右上"
--[[ zhCN ]] bL["LEFT"] = "左"
--[[ zhCN ]] bL["CENTER"] = "中"
--[[ zhCN ]] bL["RIGHT"] = "右"
--[[ zhCN ]] bL["BOTTOMLEFT"] = "左下"
--[[ zhCN ]] bL["BOTTOM"] = "下"
--[[ zhCN ]] bL["BOTTOMRIGHT"] = "右下"

-----------------------------------------------------------------------------

--[[ zhCN ]] iL["Spell Icon"] = "法术图标"
--[[ zhCN ]] iL["Crowd control spell icon placement options"] = "Crowd control spell icon placement options"
--[[ zhCN ]] iL["Enable"] = "启用"
--[[ zhCN ]] iL["Enable crowd control spell icon display on the nameplate"] = "Enable crowd control spell icon display on the nameplate"
--[[ zhCN ]] iL["Position"] = "位置"
--[[ zhCN ]] iL["Adjust crowd control spell icon position"] = "Adjust crowd control spell icon position"
--[[ zhCN ]] iL["Anchor"] = "锚点"
--[[ zhCN ]] iL["Sets the anchor for the crowd control spell icon"] = "Sets the anchor for the crowd control spell icon"
--[[ zhCN ]] iL["Anchor To"] = "固定在"
--[[ zhCN ]] iL["Sets the relative point on the crowd control bar to anchor the spell icon"] = "Sets the relative point on the crowd control bar to anchor the spell icon"
--[[ zhCN ]] iL["Size"] = "尺寸"
--[[ zhCN ]] iL["Size in pixels of the crowd control spell icon"] = "Size in pixels of the crowd control spell icon"
--[[ zhCN ]] iL["X Offset"] = "X轴偏移"
--[[ zhCN ]] iL["X offset of the crowd control spell icon"] = "X offset of the crowd control spell icon"
--[[ zhCN ]] iL["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] iL["Y offset of the crowd control spell icon"] = "Y offset of the crowd control spell icon"

--[[ zhCN ]] iL["TOPLEFT"] = "左上"
--[[ zhCN ]] iL["TOP"] = "上"
--[[ zhCN ]] iL["TOPRIGHT"] = "右上"
--[[ zhCN ]] iL["LEFT"] = "左"
--[[ zhCN ]] iL["CENTER"] = "中"
--[[ zhCN ]] iL["RIGHT"] = "右"
--[[ zhCN ]] iL["BOTTOMLEFT"] = "左下"
--[[ zhCN ]] iL["BOTTOM"] = "下"
--[[ zhCN ]] iL["BOTTOMRIGHT"] = "右下"

-----------------------------------------------------------------------------

--[[ zhCN ]] nL["Spell Name"] = "法术名称"
--[[ zhCN ]] nL["Crowd control bar spell name text options"] = "Crowd control bar spell name text options"
--[[ zhCN ]] nL["Enable"] = "启用"
--[[ zhCN ]] nL["Show spell name on crowd control bar"] = "Show spell name on crowd control bar"
--[[ zhCN ]] nL["Typeface"] = "字体"
--[[ zhCN ]] nL["Spell name typeface options"] = "法术名称文字式样设置"
--[[ zhCN ]] nL["Font"] = "字体"
--[[ zhCN ]] nL["Sets the font for spell name"] = "设定法术名称文字的字体"
--[[ zhCN ]] nL["Font Size"] = "字号"
--[[ zhCN ]] nL["Sets the font height of the spell name"] = "设定法术名称文字的字号"
--[[ zhCN ]] nL["Font Shadow"] = "字体阴影"
--[[ zhCN ]] nL["Show font shadow on spell name"] = "设定法术名称文字的字体阴影"
--[[ zhCN ]] nL["Alignment"] = "对齐"
--[[ zhCN ]] nL["Sets the alignment of the spell name"] = "设定法术名称文字的字体的对齐方式"
--[[ zhCN ]] nL["Outline"] = "轮廓"
--[[ zhCN ]] nL["Sets the font outline for spell name"] = "设定法术名称文字的字体轮廓"
--[[ zhCN ]] nL["Position"] = "位置"
--[[ zhCN ]] nL["Adjust spell name position"] = "调整法术名称文字的位置"
--[[ zhCN ]] nL["Left Offset"] = "向左偏移"
--[[ zhCN ]] nL["Sets the offset of the left of the text"] = "设定法术名称文字的向左偏移量"
--[[ zhCN ]] nL["Right Offset"] = "向右偏移"
--[[ zhCN ]] nL["Sets the offset of the right of the text"] = "设定法术名称文字的向右偏移量"
--[[ zhCN ]] nL["Vertical Offset"] = "垂直位移"
--[[ zhCN ]] nL["Sets the vertical offset of the text"] = "设定法术名称文字的垂直偏移量"
--[[ zhCN ]] nL["Color"] = "颜色"
--[[ zhCN ]] nL["Sets the spell name color"] = "设定法术名称文字的颜色"

--[[ zhCN ]] nL["None"] = "无"
--[[ zhCN ]] nL["Normal"] = "正常"
--[[ zhCN ]] nL["Thick"] = "粗"

--[[ zhCN ]] nL["LEFT"] = "左"
--[[ zhCN ]] nL["CENTER"] = "中"
--[[ zhCN ]] nL["RIGHT"] = "右"

-----------------------------------------------------------------------------

--[[ zhCN ]] tL["Time Text"] = "计时文字"
--[[ zhCN ]] tL["Crowd control bar time text options"] = "Crowd control bar time text options"
--[[ zhCN ]] tL["Enable"] = "启用"
--[[ zhCN ]] tL["Show crowd control bar time text"] = "Show crowd control bar time text"
--[[ zhCN ]] tL["Typeface"] = "式样"
--[[ zhCN ]] tL["Crowd control bar time text typeface options"] = "Crowd control bar time text typeface options"
--[[ zhCN ]] tL["Font"] = "字体"
--[[ zhCN ]] tL["Sets the font for crowd control bar time text"] = "Sets the font for crowd control bar time text"
--[[ zhCN ]] tL["Font Size"] = "字号"
--[[ zhCN ]] tL["Sets the font height of the crowd control bar time text"] = "Sets the font height of the crowd control bar time text"
--[[ zhCN ]] tL["Font Shadow"] = "字体阴影"
--[[ zhCN ]] tL["Show font shadow on crowd control bar time text"] = "Show font shadow on crowd control bar time text"
--[[ zhCN ]] tL["Alignment"] = "对齐"
--[[ zhCN ]] tL["Sets the alignment of the crowd control bar time text"] = "Sets the alignment of the crowd control bar time text"
--[[ zhCN ]] tL["Outline"] = "轮廓"
--[[ zhCN ]] tL["Sets the font outline for crowd control bar time text"] = "Sets the font outline for crowd control bar time text"
--[[ zhCN ]] tL["Position"] = "位置"
--[[ zhCN ]] tL["Adjust crowd control bar time text position"] = "Adjust crowd control bar time text position"
--[[ zhCN ]] tL["Left Offset"] = "向左偏移"
--[[ zhCN ]] tL["Sets the offset of the left of the text"] = "设定文字的向左偏移量"
--[[ zhCN ]] tL["Right Offset"] = "向右偏移"
--[[ zhCN ]] tL["Sets the offset of the right of the text"] = "设定文字的向右偏移量"
--[[ zhCN ]] tL["Vertical Offset"] = "垂直偏移"
--[[ zhCN ]] tL["Sets the vertical offset of the text"] = "设定文字的垂直偏移量"
--[[ zhCN ]] tL["Color"] = "颜色"
--[[ zhCN ]] tL["Sets the crowd control bar time text color"] = "Sets the crowd control bar time text color"

--[[ zhCN ]] tL["None"] = "无"
--[[ zhCN ]] tL["Normal"] = "正常"
--[[ zhCN ]] tL["Thick"] = "粗"

--[[ zhCN ]] tL["LEFT"] = "左"
--[[ zhCN ]] tL["CENTER"] = "中"
--[[ zhCN ]] tL["RIGHT"] = "右"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftCrowdControl"] = "控场效果"
--[[ zhCN ]] mL["Display crowd control timers on nameplates when possible"] = "可能的情况在姓名板上显示控场效果计时器"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] bL["Crowd Control"] = "群體控制"
--[[ zhTW ]] bL["Crowd control options"] = "群體控制設定"

--[[ zhTW ]] bL["Enable"] = "啟用"
--[[ zhTW ]] bL["Shows crowd control timers on nameplates when possible"] = "可以的話在名牌上顯示群體控制時間"
--[[ zhTW ]] bL["Speculative Attach"] = "推理依附"
--[[ zhTW ]] bL["Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"] = "如果是群體名牌，企圖附加群體控制時間條當並不完全可靠"
--[[ zhTW ]] bL["Texture"] = "材質"
--[[ zhTW ]] bL["Sets the crowd control bar texture"] = "設定群體控制條材質"

--[[ zhTW ]] bL["Border"] = "邊框"
--[[ zhTW ]] bL["Border options"] = "邊框設定"
--[[ zhTW ]] bL["Target Only"] = "只在目標"
--[[ zhTW ]] bL["Enables the border on the current target only"] = "啟用只在目前目標上的邊框"
--[[ zhTW ]] bL["Border Edge Size"] = "邊框邊緣大小"
--[[ zhTW ]] bL["Sets the thickness of the border"] = "設定邊框的厚度"
--[[ zhTW ]] bL["Border Inset"] = "邊框崁入"
--[[ zhTW ]] bL["Sets the padding aroundthe border"] = "設定邊框的間距範圍"
--[[ zhTW ]] bL["Border Color"] = "邊框顏色"
--[[ zhTW ]] bL["Sets the border color of the crowd control bar"] = "設定群體控制條的邊框顏色"
--[[ zhTW ]] bL["Border Style"] = "邊框樣式"
--[[ zhTW ]] bL["Sets the style of the crowd control bar border"] = "設定群體控制條的樣式"

--[[ zhTW ]] bL["Colors"] = "顏色"
--[[ zhTW ]] bL["Color options"] = "顏色設定"
--[[ zhTW ]] bL["Bar Color"] = "條顏色"
--[[ zhTW ]] bL["Sets the crowd control bar color"] = "設定群體控制條顏色"
--[[ zhTW ]] bL["Backdrop Color"] = "背景顏色"
--[[ zhTW ]] bL["Sets the crowd control backdrop color"] = "設定群體控制背景顏色"

--[[ zhTW ]] bL["Height"] = "高度"
--[[ zhTW ]] bL["Sets the height of the crowd control bar"] = "設定群體控制條高度"

--[[ zhTW ]] bL["Position"] = "位置"
--[[ zhTW ]] bL["Adjust the crowd control bar's position"] = "調整群體控制條的位置"
--[[ zhTW ]] bL["Left Offset"] = "左偏移"
--[[ zhTW ]] bL["Sets the offset of the left of the crowd control bar"] = "設定群體控制條的左偏移"
--[[ zhTW ]] bL["Right Offset"] = "右偏移"
--[[ zhTW ]] bL["Sets the offset of the right of the crowd control bar"] = "設定群體控制條的右偏移"
--[[ zhTW ]] bL["Vertical Offset"] = "垂直偏移"
--[[ zhTW ]] bL["Sets the vertical offset of the crowd control bar"] = "設定群體控制條的垂直偏移"

--[[ zhTW ]] bL["TOPLEFT"] = "上左"
--[[ zhTW ]] bL["TOP"] = "上"
--[[ zhTW ]] bL["TOPRIGHT"] = "上右"
--[[ zhTW ]] bL["LEFT"] = "左"
--[[ zhTW ]] bL["CENTER"] = "中"
--[[ zhTW ]] bL["RIGHT"] = "右"
--[[ zhTW ]] bL["BOTTOMLEFT"] = "下左"
--[[ zhTW ]] bL["BOTTOM"] = "下"
--[[ zhTW ]] bL["BOTTOMRIGHT"] = "下右"

-----------------------------------------------------------------------------

--[[ zhTW ]] iL["Spell Icon"] = "法術圖示"
--[[ zhTW ]] iL["Crowd control spell icon placement options"] = "群體控制法術圖示佈局設定"
--[[ zhTW ]] iL["Enable"] = "啟用"
--[[ zhTW ]] iL["Enable crowd control spell icon display on the nameplate"] = "啟用在名牌上的群體控制法術圖示顯示"
--[[ zhTW ]] iL["Position"] = "位置"
--[[ zhTW ]] iL["Adjust crowd control spell icon position"] = "群體控制法術圖示位置"
--[[ zhTW ]] iL["Anchor"] = "錨點"
--[[ zhTW ]] iL["Sets the anchor for the crowd control spell icon"] = "設定群體控制法術圖示的錨點"
--[[ zhTW ]] iL["Anchor To"] = "錨點在"
--[[ zhTW ]] iL["Sets the relative point on the crowd control bar to anchor the spell icon"] = "設定在群體控制條上錨到法術圖示的相關點"
--[[ zhTW ]] iL["Size"] = "大小"
--[[ zhTW ]] iL["Size in pixels of the crowd control spell icon"] = "群體控制法術圖示的像素大小"
--[[ zhTW ]] iL["X Offset"] = "X偏移"
--[[ zhTW ]] iL["X offset of the crowd control spell icon"] = "群體控制法術圖示的X偏移"
--[[ zhTW ]] iL["Y Offset"] = "Y偏移"
--[[ zhTW ]] iL["Y offset of the crowd control spell icon"] = "群體控制法術圖示的Y偏移"

--[[ zhTW ]] iL["TOPLEFT"] = "上左"
--[[ zhTW ]] iL["TOP"] = "上"
--[[ zhTW ]] iL["TOPRIGHT"] = "上右"
--[[ zhTW ]] iL["LEFT"] = "左"
--[[ zhTW ]] iL["CENTER"] = "中"
--[[ zhTW ]] iL["RIGHT"] = "右"
--[[ zhTW ]] iL["BOTTOMLEFT"] = "下左"
--[[ zhTW ]] iL["BOTTOM"] = "下"
--[[ zhTW ]] iL["BOTTOMRIGHT"] = "下右"

-----------------------------------------------------------------------------

--[[ zhTW ]] nL["Spell Name"] = "法術名稱"
--[[ zhTW ]] nL["Crowd control bar spell name text options"] = "群體控制條法術名稱文字設定"
--[[ zhTW ]] nL["Enable"] = "啟用"
--[[ zhTW ]] nL["Show spell name on crowd control bar"] = "顯示在群體控制條上的法術名稱"
--[[ zhTW ]] nL["Typeface"] = "字體"
--[[ zhTW ]] nL["Spell name typeface options"] = "法術名稱字體設定"
--[[ zhTW ]] nL["Font"] = "字型"
--[[ zhTW ]] nL["Sets the font for spell name"] = "設定法術名稱的字型"
--[[ zhTW ]] nL["Font Size"] = "字型大小"
--[[ zhTW ]] nL["Sets the font height of the spell name"] = "設定法術名稱的字型大小"
--[[ zhTW ]] nL["Font Shadow"] = "字型陰影"
--[[ zhTW ]] nL["Show font shadow on spell name"] = "設定法術名稱的字型陰影"
--[[ zhTW ]] nL["Alignment"] = "對齊"
--[[ zhTW ]] nL["Sets the alignment of the spell name"] = "設定法術名稱的對齊"
--[[ zhTW ]] nL["Outline"] = "輪廓"
--[[ zhTW ]] nL["Sets the font outline for spell name"] = "設定法術名稱的字型輪廓"
--[[ zhTW ]] nL["Position"] = "位置"
--[[ zhTW ]] nL["Adjust spell name position"] = "調整法術名稱位置"
--[[ zhTW ]] nL["Left Offset"] = "左偏移"
--[[ zhTW ]] nL["Sets the offset of the left of the text"] = "設定文字的左偏移"
--[[ zhTW ]] nL["Right Offset"] = "右偏移"
--[[ zhTW ]] nL["Sets the offset of the right of the text"] = "設定文字的右偏移"
--[[ zhTW ]] nL["Vertical Offset"] = "垂直偏移"
--[[ zhTW ]] nL["Sets the vertical offset of the text"] = "設定文字的垂直偏移"
--[[ zhTW ]] nL["Color"] = "顏色"
--[[ zhTW ]] nL["Sets the spell name color"] = "設定法術名稱顏色"

--[[ zhTW ]] nL["None"] = "無"
--[[ zhTW ]] nL["Normal"] = "正常"
--[[ zhTW ]] nL["Thick"] = "粗"

--[[ zhTW ]] nL["LEFT"] = "左"
--[[ zhTW ]] nL["CENTER"] = "中"
--[[ zhTW ]] nL["RIGHT"] = "右"

-----------------------------------------------------------------------------

--[[ zhTW ]] tL["Time Text"] = "時間文字"
--[[ zhTW ]] tL["Crowd control bar time text options"] = "群體控制條時間文字設定"
--[[ zhTW ]] tL["Enable"] = "啟用"
--[[ zhTW ]] tL["Show crowd control bar time text"] = "顯示群體控制條時間文字"
--[[ zhTW ]] tL["Typeface"] = "字體"
--[[ zhTW ]] tL["Crowd control bar time text typeface options"] = "群體控制條文字字體設定"
--[[ zhTW ]] tL["Font"] = "字型"
--[[ zhTW ]] tL["Sets the font for crowd control bar time text"] = "設定群體控制條時間文字的字型"
--[[ zhTW ]] tL["Font Size"] = "字型大小"
--[[ zhTW ]] tL["Sets the font height of the crowd control bar time text"] = "設定群體控制條時間文字的字型高度"
--[[ zhTW ]] tL["Font Shadow"] = "字型陰影"
--[[ zhTW ]] tL["Show font shadow on crowd control bar time text"] = "設定群體控制條時間文字的字型陰影"
--[[ zhTW ]] tL["Alignment"] = "對齊"
--[[ zhTW ]] tL["Sets the alignment of the crowd control bar time text"] = "設定群體控制條時間文字的對齊"
--[[ zhTW ]] tL["Outline"] = "輪廓"
--[[ zhTW ]] tL["Sets the font outline for crowd control bar time text"] = "設定群體控制條時間文字的字型輪廓"
--[[ zhTW ]] tL["Position"] = "位置"
--[[ zhTW ]] tL["Adjust crowd control bar time text position"] = "調整群體控制條時間文字位置"
--[[ zhTW ]] tL["Left Offset"] = "左偏移"
--[[ zhTW ]] tL["Sets the offset of the left of the text"] = "設定文字的左偏移"
--[[ zhTW ]] tL["Right Offset"] = "右偏移"
--[[ zhTW ]] tL["Sets the offset of the right of the text"] = "設定文字的右偏移"
--[[ zhTW ]] tL["Vertical Offset"] = "垂直偏移"
--[[ zhTW ]] tL["Sets the vertical offset of the text"] = "設定文字的垂直偏移"
--[[ zhTW ]] tL["Color"] = "顏色"
--[[ zhTW ]] tL["Sets the crowd control bar time text color"] = "設定群體控制條時間文字顏色"

--[[ zhTW ]] tL["None"] = "無"
--[[ zhTW ]] tL["Normal"] = "正常"
--[[ zhTW ]] tL["Thick"] = "粗"

--[[ zhTW ]] tL["LEFT"] = "左"
--[[ zhTW ]] tL["CENTER"] = "中"
--[[ zhTW ]] tL["RIGHT"] = "右"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftCrowdControl"] = "Aloft群體控制"
--[[ zhTW ]] mL["Display crowd control timers on nameplates when possible"] = "可以的話在名牌上顯示群體控制時間"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

AloftLocale.AloftPolymorphOptions = setmetatable(bL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
bL = nil

AloftLocale.AloftCrowdControlSpellIconOptions = setmetatable(iL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
iL = nil

AloftLocale.AloftCrowdControlSpellNameTextOptions = setmetatable(nL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
nL = nil

AloftLocale.AloftCrowdControlTimeTextOptions = setmetatable(tL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
tL = nil

-----------------------------------------------------------------------------

end)
