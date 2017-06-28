local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local MAJOR_VERSION = "2.8.15"
local MINOR_VERSION = ("$Revision$"):match("%d+") 
local locale = GetLocale()

Aloft.version = MAJOR_VERSION .. "-" .. MINOR_VERSION .. "-" .. locale

-----------------------------------------------------------------------------
