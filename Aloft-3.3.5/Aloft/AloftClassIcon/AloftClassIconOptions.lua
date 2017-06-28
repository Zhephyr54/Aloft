local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("ClassIcon") then return end

local AloftClassIcon = Aloft:GetModule("ClassIcon")
local L = AceLibrary("AceLocale-2.2"):new("AloftClassIconOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.classIcon =
{
	type = 'group',
	name = L["Class Icon"],
	desc = L["Class icon placement options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable class icon display on the nameplate"],
			get = function() return AloftClassIcon.db.profile.enable end,
			set = function(v) AloftClassIcon.db.profile.enable = v AloftClassIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust class icon position"],
			disabled = function() return not AloftClassIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the class icon"],
					get = function() return AloftClassIcon.db.profile.point end,
					set = function(v) AloftClassIcon.db.profile.point = v AloftClassIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the class icon"],
					get = function() return AloftClassIcon.db.profile.relativeToPoint end,
					set = function(v) AloftClassIcon.db.profile.relativeToPoint = v AloftClassIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the class icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftClassIcon.db.profile.offsetX end,
					set = function(v) AloftClassIcon.db.profile.offsetX = v AloftClassIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the class icon"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftClassIcon.db.profile.offsetY end,
					set = function(v) AloftClassIcon.db.profile.offsetY = v AloftClassIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			name = L["Size"],
			desc = L["Size in pixels of the class icon"],
			min = 4,
			max = 64,
			step = 1,
			disabled = function() return not AloftClassIcon.db.profile.enable end,
			get = function() return AloftClassIcon.db.profile.size end,
			set = function(v) AloftClassIcon.db.profile.size = v AloftClassIcon:UpdateAll() end
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the class icon alpha"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftClassIcon.db.profile.enable end,
			get = function() return AloftClassIcon.db.profile.alpha end,
			set = function(v) AloftClassIcon.db.profile.alpha = v AloftClassIcon:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------

end)
