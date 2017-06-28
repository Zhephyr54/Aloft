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

AloftModules:AddInitializer("AloftFaction", function()

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Save Faction Data"] = "Save Faction Data"
--[[ enUS ]] L["Stores faction data between sessions"] = "Stores faction data between sessions"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftFaction"] = "AloftFaction"
--[[ enUS ]] mL["Gather faction data"] = "Gather faction data"

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFaction", function()

-----------------------------------------------------------------------------

--[[ koKR ]] L["Save Faction Data"] = "Save Faction Data"
--[[ koKR ]] L["Stores faction data between sessions"] = "Stores faction data between sessions"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftFaction"] = "AloftFaction"
--[[ koKR ]] mL["Gather faction data"] = "Gather faction data"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFaction", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Save Faction Data"] = "Save Faction Data"
--[[ ruRU ]] L["Stores faction data between sessions"] = "Stores faction data between sessions"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftFaction"] = "AloftFaction"
--[[ ruRU ]] mL["Gather faction data"] = "Gather faction data"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFaction", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Save Faction Data"] = "Save Faction Data"
--[[ zhCN ]] L["Stores faction data between sessions"] = "Stores faction data between sessions"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftFaction"] = "AloftFaction"
--[[ zhCN ]] mL["Gather faction data"] = "Gather faction data"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFaction", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Save Faction Data"] = "儲存聲望資料"
--[[ zhTW ]] L["Stores faction data between sessions"] = "儲存聲望資料在登錄期間"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftFaction"] = "Aloft聲望"
--[[ zhTW ]] mL["Gather faction data"] = "收集聲望資料"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFaction", function()

-----------------------------------------------------------------------------

AloftLocale.AloftFactionDataOptions = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------
