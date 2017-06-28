local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
if not AloftLocale or not AloftLocale.AloftModules then return end

-----------------------------------------------------------------------------

local L = { }

local mL = AloftLocale.AloftModules

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

-- TODO: on the surface, this wastes space in the enUS locale; the metatable could just return the canonical string as the localization;
--       BUT, this serves as a default locale, and also will permit the metatable to check/notify on missing locale strings

--[[ enUS ]] L["Health Text"] = "Health Text"
--[[ enUS ]] L["Health text options"] = "Health text options"
--[[ enUS ]] L["Enable"] = "Enable"
--[[ enUS ]] L["Show health text on nameplates"] = "Show health text on nameplates"
--[[ enUS ]] L["Unknown"] = "Unknown" -- unit name for "Unknown" units

--[[ enUS ]] L["Typeface"] = "Typeface"
--[[ enUS ]] L["Health text typeface options"] = "Health text typeface options"
--[[ enUS ]] L["Font"] = "Font"
--[[ enUS ]] L["Sets the font for health text"] = "Sets the font for health text"
--[[ enUS ]] L["Font Size"] = "Font Size"
--[[ enUS ]] L["Sets the font height of the health text"] = "Sets the font height of the health text"
--[[ enUS ]] L["Font Shadow"] = "Font Shadow"
--[[ enUS ]] L["Show font shadow on health text"] = "Show font shadow on health text"
--[[ enUS ]] L["Outline"] = "Outline"
--[[ enUS ]] L["Sets the outline for health text"] = "Sets the outline for health text"
--[[ enUS ]] L["Mode"] = "Mode"
--[[ enUS ]] L["Choose what to show for health text"] = "Choose what to show for health text"

--[[ enUS ]] L["Position"] = "Position"
--[[ enUS ]] L["Adjust health text position"] = "Adjust health text position"
--[[ enUS ]] L["Anchor"] = "Anchor"
--[[ enUS ]] L["Sets the anchor for the health text"] = "Sets the anchor for the health text"
--[[ enUS ]] L["Anchor To"] = "Anchor To"
--[[ enUS ]] L["Sets the relative point on the health bar to anchor the health text"] = "Sets the relative point on the health bar to anchor the health text"
--[[ enUS ]] L["X Offset"] = "X Offset"
--[[ enUS ]] L["X offset of the health text"] = "X offset of the health text"
--[[ enUS ]] L["Y Offset"] = "Y Offset"
--[[ enUS ]] L["Y offset of the health text"] = "Y offset of the health text"
--[[ enUS ]] L["Alpha"] = "Alpha"
--[[ enUS ]] L["Sets the alpha of the health text"] = "Sets the alpha of the health text"
--[[ enUS ]] L["Color"] = "Color"
--[[ enUS ]] L["Sets the health text color"] = "Sets the health text color"

--[[ enUS ]] L["None"] = "None"
--[[ enUS ]] L["Normal"] = "Normal"
--[[ enUS ]] L["Thick"] = "Thick"

--[[ enUS ]] L["Percent"] = "Percent"
--[[ enUS ]] L["Group Health"] = "Group Health"
--[[ enUS ]] L["Group Health Deficit"] = "Group Health Deficit"
--[[ enUS ]] L["Health"] = "Health"
--[[ enUS ]] L["Health & Percent"] = "Health & Percent"
--[[ enUS ]] L["Full"] = "Full"
--[[ enUS ]] L["Smart"] = "Smart"

--[[ enUS ]] L["Advanced"] = "Advanced"
--[[ enUS ]] L["Options for expert users"] = "Options for expert users"
--[[ enUS ]] L["Format"] = "Format"
--[[ enUS ]] L["Health tag"] = "Health tag"
--[[ enUS ]] L["<Any tag string>"] = "<Any tag string>"

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

--[[ enUS ]] mL["AloftHealthText"] = "AloftHealthText"
--[[ enUS ]] mL["Display health data and text on nameplates"] = "Display health data and text on nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

--[[ koKR ]] L["Health Text"] = "생명력 수치"
--[[ koKR ]] L["Health text options"] = "생명력 수치 설정"
--[[ koKR ]] L["Enable"] = "사용"
--[[ koKR ]] L["Show health text on nameplates"] = "이름표에 생명력 수치를 표시합니다."
--[[ koKR ]] L["Unknown"] = "Unknown" -- unit name for "Unknown" units

--[[ koKR ]] L["Typeface"] = "서체"
--[[ koKR ]] L["Health text typeface options"] = "생명력 수치 서체 설정"
--[[ koKR ]] L["Font"] = "글꼴"
--[[ koKR ]] L["Sets the font for health text"] = "생명력 수치의 글꼴을 설정합니다."
--[[ koKR ]] L["Font Size"] = "글꼴 크기"
--[[ koKR ]] L["Sets the font height of the health text"] = "생명력 수치의 크기를 설정합니다."
--[[ koKR ]] L["Font Shadow"] = "글꼴 그림자"
--[[ koKR ]] L["Show font shadow on health text"] = "생명력 수치에 그림자를 표시합니다."
--[[ koKR ]] L["Outline"] = "테두리"
--[[ koKR ]] L["Sets the outline for health text"] = "생명력 수치의 테두리를 설정합니다."
--[[ koKR ]] L["Mode"] = "모드"
--[[ koKR ]] L["Choose what to show for health text"] = "생명력 수치의 표시 방법을 선택합니다."

--[[ koKR ]] L["Position"] = "위치"
--[[ koKR ]] L["Adjust health text position"] = "생명력 수치 위치 조절"
--[[ koKR ]] L["Anchor"] = "앵커"
--[[ koKR ]] L["Sets the anchor for the health text"] = "생명력 수치의 앵커를 설정합니다."
--[[ koKR ]] L["Anchor To"] = "앵커 위치"
--[[ koKR ]] L["Sets the relative point on the health bar to anchor the health text"] = "생명력 바에서 생명력 수치의 앵커 위치를 설정합니다."
--[[ koKR ]] L["X Offset"] = "X 좌표"
--[[ koKR ]] L["X offset of the health text"] = "생명력 수치의 X 좌표 입니다."
--[[ koKR ]] L["Y Offset"] = "Y 좌표"
--[[ koKR ]] L["Y offset of the health text"] = "생명력 수치의 Y 좌표 입니다."
--[[ koKR ]] L["Alpha"] = "투명도"
--[[ koKR ]] L["Sets the alpha of the health text"] = "생명력 수치의 투명도를 설정합니다."
--[[ koKR ]] L["Color"] = "색상"
--[[ koKR ]] L["Sets the health text color"] = "생명력 수치의 색상을 설정합니다."

--[[ koKR ]] L["None"] = "없음"
--[[ koKR ]] L["Normal"] = "기본"
--[[ koKR ]] L["Thick"] = "굵게"

--[[ koKR ]] L["Percent"] = "백분율"
--[[ koKR ]] L["Group Health"] = "파티 생명력"
--[[ koKR ]] L["Group Health Deficit"] = "파티 생명력 결손치"
--[[ koKR ]] L["Health"] = "생명력"
--[[ koKR ]] L["Health & Percent"] = "생명력 & 백분율"
--[[ koKR ]] L["Full"] = "가득"
--[[ koKR ]] L["Smart"] = "자동"

--[[ koKR ]] L["Advanced"] = "고급"
--[[ koKR ]] L["Options for expert users"] = "고급 사용자를 위한 설정입니다."
--[[ koKR ]] L["Format"] = "형식"
--[[ koKR ]] L["Health tag"] = "생명력 태그"
--[[ koKR ]] L["<Any tag string>"] = "<태그 문자열>"

--[[ koKR ]] L["TOPLEFT"] = "좌측 상단"
--[[ koKR ]] L["TOP"] = "상단"
--[[ koKR ]] L["TOPRIGHT"] = "우측 상단"
--[[ koKR ]] L["LEFT"] = "좌측"
--[[ koKR ]] L["CENTER"] = "가운데"
--[[ koKR ]] L["RIGHT"] = "우측"
--[[ koKR ]] L["BOTTOMLEFT"] = "좌측 하단"
--[[ koKR ]] L["BOTTOM"] = "하단"
--[[ koKR ]] L["BOTTOMRIGHT"] = "우측 하단"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftHealthText"] = "AloftHealthText"
--[[ koKR ]] mL["Display health data and text on nameplates"] = "Display health data and text on nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Health Text"] = "Текст здоровья"
--[[ ruRU ]] L["Health text options"] = "Настройка текста здоровья"
--[[ ruRU ]] L["Enable"] = "Включить"
--[[ ruRU ]] L["Show health text on nameplates"] = "Отображать текст здоровья на табличках"
--[[ ruRU ]] L["Unknown"] = "Unknown" -- unit name for "Unknown" units

--[[ ruRU ]] L["Typeface"] = "Шрифт"
--[[ ruRU ]] L["Health text typeface options"] = "Настройка шрифта текста здоровья"
--[[ ruRU ]] L["Font"] = "Шрифт"
--[[ ruRU ]] L["Sets the font for health text"] = "Задает шрифт для текста здоровья"
--[[ ruRU ]] L["Font Size"] = "Размер шрифта"
--[[ ruRU ]] L["Sets the font height of the health text"] = "Задает высоту шрифта для текста здоровья"
--[[ ruRU ]] L["Font Shadow"] = "Тень шрифта"
--[[ ruRU ]] L["Show font shadow on health text"] = "Отображать тень для текста здоровья"
--[[ ruRU ]] L["Outline"] = "Контур"
--[[ ruRU ]] L["Sets the outline for health text"] = "Задает окантовку для текста здоровья"
--[[ ruRU ]] L["Mode"] = "Режим"
--[[ ruRU ]] L["Choose what to show for health text"] = "Выбрать, что показывать в тексте здоровья"

--[[ ruRU ]] L["Position"] = "Позиция"
--[[ ruRU ]] L["Adjust health text position"] = "Задать место текста здоровья"
--[[ ruRU ]] L["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] L["Sets the anchor for the health text"] = "Задает прикрепление текста здоровья"
--[[ ruRU ]] L["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] L["Sets the relative point on the health bar to anchor the health text"] = "Задает точку для положения текста здоровья относительно полоски здоровья"
--[[ ruRU ]] L["X Offset"] = "Смещение по X"
--[[ ruRU ]] L["X offset of the health text"] = "Смещение текста здоровья по X"
--[[ ruRU ]] L["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] L["Y offset of the health text"] = "Смещение полоски здоровья по Y"
--[[ ruRU ]] L["Alpha"] = "Прозрачность"
--[[ ruRU ]] L["Sets the alpha of the health text"] = "Задает прозрачность текста здоровья"
--[[ ruRU ]] L["Color"] = "Цвет"
--[[ ruRU ]] L["Sets the health text color"] = "Задает цвет текста здоровья"

--[[ ruRU ]] L["None"] = "Нет"
--[[ ruRU ]] L["Normal"] = "Обычно"
--[[ ruRU ]] L["Thick"] = "Жирный"

--[[ ruRU ]] L["Percent"] = "Проценты"
--[[ ruRU ]] L["Group Health"] = "Здоровье группы"
--[[ ruRU ]] L["Group Health Deficit"] = "Дефицит здоровья группы"
--[[ ruRU ]] L["Health"] = "Здоровье"
--[[ ruRU ]] L["Health & Percent"] = "Здоровье & Проценты"
--[[ ruRU ]] L["Full"] = "Полное"
--[[ ruRU ]] L["Smart"] = "Умное"

--[[ ruRU ]] L["Advanced"] = "Дополнительно"
--[[ ruRU ]] L["Options for expert users"] = "Настройки для опытных пользователей"
--[[ ruRU ]] L["Format"] = "Формат"
--[[ ruRU ]] L["Health tag"] = "Вид здоровья"
--[[ ruRU ]] L["<Any tag string>"] = "<Любая строка формата>"

--[[ ruRU ]] L["TOPLEFT"] = "ВВЕРХУ-СЛЕВА"
--[[ ruRU ]] L["TOP"] = "ВВЕРХУ"
--[[ ruRU ]] L["TOPRIGHT"] = "ВВЕРХУ-СПРАВА"
--[[ ruRU ]] L["LEFT"] = "СЛЕВА"
--[[ ruRU ]] L["CENTER"] = "ПО ЦЕНТРУ"
--[[ ruRU ]] L["RIGHT"] = "СПРАВА"
--[[ ruRU ]] L["BOTTOMLEFT"] = "СНИЗУ-СЛЕВА"
--[[ ruRU ]] L["BOTTOM"] = "СНИЗУ"
--[[ ruRU ]] L["BOTTOMRIGHT"] = "СНИЗУ-СПРАВА"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftHealthText"] = "AloftHealthText"
--[[ ruRU ]] mL["Display health data and text on nameplates"] = "Отображает данные/тект здоровья"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Health Text"] = "生命值提示文字"
--[[ zhCN ]] L["Health text options"] = "生命值提示文字相关设置"
--[[ zhCN ]] L["Enable"] = "启用"
--[[ zhCN ]] L["Show health text on nameplates"] = "在姓名板上显示生命值提示文字"
--[[ zhCN ]] L["Unknown"] = "Unknown" -- unit name for "Unknown" units

--[[ zhCN ]] L["Typeface"] = "式样"
--[[ zhCN ]] L["Health text typeface options"] = "生命值提示文字的式样设置"
--[[ zhCN ]] L["Font"] = "字体"
--[[ zhCN ]] L["Sets the font for health text"] = "设定生命值提示文字的字体"
--[[ zhCN ]] L["Font Size"] = "字号"
--[[ zhCN ]] L["Sets the font height of the health text"] = "设定生命值提示文字的字号"
--[[ zhCN ]] L["Font Shadow"] = "字体阴影"
--[[ zhCN ]] L["Show font shadow on health text"] = "显示生命值提示文字的字体阴影"
--[[ zhCN ]] L["Outline"] = "轮廓"
--[[ zhCN ]] L["Sets the outline for health text"] = "设定生命值提示文字的字体轮廓"
--[[ zhCN ]] L["Mode"] = "模式"
--[[ zhCN ]] L["Choose what to show for health text"] = "选择生命值提示文字的显示方式"

--[[ zhCN ]] L["Position"] = "位置"
--[[ zhCN ]] L["Adjust health text position"] = "调整生命值提示文字的位置"
--[[ zhCN ]] L["Anchor"] = "锚点"
--[[ zhCN ]] L["Sets the anchor for the health text"] = "设定生命值提示文字的锚点"
--[[ zhCN ]] L["Anchor To"] = "固定在"
--[[ zhCN ]] L["Sets the relative point on the health bar to anchor the health text"] = "设定生命值提示文字固定在生命值显示条的相对位置"
--[[ zhCN ]] L["X Offset"] = "X轴偏移"
--[[ zhCN ]] L["X offset of the health text"] = "生命值提示文字的X轴偏移量"
--[[ zhCN ]] L["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] L["Y offset of the health text"] = "生命值提示文字的Y轴偏移量"
--[[ zhCN ]] L["Alpha"] = "透明度"
--[[ zhCN ]] L["Sets the alpha of the health text"] = "设定生命值提示文字的透明度"
--[[ zhCN ]] L["Color"] = "颜色"
--[[ zhCN ]] L["Sets the health text color"] = "设定生命值提示文字的颜色"

--[[ zhCN ]] L["None"] = "无"
--[[ zhCN ]] L["Normal"] = "正常"
--[[ zhCN ]] L["Thick"] = "粗"

--[[ zhCN ]] L["Percent"] = "百分比"
--[[ zhCN ]] L["Group Health"] = "队友生命值"
--[[ zhCN ]] L["Group Health Deficit"] = "队友生命值不足额"
--[[ zhCN ]] L["Health"] = "生命值"
--[[ zhCN ]] L["Health & Percent"] = "生命值和百分比"
--[[ zhCN ]] L["Full"] = "完全"
--[[ zhCN ]] L["Smart"] = "智能"

--[[ zhCN ]] L["Advanced"] = "高级"
--[[ zhCN ]] L["Options for expert users"] = "高级设置"
--[[ zhCN ]] L["Format"] = "格式"
--[[ zhCN ]] L["Health tag"] = "生命值标签"
--[[ zhCN ]] L["<Any tag string>"] = "<任意标签文字>"

--[[ zhCN ]] L["TOPLEFT"] = "左上"
--[[ zhCN ]] L["TOP"] = "上"
--[[ zhCN ]] L["TOPRIGHT"] = "右上"
--[[ zhCN ]] L["LEFT"] = "左"
--[[ zhCN ]] L["CENTER"] = "中"
--[[ zhCN ]] L["RIGHT"] = "右"
--[[ zhCN ]] L["BOTTOMLEFT"] = "左下"
--[[ zhCN ]] L["BOTTOM"] = "下"
--[[ zhCN ]] L["BOTTOMRIGHT"] = "右下"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftHealthText"] = "生命值"
--[[ zhCN ]] mL["Display health data and text on nameplates"] = "在姓名板上显示生命值数据和文字"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Health Text"] = "生命文字"
--[[ zhTW ]] L["Health text options"] = "生命文字設定"
--[[ zhTW ]] L["Enable"] = "啟用"
--[[ zhTW ]] L["Show health text on nameplates"] = "在名牌顯示生命文字"
--[[ zhTW ]] L["Unknown"] = "未知" -- unit name for "Unknown" units

--[[ zhTW ]] L["Typeface"] = "字體"
--[[ zhTW ]] L["Health text typeface options"] = "生命文字字體設定"
--[[ zhTW ]] L["Font"] = "字型"
--[[ zhTW ]] L["Sets the font for health text"] = "設定生命文字的字型"
--[[ zhTW ]] L["Font Size"] = "字型大小"
--[[ zhTW ]] L["Sets the font height of the health text"] = "設定生命文字的字型高度"
--[[ zhTW ]] L["Font Shadow"] = "字型陰影"
--[[ zhTW ]] L["Show font shadow on health text"] = "設定生命文字的字型陰影"
--[[ zhTW ]] L["Outline"] = "輪廓"
--[[ zhTW ]] L["Sets the outline for health text"] = "設定生命文字的字型輪廓"
--[[ zhTW ]] L["Mode"] = "模式"
--[[ zhTW ]] L["Choose what to show for health text"] = "選擇在生命文字顯示什麼"

--[[ zhTW ]] L["Position"] = "位置"
--[[ zhTW ]] L["Adjust health text position"] = "調整生命文字位置"
--[[ zhTW ]] L["Anchor"] = "錨點"
--[[ zhTW ]] L["Sets the anchor for the health text"] = "設定生命文字的錨點"
--[[ zhTW ]] L["Anchor To"] = "錨點在"
--[[ zhTW ]] L["Sets the relative point on the health bar to anchor the health text"] = "設定在生命條上錨到生命文字的相關點"
--[[ zhTW ]] L["X Offset"] = "X偏移"
--[[ zhTW ]] L["X offset of the health text"] = "生命文字的X偏移"
--[[ zhTW ]] L["Y Offset"] = "Y偏移"
--[[ zhTW ]] L["Y offset of the health text"] = "生命文字的Y偏移"
--[[ zhTW ]] L["Alpha"] = "透明度"
--[[ zhTW ]] L["Sets the alpha of the health text"] = "設定生命文字的透明度"
--[[ zhTW ]] L["Color"] = "顏色"
--[[ zhTW ]] L["Sets the health text color"] = "設定生命文字顏色"

--[[ zhTW ]] L["None"] = "無"
--[[ zhTW ]] L["Normal"] = "正常"
--[[ zhTW ]] L["Thick"] = "粗"

--[[ zhTW ]] L["Percent"] = "百分比"
--[[ zhTW ]] L["Group Health"] = "隊伍生命"
--[[ zhTW ]] L["Group Health Deficit"] = "隊伍生命虧減"
--[[ zhTW ]] L["Health"] = "生命"
--[[ zhTW ]] L["Health & Percent"] = "生命和百分比"
--[[ zhTW ]] L["Full"] = "完全"
--[[ zhTW ]] L["Smart"] = "精明"

--[[ zhTW ]] L["Advanced"] = "進階"
--[[ zhTW ]] L["Options for expert users"] = "熟練的使用者設定"
--[[ zhTW ]] L["Format"] = "格式"
--[[ zhTW ]] L["Health tag"] = "生命標籤"
--[[ zhTW ]] L["<Any tag string>"] = "<任何標籤文字>"

--[[ zhTW ]] L["TOPLEFT"] = "上左"
--[[ zhTW ]] L["TOP"] = "上"
--[[ zhTW ]] L["TOPRIGHT"] = "上右"
--[[ zhTW ]] L["LEFT"] = "左"
--[[ zhTW ]] L["CENTER"] = "中"
--[[ zhTW ]] L["RIGHT"] = "右"
--[[ zhTW ]] L["BOTTOMLEFT"] = "下左"
--[[ zhTW ]] L["BOTTOM"] = "下"
--[[ zhTW ]] L["BOTTOMRIGHT"] = "下右"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftHealthText"] = "Aloft生命文字"
--[[ zhTW ]] mL["Display health data and text on nameplates"] = "在名牌上顯示生命資料和文字"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

AloftLocale.AloftHealthText = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

-----------------------------------------------------------------------------

end)
