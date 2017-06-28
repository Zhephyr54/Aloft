local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local bL = AceLibrary("AceLocale-2.2"):new("AloftHealthBarOptions")

-----------------------------------------------------------------------------

bL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Health Bar"] = true,
	--[[ enUS ]] ["Health Bar options"] = true,

	--[[ enUS ]] ["Texture"] = true,
	--[[ enUS ]] ["Sets the health bar texture"] = true,
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Sets the health bar alpha"] = true,

	--[[ enUS ]] ["Size"] = true,
	--[[ enUS ]] ["Adjust health bar's size"] = true,
	--[[ enUS ]] ["Width"] = true,
	--[[ enUS ]] ["Sets the width of the health bar"] = true,
	--[[ enUS ]] ["Height"] = true,
	--[[ enUS ]] ["Sets the height of the health bar"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust the health bar's position"] = true,
	--[[ enUS ]] ["Left Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the left of the health bar"] = true,
	--[[ enUS ]] ["Right Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the right of the health bar"] = true,
	--[[ enUS ]] ["Vertical Offset"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the health bar"] = true,

	--[[ enUS ]] ["Colors"] = true,
	--[[ enUS ]] ["Customize colors"] = true,
	--[[ enUS ]] ["Color by Class"] = true,
	--[[ enUS ]] ["Sets the health bar color of players according to class"] = true,
	--[[ enUS ]] ["Color Hostile by Class"] = true,
	--[[ enUS ]] ["Sets the health bar color of hostile players according to class"] = true,
	--[[ enUS ]] ["Backdrop Color"] = true,
	--[[ enUS ]] ["Sets the backdrop color of the health bar"] = true,
	--[[ enUS ]] ["Pet"] = true,
	--[[ enUS ]] ["Sets the health bar color for your pet"] = true,
	--[[ enUS ]] ["Friendly Players"] = true,
	--[[ enUS ]] ["Sets the health bar color for friendly players"] = true,
	--[[ enUS ]] ["Friendly Pets"] = true,
	--[[ enUS ]] ["Sets the health bar color for friendly pets"] = true,
	--[[ enUS ]] ["Friendly NPCs"] = true,
	--[[ enUS ]] ["Sets the health bar color for friendly NPC Bosses"] = true,
	--[[ enUS ]] ["Friendly Boss"] = true,
	--[[ enUS ]] ["Sets the health bar color for friendly NPCs"] = true,
	--[[ enUS ]] ["Hostile Players"] = true,
	--[[ enUS ]] ["Sets the health bar color for hostile players"] = true,
	--[[ enUS ]] ["Hostile Pets"] = true,
	--[[ enUS ]] ["Sets the health bar color for hostile pets"] = true,
	--[[ enUS ]] ["Hostile NPCs"] = true,
	--[[ enUS ]] ["Sets the health bar color for hostile units"] = true,
	--[[ enUS ]] ["Hostile Boss"] = true,
	--[[ enUS ]] ["Sets the health bar color for hostile boss units"] = true,
	--[[ enUS ]] ["Neutral Units"] = true,
	--[[ enUS ]] ["Sets the health bar color for neutral units"] = true,
	--[[ enUS ]] ["Group Pets"] = true,
	--[[ enUS ]] ["Sets the health bar color for group pets"] = true,
	--[[ enUS ]] ["Unknown"] = true,
	--[[ enUS ]] ["Sets the health bar color for unknown units"] = true,
	--[[ enUS ]] ["Reset to Defaults"] = true,
	--[[ enUS ]] ["Resets all colors to their defaults"] = true,

	--[[ enUS ]] ["Border"] = true,
	--[[ enUS ]] ["Border options"] = true,
	--[[ enUS ]] ["Target Only"] = true,
	--[[ enUS ]] ["Enables the border on the current target only"] = true,
	--[[ enUS ]] ["Border Color"] = true,
	--[[ enUS ]] ["Sets the border color of the health bar"] = true,
	--[[ enUS ]] ["Border Style"] = true,
	--[[ enUS ]] ["Sets the style of the health bar border"] = true,

	--[[ enUS ]] ["Advanced"] = true,
	--[[ enUS ]] ["Options for expert users"] = true,
	--[[ enUS ]] ["Color Format"] = true,
	--[[ enUS ]] ["Color tag"] = true,
	--[[ enUS ]] ["<Any tag string>"] = true,
} end)

-----------------------------------------------------------------------------

local fL = AceLibrary("AceLocale-2.2"):new("AloftHealthBarDeficit")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthBarDeficit", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
fL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Deficit Health Bar"] = true,
	--[[ enUS ]] ["Display health bar as a deficit (grows from right as health is lost)"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

bL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Health Bar"] = "생명력바",
	--[[ koKR ]] ["Health Bar options"] = "생명력바 설정",

	--[[ koKR ]] ["Texture"] = "텍스쳐",
	--[[ koKR ]] ["Sets the health bar texture"] = "생명력바의 텍스쳐를 설정합니다.",
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Sets the health bar alpha"] = "생명력바의 투명도를 설정합니다.",

	--[[ koKR ]] ["Size"] = "크기",
	--[[ koKR ]] ["Adjust health bar's size"] = "생명력바의 크기를 조절합니다.",
	--[[ koKR ]] ["Width"] = "너비",
	--[[ koKR ]] ["Sets the width of the health bar"] = "생명력바의 너비를 설정합니다.",
	--[[ koKR ]] ["Height"] = "높이",
	--[[ koKR ]] ["Sets the height of the health bar"] = "생명력바의 높이를 설정합니다.",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust the health bar's position"] = "생명력바의 위치를 조절합니다.",
	--[[ koKR ]] ["Left Offset"] = "Left Offset",
	--[[ koKR ]] ["Sets the offset of the left of the health bar"] = "Sets the offset of the left of the health bar",
	--[[ koKR ]] ["Right Offset"] = "Right Offset",
	--[[ koKR ]] ["Sets the offset of the right of the health bar"] = "Sets the offset of the right of the health bar",
	--[[ koKR ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ koKR ]] ["Sets the vertical offset of the health bar"] = "Sets the vertical offset of the health bar",

	--[[ koKR ]] ["Colors"] = "색상",
	--[[ koKR ]] ["Customize colors"] = "사용자 색상",
	--[[ koKR ]] ["Color by Class"] = "직업에 따른 색상",
	--[[ koKR ]] ["Sets the health bar color of players according to class"] = "플레이어의 생명력바에 직업별 색상을 설정합니다.",
	--[[ koKR ]] ["Color Hostile by Class"] = "적대적 직업별 색상",
	--[[ koKR ]] ["Sets the health bar color of hostile players according to class"] = "적대적 플레이어의 생명력바에 직업별 색상을 설정합니다.",
	--[[ koKR ]] ["Backdrop Color"] = "배경 색상",
	--[[ koKR ]] ["Sets the backdrop color of the health bar"] = "생명력바의 배경 색상을 설정합니다.",
	--[[ koKR ]] ["Pet"] = "소환수",
	--[[ koKR ]] ["Sets the health bar color for your pet"] = "소환수의 생명력바 색상을 설정합니다.",
	--[[ koKR ]] ["Friendly Players"] = "우호적 플레이어",
	--[[ koKR ]] ["Sets the health bar color for friendly players"] = "우호적 플레이어에 대한 생명력바 색상을 설정합니다.",
	--[[ koKR ]] ["Friendly Pets"] = "우호적 소환수",
	--[[ koKR ]] ["Sets the health bar color for friendly pets"] = "우호적 소환수의 생명력바 색상을 설정합니다.",
	--[[ koKR ]] ["Friendly NPCs"] = "우호적 NPC",
	--[[ koKR ]] ["Sets the health bar color for friendly NPC Bosses"] =  "우호적 NPC 보스에 대한 생명력바 색상을 설정합니다.",
	--[[ koKR ]] ["Friendly Boss"] = "우호적 보스",
	--[[ koKR ]] ["Sets the health bar color for friendly NPCs"] = "우호적 NPC에 대한 생명력바 색상을 설정합니다.",
	--[[ koKR ]] ["Hostile Players"] = "적대적 플레이어",
	--[[ koKR ]] ["Sets the health bar color for hostile players"] = "적대적 플레이어의 생명력바의 색상을 설정합니다.",
	--[[ koKR ]] ["Hostile Pets"] = "적대적 소환수",
	--[[ koKR ]] ["Sets the health bar color for hostile pets"] = "적대적 소환수의 생명력바 색상을 설정합니다.",
	--[[ koKR ]] ["Hostile NPCs"] = "적대적 NPC",
	--[[ koKR ]] ["Sets the health bar color for hostile units"] = "적대적 대상에 대한 생명력바 색상을 설정합니다.",
	--[[ koKR ]] ["Hostile Boss"] = "적대적 보스",
	--[[ koKR ]] ["Sets the health bar color for hostile boss units"] = "적대적 보스에 대한 생명력바 색상을 설정합니다.",
	--[[ koKR ]] ["Neutral Units"] = "중립적 대상",
	--[[ koKR ]] ["Sets the health bar color for neutral units"] = "중립적 대상에 대한 생명력바 색상을 설정합니다.",
	--[[ koKR ]] ["Group Pets"] = "파티 소환수",
	--[[ koKR ]] ["Sets the health bar color for group pets"] = "파티 소환수에 대한 생명력바 색상을 설정합니다.",
	--[[ koKR ]] ["Unknown"] = "Unknown",
	--[[ koKR ]] ["Sets the health bar color for unknown units"] = "Sets the health bar color for unknown units",
	--[[ koKR ]] ["Reset to Defaults"] = "기본값으로 초기화",
	--[[ koKR ]] ["Resets all colors to their defaults"] = "모든 색상을 기본값으로 초기화합니다.",

	--[[ koKR ]] ["Border"] = "Border",
	--[[ koKR ]] ["Border options"] = "Border options",
	--[[ koKR ]] ["Target Only"] = "Target Only",
	--[[ koKR ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ koKR ]] ["Border Color"] = "테두리 색상",
	--[[ koKR ]] ["Sets the border color of the health bar"] = "Sets the border color of the health bar",
	--[[ koKR ]] ["Border Style"] = "테두리 스타일",
	--[[ koKR ]] ["Sets the style of the health bar border"] = "Sets the style of the health bar border",

	--[[ koKR ]] ["Advanced"] = "고급",
	--[[ koKR ]] ["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	--[[ koKR ]] ["Color Format"] = "색상 형식",
	--[[ koKR ]] ["Color tag"] = "색상 태그",
	--[[ koKR ]] ["<Any tag string>"] = "<태그 문자열>",
} end)

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthBarDeficit", function()

-----------------------------------------------------------------------------

fL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Deficit Health Bar"] = "Deficit Health Bar",
	--[[ koKR ]] ["Display health bar as a deficit (grows from right as health is lost)"] = "Display health bar as a deficit (grows from right as health is lost)",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

bL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Health Bar"] = "Полоска здоровья",
	--[[ ruRU ]] ["Health Bar options"] = "Настройка полосы здоровья",

	--[[ ruRU ]] ["Texture"] = "Текстура",
	--[[ ruRU ]] ["Sets the health bar texture"] = "Задает текстуру полоски здоровья",
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Sets the health bar alpha"] = "Задает прозрачность полоски здоровья",

	--[[ ruRU ]] ["Size"] = "Размер",
	--[[ ruRU ]] ["Adjust health bar's size"] = "Задать размер полоски здоровья",
	--[[ ruRU ]] ["Width"] = "Ширина",
	--[[ ruRU ]] ["Sets the width of the health bar"] = "Задает ширину полоски здоровья",
	--[[ ruRU ]] ["Height"] = "Высота",
	--[[ ruRU ]] ["Sets the height of the health bar"] = "Задает высоту полоски здоровья",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust the health bar's position"] = "Задать место полоски здоровья",
	--[[ ruRU ]] ["Left Offset"] = "Смещение влево",
	--[[ ruRU ]] ["Sets the offset of the left of the health bar"] = "Смещение текста на полосе здоровья влево",
	--[[ ruRU ]] ["Right Offset"] = "Смещение вправо",
	--[[ ruRU ]] ["Sets the offset of the right of the health bar"] = "Смещение текста на полосе здоровья вправо",
	--[[ ruRU ]] ["Vertical Offset"] = "Смещение по вертикале",
	--[[ ruRU ]] ["Sets the vertical offset of the health bar"] = "Смещение текста на полосе здоровья по вертикале",

	--[[ ruRU ]] ["Colors"] = "Цвета",
	--[[ ruRU ]] ["Customize colors"] = "Настройка цветов",
	--[[ ruRU ]] ["Color by Class"] = "Окрашивать в цвет класса",
	--[[ ruRU ]] ["Sets the health bar color of players according to class"] = "Задает цвет полоски здоровья в зависимости от класса",
	--[[ ruRU ]] ["Color Hostile by Class"] = "Окрашивать враждебных в цвет класса",
	--[[ ruRU ]] ["Sets the health bar color of hostile players according to class"] = "Задает цвет полоски здоровья для враждебных игроков в зависимости от класса",
	--[[ ruRU ]] ["Backdrop Color"] = "Цвет тени",
	--[[ ruRU ]] ["Sets the backdrop color of the health bar"] = "Задает цвет тени полоски здоровья",
	--[[ ruRU ]] ["Pet"] = "Питомец",
	--[[ ruRU ]] ["Sets the health bar color for your pet"] = "Задает цвет полоски здоровья для вашего питомца",
	--[[ ruRU ]] ["Friendly Players"] = "Дружественные игроки",
	--[[ ruRU ]] ["Sets the health bar color for friendly players"] = "Задает цвет полоски здоровья для дружественных игроков",
	--[[ ruRU ]] ["Friendly Pets"] = "Дружественные питомцы",
	--[[ ruRU ]] ["Sets the health bar color for friendly pets"] = "Задает цвет полоски здоровья для дружественных питомцев",
	--[[ ruRU ]] ["Friendly NPCs"] = "Дружественные NPC",
	--[[ ruRU ]] ["Sets the health bar color for friendly NPC Bosses"] = "Задает цвет полоски здоровья для дружественных НИПов боссов",
	--[[ ruRU ]] ["Friendly Boss"] = "Дружественный босс",
	--[[ ruRU ]] ["Sets the health bar color for friendly NPCs"] = "Задает цвет полоски здоровья для дружественных НИПов",
	--[[ ruRU ]] ["Hostile Players"] = "Враждебные игроки",
	--[[ ruRU ]] ["Sets the health bar color for hostile players"] = "Задает цвет полоски здоровья для враждебных игроков",
	--[[ ruRU ]] ["Hostile Pets"] = "Враждебные питомцы",
	--[[ ruRU ]] ["Sets the health bar color for hostile pets"] = "Задает цвет полоски здоровья для враждебных питомцев",
	--[[ ruRU ]] ["Hostile NPCs"] = "Враждебные NPC",
	--[[ ruRU ]] ["Sets the health bar color for hostile units"] = "Задает цвет полоски здоровья для враждебных единиц",
	--[[ ruRU ]] ["Hostile Boss"] = "Враждебный босс",
	--[[ ruRU ]] ["Sets the health bar color for hostile boss units"] = "Задает цвет полоски здоровья для враждебных боссов",
	--[[ ruRU ]] ["Neutral Units"] = "Нейтральные цели",
	--[[ ruRU ]] ["Sets the health bar color for neutral units"] = "Задает цвет полоски здоровья для нейтральных",
	--[[ ruRU ]] ["Group Pets"] = "Питомцы группы",
	--[[ ruRU ]] ["Sets the health bar color for group pets"] = "Задает цвет полоски здоровья для питомцев группы",
	--[[ ruRU ]] ["Unknown"] = "Unknown",
	--[[ ruRU ]] ["Sets the health bar color for unknown units"] = "Sets the health bar color for unknown units",
	--[[ ruRU ]] ["Reset to Defaults"] = "Сброс в настройки по умолчанию",
	--[[ ruRU ]] ["Resets all colors to their defaults"] = "Сбрасывает все цвета в настройки по умолчанию",

	--[[ ruRU ]] ["Border"] = "Края",
	--[[ ruRU ]] ["Border options"] = "Настройки краев",
	--[[ ruRU ]] ["Target Only"] = "Только цель",
	--[[ ruRU ]] ["Enables the border on the current target only"] = "Включить края только для текущей цели",
	--[[ ruRU ]] ["Border Color"] = "Цвет рамки",
	--[[ ruRU ]] ["Sets the border color of the health bar"] = "Sets the border color of the health bar",
	--[[ ruRU ]] ["Border Style"] = "Стиль рамки",
	--[[ ruRU ]] ["Sets the style of the health bar border"] = "Sets the style of the health bar border",

	--[[ ruRU ]] ["Advanced"] = "Дополнительно",
	--[[ ruRU ]] ["Options for expert users"] = "Настройки для опытных пользователей",
	--[[ ruRU ]] ["Color Format"] = "Формат цвета",
	--[[ ruRU ]] ["Color tag"] = "Формат цвета",
	--[[ ruRU ]] ["<Any tag string>"] = "<Любая строка формата>",
} end)

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthBarDeficit", function()

-----------------------------------------------------------------------------

fL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Deficit Health Bar"] = "Полоска дефицита здоровья",
	--[[ ruRU ]] ["Display health bar as a deficit (grows from right as health is lost)"] = "Отображать на полоске здоровья дефицит здоровья (растет справа с уменьшением здоровья)",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

bL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Health Bar"] = "生命值显示条",
	--[[ zhCN ]] ["Health Bar options"] = "生命值显示条相关设置",

	--[[ zhCN ]] ["Texture"] = "材质",
	--[[ zhCN ]] ["Sets the health bar texture"] = "设定生命值显示条的材质",
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Sets the health bar alpha"] = "设定生命值显示条透明度",

	--[[ zhCN ]] ["Size"] = "尺寸",
	--[[ zhCN ]] ["Adjust health bar's size"] = "调整生命值显示条的尺寸",
	--[[ zhCN ]] ["Width"] = "宽度",
	--[[ zhCN ]] ["Sets the width of the health bar"] = "设定生命值显示条的宽度",
	--[[ zhCN ]] ["Height"] = "高度",
	--[[ zhCN ]] ["Sets the height of the health bar"] = "设定生命值显示条的高度",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust the health bar's position"] = "调整生命值显示条的位置",
	--[[ zhCN ]] ["Left Offset"] = "Left Offset",
	--[[ zhCN ]] ["Sets the offset of the left of the health bar"] = "Sets the offset of the left of the health bar",
	--[[ zhCN ]] ["Right Offset"] = "Right Offset",
	--[[ zhCN ]] ["Sets the offset of the right of the health bar"] = "Sets the offset of the right of the health bar",
	--[[ zhCN ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ zhCN ]] ["Sets the vertical offset of the health bar"] = "Sets the vertical offset of the health bar",

	--[[ zhCN ]] ["Colors"] = "颜色",
	--[[ zhCN ]] ["Customize colors"] = "自定义颜色",
	--[[ zhCN ]] ["Color by Class"] = "显示职业代表色",
	--[[ zhCN ]] ["Sets the health bar color of players according to class"] = "生命值显示条颜色使用职业颜色",
	--[[ zhCN ]] ["Color Hostile by Class"] = "敌对方单位根据职业显示颜色",
	--[[ zhCN ]] ["Sets the health bar color of hostile players according to class"] = "敌对方玩家的生命值显示条颜色使用职业代表色",
	--[[ zhCN ]] ["Backdrop Color"] = "背景颜色",
	--[[ zhCN ]] ["Sets the backdrop color of the health bar"] = "设定生命值显示条的背景颜色",
	--[[ zhCN ]] ["Pet"] = "宠物",
	--[[ zhCN ]] ["Sets the health bar color for your pet"] = "设定宠物的生命值显示条颜色",
	--[[ zhCN ]] ["Friendly Players"] = "友好方玩家",
	--[[ zhCN ]] ["Sets the health bar color for friendly players"] = "设定友好方玩家的生命值显示条颜色",
	--[[ zhCN ]] ["Friendly Pets"] = "友好方宠物",
	--[[ zhCN ]] ["Sets the health bar color for friendly pets"] = "设定友好方宠物的生命值显示条颜色",
	--[[ zhCN ]] ["Friendly NPCs"] = "友好方NPC",
	--[[ zhCN ]] ["Sets the health bar color for friendly NPC Bosses"] = "设定友好方NPC的生命值显示条颜色",
	--[[ zhCN ]] ["Friendly Boss"] = "友好方首领",
	--[[ zhCN ]] ["Sets the health bar color for friendly NPCs"] = "设定友好方首领的生命值显示条颜色",
	--[[ zhCN ]] ["Hostile Players"] = "敌对方玩家",
	--[[ zhCN ]] ["Sets the health bar color for hostile players"] = "设定敌对方玩家的生命值显示条颜色",
	--[[ zhCN ]] ["Hostile Pets"] = "敌对方宠物",
	--[[ zhCN ]] ["Sets the health bar color for hostile pets"] = "设定敌对方宠物的生命值显示条颜色",
	--[[ zhCN ]] ["Hostile NPCs"] = "敌对方NPC",
	--[[ zhCN ]] ["Sets the health bar color for hostile units"] = "设定敌对方NPC的生命值显示条颜色",
	--[[ zhCN ]] ["Hostile Boss"] = "敌对方首领",
	--[[ zhCN ]] ["Sets the health bar color for hostile boss units"] = "设定敌对方首领的生命值显示条颜色",
	--[[ zhCN ]] ["Neutral Units"] = "中立方单位",
	--[[ zhCN ]] ["Sets the health bar color for neutral units"] = "设定中立方单位的生命值显示条颜色",
	--[[ zhCN ]] ["Group Pets"] = "队友宠物",
	--[[ zhCN ]] ["Sets the health bar color for group pets"] = "队友宠物的生命值显示条颜色",
	--[[ zhCN ]] ["Unknown"] = "Unknown",
	--[[ zhCN ]] ["Sets the health bar color for unknown units"] = "Sets the health bar color for unknown units",
	--[[ zhCN ]] ["Reset to Defaults"] = "重置为默认",
	--[[ zhCN ]] ["Resets all colors to their defaults"] = "将全部颜色设定重置为默认",

	--[[ zhCN ]] ["Border"] = "Border",
	--[[ zhCN ]] ["Border options"] = "Border options",
	--[[ zhCN ]] ["Target Only"] = "Target Only",
	--[[ zhCN ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ zhCN ]] ["Border Color"] = "边框颜色",
	--[[ zhCN ]] ["Sets the border color of the health bar"] = "Sets the border color of the health bar",
	--[[ zhCN ]] ["Border Style"] = "边框样式",
	--[[ zhCN ]] ["Sets the style of the health bar border"] = "Sets the style of the health bar border",

	--[[ zhCN ]] ["Advanced"] = "高级",
	--[[ zhCN ]] ["Options for expert users"] = "高级设置",
	--[[ zhCN ]] ["Color Format"] = "颜色格式",
	--[[ zhCN ]] ["Color tag"] = "颜色标签",
	--[[ zhCN ]] ["<Any tag string>"] = "<任意标签文字>",
} end)

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthBarDeficit", function()

-----------------------------------------------------------------------------

fL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Deficit Health Bar"] = "亏减生命条",
	--[[ zhCN ]] ["Display health bar as a deficit (grows from right as health is lost)"] = "将生命条显示为亏减模式（随着生命值丧失从右侧增长）",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

bL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Health Bar"] = "生命力條",
	--[[ zhTW ]] ["Health Bar options"] = "生命力條選項",

	--[[ zhTW ]] ["Texture"] = "紋理",
	--[[ zhTW ]] ["Sets the health bar texture"] = "生命力條紋理",
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Sets the health bar alpha"] = "生命力條透明度",

	--[[ zhTW ]] ["Size"] = "大小",
	--[[ zhTW ]] ["Adjust health bar's size"] = "生命力條大小",
	--[[ zhTW ]] ["Width"] = "寬度",
	--[[ zhTW ]] ["Sets the width of the health bar"] = "生命力條寬度",
	--[[ zhTW ]] ["Height"] = "高度",
	--[[ zhTW ]] ["Sets the height of the health bar"] = "生命力條高度",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust the health bar's position"] = "生命力條位置",
	--[[ zhTW ]] ["Left Offset"] = "Left Offset",
	--[[ zhTW ]] ["Sets the offset of the left of the health bar"] = "Sets the offset of the left of the health bar",
	--[[ zhTW ]] ["Right Offset"] = "Right Offset",
	--[[ zhTW ]] ["Sets the offset of the right of the health bar"] = "Sets the offset of the right of the health bar",
	--[[ zhTW ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ zhTW ]] ["Sets the vertical offset of the health bar"] = "Sets the vertical offset of the health bar",

	--[[ zhTW ]] ["Colors"] = "顏色",
	--[[ zhTW ]] ["Customize colors"] = "自定顏色",
	--[[ zhTW ]] ["Color by Class"] = "根據職業上色",
	--[[ zhTW ]] ["Sets the health bar color of players according to class"] = "生命力條顏色使用職業顏色",
	--[[ zhTW ]] ["Color Hostile by Class"] = "敵對單位根據職業上色",
	--[[ zhTW ]] ["Sets the health bar color of hostile players according to class"] = "敵對玩家的生命力條顏色使用職業顏色",
	--[[ zhTW ]] ["Backdrop Color"] = "背景顏色",
	--[[ zhTW ]] ["Sets the backdrop color of the health bar"] = "生命力條背景顏色",
	--[[ zhTW ]] ["Pet"] = "寵物",
	--[[ zhTW ]] ["Sets the health bar color for your pet"] = "寵物的生命力條顏色",
	--[[ zhTW ]] ["Friendly Players"] = "友好玩家",
	--[[ zhTW ]] ["Sets the health bar color for friendly players"] = "友好玩家的生命力條顏色",
	--[[ zhTW ]] ["Friendly Pets"] = "友好寵物",
	--[[ zhTW ]] ["Sets the health bar color for friendly pets"] = "友好寵物的生命力條顏色",
	--[[ zhTW ]] ["Friendly NPCs"] = "友好NPC",
	--[[ zhTW ]] ["Sets the health bar color for friendly NPC Bosses"] = "友好NPC的生命力條顏色",
	--[[ zhTW ]] ["Friendly Boss"] = "友好首領",
	--[[ zhTW ]] ["Sets the health bar color for friendly NPCs"] = "友好首領的生命力條顏色",
	--[[ zhTW ]] ["Hostile Players"] = "敵對玩家",
	--[[ zhTW ]] ["Sets the health bar color for hostile players"] = "敵對玩家的生命力條顏色",
	--[[ zhTW ]] ["Hostile Pets"] = "敵對寵物",
	--[[ zhTW ]] ["Sets the health bar color for hostile pets"] = "敵對寵物的生命力條顏色",
	--[[ zhTW ]] ["Hostile NPCs"] = "敵對NPC",
	--[[ zhTW ]] ["Sets the health bar color for hostile units"] = "敵對NPC的生命力條顏色",
	--[[ zhTW ]] ["Hostile Boss"] = "敵對玩家",
	--[[ zhTW ]] ["Sets the health bar color for hostile boss units"] = "敵對首領的生命力條顏色",
	--[[ zhTW ]] ["Neutral Units"] = "中立單位",
	--[[ zhTW ]] ["Sets the health bar color for neutral units"] = "中立單位的生命力條顏色",
	--[[ zhTW ]] ["Group Pets"] = "團體寵物",
	--[[ zhTW ]] ["Sets the health bar color for group pets"] = "團體寵物的生命力條顏色",
	--[[ zhTW ]] ["Unknown"] = "Unknown",
	--[[ zhTW ]] ["Sets the health bar color for unknown units"] = "Sets the health bar color for unknown units",
	--[[ zhTW ]] ["Reset to Defaults"] = "重設回預設值",
	--[[ zhTW ]] ["Resets all colors to their defaults"] = "重設全部顏色回預設值",

	--[[ zhTW ]] ["Border"] = "Border",
	--[[ zhTW ]] ["Border options"] = "Border options",
	--[[ zhTW ]] ["Target Only"] = "Target Only",
	--[[ zhTW ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ zhTW ]] ["Border Color"] = "邊框顏色",
	--[[ zhTW ]] ["Sets the border color of the health bar"] = "Sets the border color of the health bar",
	--[[ zhTW ]] ["Border Style"] = "邊框樣式",
	--[[ zhTW ]] ["Sets the style of the health bar border"] = "Sets the style of the health bar border",

	--[[ zhTW ]] ["Advanced"] = "進階",
	--[[ zhTW ]] ["Options for expert users"] = "進階選項",
	--[[ zhTW ]] ["Color Format"] = "顏色格式",
	--[[ zhTW ]] ["Color tag"] = "顏色標籤",
	--[[ zhTW ]] ["<Any tag string>"] = "<任何標籤文字>",
} end)

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthBarDeficit", function()

-----------------------------------------------------------------------------

fL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Deficit Health Bar"] = "虧減生命條",
	--[[ zhTW ]] ["Display health bar as a deficit (grows from right as health is lost)"] = "將生命條顯示為虧減模式（隨著生命值喪失從右側增長）",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
