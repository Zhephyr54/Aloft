local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

local AloftManaText = Aloft:GetModule("ManaText")
local L = AceLibrary("AceLocale-2.2"):new("AloftManaTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

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
	disabled = function() return not Aloft:IsActive() end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show mana text on group member nameplates"],
			get = function() return AloftManaText.db.profile.enable end,
			set = function(v) AloftManaText.db.profile.enable = v AloftManaText:UpdateTag() AloftManaText:UpdateAll() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Mana text typeface options"],
			disabled = function() return not AloftManaText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for mana text"],
					get = function() return AloftManaText.db.profile.font end,
					set = function(v)
						AloftManaText.db.profile.font = v
						AloftManaText:UpdateAll()
					end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the mana text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftManaText.db.profile.fontSize end,
					set = function(value) AloftManaText.db.profile.fontSize = value AloftManaText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on mana text"],
					get = function() return AloftManaText.db.profile.shadow end,
					set = function(v) AloftManaText.db.profile.shadow = v AloftManaText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the outline for mana text"],
					get = function() return AloftManaText.db.profile.outline end,
					set = function(value) AloftManaText.db.profile.outline = value AloftManaText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		colorByType =
		{
			type = 'toggle',
			name = L["Color by type"],
			desc = L["Color text differently for mana, energy, rage"],
			disabled = function() return not AloftManaText.db.profile.enable end,
			get = function() return AloftManaText.db.profile.colorByType end,
			set = function(value) AloftManaText.db.profile.colorByType = value AloftManaText:UpdateTag() AloftManaText:UpdateAll() end,
		},
		mode =
		{
			type = 'text',
			name = L["Mode"],
			desc = L["Choose what to show for mana text"],
			disabled = function() return not AloftManaText.db.profile.enable end,
			get = function() return AloftManaText.db.profile.mode end,
			set = function(value) AloftManaText.db.profile.mode = value AloftManaText:UpdateTag() AloftManaText:UpdateAll() end,
			validate = { PERCENT = L["Percent"], MANA = L["Mana"], MANAANDPERCENT = L["Mana & Percent"], DEFICIT = L["Deficit"], FULL = L["Full"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust mana text position"],
			disabled = function() return not AloftManaText.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the mana text"],
					get = function() return AloftManaText.db.profile.point end,
					set = function(v) AloftManaText.db.profile.point = v AloftManaText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the mana text"],
					get = function() return AloftManaText.db.profile.relativeToPoint end,
					set = function(v) AloftManaText.db.profile.relativeToPoint = v AloftManaText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the mana text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftManaText.db.profile.offsetX end,
					set = function(v) AloftManaText.db.profile.offsetX = v AloftManaText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the mana text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftManaText.db.profile.offsetY end,
					set = function(v) AloftManaText.db.profile.offsetY = v AloftManaText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the alpha of the mana text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftManaText.db.profile.enable end,
			get = function() return AloftManaText.db.profile.alpha end,
			set = function(v) AloftManaText.db.profile.alpha = v AloftManaText:UpdateAll() end
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the mana text color"],
			disabled = function() return not AloftManaText.db.profile.enable end,
			get = function() return unpack(AloftManaText.db.profile.color) end,
			set = function(r, g, b, a) AloftManaText.db.profile.color = { r, g, b, a } AloftManaText:UpdateAll() end,
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function() return not AloftManaText.db.profile.enable end,
			args =
			{
				format =
				{
					type = 'text',
					name = L["Format"],
					desc = L["Mana tag"],
					usage = L["<Any tag string>"],
					get = function() return Aloft:HighlightTagSyntax(AloftManaText.db.profile.format) end,
					set =	function(v)
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
			get = function() return AloftManaText.db.profile.always end,
			set = function(v) AloftManaText.db.profile.always = v Aloft:DetermineDataSources() AloftManaText:UpdateAll() end,
			disabled = function() return not AloftManaText.db.profile.enable end,
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
