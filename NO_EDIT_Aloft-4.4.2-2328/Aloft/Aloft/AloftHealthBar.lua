local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftFrame = Aloft:GetModule("Frame") -- always on
if not AloftFrame then return end

local AloftOverlay = Aloft:GetModule("Overlay") -- always on
if not AloftOverlay then return end

local AloftHealthBar = Aloft:NewModule("HealthBar", Aloft, "AceEvent-3.0", "AceTimer-3.0")

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftHealthBar.namespace = "healthBar"
AloftHealthBar.defaults =
{
	profile =
	{
		texture				= "Blizzard",
		tileHoriz			= false,
		height				= 11,
		alpha				= 1.0,
		colorByClass		= true,
		colorHostileByClass = true,
		targetOnly			= true,
		border				= "None",
		borderEdgeSize		= 16,
		borderInset			= 4,
		borderColor			= { 1, 1, 1, 1 },
		width				= 115,
		height				= 11,
		offsets =
		{
			left			= 0,
			right			= 0,
			vertical		= 0,
		},
		colorFormat			= "",
		colors =
		{
			backdropColor	= { 0.25, 0.25, 0.25, 0.5 },
			friendlyPlayer	= { 0, 0, 1 },
			friendlyPet		= { 0, 1, 0 },
			friendlyNPC		= { 0, 1, 0 },
			friendlyBoss	= { 0, 1, 0 },
			hostilePlayer	= { 1, 0, 0 },
			hostilePet		= { 1, 0, 0 },
			hostileNPC		= { 1, 0, 0 },
			hostileBoss		= { 1, 0, 0 },
			neutral			= { 1, 1, 0 },
			pet				= { 0, 1, 0 },
			groupPet		= { 0, 1, 0 },
			unknown			= { 0.5, 0.5, 0.5 },
		},
		deficit = false,
	},
}

-----------------------------------------------------------------------------

AloftHealthBar.colorMethod = nil
AloftHealthBar.colorMethodData = { }

-----------------------------------------------------------------------------

-- backdrop table for initializing visible nameplates
local backdropTable =
{
	-- tile = true,
	-- tileSize = 16,
	bgFile = nil,
	edgeSize = 16,
	edgeFile = nil,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

-- backdrop table for resetting nameplates when they are hidden
local defaultBackdropTable =
{
	-- tile = true,
	-- tileSize = 0,
	bgFile = nil,
	-- edgeSize = 0,
	edgeFile = nil,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

-- local backdropTable =
-- {
--	edgeSize = 16,
--	insets = { left = 4, right = 4, top = 4, bottom = 4 },
--
--	edgeFile = [[Interface\Addons\Aloft\Textures\krsnik]],
--	bgFile = [[Interface\Addons\SharedMedia\statusbar\Minimalist]],
-- }
--
-- frame:SetBackdrop(backdropTable)
-- frame:SetBackdropBorderColor(R, G, B, A)

-----------------------------------------------------------------------------

local CreateFrame = CreateFrame

-----------------------------------------------------------------------------

function AloftHealthBar:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftHealthBar:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UpdateAll()
	self:UpdateSizesAll()
end

function AloftHealthBar:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	defaultBackdropTable.bgFile = ""

	for aloftData in Aloft:IterateNameplates() do
		local healthBar = aloftData.healthBar

		healthBar:ClearAllPoints()
		healthBar:SetPoint("BOTTOMLEFT", aloftData.nameplateFrame, "BOTTOMLEFT", 4.5, 4.5)
		healthBar:SetWidth(116.5)
		healthBar:SetHeight(10.18)
		healthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		healthBar:SetStatusBarColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB)
		healthBar:SetBackdrop(defaultBackdropTable)
		healthBar:SetBackdropColor(0, 0, 0, 0)

		self:ReleaseHealthFrame(aloftData)
		aloftData.healthBar:Show()
	end
end

-----------------------------------------------------------------------------

function AloftHealthBar:UpdateAll()
	-- ChatFrame7:AddMessage("AloftHealthBar:UpdateAll(): enter")
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateShow("AloftHealthBar:UpdateAll", aloftData)
	end
	-- ChatFrame7:AddMessage("AloftHealthBar:UpdateAll(): exit")
end

function AloftHealthBar:UpdateSizesAll()
	--[[
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateShow("AloftHealthBar:UpdateSizesAll", aloftData)
	end
	]]

	AloftFrame:UpdateAll()
	AloftOverlay:UpdateAll()

	self:UpdateAll()
end

-----------------------------------------------------------------------------

local dataRequiredList = { }
function AloftHealthBar:RequiresData()
	if self.db.profile.colorFormat and self.db.profile.colorFormat ~= "" and (not self.colorMethodData or not self.colorMethod) then
		self.colorMethodData = Aloft:CreateTag(self.db.profile.colorFormat, true)
		self.colorMethod = self.colorMethodData.method
	end

	self:RegisterEvents()

	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	if self.db.profile.colorByClass or -- both friendly and hostile class discovery is of interest
	   self.db.profile.colorHostileByClass or
	   not self:IsArrayEqual(self.db.profile.colors.hostileNPC, self.db.profile.colors.hostilePlayer) then
		-- ChatFrame7:AddMessage("AloftHealthBar:RequiresData(): class")
		table.insert(dataRequiredList, "class")
	end

	if not self:IsArrayEqual(self.db.profile.colors.friendlyPet, self.db.profile.colors.friendlyNPC) or
	   not self:IsArrayEqual(self.db.profile.colors.hostilePet, self.db.profile.colors.hostileNPC) then
		table.insert(dataRequiredList, "isPet")
		table.insert(dataRequiredList, "petOwnersName")
	end

	if Aloft:IsDataAvailable("unitid") and not self:IsArrayEqual(self.db.profile.colors.friendlyPet, self.db.profile.colors.groupPet) then
		table.insert(dataRequiredList, "unitid")
	end

	if self.colorMethodData and self.colorMethodData.data then
		for data in pairs(self.colorMethodData.data) do
			table.insert(dataRequiredList, data)
		end
	end

	return unpack(dataRequiredList)
end

function AloftHealthBar:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile then
		self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
		self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
		self:RegisterMessage("Aloft:OnHealthBarValueChanged", "Update")
		self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("Aloft:OnSetHealthBarColor", "OnSetHealthBarColor")
		self:RegisterMessage("Aloft:OnHealthBarColorChanged", "OnHealthBarColorChanged")
		self:RegisterMessage("Aloft:OnUnitidDataChanged", "OnUnitidDataChanged")

		self:RegisterMessage("SharedMedia_SetGlobal", function(message, mediatype, override)
			if mediatype == "statusbar" then
				self:UpdateAll()
			end
		end)

		self:RegisterMessage("Aloft:SetAll", function(message, type, value)
			if AloftHealthBar.db.profile[type] then
				AloftHealthBar.db.profile[type] = value
				AloftHealthBar:UpdateAll()
			end
		end)

		if self.db.profile.border ~= "None" and self.db.profile.targetOnly then
			-- ChatFrame7:AddMessage("AloftHealthBar:RegisterEvents(): register Aloft:OnIsTargetDataChanged")
			self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
		end

		if self.db.profile.colorByClass or -- both friendly and hostile class discovery is of interest
		   self.db.profile.colorHostileByClass then
			self:RegisterMessage("Aloft:OnClassDataChanged", "OnClassDataChanged")
		end

		if not self:IsArrayEqual(self.db.profile.colors.friendlyPet, self.db.profile.colors.friendlyNPC) or
		   not self:IsArrayEqual(self.db.profile.colors.hostilePet, self.db.profile.colors.hostileNPC) then
			self:RegisterMessage("Aloft:OnIsPetDataChanged", "Update")
		end

		if self.colorMethodData and self.colorMethodData.events then
			for events in pairs(self.colorMethodData.events) do
				-- ChatFrame7:AddMessage("AloftHealthBar:RegisterEvents(): register event " .. events)
				self:RegisterMessage(events, "Update")
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftHealthBar:AcquireHealthFrame(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:AcquireHealthFrame(): acquire " .. aloftData.name)
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	if not layoutFrame then
		ChatFrame7:AddMessage("AloftHealthBar:AcquireHealthFrame(): no layoutFrame " .. tostring(aloftData.name))
		ChatFrame7:AddMessage("AloftHealthBar:AcquireHealthFrame(): " .. debugstack())
	end

	local healthFrame = layoutFrame.healthFrame
	if not healthFrame then
		healthFrame = CreateFrame("Frame", nil, layoutFrame)

		layoutFrame.healthFrame = healthFrame
		healthFrame.layoutFrame = layoutFrame
	end

	self:SetupFrame("AloftHealthBar:AcquireHealthFrame", aloftData)

	return healthFrame
end

function AloftHealthBar:GetBorder(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:GetBorder(): " .. tostring(aloftData and aloftData.name) .. "/" .. tostring(aloftData and aloftData.isTarget) .. "/" .. tostring(aloftData and aloftData:IsTarget()))
	if not self.db.profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		return ((self.db.profile.border ~= "None") and self.db.profile.borderInset) or 0, SML:Fetch("border", self.db.profile.border)
		-- return 0, SML:Fetch("border", "None")
	else
		return 0, nil
	end
end

function AloftHealthBar:SetupFrame(message, aloftData)
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	if not layoutFrame then
		ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): no layoutFrame " .. tostring(aloftData.name))
		ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): " .. debugstack())
	end

	local nameplateFrame = aloftData.nameplateFrame
	local healthBar = aloftData.healthBar

	-- we do this much to insure that the Blizzard-managed mouseover highlight region is correctly sized
	healthBar:ClearAllPoints()
	healthBar:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", self.db.profile.offsets.left, self.db.profile.offsets.vertical)
	healthBar:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", self.db.profile.offsets.right, self.db.profile.offsets.vertical - self.db.profile.height)
	healthBar:SetFrameLevel(nameplateFrame:GetFrameLevel())

	-- then, we hide the default health bar; StatusBar fill texture clipping and backdrop inset functionality is broken as of WoW 3.3.3
	-- health bar is currently supplied via AloftHealthBar.lua
	healthBar:Hide()

	local healthFrame = layoutFrame.healthFrame
	if healthFrame then
		local texture = SML:Fetch("statusbar", self.db.profile.texture)
		local inset, edgeFile = self:GetBorder(aloftData)

		healthFrame:ClearAllPoints()
		healthFrame:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", self.db.profile.offsets.left - inset, self.db.profile.offsets.vertical + inset)
		healthFrame:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", self.db.profile.offsets.right + inset, self.db.profile.offsets.vertical - self.db.profile.height - inset)
		healthFrame:SetFrameLevel(nameplateFrame:GetFrameLevel())
		healthFrame:Show()

		local healthRegion = healthFrame.healthRegion
		if not healthRegion then
			healthRegion = healthFrame:CreateTexture(nil, "ARTWORK")
			healthRegion:SetBlendMode("BLEND")
			healthFrame.healthRegion = healthRegion
		end
		healthRegion:SetTexture(texture)

		-- set horizontal tiling
		if self.db.profile.tileHoriz then
			healthRegion:SetHorizTile(true)
		else
			healthRegion:SetHorizTile(false)
		end
		-- healthRegion:SetVertTile(true) -- currently disabled; TODO: add an option for this as well
		-- ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): tile " .. tostring(healthRegion:GetVertTile()) .. "/" .. tostring(healthRegion:GetHorizTile()))

		-- glue the right of the health region to the right of the deficit frame, we want motion on the left edge of this region; adjusting for the inset is handled by adjusting the width
		healthRegion:ClearAllPoints()
		if self.db.profile.deficit then
			-- deficit mode
			healthRegion:SetPoint("TOPRIGHT", healthFrame, "TOPRIGHT", -inset, -inset)
			healthRegion:SetPoint("BOTTOMRIGHT", healthFrame, "BOTTOMRIGHT", -inset, inset)

			healthRegion:SetWidth(0)
			-- ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): width " .. tostring(0))
			healthRegion:Hide()
		else
			-- normal mode
			healthRegion:SetPoint("TOPLEFT", healthFrame, "TOPLEFT", inset, -inset)
			healthRegion:SetPoint("BOTTOMLEFT", healthFrame, "BOTTOMLEFT", inset, inset)

			local width = self:CalculateFrameWidth(aloftData, healthFrame)
			if width then healthRegion:SetWidth(width) end
			-- ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): width " .. tostring(width))
			healthRegion:Show()
		end
		-- ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): health " .. healthRegion:GetDrawLayer())

		-- healthRegion:SetWidth(0)
		-- healthRegion:Hide()

		-- backdropTable.tile = true
		backdropTable.insets.left = inset
		backdropTable.insets.right = inset
		backdropTable.insets.top = inset
		backdropTable.insets.bottom = inset
		backdropTable.edgeFile = edgeFile
		backdropTable.edgeSize = self.db.profile.borderEdgeSize
		backdropTable.bgFile = texture

		-- ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): " .. tostring(inset) .. "/" .. tostring(backdropTable.bgFile) .. "/" .. tostring(backdropTable.edgeFile).. "/" .. tostring(backdropTable.tile).. "/" .. tostring(backdropTable.tileSize))

		-- NOTE: this dead code is relevant to various #132 crash experiments 
		-- healthFrame:SetBackdrop( { insets = { left = inset, right = inset, top = inset, bottom = inset, }, edgeFile = edgeFile, edgeSize = 16, bgFile = texture, } )
		-- if not self.db.profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
			-- healthFrame:SetBackdrop( { insets = { left = 4, right = 4, top = 4, bottom = 4, },
			--							edgeSize = 16, edgeFile = [[Interface\Addons\Aloft\Textures\krsnik]],
			--							bgFile = [[Interface\AddOns\Forte_Core\Textures\Minimalist]], } )
			-- healthFrame:SetBackdrop( { insets = { left = 4, right = 4, top = 4, bottom = 4, },
			--							edgeSize = 16, edgeFile = [[Interface\Addons\Aloft\Textures\krsnik]],
			--							bgFile = [[Interface\AddOns\Forte_Core\Textures\Minimalist]], } )
		-- else
			-- healthFrame:SetBackdrop( { insets = { left = 0, right = 0, top = 0, bottom = 0, },
			--							edgeSize = 16, edgeFile = nil,
			--							bgFile = [[Interface\AddOns\Forte_Core\Textures\Minimalist]], } )
		-- end

		healthFrame:SetBackdrop(backdropTable)
		healthFrame:SetBackdropColor(unpack(self.db.profile.colors.backdropColor))
		healthFrame:SetBackdropBorderColor(unpack(self.db.profile.borderColor))
		-- healthFrame:SetAlpha(aloftData.nameplateFrame:GetAlpha())

		-- This manipulates the healthbar background to always display above the frame background
		-- ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): deficit #regions " .. healthFrame:GetNumRegions())
		local _, backgroundRegion = healthFrame:GetRegions()

		backgroundRegion:SetDrawLayer("BACKGROUND")
		backgroundRegion:SetBlendMode("BLEND")
		-- backgroundRegion:SetHorizTile(true)
		-- backgroundRegion:SetVertTile(true)
		backgroundRegion:Show()

		-- ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): backdrop " .. tostring(aloftData.name) .. "/" .. tostring(layoutFrame:GetWidth()) .. "/" .. tostring(layoutFrame:GetHeight()))
		-- ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): health " .. tostring(aloftData.name) .. "/" .. tostring(inset) .. "/" .. tostring(healthFrame:GetWidth()) .. "/" .. tostring(healthFrame:GetHeight()))
	end
end

function AloftHealthBar:ReleaseHealthFrame(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:ReleaseHealthFrame(): release " .. aloftData.name)
	self:CleanupHealthFrame(aloftData)
	self:RePoolHealthFrame(aloftData)
end

function AloftHealthBar:CleanupHealthFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local healthFrame = layoutFrame and layoutFrame.healthFrame
	if healthFrame then
		self:ClearBackdrop(healthFrame)
		-- if healthFrame.healthRegion then healthFrame.healthRegion:Hide() end
	end
end

function AloftHealthBar:RePoolHealthFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local healthFrame = layoutFrame and layoutFrame.healthFrame
	if healthFrame then
		healthFrame:Hide()
	end
end

function AloftHealthBar:ClearBackdrop(healthFrame)
	if healthFrame then
		healthFrame:SetBackdropColor(0, 0, 0, 0)
		healthFrame:SetBackdropBorderColor(0, 0, 0, 0)

		-- NOTE: doing this on nameplate hide may case #132 crashes
		-- healthFrame:SetBackdrop(defaultBackdropTable)
	end
end

function AloftHealthBar:SyncNameplateHealthColor(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:SyncNameplateHealthColor(): " .. aloftData.name .. " rgb = " .. aloftData.healthBarR .. "/" .. aloftData.healthBarG .. "/" .. aloftData.healthBarB)
	self:SetAtomicHealthFrameColors(aloftData, aloftData.healthBarR, aloftData.healthBarG, aloftData.healthBarB, self.db.profile.alpha)
end

function AloftHealthBar:SetHealthFrameColor(aloftData, color)
	self:SetAtomicHealthFrameColors(aloftData, color[1], color[2], color[3], self.db.profile.alpha)
end

function AloftHealthBar:SetAtomicHealthFrameColors(aloftData, hbr, hbg, hbb, hba)
	local layoutFrame = aloftData.layoutFrame
	local healthFrame = layoutFrame and layoutFrame.healthFrame
	local healthRegion = healthFrame and healthFrame.healthRegion
	if healthRegion then
		-- local r, g, b, a = self:GetSemiQuasiPseudoComplementColor(hbr, hbg, hbb, hba)
		local r, g, b, a = hbr, hbg, hbb, hba
		healthRegion:SetVertexColor(r, g, b, a)

		-- read these back in; apparently the concern is that there is rounding error
		aloftData.healthBarR, aloftData.healthBarG, aloftData.healthBarB, aloftData.healthBarA = healthRegion:GetVertexColor()
	end
end

-----------------------------------------------------------------------------

function AloftHealthBar:OnNameplateShow(message, aloftData)
	-- self:ScheduleTimer(function(aloftData) AloftHealthBar:DoNameplateShow(aloftData) end, 0.0, aloftData) -- next frame
	self:AcquireHealthFrame(aloftData)
	self:Update(message, aloftData)
end

function AloftHealthBar:OnNameplateHide(message, aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:OnNameplateHide(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:ReleaseHealthFrame(aloftData)
end

function AloftHealthBar:OnClassDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:OnClassDataChanged(): invoke")
	self:Update(message, aloftData)
end

function AloftHealthBar:OnHealthBarColorChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:OnHealthBarColorChanged(): invoke")
	self:Update(message, aloftData)
end

function AloftHealthBar:OnUnitidDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:OnUnitidDataChanged(): invoke")
	self:Update(message, aloftData)
end

function AloftHealthBar:OnIsTargetDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:OnIsTargetDataChanged(): " .. tostring(aloftData) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(aloftData.nameplateFrame:GetAlpha()) .. "/" .. tostring(aloftData.isTarget) .. "/" .. tostring(aloftData:IsTarget()))
	self:ScheduleTimer(function(aloftData) AloftHealthBar:DoNameplateShow(aloftData) end, 0.1, aloftData) -- next frame
end

function AloftHealthBar:OnSetHealthBarColor(message, aloftData)
	self:SyncNameplateHealthColor(aloftData) -- this actually changes the health bar color
end

-----------------------------------------------------------------------------

function AloftHealthBar:DoNameplateShow(aloftData)
	-- self:AcquireHealthFrame(aloftData)
	-- self:Update(message, aloftData)
	self:OnNameplateShow("AloftHealthBar:DoNameplateShow", aloftData)
end

-----------------------------------------------------------------------------

function AloftHealthBar:SetHealthBarColor(aloftData, color)
	self:SetHealthBarColors(aloftData, color[1], color[2], color[3])
end

function AloftHealthBar:SetHealthBarColors(aloftData, r, g, b)
	-- ChatFrame7:AddMessage("AloftHealthBar:SetHealthBarColors(): " .. aloftData.name .. "/rgb = " .. r .. "." .. g .. "." .. b)
	aloftData.healthBarR = r
	aloftData.healthBarG = g
	aloftData.healthBarB = b
	aloftData.healthBarA = self.db.profile.alpha
	-- aloftData.healthBar:SetStatusBarColor(r, g, b, self.db.profile.alpha)

	--[[
	local rr, rg, rb, ra = aloftData.healthBar:GetStatusBarColor()
	local br, bg, bb, ba = aloftData.healthBar:GetBackdropColor()
	ChatFrame7:AddMessage("AloftHealthBar:SetHealthBarColors(): health " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.healthBar:GetAlpha())
		.. "|" .. tostring(rr) .. "-" .. tostring(rg) .. "-" .. tostring(rb) .. "-" .. tostring(ra)
			.. "/" .. floor(255*rr) .. "." .. floor(255*rg) .. "." .. floor(255*rb) .. "." .. floor(255*ra)
			.. "/" .. ("|c%02x%02x%02x%02xbar color|r"):format(floor(255*ra), floor(255*rr), floor(255*rg), floor(255*rb))
		.. "|" .. tostring(br) .. "-" .. tostring(bg) .. "-" .. tostring(bb) .. "-" .. tostring(ba)
			.. "/" .. floor(255*br) .. "." .. floor(255*bg) .. "." .. floor(255*bb) .. "." .. floor(255*ba)
			.. "/" .. ("|c%02x%02x%02x%02xbkg color|r"):format(floor(255*ba), floor(255*br), floor(255*bg), floor(255*bb)))
	]]

	self:SendMessage("Aloft:OnSetHealthBarColor", aloftData) -- this flags to everything that the health bar color has changed; no delay is necessary here

	-- self:ScheduleTimer(function(aloftData) AloftHealthBar:UpdateHealthBarColor(aloftData) end, 0.0, aloftData) -- next frame
	-- self:SyncNameplateHealthColor(aloftData)
end

--[[
function AloftHealthBar:UpdateHealthBarColor(aloftData)
	self:SendMessage("Aloft:OnSetHealthBarColor", aloftData)
end
]]

function AloftHealthBar:ColourFriendlyPlayer(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:ColourFriendlyPlayer(): invoke " .. aloftData.name)
	if self.db.profile.colorByClass and aloftData.class then
		local color = Aloft.db.profile.classColors[aloftData.class]
		-- ChatFrame7:AddMessage("AloftHealthBar:ColourFriendlyPlayer(): class " .. aloftData.name .. "/" .. class)
		if color then
			-- aloftData.healthBar:SetStatusBarColor(color.r, color.g, color.b, self.db.profile.alpha)
			-- ChatFrame7:AddMessage("AloftHealthBar:ColourFriendlyPlayer(): color " .. aloftData.name)
			self:SetHealthBarColor(aloftData, color)
			return
		end
	end

	-- ChatFrame7:AddMessage("AloftHealthBar:ColourFriendlyPlayer(): color default " .. aloftData.name)
	self:SetHealthBarColor(aloftData, self.db.profile.colors.friendlyPlayer)
end

function AloftHealthBar:ColourFriendlyNPC(aloftData)
	-- Could be player pet, group pet, friendly pet, friendlyBoss, or friendlyNPC
	if aloftData.name == UnitName("pet") then
		self:SetHealthBarColor(aloftData, self.db.profile.colors.pet)
	elseif aloftData.unitid then
		self:SetHealthBarColor(aloftData, self.db.profile.colors.groupPet)
	elseif aloftData.isPet or aloftData.petOwnersName then
		self:SetHealthBarColor(aloftData, self.db.profile.colors.friendlyPet)
	elseif aloftData.isBoss then
		self:SetHealthBarColor(aloftData, self.db.profile.colors.friendlyBoss)
	else
		self:SetHealthBarColor(aloftData, self.db.profile.colors.friendlyNPC)
	end
end

function AloftHealthBar:ColourHostile(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:ColourHostile(): invoke " .. aloftData.name)
	-- player, hostile pet, hostile boss, hostileNPC

	-- ChatFrame7:AddMessage("AloftHealthBar:ColourHostile(): color default " .. aloftData.name)
	local class = aloftData.class
	if class then
		local color = Aloft.db.profile.classColors[aloftData.class]
		if self.db.profile.colorHostileByClass and color then
			self:SetHealthBarColor(aloftData, color)
			-- ChatFrame7:AddMessage("AloftHealthBar:ColourHostile(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.class))
		else
			self:SetHealthBarColor(aloftData, self.db.profile.colors.hostilePlayer)
			-- ChatFrame7:AddMessage("AloftHealthBar:ColourHostile(): " .. class hostile " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.class))
		end
	elseif Aloft:IsTotem(aloftData) then
		local color = (Aloft.GetTotemExceptionColor and Aloft:GetTotemExceptionColor(aloftData)) or self.db.profile.colors.hostileNPC
		-- ChatFrame7:AddMessage("AloftHealthBar:ColourHostile(): " .. tostring(aloftData.name) .. "/" ..("|cff%02x%02x%02xcolor|r"):format(floor(255*color[1]), floor(255*color[2]), floor(255*color[3])))
		self:SetHealthBarColor(aloftData, color)
	elseif aloftData.isPet or aloftData.petOwnersName then
		self:SetHealthBarColor(aloftData, self.db.profile.colors.hostilePet)
	elseif aloftData.isBoss then
		self:SetHealthBarColor(aloftData, self.db.profile.colors.hostileBoss)
	else
		self:SetHealthBarColor(aloftData, self.db.profile.colors.hostileNPC)
	end
end

function AloftHealthBar:ColourNeutral(aloftData)
	local class = aloftData.class
	if class then
		local color = Aloft.db.profile.classColors[aloftData.class]
		if self.db.profile.colorHostileByClass and color then
			self:SetHealthBarColor(aloftData, color)
			-- ChatFrame7:AddMessage("AloftHealthBar:ColourNeutral(): " .. class " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.class))
		else
			self:SetHealthBarColor(aloftData, self.db.profile.colors.hostilePlayer)
			-- ChatFrame7:AddMessage("AloftHealthBar:ColourNeutral(): " .. class hostile " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.class))
		end
	elseif Aloft:IsTotem(aloftData) then
		local color = (Aloft.GetTotemExceptionColor and Aloft:GetTotemExceptionColor(aloftData)) or self.db.profile.colors.neutral
		-- ChatFrame7:AddMessage("AloftHealthBar:ColourHostile(): " .. tostring(aloftData.name) .. "/" ..("|cff%02x%02x%02xcolor|r"):format(floor(255*color[1]), floor(255*color[2]), floor(255*color[3])))
		self:SetHealthBarColor(aloftData, color)
	else
		self:SetHealthBarColor(aloftData, self.db.profile.colors.neutral)
		-- ChatFrame7:AddMessage("AloftHealthBar:ColourNeutral(): neutral " .. tostring(aloftData.name))
	end
end

function AloftHealthBar:ColourUnknown(aloftData)
	-- local r, g, b = aloftData.healthBar:GetStatusBarColor()

	-- aloftData.healthBar:SetStatusBarColor(r, g, b, self.db.profile.alpha) -- no longer a status bar
	-- self:SetHealthBarColors(aloftData, r, g, b) -- Thortok2000 wants his "Unknown" color :-)
	self:SetHealthBarColor(aloftData, self.db.profile.colors.unknown)
	-- ChatFrame7:AddMessage("AloftHealthBar:ColourUnknown(): " .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:IsVisible()))
end

local healthBarMethods =
{
	["friendlyPlayer"]	= AloftHealthBar.ColourFriendlyPlayer,
	["friendlyNPC"]		= AloftHealthBar.ColourFriendlyNPC,
	["hostile"]			= AloftHealthBar.ColourHostile,
	["hostilePlayer"]	= AloftHealthBar.ColourHostile,
	["neutral"]			= AloftHealthBar.ColourNeutral,
	["unknown"]			= AloftHealthBar.ColourUnknown,
}

-----------------------------------------------------------------------------

function AloftHealthBar:CalculateFrameWidth(aloftData, healthFrame)
	local width
	if aloftData.healthBarValue and aloftData.healthBarMaxValue then
		local inset, _ = self:GetBorder(aloftData)

		local value = (self.db.profile.deficit and (aloftData.healthBarMaxValue - aloftData.healthBarValue)) or aloftData.healthBarValue
		width = (value / aloftData.healthBarMaxValue) * (healthFrame:GetWidth() - (2 * inset))
	end

	return width
end

function AloftHealthBar:Update(message, aloftData)
	if not aloftData then return end

	local layoutFrame = aloftData.layoutFrame
	local healthFrame = (layoutFrame and layoutFrame.healthFrame) or self:AcquireHealthFrame(aloftData)
	local healthRegion = healthFrame and healthFrame.healthRegion

	if healthFrame and healthRegion then
		local width = self:CalculateFrameWidth(aloftData, healthFrame)
		if width then
			if width > 0 then
				healthRegion:SetWidth(width)
				-- ChatFrame7:AddMessage("AloftHealthBar:Update(): " .. tostring(aloftData.name) .. "/" .. tostring(width))
				healthRegion:Show()
			else
				healthRegion:SetWidth(0)
				-- ChatFrame7:AddMessage("AloftHealthBar:Update(): " .. tostring(aloftData.name) .. "/" .. tostring(0))
				healthRegion:Hide()
			end
		end
		healthFrame:Show()
	end

	if self.db.profile.colorFormat and self.db.profile.colorFormat ~= "" and (not self.colorMethodData or not self.colorMethod) then
		self.colorMethodData = Aloft:CreateTag(self.db.profile.colorFormat, true)
		self.colorMethod = self.colorMethodData.method
		-- ChatFrame7:AddMessage("AloftHealthBar:Update(): establish color method")
	end
	--[[
	if self.colorMethodData then
		ChatFrame7:AddMessage("AloftHealthBar:Update(): functionString " .. tostring(self.colorMethodData.functionString))
	end
	]]

	local override = (self.colorMethod and self.colorMethod(aloftData)) or nil
	if override and #override >= 6 then
		-- ChatFrame7:AddMessage("AloftHealthBar:Update(): color override " .. tostring(aloftData) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(aloftData.nameplateFrame:GetAlpha()) .. "/" .. tostring(aloftData.isTarget) .. "/" .. tostring(aloftData:IsTarget()) .. "/" .. tostring(self.colorMethodData.functionString))
		local rhex, ghex, bhex = override:sub(1, 2), override:sub(3, 4), override:sub(5, 6)
		local color = { tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255 }
		self:SetHealthBarColor(aloftData, color)
		-- aloftData.healthBar:SetStatusBarColor(tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255, self.db.profile.alpha)
	elseif not aloftData.noGlow then -- coordinate with nameplate glow processing; when we are not using a glow, we surrender control over health bar colors of targets with threat to the glow module
		local unitType = aloftData.type
		-- ChatFrame7:AddMessage("AloftHealthBar:Update(): color type " .. aloftData.name .. "/" .. unitType)
		healthBarMethods[unitType](self, aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftHealthBar:GetSemiQuasiPseudoComplementColor(r, g, b, a)
	local cr = 1.0 - r
	local cg = 1.0 - g
	local cb = 1.0 - b
	local ca = a

	return cr, cg, cb
end

-----------------------------------------------------------------------------
