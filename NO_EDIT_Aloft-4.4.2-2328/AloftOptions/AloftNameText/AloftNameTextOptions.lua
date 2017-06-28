local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftNameText
if not L then return end

local AloftNameText = Aloft:GetModule("NameText", true)
if not AloftNameText then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.nameText =
{
	type = 'group',
	name = L["Name Text"],
	desc = L["Nameplate text options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftNameText:IsEnabled() or not AloftNameText.db or not AloftNameText.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show unit names"],
			get = function(i) return AloftNameText.db.profile.enable end,
			set = function(i, v) AloftNameText.db.profile.enable = v Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
			order = 1
		},
		useAliases =
		{
			type = 'toggle',
			width = 'full',
			name = L["Use Aliases"],
			desc = L["Uses user defined aliases"],
			disabled = function(i) return not AloftNameText.db.profile.enable end,
			get = function(i) return AloftNameText.db.profile.useAliases end,
			set = function(i, v) AloftNameText.db.profile.useAliases = v AloftNameText:UpdateFormatTag() Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
			order = 2
		},
		setAlias =
		{
			type = 'input',
			width = 'full',
			name = L["Set Alias"],
			desc = L["Sets the alias for your current target. An empty alias will return the unit to its original name"],
			usage = L["<Any String>"],
			disabled = function(i) return not AloftNameText.db.profile.enable or not AloftNameText.db.profile.useAliases end,
			get = function(i) return "" end,
			set = function(i, v) Aloft:GetModule("AliasData"):SetAlias(UnitName("target"), v) end,
			order = 3
		},
		typeface =
		{
			type = 'group',
			name = L["Typeface"],
			desc = L["Nameplate text typeface options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftNameText:IsEnabled() or not AloftNameText.db or not AloftNameText.db.profile or not AloftNameText.db.profile.enable end,
			args =
			{
				font =
				{
					type = 'select',
					width = 'full',
					name = L["Font"],
					desc = L["Sets the font for nameplate text"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.nameText.args.typeface.args.font.values) do
							if v == AloftNameText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftNameText.db.profile.font = Aloft.Options.args.nameText.args.typeface.args.font.values[v]
						AloftNameText:UpdateAll()
					end,
					values = SML:List("font"),
				},
				fontSize =
				{
					type = 'range',
					width = 'full',
					name = L["Font Size"],
					desc = L["Sets the font height of the nameplate text"],
					max = 16,
					min = 4,
					step = 1,
					get = function(i) return AloftNameText.db.profile.fontSize end,
					set = function(i, value) AloftNameText.db.profile.fontSize = value AloftNameText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					width = 'full',
					name = L["Font Shadow"],
					desc = L["Show font shadow on nameplate text"],
					get = function(i) return AloftNameText.db.profile.shadow end,
					set = function(i, v) AloftNameText.db.profile.shadow = v AloftNameText:UpdateAll() end
				},
				outline =
				{
					type = 'select',
					width = 'full',
					name = L["Outline"],
					desc = L["Sets the font outline for nameplate text"],
					get = function(i) return AloftNameText.db.profile.outline end,
					set = function(i, value) AloftNameText.db.profile.outline = value AloftNameText:UpdateAll() end,
					values = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'select',
			width = 'full',
			name = L["Alignment"],
			desc = L["Sets the alignment of the nameplate text"],
			disabled = function(i) return not AloftNameText.db.profile.enable end,
			get = function(i) return AloftNameText.db.profile.alignment end,
			set = function(i, value) AloftNameText.db.profile.alignment = value AloftNameText:UpdateAll() end,
			values = { ["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust nameplate text position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftNameText:IsEnabled() or not AloftNameText.db or not AloftNameText.db.profile or not AloftNameText.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					width = 'full',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the text"],
					min = -640,
					max = 640,
					step = 1,
					get = function(i) return AloftNameText.db.profile.offsets.left end,
					set = function(i, v) AloftNameText.db.profile.offsets.left = v AloftNameText:UpdateAll() end
				},
				right =
				{
					type = 'range',
					width = 'full',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the text"],
					min = -640,
					max = 640,
					step = 1,
					get = function(i) return AloftNameText.db.profile.offsets.right end,
					set = function(i, v) AloftNameText.db.profile.offsets.right = v AloftNameText:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					width = 'full',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftNameText.db.profile.offsets.vertical end,
					set = function(i, v) AloftNameText.db.profile.offsets.vertical = v AloftNameText:UpdateAll() end
				},
			},
		},
		overrideColors =
		{
			type = 'toggle',
			width = 'full',
			name = L["Override Colors"],
			desc = L["Override the games colors for nameplate text"],
			disabled = function(i) return not AloftNameText.db.profile.enable end,
			get = function(i) return AloftNameText.db.profile.overrideColors end,
			set = function(i, value) AloftNameText.db.profile.overrideColors = value AloftNameText:UpdateAll() end,
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize colors"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftNameText:IsEnabled() or not AloftNameText.db or not AloftNameText.db.profile or not AloftNameText.db.profile.enable end,
			args =
			{
				colorByClass =
				{
					type = 'toggle',
					width = 'full',
					name = L["Color by Class"],
					desc = L["Sets the name text color according to class"],
					get = function(i) return AloftNameText.db.profile.colorByClass end,
					set = function(i, v) AloftNameText.db.profile.colorByClass = v Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
					order = 1
				},
				colorHostileByClass =
				{
					type = 'toggle',
					width = 'full',
					name = L["Color Hostile by Class"],
					desc = L["Sets the name text color of hostile players according to class"],
					get = function(i) return AloftNameText.db.profile.colorHostileByClass end,
					set = function(i, v) AloftNameText.db.profile.colorHostileByClass = v Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
					order = 2
				},
				setAll =
				{
					type = 'color',
					width = 'full',
					name = L["Set All"],
					desc = L["Sets the name text color for all types"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.friendlyPlayer) end,
					set = function(i, r, g, b)
						AloftNameText.db.profile.colors.friendlyPlayer	= { r, g, b }
						AloftNameText.db.profile.colors.friendlyPet		= { r, g, b }
						AloftNameText.db.profile.colors.friendlyNPC		= { r, g, b }
						AloftNameText.db.profile.colors.friendlyBoss	= { r, g, b }
						AloftNameText.db.profile.colors.hostilePlayer	= { r, g, b }
						AloftNameText.db.profile.colors.hostilePet		= { r, g, b }
						AloftNameText.db.profile.colors.hostileNPC		= { r, g, b }
						AloftNameText.db.profile.colors.hostileBoss		= { r, g, b }
						AloftNameText.db.profile.colors.neutral			= { r, g, b }
						AloftNameText.db.profile.colors.pet				= { r, g, b }
						AloftNameText.db.profile.colors.groupPet		= { r, g, b }
						Aloft:DetermineDataSources()
						AloftNameText:UpdateAll() end,
					order = 3
				},
				setAllFriendly =
				{
					type = 'color',
					width = 'full',
					name = L["Set All Friendly"],
					desc = L["Sets the name text color for all friendly types"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.friendlyPlayer) end,
					set = function(i, r, g, b)
						AloftNameText.db.profile.colors.friendlyPlayer	= { r, g, b }
						AloftNameText.db.profile.colors.friendlyPet		= { r, g, b }
						AloftNameText.db.profile.colors.friendlyNPC		= { r, g, b }
						AloftNameText.db.profile.colors.friendlyBoss	= { r, g, b }
						AloftNameText.db.profile.colors.pet				= { r, g, b }
						AloftNameText.db.profile.colors.groupPet		= { r, g, b }
						Aloft:DetermineDataSources()
						AloftNameText:UpdateAll() end,
					order = 4
				},
				setAllHostile =
				{
					type = 'color',
					width = 'full',
					name = L["Set All Hostile"],
					desc = L["Sets the name text color for all hostile types"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.hostileNPC) end,
					set = function(i, r, g, b)
						AloftNameText.db.profile.colors.hostilePlayer	= { r, g, b }
						AloftNameText.db.profile.colors.hostilePet		= { r, g, b }
						AloftNameText.db.profile.colors.hostileNPC		= { r, g, b }
						AloftNameText.db.profile.colors.hostileBoss		= { r, g, b }
						Aloft:DetermineDataSources()
						AloftNameText:UpdateAll() end,
					order = 5
				},
				friendlyPlayer =
				{
					type = 'color',
					width = 'full',
					name = L["Friendly Players"],
					desc = L["Sets the name text color for friendly players"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.friendlyPlayer) end,
					set = function(i, r, g, b) AloftNameText.db.profile.colors.friendlyPlayer = { r, g, b } AloftNameText:UpdateAll() end
				},
				friendlyPet =
				{
					type = 'color',
					width = 'full',
					name = L["Friendly Pets"],
					desc = L["Sets the name text color for friendly pets"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.friendlyPet) end,
					set = function(i, r, g, b) AloftNameText.db.profile.colors.friendlyPet = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				friendlyNPC =
				{
					type = 'color',
					width = 'full',
					name = L["Friendly NPCs"],
					desc = L["Sets the name text color for friendly NPCs"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.friendlyNPC) end,
					set = function(i, r, g, b) AloftNameText.db.profile.colors.friendlyNPC = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				friendlyBoss =
				{
					type = 'color',
					width = 'full',
					name = L["Friendly Boss"],
					desc = L["Sets the name text color for friendly NPC Bosses"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.friendlyBoss) end,
					set = function(i, r, g, b) AloftNameText.db.profile.colors.friendlyBoss = { r, g, b } AloftNameText:UpdateAll() end
				},
				hostilePlayer =
				{
					type = 'color',
					width = 'full',
					name = L["Hostile Players"],
					desc = L["Sets the name text color for hostile players"],
					disabled = function(i) return AloftNameText.db.profile.colorHostileByClass end,
					get = function(i) return unpack(AloftNameText.db.profile.colors.hostilePlayer) end,
					set = function(i, r, g, b) AloftNameText.db.profile.colors.hostilePlayer = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				hostilePet  =
				{
					type = 'color',
					width = 'full',
					name = L["Hostile Pets"],
					desc = L["Sets the name text color for hostile pets"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.hostilePet) end,
					set = function(i, r, g, b) AloftNameText.db.profile.colors.hostilePet = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				hostileNPC =
				{
					type = 'color',
					width = 'full',
					name = L["Hostile NPCs"],
					desc = L["Sets the name text color for hostile units"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.hostileNPC) end,
					set = function(i, r, g, b) AloftNameText.db.profile.colors.hostileNPC = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				hostileBoss =
				{
					type = 'color',
					width = 'full',
					name = L["Hostile Boss"],
					desc = L["Sets the name text color for hostile boss units"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.hostileBoss) end,
					set = function(i, r, g, b) AloftNameText.db.profile.colors.hostileBoss = { r, g, b } AloftNameText:UpdateAll() end
				},
				neutral =
				{
					type = 'color',
					width = 'full',
					name = L["Neutral Units"],
					desc = L["Sets the name text color for neutral units"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.neutral) end,
					set = function(i, r, g, b) AloftNameText.db.profile.colors.neutral = { r, g, b } AloftNameText:UpdateAll() end
				},
				pet =
				{
					type = 'color',
					width = 'full',
					name = L["Pet"],
					desc = L["Sets the name text color for your pet"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.pet) end,
					set = function(i, r, g, b) AloftNameText.db.profile.colors.pet = { r, g, b } AloftNameText:UpdateAll() end
				},
				groupPet =
				{
					type = 'color',
					width = 'full',
					name = L["Group Pets"],
					desc = L["Sets the name text color for group pets"],
					get = function(i) return unpack(AloftNameText.db.profile.colors.groupPet) end,
					set = function(i, r, g, b) AloftNameText.db.profile.colors.groupPet = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
			}
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftNameText:IsEnabled() or not AloftNameText.db or not AloftNameText.db.profile or not AloftNameText.db.profile.enable end,
			args =
			{
				format =
				{
					type = 'input',
					width = 'full',
					name = L["Format"],
					desc = L["Name tag"],
					usage = L["<Any tag string>"],
					get = function(i) return Aloft:HighlightTagSyntax(AloftNameText.db.profile.format) end,
					set =	function(i, v)
								AloftNameText.db.profile.format = Aloft:FixTagCasing(v)
								AloftNameText.textMethodData = nil
								AloftNameText.textMethod = nil
								Aloft:DetermineDataSources()
								AloftNameText:UpdateAll()
							end,
				}
			},
		},
	},
}

-----------------------------------------------------------------------------

local tagModifiers = { }

function AloftNameText:RegisterFormatTagModifier(priority, method, ...)
	table.insert(tagModifiers, { priority, method,  ... })
end

function AloftNameText:UpdateFormatTag()
	self.db.profile.format = self.db.profile.useAliases and "[Alias]" or "[Name]"
	table.sort(tagModifiers, function(a, b) return a[1] < b[1] end) -- sort by "priority"

	self.textMethodData = nil
	self.textMethod = nil

	for _,k in ipairs(tagModifiers) do
		k[2](unpack(k, 3))
	end
end

-----------------------------------------------------------------------------
