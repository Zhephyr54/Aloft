local Aloft = Aloft
if (not Aloft) then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftSetAll")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_statusbar = SML:List("statusbar")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

local lastSetTexture = ""
local lastSetFont = ""
local lastSetFontSize = 10

-----------------------------------------------------------------------------

Aloft.Options.args.setAll =
{
	type = 'group',
	name = L["Set All"],
	desc = L["Set all options"],
	disabled = function() return not Aloft:IsActive() end,
	order = 600,
	args =
	{
		texture =
		{
			type = "text",
			name = L["Textures"],
			desc = L["Sets the texture for all status bars in Aloft"],
			get = function() return lastSetTexture end,
			set = function(v)
				lastSetTexture = v
				Aloft:TriggerEvent("Aloft:SetAll", "texture", lastSetTexture)
			end,
			validate = SML_statusbar,
		},
		font =
		{
			type = "text",
			name = L["Fonts"],
			desc = L["Sets the font for all text in Aloft"],
			get = function() return lastSetTexture end,
			set = function(v)
				lastSetFont = v
				Aloft:TriggerEvent("Aloft:SetAll", "font", lastSetFont)
			end,
			validate = SML_font,
		},
		fontSize =
		{
			type = 'range',
			name = L["Font Sizes"],
			desc = L["Sets the fonts size for all text in Aloft"],
			max = 16,
			min = 4,
			step = 1,
			get = function() return lastSetFontSize end,
			set = function(v) if lastSetFontSize ~= v then lastSetFontSize = v Aloft:TriggerEvent("Aloft:SetAll", "fontSize", v) end end
		},
	}
}

-----------------------------------------------------------------------------
