local Aloft = Aloft
if not Aloft or not Aloft:HasModule("NameText") then return end

-----------------------------------------------------------------------------

local AloftNameText = Aloft:GetModule("NameText")
local L = AceLibrary("AceLocale-2.2"):new("AloftNameTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

Aloft.Options.args.nameText =
{
	type = 'group',
	name = L["Name Text"],
	desc = L["Nameplate text options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show unit names"],
			get = function() return AloftNameText.db.profile.enable end,
			set = function(v) AloftNameText.db.profile.enable = v Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
			order = 1
		},
		useAliases =
		{
			type = 'toggle',
			name = L["Use Aliases"],
			desc = L["Uses user defined aliases"],
			disabled = function() return not AloftNameText.db.profile.enable end,
			get = function() return AloftNameText.db.profile.useAliases end,
			set = function(v) AloftNameText.db.profile.useAliases = v AloftNameText:UpdateFormatTag() Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
			order = 2
		},
		setAlias =
		{
			type = 'text',
			name = L["Set Alias"],
			desc = L["Sets the alias for your current target. An empty alias will return the unit to its original name"],
			usage = L["<Any String>"],
			disabled = function() return not AloftNameText.db.profile.enable or not AloftNameText.db.profile.useAliases end,
			get = function() return "" end,
			set = function(v) Aloft:GetModule("AliasData"):SetAlias(UnitName("target"), v) end,
			order = 3
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Nameplate text typeface options"],
			disabled = function() return not AloftNameText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for nameplate text"],
					get = function() return AloftNameText.db.profile.font end,
					set = function(v)
						AloftNameText.db.profile.font = v
						AloftNameText:UpdateAll()
					end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the nameplate text"],
					max = 16,
					min = 4,
					step = 1,
					get = function() return AloftNameText.db.profile.fontSize end,
					set = function(value) AloftNameText.db.profile.fontSize = value AloftNameText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on nameplate text"],
					get = function() return AloftNameText.db.profile.shadow end,
					set = function(v) AloftNameText.db.profile.shadow = v AloftNameText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline for nameplate text"],
					get = function() return AloftNameText.db.profile.outline end,
					set = function(value) AloftNameText.db.profile.outline = value AloftNameText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'text',
			name = L["Alignment"],
			desc = L["Sets the alignment of the nameplate text"],
			disabled = function() return not AloftNameText.db.profile.enable end,
			get = function() return AloftNameText.db.profile.alignment end,
			set = function(value) AloftNameText.db.profile.alignment = value AloftNameText:UpdateAll() end,
			validate = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust nameplate text position"],
			disabled = function() return not AloftNameText.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the text"],
					min = -640,
					max = 640,
					step = 1,
					get = function() return AloftNameText.db.profile.offsets.left end,
					set = function(v) AloftNameText.db.profile.offsets.left = v AloftNameText:UpdateAll() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the text"],
					min = -640,
					max = 640,
					step = 1,
					get = function() return AloftNameText.db.profile.offsets.right end,
					set = function(v) AloftNameText.db.profile.offsets.right = v AloftNameText:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftNameText.db.profile.offsets.vertical end,
					set = function(v) AloftNameText.db.profile.offsets.vertical = v AloftNameText:UpdateAll() end
				},
			},
		},
		overrideColors =
		{
			type = 'toggle',
			name = L["Override Colors"],
			desc = L["Override the games colors for nameplate text"],
			disabled = function() return not AloftNameText.db.profile.enable end,
			get = function() return AloftNameText.db.profile.overrideColors end,
			set = function(value) AloftNameText.db.profile.overrideColors = value AloftNameText:UpdateAll() end,
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize colors"],
			disabled = function() return not AloftNameText.db.profile.enable or not AloftNameText.db.profile.overrideColors end,
			args =
			{
				colorByClass =
				{
					type = 'toggle',
					name = L["Color by Class"],
					desc = L["Sets the name text color according to class"],
					get = function() return AloftNameText.db.profile.colorByClass end,
					set = function(v) AloftNameText.db.profile.colorByClass = v Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
					order = 1
				},
				colorHostileByClass =
				{
					type = 'toggle',
					name = L["Color Hostile by Class"],
					desc = L["Sets the name text color of hostile players according to class"],
					get = function() return AloftNameText.db.profile.colorHostileByClass end,
					set = function(v) AloftNameText.db.profile.colorHostileByClass = v Aloft:DetermineDataSources() AloftNameText:UpdateAll() end,
					order = 2
				},
				setAll =
				{
					type = 'color',
					name = L["Set All"],
					desc = L["Sets the name text color for all types"],
					get = function() return unpack(AloftNameText.db.profile.colors.friendlyPlayer) end,
					set = function(r, g, b)
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
					name = L["Set All Friendly"],
					desc = L["Sets the name text color for all friendly types"],
					get = function() return unpack(AloftNameText.db.profile.colors.friendlyPlayer) end,
					set = function(r, g, b)
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
					name = L["Set All Hostile"],
					desc = L["Sets the name text color for all hostile types"],
					get = function() return unpack(AloftNameText.db.profile.colors.hostileNPC) end,
					set = function(r, g, b)
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
					name = L["Friendly Players"],
					desc = L["Sets the name text color for friendly players"],
					get = function() return unpack(AloftNameText.db.profile.colors.friendlyPlayer) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.friendlyPlayer = { r, g, b } AloftNameText:UpdateAll() end
				},
				friendlyPet =
				{
					type = 'color',
					name = L["Friendly Pets"],
					desc = L["Sets the name text color for friendly pets"],
					get = function() return unpack(AloftNameText.db.profile.colors.friendlyPet) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.friendlyPet = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				friendlyNPC =
				{
					type = 'color',
					name = L["Friendly NPCs"],
					desc = L["Sets the name text color for friendly NPCs"],
					get = function() return unpack(AloftNameText.db.profile.colors.friendlyNPC) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.friendlyNPC = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				friendlyBoss =
				{
					type = 'color',
					name = L["Friendly Boss"],
					desc = L["Sets the name text color for friendly NPC Bosses"],
					get = function() return unpack(AloftNameText.db.profile.colors.friendlyBoss) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.friendlyBoss = { r, g, b } AloftNameText:UpdateAll() end
				},
				hostilePlayer =
				{
					type = 'color',
					name = L["Hostile Players"],
					desc = L["Sets the name text color for hostile players"],
					disabled = function() return AloftNameText.db.profile.colorHostileByClass end,
					get = function() return unpack(AloftNameText.db.profile.colors.hostilePlayer) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.hostilePlayer = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				hostilePet  =
				{
					type = 'color',
					name = L["Hostile Pets"],
					desc = L["Sets the name text color for hostile pets"],
					get = function() return unpack(AloftNameText.db.profile.colors.hostilePet) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.hostilePet = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				hostileNPC =
				{
					type = 'color',
					name = L["Hostile NPCs"],
					desc = L["Sets the name text color for hostile units"],
					get = function() return unpack(AloftNameText.db.profile.colors.hostileNPC) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.hostileNPC = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
				hostileBoss =
				{
					type = 'color',
					name = L["Hostile Boss"],
					desc = L["Sets the name text color for hostile boss units"],
					get = function() return unpack(AloftNameText.db.profile.colors.hostileBoss) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.hostileBoss = { r, g, b } AloftNameText:UpdateAll() end
				},
				neutral =
				{
					type = 'color',
					name = L["Neutral Units"],
					desc = L["Sets the name text color for neutral units"],
					get = function() return unpack(AloftNameText.db.profile.colors.neutral) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.neutral = { r, g, b } AloftNameText:UpdateAll() end
				},
				pet =
				{
					type = 'color',
					name = L["Pet"],
					desc = L["Sets the name text color for your pet"],
					get = function() return unpack(AloftNameText.db.profile.colors.pet) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.pet = { r, g, b } AloftNameText:UpdateAll() end
				},
				groupPet =
				{
					type = 'color',
					name = L["Group Pets"],
					desc = L["Sets the name text color for group pets"],
					get = function() return unpack(AloftNameText.db.profile.colors.groupPet) end,
					set = function(r, g, b) AloftNameText.db.profile.colors.groupPet = { r, g, b } Aloft:DetermineDataSources() AloftNameText:UpdateAll() end
				},
			}
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function() return not AloftNameText.db.profile.enable end,
			args =
			{
				format =
				{
					type = 'text',
					name = L["Format"],
					desc = L["Name tag"],
					usage = L["<Any tag string>"],
					get = function() return Aloft:HighlightTagSyntax(AloftNameText.db.profile.format) end,
					set =	function(v)
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
	table.sort(tagModifiers, function(a, b) return a[1] < b[1] end)

	self.textMethodData = nil
	self.textMethod = nil

	for _,k in ipairs(tagModifiers) do
		k[2](unpack(k, 3))
	end
end

-----------------------------------------------------------------------------
