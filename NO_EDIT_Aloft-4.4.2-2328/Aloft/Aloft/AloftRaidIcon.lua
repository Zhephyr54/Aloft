local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftRaidIcon = Aloft:NewModule("RaidIcon", Aloft, "AceEvent-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

AloftRaidIcon.namespace = "raidIcon"
AloftRaidIcon.defaults =
{
	profile =
	{
		enable			= true,
		alpha			= 0.75,
		point			= "CENTER",
		relativeToPoint	= "CENTER",
		offsetX			= 0,
		offsetY			= 0,
		size			= 32,
	},
}

-----------------------------------------------------------------------------

function AloftRaidIcon:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame("AloftRaidIcon:UpdateAll", aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftRaidIcon:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftRaidIcon:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
	self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
	-- self:RegisterMessage("Aloft:OnConfigModeChanged", "OnConfigModeChanged") -- in WoW 4.0, will be able to put a raid icon on nameplates at any time?
	self:UpdateAll()
end

function AloftRaidIcon:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		local raidIconRegion = aloftData.raidIconRegion
		raidIconRegion:ClearAllPoints()
		raidIconRegion:SetPoint("RIGHT", aloftData.nameplateFrame, "LEFT")
		raidIconRegion:SetWidth(29)
		raidIconRegion:SetHeight(29)
		raidIconRegion:SetAlpha(1)
		raidIconRegion:SetDrawLayer("OVERLAY")
	end
end

-----------------------------------------------------------------------------

function AloftRaidIcon:SetupFrame(message, aloftData)
	if aloftData then
		local layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		local raidIconRegion = aloftData.raidIconRegion

		self:PlaceFrame(raidIconRegion, layoutFrame, self.db.profile, 0, 0)
		raidIconRegion:SetDrawLayer("OVERLAY")
		raidIconRegion:SetBlendMode("BLEND")
	end
end

-----------------------------------------------------------------------------

function AloftRaidIcon:OnNameplateShow(message, aloftData)
	self:SetupFrame(message, aloftData)
end

function AloftRaidIcon:OnIsTargetDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftRaidIcon:OnIsTargetDataChanged(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:ScheduleTimer(function(aloftData) AloftRaidIcon:SetupFrame("AloftRaidIcon:OnIsTargetDataChanged", aloftData) end, 0.0, aloftData) -- next frame
end

-----------------------------------------------------------------------------
