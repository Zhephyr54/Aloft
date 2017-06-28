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

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

-- some of these duplicate labels for keybindings; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ enUS ]] L["Show Neutral/Enemy Name Plates"] = "Show Neutral/Enemy Name Plates"
--[[ enUS ]] L["Show nameplates for neutral or hostile units"] = "Show nameplates for neutral or hostile units"
--[[ enUS ]] L["Show Friendly Name Plates"] = "Show Friendly Name Plates"
--[[ enUS ]] L["Show nameplates for friendly units"] = "Show nameplates for friendly units"
--[[ enUS ]] L["Show All Name Plates"] = "Show All Name Plates"
--[[ enUS ]] L["Show Nameplates"] = "Show Nameplates"

-- player states; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ enUS ]] L["Player State"] = "Player State"
--[[ enUS ]] L["Combat"] = "Combat"
--[[ enUS ]] L["Flagged/PvP"] = "Flagged/PvP"
--[[ enUS ]] L["Resting"] = "Resting"
--[[ enUS ]] L["Group"] = "Group"
--[[ enUS ]] L["Default"] = "Default"

-- player locations; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ enUS ]] L["Player Location"] = "Player Location"
--[[ enUS ]] L["World"] = "World"
--[[ enUS ]] L["Battleground"] = "Battleground"
--[[ enUS ]] L["Arena"] = "Arena"
--[[ enUS ]] L["5-Man Instance"] = "5-Man Instance"
--[[ enUS ]] L["Raid Instance"] = "Raid Instance"

--[[ enUS ]] L["Set All"] = "Set All"

--[[ enUS ]] L["Name Plate Motion"] = "Name Plate Motion"
--[[ enUS ]] L["Motion of nameplates when they might overlap"] = "Motion of nameplates when they might overlap"

--[[ enUS ]] L["Motion Style"] = "Motion Style"
--[[ enUS ]] L["STACK"] = "Stack"
--[[ enUS ]] L["SPREAD"] = "Spread"

--[[ enUS ]] L["Automate all nameplate motion"] = "Automate all nameplate motion"
--[[ enUS ]] L["Motion Options"] = "Motion Options"
--[[ enUS ]] L["Options controlling nameplate motion"] = "Options controlling nameplate motion"
--[[ enUS ]] L["Bounce Nameplates on Motion Change"] = "Bounce Nameplates on Motion Change"
--[[ enUS ]] L["Quicky toggle nameplates (bounce) when motion settings are automatically changed"] = "Quicky toggle nameplates (bounce) when motion settings are automatically changed"

--[[ enUS ]] L["Nameplate motion based on player state (subject to Visibility options)"] = "Nameplate motion based on player state (subject to Visibility options)"
--[[ enUS ]] L["Nameplate motion on entering/exiting combat (subject to Visibility options)"] = "Nameplate motion on entering/exiting combat (subject to Visibility options)"
--[[ enUS ]] L["Nameplate motion on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Nameplate motion on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"
--[[ enUS ]] L["Nameplate motion on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Nameplate motion on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"
--[[ enUS ]] L["Nameplate motion on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Nameplate motion on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"
--[[ enUS ]] L["Nameplate motion by default (subject to Visibility options)"] = "Nameplate motion by default (subject to Visibility options)"

--[[ enUS ]] L["Nameplate motion based on player location (subject to Visibility options)"] = "Nameplate motion based on player location (subject to Visibility options)"
--[[ enUS ]] L["Nameplate motion on entering/exiting the world (subject to Visibility options)"] = "Nameplate motion on entering/exiting the world (subject to Visibility options)"
--[[ enUS ]] L["Nameplate motion on entering/exiting battlegrounds (subject to Visibility options)"] = "Nameplate motion on entering/exiting battlegrounds (subject to Visibility options)"
--[[ enUS ]] L["Nameplate motion on entering/exiting arenas (subject to Visibility options)"] = "Nameplate motion on entering/exiting arenas (subject to Visibility options)"
--[[ enUS ]] L["Nameplate motion on entering/exiting 5-man instances (subject to Visibility options)"] = "Nameplate motion on entering/exiting 5-man instances (subject to Visibility options)"
--[[ enUS ]] L["Nameplate motion on entering/exiting raid instances (subject to Visibility options)"] = "Nameplate motion on entering/exiting raid instances (subject to Visibility options)"

--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"

--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"

--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"

--[[ enUS ]] L["Auto-show/hide all friendly nameplates (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates (subject to Visibility options)"

--[[ enUS ]] L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates by default (subject to Visibility options)"

--[[ enUS ]] L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"
--[[ enUS ]] L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"

--[[ enUS ]] L["All Nameplates"] = "All Nameplates"
--[[ enUS ]] L["All nameplates"] = "All nameplates"
--[[ enUS ]] L["Pet Nameplates"] = "Pet Nameplates"
--[[ enUS ]] L["Pet nameplates"] = "Pet nameplates"
--[[ enUS ]] L["Guardian Nameplates"] = "Guardian Nameplates"
--[[ enUS ]] L["Guardian nameplates"] = "Guardian nameplates"
--[[ enUS ]] L["Totem Nameplates"] = "Totem Nameplates"
--[[ enUS ]] L["Totem nameplates"] = "Totem nameplates"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftAutoShow"] = "AloftAutoShow"
--[[ enUS ]] mL["Automatically show/hide nameplates based on various events and conditions"] = "Automatically show/hide nameplates based on various events and conditions"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

-- some of these duplicate labels for keybindings; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ koKR ]] L["Show Neutral/Enemy Name Plates"] = "Show Neutral/Enemy Name Plates"
--[[ koKR ]] L["Show nameplates for neutral or hostile units"] = "중립적 혹은 적대적 대상에 대한 이름표를 표시합니다."
--[[ koKR ]] L["Show Friendly Name Plates"] = "Show Friendly Name Plates"
--[[ koKR ]] L["Show nameplates for friendly units"] = "우호적 대상에 대한 이름표를 표시합니다."
--[[ koKR ]] L["Show All Name Plates"] = "Show All Name Plates"
--[[ koKR ]] L["Show Nameplates"] = "이름표 표시"

-- player states; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ koKR ]] L["Combat"] = "Combat"
--[[ koKR ]] L["Flagged/PvP"] = "Flagged/PvP"
--[[ koKR ]] L["Resting"] = "Resting"
--[[ koKR ]] L["Group"] = "Group"
--[[ koKR ]] L["Default"] = "Default"

-- player locations; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ koKR ]] L["Player Location"] = "Player Location"
--[[ koKR ]] L["World"] = "World"
--[[ koKR ]] L["Battleground"] = "Battleground"
--[[ koKR ]] L["Arena"] = "Arena"
--[[ koKR ]] L["5-Man Instance"] = "5-Man Instance"
--[[ koKR ]] L["Raid Instance"] = "Raid Instance"

--[[ koKR ]] L["Set All"] = "Set All"

--[[ koKR ]] L["Name Plate Motion"] = "Name Plate Motion"
--[[ koKR ]] L["Motion of nameplates when they might overlap"] = "Motion of nameplates when they might overlap"

--[[ koKR ]] L["Motion Style"] = "Motion Style"
--[[ koKR ]] L["STACK"] = "Stack"
--[[ koKR ]] L["SPREAD"] = "Spread"

--[[ koKR ]] L["Automate all nameplate motion"] = "Automate all nameplate motion"
--[[ koKR ]] L["Motion Options"] = "Motion Options"
--[[ koKR ]] L["Options controlling nameplate motion"] = "Options controlling nameplate motion"
--[[ koKR ]] L["Bounce Nameplates on Motion Change"] = "Bounce Nameplates on Motion Change"
--[[ koKR ]] L["Quicky toggle nameplates (bounce) when motion settings are automatically changed"] = "Quicky toggle nameplates (bounce) when motion settings are automatically changed"

--[[ koKR ]] L["Nameplate motion based on player state (subject to Visibility options)"] = "Nameplate motion based on player state (subject to Visibility options)"
--[[ koKR ]] L["Nameplate motion on entering/exiting combat (subject to Visibility options)"] = "Nameplate motion on entering/exiting combat (subject to Visibility options)"
--[[ koKR ]] L["Nameplate motion on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Nameplate motion on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"
--[[ koKR ]] L["Nameplate motion on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Nameplate motion on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"
--[[ koKR ]] L["Nameplate motion on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Nameplate motion on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"
--[[ koKR ]] L["Nameplate motion by default (subject to Visibility options)"] = "Nameplate motion by default (subject to Visibility options)"

--[[ koKR ]] L["Nameplate motion based on player location (subject to Visibility options)"] = "Nameplate motion based on player location (subject to Visibility options)"
--[[ koKR ]] L["Nameplate motion on entering/exiting the world (subject to Visibility options)"] = "Nameplate motion on entering/exiting the world (subject to Visibility options)"
--[[ koKR ]] L["Nameplate motion on entering/exiting battlegrounds (subject to Visibility options)"] = "Nameplate motion on entering/exiting battlegrounds (subject to Visibility options)"
--[[ koKR ]] L["Nameplate motion on entering/exiting arenas (subject to Visibility options)"] = "Nameplate motion on entering/exiting arenas (subject to Visibility options)"
--[[ koKR ]] L["Nameplate motion on entering/exiting 5-man instances (subject to Visibility options)"] = "Nameplate motion on entering/exiting 5-man instances (subject to Visibility options)"
--[[ koKR ]] L["Nameplate motion on entering/exiting raid instances (subject to Visibility options)"] = "Nameplate motion on entering/exiting raid instances (subject to Visibility options)"

--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"

--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"

--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"

--[[ koKR ]] L["Auto-show/hide all friendly nameplates (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates (subject to Visibility options)"

--[[ koKR ]] L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates by default (subject to Visibility options)"

--[[ koKR ]] L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"
--[[ koKR ]] L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"

--[[ koKR ]] L["All Nameplates"] = "All Nameplates"
--[[ koKR ]] L["All nameplates"] = "All nameplates"
--[[ koKR ]] L["Pet Nameplates"] = "Pet Nameplates"
--[[ koKR ]] L["Pet nameplates"] = "Pet nameplates"
--[[ koKR ]] L["Guardian Nameplates"] = "Guardian Nameplates"
--[[ koKR ]] L["Guardian nameplates"] = "Guardian nameplates"
--[[ koKR ]] L["Totem Nameplates"] = "Totem Nameplates"
--[[ koKR ]] L["Totem nameplates"] = "Totem nameplates"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftAutoShow"] = "AloftAutoShow"
--[[ koKR ]] mL["Automatically show/hide nameplates based on various events and conditions"] = "Automatically show/hide nameplates based on various events and conditions"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

-- some of these duplicate labels for keybindings; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ ruRU ]] L["Show Neutral/Enemy Name Plates"] = "Отображать таблички нейтральных/враждебных"
--[[ ruRU ]] L["Show nameplates for neutral or hostile units"] = "Отображать таблички для нейтральных или враждебных"
--[[ ruRU ]] L["Show Friendly Name Plates"] = "Отображать таблички дружественных"
--[[ ruRU ]] L["Show nameplates for friendly units"] = "Отображать таблички для дружественных"
--[[ ruRU ]] L["Show All Name Plates"] = "Отображать все таблички"
--[[ ruRU ]] L["Show Nameplates"] = "Отображать таблички"

-- player states; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ ruRU ]] L["Player State"] = "Состояние игрока"
--[[ ruRU ]] L["Combat"] = "Бой"
--[[ ruRU ]] L["Flagged/PvP"] = "Флаг/PvP"
--[[ ruRU ]] L["Resting"] = "Отдых"
--[[ ruRU ]] L["Group"] = "Группа"
--[[ ruRU ]] L["Default"] = "По умолчанию"

-- player locations; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ ruRU ]] L["Player Location"] = "Местонахождение игрока"
--[[ ruRU ]] L["World"] = "Мир"
--[[ ruRU ]] L["Battleground"] = "Поля сражений"
--[[ ruRU ]] L["Arena"] = "Арена"
--[[ ruRU ]] L["5-Man Instance"] = "Инстансы на 5-чел"
--[[ ruRU ]] L["Raid Instance"] = "Рейдовые инстансыe"

--[[ ruRU ]] L["Set All"] = "Выбрать всё"

--[[ ruRU ]] L["Name Plate Motion"] = "Name Plate Motion"
--[[ ruRU ]] L["Motion of nameplates when they might overlap"] = "Motion of nameplates when they might overlap"

--[[ ruRU ]] L["Motion Style"] = "Motion Style"
--[[ ruRU ]] L["STACK"] = "Stack"
--[[ ruRU ]] L["SPREAD"] = "Spread"

--[[ ruRU ]] L["Automate all nameplate motion"] = "Automate all nameplate motion"
--[[ ruRU ]] L["Motion Options"] = "Motion Options"
--[[ ruRU ]] L["Options controlling nameplate motion"] = "Options controlling nameplate motion"
--[[ ruRU ]] L["Bounce Nameplates on Motion Change"] = "Bounce Nameplates on Motion Change"
--[[ ruRU ]] L["Quicky toggle nameplates (bounce) when motion settings are automatically changed"] = "Quicky toggle nameplates (bounce) when motion settings are automatically changed"

--[[ ruRU ]] L["Nameplate motion based on player state (subject to Visibility options)"] = "Nameplate motion based on player state (subject to Visibility options)"
--[[ ruRU ]] L["Nameplate motion on entering/exiting combat (subject to Visibility options)"] = "Nameplate motion on entering/exiting combat (subject to Visibility options)"
--[[ ruRU ]] L["Nameplate motion on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Nameplate motion on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"
--[[ ruRU ]] L["Nameplate motion on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Nameplate motion on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"
--[[ ruRU ]] L["Nameplate motion on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Nameplate motion on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"
--[[ ruRU ]] L["Nameplate motion by default (subject to Visibility options)"] = "Nameplate motion by default (subject to Visibility options)"

--[[ ruRU ]] L["Nameplate motion based on player location (subject to Visibility options)"] = "Nameplate motion based on player location (subject to Visibility options)"
--[[ ruRU ]] L["Nameplate motion on entering/exiting the world (subject to Visibility options)"] = "Nameplate motion on entering/exiting the world (subject to Visibility options)"
--[[ ruRU ]] L["Nameplate motion on entering/exiting battlegrounds (subject to Visibility options)"] = "Nameplate motion on entering/exiting battlegrounds (subject to Visibility options)"
--[[ ruRU ]] L["Nameplate motion on entering/exiting arenas (subject to Visibility options)"] = "Nameplate motion on entering/exiting arenas (subject to Visibility options)"
--[[ ruRU ]] L["Nameplate motion on entering/exiting 5-man instances (subject to Visibility options)"] = "Nameplate motion on entering/exiting 5-man instances (subject to Visibility options)"
--[[ ruRU ]] L["Nameplate motion on entering/exiting raid instances (subject to Visibility options)"] = "Nameplate motion on entering/exiting raid instances (subject to Visibility options)"

--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных (относится к настройкам Вида)"

--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных оснавываяс на состаянии игрока (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из боя (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при присутствии/отсутствии метки PvP (и не находясь в бою; относится к настройкам Вида"
--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из состояния отдыха (и не находясь в бою или помеченным; относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных вступая/выходя из группы (и не находясь в бою, помеченным, или отдыхая; относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных по умолчанию (относится к настройкам Вида)"

--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных основываясь на местонахождение игрока (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из мира (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из поля боя (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из арены (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из подземелья на 5-чел (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из рейдового подземелья (относится к настройкам Вида)"

--[[ ruRU ]] L["Auto-show/hide all friendly nameplates (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички (относится к настройкам Вида)"

--[[ ruRU ]] L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички основываясь на состоянии игрока (относится к настройкам Видаs)"
--[[ ruRU ]] L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при входе/выходе из боя (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при присутствии/отсутствии метки PvP (и не находясь в бою; относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при входе/выходе из состояния отдыха (и не находясь в бою или помеченным; относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички вступая/выходя из группы (и не находясь в бою, помеченным, или отдыхая; относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички по умолчанию (относится к настройкам Вида)"

--[[ ruRU ]] L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички основываясь на местонахождение игрока (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при входе/выходе из мира (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при входе/выходе из поля боя (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички  при входе/выходе из арены (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при входе/выходе из подземелья на 5-чел (относится к настройкам Вида)"
--[[ ruRU ]] L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при входе/выходе из рейдового подземелья (относится к настройкам Вида)"

--[[ ruRU ]] L["All Nameplates"] = "All Nameplates"
--[[ ruRU ]] L["All nameplates"] = "All nameplates"
--[[ ruRU ]] L["Pet Nameplates"] = "Pet Nameplates"
--[[ ruRU ]] L["Pet nameplates"] = "Pet nameplates"
--[[ ruRU ]] L["Guardian Nameplates"] = "Guardian Nameplates"
--[[ ruRU ]] L["Guardian nameplates"] = "Guardian nameplates"
--[[ ruRU ]] L["Totem Nameplates"] = "Totem Nameplates"
--[[ ruRU ]] L["Totem nameplates"] = "Totem nameplates"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftAutoShow"] = "AloftAutoShow"
--[[ ruRU ]] mL["Automatically show/hide nameplates based on various events and conditions"] = "Автоматически показывает/скрывает таблички основываясь на различных критериях и событиях"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

-- some of these duplicate labels for keybindings; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ zhCN ]] L["Show Neutral/Enemy Name Plates"] = "Show Neutral/Enemy Name Plates"
--[[ zhCN ]] L["Show nameplates for neutral or hostile units"] = "显示中立或敌对单位的姓名板"
--[[ zhCN ]] L["Show Friendly Name Plates"] = "Show Friendly Name Plates"
--[[ zhCN ]] L["Show nameplates for friendly units"] = "显示友方单位的姓名板"
--[[ zhCN ]] L["Show All Name Plates"] = "Show All Name Plates"
--[[ zhCN ]] L["Show Nameplates"] = "显示姓名板"

--[[ zhCN ]] L["Combat"] = "战斗"
--[[ zhCN ]] L["Flagged/PvP"] = "Flagged/PvP"
--[[ zhCN ]] L["Resting"] = "休息"
--[[ zhCN ]] L["Group"] = "小队"
--[[ zhCN ]] L["Default"] = "默认"

-- player locations; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ zhCN ]] L["Player Location"] = "Player Location"
--[[ zhCN ]] L["World"] = "World"
--[[ zhCN ]] L["Battleground"] = "Battleground"
--[[ zhCN ]] L["Arena"] = "Arena"
--[[ zhCN ]] L["5-Man Instance"] = "5-Man Instance"
--[[ zhCN ]] L["Raid Instance"] = "Raid Instance"

--[[ zhCN ]] L["Set All"] = "全部"

--[[ zhCN ]] L["Name Plate Motion"] = "Name Plate Motion"
--[[ zhCN ]] L["Motion of nameplates when they might overlap"] = "Motion of nameplates when they might overlap"

--[[ zhCN ]] L["Motion Style"] = "Motion Style"
--[[ zhCN ]] L["STACK"] = "Stack"
--[[ zhCN ]] L["SPREAD"] = "Spread"

--[[ zhCN ]] L["Automate all nameplate motion"] = "Automate all nameplate motion"
--[[ zhCN ]] L["Motion Options"] = "Motion Options"
--[[ zhCN ]] L["Options controlling nameplate motion"] = "Options controlling nameplate motion"
--[[ zhCN ]] L["Bounce Nameplates on Motion Change"] = "Bounce Nameplates on Motion Change"
--[[ zhCN ]] L["Quicky toggle nameplates (bounce) when motion settings are automatically changed"] = "Quicky toggle nameplates (bounce) when motion settings are automatically changed"

--[[ zhCN ]] L["Nameplate motion based on player state (subject to Visibility options)"] = "Nameplate motion based on player state (subject to Visibility options)"
--[[ zhCN ]] L["Nameplate motion on entering/exiting combat (subject to Visibility options)"] = "Nameplate motion on entering/exiting combat (subject to Visibility options)"
--[[ zhCN ]] L["Nameplate motion on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Nameplate motion on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"
--[[ zhCN ]] L["Nameplate motion on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Nameplate motion on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"
--[[ zhCN ]] L["Nameplate motion on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Nameplate motion on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"
--[[ zhCN ]] L["Nameplate motion by default (subject to Visibility options)"] = "Nameplate motion by default (subject to Visibility options)"

--[[ zhCN ]] L["Nameplate motion based on player location (subject to Visibility options)"] = "Nameplate motion based on player location (subject to Visibility options)"
--[[ zhCN ]] L["Nameplate motion on entering/exiting the world (subject to Visibility options)"] = "Nameplate motion on entering/exiting the world (subject to Visibility options)"
--[[ zhCN ]] L["Nameplate motion on entering/exiting battlegrounds (subject to Visibility options)"] = "Nameplate motion on entering/exiting battlegrounds (subject to Visibility options)"
--[[ zhCN ]] L["Nameplate motion on entering/exiting arenas (subject to Visibility options)"] = "Nameplate motion on entering/exiting arenas (subject to Visibility options)"
--[[ zhCN ]] L["Nameplate motion on entering/exiting 5-man instances (subject to Visibility options)"] = "Nameplate motion on entering/exiting 5-man instances (subject to Visibility options)"
--[[ zhCN ]] L["Nameplate motion on entering/exiting raid instances (subject to Visibility options)"] = "Nameplate motion on entering/exiting raid instances (subject to Visibility options)"

--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"] = "自动显示/隐藏所有中立和敌对姓名板（受控于可见度选项）"

--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"] = "进入/离开战斗时自动显示/隐藏所有中立和敌对姓名板（受控于可见度选项）"
--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"] = "默认自动显示/隐藏所有中立和敌对姓名板（受控于可见度选项）"

--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"

--[[ zhCN ]] L["Auto-show/hide all friendly nameplates (subject to Visibility options)"] = "自动显示/隐藏所有友方姓名板（受控于可见度选项）"

--[[ zhCN ]] L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"] = "进入/离开战斗时自动显示/隐藏所有友方姓名板（受控于可见度选项）"
--[[ zhCN ]] L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"] = "默认自动显示/隐藏所有友方姓名板（受控于可见度选项）"

--[[ zhCN ]] L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"
--[[ zhCN ]] L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"

--[[ zhCN ]] L["All Nameplates"] = "All Nameplates"
--[[ zhCN ]] L["All nameplates"] = "All nameplates"
--[[ zhCN ]] L["Pet Nameplates"] = "Pet Nameplates"
--[[ zhCN ]] L["Pet nameplates"] = "Pet nameplates"
--[[ zhCN ]] L["Guardian Nameplates"] = "Guardian Nameplates"
--[[ zhCN ]] L["Guardian nameplates"] = "Guardian nameplates"
--[[ zhCN ]] L["Totem Nameplates"] = "Totem Nameplates"
--[[ zhCN ]] L["Totem nameplates"] = "Totem nameplates"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftAutoShow"] = "自动显示"
--[[ zhCN ]] mL["Automatically show/hide nameplates based on various events and conditions"] = "在特定事件和状态下自动显示/隐藏姓名板"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

-- some of these duplicate labels for keybindings; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ zhTW ]] L["Show Neutral/Enemy Name Plates"] = "顯示中立/敵對名牌"
--[[ zhTW ]] L["Show nameplates for neutral or hostile units"] = "顯示中立或敵對單位的名牌"
--[[ zhTW ]] L["Show Friendly Name Plates"] = "顯示友方單位名牌"
--[[ zhTW ]] L["Show nameplates for friendly units"] = "顯示友方單位的名牌"
--[[ zhTW ]] L["Show All Name Plates"] = "顯示全部名牌"
--[[ zhTW ]] L["Show Nameplates"] = "顯示名牌"

--[[ zhTW ]] L["Combat"] = "戰鬥"
--[[ zhTW ]] L["Flagged/PvP"] = "標幟/PvP"
--[[ zhTW ]] L["Resting"] = "休息"
--[[ zhTW ]] L["Group"] = "隊伍"
--[[ zhTW ]] L["Default"] = "預設"

-- player locations; should match strings in Aloft/Aloft.lua and Aloft localizations
--[[ zhTW ]] L["Player Location"] = "玩家位置"
--[[ zhTW ]] L["World"] = "世界"
--[[ zhTW ]] L["Battleground"] = "戰場"
--[[ zhTW ]] L["Arena"] = "競技場"
--[[ zhTW ]] L["5-Man Instance"] = "5人副本"
--[[ zhTW ]] L["Raid Instance"] = "團隊副本"

--[[ zhTW ]] L["Set All"] = "設定全部"

--[[ zhTW ]] L["Name Plate Motion"] = "名牌移動"
--[[ zhTW ]] L["Motion of nameplates when they might overlap"] = "可能會重疊時名牌移動"

--[[ zhTW ]] L["Motion Style"] = "移動類型"
--[[ zhTW ]] L["STACK"] = "堆疊"
--[[ zhTW ]] L["SPREAD"] = "延展"

--[[ zhTW ]] L["Automate all nameplate motion"] = "自動化全部名牌移動"
--[[ zhTW ]] L["Motion Options"] = "移動設定"
--[[ zhTW ]] L["Options controlling nameplate motion"] = "設定控制名牌移動"
--[[ zhTW ]] L["Bounce Nameplates on Motion Change"] = "在移動改變時彈跳名牌"
--[[ zhTW ]] L["Quicky toggle nameplates (bounce) when motion settings are automatically changed"] = "快速切換名牌(彈跳)當移動設定是自動改變"

--[[ zhTW ]] L["Nameplate motion based on player state (subject to Visibility options)"] = "名牌移動根據玩家狀態(受能見度設定)"
--[[ zhTW ]] L["Nameplate motion on entering/exiting combat (subject to Visibility options)"] = "名牌移動在進入/離開戰鬥(受能見度設定)"
--[[ zhTW ]] L["Nameplate motion on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "名牌移動在PVP有標幟/沒標幟(且沒在戰鬥中;受能見度設定)"
--[[ zhTW ]] L["Nameplate motion on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "名牌移動在進入/離開休息狀態(且沒在戰鬥中或標幟;受能見度設定)"
--[[ zhTW ]] L["Nameplate motion on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "名牌移動在進入/離開隊伍(且沒在戰鬥中、標幟、或是休息;受能見度設定)"
--[[ zhTW ]] L["Nameplate motion by default (subject to Visibility options)"] = "預設方式移動名牌(受能見度設定)"

--[[ zhTW ]] L["Nameplate motion based on player location (subject to Visibility options)"] = "名牌移動根據玩家位置(受能見度設定)"
--[[ zhTW ]] L["Nameplate motion on entering/exiting the world (subject to Visibility options)"] = "名牌移動在進入/離開世界(受能見度設定)"
--[[ zhTW ]] L["Nameplate motion on entering/exiting battlegrounds (subject to Visibility options)"] = "名牌移動在進入/離開戰場(受能見度設定)"
--[[ zhTW ]] L["Nameplate motion on entering/exiting arenas (subject to Visibility options)"] = "名牌移動在進入/離開競技場(受能見度設定)"
--[[ zhTW ]] L["Nameplate motion on entering/exiting 5-man instances (subject to Visibility options)"] = "名牌移動在進入/離開5人副本(受能見度設定)"
--[[ zhTW ]] L["Nameplate motion on entering/exiting raid instances (subject to Visibility options)"] = "名牌移動在進入/離開團隊副本(受能見度設定)"

--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"] = "自動顯示/隱藏所有中立和敵對名牌(受能見度設定)"

--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"] = "自動顯示/隱藏所有中立和敵對名牌根據玩家狀態(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"] = "進入/離開戰鬥時自動顯示/隱藏所有中立和敵對名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "PvP在標幟/未標誌時自動顯示/隱藏所有中立和敵對名牌(且不在戰鬥中;受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "在進入/離開休息狀態時自動顯示/隱藏所有中立和敵對名牌(且不在戰鬥中或標幟;受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "在進入/離開小隊時自動顯示/隱藏所有中立和敵對名牌(且不在戰鬥中、標幟或是休息;受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"] = "預設自動顯示/隱藏所有中立和敵對名牌(受能見度設定)"

--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"] = "根據玩家位置自動顯示/隱藏所有中立和敵對名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"] = "在進入/離開世界時自動顯示/隱藏所有中立和敵對名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "在進入/離開戰場時自動顯示/隱藏所有中立和敵對名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"] = "在進入/離開競技場時自動顯示/隱藏所有中立和敵對名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "在進入/離開5人副本時自動顯示/隱藏所有中立和敵對名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"] = "在進入/離開團隊副本時自動顯示/隱藏所有中立和敵對名牌(受能見度設定)"

--[[ zhTW ]] L["Auto-show/hide all friendly nameplates (subject to Visibility options)"] = "自動顯示/隱藏所有友方名牌(受能見度設定)"

--[[ zhTW ]] L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"] = "根據玩家狀態自動顯示/隱藏所有友方名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"] = "進入/離開戰鬥時自動顯示/隱藏所有友方名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "PvP在標幟/沒標幟時自動顯示/隱藏所有友方名牌(且不在戰鬥中;受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "在進入/離開休息狀態時自動顯示/隱藏所有友方名牌(且不在戰鬥中或標幟;受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "在進入/離開隊伍自動顯示/隱藏所有友方名牌(且不在戰鬥中、標幟或休息;受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"] = "預設自動顯示/隱藏所有友方名牌(受能見度設定)"

--[[ zhTW ]] L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"] = "根據玩家位置自動顯示/隱藏所有友方名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"] = "在進入/離開世界時自動顯示/隱藏所有友方名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "在進入/離開戰場時自動顯示/隱藏所有友方名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"] = "在進入/離開競技場時自動顯示/隱藏所有友方名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "在進入/離開5人副本時自動顯示/隱藏所有友方名牌(受能見度設定)"
--[[ zhTW ]] L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"] = "在進入/離開團隊副本時自動顯示/隱藏所有友方名牌(受能見度設定)"

--[[ zhTW ]] L["All Nameplates"] = "全部名牌"
--[[ zhTW ]] L["All nameplates"] = "全部名牌"
--[[ zhTW ]] L["Pet Nameplates"] = "寵物名牌"
--[[ zhTW ]] L["Pet nameplates"] = "寵物名牌"
--[[ zhTW ]] L["Guardian Nameplates"] = "守護者名牌"
--[[ zhTW ]] L["Guardian nameplates"] = "守護者名牌"
--[[ zhTW ]] L["Totem Nameplates"] = "圖騰名牌"
--[[ zhTW ]] L["Totem nameplates"] = "圖騰名牌"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftAutoShow"] = "Aloft自動顯示"
--[[ zhTW ]] mL["Automatically show/hide nameplates based on various events and conditions"] = "自動在特定的事件和狀態下顯示/隱藏名牌"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

AloftLocale.AloftAutoShowOptions = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

-----------------------------------------------------------------------------

end)
