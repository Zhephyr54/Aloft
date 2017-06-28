local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CrowdControl") then return end

local AloftCrowdControlSpellIcon = Aloft:NewModule("CrowdControlSpellIcon", "AceEvent-2.0")
AloftCrowdControlSpellIcon.dynamic = "AloftCrowdControl"

local AloftCrowdControl = Aloft:GetModule("CrowdControl")

-----------------------------------------------------------------------------

AloftCrowdControlSpellIcon.db = Aloft:AcquireDBNamespace("crowdControlSpellIcon")
Aloft:RegisterDefaults("crowdControlSpellIcon", "profile", {
	enable			= false,
	point			= "RIGHT",
	relativeToPoint	= "LEFT",
	offsetX			= 0,
	offsetY			= 0,
	size			= 12
})

-----------------------------------------------------------------------------

local crowdControlSpellIconRegion = nil
local profile

-----------------------------------------------------------------------------

function AloftCrowdControlSpellIcon:UpdateAll()
	self:CreateFrame()
	self:RegisterEvents()

	if profile.enable then
		self:SetupFrame()
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControlSpellIcon:CreateFrame()
	if not profile.enable then
		if crowdControlSpellIconRegion then
			crowdControlSpellIconRegion:Hide()
		end
		return
	end

	if not crowdControlSpellIconRegion and AloftCrowdControl.crowdControlExtraFrame then
		local crowdControlExtraFrame = AloftCrowdControl.crowdControlExtraFrame
		crowdControlSpellIconRegion = crowdControlExtraFrame:CreateTexture(nil, "OVERLAY")
		crowdControlSpellIconRegion:SetBlendMode("BLEND")
		crowdControlSpellIconRegion:Hide()
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControlSpellIcon:RegisterEvents()
	if profile.enable then
		self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
		self:RegisterEvent("Aloft:OnNameplateShow", "OnCrowdControlBarShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnCrowdControlBarHide")
		self:RegisterEvent("Aloft:OnCrowdControlBarShow", "OnCrowdControlBarShow")
		self:RegisterEvent("Aloft:OnCrowdControlBarHide", "OnCrowdControlBarHide")
	else
		self:CancelEvent("Aloft:SetupFrame")
		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnNameplateHide")
		self:CancelEvent("Aloft:OnCrowdControlBarShow")
		self:CancelEvent("Aloft:OnCrowdControlBarHide")
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControlSpellIcon:OnInitialize()
	profile = self.db.profile
end

function AloftCrowdControlSpellIcon:OnEnable()
	self:UpdateAll()
end

function AloftCrowdControlSpellIcon:OnDisable()
	self:UnregisterAllEvents()

	if crowdControlSpellIconRegion then
		crowdControlSpellIconRegion:Hide()
	end
end

function AloftCrowdControlSpellIcon:SetupFrame()
end

function AloftCrowdControlSpellIcon:OnCrowdControlBarShow(aloftData)
	self:PlaceFrame(crowdControlSpellIconRegion, AloftCrowdControl.crowdControlExtraFrame, profile)
	crowdControlSpellIconRegion:SetTexture(AloftCrowdControl.crowdControlSpellIcon)
	crowdControlSpellIconRegion:Show()

	self:ScheduleRepeatingEvent("AloftCrowdControlSpellIcon:UpdateAlpha", self.UpdateAlpha, 0.1, self, AloftCrowdControl.crowdControlStatusBar)
end

function AloftCrowdControlSpellIcon:OnCrowdControlBarHide(aloftData)
	self:CancelScheduledEvent("AloftCrowdControlSpellIcon:UpdateAlpha")
	crowdControlSpellIconRegion:SetTexture("")
	crowdControlSpellIconRegion:Hide()
end

function AloftCrowdControlSpellIcon:UpdateAlpha(crowdControlStatusBar)
	local _, _, _, a = crowdControlStatusBar:GetStatusBarColor()
	crowdControlSpellIconRegion:SetAlpha(a)
end

-----------------------------------------------------------------------------

end)
