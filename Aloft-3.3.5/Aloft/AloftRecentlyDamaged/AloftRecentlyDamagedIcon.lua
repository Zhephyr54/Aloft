local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftRecentlyDamaged", function()

-----------------------------------------------------------------------------

local AloftRecentlyDamagedIcon = Aloft:NewModule("RecentlyDamagedIcon", "AceEvent-2.0")
AloftRecentlyDamagedIcon.dynamic = "AloftRecentlyDamaged"

-----------------------------------------------------------------------------

AloftRecentlyDamagedIcon.db = Aloft:AcquireDBNamespace("recentlyDamagedIcon")
Aloft:RegisterDefaults("recentlyDamagedIcon", "profile", {
	enable			= false,
	alpha			= 1.0,
	point			= "RIGHT",
	relativeToPoint	= "LEFT",
	offsetX			= 0,
	offsetY			= 0,
	size			= 12
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftRecentlyDamagedIcon:UpdateAll()
	if profile and profile.enable then
		for aloftData in Aloft:IterateNameplates() do
			self:Update(aloftData)
		end
		for layoutFrame in pairs(Aloft.layoutFramePool) do
			local recentlyDamagedIconRegion = layoutFrame.recentlyDamagedIconRegion
			if recentlyDamagedIconRegion then
				-- ChatFrame7:AddMessage("AloftRecentlyDamagedIcon:UpdateAll(): " .. tostring(layoutFrame.aloftData and layoutFrame.aloftData.name) .. "/" .. tostring(profile.point) .. "/" .. tostring(profile.relativeToPoint) .. "/" .. tostring(profile.offsetX) .. "/" .. tostring(profile.offsetY) .. "/" .. tostring(profile.size))
				self:PlaceFrame(recentlyDamagedIconRegion, layoutFrame, profile, 0, 0)
			end
		end
	else
		for aloftData in Aloft:IterateNameplates() do
			local layoutFrame = aloftData.layoutFrame
			local recentlyDamagedIconRegion = layoutFrame and layoutFrame.recentlyDamagedIconRegion
			if recentlyDamagedIconRegion then
				recentlyDamagedIconRegion:Hide()
			end
		end
	end

	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftRecentlyDamagedIcon:RequiresData()
	if profile and profile.enable then
		return "recentlyDamaged"
	end
end

function AloftRecentlyDamagedIcon:RegisterEvents()
	if profile and profile.enable then
		self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterEvent("Aloft:OnRecentlyDamagedChanged", "OnRecentlyDamagedChanged")
	else
		self:CancelEvent("Aloft:SetupFrame")
		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnRecentlyDamagedChanged")
	end
end

-----------------------------------------------------------------------------

function AloftRecentlyDamagedIcon:OnInitialize()
	profile = self.db.profile
end

function AloftRecentlyDamagedIcon:OnEnable()
	self:UpdateAll()
end

function AloftRecentlyDamagedIcon:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local layoutFrame = aloftData.layoutFrame
		local recentlyDamagedIconRegion = layoutFrame and layoutFrame.recentlyDamagedIconRegion
		if recentlyDamagedIconRegion then
			recentlyDamagedIconRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftRecentlyDamagedIcon:SetupFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	local recentlyDamagedIconRegion = layoutFrame.recentlyDamagedIconRegion

	if not recentlyDamagedIconRegion then
		recentlyDamagedIconRegion = aloftData:CreateTexture()
		recentlyDamagedIconRegion:SetTexture("Interface\\CharacterFrame\\UI-StateIcon")
		recentlyDamagedIconRegion:SetTexCoord(0.5, 1, 0, 0.5)

		layoutFrame.recentlyDamagedIconRegion = recentlyDamagedIconRegion
	end

	-- ChatFrame7:AddMessage("AloftRecentlyDamagedIcon:SetupFrame(): " .. tostring(layoutFrame.aloftData and layoutFrame.aloftData.name) .. "/" .. tostring(profile.point) .. "/" .. tostring(profile.relativeToPoint) .. "/" .. tostring(profile.offsetX) .. "/" .. tostring(profile.offsetY) .. "/" .. tostring(profile.size))
	self:PlaceFrame(recentlyDamagedIconRegion, layoutFrame, profile)

	return recentlyDamagedIconRegion
end

function AloftRecentlyDamagedIcon:Update(aloftData)
	local recentlyDamagedIconRegion = self:SetupFrame(aloftData)

	if recentlyDamagedIconRegion and aloftData.recentlyDamaged then
		recentlyDamagedIconRegion:Show()
	else
		self:OnNameplateHide(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftRecentlyDamagedIcon:OnRecentlyDamagedChanged(aloftData)
	self:Update(aloftData)
end

function AloftRecentlyDamagedIcon:OnNameplateShow(aloftData)
	self:Update(aloftData)
end

function AloftRecentlyDamagedIcon:OnNameplateHide(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local recentlyDamagedIconRegion = layoutFrame and layoutFrame.recentlyDamagedIconRegion
	if recentlyDamagedIconRegion then
		recentlyDamagedIconRegion:Hide()
		-- ChatFrame7:AddMessage("AloftRecentlyDamagedIcon:OnNameplateHide(): hide " .. tostring(aloftData.name))
	end
end

-----------------------------------------------------------------------------

end)
