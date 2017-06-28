local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local dL = AceLibrary("AceLocale-2.2"):new("AloftVisibilityData")

-----------------------------------------------------------------------------

local oL = AceLibrary("AceLocale-2.2"):new("AloftVisibilityOptions")

-----------------------------------------------------------------------------

local oT = AceLibrary("AceLocale-2.2"):new("AloftVisibilityTotems")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Critter"] = true,
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Visibility"] = true,
	--[[ enUS ]] ["Extra visibility options"] = true,

	--[[ enUS ]] ["Show Hostile Players"] = true,
	--[[ enUS ]] ["Shows nameplates for hostile players"] = true,
	--[[ enUS ]] ["Show Hostile Pets"] = true,
	--[[ enUS ]] ["Shows nameplates for hostile pets"] = true,
	--[[ enUS ]] ["Show Hostile NPCs"] = true,
	--[[ enUS ]] ["Show hostile NPCs"] = true,

	--[[ enUS ]] ["Friendly Players"] = true,
	--[[ enUS ]] ["Selects which friendly players to show"] = true,
	--[[ enUS ]] ["Show Pet"] = true,
	--[[ enUS ]] ["Shows nameplates for your pets"] = true,
	--[[ enUS ]] ["Show Group Pets"] = true,
	--[[ enUS ]] ["Shows nameplates for group pets"] = true,
	--[[ enUS ]] ["Show Friendly Pets"] = true,
	--[[ enUS ]] ["Shows nameplates for friendly pets"] = true,
	--[[ enUS ]] ["Show Friendly NPCs"] = true,
	--[[ enUS ]] ["Show friendly NPCs"] = true,

	--[[ enUS ]] ["Critters"] = true,
	--[[ enUS ]] ["Visibility options for critters"] = true,
	--[[ enUS ]] ["Critter Level"] = true,
	--[[ enUS ]] ["Assume neutral units below this level are 'critters'"] = true,
	--[[ enUS ]] ["Critter Health"] = true,
	--[[ enUS ]] ["Assume neutral units below this health are 'critters'"] = true,
	--[[ enUS ]] ["Show Critters"] = true,
	--[[ enUS ]] ["Shows nameplates for critters"] = true,

	--[[ enUS ]] ["Show Neutral Units"] = true,
	--[[ enUS ]] ["Show neutral units"] = true,

	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Exceptions"] = true,
	--[[ enUS ]] ["Enable Tremor Totem"] = true,
	--[[ enUS ]] ["Dedicated Tremor Totem Color"] = true,
	--[[ enUS ]] ["Enable Grounding Totem"] = true,
	--[[ enUS ]] ["Dedicated Grounding Totem Color"] = true,
	--[[ enUS ]] ["Enable Earthbind Totem"] = true,
	--[[ enUS ]] ["Dedicated Earthbind Totem Color"] = true,
	--[[ enUS ]] ["Enable Cleansing Totem"] = true,
	--[[ enUS ]] ["Dedicated Cleansing Totem Color"] = true,
	--[[ enUS ]] ["Enable Mana Tide Totem"] = true,
	--[[ enUS ]] ["Dedicated Mana Tide Totem Color"] = true,

	--[[ enUS ]] ["Show Hostile Totems/Trap Snakes/Bloodworms"] = true,
	--[[ enUS ]] ["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = true,
	--[[ enUS ]] ["Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = true,
	--[[ enUS ]] ["Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"] = true,
	--[[ enUS ]] ["Sets the dedicated color for hostile tremor totem nameplates"] = true,
	--[[ enUS ]] ["Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"] = true,
	--[[ enUS ]] ["Sets the dedicated color for hostile grounding totem nameplates"] = true,
	--[[ enUS ]] ["Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"] = true,
	--[[ enUS ]] ["Sets the dedicated color for hostile earthbind totem nameplates"] = true,
	--[[ enUS ]] ["Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"] = true,
	--[[ enUS ]] ["Sets the dedicated color for hostile cleansing totem nameplates"] = true,
	--[[ enUS ]] ["Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"] = true,
	--[[ enUS ]] ["Sets the dedicated color for hostile mana tide totem nameplates"] = true,

	--[[ enUS ]] ["Show Friendly Totems/Trap Snakes/Bloodworms"] = true,
	--[[ enUS ]] ["Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = true,
	--[[ enUS ]] ["Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = true,
	--[[ enUS ]] ["Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"] = true,
	--[[ enUS ]] ["Sets the dedicated color for friendly tremor totem nameplates"] = true,
	--[[ enUS ]] ["Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"] = true,
	--[[ enUS ]] ["Sets the dedicated color for friendly grounding totem nameplates"] = true,
	--[[ enUS ]] ["Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"] = true,
	--[[ enUS ]] ["Sets the dedicated color for friendly earthbind totem nameplates"] = true,

	--[[ enUS ]] ["Use Nameplate Alpha In Combat"] = true,
	--[[ enUS ]] ["Controls nameplate visibility in combat by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load, and the nameplate remains mouse-sensitive until combat ends)"] = true,
	
	--[[ enUS ]] ["Hide Unit Names"] = true,
	--[[ enUS ]] ["Hide nameplates by unit name"] = true,
	--[[ enUS ]] ["Hide Unit Name"] = true,
	--[[ enUS ]] ["Hide Current Target"] = true,
	--[[ enUS ]] ["Add current target to list of unit names to hide"] = true,
	--[[ enUS ]] ["Add given name to list of unit names to hide"] = true,
	--[[ enUS ]] ["Enter any unit name, then enter <return>"] = true,
	--[[ enUS ]] ["Delete Unit Name"] = true,
	--[[ enUS ]] ["Delete from list of unit names to hide"] = true,
	--[[ enUS ]] ["Select a unit name to delete it from the list"] = true,

	--[[ enUS ]] ["All"] = true,
	--[[ enUS ]] ["Group Only"] = true,
	--[[ enUS ]] ["Guild Only"] = true,
	--[[ enUS ]] ["None"] = true,
} end)

-----------------------------------------------------------------------------

oT:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Tremor Totem"] = true,
	--[[ enUS ]] ["Grounding Totem"] = true,
	--[[ enUS ]] ["Earthbind Totem"] = true,
	--[[ enUS ]] ["Cleansing Totem"] = true,
	--[[ enUS ]] ["Mana Tide Totem"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "deDE") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

oT:RegisterTranslations("deDE", function() return {
	--[[ deDE ]] ["Tremor Totem"]		= "Totem des Erdstoßes",
	--[[ deDE ]] ["Grounding Totem"]	= "Totem der Erdung",
	--[[ deDE ]] ["Earthbind Totem"]	= "Totem der Erdbindung",
	--[[ deDE ]] ["Cleansing Totem"]	= "Totem der Reinigung",
	--[[ deDE ]] ["Mana Tide Totem"]	= "Totem der Manaflut",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Critter"]	= "동물",
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Visibility"] = "표시",
	--[[ koKR ]] ["Extra visibility options"] = "추가 표시 설정",

	--[[ koKR ]] ["Show Hostile Players"] = "적대적 플레이어 표시",
	--[[ koKR ]] ["Shows nameplates for hostile players"] = "적대적 플레이어의 이름표를 표시합니다.",
	--[[ koKR ]] ["Show Hostile Pets"] = "적대적 소환수 표시",
	--[[ koKR ]] ["Shows nameplates for hostile pets"] = "적대적 소환수의 이름표를 표시합니다.",
	--[[ koKR ]] ["Show Hostile NPCs"] = "적대적 NPC 표시",
	--[[ koKR ]] ["Show hostile NPCs"] = "적대적 NPC를 표시합니다.",

	--[[ koKR ]] ["Friendly Players"] = "우호적 플레이어",
	--[[ koKR ]] ["Selects which friendly players to show"] = "우호적 플레이어의 표시를 선택합니다.",
	--[[ koKR ]] ["Show Pet"] = "소환수 표시",
	--[[ koKR ]] ["Shows nameplates for your pets"] = "소환수의 이름표를 표시합니다.",
	--[[ koKR ]] ["Show Group Pets"] = "파티 소환수 표시",
	--[[ koKR ]] ["Shows nameplates for group pets"] = "파티 소환수의 이름표를 표시합니다.",
	--[[ koKR ]] ["Show Friendly Pets"] = "우호적 소환수 표시",
	--[[ koKR ]] ["Shows nameplates for friendly pets"] = "우호적 소환수의 이름표를 표시합니다.",
	--[[ koKR ]] ["Show Friendly NPCs"] = "우호적 NPC 표시",
	--[[ koKR ]] ["Show friendly NPCs"] = "우호적 NPC를 표시합니다.",

	--[[ koKR ]] ["Critters"] = "Critters",
	--[[ koKR ]] ["Visibility options for critters"] = "Visibility options for critters",
	--[[ koKR ]] ["Critter Level"] = "Critter Level",
	--[[ koKR ]] ["Assume neutral units below this level are 'critters'"] = "Assume neutral units below this level are 'critters'",
	--[[ koKR ]] ["Critter Health"] = "Critter Health",
	--[[ koKR ]] ["Assume neutral units below this health are 'critters'"] = "Assume neutral units below this health are 'critters'",
	--[[ koKR ]] ["Show Critters"] = "동물 표시",
	--[[ koKR ]] ["Shows nameplates for critters"] = "동물에 대한 이름표를 표시합니다.",

	--[[ koKR ]] ["Show Neutral Units"] = "중립적 대상 표시",
	--[[ koKR ]] ["Show neutral units"] = "중립적 대상을 표시합니다.",

	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Exceptions"] = "Exceptions",
	--[[ koKR ]] ["Enable Tremor Totem"] = "Enable Tremor Totem",
	--[[ koKR ]] ["Dedicated Tremor Totem Color"] = "Dedicated Tremor Totem Color",
	--[[ koKR ]] ["Enable Grounding Totem"] = "Enable Grounding Totem",
	--[[ koKR ]] ["Dedicated Grounding Totem Color"] = "Dedicated Grounding Totem Color",
	--[[ koKR ]] ["Enable Earthbind Totem"] = "Enable Earthbind Totem",
	--[[ koKR ]] ["Dedicated Earthbind Totem Color"] = "Dedicated Earthbind Totem Color",
	--[[ koKR ]] ["Enable Cleansing Totem"] = "Enable Cleansing Totem",
	--[[ koKR ]] ["Dedicated Cleansing Totem Color"] = "Dedicated Cleansing Totem Color",
	--[[ koKR ]] ["Enable Mana Tide Totem"] = "Enable Mana Tide Totem",
	--[[ koKR ]] ["Dedicated Mana Tide Totem Color"] = "Dedicated Mana Tide Totem Color",

	--[[ koKR ]] ["Show Hostile Totems/Trap Snakes/Bloodworms"] = "Show Hostile Totems/Trap Snakes/Bloodworms",
	--[[ koKR ]] ["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)",
	--[[ koKR ]] ["Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)",
	--[[ koKR ]] ["Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile tremor totems (with a dedicated color)",
	--[[ koKR ]] ["Sets the dedicated color for hostile tremor totem nameplates"] = "Sets the dedicated color for hostile tremor totem nameplates",
	--[[ koKR ]] ["Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile grounding totems (with a dedicated color)",
	--[[ koKR ]] ["Sets the dedicated color for hostile grounding totem nameplates"] = "Sets the dedicated color for hostile grounding totem nameplates",
	--[[ koKR ]] ["Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)",
	--[[ koKR ]] ["Sets the dedicated color for hostile earthbind totem nameplates"] = "Sets the dedicated color for hostile earthbind totem nameplates",
	--[[ koKR ]] ["Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)",
	--[[ koKR ]] ["Sets the dedicated color for hostile cleansing totem nameplates"] = "Sets the dedicated color for hostile cleansing totem nameplates",
	--[[ koKR ]] ["Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)",
	--[[ koKR ]] ["Sets the dedicated color for hostile mana tide totem nameplates"] = "Sets the dedicated color for hostile mana tide totem nameplates",

	--[[ koKR ]] ["Show Friendly Totems/Trap Snakes/Bloodworms"] = "Show Friendly Totems/Trap Snakes/Bloodworms",
	--[[ koKR ]] ["Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)",
	--[[ koKR ]] ["Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)",
	--[[ koKR ]] ["Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly tremor totems (with a dedicated color)",
	--[[ koKR ]] ["Sets the dedicated color for friendly tremor totem nameplates"] = "Sets the dedicated color for friendly tremor totem nameplates",
	--[[ koKR ]] ["Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly grounding totems (with a dedicated color)",
	--[[ koKR ]] ["Sets the dedicated color for friendly grounding totem nameplates"] = "Sets the dedicated color for friendly grounding totem nameplates",
	--[[ koKR ]] ["Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)",
	--[[ koKR ]] ["Sets the dedicated color for friendly earthbind totem nameplates"] = "Sets the dedicated color for friendly earthbind totem nameplates",

	--[[ koKR ]] ["Use Nameplate Alpha In Combat"] = "Use Nameplate Alpha In Combat",
	--[[ koKR ]] ["Controls nameplate visibility in combat by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load, and the nameplate remains mouse-sensitive until combat ends)"] = "Controls nameplate visibility in combat by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load, and the nameplate remains mouse-sensitive until combat ends)",

	--[[ koKR ]] ["All"] = "모두",
	--[[ koKR ]] ["Group Only"] = "파티",
	--[[ koKR ]] ["Guild Only"] = "길드",
	--[[ koKR ]] ["None"] = "없음",
} end)

-----------------------------------------------------------------------------

-- TODO: need koKR translation
--[[
oT:RegisterTranslations("koKR", function() return {
}
]]

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Critter"] = "Существо",
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Visibility"] = "Видимость",
	--[[ ruRU ]] ["Extra visibility options"] = "Настройки дополнительной видимости",

	--[[ ruRU ]] ["Show Hostile Players"] = "Отображать враждебных игроков",
	--[[ ruRU ]] ["Shows nameplates for hostile players"] = "Отображает таблички для враждебных игроков",
	--[[ ruRU ]] ["Show Hostile Pets"] = "Отображать враждебных питомцев",
	--[[ ruRU ]] ["Shows nameplates for hostile pets"] = "Отображает таблички для враждебных питомцев",
	--[[ ruRU ]] ["Show Hostile NPCs"] = "Отображать враждебных NPC",
	--[[ ruRU ]] ["Show hostile NPCs"] = "Отображать враждебных NPC",

	--[[ ruRU ]] ["Friendly Players"] = "Дружественные игроки",
	--[[ ruRU ]] ["Selects which friendly players to show"] = "Выбирает, как отображать дружественных игроков",
	--[[ ruRU ]] ["Show Pet"] = "Отображать питомца",
	--[[ ruRU ]] ["Shows nameplates for your pets"] = "Отображает таблички для питомцев",
	--[[ ruRU ]] ["Show Group Pets"] = "Отображать питомцев группы",
	--[[ ruRU ]] ["Shows nameplates for group pets"] = "Отображает таблички для питомцев группы",
	--[[ ruRU ]] ["Show Friendly Pets"] = "Отображать дружественных питомцев",
	--[[ ruRU ]] ["Shows nameplates for friendly pets"] = "Отображает таблички для дружественных питомцев",
	--[[ ruRU ]] ["Show Friendly NPCs"] = "Отображать дружественных NPC",
	--[[ ruRU ]] ["Show friendly NPCs"] = "Отображать дружественных NPC",

	--[[ ruRU ]] ["Critters"] = "Существо",
	--[[ ruRU ]] ["Visibility options for critters"] = "Настройки вида для существ",
	--[[ ruRU ]] ["Critter Level"] = "Уровень существа",
	--[[ ruRU ]] ["Assume neutral units below this level are 'critters'"] = "Нейтральный объект ниже этого уровня предпологаемо будет - 'существо'",
	--[[ ruRU ]] ["Critter Health"] = "Здоровье спутника",
	--[[ ruRU ]] ["Assume neutral units below this health are 'critters'"] = "Нейтральный объект ниже этого уровня здаровья предпологаемо будет 'существо'",
	--[[ ruRU ]] ["Show Critters"] = "Отображать существа",
	--[[ ruRU ]] ["Shows nameplates for critters"] = "Отображает таблички для существ",

	--[[ ruRU ]] ["Show Neutral Units"] = "Отображать нейтральных",
	--[[ ruRU ]] ["Show neutral units"] = "Отображать нейтральных",

	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Exceptions"] = "Исключения",
	--[[ ruRU ]] ["Enable Tremor Totem"] = "Включить Тотем трепета",
	--[[ ruRU ]] ["Dedicated Tremor Totem Color"] = "Цвет выделения Тотема трепета",
	--[[ ruRU ]] ["Enable Grounding Totem"] = "Включить Тотем заземления",
	--[[ ruRU ]] ["Dedicated Grounding Totem Color"] = "Цвет выделения Тотема заземления",
	--[[ ruRU ]] ["Enable Earthbind Totem"] = "Включить Тотем оков земли",
	--[[ ruRU ]] ["Dedicated Earthbind Totem Color"] = "Цвет выделения Тотема оков земли",
	--[[ ruRU ]] ["Enable Cleansing Totem"] = "Enable Cleansing Totem",
	--[[ ruRU ]] ["Dedicated Cleansing Totem Color"] = "Dedicated Cleansing Totem Color",
	--[[ ruRU ]] ["Enable Mana Tide Totem"] = "Enable Mana Tide Totem",
	--[[ ruRU ]] ["Dedicated Mana Tide Totem Color"] = "Dedicated Mana Tide Totem Color",

	--[[ ruRU ]] ["Show Hostile Totems/Trap Snakes/Bloodworms"] = "Показывать враждебные тотемы/ловушки/змеи/кровочерви",
	--[[ ruRU ]] ["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Показывать таблички враждебных тотемов/ловушкек/змеи/кровочервей (влияет на таблички только вне боя)",
	--[[ ruRU ]] ["Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Даже если таблички для враждебных тотемов/ловушкек/змеи/кровочервей скрыты, отображать (с цветовым выделением)",
	--[[ ruRU ]] ["Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"] = "Однозначно показывает таблички враждебного тотема трепета (с цветовым выделением)",
	--[[ ruRU ]] ["Sets the dedicated color for hostile tremor totem nameplates"] = "Установка цвета выделения таблички вреждебного тотема трепета",
	--[[ ruRU ]] ["Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"] = "Однозначно показывает таблички враждебного тотема заземления (с цветовым выделением)",
	--[[ ruRU ]] ["Sets the dedicated color for hostile grounding totem nameplates"] = "становка цвета выделения таблички вреждебного тотема заземления",
	--[[ ruRU ]] ["Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"] = "Однозначно показывает таблички враждебного тотема оков земли (с цветовым выделением)",
	--[[ ruRU ]] ["Sets the dedicated color for hostile earthbind totem nameplates"] = "становка цвета выделения таблички вреждебного тотема оков земли",
	--[[ ruRU ]] ["Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)",
	--[[ ruRU ]] ["Sets the dedicated color for hostile cleansing totem nameplates"] = "Sets the dedicated color for hostile cleansing totem nameplates",
	--[[ ruRU ]] ["Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)",
	--[[ ruRU ]] ["Sets the dedicated color for hostile mana tide totem nameplates"] = "Sets the dedicated color for hostile mana tide totem nameplates",

	--[[ ruRU ]] ["Show Friendly Totems/Trap Snakes/Bloodworms"] = "Показывать дружественные тотемы/ловушки/змеи/кровочерви",
	--[[ ruRU ]] ["Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Показывать таблички дружественных тотемов/ловушкек/змеи/кровочервей (влияет на таблички только вне боя)",
	--[[ ruRU ]] ["Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Даже если таблички для враждебных тотемов/ловушкек/змеи/кровочервей скрыты, отображать (с цветовым выделением)",
	--[[ ruRU ]] ["Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"] = "Однозначно показывает таблички дружественного тотема трепета (с цветовым выделением)",
	--[[ ruRU ]] ["Sets the dedicated color for friendly tremor totem nameplates"] = "Установка цвета выделения таблички дружественного тотема трепета",
	--[[ ruRU ]] ["Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"] = "Однозначно показывает таблички дружественного тотема заземления (с цветовым выделением)",
	--[[ ruRU ]] ["Sets the dedicated color for friendly grounding totem nameplates"] = "Установка цвета выделения таблички дружественного тотема заземления",
	--[[ ruRU ]] ["Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"] = "Однозначно показывает таблички дружественного тотема оков земли (с цветовым выделением)",
	--[[ ruRU ]] ["Sets the dedicated color for friendly earthbind totem nameplates"] = "Установка цвета выделения таблички дружественного eтотема оков земли",

	--[[ ruRU ]] ["Use Nameplate Alpha In Combat"] = "Use Nameplate Alpha In Combat",
	--[[ ruRU ]] ["Controls nameplate visibility in combat by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load, and the nameplate remains mouse-sensitive until combat ends)"] = "Controls nameplate visibility in combat by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load, and the nameplate remains mouse-sensitive until combat ends)",

	--[[ ruRU ]] ["All"] = "Все",
	--[[ ruRU ]] ["Group Only"] = "Только группа",
	--[[ ruRU ]] ["Guild Only"] = "Только гильдия",
	--[[ ruRU ]] ["None"] = "Нет",
} end)

-----------------------------------------------------------------------------

-- TODO: need ruRU translation
--[[
oT:RegisterTranslations("ruRU", function() return {
}
]]

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Critter"]	= "小动目",
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Visibility"] = "能见度",
	--[[ zhCN ]] ["Extra visibility options"] = "额外能见度相关设置",

	--[[ zhCN ]] ["Show Hostile Players"] = "显示敌对方玩家",
	--[[ zhCN ]] ["Shows nameplates for hostile players"] = "显示敌对方玩家的姓名板",
	--[[ zhCN ]] ["Show Hostile Pets"] = "显示敌对方宠物",
	--[[ zhCN ]] ["Shows nameplates for hostile pets"] = "显示敌对方宠物的姓名板",
	--[[ zhCN ]] ["Show Hostile NPCs"] = "显示敌对方NPC",
	--[[ zhCN ]] ["Show hostile NPCs"] = "显示敌对方NPC的姓名板",

	--[[ zhCN ]] ["Friendly Players"] = "显示友好方玩家",
	--[[ zhCN ]] ["Selects which friendly players to show"] = "选择显示哪些友好方玩家",
	--[[ zhCN ]] ["Show Pet"] = "显示宠物",
	--[[ zhCN ]] ["Shows nameplates for your pets"] = "显示你的宠物的姓名板",
	--[[ zhCN ]] ["Show Group Pets"] = "显示队友宠物",
	--[[ zhCN ]] ["Shows nameplates for group pets"] = "显示队友的宠物的姓名板",
	--[[ zhCN ]] ["Show Friendly Pets"] = "显示友好方宠物",
	--[[ zhCN ]] ["Shows nameplates for friendly pets"] = "显示友好方宠物的姓名板",
	--[[ zhCN ]] ["Show Friendly NPCs"] = "显示友好方NPC",
	--[[ zhCN ]] ["Show friendly NPCs"] = "显示友好方NPC的姓名板",

	--[[ zhCN ]] ["Critters"] = "Critters",
	--[[ zhCN ]] ["Visibility options for critters"] = "Visibility options for critters",
	--[[ zhCN ]] ["Critter Level"] = "Critter Level",
	--[[ zhCN ]] ["Assume neutral units below this level are 'critters'"] = "Assume neutral units below this level are 'critters'",
	--[[ zhCN ]] ["Critter Health"] = "Critter Health",
	--[[ zhCN ]] ["Assume neutral units below this health are 'critters'"] = "Assume neutral units below this health are 'critters'",
	--[[ zhCN ]] ["Show Critters"] = "显示小动物",
	--[[ zhCN ]] ["Shows nameplates for critters"] = "显示小动物的姓名板",

	--[[ zhCN ]] ["Show Neutral Units"] = "显示中立方单位",
	--[[ zhCN ]] ["Show neutral units"] = "显示中立方单位的姓名板",

	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Exceptions"] = "Exceptions",
	--[[ zhCN ]] ["Enable Tremor Totem"] = "Enable Tremor Totem",
	--[[ zhCN ]] ["Dedicated Tremor Totem Color"] = "Dedicated Tremor Totem Color",
	--[[ zhCN ]] ["Enable Grounding Totem"] = "Enable Grounding Totem",
	--[[ zhCN ]] ["Dedicated Grounding Totem Color"] = "Dedicated Grounding Totem Color",
	--[[ zhCN ]] ["Enable Earthbind Totem"] = "Enable Earthbind Totem",
	--[[ zhCN ]] ["Dedicated Earthbind Totem Color"] = "Dedicated Earthbind Totem Color",
	--[[ zhCN ]] ["Enable Cleansing Totem"] = "Enable Cleansing Totem",
	--[[ zhCN ]] ["Dedicated Cleansing Totem Color"] = "Dedicated Cleansing Totem Color",
	--[[ zhCN ]] ["Enable Mana Tide Totem"] = "Enable Mana Tide Totem",
	--[[ zhCN ]] ["Dedicated Mana Tide Totem Color"] = "Dedicated Mana Tide Totem Color",

	--[[ zhCN ]] ["Show Hostile Totems/Trap Snakes/Bloodworms"] = "Show Hostile Totems/Trap Snakes/Bloodworms",
	--[[ zhCN ]] ["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)",
	--[[ zhCN ]] ["Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)",
	--[[ zhCN ]] ["Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile tremor totems (with a dedicated color)",
	--[[ zhCN ]] ["Sets the dedicated color for hostile tremor totem nameplates"] = "Sets the dedicated color for hostile tremor totem nameplates",
	--[[ zhCN ]] ["Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile grounding totems (with a dedicated color)",
	--[[ zhCN ]] ["Sets the dedicated color for hostile grounding totem nameplates"] = "Sets the dedicated color for hostile grounding totem nameplates",
	--[[ zhCN ]] ["Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)",
	--[[ zhCN ]] ["Sets the dedicated color for hostile earthbind totem nameplates"] = "Sets the dedicated color for hostile earthbind totem nameplates",
	--[[ zhCN ]] ["Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)",
	--[[ zhCN ]] ["Sets the dedicated color for hostile cleansing totem nameplates"] = "Sets the dedicated color for hostile cleansing totem nameplates",
	--[[ zhCN ]] ["Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)",
	--[[ zhCN ]] ["Sets the dedicated color for hostile mana tide totem nameplates"] = "Sets the dedicated color for hostile mana tide totem nameplates",

	--[[ zhCN ]] ["Show Friendly Totems/Trap Snakes/Bloodworms"] = "Show Friendly Totems/Trap Snakes/Bloodworms",
	--[[ zhCN ]] ["Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)",
	--[[ zhCN ]] ["Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)",
	--[[ zhCN ]] ["Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly tremor totems (with a dedicated color)",
	--[[ zhCN ]] ["Sets the dedicated color for friendly tremor totem nameplates"] = "Sets the dedicated color for friendly tremor totem nameplates",
	--[[ zhCN ]] ["Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly grounding totems (with a dedicated color)",
	--[[ zhCN ]] ["Sets the dedicated color for friendly grounding totem nameplates"] = "Sets the dedicated color for friendly grounding totem nameplates",
	--[[ zhCN ]] ["Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)",
	--[[ zhCN ]] ["Sets the dedicated color for friendly earthbind totem nameplates"] = "Sets the dedicated color for friendly earthbind totem nameplates",

	--[[ zhCN ]] ["Use Nameplate Alpha In Combat"] = "Use Nameplate Alpha In Combat",
	--[[ zhCN ]] ["Controls nameplate visibility in combat by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load, and the nameplate remains mouse-sensitive until combat ends)"] = "Controls nameplate visibility in combat by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load, and the nameplate remains mouse-sensitive until combat ends)",

	--[[ zhCN ]] ["All"] = "全部",
	--[[ zhCN ]] ["Group Only"] = "仅显示队友",
	--[[ zhCN ]] ["Guild Only"] = "仅显示公会成员",
	--[[ zhCN ]] ["None"] = "无",
} end)

-----------------------------------------------------------------------------

-- TODO: need zhCN translation
--[[
oT:RegisterTranslations("zhCN", function() return {
}
]]

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Critter"]	= "小動物",
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Visibility"] = "能見度",
	--[[ zhTW ]] ["Extra visibility options"] = "額外能見度選項",

	--[[ zhTW ]] ["Show Hostile Players"] = "顯示敵對玩家",
	--[[ zhTW ]] ["Shows nameplates for hostile players"] = "顯示敵對玩家的名牌",
	--[[ zhTW ]] ["Show Hostile Pets"] = "顯示敵對寵物",
	--[[ zhTW ]] ["Shows nameplates for hostile pets"] = "顯示敵對寵物的名牌",
	--[[ zhTW ]] ["Show Hostile NPCs"] = "顯示敵對NPC",
	--[[ zhTW ]] ["Show hostile NPCs"] = "顯示敵對NPC的名牌",

	--[[ zhTW ]] ["Friendly Players"] = "顯示友好玩家",
	--[[ zhTW ]] ["Selects which friendly players to show"] = "選擇顯示哪一些友好玩家",
	--[[ zhTW ]] ["Show Pet"] = "顯示寵物",
	--[[ zhTW ]] ["Shows nameplates for your pets"] = "顯示你的寵物的名牌",
	--[[ zhTW ]] ["Show Group Pets"] = "顯示團體寵物",
	--[[ zhTW ]] ["Shows nameplates for group pets"] = "顯示團體寵物的名牌",
	--[[ zhTW ]] ["Show Friendly Pets"] = "顯示友好寵物",
	--[[ zhTW ]] ["Shows nameplates for friendly pets"] = "顯示友好寵物的名牌",
	--[[ zhTW ]] ["Show Friendly NPCs"] = "顯示友好NPC",
	--[[ zhTW ]] ["Show friendly NPCs"] = "顯示友好NPC的名牌",

	--[[ zhTW ]] ["Critters"] = "Critters",
	--[[ zhTW ]] ["Visibility options for critters"] = "Visibility options for critters",
	--[[ zhTW ]] ["Critter Level"] = "Critter Level",
	--[[ zhTW ]] ["Assume neutral units below this level are 'critters'"] = "Assume neutral units below this level are 'critters'",
	--[[ zhTW ]] ["Critter Health"] = "Critter Health",
	--[[ zhTW ]] ["Assume neutral units below this health are 'critters'"] = "Assume neutral units below this health are 'critters'",
	--[[ zhTW ]] ["Show Critters"] = "顯示小動物",
	--[[ zhTW ]] ["Shows nameplates for critters"] = "顯示小動物的名牌",

	--[[ zhTW ]] ["Show Neutral Units"] = "顯示中立單位",
	--[[ zhTW ]] ["Show neutral units"] = "顯示中立單位的名牌",

	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Exceptions"] = "Exceptions",
	--[[ zhTW ]] ["Enable Tremor Totem"] = "Enable Tremor Totem",
	--[[ zhTW ]] ["Dedicated Tremor Totem Color"] = "Dedicated Tremor Totem Color",
	--[[ zhTW ]] ["Enable Grounding Totem"] = "Enable Grounding Totem",
	--[[ zhTW ]] ["Dedicated Grounding Totem Color"] = "Dedicated Grounding Totem Color",
	--[[ zhTW ]] ["Enable Earthbind Totem"] = "Enable Earthbind Totem",
	--[[ zhTW ]] ["Dedicated Earthbind Totem Color"] = "Dedicated Earthbind Totem Color",
	--[[ zhTW ]] ["Enable Cleansing Totem"] = "Enable Cleansing Totem",
	--[[ zhTW ]] ["Dedicated Cleansing Totem Color"] = "Dedicated Cleansing Totem Color",
	--[[ zhTW ]] ["Enable Mana Tide Totem"] = "Enable Mana Tide Totem",
	--[[ zhTW ]] ["Dedicated Mana Tide Totem Color"] = "Dedicated Mana Tide Totem Color",

	--[[ zhTW ]] ["Show Hostile Totems/Trap Snakes/Bloodworms"] = "Show Hostile Totems/Trap Snakes/Bloodworms",
	--[[ zhTW ]] ["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)",
	--[[ zhTW ]] ["Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)",
	--[[ zhTW ]] ["Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile tremor totems (with a dedicated color)",
	--[[ zhTW ]] ["Sets the dedicated color for hostile tremor totem nameplates"] = "Sets the dedicated color for hostile tremor totem nameplates",
	--[[ zhTW ]] ["Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile grounding totems (with a dedicated color)",
	--[[ zhTW ]] ["Sets the dedicated color for hostile grounding totem nameplates"] = "Sets the dedicated color for hostile grounding totem nameplates",
	--[[ zhTW ]] ["Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)",
	--[[ zhTW ]] ["Sets the dedicated color for hostile earthbind totem nameplates"] = "Sets the dedicated color for hostile earthbind totem nameplates",
	--[[ zhTW ]] ["Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)",
	--[[ zhTW ]] ["Sets the dedicated color for hostile cleansing totem nameplates"] = "Sets the dedicated color for hostile cleansing totem nameplates",
	--[[ zhTW ]] ["Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)",
	--[[ zhTW ]] ["Sets the dedicated color for hostile mana tide totem nameplates"] = "Sets the dedicated color for hostile mana tide totem nameplates",

	--[[ zhTW ]] ["Show Friendly Totems/Trap Snakes/Bloodworms"] = "Show Friendly Totems/Trap Snakes/Bloodworms",
	--[[ zhTW ]] ["Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)",
	--[[ zhTW ]] ["Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)",
	--[[ zhTW ]] ["Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly tremor totems (with a dedicated color)",
	--[[ zhTW ]] ["Sets the dedicated color for friendly tremor totem nameplates"] = "Sets the dedicated color for friendly tremor totem nameplates",
	--[[ zhTW ]] ["Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly grounding totems (with a dedicated color)",
	--[[ zhTW ]] ["Sets the dedicated color for friendly grounding totem nameplates"] = "Sets the dedicated color for friendly grounding totem nameplates",
	--[[ zhTW ]] ["Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)",
	--[[ zhTW ]] ["Sets the dedicated color for friendly earthbind totem nameplates"] = "Sets the dedicated color for friendly earthbind totem nameplates",

	--[[ zhTW ]] ["Use Nameplate Alpha In Combat"] = "Use Nameplate Alpha In Combat",
	--[[ zhTW ]] ["Controls nameplate visibility in combat by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load, and the nameplate remains mouse-sensitive until combat ends)"] = "Controls nameplate visibility in combat by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load, and the nameplate remains mouse-sensitive until combat ends)",

	--[[ zhTW ]] ["All"] = "全部",
	--[[ zhTW ]] ["Group Only"] = "唯有團體",
	--[[ zhTW ]] ["Guild Only"] = "唯有公會",
	--[[ zhTW ]] ["None"] = "無",
} end)

-----------------------------------------------------------------------------

-- TODO: need zhTW translation
--[[
oT:RegisterTranslations("zhTW", function() return {
}
]]

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
