local Aloft = Aloft
if (not Aloft) then return end

-----------------------------------------------------------------------------

local AloftReportStatusChanges = Aloft:NewModule("ReportStatus", "AceEvent-2.0", "AceHook-2.1")
local L = AceLibrary("AceLocale-2.2"):new("AloftReportStatusChanges")

-----------------------------------------------------------------------------

AloftReportStatusChanges.db = Aloft:AcquireDBNamespace("reportStatusChanges")
Aloft:RegisterDefaults("reportStatusChanges", "profile", { enable = true })

-----------------------------------------------------------------------------

function AloftReportStatusChanges:OnEnable()
	self:RegisterEvent("CVAR_UPDATE", "OnCVarUpdate")
	self:HookNameplates()
end

function AloftReportStatusChanges:OnDisable()
end

function AloftReportStatusChanges:HookNameplates()
	self:UnhookAll()

	if self.db.profile.enable then
		self:Hook(Aloft, "DisplayEnemyNameplates")
		self:Hook(Aloft, "DisplayFriendNameplates")
		self:Hook(Aloft, "ToggleAllNameplates")
	end
end

local function ReportNameplateStatus()
	Aloft:Print((Aloft:GetEnemyNameplates() and L["HostileNameplatesEnabled"] or L["HostileNameplatesDisabled"]).." "..
				(Aloft:GetFriendNameplates() and L["FriendlyNameplatesEnabled"] or L["FriendlyNameplatesDisabled"]))
end

-----------------------------------------------------------------------------

function AloftReportStatusChanges:OnCVarUpdate(name, value)
	-- ChatFrame7:AddMessage("CVAR " .. tostring(name) .. "/" .. tostring(value))
	-- TODO: set to check the CVar for enable/disable
end

function AloftReportStatusChanges:DisplayEnemyNameplates(this, value)
	--if (Aloft:IsLogEnbl("ReportStatusChanges", 1)) then Aloft:Log("ReportStatusChanges", "DisplayEnemyNameplates", 1, invoke") end
	self.hooks[this].DisplayEnemyNameplates(this, value)
	ReportNameplateStatus()
end

function AloftReportStatusChanges:DisplayFriendNameplates(this, value)
	--if (Aloft:IsLogEnbl("ReportStatusChanges", 1)) then Aloft:Log("ReportStatusChanges", "DisplayFriendNameplates", 1, invoke") end
	self.hooks[this].DisplayFriendNameplates(this, value)
	ReportNameplateStatus()
end

function AloftReportStatusChanges:ToggleAllNameplates(this)
	if (Aloft:GetEnemyNameplates() or Aloft:GetFriendNameplates()) then
		self.hooks[this].DisplayEnemyNameplates(this, false)
		self.hooks[this].DisplayFriendNameplates(this, false)
	else
		self.hooks[this].DisplayEnemyNameplates(this, true)
		self.hooks[this].DisplayFriendNameplates(this, true)
	end
	ReportNameplateStatus()
end

-----------------------------------------------------------------------------
