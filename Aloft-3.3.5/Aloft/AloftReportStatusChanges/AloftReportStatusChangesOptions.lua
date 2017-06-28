local Aloft = Aloft
if not Aloft or not Aloft:HasModule("ReportStatus") then return end

-----------------------------------------------------------------------------

local AloftReportStatusChanges = Aloft:GetModule("ReportStatus")
local L = AceLibrary("AceLocale-2.2"):new("AloftReportStatusChanges")

-----------------------------------------------------------------------------

Aloft.Options.args.reportStatusChanges =
{
	type = 'toggle',
	name = L["Report Status Changes"],
	desc = L["Prints the status of nameplates whenever they change"],
	get = function() return AloftReportStatusChanges.db.profile.enable end,
	set = function(v) AloftReportStatusChanges.db.profile.enable = v AloftReportStatusChanges:HookNameplates() end,
	order = 5,
}

-----------------------------------------------------------------------------
