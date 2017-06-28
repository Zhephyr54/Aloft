local Aloft = Aloft
if not Aloft or not Aloft:HasModule("Highlight") then return end

-----------------------------------------------------------------------------

local AloftHighlight = Aloft:GetModule("Highlight")
local L = AceLibrary("AceLocale-2.2"):new("AloftHighlightOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_statusbar = SML:List("statusbar")

-----------------------------------------------------------------------------

Aloft.Options.args.healthBar.args.highlight =
{
	type = 'group',
	name = L["Highlight"],
	desc = L["Mouseover highlight options"],
	disabled = function() return not Aloft:IsActive() end,
	order = -1,
	args =
	{
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the highlight color"],
			get = function() return unpack(AloftHighlight.db.profile.color) end,
			set = function(r, g, b, a) AloftHighlight.db.profile.color = { r, g, b, a } AloftHighlight:UpdateAll() end,
			hasAlpha = true
		},
		texture =
		{
			type = "text",
			name = L["Texture"],
			desc = L["Sets the highlight texture"],
			get = function() return AloftHighlight.db.profile.texture end,
			set = function(v)
				AloftHighlight.db.profile.texture = v
				AloftHighlight:UpdateAll()
			end,
			validate = SML_statusbar,
		},
		mode =
		{
			type = "text",
			name = L["Blend Mode"],
			desc = L["Sets the blend mode for the highlight texture"],
			get = function() return AloftHighlight.db.profile.blendMode end,
			set = function(v) AloftHighlight.db.profile.blendMode = v AloftHighlight:UpdateAll() end,
			validate = { ["BLEND"] = L["BLEND"], ["ADD"] = L["ADD"] },
		},
	},
}

-----------------------------------------------------------------------------
