local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("GuildText") then return end

local AloftGuildText = Aloft:GetModule("GuildText")
local AloftNameText = Aloft:GetModule("NameText")

local L = AceLibrary("AceLocale-2.2"):new("AloftGuildTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

local attachFormats =
{
	["HYPHEN"]	= { "[Guild:Prefix(\" - \"):HideGuild]", "[ShortGuild:Prefix(\" - \"):HideGuild]", "[Guild:Prefix(\" - \")]", "[ShortGuild:Prefix(\" - \")]" },
	["BRACKET"]	= { "[Guild:HideGuild:Surround(\" (\", \")\")]", "[ShortGuild:HideGuild:Surround(\" (\", \")\")]", "[Guild:Surround(\" (\", \")\")]", "[ShortGuild:Surround(\" (\", \")\")]" },
	["SLASH"]	= { "[Guild:Prefix(\" / \"):HideGuild]", "[ShortGuild:Prefix(\" / \"):HideGuild]", "[Guild:Prefix(\" / \")]", "[ShortGuild:Prefix(\" / \")]" },
	["COLON"]	= { "[Guild:Prefix(\" : \"):HideGuild]", "[ShortGuild:Prefix(\" : \"):HideGuild]", "[Guild:Prefix(\" : \")]", "[ShortGuild:Prefix(\" : \")]" },
}

local formats	= { "[Guild:HideGuild]", "[ShortGuild:HideGuild]", "[Guild]", "[ShortGuild]" }

-----------------------------------------------------------------------------

Aloft.Options.args.guildText =
{
	type = 'group',
	name = L["Guild Text"],
	desc = L["Guild text options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show guild information on nameplates"],
			get = function() return AloftGuildText.db.profile.enable end,
			set = function(v) AloftGuildText.db.profile.enable = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			order = 1
		},
		attachToName =
		{
			type = 'toggle',
			name = L["Attach to Name"],
			desc = L["Attaches guild text to name"],
			disabled = function() return not AloftGuildText.db.profile.enable end,
			get = function() return AloftGuildText.db.profile.attachToName end,
			set = function(v) AloftGuildText.db.profile.attachToName = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			order = 2
		},
		attachFormat =
		{
			type = 'text',
			name = L["Attach Format"],
			desc = L["Selects the text format to use"],
			disabled = function() return not AloftGuildText.db.profile.enable or not AloftGuildText.db.profile.attachToName end,
			get = function() return AloftGuildText.db.profile.attachFormat end,
			set = function(v) AloftGuildText.db.profile.attachFormat = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			validate = { HYPHEN = L["HYPHEN"], SLASH = L["SLASH"], BRACKET = L["BRACKET"], COLON = L["COLON"] },
			order = 3
		},
		short =
		{
			type = 'toggle',
			name = L["Short"],
			desc = L["Use short guild names"],
			disabled = function() return not AloftGuildText.db.profile.enable end,
			get = function() return AloftGuildText.db.profile.useShort end,
			set = function(v) AloftGuildText.db.profile.useShort = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			order = 4
		},
		setShort =
		{
			type = 'text',
			name = L["Set Short Name"],
			desc = L["Sets the short name for your current target"],
			usage = L["<Any String>"],
			disabled = function() return not AloftGuildText.db.profile.enable or not AloftGuildText.db.profile.useShort end,
			get = function() return "" end,
			set = function(v)
					if UnitExists("target") then
						local targetGuild = GetGuildInfo("target") or ""
						Aloft:GetModule("ShortGuildData"):AddData(targetGuild, v)
						Aloft:Print(string.format(L["ShortNameAdded"], targetGuild, v))
					else
						Aloft:Print(L["NoSetShortName"])
					end
				  end,
			order = 5
		},
		showOwn =
		{
			type = 'toggle',
			name = L["Show Own"],
			desc = L["Show the guild names of your own guild members"],
			disabled = function() return not AloftGuildText.db.profile.enable end,
			get = function() return AloftGuildText.db.profile.showOwn end,
			set = function(v) AloftGuildText.db.profile.showOwn = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			order = 6
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Guild text typeface options"],
			disabled = function() return not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for guild text"],
					get = function() return AloftGuildText.db.profile.font end,
					set = function(v)
						AloftGuildText.db.profile.font = v
						AloftGuildText:UpdateAll()
					end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the guild text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftGuildText.db.profile.fontSize end,
					set = function(value) AloftGuildText.db.profile.fontSize = value AloftGuildText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on guild text"],
					get = function() return AloftGuildText.db.profile.shadow end,
					set = function(v) AloftGuildText.db.profile.shadow = v AloftGuildText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the outline for guild text"],
					get = function() return AloftGuildText.db.profile.outline end,
					set = function(value) AloftGuildText.db.profile.outline = value AloftGuildText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust guild text position"],
			disabled = function() return not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the guild text"],
					get = function() return AloftGuildText.db.profile.point end,
					set = function(v) AloftGuildText.db.profile.point = v AloftGuildText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the guild text"],
					get = function() return AloftGuildText.db.profile.relativeToPoint end,
					set = function(v) AloftGuildText.db.profile.relativeToPoint = v AloftGuildText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the guild text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftGuildText.db.profile.offsetX end,
					set = function(v) AloftGuildText.db.profile.offsetX = v AloftGuildText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the guild text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftGuildText.db.profile.offsetY end,
					set = function(v) AloftGuildText.db.profile.offsetY = v AloftGuildText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the alpha of the guild text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			get = function() return AloftGuildText.db.profile.alpha end,
			set = function(v) AloftGuildText.db.profile.alpha = v AloftGuildText:UpdateAll() end
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the guild text color"],
			disabled = function() return not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			get = function() return unpack(AloftGuildText.db.profile.color) end,
			set = function(r, g, b, a) AloftGuildText.db.profile.color = { r, g, b, a } AloftGuildText:UpdateAll() end,
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function() return not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			args =
			{
				format =
				{
					type = 'text',
					name = L["Format"],
					desc = L["Guild tag"],
					usage = L["<Any tag string>"],
					get = function() return Aloft:HighlightTagSyntax(AloftGuildText.db.profile.format) end,
					set =	function(v)
								AloftGuildText.db.profile.format = Aloft:FixTagCasing(v)
								AloftGuildText.textMethodData = nil
								AloftGuildText.textMethod = nil
								Aloft:DetermineDataSources()
								AloftGuildText:UpdateAll()
							end,
				}
			},
		},
	},
}

-----------------------------------------------------------------------------

function AloftGuildText:GetAttachFormatIndex()
	local attachFormatIndex = 1
	if self.db.profile.useShort then attachFormatIndex = 2 end
	if self.db.profile.showOwn then attachFormatIndex = attachFormatIndex+2 end
	return attachFormatIndex
end

function AloftGuildText:UpdateAttachedText()
	self.db.profile.format = formats[self:GetAttachFormatIndex()]
	self.textMethodData = nil
	self.textMethod = nil
	AloftNameText:UpdateFormatTag()
end

-----------------------------------------------------------------------------

function AloftGuildText:NameTextTagModifier()
	if not self.db.profile.enable or not self.db.profile.attachToName then return end
	AloftNameText.db.profile.format = AloftNameText.db.profile.format..attachFormats[self.db.profile.attachFormat][self:GetAttachFormatIndex()]
end

AloftNameText:RegisterFormatTagModifier(1, AloftGuildText.NameTextTagModifier, AloftGuildText)

-----------------------------------------------------------------------------

end)

