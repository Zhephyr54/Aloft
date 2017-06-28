local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftLevelText
if not L then return end

local AloftLevelText = Aloft:GetModule("LevelText")
if not AloftLevelText then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

local LEVELTEXT_FORMAT_BASE = "[Level]"
local LEVELTEXT_FORMAT_CREATURETYPE = "[ShortCreatureType]"
local LEVELTEXT_FORMAT_CLASSIFICATION = "[Select(Level, ShortClassification, Classification)]"
local LEVELTEXT_FORMAT_RACE = "[Race:Prefix(\" \"):Cyan]"

Aloft.Options.args.levelText =
{
	type = 'group',
	name = L["Level Text"],
	desc = L["Level text options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftLevelText:IsEnabled() or not AloftLevelText.db or not AloftLevelText.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = "full",
			name = L["Enable"],
			desc = L["Enable level text display on the nameplate"],
			get = function(i) return AloftLevelText.db.profile.enable end,
			set = function(i, v) AloftLevelText.db.profile.enable = v AloftLevelText:UpdateTag() Aloft:DetermineDataSources() AloftLevelText:UpdateAll() end,
			order = 1
		},
		showCreatureType =
		{
			type = 'toggle',
			width = "full",
			name = L["Show Creature Type"],
			desc = L["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"],
			disabled = function(i) return not AloftLevelText.db.profile.enable end,
			get = function(i) return AloftLevelText.db.profile.showCreatureType end,
			set = function(i, v)
					AloftLevelText.db.profile.showCreatureType = v
					AloftLevelText:UpdateTag()
					Aloft:DetermineDataSources()
					AloftLevelText:UpdateAll()
				  end,
			order = 2,
		},
		showClassification =
		{
			type = 'toggle',
			width = "full",
			name = L["Show Classification"],
			desc = L["Shows +,r,b for elite, rare and bosses after the level"],
			disabled = function(i) return not AloftLevelText.db.profile.enable end,
			get = function(i) return AloftLevelText.db.profile.showClassification end,
			set = function(i, v)
					AloftLevelText.db.profile.showClassification = v
					AloftLevelText:UpdateTag()
					Aloft:DetermineDataSources()
					AloftLevelText:UpdateAll()
				  end,
			order = 3,
		},
		showRace =
		{
			type = 'toggle',
			width = "full",
			name = L["Show Race"],
			desc = L["Shows unit race after the level"],
			disabled = function(i) return not AloftLevelText.db.profile.enable end,
			get = function(i) return AloftLevelText.db.profile.showRace end,
			set = function(i, v)
					AloftLevelText.db.profile.showRace = v
					AloftLevelText:UpdateTag()
					Aloft:DetermineDataSources()
					AloftLevelText:UpdateAll()
				  end,
			order = 4,
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Level text typeface options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftLevelText:IsEnabled() or not AloftLevelText.db or not AloftLevelText.db.profile or not AloftLevelText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "select",
					width = "full",
					name = L["Font"],
					desc = L["Sets the font for level text"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.levelText.args.typeface.args.font.values) do
							if v == AloftLevelText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftLevelText.db.profile.font = Aloft.Options.args.levelText.args.typeface.args.font.values[v]
						AloftLevelText:UpdateAll()
					end,
					values = SML:List("font"),
				},
				fontSize =
				{
					type = 'range',
					width = "full",
					name = L["Font Size"],
					desc = L["Sets the font height of the level text"],
					max = 16,
					min = 5,
					step = 1,
					get = function(i) return AloftLevelText.db.profile.fontSize end,
					set = function(i, value) AloftLevelText.db.profile.fontSize = value AloftLevelText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					width = "full",
					name = L["Font Shadow"],
					desc = L["Show font shadow on level text"],
					get = function(i) return AloftLevelText.db.profile.shadow end,
					set = function(i, v) AloftLevelText.db.profile.shadow = v AloftLevelText:UpdateAll() end
				},
				outline =
				{
					type = 'select',
					width = "full",
					name = L["Outline"],
					desc = L["Sets the font outline of the level text"],
					get = function(i) return AloftLevelText.db.profile.outline end,
					set = function(i, value) AloftLevelText.db.profile.outline = value AloftLevelText:UpdateAll() end,
					values = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust level text position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftLevelText:IsEnabled() or not AloftLevelText.db or not AloftLevelText.db.profile or not AloftLevelText.db.profile.enable end,
			args =
			{
				anchor = {
					type = "select",
					width = "full",
					name = L["Anchor"],
					desc = L["Sets the anchor for the level text"],
					get = function(i) return AloftLevelText.db.profile.point end,
					set = function(i, v) AloftLevelText.db.profile.point = v AloftLevelText:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "select",
					width = "full",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the level text"],
					get = function(i) return AloftLevelText.db.profile.relativeToPoint end,
					set = function(i, v) AloftLevelText.db.profile.relativeToPoint = v AloftLevelText:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					width = "full",
					name = L["X Offset"],
					desc = L["X offset of the level text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftLevelText.db.profile.offsetX end,
					set = function(i, v) AloftLevelText.db.profile.offsetX = v AloftLevelText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = "full",
					name = L["Y Offset"],
					desc = L["Y offset of the level text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftLevelText.db.profile.offsetY end,
					set = function(i, v) AloftLevelText.db.profile.offsetY = v AloftLevelText:UpdateAll() end
				},
			},
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftLevelText:IsEnabled() or not AloftLevelText.db or not AloftLevelText.db.profile or not AloftLevelText.db.profile.enable end,
			args =
			{
				enable =
				{
					type = 'toggle',
					width = "full",
					name = L["Override Text"],
					desc = L["Override level text"],
					get = function(i) return AloftLevelText.db.profile.overrideText end,
					set = function(i, v) AloftLevelText.db.profile.overrideText = v if v then AloftLevelText:UpdateTag() end Aloft:DetermineDataSources() AloftLevelText:UpdateAll() end,
					order = 1
				},
				format =
				{
					type = 'input',
					width = "full",
					name = L["Format"],
					desc = L["Level tag"],
					usage = L["<Any tag string>"],
					disabled = function(i) return not AloftLevelText.db.profile.overrideText end,
					get = function(i) return Aloft:HighlightTagSyntax(AloftLevelText.db.profile.format) end,
					set =	function(i, v)
								AloftLevelText.db.profile.format = Aloft:FixTagCasing(v)
								AloftLevelText.textMethodData = nil
								AloftLevelText.textMethod = nil
								Aloft:DetermineDataSources()
								AloftLevelText:UpdateAll()
							end,
				}
			},
		},
	},
}

-----------------------------------------------------------------------------

function AloftLevelText:UpdateTag()
	AloftLevelText.textMethodData = nil
	AloftLevelText.textMethod = nil

	if not self.db.profile.enable or (not self.db.profile.showCreatureType and not self.db.profile.showClassification and not self.db.profile.showRace) then
		self.db.profile.overrideText = false
	else
		self.db.profile.overrideText = true
		self.db.profile.format = LEVELTEXT_FORMAT_BASE..
								  (self.db.profile.showCreatureType and LEVELTEXT_FORMAT_CREATURETYPE or "")..
								  (self.db.profile.showClassification and LEVELTEXT_FORMAT_CLASSIFICATION or "")..
								  (self.db.profile.showRace and LEVELTEXT_FORMAT_RACE or "")
	end
end

-----------------------------------------------------------------------------
