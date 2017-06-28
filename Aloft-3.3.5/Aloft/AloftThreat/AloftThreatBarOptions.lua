local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("ThreatBar") then return end

local AloftThreatBar = Aloft:GetModule("ThreatBar")
local L = AceLibrary("AceLocale-2.2"):new("AloftThreatBarOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_statusbar = SML:List("statusbar")
local SML_border = SML:List("border")

-----------------------------------------------------------------------------

Aloft.Options.args.threatBar =
{
	type = 'group',
	name = L["Threat Bar"],
	desc = L["Threat Bar options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show threat bars on group member nameplates"],
			order = 1,
			get = function() return AloftThreatBar.db.profile.enable end,
			set = function(v) AloftThreatBar.db.profile.enable = v Aloft:DetermineDataSources() AloftThreatBar:UpdateAll() end,
		},
		activeWhileSolo =
		{
			type = 'toggle',
			name = L["Active While Solo"],
			desc = L["Show threat bars on nameplates while solo (for classes with pets and guardians)"],
			order = 2,
			disabled = function() return not AloftThreatBar.db.profile.enable end,
			get = function() return AloftThreatBar.db.profile.activeWhileSolo end,
			set = function(v) AloftThreatBar.db.profile.activeWhileSolo = v Aloft:DetermineDataSources() AloftThreatBar:UpdateAll() end,
		},
		texture =
		{
			type = "text",
			name = L["Texture"],
			desc = L["Sets the threat bar texture"],
			order = 6,
			disabled = function() return not AloftThreatBar.db.profile.enable end,
			get = function() return AloftThreatBar.db.profile.texture end,
			set = function(v)
				AloftThreatBar.db.profile.texture = v
				AloftThreatBar:UpdateAll()
			end,
			validate = SML_statusbar,
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the threat bar's position"],
			order = 7,
			disabled = function() return not AloftThreatBar.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the threat bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftThreatBar.db.profile.offsets.left end,
					set = function(v) AloftThreatBar.db.profile.offsets.left = v AloftThreatBar:UpdateAll() end,
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the threat bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftThreatBar.db.profile.offsets.right end,
					set = function(v) AloftThreatBar.db.profile.offsets.right = v AloftThreatBar:UpdateAll() end,
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the threat bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftThreatBar.db.profile.offsets.vertical end,
					set = function(v) AloftThreatBar.db.profile.offsets.vertical = v AloftThreatBar:UpdateAll() end,
				},
			},
		},
		height =
		{
			type = 'range',
			name = L["Height"],
			desc = L["Sets the height of the threat bar"],
			order = 8,
			min = 1,
			max = 32,
			step = 1,
			disabled = function() return not AloftThreatBar.db.profile.enable end,
			get = function() return AloftThreatBar.db.profile.height end,
			set = function(v) AloftThreatBar.db.profile.height = v AloftThreatBar:UpdateAll() end,
		},
		border = {
			type = 'group',
			name = L["Border"],
			desc = L["Border options"],
			order = 9,
			disabled = function() return not AloftThreatBar.db.profile.enable end,
			args =
			{
				targetOnly =
				{
					type = 'toggle',
					name = L["Target Only"],
					desc = L["Enables the border on the current target only"],
					order = 1,
					get = function() return AloftThreatBar.db.profile.targetOnly end,
					set = function(v) AloftThreatBar.db.profile.targetOnly = v AloftThreatBar:UpdateAll() end,
					disabled = function() return AloftThreatBar.db.profile.border == "None" end,
				},
				style =
				{
					type = 'text',
					name = L["Border Style"],
					desc = L["Sets the style of the threat bar border"],
					order = 2,
					get = function() return AloftThreatBar.db.profile.border end,
					set = function(v)
						AloftThreatBar.db.profile.border = v
						AloftThreatBar:UpdateAll()
					end,
					validate = SML_border
				},
				color =
				{
					type = 'color',
					name = L["Border Color"],
					order = 3,
					desc = L["Sets the border color of the threat bar"],
					get = function() return unpack(AloftThreatBar.db.profile.borderColor) end,
					set = function(r, g, b, a) AloftThreatBar.db.profile.borderColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					disabled = function() return AloftThreatBar.db.profile.border == "None" end,
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
			disabled = function() return not AloftThreatBar.db.profile.enable end,
			args =
			{
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the threat bar"],
					get = function() return unpack(AloftThreatBar.db.profile.backdropColor) end,
					set = function(r, g, b, a) AloftThreatBar.db.profile.backdropColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
					order = 1,
				},
				commonThreat =
				{
					type = 'color',
					name = L["Common Threat Color"],
					desc = L["Sets the threat color for the threat bar when indicating common threat"],
					get = function() return unpack(AloftThreatBar.db.profile.commonThreatColor) end,
					set = function(r, g, b, a) AloftThreatBar.db.profile.commonThreatColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
					order = 2,
				},
				maximumThreat =
				{
					type = 'color',
					name = L["Maximum Threat Color"],
					desc = L["Sets the threat color for the threat bar when indicating maximum threat"],
					get = function() return unpack(AloftThreatBar.db.profile.maximumThreatColor) end,
					set = function(r, g, b, a) AloftThreatBar.db.profile.maximumThreatColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
					order = 3,
				},
				reset =
				{
					type = "execute",
					name = L["Reset to Defaults"],
					desc = L["Resets all colors to their defaults"],
					order = -1,
					func  = function()
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
			disabled = function() return not AloftThreatBar.db.profile.enable end,
			args =
			{
				gainEnable =
				{
					type = 'toggle',
					name = L["Enable"],
					desc = L["Show maximum threat threshold on the player's target nameplate"],
					order = 1,
					get = function() return AloftThreatBar.db.profile.gainEnable end,
					set = function(v) AloftThreatBar.db.profile.gainEnable = v Aloft:DetermineDataSources() AloftThreatBar:UpdateAll() end,
				},
				threatGainColor =
				{
					type = 'color',
					name = L["Threat Gain Color"],
					desc = L["Sets the color of the maximum threat threshold on the player's target nameplate"],
					order = 2,
					disabled = function() return not AloftThreatBar.db.profile.gainEnable end,
					get = function() return unpack(AloftThreatBar.db.profile.threatGainColor) end,
					set = function(r, g, b, a) AloftThreatBar.db.profile.threatGainColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
				},
				reset =
				{
					type = "execute",
					name = L["Reset Color to Default"],
					desc = L["Resets the maximum threat threshold color to its default"],
					order = -1,
					func  = function()
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
			disabled = function() return not AloftThreatBar.db.profile.enable end,
			args =
			{
				enable =
				{
					type = 'toggle',
					name = L["Enable"],
					desc = L["Show threat flash"],
					order = 1,
					get = function() return AloftThreatBar.db.profile.flashEnable end,
					set = function(v) AloftThreatBar.db.profile.flashEnable = v Aloft:DetermineDataSources() AloftThreatBar:UpdateAll() end,
				},
				invert =
				{
					type = 'toggle',
					name = L["Invert"],
					desc = L["Invert threat flash (enable on targets below the threshold)"],
					order = 2,
					disabled = function() return not AloftThreatBar.db.profile.flashEnable end,
					get = function() return AloftThreatBar.db.profile.flashInvert end,
					set = function(v) AloftThreatBar.db.profile.flashInvert = v AloftThreatBar:UpdateAll() end,
				},
				threshold =
				{
					type = 'range',
					name = L["Threshold"],
					desc = L["The percentage of maximum threat at which flash appears"],
					order = 2,
					min = 0,
					max = 100,
					step = 1,
					disabled = function() return not AloftThreatBar.db.profile.flashEnable end,
					get = function() return AloftThreatBar.db.profile.flashThreshold end,
					set = function(v) AloftThreatBar.db.profile.flashThreshold = v Aloft:DetermineDataSources() AloftThreatBar:UpdateAll() end,
				},
				style =
				{
					type = "text",
					name = L["Style"],
					desc = L["Sets the threat flash style"],
					order = 3,
					disabled = function() return not AloftThreatBar.db.profile.flashEnable end,
					get = function() return AloftThreatBar.db.profile.flashStyle end,
					set = function(v) AloftThreatBar.db.profile.flashStyle = v AloftThreatBar:UpdateAll() end,
					validate = {
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
				},
				size =
				{
					type = 'group',
					name = L["Size"],
					desc = L["Adjust threat flash size"],
					order = 4,
					args =
					{
						width =
						{
							type = 'range',
							name = L["Width"],
							desc = L["Sets the width of the threat flash"],
							order = 1,
							min = 32,
							max = 768,
							step = 1,
							disabled = function() return not AloftThreatBar.db.profile.flashEnable end,
							get = function() return AloftThreatBar.db.profile.flashWidth end,
							set = function(v) AloftThreatBar.db.profile.flashWidth = v AloftThreatBar:UpdateAll() end,
						},
						height =
						{
							type = 'range',
							name = L["Height"],
							desc = L["Sets the height of the threat flash"],
							order = 2,
							min = 4,
							max = 256,
							step = 1,
							disabled = function() return not AloftThreatBar.db.profile.flashEnable end,
							get = function() return AloftThreatBar.db.profile.flashHeight end,
							set = function(v) AloftThreatBar.db.profile.flashHeight = v AloftThreatBar:UpdateAll() end,
						},
					}
				},
				position =
				{
					type = 'group',
					name = L["Position"],
					desc = L["Adjust the threat flash position"],
					order = 5,
					args =
					{
						offsetX =
						{
							type = 'range',
							name = L["X Offset"],
							desc = L["X offset of the threat flash"],
							order = 1,
							min = -32,
							max = 32,
							step = 1,
							disabled = function() return not AloftThreatBar.db.profile.flashEnable end,
							get = function() return AloftThreatBar.db.profile.flashOffsetX end,
							set = function(v) AloftThreatBar.db.profile.flashOffsetX = v AloftThreatBar:UpdateAll() end,
						},
						offsetY =
						{
							type = 'range',
							name = L["Y Offset"],
							desc = L["Y offset of the threat flash"],
							order = 2,
							min = -32,
							max = 32,
							step = 1,
							disabled = function() return not AloftThreatBar.db.profile.flashEnable end,
							get = function() return AloftThreatBar.db.profile.flashOffsetY end,
							set = function(v) AloftThreatBar.db.profile.flashOffsetY = v AloftThreatBar:UpdateAll() end,
						},
					},
				},
				color =
				{
					type = 'color',
					name = L["Color"],
					desc = L["Sets the threat flash color"],
					order = 6,
					disabled = function() return not AloftThreatBar.db.profile.flashEnable end,
					get = function() return unpack(AloftThreatBar.db.profile.flashColor) end,
					set = function(r, g, b, a) AloftThreatBar.db.profile.flashColor = { r, g, b, a } AloftThreatBar:UpdateAll() end,
					hasAlpha = true,
				},
				mode =
				{
					type = "text",
					name = L["Blend Mode"],
					desc = L["Sets the threat flash blend mode"],
					order = 7,
					disabled = function() return not AloftThreatBar.db.profile.flashEnable end,
					get = function() return AloftThreatBar.db.profile.flashBlendMode end,
					set = function(v) AloftThreatBar.db.profile.flashBlendMode = v AloftThreatBar:UpdateAll() end,
					validate = { ["BLEND"] = L["BLEND"], ["ADD"] = L["ADD"] },
				},
				reset =
				{
					type = "execute",
					name = L["Reset Color to Default"],
					desc = L["Resets the threat flash color to its default"],
					order = -1,
					func  = function()
								AloftThreatBar.db.profile.flashColor		= { 1.0, 0.0, 0.0, 1.0 },
								AloftThreatBar:UpdateAll()
							end,
				},
			},
		},
	},
}

-----------------------------------------------------------------------------

end)