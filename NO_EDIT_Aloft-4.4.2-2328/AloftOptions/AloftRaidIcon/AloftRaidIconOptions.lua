local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftRaidIconOptions
if not L then return end

local AloftRaidIcon = Aloft:GetModule("RaidIcon", true)
if not AloftRaidIcon then return end

-----------------------------------------------------------------------------

Aloft.Options.args.raidIcon =
{
	type = 'group',
	name = L["Raid Icon"],
	desc = L["Raid icon placement options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftRaidIcon:IsEnabled() or not AloftRaidIcon.db or not AloftRaidIcon.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Enable raid icon display on the nameplate"],
			get = function(i) return AloftRaidIcon.db.profile.enable end,
			set = function(i, v) AloftRaidIcon.db.profile.enable = v AloftRaidIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust raid icon position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftRaidIcon:IsEnabled() or not AloftRaidIcon.db or not AloftRaidIcon.db.profile or not AloftRaidIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = 'select',
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the raid icon"],
					get = function(i) return AloftRaidIcon.db.profile.point end,
					set = function(i, v) AloftRaidIcon.db.profile.point = v AloftRaidIcon:UpdateAll() end,
					values = { ["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"] },
				},
				anchorto = {
					type = 'select',
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the raid icon"],
					get = function(i) return AloftRaidIcon.db.profile.relativeToPoint end,
					set = function(i, v) AloftRaidIcon.db.profile.relativeToPoint = v AloftRaidIcon:UpdateAll() end,
					values = { ["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"] },
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the raid icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftRaidIcon.db.profile.offsetX end,
					set = function(i, v) AloftRaidIcon.db.profile.offsetX = v AloftRaidIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the raid icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftRaidIcon.db.profile.offsetY end,
					set = function(i, v) AloftRaidIcon.db.profile.offsetY = v AloftRaidIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			width = 'full',
			name = L["Size"],
			desc = L["Size in pixels of the raid icon"],
			min = 4,
			max = 64,
			step = 1,
			disabled = function(i) return not AloftRaidIcon.db.profile.enable end,
			get = function(i) return AloftRaidIcon.db.profile.size end,
			set = function(i, v) AloftRaidIcon.db.profile.size = v AloftRaidIcon:UpdateAll() end
		},
		alpha =
		{
			type = 'range',
			width = 'full',
			name = L["Alpha"],
			desc = L["Sets the raid icon alpha"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function(i) return not AloftRaidIcon.db.profile.enable end,
			get = function(i) return AloftRaidIcon.db.profile.alpha end,
			set = function(i, v) AloftRaidIcon.db.profile.alpha = v AloftRaidIcon:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------
