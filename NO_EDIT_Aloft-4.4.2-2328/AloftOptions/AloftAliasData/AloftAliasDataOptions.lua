local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftAliasDataOptions
if not L then return end

local AloftAliasData = Aloft:GetModule("AliasData", true)
if not AloftAliasData then return end

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.alias =
{
	type = "execute",
	width = 'full',
	name = L["Reset Aliases"],
	desc = L["Empties the alias database"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftAliasData:IsEnabled() end,
	func = function(i) AloftAliasData:ClearAllData() end,
	confirm = function(i) return L["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] end,
}

-----------------------------------------------------------------------------
