local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("Alpha") then return end

local AloftAlpha = Aloft:GetModule("Alpha")
local L = AceLibrary("AceLocale-2.2"):new("AloftAlphaOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.AloftAlpha =
{
	type = 'group',
	name = L["Alpha"],
	desc = L["Various Alpha Options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		targetEnable =
		{
			type = 'toggle',
			name = L["Target Enable"],
			desc = L["Enable changing alpha of target"],
			get = function() return AloftAlpha.db.profile.targetEnable end,
			set = function(v) AloftAlpha.db.profile.targetEnable = v AloftAlpha:EnableChange() end,
			order = 1
		},
		targetAlpha =
		{
			type = 'range',
			name = L["Target Alpha"],
			desc = L["Sets the alpha of the target's nameplate"],
			min = 0,
			max = 1,
			step = 0.01,
			disabled = function() return not AloftAlpha.db.profile.targetEnable end,
			get = function() return AloftAlpha.db.profile.targetAlpha end,
			set = function(v) AloftAlpha.db.profile.targetAlpha = v AloftAlpha:AdjustOptionValues() end,
			order = 2,
		},
		nonTargetEnable =
		{
			type = 'toggle',
			name = L["Non-Target Enable"],
			desc = L["Enable changing alpha of non-target"],
			get = function() return AloftAlpha.db.profile.nonTargetEnable end,
			set = function(v) AloftAlpha.db.profile.nonTargetEnable = v AloftAlpha:EnableChange() end,
			order = 3,
		},
		nonTargetAlpha =
		{
			type = 'range',
			name = L["Non-Target Alpha"],
			desc = L["Sets the alpha of non-target nameplates"],
			min = 0,
			max = 1,
			step = 0.01,
			disabled = function() return not AloftAlpha.db.profile.nonTargetEnable end,
			get = function() return AloftAlpha.db.profile.nonTargetAlpha end,
			set = function(v) AloftAlpha.db.profile.nonTargetAlpha = v AloftAlpha:AdjustOptionValues() end,
			order = 4,
		},
		defaultEnable =
		{
			type = 'toggle',
			name = L["Default Enable"],
			desc = L["Enable changing alpha of default nameplates"],
			get = function() return AloftAlpha.db.profile.defaultEnable end,
			set = function(v) AloftAlpha.db.profile.defaultEnable = v AloftAlpha:EnableChange() end,
			order = 5,
		},
		defaultAlpha =
		{
			type = 'range',
			name = L["Default Alpha"],
			desc = L["Sets the alpha of default nameplates"],
			min = 0,
			max = 1,
			step = 0.01,
			disabled = function() return not AloftAlpha.db.profile.defaultEnable end,
			get = function() return AloftAlpha.db.profile.defaultAlpha end,
			set = function(v) AloftAlpha.db.profile.defaultAlpha = v AloftAlpha:AdjustOptionValues() end,
			order = 6,
		},
		--[[
		interval =
		{
			type = 'range',
			name = L["Update Interval"],
			desc = L["The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"],
			min = 0.0,
			max = 1.0,
			step = 0.01,
			disabled = function() return not (AloftAlpha.db.profile.targetAlpha or AloftAlpha.db.profile.nonTargetEnable or AloftAlpha.db.profile.defaultEnable) end,
			get = function() return AloftAlpha.db.profile.interval end,
			set = function(v) AloftAlpha.db.profile.interval = v end,
			order = 7,
		},
		]]
	},
}

-----------------------------------------------------------------------------

end)
