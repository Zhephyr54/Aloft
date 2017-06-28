local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftCastBarOptions
if not L then return end

local AloftCastBar = Aloft:GetModule("CastBar", true)
if not AloftCastBar then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.castBar =
{
	type = 'group',
	name = L["Cast Bar"],
	desc = L["Cast bar options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCastBar:IsEnabled() or not AloftCastBar.db or not AloftCastBar.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Shows the current target's casting bar"],
			get = function(i)
				-- ChatFrame7:AddMessage("AloftCastBarOptions:enbable.get(): " .. tostring(Aloft:GetNameplateCVar("ShowVKeyCastbar")))
				return Aloft:GetNameplateCVar("ShowVKeyCastbar")
			end,
			set = function(i, v)
				Aloft:SetNameplateCVar("ShowVKeyCastbar", v)
				-- ChatFrame7:AddMessage("AloftCastBarOptions:enbable.set(): " .. tostring(Aloft:GetNameplateCVar("ShowVKeyCastbar")))
			end,
			order = 1,
		},
		incremental =
		{
			type = 'toggle',
			width = 'full',
			name = L["Incremetal"],
			desc = L["Update incrementally; workaround for malformed borders, only relevant when borders are enabled"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastBar:IsEnabled() or not AloftCastBar.db or not AloftCastBar.db.profile or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			get = function(i) return AloftCastBar.db.profile.incremental end,
			set = function(i, v) AloftCastBar.db.profile.incremental = v end,
			order = 2,
		},
		height =
		{
			type = 'range',
			width = 'full',
			name = L["Height"],
			desc = L["Sets the height of the cast bar"],
			min = 1,
			max = 32,
			step = 1,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastBar:IsEnabled() or not AloftCastBar.db or not AloftCastBar.db.profile or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			get = function(i) return AloftCastBar.db.profile.height end,
			set = function(i, v) AloftCastBar.db.profile.height = v AloftCastBar:UpdateAll() end,
			order = 3,
		},
		position =
		{
			type = 'group',
			width = 'full',
			name = L["Position"],
			desc = L["Adjust cast bar position"],
			order = 4,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastBar:IsEnabled() or not AloftCastBar.db or not AloftCastBar.db.profile or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			args =
			{
				left =
				{
					type = 'range',
					width = 'full',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the cast bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftCastBar.db.profile.offsets.left end,
					set = function(i, v) AloftCastBar.db.profile.offsets.left = v AloftCastBar:UpdateAll() end
				},
				right =
				{
					type = 'range',
					width = 'full',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the cast bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftCastBar.db.profile.offsets.right end,
					set = function(i, v) AloftCastBar.db.profile.offsets.right = v AloftCastBar:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					width = 'full',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the cast bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftCastBar.db.profile.offsets.vertical end,
					set = function(i, v) AloftCastBar.db.profile.offsets.vertical = v AloftCastBar:UpdateAll() end
				},
			},
		},
		interruptable =
		{
			type = 'group',
			name = L["Interruptable Cast Bar"],
			desc = L["Cast bar appearance for interruptable spells"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastBar:IsEnabled() or not AloftCastBar.db or not AloftCastBar.db.profile or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			order = 5,
			args =
			{
				color =
				{
					type = 'color',
					width = 'full',
					name = L["Cast Bar Color"],
					desc = L["Sets the color of the cast bar"],
					order = 1,
					get = function(i) return unpack(AloftCastBar.db.profile.color) end,
					set = function(i, r, g, b, a) AloftCastBar.db.profile.color = { r, g, b, a } AloftCastBar:UpdateAll() end,
					hasAlpha = true,
				},
				texture =
				{
					type = 'select',
					width = 'full',
					name = L["Texture"],
					desc = L["Sets the cast bar texture"],
					order = 2,
					get = function(i)
						for k, v in pairs(Aloft.Options.args.castBar.args.interruptable.args.texture.values) do
							if v == AloftCastBar.db.profile.texture then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftCastBar.db.profile.texture = Aloft.Options.args.castBar.args.interruptable.args.texture.values[v]
						AloftCastBar:UpdateAll()
					end,
					values = SML:List("statusbar"),
				},
				backdrop =
				{
					type = 'color',
					width = 'full',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the cast bar"],
					order = 3,
					get = function(i) return unpack(AloftCastBar.db.profile.backdropColor) end,
					set = function(i, r, g, b, a) AloftCastBar.db.profile.backdropColor = { r, g, b, a } AloftCastBar:UpdateAll() end,
					hasAlpha = true,
				},
				border =
				{
					type = 'select',
					width = 'full',
					name = L["Border Style"],
					desc = L["Sets the style of the cast bar border"],
					order = 4,
					get = function(i)
						for k, v in pairs(Aloft.Options.args.castBar.args.interruptable.args.border.values) do
							if v == AloftCastBar.db.profile.border then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftCastBar.db.profile.border = Aloft.Options.args.castBar.args.interruptable.args.border.values[v]
						AloftCastBar:UpdateAll()
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
					get = function(i) return AloftCastBar.db.profile.borderEdgeSize end,
					set = function(i, v) AloftCastBar.db.profile.borderEdgeSize = v AloftCastBar:UpdateAll() end
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
					get = function(i) return AloftCastBar.db.profile.borderInset end,
					set = function(i, v) AloftCastBar.db.profile.borderInset = v AloftCastBar:UpdateAll() end
				},
				borderColor =
				{
					type = 'color',
					width = 'full',
					name = L["Border Color"],
					desc = L["Sets the border color of the cast bar"],
					order = 5,
					disabled = function(i) return AloftCastBar.db.profile.border == "None" end,
					get = function(i) return unpack(AloftCastBar.db.profile.borderColor) end,
					set = function(i, r, g, b, a) AloftCastBar.db.profile.borderColor = { r, g, b, a } AloftCastBar:UpdateAll() end,
					hasAlpha = true,
				},
			},
		},
		uninterruptable =
		{
			type = 'group',
			name = L["Uninterruptable Cast Bar"],
			desc = L["Cast bar appearance for uninterruptable spells"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastBar:IsEnabled() or not AloftCastBar.db or not AloftCastBar.db.profile or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			order = 6,
			args =
			{
				color =
				{
					type = 'color',
					width = 'full',
					name = L["Cast Bar Color"],
					desc = L["Sets the color of the cast bar"],
					order = 1,
					get = function(i) return unpack(AloftCastBar.db.profile.nointerColor) end,
					set = function(i, r, g, b, a) AloftCastBar.db.profile.nointerColor = { r, g, b, a } AloftCastBar:UpdateAll() end,
					hasAlpha = true,
				},
				texture =
				{
					type = 'select',
					width = 'full',
					name = L["Texture"],
					desc = L["Sets the cast bar texture"],
					order = 2,
					get = function(i)
						for k, v in pairs(Aloft.Options.args.castBar.args.uninterruptable.args.texture.values) do
							if v == AloftCastBar.db.profile.nointerTexture then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftCastBar.db.profile.nointerTexture = Aloft.Options.args.castBar.args.uninterruptable.args.texture.values[v]
						AloftCastBar:UpdateAll()
					end,
					values = SML:List("statusbar"),
				},
				backdrop =
				{
					type = 'color',
					width = 'full',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the cast bar"],
					order = 3,
					get = function(i) return unpack(AloftCastBar.db.profile.nointerBackdropColor) end,
					set = function(i, r, g, b, a) AloftCastBar.db.profile.nointerBackdropColor = { r, g, b, a } AloftCastBar:UpdateAll() end,
					hasAlpha = true,
				},
				border =
				{
					type = 'select',
					width = 'full',
					name = L["Border Style"],
					desc = L["Sets the style of the cast bar border"],
					order = 4,
					get = function(i)
						for k, v in pairs(Aloft.Options.args.castBar.args.uninterruptable.args.border.values) do
							if v == AloftCastBar.db.profile.nointerBorder then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftCastBar.db.profile.nointerBorder = Aloft.Options.args.castBar.args.uninterruptable.args.border.values[v]
						AloftCastBar:UpdateAll()
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
					get = function(i) return AloftCastBar.db.profile.nointerBorderEdgeSize end,
					set = function(i, v) AloftCastBar.db.profile.nointerBorderEdgeSize = v AloftCastBar:UpdateAll() end
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
					get = function(i) return AloftCastBar.db.profile.nointerBorderInset end,
					set = function(i, v) AloftCastBar.db.profile.nointerBorderInset = v AloftCastBar:UpdateAll() end
				},
				borderColor =
				{
					type = 'color',
					width = 'full',
					name = L["Border Color"],
					desc = L["Sets the border color of the cast bar"],
					order = 5,
					disabled = function(i) return AloftCastBar.db.profile.nointerBorder == "None" end,
					get = function(i) return unpack(AloftCastBar.db.profile.nointerBorderColor) end,
					set = function(i, r, g, b, a) AloftCastBar.db.profile.nointerBorderColor = { r, g, b, a } AloftCastBar:UpdateAll() end,
					hasAlpha = true,
				},
			},
		},
	},
}

-----------------------------------------------------------------------------
