local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftReportStatusChanges
if not L then return end

local AloftReportStatusChanges = Aloft:NewModule("ReportStatus", Aloft, "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

AloftReportStatusChanges.namespace = "reportStatusChanges"
AloftReportStatusChanges.defaults =
{
	profile =
	{
		enable = true,
	},
}

-----------------------------------------------------------------------------

function AloftReportStatusChanges:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftReportStatusChanges:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:RegisterEvent("CVAR_UPDATE", "OnCVarUpdate")
	self:HookNameplates()
end

function AloftReportStatusChanges:OnDisable()
	self:UnhookAll()

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

function AloftReportStatusChanges:HookNameplates()
	self:UnhookAll()

	if self.db.profile.enable then
		self:RawHook(Aloft, "DisplayEnemyNameplates")
		self:RawHook(Aloft, "DisplayFriendNameplates")
		self:RawHook(Aloft, "ToggleAllNameplates")
	end
end

local function ReportNameplateStatus()
	Aloft:Print((Aloft:GetEnemyNameplates() and L["HostileNameplatesEnabled"] or L["HostileNameplatesDisabled"]).." "..
				(Aloft:GetFriendNameplates() and L["FriendlyNameplatesEnabled"] or L["FriendlyNameplatesDisabled"]))
end

-----------------------------------------------------------------------------

function AloftReportStatusChanges:OnCVarUpdate(event, name, value)
	-- ChatFrame7:AddMessage("CVAR " .. tostring(name) .. "/" .. tostring(value))
	-- TODO: set to check the CVar for enable/disable
end

function AloftReportStatusChanges:DisplayEnemyNameplates(this, value)
	-- ChatFrame7:AddMessage("AloftReportStatusChanges:DisplayEnemyNameplates(): invoke")
	self.hooks[this].DisplayEnemyNameplates(this, value)
	ReportNameplateStatus()
end

function AloftReportStatusChanges:DisplayFriendNameplates(this, value)
	-- ChatFrame7:AddMessage("AloftReportStatusChanges:DisplayFriendNameplates(): invoke")
	self.hooks[this].DisplayFriendNameplates(this, value)
	ReportNameplateStatus()
end

function AloftReportStatusChanges:ToggleAllNameplates(this)
	-- ChatFrame7:AddMessage("AloftReportStatusChanges:ToggleAllNameplates(): enter")
	if (Aloft:GetEnemyNameplates() or Aloft:GetFriendNameplates()) then
		-- ChatFrame7:AddMessage("AloftReportStatusChanges:ToggleAllNameplates(): disable all nameplates")
		self.hooks[this].DisplayEnemyNameplates(this, false)
		self.hooks[this].DisplayFriendNameplates(this, false)
	else
		-- ChatFrame7:AddMessage("AloftReportStatusChanges:ToggleAllNameplates(): enable all nameplates")
		self.hooks[this].DisplayEnemyNameplates(this, true)
		self.hooks[this].DisplayFriendNameplates(this, true)
	end
	ReportNameplateStatus()
	-- ChatFrame7:AddMessage("AloftReportStatusChanges:ToggleAllNameplates(): exit")
end

-----------------------------------------------------------------------------
