local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local bL = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] bL["Health Bar"] = "Health Bar"
--[[ enUS ]] bL["Health Bar options"] = "Health Bar options"

--[[ enUS ]] bL["Texture"] = "Texture"
--[[ enUS ]] bL["Sets the health bar texture"] = "Sets the health bar texture"
--[[ enUS ]] bL["Enable Horizontal Tiling"] = "Enable Horizontal Tiling"
--[[ enUS ]] bL["Enable horizontal tiling of the health bar texture"] = "Enable horizontal tiling of the health bar texture"
--[[ enUS ]] bL["Alpha"] = "Alpha"
--[[ enUS ]] bL["Sets the health bar alpha"] = "Sets the health bar alpha"

--[[ enUS ]] bL["Size"] = "Size"
--[[ enUS ]] bL["Adjust health bar's size"] = "Adjust health bar's size"
--[[ enUS ]] bL["Width"] = "Width"
--[[ enUS ]] bL["Sets the width of the health bar"] = "Sets the width of the health bar"
--[[ enUS ]] bL["Height"] = "Height"
--[[ enUS ]] bL["Sets the height of the health bar"] = "Sets the height of the health bar"

--[[ enUS ]] bL["Position"] = "Position"
--[[ enUS ]] bL["Adjust the health bar's position"] = "Adjust the health bar's position"
--[[ enUS ]] bL["Left Offset"] = "Left Offset"
--[[ enUS ]] bL["Sets the offset of the left of the health bar"] = "Sets the offset of the left of the health bar"
--[[ enUS ]] bL["Right Offset"] = "Right Offset"
--[[ enUS ]] bL["Sets the offset of the right of the health bar"] = "Sets the offset of the right of the health bar"
--[[ enUS ]] bL["Vertical Offset"] = "Vertical Offset"
--[[ enUS ]] bL["Sets the vertical offset of the health bar"] = "Sets the vertical offset of the health bar"

--[[ enUS ]] bL["Colors"] = "Colors"
--[[ enUS ]] bL["Customize colors"] = "Customize colors"
--[[ enUS ]] bL["Color by Class"] = "Color by Class"
--[[ enUS ]] bL["Sets the health bar color of players according to class"] = "Sets the health bar color of players according to class"
--[[ enUS ]] bL["Color Hostile by Class"] = "Color Hostile by Class"
--[[ enUS ]] bL["Sets the health bar color of hostile players according to class"] = "Sets the health bar color of hostile players according to class"
--[[ enUS ]] bL["Backdrop Color"] = "Backdrop Color"
--[[ enUS ]] bL["Sets the backdrop color of the health bar"] = "Sets the backdrop color of the health bar"
--[[ enUS ]] bL["Pet"] = "Pet"
--[[ enUS ]] bL["Sets the health bar color for your pet"] = "Sets the health bar color for your pet"
--[[ enUS ]] bL["Friendly Players"] = "Friendly Players"
--[[ enUS ]] bL["Sets the health bar color for friendly players"] = "Sets the health bar color for friendly players"
--[[ enUS ]] bL["Friendly Pets"] = "Friendly Pets"
--[[ enUS ]] bL["Sets the health bar color for friendly pets"] = "Sets the health bar color for friendly pets"
--[[ enUS ]] bL["Friendly NPCs"] = "Friendly NPCs"
--[[ enUS ]] bL["Sets the health bar color for friendly NPC Bosses"] = "Sets the health bar color for friendly NPC Bosses"
--[[ enUS ]] bL["Friendly Boss"] = "Friendly Boss"
--[[ enUS ]] bL["Sets the health bar color for friendly NPCs"] = "Sets the health bar color for friendly NPCs"
--[[ enUS ]] bL["Hostile Players"] = "Hostile Players"
--[[ enUS ]] bL["Sets the health bar color for hostile players"] = "Sets the health bar color for hostile players"
--[[ enUS ]] bL["Hostile Pets"] = "Hostile Pets"
--[[ enUS ]] bL["Sets the health bar color for hostile pets"] = "Sets the health bar color for hostile pets"
--[[ enUS ]] bL["Hostile NPCs"] = "Hostile NPCs"
--[[ enUS ]] bL["Sets the health bar color for hostile units"] = "Sets the health bar color for hostile units"
--[[ enUS ]] bL["Hostile Boss"] = "Hostile Boss"
--[[ enUS ]] bL["Sets the health bar color for hostile boss units"] = "Sets the health bar color for hostile boss units"
--[[ enUS ]] bL["Neutral Units"] = "Neutral Units"
--[[ enUS ]] bL["Sets the health bar color for neutral units"] = "Sets the health bar color for neutral units"
--[[ enUS ]] bL["Group Pets"] = "Group Pets"
--[[ enUS ]] bL["Sets the health bar color for group pets"] = "Sets the health bar color for group pets"
--[[ enUS ]] bL["Unknown"] = "Unknown"
--[[ enUS ]] bL["Sets the health bar color for unknown units"] = "Sets the health bar color for unknown units"
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
--[[ enUS ]] bL["Sets the border color of the health bar"] = "Sets the border color of the health bar"
--[[ enUS ]] bL["Border Style"] = "Border Style"
--[[ enUS ]] bL["Sets the style of the health bar border"] = "Sets the style of the health bar border"

--[[ enUS ]] bL["Advanced"] = "Advanced"
--[[ enUS ]] bL["Options for expert users"] = "Options for expert users"
--[[ enUS ]] bL["Color Format"] = "Color Format"
--[[ enUS ]] bL["Color tag"] = "Color tag"
--[[ enUS ]] bL["<Any tag string>"] = "<Any tag string>"

--[[ enUS ]] bL["Deficit Health Bar"] = "Deficit Health Bar"
--[[ enUS ]] bL["Display health bar as a deficit (grows from right as health is lost)"] = "Display health bar as a deficit (grows from right as health is lost)"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] bL["Health Bar"] = "생명력바"
--[[ koKR ]] bL["Health Bar options"] = "생명력바 설정"

--[[ koKR ]] bL["Texture"] = "텍스쳐"
--[[ koKR ]] bL["Sets the health bar texture"] = "생명력바의 텍스쳐를 설정합니다."
--[[ koKR ]] bL["Enable Horizontal Tiling"] = "Enable Horizontal Tiling"
--[[ koKR ]] bL["Enable horizontal tiling of the health bar texture"] = "Enable horizontal tiling of the health bar texture"
--[[ koKR ]] bL["Alpha"] = "투명도"
--[[ koKR ]] bL["Sets the health bar alpha"] = "생명력바의 투명도를 설정합니다."

--[[ koKR ]] bL["Size"] = "크기"
--[[ koKR ]] bL["Adjust health bar's size"] = "생명력바의 크기를 조절합니다."
--[[ koKR ]] bL["Width"] = "너비"
--[[ koKR ]] bL["Sets the width of the health bar"] = "생명력바의 너비를 설정합니다."
--[[ koKR ]] bL["Height"] = "높이"
--[[ koKR ]] bL["Sets the height of the health bar"] = "생명력바의 높이를 설정합니다."

--[[ koKR ]] bL["Position"] = "위치"
--[[ koKR ]] bL["Adjust the health bar's position"] = "생명력바의 위치를 조절합니다."
--[[ koKR ]] bL["Left Offset"] = "Left Offset"
--[[ koKR ]] bL["Sets the offset of the left of the health bar"] = "Sets the offset of the left of the health bar"
--[[ koKR ]] bL["Right Offset"] = "Right Offset"
--[[ koKR ]] bL["Sets the offset of the right of the health bar"] = "Sets the offset of the right of the health bar"
--[[ koKR ]] bL["Vertical Offset"] = "Vertical Offset"
--[[ koKR ]] bL["Sets the vertical offset of the health bar"] = "Sets the vertical offset of the health bar"

--[[ koKR ]] bL["Colors"] = "색상"
--[[ koKR ]] bL["Customize colors"] = "사용자 색상"
--[[ koKR ]] bL["Color by Class"] = "직업에 따른 색상"
--[[ koKR ]] bL["Sets the health bar color of players according to class"] = "플레이어의 생명력바에 직업별 색상을 설정합니다."
--[[ koKR ]] bL["Color Hostile by Class"] = "적대적 직업별 색상"
--[[ koKR ]] bL["Sets the health bar color of hostile players according to class"] = "적대적 플레이어의 생명력바에 직업별 색상을 설정합니다."
--[[ koKR ]] bL["Backdrop Color"] = "배경 색상"
--[[ koKR ]] bL["Sets the backdrop color of the health bar"] = "생명력바의 배경 색상을 설정합니다."
--[[ koKR ]] bL["Pet"] = "소환수"
--[[ koKR ]] bL["Sets the health bar color for your pet"] = "소환수의 생명력바 색상을 설정합니다."
--[[ koKR ]] bL["Friendly Players"] = "우호적 플레이어"
--[[ koKR ]] bL["Sets the health bar color for friendly players"] = "우호적 플레이어에 대한 생명력바 색상을 설정합니다."
--[[ koKR ]] bL["Friendly Pets"] = "우호적 소환수"
--[[ koKR ]] bL["Sets the health bar color for friendly pets"] = "우호적 소환수의 생명력바 색상을 설정합니다."
--[[ koKR ]] bL["Friendly NPCs"] = "우호적 NPC"
--[[ koKR ]] bL["Sets the health bar color for friendly NPC Bosses"] =  "우호적 NPC 보스에 대한 생명력바 색상을 설정합니다."
--[[ koKR ]] bL["Friendly Boss"] = "우호적 보스"
--[[ koKR ]] bL["Sets the health bar color for friendly NPCs"] = "우호적 NPC에 대한 생명력바 색상을 설정합니다."
--[[ koKR ]] bL["Hostile Players"] = "적대적 플레이어"
--[[ koKR ]] bL["Sets the health bar color for hostile players"] = "적대적 플레이어의 생명력바의 색상을 설정합니다."
--[[ koKR ]] bL["Hostile Pets"] = "적대적 소환수"
--[[ koKR ]] bL["Sets the health bar color for hostile pets"] = "적대적 소환수의 생명력바 색상을 설정합니다."
--[[ koKR ]] bL["Hostile NPCs"] = "적대적 NPC"
--[[ koKR ]] bL["Sets the health bar color for hostile units"] = "적대적 대상에 대한 생명력바 색상을 설정합니다."
--[[ koKR ]] bL["Hostile Boss"] = "적대적 보스"
--[[ koKR ]] bL["Sets the health bar color for hostile boss units"] = "적대적 보스에 대한 생명력바 색상을 설정합니다."
--[[ koKR ]] bL["Neutral Units"] = "중립적 대상"
--[[ koKR ]] bL["Sets the health bar color for neutral units"] = "중립적 대상에 대한 생명력바 색상을 설정합니다."
--[[ koKR ]] bL["Group Pets"] = "파티 소환수"
--[[ koKR ]] bL["Sets the health bar color for group pets"] = "파티 소환수에 대한 생명력바 색상을 설정합니다."
--[[ koKR ]] bL["Unknown"] = "Unknown"
--[[ koKR ]] bL["Sets the health bar color for unknown units"] = "Sets the health bar color for unknown units"
--[[ koKR ]] bL["Reset to Defaults"] = "기본값으로 초기화"
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
--[[ koKR ]] bL["Sets the border color of the health bar"] = "Sets the border color of the health bar"
--[[ koKR ]] bL["Border Style"] = "테두리 스타일"
--[[ koKR ]] bL["Sets the style of the health bar border"] = "Sets the style of the health bar border"

--[[ koKR ]] bL["Advanced"] = "고급"
--[[ koKR ]] bL["Options for expert users"] = "고급 사용자를 위한 설정입니다."
--[[ koKR ]] bL["Color Format"] = "색상 형식"
--[[ koKR ]] bL["Color tag"] = "색상 태그"
--[[ koKR ]] bL["<Any tag string>"] = "<태그 문자열>"

--[[ koKR ]] bL["Deficit Health Bar"] = "Deficit Health Bar"
--[[ koKR ]] bL["Display health bar as a deficit (grows from right as health is lost)"] = "Display health bar as a deficit (grows from right as health is lost)"

-----------------------------------------------------------------------------

-- end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] bL["Health Bar"] = "Полоска здоровья"
--[[ ruRU ]] bL["Health Bar options"] = "Настройка полосы здоровья"

--[[ ruRU ]] bL["Texture"] = "Текстура"
--[[ ruRU ]] bL["Sets the health bar texture"] = "Задает текстуру полоски здоровья"
--[[ ruRU ]] bL["Enable Horizontal Tiling"] = "Enable Horizontal Tiling"
--[[ ruRU ]] bL["Enable horizontal tiling of the health bar texture"] = "Enable horizontal tiling of the health bar texture"
--[[ ruRU ]] bL["Alpha"] = "Прозрачность"
--[[ ruRU ]] bL["Sets the health bar alpha"] = "Задает прозрачность полоски здоровья"

--[[ ruRU ]] bL["Size"] = "Размер"
--[[ ruRU ]] bL["Adjust health bar's size"] = "Задать размер полоски здоровья"
--[[ ruRU ]] bL["Width"] = "Ширина"
--[[ ruRU ]] bL["Sets the width of the health bar"] = "Задает ширину полоски здоровья"
--[[ ruRU ]] bL["Height"] = "Высота"
--[[ ruRU ]] bL["Sets the height of the health bar"] = "Задает высоту полоски здоровья"

--[[ ruRU ]] bL["Position"] = "Позиция"
--[[ ruRU ]] bL["Adjust the health bar's position"] = "Задать место полоски здоровья"
--[[ ruRU ]] bL["Left Offset"] = "Смещение влево"
--[[ ruRU ]] bL["Sets the offset of the left of the health bar"] = "Смещение текста на полосе здоровья влево"
--[[ ruRU ]] bL["Right Offset"] = "Смещение вправо"
--[[ ruRU ]] bL["Sets the offset of the right of the health bar"] = "Смещение текста на полосе здоровья вправо"
--[[ ruRU ]] bL["Vertical Offset"] = "Смещение по вертикале"
--[[ ruRU ]] bL["Sets the vertical offset of the health bar"] = "Смещение текста на полосе здоровья по вертикале"

--[[ ruRU ]] bL["Colors"] = "Цвета"
--[[ ruRU ]] bL["Customize colors"] = "Настройка цветов"
--[[ ruRU ]] bL["Color by Class"] = "Окрашивать в цвет класса"
--[[ ruRU ]] bL["Sets the health bar color of players according to class"] = "Задает цвет полоски здоровья в зависимости от класса"
--[[ ruRU ]] bL["Color Hostile by Class"] = "Окрашивать враждебных в цвет класса"
--[[ ruRU ]] bL["Sets the health bar color of hostile players according to class"] = "Задает цвет полоски здоровья для враждебных игроков в зависимости от класса"
--[[ ruRU ]] bL["Backdrop Color"] = "Цвет тени"
--[[ ruRU ]] bL["Sets the backdrop color of the health bar"] = "Задает цвет тени полоски здоровья"
--[[ ruRU ]] bL["Pet"] = "Питомец"
--[[ ruRU ]] bL["Sets the health bar color for your pet"] = "Задает цвет полоски здоровья для вашего питомца"
--[[ ruRU ]] bL["Friendly Players"] = "Дружественные игроки"
--[[ ruRU ]] bL["Sets the health bar color for friendly players"] = "Задает цвет полоски здоровья для дружественных игроков"
--[[ ruRU ]] bL["Friendly Pets"] = "Дружественные питомцы"
--[[ ruRU ]] bL["Sets the health bar color for friendly pets"] = "Задает цвет полоски здоровья для дружественных питомцев"
--[[ ruRU ]] bL["Friendly NPCs"] = "Дружественные NPC"
--[[ ruRU ]] bL["Sets the health bar color for friendly NPC Bosses"] = "Задает цвет полоски здоровья для дружественных НИПов боссов"
--[[ ruRU ]] bL["Friendly Boss"] = "Дружественный босс"
--[[ ruRU ]] bL["Sets the health bar color for friendly NPCs"] = "Задает цвет полоски здоровья для дружественных НИПов"
--[[ ruRU ]] bL["Hostile Players"] = "Враждебные игроки"
--[[ ruRU ]] bL["Sets the health bar color for hostile players"] = "Задает цвет полоски здоровья для враждебных игроков"
--[[ ruRU ]] bL["Hostile Pets"] = "Враждебные питомцы"
--[[ ruRU ]] bL["Sets the health bar color for hostile pets"] = "Задает цвет полоски здоровья для враждебных питомцев"
--[[ ruRU ]] bL["Hostile NPCs"] = "Враждебные NPC"
--[[ ruRU ]] bL["Sets the health bar color for hostile units"] = "Задает цвет полоски здоровья для враждебных единиц"
--[[ ruRU ]] bL["Hostile Boss"] = "Враждебный босс"
--[[ ruRU ]] bL["Sets the health bar color for hostile boss units"] = "Задает цвет полоски здоровья для враждебных боссов"
--[[ ruRU ]] bL["Neutral Units"] = "Нейтральные цели"
--[[ ruRU ]] bL["Sets the health bar color for neutral units"] = "Задает цвет полоски здоровья для нейтральных"
--[[ ruRU ]] bL["Group Pets"] = "Питомцы группы"
--[[ ruRU ]] bL["Sets the health bar color for group pets"] = "Задает цвет полоски здоровья для питомцев группы"
--[[ ruRU ]] bL["Unknown"] = "Unknown"
--[[ ruRU ]] bL["Sets the health bar color for unknown units"] = "Sets the health bar color for unknown units"
--[[ ruRU ]] bL["Reset to Defaults"] = "Сброс в настройки по умолчанию"
--[[ ruRU ]] bL["Resets all colors to their defaults"] = "Сбрасывает все цвета в настройки по умолчанию"

--[[ ruRU ]] bL["Border"] = "Края"
--[[ ruRU ]] bL["Border options"] = "Настройки краев"
--[[ ruRU ]] bL["Target Only"] = "Только цель"
--[[ ruRU ]] bL["Enables the border on the current target only"] = "Включить края только для текущей цели"
--[[ ruRU ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ ruRU ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ ruRU ]] bL["Border Inset"] = "Border Inset"
--[[ ruRU ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ ruRU ]] bL["Border Color"] = "Цвет рамки"
--[[ ruRU ]] bL["Sets the border color of the health bar"] = "Sets the border color of the health bar"
--[[ ruRU ]] bL["Border Style"] = "Стиль рамки"
--[[ ruRU ]] bL["Sets the style of the health bar border"] = "Sets the style of the health bar border"

--[[ ruRU ]] bL["Advanced"] = "Дополнительно"
--[[ ruRU ]] bL["Options for expert users"] = "Настройки для опытных пользователей"
--[[ ruRU ]] bL["Color Format"] = "Формат цвета"
--[[ ruRU ]] bL["Color tag"] = "Формат цвета"
--[[ ruRU ]] bL["<Any tag string>"] = "<Любая строка формата>"

--[[ ruRU ]] bL["Deficit Health Bar"] = "Полоска дефицита здоровья"
--[[ ruRU ]] bL["Display health bar as a deficit (grows from right as health is lost)"] = "Отображать на полоске здоровья дефицит здоровья (растет справа с уменьшением здоровья)"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] bL["Health Bar"] = "生命值显示条"
--[[ zhCN ]] bL["Health Bar options"] = "生命值显示条相关设置"

--[[ zhCN ]] bL["Texture"] = "材质"
--[[ zhCN ]] bL["Sets the health bar texture"] = "设定生命值显示条的材质"
--[[ zhCN ]] bL["Enable Horizontal Tiling"] = "Enable Horizontal Tiling"
--[[ zhCN ]] bL["Enable horizontal tiling of the health bar texture"] = "Enable horizontal tiling of the health bar texture"
--[[ zhCN ]] bL["Alpha"] = "透明度"
--[[ zhCN ]] bL["Sets the health bar alpha"] = "设定生命值显示条透明度"

--[[ zhCN ]] bL["Size"] = "尺寸"
--[[ zhCN ]] bL["Adjust health bar's size"] = "调整生命值显示条的尺寸"
--[[ zhCN ]] bL["Width"] = "宽度"
--[[ zhCN ]] bL["Sets the width of the health bar"] = "设定生命值显示条的宽度"
--[[ zhCN ]] bL["Height"] = "高度"
--[[ zhCN ]] bL["Sets the height of the health bar"] = "设定生命值显示条的高度"

--[[ zhCN ]] bL["Position"] = "位置"
--[[ zhCN ]] bL["Adjust the health bar's position"] = "调整生命值显示条的位置"
--[[ zhCN ]] bL["Left Offset"] = "Left Offset"
--[[ zhCN ]] bL["Sets the offset of the left of the health bar"] = "Sets the offset of the left of the health bar"
--[[ zhCN ]] bL["Right Offset"] = "Right Offset"
--[[ zhCN ]] bL["Sets the offset of the right of the health bar"] = "Sets the offset of the right of the health bar"
--[[ zhCN ]] bL["Vertical Offset"] = "Vertical Offset"
--[[ zhCN ]] bL["Sets the vertical offset of the health bar"] = "Sets the vertical offset of the health bar"

--[[ zhCN ]] bL["Colors"] = "颜色"
--[[ zhCN ]] bL["Customize colors"] = "自定义颜色"
--[[ zhCN ]] bL["Color by Class"] = "显示职业代表色"
--[[ zhCN ]] bL["Sets the health bar color of players according to class"] = "生命值显示条颜色使用职业颜色"
--[[ zhCN ]] bL["Color Hostile by Class"] = "敌对方单位根据职业显示颜色"
--[[ zhCN ]] bL["Sets the health bar color of hostile players according to class"] = "敌对方玩家的生命值显示条颜色使用职业代表色"
--[[ zhCN ]] bL["Backdrop Color"] = "背景颜色"
--[[ zhCN ]] bL["Sets the backdrop color of the health bar"] = "设定生命值显示条的背景颜色"
--[[ zhCN ]] bL["Pet"] = "宠物"
--[[ zhCN ]] bL["Sets the health bar color for your pet"] = "设定宠物的生命值显示条颜色"
--[[ zhCN ]] bL["Friendly Players"] = "友好方玩家"
--[[ zhCN ]] bL["Sets the health bar color for friendly players"] = "设定友好方玩家的生命值显示条颜色"
--[[ zhCN ]] bL["Friendly Pets"] = "友好方宠物"
--[[ zhCN ]] bL["Sets the health bar color for friendly pets"] = "设定友好方宠物的生命值显示条颜色"
--[[ zhCN ]] bL["Friendly NPCs"] = "友好方NPC"
--[[ zhCN ]] bL["Sets the health bar color for friendly NPC Bosses"] = "设定友好方NPC的生命值显示条颜色"
--[[ zhCN ]] bL["Friendly Boss"] = "友好方首领"
--[[ zhCN ]] bL["Sets the health bar color for friendly NPCs"] = "设定友好方首领的生命值显示条颜色"
--[[ zhCN ]] bL["Hostile Players"] = "敌对方玩家"
--[[ zhCN ]] bL["Sets the health bar color for hostile players"] = "设定敌对方玩家的生命值显示条颜色"
--[[ zhCN ]] bL["Hostile Pets"] = "敌对方宠物"
--[[ zhCN ]] bL["Sets the health bar color for hostile pets"] = "设定敌对方宠物的生命值显示条颜色"
--[[ zhCN ]] bL["Hostile NPCs"] = "敌对方NPC"
--[[ zhCN ]] bL["Sets the health bar color for hostile units"] = "设定敌对方NPC的生命值显示条颜色"
--[[ zhCN ]] bL["Hostile Boss"] = "敌对方首领"
--[[ zhCN ]] bL["Sets the health bar color for hostile boss units"] = "设定敌对方首领的生命值显示条颜色"
--[[ zhCN ]] bL["Neutral Units"] = "中立方单位"
--[[ zhCN ]] bL["Sets the health bar color for neutral units"] = "设定中立方单位的生命值显示条颜色"
--[[ zhCN ]] bL["Group Pets"] = "队友宠物"
--[[ zhCN ]] bL["Sets the health bar color for group pets"] = "队友宠物的生命值显示条颜色"
--[[ zhCN ]] bL["Unknown"] = "Unknown"
--[[ zhCN ]] bL["Sets the health bar color for unknown units"] = "Sets the health bar color for unknown units"
--[[ zhCN ]] bL["Reset to Defaults"] = "重置为默认"
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
--[[ zhCN ]] bL["Sets the border color of the health bar"] = "Sets the border color of the health bar"
--[[ zhCN ]] bL["Border Style"] = "边框样式"
--[[ zhCN ]] bL["Sets the style of the health bar border"] = "Sets the style of the health bar border"

--[[ zhCN ]] bL["Advanced"] = "高级"
--[[ zhCN ]] bL["Options for expert users"] = "高级设置"
--[[ zhCN ]] bL["Color Format"] = "颜色格式"
--[[ zhCN ]] bL["Color tag"] = "颜色标签"
--[[ zhCN ]] bL["<Any tag string>"] = "<任意标签文字>"

--[[ zhCN ]] bL["Deficit Health Bar"] = "亏减生命条"
--[[ zhCN ]] bL["Display health bar as a deficit (grows from right as health is lost)"] = "将生命条显示为亏减模式（随着生命值丧失从右侧增长）"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] bL["Health Bar"] = "生命條"
--[[ zhTW ]] bL["Health Bar options"] = "生命條設定"

--[[ zhTW ]] bL["Texture"] = "材質"
--[[ zhTW ]] bL["Sets the health bar texture"] = "設定生命條材質"
--[[ zhTW ]] bL["Enable Horizontal Tiling"] = "啟用水平分層"
--[[ zhTW ]] bL["Enable horizontal tiling of the health bar texture"] = "啟用生命條材質的水平分層"
--[[ zhTW ]] bL["Alpha"] = "透明度"
--[[ zhTW ]] bL["Sets the health bar alpha"] = "設定生命條透明度"

--[[ zhTW ]] bL["Size"] = "大小"
--[[ zhTW ]] bL["Adjust health bar's size"] = "調整生命條大小"
--[[ zhTW ]] bL["Width"] = "寬度"
--[[ zhTW ]] bL["Sets the width of the health bar"] = "設定生命條的寬度"
--[[ zhTW ]] bL["Height"] = "高度"
--[[ zhTW ]] bL["Sets the height of the health bar"] = "設定生命條的高度"

--[[ zhTW ]] bL["Position"] = "位置"
--[[ zhTW ]] bL["Adjust the health bar's position"] = "調整生命條的位置"
--[[ zhTW ]] bL["Left Offset"] = "左偏移"
--[[ zhTW ]] bL["Sets the offset of the left of the health bar"] = "設定生命條的左偏移"
--[[ zhTW ]] bL["Right Offset"] = "右偏移"
--[[ zhTW ]] bL["Sets the offset of the right of the health bar"] = "設定生命條的右偏移"
--[[ zhTW ]] bL["Vertical Offset"] = "垂直偏移"
--[[ zhTW ]] bL["Sets the vertical offset of the health bar"] = "設定生命條的垂直偏移"

--[[ zhTW ]] bL["Colors"] = "顏色"
--[[ zhTW ]] bL["Customize colors"] = "自定顏色"
--[[ zhTW ]] bL["Color by Class"] = "著色根據職業"
--[[ zhTW ]] bL["Sets the health bar color of players according to class"] = "設定玩家的生命條顏色根據職業"
--[[ zhTW ]] bL["Color Hostile by Class"] = "著色敵對根據職業"
--[[ zhTW ]] bL["Sets the health bar color of hostile players according to class"] = "設定敵對玩家的生命條顏色根據職業"
--[[ zhTW ]] bL["Backdrop Color"] = "背景顏色"
--[[ zhTW ]] bL["Sets the backdrop color of the health bar"] = "設定生命條的背景顏色"
--[[ zhTW ]] bL["Pet"] = "寵物"
--[[ zhTW ]] bL["Sets the health bar color for your pet"] = "設定寵物的生命條顏色"
--[[ zhTW ]] bL["Friendly Players"] = "友好玩家"
--[[ zhTW ]] bL["Sets the health bar color for friendly players"] = "設定友好玩家的生命條顏色"
--[[ zhTW ]] bL["Friendly Pets"] = "友好寵物"
--[[ zhTW ]] bL["Sets the health bar color for friendly pets"] = "捨定友好寵物的生命條顏色"
--[[ zhTW ]] bL["Friendly NPCs"] = "友好NPC"
--[[ zhTW ]] bL["Sets the health bar color for friendly NPC Bosses"] = "設定友好NPC的生命條顏色"
--[[ zhTW ]] bL["Friendly Boss"] = "友好首領"
--[[ zhTW ]] bL["Sets the health bar color for friendly NPCs"] = "設定友好首領的生命條顏色"
--[[ zhTW ]] bL["Hostile Players"] = "敵對玩家"
--[[ zhTW ]] bL["Sets the health bar color for hostile players"] = "設定敵對玩家的生命條顏色"
--[[ zhTW ]] bL["Hostile Pets"] = "敵對寵物"
--[[ zhTW ]] bL["Sets the health bar color for hostile pets"] = "設定敵對寵物的生命條顏色"
--[[ zhTW ]] bL["Hostile NPCs"] = "敵對NPC"
--[[ zhTW ]] bL["Sets the health bar color for hostile units"] = "設定敵對NPC的生命條顏色"
--[[ zhTW ]] bL["Hostile Boss"] = "敵對玩家"
--[[ zhTW ]] bL["Sets the health bar color for hostile boss units"] = "設定敵對首領的生命條顏色"
--[[ zhTW ]] bL["Neutral Units"] = "中立單位"
--[[ zhTW ]] bL["Sets the health bar color for neutral units"] = "設定中立單位的生命條顏色"
--[[ zhTW ]] bL["Group Pets"] = "隊伍寵物"
--[[ zhTW ]] bL["Sets the health bar color for group pets"] = "設定隊伍寵物的生命條顏色"
--[[ zhTW ]] bL["Unknown"] = "未知"
--[[ zhTW ]] bL["Sets the health bar color for unknown units"] = "設定未知單位的生命條顏色"
--[[ zhTW ]] bL["Reset to Defaults"] = "重置到預設"
--[[ zhTW ]] bL["Resets all colors to their defaults"] = "重置全部顏色到預設"

--[[ zhTW ]] bL["Border"] = "邊框"
--[[ zhTW ]] bL["Border options"] = "邊框設定"
--[[ zhTW ]] bL["Target Only"] = "只在目標"
--[[ zhTW ]] bL["Enables the border on the current target only"] = "啟用只在目前目標的邊框"
--[[ zhTW ]] bL["Border Edge Size"] = "邊框邊緣大小"
--[[ zhTW ]] bL["Sets the thickness of the border"] = "設定邊框的寬度"
--[[ zhTW ]] bL["Border Inset"] = "邊框崁入"
--[[ zhTW ]] bL["Sets the padding aroundthe border"] = "設定邊框的間距範圍"
--[[ zhTW ]] bL["Border Color"] = "邊框顏色"
--[[ zhTW ]] bL["Sets the border color of the health bar"] = "設定生命條的邊框顏色"
--[[ zhTW ]] bL["Border Style"] = "邊框樣式"
--[[ zhTW ]] bL["Sets the style of the health bar border"] = "設定生命條的樣式"

--[[ zhTW ]] bL["Advanced"] = "進階"
--[[ zhTW ]] bL["Options for expert users"] = "熟練的使用者設定"
--[[ zhTW ]] bL["Color Format"] = "顏色格式"
--[[ zhTW ]] bL["Color tag"] = "顏色標籤"
--[[ zhTW ]] bL["<Any tag string>"] = "<任何標籤文字>"

--[[ zhTW ]] bL["Deficit Health Bar"] = "虧減生命條"
--[[ zhTW ]] bL["Display health bar as a deficit (grows from right as health is lost)"] = "將生命條顯示為虧減模式（隨著生命值喪失從右側增長）"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftHealthBar = setmetatable(bL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
bL = nil

-----------------------------------------------------------------------------
