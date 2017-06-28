local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

local AloftThreatBar = Aloft:NewModule("ThreatBar", "AceEvent-2.0")
AloftThreatBar.dynamic = "AloftThreat"

local SML = AceLibrary("LibSharedMedia-3.0")
local SML_statusbar = SML:List("statusbar")

-----------------------------------------------------------------------------

AloftThreatBar.db = Aloft:AcquireDBNamespace("threatBar")
Aloft:RegisterDefaults("threatBar", "profile", {
	enable				= false,
	activeWhileSolo		= true,
	gainEnable			= true,
	texture				= "Blizzard",
	height				= 4,
	targetOnly			= true,
	border				= "None",
	borderColor			= { 1, 1, 1, 1 },
	backdropColor		= { 0.25, 0.25, 0.25, 0.5 },
	flashEnable			= true,
	flashInvert			= false,
	flashThreshold		= 90,
	flashColor			= { 0.0, 0.0, 1.0, 1.0 }, -- blue
	flashStyle			= "THRQTRSOFT",
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
})

-----------------------------------------------------------------------------

local profile

local unpack=unpack

local backdropTable =
{
	tile = false, tileSize = 16,
	edgeSize = 16,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
}

local flashTexture =
{
	["HARD"]				= [[Interface\Addons\Aloft\Textures\Outline]],			-- TODO: research this [[]] notation
	["SOFT"]				= [[Interface\AddOns\Aloft\Textures\SoftOutline]],
	["PRTLSOFT"]			= [[Interface\AddOns\Aloft\Textures\PartialSoftOutline]],
	["THRQTRSOFT"]			= [[Interface\AddOns\Aloft\Textures\ThrQrtrSoftOutline]],
	["EXTRASOFT"]			= [[Interface\AddOns\Aloft\Textures\ExtraSoftOutline]],
	["OVAL"]				= [[Interface\AddOns\Aloft\Textures\OvalOutline]],
	["OVALGLOW"]			= [[Interface\AddOns\Aloft\Textures\OvalGlow]],
	["SQUAREGLOW"]			= [[Interface\AddOns\Aloft\Textures\SquareGlow]],
	["PRTLSQUAREGLOW"]		= [[Interface\AddOns\Aloft\Textures\PartialSquareGlow]],
	["THRQTRSQUAREGLOW"]	= [[Interface\AddOns\Aloft\Textures\ThrQrtrSquareGlow]],
}

-----------------------------------------------------------------------------

function AloftThreatBar:IsGrouped()
	return (GetNumPartyMembers() + GetNumRaidMembers()) > 0
end

function AloftThreatBar:IsEnabled()
	return profile and profile.enable and (self:IsGrouped() or profile.activeWhileSolo)
end

----------------------------------------------------------------------------

function AloftThreatBar:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if self:IsEnabled() then
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
			self:Update(aloftData)
		else
			-- ChatFrame7:AddMessage("AloftThreatBar:UpdateAll(): release " .. aloftData.name)
			self:ReleaseThreatBar(aloftData)
			self:ReleaseFlashFrame(aloftData)
		end
	end
	if self:IsEnabled() then
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
	if self:IsEnabled() then
		self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
		self:RegisterEvent("Aloft:OnThreatDataChanged", "Update")
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	else
		self:CancelEvent("Aloft:OnIsTargetDataChanged")
		self:CancelEvent("Aloft:OnThreatDataChanged")
		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnNameplateHide")
	end
end

function AloftThreatBar:OnInitialize()
	profile = self.db.profile
end

function AloftThreatBar:OnEnable()
	Aloft:DebugRegister("ThreatBar")
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

function AloftThreatBar:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:ReleaseThreatBar(aloftData)
		self:ReleaseFlashFrame(aloftData)
	end
end

function AloftThreatBar:RequiresData()
	self:RegisterEvents()
	if self:IsEnabled() then
		return "threat", "maxThreat", "maxThreatGain"
	end
end

-----------------------------------------------------------------------------

function AloftThreatBar:GetBorder(aloftData)
	if not profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		-- ChatFrame7:AddMessage("AloftHealthBar:GetBorder(): border " .. tostring(profile.border))
		return ((profile.border ~= "None") and 4) or 0, SML:Fetch("border", profile.border)
	else
		return 0, SML:Fetch("border", "None")
	end
end

function AloftThreatBar:SetupThreatBar(aloftData, threatBar)
	-- ChatFrame7:AddMessage("AloftThreatBar:SetupThreatBar(): invoke")

	local texture = SML:Fetch("statusbar", profile.texture)
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
	gainRegion:SetVertexColor(unpack(profile.threatGainColor))

	-- glue the left of the gain region to the right of the threat region, so there is no overlap; we want motion on both edges of this region; TODO: see if this can be done once
	gainRegion:ClearAllPoints()
	gainRegion:SetPoint("TOPLEFT", threatRegion, "TOPRIGHT")
	gainRegion:SetPoint("BOTTOMLEFT", threatRegion, "BOTTOMRIGHT")
	gainRegion:Hide()
	-- ChatFrame7:AddMessage("AloftThreatBar:SetupThreatBar(): gain " .. gainRegion:GetDrawLayer())

	backdropTable.insets = { left = inset, right = inset, top = inset, bottom = inset }
	backdropTable.edgeFile = edgeFile
	backdropTable.bgFile = texture

	-- ChatFrame7:AddMessage("AloftThreatBar:SetupThreatBar(): set backdrop " .. tostring(backdropTable.edgeFile))
	threatBar:SetBackdrop(backdropTable)
	threatBar:SetBackdropBorderColor(unpack(profile.borderColor))
	threatBar:SetBackdropColor(unpack(profile.backdropColor))

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
		threatBar:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", profile.offsets.left - inset, profile.offsets.vertical + inset)
		threatBar:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", profile.offsets.right + inset, profile.offsets.vertical - profile.height - inset)
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

function AloftThreatBar:RePoolThreatBar(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local threatBar = layoutFrame and layoutFrame.threatBar
	if threatBar then
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
		flashRegion = flashFrame:CreateTexture(nil, "ARTWORK") -- this is intentional, so that this will display on top of the main glow (if any)
		flashFrame.flashRegion = flashRegion
	end

	flashRegion:SetTexture(flashTexture[profile.flashStyle])
	-- ChatFrame7:AddMessage("AloftThreatBar:SetupFlashFrame(): texture " .. tostring(flashTexture[profile.flashStyle]) .. " - " .. tostring(flashRegion:GetTexture()))
	flashRegion:SetBlendMode(profile.flashBlendMode)
	flashRegion:SetVertexColor(unpack(profile.flashColor))
	-- ChatFrame7:AddMessage("AloftThreatBar:SetupFlashFrame(): texture " .. tostring(flashRegion:GetTexture()))

	flashRegion:ClearAllPoints()
	flashRegion:SetAllPoints(flashFrame) -- conform to the underlying flash frame
	flashRegion:Show()

	flashFrame:SetWidth(profile.flashWidth)		-- make the frame it slightly larger than the underlying health bar frame
	flashFrame:SetHeight(profile.flashHeight)	-- make the frame it slightly larger than the underlying health bar frame
	flashFrame:Hide()
end

function AloftThreatBar:PlaceFlashFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local flashFrame = layoutFrame.flashFrame
	if flashFrame then
		local nameplateFrame = aloftData.nameplateFrame
		local level = nameplateFrame:GetFrameLevel()

		-- ChatFrame7:AddMessage("AloftThreatBar:PlaceFlashFrame(): place " .. aloftData.name)
		flashFrame:ClearAllPoints()
		flashFrame:SetPoint("CENTER", aloftData.healthBar, "CENTER", profile.flashOffsetX, profile.flashOffsetY)
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

function AloftThreatBar:Update(aloftData)
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
		if profile.flashEnable then
			-- ChatFrame7:AddMessage("AloftThreatBar:Update(): acquire flash frame " .. tostring(aloftData.name))
			flashFrame = self:AcquireFlashFrame(aloftData)
			self:CleanupFlashFrame(aloftData)
		end
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): have threat " .. aloftData.threat .. "/" .. aloftData.maxThreat .. "/" .. aloftData.maxThreatGain)

		local inset, _ = self:GetBorder(aloftData)
		local width = threatBar:GetWidth() - (2 * inset) -- maximum displayed width of the total threatbar
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. aloftData.name .. " total width " .. width)

		-- total width of the colored part of the threat bar, all active regions included (i.e. background not included); threat gain shows only on the current player target
		local totalRegionWidth = (profile.gainEnable and
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
		local threatRegionColor = (aloftData.threat < aloftData.maxThreat) and profile.commonThreatColor or profile.maximumThreatColor
		threatRegion:SetVertexColor(unpack(threatRegionColor))
		threatRegion:SetWidth(threatRegionWidth)
		threatRegion:Show()
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. aloftData.name .. " threat width " .. threatRegion:GetWidth())

		-- dunno if this width measure can go below zero, but best to be safe... don't want negative gain threstholds showing
		if profile.gainEnable and
		   -- (aloftData.type == "hostilePlayer" or aloftData.type == "hostile" or aloftData.type == "neutral" or aloftData.isTarget or aloftData:IsTarget()) and
		   gainRegionWidth > 0 then
			-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. tostring(aloftData.name) .. "/" .. tostring(gainRegionWidth))
			local gainRegion = threatBar.gainRegion
			gainRegion:SetWidth(gainRegionWidth)
			gainRegion:Show()
			-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. aloftData.name .. " gain width " .. gainRegion:GetWidth())
		end

		-- the threat bar is constructed, show it
		threatBar:Show()
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): show threat bar " .. tostring(aloftData.name))

		-- if the nameplate's unit has maximum threat, show the flash bar as well
		if profile.flashEnable and flashFrame then
			-- ChatFrame7:AddMessage("AloftThreatBar:Update(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.threatFraction * 100.0) .. "/" .. tostring(profile.flashThreshold))
			currentFraction = (aloftData.threatFraction * 100.0)
			if ((profile.flashInvert) and (currentFraction <= profile.flashThreshold)) or ((not profile.flashInvert) and (currentFraction >= profile.flashThreshold)) then
				flashFrame:Show()
				-- ChatFrame7:AddMessage("AloftThreatBar:Update(): show flash frame " .. tostring(aloftData.name))
			else
				flashFrame:Hide()
				-- ChatFrame7:AddMessage("AloftThreatBar:Update(): hide flash frame " .. tostring(aloftData.name))
			end
		end
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): glow visible " .. tostring(aloftData.name) .. "/" .. tostring(flashFrame.flashRegion:IsVisible()))
	else
		-- threat bar and flash frame are still cleaned up from before the if-statement, so just return them to the pool
		self:RePoolThreatBar(aloftData)
		-- ChatFrame7:AddMessage("AloftThreatBar:Update(): recover threat bar " .. tostring(aloftData.name))

		if profile.flashEnable then
			self:RePoolFlashFrame(aloftData)
		end
	end

	-- ChatFrame7:AddMessage("AloftThreatBar:Update(): exit")
end

-----------------------------------------------------------------------------

function AloftThreatBar:OnNameplateShow(aloftData)
	-- ChatFrame7:AddMessage("AloftThreatBar:OnNameplateShow(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	if aloftData.isTarget or aloftData:IsTarget() then
		local eventName = "AloftThreatBar:OnNameplateShow:" .. tostring(math.random(1,1000000000))
		self:ScheduleEvent(eventName, self.Update, 0.5, self, aloftData) -- give it a couple of frames
	else
		self:Update(aloftData)
	end
end

function AloftThreatBar:OnNameplateHide(aloftData)
	-- ChatFrame7:AddMessage("AloftThreatBar:OnNameplateHide(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:ReleaseThreatBar(aloftData)
	self:ReleaseFlashFrame(aloftData)
end

function AloftThreatBar:OnIsTargetDataChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftThreatBar:OnIsTargetDataChanged(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	local eventName = "AloftThreatBar:OnIsTargetDataChanged:" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.Update, 0.0, self, aloftData) -- next frame
end

-----------------------------------------------------------------------------

end)