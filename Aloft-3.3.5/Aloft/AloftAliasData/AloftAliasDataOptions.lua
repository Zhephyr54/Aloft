local Aloft = Aloft
if not Aloft or not Aloft:HasModule("AliasData") then return  end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftAliasDataOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.alias =
{
	type = "execute",
	name = L["Reset Aliases"],
	desc = L["Empties the alias database"],
	func = function() Aloft:GetModule("AliasData"):ClearAllData() end,
	confirm = L["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"]
}

-----------------------------------------------------------------------------
