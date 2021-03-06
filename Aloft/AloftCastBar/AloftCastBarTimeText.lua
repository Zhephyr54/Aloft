local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

local AloftCastBarTimeText = Aloft:NewModule("CastBarTimeText", "AceEvent-2.0")
AloftCastBarTimeText.dynamic = "AloftCastBarTimeText"

-----------------------------------------------------------------------------

AloftCastBarTimeText.db = Aloft:AcquireDBNamespace("castBarTimeText")
Aloft:RegisterDefaults("castBarTimeText", "profile", {
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
	color			= { 1, 1, 1, 1 }
})

-----------------------------------------------------------------------------

local castBarTimeTextRegion = nil
local profile

-----------------------------------------------------------------------------

function AloftCastBarTimeText:Update()
	self:CreateFrame()
	self:RegisterEvents()

	if profile.enable then
		for aloftData in Aloft:IterateVisibleNameplates() do
			self:SetupFrame(aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastBarTimeText:CreateFrame()
	if not profile.enable then
		if castBarTimeTextRegion then
			castBarTimeTextRegion:Hide()
		end
		return
	end

	if not castBarTimeTextRegion then
		castBarTimeTextRegion = UIParent:CreateFontString()
	end

	self:PrepareText(castBarTimeTextRegion, profile)
end

function AloftCastBarTimeText:RegisterEvents()
	if profile.enable then
		self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
		self:RegisterEvent("Aloft:OnCastBarValueChanged", "UpdateText")
		self:RegisterEvent("Aloft:OnCastBarShow", "OnCastBarShow")
		self:RegisterEvent("Aloft:OnCastBarHide", "OnCastBarHide")
	else
		self:CancelEvent("Aloft:SetupFrame")
		self:CancelEvent("Aloft:OnCastBarValueChanged")
		self:CancelEvent("Aloft:OnCastBarShow")
		self:CancelEvent("Aloft:OnCastBarHide")
	end
end

-----------------------------------------------------------------------------

function AloftCastBarTimeText:OnInitialize()
	profile = self.db.profile
end

function AloftCastBarTimeText:OnEnable()
	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:Update()
		end
	end)

	self:Update()
end

function AloftCastBarTimeText:OnDisable()
	self:UnregisterAllEvents()

	if castBarTimeTextRegion then
		castBarTimeTextRegion:Hide()
	end
end

function AloftCastBarTimeText:SetupFrame(aloftData)
	aloftData.lastCastTimeValue = 0
	if aloftData:IsTarget() then
		self:OnCastBarShow(aloftData)
	end
end

function AloftCastBarTimeText:UpdateText(aloftData)
	local castBar = aloftData.castBar
	local minValue, maxValue = castBar:GetMinMaxValues()
	local value = castBar:GetValue()

	if value >= maxValue or value <= minValue then
		castBarTimeTextRegion:SetText("")
		aloftData.lastCastTimeValue = 0
	else
		castBarTimeTextRegion:SetText(("%.2f"):format((value > aloftData.lastCastTimeValue) and (maxValue-value) or (value-minValue)))
		aloftData.lastCastTimeValue = value

		local _, _, _, a = castBar:GetStatusBarColor()
		castBarTimeTextRegion:SetAlpha(a)
	end
end

function AloftCastBarTimeText:OnCastBarShow(aloftData)
	local castBar = aloftData.castBar
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	if not layoutFrame then
		ChatFrame7:AddMessage("AloftCastBarTimeText:OnCastBarShow(): no layoutFrame " .. tostring(aloftData.name))
		ChatFrame7:AddMessage("AloftCastBarTimeText:OnCastBarShow(): " .. debugstack())
	end

	aloftData.lastCastTimeValue = castBar:GetValue()

	castBarTimeTextRegion:SetParent(layoutFrame)
	castBarTimeTextRegion:SetDrawLayer("OVERLAY")

	castBarTimeTextRegion:ClearAllPoints()
	castBarTimeTextRegion:SetPoint("TOPLEFT", castBar, "TOPLEFT", profile.offsets.left, profile.offsets.vertical)
	castBarTimeTextRegion:SetPoint("BOTTOMRIGHT", castBar, "BOTTOMRIGHT", profile.offsets.right, profile.offsets.vertical)
	castBarTimeTextRegion:Show()
end

function AloftCastBarTimeText:OnCastBarHide(aloftData)
	castBarTimeTextRegion:Hide()
end

-----------------------------------------------------------------------------

end)
