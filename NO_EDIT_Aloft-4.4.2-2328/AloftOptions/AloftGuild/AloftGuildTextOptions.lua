local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftGuildTextOptions
if not L then return end

local AloftGuildText = Aloft:GetModule("GuildText", true)
if not AloftGuildText then return end

local AloftNameText = Aloft:GetModule("NameText", true) -- always enabled
if not AloftNameText then return end -- always enabled

local SML = LibStub("LibSharedMedia-3.0")

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
	disabled = function(i) return not Aloft:IsEnabled() or not AloftGuildText:IsEnabled() or not AloftGuildText.db or not AloftGuildText.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show guild information on nameplates"],
			get = function(i) return AloftGuildText.db.profile.enable end,
			set = function(i, v) AloftGuildText.db.profile.enable = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			order = 1
		},
		attachToName =
		{
			type = 'toggle',
			width = 'full',
			name = L["Attach to Name"],
			desc = L["Attaches guild text to name"],
			disabled = function(i) return not AloftGuildText.db.profile.enable end,
			get = function(i) return AloftGuildText.db.profile.attachToName end,
			set = function(i, v) AloftGuildText.db.profile.attachToName = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			order = 2
		},
		attachFormat =
		{
			type = 'select',
			width = 'full',
			name = L["Attach Format"],
			desc = L["Selects the text format to use"],
			disabled = function(i) return not AloftGuildText.db.profile.enable or not AloftGuildText.db.profile.attachToName end,
			get = function(i) return AloftGuildText.db.profile.attachFormat end,
			set = function(i, v) AloftGuildText.db.profile.attachFormat = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			values = { HYPHEN = L["HYPHEN"], SLASH = L["SLASH"], BRACKET = L["BRACKET"], COLON = L["COLON"] },
			order = 3
		},
		short =
		{
			type = 'toggle',
			width = 'full',
			name = L["Short"],
			desc = L["Use short guild names"],
			disabled = function(i) return not AloftGuildText.db.profile.enable end,
			get = function(i) return AloftGuildText.db.profile.useShort end,
			set = function(i, v) AloftGuildText.db.profile.useShort = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			order = 4
		},
		setShort =
		{
			type = 'input',
			width = 'full',
			name = L["Set Short Name"],
			desc = L["Sets the short name for your current target"],
			usage = L["<Any String>"],
			disabled = function(i) return not AloftGuildText.db.profile.enable or not AloftGuildText.db.profile.useShort end,
			get = function(i) return "" end,
			set = function(i, v)
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
			width = 'full',
			name = L["Show Own"],
			desc = L["Show the guild names of your own guild members"],
			disabled = function(i) return not AloftGuildText.db.profile.enable end,
			get = function(i) return AloftGuildText.db.profile.showOwn end,
			set = function(i, v) AloftGuildText.db.profile.showOwn = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			order = 6
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Guild text typeface options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftGuildText:IsEnabled() or not AloftGuildText.db or not AloftGuildText.db.profile or not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			args =
			{
				font =
				{
					type = 'select',
					width = 'full',
					name = L["Font"],
					desc = L["Sets the font for guild text"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.guildText.args.typeface.args.font.values) do
							if v == AloftGuildText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftGuildText.db.profile.font = Aloft.Options.args.guildText.args.typeface.args.font.values[v]
						AloftGuildText:UpdateAll()
					end,
					values = SML:List("font"),
				},
				fontSize =
				{
					type = 'range',
					width = 'full',
					name = L["Font Size"],
					desc = L["Sets the font height of the guild text"],
					max = 16,
					min = 5,
					step = 1,
					get = function(i) return AloftGuildText.db.profile.fontSize end,
					set = function(i, value) AloftGuildText.db.profile.fontSize = value AloftGuildText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					width = 'full',
					name = L["Font Shadow"],
					desc = L["Show font shadow on guild text"],
					get = function(i) return AloftGuildText.db.profile.shadow end,
					set = function(i, v) AloftGuildText.db.profile.shadow = v AloftGuildText:UpdateAll() end
				},
				outline =
				{
					type = 'select',
					width = 'full',
					name = L["Outline"],
					desc = L["Sets the outline for guild text"],
					get = function(i) return AloftGuildText.db.profile.outline end,
					set = function(i, value) AloftGuildText.db.profile.outline = value AloftGuildText:UpdateAll() end,
					values = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust guild text position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftGuildText:IsEnabled() or not AloftGuildText.db or not AloftGuildText.db.profile or not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			args =
			{
				anchor = {
					type = 'select',
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the guild text"],
					get = function(i) return AloftGuildText.db.profile.point end,
					set = function(i, v) AloftGuildText.db.profile.point = v AloftGuildText:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = 'select',
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the guild text"],
					get = function(i) return AloftGuildText.db.profile.relativeToPoint end,
					set = function(i, v) AloftGuildText.db.profile.relativeToPoint = v AloftGuildText:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the guild text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftGuildText.db.profile.offsetX end,
					set = function(i, v) AloftGuildText.db.profile.offsetX = v AloftGuildText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the guild text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftGuildText.db.profile.offsetY end,
					set = function(i, v) AloftGuildText.db.profile.offsetY = v AloftGuildText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			width = 'full',
			name = L["Alpha"],
			desc = L["Sets the alpha of the guild text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function(i) return not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			get = function(i) return AloftGuildText.db.profile.alpha end,
			set = function(i, v) AloftGuildText.db.profile.alpha = v AloftGuildText:UpdateAll() end
		},
		color =
		{
			type = 'color',
			width = 'full',
			name = L["Color"],
			desc = L["Sets the guild text color"],
			disabled = function(i) return not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			get = function(i) return unpack(AloftGuildText.db.profile.color) end,
			set = function(i, r, g, b, a) AloftGuildText.db.profile.color = { r, g, b, a } AloftGuildText:UpdateAll() end,
		},
		advanced  =
		{
			type = 'group',
			width = 'full',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftGuildText:IsEnabled() or not AloftGuildText.db or not AloftGuildText.db.profile or not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			args =
			{
				format =
				{
					type = 'input',
					width = 'full',
					name = L["Format"],
					desc = L["Guild tag"],
					usage = L["<Any tag string>"],
					get = function(i) return Aloft:HighlightTagSyntax(AloftGuildText.db.profile.format) end,
					set =	function(i, v)
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
	AloftNameText.db.profile.format = AloftNameText.db.profile.format .. attachFormats[self.db.profile.attachFormat][self:GetAttachFormatIndex()]
end

AloftNameText:RegisterFormatTagModifier(1, AloftGuildText.NameTextTagModifier, AloftGuildText)

-----------------------------------------------------------------------------

end)

