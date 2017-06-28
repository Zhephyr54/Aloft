local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

local AloftManaData = Aloft:GetModule("ManaData", true)
if not AloftManaData then return end

local AloftManaBar = Aloft:NewModule("ManaBar", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftManaBar.dynamic = "AloftMana"

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftManaBar.namespace = "manaBar"
AloftManaBar.defaults =
{
	profile =
	{
		enable			= false,
		texture			= "Blizzard",
		height			= 4,
		targetOnly		= true,
		border			= "None",
		borderEdgeSize	= 16,
		borderInset		= 4,
		borderColor		= { 1, 1, 1, 1 },
		backdropColor	= { 0.25, 0.25, 0.25, 0.5 },
		offsets =
		{
			left		= 0,
			right		= 0,
			vertical	= -12,
		},
		powerTypeColors	=
		{
			[0] = { 0.28, 0.52, 0.84, 1},	-- Mana
			[1] = { 0.89, 0.18, 0.29, 1}, 	-- Rage
			[2] = {    1, 0.82,    0, 1},	-- Focus
			[3] = {    1, 0.86, 0.10, 1}, 	-- Energy
			[4] = {    0,    1,    1, 1}, 	-- Happiness
			[5] = { 0.50, 0.50, 0.50, 1}, 	-- Runes
			[6] = { 0.92, 0.92, 0.92, 1}, 	-- Runic Power
		},
		--always			= true,
	},
}

-----------------------------------------------------------------------------

-- backdrop table for initializing visible nameplates
local backdropTable =
{
	-- tile = false,
	-- tileSize = 16,
	bgFile = nil,
	edgeSize = 16,
	edgeFile = nil,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

local unpack=unpack

-----------------------------------------------------------------------------

function AloftManaBar:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if self.db.profile and self.db.profile.enable then
			-- if aloftData.manaBar then
				-- self:SetupBar(aloftData, aloftData.manaBar)
				-- self:PlaceBar(aloftData)
			-- end
			self:Update("AloftManaBar:UpdateAll", aloftData)
		else
			self:ReleaseManaBar(aloftData)
		end
	end
	if self.db.profile and self.db.profile.enable then
		for layoutFrame in pairs(Aloft.layoutFramePool) do
			local manaBar = layoutFrame.manaBar
			if manaBar then
				self:SetupBar(nil, manaBar)
				manaBar:Hide()
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftManaBar:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftManaBar:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftManaBar:OnEnable(): enter")

	self:RegisterMessage("SharedMedia_SetGlobal", function(message, mediatype, override)
		if mediatype == "statusbar" then
			self:UpdateAll()
		end
	end)

	self:RegisterMessage("Aloft:SetAll", function(message, type, value)
		if AloftManaBar.db.profile[type] then
			AloftManaBar.db.profile[type] = value
			AloftManaBar:UpdateAll()
		end
	end)

	self:UpdateAll()
end

function AloftManaBar:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:ReleaseManaBar(aloftData)
	end
	-- TODO: nil out Aloft.Options
end

function AloftManaBar:RequiresData()
	self:RegisterEvents()

	if self.db.profile and self.db.profile.enable then
		return "mana", "maxMana", "powerType"
	end
end

function AloftManaBar:RegisterEvents()
	if self.db.profile and self.db.profile.enable then
		self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
		self:RegisterMessage("Aloft:OnManaDataChanged", "Update")
		self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
	else
		self:UnregisterMessage("Aloft:OnIsTargetDataChanged")
		self:UnregisterMessage("Aloft:OnManaDataChanged")
		self:UnregisterMessage("Aloft:OnNameplateShow")
		self:UnregisterMessage("Aloft:OnNameplateHide")
	end
end

-----------------------------------------------------------------------------

function AloftManaBar:GetBorder(aloftData)
	if not self.db.profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		-- ChatFrame7:AddMessage("AloftHealthBar:GetBorder(): border " .. tostring(self.db.profile.border))
		return ((self.db.profile.border ~= "None") and self.db.profile.borderInset) or 0, SML:Fetch("border", self.db.profile.border)
		-- return 0, SML:Fetch("border", "None")
	else
		return 0, SML:Fetch("border", "None")
	end
end

function AloftManaBar:SetupBar(aloftData, manaBar)
	-- ChatFrame7:AddMessage("ManaBar:SetupBar(): invoke")

	local texture = SML:Fetch("statusbar", self.db.profile.texture)
	local inset, edgeFile = self:GetBorder(aloftData)

	local manaRegion = manaBar.manaRegion
	if not manaRegion then
		manaRegion = manaBar:CreateTexture(nil, "ARTWORK")
		manaRegion:SetBlendMode("BLEND")
		manaBar.manaRegion = manaRegion
	end

	-- glue the left of the mana region to the left of the mana bar frame, we want motion on the right edge of this region; adjusting for the inset is handled by adjusting the width
	-- TODO: see if this can be done once
	-- TODO: remember why we did this, instead of a status bar, and document it
	manaRegion:ClearAllPoints()
	manaRegion:SetPoint("TOPLEFT", manaBar, "TOPLEFT", inset, -inset)
	manaRegion:SetPoint("BOTTOMLEFT", manaBar, "BOTTOMLEFT", inset, inset)
	manaRegion:SetTexture(texture)
	manaRegion:Hide()
	-- ChatFrame7:AddMessage("ManaBar:SetupManaBar(): mana " .. manaRegion:GetDrawLayer())

	backdropTable.insets.left = inset
	backdropTable.insets.right = inset
	backdropTable.insets.top = inset
	backdropTable.insets.bottom = inset
	backdropTable.edgeFile = edgeFile
	backdropTable.edgeSize = self.db.profile.borderEdgeSize
	backdropTable.bgFile = texture

	-- ChatFrame7:AddMessage("AloftManaBar:SetupBar(): set backdrop " .. tostring(backdropTable.edgeFile))
	manaBar:SetBackdrop(backdropTable)
	manaBar:SetBackdropBorderColor(unpack(self.db.profile.borderColor))
	manaBar:SetBackdropColor(unpack(self.db.profile.backdropColor))

	-- This manipulates the mana bar background to always display "below" the mana bar
	-- ChatFrame7:AddMessage("AloftManaBar:SetupBar(): mana #regions " .. manaBar:GetNumRegions())
	local _, backgroundRegion = manaBar:GetRegions()
	backgroundRegion:SetDrawLayer("BACKGROUND")
	backgroundRegion:SetBlendMode("BLEND")
	backgroundRegion:Show()

	-- manaBar:Hide()
end

function AloftManaBar:PlaceBar(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local manaBar = layoutFrame and layoutFrame.manaBar
	if manaBar then
		local inset, _ = self:GetBorder(aloftData)
		local nameplateFrame = aloftData.nameplateFrame
		local level = nameplateFrame:GetFrameLevel()

		manaBar:ClearAllPoints()
		manaBar:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", self.db.profile.offsets.left - inset, self.db.profile.offsets.vertical + inset)
		manaBar:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", self.db.profile.offsets.right + inset, self.db.profile.offsets.vertical - self.db.profile.height - inset)
		manaBar:SetFrameLevel(level)
	end
end

function AloftManaBar:AcquireManaBar(aloftData)
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	if not layoutFrame then
		ChatFrame7:AddMessage("AloftManaBar:AcquireManaBar(): no layoutFrame " .. tostring(aloftData.name))
		ChatFrame7:AddMessage("AloftManaBar:AcquireManaBar(): " .. debugstack())
	end
	local manaBar = layoutFrame.manaBar

	if not manaBar then
		manaBar = CreateFrame("Frame", nil, layoutFrame)

		layoutFrame.manaBar = manaBar
		manaBar.layoutFrame = layoutFrame
	end

	self:SetupBar(aloftData, manaBar)
	self:PlaceBar(aloftData)

	return manaBar
end

function AloftManaBar:ReleaseManaBar(aloftData)
	-- ChatFrame7:AddMessage("ManaBar:ReleaseManaBar(): release " .. aloftData.name)
	self:CleanupManaBar(aloftData)
	self:RePoolManaBar(aloftData)
end

function AloftManaBar:CleanupManaBar(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local manaBar = layoutFrame and layoutFrame.manaBar
	if manaBar then
		-- if manaBar.manaRegion then manaBar.manaRegion:Hide() end
	end
end

function AloftManaBar:RePoolManaBar(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local manaBar = layoutFrame and layoutFrame.manaBar
	if manaBar then
		manaBar:Hide()
	end
end

function AloftManaBar:Update(message, aloftData)
	-- ChatFrame7:AddMessage("ManaBar:Update(): enter")
	-- ChatFrame7:AddMessage("ManaBar:Update(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.powerType) .. "/".. tostring(aloftData.mana) .. "/".. tostring(aloftData.maxMana))
	if aloftData.mana and aloftData.maxMana and aloftData.maxMana > 0 then
		-- ChatFrame7:AddMessage("ManaBar:Update(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.powerType) .. "/".. tostring(aloftData.mana) .. "/".. tostring(aloftData.maxMana))
		local manaBar = self:AcquireManaBar(aloftData)
		local color = self.db.profile.powerTypeColors[aloftData.powerType]
		local inset, _ = self:GetBorder(aloftData)

		local manaRegionWidth = (aloftData.mana / aloftData.maxMana) * (manaBar:GetWidth() - (2 * inset))
		if manaRegionWidth <= 0 then manaRegionWidth = 0.00001 end -- needs to be > 0, so it doesn't default to the blizzard value, but make it as skinny as we can get it

		manaBar.manaRegion:SetVertexColor(unpack(color))
		manaBar.manaRegion:SetWidth(manaRegionWidth)
		manaBar.manaRegion:Show()

		manaBar:Show()
	else
		self:ReleaseManaBar(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftManaBar:OnNameplateShow(message, aloftData)
	-- ChatFrame7:AddMessage("AloftManaBar:OnNameplateShow(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget) .. "/" .. tostring(aloftData.IsTarget()))
	if aloftData.isTarget or aloftData:IsTarget() then
		self:ScheduleTimer(function(aloftData) AloftManaBar:Update("AloftManaBar:OnNameplateShow", aloftData) end, 0.00, aloftData) -- next frame
	else
		self:Update(message, aloftData) -- update immediately
	end
end

function AloftManaBar:OnNameplateHide(message, aloftData)
	-- ChatFrame7:AddMessage("AloftManaBar:OnNameplateHide(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:ReleaseManaBar(aloftData)
end

function AloftManaBar:OnIsTargetDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftManaBar:OnIsTargetDataChanged(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:ScheduleTimer(function(aloftData) AloftManaBar:Update("AloftManaBar:OnIsTargetDataChanged", aloftData) end, 0.1, aloftData) -- a bit more than next frame
end

-----------------------------------------------------------------------------

end)
