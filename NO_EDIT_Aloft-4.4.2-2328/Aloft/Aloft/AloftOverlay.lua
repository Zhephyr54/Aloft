local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftOverlay = Aloft:NewModule("Overlay", Aloft, "AceEvent-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

function AloftOverlay:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		aloftData.overlayRegion:Hide()
	end
end

-----------------------------------------------------------------------------

function AloftOverlay:OnInitialize()
	self.initialized = true
end

function AloftOverlay:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
	self:UpdateAll()
end

function AloftOverlay:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		local overlayRegion = aloftData.overlayRegion
		overlayRegion:ClearAllPoints()
		overlayRegion:SetAllPoints(aloftData.nameplateFrame)
		overlayRegion:SetTexture("Interface\\Tooltips\\Nameplate-Border")
		overlayRegion:SetVertexColor(1.0, 1.0, 1.0, 1.0)
		overlayRegion:SetTexCoord(0.0, 1.0, 0.0, 1.0)
		overlayRegion:Show()
	end
end

function AloftOverlay:SetupFrame(message, aloftData)
	aloftData.overlayRegion:Hide()
end

-----------------------------------------------------------------------------
