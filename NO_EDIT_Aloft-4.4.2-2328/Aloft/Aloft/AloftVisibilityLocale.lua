local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local dL = { }

local oT = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] dL["Critter"] = "Critter"

-----------------------------------------------------------------------------

--[[ enUS ]] oT["Tremor Totem"] = "Tremor Totem"
--[[ enUS ]] oT["Grounding Totem"] = "Grounding Totem"
--[[ enUS ]] oT["Earthbind Totem"] = "Earthbind Totem"
--[[ enUS ]] oT["Cleansing Totem"] = "Cleansing Totem"
--[[ enUS ]] oT["Mana Tide Totem"] = "Mana Tide Totem"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "deDE") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

--[[ deDE ]] oT["Tremor Totem"]		= "Totem des Erdstoßes"
--[[ deDE ]] oT["Grounding Totem"]	= "Totem der Erdung"
--[[ deDE ]] oT["Earthbind Totem"]	= "Totem der Erdbindung"
--[[ deDE ]] oT["Cleansing Totem"]	= "Totem der Reinigung"
--[[ deDE ]] oT["Mana Tide Totem"]	= "Totem der Manaflut"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "frFR") then

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

--[[ frFR ]] oT["Tremor Totem"] = "Totem de séisme"
--[[ frFR ]] oT["Grounding Totem"] = "Totem de glèbe"
--[[ frFR ]] oT["Earthbind Totem"] = "Totem de lien terrestre"
--[[ frFR ]] oT["Cleansing Totem"] = "Totem de purification"
--[[ frFR ]] oT["Mana Tide Totem"] = "Totem de vague de mana"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

--[[ koKR ]] dL["Critter"]	= "동물"

-----------------------------------------------------------------------------

-- TODO: need koKR translation for oT

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] dL["Critter"] = "Существо"

-----------------------------------------------------------------------------

-- TODO: need ruRU translation for oT

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] dL["Critter"]	= "小动目"

-----------------------------------------------------------------------------

-- TODO: need zhCN translation for oT

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] dL["Critter"]	= "小動物"

-----------------------------------------------------------------------------

--[[ zhTW ]] oT["Tremor Totem"] = "戰慄圖騰"
--[[ zhTW ]] oT["Grounding Totem"] = "根基圖騰"
--[[ zhTW ]] oT["Earthbind Totem"] = "地縛圖騰"
--[[ zhTW ]] oT["Cleansing Totem"] = "祛病圖騰"
--[[ zhTW ]] oT["Mana Tide Totem"] = "法力之潮圖騰"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

AloftLocale.AloftVisibilityData = setmetatable(dL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
dL = nil

-----------------------------------------------------------------------------

AloftLocale.AloftVisibilityTotems = setmetatable(oT, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
oT = nil

-----------------------------------------------------------------------------

end)
