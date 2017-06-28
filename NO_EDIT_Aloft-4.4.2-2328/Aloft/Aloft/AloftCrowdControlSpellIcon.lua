local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

local AloftCrowdControl = Aloft:GetModule("CrowdControl", true)
if not AloftCrowdControl then return end

local AloftCrowdControlSpellIcon = Aloft:NewModule("CrowdControlSpellIcon", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftCrowdControlSpellIcon.dynamic = "AloftCrowdControl"

-----------------------------------------------------------------------------

AloftCrowdControlSpellIcon.namespace = "crowdControlSpellIcon"
AloftCrowdControlSpellIcon.defaults =
{
	profile =
	{
		enable			= false,
		point			= "RIGHT",
		relativeToPoint	= "LEFT",
		offsetX			= 0,
		offsetY			= 0,
		size			= 12,
	},
}

-----------------------------------------------------------------------------

local crowdControlSpellIconRegion = nil

-----------------------------------------------------------------------------

function AloftCrowdControlSpellIcon:UpdateAll()
	self:CreateFrame()
	self:RegisterEvents()

	if self.db.profile.enable then
		self:SetupFrame("AloftCrowdControlSpellIcon:UpdateAll")
	end
end

-----------------------------------------------------------------------------

-- TODO: propagate this to name text, level text, boss icon, and/or other "default" nameplate components as needed
function AloftCrowdControlSpellIcon:GetInset(aloftData)
	return ((AloftCrowdControl.db.profile.border ~= "None") and 4) or 0
end

function AloftCrowdControlSpellIcon:CreateFrame()
	local crowdControlExtraFrame = AloftCrowdControl.crowdControlExtraFrame
	if not self.db.profile.enable or not crowdControlExtraFrame then
		if crowdControlSpellIconRegion then
			crowdControlSpellIconRegion:Hide()	
		end
		return
	end

	if not crowdControlSpellIconRegion then
		crowdControlSpellIconRegion = crowdControlExtraFrame:CreateTexture(nil, "OVERLAY")
		crowdControlSpellIconRegion:SetBlendMode("BLEND")
	end

	-- crowdControlSpellIconRegion:Hide()

	local inset = self:GetInset(aloftData)
	local hinset, vinset = Aloft:AdjustFrame(inset, self.db.profile.relativeToPoint)

	self:PlaceFrame(crowdControlSpellIconRegion, crowdControlExtraFrame, self.db.profile, hinset, vinset)
end

-----------------------------------------------------------------------------

function AloftCrowdControlSpellIcon:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile.enable then
		self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
		-- self:RegisterMessage("Aloft:OnNameplateShow", "OnCrowdControlBarShow")
		-- self:RegisterMessage("Aloft:OnNameplateHide", "OnCrowdControlBarHide")
		self:RegisterMessage("Aloft:OnCrowdControlBarShow", "OnCrowdControlBarShow")
		self:RegisterMessage("Aloft:OnCrowdControlBarHide", "OnCrowdControlBarHide")
	end
end

-----------------------------------------------------------------------------

function AloftCrowdControlSpellIcon:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftCrowdControlSpellIcon:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftCrowdControlSpellIcon:OnEnable(): enter")
	self:UpdateAll()
end

function AloftCrowdControlSpellIcon:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if crowdControlSpellIconRegion then
		crowdControlSpellIconRegion:Hide()
	end
end

function AloftCrowdControlSpellIcon:SetupFrame(message)
end

function AloftCrowdControlSpellIcon:OnCrowdControlBarShow(message, aloftData)
	local inset = self:GetInset(aloftData)
	local hinset, vinset = Aloft:AdjustFrame(inset, self.db.profile.relativeToPoint)

	self:PlaceFrame(crowdControlSpellIconRegion, AloftCrowdControl.crowdControlExtraFrame, self.db.profile, hinset, vinset)

	crowdControlSpellIconRegion:SetTexture(AloftCrowdControl.crowdControlSpellIcon)
	crowdControlSpellIconRegion:Show()

	self:CancelAllTimers()
	self:ScheduleRepeatingTimer(function(crowdControlFrame) AloftCrowdControlSpellIcon:UpdateAlpha(crowdControlFrame) end, 0.1, AloftCrowdControl.crowdControlFrame)
end

function AloftCrowdControlSpellIcon:OnCrowdControlBarHide(message, aloftData)
	self:CancelAllTimers()
	crowdControlSpellIconRegion:SetTexture("")
	crowdControlSpellIconRegion:Hide()
end

function AloftCrowdControlSpellIcon:UpdateAlpha(crowdControlFrame)
	local crowdControlRegion = AloftCrowdControl.crowdControlFrame and AloftCrowdControl.crowdControlFrame.crowdControlRegion
	if crowdControlRegion then
		local _, _, _, a = AloftCrowdControl.crowdControlFrame.crowdControlRegion:GetVertexColor()
		crowdControlSpellIconRegion:SetAlpha(a)
	end
end

-----------------------------------------------------------------------------

end)
