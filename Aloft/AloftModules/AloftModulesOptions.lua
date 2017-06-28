local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.modules =
{
	type = 'group',
	order = 800,
	name = L["Modules"],
	desc = L["Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		regentags =
		{
			type = 'execute',
			order = -1,
			name = L["Regenerate Text Tags"],
			desc = L["Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"],
			func  = function() AloftModules:Regenerate() end -- TODO: a check for being in combat?
		},
		reload =
		{
			type = 'execute',
			order = -1,
			name = L["Reload UI"],
			desc = L["Reload the user interface to synchronize all modules"],
			func  = function() ReloadUI() end -- TODO: a check for being in combat?
		}
	},
}

-----------------------------------------------------------------------------
