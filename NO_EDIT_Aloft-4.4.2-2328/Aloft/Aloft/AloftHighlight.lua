local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftHealthBar = Aloft:GetModule("HealthBar") -- always on
if not AloftHealthBar then return end

local AloftHighlight = Aloft:NewModule("Highlight", Aloft, "AceEvent-3.0", "AceTimer-3.0")

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftHighlight.namespace = "highlight"
AloftHighlight.defaults =
{
	profile =
	{
		color			= { 1, 1, 0, 0.25 },
		texture			= "Blizzard",
		blendMode		= "ADD",
	},
}

-----------------------------------------------------------------------------

function AloftHighlight:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame("AloftHighlight:UpdateAll", aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftHighlight:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftHighlight:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:RegisterMessage("SharedMedia_SetGlobal", function(message, mediatype, override)
		if mediatype == "statusbar" then
			self:UpdateAll()
		end
	end)

	self:RegisterMessage("Aloft:SetAll", function(message, type, value)
		if AloftHighlight.db.profile[type] then
			AloftHighlight.db.profile[type] = value
			AloftHighlight:UpdateAll()
		end
	end)

	self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
	self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
	self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")

	self:UpdateAll()
end

function AloftHighlight:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		local highlightRegion = aloftData.highlightRegion
		highlightRegion:ClearAllPoints()
		highlightRegion:SetAllPoints(aloftData.nameplateFrame)
		highlightRegion:SetTexture("Interface\\Tooltips\\Nameplate-Glow")
		highlightRegion:SetBlendMode("ADD")
		highlightRegion:SetDrawLayer("HIGHLIGHT")
	end
end

function AloftHighlight:OnIsTargetDataChanged(message, aloftData)
	self:PlaceFrame(aloftData)
end

function AloftHighlight:OnNameplateShow(message, aloftData)
	self:SetupFrame(message, aloftData)
end

function AloftHighlight:OnNameplateHide(message, aloftData)
	-- We do this because WoW leaves lingering highlights if you toggle off nameplate while the mouse is over them
	aloftData.highlightRegion:Hide()
end

function AloftHighlight:GetInset(aloftData)
	if not AloftHealthBar.db.profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		return ((AloftHealthBar.db.profile.border ~= "None") and 4) or 0
	else
		return 0
	end
end

function AloftHighlight:SetupFrame(message, aloftData)
	local highlightRegion = aloftData.highlightRegion

	highlightRegion:SetVertexColor(unpack(self.db.profile.color))
	highlightRegion:SetTexture(SML:Fetch("statusbar", self.db.profile.texture))
	highlightRegion:SetBlendMode(self.db.profile.blendMode)

	self:PlaceFrame(aloftData)
end

function AloftHighlight:PlaceFrame(aloftData)
	local healthFrame = AloftHealthBar:AcquireHealthFrame(aloftData)
	local highlightRegion = aloftData.highlightRegion
	local inset = self:GetInset(aloftData)

	-- ChatFrame7:AddMessage("AloftHighlight:PlaceFrame(): " .. tostring(highlightRegion:GetTexture()))

	highlightRegion:ClearAllPoints()
	highlightRegion:SetPoint("TOPLEFT", healthFrame, "TOPLEFT", inset, -inset)
	highlightRegion:SetPoint("BOTTOMRIGHT", healthFrame, "BOTTOMRIGHT", -inset, inset)
	highlightRegion:SetDrawLayer("HIGHLIGHT")
end

-----------------------------------------------------------------------------
