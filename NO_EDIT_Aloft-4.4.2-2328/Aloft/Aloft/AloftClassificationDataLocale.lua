local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local dL = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] dL["rare"]				= "Rare"
--[[ enUS ]] dL["elite"]			= "Elite"
--[[ enUS ]] dL["rareelite"]		= "Rare-Elite"
--[[ enUS ]] dL["worldboss"]		= "Boss"

--[[ enUS ]] dL["shortrare"]		= "r"
--[[ enUS ]] dL["shortelite"]		= "+"
--[[ enUS ]] dL["shortrareelite"]	= "r+"
--[[ enUS ]] dL["shortworldboss"]	= "b"

--[[ enUS ]] dL["Unknown"]			= "Unknown" -- unit name for "Unknown" units

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] dL["rare"]				= "희귀"
--[[ koKR ]] dL["elite"]			= "정예"
--[[ koKR ]] dL["rareelite"]		= "희귀-정예"
--[[ koKR ]] dL["worldboss"]		= "보스"

--[[ koKR ]] dL["shortrare"]		= "r"
--[[ koKR ]] dL["shortelite"]		= "+"
--[[ koKR ]] dL["shortrareelite"]	= "r+"
--[[ koKR ]] dL["shortworldboss"]	= "b"

--[[ koKR ]] dL["Unknown"]			= "Unknown" -- unit name for "Unknown" units

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] dL["rare"]				= "Редкий"
--[[ ruRU ]] dL["elite"]			= "Элита"
--[[ ruRU ]] dL["rareelite"]		= "Редкий-Элита"
--[[ ruRU ]] dL["worldboss"]		= "Босс"

--[[ ruRU ]] dL["shortrare"]		= "р"
--[[ ruRU ]] dL["shortelite"]		= "+"
--[[ ruRU ]] dL["shortrareelite"]	= "р+"
--[[ ruRU ]] dL["shortworldboss"]	= "б"

--[[ ruRU ]] dL["Unknown"]			= "Unknown" -- unit name for "Unknown" units

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] dL["rare"]				= "稀有"
--[[ zhCN ]] dL["elite"]			= "精英"
--[[ zhCN ]] dL["rareelite"]		= "稀有精英"
--[[ zhCN ]] dL["worldboss"]		= "首领"

--[[ zhCN ]] dL["shortrare"]		= "-"
--[[ zhCN ]] dL["shortelite"]		= "+"
--[[ zhCN ]] dL["shortrareelite"]	= "++"
--[[ zhCN ]] dL["shortworldboss"]	= "boss"

--[[ zhCN ]] dL["Unknown"]			= "Unknown" -- unit name for "Unknown" units

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] dL["rare"]				= "稀有"
--[[ zhTW ]] dL["elite"]			= "精英"
--[[ zhTW ]] dL["rareelite"]		= "稀有-精英"
--[[ zhTW ]] dL["worldboss"]		= "首領"

--[[ zhTW ]] dL["shortrare"]		= "稀"
--[[ zhTW ]] dL["shortelite"]		= "+"
--[[ zhTW ]] dL["shortrareelite"]	= "稀+"
--[[ zhTW ]] dL["shortworldboss"]	= "首"

--[[ zhTW ]] dL["Unknown"]			= "未知" -- unit name for "Unknown" units

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftClassificationData = setmetatable(dL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
dL = nil
