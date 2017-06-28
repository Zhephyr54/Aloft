local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftSetAll
if not L then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

local lastSetFont = ""
local lastSetFontSize = 10
local lastSetBorder = ""
local lastSetTexture = ""

-----------------------------------------------------------------------------

Aloft.Options.args.setAll =
{
	type = 'group',
	name = L["Set All"],
	desc = L["Set all options"],
	disabled = function(i) return not Aloft:IsEnabled() end,
	order = 600,
	args =
	{
		fontSize =
		{
			type = 'range',
			width = 'full',
			name = L["Font Sizes"],
			desc = L["Sets the fonts size for all text in Aloft"],
			order = 1,
			max = 16,
			min = 4,
			step = 1,
			get = function(i) return lastSetFontSize end,
			set = function(i, v) if lastSetFontSize ~= v then lastSetFontSize = v Aloft:SendMessage("Aloft:SetAll", "fontSize", v) end end
		},
		font =
		{
			type = 'select',
			width = 'full',
			name = L["Fonts"],
			desc = L["Sets the font for all text in Aloft"],
			order = 2,
			get = function(i)
				for k, v in pairs(Aloft.Options.args.setAll.args.font.values) do
					if v == lastSetFont then
						return k
					end
				end
			end,
			set = function(i, v)
				lastSetFont = Aloft.Options.args.setAll.args.font.values[v]
				Aloft:SendMessage("Aloft:SetAll", "font", lastSetFont)
			end,
			values = SML:List("font"),
		},
		border =
		{
			type = 'select',
			width = 'full',
			name = L["Borders"],
			desc = L["Sets the border for all status bars in Aloft"],
			order = 4,
			get = function(i)
				for k, v in pairs(Aloft.Options.args.setAll.args.border.values) do
					if v == lastSetBorder then
						return k
					end
				end
			end,
			set = function(i, v)
				lastSetBorder = Aloft.Options.args.setAll.args.border.values[v]
				Aloft:SendMessage("Aloft:SetAll", "border", lastSetBorder)
			end,
			values = SML:List("border"),
		},
		texture =
		{
			type = 'select',
			width = 'full',
			name = L["Textures"],
			desc = L["Sets the texture for all status bars in Aloft"],
			order = 4,
			get = function(i)
				for k, v in pairs(Aloft.Options.args.setAll.args.texture.values) do
					if v == lastSetTexture then
						return k
					end
				end
			end,
			set = function(i, v)
				lastSetTexture = Aloft.Options.args.setAll.args.texture.values[v]
				Aloft:SendMessage("Aloft:SetAll", "texture", lastSetTexture)
			end,
			values = SML:List("statusbar"),
		},
	},
}

-----------------------------------------------------------------------------
