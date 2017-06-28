local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftRaidIcon = Aloft:NewModule("RaidIcon", "AceEvent-2.0")

-----------------------------------------------------------------------------

AloftRaidIcon.db = Aloft:AcquireDBNamespace("raidIcon")
Aloft:RegisterDefaults("raidIcon", "profile", {
	enable			= true,
	alpha			= 0.75,
	point			= "CENTER",
	relativeToPoint	= "CENTER",
	offsetX			= 0,
	offsetY			= 0,
	size			= 32
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftRaidIcon:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftRaidIcon:OnInitialize()
	profile = self.db.profile
end

function AloftRaidIcon:OnEnable()
	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
	self:UpdateAll()
end

function AloftRaidIcon:OnDisable()
	self:UnregisterAllEvents()

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

function AloftRaidIcon:SetupFrame(aloftData)
	if aloftData then
		local layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		local raidIconRegion = aloftData.raidIconRegion

		self:PlaceFrame(raidIconRegion, layoutFrame, profile, 0, 0)
		raidIconRegion:SetDrawLayer("OVERLAY")
		raidIconRegion:SetBlendMode("BLEND")
	end
end

-----------------------------------------------------------------------------

function AloftRaidIcon:OnNameplateShow(aloftData)
	self:SetupFrame(aloftData)
end

function AloftRaidIcon:OnIsTargetDataChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftRaidIcon:OnIsTargetDataChanged(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	local eventName = "AloftRaidIcon:OnIsTargetDataChanged(): " .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.SetupFrame, 0.0, self, aloftData) -- next frame
end

-----------------------------------------------------------------------------
