local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftRecentlyDamaged", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("RecentlyDamagedIcon") then return end

local AloftRecentlyDamagedIcon = Aloft:GetModule("RecentlyDamagedIcon")
local L = AceLibrary("AceLocale-2.2"):new("AloftRecentlyDamagedIconOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.recentlyDamagedIcon =
{
	type = 'group',
	name = L["Recently Damaged Icon"],
	desc = L["Recently damaged icon placement options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable recently damaged icon display on the nameplate"],
			get = function() return AloftRecentlyDamagedIcon.db.profile.enable end,
			set = function(v) AloftRecentlyDamagedIcon.db.profile.enable = v Aloft:DetermineDataSources() AloftRecentlyDamagedIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust recently damaged icon position"],
			disabled = function() return not AloftRecentlyDamagedIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the recently damaged icon"],
					get = function() return AloftRecentlyDamagedIcon.db.profile.point end,
					set = function(v) AloftRecentlyDamagedIcon.db.profile.point = v AloftRecentlyDamagedIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the recently damaged icon"],
					get = function() return AloftRecentlyDamagedIcon.db.profile.relativeToPoint end,
					set = function(v) AloftRecentlyDamagedIcon.db.profile.relativeToPoint = v AloftRecentlyDamagedIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the recently damaged icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftRecentlyDamagedIcon.db.profile.offsetX end,
					set = function(v) AloftRecentlyDamagedIcon.db.profile.offsetX = v AloftRecentlyDamagedIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the recently damaged icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftRecentlyDamagedIcon.db.profile.offsetY end,
					set = function(v) AloftRecentlyDamagedIcon.db.profile.offsetY = v AloftRecentlyDamagedIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			name = L["Size"],
			desc = L["Size in pixels of the recently damaged icon"],
			min = 4,
			max = 64,
			step = 1,
			disabled = function() return not AloftRecentlyDamagedIcon.db.profile.enable end,
			get = function() return AloftRecentlyDamagedIcon.db.profile.size end,
			set = function(v) AloftRecentlyDamagedIcon.db.profile.size = v AloftRecentlyDamagedIcon:UpdateAll() end
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the recently damaged icon alpha"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftRecentlyDamagedIcon.db.profile.enable end,
			get = function() return AloftRecentlyDamagedIcon.db.profile.alpha end,
			set = function(v) AloftRecentlyDamagedIcon.db.profile.alpha = v AloftRecentlyDamagedIcon:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------

end)
