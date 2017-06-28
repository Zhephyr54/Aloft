local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftStateIcon
if not L then return end

local AloftStateIcon = Aloft:GetModule("StateIcon", true)
if not AloftStateIcon then return end

-----------------------------------------------------------------------------

Aloft.Options.args.stateIcon =
{
	type = 'group',
	name = L["State Icon"],
	desc = L["State icon placement options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftStateIcon:IsEnabled() or not AloftStateIcon.db or not AloftStateIcon.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Enable state icon display on the nameplate"],
			order = 1,
			get = function(i) return AloftStateIcon.db.profile.enable end,
			set = function(i, v) AloftStateIcon.db.profile.enable = v AloftStateIcon:UpdateAll() end,
		},
		alpha =
		{
			type = 'range',
			width = 'full',
			name = L["Alpha"],
			desc = L["Sets the state icon alpha"],
			order = 2,
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function(i) return not AloftStateIcon.db.profile.enable end,
			get = function(i) return AloftStateIcon.db.profile.alpha end,
			set = function(i, v) AloftStateIcon.db.profile.alpha = v AloftStateIcon:UpdateAll() end
		},
		reverse =
		{
			type = 'toggle',
			width = 'full',
			name = L["Reverse"],
			desc = L["Reverse the state icon graphic horizontally"],
			order = 3,
			disabled = function(i) return not AloftStateIcon.db.profile.enable end,
			get = function(i) return AloftStateIcon.db.profile.reverse end,
			set = function(i, v) AloftStateIcon.db.profile.reverse = v AloftStateIcon:UpdateAll() end
		},
		height =
		{
			type = 'range',
			width = 'full',
			name = L["Height"],
			desc = L["Height in pixels of the state icon"],
			order = 4,
			min = 4,
			max = 64,
			step = 1,
			disabled = function(i) return not AloftStateIcon.db.profile.enable end,
			get = function(i) return AloftStateIcon.db.profile.height end,
			set = function(i, v) AloftStateIcon.db.profile.height = v AloftStateIcon:UpdateAll() end
		},
		width =
		{
			type = 'range',
			width = 'full',
			name = L["Width"],
			desc = L["Width in pixels of the state icon"],
			order = 5,
			min = 4,
			max = 72,
			step = 1,
			disabled = function(i) return not AloftStateIcon.db.profile.enable end,
			get = function(i) return AloftStateIcon.db.profile.width end,
			set = function(i, v) AloftStateIcon.db.profile.width = v AloftStateIcon:UpdateAll() end
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust state icon position"],
			order = 6,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftStateIcon:IsEnabled() or not AloftStateIcon.db or not AloftStateIcon.db.profile or not AloftStateIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = "select",
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the state icon"],
					get = function(i) return AloftStateIcon.db.profile.point end,
					set = function(i, v) AloftStateIcon.db.profile.point = v AloftStateIcon:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "select",
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the state icon"],
					get = function(i) return AloftStateIcon.db.profile.relativeToPoint end,
					set = function(i, v) AloftStateIcon.db.profile.relativeToPoint = v AloftStateIcon:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the state icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftStateIcon.db.profile.offsetX end,
					set = function(i, v) AloftStateIcon.db.profile.offsetX = v AloftStateIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the state icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftStateIcon.db.profile.offsetY end,
					set = function(i, v) AloftStateIcon.db.profile.offsetY = v AloftStateIcon:UpdateAll() end
				},
			},
		},
	},
}

-----------------------------------------------------------------------------
