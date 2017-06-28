local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftBossIconOptions
if not L then return end

local AloftBossIcon = Aloft:GetModule("BossIcon", true) -- always enabled
if not AloftBossIcon then return end

-----------------------------------------------------------------------------

Aloft.Options.args.bossIcon =
{
	type = 'group',
	name = L["Boss Icon"],
	desc = L["Boss icon placement options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftBossIcon:IsEnabled() or not AloftBossIcon.db or not AloftBossIcon.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Enable boss icon display on the nameplate"],
			get = function(i) return AloftBossIcon.db.profile.enable end,
			set = function(i, v) AloftBossIcon.db.profile.enable = v AloftBossIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust boss icon position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftBossIcon:IsEnabled() or not AloftBossIcon.db or not AloftBossIcon.db.profile or not AloftBossIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = 'select',
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the boss icon"],
					get = function(i) return AloftBossIcon.db.profile.point end,
					set = function(i, v) AloftBossIcon.db.profile.point = v AloftBossIcon:UpdateAll() end,
					values = { ["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"] },
				},
				anchorto = {
					type = 'select',
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the boss icon"],
					get = function(i) return AloftBossIcon.db.profile.relativeToPoint end,
					set = function(i, v) AloftBossIcon.db.profile.relativeToPoint = v AloftBossIcon:UpdateAll() end,
					values = { ["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"] },
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the boss icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftBossIcon.db.profile.offsetX end,
					set = function(i, v) AloftBossIcon.db.profile.offsetX = v AloftBossIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the boss icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftBossIcon.db.profile.offsetY end,
					set = function(i, v) AloftBossIcon.db.profile.offsetY = v AloftBossIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			width = 'full',
			name = L["Size"],
			desc = L["Size in pixels of the boss icon"],
			min = 4,
			max = 32,
			step = 1,
			disabled = function(i) return not AloftBossIcon.db.profile.enable end,
			get = function(i) return AloftBossIcon.db.profile.size end,
			set = function(i, v) AloftBossIcon.db.profile.size = v AloftBossIcon:UpdateAll() end
		},
		alpha =
		{
			type = 'range',
			width = 'full',
			name = L["Alpha"],
			desc = L["Sets the boss icon alpha"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function(i) return not AloftBossIcon.db.profile.enable end,
			get = function(i) return AloftBossIcon.db.profile.alpha end,
			set = function(i, v) AloftBossIcon.db.profile.alpha = v AloftBossIcon:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------
