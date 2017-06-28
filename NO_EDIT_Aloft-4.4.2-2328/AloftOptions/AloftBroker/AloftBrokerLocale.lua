local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] mL["AloftLDB"] = "AloftLDB"
--[[ enUS ]] mL["Provide a LibDataBroker-1.1 interface for Aloft"] = "Provide a LibDataBroker-1.1 interface for Aloft"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftLDB"] = "AloftLDB"
--[[ koKR ]] mL["Provide a LibDataBroker-1.1 interface for Aloft"] = "Provide a LibDataBroker-1.1 interface for Aloft"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftLDB"] = "AloftLDB"
--[[ ruRU ]] mL["Provide a LibDataBroker-1.1 interface for Aloft"] = "беспечивать интерфейсов Aloftа LibDataBroker-1.1"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftLDB"] = "LDB支持"
--[[ zhCN ]] mL["Provide a LibDataBroker-1.1 interface for Aloft"] = "为Aloft提供LibDataBroker支持"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftLDB"] = "AloftLDB"
--[[ zhTW ]] mL["Provide a LibDataBroker-1.1 interface for Aloft"] = "為Aloft提供LibDataBroker-1.1介面"

-----------------------------------------------------------------------------

end
