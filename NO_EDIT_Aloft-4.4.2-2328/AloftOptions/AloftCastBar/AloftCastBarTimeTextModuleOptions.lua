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

Aloft.Options.args.modules.args.aloftCastBarTimeText =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftCastBarTimeText"],
	desc = L["Display cast bar time text"],
	get = function(i) return AloftModules.db.profile.AloftCastBarTimeText end,
	set = function(i, v) AloftModules.db.profile.AloftCastBarTimeText = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
