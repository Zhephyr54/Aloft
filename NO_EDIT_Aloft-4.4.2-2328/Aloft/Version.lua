local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local MAJOR_VERSION = "4.4.2"
local MINOR_VERSION = ("$Revision: 435 $"):match("%d+") 
local locale = GetLocale()

Aloft.version = MAJOR_VERSION .. "-" .. MINOR_VERSION .. "-" .. locale

-----------------------------------------------------------------------------
