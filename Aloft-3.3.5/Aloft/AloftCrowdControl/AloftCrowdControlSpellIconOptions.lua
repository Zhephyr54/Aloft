local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CrowdControlSpellIcon") then return end

local AloftCrowdControlSpellIcon = Aloft:GetModule("CrowdControlSpellIcon")
local SML = AceLibrary("LibSharedMedia-3.0")
local L = AceLibrary("AceLocale-2.2"):new("AloftCrowdControlSpellIconOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.crowdControl.args.crowdControlSpellIcon =
{
	type = 'group',
	name = L["Spell Icon"],
	desc = L["Crowd control spell icon placement options"],
	disabled = function() return not AloftCrowdControl.db.profile.enable end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable crowd control spell icon display on the nameplate"],
			get = function() return AloftCrowdControlSpellIcon.db.profile.enable end,
			set = function(v) AloftCrowdControlSpellIcon.db.profile.enable = v AloftCrowdControlSpellIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust crowd control spell icon position"],
			disabled = function() return not AloftCrowdControlSpellIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the crowd control spell icon"],
					get = function() return AloftCrowdControlSpellIcon.db.profile.point end,
					set = function(v) AloftCrowdControlSpellIcon.db.profile.point = v AloftCrowdControlSpellIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the crowd control bar to anchor the spell icon"],
					get = function() return AloftCrowdControlSpellIcon.db.profile.relativeToPoint end,
					set = function(v) AloftCrowdControlSpellIcon.db.profile.relativeToPoint = v AloftCrowdControlSpellIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the crowd control spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCrowdControlSpellIcon.db.profile.offsetX end,
					set = function(v) AloftCrowdControlSpellIcon.db.profile.offsetX = v AloftCrowdControlSpellIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the crowd control spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCrowdControlSpellIcon.db.profile.offsetY end,
					set = function(v) AloftCrowdControlSpellIcon.db.profile.offsetY = v AloftCrowdControlSpellIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			name = L["Size"],
			desc = L["Size in pixels of the crowd control spell icon"],
			min = 4,
			max = 32,
			step = 1,
			disabled = function() return not AloftCrowdControlSpellIcon.db.profile.enable end,
			get = function() return AloftCrowdControlSpellIcon.db.profile.size end,
			set = function(v) AloftCrowdControlSpellIcon.db.profile.size = v AloftCrowdControlSpellIcon:UpdateAll() end
		},
	},
}

-----------------------------------------------------------------------------

end)
