local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftCastWarning = Aloft:HasModule("CastWarning") and Aloft:GetModule("CastWarning")

local MAJOR_VERSION = "0.7.9"
local MINOR_VERSION = ("$Revision$"):match("%d+")
local locale = GetLocale()

AloftCastWarning.version = MAJOR_VERSION .. "." .. MINOR_VERSION .. "-" .. locale

-----------------------------------------------------------------------------
