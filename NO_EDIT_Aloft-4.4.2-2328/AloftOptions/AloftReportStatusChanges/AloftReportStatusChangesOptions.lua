local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftReportStatusChangesOptions
if not L then return end

local AloftReportStatusChanges = Aloft:GetModule("ReportStatus", true) -- always enabled
if not AloftReportStatusChanges then return end

-----------------------------------------------------------------------------

Aloft.Options.args.basic.args.reportStatusChanges =
{
	type = 'toggle',
	width = 'full',
	name = L["Report Status Changes"],
	desc = L["Prints the status of nameplates whenever they change"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftReportStatusChanges:IsEnabled() or not AloftReportStatusChanges.db or not AloftReportStatusChanges.db.profile end,
	get = function(i) return AloftReportStatusChanges.db.profile.enable end,
	set = function(i, v) AloftReportStatusChanges.db.profile.enable = v AloftReportStatusChanges:HookNameplates() end,
	order = 3,
}

-----------------------------------------------------------------------------
