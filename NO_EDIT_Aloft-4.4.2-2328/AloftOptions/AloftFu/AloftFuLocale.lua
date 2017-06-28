local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] mL["AloftFu"] = "AloftFu"
--[[ enUS ]] mL["Provide a FuBar interface for Aloft"] = "Provide a FuBar interface for Aloft"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftFu"] = "AloftFu"
--[[ koKR ]] mL["Provide a FuBar interface for Aloft"] = "Provide a FuBar interface for Aloft"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftFu"] = "AloftFu"
--[[ ruRU ]] mL["Provide a FuBar interface for Aloft"] = "Обеспечивать интерфейсов Aloftа FuBar"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftFu"] = "FuBar支持"
--[[ zhCN ]] mL["Provide a FuBar interface for Aloft"] = "为Aloft提供Fubar支持"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftFu"] = "AloftFuBar"
--[[ zhTW ]] mL["Provide a FuBar interface for Aloft"] = "為Aloft提供Fubar支援"

-----------------------------------------------------------------------------

end
