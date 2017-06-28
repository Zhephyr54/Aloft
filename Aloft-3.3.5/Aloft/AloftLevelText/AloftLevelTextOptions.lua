-----------------------------------------------------------------------------

local Aloft = Aloft
if not Aloft or not Aloft:HasModule("LevelText") then return end

-----------------------------------------------------------------------------

local AloftLevelText = Aloft:GetModule("LevelText")
local L = AceLibrary("AceLocale-2.2"):new("AloftLevelTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

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
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable level text display on the nameplate"],
			get = function() return AloftLevelText.db.profile.enable end,
			set = function(v) AloftLevelText.db.profile.enable = v AloftLevelText:UpdateTag() Aloft:DetermineDataSources() AloftLevelText:UpdateAll() end,
			order = 1
		},
		showCreatureType =
		{
			type = 'toggle',
			name = L["Show Creature Type"],
			desc = L["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"],
			get = function() return AloftLevelText.db.profile.showCreatureType end,
			set = function(v)
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
			name = L["Show Classification"],
			desc = L["Shows +,r,b for elite, rare and bosses after the level"],
			get = function() return AloftLevelText.db.profile.showClassification end,
			set = function(v)
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
			name = L["Show Race"],
			desc = L["Shows unit race after the level"],
			get = function() return AloftLevelText.db.profile.showRace end,
			set = function(v)
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
			disabled = function() return not AloftLevelText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for level text"],
					get = function() return AloftLevelText.db.profile.font end,
					set = function(v)
						AloftLevelText.db.profile.font = v
						AloftLevelText:UpdateAll()
					end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the level text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftLevelText.db.profile.fontSize end,
					set = function(value) AloftLevelText.db.profile.fontSize = value AloftLevelText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on level text"],
					get = function() return AloftLevelText.db.profile.shadow end,
					set = function(v) AloftLevelText.db.profile.shadow = v AloftLevelText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline of the level text"],
					get = function() return AloftLevelText.db.profile.outline end,
					set = function(value) AloftLevelText.db.profile.outline = value AloftLevelText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust level text position"],
			disabled = function() return not AloftLevelText.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the level text"],
					get = function() return AloftLevelText.db.profile.point end,
					set = function(v) AloftLevelText.db.profile.point = v AloftLevelText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the level text"],
					get = function() return AloftLevelText.db.profile.relativeToPoint end,
					set = function(v) AloftLevelText.db.profile.relativeToPoint = v AloftLevelText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the level text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftLevelText.db.profile.offsetX end,
					set = function(v) AloftLevelText.db.profile.offsetX = v AloftLevelText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the level text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftLevelText.db.profile.offsetY end,
					set = function(v) AloftLevelText.db.profile.offsetY = v AloftLevelText:UpdateAll() end
				},
			},
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function() return not AloftLevelText.db.profile.enable end,
			args =
			{
				enable =
				{
					type = 'toggle',
					name = L["Override Text"],
					desc = L["Override level text"],
					get = function() return AloftLevelText.db.profile.overrideText end,
					set = function(v) AloftLevelText.db.profile.overrideText = v if v then AloftLevelText:UpdateTag() end Aloft:DetermineDataSources() AloftLevelText:UpdateAll() end,
					order = 1
				},
				format =
				{
					type = 'text',
					name = L["Format"],
					desc = L["Level tag"],
					usage = L["<Any tag string>"],
					disabled = function() return not AloftLevelText.db.profile.overrideText end,
					get = function() return Aloft:HighlightTagSyntax(AloftLevelText.db.profile.format) end,
					set =	function(v)
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
