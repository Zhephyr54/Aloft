local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftClassIcon
if not L then return end

local AloftClassIcon = Aloft:GetModule("ClassIcon")
if not AloftClassIcon then return end

-----------------------------------------------------------------------------

Aloft.Options.args.classIcon =
{
	type = 'group',
	name = L["Class Icon"],
	desc = L["Class icon placement options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftClassIcon:IsEnabled() or not AloftClassIcon.db or not AloftClassIcon.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Enable class icon display on the nameplate"],
			get = function(i) return AloftClassIcon.db.profile.enable end,
			set = function(i, v) AloftClassIcon.db.profile.enable = v AloftClassIcon:UpdateAll() end,
			order = 1,
		},
		totemEnable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Totem Enable"],
			desc = L["Enable totem icon display on the nameplate"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftClassIcon:IsEnabled() or not AloftClassIcon.db or not AloftClassIcon.db.profile or not AloftClassIcon.db.profile.enable end,
			get = function(i) return AloftClassIcon.db.profile.totemEnable end,
			set = function(i, v) AloftClassIcon.db.profile.totemEnable = v AloftClassIcon:UpdateAll() end,
			order = 2,
		},
		totemCrop =
		{
			type = 'range',
			width = 'full',
			name = L["Totem Crop"],
			desc = L["Percentage to crop off the outside of the totem icon"],
			min = 0,
			max = 1,
			step = 0.01,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftClassIcon:IsEnabled() or not AloftClassIcon.db or not AloftClassIcon.db.profile or not AloftClassIcon.db.profile.enable or not AloftClassIcon.db.profile.totemEnable end,
			get = function(i) return AloftClassIcon.db.profile.totemCrop end,
			set = function(i, v) AloftClassIcon.db.profile.totemCrop = v AloftClassIcon:UpdateAll() end,
			order = 3,
		},
		alpha =
		{
			type = 'range',
			width = 'full',
			name = L["Alpha"],
			desc = L["Sets the class icon alpha"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function(i) return not AloftClassIcon.db.profile.enable end,
			get = function(i) return AloftClassIcon.db.profile.alpha end,
			set = function(i, v) AloftClassIcon.db.profile.alpha = v AloftClassIcon:UpdateAll() end,
			order = 4,
		},
		size =
		{
			type = 'range',
			width = 'full',
			name = L["Size"],
			desc = L["Size in pixels of the class icon"],
			min = 4,
			max = 64,
			step = 1,
			disabled = function(i) return not AloftClassIcon.db.profile.enable end,
			get = function(i) return AloftClassIcon.db.profile.size end,
			set = function(i, v) AloftClassIcon.db.profile.size = v AloftClassIcon:UpdateAll() end,
			order = 5,
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust class icon position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftClassIcon:IsEnabled() or not AloftClassIcon.db or not AloftClassIcon.db.profile or not AloftClassIcon.db.profile.enable end,
			order = 6,
			args =
			{
				anchor = {
					type = 'select',
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the class icon"],
					get = function(i) return AloftClassIcon.db.profile.point end,
					set = function(i, v) AloftClassIcon.db.profile.point = v AloftClassIcon:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = 'select',
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the class icon"],
					get = function(i) return AloftClassIcon.db.profile.relativeToPoint end,
					set = function(i, v) AloftClassIcon.db.profile.relativeToPoint = v AloftClassIcon:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the class icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftClassIcon.db.profile.offsetX end,
					set = function(i, v) AloftClassIcon.db.profile.offsetX = v AloftClassIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the class icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftClassIcon.db.profile.offsetY end,
					set = function(i, v) AloftClassIcon.db.profile.offsetY = v AloftClassIcon:UpdateAll() end
				},
			},
		},
	},
}

-----------------------------------------------------------------------------

end)
