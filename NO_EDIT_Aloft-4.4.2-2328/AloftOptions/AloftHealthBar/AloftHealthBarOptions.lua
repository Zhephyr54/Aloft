local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftHealthBar
if not L then return end

local AloftHealthBar = Aloft:GetModule("HealthBar")
if not AloftHealthBar then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.healthBar =
{
	type = 'group',
	name = L["Health Bar"],
	desc = L["Health Bar options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftHealthBar:IsEnabled() or not AloftHealthBar.db or not AloftHealthBar.db.profile end,
	args =
	{
		height =
		{
			type = 'range',
			width = "full",
			name = L["Height"],
			desc = L["Sets the height of the health bar"],
			order = 1,
			min = 1,
			max = 128,
			step = 1,
			get = function(i) return AloftHealthBar.db.profile.height end,
			set = function(i, v) AloftHealthBar.db.profile.height = v AloftHealthBar:UpdateAll() end
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the health bar's position"],
			order = 2,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftHealthBar:IsEnabled() or not AloftHealthBar.db or not AloftHealthBar.db.profile end,
			args =
			{
				left =
				{
					type = 'range',
					width = "full",
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the health bar"],
					order = 1,
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftHealthBar.db.profile.offsets.left end,
					set = function(i, v) AloftHealthBar.db.profile.offsets.left = v AloftHealthBar:UpdateAll() end
				},
				right =
				{
					type = 'range',
					width = "full",
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the health bar"],
					order = 2,
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftHealthBar.db.profile.offsets.right end,
					set = function(i, v) AloftHealthBar.db.profile.offsets.right = v AloftHealthBar:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					width = "full",
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the health bar"],
					order = 3,
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftHealthBar.db.profile.offsets.vertical end,
					set = function(i, v) AloftHealthBar.db.profile.offsets.vertical = v AloftHealthBar:UpdateAll() end
				},
			},
		},
		texture =
		{
			type = 'select',
			width = "full",
			name = L["Texture"],
			desc = L["Sets the health bar texture"],
			order = 3,
			get = function(i)
				for k, v in pairs(Aloft.Options.args.healthBar.args.texture.values) do
					if v == AloftHealthBar.db.profile.texture then
						return k
					end
				end
			end,
			set = function(i, v)
				AloftHealthBar.db.profile.texture = Aloft.Options.args.healthBar.args.texture.values[v]
				Aloft:DetermineDataSources() 
				AloftHealthBar:UpdateAll()
			end,
			values = SML:List("statusbar")
		},
		tileHoriz =
		{
			type = 'toggle',
			width = "full",
			name = L["Enable Horizontal Tiling"],
			desc = L["Enable horizontal tiling of the health bar texture"],
			order = 4,
			get = function(i) return AloftHealthBar.db.profile.tileHoriz end,
			set = function(i, v) AloftHealthBar.db.profile.tileHoriz = v AloftHealthBar:UpdateAll() end
		},
		border = {
			type = 'group',
			name = L["Border"],
			desc = L["Border options"],
			order = 5,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftHealthBar:IsEnabled() or not AloftHealthBar.db or not AloftHealthBar.db.profile end,
			args =
			{
				targetOnly =
				{
					type = 'toggle',
					width = "full",
					name = L["Target Only"],
					desc = L["Enables the border on the current target only"],
					order = 1,
					get = function(i) return AloftHealthBar.db.profile.targetOnly end,
					set = function(i, v) AloftHealthBar.db.profile.targetOnly = v Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end,
					disabled = function(i) return AloftHealthBar.db.profile.border == "None" end,
				},
				style =
				{
					type = 'select',
					width = "full",
					name = L["Border Style"],
					desc = L["Sets the style of the health bar border"],
					order = 2,
					get = function(i)
						for k, v in pairs(Aloft.Options.args.healthBar.args.border.args.style.values) do
							if v == AloftHealthBar.db.profile.border then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftHealthBar.db.profile.border = Aloft.Options.args.healthBar.args.border.args.style.values[v]
						AloftHealthBar:UpdateAll()
					end,
					values = SML:List("border")
				},
				edgeSize =
				{
					type = 'range',
					width = "full",
					name = L["Border Edge Size"],
					desc = L["Sets the thickness of the border"],
					min = 1,
					max = 32,
					step = 1,
					get = function(i) return AloftHealthBar.db.profile.borderEdgeSize end,
					set = function(i, v) AloftHealthBar.db.profile.borderEdgeSize = v AloftHealthBar:UpdateAll() end
				},
				inset =
				{
					type = 'range',
					width = "full",
					name = L["Border Inset"],
					desc = L["Sets the padding aroundthe border"],
					min = 0,
					max = 32,
					step = 1,
					get = function(i) return AloftHealthBar.db.profile.borderInset end,
					set = function(i, v) AloftHealthBar.db.profile.borderInset = v AloftHealthBar:UpdateAll() end
				},
				color =
				{
					type = 'color',
					width = "full",
					name = L["Border Color"],
					desc = L["Sets the border color of the health bar"],
					order = 3,
					get = function(i) return unpack(AloftHealthBar.db.profile.borderColor) end,
					set = function(i, r, g, b, a) AloftHealthBar.db.profile.borderColor = { r, g, b, a } AloftHealthBar:UpdateAll() end,
					disabled = function(i) return AloftHealthBar.db.profile.border == "None" end,
					hasAlpha = true,
				},
			},
		},
		alpha =
		{
			type = 'range',
			width = "full",
			name = L["Alpha"],
			desc = L["Sets the health bar alpha"],
			order = 6,
			min = 0,
			max = 1.0,
			step = 0.05,
			get = function(i) return AloftHealthBar.db.profile.alpha end,
			set = function(i, v) AloftHealthBar.db.profile.alpha = v AloftHealthBar:UpdateAll() end,
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize colors"],
			order = 7,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftHealthBar:IsEnabled() or not AloftHealthBar.db or not AloftHealthBar.db.profile end,
			args =
			{
				colorByClass =
				{
					type = 'toggle',
					width = "full",
					name = L["Color by Class"],
					desc = L["Sets the health bar color of players according to class"],
					get = function(i) return AloftHealthBar.db.profile.colorByClass end,
					set = function(i, v) AloftHealthBar.db.profile.colorByClass = v Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end,
					order = 1
				},
				colorHostileByClass =
				{
					type = 'toggle',
					width = "full",
					name = L["Color Hostile by Class"],
					desc = L["Sets the health bar color of hostile players according to class"],
					get = function(i) return AloftHealthBar.db.profile.colorHostileByClass end,
					set = function(i, v) AloftHealthBar.db.profile.colorHostileByClass = v Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end,
					order = 2
				},
				backdrop =
				{
					type = 'color',
					width = "full",
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the health bar"],
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.backdropColor) end,
					set = function(i, r, g, b, a) AloftHealthBar.db.profile.colors.backdropColor = { r, g, b, a } AloftHealthBar:UpdateAll() end,
					hasAlpha = true,
					order = 3
				},
				friendlyPlayer =
				{
					type = 'color',
					width = "full",
					name = L["Friendly Players"],
					desc = L["Sets the health bar color for friendly players"],
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.friendlyPlayer) end,
					set = function(i, r, g, b) AloftHealthBar.db.profile.colors.friendlyPlayer = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				friendlyPet =
				{
					type = 'color',
					width = "full",
					name = L["Friendly Pets"],
					desc = L["Sets the health bar color for friendly pets"],
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.friendlyPet) end,
					set = function(i, r, g, b) AloftHealthBar.db.profile.colors.friendlyPet = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				friendlyNPC =
				{
					type = 'color',
					width = "full",
					name = L["Friendly NPCs"],
					desc = L["Sets the health bar color for friendly NPCs"],
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.friendlyNPC) end,
					set = function(i, r, g, b) AloftHealthBar.db.profile.colors.friendlyNPC = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				friendlyBoss =
				{
					type = 'color',
					width = "full",
					name = L["Friendly Boss"],
					desc = L["Sets the health bar color for friendly NPC Bosses"],
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.friendlyBoss) end,
					set = function(i, r, g, b) AloftHealthBar.db.profile.colors.friendlyBoss = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				hostilePlayer =
				{
					type = 'color',
					width = "full",
					name = L["Hostile Players"],
					desc = L["Sets the health bar color for hostile players"],
					disabled = function(i) return AloftHealthBar.db.profile.colorHostileByClass end,
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.hostilePlayer) end,
					set = function(i, r, g, b) AloftHealthBar.db.profile.colors.hostilePlayer = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				hostilePet  =
				{
					type = 'color',
					width = "full",
					name = L["Hostile Pets"],
					desc = L["Sets the health bar color for hostile pets"],
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.hostilePet) end,
					set = function(i, r, g, b) AloftHealthBar.db.profile.colors.hostilePet = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				hostileNPC =
				{
					type = 'color',
					width = "full",
					name = L["Hostile NPCs"],
					desc = L["Sets the health bar color for hostile units"],
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.hostileNPC) end,
					set = function(i, r, g, b) AloftHealthBar.db.profile.colors.hostileNPC = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				hostileBoss =
				{
					type = 'color',
					width = "full",
					name = L["Hostile Boss"],
					desc = L["Sets the health bar color for hostile boss units"],
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.hostileBoss) end,
					set = function(i, r, g, b) AloftHealthBar.db.profile.colors.hostileBoss = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				neutral =
				{
					type = 'color',
					width = "full",
					name = L["Neutral Units"],
					desc = L["Sets the health bar color for neutral units"],
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.neutral) end,
					set = function(i, r, g, b) AloftHealthBar.db.profile.colors.neutral = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				pet =
				{
					type = 'color',
					width = "full",
					name = L["Pet"],
					desc = L["Sets the health bar color for your pet"],
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.pet) end,
					set = function(i, r, g, b) AloftHealthBar.db.profile.colors.pet = { r, g, b } AloftHealthBar:UpdateAll() end
				},
				groupPet =
				{
					type = 'color',
					width = "full",
					name = L["Group Pets"],
					desc = L["Sets the health bar color for group pets"],
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.groupPet) end,
					set = function(i, r, g, b) AloftHealthBar.db.profile.colors.groupPet = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				unknown =
				{
					type = 'color',
					name = L["Unknown"],
					desc = L["Sets the health bar color for unknown units"],
					get = function(i) return unpack(AloftHealthBar.db.profile.colors.unknown) end,
					set = function(i, r, g, b) AloftHealthBar.db.profile.colors.unknown = { r, g, b } Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end
				},
				reset =
				{
					type = 'execute',
					width = "full",
					name = L["Reset to Defaults"],
					desc = L["Resets all colors to their defaults"],
					order = -1,
					func  = function(i)
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
					disabled = function(i) return not Aloft:IsEnabled() or not AloftHealthBar:IsEnabled() or not AloftHealthBar.db or not AloftHealthBar.db.profile end,
					args =
					{
						format =
						{
							type = 'input',
							width = "full",
							name = L["Color Format"],
							desc = L["Color tag"],
							usage = L["<Any tag string>"],
							get = function(i) return Aloft:HighlightTagSyntax(AloftHealthBar.db.profile.colorFormat) end,
							set =	function(i, v)
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
		deficit =
		{
			type = 'toggle',
			name = L["Deficit Health Bar"],
			desc = L["Display health bar as a deficit (grows from right as health is lost)"],
			disabled = function(i)
							-- ChatFrame7:AddMessage("Aloft.Options.args.healthBar.args.deficit.disabled(): " .. tostring(Aloft:IsEnabled()) .. "/" .. tostring(AloftHealthBar:IsEnabled()) .. "/" .. tostring(AloftHealthBar.db) .. "/" .. tostring(AloftHealthBar.db.profile))
							return not Aloft:IsEnabled() or not AloftHealthBar:IsEnabled() or not AloftHealthBar.db or not AloftHealthBar.db.profile
						end,
			get = function(i) return AloftHealthBar.db.profile.deficit end,
			set = function(i, v) AloftHealthBar.db.profile.deficit = v Aloft:DetermineDataSources() AloftHealthBar:UpdateAll() end,
			order = 99
		},
	},
}

-----------------------------------------------------------------------------
