local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftStackedPointsText", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("StackedPointsText") then return end

local AloftStackedPointsText = Aloft:GetModule("StackedPointsText")
local L = AceLibrary("AceLocale-2.2"):new("AloftStackedPointsTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

Aloft.Options.args.stackedPointsText =
{
	type = 'group',
	name = L["Stacked Points Text"],
	desc = L["Stacked points (combo point/lacerate/sunder) text options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show stacked points text"],
			get = function() return AloftStackedPointsText.db.profile.enable end,
			set = function(v) AloftStackedPointsText.db.profile.enable = v AloftStackedPointsText:Update() end,
			order = 1
		},
		interval =
		{
			type = 'range',
			name = L["Stacked Points Update Interval"],
			desc = L["The amount of time, in seconds, between updates (0.0 is as fast as possible"],
			min = 0.0,
			max = 5.0,
			step = 0.01,
			disabled = function() return not AloftStackedPointsText.db.profile.enable end,
			get = function() return AloftStackedPointsText.db.profile.interval end,
			set = function(v) AloftStackedPointsText.db.profile.interval = v AloftStackedPointsText:Update() end,
			order = 2,
		},
		color =
		{
			type = 'group',
			name = L["Color"],
			desc = L["Sets the stacked points text color"],
			order = 3,
			disabled = function() return not AloftStackedPointsText.db.profile.enable end,
			args =
			{
				maxColor =
				{
					type = 'color',
					name = L["Max Color"],
					desc = L["Sets the stacked points text color (maximum debuff time left)"],
					get = function() return unpack(AloftStackedPointsText.db.profile.color) end,
					set = function(r, g, b, a) AloftStackedPointsText.db.profile.color = { r, g, b, a } AloftStackedPointsText:Update() end,
					hasAlpha = true
				},
				minColor =
				{
					type = 'color',
					name = L["Min Color"],
					desc = L["Sets the stacked points text color (minimum debuff time left)"],
					order = 3,
					get = function() return unpack(AloftStackedPointsText.db.profile.minColor) end,
					set = function(r, g, b, a) AloftStackedPointsText.db.profile.minColor = { r, g, b, a } AloftStackedPointsText:Update() end,
					hasAlpha = true
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust stacked points text position"],
			order = 4,
			disabled = function() return not AloftStackedPointsText.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the stacked points text"],
					get = function() return AloftStackedPointsText.db.profile.point end,
					set = function(v) AloftStackedPointsText.db.profile.point = v AloftStackedPointsText:Update() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the stacked points text"],
					get = function() return AloftStackedPointsText.db.profile.relativeToPoint end,
					set = function(v) AloftStackedPointsText.db.profile.relativeToPoint = v AloftStackedPointsText:Update() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the stacked points text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftStackedPointsText.db.profile.offsetX end,
					set = function(v) AloftStackedPointsText.db.profile.offsetX = v AloftStackedPointsText:Update() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the stacked points text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftStackedPointsText.db.profile.offsetY end,
					set = function(v) AloftStackedPointsText.db.profile.offsetY = v AloftStackedPointsText:Update() end
				},
			},
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Stacked points text typeface options"],
			order = 5,
			disabled = function() return not AloftStackedPointsText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for stacked points text"],
					get = function() return AloftStackedPointsText.db.profile.font end,
					set = function(v)
						AloftStackedPointsText.db.profile.font = v
						AloftStackedPointsText:Update()
					end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the stacked points text"],
					max = 40,
					min = 5,
					step = 1,
					get = function() return AloftStackedPointsText.db.profile.fontSize end,
					set = function(value) AloftStackedPointsText.db.profile.fontSize = value AloftStackedPointsText:Update() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on stacked points text"],
					get = function() return AloftStackedPointsText.db.profile.shadow end,
					set = function(v) AloftStackedPointsText.db.profile.shadow = v AloftStackedPointsText:Update() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline for stacked points text"],
					get = function() return AloftStackedPointsText.db.profile.outline end,
					set = function(value) AloftStackedPointsText.db.profile.outline = value AloftStackedPointsText:Update() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
	},
}

-----------------------------------------------------------------------------

end)
