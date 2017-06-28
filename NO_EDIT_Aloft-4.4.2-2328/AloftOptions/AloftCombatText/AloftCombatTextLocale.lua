local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

local L = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Combat Text"] = "Combat Text"
--[[ enUS ]] L["Combat text options"] = "Combat text options"
--[[ enUS ]] L["Enable Target"] = "Enable Target"
--[[ enUS ]] L["Show combat text on target nameplates"] = "Show combat text on target nameplates"
--[[ enUS ]] L["Enable Group"] = "Enable Group"
--[[ enUS ]] L["Show combat text on group member nameplates"] = "Show combat text on group member nameplates"
--[[ enUS ]] L["Enable Other"] = "Enable Other"
--[[ enUS ]] L["Show combat text on other nameplates"] = "Show combat text on other nameplates"

--[[ enUS ]] L["Damage/Healing By Player"] = "Damage/Healing By Player"
--[[ enUS ]] L["Show combat text for damage/healing done by the player"] = "Show combat text for damage/healing done by the player"
--[[ enUS ]] L["Damage/Healing By Group"] = "Damage/Healing By Group"
--[[ enUS ]] L["Show combat text for damage/healing done by group members (including pets)"] = "Show combat text for damage/healing done by group members (including pets)"
--[[ enUS ]] L["Damage/Healing By Other"] = "Damage/Healing By Other"
--[[ enUS ]] L["Show combat text for damage/healing done by other units"] = "Show combat text for damage/healing done by other units"
--[[ enUS ]] L["Include Overhealing"] = "Include Overhealing"
--[[ enUS ]] L["Show combat text for healing that includes overhealing"] = "Show combat text for healing that includes overhealing"

--[[ enUS ]] L["Typeface"] = "Typeface"
--[[ enUS ]] L["Combat text typeface options"] = "Combat text typeface options"
--[[ enUS ]] L["Font"] = "Font"
--[[ enUS ]] L["Sets the font for combat text"] = "Sets the font for combat text"
--[[ enUS ]] L["Font Size"] = "Font Size"
--[[ enUS ]] L["Sets the font height of the combat text"] = "Sets the font height of the combat text"
--[[ enUS ]] L["Font Shadow"] = "Font Shadow"
--[[ enUS ]] L["Show font shadow on combat text"] = "Show font shadow on combat text"
--[[ enUS ]] L["Outline"] = "Outline"
--[[ enUS ]] L["Sets the outline for combat text"] = "Sets the outline for combat text"

--[[ enUS ]] L["Position"] = "Position"
--[[ enUS ]] L["Adjust combat text position"] = "Adjust combat text position"
--[[ enUS ]] L["Anchor"] = "Anchor"
--[[ enUS ]] L["Sets the anchor for the combat text"] = "Sets the anchor for the combat text"
--[[ enUS ]] L["Anchor To"] = "Anchor To"
--[[ enUS ]] L["Sets the relative point on the health bar to anchor the combat text"] = "Sets the relative point on the health bar to anchor the combat text"
--[[ enUS ]] L["X Offset"] = "X Offset"
--[[ enUS ]] L["X offset of the combat text"] = "X offset of the combat text"
--[[ enUS ]] L["Y Offset"] = "Y Offset"
--[[ enUS ]] L["Y offset of the combat text"] = "Y offset of the combat text"
--[[ enUS ]] L["Alpha"] = "Alpha"
--[[ enUS ]] L["Sets the alpha of the combat text"] = "Sets the alpha of the combat text"

--[[ enUS ]] L["None"] = "None"
--[[ enUS ]] L["Normal"] = "Normal"
--[[ enUS ]] L["Thick"] = "Thick"

--[[ enUS ]] L["Colors"] = "Colors"
--[[ enUS ]] L["Customize colors"] = "Customize colors"
--[[ enUS ]] L["Physical"] = "Physical"
--[[ enUS ]] L["Sets the color for physical damage"] = "Sets the color for physical damage"
--[[ enUS ]] L["Holy"] = "Holy"
--[[ enUS ]] L["Sets the color for holy damage"] = "Sets the color for holy damage"
--[[ enUS ]] L["Fire"] = "Fire"
--[[ enUS ]] L["Sets the color for fire damage"] = "Sets the color for fire damage"
--[[ enUS ]] L["Nature"] = "Nature"
--[[ enUS ]] L["Sets the color for nature damage"] = "Sets the color for nature damage"
--[[ enUS ]] L["Frost"] = "Frost"
--[[ enUS ]] L["Sets the color for frost damage"] = "Sets the color for frost damage"
--[[ enUS ]] L["Shadow"] = "Shadow"
--[[ enUS ]] L["Sets the color for shadow damage"] = "Sets the color for shadow damage"
--[[ enUS ]] L["Arcane"] = "Arcane"
--[[ enUS ]] L["Sets the color for arcane damage"] = "Sets the color for arcane damage"
--[[ enUS ]] L["Heal"] = "Heal"
--[[ enUS ]] L["Sets the color for healing"] = "Sets the color for healing"
--[[ enUS ]] L["Text"] = "Text"
--[[ enUS ]] L["Sets the color for text feedback"] = "Sets the color for text feedback"
--[[ enUS ]] L["Default"] = "Default"
--[[ enUS ]] L["Sets the default combat text color"] = "Sets the default combat text color"
--[[ enUS ]] L["Reset"] = "Reset"
--[[ enUS ]] L["Resets all of the colors to default"] = "Resets all of the colors to default"
--[[ enUS ]] L["Set All"] = "Set All"
--[[ enUS ]] L["Sets all of the colors"] = "Sets all of the colors"

--[[ enUS ]] L["TOPLEFT"] = "TOPLEFT"
--[[ enUS ]] L["TOP"] = "TOP"
--[[ enUS ]] L["TOPRIGHT"] = "TOPRIGHT"
--[[ enUS ]] L["LEFT"] = "LEFT"
--[[ enUS ]] L["CENTER"] = "CENTER"
--[[ enUS ]] L["RIGHT"] = "RIGHT"
--[[ enUS ]] L["BOTTOMLEFT"] = "BOTTOMLEFT"
--[[ enUS ]] L["BOTTOM"] = "BOTTOM"
--[[ enUS ]] L["BOTTOMRIGHT"] = "BOTTOMRIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftCombatText"] = "AloftCombatText"
--[[ enUS ]] mL["Display combat text on group member nameplates"] = "Display combat text on group member nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

--[[ koKR ]] L["Combat Text"] = "전투 텍스트"
--[[ koKR ]] L["Combat text options"] = "전투 텍스트 설정"
--[[ koKR ]] L["Enable Target"] = "대상 사용"
--[[ koKR ]] L["Show combat text on target nameplates"] = "대상의 이름표에 전투 텍스트를 사용합니다."
--[[ koKR ]] L["Enable Group"] = "파티 사용"
--[[ koKR ]] L["Show combat text on group member nameplates"] = "파티원의 이름표에 전투 텍스트를 표시합니다."
--[[ koKR ]] L["Enable Other"] = "Enable Other"
--[[ koKR ]] L["Show combat text on other nameplates"] = "Show combat text on other nameplates"

--[[ koKR ]] L["Damage/Healing By Player"] = "Damage/Healing By Player"
--[[ koKR ]] L["Show combat text for damage/healing done by the player"] = "Show combat text for damage/healing done by the player"
--[[ koKR ]] L["Damage/Healing By Group"] = "Damage/Healing By Group"
--[[ koKR ]] L["Show combat text for damage/healing done by group members (including pets)"] = "Show combat text for damage/healing done by group members (including pets)"
--[[ koKR ]] L["Damage/Healing By Other"] = "Damage/Healing By Other"
--[[ koKR ]] L["Show combat text for damage/healing done by other units"] = "Show combat text for damage/healing done by other units"
--[[ koKR ]] L["Include Overhealing"] = "Include Overhealing"
--[[ koKR ]] L["Show combat text for healing that includes overhealing"] = "Show combat text for healing that includes overhealing"

--[[ koKR ]] L["Typeface"] = "서체"
--[[ koKR ]] L["Combat text typeface options"] = "전투 텍스트 서체 설정"
--[[ koKR ]] L["Font"] = "글꼴"
--[[ koKR ]] L["Sets the font for combat text"] = "전투 텍스트의 글꼴을 설정합니다."
--[[ koKR ]] L["Font Size"] = "글꼴 크기"
--[[ koKR ]] L["Sets the font height of the combat text"] = "전투 텍스트의 글꼴 높이를 설정합니다."
--[[ koKR ]] L["Font Shadow"] = "글꼴 그림자"
--[[ koKR ]] L["Show font shadow on combat text"] = "전투 텍스트에 그림자를 표시합니다."
--[[ koKR ]] L["Outline"] = "테두리"
--[[ koKR ]] L["Sets the outline for combat text"] = "전투 텍스트에 대한 테두리를 설정합니다."

--[[ koKR ]] L["Position"] = "위치"
--[[ koKR ]] L["Adjust combat text position"] = "전투 텍스트 위치 조절"
--[[ koKR ]] L["Anchor"] = "앵커"
--[[ koKR ]] L["Sets the anchor for the combat text"] = "전투 텍스트의 앵커를 설정합니다."
--[[ koKR ]] L["Anchor To"] = "앵커 위치"
--[[ koKR ]] L["Sets the relative point on the health bar to anchor the combat text"] = "생명력 바에서 전투 텍스트의 앵커 위치를 설정합니다."
--[[ koKR ]] L["X Offset"] = "X 좌표"
--[[ koKR ]] L["X offset of the combat text"] = "전투 텍스트의 X 좌표입니다."
--[[ koKR ]] L["Y Offset"] = "Y 좌표"
--[[ koKR ]] L["Y offset of the combat text"] = "전투 텍스트의 Y 좌표입니다."
--[[ koKR ]] L["Alpha"] = "투명도"
--[[ koKR ]] L["Sets the alpha of the combat text"] = "전투 텍스트의 투명도를 설정합니다."

--[[ koKR ]] L["None"] = "없음"
--[[ koKR ]] L["Normal"] = "기본"
--[[ koKR ]] L["Thick"] = "굵게"

--[[ koKR ]] L["Colors"] = "색상"
--[[ koKR ]] L["Customize colors"] = "사용자 지정 색상"
--[[ koKR ]] L["Physical"] = "물리"
--[[ koKR ]] L["Sets the color for physical damage"] = "물리적 피해량의 색상을 설정합니다."
--[[ koKR ]] L["Holy"] = "신성"
--[[ koKR ]] L["Sets the color for holy damage"] = "신성 피해량의 색상을 설정합니다."
--[[ koKR ]] L["Fire"] = "화염"
--[[ koKR ]] L["Sets the color for fire damage"] = "화염 피해량의 색상을 설정합니다."
--[[ koKR ]] L["Nature"] = "자연"
--[[ koKR ]] L["Sets the color for nature damage"] = "자연 피해량의 색상을 설정합니다."
--[[ koKR ]] L["Frost"] = "냉기"
--[[ koKR ]] L["Sets the color for frost damage"] = "냉기 피해량의 색상을 설정합니다."
--[[ koKR ]] L["Shadow"] = "암흑"
--[[ koKR ]] L["Sets the color for shadow damage"] = "암흑 피해량의 색상을 설정합니다."
--[[ koKR ]] L["Arcane"] = "비전"
--[[ koKR ]] L["Sets the color for arcane damage"] = "비전 피해량의 색상을 설정합니다."
--[[ koKR ]] L["Heal"] = "치유"
--[[ koKR ]] L["Sets the color for healing"] = "치유량의 색상을 설정합니다."
--[[ koKR ]] L["Text"] = "글자"
--[[ koKR ]] L["Sets the color for text feedback"] = "피드백 글자의 색상을 설정합니다."
--[[ koKR ]] L["Default"] = "Default"
--[[ koKR ]] L["Sets the default combat text color"] = "Sets the default combat text color"
--[[ koKR ]] L["Reset"] = "초기화"
--[[ koKR ]] L["Resets all of the colors to default"] = "기본 색상으로 모두 초기화합니다."
--[[ koKR ]] L["Set All"] = "전체 설정"
--[[ koKR ]] L["Sets all of the colors"] = "전체 색상을 설정합니다."

--[[ koKR ]] L["TOPLEFT"] = "좌측 상단"
--[[ koKR ]] L["TOP"] = "상단"
--[[ koKR ]] L["TOPRIGHT"] = "우측 상단"
--[[ koKR ]] L["LEFT"] = "좌측"
--[[ koKR ]] L["CENTER"] = "가운데"
--[[ koKR ]] L["RIGHT"] = "우측"
--[[ koKR ]] L["BOTTOMLEFT"] = "좌측 하단"
--[[ koKR ]] L["BOTTOM"] = "하단"
--[[ koKR ]] L["BOTTOMRIGHT"] = "우측 하단"

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftCombatText"] = "AloftCombatText"
--[[ koKR ]] mL["Display combat text on group member nameplates"] = "Display combat text on group member nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Combat Text"] = "Текст боя"
--[[ ruRU ]] L["Combat text options"] = "Настройка текста боя"
--[[ ruRU ]] L["Enable Target"] = "Включить цель"
--[[ ruRU ]] L["Show combat text on target nameplates"] = "Отображать текст боя на табличке цели"
--[[ ruRU ]] L["Enable Group"] = "Включить группу"
--[[ ruRU ]] L["Show combat text on group member nameplates"] = "Отображать текст боя на табличках участников группы"
--[[ ruRU ]] L["Enable Other"] = "Enable Other"
--[[ ruRU ]] L["Show combat text on other nameplates"] = "Show combat text on other nameplates"

--[[ ruRU ]] L["Damage/Healing By Player"] = "Damage/Healing By Player"
--[[ ruRU ]] L["Show combat text for damage/healing done by the player"] = "Show combat text for damage/healing done by the player"
--[[ ruRU ]] L["Damage/Healing By Group"] = "Damage/Healing By Group"
--[[ ruRU ]] L["Show combat text for damage/healing done by group members (including pets)"] = "Show combat text for damage/healing done by group members (including pets)"
--[[ ruRU ]] L["Damage/Healing By Other"] = "Damage/Healing By Other"
--[[ ruRU ]] L["Show combat text for damage/healing done by other units"] = "Show combat text for damage/healing done by other units"
--[[ ruRU ]] L["Include Overhealing"] = "Include Overhealing"
--[[ ruRU ]] L["Show combat text for healing that includes overhealing"] = "Show combat text for healing that includes overhealing"

--[[ ruRU ]] L["Typeface"] = "Шрифт"
--[[ ruRU ]] L["Combat text typeface options"] = "Настройка шрифта текста боя"
--[[ ruRU ]] L["Font"] = "Шрифт"
--[[ ruRU ]] L["Sets the font for combat text"] = "Задает шрифт для текста боя"
--[[ ruRU ]] L["Font Size"] = "Размер шрифта"
--[[ ruRU ]] L["Sets the font height of the combat text"] = "Задает высоту шрифта для текста боя"
--[[ ruRU ]] L["Font Shadow"] = "Тень шрифта"
--[[ ruRU ]] L["Show font shadow on combat text"] = "Отображать тень для текста боя"
--[[ ruRU ]] L["Outline"] = "Контур"
--[[ ruRU ]] L["Sets the outline for combat text"] = "Задает окантовку для текста боя"

--[[ ruRU ]] L["Position"] = "Позиция"
--[[ ruRU ]] L["Adjust combat text position"] = "Задать место текста боя"
--[[ ruRU ]] L["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] L["Sets the anchor for the combat text"] = "Задает прикрепление текста боя"
--[[ ruRU ]] L["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] L["Sets the relative point on the health bar to anchor the combat text"] = "Задает точку для положения текста боя относительно полоски здоровья"
--[[ ruRU ]] L["X Offset"] = "Смещение по X"
--[[ ruRU ]] L["X offset of the combat text"] = "Смещение текста боя по X"
--[[ ruRU ]] L["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] L["Y offset of the combat text"] = "Смещение текста боя по Y"
--[[ ruRU ]] L["Alpha"] = "Прозрачность"
--[[ ruRU ]] L["Sets the alpha of the combat text"] = "Задает прозрачность текста боя"

--[[ ruRU ]] L["None"] = "Нет"
--[[ ruRU ]] L["Normal"] = "Обычно"
--[[ ruRU ]] L["Thick"] = "Жирный"

--[[ ruRU ]] L["Colors"] = "Цвета"
--[[ ruRU ]] L["Customize colors"] = "Настройка цветов"
--[[ ruRU ]] L["Physical"] = "Физическое"
--[[ ruRU ]] L["Sets the color for physical damage"] = "Задает цвет для физического урона"
--[[ ruRU ]] L["Holy"] = "Священная магия"
--[[ ruRU ]] L["Sets the color for holy damage"] = "Задает цвет для урона от священной магии"
--[[ ruRU ]] L["Fire"] = "Огонь"
--[[ ruRU ]] L["Sets the color for fire damage"] = "Задает цвет для урона от магии огня"
--[[ ruRU ]] L["Nature"] = "Природная магия"
--[[ ruRU ]] L["Sets the color for nature damage"] = "Задает цвет для урона от магии природы"
--[[ ruRU ]] L["Frost"] = "Лед"
--[[ ruRU ]] L["Sets the color for frost damage"] = "Задать цвет для урона от магии льда"
--[[ ruRU ]] L["Shadow"] = "Тень"
--[[ ruRU ]] L["Sets the color for shadow damage"] = "Задает цвет для урона от теневой магии"
--[[ ruRU ]] L["Arcane"] = "Тайная магия"
--[[ ruRU ]] L["Sets the color for arcane damage"] = "Задает цвет для урона от тайной магии"
--[[ ruRU ]] L["Heal"] = "Лечение"
--[[ ruRU ]] L["Sets the color for healing"] = "Задать цвет для излечения"
--[[ ruRU ]] L["Text"] = "Текст"
--[[ ruRU ]] L["Sets the color for text feedback"] = "Задает цвет для текста отзыва"
--[[ ruRU ]] L["Default"] = "По умолчанию"
--[[ ruRU ]] L["Sets the default combat text color"] = "Задает цвет текста боя по умолчанию"
--[[ ruRU ]] L["Reset"] = "Сброс"
--[[ ruRU ]] L["Resets all of the colors to default"] = "Сбрасывает все цвета в настройки по умолчанию"
--[[ ruRU ]] L["Set All"] = "Задать все"
--[[ ruRU ]] L["Sets all of the colors"] = "Задает все цвета"

--[[ ruRU ]] L["TOPLEFT"] = "ВВЕРХУ-СЛЕВА"
--[[ ruRU ]] L["TOP"] = "ВВЕРХУ"
--[[ ruRU ]] L["TOPRIGHT"] = "ВВЕРХУ-СПРАВА"
--[[ ruRU ]] L["LEFT"] = "СЛЕВА"
--[[ ruRU ]] L["CENTER"] = "ПО ЦЕНТРУ"
--[[ ruRU ]] L["RIGHT"] = "СПРАВА"
--[[ ruRU ]] L["BOTTOMLEFT"] = "СНИЗУ-СЛЕВА"
--[[ ruRU ]] L["BOTTOM"] = "СНИЗУ"
--[[ ruRU ]] L["BOTTOMRIGHT"] = "СНИЗУ-СПРАВА"

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftCombatText"] = "AloftCombatText"
--[[ ruRU ]] mL["Display combat text on group member nameplates"] = "Отображает текст боя на табличках участников группы"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Combat Text"] = "战斗信息文字"
--[[ zhCN ]] L["Combat text options"] = "战斗信息文字相关设置"
--[[ zhCN ]] L["Enable Target"] = "启用目标"
--[[ zhCN ]] L["Show combat text on target nameplates"] = "在目标的姓名板上显示战斗信息文字"
--[[ zhCN ]] L["Enable Group"] = "启用队友"
--[[ zhCN ]] L["Show combat text on group member nameplates"] = "在队友的姓名板上显示战斗信息文字"
--[[ zhCN ]] L["Enable Other"] = "Enable Other"
--[[ zhCN ]] L["Show combat text on other nameplates"] = "Show combat text on other nameplates"

--[[ zhCN ]] L["Damage/Healing By Player"] = "Damage/Healing By Player"
--[[ zhCN ]] L["Show combat text for damage/healing done by the player"] = "Show combat text for damage/healing done by the player"
--[[ zhCN ]] L["Damage/Healing By Group"] = "Damage/Healing By Group"
--[[ zhCN ]] L["Show combat text for damage/healing done by group members (including pets)"] = "Show combat text for damage/healing done by group members (including pets)"
--[[ zhCN ]] L["Damage/Healing By Other"] = "Damage/Healing By Other"
--[[ zhCN ]] L["Show combat text for damage/healing done by other units"] = "Show combat text for damage/healing done by other units"
--[[ zhCN ]] L["Include Overhealing"] = "Include Overhealing"
--[[ zhCN ]] L["Show combat text for healing that includes overhealing"] = "Show combat text for healing that includes overhealing"

--[[ zhCN ]] L["Typeface"] = "式样"
--[[ zhCN ]] L["Combat text typeface options"] = "战斗信息文字式样设置"
--[[ zhCN ]] L["Font"] = "字体"
--[[ zhCN ]] L["Sets the font for combat text"] = "设定战斗信息文字的字体"
--[[ zhCN ]] L["Font Size"] = "字号"
--[[ zhCN ]] L["Sets the font height of the combat text"] = "设定战斗信息文字的字号"
--[[ zhCN ]] L["Font Shadow"] = "字体阴影"
--[[ zhCN ]] L["Show font shadow on combat text"] = "显示战斗信息文字的字体阴影"
--[[ zhCN ]] L["Outline"] = "轮廓"
--[[ zhCN ]] L["Sets the outline for combat text"] = "设定战斗信息文字的字体轮廓"

--[[ zhCN ]] L["Position"] = "位置"
--[[ zhCN ]] L["Adjust combat text position"] = "调整战斗信息文字的位置"
--[[ zhCN ]] L["Anchor"] = "锚点"
--[[ zhCN ]] L["Sets the anchor for the combat text"] = "设定战斗信息文字的锚点"
--[[ zhCN ]] L["Anchor To"] = "固定在"
--[[ zhCN ]] L["Sets the relative point on the health bar to anchor the combat text"] = "设定战斗信息文字固定在生命值显示条的相对位置"
--[[ zhCN ]] L["X Offset"] = "X轴偏移"
--[[ zhCN ]] L["X offset of the combat text"] = "战斗信息文字的X轴偏移量"
--[[ zhCN ]] L["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] L["Y offset of the combat text"] = "战斗信息文字的Y轴偏移量"
--[[ zhCN ]] L["Alpha"] = "透明度"
--[[ zhCN ]] L["Sets the alpha of the combat text"] = "设定战斗信息文字的透明度"

--[[ zhCN ]] L["None"] = "无"
--[[ zhCN ]] L["Normal"] = "正常"
--[[ zhCN ]] L["Thick"] = "粗"

--[[ zhCN ]] L["Colors"] = "颜色"
--[[ zhCN ]] L["Customize colors"] = "自定义颜色"
--[[ zhCN ]] L["Physical"] = "物理"
--[[ zhCN ]] L["Sets the color for physical damage"] = "设定物理伤害的颜色"
--[[ zhCN ]] L["Holy"] = "神圣"
--[[ zhCN ]] L["Sets the color for holy damage"] = "设定神圣伤害的颜色"
--[[ zhCN ]] L["Fire"] = "火焰"
--[[ zhCN ]] L["Sets the color for fire damage"] = "设定火焰伤害的颜色"
--[[ zhCN ]] L["Nature"] = "自然"
--[[ zhCN ]] L["Sets the color for nature damage"] = "设定自然伤害的颜色"
--[[ zhCN ]] L["Frost"] = "冰霜"
--[[ zhCN ]] L["Sets the color for frost damage"] = "设定冰霜伤害的颜色"
--[[ zhCN ]] L["Shadow"] = "暗影"
--[[ zhCN ]] L["Sets the color for shadow damage"] = "设定暗影伤害的颜色"
--[[ zhCN ]] L["Arcane"] = "奥术"
--[[ zhCN ]] L["Sets the color for arcane damage"] = "设定奥术伤害的颜色"
--[[ zhCN ]] L["Heal"] = "治疗"
--[[ zhCN ]] L["Sets the color for healing"] = "设定治疗的颜色"
--[[ zhCN ]] L["Text"] = "文字"
--[[ zhCN ]] L["Sets the color for text feedback"] = "设定回应文字的颜色"
--[[ zhCN ]] L["Default"] = "Default"
--[[ zhCN ]] L["Sets the default combat text color"] = "Sets the default combat text color"
--[[ zhCN ]] L["Reset"] = "重置"
--[[ zhCN ]] L["Resets all of the colors to default"] = "将所有颜色设定重置为默认"
--[[ zhCN ]] L["Set All"] = "设定全部"
--[[ zhCN ]] L["Sets all of the colors"] = "设定全部颜色"

--[[ zhCN ]] L["TOPLEFT"] = "左上"
--[[ zhCN ]] L["TOP"] = "上"
--[[ zhCN ]] L["TOPRIGHT"] = "右上"
--[[ zhCN ]] L["LEFT"] = "左"
--[[ zhCN ]] L["CENTER"] = "中"
--[[ zhCN ]] L["RIGHT"] = "右"
--[[ zhCN ]] L["BOTTOMLEFT"] = "左下"
--[[ zhCN ]] L["BOTTOM"] = "下"
--[[ zhCN ]] L["BOTTOMRIGHT"] = "右下"

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftCombatText"] = "战斗文字"
--[[ zhCN ]] mL["Display combat text on group member nameplates"] = "在小队成员的姓名板上显示战斗文字"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Combat Text"] = "戰鬥文字"
--[[ zhTW ]] L["Combat text options"] = "戰鬥文字設定"
--[[ zhTW ]] L["Enable Target"] = "啟用目標"
--[[ zhTW ]] L["Show combat text on target nameplates"] = "在目標名牌上顯示戰鬥文字"
--[[ zhTW ]] L["Enable Group"] = "啟用隊伍"
--[[ zhTW ]] L["Show combat text on group member nameplates"] = "在隊伍成員名牌上顯示戰鬥文字"
--[[ zhTW ]] L["Enable Other"] = "啟用其他"
--[[ zhTW ]] L["Show combat text on other nameplates"] = "在其他名牌上顯示戰鬥文字"

--[[ zhTW ]] L["Damage/Healing By Player"] = "由玩家的傷害/治療"
--[[ zhTW ]] L["Show combat text for damage/healing done by the player"] = "顯示由玩家造成的傷害/治療文字"
--[[ zhTW ]] L["Damage/Healing By Group"] = "由隊伍的傷害/治療"
--[[ zhTW ]] L["Show combat text for damage/healing done by group members (including pets)"] = "顯示由隊伍成員(包含寵物)造成的傷害/治療文字"
--[[ zhTW ]] L["Damage/Healing By Other"] = "由其它的傷害/治療"
--[[ zhTW ]] L["Show combat text for damage/healing done by other units"] = "顯示由其它單位造成的傷害/治療文字"
--[[ zhTW ]] L["Include Overhealing"] = "包含過量治療"
--[[ zhTW ]] L["Show combat text for healing that includes overhealing"] = "顯示包含過量治療的治療文字"

--[[ zhTW ]] L["Typeface"] = "字體"
--[[ zhTW ]] L["Combat text typeface options"] = "戰鬥文字字體設定"
--[[ zhTW ]] L["Font"] = "字型"
--[[ zhTW ]] L["Sets the font for combat text"] = "設定戰鬥文字的字型"
--[[ zhTW ]] L["Font Size"] = "字型大小"
--[[ zhTW ]] L["Sets the font height of the combat text"] = "設定戰鬥文字的字型高度"
--[[ zhTW ]] L["Font Shadow"] = "字型陰影"
--[[ zhTW ]] L["Show font shadow on combat text"] = "在戰鬥文字上顯示字型陰影"
--[[ zhTW ]] L["Outline"] = "輪廓"
--[[ zhTW ]] L["Sets the outline for combat text"] = "設定戰鬥文字的字型輪廓"

--[[ zhTW ]] L["Position"] = "位置"
--[[ zhTW ]] L["Adjust combat text position"] = "調整戰鬥文字位置"
--[[ zhTW ]] L["Anchor"] = "錨點"
--[[ zhTW ]] L["Sets the anchor for the combat text"] = "設定戰鬥文字的錨點"
--[[ zhTW ]] L["Anchor To"] = "錨點到"
--[[ zhTW ]] L["Sets the relative point on the health bar to anchor the combat text"] = "設定在生命條上錨到戰鬥文字的相關點"
--[[ zhTW ]] L["X Offset"] = "X偏移"
--[[ zhTW ]] L["X offset of the combat text"] = "戰鬥文字的X偏移"
--[[ zhTW ]] L["Y Offset"] = "Y偏移"
--[[ zhTW ]] L["Y offset of the combat text"] = "戰鬥文字的Y偏移"
--[[ zhTW ]] L["Alpha"] = "透明度"
--[[ zhTW ]] L["Sets the alpha of the combat text"] = "設定戰鬥文字的透明度"

--[[ zhTW ]] L["None"] = "無"
--[[ zhTW ]] L["Normal"] = "正常"
--[[ zhTW ]] L["Thick"] = "粗"

--[[ zhTW ]] L["Colors"] = "顏色"
--[[ zhTW ]] L["Customize colors"] = "自定顏色"
--[[ zhTW ]] L["Physical"] = "物理"
--[[ zhTW ]] L["Sets the color for physical damage"] = "設定物理傷害的顏色"
--[[ zhTW ]] L["Holy"] = "神聖"
--[[ zhTW ]] L["Sets the color for holy damage"] = "設定神聖傷害的顏色"
--[[ zhTW ]] L["Fire"] = "火焰"
--[[ zhTW ]] L["Sets the color for fire damage"] = "設定火焰傷害的顏色"
--[[ zhTW ]] L["Nature"] = "自然"
--[[ zhTW ]] L["Sets the color for nature damage"] = "設定自然傷害的顏色"
--[[ zhTW ]] L["Frost"] = "冰霜"
--[[ zhTW ]] L["Sets the color for frost damage"] = "設定冰霜傷害的顏色"
--[[ zhTW ]] L["Shadow"] = "暗影"
--[[ zhTW ]] L["Sets the color for shadow damage"] = "設定暗影傷害的顏色"
--[[ zhTW ]] L["Arcane"] = "秘法"
--[[ zhTW ]] L["Sets the color for arcane damage"] = "設定秘法傷害的顏色"
--[[ zhTW ]] L["Heal"] = "治療"
--[[ zhTW ]] L["Sets the color for healing"] = "設定治療的顏色"
--[[ zhTW ]] L["Text"] = "文字"
--[[ zhTW ]] L["Sets the color for text feedback"] = "設定文字回應的顏色"
--[[ zhTW ]] L["Default"] = "預設"
--[[ zhTW ]] L["Sets the default combat text color"] = "設定預設戰鬥文字顏色"
--[[ zhTW ]] L["Reset"] = "重置"
--[[ zhTW ]] L["Resets all of the colors to default"] = "重置全部顏色到預設"
--[[ zhTW ]] L["Set All"] = "設定全部"
--[[ zhTW ]] L["Sets all of the colors"] = "設定全部顏色"

--[[ zhTW ]] L["TOPLEFT"] = "上左"
--[[ zhTW ]] L["TOP"] = "上"
--[[ zhTW ]] L["TOPRIGHT"] = "上右"
--[[ zhTW ]] L["LEFT"] = "左"
--[[ zhTW ]] L["CENTER"] = "中"
--[[ zhTW ]] L["RIGHT"] = "右"
--[[ zhTW ]] L["BOTTOMLEFT"] = "下左"
--[[ zhTW ]] L["BOTTOM"] = "下"
--[[ zhTW ]] L["BOTTOMRIGHT"] = "下右"

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftCombatText"] = "Aloft戰鬥文字"
--[[ zhTW ]] mL["Display combat text on group member nameplates"] = "在隊伍成員名牌上顯示戰鬥文字"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

AloftLocale.AloftCombatText = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------
