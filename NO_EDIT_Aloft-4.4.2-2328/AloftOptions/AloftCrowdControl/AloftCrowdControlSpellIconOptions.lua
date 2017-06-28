local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftCrowdControlSpellIconOptions
if not L then return end

local AloftCrowdControl = Aloft:GetModule("CrowdControl", true)
if not AloftCrowdControl then return end

local AloftCrowdControlSpellIcon = Aloft:GetModule("CrowdControlSpellIcon", true)
if not AloftCrowdControlSpellIcon then return end

-----------------------------------------------------------------------------

Aloft.Options.args.crowdControl.args.crowdControlSpellIcon =
{
	type = 'group',
	name = L["Spell Icon"],
	desc = L["Crowd control spell icon placement options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCrowdControl:IsEnabled() or not AloftCrowdControl.db or not AloftCrowdControl.db.profile or not AloftCrowdControl.db.profile.enable or not AloftCrowdControlSpellIcon:IsEnabled() or not AloftCrowdControlSpellIcon.db or not AloftCrowdControlSpellIcon.db.profile end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Enable crowd control spell icon display on the nameplate"],
			get = function(i) return AloftCrowdControlSpellIcon.db.profile.enable end,
			set = function(i, v) AloftCrowdControlSpellIcon.db.profile.enable = v AloftCrowdControlSpellIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust crowd control spell icon position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCrowdControl:IsEnabled() or not AloftCrowdControl.db or not AloftCrowdControl.db.profile or not AloftCrowdControl.db.profile.enable or not AloftCrowdControlSpellIcon:IsEnabled() or not AloftCrowdControlSpellIcon.db or not AloftCrowdControlSpellIcon.db.profile or not AloftCrowdControlSpellIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = 'select',
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the crowd control spell icon"],
					get = function(i) return AloftCrowdControlSpellIcon.db.profile.point end,
					set = function(i, v) AloftCrowdControlSpellIcon.db.profile.point = v AloftCrowdControlSpellIcon:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = 'select',
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the crowd control bar to anchor the spell icon"],
					get = function(i) return AloftCrowdControlSpellIcon.db.profile.relativeToPoint end,
					set = function(i, v) AloftCrowdControlSpellIcon.db.profile.relativeToPoint = v AloftCrowdControlSpellIcon:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the crowd control spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function(i) return AloftCrowdControlSpellIcon.db.profile.offsetX end,
					set = function(i, v) AloftCrowdControlSpellIcon.db.profile.offsetX = v AloftCrowdControlSpellIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the crowd control spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function(i) return AloftCrowdControlSpellIcon.db.profile.offsetY end,
					set = function(i, v) AloftCrowdControlSpellIcon.db.profile.offsetY = v AloftCrowdControlSpellIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			width = 'full',
			name = L["Size"],
			desc = L["Size in pixels of the crowd control spell icon"],
			min = 4,
			max = 32,
			step = 1,
			disabled = function(i) return not AloftCrowdControlSpellIcon.db.profile.enable end,
			get = function(i) return AloftCrowdControlSpellIcon.db.profile.size end,
			set = function(i, v) AloftCrowdControlSpellIcon.db.profile.size = v AloftCrowdControlSpellIcon:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------

end)
