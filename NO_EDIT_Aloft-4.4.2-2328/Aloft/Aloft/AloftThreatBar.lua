local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

local AloftThreatData = Aloft:GetModule("ThreatData", true)
if not AloftThreatData then return end

local AloftThreatBar = Aloft:NewModule("ThreatBar", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftThreatBar.dynamic = "AloftThreat"

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftThreatBar.namespace = "threatBar"
AloftThreatBar.defaults =
{
	profile =
	{
		enable				= false,
		activeWhileSolo		= true,
		gainEnable			= true,
		texture				= "Blizzard",
		height				= 4,
		incremental			= true,
		targetOnly			= true,
		border				= "None",
		borderEdgeSize		= 16,
		borderInset			= 4,
		borderColor			= { 1, 1, 1, 1 },
		backdropColor		= { 0.25, 0.25, 0.25, 0.5 },
		flashEnable			= true,
		flashInvert			= false,
		flashThreshold		= 90,
		flashColor			= { 0.0, 0.0, 1.0, 1.0 }, -- blue
		-- flashStyle			= "THRQTRSOFT",
		flashStyle			= "3/4 Soft Outline",
		flashBlendMode		= "BLEND",
		flashWidth			= 123,
		flashHeight			= 18,
		flashOffsetX		= 0,
		flashOffsetY		= 2,
		commonThreatColor	= { 1.0, 1.0, 0.0, 1.0 }, -- yellow
		threatGainColor		= { 1.0, 0.5, 0.0, 1.0 }, -- orange
		maximumThreatColor	= { 1.0, 0.0, 0.0, 1.0 }, -- red
		offsets =
		{
			left			= 0,
			right			= 0,
			vertical		= -17,
		},
	},
}

-----------------------------------------------------------------------------

local unpack = unpack
local GetNumPartyMembers = GetNumPartyMembers
local GetNumRaidMembers = GetNumRaidMembers

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

local BORDER_INIT_ATTEMPTS = 2

-----------------------------------------------------------------------------

function AloftThreatBar:IsGrouped()
	return (GetNumPartyMembers() + GetNumRaidMembers()) > 0
end

-- NOTE: need to name this something other than "IsEnabled()", since Ace3 uses that
function AloftThreatBar:IsActive()
	return self:IsEnabled() and self.db and self.db.profile and self.db.profile.enable and (self:IsGrouped() or self.db.profile.activeWhileSolo)
end

----------------------------------------------------------------------------

function AloftThreatBar:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if self:IsActive() then
			--if aloftData.threatBar then
				-- ChatFrame7:AddMessage("AloftThreatBar:UpdateAll(): threat bar " .. aloftData.name)
				--self:SetupThreatBar(aloftData, aloftData.threatBar)
				--self:PlaceThreatBar(aloftData)
			--end
			--if aloftData.flashFrame then
				-- ChatFrame7:AddMessage("AloftThreatBar:UpdateAll(): flash frame " .. aloftData.name)
				--self:SetupFlashFrame(aloftData.flashFrame)
				--self:PlaceFlashFrame(aloftData)
			--end
			self:Update("AloftThreatBar:UpdateAll", aloftData)
		else
			-- ChatFrame7:AddMessage("AloftThreatBar:UpdateAll(): release " .. aloftData.name)
			self:ReleaseThreatBar(aloftData)
			self:ReleaseFlashFrame(aloftData)
		end
	end
	if self:IsActive() then
		for layoutFrame in pairs(Aloft.layoutFramePool) do
			local threatBar = layoutFrame.threatBar
			if threatBar then
				self:SetupThreatBar(nil, threatBar)
				threatBar:Hide()
			end

			local flashFrame = layoutFrame.flashFrame
			if flashFrame then
				self:SetupFlashFrame(flashFrame)
				flashFrame:Hide()
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftThreatBar:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self:IsActive() then
		self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
		self:RegisterMessage("Aloft:OnThreatDataChanged", "Update")
		self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
	end

	self:RegisterMessage("SharedMedia_SetGlobal", function(message, mediatype, override)
		if mediatype == "statusbar" then
			AloftThreatBar:UpdateAll()
		end
	end)

	self:RegisterMessage("Aloft:SetAll", function(message, type, value)
		if AloftThreatBar.db.profile[type] then
			AloftThreatBar.db.profile[type] = value
			AloftThreatBar:UpdateAll()
		end
	end)
end

function AloftThreatBar:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftThreatBar:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:RegisterEvents()
	self:UpdateAll()
end

function AloftThreatBar:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:ReleaseThreatBar(aloftData)
		self:ReleaseFlashFrame(aloftData)
	end
end

function AloftThreatBar:RequiresData()
	self:RegisterEvents()
	if self:IsActive() then
		return "threat", "maxThreat", "maxThreatGain"
	end
end

-----------------------------------------------------------------------------

function AloftThreatBar:NeedsBorder(aloftData)
	if not self.db.profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		-- ChatFrame7:AddMessage("AloftThreatBar:NeedsBorder(): border " .. tostring(self.db.profile.border))
		return self.db.profile.border ~= "None"
	end
	return nil
end

function AloftThreatBar:GetBorder(aloftData)
	if not self.db.profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		-- ChatFrame7:AddMessage("AloftThreatBar:GetBorder(): border " .. tostring(self.db.profile.border))
		return ((self.db.profile.border ~= "None") and self.db.profile.borderInset) or 0, SML:Fetch("border", self.db.profile.border)
		-- return 0, SML:Fetch("border", "None")
	else
		return 0, SML:Fetch("border", "None")
	end
end

function AloftThreatBar:SetupThreatBar(aloftData, threatBar)
	-- ChatFrame7:AddMessage("AloftThreatBar:SetupThreatBar(): invoke")

	-- we only need to go through this rigamarole once
	if not threatBar or (threatBar.init and threatBar.init >= BORDER_INIT_ATTEMPTS) then return end

	local texture = SML:Fetch("statusbar", self.db.profile.texture)
	local inset, edgeFile = self:GetBorder(aloftData)

	local threatRegion = threatBar.threatRegion
	if not threatRegion then
		threatRegion = threatBar:CreateTexture(nil, "ARTWORK")
		threatRegion:SetBlendMode("BLEND")
		threatBar.threatRegion = threatRegion
	end
	threatRegion:SetTexture(texture)

	-- glue the left of the threat region to the left of the threat bar frame, we want motion on the right edge of this region; TODO: see if this can be done once
	threatRegion:ClearAllPoints()
	threatRegion:SetPoint("TOPLEFT", threatBar, "TOPLEFT", inset, -inset)
	threatRegion:SetPoint("BOTTOMLEFT", threatBar, "BOTTOMLEFT", inset, inset)
	threatRegion:Hide()
	-- ChatFrame7:AddMessage("AloftThreatBar:SetupThreatBar(): threat " .. threatRegion:GetDrawLayer())

	local gainRegion = threatBar.gainRegion
	if not gainRegion then
		gainRegion = threatBar:CreateTexture(nil, "ARTWORK")
		gainRegion:SetBlendMode("BLEND")
		threatBar.gainRegion = gainRegion
	end
	gainRegion:SetTexture(texture)
	gainRegion:SetVertexColor(unpack(self.db.profile.threatGainColor)) -- the gain region color does not change

	-- glue the left of the gain region to the right of the threat region, so there is no overlap; we want motion on both edges of this region; TODO: see if this can be done once
	gainRegion:ClearAllPoints()
	gainRegion:SetPoint("TOPLEFT", threatRegion, "TOPRIGHT")
	gainRegion:SetPoint("BOTTOMLEFT", threatRegion, "BOTTOMRIGHT")
	gainRegion:Hide()
	-- ChatFrame7:AddMessage("AloftThreatBar:SetupThreatBar(): gain " .. gainRegion:GetDrawLayer())

	backdropTable.insets.left = inset
	backdropTable.insets.right = inset
	backdropTable.insets.top = inset
	backdropTable.insets.bottom = inset
	backdropTable.edgeFile = edgeFile
	backdropTable.edgeSize = self.db.profile.borderEdgeSize
	backdropTable.bgFile = texture

	-- ChatFrame7:AddMessage("AloftThreatBar:SetupThreatBar(): set backdrop " .. tostring(backdropTable.edgeFile))
	threatBar:SetBackdrop(backdropTable)
	-- threatBar:SetBackdropBorderColor(0, 0, 0, 0.1)
	-- threatBar:SetBackdropColor(0, 0, 0, 0.1)
	-- threatBar:SetBackdropColor(unpack(self.db.profile.backdropColor))

	-- This manipulates the threat bar background to always display "below" the threat bar
	-- ChatFrame7:AddMessage("AloftThreatBar:SetupBar(): threat #regions " .. threatBar:GetNumRegions())
	local _, _, backgroundRegion = threatBar:GetRegions()
	backgroundRegion:SetDrawLayer("BACKGROUND")
	backgroundRegion:SetBlendMode("BLEND")
	backgroundRegion:Show()

	threatBar:Hide()
end

function AloftThreatBar:PlaceThreatBar(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local threatBar = layoutFrame and layoutFrame.threatBar
	if threatBar then
		local inset, _ = self:GetBorder(aloftData)
		local nameplateFrame = aloftData.nameplateFrame
		local level = nameplateFrame:GetFrameLevel()

		-- ChatFrame7:AddMessage("AloftThreatBar:PlaceThreatBar(): place " .. aloftData.name)
		threatBar:ClearAllPoints() -- this line is important to getting threat text to layer properly? TODO: verify and understand why
		threatBar:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", self.db.profile.offsets.left - inset, self.db.profile.offsets.vertical + inset)
		threatBar:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", self.db.profile.offsets.right + inset, self.db.profile.offsets.vertical - self.db.profile.height - inset)
		threatBar:SetFrameLevel(level) -- this line is important to getting threat text to layer properly? TODO: verify and understand why
	end
end

function AloftThreatBar:AcquireThreatBar(aloftData)
	-- ChatFrame7:AddMessage("AloftThreatBar:AcquireThreatBar(): acquire " .. aloftData.name)
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	if not layoutFrame then
		ChatFrame7:AddMessage("AloftThreatBar:AcquireThreatBar(): no layoutFrame " .. tostring(aloftData.name))
		ChatFrame7:AddMessage("AloftThreatBar:AcquireThreatBar(): " .. debugstack())
	end
	local threatBar = layoutFrame.threatBar

	if not threatBar then
		threatBar = CreateFrame("Frame", nil, layoutFrame)

		layoutFrame.threatBar = threatBar
		threatBar.layoutFrame = layoutFrame
	end

	self:SetupThreatBar(aloftData, threatBar)
	self:PlaceThreatBar(aloftData)

	return threatBar
end

function AloftThreatBar:ReleaseThreatBar(aloftData)
	-- ChatFrame7:AddMessage("AloftThreatBar:ReleaseThreatBar(): release " .. aloftData.name)
	self:CleanupThreatBar(aloftData)
	self:RePoolThreatBar(aloftData)
end

function AloftThreatBar:CleanupThreatBar(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local threatBar = layoutFrame and layoutFrame.threatBar
	if threatBar then
		-- if threatBar.threatRegion then threatBar.threatRegion:Hide() end
		-- if threatBar.gainRegion then threatBar.gainRegion:Hide() end
	end
end

-- engaging in various frame-delay tactics here, to get rid of graphical artifacts; pieces of the threat bar are left behind on target switch
function AloftThreatBar:RePoolThreatBar(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local threatBar = layoutFrame and layoutFrame.threatBar
	if threatBar then
		-- clear the frame-delay flag, this bar should be initialized when re-used
		threatBar.init = nil

		-- NOTE: this is very cryptic; need to clear the color and set the width incrementally here;
		-- THEN: after a frame delay, we can zero the width and hide; all other permutations on this resulted
		--       in artifacts

		threatBar:SetBackdropColor(0, 0, 0, 0.0)
		threatBar:SetBackdropBorderColor(0, 0, 0, 0.0)

		local threatRegion = threatBar.threatRegion
		if threatRegion then
			threatRegion:SetWidth(1) -- try wiggling incrementally, first to a nominal width, and then to 0 after a frame delay
			-- threatRegion:Hide()
		end

		local gainRegion = threatBar.gainRegion
		if gainRegion then
			gainRegion:SetWidth(1) -- try wiggling incrementally, first to a nominal width, and then to 0 after a frame delay
			-- gainRegion:Hide()
		end

		-- threatBar:Hide()

		-- engaging in various frame-delay tactics here, to get rid of graphical artifacts; pieces of the threat bar are left behind on target switch
		self:ScheduleTimer(function(threatBar) AloftThreatBar:DoHideThreatBarBorder(threatBar) end, 0.1, threatBar) -- frame delay; delay of 0.0 almost does it, so try 0.1
	end
end

-- engaging in various frame-delay tactics here, to get rid of graphical artifacts; pieces of the threat bar are left behind on target switch
function AloftThreatBar:DoHideThreatBarBorder(threatBar)
	if threatBar and not threatBar.init then
		-- threatBar:SetBackdropColor(0, 0, 0, 0.0)
		-- threatBar:SetBackdropBorderColor(0, 0, 0, 0.0)

		local threatRegion = threatBar.threatRegion
		if threatRegion then
			threatRegion:SetWidth(0)
			threatRegion:Hide()
		end

		local gainRegion = threatBar.gainRegion
		if gainRegion then
			gainRegion:SetWidth(0)
			gainRegion:Hide()
		end

		threatBar:Hide()
	end
end

function AloftThreatBar:AcquireFlashFrame(aloftData)
	-- ChatFrame7:AddMessage("AloftThreatBar:AcquireFlashFrame(): acquire " .. aloftData.name)
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	if not layoutFrame then
		ChatFrame7:AddMessage("AloftThreatBar:AcquireFlashFrame(): no layoutFrame " .. tostring(aloftData.name))
		ChatFrame7:AddMessage("AloftThreatBar:AcquireFlashFrame(): " .. debugstack())
	end
	local flashFrame = layoutFrame.flashFrame

	if not flashFrame then
		flashFrame = CreateFrame("Frame", nil, layoutFrame)

		layoutFrame.flashFrame = flashFrame
		flashFrame.layoutFrame = layoutFrame

		self:SetupFlashFrame(flashFrame)
	end

	self:PlaceFlashFrame(aloftData)

	return flashFrame
end

function AloftThreatBar:SetupFlashFrame(flashFrame)
	local flashRegion = flashFrame.flashRegion
	if not flashRegion then
		-- a layer above "BACKGROUND" is intentional, so that this will display on top of the main glow (if any); the main nameplate glow is in "BACKGROUND"
		-- NOTE: putting this in the "ARTWORK" layer can obscure other frame's border artwork
		flashRegion = flashFrame:CreateTexture(nil, "BORDER")
		flashFrame.flashRegion = flashRegion
	end

	local texture = SML:Fetch("glow", self.db.profile.flashStyle) -- these textures are registered in AloftGlow/AloftGlow.lua

	-- flashRegion:SetTexture(flashTexture[self.db.profile.flashStyle])
	flashRegion:SetTexture(texture)
	-- ChatFrame7:AddMessage("AloftThreatBar:SetupFlashFrame(): texture " .. tostring(texture) .. " - " .. tostring(flashRegion:GetTexture()))
	flashRegion:SetBlendMode(self.db.profile.flashBlendMode)
	flashRegion:SetVertexColor(unpack(self.db.profile.flashColor))
	-- ChatFrame7:AddMessage("AloftThreatBar:SetupFlashFrame(): texture " .. tostring(flashRegion:GetTexture()))

	flashRegion:ClearAllPoints()
	flashRegion:SetAllPoints(flashFrame) -- conform to the underlying flash frame
	flashRegion:Show()

	flashFrame:SetWidth(self.db.profile.flashWidth)		-- make the frame it slightly larger than the underlying health bar frame
	flashFrame:SetHeight(self.db.profile.flashHeight)	-- make the frame it slightly larger than the underlying health bar frame
	flashFrame:Hide()
end

function AloftThreatBar:PlaceFlashFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local flashFrame = layoutFrame and layoutFrame.flashFrame
	if flashFrame then
		local nameplateFrame = aloftData.nameplateFrame
		local level = nameplateFrame:GetFrameLevel()

		-- ChatFrame7:AddMessage("AloftThreatBar:PlaceFlashFrame(): place " .. aloftData.name)
		flashFrame:ClearAllPoints()
		flashFrame:SetPoint("CENTER", layoutFrame.healthFrame, "CENTER", self.db.profile.flashOffsetX, self.db.profile.flashOffsetY)
		flashFrame:SetFrameLevel(level) -- above the backdrop frame, but below all artwork
	end
end

function AloftThreatBar:ReleaseFlashFrame(aloftData)
	-- ChatFrame7:AddMessage("AloftThreatBar:ReleaseFlashFrame(): release " .. aloftData.name)
	self:CleanupFlashFrame(aloftData)
	self:RePoolFlashFrame(aloftData)
end

function AloftThreatBar:CleanupFlashFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local flashFrame = layoutFrame and layoutFrame.flashFrame
	if flashFrame then
		-- if flashFrame.flashRegion then flashFrame.flashRegion:Hide() end
	end
end

function AloftThreatBar:RePoolFlashFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local flashFrame = layoutFrame and layoutFrame.flashFrame
	if flashFrame then
		flashFrame:Hide()
	end
end

function AloftThreatBar:Update(message, aloftData)
	-- ChatFrame7:AddMessage("AloftThreatBar:Update(): enter")

	-- we have attempted various workarounds for some threat bar screen artifacts;
	-- sometimes it looks like the WoW client is trying to optimize texture region updates and is forgetting to update when it should
	-- the background region peeps out from behind the threat/gain regions, the gain region sticks way out to the side
	-- so, we clean all this up by reinitializing to a known basic state here, and then we set the threat bar elements up if we need to,
	-- and we use an extremely small value for the threat region width when the player does not have any threat
	-- TODO: i could be nuts here, so continue experimenting with this, and see if the overhead can be reduced

	-- ChatFrame7:AddMessage("AloftThreatBar:Update(): update " .. aloftData.name)

	-- TODO: we do this check in ThreatData.lua, preparatory to calculating ThreatFraction; see if there is a way to avoid duplicating it
	-- ChatFrame7:AddMessage("AloftThreatBar:Update(): update bar " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.threat) .. "/" .. tostring(aloftData.maxThreat))
	if aloftData.threat ~= nil and aloftData.maxThreat ~= nil and aloftData.maxThreat > 0 then
		local threatBar = self:AcquireThreatBar(aloftData)
		self:CleanupThreatBar(aloftData)

		local flashFrame
		if self.db.profile.flashEnable then
			-- ChatFrame7:AddMessage("AloftThreatBar:Update(): acquire flash frame " .. tostring(aloftData.name))
			flashFrame = self:AcquireFlashFrame(aloftData)
			self:CleanupFlashFrame(aloftData)
		else
			self:ReleaseFlashFrame(aloftData)
		end
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): have threat " .. aloftData.threat .. "/" .. aloftData.maxThreat .. "/" .. aloftData.maxThreatGain)

		local inset, _ = self:GetBorder(aloftData)
		local width = threatBar:GetWidth() - (2 * inset) -- maximum displayed width of the total threatbar
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. aloftData.name .. " total width " .. width)

		-- total width of the colored part of the threat bar, all active regions included (i.e. background not included); threat gain shows only on the current player target
		local totalRegionWidth = (self.db.profile.gainEnable and
				-- (aloftData.type == "hostilePlayer" or aloftData.type == "hostile" or aloftData.type == "neutral" or aloftData.isTarget or aloftData:IsTarget()) and
				(width * (aloftData.maxThreat / aloftData.maxThreatGain))) or width
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. aloftData.name .. " region width " .. totalRegionWidth)

		-- portion of the total active region to be occupied by the threat bar
		local threatRegionWidth = (totalRegionWidth * (aloftData.threat / aloftData.maxThreat))
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. aloftData.name .. " initial threat width " .. threatRegionWidth)
		if threatRegionWidth > totalRegionWidth then threatRegionWidth = totalRegionWidth end
		if threatRegionWidth <= 0 then threatRegionWidth = 0.00001 end -- needs to be > 0, so it doesn't default to the blizzard value, but make it as skinny as we can get it
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. aloftData.name .. " adjusted threat width " .. threatRegionWidth)

		-- portion of the total active region to be occupied by the threat gain threshold bar
		local gainRegionWidth = totalRegionWidth - threatRegionWidth
		if gainRegionWidth < 0 then gainRegionWidth = 0 end

		-- color according to whether the active threat has equalled the maximum threat; color changes as an "alarm" when that threshold is reached
		-- NOTE: if threat gain thresholds are enabled, for the player nameplate, the threatRegion will change to the maximum threat color;
		--              only when the player becomes the "tank" (target of target) will the threatRegion subsume the entire threat bar
		local threatRegion = threatBar.threatRegion
		local threatRegionColor = (aloftData.threat < aloftData.maxThreat) and self.db.profile.commonThreatColor or self.db.profile.maximumThreatColor
		threatRegion:SetVertexColor(unpack(threatRegionColor)) -- the threat region color can change
		if not threatBar.init or threatBar.init < BORDER_INIT_ATTEMPTS then
			threatRegion:SetWidth(1) -- width is initially bogus, updated after a frame delay below (only once, before the first frame delay)
		end
		threatRegion:Show()
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. aloftData.name .. " threat width " .. threatRegion:GetWidth())

		-- dunno if this width measure can go below zero, but best to be safe... don't want negative gain threstholds showing
		if self.db.profile.gainEnable and
		   -- (aloftData.type == "hostilePlayer" or aloftData.type == "hostile" or aloftData.type == "neutral" or aloftData.isTarget or aloftData:IsTarget()) and
		   gainRegionWidth > 0 then
			-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. tostring(aloftData.name) .. "/" .. tostring(gainRegionWidth))
			local gainRegion = threatBar.gainRegion
			gainRegion:SetWidth(gainRegionWidth)
			gainRegion:Show()
			-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. aloftData.name .. " gain width " .. gainRegion:GetWidth())
		else
			threatBar.gainRegion:Hide()
		end

		-- the threat bar is constructed; show it, initially with bogus colors (only once, before the first frame-delay)
		if self:NeedsBorder(aloftData) and self.db.profile.incremental and (not threatBar.init or threatBar.init < BORDER_INIT_ATTEMPTS) then
			threatBar:SetBackdropColor(0, 0, 0, 0.1)
			threatBar:SetBackdropBorderColor(0, 0, 0, 0.1)
			threatBar:Show()
		end

		if self:NeedsBorder(aloftData) and self.db.profile.incremental then
			-- frame delay to flip the backdrop color(s); hopefully avoids the "malformed border" issue
			self:ScheduleTimer(function(arg) AloftThreatBar:DoShowThreatBar(arg) end, 0.15, { aloftData = aloftData, threatRegionWidth = threatRegionWidth, gainRegionWidth = gainRegionWidth, }) -- a bit more than one frame
			-- ChatFrame7:AddMessage("AloftThreatBar:Update(): show threat bar on delay " .. tostring(aloftData.name))
		else
			self:DoShowThreatBar({ aloftData = aloftData, threatRegionWidth = threatRegionWidth, gainRegionWidth = gainRegionWidth, })
			-- ChatFrame7:AddMessage("AloftThreatBar:Update(): show threat bar immediately " .. tostring(aloftData.name))
		end

		-- if the nameplate's unit has maximum threat, show the flash bar as well
		if flashFrame and self.db.profile.flashEnable then
			-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.threatFraction * 100.0) .. "/" .. tostring(self.db.profile.flashThreshold))
			currentFraction = (aloftData.threatFraction * 100.0)
			if ((self.db.profile.flashInvert) and (currentFraction <= self.db.profile.flashThreshold)) or ((not self.db.profile.flashInvert) and (currentFraction >= self.db.profile.flashThreshold)) then
				flashFrame:Show()
				-- ChatFrame7:AddMessage("AloftThreatBar:Update(): show flash frame " .. tostring(aloftData.name))
			else
				flashFrame:Hide()
				-- ChatFrame7:AddMessage("AloftThreatBar:Update(): hide flash frame " .. tostring(aloftData.name))
			end
			-- ChatFrame7:AddMessage("AloftThreatBar:Update(): flash visible " .. tostring(aloftData.name) .. "/" .. tostring(flashFrame.flashRegion:IsVisible()))
		end
	else
		-- threat bar and flash frame are still cleaned up from before the if-statement, so just return them to the pool
		self:RePoolThreatBar(aloftData)
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): recover threat bar " .. tostring(aloftData.name))

		if self.db.profile.flashEnable then
			self:RePoolFlashFrame(aloftData)
		end
	end

	-- ChatFrame7:AddMessage("AloftThreatBar:Update(): exit")
end

function AloftThreatBar:DoShowThreatBar(arg)
	local aloftData = arg.aloftData
	local threatBar = aloftData.layoutFrame and aloftData.layoutFrame.threatBar

	if threatBar then
		threatBar:SetBackdropColor(unpack(self.db.profile.backdropColor))
		threatBar:SetBackdropBorderColor(unpack(self.db.profile.borderColor))
		threatBar.threatRegion:SetWidth(arg.threatRegionWidth)
		threatBar:Show()

		if not arg.gainRegionWidth or arg.gainRegionWidth <= 0 then
			threatBar.gainRegion:Hide()
		end

		-- flag as having been through the first frame-delay
		if threatBar then
			if not threatBar.init then
				threatBar.init = 0
			else
				threatBar.init = threatBar.init + 1
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftThreatBar:OnNameplateShow(message, aloftData)
	-- ChatFrame7:AddMessage("AloftThreatBar:OnNameplateShow(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	if aloftData.isTarget or aloftData:IsTarget() then
		self:ScheduleTimer(function(arg) AloftThreatBar:Update(arg.message, arg.aloftData) end, 0.0, { message = message, aloftData = aloftData, }) -- just one frame
	else
		self:Update(message, aloftData)
	end
end

function AloftThreatBar:OnNameplateHide(message, aloftData)
	-- ChatFrame7:AddMessage("AloftThreatBar:OnNameplateHide(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:ReleaseThreatBar(aloftData)
	self:ReleaseFlashFrame(aloftData)
end

function AloftThreatBar:OnIsTargetDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftThreatBar:OnIsTargetDataChanged(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:ScheduleTimer(function(arg) AloftThreatBar:Update(arg.message, arg.aloftData) end, 0.0, { message = message, aloftData = aloftData, }) -- next frame
end

-----------------------------------------------------------------------------

end)