local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftGuildDataOptions
if not L then return end

local AloftGuildData = Aloft:GetModule("GuildData", true)
if not AloftGuildData then return end

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.guild =
{
	type = 'toggle',
	width = 'full',
	name = L["Save Guild Data"],
	desc = L["Stores guild information between sessions"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftGuildData:IsEnabled() or not AloftGuildData.db or not AloftGuildData.db.profile end,
	get = function(i) return AloftGuildData.db.profile.save end,
	set = AloftGuildData.SetSaveData,
}

-----------------------------------------------------------------------------

end)
