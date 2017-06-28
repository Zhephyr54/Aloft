local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CrowdControl") then return end

local AloftCrowdControlSpellNameText = Aloft:NewModule("CrowdControlSpellNameText", "AceEvent-2.0")
AloftCrowdControlSpellNameText.dynamic = "AloftCrowdControl"

local AloftCrowdControl = Aloft:GetModule("CrowdControl")

-----------------------------------------------------------------------------

AloftCrowdControlSpellNameText.db = Aloft:AcquireDBNamespace("crowdControlSpellNameText")
Aloft:RegisterDefaults("crowdControlSpellNameText", "profile", {
	enable			= false,
	font			= "Arial Narrow",
	fontSize		= 9,
	shadow			= true,
	alignment		= "LEFT",
	outline			= "",
	offsets =
	{
		left		= 0,
		right		= 0,
		vertical	= 0,
	},
	color			= { 1, 1, 1, 1 }
})

-----------------------------------------------------------------------------

local crowdControlSpellNameTextRegion = nil
local profile

-----------------------------------------------------------------------------

function AloftCrowdControlSpellNameText:Update()
	self:CreateFrame()
	self:RegisterEvents()

	if profile.enable then
		self:SetupFrame()
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControlSpellNameText:CreateFrame()
	if not profile.enable then
		if crowdControlSpellNameTextRegion then
			crowdControlSpellNameTextRegion:Hide()
		end
		return
	end

	if not crowdControlSpellNameTextRegion then
		local crowdControlExtraFrame = AloftCrowdControl.crowdControlExtraFrame
		crowdControlSpellNameTextRegion = crowdControlExtraFrame:CreateFontString(nil, "OVERLAY")

		crowdControlSpellNameTextRegion:ClearAllPoints()
		crowdControlSpellNameTextRegion:SetPoint("TOPLEFT", crowdControlExtraFrame, "TOPLEFT", profile.offsets.left, profile.offsets.vertical)
		crowdControlSpellNameTextRegion:SetPoint("BOTTOMRIGHT", crowdControlExtraFrame, "BOTTOMRIGHT", profile.offsets.right, profile.offsets.vertical)
		crowdControlSpellNameTextRegion:Hide()
	end

	self:PrepareText(crowdControlSpellNameTextRegion, profile)
end

-----------------------------------------------------------------------------

function AloftCrowdControlSpellNameText:RegisterEvents()
	if profile.enable then
		self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
		self:RegisterEvent("Aloft:OnNameplateShow", "OnCrowdControlBarShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnCrowdControlBarHide")
		self:RegisterEvent("Aloft:OnCrowdControlBarShow", "OnCrowdControlBarShow")
		self:RegisterEvent("Aloft:OnCrowdControlBarHide", "OnCrowdControlBarHide")
		self:RegisterEvent("Aloft:OnCrowdControlBarValueChanged", "UpdateText")
	else
		self:CancelEvent("Aloft:SetupFrame")
		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnNameplateHide")
		self:CancelEvent("Aloft:OnCrowdControlBarShow")
		self:CancelEvent("Aloft:OnCrowdControlBarHide")
		self:CancelEvent("Aloft:OnCrowdControlBarValueChanged")
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControlSpellNameText:GetTargetCrowdControlSpellName()
	local crowdControlSpellName = ""
	if (AloftCrowdControl.crowdControlSpellName) then
		crowdControlSpellName = AloftCrowdControl.crowdControlSpellName
		if (AloftCrowdControl.crowdControlSpellRank) then
			crowdControlSpellName = crowdControlSpellName .. "(" .. AloftCrowdControl.crowdControlSpellRank .. ")"
		end
	end
	return crowdControlSpellName
end

-----------------------------------------------------------------------------

function AloftCrowdControlSpellNameText:OnInitialize()
	profile = self.db.profile
end

function AloftCrowdControlSpellNameText:OnEnable()
	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:Update()
		end
	end)

	self:Update()
end

function AloftCrowdControlSpellNameText:OnDisable()
	self:UnregisterAllEvents()

	if crowdControlSpellNameTextRegion then
		crowdControlSpellNameTextRegion:Hide()
	end
end

function AloftCrowdControlSpellNameText:SetupFrame()
end

function AloftCrowdControlSpellNameText:UpdateText()
	crowdControlSpellNameTextRegion:SetText(self:GetTargetCrowdControlSpellName())
end

function AloftCrowdControlSpellNameText:OnCrowdControlBarShow()
	crowdControlSpellNameTextRegion:SetText(self:GetTargetCrowdControlSpellName())
	crowdControlSpellNameTextRegion:SetAlpha(1.0)
	crowdControlSpellNameTextRegion:Show()

	self:ScheduleRepeatingEvent("AloftCrowdControlSpellNameText:UpdateAlpha", self.UpdateAlpha, 0.1, self, AloftCrowdControl.crowdControlStatusBar)
end

function AloftCrowdControlSpellNameText:OnCrowdControlBarHide()
	self:CancelScheduledEvent("AloftCrowdControlSpellNameText:UpdateAlpha")
	crowdControlSpellNameTextRegion:SetText("")
	crowdControlSpellNameTextRegion:Hide()
end

function AloftCrowdControlSpellNameText:UpdateAlpha(crowdControlStatusBar)
	local _, _, _, a = crowdControlStatusBar:GetStatusBarColor()
	crowdControlSpellNameTextRegion:SetAlpha(a)
end

-----------------------------------------------------------------------------

end)
