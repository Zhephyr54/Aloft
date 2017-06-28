local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftFrame
if not L then return end

local AloftFrame = Aloft:GetModule("Frame")
if not AloftFrame then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.frame =
{
	type = 'group',
	name = L["Frame"],
	desc = L["Frame options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftFrame:IsEnabled() or not AloftFrame.db or not AloftFrame.db.profile end,
	args =
	{
		enableMouse  =
		{
			type = 'toggle',
			width = "full",
			name = L["Enable Mouse"],
			desc = L["Allows left click to target and right click to interact"],
			order = 1,
			get = function(i) return AloftFrame.db.profile.enableMouse end,
			set = function(i, v) AloftFrame.db.profile.enableMouse = v AloftFrame:UpdateAll() end,
		},
		height =
		{
			type = 'range',
			width = "full",
			name = L["Height"],
			desc = L["Sets the height of the frame"],
			order = 2,
			min = 1,
			max = 128,
			step = 1,
			get = function(i) return AloftFrame.db.profile.height end,
			set = function(i, v)
				if AloftFrame.db.profile.height ~= v then
					AloftFrame.db.profile.height = v
					--AloftFrame.db.profile.packingHeight = v
					AloftFrame:UpdateAll()
				end
			end,
		},
		width =
		{
			type = 'range',
			width = "full",
			name = L["Width"],
			desc = L["Sets the width of the frame"],
			order = 3,
			min = 40,
			max = 256,
			step = 1,
			get = function(i) return AloftFrame.db.profile.width end,
			set = function(i, v)
				if AloftFrame.db.profile.width ~= v then
					AloftFrame.db.profile.width = v
					--AloftFrame.db.profile.packingWidth = v
					AloftFrame:UpdateAll()
				end
			end,
		},
		packingHeight =
		{
			type = 'range',
			width = "full",
			name = L["Packing Height"],
			desc = L["Sets the minimum vertical distance between frames"],
			order = 4,
			min = -10,
			max = 160,
			step = 1,
			get = function(i) return AloftFrame.db.profile.packingHeight end,
			set = function(i, v) AloftFrame.db.profile.packingHeight = v AloftFrame:UpdateAll() end,
		},
		packingWidth =
		{
			type = 'range',
			width = "full",
			name = L["Packing Width"],
			desc = L["Sets the minimum horizontal distance between frames"],
			order = 5,
			min = -10,
			max = 100,
			step = 1,
			get = function(i) return AloftFrame.db.profile.packingWidth end,
			set = function(i, v) AloftFrame.db.profile.packingWidth = v AloftFrame:UpdateAll() end,
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust layout base and background position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftFrame:IsEnabled() or not AloftFrame.db or not AloftFrame.db.profile end,
			order = 6,
			args =
			{
				offsetX =
				{
					type = 'range',
					width = "full",
					name = L["X Offset"],
					desc = L["X offset of the layout base and background"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftFrame.db.profile.offsetX end,
					set = function(i, v) AloftFrame.db.profile.offsetX = v AloftFrame:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = "full",
					name = L["Y Offset"],
					desc = L["Y offset of the layout base and background"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftFrame.db.profile.offsetY end,
					set = function(i, v) AloftFrame.db.profile.offsetY = v AloftFrame:UpdateAll() end
				},
			},
		},
		border = {
			type = 'group',
			name = L["Border"],
			desc = L["Border options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftFrame:IsEnabled() or not AloftFrame.db or not AloftFrame.db.profile end,
			order = 7,
			args =
			{
				targetOnly =
				{
					type = 'toggle',
					width = "full",
					name = L["Target Only"],
					desc = L["Enables the border on the current target only"],
					order = 1,
					get = function(i) return AloftFrame.db.profile.targetOnly end,
					set = function(i, v) AloftFrame.db.profile.targetOnly = v Aloft:DetermineDataSources() AloftFrame:UpdateAll() end,
					disabled = function(i) return AloftFrame.db.profile.border == "None" end,
				},
				style =
				{
					type = 'select',
					width = "full",
					name = L["Border Style"],
					desc = L["Sets the style of the nameplate border"],
					order = 2,
					get = function(i)
						for k, v in pairs(Aloft.Options.args.frame.args.border.args.style.values) do
							if v == AloftFrame.db.profile.border then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftFrame.db.profile.border = Aloft.Options.args.frame.args.border.args.style.values[v]
						AloftFrame:UpdateAll()
					end,
					values = SML:List("border"),
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
					get = function(i) return AloftFrame.db.profile.borderEdgeSize end,
					set = function(i, v) AloftFrame.db.profile.borderEdgeSize = v AloftFrame:UpdateAll() end
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
					get = function(i) return AloftFrame.db.profile.borderInset end,
					set = function(i, v) AloftFrame.db.profile.borderInset = v AloftFrame:UpdateAll() end
				},
				color =
				{
					type = 'color',
					width = "full",
					name = L["Border Color"],
					desc = L["Sets the border color of the nameplate"],
					order = 3,
					get = function(i) return unpack(AloftFrame.db.profile.borderColor) end,
					set = function(i, r, g, b, a) AloftFrame.db.profile.borderColor = { r, g, b, a } AloftFrame:UpdateAll() end,
					disabled = function(i) return AloftFrame.db.profile.border == "None" end,
					hasAlpha = true,
				},
			},
		},
		background = {
			type = 'group',
			name = L["Background"],
			desc = L["Background options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftFrame:IsEnabled() or not AloftFrame.db or not AloftFrame.db.profile end,
			order = 8,
			args =
			{
				alpha =
				{
					type = 'range',
					width = "full",
					name = L["Background Alpha"],
					desc = L["Sets the alpha for the background of the nameplates"],
					min = 0,
					max = 1,
					step = 0.01,
					get = function(i) return AloftFrame.db.profile.backgroundAlpha end,
					set = function(i, v)
						local oldShow = (AloftFrame.db.profile.backgroundAlpha ~= 0)
						AloftFrame.db.profile.backgroundAlpha = v
						local newShow = (v ~= 0)
						if oldShow ~= newShow then
							Aloft:DetermineDataSources()
						end
						AloftFrame:UpdateAll()
					end,
				},
				style =
				{
					type = 'select',
					width = "full",
					name = L["Background Style"],
					desc = L["Sets the style of the nameplate background"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.frame.args.background.args.style.values) do
							if v == AloftFrame.db.profile.background then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftFrame.db.profile.background = Aloft.Options.args.frame.args.background.args.style.values[v]
						AloftFrame:UpdateAll()
					end,
					values = SML:List("background"),
				},
				colors =
				{
					type = 'group',
					name = L["Background Colors"],
					desc = L["Customize colors"],
					disabled = function(i) return not Aloft:IsEnabled() or not AloftFrame:IsEnabled() or not AloftFrame.db or not AloftFrame.db.profile end,
					args =
					{
						colorByClass =
						{
							type = 'toggle',
							width = "full",
							name = L["Color by Class"],
							desc = L["Sets the background color according to class"],
							get = function(i) return AloftFrame.db.profile.colorByClass end,
							set = function(i, v) AloftFrame.db.profile.colorByClass = v Aloft:DetermineDataSources() AloftFrame:UpdateAll() end,
							order = 1
						},
						colorHostileByClass =
						{
							type = 'toggle',
							width = "full",
							name = L["Color Hostile by Class"],
							desc = L["Sets the background color of hostile players according to class"],
							get = function(i) return AloftFrame.db.profile.colorHostileByClass end,
							set = function(i, v) AloftFrame.db.profile.colorHostileByClass = v Aloft:DetermineDataSources() AloftFrame:UpdateAll() end,
							order = 2
						},
						setAll =
						{
							type = 'color',
							width = "full",
							name = L["Set All"],
							desc = L["Sets the background color for all types"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.friendlyPlayer) end,
							set = function(i, r, g, b)
								AloftFrame.db.profile.backgroundColors.friendlyPlayer	= { r, g, b }
								AloftFrame.db.profile.backgroundColors.friendlyPet		= { r, g, b }
								AloftFrame.db.profile.backgroundColors.friendlyNPC		= { r, g, b }
								AloftFrame.db.profile.backgroundColors.friendlyBoss		= { r, g, b }
								AloftFrame.db.profile.backgroundColors.hostilePlayer	= { r, g, b }
								AloftFrame.db.profile.backgroundColors.hostilePet		= { r, g, b }
								AloftFrame.db.profile.backgroundColors.hostileNPC		= { r, g, b }
								AloftFrame.db.profile.backgroundColors.hostileBoss		= { r, g, b }
								AloftFrame.db.profile.backgroundColors.neutral			= { r, g, b }
								AloftFrame.db.profile.backgroundColors.pet				= { r, g, b }
								AloftFrame.db.profile.backgroundColors.groupPet			= { r, g, b }
								AloftFrame.db.profile.backgroundColors.unknown			= { r, g, b }
								Aloft:DetermineDataSources()
								AloftFrame:UpdateAll() end,
							order = 3
						},
						setAllFriendly =
						{
							type = 'color',
							width = "full",
							name = L["Set All Friendly"],
							desc = L["Sets the background color for all friendly types"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.friendlyPlayer) end,
							set = function(i, r, g, b)
								AloftFrame.db.profile.backgroundColors.friendlyPlayer	= { r, g, b }
								AloftFrame.db.profile.backgroundColors.friendlyPet		= { r, g, b }
								AloftFrame.db.profile.backgroundColors.friendlyNPC		= { r, g, b }
								AloftFrame.db.profile.backgroundColors.friendlyBoss		= { r, g, b }
								AloftFrame.db.profile.backgroundColors.pet				= { r, g, b }
								AloftFrame.db.profile.backgroundColors.groupPet			= { r, g, b }
								Aloft:DetermineDataSources()
								AloftFrame:UpdateAll() end,
							order = 4
						},
						setAllHostile =
						{
							type = 'color',
							width = "full",
							name = L["Set All Hostile"],
							desc = L["Sets the background color for all hostile types"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.hostileNPC) end,
							set = function(i, r, g, b)
								AloftFrame.db.profile.backgroundColors.hostilePlayer	= { r, g, b }
								AloftFrame.db.profile.backgroundColors.hostilePet		= { r, g, b }
								AloftFrame.db.profile.backgroundColors.hostileNPC		= { r, g, b }
								AloftFrame.db.profile.backgroundColors.hostileBoss		= { r, g, b }
								Aloft:DetermineDataSources()
								AloftFrame:UpdateAll() end,
							order = 5
						},
						friendlyPlayer =
						{
							type = 'color',
							width = "full",
							name = L["Friendly Players"],
							desc = L["Sets the background color for friendly players"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.friendlyPlayer) end,
							set = function(i, r, g, b) AloftFrame.db.profile.backgroundColors.friendlyPlayer = { r, g, b } AloftFrame:UpdateAll() end
						},
						friendlyPet =
						{
							type = 'color',
							width = "full",
							name = L["Friendly Pets"],
							desc = L["Sets the background color for friendly pets"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.friendlyPet) end,
							set = function(i, r, g, b) AloftFrame.db.profile.backgroundColors.friendlyPet = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
						},
						friendlyNPC =
						{
							type = 'color',
							width = "full",
							name = L["Friendly NPCs"],
							desc = L["Sets the background color for friendly NPCs"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.friendlyNPC) end,
							set = function(i, r, g, b) AloftFrame.db.profile.backgroundColors.friendlyNPC = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
						},
						friendlyBoss =
						{
							type = 'color',
							width = "full",
							name = L["Friendly Boss"],
							desc = L["Sets the background color for friendly NPC Bosses"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.friendlyBoss) end,
							set = function(i, r, g, b) AloftFrame.db.profile.backgroundColors.friendlyBoss = { r, g, b } AloftFrame:UpdateAll() end
						},
						hostilePlayer =
						{
							type = 'color',
							width = "full",
							name = L["Hostile Players"],
							desc = L["Sets the background color for hostile players"],
							disabled = function(i) return AloftFrame.db.profile.colorHostileByClass end,
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.hostilePlayer) end,
							set = function(i, r, g, b) AloftFrame.db.profile.backgroundColors.hostilePlayer = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
						},
						hostilePet  =
						{
							type = 'color',
							width = "full",
							name = L["Hostile Pets"],
							desc = L["Sets the background color for hostile pets"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.hostilePet) end,
							set = function(i, r, g, b) AloftFrame.db.profile.backgroundColors.hostilePet = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
						},
						hostileNPC =
						{
							type = 'color',
							width = "full",
							name = L["Hostile NPCs"],
							desc = L["Sets the background color for hostile units"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.hostileNPC) end,
							set = function(i, r, g, b) AloftFrame.db.profile.backgroundColors.hostileNPC = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
						},
						hostileBoss =
						{
							type = 'color',
							width = "full",
							name = L["Hostile Boss"],
							desc = L["Sets the background color for hostile boss units"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.hostileBoss) end,
							set = function(i, r, g, b) AloftFrame.db.profile.backgroundColors.hostileBoss = { r, g, b } AloftFrame:UpdateAll() end
						},
						neutral =
						{
							type = 'color',
							width = "full",
							name = L["Neutral Units"],
							desc = L["Sets the background color for neutral units"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.neutral) end,
							set = function(i, r, g, b) AloftFrame.db.profile.backgroundColors.neutral = { r, g, b } AloftFrame:UpdateAll() end
						},
						pet =
						{
							type = 'color',
							width = "full",
							name = L["Pet"],
							desc = L["Sets the background color for your pet"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.pet) end,
							set = function(i, r, g, b) AloftFrame.db.profile.backgroundColors.pet = { r, g, b } AloftFrame:UpdateAll() end
						},
						groupPet =
						{
							type = 'color',
							width = "full",
							name = L["Group Pets"],
							desc = L["Sets the background color for group pets"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.groupPet) end,
							set = function(i, r, g, b) AloftFrame.db.profile.backgroundColors.groupPet = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
						},
						unknown =
						{
							type = 'color',
							name = L["Unknown"],
							desc = L["Sets the background color for unknown units"],
							get = function(i) return unpack(AloftFrame.db.profile.backgroundColors.unknown) end,
							set = function(i, r, g, b) AloftFrame.db.profile.backgroundColors.unknown = { r, g, b } Aloft:DetermineDataSources() AloftFrame:UpdateAll() end
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
									type = 'input',
									width = "full",
									name = L["Color Format"],
									desc = L["Color tag"],
									usage = L["<Any tag string>"],
									get = function(i) return Aloft:HighlightTagSyntax(AloftFrame.db.profile.colorFormat) end,
									set =	function(i, v)
												AloftFrame.db.profile.colorFormat = Aloft:FixTagCasing(v)
												AloftFrame.colorMethodData = nil
												AloftFrame.colorMethod = nil
												Aloft:DetermineDataSources()
												AloftFrame:UpdateAll()
											end,
									disabled = function(i) return not Aloft:IsEnabled() or not AloftFrame:IsEnabled() or not AloftFrame.db or not AloftFrame.db.profile end,
								}
							},
						},
					}
				},
			},
		},
	},
}

-----------------------------------------------------------------------------
