local Aloft = Aloft
if not Aloft or not Aloft:HasModule("CastBar") then return end

-----------------------------------------------------------------------------

local AloftCastBar = Aloft:GetModule("CastBar")

local L = AceLibrary("AceLocale-2.2"):new("AloftCastBarOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_statusbar = SML:List("statusbar")
local SML_border = SML:List("border")

-----------------------------------------------------------------------------

Aloft.Options.args.castBar =
{
	type = 'group',
	name = L["Cast Bar"],
	desc = L["Cast bar options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Shows the current target's casting bar"],
			get = function() return GetCVar("ShowVKeyCastbar") == "1" end,
			set = function(v) SetCVar("ShowVKeyCastbar", v and "1" or "0") end,
			order = 1,
		},
		height =
		{
			type = 'range',
			name = L["Height"],
			desc = L["Sets the height of the cast bar"],
			min = 1,
			max = 32,
			step = 1,
			disabled = function() return GetCVar("ShowVKeyCastbar") ~= "1" end,
			get = function() return AloftCastBar.db.profile.height end,
			set = function(v) AloftCastBar.db.profile.height = v AloftCastBar:UpdateAll() end,
			order = 2,
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust cast bar position"],
			order = 3,
			disabled = function() return GetCVar("ShowVKeyCastbar") ~= "1" end,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the cast bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftCastBar.db.profile.offsets.left end,
					set = function(v) AloftCastBar.db.profile.offsets.left = v AloftCastBar:UpdateAll() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the cast bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftCastBar.db.profile.offsets.right end,
					set = function(v) AloftCastBar.db.profile.offsets.right = v AloftCastBar:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the cast bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftCastBar.db.profile.offsets.vertical end,
					set = function(v) AloftCastBar.db.profile.offsets.vertical = v AloftCastBar:UpdateAll() end
				},
			},
		},
		interruptable =
		{
			type = 'group',
			name = L["Interruptable Cast Bar"],
			desc = L["Cast bar appearance for interruptable spells"],
			disabled = function() return GetCVar("ShowVKeyCastbar") ~= "1" end,
			order = 4,
			args =
			{
				color =
				{
					type = 'color',
					name = L["Cast Bar Color"],
					desc = L["Sets the color of the cast bar"],
					order = 1,
					get = function() return unpack(AloftCastBar.db.profile.color) end,
					set = function(r, g, b, a) AloftCastBar.db.profile.color = { r, g, b, a } AloftCastBar:UpdateAll() end,
					hasAlpha = true,
				},
				texture =
				{
					type = "text",
					name = L["Texture"],
					desc = L["Sets the cast bar texture"],
					order = 2,
					get = function() return AloftCastBar.db.profile.texture end,
					set = function(v)
						AloftCastBar.db.profile.texture = v
						AloftCastBar:UpdateAll()
					end,
					validate = SML_statusbar,
				},
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the cast bar"],
					order = 3,
					get = function() return unpack(AloftCastBar.db.profile.backdropColor) end,
					set = function(r, g, b, a) AloftCastBar.db.profile.backdropColor = { r, g, b, a } AloftCastBar:UpdateAll() end,
					hasAlpha = true,
				},
				border =
				{
					type = 'text',
					name = L["Border Style"],
					desc = L["Sets the style of the cast bar border"],
					order = 4,
					get = function() return AloftCastBar.db.profile.border end,
					set = function(v)
						AloftCastBar.db.profile.border = v
						AloftCastBar:UpdateAll()
					end,
					validate = SML_border,
				},
				borderColor =
				{
					type = 'color',
					name = L["Border Color"],
					desc = L["Sets the border color of the cast bar"],
					order = 5,
					disabled = function() return AloftCastBar.db.profile.border == "None" end,
					get = function() return unpack(AloftCastBar.db.profile.borderColor) end,
					set = function(r, g, b, a) AloftCastBar.db.profile.borderColor = { r, g, b, a } AloftCastBar:UpdateAll() end,
					hasAlpha = true,
				},
			},
		},
		uninterruptable =
		{
			type = 'group',
			name = L["Uninterruptable Cast Bar"],
			desc = L["Cast bar appearance for uninterruptable spells"],
			disabled = function() return GetCVar("ShowVKeyCastbar") ~= "1" end,
			order = 5,
			args =
			{
				color =
				{
					type = 'color',
					name = L["Cast Bar Color"],
					desc = L["Sets the color of the cast bar"],
					order = 1,
					get = function() return unpack(AloftCastBar.db.profile.nointerColor) end,
					set = function(r, g, b, a) AloftCastBar.db.profile.nointerColor = { r, g, b, a } AloftCastBar:UpdateAll() end,
					hasAlpha = true,
				},
				texture =
				{
					type = "text",
					name = L["Texture"],
					desc = L["Sets the cast bar texture"],
					order = 2,
					get = function() return AloftCastBar.db.profile.nointerTexture end,
					set = function(v)
						AloftCastBar.db.profile.nointerTexture = v
						AloftCastBar:UpdateAll()
					end,
					validate = SML_statusbar,
				},
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the cast bar"],
					order = 3,
					get = function() return unpack(AloftCastBar.db.profile.nointerBackdropColor) end,
					set = function(r, g, b, a) AloftCastBar.db.profile.nointerBackdropColor = { r, g, b, a } AloftCastBar:UpdateAll() end,
					hasAlpha = true,
				},
				border =
				{
					type = 'text',
					name = L["Border Style"],
					desc = L["Sets the style of the cast bar border"],
					order = 4,
					get = function() return AloftCastBar.db.profile.nointerBorder end,
					set = function(v)
						AloftCastBar.db.profile.nointerBorder = v
						AloftCastBar:UpdateAll()
					end,
					validate = SML_border,
				},
				borderColor =
				{
					type = 'color',
					name = L["Border Color"],
					desc = L["Sets the border color of the cast bar"],
					order = 5,
					disabled = function() return AloftCastBar.db.profile.nointerBorder == "None" end,
					get = function() return unpack(AloftCastBar.db.profile.nointerBorderColor) end,
					set = function(r, g, b, a) AloftCastBar.db.profile.nointerBorderColor = { r, g, b, a } AloftCastBar:UpdateAll() end,
					hasAlpha = true,
				},
			},
		},
	},
}

-----------------------------------------------------------------------------
