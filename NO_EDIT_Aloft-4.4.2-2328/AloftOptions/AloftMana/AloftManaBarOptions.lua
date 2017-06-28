local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftManaBarOptions
if not L then return end

local AloftManaBar = Aloft:GetModule("ManaBar", true)
if not AloftManaBar then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.manaBar =
{
	type = 'group',
	name = L["Mana Bar"],
	desc = L["Mana Bar options"],
	disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ManaData", true) and Aloft:GetModule("ManaData"):IsEnabled()) or not AloftManaBar:IsEnabled() or not AloftManaBar.db or not AloftManaBar.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show mana bars on group member nameplates"],
			order = 1,
			get = function(i) return AloftManaBar.db.profile.enable end,
			set = function(i, v) AloftManaBar.db.profile.enable = v Aloft:DetermineDataSources() AloftManaBar:UpdateAll() end,
		},
		height =
		{
			type = 'range',
			width = 'full',
			name = L["Height"],
			desc = L["Sets the height of the mana bar"],
			order = 2,
			min = 1,
			max = 32,
			step = 1,
			disabled = function(i) return not AloftManaBar.db.profile.enable end,
			get = function(i) return AloftManaBar.db.profile.height end,
			set = function(i, v) AloftManaBar.db.profile.height = v AloftManaBar:UpdateAll() end
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the mana bar's position"],
			order = 3,
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ManaData", true) and Aloft:GetModule("ManaData"):IsEnabled()) or not AloftManaBar:IsEnabled() or not AloftManaBar.db or not AloftManaBar.db.profile or not AloftManaBar.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					width = 'full',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the mana bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftManaBar.db.profile.offsets.left end,
					set = function(i, v) AloftManaBar.db.profile.offsets.left = v AloftManaBar:UpdateAll() end
				},
				right =
				{
					type = 'range',
					width = 'full',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the mana bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftManaBar.db.profile.offsets.right end,
					set = function(i, v) AloftManaBar.db.profile.offsets.right = v AloftManaBar:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					width = 'full',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the mana bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftManaBar.db.profile.offsets.vertical end,
					set = function(i, v) AloftManaBar.db.profile.offsets.vertical = v AloftManaBar:UpdateAll() end
				},
			},
		},
		texture =
		{
			type = 'select',
			width = 'full',
			name = L["Texture"],
			desc = L["Sets the mana bar texture"],
			order = 4,
			disabled = function(i) return not AloftManaBar.db.profile.enable end,
			get = function(i)
				for k, v in pairs(Aloft.Options.args.manaBar.args.texture.values) do
					if v == AloftManaBar.db.profile.texture then
						return k
					end
				end
			end,
			set = function(i, v)
				AloftManaBar.db.profile.texture = Aloft.Options.args.manaBar.args.texture.values[v]
				Aloft:DetermineDataSources() 
				AloftManaBar:UpdateAll()
			end,
			values = SML:List("statusbar")
		},
		border = {
			type = 'group',
			name = L["Border"],
			desc = L["Border options"],
			order = 5,
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ManaData", true) and Aloft:GetModule("ManaData"):IsEnabled()) or not AloftManaBar:IsEnabled() or not AloftManaBar.db or not AloftManaBar.db.profile or not AloftManaBar.db.profile.enable end,
			args =
			{
				targetOnly =
				{
					type = 'toggle',
					width = 'full',
					name = L["Target Only"],
					desc = L["Enables the border on the current target only"],
					order = 1,
					get = function(i) return AloftManaBar.db.profile.targetOnly end,
					set = function(i, v) AloftManaBar.db.profile.targetOnly = v Aloft:DetermineDataSources() AloftManaBar:UpdateAll() end,
					disabled = function(i) return AloftManaBar.db.profile.border == "None" end,
				},
				style =
				{
					type = 'select',
					width = 'full',
					name = L["Border Style"],
					desc = L["Sets the style of the mana bar border"],
					order = 2,
					get = function(i)
						for k, v in pairs(Aloft.Options.args.manaBar.args.border.args.style.values) do
							if v == AloftManaBar.db.profile.border then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftManaBar.db.profile.border = Aloft.Options.args.manaBar.args.border.args.style.values[v]
						AloftManaBar:UpdateAll()
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
					get = function(i) return AloftManaBar.db.profile.borderEdgeSize end,
					set = function(i, v) AloftManaBar.db.profile.borderEdgeSize = v AloftManaBar:UpdateAll() end
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
					get = function(i) return AloftManaBar.db.profile.borderInset end,
					set = function(i, v) AloftManaBar.db.profile.borderInset = v AloftManaBar:UpdateAll() end
				},
				color =
				{
					type = 'color',
					width = 'full',
					name = L["Border Color"],
					desc = L["Sets the border color of the mana bar"],
					order = 3,
					get = function(i) return unpack(AloftManaBar.db.profile.borderColor) end,
					set = function(i, r, g, b, a) AloftManaBar.db.profile.borderColor = { r, g, b, a } AloftManaBar:UpdateAll() end,
					disabled = function(i) return AloftManaBar.db.profile.border == "None" end,
					hasAlpha = true,
				},
			},
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize colors"],
			order = 6,
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ManaData", true) and Aloft:GetModule("ManaData"):IsEnabled()) or not AloftManaBar:IsEnabled() or not AloftManaBar.db or not AloftManaBar.db.profile or not AloftManaBar.db.profile.enable end,
			args =
			{
				backdrop =
				{
					type = 'color',
					width = 'full',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the mana bar"],
					get = function(i) return unpack(AloftManaBar.db.profile.backdropColor) end,
					set = function(i, r, g, b, a) AloftManaBar.db.profile.backdropColor = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				mana =
				{
					type = 'color',
					width = 'full',
					name = L["Mana Color"],
					desc = L["Sets the color for mana bars"],
					get = function(i) return unpack(AloftManaBar.db.profile.powerTypeColors[0]) end,
					set = function(i, r, g, b, a) AloftManaBar.db.profile.powerTypeColors[0] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				rage =
				{
					type = 'color',
					width = 'full',
					name = L["Rage Color"],
					desc = L["Sets the color for rage bars"],
					get = function(i) return unpack(AloftManaBar.db.profile.powerTypeColors[1]) end,
					set = function(i, r, g, b, a) AloftManaBar.db.profile.powerTypeColors[1] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				focus =
				{
					type = 'color',
					width = 'full',
					name = L["Focus Color"],
					desc = L["Sets the color for focus bars"],
					get = function(i) return unpack(AloftManaBar.db.profile.powerTypeColors[2]) end,
					set = function(i, r, g, b, a) AloftManaBar.db.profile.powerTypeColors[2] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				energy =
				{
					type = 'color',
					width = 'full',
					name = L["Energy Color"],
					desc = L["Sets the color for energy bars"],
					get = function(i) return unpack(AloftManaBar.db.profile.powerTypeColors[3]) end,
					set = function(i, r, g, b, a) AloftManaBar.db.profile.powerTypeColors[3] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				happiness =
				{
					type = 'color',
					width = 'full',
					name = L["Happiness Color"],
					desc = L["Sets the color for happiness bars"],
					get = function(i) return unpack(AloftManaBar.db.profile.powerTypeColors[4]) end,
					set = function(i, r, g, b, a) AloftManaBar.db.profile.powerTypeColors[4] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				rune =
				{
					type = 'color',
					width = 'full',
					name = L["Rune Color"],
					desc = L["Sets the color for rune bars"],
					get = function(i) return unpack(AloftManaBar.db.profile.powerTypeColors[5]) end,
					set = function(i, r, g, b, a) AloftManaBar.db.profile.powerTypeColors[5] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				runic =
				{
					type = 'color',
					width = 'full',
					name = L["Runic Power Color"],
					desc = L["Sets the color for runic power bars"],
					get = function(i) return unpack(AloftManaBar.db.profile.powerTypeColors[6]) end,
					set = function(i, r, g, b, a) AloftManaBar.db.profile.powerTypeColors[6] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				reset =
				{
					type = 'execute',
					width = 'full',
					name = L["Reset to Defaults"],
					desc = L["Resets all colors to their defaults"],
					order = -1,
					func  = function(i)
								AloftManaBar.db.profile.backdropColor	= { 0.25, 0.25, 0.25, 0.5 }
								AloftManaBar.db.profile.powerTypeColors	=
								{
									[0] = { 0.28, 0.52, 0.84, 1},	-- Mana
									[1] = { 0.89, 0.18, 0.29, 1}, 	-- Rage
									[2] = {    1, 0.82,    0, 1},	-- Focus
									[3] = {    1, 0.86, 0.10, 1}, 	-- Energy
									[4] = {    0,    1,    1, 1}, 	-- Happiness
									[5] = { 0.50, 0.50, 0.50, 1}, 	-- Runes
									[6] = { 0.92, 0.92, 0.92, 1}, 	-- Runic Power
								},
								AloftManaBar:UpdateAll()
							end,
				},
			}
		},
		--[[
		always =
		{
			type = 'toggle',
			width = 'full',
			name = L["Always Show Target"],
			desc = L["Always show mana bar on active targets in combat"],
			get = function(i) return AloftManaBar.db.profile.always end,
			set = function(i, v) AloftManaBar.db.profile.always = v Aloft:DetermineDataSources() AloftManaBar:UpdateAll() end,
			disabled = function(i) return not AloftManaBar.db.profile.enable end,
			order = 2,
		},
		]]
	},
}

-----------------------------------------------------------------------------

end)
