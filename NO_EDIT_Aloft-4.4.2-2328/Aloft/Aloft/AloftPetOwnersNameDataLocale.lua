local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local dL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

--[[ enUS ]] dL["PetTest"] = "(.*)'s Pet"
--[[ enUS ]] dL["MinionTest"] = "(.*)'s Minion"
--[[ enUS ]] dL["GuardianTest"] = "(.*)'s Guardian"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

--[[ koKR ]] dL["PetTest"] = "(.*)의 소환수"
--[[ koKR ]] dL["MinionTest"] = "(.*)의 하수인"
--[[ koKR ]] dL["GuardianTest"] = "(.*)'s Guardian"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] dL["PetTest"] = "Питомец |3-3((.*))"
--[[ ruRU ]] dL["MinionTest"] = "Прислужник |3-3((.*))"
--[[ ruRU ]] dL["GuardianTest"] = "(.*)'s Guardian"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] dL["PetTest"] = "(.*)的宠物"
--[[ zhCN ]] dL["MinionTest"] = "(.*)的仆从"
--[[ zhCN ]] dL["GuardianTest"] = "(.*)'s Guardian"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] dL["PetTest"] = "(.*)的寵物"
--[[ zhTW ]] dL["MinionTest"] = "(.*)的僕從"
--[[ zhTW ]] dL["GuardianTest"] = "(.*)的守護者"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

AloftLocale.AloftPetOwnersNameData = setmetatable(dL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
dL = nil

-----------------------------------------------------------------------------

end)
