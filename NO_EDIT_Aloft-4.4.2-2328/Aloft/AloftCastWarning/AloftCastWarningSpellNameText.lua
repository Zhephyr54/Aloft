local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellNameText", function()

-----------------------------------------------------------------------------

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData", true)
if not AloftTargetTrackingData then return end

local AloftCastWarning = Aloft:GetModule("CastWarning", true)
if not AloftCastWarning then return end

local AloftCastWarningSpellNameText = Aloft:NewModule("CastWarningSpellNameText", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftCastWarningSpellNameText.dynamic = "AloftCastWarningSpellNameText"

-----------------------------------------------------------------------------

AloftCastWarningSpellNameText.namespace = "castWarningSpellNameText"
AloftCastWarningSpellNameText.defaults =
{
	profile =
	{
		enable			= true,
		rank			= false,
		range			= false,
		outcome			= false,
		extra			= false,

		alignment		= "LEFT",
		offsets =
		{
			left		= 16,
			right		= 0,
			vertical	= 0,
		},

		font			= "Arial Narrow",
		fontSize		= 9,
		shadow			= true,
		outline			= "",

		castColor		= { 1.0, 1.0, 1.0, 1.0 }, -- white
		fadeColor		= { 0.0, 0.0, 0.0, 1.0 }, -- black
	},
}

-----------------------------------------------------------------------------

function AloftCastWarningSpellNameText:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if self.db.profile.enable then
			self:UpdateText("AloftCastWarningSpellNameText:UpdateAll", aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellNameText:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile and self.db.profile.enable then
		self:RegisterMessage("Aloft:OnNameplateShow", "UpdateText")
		self:RegisterMessage("Aloft:OnSetHealthBarColor", "UpdateText") -- TODO: is this needed?
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("AloftCastWarning:OnCastWarningDataChanged", "OnCastWarningDataChanged")
		-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:RegisterEvents(): registered")

		self:RegisterMessage("Aloft:SetAll", function(message, type, value)
			if AloftCastWarningSpellNameText.db.profile[type] then
				AloftCastWarningSpellNameText.db.profile[type] = value
				AloftCastWarningSpellNameText:UpdateAll()
			end
		end)
	end
end

local dataRequiredList = { }
function AloftCastWarningSpellNameText:RequiresData()
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellNameText:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftCastWarningSpellNameText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UpdateAll()
end

function AloftCastWarningSpellNameText:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateHide("AloftCastWarningSpellNameText:OnDisable", aloftData)
	end
	-- TODO: nil out Aloft.Options?
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellNameText:UpdateText(message, aloftData)
	local nameplateId = AloftTargetTrackingData:GetNameplateId(aloftData)
	if nameplateId then
		local nameplateGUId = AloftTargetTrackingData:GetNameplateGUId(nameplateId)
		if nameplateGUId then
			local active = nameplateGUId and AloftCastWarning:GetActiveCastByGUId(nameplateGUId)

			self:CreateFrame(aloftData, nameplateGUId, active)
		end
	end
end

function AloftCastWarningSpellNameText:OnCastWarningDataChanged(message, aloftData, nameplateGUId, active)
	-- TODO: this can be guarded here, for basic enable purposes; it would be more efficient
	-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:OnCastWarningDataChanged() " .. tostring(aloftData.name) .. "/" .. tostring(nameplateGUId) .. "/" .. tostring(active and active.id) .. "/" .. tostring(active and active.name))
	self:CreateFrame(aloftData, nameplateGUId, active)
end

function AloftCastWarningSpellNameText:OnNameplateHide(message, aloftData)
	local castWarningFrame = aloftData.castWarningFrame
	if castWarningFrame then
		local castWarningSpellNameTextRegion = castWarningFrame.castWarningSpellNameTextRegion
		if castWarningSpellNameTextRegion then
			castWarningSpellNameTextRegion:SetText("")
			castWarningSpellNameTextRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellNameText:PlaceFrame(textRegion, frame, profile)
	textRegion:SetParent(frame)

	textRegion:ClearAllPoints()
	textRegion:SetPoint("TOPLEFT", frame, "TOPLEFT", profile.offsets.left, profile.offsets.vertical)
	textRegion:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", profile.offsets.right, profile.offsets.vertical)
	textRegion:SetDrawLayer("OVERLAY")
end

function AloftCastWarningSpellNameText:CreateFrame(aloftData, nameplateGUId, active)
	if AloftCastWarning.db.profile.enable and self.db.profile.enable then
		-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): " .. tostring(aloftData.name) .. "/" .. tostring(nameplateGUId) .. "/" .. tostring(active and active.id) .. "/" .. tostring(active and active.name))
		local castWarningFrame = aloftData.castWarningFrame
		if nameplateGUId and active and castWarningFrame and castWarningFrame:IsVisible() then
			-- Check if this nameplate already has a text region assigned to it
			local castWarningSpellNameTextRegion = castWarningFrame.castWarningSpellNameTextRegion
			if not castWarningSpellNameTextRegion then
				castWarningSpellNameTextRegion = castWarningFrame.castWarningExtraFrame:CreateFontString(nil, "OVERLAY")
				castWarningFrame.castWarningSpellNameTextRegion = castWarningSpellNameTextRegion
			end

			self:PrepareText(castWarningSpellNameTextRegion, self.db.profile)
			self:PlaceFrame(castWarningSpellNameTextRegion, castWarningFrame.castWarningExtraFrame, self.db.profile)

			local text = active.name
			if self.db.profile.rank and active.rank then
				-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): rank " .. tostring(active.name) .. "/" .. tostring(active.rank) .. "/" .. tostring(active.rank ~= ""))
				text = text .. ((active.rank ~= "" and (" (" .. active.rank .. ")")) or "")
			end
			if self.db.profile.range and active.minRange and active.maxRange and active.maxRange > 0 and active.maxRange >= active.minRange then
				-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): ranke " .. tostring(active.name) .. "/" .. tostring(active.minRange) .. "/" .. tostring(active.maxRange))
				text = text .. " [" .. active.minRange .. "-" .. active.maxRange .. "]"
			end
			if self.db.profile.outcome and active.fadeTime and active.outcome then
				-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): outcome " .. tostring(active.name) .. "/" .. tostring(active.outcome))
				text = text .. (active.outcome ~= "" and (" (" .. active.outcome .. ")")) or ""
			end
			if self.db.profile.extra and active.fadeTime and active.extra then
				-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): extra " .. tostring(active.name) .. "/" .. tostring(active.extra))
				text = text .. (active.extra ~= "" and (" \"" .. active.extra .. "\"")) or ""
			end

			local color = self.db.profile.castColor
			if active.fadeTime then color = self.db.profile.fadeColor end
			castWarningSpellNameTextRegion:SetTextColor(unpack(color))
			castWarningSpellNameTextRegion:SetText(text)

			-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): " .. tostring(floor(color[4]*255)) .. "." .. tostring(floor(color[1]*255)) .. "." .. tostring(floor(color[2]*255)) .. "." .. tostring(floor(color[3]*255)))
			-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): show " .. ("|c%02x%02x%02x%02x%s|r"):format(floor(color[4]*255), floor(color[1]*255), floor(color[2]*255), floor(color[3]*255), tostring(text)))
			castWarningSpellNameTextRegion:Show()

			return
		else
			-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): NONE " .. tostring(aloftData.name) .. "/" .. tostring(nameplateGUId) .. "/" .. tostring(active and active.id) .. "/" .. tostring(active and active.name) .. "/" .. tostring(castWarningFrame and castWarningFrame:IsVisible()))
		end
	end

	-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): hide")
	self:OnNameplateHide("AloftCastWarningSpellNameText:CreateFrame", aloftData)
end

-----------------------------------------------------------------------------


end)
