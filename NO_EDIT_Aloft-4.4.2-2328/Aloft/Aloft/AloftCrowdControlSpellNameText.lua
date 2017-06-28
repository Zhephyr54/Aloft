local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

local AloftCrowdControl = Aloft:GetModule("CrowdControl", true)
if not AloftCrowdControl then return end

local AloftCrowdControlSpellNameText = Aloft:NewModule("CrowdControlSpellNameText", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftCrowdControlSpellNameText.dynamic = "AloftCrowdControl"

-----------------------------------------------------------------------------

AloftCrowdControlSpellNameText.namespace = "crowdControlSpellNameText"
AloftCrowdControlSpellNameText.defaults =
{
	profile =
	{
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
		color			= { 1, 1, 1, 1 },
	},
}

-----------------------------------------------------------------------------

local crowdControlSpellNameTextRegion = nil

-----------------------------------------------------------------------------

function AloftCrowdControlSpellNameText:Update()
	self:CreateFrame()
	self:RegisterEvents()

	if self.db.profile.enable then
		self:SetupFrame("AloftCrowdControlSpellNameText:Update")
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControlSpellNameText:CreateFrame()
	local crowdControlExtraFrame = AloftCrowdControl.crowdControlExtraFrame
	if not self.db.profile.enable or not crowdControlExtraFrame then
		if crowdControlSpellNameTextRegion then
			-- ChatFrame7:AddMessage("AloftCrowdControlSpellNameText:CreateFrame(): disable")
			crowdControlSpellNameTextRegion:Hide()
		end
		return
	end

	if not crowdControlSpellNameTextRegion then
		-- ChatFrame7:AddMessage("AloftCrowdControlSpellNameText:CreateFrame(): " .. tostring(AloftCrowdControl) .. "/" .. tostring(crowdControlExtraFrame))
		crowdControlSpellNameTextRegion = crowdControlExtraFrame:CreateFontString(nil, "OVERLAY")
	end

	crowdControlSpellNameTextRegion:ClearAllPoints()
	crowdControlSpellNameTextRegion:SetPoint("TOPLEFT", crowdControlExtraFrame, "TOPLEFT", self.db.profile.offsets.left, self.db.profile.offsets.vertical)
	crowdControlSpellNameTextRegion:SetPoint("BOTTOMRIGHT", crowdControlExtraFrame, "BOTTOMRIGHT", self.db.profile.offsets.right, self.db.profile.offsets.vertical)

	-- ChatFrame7:AddMessage("AloftCrowdControlSpellNameText:CreateFrame(): hide")
	-- crowdControlSpellNameTextRegion:Hide()

	self:PrepareText(crowdControlSpellNameTextRegion, self.db.profile)
end

-----------------------------------------------------------------------------

function AloftCrowdControlSpellNameText:RegisterEvents()
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

function AloftCrowdControlSpellNameText:GetTargetCrowdControlSpellName()
	local crowdControlSpellName = ""
	if (AloftCrowdControl.crowdControlSpellName) then
		crowdControlSpellName = AloftCrowdControl.crowdControlSpellName
		if (AloftCrowdControl.crowdControlSpellRank) then
			crowdControlSpellName = crowdControlSpellName .. " (" .. AloftCrowdControl.crowdControlSpellRank .. ")"
		end
	end
	return crowdControlSpellName
end

-----------------------------------------------------------------------------

function AloftCrowdControlSpellNameText:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftCrowdControlSpellNameText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftCrowdControlSpellNameText:OnEnable(): enter")
	self:RegisterMessage("Aloft:SetAll", function(message, type, value)
		if AloftCrowdControlSpellNameText.db.profile[type] then
			AloftCrowdControlSpellNameText.db.profile[type] = value
			AloftCrowdControlSpellNameText:Update()
		end
	end)

	self:Update()
end

function AloftCrowdControlSpellNameText:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if crowdControlSpellNameTextRegion then
		-- ChatFrame7:AddMessage("AloftCrowdControlSpellNameText:OnDisable(): hide")
		crowdControlSpellNameTextRegion:Hide()
	end
end

function AloftCrowdControlSpellNameText:SetupFrame(message)
end

function AloftCrowdControlSpellNameText:UpdateText(message)
	crowdControlSpellNameTextRegion:SetText(self:GetTargetCrowdControlSpellName())
end

function AloftCrowdControlSpellNameText:OnCrowdControlBarShow(message)
	crowdControlSpellNameTextRegion:SetText(self:GetTargetCrowdControlSpellName())
	crowdControlSpellNameTextRegion:SetAlpha(1.0)

	-- ChatFrame7:AddMessage("AloftCrowdControlSpellNameText:OnCrowdControlBarShow(): show")
	crowdControlSpellNameTextRegion:Show()

	self:CancelAllTimers()
	self:ScheduleRepeatingTimer(function(crowdControlFrame) AloftCrowdControlSpellNameText:UpdateAlpha(crowdControlFrame) end, 0.1, AloftCrowdControl.crowdControlFrame)
end

function AloftCrowdControlSpellNameText:OnCrowdControlBarHide(message)
	self:CancelAllTimers()
	crowdControlSpellNameTextRegion:SetText("")

	-- ChatFrame7:AddMessage("AloftCrowdControlSpellNameText:OnCrowdControlBarHide(): hide")
	crowdControlSpellNameTextRegion:Hide()
end

function AloftCrowdControlSpellNameText:UpdateAlpha(crowdControlFrame)
	local crowdControlRegion = AloftCrowdControl.crowdControlFrame and AloftCrowdControl.crowdControlFrame.crowdControlRegion
	if crowdControlRegion then
		local _, _, _, a = AloftCrowdControl.crowdControlFrame.crowdControlRegion:GetVertexColor()
		crowdControlSpellNameTextRegion:SetAlpha(a)
	end
end

-----------------------------------------------------------------------------

end)
