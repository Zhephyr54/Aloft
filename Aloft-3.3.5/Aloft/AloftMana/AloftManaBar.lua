local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

local AloftManaBar = Aloft:NewModule("ManaBar", "AceEvent-2.0")
AloftManaBar.dynamic = "AloftMana"

local SML = AceLibrary("LibSharedMedia-3.0")
local SML_statusbar = SML:List("statusbar")

-----------------------------------------------------------------------------

AloftManaBar.db = Aloft:AcquireDBNamespace("manaBar")
Aloft:RegisterDefaults("manaBar", "profile", {
	enable			= false,
	texture			= "Blizzard",
	height			= 4,
	targetOnly		= true,
	border			= "None",
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
})

-----------------------------------------------------------------------------

local profile

local backdropTable =
{
	tile = false,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
}

local unpack=unpack

-----------------------------------------------------------------------------

function AloftManaBar:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if profile and profile.enable then
			-- if aloftData.manaBar then
				-- self:SetupBar(aloftData, aloftData.manaBar)
				-- self:PlaceBar(aloftData)
			-- end
			self:Update(aloftData)
		else
			self:ReleaseManaBar(aloftData)
		end
	end
	if profile and profile.enable then
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
	Aloft:DebugRegister("ManaBar")
	profile = self.db.profile
end

function AloftManaBar:OnEnable()
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

function AloftManaBar:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:ReleaseManaBar(aloftData)
	end
	-- TODO: nil out Aloft.Options
end

function AloftManaBar:RequiresData()
	self:RegisterEvents()
	if profile and profile.enable then
		return "mana", "maxMana", "powerType"
	end
end

function AloftManaBar:RegisterEvents()
	if profile and profile.enable then
		self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
		self:RegisterEvent("Aloft:OnManaDataChanged", "Update")
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	else
		self:CancelEvent("Aloft:OnIsTargetDataChanged")
		self:CancelEvent("Aloft:OnManaDataChanged")
		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnNameplateHide")
	end
end

-----------------------------------------------------------------------------

function AloftManaBar:GetBorder(aloftData)
	if not profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		-- ChatFrame7:AddMessage("AloftHealthBar:GetBorder(): border " .. tostring(profile.border))
		return ((profile.border ~= "None") and 4) or 0, SML:Fetch("border", profile.border)
	else
		return 0, SML:Fetch("border", "None")
	end
end

function AloftManaBar:SetupBar(aloftData, manaBar)
	-- ChatFrame7:AddMessage("ManaBar:SetupBar(): invoke")

	local texture = SML:Fetch("statusbar", profile.texture)
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

	backdropTable.insets = { left = inset, right = inset, top = inset, bottom = inset }
	backdropTable.edgeFile = edgeFile
	backdropTable.bgFile = texture

	-- ChatFrame7:AddMessage("AloftManaBar:SetupBar(): set backdrop " .. tostring(backdropTable.edgeFile))
	manaBar:SetBackdrop(backdropTable)
	manaBar:SetBackdropBorderColor(unpack(profile.borderColor))
	manaBar:SetBackdropColor(unpack(profile.backdropColor))

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
		manaBar:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", profile.offsets.left - inset, profile.offsets.vertical + inset)
		manaBar:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", profile.offsets.right + inset, profile.offsets.vertical - profile.height - inset)
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

function AloftManaBar:Update(aloftData)
	-- ChatFrame7:AddMessage("ManaBar:Update(): enter")
	if aloftData.mana and aloftData.maxMana and aloftData.maxMana > 0 then
		-- ChatFrame7:AddMessage("ManaBar:Update(): update " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.powerType) .. "/" .. tostring(aloftData.unitid) .. "/".. tostring(aloftData.maxMana))
		local manaBar = self:AcquireManaBar(aloftData)
		local color = profile.powerTypeColors[aloftData.powerType]
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

function AloftManaBar:OnNameplateShow(aloftData)
	-- ChatFrame7:AddMessage("AloftManaBar:OnNameplateShow(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	if aloftData.isTarget or aloftData:IsTarget() then
		local eventName = "AloftManaBar:OnNameplateShow: " .. tostring(math.random(1,1000000000))
		self:ScheduleEvent(eventName, self.Update, 0.00, self, aloftData) -- next frame
	else
		self:Update(aloftData) -- update immediately
	end
end

function AloftManaBar:OnNameplateHide(aloftData)
	-- ChatFrame7:AddMessage("AloftManaBar:OnNameplateHide(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:ReleaseManaBar(aloftData)
end

function AloftManaBar:OnIsTargetDataChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftManaBar:OnIsTargetDataChanged(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	local eventName = "AloftManaBar:OnIsTargetDataChanged: " .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.Update, 0.1, self, aloftData) -- next frame
end

-----------------------------------------------------------------------------

end)
