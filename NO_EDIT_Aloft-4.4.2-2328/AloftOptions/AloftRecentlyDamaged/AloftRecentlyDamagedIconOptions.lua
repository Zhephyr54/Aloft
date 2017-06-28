local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftRecentlyDamaged", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftRecentlyDamaged
if not L then return end

local AloftRecentlyDamagedIcon = Aloft:GetModule("RecentlyDamagedIcon", true)
if not AloftRecentlyDamagedIcon then return end

-----------------------------------------------------------------------------

Aloft.Options.args.recentlyDamagedIcon =
{
	type = 'group',
	name = L["Recently Damaged Icon"],
	desc = L["Recently damaged icon placement options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftRecentlyDamagedIcon:IsEnabled() or not AloftRecentlyDamagedIcon.db or not AloftRecentlyDamagedIcon.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Enable recently damaged icon display on the nameplate"],
			get = function(i) return AloftRecentlyDamagedIcon.db.profile.enable end,
			set = function(i, v) AloftRecentlyDamagedIcon.db.profile.enable = v Aloft:DetermineDataSources() AloftRecentlyDamagedIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust recently damaged icon position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftRecentlyDamagedIcon:IsEnabled() or not AloftRecentlyDamagedIcon.db or not AloftRecentlyDamagedIcon.db.profile or not AloftRecentlyDamagedIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = 'select',
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the recently damaged icon"],
					get = function(i) return AloftRecentlyDamagedIcon.db.profile.point end,
					set = function(i, v) AloftRecentlyDamagedIcon.db.profile.point = v AloftRecentlyDamagedIcon:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = 'select',
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the recently damaged icon"],
					get = function(i) return AloftRecentlyDamagedIcon.db.profile.relativeToPoint end,
					set = function(i, v) AloftRecentlyDamagedIcon.db.profile.relativeToPoint = v AloftRecentlyDamagedIcon:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the recently damaged icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftRecentlyDamagedIcon.db.profile.offsetX end,
					set = function(i, v) AloftRecentlyDamagedIcon.db.profile.offsetX = v AloftRecentlyDamagedIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the recently damaged icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftRecentlyDamagedIcon.db.profile.offsetY end,
					set = function(i, v) AloftRecentlyDamagedIcon.db.profile.offsetY = v AloftRecentlyDamagedIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			width = 'full',
			name = L["Size"],
			desc = L["Size in pixels of the recently damaged icon"],
			min = 4,
			max = 64,
			step = 1,
			disabled = function(i) return not AloftRecentlyDamagedIcon.db.profile.enable end,
			get = function(i) return AloftRecentlyDamagedIcon.db.profile.size end,
			set = function(i, v) AloftRecentlyDamagedIcon.db.profile.size = v AloftRecentlyDamagedIcon:UpdateAll() end
		},
		alpha =
		{
			type = 'range',
			width = 'full',
			name = L["Alpha"],
			desc = L["Sets the recently damaged icon alpha"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function(i) return not AloftRecentlyDamagedIcon.db.profile.enable end,
			get = function(i) return AloftRecentlyDamagedIcon.db.profile.alpha end,
			set = function(i, v) AloftRecentlyDamagedIcon.db.profile.alpha = v AloftRecentlyDamagedIcon:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------

end)
