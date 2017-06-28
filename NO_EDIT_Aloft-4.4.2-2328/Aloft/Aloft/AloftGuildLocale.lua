local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local sL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] sL[" [Aa][Nn][Dd] "]	= " & "
--[[ enUS ]] sL[" [Oo][Ff] "]		= " of "		-- Forces shortened form "o" to go lower case
--[[ enUS ]] sL[" [Oo][Nn] "]		= " on "		-- Forces shortened form "o" to go lower case
--[[ enUS ]] sL[" [Tt][Hh][Ee] "]	= " the "
--[[ enUS ]] sL[" [Ii][Nn] "]		= " in "

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

--[[ koKR ]] sL[" [Aa][Nn][Dd] "]	= " & "
--[[ koKR ]] sL[" [Oo][Ff] "]		= " of "		-- Forces shortened form "o" to go lower case
--[[ koKR ]] sL[" [Oo][Nn] "]		= " on "		-- Forces shortened form "o" to go lower case
--[[ koKR ]] sL[" [Tt][Hh][Ee] "]	= " the "
--[[ koKR ]] sL[" [Ii][Nn] "]		= " in "

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] sL[" [Aa][Nn][Dd] "]	= " & "
--[[ ruRU ]] sL[" [Oo][Ff] "]		= " - "		-- Forces shortened form "o" to go lower case
--[[ ruRU ]] sL[" [Oo][Nn] "]		= " on "		-- Forces shortened form "o" to go lower case
--[[ ruRU ]] sL[" [Tt][Hh][Ee] "]	= " "
--[[ ruRU ]] sL[" [Ii][Nn] "]		= " в "

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] sL[" [Aa][Nn][Dd] "]	= " & "
--[[ zhCN ]] sL[" [Oo][Ff] "]		= " of "		-- Forces shortened form "o" to go lower case
--[[ zhCN ]] sL[" [Oo][Nn] "]		= " on "		-- Forces shortened form "o" to go lower case
--[[ zhCN ]] sL[" [Tt][Hh][Ee] "]	= " the "
--[[ zhCN ]] sL[" [Ii][Nn] "]		= " in "

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] sL[" [Aa][Nn][Dd] "]	= " & "
--[[ zhTW ]] sL[" [Oo][Ff] "]		= " of "		-- Forces shortened form "o" to go lower case
--[[ zhTW ]] sL[" [Oo][Nn] "]		= " on "		-- Forces shortened form "o" to go lower case
--[[ zhTW ]] sL[" [Tt][Hh][Ee] "]	= " the "
--[[ zhTW ]] sL[" [Ii][Nn] "]		= " in "

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

AloftLocale.AloftShortGuildData = setmetatable(sL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
sL = nil

-----------------------------------------------------------------------------

end)

