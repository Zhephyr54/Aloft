local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftThreatBarOptions
if not L then return end

local AloftThreatBar = Aloft:GetModule("ThreatBar", true)
if not AloftThreatBar then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.threatBar =
{
	type = 'group',
	name = L["Threat Bar"],
	desc = L["Threat Bar options"],
	disabled = function(i)
					-- ChatFrame7:AddMessage("Aloft.Options.args.threatBar.disabled(): " .. tostring(Aloft:IsEnabled()) .. "/" .. tostring(AloftThreatBar:IsEnabled()) .. "/" .. tostring(AloftThreatBar.db) .. "/" .. tostring(AloftThreatBar.db.profile))
					return not Aloft:IsEnabled() or not AloftThreatBar:IsEnabled() or not AloftThreatBar.db or not AloftThreatBar.db.profile
				end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show threat bars on group member nameplates"],
			order = 1,
			get = function(i) return AloftThreatBar.db.profile.enable end,
			set = function(i, v) AloftThreatBar.db.profile.enable = v Aloft:DetermineDataSources() AloftThreatBar:UpdateAll() end,
		},
		incremental =
		{
			type = 'toggle',
			width = 'full',
			name = L["Incremetal"],
			desc = L["Update incrementally; workaround for malformed borders, only relevant when borders are enabled"],
			order = 2,
			disabled = function(i) return not AloftThreatBar.db.profile.enable or not (Aloft:GetModule("ThreatData", true) and Aloft:GetModule("ThreatData"):IsEnabled()) or AloftThreatBar.db.profile.border == "None" end,
			get = function(i) return AloftThreatBar.db.profile.incremental end,
			set = function(i, v) AloftThreatBar.db.profile.incremental = v end,
		},
		activeWhileSolo =
		{
			type = 'toggle',
			width = 'full',
			name = L["Active While Solo"],
			desc = L["Show threat bars on nameplates while solo (for classes with pets and guardians)"],
			order = 3,
			disabled = function(i) return not AloftThreatBar.db.profile.enable or not (Aloft:GetModule("ThreatData", true) and Aloft:GetModule("ThreatData"):IsEnabled()) end,
			get = function(i) return AloftThreatBar.db.profile.activeWhileSolo end,
			set = function(i, v) AloftThreatBar.db.profile.activeWhileSolo = v Aloft:DetermineDataSources() AloftThreatBar:UpdateAll() end,
		},
		texture =
		{
			type = 'select',
			width = 'full',
			name = L["Texture"],
			desc = L["Sets the threat bar texture"],
			order = 6,
			disabled = function(i) return not AloftThreatBar.db.profile.enable or not (Aloft:GetModule("ThreatData", true) and Aloft:GetModule("ThreatData"):IsEnabled()) end,
			get = function(i)
				for k, v in pairs(Aloft.Options.args.threatBar.args.texture.values) do
					if v == AloftThreatBar.db.profile.texture then
						return k
					end
				end
			end,
			set = function(i, v)
				AloftThreatBar.db.profile.texture = Aloft.Options.args.threatBar.args.texture.values[v]
				Aloft:DetermineDataSources() 
				AloftThreatBar:UpdateAll()
			end,
			values = SML:List("statusbar"),
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the threat bar's position"],
			order = 7,
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ThreatData", true) and Aloft:GetModule("ThreatData"):IsEnabled()) or not AloftThreatBar:IsEnabled() or not AloftThreatBar.db or not AloftThreatBar.db.profile or not AloftThreatBar.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					width = 'full',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the threat bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftThreatBar.db.profile.offsets.left end,
					set = function(i, v) AloftThreatBar.db.profile.offsets.left = v AloftThreatBar:UpdateAll() end,
				},
				right =
				{
					type = 'range',
					width = 'full',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the threat bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftThreatBar.db.profile.offsets.right end,
					set = function(i, v) AloftThreatBar.db.profile.offsets.right = v AloftThreatBar:UpdateAll() end,
				},
				vertical =
				{
					type = 'range',
					width = 'full',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the threat bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftThreatBar.db.profile.offsets.vertical end,
					set = function(i, v) AloftThreatBar.db.profile.offsets.vertical = v AloftThreatBar:UpdateAll() end,
				},
			},
		},
		height =
		{
			type = 'range',
			width = 'full',
			name = L["Height"],
			desc = L["Sets the height of the threat bar"],
			order = 8,
			min = 1,
			max = 32,
			step = 1,
			disabled = function(i) return not AloftThreatBar.db.profile.enable or not (Aloft:GetModule("ThreatData", true) and Aloft:GetModule("ThreatData"):IsEnabled()) end,
			get = function(i) return AloftThreatBar.db.profile.height end,
			set = function(i, v) AloftThreatBar.db.profile.height = v AloftThreatBar:UpdateAll() end,
		},
		border = {
			type = 'group',
			name = L["Border"],
			desc = L["Border options"],
			order = 9,
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ThreatData", true) and Aloft:GetModule("ThreatData"):IsEnabled()) or not AloftThreatBar:IsEnabled() or not AloftThreatBar.db or not AloftThreatBar.db.profile or not AloftThreatBar.db.profile.enable end,
			args =
			{
				targetOnly =
				{
					type = 'toggle',
					width = 'full',
					name = L["Target Only"],
					desc = L["Enables the border on the current target only"],
					order = 1,
					get = function(i) return AloftThreatBar.db.profile.targetOnly end,
					set = function(i, v) AloftThreatBar.db.profile.targetOnly = v Aloft:DetermineDataSources() AloftThreatBar:UpdateAll() end,
					disabled = function(i) return AloftThreatBar.db.profile.border == "None" end,
				},
				style =
				{
					type = 'select',
					width = 'full',
					name = L["Border Style"],
					desc = L["Sets the style of the threat bar border"],
					order = 2,
					get = function(i)
						for k, v in pairs(Aloft.Options.args.threatBar.args.border.args.style.values) do
							if v == AloftThreatBar.db.profile.border then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftThreatBar.db.profile.border = Aloft.Options.args.threatBar.args.border.args.style.values[v]
						AloftThreatBar:UpdateAll()
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
					get = function(i) return AloftThreatBar.db.profile.borderEdgeSize end,
					set = function(i, v) AloftThreatBar.db.profile.borderEdgeSize = v AloftThreatBar:UpdateAll() end
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
					get = function(i) return AloftThreatBar.db.profile.borderInset end,
					set = function(i, v) AloftThreatBar.db.profile.borderInset = v AloftThreatBar:UpdateAll() end
				},
				color =
				{
					type = 'color',
					width = 'full',
					name = L["Border Color"],
					order = 3,
					desc = L["Sets the border color of the threat bar"],
					get = function(i) return unpack(AloftThreatBar.db.profile.borderColor) end,
					set = function(i, r, g, b, a) AloftThreatBar.db.profile.borderColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					disabled = function(i) return AloftThreatBar.db.profile.border == "None" end,
					hasAlpha = true,
				},
			},
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize colors"],
			order = 11,
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ThreatData", true) and Aloft:GetModule("ThreatData"):IsEnabled()) or not AloftThreatBar:IsEnabled() or not AloftThreatBar.db or not AloftThreatBar.db.profile or not AloftThreatBar.db.profile.enable end,
			args =
			{
				backdrop =
				{
					type = 'color',
					width = 'full',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the threat bar"],
					order = 1,
					get = function(i) return unpack(AloftThreatBar.db.profile.backdropColor) end,
					set = function(i, r, g, b, a) AloftThreatBar.db.profile.backdropColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
				},
				commonThreat =
				{
					type = 'color',
					width = 'full',
					name = L["Common Threat Color"],
					desc = L["Sets the threat color for the threat bar when indicating common threat"],
					order = 2,
					get = function(i) return unpack(AloftThreatBar.db.profile.commonThreatColor) end,
					set = function(i, r, g, b, a) AloftThreatBar.db.profile.commonThreatColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
				},
				maximumThreat =
				{
					type = 'color',
					width = 'full',
					name = L["Maximum Threat Color"],
					order = 3,
					desc = L["Sets the threat color for the threat bar when indicating maximum threat"],
					get = function(i) return unpack(AloftThreatBar.db.profile.maximumThreatColor) end,
					set = function(i, r, g, b, a) AloftThreatBar.db.profile.maximumThreatColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
				},
				reset =
				{
					type = 'execute',
					width = 'full',
					name = L["Reset to Defaults"],
					desc = L["Resets all colors to their defaults"],
					order = -1,
					func  = function(i)
								AloftThreatBar.db.profile.backgroundColor		= { 0.25, 0.25, 0.25, 0.5 }
								AloftThreatBar.db.profile.commonThreatColor		= { 1.0, 1.0, 0.0, 1.0 }
								AloftThreatBar.db.profile.maximumThreatColor	= { 1.0, 0.0, 0.0, 1.0 }
								AloftThreatBar:UpdateAll()
							end,
				},
			}
		},
		threatGain =
		{
			type = 'group',
			name = L["Threat Gain"],
			desc = L["Threat gain threshold indicator for the player's target nameplate"],
			order = 12,
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ThreatData", true) and Aloft:GetModule("ThreatData"):IsEnabled()) or not AloftThreatBar:IsEnabled() or not AloftThreatBar.db or not AloftThreatBar.db.profile or not AloftThreatBar.db.profile.enable end,
			args =
			{
				gainEnable =
				{
					type = 'toggle',
					width = 'full',
					name = L["Enable"],
					desc = L["Show maximum threat threshold on the player's target nameplate"],
					order = 1,
					get = function(i) return AloftThreatBar.db.profile.gainEnable end,
					set = function(i, v) AloftThreatBar.db.profile.gainEnable = v Aloft:DetermineDataSources() AloftThreatBar:UpdateAll() end,
				},
				threatGainColor =
				{
					type = 'color',
					width = 'full',
					name = L["Threat Gain Color"],
					desc = L["Sets the color of the maximum threat threshold on the player's target nameplate"],
					order = 2,
					disabled = function(i) return not AloftThreatBar.db.profile.gainEnable end,
					get = function(i) return unpack(AloftThreatBar.db.profile.threatGainColor) end,
					set = function(i, r, g, b, a) AloftThreatBar.db.profile.threatGainColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
				},
				reset =
				{
					type = 'execute',
					width = 'full',
					name = L["Reset Color to Default"],
					desc = L["Resets the maximum threat threshold color to its default"],
					order = -1,
					func  = function(i)
								AloftThreatBar.db.profile.threatGainColor		= { 1.0, 0.5, 0.0, 1.0 }
								AloftThreatBar:UpdateAll()
							end,
				},
			},
		},
		threatFlash = {
			type = 'group',
			name = L["Threat Flash"],
			desc = L["Health bar will be highlighted when unit has maximum threat"],
			order = 13,
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ThreatData", true) and Aloft:GetModule("ThreatData"):IsEnabled()) or not AloftThreatBar:IsEnabled() or not AloftThreatBar.db or not AloftThreatBar.db.profile or not AloftThreatBar.db.profile.enable end,
			args =
			{
				enable =
				{
					type = 'toggle',
					width = 'full',
					name = L["Enable"],
					desc = L["Show threat flash"],
					order = 1,
					get = function(i) return AloftThreatBar.db.profile.flashEnable end,
					set = function(i, v) AloftThreatBar.db.profile.flashEnable = v Aloft:DetermineDataSources() AloftThreatBar:UpdateAll() end,
				},
				invert =
				{
					type = 'toggle',
					width = 'full',
					name = L["Invert"],
					desc = L["Invert threat flash (enable on targets below the threshold)"],
					order = 2,
					disabled = function(i) return not AloftThreatBar.db.profile.flashEnable end,
					get = function(i) return AloftThreatBar.db.profile.flashInvert end,
					set = function(i, v) AloftThreatBar.db.profile.flashInvert = v AloftThreatBar:UpdateAll() end,
				},
				threshold =
				{
					type = 'range',
					width = 'full',
					name = L["Threshold"],
					desc = L["The percentage of maximum threat at which flash appears"],
					order = 2,
					min = 0,
					max = 100,
					step = 1,
					disabled = function(i) return not AloftThreatBar.db.profile.flashEnable end,
					get = function(i) return AloftThreatBar.db.profile.flashThreshold end,
					set = function(i, v) AloftThreatBar.db.profile.flashThreshold = v Aloft:DetermineDataSources() AloftThreatBar:UpdateAll() end,
				},
				style =
				{
					type = 'select',
					width = 'full',
					name = L["Style"],
					desc = L["Sets the threat flash style"],
					order = 3,
					disabled = function(i) return not AloftThreatBar.db.profile.flashEnable end,

					get = function(i)
							for k, v in pairs(Aloft.Options.args.threatBar.args.threatFlash.args.style.values) do
								if v == AloftThreatBar.db.profile.flashStyle then
									return k
								end
							end
						end,
					set = function(i, v)
							AloftThreatBar.db.profile.flashStyle = Aloft.Options.args.threatBar.args.threatFlash.args.style.values[v]
							AloftThreatBar.db.profile.flashStyle()
						end,
					values = SML:List("glow"),

					--[[
					get = function(i) return AloftThreatBar.db.profile.flashStyle end,
					set = function(i, v) AloftThreatBar.db.profile.flashStyle = v AloftThreatBar.db.profile.flashStyle() end,
					values = {
						["HARD"]				= L["HARD"],
						["SOFT"]				= L["SOFT"],
						["PRTLSOFT"]			= L["PRTLSOFT"],
						["THRQTRSOFT"]			= L["THRQTRSOFT"],
						["EXTRASOFT"]			= L["EXTRASOFT"],
						["OVAL"]				= L["OVAL"],
						["OVALGLOW"]			= L["OVALGLOW"],
						["SQUAREGLOW"]			= L["SQUAREGLOW"],
						["PRTLSQUAREGLOW"]		= L["PRTLSQUAREGLOW"],
						["THRQTRSQUAREGLOW"]	= L["THRQTRSQUAREGLOW"],
					},
					]]
				},
				size =
				{
					type = 'group',
					name = L["Size"],
					desc = L["Adjust threat flash size"],
					order = 4,
					disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ThreatData", true) and Aloft:GetModule("ThreatData"):IsEnabled()) or not AloftThreatBar:IsEnabled() or not AloftThreatBar.db or not AloftThreatBar.db.profile or not AloftThreatBar.db.profile.enable or not AloftThreatBar.db.profile.flashEnable end,
					args =
					{
						width =
						{
							type = 'range',
							width = 'full',
							name = L["Width"],
							desc = L["Sets the width of the threat flash"],
							order = 1,
							min = 32,
							max = 768,
							step = 1,
							disabled = function(i) return not AloftThreatBar.db.profile.flashEnable end,
							get = function(i) return AloftThreatBar.db.profile.flashWidth end,
							set = function(i, v) AloftThreatBar.db.profile.flashWidth = v AloftThreatBar:UpdateAll() end,
						},
						height =
						{
							type = 'range',
							width = 'full',
							name = L["Height"],
							desc = L["Sets the height of the threat flash"],
							order = 2,
							min = 4,
							max = 256,
							step = 1,
							disabled = function(i) return not AloftThreatBar.db.profile.flashEnable end,
							get = function(i) return AloftThreatBar.db.profile.flashHeight end,
							set = function(i, v) AloftThreatBar.db.profile.flashHeight = v AloftThreatBar:UpdateAll() end,
						},
					}
				},
				position =
				{
					type = 'group',
					name = L["Position"],
					desc = L["Adjust the threat flash position"],
					order = 5,
					disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("ThreatData", true) and Aloft:GetModule("ThreatData"):IsEnabled()) or not AloftThreatBar:IsEnabled() or not AloftThreatBar.db or not AloftThreatBar.db.profile or not AloftThreatBar.db.profile.enable or not AloftThreatBar.db.profile.flashEnable end,
					args =
					{
						offsetX =
						{
							type = 'range',
							width = 'full',
							name = L["X Offset"],
							desc = L["X offset of the threat flash"],
							order = 1,
							min = -32,
							max = 32,
							step = 1,
							disabled = function(i) return not AloftThreatBar.db.profile.flashEnable end,
							get = function(i) return AloftThreatBar.db.profile.flashOffsetX end,
							set = function(i, v) AloftThreatBar.db.profile.flashOffsetX = v AloftThreatBar:UpdateAll() end,
						},
						offsetY =
						{
							type = 'range',
							width = 'full',
							name = L["Y Offset"],
							desc = L["Y offset of the threat flash"],
							order = 2,
							min = -32,
							max = 32,
							step = 1,
							disabled = function(i) return not AloftThreatBar.db.profile.flashEnable end,
							get = function(i) return AloftThreatBar.db.profile.flashOffsetY end,
							set = function(i, v) AloftThreatBar.db.profile.flashOffsetY = v AloftThreatBar:UpdateAll() end,
						},
					},
				},
				color =
				{
					type = 'color',
					width = 'full',
					name = L["Color"],
					desc = L["Sets the threat flash color"],
					order = 6,
					disabled = function(i) return not AloftThreatBar.db.profile.flashEnable end,
					get = function(i) return unpack(AloftThreatBar.db.profile.flashColor) end,
					set = function(i, r, g, b, a) AloftThreatBar.db.profile.flashColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
				},
				mode =
				{
					type = 'select',
					width = 'full',
					name = L["Blend Mode"],
					desc = L["Sets the threat flash blend mode"],
					order = 7,
					disabled = function(i) return not AloftThreatBar.db.profile.flashEnable end,
					get = function(i) return AloftThreatBar.db.profile.flashBlendMode end,
					set = function(i, v) AloftThreatBar.db.profile.flashBlendMode = v AloftThreatBar:UpdateAll() end,
					values = { ["BLEND"] = L["BLEND"], ["ADD"] = L["ADD"] },
				},
				reset =
				{
					type = 'execute',
					width = 'full',
					name = L["Reset Color to Default"],
					desc = L["Resets the threat flash color to its default"],
					order = -1,
					disabled = function(i) return not AloftThreatBar.db.profile.flashEnable end,
					func  = function(i)
								AloftThreatBar.db.profile.flashColor = { 1.0, 0.0, 0.0, 1.0 }
								AloftThreatBar:UpdateAll()
							end,
				},
			},
		},
	},
}

-----------------------------------------------------------------------------

end)