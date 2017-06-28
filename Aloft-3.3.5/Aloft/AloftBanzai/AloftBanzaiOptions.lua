local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftBanzai", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("Banzai") then return end

local AloftBanzai = Aloft:GetModule("Banzai")
local L = AceLibrary("AceLocale-2.2"):new("AloftBanzaiOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.banzai =
{
	type = 'group',
	name = L["Banzai"],
	desc = L["Banzai options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Highlights group members that have aggro"],
			get = function() return AloftBanzai.db.profile.enable end,
			set = function(v) AloftBanzai.db.profile.enable = v Aloft:DetermineDataSources() AloftBanzai:UpdateAll() end,
			order = 1
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the aggro color"],
			disabled = function() return not AloftBanzai.db.profile.enable end,
			get = function() return unpack(AloftBanzai.db.profile.color) end,
			set = function(r, g, b, a) AloftBanzai.db.profile.color = { r, g, b, a } AloftBanzai:UpdateAll() end,
		},
	},
}

-----------------------------------------------------------------------------

end)
