local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftHealthText
if not L then return end

local AloftHealthText = Aloft:GetModule("HealthText")
if not AloftHealthText then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

local healthTags =
{
	NONE				= "",
	PERCENT				= "[HealthFraction:Percent]",
	GROUPHEALTH 		= "[IsGroup:HealthBarValue:Short]",
	GROUPHEALTHDEFICIT	= "[IsGroup:HealthBarDeficit:HideZero:Negate:Short]",
	HEALTH				= "[Select(Health, Health:Short, HealthFraction:Percent)]",
	HEALTHANDPERCENT	= "[Health:Short:Suffix(\" (\")][HealthFraction:Percent][Health:\")\"]",
	FULL				= "[Health:Short:Suffix(\"/\")][MaxHealth:Short:Suffix(\" \")][Health:\"(\"][HealthFraction:Percent][Health:\")\"]",
	SMART				= "[Select(IsFriendly, HealthDeficit:Negate:HideZero:Short:HexColor(\"ff8080\"), Select(Health, Health:Short, HealthFraction:Percent))]",
}

-----------------------------------------------------------------------------

Aloft.Options.args.healthBar.args.healthText =
{
	type = 'group',
	name = L["Health Text"],
	desc = L["Health text options"],
	order = -1,
	disabled = function(i) return not Aloft:IsEnabled() or not AloftHealthText:IsEnabled() or not AloftHealthText.db or not AloftHealthText.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show health text on nameplates"],
			get = function(i) return AloftHealthText.db.profile.enable end,
			set = function(i, v) AloftHealthText.db.profile.enable = v AloftHealthText:UpdateTag() AloftHealthText:UpdateAll() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Health text typeface options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftHealthText:IsEnabled() or not AloftHealthText.db or not AloftHealthText.db.profile or not AloftHealthText.db.profile.enable end,
			args =
			{
				font =
				{
					type = 'select',
					width = 'full',
					name = L["Font"],
					desc = L["Sets the font for health text"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.healthBar.args.healthText.args.typeface.args.font.values) do
							if v == AloftHealthText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftHealthText.db.profile.font = Aloft.Options.args.healthBar.args.healthText.args.typeface.args.font.values[v]
						AloftHealthText:UpdateAll()
					end,
					values = SML:List("font"),
				},
				fontSize =
				{
					type = 'range',
					width = 'full',
					name = L["Font Size"],
					desc = L["Sets the font height of the health text"],
					max = 16,
					min = 5,
					step = 1,
					get = function(i) return AloftHealthText.db.profile.fontSize end,
					set = function(i, value) AloftHealthText.db.profile.fontSize = value AloftHealthText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					width = 'full',
					name = L["Font Shadow"],
					desc = L["Show font shadow on health text"],
					get = function(i) return AloftHealthText.db.profile.shadow end,
					set = function(i, v) AloftHealthText.db.profile.shadow = v AloftHealthText:UpdateAll() end
				},
				outline =
				{
					type = 'select',
					width = 'full',
					name = L["Outline"],
					desc = L["Sets the outline for health text"],
					get = function(i) return AloftHealthText.db.profile.outline end,
					set = function(i, value) AloftHealthText.db.profile.outline = value AloftHealthText:UpdateAll() end,
					values = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		mode =
		{
			type = 'select',
			width = 'full',
			name = L["Mode"],
			desc = L["Choose what to show for health text"],
			disabled = function(i) return not AloftHealthText.db.profile.enable end,
			get = function(i) return AloftHealthText.db.profile.mode end,
			set = function(i, value) AloftHealthText.db.profile.mode = value AloftHealthText:UpdateTag() AloftHealthText:UpdateAll() end,
			values = { PERCENT = L["Percent"], GROUPHEALTH = L["Group Health"], GROUPHEALTHDEFICIT = L["Group Health Deficit"], HEALTH = L["Health"], HEALTHANDPERCENT = L["Health & Percent"], FULL = L["Full"], SMART = L["Smart"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust health text position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftHealthText:IsEnabled() or not AloftHealthText.db or not AloftHealthText.db.profile or not AloftHealthText.db.profile.enable end,
			args =
			{
				anchor = {
					type = 'select',
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the health text"],
					get = function(i) return AloftHealthText.db.profile.point end,
					set = function(i, v) AloftHealthText.db.profile.point = v AloftHealthText:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = 'select',
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the health text"],
					get = function(i) return AloftHealthText.db.profile.relativeToPoint end,
					set = function(i, v) AloftHealthText.db.profile.relativeToPoint = v AloftHealthText:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the health text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftHealthText.db.profile.offsetX end,
					set = function(i, v) AloftHealthText.db.profile.offsetX = v AloftHealthText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the health text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftHealthText.db.profile.offsetY end,
					set = function(i, v) AloftHealthText.db.profile.offsetY = v AloftHealthText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			width = 'full',
			name = L["Alpha"],
			desc = L["Sets the alpha of the health text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function(i) return not AloftHealthText.db.profile.enable end,
			get = function(i) return AloftHealthText.db.profile.alpha end,
			set = function(i, v) AloftHealthText.db.profile.alpha = v AloftHealthText:UpdateAll() end
		},
		color =
		{
			type = 'color',
			width = 'full',
			name = L["Color"],
			desc = L["Sets the health text color"],
			disabled = function(i) return not AloftHealthText.db.profile.enable end,
			get = function(i) return unpack(AloftHealthText.db.profile.color) end,
			set = function(i, r, g, b, a) AloftHealthText.db.profile.color = { r, g, b, a } AloftHealthText:UpdateAll() end,
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftHealthText:IsEnabled() or not AloftHealthText.db or not AloftHealthText.db.profile or not AloftHealthText.db.profile.enable end,
			args =
			{
				format =
				{
					type = 'input',
					width = 'full',
					name = L["Format"],
					desc = L["Health tag"],
					usage = L["<Any tag string>"],
					get = function(i) return Aloft:HighlightTagSyntax(AloftHealthText.db.profile.format) end,
					set =	function(i, v)
								AloftHealthText.db.profile.format = Aloft:FixTagCasing(v)
								AloftHealthText.textMethodData = nil
								AloftHealthText.textMethod = nil
								Aloft:DetermineDataSources()
								AloftHealthText:UpdateAll()
							end,
				}
			},
		},
	},
}

-----------------------------------------------------------------------------

function AloftHealthText:UpdateTag()
	local tag = self.db.profile.mode
	if not self.db.profile.enable then tag = "NONE" end
	self.db.profile.format = healthTags[tag]

	self.textMethodData = nil
	self.textMethod = nil

	Aloft:DetermineDataSources()
end

-----------------------------------------------------------------------------

end)
