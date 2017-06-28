local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("ThreatData") then return end

local AloftThreatData = Aloft:GetModule("ThreatData")
local L = AceLibrary("AceLocale-2.2"):new("AloftThreatData")

-----------------------------------------------------------------------------

AloftThreatData.options =
{
	AOEEnable =
	{
		type = 'toggle',
		name = L["AOE Threat"],
		desc = L["Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"],
		order = 3,
		disabled = function() return
					not ((Aloft:HasModule("ThreatBar") and Aloft:GetModule("ThreatBar").db.profile.enable) or
					    (Aloft:HasModule("ThreatText") and Aloft:GetModule("ThreatText").db.profile.enable)) end,
		get = function() return AloftThreatData.db.profile.AOEEnable end,
		set = function(v) AloftThreatData.db.profile.AOEEnable = v Aloft:DetermineDataSources() end,
	},
	groupEnable =
	{
		type = 'toggle',
		name = L["Group Threat"],
		desc = L["Attempt to approximate threat for visible friendly units versus the player's current target"],
		order = 4,
		disabled = function() return
					not ((Aloft:HasModule("ThreatBar") and Aloft:GetModule("ThreatBar").db.profile.enable) or
					    (Aloft:HasModule("ThreatText") and Aloft:GetModule("ThreatText").db.profile.enable)) end,
		get = function() return AloftThreatData.db.profile.groupEnable end,
		set = function(v) AloftThreatData.db.profile.groupEnable = v Aloft:DetermineDataSources() end,
	},
	interval =
	{
		type = 'range',
		name = L["AOE/Group Threat Update Interval"],
		desc = L["The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"],
		order = 5,
		min = 0.0,
		max = 5.0,
		step = 0.01,
		disabled = function() return
					not (((Aloft:HasModule("ThreatBar") and Aloft:GetModule("ThreatBar").db.profile.enable) or
						(Aloft:HasModule("ThreatText") and Aloft:GetModule("ThreatText").db.profile.enable)) and
						(AloftThreatData.db.profile.AOEEnable or AloftThreatData.db.profile.groupEnable)) end,
		get = function() return AloftThreatData.db.profile.interval end,
		set = function(v) AloftThreatData.db.profile.interval = v Aloft:DetermineDataSources() end,
	},
}

-----------------------------------------------------------------------------

end)