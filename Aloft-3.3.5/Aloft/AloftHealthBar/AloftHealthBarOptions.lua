local Aloft = Aloft
if not Aloft or not Aloft:HasModule("HealthBar") then return end

-----------------------------------------------------------------------------

local AloftHealthBar = Aloft:GetModule("HealthBar")
local L = AceLibrary("AceLocale-2.2"):new("AloftHealthBarOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_statusbar = SML:List("statusbar")
local SML_border = SML:List("border")

-----------------------------------------------------------------------------

Aloft.Options.args.healthBar =
{
	type = 'group',
	name = L["Health Bar"],
	desc = L["Health Bar options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		height =
		{
			type = 'range',
			name = L["Height"],
			desc = L["Sets the height of the health bar"],
			order = 1,
			min = 1,
			max = 128,
			step = 1,
			get = function() return AloftHealthBar.db.profile.height end,
			set = function(v) AloftHealthBar.db.profile.height = v AloftHealthBar:UpdateAll() end
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the health bar's position"],
			order = 2,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the health bar"],
					order = 1,
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftHealthBar.db.profile.offsets.left end,
					set = function(v) AloftHealthBar.db.profile.offsets.left = v AloftHealthBar:UpdateAll() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the health bar"],
					order = 2,
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftHealthBar.db.profile.offsets.right end,
					set = function(v) AloftHealthBar.db.profile.offsets.right = v AloftHealthBar:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the health bar"],
					order = 3,
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftHealthBar.db.profile.offsets.vertical end,
					set = function(v) AloftHealthBar.db.profile.offsets.vertical = v AloftHealthBar:UpdateAll() end
				},
			},
		},
		texture =
		{
			type = "text",
			name = L["Texture"],
			desc = L["Sets the health bar texture"],
			order = 3,
			get = function() return AloftHealthBar.db.profile.texture end,
			set = function(v)
				AloftHealthBar.db.profile.texture = v
				AloftHealthBar:UpdateAll()
			end,
			validate = SML_statusbar
		},
		border = {
			type = 'group',
			name = L["Border"],
			desc = L["Border options"],
			order = 4,
			args =
			{
				targetOnly =
				{
					type = 'toggle',
					name = L["Target Only"],
					desc = L["Enables the border on the current target only"],
					order = 1,
					get = function() return AloftHealthBar.db.profile.targetOnly end,
					set = function(v) AloftHealthBar.db.profile.targetOnly = v AloftHealthBar:UpdateAll() end,
					disabled = function() return AloftHealthBar.db.profile.border == "None" end,
				},
				style =
				{
					type = 'text',
					name = L["Border Style"],
					desc = L["Sets the style of the health bar border"],
					order = 2,
					get = function() return AloftHealthBar.db.profile.border end,
					set = function(v)
						AloftHealthBar.db.profile.border = v
						AloftHealthBar:UpdateAll()
					end,
					validate = SML_border
				},
				color =
				{
					type = 'color',
					name = L["Border Color"],
					desc = L["Sets the border color of the health bar"],
					order = 3,
					get = function() return unpack(AloftHealthBar.db.profile.borderColor) end,
					set = function(r, g, b, a) AloftHealthBar.db.profile.borderColor = { r, g, b, a } AloftHealthBar:UpdateAll() end,
					disabled = function() return AloftHealthBar.db.profile.border == "None" end,
					hasAlpha = true,
				},
			},
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the health bar alpha"],
			order = 5,
			min = 0,
			max = 1.0,
			step = 0.05,
			get = function() return AloftHealthBar.db.profile.alpha end,
			set = function(v) AloftHealthBar.db.profile.alpha = v AloftHealthBar:UpdateAll() end,
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize colors"],
			order = 6,
			args =
			{
				colorByClass =
				{
					type = 'toggle',
					name = L["Color by Class"],
					desc = L["Sets the health bar color of players according to class"],
					get = function() return AloftHealthBar.db.profile.colorByClass end,
					set = function(v) AloftHealthBar.db.profile.colorByClass = v Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end,
					order = 1
				},
				colorHostileByClass =
				{
					type = 'toggle',
					name = L["Color Hostile by Class"],
					desc = L["Sets the health bar color of hostile players according to class"],
					get = function() return AloftHealthBar.db.profile.colorHostileByClass end,
					set = function(v) AloftHealthBar.db.profile.colorHostileByClass = v Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end,
					order = 2
				},
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the health bar"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.backdropColor) end,
					set = function(r, g, b, a) AloftHealthBar.db.profile.colors.backdropColor = { r, g, b, a } AloftHealthBar:UpdateAll() end,
					hasAlpha = true,
					order = 3
				},
				friendlyPlayer =
				{
					type = 'color',
					name = L["Friendly Players"],
					desc = L["Sets the health bar color for friendly players"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.friendlyPlayer) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.friendlyPlayer = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				friendlyPet =
				{
					type = 'color',
					name = L["Friendly Pets"],
					desc = L["Sets the health bar color for friendly pets"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.friendlyPet) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.friendlyPet = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				friendlyNPC =
				{
					type = 'color',
					name = L["Friendly NPCs"],
					desc = L["Sets the health bar color for friendly NPCs"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.friendlyNPC) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.friendlyNPC = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				friendlyBoss =
				{
					type = 'color',
					name = L["Friendly Boss"],
					desc = L["Sets the health bar color for friendly NPC Bosses"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.friendlyBoss) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.friendlyBoss = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				hostilePlayer =
				{
					type = 'color',
					name = L["Hostile Players"],
					desc = L["Sets the health bar color for hostile players"],
					disabled = function() return AloftHealthBar.db.profile.colorHostileByClass end,
					get = function() return unpack(AloftHealthBar.db.profile.colors.hostilePlayer) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.hostilePlayer = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				hostilePet  =
				{
					type = 'color',
					name = L["Hostile Pets"],
					desc = L["Sets the health bar color for hostile pets"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.hostilePet) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.hostilePet = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				hostileNPC =
				{
					type = 'color',
					name = L["Hostile NPCs"],
					desc = L["Sets the health bar color for hostile units"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.hostileNPC) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.hostileNPC = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				hostileBoss =
				{
					type = 'color',
					name = L["Hostile Boss"],
					desc = L["Sets the health bar color for hostile boss units"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.hostileBoss) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.hostileBoss = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				neutral =
				{
					type = 'color',
					name = L["Neutral Units"],
					desc = L["Sets the health bar color for neutral units"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.neutral) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.neutral = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				pet =
				{
					type = 'color',
					name = L["Pet"],
					desc = L["Sets the health bar color for your pet"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.pet) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.pet = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				groupPet =
				{
					type = 'color',
					name = L["Group Pets"],
					desc = L["Sets the health bar color for group pets"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.groupPet) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.groupPet = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				unknown =
				{
					type = 'color',
					name = L["Unknown"],
					desc = L["Sets the health bar color for unknown units"],
					get = function() return unpack(AloftHealthBar.db.profile.colors.unknown) end,
					set = function(r, g, b) AloftHealthBar.db.profile.colors.unknown = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				reset =
				{
					type = "execute",
					name = L["Reset to Defaults"],
					desc = L["Resets all colors to their defaults"],
					order = -1,
					func  = function()
								local colors = AloftHealthBar.db.profile.colors
								colors.backdropColor	= { 0.25, 0.25, 0.25, 0.5 }
								colors.friendlyPlayer	= { 0, 0, 1 }
								colors.friendlyPet		= { 0, 1, 0 }
								colors.friendlyNPC		= { 0, 1, 0 }
								colors.friendlyBoss		= { 0, 1, 0 }
								colors.hostilePlayer	= { 1, 0, 0 }
								colors.hostilePet		= { 1, 0, 0 }
								colors.hostileNPC		= { 1, 0, 0 }
								colors.hostileBoss		= { 1, 0, 0 }
								colors.neutral			= { 1, 1, 0 }
								colors.pet				= { 0, 1, 0 }
								colors.groupPet			= { 0, 1, 0 }
								colors.unknown			= { 0.5, 0.5, 0.5 }
								Aloft:DetermineDataSources()
								AloftHealthBar:UpdateAll()
							end,
				},
				advanced  =
				{
					type = 'group',
					name = L["Advanced"],
					desc = L["Options for expert users"],
					order = -1,
					args =
					{
						format =
						{
							type = 'text',
							name = L["Color Format"],
							desc = L["Color tag"],
							usage = L["<Any tag string>"],
							get = function() return Aloft:HighlightTagSyntax(AloftHealthBar.db.profile.colorFormat) end,
							set =	function(v)
										AloftHealthBar.db.profile.colorFormat = Aloft:FixTagCasing(v)
										AloftHealthBar.colorMethodData = nil
										AloftHealthBar.colorMethod = nil
										Aloft:DetermineDataSources()
										AloftHealthBar:UpdateAll()
									end,
						}
					},
				},
			}
		},
	},
}

-----------------------------------------------------------------------------
