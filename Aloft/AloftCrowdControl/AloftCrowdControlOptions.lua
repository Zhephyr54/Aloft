local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CrowdControl") then return end

local AloftCrowdControl = Aloft:GetModule("CrowdControl")
local L = AceLibrary("AceLocale-2.2"):new("AloftPolymorphOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_statusbar = SML:List("statusbar")
local SML_border = SML:List("border")

-----------------------------------------------------------------------------

Aloft.Options.args.crowdControl =
{
	type = 'group',
	name = L["Crowd Control"],
	desc = L["Crowd control options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Shows crowd control timers on nameplates when possible"],
			get = function() return AloftCrowdControl.db.profile.enable end,
			set = function(v) AloftCrowdControl.db.profile.enable = v AloftCrowdControl:UpdateAll() end,
			order = 1
		},
		speculativeAttach =
		{
			type = 'toggle',
			name = L["Speculative Attach"],
			desc = L["Attempt to attach the crowd control timer bar when it is not absolutely certain if it is the correct nameplate"],
			disabled = function() return not AloftCrowdControl.db.profile.enable end,
			get = function() return AloftCrowdControl.db.profile.speculativeAttach end,
			set = function(v) AloftCrowdControl.db.profile.speculativeAttach = v end,
			order = 2
		},
		texture =
		{
			type = "text",
			name = L["Texture"],
			desc = L["Sets the crowd control bar texture"],
			disabled = function() return not AloftCrowdControl.db.profile.enable end,
			get = function() return AloftCrowdControl.db.profile.texture end,
			set = function(v)
				AloftCrowdControl.db.profile.texture = v
				AloftCrowdControl:UpdateAll()
			end,
			validate = SML_statusbar
		},
		border = {
			type = 'group',
			name = L["Border"],
			desc = L["Border options"],
			disabled = function() return not AloftCrowdControl.db.profile.enable end,
			args =
			{
				targetOnly =
				{
					type = 'toggle',
					name = L["Target Only"],
					desc = L["Enables the border on the current target only"],
					order = 1,
					get = function() return AloftCrowdControl.db.profile.targetOnly end,
					set = function(v) AloftCrowdControl.db.profile.targetOnly = v AloftCrowdControl:UpdateAll() end,
					disabled = function() return AloftCrowdControl.db.profile.border == "None" end,
				},
				style =
				{
					type = 'text',
					name = L["Border Style"],
					desc = L["Sets the style of the crowd control bar border"],
					order = 2,
					get = function() return AloftCrowdControl.db.profile.border end,
					set = function(v)
						AloftCrowdControl.db.profile.border = v
						AloftCrowdControl:UpdateAll()
					end,
					validate = SML_border,
				},
				color =
				{
					type = 'color',
					name = L["Border Color"],
					desc = L["Sets the border color of the crowd control bar"],
					order = 3,
					disabled = function() return AloftCrowdControl.db.profile.border == "None" end,
					get = function() return unpack(AloftCrowdControl.db.profile.borderColor) end,
					set = function(r, g, b, a) AloftCrowdControl.db.profile.borderColor = { r, g, b, a } AloftCrowdControl:UpdateAll() end,
					hasAlpha = true,
				},
			},
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Color options"],
			disabled = function() return not AloftCrowdControl.db.profile.enable end,
			args =
			{
				bar =
				{
					type = 'color',
					name = L["Bar Color"],
					desc = L["Sets the crowd control bar color"],
					get = function() return unpack(AloftCrowdControl.db.profile.color) end,
					set = function(r, g, b, a) AloftCrowdControl.db.profile.color = { r, g, b, a } AloftCrowdControl:UpdateAll() end,
					hasAlpha = true,
					order = 1
				},
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the crowd control backdrop color"],
					get = function() return unpack(AloftCrowdControl.db.profile.backdropColor) end,
					set = function(r, g, b, a) AloftCrowdControl.db.profile.backdropColor = { r, g, b, a } AloftCrowdControl:UpdateAll() end,
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
			disabled = function() return not AloftCrowdControl.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the crowd control bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftCrowdControl.db.profile.offsets.left end,
					set = function(v) AloftCrowdControl.db.profile.offsets.left = v AloftCrowdControl:UpdateAll() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the crowd control bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftCrowdControl.db.profile.offsets.right end,
					set = function(v) AloftCrowdControl.db.profile.offsets.right = v AloftCrowdControl:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the crowd control bar"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftCrowdControl.db.profile.offsets.vertical end,
					set = function(v) AloftCrowdControl.db.profile.offsets.vertical = v AloftCrowdControl:UpdateAll() end
				},
			},
		},
		height =
		{
			type = 'range',
			name = L["Height"],
			desc = L["Sets the height of the crowd control bar"],
			min = 1,
			max = 32,
			step = 1,
			disabled = function() return not AloftCrowdControl.db.profile.enable end,
			get = function() return AloftCrowdControl.db.profile.height end,
			set = function(v) AloftCrowdControl.db.profile.height = v AloftCrowdControl:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------

end)
