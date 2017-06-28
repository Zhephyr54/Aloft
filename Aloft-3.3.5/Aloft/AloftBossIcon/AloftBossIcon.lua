local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftBossIcon = Aloft:NewModule("BossIcon", "AceEvent-2.0")

-----------------------------------------------------------------------------

AloftBossIcon.db = Aloft:AcquireDBNamespace("bossIcon")
Aloft:RegisterDefaults("bossIcon", "profile", {
	enable			= true,
	alpha			= 1.0,
	point			= "CENTER",
	relativeToPoint	= "CENTER",
	offsetX			= 0,
	offsetY			= 0,
	size			= 12
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftBossIcon:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftBossIcon:OnInitialize()
	profile = self.db.profile
end

function AloftBossIcon:OnEnable()
	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
	self:UpdateAll()
end

function AloftBossIcon:OnDisable()
	self:UnregisterAllEvents()

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

function AloftBossIcon:SetupFrame(aloftData)
	if aloftData then
		local layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		local bossIconRegion = aloftData.bossIconRegion

		self:PlaceFrame(bossIconRegion, layoutFrame, profile, 0, 0)
		bossIconRegion:SetDrawLayer("OVERLAY")
		bossIconRegion:SetBlendMode("BLEND")
	end
end

-----------------------------------------------------------------------------

function AloftBossIcon:OnNameplateShow(aloftData)
	self:SetupFrame(aloftData)
end

function AloftBossIcon:OnIsTargetDataChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftBossIcon:OnIsTargetDataChanged(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	local eventName = "AloftBossIcon:OnIsTargetDataChanged(): " .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.SetupFrame, 0.0, self, aloftData) -- next frame
end

-----------------------------------------------------------------------------
