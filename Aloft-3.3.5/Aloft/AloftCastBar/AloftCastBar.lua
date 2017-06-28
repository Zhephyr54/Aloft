local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftCastBar = Aloft:NewModule("CastBar", "AceEvent-2.0")
local SML = AceLibrary("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftCastBar.db = Aloft:AcquireDBNamespace("castBar")
Aloft:RegisterDefaults("castBar", "profile", {
	offsets =
	{
		left		= 0,
		right		= 0,
		vertical	= -12,
	},
	height			= 10,

	border			= "None",
	borderColor		= { 1, 1, 1, 1 },
	backdropColor	= { 0.25, 0.25, 0.25, 0.5 },
	color			= { 1.0, 0.7, 0.0, 1.0 },
	texture			= "Blizzard",

	nointerBorder			= "None",
	nointerBorderColor		= { 1, 1, 1, 1 },
	nointerBackdropColor	= { 0.25, 0.25, 0.25, 0.5 },
	nointerTexture			= "Blizzard",
	nointerColor			= { 1.0, 0.0, 0.0, 1.0 },
})

-----------------------------------------------------------------------------

-- local AloftFrame
local profile
local inset

local defaultBackdropTable = { }
local backdropTable =
{
	tile = false, tileSize = 16,
	edgeSize = 16,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
}

-----------------------------------------------------------------------------

function AloftCastBar:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame(aloftData)
	end

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnCastBarShow(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftCastBar:OnInitialize()
	profile = self.db.profile
end

function AloftCastBar:OnEnable()
	-- AloftFrame = Aloft:HasModule("Frame") and Aloft:GetModule("Frame")

	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:OnCastBarShow", "OnCastBarShow")
	self:RegisterEvent("Aloft:OnCastBarHide", "OnCastBarHide")

	self:RegisterEvent("SharedMedia_SetGlobal", function(mediatype, override)
		if mediatype == "statusbar" then
			self:UpdateAll()
		end
	end)

	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:UpdateAll()
		end
	end)

	self:UpdateAll()
end

function AloftCastBar:OnDisable()
	self:UnregisterAllEvents()

	defaultBackdropTable.bgFile = ""

	for aloftData in Aloft:IterateNameplates() do
		local nameplateFrame = aloftData.nameplateFrame
		local castBar = aloftData.castBar

		castBar:ClearAllPoints()
		castBar:SetPoint("BOTTOMRIGHT", aloftData.castBarOverlayRegion, "BOTTOMRIGHT", -4.5, 4.5)
		castBar:SetWidth(116.5)
		castBar:SetHeight(10.18)
		castBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		castBar:SetBackdrop(defaultBackdropTable)
		castBar:SetBackdropColor(0, 0, 0, 0)
		castBar:SetBackdropBorderColor(0, 0, 0, 0)

		local level = nameplateFrame:GetFrameLevel()
		castBar:SetFrameLevel(level)
	end
end

function AloftCastBar:GetBorder(aloftData, noInterrupt)
	if noInterrupt then
		return ((profile.border ~= "None") and 4) or 0, SML:Fetch("border", profile.border)
	else
		return ((profile.nointerBorder ~= "None") and 4) or 0, SML:Fetch("border", profile.nointerBorder)
	end
end

function AloftCastBar:SetupFrame(aloftData)
	local castBar = aloftData.castBar
	if castBar and castBar:IsVisible() then
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		if not layoutFrame then
			ChatFrame7:AddMessage("AloftCastBar:UpdatePlacement(): no layoutFrame " .. tostring(aloftData.name))
			ChatFrame7:AddMessage("AloftCastBar:UpdatePlacement(): " .. debugstack())
		end

		local nameplateFrame = aloftData.nameplateFrame
		-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): parent " .. tostring(aloftData.name) .. "/" .. tostring(castBar:GetParent()) .. "/" .. tostring(nameplateFrame) .. "/" .. tostring(UIParent))

		local texture, color, backdropColor, borderColor
		if castBar.noInterrupt then
			texture = SML:Fetch("statusbar", profile.nointerTexture)
			color = profile.nointerColor
			backdropColor = profile.nointerBackdropColor
			borderColor = profile.nointerBorderColor
		else
			texture = SML:Fetch("statusbar", profile.texture)
			color = profile.color
			backdropColor = profile.backdropColor
			borderColor = profile.borderColor
		end
		local inset, edgeFile = self:GetBorder(aloftData, castBar.noInterrupt)

		local r, g, b, a = unpack(backdropColor)
		local _, _, _, castBarAlpha = castBar:GetStatusBarColor()
		a = a * castBarAlpha

		backdropTable.bgFile = texture
		backdropTable.edgeFile = edgeFile
		backdropTable.insets = { left = inset, right = inset, top = inset, bottom = inset }

		local level = nameplateFrame:GetFrameLevel()
		-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): cast bar frame level " .. tostring(level))
		castBar:SetFrameLevel(level)
		castBar:SetStatusBarTexture(texture)
		castBar:SetStatusBarColor(unpack(color))

		castBar:SetBackdrop(backdropTable)
		castBar:SetBackdropColor(r, g, b, a)
		castBar:SetBackdropBorderColor(unpack(borderColor))

		castBar:ClearAllPoints()
		castBar:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", profile.offsets.left - inset, profile.offsets.vertical + inset)
		castBar:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", profile.offsets.right + inset, profile.offsets.vertical - profile.height - inset)

		--[[
		local sr, sg, sb, sa = aloftData.castBarShieldRegion:GetVertexColor()
		ChatFrame7:AddMessage("AloftCastBar:UpdateCastBar(): " .. tostring(aloftData.name) .. "|"
			.. "|" .. tostring(sr) .. "-" .. tostring(sg) .. "-" .. tostring(sb) .. "-" .. tostring(sa)
				.. "/" .. floor(255*sr) .. "." .. floor(255*sg) .. "." .. floor(255*sb) .. "." .. floor(255*sa)
				.. "/" .. ("|c%02x%02x%02x%02xshield color|r"):format(floor(255*sa), floor(255*sr), floor(255*sg), floor(255*sb)))
		]]

		-- this manipulates the cast bar background to inset within the cast bar and always display above the frame background
		local barRegion, backgroundRegion = castBar:GetRegions()
		barRegion:ClearAllPoints()
		barRegion:SetPoint("TOPLEFT", castBar, "TOPLEFT", inset, -inset)
		barRegion:SetPoint("BOTTOMRIGHT", castBar, "BOTTOMRIGHT", -inset, inset)
		barRegion:SetDrawLayer("ARTWORK")
		barRegion:SetBlendMode("BLEND")

		backgroundRegion:SetDrawLayer("BACKGROUND")
		backgroundRegion:SetBlendMode("BLEND")
		backgroundRegion:Show()
	end
end

function AloftCastBar:OnCastBarShow(aloftData)
	local castBar = aloftData.castBar
	if castBar then
		local _, noInterrupt = self:GetTargetSpellInfo()
		castBar.noInterrupt = noInterrupt

		self:UpdateCastBar(aloftData)
		-- self:ScheduleEvent("AloftCastBar:UpdateCastBar", self.UpdateCastBar, 0.0, self, aloftData)
		self:ScheduleRepeatingEvent("AloftCastBar:UpdateCastBar", self.UpdateCastBar, 0.1, self, aloftData)
	end
end

function AloftCastBar:OnCastBarHide(aloftData)
	self:CancelScheduledEvent("AloftCastBar:UpdateCastBar")

	if aloftData.castBar then aloftData.castBar.noInterrupt = nil end
end

-----------------------------------------------------------------------------

function AloftCastBar:UpdateCastBar(aloftData)
	-- unfortunately, by enabling borders/insets/etc to be altered on uninterruptable casts, and given that Blizzard can change sizes on us at will
	-- we have to do this at regular intervals
	self:SetupFrame(aloftData)
end

-----------------------------------------------------------------------------

function AloftCastBar:GetTargetSpellInfo()
	local _, _, displayName, _, _, _, _, castId, noInterrupt = UnitCastingInfo("target")
	if displayName then
		-- ChatFrame7:AddMessage("AloftCastBar:GetTargetSpellInfo(): casting " .. tostring(UnitName("target")) .. "/" .. tostring(displayName) .. "/" .. tostring(castId) .. "/" .. tostring(noInterrupt))
		return displayName, noInterrupt
	end
	_, _, displayName, _, _, _, _, noInterrupt = UnitChannelInfo("target")
	if displayName then
		-- ChatFrame7:AddMessage("AloftCastBar:GetTargetSpellInfo(): channel " .. tostring(UnitName("target")) .. "/" .. tostring(displayName) .. "/" .. tostring(castId) .. "/" .. tostring(noInterrupt))
		return displayName, noInterrupt
	end
	return "", nil
end

-----------------------------------------------------------------------------
