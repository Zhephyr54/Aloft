local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CrowdControl") then return end

local AloftCrowdControlTimeText = Aloft:NewModule("CrowdControlTimeText", "AceEvent-2.0")
AloftCrowdControlTimeText.dynamic = "AloftCrowdControl"

local AloftCrowdControl = Aloft:GetModule("CrowdControl")

-----------------------------------------------------------------------------

AloftCrowdControlTimeText.db = Aloft:AcquireDBNamespace("crowdControlTimeText")
Aloft:RegisterDefaults("crowdControlTimeText", "profile", {
	enable			= false,
	font			= "Arial Narrow",
	fontSize		= 9,
	shadow			= true,
	alignment		= "RIGHT",
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

local lastCrowdControlTimeValue = 0
local crowdControlTimeTextRegion = nil
local profile

-----------------------------------------------------------------------------

function AloftCrowdControlTimeText:Update()
	self:CreateFrame()
	self:RegisterEvents()

	if profile.enable then
		self:SetupFrame()
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControlTimeText:CreateFrame()
	if not profile.enable then
		if crowdControlTimeTextRegion then
			crowdControlTimeTextRegion:Hide()
		end
		return
	end

	if not crowdControlTimeTextRegion then
		local crowdControlExtraFrame = AloftCrowdControl.crowdControlExtraFrame
		crowdControlTimeTextRegion = crowdControlExtraFrame:CreateFontString(nil, "OVERLAY")

		crowdControlTimeTextRegion:ClearAllPoints()
		crowdControlTimeTextRegion:SetPoint("TOPLEFT", crowdControlExtraFrame, "TOPLEFT", profile.offsets.left, profile.offsets.vertical)
		crowdControlTimeTextRegion:SetPoint("BOTTOMRIGHT", crowdControlExtraFrame, "BOTTOMRIGHT", profile.offsets.right, profile.offsets.vertical)
		crowdControlTimeTextRegion:Hide()
	end

	self:PrepareText(crowdControlTimeTextRegion, profile)
end

-----------------------------------------------------------------------------

function AloftCrowdControlTimeText:RegisterEvents()
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

function AloftCrowdControlTimeText:GetTargetCrowdControlTime()
	local lastCrowdControlTimeText
	local minValue, maxValue = AloftCrowdControl.crowdControlStatusBar:GetMinMaxValues()
	local value = AloftCrowdControl.crowdControlStatusBar:GetValue()

	if value >= maxValue or value <= minValue then
		lastCrowdControlTimeValue = 0
		lastCrowdControlTimeText = ""
	else
		lastCrowdControlTimeValue = value
		lastCrowdControlTimeText = ("%.2f"):format((value > lastCrowdControlTimeValue) and (maxValue-value) or (value-minValue))
	end
	return lastCrowdControlTimeText
end

-----------------------------------------------------------------------------

function AloftCrowdControlTimeText:OnInitialize()
	profile = self.db.profile
end

function AloftCrowdControlTimeText:OnEnable()
	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:Update()
		end
	end)

	self:Update()
end

function AloftCrowdControlTimeText:OnDisable()
	self:UnregisterAllEvents()

	if crowdControlTimeTextRegion then
		crowdControlTimeTextRegion:Hide()
	end
end

function AloftCrowdControlTimeText:SetupFrame()
	lastCrowdControlTimeValue = 0
end

function AloftCrowdControlTimeText:UpdateText()
	crowdControlTimeTextRegion:SetText(self:GetTargetCrowdControlTime())
end

function AloftCrowdControlTimeText:OnCrowdControlBarShow()
	crowdControlTimeTextRegion:SetText(self:GetTargetCrowdControlTime())
	crowdControlTimeTextRegion:SetAlpha(1.0)
	crowdControlTimeTextRegion:Show()

	self:ScheduleRepeatingEvent("AloftCrowdControlTimeText:UpdateAlpha", self.UpdateAlpha, 0.1, self, AloftCrowdControl.crowdControlStatusBar)
end

function AloftCrowdControlTimeText:OnCrowdControlBarHide()
	self:CancelScheduledEvent("AloftCrowdControlTimeText:UpdateAlpha")
	crowdControlTimeTextRegion:SetText("")
	crowdControlTimeTextRegion:Hide()
end

function AloftCrowdControlTimeText:UpdateAlpha(crowdControlStatusBar)
	local _, _, _, a = crowdControlStatusBar:GetStatusBarColor()
	crowdControlTimeTextRegion:SetAlpha(a)
end

-----------------------------------------------------------------------------

end)
