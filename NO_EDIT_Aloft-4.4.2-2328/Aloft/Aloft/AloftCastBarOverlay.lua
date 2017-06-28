local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftCastBarOverlay = Aloft:NewModule("CastBarOverlay", Aloft, "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

function AloftCastBarOverlay:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftCastBarOverlay:OnInitialize()
	self.initialized = true
end

function AloftCastBarOverlay:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
	self:UpdateAll()
end

function AloftCastBarOverlay:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		local castBarOverlayRegion = aloftData.castBarOverlayRegion

		castBarOverlayRegion:ClearAllPoints()
		castBarOverlayRegion:SetPoint("CENTER", aloftData.nameplateFrame, "CENTER", 0, -16)
		castBarOverlayRegion:SetTexture("Interface\\Tooltips\\Nameplate-Border")
		castBarOverlayRegion:SetTexCoord(0.0, 1.0, 1.0, 1.0)
		castBarOverlayRegion:SetAlpha(1)
		castBarOverlayRegion:SetWidth(128)
		castBarOverlayRegion:SetHeight(32)
	end
end

function AloftCastBarOverlay:SetupFrame(message, aloftData)
	aloftData.castBarOverlayRegion:SetTexture("")
end

-----------------------------------------------------------------------------
