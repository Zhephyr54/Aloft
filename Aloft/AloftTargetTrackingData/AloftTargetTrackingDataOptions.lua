local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData")
local L = AceLibrary("AceLocale-2.2"):new("AloftTargetTrackingDataOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.AloftTargetTrackingData =
{
	type = 'group',
	name = L["Target Tracking"],
	desc = L["Various target tracking options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		trackUnique =
		{
			type = 'toggle',
			name = L["Treat Rares and Bosses as Unique (Experimental)"],
			desc = L["Rare and elite boss targets (based on classification and level) are tracked as if their names are unique (experimental)"],
			order = 5,
			get = function() return AloftTargetTrackingData.db.profile.trackUnique end,
			set = function(v) AloftTargetTrackingData.db.profile.trackUnique = v Aloft:DetermineDataSources() end,
		},
		--[[
		focusEnable =
		{
			type = 'toggle',
			name = L["Enable Focus Tracking"],
			desc = L["Enable group focus target tracking"],
			get = function() return AloftTargetTrackingData.db.profile.focusEnable end,
			set = function(v) AloftTargetTrackingData.db.profile.focusEnable = v Aloft:DetermineDataSources() end,
			order = 1,
		},
		focusInterval =
		{
			type = 'range',
			name = L["Focus Tracking Update Interval"],
			desc = L["The amount of time, in seconds, between group focus updates (0.0 is as fast as possible)"],
			min = 0.0,
			max = 5.0,
			step = 0.01,
			disabled = function() return not AloftTargetTrackingData.db.profile.focusEnable end,
			get = function() return AloftTargetTrackingData.db.profile.focusInterval end,
			set = function(v) AloftTargetTrackingData.db.profile.focusInterval = v Aloft:DetermineDataSources() end,
			order = 2,
		},
		]]
	},
}

-----------------------------------------------------------------------------
