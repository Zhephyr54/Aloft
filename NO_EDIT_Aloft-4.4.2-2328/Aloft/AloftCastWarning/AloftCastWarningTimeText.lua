local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningTimeText", function()

-----------------------------------------------------------------------------

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData", true)
if not Aloft:GetModule("CastWarning", true) or not Aloft:GetModule("TargetTrackingData", true) then return end

local AloftCastWarning = Aloft:GetModule("CastWarning", true)
if not Aloft:GetModule("CastWarning", true) or not Aloft:GetModule("TargetTrackingData", true) then return end

local AloftCastWarningTimeText = Aloft:NewModule("CastWarningTimeText", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftCastWarningTimeText.dynamic = "AloftCastWarningTimeText"

-----------------------------------------------------------------------------

AloftCastWarningTimeText.namespace = "castWarningTimeText"
AloftCastWarningTimeText.defaults =
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

		castColor		= { 1.0, 1.0, 1.0, 1.0 }, -- white
		fadeColor		= { 0.0, 0.0, 0.0, 1.0 }, -- black
	},
}

-----------------------------------------------------------------------------

function AloftCastWarningTimeText:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if self.db.profile.enable then
			self:UpdateText("AloftCastWarningTimeText:UpdateAll", aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarningTimeText:RegisterEvents()
	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:RegisterEvents(): invoke")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile and self.db.profile.enable then
		self:RegisterMessage("Aloft:OnNameplateShow", "UpdateText")
		self:RegisterMessage("Aloft:OnSetHealthBarColor", "UpdateText") -- TODO: is this needed?
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		-- self:RegisterMessage("AloftCastWarning:OnCastWarningDataChanged", "OnCastWarningDataChanged")
		self:RegisterMessage("AloftCastWarning:OnCastWarningTimeChanged", "OnCastWarningTimeChanged")

		-- ChatFrame7:AddMessage("AloftCastWarningTimeText:RegisterEvents(): registered")

		self:RegisterMessage("Aloft:SetAll", function(message, type, value)
			if AloftCastWarningTimeText.db.profile[type] then
				AloftCastWarningTimeText.db.profile[type] = value
				AloftCastWarningTimeText:UpdateAll()
			end
		end)
	end
end

local dataRequiredList = { }
function AloftCastWarningTimeText:RequiresData()
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftCastWarningTimeText:GetCastWarningTime(castWarningFrame)
	local value = castWarningFrame.value or 0
	local castWarningTimeText = ("%.2f"):format(value)
	return value, castWarningTimeText
end

-----------------------------------------------------------------------------

function AloftCastWarningTimeText:OnInitialize()
	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:OnInitialize(): invoke")
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftCastWarningTimeText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:OnEnable(): invoke")

	self:UpdateAll()
end

function AloftCastWarningTimeText:OnDisable()
	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:OnDisable(): invoke")
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateHide("AloftCastWarningTimeText:OnDisable", aloftData)
	end
	-- TODO: nil out Aloft.Options?
end

-----------------------------------------------------------------------------

function AloftCastWarningTimeText:UpdateText(message, aloftData)
	-- TODO: this can be guarded here, for basic enable purposes; it would be more efficient
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
function AloftCastWarningTimeText:OnCastWarningDataChanged(message, aloftData, nameplateGUId, active)
	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:OnCastWarningDataChanged(): " .. tostring(aloftData) .."/" .. tostring(nameplateGUId) .. "/" .. tostring(active))
	self:CreateFrame(aloftData, nameplateGUId, active)
end
]]

function AloftCastWarningTimeText:OnCastWarningTimeChanged(message, aloftData, nameplateGUId, active)
	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:OnCastWarningTimeChanged(): " .. tostring(aloftData) .."/" .. tostring(nameplateGUId) .. "/" .. tostring(active))
	self:CreateFrame(aloftData, nameplateGUId, active)
end

function AloftCastWarningTimeText:OnNameplateHide(message, aloftData)
	local castWarningFrame = aloftData.castWarningFrame
	if castWarningFrame then
		local castWarningTimeTextRegion = castWarningFrame.castWarningTimeTextRegion
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
	if AloftCastWarning.db.profile.enable and self.db.profile.enable then
		-- ChatFrame7:AddMessage("AloftCastWarningTimeText:CreateFrame(): " .. tostring(aloftData.name) .. "/" .. tostring(nameplateGUId) .. "/" .. tostring(active and active.id) .. "/" .. tostring(active and active.name))
		local castWarningFrame = aloftData.castWarningFrame
		if nameplateGUId and active and castWarningFrame and castWarningFrame:IsVisible() then
			-- Check if this nameplate already has a text region assigned to it
			local castWarningTimeTextRegion = castWarningFrame.castWarningTimeTextRegion
			if not castWarningTimeTextRegion then
				castWarningTimeTextRegion = castWarningFrame.castWarningExtraFrame:CreateFontString(nil, "OVERLAY")
				castWarningFrame.castWarningTimeTextRegion = castWarningTimeTextRegion
			end

			self:PrepareText(castWarningTimeTextRegion, self.db.profile)
			self:PlaceFrame(castWarningTimeTextRegion, castWarningFrame.castWarningExtraFrame, self.db.profile)

			local value, text = self:GetCastWarningTime(castWarningFrame)
			-- ChatFrame7:AddMessage("AloftCastWarningTimeText:CreateFrame(): value ".. tostring(value) .. " text " .. tostring(text))

			local color = self.db.profile.castColor
			if active.fadeTime then color = self.db.profile.fadeColor end
			castWarningTimeTextRegion:SetTextColor(unpack(color))
			castWarningTimeTextRegion:SetText(text)

			-- ChatFrame7:AddMessage("AloftCastWarningTimeText:CreateFrame(): " .. tostring(floor(color[4]*255)) .. "." .. tostring(floor(color[1]*255)) .. "." .. tostring(floor(color[2]*255)) .. "." .. tostring(floor(color[3]*255)))
			-- ChatFrame7:AddMessage("AloftCastWarningTimeText:CreateFrame(): " .. ("|c%02x%02x%02x%02x%s|r"):format(floor(color[4]*255), floor(color[1]*255), floor(color[2]*255), floor(color[3]*255), tostring(text)))
			castWarningTimeTextRegion:Show()

			return
		end
	end

	-- ChatFrame7:AddMessage("AloftCastWarningTimeText:CreateFrame() hide")
	self:OnNameplateHide("AloftCastWarningTimeText:CreateFrame", aloftData)
end

-----------------------------------------------------------------------------

end)
