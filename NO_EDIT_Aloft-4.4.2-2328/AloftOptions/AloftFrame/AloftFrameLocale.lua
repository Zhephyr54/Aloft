local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Enable Mouse"] = "Enable Mouse"
--[[ enUS ]] L["Allows left click to target and right click to interact"] = "Allows left click to target and right click to interact"

--[[ enUS ]] L["Frame"] = "Frame"
--[[ enUS ]] L["Frame options"] = "Frame options"
--[[ enUS ]] L["Width"] = "Width"
--[[ enUS ]] L["Sets the width of the frame"] = "Sets the width of the frame"
--[[ enUS ]] L["Height"] = "Height"
--[[ enUS ]] L["Sets the height of the frame"] = "Sets the height of the frame"

--[[ enUS ]] L["Packing Width"] = "Packing Width"
--[[ enUS ]] L["Sets the minimum horizontal distance between frames"] = "Sets the minimum horizontal distance between frames"
--[[ enUS ]] L["Packing Height"] = "Packing Height"
--[[ enUS ]] L["Sets the minimum vertical distance between frames"] = "Sets the minimum vertical distance between frames"

--[[ enUS ]] L["Position"] = "Position"
--[[ enUS ]] L["Adjust layout base and background position"] = "Adjust layout base and background position"
--[[ enUS ]] L["X Offset"] = "X Offset"
--[[ enUS ]] L["X offset of the layout base and background"] = "X offset of the layout base and background"
--[[ enUS ]] L["Y Offset"] = "Y Offset"
--[[ enUS ]] L["Y offset of the layout base and background"] = "Y offset of the layout base and background"

--[[ enUS ]] L["Background"] = "Background"
--[[ enUS ]] L["Background options"] = "Background options"
--[[ enUS ]] L["Background Alpha"] = "Background Alpha"
--[[ enUS ]] L["Sets the alpha for the background of the nameplates"] = "Sets the alpha for the background of the nameplates"
--[[ enUS ]] L["Background Colors"] = "Background Colors"
--[[ enUS ]] L["Customize colors"] = "Customize colors"

--[[ enUS ]] L["Color by Class"] = "Color by Class"
--[[ enUS ]] L["Sets the background color according to class"] = "Sets the background color according to class"
--[[ enUS ]] L["Color Hostile by Class"] = "Color Hostile by Class"
--[[ enUS ]] L["Sets the background color of hostile players according to class"] = "Sets the background color of hostile players according to class"
--[[ enUS ]] L["Set All"] = "Set All"
--[[ enUS ]] L["Sets the background color for all types"] = "Sets the background color for all types"

--[[ enUS ]] L["Set All Friendly"] = "Set All Friendly"
--[[ enUS ]] L["Sets the background color for all friendly types"] = "Sets the background color for all friendly types"
--[[ enUS ]] L["Set All Hostile"] = "Set All Hostile"
--[[ enUS ]] L["Sets the background color for all hostile types"] = "Sets the background color for all hostile types"
--[[ enUS ]] L["Unknown"] = "Unknown"
--[[ enUS ]] L["Sets the background color for unknown units"] = "Sets the background color for unknown units"

--[[ enUS ]] L["Pet"] = "Pet"
--[[ enUS ]] L["Sets the background color for your pet"] = "Sets the background color for your pet"
--[[ enUS ]] L["Friendly Players"] = "Friendly Players"
--[[ enUS ]] L["Sets the background color for friendly players"] = "Sets the background color for friendly players"
--[[ enUS ]] L["Friendly Pets"] = "Friendly Pets"
--[[ enUS ]] L["Sets the background color for friendly pets"] = "Sets the background color for friendly pets"
--[[ enUS ]] L["Friendly NPCs"] = "Friendly NPCs"
--[[ enUS ]] L["Sets the background color for friendly NPC Bosses"] = "Sets the background color for friendly NPC Bosses"
--[[ enUS ]] L["Friendly Boss"] = "Friendly Boss"
--[[ enUS ]] L["Sets the background color for friendly NPCs"] = "Sets the background color for friendly NPCs"
--[[ enUS ]] L["Hostile Players"] = "Hostile Players"
--[[ enUS ]] L["Sets the background color for hostile players"] = "Sets the background color for hostile players"
--[[ enUS ]] L["Hostile Pets"] = "Hostile Pets"
--[[ enUS ]] L["Sets the background color for hostile pets"] = "Sets the background color for hostile pets"
--[[ enUS ]] L["Hostile NPCs"] = "Hostile NPCs"
--[[ enUS ]] L["Sets the background color for hostile units"] = "Sets the background color for hostile units"
--[[ enUS ]] L["Hostile Boss"] = "Hostile Boss"
--[[ enUS ]] L["Sets the background color for hostile boss units"] = "Sets the background color for hostile boss units"
--[[ enUS ]] L["Neutral Units"] = "Neutral Units"
--[[ enUS ]] L["Sets the background color for neutral units"] = "Sets the background color for neutral units"
--[[ enUS ]] L["Group Pets"] = "Group Pets"
--[[ enUS ]] L["Sets the background color for group pets"] = "Sets the background color for group pets"

--[[ enUS ]] L["Advanced"] = "Advanced"
--[[ enUS ]] L["Options for expert users"] = "Options for expert users"
--[[ enUS ]] L["Color Format"] = "Color Format"
--[[ enUS ]] L["Color tag"] = "Color tag"
--[[ enUS ]] L["<Any tag string>"] = "<Any tag string>"

--[[ enUS ]] L["Border"] = "Border"
--[[ enUS ]] L["Border options"] = "Border options"
--[[ enUS ]] L["Target Only"] = "Target Only"
--[[ enUS ]] L["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ enUS ]] L["Border Edge Size"] = "Border Edge Size"
--[[ enUS ]] L["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ enUS ]] L["Border Inset"] = "Border Inset"
--[[ enUS ]] L["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ enUS ]] L["Border Color"] = "Border Color"
--[[ enUS ]] L["Sets the border color of the nameplate"] = "Sets the border color of the nameplate"
--[[ enUS ]] L["Border Style"] = "Border Style"
--[[ enUS ]] L["Sets the style of the nameplate border"] = "Sets the style of the nameplate border"
--[[ enUS ]] L["Background Style"] = "Background Style"
--[[ enUS ]] L["Sets the style of the nameplate background"] = "Sets the style of the nameplate background"

--[[ enUS ]] L["NONE"] = "None"
--[[ enUS ]] L["STANDARD"] = "Standard"
--[[ enUS ]] L["SQUARE"] = "Square"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Enable Mouse"] = "마우스 사용"
--[[ koKR ]] L["Allows left click to target and right click to interact"] = "행동을 위한 우클릭과 대상에 좌클릭을 허용합니다."

--[[ koKR ]] L["Frame"] = "프레임"
--[[ koKR ]] L["Frame options"] = "프레임 설정입니다."
--[[ koKR ]] L["Width"] = "너비"
--[[ koKR ]] L["Sets the width of the frame"] = "프레임의 너비를 설정합니다."
--[[ koKR ]] L["Height"] = "높이"
--[[ koKR ]] L["Sets the height of the frame"] = "프레임의 높이를 설정합니다."

--[[ koKR ]] L["Packing Width"] = "패킹 넓이"
--[[ koKR ]] L["Sets the minimum horizontal distance between frames"] = "프레임 사이의 최소 수평 거리를 설정합니다."
--[[ koKR ]] L["Packing Height"] = "패킹 높이"
--[[ koKR ]] L["Sets the minimum vertical distance between frames"] = "프레임 사이의 최소 수직 거리를 설정합니다."

--[[ koKR ]] L["Position"] = "Position"
--[[ koKR ]] L["Adjust layout base and background position"] = "Adjust layout base and background position"
--[[ koKR ]] L["X Offset"] = "X Offset"
--[[ koKR ]] L["X offset of the layout base and background"] = "X offset of the layout base and background"
--[[ koKR ]] L["Y Offset"] = "Y Offset"
--[[ koKR ]] L["Y offset of the layout base and background"] = "Y offset of the layout base and background"

--[[ koKR ]] L["Background"] = "Background"
--[[ koKR ]] L["Background options"] = "Background options"
--[[ koKR ]] L["Background Alpha"] = "배경 투명도"
--[[ koKR ]] L["Sets the alpha for the background of the nameplates"] = "이름표의 배경에 대한 투명도를 설정합니다."
--[[ koKR ]] L["Background Colors"] = "배경 색상"
--[[ koKR ]] L["Customize colors"] = "사용자 색상"

--[[ koKR ]] L["Color by Class"] = "직업별 색상"
--[[ koKR ]] L["Sets the background color according to class"] = "직업별 색상을 배경 색상으로 설정합니다."
--[[ koKR ]] L["Color Hostile by Class"] = "적대적 직업별 색상"
--[[ koKR ]] L["Sets the background color of hostile players according to class"] = "직업별 색상을 적대적 플레이어의 배경 색상으로 설정합니다."
--[[ koKR ]] L["Set All"] = "전체 설정"
--[[ koKR ]] L["Sets the background color for all types"] = "전체의 배경 색상을 설정합니다."

--[[ koKR ]] L["Set All Friendly"] = "전체 우호적 설정"
--[[ koKR ]] L["Sets the background color for all friendly types"] = "전체 우호적 대상에 대한 배경 색상을 설정합니다."
--[[ koKR ]] L["Set All Hostile"] = "전체 적대적 설정"
--[[ koKR ]] L["Sets the background color for all hostile types"] = "전체 적대적 대상에 대한 배경 색상을 설정합니다."

--[[ koKR ]] L["Pet"] = "소환수"
--[[ koKR ]] L["Sets the background color for your pet"] = "소환수에 대한 배경 색상을 설정합니다."
--[[ koKR ]] L["Friendly Players"] = "우호적 플레이어"
--[[ koKR ]] L["Sets the background color for friendly players"] = "우호적 플레이어에 대한 배경 색상을 설정합니다."
--[[ koKR ]] L["Friendly Pets"] = "우호적 소환수"
--[[ koKR ]] L["Sets the background color for friendly pets"] = "우호적 소환수에 대한 배경 색상을 설정합니다."
--[[ koKR ]] L["Friendly NPCs"] = "우호적 NPC"
--[[ koKR ]] L["Sets the background color for friendly NPC Bosses"] = "우호적 NPC 보스에 대한 배경 색상을 설정합니다."
--[[ koKR ]] L["Friendly Boss"] = "우호적 보스"
--[[ koKR ]] L["Sets the background color for friendly NPCs"] = "우호적 NPC에 대한 배경 색상을 설정합니다."
--[[ koKR ]] L["Hostile Players"] = "적대적 플레이어"
--[[ koKR ]] L["Sets the background color for hostile players"] = "적대적 플레이어에 대한 배경 색상을 설정합니다."
--[[ koKR ]] L["Hostile Pets"] = "적대적 소환수"
--[[ koKR ]] L["Sets the background color for hostile pets"] = "적대적 소환수에 대한 배경 색상을 설정합니다."
--[[ koKR ]] L["Hostile NPCs"] = "적대적 NPC"
--[[ koKR ]] L["Sets the background color for hostile units"] = "적대적 대상에 대한 배경 색상을 설정합니다."
--[[ koKR ]] L["Hostile Boss"] = "적대적 보스"
--[[ koKR ]] L["Sets the background color for hostile boss units"] = "적대적 보스에 대한 배경 색상을 설정합니다."
--[[ koKR ]] L["Neutral Units"] = "중립적 대상"
--[[ koKR ]] L["Sets the background color for neutral units"] = "중립적 대상에 대한 배경 색상을 설정합니다."
--[[ koKR ]] L["Group Pets"] = "파티 소환수"
--[[ koKR ]] L["Sets the background color for group pets"] = "파티 소환수에 대한 배경 색상을 설정합니다."
--[[ koKR ]] L["Unknown"] = "Unknown"
--[[ koKR ]] L["Sets the background color for unknown units"] = "Sets the background color for unknown units"

--[[ koKR ]] L["Advanced"] = "고급"
--[[ koKR ]] L["Options for expert users"] = "고급 사용자를 위한 설정입니다."
--[[ koKR ]] L["Color Format"] = "색상 형식"
--[[ koKR ]] L["Color tag"] = "색상 태그"
--[[ koKR ]] L["<Any tag string>"] = "<태그 문자열>"

--[[ koKR ]] L["Border"] = "Border"
--[[ koKR ]] L["Border options"] = "Border options"
--[[ koKR ]] L["Target Only"] = "Target Only"
--[[ koKR ]] L["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ koKR ]] L["Border Edge Size"] = "Border Edge Size"
--[[ koKR ]] L["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ koKR ]] L["Border Inset"] = "Border Inset"
--[[ koKR ]] L["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ koKR ]] L["Border Color"] = "테두리 색상"
--[[ koKR ]] L["Sets the border color of the nameplate"] = "이름표의 테두리 색상을 설정합니다."
--[[ koKR ]] L["Border Style"] = "테두리 스타일"
--[[ koKR ]] L["Sets the style of the nameplate border"] = "이름표 테두리의 스타일을 설정합니다."
--[[ koKR ]] L["Background Style"] = "배경 유형"
--[[ koKR ]] L["Sets the style of the nameplate background"] = "이름표 배경의 유형을 설정합니다."

--[[ koKR ]] L["NONE"] = "없음"
--[[ koKR ]] L["STANDARD"] = "기본형"
--[[ koKR ]] L["SQUARE"] = "사각형"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Enable Mouse"] = "Включить мышь"
--[[ ruRU ]] L["Allows left click to target and right click to interact"] = "Позволяет кликом левой кнопки выделять и кликом правой кнопки взаимодействовать"

--[[ ruRU ]] L["Frame"] = "Фрейм"
--[[ ruRU ]] L["Frame options"] = "Настройки фрейма"
--[[ ruRU ]] L["Width"] = "Ширина"
--[[ ruRU ]] L["Sets the width of the frame"] = "Задает ширину фрейма"
--[[ ruRU ]] L["Height"] = "Высота"
--[[ ruRU ]] L["Sets the height of the frame"] = "Задает высоту фрейма"

--[[ ruRU ]] L["Packing Width"] = "Ширина размещения"
--[[ ruRU ]] L["Sets the minimum horizontal distance between frames"] = "Задает минимальное расстояние между двумя фреймами по горизонтали"
--[[ ruRU ]] L["Packing Height"] = "Высота размещения"
--[[ ruRU ]] L["Sets the minimum vertical distance between frames"] = "Задает минимальное расстояние между двумя фреймами по вертикали"

--[[ ruRU ]] L["Position"] = "Позиция"
--[[ ruRU ]] L["Adjust layout base and background position"] = "Регулировка расположения основного слоя и фона"
--[[ ruRU ]] L["X Offset"] = "Смещение по X"
--[[ ruRU ]] L["X offset of the layout base and background"] = "Смещение основного слоя и фона по Х"
--[[ ruRU ]] L["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] L["Y offset of the layout base and background"] = "Смещение основного слоя и фона по Y"

--[[ ruRU ]] L["Background"] = "Фон"
--[[ ruRU ]] L["Background options"] = "Опции фона"
--[[ ruRU ]] L["Background Alpha"] = "Прозрачность фона"
--[[ ruRU ]] L["Sets the alpha for the background of the nameplates"] = "Задает прозрачность фона табличек"
--[[ ruRU ]] L["Background Colors"] = "Цвета фона"
--[[ ruRU ]] L["Customize colors"] = "Настройка цветов"

--[[ ruRU ]] L["Color by Class"] = "Окрашивать в цвет класса"
--[[ ruRU ]] L["Sets the background color according to class"] = "Задает цвет фона в зависимости от класса"
--[[ ruRU ]] L["Color Hostile by Class"] = "Окрашивать враждебных в цвет класса"
--[[ ruRU ]] L["Sets the background color of hostile players according to class"] = "Задает цвет фона в зависимости от класса враждебного игрока"
--[[ ruRU ]] L["Set All"] = "Задать все"
--[[ ruRU ]] L["Sets the background color for all types"] = "Задает цвет фона для всех"

--[[ ruRU ]] L["Set All Friendly"] = "Задать всех дружественными"
--[[ ruRU ]] L["Sets the background color for all friendly types"] = "Задает цвет фона для всех дружелюбных"
--[[ ruRU ]] L["Set All Hostile"] = "Задать всех враждебными"
--[[ ruRU ]] L["Sets the background color for all hostile types"] = "Задает цвет фона для всех враждебных"

--[[ ruRU ]] L["Pet"] = "Питомец"
--[[ ruRU ]] L["Sets the background color for your pet"] = "Задает цвет фона для вашего питомца"
--[[ ruRU ]] L["Friendly Players"] = "Дружественные игроки"
--[[ ruRU ]] L["Sets the background color for friendly players"] = "Задает цвет фона для дружественных игроков"
--[[ ruRU ]] L["Friendly Pets"] = "Дружественные питомцы"
--[[ ruRU ]] L["Sets the background color for friendly pets"] = "Задает цвет фона для дружественных питомцев"
--[[ ruRU ]] L["Friendly NPCs"] = "Дружественные NPC"
--[[ ruRU ]] L["Sets the background color for friendly NPC Bosses"] = "Задает цвет фона для дружественных НИПов боссов"
--[[ ruRU ]] L["Friendly Boss"] = "Дружественный босс"
--[[ ruRU ]] L["Sets the background color for friendly NPCs"] = "Задает цвет фона для дружественных НИПов"
--[[ ruRU ]] L["Hostile Players"] = "Враждебные игроки"
--[[ ruRU ]] L["Sets the background color for hostile players"] = "Задает цвет фона для враждебных игроков"
--[[ ruRU ]] L["Hostile Pets"] = "Враждебные питомцы"
--[[ ruRU ]] L["Sets the background color for hostile pets"] = "Задает цвет фона для враждебных питомцев"
--[[ ruRU ]] L["Hostile NPCs"] = "Враждебные NPC"
--[[ ruRU ]] L["Sets the background color for hostile units"] = "Задает цвет фона для враждебных"
--[[ ruRU ]] L["Hostile Boss"] = "Враждебный босс"
--[[ ruRU ]] L["Sets the background color for hostile boss units"] = "Задает цвет фона для враждебных боссов"
--[[ ruRU ]] L["Neutral Units"] = "Нейтриальные цели"
--[[ ruRU ]] L["Sets the background color for neutral units"] = "Задает цвет фона для нейтральных"
--[[ ruRU ]] L["Group Pets"] = "Питомцы группы"
--[[ ruRU ]] L["Sets the background color for group pets"] = "Задает цвет фона для питомцев группы"
--[[ ruRU ]] L["Unknown"] = "Unknown"
--[[ ruRU ]] L["Sets the background color for unknown units"] = "Sets the background color for unknown units"

--[[ ruRU ]] L["Advanced"] = "Дополнительно"
--[[ ruRU ]] L["Options for expert users"] = "Настройки для опытных пользователей"
--[[ ruRU ]] L["Color Format"] = "Формат цвета"
--[[ ruRU ]] L["Color tag"] = "Формат цвета"
--[[ ruRU ]] L["<Any tag string>"] = "<Любая строка формата>"

--[[ ruRU ]] L["Border"] = "Края"
--[[ ruRU ]] L["Border options"] = "Настройки краев"
--[[ ruRU ]] L["Target Only"] = "Только цель"
--[[ ruRU ]] L["Enables the border on the current target only"] = "Включить края только для текущей цели"
--[[ ruRU ]] L["Border Edge Size"] = "Border Edge Size"
--[[ ruRU ]] L["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ ruRU ]] L["Border Inset"] = "Border Inset"
--[[ ruRU ]] L["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ ruRU ]] L["Border Color"] = "Цвет рамки"
--[[ ruRU ]] L["Sets the border color of the nameplate"] = "Задает цвет рамки таблички"
--[[ ruRU ]] L["Border Style"] = "Стиль рамки"
--[[ ruRU ]] L["Sets the style of the nameplate border"] = "Задает стиль для рамки таблички"
--[[ ruRU ]] L["Background Style"] = "Стиль фона"
--[[ ruRU ]] L["Sets the style of the nameplate background"] = "Задает стиль для фона таблички"

--[[ ruRU ]] L["NONE"] = "Нету"
--[[ ruRU ]] L["STANDARD"] = "Стандарт"
--[[ ruRU ]] L["SQUARE"] = "Квадрат"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Enable Mouse"] = "启用鼠标"
--[[ zhCN ]] L["Allows left click to target and right click to interact"] = "设定左键点击为选择目标，右键点击则为弹出选单"

--[[ zhCN ]] L["Frame"] = "框架"
--[[ zhCN ]] L["Frame options"] = "框架相关设置"
--[[ zhCN ]] L["Width"] = "宽度"
--[[ zhCN ]] L["Sets the width of the frame"] = "设定框架的宽度"
--[[ zhCN ]] L["Height"] = "高度"
--[[ zhCN ]] L["Sets the height of the frame"] = "设定框架的高度"

--[[ zhCN ]] L["Packing Width"] = "间隔宽度"
--[[ zhCN ]] L["Sets the minimum horizontal distance between frames"] = "设定框架之间的最小水平间隔"
--[[ zhCN ]] L["Packing Height"] = "间隔高度"
--[[ zhCN ]] L["Sets the minimum vertical distance between frames"] = "设定框架之间的最小垂直间隔"

--[[ zhCN ]] L["Position"] = "Position"
--[[ zhCN ]] L["Adjust layout base and background position"] = "Adjust layout base and background position"
--[[ zhCN ]] L["X Offset"] = "X Offset"
--[[ zhCN ]] L["X offset of the layout base and background"] = "X offset of the layout base and background"
--[[ zhCN ]] L["Y Offset"] = "Y Offset"
--[[ zhCN ]] L["Y offset of the layout base and background"] = "Y offset of the layout base and background"

--[[ zhCN ]] L["Background"] = "Background"
--[[ zhCN ]] L["Background options"] = "Background options"
--[[ zhCN ]] L["Background Alpha"] = "背景透明度"
--[[ zhCN ]] L["Sets the alpha for the background of the nameplates"] = "设定姓名板的背景透明度"
--[[ zhCN ]] L["Background Colors"] = "背景颜色"
--[[ zhCN ]] L["Customize colors"] = "自定义颜色"

--[[ zhCN ]] L["Color by Class"] = "根据职业显示颜色"
--[[ zhCN ]] L["Sets the background color according to class"] = "背景颜色使用职业代表色"
--[[ zhCN ]] L["Color Hostile by Class"] = "敌对方单位根据职业显示颜色"
--[[ zhCN ]] L["Sets the background color of hostile players according to class"] = "敌对方玩家的背景颜色使用职业代表色"
--[[ zhCN ]] L["Set All"] = "设定全部"
--[[ zhCN ]] L["Sets the background color for all types"] = "设定所有单位的背景颜色"

--[[ zhCN ]] L["Set All Friendly"] = "设定全部友好方单位"
--[[ zhCN ]] L["Sets the background color for all friendly types"] = "设定全部友好方单位的背景颜色"
--[[ zhCN ]] L["Set All Hostile"] = "设定全部敌对方单位"
--[[ zhCN ]] L["Sets the background color for all hostile types"] = "设定全部敌对方单位的背景颜色"

--[[ zhCN ]] L["Pet"] = "宠物"
--[[ zhCN ]] L["Sets the background color for your pet"] = "设定你的宠物的背景颜色"
--[[ zhCN ]] L["Friendly Players"] = "友好方玩家"
--[[ zhCN ]] L["Sets the background color for friendly players"] = "设定友好方玩家的背景颜色"
--[[ zhCN ]] L["Friendly Pets"] = "友好方宠物"
--[[ zhCN ]] L["Sets the background color for friendly pets"] = "设定友好方宠物的背景颜色"
--[[ zhCN ]] L["Friendly NPCs"] = "友好方NPC"
--[[ zhCN ]] L["Sets the background color for friendly NPC Bosses"] = "设定友好方首领的背景颜色"
--[[ zhCN ]] L["Friendly Boss"] = "友好方首领"
--[[ zhCN ]] L["Sets the background color for friendly NPCs"] = "设定友好NPC的背景颜色"
--[[ zhCN ]] L["Hostile Players"] = "敌对方玩家"
--[[ zhCN ]] L["Sets the background color for hostile players"] = "设定敌对方玩家的背景颜色"
--[[ zhCN ]] L["Hostile Pets"] = "敌对方宠物"
--[[ zhCN ]] L["Sets the background color for hostile pets"] = "设定敌对方宠物的背景颜色"
--[[ zhCN ]] L["Hostile NPCs"] = "敌对方NPC"
--[[ zhCN ]] L["Sets the background color for hostile units"] = "设定敌对方NPC的背景颜色"
--[[ zhCN ]] L["Hostile Boss"] = "敌对方首领"
--[[ zhCN ]] L["Sets the background color for hostile boss units"] = "设定敌对方首领的背景颜色"
--[[ zhCN ]] L["Neutral Units"] = "中立方单位"
--[[ zhCN ]] L["Sets the background color for neutral units"] = "设定中立方单位的背景颜色"
--[[ zhCN ]] L["Group Pets"] = "队友宠物"
--[[ zhCN ]] L["Sets the background color for group pets"] = "设定队友宠物的背景颜色"
--[[ zhCN ]] L["Unknown"] = "Unknown"
--[[ zhCN ]] L["Sets the background color for unknown units"] = "Sets the background color for unknown units"

--[[ zhCN ]] L["Advanced"] = "高级"
--[[ zhCN ]] L["Options for expert users"] = "高级设置"
--[[ zhCN ]] L["Color Format"] = "颜色格式"
--[[ zhCN ]] L["Color tag"] = "颜色标签"
--[[ zhCN ]] L["<Any tag string>"] = "<任意标签文字>"

--[[ zhCN ]] L["Border"] = "Border"
--[[ zhCN ]] L["Border options"] = "Border options"
--[[ zhCN ]] L["Target Only"] = "Target Only"
--[[ zhCN ]] L["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ zhCN ]] L["Border Edge Size"] = "Border Edge Size"
--[[ zhCN ]] L["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ zhCN ]] L["Border Inset"] = "Border Inset"
--[[ zhCN ]] L["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ zhCN ]] L["Border Color"] = "边框颜色"
--[[ zhCN ]] L["Sets the border color of the nameplate"] = "姓名板边框颜色"
--[[ zhCN ]] L["Border Style"] = "边框样式"
--[[ zhCN ]] L["Sets the style of the nameplate border"] = "设定姓名板边框样式"
--[[ zhCN ]] L["Background Style"] = "背景样式"
--[[ zhCN ]] L["Sets the style of the nameplate background"] = "设定姓名牌背景样式"

--[[ zhCN ]] L["NONE"] = "无"
--[[ zhCN ]] L["STANDARD"] = "标准"
--[[ zhCN ]] L["SQUARE"] = "正方形"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Enable Mouse"] = "啟用滑鼠"
--[[ zhTW ]] L["Allows left click to target and right click to interact"] = "允許左擊選擇目標，右擊彈出選單"

--[[ zhTW ]] L["Frame"] = "框架"
--[[ zhTW ]] L["Frame options"] = "框架設定"
--[[ zhTW ]] L["Width"] = "寬度"
--[[ zhTW ]] L["Sets the width of the frame"] = "設定框架的寬度"
--[[ zhTW ]] L["Height"] = "高度"
--[[ zhTW ]] L["Sets the height of the frame"] = "設定框架的高度"

--[[ zhTW ]] L["Packing Width"] = "間隔寬度"
--[[ zhTW ]] L["Sets the minimum horizontal distance between frames"] = "設定框架最小水平間隔"
--[[ zhTW ]] L["Packing Height"] = "間隔高度"
--[[ zhTW ]] L["Sets the minimum vertical distance between frames"] = "設定框架最小垂直間隔"

--[[ zhTW ]] L["Position"] = "位置"
--[[ zhTW ]] L["Adjust layout base and background position"] = "調整佈局基礎和背景位置"
--[[ zhTW ]] L["X Offset"] = "X偏移"
--[[ zhTW ]] L["X offset of the layout base and background"] = "佈局基礎和背景的X偏移"
--[[ zhTW ]] L["Y Offset"] = "Y偏移"
--[[ zhTW ]] L["Y offset of the layout base and background"] = "佈局基礎和背景的Y偏移"

--[[ zhTW ]] L["Background"] = "背景"
--[[ zhTW ]] L["Background options"] = "背景設定"
--[[ zhTW ]] L["Background Alpha"] = "背景透明度"
--[[ zhTW ]] L["Sets the alpha for the background of the nameplates"] = "設定名牌的背景透明度"
--[[ zhTW ]] L["Background Colors"] = "背景顏色"
--[[ zhTW ]] L["Customize colors"] = "自定顏色"

--[[ zhTW ]] L["Color by Class"] = "根據職業著色"
--[[ zhTW ]] L["Sets the background color according to class"] = "設定背景顏色根據職業"
--[[ zhTW ]] L["Color Hostile by Class"] = "敵對單位根據職業著色"
--[[ zhTW ]] L["Sets the background color of hostile players according to class"] = "設定敵對玩家的背景顏色根據職業"
--[[ zhTW ]] L["Set All"] = "設定全部"
--[[ zhTW ]] L["Sets the background color for all types"] = "設定全部類型的背景顏色"

--[[ zhTW ]] L["Set All Friendly"] = "設定全部友好"
--[[ zhTW ]] L["Sets the background color for all friendly types"] = "設定全部友好單位的背景顏色"
--[[ zhTW ]] L["Set All Hostile"] = "設定全部敵對"
--[[ zhTW ]] L["Sets the background color for all hostile types"] = "設定全部敵對單位的背景顏色"

--[[ zhTW ]] L["Pet"] = "寵物"
--[[ zhTW ]] L["Sets the background color for your pet"] = "設定你的寵物的背景顏色"
--[[ zhTW ]] L["Friendly Players"] = "友好玩家"
--[[ zhTW ]] L["Sets the background color for friendly players"] = "設定友好玩家的背景顏色"
--[[ zhTW ]] L["Friendly Pets"] = "友好寵物"
--[[ zhTW ]] L["Sets the background color for friendly pets"] = "設定友好寵物的背景顏色"
--[[ zhTW ]] L["Friendly NPCs"] = "友好NPC"
--[[ zhTW ]] L["Sets the background color for friendly NPC Bosses"] = "設定友好NPC的背景顏色"
--[[ zhTW ]] L["Friendly Boss"] = "友好首領"
--[[ zhTW ]] L["Sets the background color for friendly NPCs"] = "設定友好首領的背景顏色"
--[[ zhTW ]] L["Hostile Players"] = "敵對玩家"
--[[ zhTW ]] L["Sets the background color for hostile players"] = "設定敵對玩家的背景顏色"
--[[ zhTW ]] L["Hostile Pets"] = "敵對寵物"
--[[ zhTW ]] L["Sets the background color for hostile pets"] = "設定敵對寵物的背景顏色"
--[[ zhTW ]] L["Hostile NPCs"] = "敵對NPC"
--[[ zhTW ]] L["Sets the background color for hostile units"] = "設定敵對NPC的背景顏色"
--[[ zhTW ]] L["Hostile Boss"] = "敵對玩家"
--[[ zhTW ]] L["Sets the background color for hostile boss units"] = "設定敵對首領的背景顏色"
--[[ zhTW ]] L["Neutral Units"] = "中立單位"
--[[ zhTW ]] L["Sets the background color for neutral units"] = "設定中立單位的背景顏色"
--[[ zhTW ]] L["Group Pets"] = "隊伍寵物"
--[[ zhTW ]] L["Sets the background color for group pets"] = "設定隊伍寵物的背景顏色"
--[[ zhTW ]] L["Unknown"] = "未知"
--[[ zhTW ]] L["Sets the background color for unknown units"] = "設定未知單位的背景顏色"

--[[ zhTW ]] L["Advanced"] = "進階"
--[[ zhTW ]] L["Options for expert users"] = "熟練的使用者設定"
--[[ zhTW ]] L["Color Format"] = "顏色格式"
--[[ zhTW ]] L["Color tag"] = "顏色標籤"
--[[ zhTW ]] L["<Any tag string>"] = "<任何標籤文字>"

--[[ zhTW ]] L["Border"] = "邊框"
--[[ zhTW ]] L["Border options"] = "邊框設定"
--[[ zhTW ]] L["Target Only"] = "只在目標"
--[[ zhTW ]] L["Enables the border on the current target only"] = "啟用只在目前目標上的邊框"
--[[ zhTW ]] L["Border Edge Size"] = "邊框邊緣大小"
--[[ zhTW ]] L["Sets the thickness of the border"] = "設定邊框的寬度"
--[[ zhTW ]] L["Border Inset"] = "邊框崁入"
--[[ zhTW ]] L["Sets the padding aroundthe border"] = "設定邊框的間距範圍"
--[[ zhTW ]] L["Border Color"] = "邊框顏色"
--[[ zhTW ]] L["Sets the border color of the nameplate"] = "設定在名牌上的邊框顏色"
--[[ zhTW ]] L["Border Style"] = "邊框樣式"
--[[ zhTW ]] L["Sets the style of the nameplate border"] = "設定在名牌邊框上的樣式"
--[[ zhTW ]] L["Background Style"] = "背景樣式"
--[[ zhTW ]] L["Sets the style of the nameplate background"] = "設定在名牌背景上的樣式"

--[[ zhTW ]] L["NONE"] = "無"
--[[ zhTW ]] L["STANDARD"] = "標準"
--[[ zhTW ]] L["SQUARE"] = "正方形"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftFrame = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil