local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftTargetTrackingData
if not L then return end

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData", true)
if not AloftTargetTrackingData then return end

-----------------------------------------------------------------------------

Aloft.Options.args.AloftTargetTrackingData =
{
	type = 'group',
	name = L["Target Tracking"],
	desc = L["Various target tracking options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftTargetTrackingData:IsEnabled() or not AloftTargetTrackingData.db or not AloftTargetTrackingData.db.profile end,
	args =
	{
		trackUnique =
		{
			type = 'toggle',
			width = "full",
			name = L["Treat Rares and Bosses as Unique (Experimental)"],
			desc = L["Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"],
			order = 5,
			get = function(i) return AloftTargetTrackingData.db.profile.trackUnique end,
			set = function(i, v) AloftTargetTrackingData.db.profile.trackUnique = v Aloft:DetermineDataSources() end,
		},
		--[[
		focusEnable =
		{
			type = 'toggle',
			width = "full",
			name = L["Enable Focus Tracking"],
			desc = L["Enable group focus target tracking"],
			get = function(i) return AloftTargetTrackingData.db.profile.focusEnable end,
			set = function(i, v) AloftTargetTrackingData.db.profile.focusEnable = v Aloft:DetermineDataSources() end,
			order = 1,
		},
		focusInterval =
		{
			type = 'range',
			width = "full",
			name = L["Focus Tracking Update Interval"],
			desc = L["The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"],
			min = 0.0,
			max = 5.0,
			step = 0.01,
			disabled = function(i) return not AloftTargetTrackingData.db.profile.focusEnable end,
			get = function(i) return AloftTargetTrackingData.db.profile.focusInterval end,
			set = function(i, v) AloftTargetTrackingData.db.profile.focusInterval = v Aloft:DetermineDataSources() end,
			order = 2,
		},
		]]
	},
}

-----------------------------------------------------------------------------
