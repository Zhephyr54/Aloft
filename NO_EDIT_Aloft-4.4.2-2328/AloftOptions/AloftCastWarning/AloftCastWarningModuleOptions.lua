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

Aloft.Options.args.modules.args.aloftCastWarning =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftCastWarning"],
	desc = L["Add cast warnings to Aloft unit nameplates"],
	disabled = function(i) return AloftModules.db.profile.AloftCastWarningSpellIcon or AloftModules.db.profile.AloftCastWarningSpellNameText or AloftModules.db.profile.AloftCastWarningTimeText end,
	get = function(i) return AloftModules.db.profile.AloftCastWarning end,
	set = function(i, v) AloftModules.db.profile.AloftCastWarning = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------

Aloft.Options.args.modules.args.aloftCastWarningSpellIcon =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftCastWarningSpellIcon"],
	desc = L["Display spell icon on cast warning"],
	disabled = function(i) return not AloftModules.db.profile.AloftCastWarning end,
	get = function(i) return AloftModules.db.profile.AloftCastWarningSpellIcon end,
	set = function(i, v) AloftModules.db.profile.AloftCastWarningSpellIcon = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------

Aloft.Options.args.modules.args.aloftCastWarningSpellNameText =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftCastWarningSpellNameText"],
	desc = L["Display spell name on cast warning"],
	disabled = function(i) return not AloftModules.db.profile.AloftCastWarning end,
	get = function(i) return AloftModules.db.profile.AloftCastWarningSpellNameText end,
	set = function(i, v) AloftModules.db.profile.AloftCastWarningSpellNameText = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------

Aloft.Options.args.modules.args.aloftCastWarningTimeText =
{
	type = 'toggle',
	width = 'full',
	name = L["AloftCastWarningTimeText"],
	desc = L["Display time text on cast warning"],
	disabled = function(i) return not AloftModules.db.profile.AloftCastWarning end,
	get = function(i) return AloftModules.db.profile.AloftCastWarningTimeText end,
	set = function(i, v) AloftModules.db.profile.AloftCastWarningTimeText = v AloftModules:Initialize() AloftModules:Activate() end,
}

-----------------------------------------------------------------------------
