local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

local oL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] oL["Visibility"] = "Visibility"
--[[ enUS ]] oL["Extra visibility options"] = "Extra visibility options"

--[[ enUS ]] oL["Always Show Current Target"] = "Always Show Current Target"
--[[ enUS ]] oL["Always shows the current target nameplate (overrides other visibility options, requires use of alpha)"] = "Always shows the current target nameplate (overrides other visibility options, requires use of alpha)"

--[[ enUS ]] oL["Show Hostile Players"] = "Show Hostile Players"
--[[ enUS ]] oL["Shows nameplates for hostile players"] = "Shows nameplates for hostile players"
--[[ enUS ]] oL["Show Hostile Pets"] = "Show Hostile Pets"
--[[ enUS ]] oL["Shows nameplates for hostile pets"] = "Shows nameplates for hostile pets"
--[[ enUS ]] oL["Show Hostile NPCs"] = "Show Hostile NPCs"
--[[ enUS ]] oL["Show hostile NPCs"] = "Show hostile NPCs"

--[[ enUS ]] oL["Friendly Players"] = "Friendly Players"
--[[ enUS ]] oL["Selects which friendly players to show"] = "Selects which friendly players to show"
--[[ enUS ]] oL["Show Pet"] = "Show Pet"
--[[ enUS ]] oL["Shows nameplates for your pets"] = "Shows nameplates for your pets"
--[[ enUS ]] oL["Show Group Pets"] = "Show Group Pets"
--[[ enUS ]] oL["Shows nameplates for group pets"] = "Shows nameplates for group pets"
--[[ enUS ]] oL["Show Friendly Pets"] = "Show Friendly Pets"
--[[ enUS ]] oL["Shows nameplates for friendly pets"] = "Shows nameplates for friendly pets"
--[[ enUS ]] oL["Show Friendly NPCs"] = "Show Friendly NPCs"
--[[ enUS ]] oL["Show friendly NPCs"] = "Show friendly NPCs"

--[[ enUS ]] oL["Critters"] = "Critters"
--[[ enUS ]] oL["Visibility options for critters"] = "Visibility options for critters"
--[[ enUS ]] oL["Critter Level"] = "Critter Level"
--[[ enUS ]] oL["Assume neutral units below this level are 'critters'"] = "Assume neutral units below this level are 'critters'"
--[[ enUS ]] oL["Critter Health"] = "Critter Health"
--[[ enUS ]] oL["Assume neutral units below this health are 'critters'"] = "Assume neutral units below this health are 'critters'"
--[[ enUS ]] oL["Show Critters"] = "Show Critters"
--[[ enUS ]] oL["Shows nameplates for critters"] = "Shows nameplates for critters"

--[[ enUS ]] oL["Show Neutral Units"] = "Show Neutral Units"
--[[ enUS ]] oL["Show neutral units"] = "Show neutral units"

--[[ enUS ]] oL["Enable"] = "Enable"
--[[ enUS ]] oL["Exceptions"] = "Exceptions"
--[[ enUS ]] oL["Enable Tremor Totem"] = "Enable Tremor Totem"
--[[ enUS ]] oL["Dedicated Tremor Totem Color"] = "Dedicated Tremor Totem Color"
--[[ enUS ]] oL["Enable Grounding Totem"] = "Enable Grounding Totem"
--[[ enUS ]] oL["Dedicated Grounding Totem Color"] = "Dedicated Grounding Totem Color"
--[[ enUS ]] oL["Enable Earthbind Totem"] = "Enable Earthbind Totem"
--[[ enUS ]] oL["Dedicated Earthbind Totem Color"] = "Dedicated Earthbind Totem Color"
--[[ enUS ]] oL["Enable Cleansing Totem"] = "Enable Cleansing Totem"
--[[ enUS ]] oL["Dedicated Cleansing Totem Color"] = "Dedicated Cleansing Totem Color"
--[[ enUS ]] oL["Enable Mana Tide Totem"] = "Enable Mana Tide Totem"
--[[ enUS ]] oL["Dedicated Mana Tide Totem Color"] = "Dedicated Mana Tide Totem Color"

--[[ enUS ]] oL["Show Hostile Totems/Trap Snakes/Bloodworms"] = "Show Hostile Totems/Trap Snakes/Bloodworms"
--[[ enUS ]] oL["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"
--[[ enUS ]] oL["Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"
--[[ enUS ]] oL["Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"
--[[ enUS ]] oL["Sets the dedicated color for hostile tremor totem nameplates"] = "Sets the dedicated color for hostile tremor totem nameplates"
--[[ enUS ]] oL["Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"
--[[ enUS ]] oL["Sets the dedicated color for hostile grounding totem nameplates"] = "Sets the dedicated color for hostile grounding totem nameplates"
--[[ enUS ]] oL["Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"
--[[ enUS ]] oL["Sets the dedicated color for hostile earthbind totem nameplates"] = "Sets the dedicated color for hostile earthbind totem nameplates"
--[[ enUS ]] oL["Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"
--[[ enUS ]] oL["Sets the dedicated color for hostile cleansing totem nameplates"] = "Sets the dedicated color for hostile cleansing totem nameplates"
--[[ enUS ]] oL["Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"
--[[ enUS ]] oL["Sets the dedicated color for hostile mana tide totem nameplates"] = "Sets the dedicated color for hostile mana tide totem nameplates"

--[[ enUS ]] oL["Show Friendly Totems/Trap Snakes/Bloodworms"] = "Show Friendly Totems/Trap Snakes/Bloodworms"
--[[ enUS ]] oL["Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"
--[[ enUS ]] oL["Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"
--[[ enUS ]] oL["Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"
--[[ enUS ]] oL["Sets the dedicated color for friendly tremor totem nameplates"] = "Sets the dedicated color for friendly tremor totem nameplates"
--[[ enUS ]] oL["Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"
--[[ enUS ]] oL["Sets the dedicated color for friendly grounding totem nameplates"] = "Sets the dedicated color for friendly grounding totem nameplates"
--[[ enUS ]] oL["Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"
--[[ enUS ]] oL["Sets the dedicated color for friendly earthbind totem nameplates"] = "Sets the dedicated color for friendly earthbind totem nameplates"

--[[ enUS ]] oL["Use Nameplate Alpha"] = "Use Nameplate Alpha"
--[[ enUS ]] oL["Controls nameplate visibility in combat or when target nameplate is always shown by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load)"] = "Controls nameplate visibility in combat or when target nameplate is always shown by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load)"

--[[ enUS ]] oL["Hide Unit Names"] = "Hide Unit Names"
--[[ enUS ]] oL["Hide nameplates by unit name"] = "Hide nameplates by unit name"
--[[ enUS ]] oL["Hide Unit Name"] = "Hide Unit Name"
--[[ enUS ]] oL["Hide Current Target"] = "Hide Current Target"
--[[ enUS ]] oL["Add current target to list of unit names to hide"] = "Add current target to list of unit names to hide"
--[[ enUS ]] oL["Add given name to list of unit names to hide"] = "Add given name to list of unit names to hide"
--[[ enUS ]] oL["Enter any unit name, then enter <return>"] = "Enter any unit name, then enter <return>"
--[[ enUS ]] oL["Delete Unit Name"] = "Delete Unit Name"
--[[ enUS ]] oL["Select from list of unit names to delete"] = "Select from list of unit names to delete"
--[[ enUS ]] oL["Select a unit name to delete it from the list"] = "Select a unit name to delete it from the list"

--[[ enUS ]] oL["Color"] = "Color"

--[[ enUS ]] oL["All"] = "All"
--[[ enUS ]] oL["Group Only"] = "Group Only"
--[[ enUS ]] oL["Guild Only"] = "Guild Only"
--[[ enUS ]] oL["None"] = "None"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftVisibility"] = "AloftVisibility"
--[[ enUS ]] mL["Control the visibility of various types of nameplates"] = "Control the visibility of various types of nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "deDE") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "frFR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

--[[ frFR ]] oL["Visibility"] = "Visibiliteeeeeeeeeee"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

--[[ koKR ]] oL["Visibility"] = "표시"
--[[ koKR ]] oL["Extra visibility options"] = "추가 표시 설정"

--[[ koKR ]] oL["Always Show Current Target"] = "Always Show Current Target"
--[[ koKR ]] oL["Always shows the current target nameplate (overrides other visibility options, requires use of alpha)"] = "Always shows the current target nameplate (overrides other visibility options, requires use of alpha)"

--[[ koKR ]] oL["Show Hostile Players"] = "적대적 플레이어 표시"
--[[ koKR ]] oL["Shows nameplates for hostile players"] = "적대적 플레이어의 이름표를 표시합니다."
--[[ koKR ]] oL["Show Hostile Pets"] = "적대적 소환수 표시"
--[[ koKR ]] oL["Shows nameplates for hostile pets"] = "적대적 소환수의 이름표를 표시합니다."
--[[ koKR ]] oL["Show Hostile NPCs"] = "적대적 NPC 표시"
--[[ koKR ]] oL["Show hostile NPCs"] = "적대적 NPC를 표시합니다."

--[[ koKR ]] oL["Friendly Players"] = "우호적 플레이어"
--[[ koKR ]] oL["Selects which friendly players to show"] = "우호적 플레이어의 표시를 선택합니다."
--[[ koKR ]] oL["Show Pet"] = "소환수 표시"
--[[ koKR ]] oL["Shows nameplates for your pets"] = "소환수의 이름표를 표시합니다."
--[[ koKR ]] oL["Show Group Pets"] = "파티 소환수 표시"
--[[ koKR ]] oL["Shows nameplates for group pets"] = "파티 소환수의 이름표를 표시합니다."
--[[ koKR ]] oL["Show Friendly Pets"] = "우호적 소환수 표시"
--[[ koKR ]] oL["Shows nameplates for friendly pets"] = "우호적 소환수의 이름표를 표시합니다."
--[[ koKR ]] oL["Show Friendly NPCs"] = "우호적 NPC 표시"
--[[ koKR ]] oL["Show friendly NPCs"] = "우호적 NPC를 표시합니다."

--[[ koKR ]] oL["Critters"] = "Critters"
--[[ koKR ]] oL["Visibility options for critters"] = "Visibility options for critters"
--[[ koKR ]] oL["Critter Level"] = "Critter Level"
--[[ koKR ]] oL["Assume neutral units below this level are 'critters'"] = "Assume neutral units below this level are 'critters'"
--[[ koKR ]] oL["Critter Health"] = "Critter Health"
--[[ koKR ]] oL["Assume neutral units below this health are 'critters'"] = "Assume neutral units below this health are 'critters'"
--[[ koKR ]] oL["Show Critters"] = "동물 표시"
--[[ koKR ]] oL["Shows nameplates for critters"] = "동물에 대한 이름표를 표시합니다."

--[[ koKR ]] oL["Show Neutral Units"] = "중립적 대상 표시"
--[[ koKR ]] oL["Show neutral units"] = "중립적 대상을 표시합니다."

--[[ koKR ]] oL["Enable"] = "사용"
--[[ koKR ]] oL["Exceptions"] = "Exceptions"
--[[ koKR ]] oL["Enable Tremor Totem"] = "Enable Tremor Totem"
--[[ koKR ]] oL["Dedicated Tremor Totem Color"] = "Dedicated Tremor Totem Color"
--[[ koKR ]] oL["Enable Grounding Totem"] = "Enable Grounding Totem"
--[[ koKR ]] oL["Dedicated Grounding Totem Color"] = "Dedicated Grounding Totem Color"
--[[ koKR ]] oL["Enable Earthbind Totem"] = "Enable Earthbind Totem"
--[[ koKR ]] oL["Dedicated Earthbind Totem Color"] = "Dedicated Earthbind Totem Color"
--[[ koKR ]] oL["Enable Cleansing Totem"] = "Enable Cleansing Totem"
--[[ koKR ]] oL["Dedicated Cleansing Totem Color"] = "Dedicated Cleansing Totem Color"
--[[ koKR ]] oL["Enable Mana Tide Totem"] = "Enable Mana Tide Totem"
--[[ koKR ]] oL["Dedicated Mana Tide Totem Color"] = "Dedicated Mana Tide Totem Color"

--[[ koKR ]] oL["Show Hostile Totems/Trap Snakes/Bloodworms"] = "Show Hostile Totems/Trap Snakes/Bloodworms"
--[[ koKR ]] oL["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"
--[[ koKR ]] oL["Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"
--[[ koKR ]] oL["Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"
--[[ koKR ]] oL["Sets the dedicated color for hostile tremor totem nameplates"] = "Sets the dedicated color for hostile tremor totem nameplates"
--[[ koKR ]] oL["Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"
--[[ koKR ]] oL["Sets the dedicated color for hostile grounding totem nameplates"] = "Sets the dedicated color for hostile grounding totem nameplates"
--[[ koKR ]] oL["Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"
--[[ koKR ]] oL["Sets the dedicated color for hostile earthbind totem nameplates"] = "Sets the dedicated color for hostile earthbind totem nameplates"
--[[ koKR ]] oL["Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"
--[[ koKR ]] oL["Sets the dedicated color for hostile cleansing totem nameplates"] = "Sets the dedicated color for hostile cleansing totem nameplates"
--[[ koKR ]] oL["Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"
--[[ koKR ]] oL["Sets the dedicated color for hostile mana tide totem nameplates"] = "Sets the dedicated color for hostile mana tide totem nameplates"

--[[ koKR ]] oL["Show Friendly Totems/Trap Snakes/Bloodworms"] = "Show Friendly Totems/Trap Snakes/Bloodworms"
--[[ koKR ]] oL["Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"
--[[ koKR ]] oL["Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"
--[[ koKR ]] oL["Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"
--[[ koKR ]] oL["Sets the dedicated color for friendly tremor totem nameplates"] = "Sets the dedicated color for friendly tremor totem nameplates"
--[[ koKR ]] oL["Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"
--[[ koKR ]] oL["Sets the dedicated color for friendly grounding totem nameplates"] = "Sets the dedicated color for friendly grounding totem nameplates"
--[[ koKR ]] oL["Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"
--[[ koKR ]] oL["Sets the dedicated color for friendly earthbind totem nameplates"] = "Sets the dedicated color for friendly earthbind totem nameplates"

--[[ koKR ]] oL["Use Nameplate Alpha In Combat"] = "Use Nameplate Alpha In Combat"
--[[ koKR ]] oL["Controls nameplate visibility in combat or when target nameplate is always shown by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load)"] = "Controls nameplate visibility in combat or when target nameplate is always shown by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load)"

--[[ koKR ]] oL["Hide Unit Names"] = "Hide Unit Names"
--[[ koKR ]] oL["Hide nameplates by unit name"] = "Hide nameplates by unit name"
--[[ koKR ]] oL["Hide Unit Name"] = "Hide Unit Name"
--[[ koKR ]] oL["Hide Current Target"] = "Hide Current Target"
--[[ koKR ]] oL["Add current target to list of unit names to hide"] = "Add current target to list of unit names to hide"
--[[ koKR ]] oL["Add given name to list of unit names to hide"] = "Add given name to list of unit names to hide"
--[[ koKR ]] oL["Enter any unit name, then enter <return>"] = "Enter any unit name, then enter <return>"
--[[ koKR ]] oL["Delete Unit Name"] = "Delete Unit Name"
--[[ koKR ]] oL["Select from list of unit names to delete"] = "Select from list of unit names to delete"
--[[ koKR ]] oL["Select a unit name to delete it from the list"] = "Select a unit name to delete it from the list"

--[[ koKR ]] oL["Color"] = "색상"

--[[ koKR ]] oL["All"] = "모두"
--[[ koKR ]] oL["Group Only"] = "파티"
--[[ koKR ]] oL["Guild Only"] = "길드"
--[[ koKR ]] oL["None"] = "없음"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftVisibility"] = "AloftVisibility"
--[[ koKR ]] mL["Control the visibility of various types of nameplates"] = "Control the visibility of various types of nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] oL["Visibility"] = "Видимость"
--[[ ruRU ]] oL["Extra visibility options"] = "Настройки дополнительной видимости"

--[[ ruRU ]] oL["Always Show Current Target"] = "Always Show Current Target"
--[[ ruRU ]] oL["Always shows the current target nameplate (overrides other visibility options, requires use of alpha)"] = "Always shows the current target nameplate (overrides other visibility options, requires use of alpha)"

--[[ ruRU ]] oL["Show Hostile Players"] = "Отображать враждебных игроков"
--[[ ruRU ]] oL["Shows nameplates for hostile players"] = "Отображает таблички для враждебных игроков"
--[[ ruRU ]] oL["Show Hostile Pets"] = "Отображать враждебных питомцев"
--[[ ruRU ]] oL["Shows nameplates for hostile pets"] = "Отображает таблички для враждебных питомцев"
--[[ ruRU ]] oL["Show Hostile NPCs"] = "Отображать враждебных NPC"
--[[ ruRU ]] oL["Show hostile NPCs"] = "Отображать враждебных NPC"

--[[ ruRU ]] oL["Friendly Players"] = "Дружественные игроки"
--[[ ruRU ]] oL["Selects which friendly players to show"] = "Выбирает, как отображать дружественных игроков"
--[[ ruRU ]] oL["Show Pet"] = "Отображать питомца"
--[[ ruRU ]] oL["Shows nameplates for your pets"] = "Отображает таблички для питомцев"
--[[ ruRU ]] oL["Show Group Pets"] = "Отображать питомцев группы"
--[[ ruRU ]] oL["Shows nameplates for group pets"] = "Отображает таблички для питомцев группы"
--[[ ruRU ]] oL["Show Friendly Pets"] = "Отображать дружественных питомцев"
--[[ ruRU ]] oL["Shows nameplates for friendly pets"] = "Отображает таблички для дружественных питомцев"
--[[ ruRU ]] oL["Show Friendly NPCs"] = "Отображать дружественных NPC"
--[[ ruRU ]] oL["Show friendly NPCs"] = "Отображать дружественных NPC"

--[[ ruRU ]] oL["Critters"] = "Существо"
--[[ ruRU ]] oL["Visibility options for critters"] = "Настройки вида для существ"
--[[ ruRU ]] oL["Critter Level"] = "Уровень существа"
--[[ ruRU ]] oL["Assume neutral units below this level are 'critters'"] = "Нейтральный объект ниже этого уровня предпологаемо будет - 'существо'"
--[[ ruRU ]] oL["Critter Health"] = "Здоровье спутника"
--[[ ruRU ]] oL["Assume neutral units below this health are 'critters'"] = "Нейтральный объект ниже этого уровня здаровья предпологаемо будет 'существо'"
--[[ ruRU ]] oL["Show Critters"] = "Отображать существа"
--[[ ruRU ]] oL["Shows nameplates for critters"] = "Отображает таблички для существ"

--[[ ruRU ]] oL["Show Neutral Units"] = "Отображать нейтральных"
--[[ ruRU ]] oL["Show neutral units"] = "Отображать нейтральных"

--[[ ruRU ]] oL["Enable"] = "Включить"
--[[ ruRU ]] oL["Exceptions"] = "Исключения"
--[[ ruRU ]] oL["Enable Tremor Totem"] = "Включить Тотем трепета"
--[[ ruRU ]] oL["Dedicated Tremor Totem Color"] = "Цвет выделения Тотема трепета"
--[[ ruRU ]] oL["Enable Grounding Totem"] = "Включить Тотем заземления"
--[[ ruRU ]] oL["Dedicated Grounding Totem Color"] = "Цвет выделения Тотема заземления"
--[[ ruRU ]] oL["Enable Earthbind Totem"] = "Включить Тотем оков земли"
--[[ ruRU ]] oL["Dedicated Earthbind Totem Color"] = "Цвет выделения Тотема оков земли"
--[[ ruRU ]] oL["Enable Cleansing Totem"] = "Enable Cleansing Totem"
--[[ ruRU ]] oL["Dedicated Cleansing Totem Color"] = "Dedicated Cleansing Totem Color"
--[[ ruRU ]] oL["Enable Mana Tide Totem"] = "Enable Mana Tide Totem"
--[[ ruRU ]] oL["Dedicated Mana Tide Totem Color"] = "Dedicated Mana Tide Totem Color"

--[[ ruRU ]] oL["Show Hostile Totems/Trap Snakes/Bloodworms"] = "Показывать враждебные тотемы/ловушки/змеи/кровочерви"
--[[ ruRU ]] oL["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Показывать таблички враждебных тотемов/ловушкек/змеи/кровочервей (влияет на таблички только вне боя)"
--[[ ruRU ]] oL["Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Даже если таблички для враждебных тотемов/ловушкек/змеи/кровочервей скрыты, отображать (с цветовым выделением)"
--[[ ruRU ]] oL["Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"] = "Однозначно показывает таблички враждебного тотема трепета (с цветовым выделением)"
--[[ ruRU ]] oL["Sets the dedicated color for hostile tremor totem nameplates"] = "Установка цвета выделения таблички вреждебного тотема трепета"
--[[ ruRU ]] oL["Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"] = "Однозначно показывает таблички враждебного тотема заземления (с цветовым выделением)"
--[[ ruRU ]] oL["Sets the dedicated color for hostile grounding totem nameplates"] = "становка цвета выделения таблички вреждебного тотема заземления"
--[[ ruRU ]] oL["Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"] = "Однозначно показывает таблички враждебного тотема оков земли (с цветовым выделением)"
--[[ ruRU ]] oL["Sets the dedicated color for hostile earthbind totem nameplates"] = "становка цвета выделения таблички вреждебного тотема оков земли"
--[[ ruRU ]] oL["Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"
--[[ ruRU ]] oL["Sets the dedicated color for hostile cleansing totem nameplates"] = "Sets the dedicated color for hostile cleansing totem nameplates"
--[[ ruRU ]] oL["Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"
--[[ ruRU ]] oL["Sets the dedicated color for hostile mana tide totem nameplates"] = "Sets the dedicated color for hostile mana tide totem nameplates"

--[[ ruRU ]] oL["Show Friendly Totems/Trap Snakes/Bloodworms"] = "Показывать дружественные тотемы/ловушки/змеи/кровочерви"
--[[ ruRU ]] oL["Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Показывать таблички дружественных тотемов/ловушкек/змеи/кровочервей (влияет на таблички только вне боя)"
--[[ ruRU ]] oL["Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Даже если таблички для враждебных тотемов/ловушкек/змеи/кровочервей скрыты, отображать (с цветовым выделением)"
--[[ ruRU ]] oL["Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"] = "Однозначно показывает таблички дружественного тотема трепета (с цветовым выделением)"
--[[ ruRU ]] oL["Sets the dedicated color for friendly tremor totem nameplates"] = "Установка цвета выделения таблички дружественного тотема трепета"
--[[ ruRU ]] oL["Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"] = "Однозначно показывает таблички дружественного тотема заземления (с цветовым выделением)"
--[[ ruRU ]] oL["Sets the dedicated color for friendly grounding totem nameplates"] = "Установка цвета выделения таблички дружественного тотема заземления"
--[[ ruRU ]] oL["Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"] = "Однозначно показывает таблички дружественного тотема оков земли (с цветовым выделением)"
--[[ ruRU ]] oL["Sets the dedicated color for friendly earthbind totem nameplates"] = "Установка цвета выделения таблички дружественного eтотема оков земли"

--[[ ruRU ]] oL["Use Nameplate Alpha In Combat"] = "Use Nameplate Alpha In Combat"
--[[ ruRU ]] oL["Controls nameplate visibility in combat or when target nameplate is always shown by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load)"] = "Controls nameplate visibility in combat or when target nameplate is always shown by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load)"

--[[ ruRU ]] oL["Hide Unit Names"] = "Hide Unit Names"
--[[ ruRU ]] oL["Hide nameplates by unit name"] = "Hide nameplates by unit name"
--[[ ruRU ]] oL["Hide Unit Name"] = "Hide Unit Name"
--[[ ruRU ]] oL["Hide Current Target"] = "Hide Current Target"
--[[ ruRU ]] oL["Add current target to list of unit names to hide"] = "Add current target to list of unit names to hide"
--[[ ruRU ]] oL["Add given name to list of unit names to hide"] = "Add given name to list of unit names to hide"
--[[ ruRU ]] oL["Enter any unit name, then enter <return>"] = "Enter any unit name, then enter <return>"
--[[ ruRU ]] oL["Delete Unit Name"] = "Delete Unit Name"
--[[ ruRU ]] oL["Select from list of unit names to delete"] = "Select from list of unit names to delete"
--[[ ruRU ]] oL["Select a unit name to delete it from the list"] = "Select a unit name to delete it from the list"

--[[ ruRU ]] oL["Color"] = "Цвет"

--[[ ruRU ]] oL["All"] = "Все"
--[[ ruRU ]] oL["Group Only"] = "Только группа"
--[[ ruRU ]] oL["Guild Only"] = "Только гильдия"
--[[ ruRU ]] oL["None"] = "Нет"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftVisibility"] = "AloftVisibility"
--[[ ruRU ]] mL["Control the visibility of various types of nameplates"] = "Различные настройки отображения"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] oL["Visibility"] = "能见度"
--[[ zhCN ]] oL["Extra visibility options"] = "额外能见度相关设置"

--[[ zhCN ]] oL["Always Show Current Target"] = "Always Show Current Target"
--[[ zhCN ]] oL["Always shows the current target nameplate (overrides other visibility options, requires use of alpha)"] = "Always shows the current target nameplate (overrides other visibility options, requires use of alpha)"

--[[ zhCN ]] oL["Show Hostile Players"] = "显示敌对方玩家"
--[[ zhCN ]] oL["Shows nameplates for hostile players"] = "显示敌对方玩家的姓名板"
--[[ zhCN ]] oL["Show Hostile Pets"] = "显示敌对方宠物"
--[[ zhCN ]] oL["Shows nameplates for hostile pets"] = "显示敌对方宠物的姓名板"
--[[ zhCN ]] oL["Show Hostile NPCs"] = "显示敌对方NPC"
--[[ zhCN ]] oL["Show hostile NPCs"] = "显示敌对方NPC的姓名板"

--[[ zhCN ]] oL["Friendly Players"] = "显示友好方玩家"
--[[ zhCN ]] oL["Selects which friendly players to show"] = "选择显示哪些友好方玩家"
--[[ zhCN ]] oL["Show Pet"] = "显示宠物"
--[[ zhCN ]] oL["Shows nameplates for your pets"] = "显示你的宠物的姓名板"
--[[ zhCN ]] oL["Show Group Pets"] = "显示队友宠物"
--[[ zhCN ]] oL["Shows nameplates for group pets"] = "显示队友的宠物的姓名板"
--[[ zhCN ]] oL["Show Friendly Pets"] = "显示友好方宠物"
--[[ zhCN ]] oL["Shows nameplates for friendly pets"] = "显示友好方宠物的姓名板"
--[[ zhCN ]] oL["Show Friendly NPCs"] = "显示友好方NPC"
--[[ zhCN ]] oL["Show friendly NPCs"] = "显示友好方NPC的姓名板"

--[[ zhCN ]] oL["Critters"] = "Critters"
--[[ zhCN ]] oL["Visibility options for critters"] = "Visibility options for critters"
--[[ zhCN ]] oL["Critter Level"] = "Critter Level"
--[[ zhCN ]] oL["Assume neutral units below this level are 'critters'"] = "Assume neutral units below this level are 'critters'"
--[[ zhCN ]] oL["Critter Health"] = "Critter Health"
--[[ zhCN ]] oL["Assume neutral units below this health are 'critters'"] = "Assume neutral units below this health are 'critters'"
--[[ zhCN ]] oL["Show Critters"] = "显示小动物"
--[[ zhCN ]] oL["Shows nameplates for critters"] = "显示小动物的姓名板"

--[[ zhCN ]] oL["Show Neutral Units"] = "显示中立方单位"
--[[ zhCN ]] oL["Show neutral units"] = "显示中立方单位的姓名板"

--[[ zhCN ]] oL["Enable"] = "启用"
--[[ zhCN ]] oL["Exceptions"] = "Exceptions"
--[[ zhCN ]] oL["Enable Tremor Totem"] = "Enable Tremor Totem"
--[[ zhCN ]] oL["Dedicated Tremor Totem Color"] = "Dedicated Tremor Totem Color"
--[[ zhCN ]] oL["Enable Grounding Totem"] = "Enable Grounding Totem"
--[[ zhCN ]] oL["Dedicated Grounding Totem Color"] = "Dedicated Grounding Totem Color"
--[[ zhCN ]] oL["Enable Earthbind Totem"] = "Enable Earthbind Totem"
--[[ zhCN ]] oL["Dedicated Earthbind Totem Color"] = "Dedicated Earthbind Totem Color"
--[[ zhCN ]] oL["Enable Cleansing Totem"] = "Enable Cleansing Totem"
--[[ zhCN ]] oL["Dedicated Cleansing Totem Color"] = "Dedicated Cleansing Totem Color"
--[[ zhCN ]] oL["Enable Mana Tide Totem"] = "Enable Mana Tide Totem"
--[[ zhCN ]] oL["Dedicated Mana Tide Totem Color"] = "Dedicated Mana Tide Totem Color"

--[[ zhCN ]] oL["Show Hostile Totems/Trap Snakes/Bloodworms"] = "Show Hostile Totems/Trap Snakes/Bloodworms"
--[[ zhCN ]] oL["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"
--[[ zhCN ]] oL["Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"
--[[ zhCN ]] oL["Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"
--[[ zhCN ]] oL["Sets the dedicated color for hostile tremor totem nameplates"] = "Sets the dedicated color for hostile tremor totem nameplates"
--[[ zhCN ]] oL["Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"
--[[ zhCN ]] oL["Sets the dedicated color for hostile grounding totem nameplates"] = "Sets the dedicated color for hostile grounding totem nameplates"
--[[ zhCN ]] oL["Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"
--[[ zhCN ]] oL["Sets the dedicated color for hostile earthbind totem nameplates"] = "Sets the dedicated color for hostile earthbind totem nameplates"
--[[ zhCN ]] oL["Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"
--[[ zhCN ]] oL["Sets the dedicated color for hostile cleansing totem nameplates"] = "Sets the dedicated color for hostile cleansing totem nameplates"
--[[ zhCN ]] oL["Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"] = "Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"
--[[ zhCN ]] oL["Sets the dedicated color for hostile mana tide totem nameplates"] = "Sets the dedicated color for hostile mana tide totem nameplates"

--[[ zhCN ]] oL["Show Friendly Totems/Trap Snakes/Bloodworms"] = "Show Friendly Totems/Trap Snakes/Bloodworms"
--[[ zhCN ]] oL["Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"
--[[ zhCN ]] oL["Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"
--[[ zhCN ]] oL["Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"
--[[ zhCN ]] oL["Sets the dedicated color for friendly tremor totem nameplates"] = "Sets the dedicated color for friendly tremor totem nameplates"
--[[ zhCN ]] oL["Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"
--[[ zhCN ]] oL["Sets the dedicated color for friendly grounding totem nameplates"] = "Sets the dedicated color for friendly grounding totem nameplates"
--[[ zhCN ]] oL["Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"] = "Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"
--[[ zhCN ]] oL["Sets the dedicated color for friendly earthbind totem nameplates"] = "Sets the dedicated color for friendly earthbind totem nameplates"

--[[ zhCN ]] oL["Use Nameplate Alpha In Combat"] = "Use Nameplate Alpha In Combat"
--[[ zhCN ]] oL["Controls nameplate visibility in combat or when target nameplate is always shown by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load)"] = "Controls nameplate visibility in combat or when target nameplate is always shown by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load)"

--[[ zhCN ]] oL["Hide Unit Names"] = "Hide Unit Names"
--[[ zhCN ]] oL["Hide nameplates by unit name"] = "Hide nameplates by unit name"
--[[ zhCN ]] oL["Hide Unit Name"] = "Hide Unit Name"
--[[ zhCN ]] oL["Hide Current Target"] = "Hide Current Target"
--[[ zhCN ]] oL["Add current target to list of unit names to hide"] = "Add current target to list of unit names to hide"
--[[ zhCN ]] oL["Add given name to list of unit names to hide"] = "Add given name to list of unit names to hide"
--[[ zhCN ]] oL["Enter any unit name, then enter <return>"] = "Enter any unit name, then enter <return>"
--[[ zhCN ]] oL["Delete Unit Name"] = "Delete Unit Name"
--[[ zhCN ]] oL["Select from list of unit names to delete"] = "Select from list of unit names to delete"
--[[ zhCN ]] oL["Select a unit name to delete it from the list"] = "Select a unit name to delete it from the list"

--[[ zhCN ]] oL["Color"] = "颜色"

--[[ zhCN ]] oL["All"] = "全部"
--[[ zhCN ]] oL["Group Only"] = "仅显示队友"
--[[ zhCN ]] oL["Guild Only"] = "仅显示公会成员"
--[[ zhCN ]] oL["None"] = "无"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftVisibility"] = "可见度"
--[[ zhCN ]] mL["Control the visibility of various types of nameplates"] = "Control the visibility of various types of nameplates"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] oL["Visibility"] = "能見度"
--[[ zhTW ]] oL["Extra visibility options"] = "額外能見度設定"

--[[ zhTW ]] oL["Always Show Current Target"] = "總是顯示目前目標"
--[[ zhTW ]] oL["Always shows the current target nameplate (overrides other visibility options, requires use of alpha)"] = "總是顯示目前目標名牌(覆蓋其它能見度設定，需要透明度的使用)"

--[[ zhTW ]] oL["Show Hostile Players"] = "顯示敵對玩家"
--[[ zhTW ]] oL["Shows nameplates for hostile players"] = "顯示敵對玩家的名牌"
--[[ zhTW ]] oL["Show Hostile Pets"] = "顯示敵對寵物"
--[[ zhTW ]] oL["Shows nameplates for hostile pets"] = "顯示敵對寵物的名牌"
--[[ zhTW ]] oL["Show Hostile NPCs"] = "顯示敵對NPC"
--[[ zhTW ]] oL["Show hostile NPCs"] = "顯示敵對NPC的名牌"

--[[ zhTW ]] oL["Friendly Players"] = "顯示友善玩家"
--[[ zhTW ]] oL["Selects which friendly players to show"] = "選擇顯示哪一些友善玩家"
--[[ zhTW ]] oL["Show Pet"] = "顯示寵物"
--[[ zhTW ]] oL["Shows nameplates for your pets"] = "顯示你的寵物的名牌"
--[[ zhTW ]] oL["Show Group Pets"] = "顯示團體寵物"
--[[ zhTW ]] oL["Shows nameplates for group pets"] = "顯示團體寵物的名牌"
--[[ zhTW ]] oL["Show Friendly Pets"] = "顯示友善寵物"
--[[ zhTW ]] oL["Shows nameplates for friendly pets"] = "顯示友善寵物的名牌"
--[[ zhTW ]] oL["Show Friendly NPCs"] = "顯示友善NPC"
--[[ zhTW ]] oL["Show friendly NPCs"] = "顯示友善NPC的名牌"

--[[ zhTW ]] oL["Critters"] = "小動物"
--[[ zhTW ]] oL["Visibility options for critters"] = "小動物的能見度設定"
--[[ zhTW ]] oL["Critter Level"] = "小動物等級"
--[[ zhTW ]] oL["Assume neutral units below this level are 'critters'"] = "假設中立單位等級是'小動物'之下"
--[[ zhTW ]] oL["Critter Health"] = "小動物生命"
--[[ zhTW ]] oL["Assume neutral units below this health are 'critters'"] = "假設中立單位生命是'小動物'之下"
--[[ zhTW ]] oL["Show Critters"] = "顯示小動物"
--[[ zhTW ]] oL["Shows nameplates for critters"] = "顯示小動物的名牌"

--[[ zhTW ]] oL["Show Neutral Units"] = "顯示中立單位"
--[[ zhTW ]] oL["Show neutral units"] = "顯示中立單位的名牌"

--[[ zhTW ]] oL["Enable"] = "啟用"
--[[ zhTW ]] oL["Exceptions"] = "例外"
--[[ zhTW ]] oL["Enable Tremor Totem"] = "啟用戰慄圖騰"
--[[ zhTW ]] oL["Dedicated Tremor Totem Color"] = "專用的戰慄圖騰顏色"
--[[ zhTW ]] oL["Enable Grounding Totem"] = "啟用根基圖騰"
--[[ zhTW ]] oL["Dedicated Grounding Totem Color"] = "專用的根基圖騰顏色"
--[[ zhTW ]] oL["Enable Earthbind Totem"] = "啟用地縛圖騰"
--[[ zhTW ]] oL["Dedicated Earthbind Totem Color"] = "專用的地縛圖騰顏色"
--[[ zhTW ]] oL["Enable Cleansing Totem"] = "啟用祛病圖騰"
--[[ zhTW ]] oL["Dedicated Cleansing Totem Color"] = "專用的祛病圖騰顏色"
--[[ zhTW ]] oL["Enable Mana Tide Totem"] = "啟用法力之潮圖騰"
--[[ zhTW ]] oL["Dedicated Mana Tide Totem Color"] = "專用的法力之潮圖騰顏色"

--[[ zhTW ]] oL["Show Hostile Totems/Trap Snakes/Bloodworms"] = "顯示敵對圖騰/毒蛇陷阱/血蟲"
--[[ zhTW ]] oL["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "顯示敵對圖騰/毒蛇陷阱/血蟲的名牌(只在離開戰鬥時影響名牌)"
--[[ zhTW ]] oL["Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "即使敵對圖騰/毒蛇陷阱/血蟲的名牌是隱藏的，顯示他們(用專用的顏色)"
--[[ zhTW ]] oL["Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"] = "明確地顯示敵對戰慄圖騰名牌(用專用的顏色)"
--[[ zhTW ]] oL["Sets the dedicated color for hostile tremor totem nameplates"] = "設定敵對戰慄圖騰名牌的專用的顏色"
--[[ zhTW ]] oL["Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"] = "明確地顯示敵對根基圖騰名牌(用專用的顏色)"
--[[ zhTW ]] oL["Sets the dedicated color for hostile grounding totem nameplates"] = "設定敵對根基圖騰名牌的專用的顏色"
--[[ zhTW ]] oL["Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"] = "明確地顯示敵對地縛圖騰名牌(用專用的顏色)"
--[[ zhTW ]] oL["Sets the dedicated color for hostile earthbind totem nameplates"] = "設定敵對地縛圖騰名牌的專用的顏色"
--[[ zhTW ]] oL["Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"] = "明確地顯示敵對祛病圖騰名牌(用專用的顏色)"
--[[ zhTW ]] oL["Sets the dedicated color for hostile cleansing totem nameplates"] = "設定敵對祛病圖騰名牌的專用的顏色"
--[[ zhTW ]] oL["Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"] = "明確地顯示敵對法力之潮圖騰名牌(用專用的顏色)"
--[[ zhTW ]] oL["Sets the dedicated color for hostile mana tide totem nameplates"] = "設定敵對法力之潮圖騰名牌的專用的顏色"

--[[ zhTW ]] oL["Show Friendly Totems/Trap Snakes/Bloodworms"] = "顯示友善圖騰/毒蛇陷阱/血蟲"
--[[ zhTW ]] oL["Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"] = "顯示友善圖騰/毒蛇陷阱/血蟲的名牌(只在離開戰鬥時影響名牌)"
--[[ zhTW ]] oL["Even if nameplates for friendly totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"] = "即使友善圖騰/毒蛇陷阱/血蟲的名牌是隱藏的，顯示他們(用專用的顏色)"
--[[ zhTW ]] oL["Explicitly shows nameplates for friendly tremor totems (with a dedicated color)"] = "明確地顯示友善戰慄圖騰名牌(用專用的顏色)"
--[[ zhTW ]] oL["Sets the dedicated color for friendly tremor totem nameplates"] = "設定友善戰慄圖騰名牌的專用的顏色"
--[[ zhTW ]] oL["Explicitly shows nameplates for friendly grounding totems (with a dedicated color)"] = "明確地顯示友善根基圖騰名牌(用專用的顏色)"
--[[ zhTW ]] oL["Sets the dedicated color for friendly grounding totem nameplates"] = "設定友善根基圖騰名牌的專用的顏色"
--[[ zhTW ]] oL["Explicitly shows nameplates for friendly earthbind totems (with a dedicated color)"] = "明確地顯示友善地縛圖騰名牌(用專用的顏色)"
--[[ zhTW ]] oL["Sets the dedicated color for friendly earthbind totem nameplates"] = "設定友善地縛圖騰名牌的專用的顏色"

--[[ zhTW ]] oL["Use Nameplate Alpha In Combat"] = "戰鬥中使用名牌透明度"
--[[ zhTW ]] oL["Controls nameplate visibility in combat or when target nameplate is always shown by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load)"] = "控制戰鬥中名牌能見度或是當用目標名牌總是顯示，設定透明度到0(在載入時需要Aloft透明度模組啟用)"

--[[ zhTW ]] oL["Hide Unit Names"] = "隱藏單位名稱"
--[[ zhTW ]] oL["Hide nameplates by unit name"] = "根據單位名稱隱藏名牌"
--[[ zhTW ]] oL["Hide Unit Name"] = "隱藏單位名稱"
--[[ zhTW ]] oL["Hide Current Target"] = "隱藏目前目標"
--[[ zhTW ]] oL["Add current target to list of unit names to hide"] = "新增目前目標到單位名稱清單來隱藏"
--[[ zhTW ]] oL["Add given name to list of unit names to hide"] = "新增給予目標到單位名稱清單來隱藏"
--[[ zhTW ]] oL["Enter any unit name, then enter <return>"] = "輸入任何單位名稱，然後輸入<返回>"
--[[ zhTW ]] oL["Delete Unit Name"] = "刪除單位名稱"
--[[ zhTW ]] oL["Select from list of unit names to delete"] = "從單位名稱清單選擇來刪除"
--[[ zhTW ]] oL["Select a unit name to delete it from the list"] = "選擇從清單的單位名稱來刪除"

--[[ zhTW ]] oL["Color"] = "顏色"

--[[ zhTW ]] oL["All"] = "全部"
--[[ zhTW ]] oL["Group Only"] = "只有隊伍"
--[[ zhTW ]] oL["Guild Only"] = "只有公會"
--[[ zhTW ]] oL["None"] = "無"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftVisibility"] = "Aloft能見度"
--[[ zhTW ]] mL["Control the visibility of various types of nameplates"] = "控制名牌各種類型的能見度"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

AloftLocale.AloftVisibilityOptions = setmetatable(oL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
oL = nil

-----------------------------------------------------------------------------

end)
