local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftShortGuildDataOptions
if not L then return end

local AloftShortGuildData = Aloft:GetModule("ShortGuildData", true)
if not AloftShortGuildData then return end

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.shortGuild =
{
	type = 'execute',
	width = 'full',
	name = L["Reset Short Guilds"],
	desc = L["Empties the custom short guild database"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftShortGuildData:IsEnabled() end,
	func = function(i) AloftShortGuildData:ClearAllData() end,
	confirm = function(i) return L["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] end,
}

-----------------------------------------------------------------------------

end)
