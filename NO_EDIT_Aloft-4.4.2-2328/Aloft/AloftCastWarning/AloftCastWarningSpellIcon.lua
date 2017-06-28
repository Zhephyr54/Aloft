local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellIcon", function()

-----------------------------------------------------------------------------

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData", true)
if not AloftTargetTrackingData then return end

local AloftCastWarning = Aloft:GetModule("CastWarning", true)
if not AloftCastWarning then return end

local AloftCastWarningSpellIcon = Aloft:NewModule("CastWarningSpellIcon", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftCastWarningSpellIcon.dynamic = "AloftCastWarningSpellIcon"

-----------------------------------------------------------------------------

AloftCastWarningSpellIcon.namespace = "castWarningSpellIcon"
AloftCastWarningSpellIcon.defaults =
{
	profile =
	{
		enable			= true,
		point			= "LEFT",
		relativeToPoint	= "LEFT",
		offsetX			= 0,
		offsetY			= 0,
		size			= 11,

		nointerShield	= true,
		nointerStyle	= "SQUARE",
		nointerColor	= { 1.0, 1.0, 1.0, 0.65 }, -- white
	},
}

-----------------------------------------------------------------------------

-- textures for shield graphic
local noInterruptTexture =
{
	["ROUND"]	= [[Interface\Addons\Aloft\Textures\RndNoInterrupt]],
	["SQUARE"]	= [[Interface\Addons\Aloft\Textures\SqrNoInterrupt]],
}

-- determines how shield graphic scales with spell icon
local noInterruptSize =
{
	["ROUND"]	= { w = 2.5, h = 2.5, },
	["SQUARE"]	= { w = 2.5, h = 2.5, },
}

-----------------------------------------------------------------------------

function AloftCastWarningSpellIcon:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if self.db.profile.enable then
			self:Update("AloftCastWarningSpellIcon:UpdateAll", aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellIcon:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile and self.db.profile.enable then
		self:RegisterMessage("Aloft:OnNameplateShow", "Update")
		self:RegisterMessage("Aloft:OnSetHealthBarColor", "Update") -- TODO: is this needed?
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("AloftCastWarning:OnCastWarningDataChanged", "OnCastWarningDataChanged")
	end
end

local dataRequiredList = { }
function AloftCastWarningSpellIcon:RequiresData()
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellIcon:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftCastWarningSpellIcon:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UpdateAll()
end

function AloftCastWarningSpellIcon:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateHide("AloftCastWarningSpellIcon:OnDisable", aloftData)
	end
	-- TODO: nil out Aloft.Options?
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellIcon:Update(message, aloftData)
	local nameplateId = AloftTargetTrackingData:GetNameplateId(aloftData)
	if nameplateId then
		local nameplateGUId = AloftTargetTrackingData:GetNameplateGUId(nameplateId)
		if nameplateGUId then
			local active = nameplateGUId and AloftCastWarning:GetActiveCastByGUId(nameplateGUId)

			self:CreateFrame(aloftData, nameplateGUId, active)
		end
	end
end

function AloftCastWarningSpellIcon:OnCastWarningDataChanged(message, aloftData, nameplateGUId, active)
	-- TODO: this can be guarded here, for basic enable purposes; it would be more efficient
	-- ChatFrame7:AddMessage("AloftCastWarningSpellIcon:OnCastWarningDataChanged() " .. tostring(aloftData.name) .. "/" .. tostring(nameplateGUId) .. "/" .. tostring(active and active.id) .. "/" .. tostring(active and active.name))
	self:CreateFrame(aloftData, nameplateGUId, active)
end

function AloftCastWarningSpellIcon:OnNameplateHide(message, aloftData)
	local castWarningFrame = aloftData.castWarningFrame
	if castWarningFrame then
		local castWarningSpellIconRegion = castWarningFrame.castWarningSpellIconRegion
		if castWarningSpellIconRegion then
			castWarningSpellIconRegion:Hide()
		end
		local nointerruptRegion = castWarningFrame.nointerruptRegion
		if nointerruptRegion then
			nointerruptRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellIcon:CreateFrame(aloftData, nameplateGUId, active)
	if AloftCastWarning.db.profile.enable and self.db.profile.enable then
		local castWarningFrame = aloftData.castWarningFrame
		if nameplateGUId and active and castWarningFrame and castWarningFrame:IsVisible() then
			-- Check if this nameplate already has a text region assigned to it
			local castWarningSpellIconRegion = castWarningFrame.castWarningSpellIconRegion
			if not castWarningSpellIconRegion then
				castWarningSpellIconRegion = castWarningFrame.castWarningExtraFrame:CreateTexture(nil, "OVERLAY")
				castWarningFrame.castWarningSpellIconRegion = castWarningSpellIconRegion
			end

			local nointerruptRegion = castWarningFrame.nointerruptRegion
			if not nointerruptRegion then
				nointerruptRegion = castWarningFrame.castWarningExtraFrame:CreateTexture(nil, "BORDER")

				castWarningFrame.nointerruptRegion = nointerruptRegion
			end

			self:PlaceFrame(castWarningSpellIconRegion, castWarningFrame.castWarningExtraFrame, self.db.profile)
			castWarningSpellIconRegion:SetTexture(active.icon)
			castWarningSpellIconRegion:Show()

			if self.db.profile.nointerShield and active.noInterrupt then
				local texture = noInterruptTexture[self.db.profile.nointerStyle]

				nointerruptRegion:SetTexture(texture)
				nointerruptRegion:SetVertexColor(unpack(self.db.profile.nointerColor))
		
				nointerruptRegion:ClearAllPoints()
				nointerruptRegion:SetWidth(noInterruptSize[self.db.profile.nointerStyle].w * self.db.profile.size)
				nointerruptRegion:SetHeight(noInterruptSize[self.db.profile.nointerStyle].h * self.db.profile.size)
				nointerruptRegion:SetPoint("CENTER", castWarningSpellIconRegion, "CENTER", 0, 0)
				nointerruptRegion:SetAlpha(1.0)
				nointerruptRegion:Show()

				-- ChatFrame7:AddMessage("AloftCastWarningSpellIcon:CreateFrame() show nointerruptRegion " .. tostring(nointerruptRegion:IsVisible()) .. "/" .. tostring(texture) .. "/" .. tostring(nointerruptRegion:GetTexture()))
			else
				-- some users have reported the occasional residual no-interrupt graphics appearing on nameplates; explicitly hide this if it is not being used
				-- ChatFrame7:AddMessage("AloftCastWarningSpellIcon:CreateFrame() hide nointerruptRegion")
				nointerruptRegion:Hide()
			end
			return
		end
	end

	-- ChatFrame7:AddMessage("AloftCastWarningSpellIcon:CreateFrame() hide")
	self:OnNameplateHide("AloftCastWarningSpellIcon:CreateFrame", aloftData)
end

-----------------------------------------------------------------------------

end)
