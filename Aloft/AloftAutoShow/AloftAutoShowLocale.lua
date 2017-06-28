local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftAutoShowOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	-- some of these duplicate labels for keybindings; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ enUS ]] ["Show Neutral/Enemy Name Plates"] = true,
	--[[ enUS ]] ["Show nameplates for neutral or hostile units"] = true,
	--[[ enUS ]] ["Show Friendly Name Plates"] = true,
	--[[ enUS ]] ["Show nameplates for friendly units"] = true,
	--[[ enUS ]] ["Show All Name Plates"] = true,
	--[[ enUS ]] ["Show Nameplates"] = true,
	
	-- player states; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ enUS ]] ["Player State"] = true,
	--[[ enUS ]] ["Combat"] = true,
	--[[ enUS ]] ["Flagged/PvP"] = true,
	--[[ enUS ]] ["Resting"] = true,
	--[[ enUS ]] ["Group"] = true,
	--[[ enUS ]] ["Default"] = true,

	-- player locations; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ enUS ]] ["Player Location"] = true,
	--[[ enUS ]] ["World"] = true,
	--[[ enUS ]] ["Battleground"] = true,
	--[[ enUS ]] ["Arena"] = true,
	--[[ enUS ]] ["5-Man Instance"] = true,
	--[[ enUS ]] ["Raid Instance"] = true,

	--[[ enUS ]] ["Set All"] = true,

	--[[ enUS ]] ["Overlap Name Plates"] = true,
	--[[ enUS ]] ["Overlap nameplates"] = true,

	--[[ enUS ]] ["Overlap Options"] = true,
	--[[ enUS ]] ["Options controlling auto-overlap"] = true,
	--[[ enUS ]] ["Bounce Nameplates on Overlap Change"] = true,
	--[[ enUS ]] ["Quicky toggle nameplates (bounce) when overlap settings are automatically changed"] = true,
	--[[ enUS ]] ["Auto-overlap all nameplates"] = true,

	--[[ enUS ]] ["Auto-overlap all nameplates based on player state (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-overlap all nameplates on entering/exiting combat (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-overlap all nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-overlap all nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-overlap all nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-overlap all nameplates by default (subject to Visibility options)"] = true,

	--[[ enUS ]] ["Auto-overlap all nameplates based on player location (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-overlap all nameplates on entering/exiting the world (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-overlap all nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-overlap all nameplates on entering/exiting arenas (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-overlap all nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-overlap all nameplates on entering/exiting raid instances (subject to Visibility options)"] = true,

	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"] = true,

	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"] = true,

	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"] = true,

	--[[ enUS ]] ["Auto-show/hide all friendly nameplates (subject to Visibility options)"] = true,

	--[[ enUS ]] ["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"] = true,

	--[[ enUS ]] ["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = true,
	--[[ enUS ]] ["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"] = true,
	
	--[[ enUS ]] ["All Nameplates"] = true,
	--[[ enUS ]] ["All nameplates"] = true,
	--[[ enUS ]] ["Pet Nameplates"] = true,
	--[[ enUS ]] ["Pet nameplates"] = true,
	--[[ enUS ]] ["Guardian Nameplates"] = true,
	--[[ enUS ]] ["Guardian nameplates"] = true,
	--[[ enUS ]] ["Totem Nameplates"] = true,
	--[[ enUS ]] ["Totem nameplates"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	-- some of these duplicate labels for keybindings; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ koKR ]] ["Show Neutral/Enemy Name Plates"] = "Show Neutral/Enemy Name Plates",
	--[[ koKR ]] ["Show nameplates for neutral or hostile units"] = "중립적 혹은 적대적 대상에 대한 이름표를 표시합니다.",
	--[[ koKR ]] ["Show Friendly Name Plates"] = "Show Friendly Name Plates",
	--[[ koKR ]] ["Show nameplates for friendly units"] = "우호적 대상에 대한 이름표를 표시합니다.",
	--[[ koKR ]] ["Show All Name Plates"] = "Show All Name Plates",
	--[[ koKR ]] ["Show Nameplates"] = "이름표 표시",

	-- player states; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ koKR ]] ["Combat"] = "Combat",
	--[[ koKR ]] ["Flagged/PvP"] = "Flagged/PvP",
	--[[ koKR ]] ["Resting"] = "Resting",
	--[[ koKR ]] ["Group"] = "Group",
	--[[ koKR ]] ["Default"] = "Default",

	-- player locations; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ koKR ]] ["Player Location"] = "Player Location",
	--[[ koKR ]] ["World"] = "World",
	--[[ koKR ]] ["Battleground"] = "Battleground",
	--[[ koKR ]] ["Arena"] = "Arena",
	--[[ koKR ]] ["5-Man Instance"] = "5-Man Instance",
	--[[ koKR ]] ["Raid Instance"] = "Raid Instance",

	--[[ koKR ]] ["Set All"] = "Set All",

	--[[ koKR ]] ["Overlap Name Plates"] = "Overlap Name Plates",
	--[[ koKR ]] ["Overlap nameplates"] = "Overlap nameplates",

	--[[ koKR ]] ["Overlap Options"] = "Overlap Options",
	--[[ koKR ]] ["Options controlling auto-overlap"] = "Options controlling auto-overlap",
	--[[ koKR ]] ["Bounce Nameplates on Overlap Change"] = "Bounce Nameplates on Overlap Change",
	--[[ koKR ]] ["Quicky toggle nameplates (bounce) when overlap settings are automatically changed"] = "Quicky toggle nameplates (bounce) when overlap settings are automatically changed",
	--[[ koKR ]] ["Auto-overlap all nameplates"] = "Auto-overlap all nameplates",

	--[[ koKR ]] ["Auto-overlap all nameplates based on player state (subject to Visibility options)"] = "Auto-overlap all nameplates based on player state (subject to Visibility options)",
	--[[ koKR ]] ["Auto-overlap all nameplates on entering/exiting combat (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting combat (subject to Visibility options)",
	--[[ koKR ]] ["Auto-overlap all nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-overlap all nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)",
	--[[ koKR ]] ["Auto-overlap all nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)",
	--[[ koKR ]] ["Auto-overlap all nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)",
	--[[ koKR ]] ["Auto-overlap all nameplates by default (subject to Visibility options)"] = "Auto-overlap all nameplates by default (subject to Visibility options)",

	--[[ koKR ]] ["Auto-overlap all nameplates based on player location (subject to Visibility options)"] = "Auto-overlap all nameplates based on player location (subject to Visibility options)",
	--[[ koKR ]] ["Auto-overlap all nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting the world (subject to Visibility options)",
	--[[ koKR ]] ["Auto-overlap all nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting battlegrounds (subject to Visibility options)",
	--[[ koKR ]] ["Auto-overlap all nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting arenas (subject to Visibility options)",
	--[[ koKR ]] ["Auto-overlap all nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting 5-man instances (subject to Visibility options)",
	--[[ koKR ]] ["Auto-overlap all nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting raid instances (subject to Visibility options)",

	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)",

	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)",

	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)",

	--[[ koKR ]] ["Auto-show/hide all friendly nameplates (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates (subject to Visibility options)",

	--[[ koKR ]] ["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates by default (subject to Visibility options)",

	--[[ koKR ]] ["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)",
	--[[ koKR ]] ["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)",
	
	--[[ koKR ]] ["All Nameplates"] = "All Nameplates",
	--[[ koKR ]] ["All nameplates"] = "All nameplates",
	--[[ koKR ]] ["Pet Nameplates"] = "Pet Nameplates",
	--[[ koKR ]] ["Pet nameplates"] = "Pet nameplates",
	--[[ koKR ]] ["Guardian Nameplates"] = "Guardian Nameplates",
	--[[ koKR ]] ["Guardian nameplates"] = "Guardian nameplates",
	--[[ koKR ]] ["Totem Nameplates"] = "Totem Nameplates",
	--[[ koKR ]] ["Totem nameplates"] = "Totem nameplates",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	-- some of these duplicate labels for keybindings; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ ruRU ]] ["Show Neutral/Enemy Name Plates"] = "Отображать таблички нейтральных/враждебных",							
	--[[ ruRU ]] ["Show nameplates for neutral or hostile units"] = "Отображать таблички для нейтральных или враждебных",
	--[[ ruRU ]] ["Show Friendly Name Plates"] = "Отображать таблички дружественных",
	--[[ ruRU ]] ["Show nameplates for friendly units"] = "Отображать таблички для дружественных",
	--[[ ruRU ]] ["Show All Name Plates"] = "Отображать все таблички",
	--[[ ruRU ]] ["Show Nameplates"] = "Отображать таблички",

	-- player states; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ ruRU ]] ["Player State"] = "Состояние игрока",
	--[[ ruRU ]] ["Combat"] = "Бой",
	--[[ ruRU ]] ["Flagged/PvP"] = "Флаг/PvP",
	--[[ ruRU ]] ["Resting"] = "Отдых",
	--[[ ruRU ]] ["Group"] = "Группа",
	--[[ ruRU ]] ["Default"] = "По умолчанию",

	-- player locations; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ ruRU ]] ["Player Location"] = "Местонахождение игрока",
	--[[ ruRU ]] ["World"] = "Мир",
	--[[ ruRU ]] ["Battleground"] = "Поля сражений",
	--[[ ruRU ]] ["Arena"] = "Арена",
	--[[ ruRU ]] ["5-Man Instance"] = "Инстансы на 5-чел",
	--[[ ruRU ]] ["Raid Instance"] = "Рейдовые инстансыe",

	--[[ ruRU ]] ["Set All"] = "Выбрать всё",

	--[[ ruRU ]] ["Overlap Name Plates"] = "Overlap Name Plates",
	--[[ ruRU ]] ["Overlap nameplates"] = "Overlap nameplates",

	--[[ ruRU ]] ["Overlap Options"] = "Overlap Options",
	--[[ ruRU ]] ["Options controlling auto-overlap"] = "Options controlling auto-overlap",
	--[[ ruRU ]] ["Bounce Nameplates on Overlap Change"] = "Bounce Nameplates on Overlap Change",
	--[[ ruRU ]] ["Quicky toggle nameplates (bounce) when overlap settings are automatically changed"] = "Quicky toggle nameplates (bounce) when overlap settings are automatically changed",
	--[[ ruRU ]] ["Auto-overlap all nameplates"] = "Auto-overlap all nameplates",

	--[[ ruRU ]] ["Auto-overlap all nameplates based on player state (subject to Visibility options)"] = "Auto-overlap all nameplates based on player state (subject to Visibility options)",
	--[[ ruRU ]] ["Auto-overlap all nameplates on entering/exiting combat (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting combat (subject to Visibility options)",
	--[[ ruRU ]] ["Auto-overlap all nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-overlap all nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)",
	--[[ ruRU ]] ["Auto-overlap all nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)",
	--[[ ruRU ]] ["Auto-overlap all nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)",
	--[[ ruRU ]] ["Auto-overlap all nameplates by default (subject to Visibility options)"] = "Auto-overlap all nameplates by default (subject to Visibility options)",

	--[[ ruRU ]] ["Auto-overlap all nameplates based on player location (subject to Visibility options)"] = "Auto-overlap all nameplates based on player location (subject to Visibility options)",
	--[[ ruRU ]] ["Auto-overlap all nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting the world (subject to Visibility options)",
	--[[ ruRU ]] ["Auto-overlap all nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting battlegrounds (subject to Visibility options)",
	--[[ ruRU ]] ["Auto-overlap all nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting arenas (subject to Visibility options)",
	--[[ ruRU ]] ["Auto-overlap all nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting 5-man instances (subject to Visibility options)",
	--[[ ruRU ]] ["Auto-overlap all nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting raid instances (subject to Visibility options)",

	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных (относится к настройкам Вида)",

	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных оснавываяс на состаянии игрока (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из боя (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при присутствии/отсутствии метки PvP (и не находясь в бою; относится к настройкам Вида",
	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из состояния отдыха (и не находясь в бою или помеченным; относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных вступая/выходя из группы (и не находясь в бою, помеченным, или отдыхая; относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных по умолчанию (относится к настройкам Вида)",

	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных основываясь на местонахождение игрока (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из мира (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из поля боя (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из арены (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из подземелья на 5-чел (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Авто-показать/скрыть все таблички нейтральных и враждебных при входе/выходе из рейдового подземелья (относится к настройкам Вида)",

	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички (относится к настройкам Вида)",

	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички основываясь на состоянии игрока (относится к настройкам Видаs)",
	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при входе/выходе из боя (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при присутствии/отсутствии метки PvP (и не находясь в бою; относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при входе/выходе из состояния отдыха (и не находясь в бою или помеченным; относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички вступая/выходя из группы (и не находясь в бою, помеченным, или отдыхая; относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички по умолчанию (относится к настройкам Вида)",

	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички основываясь на местонахождение игрока (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при входе/выходе из мира (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при входе/выходе из поля боя (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички  при входе/выходе из арены (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при входе/выходе из подземелья на 5-чел (относится к настройкам Вида)",
	--[[ ruRU ]] ["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Авто-показать/скрыть все дружественные таблички при входе/выходе из рейдового подземелья (относится к настройкам Вида)",
	
	--[[ ruRU ]] ["All Nameplates"] = "All Nameplates",
	--[[ ruRU ]] ["All nameplates"] = "All nameplates",
	--[[ ruRU ]] ["Pet Nameplates"] = "Pet Nameplates",
	--[[ ruRU ]] ["Pet nameplates"] = "Pet nameplates",
	--[[ ruRU ]] ["Guardian Nameplates"] = "Guardian Nameplates",
	--[[ ruRU ]] ["Guardian nameplates"] = "Guardian nameplates",
	--[[ ruRU ]] ["Totem Nameplates"] = "Totem Nameplates",
	--[[ ruRU ]] ["Totem nameplates"] = "Totem nameplates",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	-- some of these duplicate labels for keybindings; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ zhCN ]] ["Show Neutral/Enemy Name Plates"] = "Show Neutral/Enemy Name Plates",
	--[[ zhCN ]] ["Show nameplates for neutral or hostile units"] = "显示中立或敌对单位的姓名板",
	--[[ zhCN ]] ["Show Friendly Name Plates"] = "Show Friendly Name Plates",
	--[[ zhCN ]] ["Show nameplates for friendly units"] = "显示友方单位的姓名板",
	--[[ zhCN ]] ["Show All Name Plates"] = "Show All Name Plates",
	--[[ zhCN ]] ["Show Nameplates"] = "显示姓名板",

	--[[ zhCN ]] ["Combat"] = "战斗",
	--[[ zhCN ]] ["Flagged/PvP"] = "Flagged/PvP",
	--[[ zhCN ]] ["Resting"] = "休息",
	--[[ zhCN ]] ["Group"] = "小队",
	--[[ zhCN ]] ["Default"] = "默认",

	-- player locations; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ zhCN ]] ["Player Location"] = "Player Location",
	--[[ zhCN ]] ["World"] = "World",
	--[[ zhCN ]] ["Battleground"] = "Battleground",
	--[[ zhCN ]] ["Arena"] = "Arena",
	--[[ zhCN ]] ["5-Man Instance"] = "5-Man Instance",
	--[[ zhCN ]] ["Raid Instance"] = "Raid Instance",

	--[[ zhCN ]] ["Set All"] = "全部",

	--[[ zhCN ]] ["Overlap Name Plates"] = "Overlap Name Plates",
	--[[ zhCN ]] ["Overlap nameplates"] = "Overlap nameplates",

	--[[ zhCN ]] ["Overlap Options"] = "Overlap Options",
	--[[ zhCN ]] ["Options controlling auto-overlap"] = "Options controlling auto-overlap",
	--[[ zhCN ]] ["Bounce Nameplates on Overlap Change"] = "Bounce Nameplates on Overlap Change",
	--[[ zhCN ]] ["Quicky toggle nameplates (bounce) when overlap settings are automatically changed"] = "Quicky toggle nameplates (bounce) when overlap settings are automatically changed",
	--[[ zhCN ]] ["Auto-overlap all nameplates"] = "Auto-overlap all nameplates",

	--[[ zhCN ]] ["Auto-overlap all nameplates based on player state (subject to Visibility options)"] = "Auto-overlap all nameplates based on player state (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-overlap all nameplates on entering/exiting combat (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting combat (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-overlap all nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-overlap all nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)",
	--[[ zhCN ]] ["Auto-overlap all nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)",
	--[[ zhCN ]] ["Auto-overlap all nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)",
	--[[ zhCN ]] ["Auto-overlap all nameplates by default (subject to Visibility options)"] = "Auto-overlap all nameplates by default (subject to Visibility options)",

	--[[ zhCN ]] ["Auto-overlap all nameplates based on player location (subject to Visibility options)"] = "Auto-overlap all nameplates based on player location (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-overlap all nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting the world (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-overlap all nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting battlegrounds (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-overlap all nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting arenas (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-overlap all nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting 5-man instances (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-overlap all nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting raid instances (subject to Visibility options)",

	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"] = "自动显示/隐藏所有中立和敌对姓名板（受控于可见度选项）",

	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"] = "进入/离开战斗时自动显示/隐藏所有中立和敌对姓名板（受控于可见度选项）",
	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"] = "默认自动显示/隐藏所有中立和敌对姓名板（受控于可见度选项）",

	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)",

	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates (subject to Visibility options)"] = "自动显示/隐藏所有友方姓名板（受控于可见度选项）",

	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"] = "进入/离开战斗时自动显示/隐藏所有友方姓名板（受控于可见度选项）",
	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"] = "默认自动显示/隐藏所有友方姓名板（受控于可见度选项）",

	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)",
	--[[ zhCN ]] ["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)",
	
	--[[ zhCN ]] ["All Nameplates"] = "All Nameplates",
	--[[ zhCN ]] ["All nameplates"] = "All nameplates",
	--[[ zhCN ]] ["Pet Nameplates"] = "Pet Nameplates",
	--[[ zhCN ]] ["Pet nameplates"] = "Pet nameplates",
	--[[ zhCN ]] ["Guardian Nameplates"] = "Guardian Nameplates",
	--[[ zhCN ]] ["Guardian nameplates"] = "Guardian nameplates",
	--[[ zhCN ]] ["Totem Nameplates"] = "Totem Nameplates",
	--[[ zhCN ]] ["Totem nameplates"] = "Totem nameplates",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	-- some of these duplicate labels for keybindings; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ zhTW ]] ["Show Neutral/Enemy Name Plates"] = "Show Neutral/Enemy Name Plates",
	--[[ zhTW ]] ["Show nameplates for neutral or hostile units"] = "顯示中立或敵對單位的名牌",
	--[[ zhTW ]] ["Show Friendly Name Plates"] = "Show Friendly Name Plates",
	--[[ zhTW ]] ["Show nameplates for friendly units"] = "顯示友好單位的名牌",
	--[[ zhTW ]] ["Show All Name Plates"] = "Show All Name Plates",
	--[[ zhTW ]] ["Show Nameplates"] = "顯示名牌",

	--[[ zhTW ]] ["Combat"] = "戰斗",
	--[[ zhTW ]] ["Flagged/PvP"] = "Flagged/PvP",
	--[[ zhTW ]] ["Resting"] = "休息",
	--[[ zhTW ]] ["Group"] = "小隊",
	--[[ zhTW ]] ["Default"] = "默認",

	-- player locations; should match strings in Aloft/Aloft.lua and Aloft localizations
	--[[ zhTW ]] ["Player Location"] = "Player Location",
	--[[ zhTW ]] ["World"] = "World",
	--[[ zhTW ]] ["Battleground"] = "Battleground",
	--[[ zhTW ]] ["Arena"] = "Arena",
	--[[ zhTW ]] ["5-Man Instance"] = "5-Man Instance",
	--[[ zhTW ]] ["Raid Instance"] = "Raid Instance",

	--[[ zhTW ]] ["Set All"] = "全部",

	--[[ zhTW ]] ["Overlap Name Plates"] = "Overlap Name Plates",
	--[[ zhTW ]] ["Overlap nameplates"] = "Overlap nameplates",

	--[[ zhTW ]] ["Overlap Options"] = "Overlap Options",
	--[[ zhTW ]] ["Options controlling auto-overlap"] = "Options controlling auto-overlap",
	--[[ zhTW ]] ["Bounce Nameplates on Overlap Change"] = "Bounce Nameplates on Overlap Change",
	--[[ zhTW ]] ["Quicky toggle nameplates (bounce) when overlap settings are automatically changed"] = "Quicky toggle nameplates (bounce) when overlap settings are automatically changed",
	--[[ zhTW ]] ["Auto-overlap all nameplates"] = "Auto-overlap all nameplates",

	--[[ zhTW ]] ["Auto-overlap all nameplates based on player state (subject to Visibility options)"] = "Auto-overlap all nameplates based on player state (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-overlap all nameplates on entering/exiting combat (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting combat (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-overlap all nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-overlap all nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)",
	--[[ zhTW ]] ["Auto-overlap all nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)",
	--[[ zhTW ]] ["Auto-overlap all nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)",
	--[[ zhTW ]] ["Auto-overlap all nameplates by default (subject to Visibility options)"] = "Auto-overlap all nameplates by default (subject to Visibility options)",

	--[[ zhTW ]] ["Auto-overlap all nameplates based on player location (subject to Visibility options)"] = "Auto-overlap all nameplates based on player location (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-overlap all nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting the world (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-overlap all nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting battlegrounds (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-overlap all nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting arenas (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-overlap all nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting 5-man instances (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-overlap all nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-overlap all nameplates on entering/exiting raid instances (subject to Visibility options)",

	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"] = "自動顯示/隱藏所有中立和敵對名牌（受控於可見度選項）",

	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"] = "進入/離開戰鬥時自動顯示/隱藏所有中立和敵對名牌（受控於可見度選項）",
	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"] = "預設自動顯示/隱藏所有中立和敵對名牌（受控於可見度選項）",

	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)",

	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates (subject to Visibility options)"] = "自動顯示/隱藏所有友方名牌（受控於可見度選項）",

	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"] = "進入/離開戰鬥時自動顯示/隱藏所有友方名牌（受控於可見度選項）",
	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"] = "預設自動顯示/隱藏所有友方名牌（受控於可見度選項）",

	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)",
	--[[ zhTW ]] ["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"] = "Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)",
	
	--[[ zhTW ]] ["All Nameplates"] = "All Nameplates",
	--[[ zhTW ]] ["All nameplates"] = "All nameplates",
	--[[ zhTW ]] ["Pet Nameplates"] = "Pet Nameplates",
	--[[ zhTW ]] ["Pet nameplates"] = "Pet nameplates",
	--[[ zhTW ]] ["Guardian Nameplates"] = "Guardian Nameplates",
	--[[ zhTW ]] ["Guardian nameplates"] = "Guardian nameplates",
	--[[ zhTW ]] ["Totem Nameplates"] = "Totem Nameplates",
	--[[ zhTW ]] ["Totem nameplates"] = "Totem nameplates",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
