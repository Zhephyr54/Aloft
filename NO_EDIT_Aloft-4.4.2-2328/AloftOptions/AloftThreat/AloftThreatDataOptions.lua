local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftThreatDataOptions
if not L then return end

local AloftThreatData = Aloft:GetModule("ThreatData", true)
if not AloftThreatData then return end

-----------------------------------------------------------------------------

AloftThreatData.options =
{
	AOEEnable =
	{
		type = 'toggle',
		width = 'full',
		name = L["AOE Threat"],
		desc = L["Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"],
		order = 3,
		disabled = function(i) return
					not Aloft:IsEnabled() or not AloftThreatData:IsEnabled() or
					not (Aloft:GetModule("ThreatBar", true) and Aloft:GetModule("ThreatBar"):IsEnabled() and Aloft:GetModule("ThreatBar").db.profile.enable) or
					not (Aloft:GetModule("ThreatText", true) and Aloft:GetModule("ThreatText"):IsEnabled() and Aloft:GetModule("ThreatText").db.profile.enable) end,
		get = function(i) return AloftThreatData.db.profile.AOEEnable end,
		set = function(i, v) AloftThreatData.db.profile.AOEEnable = v Aloft:DetermineDataSources() end,
	},
	groupEnable =
	{
		type = 'toggle',
		width = 'full',
		name = L["Group Threat"],
		desc = L["Attempt to approximate threat for visible friendly units versus the player's current target"],
		order = 4,
		disabled = function(i) return
					not Aloft:IsEnabled() or not AloftThreatData:IsEnabled() or 
					not (Aloft:GetModule("ThreatBar", true) and Aloft:GetModule("ThreatBar"):IsEnabled() and Aloft:GetModule("ThreatBar").db.profile.enable) or
					not (Aloft:GetModule("ThreatText", true) and Aloft:GetModule("ThreatText"):IsEnabled() and Aloft:GetModule("ThreatText").db.profile.enable) end,
		get = function(i) return AloftThreatData.db.profile.groupEnable end,
		set = function(i, v) AloftThreatData.db.profile.groupEnable = v Aloft:DetermineDataSources() end,
	},
	interval =
	{
		type = 'range',
		width = 'full',
		name = L["AOE/Group Threat Update Interval"],
		desc = L["The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"],
		order = 5,
		min = 0.0,
		max = 5.0,
		step = 0.01,
		disabled = function(i) return
					not Aloft:IsEnabled() or not AloftThreatData:IsEnabled() or 
					not (Aloft:GetModule("ThreatBar", true) and Aloft:GetModule("ThreatBar"):IsEnabled() and Aloft:GetModule("ThreatBar").db.profile.enable) or
					not (Aloft:GetModule("ThreatText", true) and Aloft:GetModule("ThreatText"):IsEnabled() and Aloft:GetModule("ThreatText").db.profile.enable) or
					not AloftThreatData.db.profile.AOEEnable or not AloftThreatData.db.profile.groupEnable end,
		get = function(i) return AloftThreatData.db.profile.interval end,
		set = function(i, v) AloftThreatData.db.profile.interval = v Aloft:DetermineDataSources() end,
	},
}

-----------------------------------------------------------------------------

end)