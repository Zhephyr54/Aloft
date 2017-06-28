local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftHighlight = Aloft:NewModule("Highlight", "AceEvent-2.0")
local SML = AceLibrary("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftHighlight.db = Aloft:AcquireDBNamespace("highlight")
Aloft:RegisterDefaults("highlight", "profile", {
	color			= { 1, 1, 0, 0.25 },
	texture			= "Blizzard",
	blendMode		= "ADD",
})

-----------------------------------------------------------------------------

local profile
local aloftHealthBarProfile

-----------------------------------------------------------------------------

function AloftHighlight:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftHighlight:OnInitialize()
	profile = self.db.profile
end

function AloftHighlight:OnEnable()
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

	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")

	aloftHealthBarProfile = Aloft:GetModule("HealthBar").db.profile

	self:UpdateAll()
end

function AloftHighlight:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local highlightRegion = aloftData.highlightRegion
		highlightRegion:ClearAllPoints()
		highlightRegion:SetAllPoints(aloftData.nameplateFrame)
		highlightRegion:SetTexture("Interface\\Tooltips\\Nameplate-Glow")
		highlightRegion:SetBlendMode("ADD")
		highlightRegion:SetDrawLayer("HIGHLIGHT")
	end
end

function AloftHighlight:OnIsTargetDataChanged(aloftData)
	self:PlaceFrame(aloftData)
end

function AloftHighlight:OnNameplateShow(aloftData)
	self:SetupFrame(aloftData)
end

function AloftHighlight:OnNameplateHide(aloftData)
	-- We do this because WoW leaves lingering highlights if you toggle off nameplate while the mouse is over them
	aloftData.highlightRegion:Hide()
end

function AloftHighlight:GetInset(aloftData)
	if not aloftHealthBarProfile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		return ((aloftHealthBarProfile.border ~= "None") and 4) or 0
	else
		return 0
	end
end

function AloftHighlight:SetupFrame(aloftData)
	local highlightRegion = aloftData.highlightRegion
	local healthBar = aloftData and aloftData.healthBar

	highlightRegion:SetVertexColor(unpack(profile.color))
	highlightRegion:SetTexture(SML:Fetch("statusbar", profile.texture))
	highlightRegion:SetBlendMode(profile.blendMode)

	self:PlaceFrame(aloftData)
end

function AloftHighlight:PlaceFrame(aloftData)
	local highlightRegion = aloftData.highlightRegion
	local healthBar = aloftData.healthBar
	local inset = self:GetInset(aloftData)

	-- ChatFrame7:AddMessage("AloftHighlight:PlaceFrame(): " .. tostring(highlightRegion:GetTexture()))

	highlightRegion:ClearAllPoints()
	highlightRegion:SetPoint("TOPLEFT", healthBar, "TOPLEFT", inset, -inset)
	highlightRegion:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", -inset, inset)
	highlightRegion:SetDrawLayer("HIGHLIGHT")
end

-----------------------------------------------------------------------------
