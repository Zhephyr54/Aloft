local Aloft = Aloft
if not Aloft or not AceLibrary:HasInstance("Waterfall-1.0") then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftWaterfall")
local waterfall = AceLibrary("Waterfall-1.0")
local dewdrop = AceLibrary:HasInstance("Dewdrop-2.0") and AceLibrary("Dewdrop-2.0")

---------------------------------------------------------------------------------

Aloft.Options.args.waterfall =
{
	type = "execute",
	name = L["GUI Configuration"],
	desc = L["Opens the Waterfall GUI configuration menu"],
	order = 400,
	func = function() Aloft:LoadOptions() waterfall:Open("Aloft") if dewdrop then dewdrop:Close() end end,
	disabled = function() return waterfall:IsOpen("Aloft") end,
	guiHidden = true,
}

---------------------------------------------------------------------------------
