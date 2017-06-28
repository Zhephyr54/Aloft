local Aloft = Aloft
if not Aloft or not AceLibrary:HasInstance("Waterfall-1.0") then return end

---------------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftWaterfall")
local waterfall = AceLibrary("Waterfall-1.0")
local dewdrop = AceLibrary:HasInstance("Dewdrop-2.0") and AceLibrary("Dewdrop-2.0")
local locale = GetLocale()

---------------------------------------------------------------------------------

local AloftWaterfall = AceLibrary("AceAddon-2.0"):new()

function AloftWaterfall:OnInitialize()
	waterfall:Register("Aloft",
					   "title", L["Aloft"] .. " " .. tostring(Aloft.version .. " (" .. locale .. ")"),
					   "aceOptions", Aloft.Options,
					   "treeType","TREE",
					   "colorR", 0.26, "colorG", 0.41, "colorB", 0.57
					   )
end

---------------------------------------------------------------------------------
