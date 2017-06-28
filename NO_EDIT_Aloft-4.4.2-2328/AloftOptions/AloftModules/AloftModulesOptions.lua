local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftModules
if not L then return end

-----------------------------------------------------------------------------

Aloft.Options.args.modules =
{
	type = 'group',
	order = 800,
	name = L["Modules"],
	desc = L["Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"],
	disabled = function(i) return not Aloft:IsEnabled() or not Aloft.db or not Aloft.db.profile end,
	args =
	{
		regentags =
		{
			type = 'execute',
			width = 'full',
			order = -1,
			name = L["Regenerate Text Tags"],
			desc = L["Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"],
			func  = function(i) AloftModules:Regenerate() end -- TODO: a check for being in combat?
		},
		reload =
		{
			type = 'execute',
			width = 'full',
			order = -1,
			name = L["Reload UI"],
			desc = L["Reload the user interface to synchronize all modules"],
			func  = function(i) ReloadUI() end -- TODO: a check for being in combat?
		},
	},
}

-----------------------------------------------------------------------------
