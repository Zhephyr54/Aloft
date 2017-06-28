local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("ShortGuildData") then return end

local AloftShortGuildData = Aloft:GetModule("ShortGuildData")
local L = AceLibrary("AceLocale-2.2"):new("AloftShortGuildDataOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.shortGuild =
{
	type = "execute",
	name = L["Reset Short Guilds"],
	desc = L["Empties the custom short guild database"],
	func = function() AloftShortGuildData:ClearAllData() end,
	confirm = L["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"]
}

-----------------------------------------------------------------------------

end)
