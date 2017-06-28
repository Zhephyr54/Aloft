local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

-----------------------------------------------------------------------------

local bL = { }

-----------------------------------------------------------------------------

--[[ enUS ]] bL["Cast Bar"] = "Cast Bar"
--[[ enUS ]] bL["Cast bar options"] = "Cast bar options"
--[[ enUS ]] bL["Enable"] = "Enable"
--[[ enUS ]] bL["Shows the current target's casting bar"] = "Shows the current target's casting bar"
--[[ enUS ]] bL["Position"] = "Position"
--[[ enUS ]] bL["Adjust cast bar position"] = "Adjust cast bar position"
--[[ enUS ]] bL["Left Offset"] = "Left Offset"
--[[ enUS ]] bL["Sets the offset of the left of the cast bar"] = "Sets the offset of the left of the cast bar"
--[[ enUS ]] bL["Right Offset"] = "Right Offset"
--[[ enUS ]] bL["Sets the offset of the right of the cast bar"] = "Sets the offset of the right of the cast bar"
--[[ enUS ]] bL["Vertical Offset"] = "Vertical Offset"
--[[ enUS ]] bL["Sets the vertical offset of the cast bar"] = "Sets the vertical offset of the cast bar"
--[[ enUS ]] bL["Height"] = "Height"
--[[ enUS ]] bL["Sets the height of the cast bar"] = "Sets the height of the cast bar"

--[[ enUS ]] bL["Interruptable Cast Bar"] = "Interruptable Cast Bar"
--[[ enUS ]] bL["Cast bar appearance for interruptable spells"] = "Cast bar appearance for interruptable spells"
--[[ enUS ]] bL["Uninterruptable Cast Bar"] = "Uninterruptable Cast Bar"
--[[ enUS ]] bL["Cast bar appearance for uninterruptable spells"] = "Cast bar appearance for uninterruptable spells"

--[[ enUS ]] bL["Cast Bar Color"] = "Cast Bar Color"
--[[ enUS ]] bL["Sets the color of the cast bar"] = "Sets the color of the cast bar"
--[[ enUS ]] bL["Backdrop Color"] = "Backdrop Color"
--[[ enUS ]] bL["Sets the backdrop color of the cast bar"] = "Sets the backdrop color of the cast bar"
--[[ enUS ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ enUS ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ enUS ]] bL["Border Inset"] = "Border Inset"
--[[ enUS ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ enUS ]] bL["Border Color"] = "Border Color"
--[[ enUS ]] bL["Sets the border color of the cast bar"] = "Sets the border color of the cast bar"
--[[ enUS ]] bL["Border Style"] = "Border Style"
--[[ enUS ]] bL["Sets the style of the cast bar border"] = "Sets the style of the cast bar border"
--[[ enUS ]] bL["Texture"] = "Texture"
--[[ enUS ]] bL["Sets the cast bar texture"] = "Sets the cast bar texture"

--[[ enUS ]] bL["Incremetal"] = "Incremetal"
--[[ enUS ]] bL["Update incrementally; workaround for malformed borders, only relevant when borders are enabled"] = "Update incrementally; workaround for malformed borders, only relevant when borders are enabled"

-----------------------------------------------------------------------------

local iL = { }

-----------------------------------------------------------------------------

--[[ enUS ]] iL["Spell Icon"] = "Spell Icon"
--[[ enUS ]] iL["Spell icon placement options"] = "Spell icon placement options"
--[[ enUS ]] iL["Enable"] = "Enable"
--[[ enUS ]] iL["Enable spell icon display on the nameplate"] = "Enable spell icon display on the nameplate"
--[[ enUS ]] iL["Position"] = "Position"
--[[ enUS ]] iL["Adjust spell icon position"] = "Adjust spell icon position"
--[[ enUS ]] iL["Anchor"] = "Anchor"
--[[ enUS ]] iL["Sets the anchor for the spell icon"] = "Sets the anchor for the spell icon"
--[[ enUS ]] iL["Anchor To"] = "Anchor To"
--[[ enUS ]] iL["Sets the relative point on the cast bar to anchor the spell icon"] = "Sets the relative point on the cast bar to anchor the spell icon"
--[[ enUS ]] iL["Size"] = "Size"
--[[ enUS ]] iL["Size in pixels of the spell icon"] = "Size in pixels of the spell icon"
--[[ enUS ]] iL["X Offset"] = "X Offset"
--[[ enUS ]] iL["X offset of the spell icon"] = "X offset of the spell icon"
--[[ enUS ]] iL["Y Offset"] = "Y Offset"
--[[ enUS ]] iL["Y offset of the spell icon"] = "Y offset of the spell icon"

--[[ enUS ]] iL["Shield"] = "Shield"
--[[ enUS ]] iL["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon"
--[[ enUS ]] iL["Enable"] = "Enable"
--[[ enUS ]] iL["Enables the shield graphic"] = "Enables the shield graphic"
--[[ enUS ]] iL["Style"] = "Style"
--[[ enUS ]] iL["Sets the shield graphic style"] = "Sets the shield graphic style"
--[[ enUS ]] iL["Scale"] = "Scale"
--[[ enUS ]] iL["Scale of the shield graphic"] = "Scale of the shield graphic"
--[[ enUS ]] iL["Color"] = "Color"
--[[ enUS ]] iL["Sets the shield graphic color"] = "Sets the shield graphic color"
--[[ enUS ]] iL["X Offset"] = "X Offset"
--[[ enUS ]] iL["Y Offset"] = "Y Offset"

--[[ enUS ]] iL["SQUARE"] = "SQUARE"
--[[ enUS ]] iL["ROUND"] = "ROUND"

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

local nL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

--[[ enUS ]] nL["Spell Name"] = "Spell Name"
--[[ enUS ]] nL["Cast bar spell name text options"] = "Cast bar spell name text options"
--[[ enUS ]] nL["Enable"] = "Enable"
--[[ enUS ]] nL["Show spell name on cast bar"] = "Show spell name on cast bar"
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

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftCastBarSpellNameText"] = "AloftCastBarSpellNameText"
--[[ enUS ]] mL["Display spell name on cast bar"] = "Display spell name on cast bar"

-----------------------------------------------------------------------------

local tL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

--[[ enUS ]] tL["Time Text"] = "Time Text"
--[[ enUS ]] tL["Cast bar time text options"] = "Cast bar time text options"
--[[ enUS ]] tL["Enable"] = "Enable"
--[[ enUS ]] tL["Show cast bar time text"] = "Show cast bar time text"
--[[ enUS ]] tL["Typeface"] = "Typeface"
--[[ enUS ]] tL["Cast bar time text typeface options"] = "Cast bar time text typeface options"
--[[ enUS ]] tL["Font"] = "Font"
--[[ enUS ]] tL["Sets the font for cast bar time text"] = "Sets the font for cast bar time text"
--[[ enUS ]] tL["Font Size"] = "Font Size"
--[[ enUS ]] tL["Sets the font height of the cast bar time text"] = "Sets the font height of the cast bar time text"
--[[ enUS ]] tL["Font Shadow"] = "Font Shadow"
--[[ enUS ]] tL["Show font shadow on cast bar time text"] = "Show font shadow on cast bar time text"
--[[ enUS ]] tL["Alignment"] = "Alignment"
--[[ enUS ]] tL["Sets the alignment of the cast bar time text"] = "Sets the alignment of the cast bar time text"
--[[ enUS ]] tL["Outline"] = "Outline"
--[[ enUS ]] tL["Sets the font outline for cast bar time text"] = "Sets the font outline for cast bar time text"
--[[ enUS ]] tL["Position"] = "Position"
--[[ enUS ]] tL["Adjust cast bar time text position"] = "Adjust cast bar time text position"
--[[ enUS ]] tL["Left Offset"] = "Left Offset"
--[[ enUS ]] tL["Sets the offset of the left of the text"] = "Sets the offset of the left of the text"
--[[ enUS ]] tL["Right Offset"] = "Right Offset"
--[[ enUS ]] tL["Sets the offset of the right of the text"] = "Sets the offset of the right of the text"
--[[ enUS ]] tL["Vertical Offset"] = "Vertical Offset"
--[[ enUS ]] tL["Sets the vertical offset of the text"] = "Sets the vertical offset of the text"
--[[ enUS ]] tL["Color"] = "Color"
--[[ enUS ]] tL["Sets the cast bar time text color"] = "Sets the cast bar time text color"

--[[ enUS ]] tL["None"] = "None"
--[[ enUS ]] tL["Normal"] = "Normal"
--[[ enUS ]] tL["Thick"] = "Thick"

--[[ enUS ]] tL["LEFT"] = "LEFT"
--[[ enUS ]] tL["CENTER"] = "CENTER"
--[[ enUS ]] tL["RIGHT"] = "RIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftCastBarTimeText"] = "AloftCastBarTimeText"
--[[ enUS ]] mL["Display cast bar time text"] = "Display cast bar time text"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] bL["Cast Bar"] = "시전바"
--[[ koKR ]] bL["Cast bar options"] = "시전바 설정"
--[[ koKR ]] bL["Enable"] = "사용"
--[[ koKR ]] bL["Shows the current target's casting bar"] = "현재 대상의 시전바를 표시합니다."
--[[ koKR ]] bL["Position"] = "위치"
--[[ koKR ]] bL["Adjust cast bar position"] = "시전바 위치 조절"
--[[ koKR ]] bL["Left Offset"] = "좌측 좌표"
--[[ koKR ]] bL["Sets the offset of the left of the cast bar"] = "시전바의 좌측 좌표를 설정합니다."
--[[ koKR ]] bL["Right Offset"] = "우측 좌표"
--[[ koKR ]] bL["Sets the offset of the right of the cast bar"] = "시전바의 우측 좌표를 설정합니다."
--[[ koKR ]] bL["Vertical Offset"] = "수직 좌표"
--[[ koKR ]] bL["Sets the vertical offset of the cast bar"] = "시전바의 수직 좌표를 설정합니다."
--[[ koKR ]] bL["Height"] = "높이"
--[[ koKR ]] bL["Sets the height of the cast bar"] = "시전바의 높이를 설정합니다."

--[[ koKR ]] bL["Interruptable Cast Bar"] = "Interruptable Cast Bar"
--[[ koKR ]] bL["Cast bar appearance for interruptable spells"] = "Cast bar appearance for interruptable spells"
--[[ koKR ]] bL["Uninterruptable Cast Bar"] = "Uninterruptable Cast Bar"
--[[ koKR ]] bL["Cast bar appearance for uninterruptable spells"] = "Cast bar appearance for uninterruptable spells"

--[[ koKR ]] bL["Cast Bar Color"] = "Cast Bar Color"
--[[ koKR ]] bL["Sets the color of the cast bar"] = "Sets the color of the cast bar"
--[[ koKR ]] bL["Backdrop Color"] = "배경 색상"
--[[ koKR ]] bL["Sets the backdrop color of the cast bar"] = "시전바의 배경 색상을 설정합니다."
--[[ koKR ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ koKR ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ koKR ]] bL["Border Inset"] = "Border Inset"
--[[ koKR ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ koKR ]] bL["Border Color"] = "테두리 색상"
--[[ koKR ]] bL["Sets the border color of the cast bar"] = "Sets the border color of the cast bar"
--[[ koKR ]] bL["Border Style"] = "테두리 스타일"
--[[ koKR ]] bL["Sets the style of the cast bar border"] = "Sets the style of the cast bar border"
--[[ koKR ]] bL["Texture"] = "텍스쳐"
--[[ koKR ]] bL["Sets the cast bar texture"] = "시전바의 텍스쳐를 설정합니다."

--[[ koKR ]] bL["Incremetal"] = "Incremetal"
--[[ koKR ]] bL["Update incrementally; workaround for malformed borders, only relevant when borders are enabled"] = "Update incrementally; workaround for malformed borders, only relevant when borders are enabled"

-----------------------------------------------------------------------------

--[[ koKR ]] iL["Spell Icon"] = "주문 아이콘"
--[[ koKR ]] iL["Spell icon placement options"] = "주문 아이콘 배치 설정"
--[[ koKR ]] iL["Enable"] = "사용"
--[[ koKR ]] iL["Enable spell icon display on the nameplate"] = "이름표에 주문 아이콘을 표시합니다."
--[[ koKR ]] iL["Position"] = "위치"
--[[ koKR ]] iL["Adjust spell icon position"] = "주문 아이콘 위치 조절"
--[[ koKR ]] iL["Anchor"] = "앵커"
--[[ koKR ]] iL["Sets the anchor for the spell icon"] = "주문 아이콘의 앵커를 설정합니다."
--[[ koKR ]] iL["Anchor To"] = "앵커 위치"
--[[ koKR ]] iL["Sets the relative point on the cast bar to anchor the spell icon"] = "시전 바에서 주문 아이콘의 앵커 위치를 설정합니다."
--[[ koKR ]] iL["Size"] = "크기"
--[[ koKR ]] iL["Size in pixels of the spell icon"] = "주문 아이콘의 크기입니다."
--[[ koKR ]] iL["X Offset"] = "X 좌표"
--[[ koKR ]] iL["X offset of the spell icon"] = "주문 아이콘의 X 좌표 입니다."
--[[ koKR ]] iL["Y Offset"] = "Y 좌표"
--[[ koKR ]] iL["Y offset of the spell icon"] = "주문 아이콘의 Y 좌표 입니다."

--[[ koKR ]] iL["Shield"] = "Shield"
--[[ koKR ]] iL["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon"
--[[ koKR ]] iL["Enable"] = "Enable"
--[[ koKR ]] iL["Enables the shield graphic"] = "Enables the shield graphic"
--[[ koKR ]] iL["Style"] = "Style"
--[[ koKR ]] iL["Sets the shield graphic style"] = "Sets the shield graphic style"
--[[ koKR ]] iL["Scale"] = "Scale"
--[[ koKR ]] iL["Scale of the shield graphic"] = "Scale of the shield graphic"
--[[ koKR ]] iL["Color"] = "Color"
--[[ koKR ]] iL["Sets the shield graphic color"] = "Sets the shield graphic color"
--[[ koKR ]] iL["X Offset"] = "X 좌표"
--[[ koKR ]] iL["Y Offset"] = "Y 좌표"

--[[ koKR ]] iL["SQUARE"] = "SQUARE"
--[[ koKR ]] iL["ROUND"] = "ROUND"

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

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

--[[ koKR ]] nL["Spell Name"] = "주문명"
--[[ koKR ]] nL["Cast bar spell name text options"] = "시전바 주문명 글자 설정"
--[[ koKR ]] nL["Enable"] = "사용"
--[[ koKR ]] nL["Show spell name on cast bar"] = "시전바에 주문명을 표시합니다."
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

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftCastBarSpellNameText"] = "AloftCastBarSpellNameText"
--[[ koKR ]] mL["Display spell name on cast bar"] = "Display spell name on cast bar"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

--[[ koKR ]] tL["Time Text"] = "시전 시간"
--[[ koKR ]] tL["Cast bar time text options"] = "시전 시간 설정"
--[[ koKR ]] tL["Enable"] = "사용"
--[[ koKR ]] tL["Show cast bar time text"] = "시전바에 시간을 표시합니다."
--[[ koKR ]] tL["Typeface"] = "서체"
--[[ koKR ]] tL["Cast bar time text typeface options"] = "시전 시간 서체 설정"
--[[ koKR ]] tL["Font"] = "글꼴"
--[[ koKR ]] tL["Sets the font for cast bar time text"] = "시전 시간의 글꼴을 설정합니다."
--[[ koKR ]] tL["Font Size"] = "글꼴 크기"
--[[ koKR ]] tL["Sets the font height of the cast bar time text"] = "시전 시간의 높이를 설정합니다."
--[[ koKR ]] tL["Font Shadow"] = "글꼴 그림자"
--[[ koKR ]] tL["Show font shadow on cast bar time text"] = "시전 시간에 그림자를 표시합니다."
--[[ koKR ]] tL["Alignment"] = "정렬"
--[[ koKR ]] tL["Sets the alignment of the cast bar time text"] = "시전 시간의 정렬을 설정합니다."
--[[ koKR ]] tL["Outline"] = "테두리"
--[[ koKR ]] tL["Sets the font outline for cast bar time text"] = "시전 시간의 테두리를 설정합니다."
--[[ koKR ]] tL["Position"] = "위치"
--[[ koKR ]] tL["Adjust cast bar time text position"] = "시전 시간 위치 조절"
--[[ koKR ]] tL["Left Offset"] = "좌측 좌표"
--[[ koKR ]] tL["Sets the offset of the left of the text"] = "시전 시간의 좌측 좌표를 설정합니다."
--[[ koKR ]] tL["Right Offset"] = "우측 좌표"
--[[ koKR ]] tL["Sets the offset of the right of the text"] = "시전 시간의 우측 좌표를 설정합니다."
--[[ koKR ]] tL["Vertical Offset"] = "수직 좌표"
--[[ koKR ]] tL["Sets the vertical offset of the text"] = "시전 시간의 수직 좌표를 설정합니다."
--[[ koKR ]] tL["Color"] = "색상"
--[[ koKR ]] tL["Sets the cast bar time text color"] = "시전 시간의 색상을 설정합니다."

--[[ koKR ]] tL["None"] = "없음"
--[[ koKR ]] tL["Normal"] = "기본"
--[[ koKR ]] tL["Thick"] = "굵게"

--[[ koKR ]] tL["LEFT"] = "좌측"
--[[ koKR ]] tL["CENTER"] = "가운데"
--[[ koKR ]] tL["RIGHT"] = "우측"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftCastBarTimeText"] = "AloftCastBarTimeText"
--[[ koKR ]] mL["Display cast bar time text"] = "Display cast bar time text"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] bL["Cast Bar"] = "Полоска каста"
--[[ ruRU ]] bL["Cast bar options"] = "Настройки полоски заклинания"

--[[ ruRU ]] bL["Enable"] = "Включить"
--[[ ruRU ]] bL["Shows the current target's casting bar"] = "Отображает каст заклинания текущей цели"
--[[ ruRU ]] bL["Position"] = "Позиция"
--[[ ruRU ]] bL["Adjust cast bar position"] = "Задать место полоски заклинания"
--[[ ruRU ]] bL["Left Offset"] = "Смещение влева"
--[[ ruRU ]] bL["Sets the offset of the left of the cast bar"] = "Задает смещение левого конца полоски заклинания"
--[[ ruRU ]] bL["Right Offset"] = "Смещение вправа"
--[[ ruRU ]] bL["Sets the offset of the right of the cast bar"] = "Задает смещение правого конца полоски заклинания"
--[[ ruRU ]] bL["Vertical Offset"] = "Смещение по вертикале"
--[[ ruRU ]] bL["Sets the vertical offset of the cast bar"] = "Задает вертикальное смещение полоски заклинания"
--[[ ruRU ]] bL["Height"] = "Высота"
--[[ ruRU ]] bL["Sets the height of the cast bar"] = "Задает высоту полоски заклинания"

--[[ ruRU ]] bL["Interruptable Cast Bar"] = "Прерываемые заклинания"
--[[ ruRU ]] bL["Cast bar appearance for interruptable spells"] = "Отображение полосы применений для прерываемых заклинаний"
--[[ ruRU ]] bL["Uninterruptable Cast Bar"] = "Непрерываемая заклинания"
--[[ ruRU ]] bL["Cast bar appearance for uninterruptable spells"] = "Отображение полосы применений для непрерываемых заклинаний"

--[[ ruRU ]] bL["Cast Bar Color"] = "Цвет полоски заклинания"
--[[ ruRU ]] bL["Sets the color of the cast bar"] = "Задает цвет полоски заклинания"
--[[ ruRU ]] bL["Backdrop Color"] = "Цвет тени"
--[[ ruRU ]] bL["Sets the backdrop color of the cast bar"] = "Задает цвет тени полоски заклинания"
--[[ ruRU ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ ruRU ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ ruRU ]] bL["Border Inset"] = "Border Inset"
--[[ ruRU ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ ruRU ]] bL["Border Color"] = "Цвет рамки"
--[[ ruRU ]] bL["Sets the border color of the cast bar"] = "Установка цвета краев полосы применения"
--[[ ruRU ]] bL["Border Style"] = "Стиль рамки"
--[[ ruRU ]] bL["Sets the style of the cast bar border"] = "Установка стиля краев полосы применения"
--[[ ruRU ]] bL["Texture"] = "Текстура"
--[[ ruRU ]] bL["Sets the cast bar texture"] = "Задает текстуру полоски заклинания"

--[[ ruRU ]] bL["Incremetal"] = "Incremetal"
--[[ ruRU ]] bL["Update incrementally; workaround for malformed borders, only relevant when borders are enabled"] = "Update incrementally; workaround for malformed borders, only relevant when borders are enabled"

-----------------------------------------------------------------------------

--[[ ruRU ]] iL["Spell Icon"] = "Значок заклинания"
--[[ ruRU ]] iL["Spell icon placement options"] = "Настройки положения значка заклинания"
--[[ ruRU ]] iL["Enable"] = "Включить"
--[[ ruRU ]] iL["Enable spell icon display on the nameplate"] = "Включить отображение значка заклинания на табличке"
--[[ ruRU ]] iL["Position"] = "Позиция"
--[[ ruRU ]] iL["Adjust spell icon position"] = "Задать место иконки заклинания"
--[[ ruRU ]] iL["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] iL["Sets the anchor for the spell icon"] = "Задает прикрепление значка заклинания"
--[[ ruRU ]] iL["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] iL["Sets the relative point on the cast bar to anchor the spell icon"] = "Задает точку для положения значка заклинания относительно полоски здоровья"
--[[ ruRU ]] iL["Size"] = "Размер"
--[[ ruRU ]] iL["Size in pixels of the spell icon"] = "Размер значка заклинания в пикселях"
--[[ ruRU ]] iL["X Offset"] = "Смещение по X"
--[[ ruRU ]] iL["X offset of the spell icon"] = "Смещение значка заклинания по X"
--[[ ruRU ]] iL["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] iL["Y offset of the spell icon"] = "Смещение значка заклинания по Y"

--[[ ruRU ]] iL["Shield"] = "Щит"
--[[ ruRU ]] iL["Shows a shield graphic around an uninterruptable spell icon"] = "Показывать графику щита около иконки непрерываемой способности"
--[[ ruRU ]] iL["Enable"] = "Включить"
--[[ ruRU ]] iL["Enables the shield graphic"] = "Включить рисунок щита"
--[[ ruRU ]] iL["Style"] = "Стиль"
--[[ ruRU ]] iL["Sets the shield graphic style"] = "Установка стиля рисунка щита"
--[[ ruRU ]] iL["Scale"] = "Scale"
--[[ ruRU ]] iL["Scale of the shield graphic"] = "Scale of the shield graphic"
--[[ ruRU ]] iL["Color"] = "Цвет"
--[[ ruRU ]] iL["Sets the shield graphic color"] = "Установка цвета рисунка щита"
--[[ ruRU ]] iL["X Offset"] = "Смещение по X"
--[[ ruRU ]] iL["Y Offset"] = "Смещение по Y"

--[[ ruRU ]] iL["SQUARE"] = "КВАДРАТ"
--[[ ruRU ]] iL["ROUND"] = "КРУГЛЫЙ"

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

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] nL["Spell Name"] = "Имя заклинания"
--[[ ruRU ]] nL["Cast bar spell name text options"] = "Настройки названия для полоске заклинания"
--[[ ruRU ]] nL["Enable"] = "Включить"
--[[ ruRU ]] nL["Show spell name on cast bar"] = "Отображать название на полоске заклинания"
--[[ ruRU ]] nL["Typeface"] = "Шрифт"
--[[ ruRU ]] nL["Spell name typeface options"] = "Настройки шрифта для заклинания"
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

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftCastBarSpellNameText"] = "AloftCastBarSpellNameText"
--[[ ruRU ]] mL["Display spell name on cast bar"] = "Отображение названия заклинаний на полоске заклинаний"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] tL["Time Text"] = "Текст времени"
--[[ ruRU ]] tL["Cast bar time text options"] = "Настройки отображения времени заклинания"
--[[ ruRU ]] tL["Enable"] = "Включить"
--[[ ruRU ]] tL["Show cast bar time text"] = "Отображать текст времени заклинания"
--[[ ruRU ]] tL["Typeface"] = "Шрифт"
--[[ ruRU ]] tL["Cast bar time text typeface options"] = "Настройки шрифта для времени на полоске заклинания"
--[[ ruRU ]] tL["Font"] = "Шрифт"
--[[ ruRU ]] tL["Sets the font for cast bar time text"] = "Задает шрифт для текста времени заклинания"
--[[ ruRU ]] tL["Font Size"] = "Размер шрифта"
--[[ ruRU ]] tL["Sets the font height of the cast bar time text"] = "Задает высоту шрифта для текста времени заклинания"
--[[ ruRU ]] tL["Font Shadow"] = "Тень шрифта"
--[[ ruRU ]] tL["Show font shadow on cast bar time text"] = "Отображать тень для текста времени заклинания"
--[[ ruRU ]] tL["Alignment"] = "Выравнивание"
--[[ ruRU ]] tL["Sets the alignment of the cast bar time text"] = "Задает выравнивание текста времени на полоске заклинания"
--[[ ruRU ]] tL["Outline"] = "Контур"
--[[ ruRU ]] tL["Sets the font outline for cast bar time text"] = "Задает окантовку для текста времени заклинания"
--[[ ruRU ]] tL["Position"] = "Позиция"
--[[ ruRU ]] tL["Adjust cast bar time text position"] = "Задать место времени заклинания"
--[[ ruRU ]] tL["Left Offset"] = "Смещение в лева"
--[[ ruRU ]] tL["Sets the offset of the left of the text"] = "Задает смещение левого конца текста"
--[[ ruRU ]] tL["Right Offset"] = "Смещение в права"
--[[ ruRU ]] tL["Sets the offset of the right of the text"] = "Задает смещение правого конца текста"
--[[ ruRU ]] tL["Vertical Offset"] = "Смещение по вертикале"
--[[ ruRU ]] tL["Sets the vertical offset of the text"] = "Задает вертикальное смещение текста"
--[[ ruRU ]] tL["Color"] = "Цвет"
--[[ ruRU ]] tL["Sets the cast bar time text color"] = "Задает цвет текста полоски заклинания"

--[[ ruRU ]] tL["None"] = "Нет"
--[[ ruRU ]] tL["Normal"] = "Обычно"
--[[ ruRU ]] tL["Thick"] = "Жирный"

--[[ ruRU ]] tL["LEFT"] = "СЛЕВА"
--[[ ruRU ]] tL["CENTER"] = "ПО ЦЕНТРУ"
--[[ ruRU ]] tL["RIGHT"] = "СПРАВА"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftCastBarTimeText"] = "AloftCastBarTimeText"
--[[ ruRU ]] mL["Display cast bar time text"] = "Отображает время на полоске заклинаний"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] bL["Cast Bar"] = "施法条"
--[[ zhCN ]] bL["Cast bar options"] = "施法条相关设置"
--[[ zhCN ]] bL["Enable"] = "启用"
--[[ zhCN ]] bL["Shows the current target's casting bar"] = "显示当前目标的施法条"
--[[ zhCN ]] bL["Position"] = "位置"
--[[ zhCN ]] bL["Adjust cast bar position"] = "调整施法条的位置"
--[[ zhCN ]] bL["Left Offset"] = "向左偏移"
--[[ zhCN ]] bL["Sets the offset of the left of the cast bar"] = "设定施法條的向左偏移量"
--[[ zhCN ]] bL["Right Offset"] = "向右偏移"
--[[ zhCN ]] bL["Sets the offset of the right of the cast bar"] = "设定施法条的向右偏移量"
--[[ zhCN ]] bL["Vertical Offset"] = "垂直偏移"
--[[ zhCN ]] bL["Sets the vertical offset of the cast bar"] = "设定施法条的垂直偏移量"
--[[ zhCN ]] bL["Height"] = "高度"
--[[ zhCN ]] bL["Sets the height of the cast bar"] = "设置施法条的高度"

--[[ zhCN ]] bL["Interruptable Cast Bar"] = "Interruptable Cast Bar"
--[[ zhCN ]] bL["Cast bar appearance for interruptable spells"] = "Cast bar appearance for interruptable spells"
--[[ zhCN ]] bL["Uninterruptable Cast Bar"] = "Uninterruptable Cast Bar"
--[[ zhCN ]] bL["Cast bar appearance for uninterruptable spells"] = "Cast bar appearance for uninterruptable spells"

--[[ zhCN ]] bL["Cast Bar Color"] = "施法条颜色"
--[[ zhCN ]] bL["Sets the color of the cast bar"] = "设置施法条颜色"
--[[ zhCN ]] bL["Backdrop Color"] = "背景颜色"
--[[ zhCN ]] bL["Sets the backdrop color of the cast bar"] = "设定施法条的背景颜色"
--[[ zhCN ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ zhCN ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ zhCN ]] bL["Border Inset"] = "Border Inset"
--[[ zhCN ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ zhCN ]] bL["Border Color"] = "边框颜色"
--[[ zhCN ]] bL["Sets the border color of the cast bar"] = "设置施法条边框颜色"
--[[ zhCN ]] bL["Border Style"] = "边框样式"
--[[ zhCN ]] bL["Sets the style of the cast bar border"] = "设置施法条边框样式"
--[[ zhCN ]] bL["Texture"] = "材质"
--[[ zhCN ]] bL["Sets the cast bar texture"] = "设定施法条的材质"

--[[ zhCN ]] bL["Incremetal"] = "Incremetal"
--[[ zhCN ]] bL["Update incrementally; workaround for malformed borders, only relevant when borders are enabled"] = "Update incrementally; workaround for malformed borders, only relevant when borders are enabled"

-----------------------------------------------------------------------------

--[[ zhCN ]] iL["Spell Icon"] = "法术图标"
--[[ zhCN ]] iL["Spell icon placement options"] = "法术图标相关设置"
--[[ zhCN ]] iL["Enable"] = "启用"
--[[ zhCN ]] iL["Enable spell icon display on the nameplate"] = "在姓名板上显示法术图标"
--[[ zhCN ]] iL["Position"] = "位置"
--[[ zhCN ]] iL["Adjust spell icon position"] = "法术图标位置"
--[[ zhCN ]] iL["Anchor"] = "锚点"
--[[ zhCN ]] iL["Sets the anchor for the spell icon"] = "设定法术图标的锚点"
--[[ zhCN ]] iL["Anchor To"] = "固定在"
--[[ zhCN ]] iL["Sets the relative point on the cast bar to anchor the spell icon"] = "设定法术图标固定在生命值显示条的相对位置"
--[[ zhCN ]] iL["Size"] = "尺寸"
--[[ zhCN ]] iL["Size in pixels of the spell icon"] = "以像素定义的法术图标尺寸"
--[[ zhCN ]] iL["X Offset"] = "X轴偏移"
--[[ zhCN ]] iL["X offset of the spell icon"] = "法术图标的X轴偏移量"
--[[ zhCN ]] iL["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] iL["Y offset of the spell icon"] = "法术图标的Y轴偏移量"

--[[ zhCN ]] iL["Shield"] = "Shield"
--[[ zhCN ]] iL["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon"
--[[ zhCN ]] iL["Enable"] = "Enable"
--[[ zhCN ]] iL["Enables the shield graphic"] = "Enables the shield graphic"
--[[ zhCN ]] iL["Style"] = "Style"
--[[ zhCN ]] iL["Sets the shield graphic style"] = "Sets the shield graphic style"
--[[ zhCN ]] iL["Scale"] = "Scale"
--[[ zhCN ]] iL["Scale of the shield graphic"] = "Scale of the shield graphic"
--[[ zhCN ]] iL["Color"] = "Color"
--[[ zhCN ]] iL["Sets the shield graphic color"] = "Sets the shield graphic color"
--[[ zhCN ]] iL["X Offset"] = "X轴偏移"
--[[ zhCN ]] iL["Y Offset"] = "Y轴偏移"

--[[ zhCN ]] iL["SQUARE"] = "SQUARE"
--[[ zhCN ]] iL["ROUND"] = "ROUND"

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

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] nL["Spell Name"] = "法术名称"
--[[ zhCN ]] nL["Cast bar spell name text options"] = "施法条法术名称文字相关设置"
--[[ zhCN ]] nL["Enable"] = "启用"
--[[ zhCN ]] nL["Show spell name on cast bar"] = "在施法条上显示法术名称"
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

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftCastBarSpellNameText"] = "施法条法术名"
--[[ zhCN ]] mL["Display spell name on cast bar"] = "在施法条上显示法术名"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] tL["Time Text"] = "计时文字"
--[[ zhCN ]] tL["Cast bar time text options"] = "施法条计时文字相关设置"
--[[ zhCN ]] tL["Enable"] = "启用"
--[[ zhCN ]] tL["Show cast bar time text"] = "显示施法条计时文字"
--[[ zhCN ]] tL["Typeface"] = "式样"
--[[ zhCN ]] tL["Cast bar time text typeface options"] = "施法条计时文字式样设置"
--[[ zhCN ]] tL["Font"] = "字体"
--[[ zhCN ]] tL["Sets the font for cast bar time text"] = "设定施法条计时文字的字体"
--[[ zhCN ]] tL["Font Size"] = "字号"
--[[ zhCN ]] tL["Sets the font height of the cast bar time text"] = "设定施法条计时文字的字号"
--[[ zhCN ]] tL["Font Shadow"] = "字体阴影"
--[[ zhCN ]] tL["Show font shadow on cast bar time text"] = "设定施法条计时文字的字体阴影"
--[[ zhCN ]] tL["Alignment"] = "对齐"
--[[ zhCN ]] tL["Sets the alignment of the cast bar time text"] = "设定施法条计时文字的对齐方式"
--[[ zhCN ]] tL["Outline"] = "轮廓"
--[[ zhCN ]] tL["Sets the font outline for cast bar time text"] = "设定施法条计时文字的字体轮廓"
--[[ zhCN ]] tL["Position"] = "位置"
--[[ zhCN ]] tL["Adjust cast bar time text position"] = "调整施法条计时文字的位置"
--[[ zhCN ]] tL["Left Offset"] = "向左偏移"
--[[ zhCN ]] tL["Sets the offset of the left of the text"] = "设定文字的向左偏移量"
--[[ zhCN ]] tL["Right Offset"] = "向右偏移"
--[[ zhCN ]] tL["Sets the offset of the right of the text"] = "设定文字的向右偏移量"
--[[ zhCN ]] tL["Vertical Offset"] = "垂直偏移"
--[[ zhCN ]] tL["Sets the vertical offset of the text"] = "设定文字的垂直偏移量"
--[[ zhCN ]] tL["Color"] = "颜色"
--[[ zhCN ]] tL["Sets the cast bar time text color"] = "设定施法条计时文字的颜色"

--[[ zhCN ]] tL["None"] = "无"
--[[ zhCN ]] tL["Normal"] = "正常"
--[[ zhCN ]] tL["Thick"] = "粗"

--[[ zhCN ]] tL["LEFT"] = "左"
--[[ zhCN ]] tL["CENTER"] = "中"
--[[ zhCN ]] tL["RIGHT"] = "右"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftCastBarTimeText"] = "施法时间"
--[[ zhCN ]] mL["Display cast bar time text"] = "在施法条上显示时间"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] bL["Cast Bar"] = "施法條"
--[[ zhTW ]] bL["Cast bar options"] = "施法條設定"
--[[ zhTW ]] bL["Enable"] = "啟用"
--[[ zhTW ]] bL["Shows the current target's casting bar"] = "顯示目前目標的施法條"
--[[ zhTW ]] bL["Position"] = "位置"
--[[ zhTW ]] bL["Adjust cast bar position"] = "調整施法條位置"
--[[ zhTW ]] bL["Left Offset"] = "左偏移"
--[[ zhTW ]] bL["Sets the offset of the left of the cast bar"] = "設定施法條的左偏移"
--[[ zhTW ]] bL["Right Offset"] = "右偏移"
--[[ zhTW ]] bL["Sets the offset of the right of the cast bar"] = "設定施法條的右偏移"
--[[ zhTW ]] bL["Vertical Offset"] = "垂直偏移"
--[[ zhTW ]] bL["Sets the vertical offset of the cast bar"] = "設定施法條的垂直偏移"
--[[ zhTW ]] bL["Height"] = "高度"
--[[ zhTW ]] bL["Sets the height of the cast bar"] = "設定施法條的高度"

--[[ zhTW ]] bL["Interruptable Cast Bar"] = "可中斷施法條"
--[[ zhTW ]] bL["Cast bar appearance for interruptable spells"] = "可中斷法術的施法條外觀"
--[[ zhTW ]] bL["Uninterruptable Cast Bar"] = "不可中斷施法條"
--[[ zhTW ]] bL["Cast bar appearance for uninterruptable spells"] = "不可中斷法術的施法條外觀"

--[[ zhTW ]] bL["Cast Bar Color"] = "施法條顏色"
--[[ zhTW ]] bL["Sets the color of the cast bar"] = "設定施法條的顏色"
--[[ zhTW ]] bL["Backdrop Color"] = "背景顏色"
--[[ zhTW ]] bL["Sets the backdrop color of the cast bar"] = "設定施法條的背景顏色"
--[[ zhTW ]] bL["Border Edge Size"] = "邊框邊緣大小"
--[[ zhTW ]] bL["Sets the thickness of the border"] = "設定邊框的厚度"
--[[ zhTW ]] bL["Border Inset"] = "邊框崁入"
--[[ zhTW ]] bL["Sets the padding aroundthe border"] = "設定邊框的周圍間距"
--[[ zhTW ]] bL["Border Color"] = "邊框顏色"
--[[ zhTW ]] bL["Sets the border color of the cast bar"] = "設定施法條的邊框顏色"
--[[ zhTW ]] bL["Border Style"] = "邊框樣式"
--[[ zhTW ]] bL["Sets the style of the cast bar border"] = "設定施法條的邊框樣式"
--[[ zhTW ]] bL["Texture"] = "材質"
--[[ zhTW ]] bL["Sets the cast bar texture"] = "施法條材質"

--[[ zhTW ]] bL["Incremetal"] = "增量"
--[[ zhTW ]] bL["Update incrementally; workaround for malformed borders, only relevant when borders are enabled"] = "遞增地更新;畸形邊框的應變措施，只在邊框啟用時有關"

-----------------------------------------------------------------------------

--[[ zhTW ]] iL["Spell Icon"] = "法術圖示"
--[[ zhTW ]] iL["Spell icon placement options"] = "法術圖示佈局設定"
--[[ zhTW ]] iL["Enable"] = "啟用"
--[[ zhTW ]] iL["Enable spell icon display on the nameplate"] = "在名牌上顯示法術圖示"
--[[ zhTW ]] iL["Position"] = "位置"
--[[ zhTW ]] iL["Adjust spell icon position"] = "調整法術圖示位置"
--[[ zhTW ]] iL["Anchor"] = "錨點"
--[[ zhTW ]] iL["Sets the anchor for the spell icon"] = "設定法術圖示的錨點"
--[[ zhTW ]] iL["Anchor To"] = "錨點在"
--[[ zhTW ]] iL["Sets the relative point on the cast bar to anchor the spell icon"] = "設定在施法條上錨到法術圖示的相關點"
--[[ zhTW ]] iL["Size"] = "大小"
--[[ zhTW ]] iL["Size in pixels of the spell icon"] = "法術圖示的像素大小"
--[[ zhTW ]] iL["X Offset"] = "X偏移"
--[[ zhTW ]] iL["X offset of the spell icon"] = "法術圖示的X偏移"
--[[ zhTW ]] iL["Y Offset"] = "Y偏移"
--[[ zhTW ]] iL["Y offset of the spell icon"] = "法術圖示的Y偏移"

--[[ zhTW ]] iL["Shield"] = "盾"
--[[ zhTW ]] iL["Shows a shield graphic around an uninterruptable spell icon"] = "顯示盾圖形在不可中斷法術圖示四周"
--[[ zhTW ]] iL["Enable"] = "啟用"
--[[ zhTW ]] iL["Enables the shield graphic"] = "啟用盾圖形"
--[[ zhTW ]] iL["Style"] = "樣式"
--[[ zhTW ]] iL["Sets the shield graphic style"] = "設定盾圖形樣式"
--[[ zhTW ]] iL["Scale"] = "縮放"
--[[ zhTW ]] iL["Scale of the shield graphic"] = "縮放盾圖形"
--[[ zhTW ]] iL["Color"] = "顏色"
--[[ zhTW ]] iL["Sets the shield graphic color"] = "設定盾圖形顏色"
--[[ zhTW ]] iL["X Offset"] = "X偏移"
--[[ zhTW ]] iL["Y Offset"] = "Y偏移"

--[[ zhTW ]] iL["SQUARE"] = "正方形"
--[[ zhTW ]] iL["ROUND"] = "圓形"

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

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] nL["Spell Name"] = "法術名稱"
--[[ zhTW ]] nL["Cast bar spell name text options"] = "施法條法術名稱文字設定"
--[[ zhTW ]] nL["Enable"] = "啟用"
--[[ zhTW ]] nL["Show spell name on cast bar"] = "在施法條上顯示法術名稱"
--[[ zhTW ]] nL["Typeface"] = "字體"
--[[ zhTW ]] nL["Spell name typeface options"] = "法術名稱字體設定"
--[[ zhTW ]] nL["Font"] = "字型"
--[[ zhTW ]] nL["Sets the font for spell name"] = "設定法術名稱的字型"
--[[ zhTW ]] nL["Font Size"] = "字型大小"
--[[ zhTW ]] nL["Sets the font height of the spell name"] = "設定法術名稱的字型高度"
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

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftCastBarSpellNameText"] = "Aloft施法條法術名稱文字"
--[[ zhTW ]] mL["Display spell name on cast bar"] = "在施法條上顯示法術名稱"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] tL["Time Text"] = "時間文字"
--[[ zhTW ]] tL["Cast bar time text options"] = "施法條時間文字設定"
--[[ zhTW ]] tL["Enable"] = "啟用"
--[[ zhTW ]] tL["Show cast bar time text"] = "顯示施法條時間文字"
--[[ zhTW ]] tL["Typeface"] = "字體"
--[[ zhTW ]] tL["Cast bar time text typeface options"] = "施法條時間文字字體設定"
--[[ zhTW ]] tL["Font"] = "字型"
--[[ zhTW ]] tL["Sets the font for cast bar time text"] = "施法條時間文字字型"
--[[ zhTW ]] tL["Font Size"] = "字型大小"
--[[ zhTW ]] tL["Sets the font height of the cast bar time text"] = "施法條時間文字字型大小"
--[[ zhTW ]] tL["Font Shadow"] = "字型陰影"
--[[ zhTW ]] tL["Show font shadow on cast bar time text"] = "施法條時間文字字型陰影"
--[[ zhTW ]] tL["Alignment"] = "對齊"
--[[ zhTW ]] tL["Sets the alignment of the cast bar time text"] = "施法條時間文字對齊"
--[[ zhTW ]] tL["Outline"] = "輪廓"
--[[ zhTW ]] tL["Sets the font outline for cast bar time text"] = "施法條時間文字字型輪廓"
--[[ zhTW ]] tL["Position"] = "位置"
--[[ zhTW ]] tL["Adjust cast bar time text position"] = "施法條時間文字位置"
--[[ zhTW ]] tL["Left Offset"] = "左偏移"
--[[ zhTW ]] tL["Sets the offset of the left of the text"] = "文字左偏移"
--[[ zhTW ]] tL["Right Offset"] = "右偏移"
--[[ zhTW ]] tL["Sets the offset of the right of the text"] = "文字右偏移"
--[[ zhTW ]] tL["Vertical Offset"] = "垂直偏移"
--[[ zhTW ]] tL["Sets the vertical offset of the text"] = "文字垂直偏移"
--[[ zhTW ]] tL["Color"] = "顏色"
--[[ zhTW ]] tL["Sets the cast bar time text color"] = "施法條時間文字顏色"

--[[ zhTW ]] tL["None"] = "無"
--[[ zhTW ]] tL["Normal"] = "正常"
--[[ zhTW ]] tL["Thick"] = "粗"

--[[ zhTW ]] tL["LEFT"] = "左"
--[[ zhTW ]] tL["CENTER"] = "中"
--[[ zhTW ]] tL["RIGHT"] = "右"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftCastBarTimeText"] = "Aloft施法時間文字"
--[[ zhTW ]] mL["Display cast bar time text"] = "在施法條上顯示時間"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftCastBarOptions = setmetatable(bL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
bL = nil

-----------------------------------------------------------------------------

AloftLocale.AloftSpellIconOptions = setmetatable(iL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
iL = nil

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

AloftLocale.AloftSpellNameTextOptions = setmetatable(nL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
nL = nil

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

AloftLocale.AloftCastBarTimeTextOptions = setmetatable(tL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
tL = nil

-----------------------------------------------------------------------------

end)
