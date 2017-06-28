local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftPolymorphOptions
if not L then return end

local AloftCrowdControl = Aloft:GetModule("CrowdControl", true)
if not AloftCrowdControl then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.crowdControl =
{
	type = 'group',
	name = L["Crowd Control"],
	desc = L["Crowd control options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCrowdControl:IsEnabled() or not AloftCrowdControl.db or not AloftCrowdControl.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Shows crowd control timers on nameplates when possible"],
			get = function(i) return AloftCrowdControl.db.profile.enable end,
			set = function(i, v) AloftCrowdControl.db.profile.enable = v AloftCrowdControl:UpdateAll() end,
			order = 1
		},
		speculativeAttach =
		{
			type = 'toggle',
			width = 'full',
			name = L["Speculative Attach"],
			desc = L["Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"],
			disabled = function(i) return not AloftCrowdControl.db.profile.enable end,
			get = function(i) return AloftCrowdControl.db.profile.speculativeAttach end,
			set = function(i, v) AloftCrowdControl.db.profile.speculativeAttach = v end,
			order = 2
		},
		texture =
		{
			type = 'select',
			width = 'full',
			name = L["Texture"],
			desc = L["Sets the crowd control bar texture"],
			disabled = function(i) return not AloftCrowdControl.db.profile.enable end,
			get = function(i)
				for k, v in pairs(Aloft.Options.args.crowdControl.args.texture.values) do
					if v == AloftCrowdControl.db.profile.texture then
						return k
					end
				end
			end,
			set = function(i, v)
				AloftCrowdControl.db.profile.texture = Aloft.Options.args.crowdControl.args.texture.values[v]
				AloftCrowdControl:UpdateAll()
			end,
			values = SML:List("statusbar")
		},
		border = {
			type = 'group',
			name = L["Border"],
			desc = L["Border options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCrowdControl:IsEnabled() or not AloftCrowdControl.db or not AloftCrowdControl.db.profile or not AloftCrowdControl.db.profile.enable end,
			args =
			{
				targetOnly =
				{
					type = 'toggle',
					width = 'full',
					name = L["Target Only"],
					desc = L["Enables the border on the current target only"],
					order = 1,
					get = function(i) return AloftCrowdControl.db.profile.targetOnly end,
					set = function(i, v) AloftCrowdControl.db.profile.targetOnly = v Aloft:DetermineDataSources() AloftCrowdControl:UpdateAll() end,
					disabled = function(i) return AloftCrowdControl.db.profile.border == "None" end,
				},
				style =
				{
					type = 'select',
					width = 'full',
					name = L["Border Style"],
					desc = L["Sets the style of the crowd control bar border"],
					order = 2,
					get = function(i)
						for k, v in pairs(Aloft.Options.args.crowdControl.args.border.args.style.values) do
							if v == AloftCrowdControl.db.profile.border then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftCrowdControl.db.profile.border = Aloft.Options.args.crowdControl.args.border.args.style.values[v]
						AloftCrowdControl:UpdateAll()
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
					get = function(i) return AloftCrowdControl.db.profile.borderEdgeSize end,
					set = function(i, v) AloftCrowdControl.db.profile.borderEdgeSize = v AloftCrowdControl:UpdateAll() end
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
					get = function(i) return AloftCrowdControl.db.profile.borderInset end,
					set = function(i, v) AloftCrowdControl.db.profile.borderInset = v AloftCrowdControl:UpdateAll() end
				},
				color =
				{
					type = 'color',
					width = 'full',
					name = L["Border Color"],
					desc = L["Sets the border color of the crowd control bar"],
					order = 3,
					disabled = function(i) return AloftCrowdControl.db.profile.border == "None" end,
					get = function(i) return unpack(AloftCrowdControl.db.profile.borderColor) end,
					set = function(i, r, g, b, a) AloftCrowdControl.db.profile.borderColor = { r, g, b, a } AloftCrowdControl:UpdateAll() end,
					hasAlpha = true,
				},
			},
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Color options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCrowdControl:IsEnabled() or not AloftCrowdControl.db or not AloftCrowdControl.db.profile or not AloftCrowdControl.db.profile.enable end,
			args =
			{
				bar =
				{
					type = 'color',
					width = 'full',
					name = L["Bar Color"],
					desc = L["Sets the crowd control bar color"],
					get = function(i) return unpack(AloftCrowdControl.db.profile.color) end,
					set = function(i, r, g, b, a) AloftCrowdControl.db.profile.color = { r, g, b, a } AloftCrowdControl:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				backdrop =
				{
					type = 'color',
					width = 'full',
					name = L["Backdrop Color"],
					desc = L["Sets the crowd control backdrop color"],
					get = function(i) return unpack(AloftCrowdControl.db.profile.backdropColor) end,
					set = function(i, r, g, b, a) AloftCrowdControl.db.profile.backdropColor = { r, g, b, a } AloftCrowdControl:UpdateAll() end,
					hasAlpha = true,
					order = 2
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the crowd control bar's position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCrowdControl:IsEnabled() or not AloftCrowdControl.db or not AloftCrowdControl.db.profile or not AloftCrowdControl.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					width = 'full',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the crowd control bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftCrowdControl.db.profile.offsets.left end,
					set = function(i, v) AloftCrowdControl.db.profile.offsets.left = v AloftCrowdControl:UpdateAll() end
				},
				right =
				{
					type = 'range',
					width = 'full',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the crowd control bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftCrowdControl.db.profile.offsets.right end,
					set = function(i, v) AloftCrowdControl.db.profile.offsets.right = v AloftCrowdControl:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					width = 'full',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the crowd control bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftCrowdControl.db.profile.offsets.vertical end,
					set = function(i, v) AloftCrowdControl.db.profile.offsets.vertical = v AloftCrowdControl:UpdateAll() end
				},
			},
		},
		height =
		{
			type = 'range',
			width = 'full',
			name = L["Height"],
			desc = L["Sets the height of the crowd control bar"],
			min = 1,
			max = 32,
			step = 1,
			disabled = function(i) return not AloftCrowdControl.db.profile.enable end,
			get = function(i) return AloftCrowdControl.db.profile.height end,
			set = function(i, v) AloftCrowdControl.db.profile.height = v AloftCrowdControl:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------

end)
