local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftManaTextOptions
if not L then return end

local AloftManaText = Aloft:GetModule("ManaText", true)
if not AloftManaText then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

local manaTags =
{
	NONE			= { "", "" },
	PERCENT			= { "[ManaFraction:Percent]", "[ManaFraction:Percent:PowerTypeColor]" },
	MANA			= { "[Mana:Short]", "[Mana:Short:PowerTypeColor]" },
	MANAANDPERCENT	= {
						"[Mana:Short][ManaFraction:Percent:Surround(\" (\", \")\")]",
						"[Mana:Short:PowerTypeColor][ManaFraction:Percent:Surround(\" (\", \")\"):PowerTypeColor]",
					},
	DEFICIT			= { "[ManaDeficit:HideZero:Short]", "[ManaDeficit:HideZero:Short:PowerTypeColor]" },
	FULL			= {
						"[Mana:Short:Suffix(\"/\")][MaxMana:Short:Suffix(\" (\")][ManaFraction:Percent:Surround(\" (\", \")\")]",
						"[Mana:Short:Suffix(\"/\"):PowerTypeColor][MaxMana:Short:PowerTypeColor][ManaFraction:Percent:Surround(\" (\", \")\"):PowerTypeColor]"
					},
}

-----------------------------------------------------------------------------

Aloft.Options.args.manaBar.args.manaText = 
{
	type = 'group',
	name = L["Mana Text"],
	desc = L["Mana text options"],
	disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ManaData", true) and Aloft:GetModule("ManaData"):IsEnabled()) or not AloftManaText:IsEnabled() or not AloftManaText.db or not AloftManaText.db.profile end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show mana text on group member nameplates"],
			get = function(i) return AloftManaText.db.profile.enable end,
			set = function(i, v) AloftManaText.db.profile.enable = v AloftManaText:UpdateTag() AloftManaText:UpdateAll() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Mana text typeface options"],
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ManaData", true) and Aloft:GetModule("ManaData"):IsEnabled()) or not AloftManaText:IsEnabled() or not AloftManaText.db or not AloftManaText.db.profile or not AloftManaText.db.profile.enable end,
			args =
			{
				font =
				{
					type = 'select',
					width = 'full',
					name = L["Font"],
					desc = L["Sets the font for mana text"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.manaBar.args.manaText.args.typeface.args.font.values) do
							if v == AloftManaText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftManaText.db.profile.font = Aloft.Options.args.manaBar.args.manaText.args.typeface.args.font.values[v]
						AloftManaText:UpdateAll()
					end,
					values = SML:List("font"),
				},
				fontSize =
				{
					type = 'range',
					width = 'full',
					name = L["Font Size"],
					desc = L["Sets the font height of the mana text"],
					max = 16,
					min = 5,
					step = 1,
					get = function(i) return AloftManaText.db.profile.fontSize end,
					set = function(i, value) AloftManaText.db.profile.fontSize = value AloftManaText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					width = 'full',
					name = L["Font Shadow"],
					desc = L["Show font shadow on mana text"],
					get = function(i) return AloftManaText.db.profile.shadow end,
					set = function(i, v) AloftManaText.db.profile.shadow = v AloftManaText:UpdateAll() end
				},
				outline =
				{
					type = 'select',
					width = 'full',
					name = L["Outline"],
					desc = L["Sets the outline for mana text"],
					get = function(i) return AloftManaText.db.profile.outline end,
					set = function(i, value) AloftManaText.db.profile.outline = value AloftManaText:UpdateAll() end,
					values = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		colorByType =
		{
			type = 'toggle',
			width = 'full',
			name = L["Color by type"],
			desc = L["Color text differently for mana, energy, rage"],
			disabled = function(i) return not AloftManaText.db.profile.enable end,
			get = function(i) return AloftManaText.db.profile.colorByType end,
			set = function(i, value) AloftManaText.db.profile.colorByType = value AloftManaText:UpdateTag() AloftManaText:UpdateAll() end,
		},
		mode =
		{
			type = 'select',
			width = 'full',
			name = L["Mode"],
			desc = L["Choose what to show for mana text"],
			disabled = function(i) return not AloftManaText.db.profile.enable end,
			get = function(i) return AloftManaText.db.profile.mode end,
			set = function(i, value) AloftManaText.db.profile.mode = value AloftManaText:UpdateTag() AloftManaText:UpdateAll() end,
			values = { PERCENT = L["Percent"], MANA = L["Mana"], MANAANDPERCENT = L["Mana & Percent"], DEFICIT = L["Deficit"], FULL = L["Full"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust mana text position"],
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ManaData", true) and Aloft:GetModule("ManaData"):IsEnabled()) or not AloftManaText:IsEnabled() or not AloftManaText.db or not AloftManaText.db.profile or not AloftManaText.db.profile.enable end,
			args =
			{
				anchor = {
					type = 'select',
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the mana text"],
					get = function(i) return AloftManaText.db.profile.point end,
					set = function(i, v) AloftManaText.db.profile.point = v AloftManaText:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = 'select',
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the mana text"],
					get = function(i) return AloftManaText.db.profile.relativeToPoint end,
					set = function(i, v) AloftManaText.db.profile.relativeToPoint = v AloftManaText:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the mana text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftManaText.db.profile.offsetX end,
					set = function(i, v) AloftManaText.db.profile.offsetX = v AloftManaText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the mana text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftManaText.db.profile.offsetY end,
					set = function(i, v) AloftManaText.db.profile.offsetY = v AloftManaText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			width = 'full',
			name = L["Alpha"],
			desc = L["Sets the alpha of the mana text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function(i) return not AloftManaText.db.profile.enable end,
			get = function(i) return AloftManaText.db.profile.alpha end,
			set = function(i, v) AloftManaText.db.profile.alpha = v AloftManaText:UpdateAll() end
		},
		color =
		{
			type = 'color',
			width = 'full',
			name = L["Color"],
			desc = L["Sets the mana text color"],
			disabled = function(i) return not AloftManaText.db.profile.enable end,
			get = function(i) return unpack(AloftManaText.db.profile.color) end,
			set = function(i, r, g, b, a) AloftManaText.db.profile.color = { r, g, b, a } AloftManaText:UpdateAll() end,
		},
		advanced  =
		{
			type = 'group',
			width = 'full',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ManaData", true) and Aloft:GetModule("ManaData"):IsEnabled()) or not AloftManaText:IsEnabled() or not AloftManaText.db or not AloftManaText.db.profile or not AloftManaText.db.profile.enable end,
			args =
			{
				format =
				{
					type = 'input',
					width = 'full',
					name = L["Format"],
					desc = L["Mana tag"],
					usage = L["<Any tag string>"],
					get = function(i) return Aloft:HighlightTagSyntax(AloftManaText.db.profile.format) end,
					set =	function(i, v)
								AloftManaText.db.profile.format = Aloft:FixTagCasing(v)
								AloftManaText.textMethodData = nil
								AloftManaText.textMethod = nil
								Aloft:DetermineDataSources()
								AloftManaText:UpdateAll()
							end,
				}
			},
		},
		--[[
		always =
		{
			type = 'toggle',
			name = L["Always Show Target"],
			desc = L["Always show mana text on active targets in combat"],
			get = function(i) return AloftManaText.db.profile.always end,
			set = function(i, v) AloftManaText.db.profile.always = v Aloft:DetermineDataSources() AloftManaText:UpdateAll() end,
			disabled = function(i) return not AloftManaText.db.profile.enable end,
			order = 2,
		},
		]]
	},
}

-----------------------------------------------------------------------------

function AloftManaText:UpdateTag()
	local tag = self.db.profile.mode
	local index = 1

	if self.db.profile.colorByType then
		index = 2
	end

	if not self.db.profile.enable then tag = "NONE"	end
	self.db.profile.format = manaTags[tag][index]

	self.textMethodData = nil
	self.textMethod = nil

	Aloft:DetermineDataSources()
end

-----------------------------------------------------------------------------

end)
