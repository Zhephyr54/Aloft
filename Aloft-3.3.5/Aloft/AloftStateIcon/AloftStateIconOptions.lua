local Aloft = Aloft
if not Aloft or not Aloft:HasModule("StateIcon") then return end

-----------------------------------------------------------------------------

local AloftStateIcon = Aloft:GetModule("StateIcon")
local L = AceLibrary("AceLocale-2.2"):new("AloftStateIconOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.stateIcon =
{
	type = 'group',
	name = L["State Icon"],
	desc = L["State icon placement options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable state icon display on the nameplate"],
			order = 1,
			get = function() return AloftStateIcon.db.profile.enable end,
			set = function(v) AloftStateIcon.db.profile.enable = v AloftStateIcon:UpdateAll() end,
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the state icon alpha"],
			order = 2,
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftStateIcon.db.profile.enable end,
			get = function() return AloftStateIcon.db.profile.alpha end,
			set = function(v) AloftStateIcon.db.profile.alpha = v AloftStateIcon:UpdateAll() end
		},
		reverse =
		{
			type = 'toggle',
			name = L["Reverse"],
			desc = L["Reverse the state icon graphic horizontally"],
			order = 3,
			disabled = function() return not AloftStateIcon.db.profile.enable end,
			get = function() return AloftStateIcon.db.profile.reverse end,
			set = function(v) AloftStateIcon.db.profile.reverse = v AloftStateIcon:UpdateAll() end
		},
		height =
		{
			type = 'range',
			name = L["Height"],
			desc = L["Height in pixels of the state icon"],
			order = 4,
			min = 4,
			max = 64,
			step = 1,
			disabled = function() return not AloftStateIcon.db.profile.enable end,
			get = function() return AloftStateIcon.db.profile.height end,
			set = function(v) AloftStateIcon.db.profile.height = v AloftStateIcon:UpdateAll() end
		},
		width =
		{
			type = 'range',
			name = L["Width"],
			desc = L["Width in pixels of the state icon"],
			order = 5,
			min = 4,
			max = 72,
			step = 1,
			disabled = function() return not AloftStateIcon.db.profile.enable end,
			get = function() return AloftStateIcon.db.profile.width end,
			set = function(v) AloftStateIcon.db.profile.width = v AloftStateIcon:UpdateAll() end
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust state icon position"],
			order = 6,
			disabled = function() return not AloftStateIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the state icon"],
					get = function() return AloftStateIcon.db.profile.point end,
					set = function(v) AloftStateIcon.db.profile.point = v AloftStateIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the state icon"],
					get = function() return AloftStateIcon.db.profile.relativeToPoint end,
					set = function(v) AloftStateIcon.db.profile.relativeToPoint = v AloftStateIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the state icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftStateIcon.db.profile.offsetX end,
					set = function(v) AloftStateIcon.db.profile.offsetX = v AloftStateIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the state icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftStateIcon.db.profile.offsetY end,
					set = function(v) AloftStateIcon.db.profile.offsetY = v AloftStateIcon:UpdateAll() end
				},
			},
		},
	},
}

-----------------------------------------------------------------------------
