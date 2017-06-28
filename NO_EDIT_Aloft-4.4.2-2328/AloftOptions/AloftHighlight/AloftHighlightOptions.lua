local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftHighlight
if not L then return end

local AloftHighlight = Aloft:GetModule("Highlight", true)
if not AloftHighlight then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.healthBar.args.highlight =
{
	type = 'group',
	name = L["Highlight"],
	desc = L["Mouseover highlight options"],
	order = -1,
	disabled = function(i) return not Aloft:IsEnabled() or not AloftHighlight:IsEnabled() or not AloftHighlight.db or not AloftHighlight.db.profile end,
	args =
	{
		color =
		{
			type = 'color',
			width = "full",
			name = L["Color"],
			desc = L["Sets the highlight color"],
			get = function(i) return unpack(AloftHighlight.db.profile.color) end,
			set = function(i, r, g, b, a) AloftHighlight.db.profile.color = { r, g, b, a } AloftHighlight:UpdateAll() end,
			hasAlpha = true
		},
		texture =
		{
			type = "select",
			width = "full",
			name = L["Texture"],
			desc = L["Sets the highlight texture"],
			get = function(i)
				for k, v in pairs(Aloft.Options.args.healthBar.args.highlight.args.texture.values) do
					if v == AloftHighlight.db.profile.texture then
						return k
					end
				end
			end,
			set = function(i, v)
				AloftHighlight.db.profile.texture = Aloft.Options.args.healthBar.args.highlight.args.texture.values[v]
				Aloft:DetermineDataSources() 
				AloftHighlight:UpdateAll()
			end,
			values = SML:List("statusbar"),
		},
		mode =
		{
			type = "select",
			width = "full",
			name = L["Blend Mode"],
			desc = L["Sets the blend mode for the highlight texture"],
			get = function(i) return AloftHighlight.db.profile.blendMode end,
			set = function(i, v) AloftHighlight.db.profile.blendMode = v AloftHighlight:UpdateAll() end,
			values = { ["BLEND"] = L["BLEND"], ["ADD"] = L["ADD"] },
		},
	},
}

-----------------------------------------------------------------------------
