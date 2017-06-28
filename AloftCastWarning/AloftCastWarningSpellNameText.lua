local Aloft = Aloft
if not Aloft then return end
-- local AloftModules = AloftModules
-- if not AloftModules then return end

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CastWarning") or not Aloft:HasModule("TargetTrackingData") then return end

local AloftCastWarningSpellNameText = Aloft:NewModule("CastWarningSpellNameText", "AceEvent-2.0")
-- AloftCastWarningSpellNameText.dynamic = true

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData")
local AloftCastWarning = Aloft:GetModule("CastWarning")

-----------------------------------------------------------------------------

AloftCastWarningSpellNameText.db = Aloft:AcquireDBNamespace("castWarningSpellNameText")
Aloft:RegisterDefaults("castWarningSpellNameText", "profile", {
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
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftCastWarningSpellNameText:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if profile.enable then
			self:UpdateText(aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellNameText:RegisterEvents()
	self:UnregisterAllEvents()

	if profile and profile.enable then
		self:RegisterEvent("Aloft:OnNameplateShow", "UpdateText")
		self:RegisterEvent("Aloft:OnSetHealthBarColor", "UpdateText") -- TODO: is this needed?
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterEvent("AloftCastWarning:OnCastWarningDataChanged", "OnCastWarningDataChanged")
		-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:RegisterEvents(): registered")

		self:RegisterEvent("Aloft:SetAll", function(type, value)
			if profile[type] then
				profile[type] = value
				self:UpdateAll()
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
	Aloft:DebugRegister("CastWarningSpellNameText")
	profile = self.db.profile
end

function AloftCastWarningSpellNameText:OnEnable()
	self:UpdateAll()
end

function AloftCastWarningSpellNameText:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateHide(aloftData)
	end
	-- TODO: nil out Aloft.Options?
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellNameText:UpdateText(aloftData)
	local nameplateId = AloftTargetTrackingData:GetNameplateId(aloftData)
	if nameplateId then
		local nameplateGUId = AloftTargetTrackingData:GetNameplateGUId(nameplateId)
		if nameplateGUId then
			local active = nameplateGUId and AloftCastWarning:GetActiveCastByGUId(nameplateGUId)

			self:CreateFrame(aloftData, nameplateGUId, active)
		end
	end
end

function AloftCastWarningSpellNameText:OnCastWarningDataChanged(aloftData, nameplateGUId, active)
	self:CreateFrame(aloftData, nameplateGUId, active)
end

function AloftCastWarningSpellNameText:OnNameplateHide(aloftData)
	local castWarningBar = aloftData.castWarningBar
	if castWarningBar then
		local castWarningSpellNameTextRegion = castWarningBar.castWarningSpellNameTextRegion
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
	-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): " .. tostring(aloftData.name) .. "/" .. tostring(nameplateGUId) .. "/" .. tostring(active and active.id) .. "/" .. tostring(active and active.name))
	local castWarningBar = aloftData.castWarningBar
	if nameplateGUId and active and castWarningBar and castWarningBar:IsVisible() then
		-- Check if this nameplate already has a text region assigned to it
		local castWarningSpellNameTextRegion = castWarningBar.castWarningSpellNameTextRegion
		if not castWarningSpellNameTextRegion then
			castWarningSpellNameTextRegion = castWarningBar.castWarningExtraFrame:CreateFontString(nil, "OVERLAY")
			castWarningBar.castWarningSpellNameTextRegion = castWarningSpellNameTextRegion
		end

		self:PrepareText(castWarningSpellNameTextRegion, profile)
		self:PlaceFrame(castWarningSpellNameTextRegion, castWarningBar.castWarningExtraFrame, profile)

		local text = active.name
		if profile.rank and active.rank then
			-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): rank " .. tostring(active.name) .. "/" .. tostring(active.rank))
			text = text .. (active.rank ~= "" and (" (" .. active.rank .. ")")) or ""
		end
		if profile.range and active.minRange and active.maxRange and active.maxRange > 0 and active.maxRange >= active.minRange then
			-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): ranke " .. tostring(active.name) .. "/" .. tostring(active.minRange) .. "/" .. tostring(active.maxRange))
			text = text .. " [" .. active.minRange .. "-" .. active.maxRange .. "]"
		end
		if profile.outcome and active.fadeTime and active.outcome then
			-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): outcome " .. tostring(active.name) .. "/" .. tostring(active.outcome))
			text = text .. (active.outcome ~= "" and (" (" .. active.outcome .. ")")) or ""
		end
		if profile.extra and active.fadeTime and active.extra then
			-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): extra " .. tostring(active.name) .. "/" .. tostring(active.extra))
			text = text .. (active.extra ~= "" and (" \"" .. active.extra .. "\"")) or ""
		end

		local color = profile.castColor
		if active.fadeTime then color = profile.fadeColor end
		castWarningSpellNameTextRegion:SetTextColor(unpack(color))
		castWarningSpellNameTextRegion:SetText(text)

		-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): " .. tostring(floor(color[4]*255)) .. "." .. tostring(floor(color[1]*255)) .. "." .. tostring(floor(color[2]*255)) .. "." .. tostring(floor(color[3]*255)))
		-- ChatFrame7:AddMessage("AloftCastWarningSpellNameText:CreateFrame(): " .. ("|c%02x%02x%02x%02x%s|r"):format(floor(color[4]*255), floor(color[1]*255), floor(color[2]*255), floor(color[3]*255), tostring(text)))
		castWarningSpellNameTextRegion:Show()
	else
		self:OnNameplateHide(aloftData)
	end
end

-----------------------------------------------------------------------------


-- end)
