local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

local AloftCrowdControl = Aloft:GetModule("CrowdControl", true)
if not AloftCrowdControl then return end

local AloftCrowdControlTimeText = Aloft:NewModule("CrowdControlTimeText", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftCrowdControlTimeText.dynamic = "AloftCrowdControl"

-----------------------------------------------------------------------------

AloftCrowdControlTimeText.namespace = "crowdControlTimeText"
AloftCrowdControlTimeText.defaults =
{
	profile =
	{
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
		color			= { 1, 1, 1, 1 },
	},
}

-----------------------------------------------------------------------------

local lastCrowdControlTimeValue = 0
local crowdControlTimeTextRegion = nil

-----------------------------------------------------------------------------

function AloftCrowdControlTimeText:Update()
	self:CreateFrame()
	self:RegisterEvents()

	if self.db.profile.enable then
		self:SetupFrame("AloftCrowdControlTimeText:Update")
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControlTimeText:CreateFrame()
	local crowdControlExtraFrame = AloftCrowdControl.crowdControlExtraFrame
	if not self.db.profile.enable or not crowdControlExtraFrame then
		if crowdControlTimeTextRegion then
			crowdControlTimeTextRegion:Hide()
		end
		return
	end

	if not crowdControlTimeTextRegion then
		-- ChatFrame7:AddMessage("AloftCrowdControlTimeText:CreateFrame(): " .. tostring(AloftCrowdControl) .. "/" .. tostring(crowdControlExtraFrame))
		crowdControlTimeTextRegion = crowdControlExtraFrame:CreateFontString(nil, "OVERLAY")
	end

	crowdControlTimeTextRegion:ClearAllPoints()
	crowdControlTimeTextRegion:SetPoint("TOPLEFT", crowdControlExtraFrame, "TOPLEFT", self.db.profile.offsets.left, self.db.profile.offsets.vertical)
	crowdControlTimeTextRegion:SetPoint("BOTTOMRIGHT", crowdControlExtraFrame, "BOTTOMRIGHT", self.db.profile.offsets.right, self.db.profile.offsets.vertical)
	-- crowdControlTimeTextRegion:Hide()

	self:PrepareText(crowdControlTimeTextRegion, self.db.profile)
end

-----------------------------------------------------------------------------

function AloftCrowdControlTimeText:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile.enable then
		self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
		-- self:RegisterMessage("Aloft:OnNameplateShow", "OnCrowdControlBarShow")
		-- self:RegisterMessage("Aloft:OnNameplateHide", "OnCrowdControlBarHide")
		self:RegisterMessage("Aloft:OnCrowdControlBarShow", "OnCrowdControlBarShow")
		self:RegisterMessage("Aloft:OnCrowdControlBarHide", "OnCrowdControlBarHide")
		self:RegisterMessage("Aloft:OnCrowdControlBarValueChanged", "UpdateText")
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControlTimeText:GetTargetCrowdControlTime()
	local lastCrowdControlTimeText

	-- ChatFrame7:AddMessage("AloftCrowdControlTimeText:GetTargetCrowdControlTime(): " .. tostring(AloftCrowdControl.value))
	if AloftCrowdControl.value then
		lastCrowdControlTimeValue = AloftCrowdControl.value
		lastCrowdControlTimeText = ("%.2f"):format(lastCrowdControlTimeValue)
		-- ChatFrame7:AddMessage("AloftCrowdControlTimeText:GetTargetCrowdControlTime(): " .. tostring(AloftCrowdControl.value) .. "/" .. tostring(lastCrowdControlTimeText))
	else
		lastCrowdControlTimeValue = 0
		lastCrowdControlTimeText = ""
	end
	return lastCrowdControlTimeText
end

-----------------------------------------------------------------------------

function AloftCrowdControlTimeText:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftCrowdControlTimeText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftCrowdControlTimeText:OnEnable(): enter")
	self:RegisterMessage("Aloft:SetAll", function(message, type, value)
		if AloftCrowdControlTimeText.db.profile[type] then
			AloftCrowdControlTimeText.db.profile[type] = value
			AloftCrowdControlTimeText:Update()
		end
	end)

	self:Update()
end

function AloftCrowdControlTimeText:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if crowdControlTimeTextRegion then
		crowdControlTimeTextRegion:Hide()
	end
end

function AloftCrowdControlTimeText:SetupFrame(message)
	lastCrowdControlTimeValue = 0
end

function AloftCrowdControlTimeText:UpdateText(message)
	-- ChatFrame7:AddMessage("AloftCrowdControlTimeText:UpdateText(): " .. tostring(AloftCrowdControl.value))
	crowdControlTimeTextRegion:SetText(self:GetTargetCrowdControlTime())
end

function AloftCrowdControlTimeText:OnCrowdControlBarShow(message)
	crowdControlTimeTextRegion:SetText(self:GetTargetCrowdControlTime())
	crowdControlTimeTextRegion:SetAlpha(1.0)
	crowdControlTimeTextRegion:Show()

	self:CancelAllTimers()
	self:ScheduleRepeatingTimer(function(crowdControlFrame) AloftCrowdControlTimeText:UpdateAlpha(crowdControlFrame) end, 0.1, AloftCrowdControl.crowdControlFrame)
end

function AloftCrowdControlTimeText:OnCrowdControlBarHide(message)
	self:CancelAllTimers()
	crowdControlTimeTextRegion:SetText("")
	crowdControlTimeTextRegion:Hide()
end

function AloftCrowdControlTimeText:UpdateAlpha(crowdControlFrame)
	local crowdControlRegion = AloftCrowdControl.crowdControlFrame and AloftCrowdControl.crowdControlFrame.crowdControlRegion
	if crowdControlRegion then
		local _, _, _, a = AloftCrowdControl.crowdControlFrame.crowdControlRegion:GetVertexColor()
		crowdControlTimeTextRegion:SetAlpha(a)
	end
end

-----------------------------------------------------------------------------

end)
