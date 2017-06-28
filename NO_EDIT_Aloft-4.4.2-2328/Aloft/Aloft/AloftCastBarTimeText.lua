local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

local AloftCastBar = Aloft:GetModule("CastBar") -- always on
if not AloftCastBar then return end

-----------------------------------------------------------------------------

local AloftCastBarTimeText = Aloft:NewModule("CastBarTimeText", Aloft, "AceEvent-3.0")
AloftCastBarTimeText.dynamic = "AloftCastBarTimeText"

-----------------------------------------------------------------------------

AloftCastBarTimeText.namespace = "castBarTimeText"
AloftCastBarTimeText.defaults =
{
	profile =
	{
		enable			= true,
		font			= "Arial Narrow",
		fontSize		= 9,
		shadow			= true,
		alignment		= "RIGHT",
		outline			= "",
		offsets =
		{
			left		= 0,
			right		= -5,
			vertical	= 0,
		},
		color			= { 1, 1, 1, 1 },
	},
}

-----------------------------------------------------------------------------

local lastCastTimeValue = 0
local castBarTimeTextRegion

-----------------------------------------------------------------------------

function AloftCastBarTimeText:Update()
	self:CreateFrame()
	self:RegisterEvents()

	if self.db.profile.enable then
		for aloftData in Aloft:IterateVisibleNameplates() do
			self:SetupFrame("AloftCastBarTimeText:Update", aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastBarTimeText:CreateFrame()
	if not self.db.profile.enable then
		if castBarTimeTextRegion then
			castBarTimeTextRegion:Hide()
		end
		return
	end

	if not castBarTimeTextRegion then
		castBarTimeTextRegion = UIParent:CreateFontString()
	end

	self:PrepareText(castBarTimeTextRegion, self.db.profile)
end

function AloftCastBarTimeText:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile.enable then
		self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
		self:RegisterMessage("Aloft:OnCastTimeChanged", "UpdateText")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("Aloft:OnCastFrameShow", "OnCastFrameShow")
		self:RegisterMessage("Aloft:OnCastFrameHide", "OnCastFrameHide")
	end
end

-----------------------------------------------------------------------------

function AloftCastBarTimeText:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftCastBarTimeText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("Aloft:SetAll", function(message, type, value)
		if AloftCastBarTimeText.db.profile[type] then
			AloftCastBarTimeText.db.profile[type] = value
			self:Update()
		end
	end)

	self:Update()
end

function AloftCastBarTimeText:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if castBarTimeTextRegion then
		castBarTimeTextRegion:Hide()
	end
end

function AloftCastBarTimeText:SetupFrame(message, aloftData)
	lastCastTimeValue = 0
	if aloftData:IsTarget() then
		self:OnCastFrameShow(message, aloftData)
	end
end

function AloftCastBarTimeText:UpdateText(message, aloftData)
	-- if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then ChatFrame7:AddMessage("AloftCastBarTimeText:UpdateText(): config enter " .. tostring(aloftData.name) .. "/" .. tostring(self.db.profile.enable) .. "/" .. tostring(AloftCastBar:IsDisplayEnabled())) end
	if self.db.profile.enable and AloftCastBar:IsDisplayEnabled() then
		local castBar = aloftData.castBar
		local value = nil
		local minValue = nil
		local maxValue = nil
		
		local castFrame = AloftCastBar:GetCastFrame() -- castFrame might still be nil here, guard for this

		if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then
			value = 21
			minValue = 0
			maxValue = 30
		else
			minValue, maxValue = castBar:GetMinMaxValues()
			value = (castFrame and castFrame.elapsedTime) or 0.0
		end

		if value > minValue and value < maxValue and castFrame and castFrame:IsVisible() and (not aloftData.alphaOverride or aloftData.alphaOverride > 0) then
			local text = castBarTimeTextRegion:SetText(("%.2f"):format((value > lastCastTimeValue) and (maxValue-value) or (value-minValue)))
			lastCastTimeValue = value

			local _, _, _, a = castBar:GetStatusBarColor()
			castBarTimeTextRegion:SetAlpha(a)
			castBarTimeTextRegion:Show()

			-- ChatFrame7:AddMessage("AloftCastBarTimeText:UpdateText(): " .. tostring(aloftData.name) .. "/" .. tostring(castBarTimeTextRegion:GetText()))
			-- if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then ChatFrame7:AddMessage("AloftCastBarTimeText:UpdateText(): config " .. tostring(aloftData.name)) end

			return
		end
	else
		-- ChatFrame7:AddMessage("AloftCastBarTimeText:UpdateText(): disabled")
	end

	lastCastTimeValue = 0
	castBarTimeTextRegion:SetText("")
	castBarTimeTextRegion:Hide()
end

function AloftCastBarTimeText:OnNameplateHide(message, aloftData)
	-- if aloftData.isTarget or aloftData:IsTarget() then
	--	self:OnCastFrameHide(message, aloftData)
	-- end
end

function AloftCastBarTimeText:OnCastFrameShow(message, aloftData)
	-- ChatFrame7:AddMessage("AloftCastBarTimeText:OnCastFrameShow(): enter " .. tostring(aloftData.name))

	local castFrame = AloftCastBar:GetCastFrame()
	if castFrame then
		if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then
			lastCastTimeValue = 21.0
		else
			lastCastTimeValue = castFrame.elapsedTime or 0.0
		end

		castBarTimeTextRegion:SetParent(castFrame)
		castBarTimeTextRegion:SetDrawLayer("OVERLAY")

		-- ChatFrame7:AddMessage("AloftCastBarTimeText:OnCastFrameShow(): position")
		castBarTimeTextRegion:ClearAllPoints()
		castBarTimeTextRegion:SetPoint("TOPLEFT", castFrame, "TOPLEFT", self.db.profile.offsets.left, self.db.profile.offsets.vertical)
		castBarTimeTextRegion:SetPoint("BOTTOMRIGHT", castFrame, "BOTTOMRIGHT", self.db.profile.offsets.right, self.db.profile.offsets.vertical)

		-- if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then ChatFrame7:AddMessage("AloftCastBarTimeText:OnCastFrameShow(): config " .. tostring(aloftData.name)) end
	end
end

function AloftCastBarTimeText:OnCastFrameHide(message, aloftData)
	castBarTimeTextRegion:Hide()
end

-----------------------------------------------------------------------------

end)
