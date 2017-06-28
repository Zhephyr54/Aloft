local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftBossIcon = Aloft:NewModule("BossIcon", Aloft, "AceEvent-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

AloftBossIcon.namespace = "bossIcon"
AloftBossIcon.defaults =
{
	profile =
	{
		enable			= true,
		alpha			= 1.0,
		point			= "CENTER",
		relativeToPoint	= "CENTER",
		offsetX			= 0,
		offsetY			= 0,
		size			= 12,
	},
}

-----------------------------------------------------------------------------

function AloftBossIcon:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame("AloftBossIcon:UpdateAll", aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftBossIcon:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftBossIcon:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
	self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
	self:RegisterMessage("Aloft:OnConfigModeChanged", "OnConfigModeChanged")
	self:UpdateAll()
end

function AloftBossIcon:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		local bossIconRegion = aloftData.bossIconRegion

		bossIconRegion:ClearAllPoints()
		bossIconRegion:SetPoint("CENTER", aloftData.levelTextFrame, "CENTER")
		bossIconRegion:SetWidth(14.5)
		bossIconRegion:SetHeight(14.5)
		bossIconRegion:SetAlpha(1)
		bossIconRegion:SetDrawLayer("OVERLAY")
	end
end

-----------------------------------------------------------------------------

function AloftBossIcon:SetupFrame(message, aloftData)
	if aloftData then
		local layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		local bossIconRegion = aloftData.bossIconRegion

		self:PlaceFrame(bossIconRegion, layoutFrame, self.db.profile, 0, 0)
		bossIconRegion:SetDrawLayer("OVERLAY")
		bossIconRegion:SetBlendMode("BLEND")

		if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) and not bossIconRegion:IsVisible() then
			bossIconRegion:Show()
			aloftData.configMode = true
		elseif aloftData.configMode then
			bossIconRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftBossIcon:OnNameplateShow(message, aloftData)
	self:SetupFrame("AloftBossIcon:OnNameplateShow", aloftData)
end

function AloftBossIcon:OnIsTargetDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftBossIcon:OnIsTargetDataChanged(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:ScheduleTimer(function(aloftData) AloftBossIcon:SetupFrame("AloftBossIcon:OnIsTargetDataChanged", aloftData) end, 0.0, aloftData) -- next frame
end

function AloftBossIcon:OnConfigModeChanged(message)
	local aloftData = Aloft:GetTargetNameplate()
	if aloftData then
		self:SetupFrame("AloftBossIcon:OnIsTargetDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------
