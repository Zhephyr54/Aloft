local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("GuildData") then return end

local AloftGuildData = Aloft:GetModule("GuildData")
local L = AceLibrary("AceLocale-2.2"):new("AloftGuildDataOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.guild =
{
	type = 'toggle',
	name = L["Save Guild Data"],
	desc = L["Stores guild information between sessions"],
	get = function() return AloftGuildData.db.profile.save end,
	set = AloftGuildData.SetSaveData,
}

-----------------------------------------------------------------------------

end)
