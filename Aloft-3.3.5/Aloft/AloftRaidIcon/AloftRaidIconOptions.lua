local Aloft = Aloft
if not Aloft or not Aloft:HasModule("RaidIcon") then return end

-----------------------------------------------------------------------------

local AloftRaidIcon = Aloft:GetModule("RaidIcon")
local L = AceLibrary("AceLocale-2.2"):new("AloftRaidIconOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.raidIcon =
{
	type = 'group',
	name = L["Raid Icon"],
	desc = L["Raid icon placement options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable raid icon display on the nameplate"],
			get = function() return AloftRaidIcon.db.profile.enable end,
			set = function(v) AloftRaidIcon.db.profile.enable = v AloftRaidIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust raid icon position"],
			disabled = function() return not AloftRaidIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the raid icon"],
					get = function() return AloftRaidIcon.db.profile.point end,
					set = function(v) AloftRaidIcon.db.profile.point = v AloftRaidIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the raid icon"],
					get = function() return AloftRaidIcon.db.profile.relativeToPoint end,
					set = function(v) AloftRaidIcon.db.profile.relativeToPoint = v AloftRaidIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the raid icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftRaidIcon.db.profile.offsetX end,
					set = function(v) AloftRaidIcon.db.profile.offsetX = v AloftRaidIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the raid icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftRaidIcon.db.profile.offsetY end,
					set = function(v) AloftRaidIcon.db.profile.offsetY = v AloftRaidIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			name = L["Size"],
			desc = L["Size in pixels of the raid icon"],
			min = 4,
			max = 64,
			step = 1,
			disabled = function() return not AloftRaidIcon.db.profile.enable end,
			get = function() return AloftRaidIcon.db.profile.size end,
			set = function(v) AloftRaidIcon.db.profile.size = v AloftRaidIcon:UpdateAll() end
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the raid icon alpha"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftRaidIcon.db.profile.enable end,
			get = function() return AloftRaidIcon.db.profile.alpha end,
			set = function(v) AloftRaidIcon.db.profile.alpha = v AloftRaidIcon:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------
