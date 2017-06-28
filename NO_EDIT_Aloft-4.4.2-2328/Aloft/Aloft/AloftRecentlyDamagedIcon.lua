local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftRecentlyDamaged", function()

-----------------------------------------------------------------------------

local AloftRecentlyDamagedIcon = Aloft:NewModule("RecentlyDamagedIcon", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftRecentlyDamagedIcon.dynamic = "AloftRecentlyDamaged"

-----------------------------------------------------------------------------

AloftRecentlyDamagedIcon.namespace = "recentlyDamagedIcon"
AloftRecentlyDamagedIcon.defaults =
{
	profile =
	{
		enable			= false,
		alpha			= 1.0,
		point			= "RIGHT",
		relativeToPoint	= "LEFT",
		offsetX			= 0,
		offsetY			= 0,
		size			= 12,
	},
}

-----------------------------------------------------------------------------

function AloftRecentlyDamagedIcon:UpdateAll()
	if self.db.profile and self.db.profile.enable then
		for aloftData in Aloft:IterateNameplates() do
			self:Update(aloftData)
		end
		for layoutFrame in pairs(Aloft.layoutFramePool) do
			local recentlyDamagedIconRegion = layoutFrame.recentlyDamagedIconRegion
			if recentlyDamagedIconRegion then
				-- ChatFrame7:AddMessage("AloftRecentlyDamagedIcon:UpdateAll(): " .. tostring(layoutFrame.aloftData and layoutFrame.aloftData.name) .. "/" .. tostring(self.db.profile.point) .. "/" .. tostring(self.db.profile.relativeToPoint) .. "/" .. tostring(self.db.profile.offsetX) .. "/" .. tostring(self.db.profile.offsetY) .. "/" .. tostring(self.db.profile.size))
				self:PlaceFrame(recentlyDamagedIconRegion, layoutFrame, self.db.profile, 0, 0)
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
	if self.db.profile and self.db.profile.enable then
		return "recentlyDamaged"
	end
end

function AloftRecentlyDamagedIcon:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile and self.db.profile.enable then
		self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
		self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("Aloft:OnRecentlyDamagedChanged", "OnRecentlyDamagedChanged")
		self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
		self:RegisterMessage("Aloft:OnConfigModeChanged", "OnConfigModeChanged")
	end
end

-----------------------------------------------------------------------------

function AloftRecentlyDamagedIcon:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftRecentlyDamagedIcon:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UpdateAll()
end

function AloftRecentlyDamagedIcon:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		local layoutFrame = aloftData.layoutFrame
		local recentlyDamagedIconRegion = layoutFrame and layoutFrame.recentlyDamagedIconRegion
		if recentlyDamagedIconRegion then
			recentlyDamagedIconRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftRecentlyDamagedIcon:SetupFrame(message, aloftData)
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	local recentlyDamagedIconRegion = layoutFrame.recentlyDamagedIconRegion

	if not recentlyDamagedIconRegion then
		recentlyDamagedIconRegion = aloftData:CreateTexture()
		recentlyDamagedIconRegion:SetTexture("Interface\\CharacterFrame\\UI-StateIcon")
		recentlyDamagedIconRegion:SetTexCoord(0.5, 1, 0, 0.5)

		-- this is done in aloftData:CreateTexture()
		-- recentlyDamagedIconRegion:SetDrawLayer("OVERLAY")
		-- recentlyDamagedIconRegion:SetBlendMode("BLEND")

		layoutFrame.recentlyDamagedIconRegion = recentlyDamagedIconRegion
	end

	-- ChatFrame7:AddMessage("AloftRecentlyDamagedIcon:SetupFrame(): " .. tostring(layoutFrame.aloftData and layoutFrame.aloftData.name) .. "/" .. tostring(self.db.profile.point) .. "/" .. tostring(self.db.profile.relativeToPoint) .. "/" .. tostring(self.db.profile.offsetX) .. "/" .. tostring(self.db.profile.offsetY) .. "/" .. tostring(self.db.profile.size))
	self:PlaceFrame(recentlyDamagedIconRegion, layoutFrame, self.db.profile)

	if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then
		recentlyDamagedIconRegion:Show()
		aloftData.configMode = true
	elseif aloftData.configMode then
		recentlyDamagedIconRegion:Hide()
	end

	return recentlyDamagedIconRegion
end

function AloftRecentlyDamagedIcon:Update(aloftData)
	local recentlyDamagedIconRegion = self:SetupFrame("AloftRecentlyDamagedIcon:Update", aloftData)

	if recentlyDamagedIconRegion and (aloftData.recentlyDamaged or (Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()))) then
		recentlyDamagedIconRegion:Show()
	else
		self:OnNameplateHide("AloftRecentlyDamagedIcon:Update", aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftRecentlyDamagedIcon:OnRecentlyDamagedChanged(message, aloftData)
	self:Update(aloftData)
end

function AloftRecentlyDamagedIcon:OnNameplateShow(message, aloftData)
	self:Update(aloftData)
end

function AloftRecentlyDamagedIcon:OnNameplateHide(message, aloftData)
	local layoutFrame = aloftData.layoutFrame
	local recentlyDamagedIconRegion = layoutFrame and layoutFrame.recentlyDamagedIconRegion
	if recentlyDamagedIconRegion then
		recentlyDamagedIconRegion:Hide()
		-- ChatFrame7:AddMessage("AloftRecentlyDamagedIcon:OnNameplateHide(): hide " .. tostring(aloftData.name))
	end
end

function AloftRecentlyDamagedIcon:OnIsTargetDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftRecentlyDamagedIcon:OnIsTargetDataChanged(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:ScheduleTimer(function(aloftData) AloftRecentlyDamagedIcon:SetupFrame("AloftRecentlyDamagedIcon:OnIsTargetDataChanged", aloftData) end, 0.0, aloftData) -- next frame
end

function AloftRecentlyDamagedIcon:OnConfigModeChanged(message)
	local aloftData = Aloft:GetTargetNameplate()
	if aloftData then
		self:SetupFrame("AloftRecentlyDamagedIcon:OnConfigModeChanged", aloftData)
	end
end

-----------------------------------------------------------------------------

end)
