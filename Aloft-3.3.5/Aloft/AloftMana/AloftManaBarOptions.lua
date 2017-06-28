local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("ManaBar") then return end

local AloftManaBar = Aloft:GetModule("ManaBar")
local L = AceLibrary("AceLocale-2.2"):new("AloftManaBarOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_statusbar = SML:List("statusbar")
local SML_border = SML:List("border")

-----------------------------------------------------------------------------

Aloft.Options.args.manaBar =
{
	type = 'group',
	name = L["Mana Bar"],
	desc = L["Mana Bar options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show mana bars on group member nameplates"],
			order = 1,
			get = function() return AloftManaBar.db.profile.enable end,
			set = function(v) AloftManaBar.db.profile.enable = v Aloft:DetermineDataSources() AloftManaBar:UpdateAll() end,
		},
		height =
		{
			type = 'range',
			name = L["Height"],
			desc = L["Sets the height of the mana bar"],
			order = 2,
			min = 1,
			max = 32,
			step = 1,
			disabled = function() return not AloftManaBar.db.profile.enable end,
			get = function() return AloftManaBar.db.profile.height end,
			set = function(v) AloftManaBar.db.profile.height = v AloftManaBar:UpdateAll() end
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the mana bar's position"],
			order = 3,
			disabled = function() return not AloftManaBar.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the mana bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftManaBar.db.profile.offsets.left end,
					set = function(v) AloftManaBar.db.profile.offsets.left = v AloftManaBar:UpdateAll() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the mana bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftManaBar.db.profile.offsets.right end,
					set = function(v) AloftManaBar.db.profile.offsets.right = v AloftManaBar:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the mana bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftManaBar.db.profile.offsets.vertical end,
					set = function(v) AloftManaBar.db.profile.offsets.vertical = v AloftManaBar:UpdateAll() end
				},
			},
		},
		texture =
		{
			type = "text",
			name = L["Texture"],
			desc = L["Sets the mana bar texture"],
			order = 4,
			disabled = function() return not AloftManaBar.db.profile.enable end,
			get = function() return AloftManaBar.db.profile.texture end,
			set = function(v)
				AloftManaBar.db.profile.texture = v
				AloftManaBar:UpdateAll()
			end,
			validate = SML_statusbar
		},
		border = {
			type = 'group',
			name = L["Border"],
			desc = L["Border options"],
			order = 5,
			disabled = function() return not AloftManaBar.db.profile.enable end,
			args =
			{
				targetOnly =
				{
					type = 'toggle',
					name = L["Target Only"],
					desc = L["Enables the border on the current target only"],
					order = 1,
					get = function() return AloftManaBar.db.profile.targetOnly end,
					set = function(v) AloftManaBar.db.profile.targetOnly = v AloftManaBar:UpdateAll() end,
					disabled = function() return AloftManaBar.db.profile.border == "None" end,
				},
				style =
				{
					type = 'text',
					name = L["Border Style"],
					desc = L["Sets the style of the mana bar border"],
					order = 2,
					get = function() return AloftManaBar.db.profile.border end,
					set = function(v)
						AloftManaBar.db.profile.border = v
						AloftManaBar:UpdateAll()
					end,
					validate = SML_border
				},
				color =
				{
					type = 'color',
					name = L["Border Color"],
					desc = L["Sets the border color of the mana bar"],
					order = 3,
					get = function() return unpack(AloftManaBar.db.profile.borderColor) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.borderColor = { r, g, b, a } AloftManaBar:UpdateAll() end,
					disabled = function() return AloftManaBar.db.profile.border == "None" end,
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
			disabled = function() return not AloftManaBar.db.profile.enable end,
			args =
			{
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the mana bar"],
					get = function() return unpack(AloftManaBar.db.profile.backdropColor) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.backdropColor = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				mana =
				{
					type = 'color',
					name = L["Mana Color"],
					desc = L["Sets the color for mana bars"],
					get = function() return unpack(AloftManaBar.db.profile.powerTypeColors[0]) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.powerTypeColors[0] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				rage =
				{
					type = 'color',
					name = L["Rage Color"],
					desc = L["Sets the color for rage bars"],
					get = function() return unpack(AloftManaBar.db.profile.powerTypeColors[1]) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.powerTypeColors[1] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				focus =
				{
					type = 'color',
					name = L["Focus Color"],
					desc = L["Sets the color for focus bars"],
					get = function() return unpack(AloftManaBar.db.profile.powerTypeColors[2]) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.powerTypeColors[2] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				energy =
				{
					type = 'color',
					name = L["Energy Color"],
					desc = L["Sets the color for energy bars"],
					get = function() return unpack(AloftManaBar.db.profile.powerTypeColors[3]) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.powerTypeColors[3] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				happiness =
				{
					type = 'color',
					name = L["Happiness Color"],
					desc = L["Sets the color for happiness bars"],
					get = function() return unpack(AloftManaBar.db.profile.powerTypeColors[4]) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.powerTypeColors[4] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				rune =
				{
					type = 'color',
					name = L["Rune Color"],
					desc = L["Sets the color for rune bars"],
					get = function() return unpack(AloftManaBar.db.profile.powerTypeColors[5]) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.powerTypeColors[5] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				runic =
				{
					type = 'color',
					name = L["Runic Power Color"],
					desc = L["Sets the color for runic power bars"],
					get = function() return unpack(AloftManaBar.db.profile.powerTypeColors[6]) end,
					set = function(r, g, b, a) AloftManaBar.db.profile.powerTypeColors[6] = { r, g, b, a } AloftManaBar:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				reset =
				{
					type = "execute",
					name = L["Reset to Defaults"],
					desc = L["Resets all colors to their defaults"],
					order = -1,
					func  = function()
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
			name = L["Always Show Target"],
			desc = L["Always show mana bar on active targets in combat"],
			get = function() return AloftManaBar.db.profile.always end,
			set = function(v) AloftManaBar.db.profile.always = v Aloft:DetermineDataSources() AloftManaBar:UpdateAll() end,
			disabled = function() return not AloftManaBar.db.profile.enable end,
			order = 2,
		},
		]]
	},
}

-----------------------------------------------------------------------------

end)
