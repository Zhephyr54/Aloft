local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

-- TODO: must match similar string in ThreatBar.lua and in localization LUA; TODO: fix this, make it centrally sourced

-- threat types
local THREAT_RANGED	= "Ranged"
local THREAT_MELEE		= "Melee"
local THREAT_TANK		= "Tank"
local THREAT_GROUP		= "Group"

local SHORT_THREAT_TYPES = {
	[THREAT_RANGED]	= "R",
	[THREAT_MELEE]	= "M",
	[THREAT_TANK]	= "K",
	[THREAT_GROUP]	= "G",
}

-----------------------------------------------------------------------------

local dL = { }

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

-- long forms
--[[ enUS ]] dL[THREAT_RANGED]						= THREAT_RANGED
--[[ enUS ]] dL[THREAT_MELEE]						= THREAT_MELEE
--[[ enUS ]] dL[THREAT_TANK]						= THREAT_TANK
--[[ enUS ]] dL[THREAT_GROUP]						= THREAT_GROUP

-- short forms
--[[ enUS ]] dL[SHORT_THREAT_TYPES[THREAT_RANGED]]	= SHORT_THREAT_TYPES[THREAT_RANGED]
--[[ enUS ]] dL[SHORT_THREAT_TYPES[THREAT_MELEE]]	= SHORT_THREAT_TYPES[THREAT_MELEE]
--[[ enUS ]] dL[SHORT_THREAT_TYPES[THREAT_TANK]]	= SHORT_THREAT_TYPES[THREAT_TANK]
--[[ enUS ]] dL[SHORT_THREAT_TYPES[THREAT_GROUP]]	= SHORT_THREAT_TYPES[THREAT_GROUP]

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

-- long forms
--[[ koKR ]] dL[THREAT_RANGED]						= "Ranged"
--[[ koKR ]] dL[THREAT_MELEE]							= "Melee"
--[[ koKR ]] dL[THREAT_TANK]							= "Tank"
--[[ koKR ]] dL[THREAT_GROUP]							= "Group"

-- short forms
--[[ koKR ]] dL[SHORT_THREAT_TYPES[THREAT_RANGED]]	= "R"
--[[ koKR ]] dL[SHORT_THREAT_TYPES[THREAT_MELEE]]		= "M"
--[[ koKR ]] dL[SHORT_THREAT_TYPES[THREAT_TANK]]		= "T"
--[[ koKR ]] dL[SHORT_THREAT_TYPES[THREAT_GROUP]]		= "G"

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

-- long forms
--[[ ruRU ]] dL[THREAT_RANGED]						= "Дальний бой"
--[[ ruRU ]] dL[THREAT_MELEE]						= "Ближний бой"
--[[ ruRU ]] dL[THREAT_TANK]							= "Танк"
--[[ ruRU ]] dL[THREAT_GROUP]						= "Группа"

--[[ ruRU ]] dL[SHORT_THREAT_TYPES[THREAT_RANGED]]	= "Бб"
--[[ ruRU ]] dL[SHORT_THREAT_TYPES[THREAT_MELEE]]	= "Дб"
--[[ ruRU ]] dL[SHORT_THREAT_TYPES[THREAT_TANK]]		= "Т"
--[[ ruRU ]] dL[SHORT_THREAT_TYPES[THREAT_GROUP]]	= "Г"

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

-- long forms
--[[ zhCN ]] dL[THREAT_RANGED]						= "Ranged"
--[[ zhCN ]] dL[THREAT_MELEE]						= "Melee"
--[[ zhCN ]] dL[THREAT_TANK]							= "Tank"
--[[ zhCN ]] dL[THREAT_GROUP]						= "Group"

-- short forms
--[[ zhCN ]] dL[SHORT_THREAT_TYPES[THREAT_RANGED]]	= "R"
--[[ zhCN ]] dL[SHORT_THREAT_TYPES[THREAT_MELEE]]	= "M"
--[[ zhCN ]] dL[SHORT_THREAT_TYPES[THREAT_TANK]]		= "T"
--[[ zhCN ]] dL[SHORT_THREAT_TYPES[THREAT_GROUP]]	= "G"

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

-- long forms
--[[ zhTW ]] dL[THREAT_RANGED]						= "遠程"
--[[ zhTW ]] dL[THREAT_MELEE]						= "進戰"
--[[ zhTW ]] dL[THREAT_TANK]							= "坦克"
--[[ zhTW ]] dL[THREAT_GROUP]						= "隊伍"

-- short forms
--[[ zhTW ]] dL[SHORT_THREAT_TYPES[THREAT_RANGED]]	= "R"
--[[ zhTW ]] dL[SHORT_THREAT_TYPES[THREAT_MELEE]]	= "M"
--[[ zhTW ]] dL[SHORT_THREAT_TYPES[THREAT_TANK]]		= "T"
--[[ zhTW ]] dL[SHORT_THREAT_TYPES[THREAT_GROUP]]	= "G"

end)

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

AloftLocale.AloftThreatData = setmetatable(dL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
dL = nil

-----------------------------------------------------------------------------

end)
