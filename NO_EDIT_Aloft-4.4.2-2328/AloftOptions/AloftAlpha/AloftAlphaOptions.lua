local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftAlphaOptions
if not L then return end

local AloftAlpha = Aloft:GetModule("Alpha", true)
if not AloftAlpha then return end

-----------------------------------------------------------------------------

Aloft.Options.args.AloftAlpha =
{
	type = 'group',
	name = L["Alpha"],
	desc = L["Various Alpha Options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftAlpha:IsEnabled() or not AloftAlpha.db or not AloftAlpha.db.profile end,
	args =
	{
		targetEnable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Target Enable"],
			desc = L["Enable changing alpha of target"],
			order = 1,
			get = function(i) return AloftAlpha.db.profile.targetEnable end,
			set = function(i, v) AloftAlpha.db.profile.targetEnable = v AloftAlpha:EnableChange() end,
		},
		targetAlpha =
		{
			type = 'range',
			width = 'full',
			name = L["Target Alpha"],
			desc = L["Sets the alpha of the target's nameplate"],
			order = 2,
			min = 0,
			max = 1,
			step = 0.01,
			disabled = function(i) return not AloftAlpha.db.profile.targetEnable end,
			get = function(i) return AloftAlpha.db.profile.targetAlpha end,
			set = function(i, v) AloftAlpha.db.profile.targetAlpha = v AloftAlpha:AdjustOptionValues() end,
		},
		nonTargetEnable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Non-Target Enable"],
			desc = L["Enable changing alpha of non-target"],
			order = 3,
			get = function(i) return AloftAlpha.db.profile.nonTargetEnable end,
			set = function(i, v) AloftAlpha.db.profile.nonTargetEnable = v AloftAlpha:EnableChange() end,
		},
		nonTargetAlpha =
		{
			type = 'range',
			width = 'full',
			name = L["Non-Target Alpha"],
			desc = L["Sets the alpha of non-target nameplates"],
			order = 4,
			min = 0,
			max = 1,
			step = 0.01,
			disabled = function(i) return not AloftAlpha.db.profile.nonTargetEnable end,
			get = function(i) return AloftAlpha.db.profile.nonTargetAlpha end,
			set = function(i, v) AloftAlpha.db.profile.nonTargetAlpha = v AloftAlpha:AdjustOptionValues() end,
		},
		defaultEnable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Default Enable"],
			desc = L["Enable changing alpha of default nameplates"],
			order = 5,
			get = function(i) return AloftAlpha.db.profile.defaultEnable end,
			set = function(i, v) AloftAlpha.db.profile.defaultEnable = v AloftAlpha:EnableChange() end,
		},
		defaultAlpha =
		{
			type = 'range',
			width = 'full',
			name = L["Default Alpha"],
			desc = L["Sets the alpha of default nameplates"],
			order = 6,
			min = 0,
			max = 1,
			step = 0.01,
			disabled = function(i) return not AloftAlpha.db.profile.defaultEnable end,
			get = function(i) return AloftAlpha.db.profile.defaultAlpha end,
			set = function(i, v) AloftAlpha.db.profile.defaultAlpha = v AloftAlpha:AdjustOptionValues() end,
		},
		--[[
		interval =
		{
			type = 'range',
			width = 'full',
			name = L["Update Interval"],
			desc = L["The amount of time, in seconds, between nameplate alpha change updates (0.0 seconds is as fast as the UI can do it)"],
			disabled = function(i) return not (AloftAlpha.db.profile.targetAlpha or AloftAlpha.db.profile.nonTargetEnable or AloftAlpha.db.profile.defaultEnable) end,
			order = 7,
			min = 0.0,
			max = 1.0,
			step = 0.01,
			get = function(i) return AloftAlpha.db.profile.interval end,
			set = function(i, v) AloftAlpha.db.profile.interval = v end,
		},
		]]
	},
}

-----------------------------------------------------------------------------

end)
