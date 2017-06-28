local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftFrameOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Enable Mouse"] = true,
	--[[ enUS ]] ["Allows left click to target and right click to interact"] = true,

	--[[ enUS ]] ["Frame"] = true,
	--[[ enUS ]] ["Frame options"] = true,
	--[[ enUS ]] ["Width"] = true,
	--[[ enUS ]] ["Sets the width of the frame"] = true,
	--[[ enUS ]] ["Height"] = true,
	--[[ enUS ]] ["Sets the height of the frame"] = true,

	--[[ enUS ]] ["Packing Width"] = true,
	--[[ enUS ]] ["Sets the minimum horizontal distance between frames"] = true,
	--[[ enUS ]] ["Packing Height"] = true,
	--[[ enUS ]] ["Sets the minimum vertical distance between frames"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust layout base and background position"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the layout base and background"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the layout base and background"] = true,

	--[[ enUS ]] ["Background"] = true,
	--[[ enUS ]] ["Background options"] = true,
	--[[ enUS ]] ["Background Alpha"] = true,
	--[[ enUS ]] ["Sets the alpha for the background of the nameplates"] = true,
	--[[ enUS ]] ["Background Colors"] = true,
	--[[ enUS ]] ["Customize colors"] = true,

	--[[ enUS ]] ["Color by Class"] = true,
	--[[ enUS ]] ["Sets the background color according to class"] = true,
	--[[ enUS ]] ["Color Hostile by Class"] = true,
	--[[ enUS ]] ["Sets the background color of hostile players according to class"] = true,
	--[[ enUS ]] ["Set All"] = true,
	--[[ enUS ]] ["Sets the background color for all types"] = true,

	--[[ enUS ]] ["Set All Friendly"] = true,
	--[[ enUS ]] ["Sets the background color for all friendly types"] = true,
	--[[ enUS ]] ["Set All Hostile"] = true,
	--[[ enUS ]] ["Sets the background color for all hostile types"] = true,

	--[[ enUS ]] ["Pet"] = true,
	--[[ enUS ]] ["Sets the background color for your pet"] = true,
	--[[ enUS ]] ["Friendly Players"] = true,
	--[[ enUS ]] ["Sets the background color for friendly players"] = true,
	--[[ enUS ]] ["Friendly Pets"] = true,
	--[[ enUS ]] ["Sets the background color for friendly pets"] = true,
	--[[ enUS ]] ["Friendly NPCs"] = true,
	--[[ enUS ]] ["Sets the background color for friendly NPC Bosses"] = true,
	--[[ enUS ]] ["Friendly Boss"] = true,
	--[[ enUS ]] ["Sets the background color for friendly NPCs"] = true,
	--[[ enUS ]] ["Hostile Players"] = true,
	--[[ enUS ]] ["Sets the background color for hostile players"] = true,
	--[[ enUS ]] ["Hostile Pets"] = true,
	--[[ enUS ]] ["Sets the background color for hostile pets"] = true,
	--[[ enUS ]] ["Hostile NPCs"] = true,
	--[[ enUS ]] ["Sets the background color for hostile units"] = true,
	--[[ enUS ]] ["Hostile Boss"] = true,
	--[[ enUS ]] ["Sets the background color for hostile boss units"] = true,
	--[[ enUS ]] ["Neutral Units"] = true,
	--[[ enUS ]] ["Sets the background color for neutral units"] = true,
	--[[ enUS ]] ["Group Pets"] = true,
	--[[ enUS ]] ["Sets the background color for group pets"] = true,
	--[[ enUS ]] ["Unknown"] = true,
	--[[ enUS ]] ["Sets the background color for unknown units"] = true,

	--[[ enUS ]] ["Advanced"] = true,
	--[[ enUS ]] ["Options for expert users"] = true,
	--[[ enUS ]] ["Color Format"] = true,
	--[[ enUS ]] ["Color tag"] = true,
	--[[ enUS ]] ["<Any tag string>"] = true,

	--[[ enUS ]] ["Border"] = true,
	--[[ enUS ]] ["Border options"] = true,
	--[[ enUS ]] ["Target Only"] = true,
	--[[ enUS ]] ["Enables the border on the current target only"] = true,
	--[[ enUS ]] ["Border Color"] = true,
	--[[ enUS ]] ["Sets the border color of the nameplate"] = true,
	--[[ enUS ]] ["Border Style"] = true,
	--[[ enUS ]] ["Sets the style of the nameplate border"] = true,
	--[[ enUS ]] ["Background Style"] = true,
	--[[ enUS ]] ["Sets the style of the nameplate background"] = true,

	--[[ enUS ]] ["NONE"] = "None",
	--[[ enUS ]] ["STANDARD"] = "Standard",
	--[[ enUS ]] ["SQUARE"] = "Square",
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Enable Mouse"] = "마우스 사용",
	--[[ koKR ]] ["Allows left click to target and right click to interact"] = "행동을 위한 우클릭과 대상에 좌클릭을 허용합니다.",

	--[[ koKR ]] ["Frame"] = "프레임",
	--[[ koKR ]] ["Frame options"] = "프레임 설정입니다.",
	--[[ koKR ]] ["Width"] = "너비",
	--[[ koKR ]] ["Sets the width of the frame"] = "프레임의 너비를 설정합니다.",
	--[[ koKR ]] ["Height"] = "높이",
	--[[ koKR ]] ["Sets the height of the frame"] = "프레임의 높이를 설정합니다.",

	--[[ koKR ]] ["Packing Width"] = "패킹 넓이",
	--[[ koKR ]] ["Sets the minimum horizontal distance between frames"] = "프레임 사이의 최소 수평 거리를 설정합니다.",
	--[[ koKR ]] ["Packing Height"] = "패킹 높이",
	--[[ koKR ]] ["Sets the minimum vertical distance between frames"] = "프레임 사이의 최소 수직 거리를 설정합니다.",

	--[[ koKR ]] ["Position"] = "Position",
	--[[ koKR ]] ["Adjust layout base and background position"] = "Adjust layout base and background position",
	--[[ koKR ]] ["X Offset"] = "X Offset",
	--[[ koKR ]] ["X offset of the layout base and background"] = "X offset of the layout base and background",
	--[[ koKR ]] ["Y Offset"] = "Y Offset",
	--[[ koKR ]] ["Y offset of the layout base and background"] = "Y offset of the layout base and background",

	--[[ koKR ]] ["Background"] = "Background",
	--[[ koKR ]] ["Background options"] = "Background options",
	--[[ koKR ]] ["Background Alpha"] = "배경 투명도",
	--[[ koKR ]] ["Sets the alpha for the background of the nameplates"] = "이름표의 배경에 대한 투명도를 설정합니다.",
	--[[ koKR ]] ["Background Colors"] = "배경 색상",
	--[[ koKR ]] ["Customize colors"] = "사용자 색상",

	--[[ koKR ]] ["Color by Class"] = "직업별 색상",
	--[[ koKR ]] ["Sets the background color according to class"] = "직업별 색상을 배경 색상으로 설정합니다.",
	--[[ koKR ]] ["Color Hostile by Class"] = "적대적 직업별 색상",
	--[[ koKR ]] ["Sets the background color of hostile players according to class"] = "직업별 색상을 적대적 플레이어의 배경 색상으로 설정합니다.",
	--[[ koKR ]] ["Set All"] = "전체 설정",
	--[[ koKR ]] ["Sets the background color for all types"] = "전체의 배경 색상을 설정합니다.",

	--[[ koKR ]] ["Set All Friendly"] = "전체 우호적 설정",
	--[[ koKR ]] ["Sets the background color for all friendly types"] = "전체 우호적 대상에 대한 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Set All Hostile"] = "전체 적대적 설정",
	--[[ koKR ]] ["Sets the background color for all hostile types"] = "전체 적대적 대상에 대한 배경 색상을 설정합니다.",

	--[[ koKR ]] ["Pet"] = "소환수",
	--[[ koKR ]] ["Sets the background color for your pet"] = "소환수에 대한 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Friendly Players"] = "우호적 플레이어",
	--[[ koKR ]] ["Sets the background color for friendly players"] = "우호적 플레이어에 대한 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Friendly Pets"] = "우호적 소환수",
	--[[ koKR ]] ["Sets the background color for friendly pets"] = "우호적 소환수에 대한 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Friendly NPCs"] = "우호적 NPC",
	--[[ koKR ]] ["Sets the background color for friendly NPC Bosses"] = "우호적 NPC 보스에 대한 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Friendly Boss"] = "우호적 보스",
	--[[ koKR ]] ["Sets the background color for friendly NPCs"] = "우호적 NPC에 대한 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Hostile Players"] = "적대적 플레이어",
	--[[ koKR ]] ["Sets the background color for hostile players"] = "적대적 플레이어에 대한 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Hostile Pets"] = "적대적 소환수",
	--[[ koKR ]] ["Sets the background color for hostile pets"] = "적대적 소환수에 대한 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Hostile NPCs"] = "적대적 NPC",
	--[[ koKR ]] ["Sets the background color for hostile units"] = "적대적 대상에 대한 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Hostile Boss"] = "적대적 보스",
	--[[ koKR ]] ["Sets the background color for hostile boss units"] = "적대적 보스에 대한 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Neutral Units"] = "중립적 대상",
	--[[ koKR ]] ["Sets the background color for neutral units"] = "중립적 대상에 대한 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Group Pets"] = "파티 소환수",
	--[[ koKR ]] ["Sets the background color for group pets"] = "파티 소환수에 대한 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Unknown"] = "Unknown",
	--[[ koKR ]] ["Sets the background color for unknown units"] = "Sets the background color for unknown units",

	--[[ koKR ]] ["Advanced"] = "고급",
	--[[ koKR ]] ["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	--[[ koKR ]] ["Color Format"] = "색상 형식",
	--[[ koKR ]] ["Color tag"] = "색상 태그",
	--[[ koKR ]] ["<Any tag string>"] = "<태그 문자열>",

	--[[ koKR ]] ["Border"] = "Border",
	--[[ koKR ]] ["Border options"] = "Border options",
	--[[ koKR ]] ["Target Only"] = "Target Only",
	--[[ koKR ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ koKR ]] ["Border Color"] = "테두리 색상",
	--[[ koKR ]] ["Sets the border color of the nameplate"] = "이름표의 테두리 색상을 설정합니다.",
	--[[ koKR ]] ["Border Style"] = "테두리 스타일",
	--[[ koKR ]] ["Sets the style of the nameplate border"] = "이름표 테두리의 스타일을 설정합니다.",
	--[[ koKR ]] ["Background Style"] = "배경 유형",
	--[[ koKR ]] ["Sets the style of the nameplate background"] = "이름표 배경의 유형을 설정합니다.",

	--[[ koKR ]] ["NONE"] = "없음",
	--[[ koKR ]] ["STANDARD"] = "기본형",
	--[[ koKR ]] ["SQUARE"] = "사각형",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Enable Mouse"] = "Включить мышь",
	--[[ ruRU ]] ["Allows left click to target and right click to interact"] = "Позволяет кликом левой кнопки выделять и кликом правой кнопки взаимодействовать",

	--[[ ruRU ]] ["Frame"] = "Фрейм",
	--[[ ruRU ]] ["Frame options"] = "Настройки фрейма",
	--[[ ruRU ]] ["Width"] = "Ширина",
	--[[ ruRU ]] ["Sets the width of the frame"] = "Задает ширину фрейма",
	--[[ ruRU ]] ["Height"] = "Высота",
	--[[ ruRU ]] ["Sets the height of the frame"] = "Задает высоту фрейма",

	--[[ ruRU ]] ["Packing Width"] = "Ширина размещения",
	--[[ ruRU ]] ["Sets the minimum horizontal distance between frames"] = "Задает минимальное расстояние между двумя фреймами по горизонтали",
	--[[ ruRU ]] ["Packing Height"] = "Высота размещения",
	--[[ ruRU ]] ["Sets the minimum vertical distance between frames"] = "Задает минимальное расстояние между двумя фреймами по вертикали",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust layout base and background position"] = "Регулировка расположения основного слоя и фона",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the layout base and background"] = "Смещение основного слоя и фона по Х",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the layout base and background"] = "Смещение основного слоя и фона по Y",

	--[[ ruRU ]] ["Background"] = "Фон",
	--[[ ruRU ]] ["Background options"] = "Опции фона",
	--[[ ruRU ]] ["Background Alpha"] = "Прозрачность фона",
	--[[ ruRU ]] ["Sets the alpha for the background of the nameplates"] = "Задает прозрачность фона табличек",
	--[[ ruRU ]] ["Background Colors"] = "Цвета фона",
	--[[ ruRU ]] ["Customize colors"] = "Настройка цветов",

	--[[ ruRU ]] ["Color by Class"] = "Окрашивать в цвет класса",
	--[[ ruRU ]] ["Sets the background color according to class"] = "Задает цвет фона в зависимости от класса",
	--[[ ruRU ]] ["Color Hostile by Class"] = "Окрашивать враждебных в цвет класса",
	--[[ ruRU ]] ["Sets the background color of hostile players according to class"] = "Задает цвет фона в зависимости от класса враждебного игрока",
	--[[ ruRU ]] ["Set All"] = "Задать все",
	--[[ ruRU ]] ["Sets the background color for all types"] = "Задает цвет фона для всех",

	--[[ ruRU ]] ["Set All Friendly"] = "Задать всех дружественными",
	--[[ ruRU ]] ["Sets the background color for all friendly types"] = "Задает цвет фона для всех дружелюбных",
	--[[ ruRU ]] ["Set All Hostile"] = "Задать всех враждебными",
	--[[ ruRU ]] ["Sets the background color for all hostile types"] = "Задает цвет фона для всех враждебных",

	--[[ ruRU ]] ["Pet"] = "Питомец",
	--[[ ruRU ]] ["Sets the background color for your pet"] = "Задает цвет фона для вашего питомца",
	--[[ ruRU ]] ["Friendly Players"] = "Дружественные игроки",
	--[[ ruRU ]] ["Sets the background color for friendly players"] = "Задает цвет фона для дружественных игроков",
	--[[ ruRU ]] ["Friendly Pets"] = "Дружественные питомцы",
	--[[ ruRU ]] ["Sets the background color for friendly pets"] = "Задает цвет фона для дружественных питомцев",
	--[[ ruRU ]] ["Friendly NPCs"] = "Дружественные NPC",
	--[[ ruRU ]] ["Sets the background color for friendly NPC Bosses"] = "Задает цвет фона для дружественных НИПов боссов",
	--[[ ruRU ]] ["Friendly Boss"] = "Дружественный босс",
	--[[ ruRU ]] ["Sets the background color for friendly NPCs"] = "Задает цвет фона для дружественных НИПов",
	--[[ ruRU ]] ["Hostile Players"] = "Враждебные игроки",
	--[[ ruRU ]] ["Sets the background color for hostile players"] = "Задает цвет фона для враждебных игроков",
	--[[ ruRU ]] ["Hostile Pets"] = "Враждебные питомцы",
	--[[ ruRU ]] ["Sets the background color for hostile pets"] = "Задает цвет фона для враждебных питомцев",
	--[[ ruRU ]] ["Hostile NPCs"] = "Враждебные NPC",
	--[[ ruRU ]] ["Sets the background color for hostile units"] = "Задает цвет фона для враждебных",
	--[[ ruRU ]] ["Hostile Boss"] = "Враждебный босс",
	--[[ ruRU ]] ["Sets the background color for hostile boss units"] = "Задает цвет фона для враждебных боссов",
	--[[ ruRU ]] ["Neutral Units"] = "Нейтриальные цели",
	--[[ ruRU ]] ["Sets the background color for neutral units"] = "Задает цвет фона для нейтральных",
	--[[ ruRU ]] ["Group Pets"] = "Питомцы группы",
	--[[ ruRU ]] ["Sets the background color for group pets"] = "Задает цвет фона для питомцев группы",
	--[[ ruRU ]] ["Unknown"] = "Unknown",
	--[[ ruRU ]] ["Sets the background color for unknown units"] = "Sets the background color for unknown units",

	--[[ ruRU ]] ["Advanced"] = "Дополнительно",
	--[[ ruRU ]] ["Options for expert users"] = "Настройки для опытных пользователей",
	--[[ ruRU ]] ["Color Format"] = "Формат цвета",
	--[[ ruRU ]] ["Color tag"] = "Формат цвета",
	--[[ ruRU ]] ["<Any tag string>"] = "<Любая строка формата>",

	--[[ ruRU ]] ["Border"] = "Края",
	--[[ ruRU ]] ["Border options"] = "Настройки краев",
	--[[ ruRU ]] ["Target Only"] = "Только цель",
	--[[ ruRU ]] ["Enables the border on the current target only"] = "Включить края только для текущей цели",
	--[[ ruRU ]] ["Border Color"] = "Цвет рамки",
	--[[ ruRU ]] ["Sets the border color of the nameplate"] = "Задает цвет рамки таблички",
	--[[ ruRU ]] ["Border Style"] = "Стиль рамки",
	--[[ ruRU ]] ["Sets the style of the nameplate border"] = "Задает стиль для рамки таблички",
	--[[ ruRU ]] ["Background Style"] = "Стиль фона",
	--[[ ruRU ]] ["Sets the style of the nameplate background"] = "Задает стиль для фона таблички",

	--[[ ruRU ]] ["NONE"] = "Нету",
	--[[ ruRU ]] ["STANDARD"] = "Стандарт",
	--[[ ruRU ]] ["SQUARE"] = "Квадрат",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Enable Mouse"] = "启用鼠标",
	--[[ zhCN ]] ["Allows left click to target and right click to interact"] = "设定左键点击为选择目标，右键点击则为弹出选单",

	--[[ zhCN ]] ["Frame"] = "框架",
	--[[ zhCN ]] ["Frame options"] = "框架相关设置",
	--[[ zhCN ]] ["Width"] = "宽度",
	--[[ zhCN ]] ["Sets the width of the frame"] = "设定框架的宽度",
	--[[ zhCN ]] ["Height"] = "高度",
	--[[ zhCN ]] ["Sets the height of the frame"] = "设定框架的高度",

	--[[ zhCN ]] ["Packing Width"] = "间隔宽度",
	--[[ zhCN ]] ["Sets the minimum horizontal distance between frames"] = "设定框架之间的最小水平间隔",
	--[[ zhCN ]] ["Packing Height"] = "间隔高度",
	--[[ zhCN ]] ["Sets the minimum vertical distance between frames"] = "设定框架之间的最小垂直间隔",

	--[[ zhCN ]] ["Position"] = "Position",
	--[[ zhCN ]] ["Adjust layout base and background position"] = "Adjust layout base and background position",
	--[[ zhCN ]] ["X Offset"] = "X Offset",
	--[[ zhCN ]] ["X offset of the layout base and background"] = "X offset of the layout base and background",
	--[[ zhCN ]] ["Y Offset"] = "Y Offset",
	--[[ zhCN ]] ["Y offset of the layout base and background"] = "Y offset of the layout base and background",

	--[[ zhCN ]] ["Background"] = "Background",
	--[[ zhCN ]] ["Background options"] = "Background options",
	--[[ zhCN ]] ["Background Alpha"] = "背景透明度",
	--[[ zhCN ]] ["Sets the alpha for the background of the nameplates"] = "设定姓名板的背景透明度",
	--[[ zhCN ]] ["Background Colors"] = "背景颜色",
	--[[ zhCN ]] ["Customize colors"] = "自定义颜色",

	--[[ zhCN ]] ["Color by Class"] = "根据职业显示颜色",
	--[[ zhCN ]] ["Sets the background color according to class"] = "背景颜色使用职业代表色",
	--[[ zhCN ]] ["Color Hostile by Class"] = "敌对方单位根据职业显示颜色",
	--[[ zhCN ]] ["Sets the background color of hostile players according to class"] = "敌对方玩家的背景颜色使用职业代表色",
	--[[ zhCN ]] ["Set All"] = "设定全部",
	--[[ zhCN ]] ["Sets the background color for all types"] = "设定所有单位的背景颜色",

	--[[ zhCN ]] ["Set All Friendly"] = "设定全部友好方单位",
	--[[ zhCN ]] ["Sets the background color for all friendly types"] = "设定全部友好方单位的背景颜色",
	--[[ zhCN ]] ["Set All Hostile"] = "设定全部敌对方单位",
	--[[ zhCN ]] ["Sets the background color for all hostile types"] = "设定全部敌对方单位的背景颜色",

	--[[ zhCN ]] ["Pet"] = "宠物",
	--[[ zhCN ]] ["Sets the background color for your pet"] = "设定你的宠物的背景颜色",
	--[[ zhCN ]] ["Friendly Players"] = "友好方玩家",
	--[[ zhCN ]] ["Sets the background color for friendly players"] = "设定友好方玩家的背景颜色",
	--[[ zhCN ]] ["Friendly Pets"] = "友好方宠物",
	--[[ zhCN ]] ["Sets the background color for friendly pets"] = "设定友好方宠物的背景颜色",
	--[[ zhCN ]] ["Friendly NPCs"] = "友好方NPC",
	--[[ zhCN ]] ["Sets the background color for friendly NPC Bosses"] = "设定友好方首领的背景颜色",
	--[[ zhCN ]] ["Friendly Boss"] = "友好方首领",
	--[[ zhCN ]] ["Sets the background color for friendly NPCs"] = "设定友好NPC的背景颜色",
	--[[ zhCN ]] ["Hostile Players"] = "敌对方玩家",
	--[[ zhCN ]] ["Sets the background color for hostile players"] = "设定敌对方玩家的背景颜色",
	--[[ zhCN ]] ["Hostile Pets"] = "敌对方宠物",
	--[[ zhCN ]] ["Sets the background color for hostile pets"] = "设定敌对方宠物的背景颜色",
	--[[ zhCN ]] ["Hostile NPCs"] = "敌对方NPC",
	--[[ zhCN ]] ["Sets the background color for hostile units"] = "设定敌对方NPC的背景颜色",
	--[[ zhCN ]] ["Hostile Boss"] = "敌对方首领",
	--[[ zhCN ]] ["Sets the background color for hostile boss units"] = "设定敌对方首领的背景颜色",
	--[[ zhCN ]] ["Neutral Units"] = "中立方单位",
	--[[ zhCN ]] ["Sets the background color for neutral units"] = "设定中立方单位的背景颜色",
	--[[ zhCN ]] ["Group Pets"] = "队友宠物",
	--[[ zhCN ]] ["Sets the background color for group pets"] = "设定队友宠物的背景颜色",
	--[[ zhCN ]] ["Unknown"] = "Unknown",
	--[[ zhCN ]] ["Sets the background color for unknown units"] = "Sets the background color for unknown units",

	--[[ zhCN ]] ["Advanced"] = "高级",
	--[[ zhCN ]] ["Options for expert users"] = "高级设置",
	--[[ zhCN ]] ["Color Format"] = "颜色格式",
	--[[ zhCN ]] ["Color tag"] = "颜色标签",
	--[[ zhCN ]] ["<Any tag string>"] = "<任意标签文字>",

	--[[ zhCN ]] ["Border"] = "Border",
	--[[ zhCN ]] ["Border options"] = "Border options",
	--[[ zhCN ]] ["Target Only"] = "Target Only",
	--[[ zhCN ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ zhCN ]] ["Border Color"] = "边框颜色",
	--[[ zhCN ]] ["Sets the border color of the nameplate"] = "姓名板边框颜色",
	--[[ zhCN ]] ["Border Style"] = "边框样式",
	--[[ zhCN ]] ["Sets the style of the nameplate border"] = "设定姓名板边框样式",
	--[[ zhCN ]] ["Background Style"] = "背景样式",
	--[[ zhCN ]] ["Sets the style of the nameplate background"] = "设定姓名牌背景样式",

	--[[ zhCN ]] ["NONE"] = "无",
	--[[ zhCN ]] ["STANDARD"] = "标准",
	--[[ zhCN ]] ["SQUARE"] = "正方形",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Enable Mouse"] = "啟用滑鼠",
	--[[ zhTW ]] ["Allows left click to target and right click to interact"] = "允許左擊選擇目標，右擊彈出選單",

	--[[ zhTW ]] ["Frame"] = "框架",
	--[[ zhTW ]] ["Frame options"] = "框架選項",
	--[[ zhTW ]] ["Width"] = "寬度",
	--[[ zhTW ]] ["Sets the width of the frame"] = "框架寬度",
	--[[ zhTW ]] ["Height"] = "高度",
	--[[ zhTW ]] ["Sets the height of the frame"] = "框架高度",

	--[[ zhTW ]] ["Packing Width"] = "間隔寬度",
	--[[ zhTW ]] ["Sets the minimum horizontal distance between frames"] = "框架最小水平間隔",
	--[[ zhTW ]] ["Packing Height"] = "間隔高度",
	--[[ zhTW ]] ["Sets the minimum vertical distance between frames"] = "框架最小垂直間隔",

	--[[ zhTW ]] ["Position"] = "Position",
	--[[ zhTW ]] ["Adjust layout base and background position"] = "Adjust layout base and background position",
	--[[ zhTW ]] ["X Offset"] = "X Offset",
	--[[ zhTW ]] ["X offset of the layout base and background"] = "X offset of the layout base and background",
	--[[ zhTW ]] ["Y Offset"] = "Y Offset",
	--[[ zhTW ]] ["Y offset of the layout base and background"] = "Y offset of the layout base and background",

	--[[ zhTW ]] ["Background"] = "Background",
	--[[ zhTW ]] ["Background options"] = "Background options",
	--[[ zhTW ]] ["Background Alpha"] = "背景透明度",
	--[[ zhTW ]] ["Sets the alpha for the background of the nameplates"] = "名牌背景透明度",
	--[[ zhTW ]] ["Background Colors"] = "背景顏色",
	--[[ zhTW ]] ["Customize colors"] = "自定顏色",

	--[[ zhTW ]] ["Color by Class"] = "根據職業上色",
	--[[ zhTW ]] ["Sets the background color according to class"] = "背景顏色使用職業顏色",
	--[[ zhTW ]] ["Color Hostile by Class"] = "敵對單位根據職業上色",
	--[[ zhTW ]] ["Sets the background color of hostile players according to class"] = "敵對玩家的背景顏色使用職業顏色",
	--[[ zhTW ]] ["Set All"] = "設定全部",
	--[[ zhTW ]] ["Sets the background color for all types"] = "設定全部單位的背景顏色",

	--[[ zhTW ]] ["Set All Friendly"] = "設定全部友好",
	--[[ zhTW ]] ["Sets the background color for all friendly types"] = "設定全部友好單位的背景顏色",
	--[[ zhTW ]] ["Set All Hostile"] = "設定全部敵對",
	--[[ zhTW ]] ["Sets the background color for all hostile types"] = "設定全部敵對單位的背景顏色",

	--[[ zhTW ]] ["Pet"] = "寵物",
	--[[ zhTW ]] ["Sets the background color for your pet"] = "寵物的背景顏色",
	--[[ zhTW ]] ["Friendly Players"] = "友好玩家",
	--[[ zhTW ]] ["Sets the background color for friendly players"] = "友好玩家的背景顏色",
	--[[ zhTW ]] ["Friendly Pets"] = "友好寵物",
	--[[ zhTW ]] ["Sets the background color for friendly pets"] = "友好寵物的背景顏色",
	--[[ zhTW ]] ["Friendly NPCs"] = "友好NPC",
	--[[ zhTW ]] ["Sets the background color for friendly NPC Bosses"] = "友好NPC的背景顏色",
	--[[ zhTW ]] ["Friendly Boss"] = "友好首領",
	--[[ zhTW ]] ["Sets the background color for friendly NPCs"] = "友好首領的背景顏色",
	--[[ zhTW ]] ["Hostile Players"] = "敵對玩家",
	--[[ zhTW ]] ["Sets the background color for hostile players"] = "敵對玩家的背景顏色",
	--[[ zhTW ]] ["Hostile Pets"] = "敵對寵物",
	--[[ zhTW ]] ["Sets the background color for hostile pets"] = "敵對寵物的背景顏色",
	--[[ zhTW ]] ["Hostile NPCs"] = "敵對NPC",
	--[[ zhTW ]] ["Sets the background color for hostile units"] = "敵對NPC的背景顏色",
	--[[ zhTW ]] ["Hostile Boss"] = "敵對玩家",
	--[[ zhTW ]] ["Sets the background color for hostile boss units"] = "敵對首領的背景顏色",
	--[[ zhTW ]] ["Neutral Units"] = "中立單位",
	--[[ zhTW ]] ["Sets the background color for neutral units"] = "中立單位的背景顏色",
	--[[ zhTW ]] ["Group Pets"] = "團體寵物",
	--[[ zhTW ]] ["Sets the background color for group pets"] = "團體寵物的背景顏色",
	--[[ zhTW ]] ["Unknown"] = "Unknown",
	--[[ zhTW ]] ["Sets the background color for unknown units"] = "Sets the background color for unknown units",

	--[[ zhTW ]] ["Advanced"] = "進階",
	--[[ zhTW ]] ["Options for expert users"] = "進階選項",
	--[[ zhTW ]] ["Color Format"] = "顏色格式",
	--[[ zhTW ]] ["Color tag"] = "顏色標籤",
	--[[ zhTW ]] ["<Any tag string>"] = "<任何標籤文字>",

	--[[ zhTW ]] ["Border"] = "Border",
	--[[ zhTW ]] ["Border options"] = "Border options",
	--[[ zhTW ]] ["Target Only"] = "Target Only",
	--[[ zhTW ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ zhTW ]] ["Border Color"] = "邊框顏色",
	--[[ zhTW ]] ["Sets the border color of the nameplate"] = "名牌邊框顏色",
	--[[ zhTW ]] ["Border Style"] = "邊框樣式",
	--[[ zhTW ]] ["Sets the style of the nameplate border"] = "名牌邊框樣式",
	--[[ zhTW ]] ["Background Style"] = "背景樣式",
	--[[ zhTW ]] ["Sets the style of the nameplate background"] = "設定名牌背景樣式",

	--[[ zhTW ]] ["NONE"] = "無",
	--[[ zhTW ]] ["STANDARD"] = "標準",
	--[[ zhTW ]] ["SQUARE"] = "正方形",
} end)

-----------------------------------------------------------------------------

end
