local Aloft = Aloft
if not Aloft then return end
-- local AloftModules = AloftModules
-- if not AloftModules then return end

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CastWarning") or not Aloft:HasModule("TargetTrackingData") then return end

local AloftCastWarningTimeText = Aloft:NewModule("CastWarningTimeText", "AceEvent-2.0")
-- AloftCastWarningTimeText.dynamic = true

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData")
local AloftCastWarning = Aloft:GetModule("CastWarning")

-----------------------------------------------------------------------------

AloftCastWarningTimeText.db = Aloft:AcquireDBNamespace("castWarningTimeText")
Aloft:RegisterDefaults("castWarningTimeText", "profile", {
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

	castColor		= { 1.0, 1.0, 1.0, 1.0 }, -- white
	fadeColor		= { 0.0, 0.0, 0.0, 1.0 }, -- black
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftCastWarningTimeText:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if profile.enable then
			self:UpdateText(aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarningTimeText:RegisterEvents()
	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:RegisterEvents(): invoke")

	self:UnregisterAllEvents()

	if profile and profile.enable then
		self:RegisterEvent("Aloft:OnNameplateShow", "UpdateText")
		self:RegisterEvent("Aloft:OnSetHealthBarColor", "UpdateText") -- TODO: is this needed?
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		-- self:RegisterEvent("AloftCastWarning:OnCastWarningDataChanged", "OnCastWarningDataChanged")
		self:RegisterEvent("AloftCastWarning:OnCastWarningTimeChanged", "OnCastWarningTimeChanged")

		-- ChatFrame7:AddMessage("AloftCastWarningTimeText:RegisterEvents(): registered")

		self:RegisterEvent("Aloft:SetAll", function(type, value)
			if profile[type] then
				profile[type] = value
				self:UpdateAll()
			end
		end)
	end
end

local dataRequiredList = { }
function AloftCastWarningTimeText:RequiresData()
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftCastWarningTimeText:GetCastWarningTime(castWarningBar)
	local castWarningTimeText
	local castWarningTimeValue
	if castWarningBar then
		local minValue, maxValue = castWarningBar:GetMinMaxValues()
		local value = castWarningBar:GetValue()

		if value > maxValue or value <= minValue then
			castWarningTimeValue = 0
			castWarningTimeText = ""
		else
			castWarningTimeValue = value
			castWarningTimeText = ("%.2f"):format((value > castWarningTimeValue) and (maxValue-value) or (value-minValue))
		end
	end
	return castWarningTimeValue, castWarningTimeText
end

-----------------------------------------------------------------------------

function AloftCastWarningTimeText:OnInitialize()
	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:OnInitialize(): invoke")
	Aloft:DebugRegister("CastWarningTimeText")
	profile = self.db.profile
end

function AloftCastWarningTimeText:OnEnable()
	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:OnEnable(): invoke")
	self:UpdateAll()
end

function AloftCastWarningTimeText:OnDisable()
	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:OnDisable(): invoke")
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateHide(aloftData)
	end
	-- TODO: nil out Aloft.Options?
end

-----------------------------------------------------------------------------

function AloftCastWarningTimeText:UpdateText(aloftData)
	local nameplateId = AloftTargetTrackingData:GetNameplateId(aloftData)
	if nameplateId then
		local nameplateGUId = AloftTargetTrackingData:GetNameplateGUId(nameplateId)
		if nameplateGUId then
			local active = nameplateGUId and AloftCastWarning:GetActiveCastByGUId(nameplateGUId)

			self:CreateFrame(aloftData, nameplateGUId, active)
		end
	end
end

--[[
function AloftCastWarningTimeText:OnCastWarningDataChanged(aloftData, nameplateGUId, active)
	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:OnCastWarningDataChanged(): " .. tostring(aloftData) .."/" .. tostring(nameplateGUId) .. "/" .. tostring(active))
	self:CreateFrame(aloftData, nameplateGUId, active)
end
]]

function AloftCastWarningTimeText:OnCastWarningTimeChanged(aloftData, nameplateGUId, active)
	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:OnCastWarningTimeChanged(): " .. tostring(aloftData) .."/" .. tostring(nameplateGUId) .. "/" .. tostring(active))
	self:CreateFrame(aloftData, nameplateGUId, active)
end

function AloftCastWarningTimeText:OnNameplateHide(aloftData)
	local castWarningBar = aloftData.castWarningBar
	if castWarningBar then
		local castWarningTimeTextRegion = castWarningBar.castWarningTimeTextRegion
		if castWarningTimeTextRegion then
			castWarningTimeTextRegion:SetText("")
			castWarningTimeTextRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarningTimeText:PlaceFrame(textRegion, frame, profile)
	textRegion:SetParent(frame)

	textRegion:ClearAllPoints()
	textRegion:SetPoint("TOPLEFT", frame, "TOPLEFT", profile.offsets.left, profile.offsets.vertical)
	textRegion:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", profile.offsets.right, profile.offsets.vertical)
	textRegion:SetDrawLayer("OVERLAY")
end

function AloftCastWarningTimeText:CreateFrame(aloftData, nameplateGUId, active)
	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:CreateFrame(): " .. tostring(aloftData.name) .. "/" .. tostring(nameplateGUId) .. "/" .. tostring(active and active.id) .. "/" .. tostring(active and active.name))
	local castWarningBar = aloftData.castWarningBar
	if nameplateGUId and active and castWarningBar and castWarningBar:IsVisible() then
		-- Check if this nameplate already has a text region assigned to it
		local castWarningTimeTextRegion = castWarningBar.castWarningTimeTextRegion
		if not castWarningTimeTextRegion then
			castWarningTimeTextRegion = castWarningBar.castWarningExtraFrame:CreateFontString(nil, "OVERLAY")
			castWarningBar.castWarningTimeTextRegion = castWarningTimeTextRegion
		end

		self:PrepareText(castWarningTimeTextRegion, profile)
		self:PlaceFrame(castWarningTimeTextRegion, castWarningBar.castWarningExtraFrame, profile)

		local value, text = self:GetCastWarningTime(castWarningBar)
		-- ChatFrame7:AddMessage("AloftCastWarningTimeText:CreateFrame(): value ".. tostring(value) .. " text " .. tostring(text))

		local color = profile.castColor
		if active.fadeTime then color = profile.fadeColor end
		castWarningTimeTextRegion:SetTextColor(unpack(color))
		castWarningTimeTextRegion:SetText(text)

		-- ChatFrame7:AddMessage("AloftCastWarningTimeText:CreateFrame(): " .. tostring(floor(color[4]*255)) .. "." .. tostring(floor(color[1]*255)) .. "." .. tostring(floor(color[2]*255)) .. "." .. tostring(floor(color[3]*255)))
		-- ChatFrame7:AddMessage("AloftCastWarningTimeText:CreateFrame(): " .. ("|c%02x%02x%02x%02x%s|r"):format(floor(color[4]*255), floor(color[1]*255), floor(color[2]*255), floor(color[3]*255), tostring(text)))
		castWarningTimeTextRegion:Show()
	else
		self:OnNameplateHide(aloftData)
	end
end

-----------------------------------------------------------------------------

-- end)
