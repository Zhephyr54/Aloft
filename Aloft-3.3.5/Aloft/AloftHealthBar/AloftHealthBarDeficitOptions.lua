local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthBarDeficit", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("HealthBarDeficit") then return end

local AloftHealthBarDeficit = Aloft:GetModule("HealthBarDeficit")
local L = AceLibrary("AceLocale-2.2"):new("AloftHealthBarDeficit")

-----------------------------------------------------------------------------

-- inject our external module options into the appropriate internal module options
Aloft.Options.args.healthBar.args.deficit =
{
	type = 'toggle',
	name = L["Deficit Health Bar"],
	desc = L["Display health bar as a deficit (grows from right as health is lost)"],
	get = function() return AloftHealthBarDeficit.db.profile.enable end,
	set = function(v) AloftHealthBarDeficit.db.profile.enable = v Aloft:DetermineDataSources() AloftHealthBarDeficit:UpdateAll() end,
	order = 99
}

-----------------------------------------------------------------------------

end)
