local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftFrame = Aloft:NewModule("Frame", Aloft, "AceEvent-3.0", "AceTimer-3.0")

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftFrame.namespace = "frame"
AloftFrame.defaults =
{
	profile =
	{
		enableMouse			= true,
		background			= "Solid",
		targetOnly			= true,
		border				= "None",
		borderEdgeSize		= 16,
		borderInset			= 4,
		borderColor			= { 1, 1, 1, 1 },
		offsetX				= 0,
		offsetY				= 0,
		width				= 115,
		height				= 11,
		packingWidth		= 5,
		packingHeight		= 5,
		backgroundAlpha		= 0,
		colorFormat			= "",
		colorByClass		= false,
		colorHostileByClass	= false,
		backgroundColors =
		{
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
	},
}

-----------------------------------------------------------------------------

AloftFrame.colorMethod = nil
AloftFrame.colorMethodData = { }

local frameUpdateList = { }

local backgroundColorMethod

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

-- backdrop table for resetting nameplates when they are hidden
local defaultBackdropTable =
{
	-- tile = false,
	-- tileSize = 0,
	bgFile = nil,
	-- edgeSize = 0,
	edgeFile = nil,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

-----------------------------------------------------------------------------

function AloftFrame:UpdateAll()
	-- ChatFrame7:AddMessage("AloftFrame:UpdateAll(): enter")

	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame("AloftFrame:UpdateAll", aloftData)
	end
	if self.db.profile and self.db.profile.enable then
		for layoutFrame in pairs(Aloft.layoutFramePool) do
			local backdropFrame = layoutFrame.backdropFrame
			if backdropFrame then
				backdropFrame:Hide()
			end
		end
	end

	-- update various bar modules that may need repositioning
	if Aloft:GetModule("HealthBar", true) then Aloft:GetModule("HealthBar"):UpdateAll() end
	-- if Aloft:GetModule("HealthBarDeficit", true) then Aloft:GetModule("HealthBarDeficit"):UpdateAll() end
	if Aloft:GetModule("CastBar", true) then Aloft:GetModule("CastBar"):UpdateAll() end
	if Aloft:GetModule("CastWarning", true) then Aloft:GetModule("CastWarning"):UpdateAll() end
	if Aloft:GetModule("ManaBar", true) then Aloft:GetModule("ManaBar"):UpdateAll() end
	if Aloft:GetModule("ThreatBar", true) then Aloft:GetModule("ThreatBar"):UpdateAll() end
	if Aloft:GetModule("CrowdControl", true) then Aloft:GetModule("CrowdControl"):UpdateAll() end

	-- ChatFrame7:AddMessage("AloftFrame:UpdateAll(): exit")
end

function AloftFrame:RegisterEvents()
	-- ChatFrame7:AddMessage("AloftFrame:RegisterEvents(): enter")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
	self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatFinished")

	-- no background, the default
	backgroundColorMethod = AloftFrame.ClearBackdropColor

	if (self.db.profile.backgroundAlpha ~= 0) and
	   (not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPlayer, self.db.profile.backgroundColors.friendlyPet) or
		not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPlayer, self.db.profile.backgroundColors.friendlyNPC) or
		not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPlayer, self.db.profile.backgroundColors.friendlyBoss) or
		not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPlayer, self.db.profile.backgroundColors.hostilePlayer) or
		not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPlayer, self.db.profile.backgroundColors.hostilePet) or
		not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPlayer, self.db.profile.backgroundColors.hostileNPC) or
		not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPlayer, self.db.profile.backgroundColors.hostileBoss) or
		not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPlayer, self.db.profile.backgroundColors.neutral) or
		not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPlayer, self.db.profile.backgroundColors.pet) or
		not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPlayer, self.db.profile.backgroundColors.groupPet) or
		self.db.profile.colorByClass or
		self.db.profile.colorHostileByClass or
		self.db.profile.colorFormat ~= "") then

		if not self.db.profile.colorByClass and
		   not self.db.profile.colorHostileByClass and
		   (self:IsArrayEqual(self.db.profile.backgroundColors.friendlyNPC, self.db.profile.backgroundColors.friendlyPet) and
			self:IsArrayEqual(self.db.profile.backgroundColors.friendlyNPC, self.db.profile.backgroundColors.friendlyBoss) and
			self:IsArrayEqual(self.db.profile.backgroundColors.friendlyNPC, self.db.profile.backgroundColors.pet) and
			self:IsArrayEqual(self.db.profile.backgroundColors.friendlyNPC, self.db.profile.backgroundColors.groupPet)) and
		   (self:IsArrayEqual(self.db.profile.backgroundColors.hostilePlayer, self.db.profile.backgroundColors.hostilePet) and
			self:IsArrayEqual(self.db.profile.backgroundColors.hostilePlayer, self.db.profile.backgroundColors.hostileNPC) and
			self:IsArrayEqual(self.db.profile.backgroundColors.hostilePlayer, self.db.profile.backgroundColors.hostileBoss)) then
			-- type colors in background
			backgroundColorMethod = AloftFrame.SetBackdropColorByType
		else
			-- class colors in background
			backgroundColorMethod = AloftFrame.SetBackdropColor
		end
	end

	self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")

	if self.db.profile.border ~= "None" and self.db.profile.targetOnly then
		-- ChatFrame7:AddMessage("AloftFrame:RegisterEvents(): register Aloft:OnIsTargetDataChanged")
		self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
	end

	if self.db.profile.backgroundAlpha ~= 0 then
		if self.db.profile.colorByClass or self.db.profile.colorHostileByClass then
			self:RegisterMessage("Aloft:OnClassDataChanged", "OnNameplateShow")
		end

		if not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPet, self.db.profile.backgroundColors.friendlyNPC) or
		   not self:IsArrayEqual(self.db.profile.backgroundColors.hostilePet, self.db.profile.backgroundColors.hostileNPC) then
			self:RegisterMessage("Aloft:OnIsPetDataChanged", "OnNameplateShow")
		end

		if self.colorMethodData and self.colorMethodData.events then
			for events in pairs(self.colorMethodData.events) do
				self:RegisterMessage(events, "OnNameplateShow")
			end
		end
	end

end

-----------------------------------------------------------------------------

function AloftFrame:OnInitialize()
	-- ChatFrame7:AddMessage("AloftFrame:OnInitialize(): enter")
	-- ChatFrame7:AddMessage("AloftFrame:OnInitialize(): " .. tostring(self) .. "/" .. tostring(self and self.db) .. "/" .. tostring(self and self.db and self.db.profile) .. "/" .. tostring(self and self.db and self.db.profile and self.db.profile.backgroundColors))

	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	-- ChatFrame7:AddMessage("AloftFrame:OnInitialize(): " .. tostring(self) .. "/" .. tostring(self and self.db) .. "/" .. tostring(self and self.db and self.db.profile) .. "/" .. tostring(self and self.db and self.db.profile and self.db.profile.backgroundColors))
	-- ChatFrame7:AddMessage("AloftFrame:OnInitialize(): exit")

	self.initialized = true
end

function AloftFrame:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftFrame:OnEnable(): enter")
	self:UpdateAll()
	-- ChatFrame7:AddMessage("AloftFrame:OnEnable(): exit")
end

function AloftFrame:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		AloftFrame:ReleaseBackdropFrame(aloftData)
	end
end

local dataRequiredList = { }
function AloftFrame:RequiresData()
	-- ChatFrame7:AddMessage("AloftFrame:RequiresData(): enter")
	if self.db.profile.colorFormat and self.db.profile.colorFormat ~= "" and (not self.colorMethodData or not self.colorMethod) then
		self.colorMethodData = Aloft:CreateTag(self.db.profile.colorFormat, true)
		self.colorMethod = self.colorMethodData.method
		-- ChatFrame7:AddMessage("AloftFrame:RequiresData(): establish color method")
	end

	self:RegisterEvents()

	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	if self.db.profile.backgroundAlpha ~= 0 then
		if self.db.profile.colorByClass or
		   self.db.profile.colorHostileByClass or
		   not self:IsArrayEqual(self.db.profile.backgroundColors.hostileNPC, self.db.profile.backgroundColors.hostilePlayer) then
			table.insert(dataRequiredList, "class")
		end

		if not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPet, self.db.profile.backgroundColors.friendlyNPC) or
		   not self:IsArrayEqual(self.db.profile.backgroundColors.hostilePet, self.db.profile.backgroundColors.hostileNPC) then
			table.insert(dataRequiredList, "isPet")
		end

		if Aloft:IsDataAvailable("unitid") and not self:IsArrayEqual(self.db.profile.backgroundColors.friendlyPet, self.db.profile.backgroundColors.groupPet) then
			table.insert(dataRequiredList, "unitid")
		end

		if self.colorMethodData and self.colorMethodData.data then
			for data in pairs(self.colorMethodData.data) do
				table.insert(dataRequiredList, data)
			end
		end
	end

	return unpack(dataRequiredList)
end

-----------------------------------------------------------------------------

function AloftFrame:GetBorder(aloftData)
	if not self.db.profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		return ((self.db.profile.border ~= "None") and self.db.profile.borderInset) or 0, SML:Fetch("border", self.db.profile.border)
		-- return 0, SML:Fetch("border", "None")
	else
		return 0, nil
	end
end

function AloftFrame:SetupFrame(message, aloftData)
	--
	-- Using the inbuilt frame for borders/background works fine, until a nameplate shows during combat
	--
	-- The game likes to automatically resize the frame when a frame is shown,
	-- but we can't change it back OnShow because of in-combat lockdown.
	--
	-- This forces us to use our own backdropFrame which we can control as we please.
	--
	-- We also can't use SetFrameLevel during combat.
	--
	-- Requirements:
	--  Reference Frame is invisible, used for placement/layout only, but we place it at the absolute top
	--  Backdrop must appear behind all visible elements
	--  CastBar/HealthBar must show backgrounds
	--  CastBar/HealthBar background must be above backdrop
	--  Overlay and HealthBar Highlightmust display on top of HealthBar/CastBar
	--  UI elements must appear on top of healthbar/castbar/overlay
	--  all frames/regions must belong to the parent/child heirarchy of the nameplate assembly (rooted at nameplateFrame) or layout won't work properly
	--

	--[[
	if aloftData then
		ChatFrame7:AddMessage("AloftFrame:SetupFrame(): setup " .. tostring(aloftData) .. "/" .. tostring(aloftData.name))
	else
		ChatFrame7:AddMessage("AloftFrame:SetupFrame(): setup " .. debugstack())
	end
	]]

	-- if not aloftData.nameplateFrame:IsShown() then return end -- stub out if hidden
	local nameplateFrame = aloftData.nameplateFrame
	if InCombatLockdown() then
		frameUpdateList[aloftData] = true
		-- return -- TODO: watch this carefully
	else
		-- nameplate setup cannot occur during combat, but all of the rest of this can
		-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): set height/width " .. tostring(nameplateFrame) .. "/" .. tostring(aloftData.name))

		nameplateFrame:SetWidth(self.db.profile.packingWidth+self.db.profile.width)
		nameplateFrame:SetHeight(self.db.profile.packingHeight+self.db.profile.height)
		if not aloftData.invisible then
			if self.db.profile.enableMouse then
				-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): enable mouse " .. tostring(aloftData.name) .. "/" .. tostring(self.db.profile.enableMouse) .. "/" .. tostring(false))
				nameplateFrame:EnableMouse(false) -- logic seems inverted
			else
				-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): disable mouse " .. tostring(aloftData.name) .. "/" .. tostring(self.db.profile.enableMouse) .. "/" .. tostring(true))
				nameplateFrame:EnableMouse(true) -- logic seems inverted
			end
		else
			-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): invisible mouse " .. tostring(aloftData.name) .. "/" .. tostring(self.db.profile.enableMouse) .. "/" .. tostring(true))
			nameplateFrame:EnableMouse(true) -- logic seems inverted
		end
		-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): nameplate frame level " .. tostring(nameplateFrame:GetFrameLevel()))
		-- nameplateFrame:SetFrameLevel(1) -- highlight region and other objects should lay out on the very top
	end

	local layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	if layoutFrame then
		layoutFrame:ClearAllPoints()

		-- size the reference frame
		layoutFrame:SetWidth(self.db.profile.width)
		layoutFrame:SetHeight(self.db.profile.height)

		-- place the reference frame
		layoutFrame:SetPoint("CENTER", nameplateFrame, "CENTER", self.db.profile.offsetX, self.db.profile.offsetY)
	else
		-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): nil layoutFrame " .. tostring(aloftData.name))
	end

	local texture = SML:Fetch("background", self.db.profile.background)
	local inset, edgeFile = self:GetBorder(aloftData)
	local level = nameplateFrame:GetFrameLevel()

	-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): backdrop " .. tostring(aloftData.name))
	local backdropFrame = self:AcquireBackdropFrame(aloftData)
	backdropFrame:SetFrameLevel((level > 0 and level - 1) or 0)
	backdropFrame:SetAlpha(1)
	backdropFrame:Hide()

	backdropFrame:ClearAllPoints()

	-- always place the backdrop frame relative to the nameplate frame
	backdropFrame:SetWidth(self.db.profile.width + (2 * inset))
	backdropFrame:SetHeight(self.db.profile.height + (2 * inset))

	backdropFrame:SetPoint("CENTER", nameplateFrame, "CENTER", self.db.profile.offsetX, self.db.profile.offsetY) -- NOTE: positionally coupling layoutFrame to backdropFrame seems to result in display artifacts

	backdropTable.insets.left = inset
	backdropTable.insets.right = inset
	backdropTable.insets.top = inset
	backdropTable.insets.bottom = inset
	backdropTable.edgeFile = edgeFile
	backdropTable.edgeSize = self.db.profile.borderEdgeSize
	backdropTable.bgFile = texture

	-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): " .. tostring(inset) .. "/" .. tostring(texture) .. "/" .. tostring(edgeFile))

	-- NOTE: this dead code is relevant to various #132 crash experiments 
	-- backdropFrame:SetBackdrop( { insets = { left = inset, right = inset, top = inset, bottom = inset, }, edgeFile = edgeFile, edgeSize = 16, bgFile = texture, } )
	-- backdropFrame:SetBackdrop( { insets = { left = 4, right = 4, top = 4, bottom = 4, },
	--								edgeSize = 16, edgeFile = [[Interface\Addons\SharedMedia\border\roth]],
	--								bgFile = [[Interface\AddOns\Forte_Core\Textures\Minimalist]], } )

	backdropFrame:SetBackdrop(backdropTable)
	-- backdropFrame:SetBackdropBorderColor(unpack(self.db.profile.borderColor))
	-- self:ClearBackdropColor(aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): backdrop cleared")

	--[[
	ChatFrame7:AddMessage("AloftFrame:SetupFrame(): backdrop #regions " .. tostring(backdropFrame:GetNumRegions()))
	local bdfR1, bdfR2, bdfR3, bdfR4, bdfR5, bdfR6, bdfR7, bdfR8, bdfR9 = backdropFrame:GetRegions()
	self:DumpRegion("bdfR1", bdfR1)
	self:DumpRegion("bdfR2", bdfR2)
	self:DumpRegion("bdfR3", bdfR3)
	self:DumpRegion("bdfR4", bdfR4)
	self:DumpRegion("bdfR5", bdfR5)
	self:DumpRegion("bdfR6", bdfR6)
	self:DumpRegion("bdfR7", bdfR7)
	self:DumpRegion("bdfR8", bdfR8)
	self:DumpRegion("bdfR9", bdfR9)
	]]

	-- pull this out and hoist it up to a slightly higher draw layer, there is "something" obscuring it in the default/"BACKGROUND" layer;
	-- rely on frame level to reder this (more-or-less) properly
	-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): bgRegion regions #" .. tostring(backdropFrame:GetNumRegions()))
	local bgRegion = backdropFrame:GetRegions()
	-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): bgRegion texture " .. tostring(bgRegion:GetTexture()))
	if bgRegion then
		bgRegion:SetDrawLayer("BORDER")
		bgRegion:SetBlendMode("BLEND")
	end

	-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): done " .. tostring(aloftData.name) .. "/" .. tostring(inset) .. "/" .. tostring(backdropFrame:GetHeight()) .. "/" .. tostring(backdropFrame:GetWidth()))
end

-----------------------------------------------------------------------------

function AloftFrame:AcquireBackdropFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	if not layoutFrame then
		ChatFrame7:AddMessage("AloftFrame:AcquireBackdropFrame(): no layoutFrame " .. tostring(aloftData.name))
		ChatFrame7:AddMessage("AloftFrame:AcquireBackdropFrame(): " .. debugstack())
	end
	local backdropFrame = layoutFrame.backdropFrame

	if not backdropFrame then
		backdropFrame = CreateFrame("Frame", nil, layoutFrame) -- NOTE: needs a parent for frame layering/Frame:SetFrameLevel() to work correctly

		layoutFrame.backdropFrame = backdropFrame
		backdropFrame.layoutFrame = layoutFrame
	end

	return backdropFrame
end

function AloftFrame:ReleaseBackdropFrame(aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:ReleaseBackdropFrame(): release " .. aloftData.name)
	self:CleanupBackdropFrame(aloftData)
	self:RePoolBackdropFrame(aloftData)
end

function AloftFrame:CleanupBackdropFrame(aloftData)
	local layoutFrame = aloftData and aloftData.layoutFrame
	local backdropFrame = layoutFrame and layoutFrame.backdropFrame
	if backdropFrame then
		AloftFrame:ClearBackdrop(backdropFrame)
		self:ClearBackdropColor(aloftData)
	end
end

function AloftFrame:RePoolBackdropFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local backdropFrame = layoutFrame and layoutFrame.backdropFrame
	if backdropFrame then
		backdropFrame:Hide()
	end
end

function AloftFrame:ClearBackdrop(backdropFrame)
	if backdropFrame then
		backdropFrame:SetBackdropColor(0, 0, 0, 0) -- TODO: this is currently redundant on nameplate hide; refactor this to clean it up
		backdropFrame:SetBackdropBorderColor(0, 0, 0, 0)

		-- NOTE: doing this on nameplate hide may case #132 crashes
		-- backdropFrame:SetBackdrop(defaultBackdropTable)
	end
end

-----------------------------------------------------------------------------

function AloftFrame:SetBackgroundColor(aloftData, color)
	if color then
		self:SetAtomicBackgroundColor(aloftData, color[1], color[2], color[3], self.db.profile.backgroundAlpha)
	-- else
	--	ChatFrame7:AddMessage("AloftFrame:SetBackgroundColor(): no color " .. debugstack())
	end
end

function AloftFrame:SetBackgroundColorRgb(aloftData, color)
	if color then
		self:SetAtomicBackgroundColor(aloftData, color.r, color.g, color.b, self.db.profile.backgroundAlpha)
	-- else
	--	ChatFrame7:AddMessage("AloftFrame:SetBackgroundColorRgb(): no color " .. debugstack())
	end
end

function AloftFrame:SetAtomicBackgroundColor(aloftData, r, g, b, a)
	-- ChatFrame7:AddMessage("AloftFrame:SetAtomicBackgroundColor(): enter")
	local layoutFrame = aloftData.layoutFrame
	local backdropFrame = layoutFrame and layoutFrame.backdropFrame
	if backdropFrame then
		-- if backdrop frame alpha/border settings render it invisible, go ahead and hide it, don't bother with borders/etc
		if (a <= 0 and self.db.profile.border == "None") or aloftData.name == "[invalid]" then
			--[[
			ChatFrame7:AddMessage("AloftFrame:SetAtomicBackgroundColor(): hide " .. tostring(aloftData.name) .. "/" .. tostring(aloftData) .. "/" .. tostring(a) .. "/" .. tostring(self.db.profile.border))
			ChatFrame7:AddMessage("AloftFrame:SetAtomicBackgroundColor(): " .. debugstack())
			]]

			backdropFrame:Hide()
		else
			--[[
			ChatFrame7:AddMessage("AloftFrame:SetAtomicBackgroundColor(): show " .. tostring(aloftData.name) .. "/" .. tostring(aloftData) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(aloftData.class))
			ChatFrame7:AddMessage("AloftFrame:SetAtomicBackgroundColor(): " .. tostring(backdropFrame:GetAlpha())
				.. "|" .. tostring(r) .. "-" .. tostring(g) .. "-" .. tostring(b) .. "-" .. tostring(a)
				.. "/" .. floor(255*r) .. "." .. floor(255*g) .. "." .. floor(255*b) .. "." .. floor(255*a)
				.. "/" .. ("|c%02x%02x%02x%02xcolor|r"):format(floor(255*a), floor(255*r), floor(255*g), floor(255*b)))
			]]


			-- NOTE: really CRYPTIC frame-delay workaround for an apparent Blizzard problem; lots of time spent on this issue
			--
			--       what we apparently have to do here, to prevent graphic artifacts in the backdrop frame border, is set the backdrop frame
			--       backdrop color to something bogus, wait a game frame (no show needed yet?!?), and then set the backdrop frame backdrop
			--       color to what we actually want, and THEN show; needs a temporary table to pass the arguments, and the whole circus;
			--       blech, i HATE this
			--
			-- NOTE: this weirdness was noticed by mousing over PC nameplates that evinced a malformed border, with class colors enabled,
			--       which resets the backdrop frame backdrop color, and coincidentally also cleared the malformed border... hence the
			--       redundant flipping of backdrop color on every nameplate when its backdrop color is set
			--
			-- TODO: arrange for this flipping to happen only on nameplates on which the frame border is visible? seems harmless, but would
			--       save a little heap overhead

			backdropFrame:SetBackdropColor(0, 0, 0, 0.1) -- set a bogus color (basically clears the default/residual color), non-transparent (to force a draw)
			backdropFrame:SetBackdropBorderColor(0, 0, 0, 0.1) -- set a bogus color (basically clears the default/residual color), non-transparent (to force a draw)
			-- backdropFrame:SetBackdropColor(r, g, b, a) -- we delay applying the actual color we want
			backdropFrame:Show() -- show, just to make sure?

			-- frame delay to set the real color and show; 2010/11/05 frame delay verified as required, flipping the color inline does not have any effect
			self:ScheduleTimer(function(arg) AloftFrame:DoSetAtomicBackgroundColor(arg) end, 0.15, { backdropFrame = backdropFrame, r = r, g = g, b = b, a = a, }) -- a bit more than one frame

			--[[
			ChatFrame7:AddMessage("AloftFrame:SetAtomicBackgroundColor(): backdrop #regions " .. tostring(backdropFrame:GetNumRegions()))
			local bdfR1, bdfR2, bdfR3, bdfR4, bdfR5, bdfR6, bdfR7, bdfR8, bdfR9 = backdropFrame:GetRegions()
			self:DumpRegion("bdfR1", bdfR1)
			self:DumpRegion("bdfR2", bdfR2)
			self:DumpRegion("bdfR3", bdfR3)
			self:DumpRegion("bdfR4", bdfR4)
			self:DumpRegion("bdfR5", bdfR5)
			self:DumpRegion("bdfR6", bdfR6)
			self:DumpRegion("bdfR7", bdfR7)
			self:DumpRegion("bdfR8", bdfR8)
			self:DumpRegion("bdfR9", bdfR9)
			]]
		end

		-- ChatFrame7:AddMessage("AloftFrame:SetAtomicBackgroundColor(): " .. tostring(aloftData.name) .. "/" .. tostring(backdropFrame:GetAlpha()) .. "/" .. tostring(r) .. "-" .. tostring(g) .. "-" .. tostring(b) .. "-" .. tostring(a) .. "/" .. floor(255*r) .. "." .. floor(255*g) .. "." .. floor(255*b) .. "." .. floor(255*a) .. "/" .. ("|c%02x%02x%02x%02xcolor|r"):format(floor(255*a), floor(255*r), floor(255*g), floor(255*b)))
		-- ChatFrame7:AddMessage("AloftFrame:SetAtomicBackgroundColor(): " .. debugstack())
	--[[
	else
		ChatFrame7:AddMessage("AloftFrame:SetAtomicBackgroundColor(): no backdropFrame " .. tostring(aloftData.name))
	]]
	end
end

function AloftFrame:DoSetAtomicBackgroundColor(arg)
	local backdropFrame = arg.backdropFrame
	backdropFrame:SetBackdropColor(arg.r, arg.g, arg.b, arg.a)
	backdropFrame:SetBackdropBorderColor(unpack(self.db.profile.borderColor))
	backdropFrame:Show()
	-- NOTE: this show works here, apparently the nameplate backdrop does not need to be visible in order to goose the border graphics;
	--       also seems to avoid flickering resulting from the malformed border showing for a frame and then the fixed border appearing
end

-----------------------------------------------------------------------------

--[[
function AloftFrame:DumpCoords(aloftData)
	local nameplateFrame = aloftData.nameplateFrame

	local nLeft = nameplateFrame:GetLeft()
	local nRight = nameplateFrame:GetRight()
	local nTop = nameplateFrame:GetTop()
	local nBottom = nameplateFrame:GetBottom()
	ChatFrame7:AddMessage("AloftFrame:DumpCoords(): nmplat " .. tostring(aloftData.name) .. "/" .. tostring(floor(nTop)) .. "/" .. tostring(floor(nLeft)) .. "/" .. tostring(floor(nBottom)) .. "/" .. tostring(floor(nRight)))

	local layoutFrame = aloftData.layoutFrame

	local lLeft = layoutFrame:GetLeft()
	local lRight = layoutFrame:GetRight()
	local lTop = layoutFrame:GetTop()
	local lBottom = layoutFrame:GetBottom()
	ChatFrame7:AddMessage("AloftFrame:DumpCoords(): layout " .. tostring(aloftData.name) .. "/" .. tostring(floor(lTop)) .. "/" .. tostring(floor(lLeft)) .. "/" .. tostring(floor(lBottom)) .. "/" .. tostring(floor(lRight)))
end
]]

function AloftFrame:OnNameplateShow(message, aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:OnNameplateShow(): " .. tostring(message))
	-- self:DoNameplateShow(aloftData)
	self:ScheduleTimer(function(aloftData) AloftFrame:DoNameplateShow(aloftData) end, 0.1, aloftData) -- a bit more than next frame
	-- self:ScheduleTimer(function(aloftData) AloftFrame:DumpCoords(aloftData) end, 0.3, aloftData)
end

function AloftFrame:OnNameplateHide(message, aloftData)
	frameUpdateList[aloftData] = nil
	self:ReleaseBackdropFrame(aloftData)
end

function AloftFrame:OnIsTargetDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:OnIsTargetDataChanged(): " .. tostring(message))
	self:ScheduleTimer(function(aloftData) AloftFrame:OnNameplateShow("AloftHealthBar:OnIsTargetDataChanged", aloftData) end, 0.1, aloftData) -- a bit more than next frame
end

function AloftFrame:OnCombatFinished(event)
	-- ChatFrame7:AddMessage("AloftFrame:OnCombatFinished(): " .. tostring(event))
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateShow(event, aloftData)
		frameUpdateList[aloftData] = nil
	end
end

-----------------------------------------------------------------------------

function AloftFrame:DoNameplateShow(aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:DoNameplateShow(): show " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:SetupFrame("AloftFrame:DoNameplateShow", aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:DoNameplateShow(): set backdrop color")
	backgroundColorMethod(self, aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:DoNameplateShow(): backdrop color set")
	-- ChatFrame7:AddMessage("AloftFrame:OnNameplateShow(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:GetFrameLevel()) .. "/" .. tostring(aloftData.healthBar and aloftData.healthBar:GetFrameLevel()) .. "/" .. tostring(layoutFrame.backdropFrame and layoutFrame.backdropFrame:GetFrameLevel()) .. "/" .. tostring(aloftData.layoutFrame and aloftData.layoutFrame:GetFrameLevel()))
end

-----------------------------------------------------------------------------

function AloftFrame:ColourFriendlyPlayer(aloftData)
	if self.db.profile.colorByClass then
		local class = aloftData.class
		if class then
			local color = Aloft.db.profile.classColors[class]
			if color then
				self:SetBackgroundColor(aloftData, color)
				return
			end
		end
	end
	self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors.friendlyPlayer)
end

function AloftFrame:ColourFriendlyNPC(aloftData)
	-- Could be player pet, group pet, friendly pet, friendlyBoss, or friendlyNPC
	if aloftData.name == UnitName("pet") then
		self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors.pet)
	elseif aloftData.unitid then
		self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors.groupPet)
	elseif aloftData.isPet then
		self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors.friendlyPet)
	elseif aloftData.isBoss then
		self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors.friendlyBoss)
	else
		self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors.friendlyNPC)
	end
end

function AloftFrame:ColourHostile(aloftData)
	-- player, hostile pet, hostile boss, hostileNPC
	if self.db.profile.colorHostileByClass then
		local class = aloftData.class
		if class then
			local color = Aloft.db.profile.classColors[class]
			if color then
				self:SetBackgroundColor(aloftData, color)
				return
			end
		end
	end

	if aloftData.class then
		self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors.hostilePlayer)
	elseif aloftData.isPet then
		self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors.hostilePet)
	elseif aloftData.isBoss then
		self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors.hostileBoss)
	else
		self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors.hostileNPC)
	end
end

function AloftFrame:ColourNeutral(aloftData)
	self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors.neutral)
end

function AloftFrame:ColourUnknown(aloftData)
	self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors.unknown)
end

local backgroundColorMethods =
{
	friendlyPlayer = AloftFrame.ColourFriendlyPlayer,
	friendlyNPC = AloftFrame.ColourFriendlyNPC,
	hostile = AloftFrame.ColourHostile,
	hostilePlayer = AloftFrame.ColourHostile,
	neutral = AloftFrame.ColourNeutral,
	unknown = AloftFrame.ColourUnknown,
}

local backgroundTypeColorLookup =
{
	friendlyPlayer = "friendlyPlayer",
	friendlyNPC = "friendlyNPC",
	hostile = "hostileNPC",
	neutral = "neutral",
	unknown = "unknown",
}

-----------------------------------------------------------------------------

-- when background alpha is 0
function AloftFrame:ClearBackdropColor(aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:ClearBackdropColor(): enter")
	self:SetAtomicBackgroundColor(aloftData, 0, 0, 0, 0)
end

-- when background alpha is > 0 and class colors are being requested
function AloftFrame:SetBackdropColor(aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:SetBackdropColor(): enter")
	if not aloftData then return end
	if self.db.profile.colorFormat and self.db.profile.colorFormat ~= "" and (not self.colorMethodData or not self.colorMethod) then
		self.colorMethodData = Aloft:CreateTag(self.db.profile.colorFormat, true)
		self.colorMethod = self.colorMethodData.method
		-- ChatFrame7:AddMessage("AloftFrame:SetBackdropColor(): establish color method")
	end

	local override = (self.colorMethod and self.colorMethod(aloftData)) or nil
	if override and #override >= 6 then
		local rhex, ghex, bhex = override:sub(1, 2), override:sub(3, 4), override:sub(5, 6)
		self:SetAtomicBackgroundColor(aloftData, tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255, self.db.profile.backgroundAlpha)
	else
		-- ChatFrame7:AddMessage("AloftFrame:SetBackdropColor(): set background color " .. tostring(aloftData.name))
		backgroundColorMethods[aloftData.type](self, aloftData)
	end
end

function AloftFrame:SetBackdropColorByType(aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:SetBackdropColorByType(): enter")
	if not aloftData then
		-- ChatFrame7:AddMessage("AloftFrame:SetBackdropColorByType(): no aloftData")
		return
	end

	if self.db.profile.colorFormat and self.db.profile.colorFormat ~= "" and (not self.colorMethodData or not self.colorMethod) then
		self.colorMethodData = Aloft:CreateTag(self.db.profile.colorFormat, true)
		self.colorMethod = self.colorMethodData.method
		-- ChatFrame7:AddMessage("AloftFrame:SetBackdropColorByType(): establish color method")
	end

	local override = (self.colorMethod and self.colorMethod(aloftData)) or nil
	if override and #override >= 6 then
		local rhex, ghex, bhex = override:sub(1, 2), override:sub(3, 4), override:sub(5, 6)
		-- ChatFrame7:AddMessage("AloftFrame:SetBackdropColorByType(): set override color")
		self:SetAtomicBackgroundColor(aloftData, tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255, self.db.profile.backgroundAlpha)
	else
		-- ChatFrame7:AddMessage("AloftFrame:SetBackdropColorByType(): set background color " .. tostring(aloftData.name))
		self:SetBackgroundColor(aloftData, self.db.profile.backgroundColors[backgroundTypeColorLookup[aloftData.type]])
	end
end

-----------------------------------------------------------------------------

--[[
function AloftFrame:DumpRegion(name, region)
	if region then
		local type = region:GetObjectType()
		local texture = region:GetTexture()
		local alpha = region:GetAlpha()
		local r, g, b, a = region:GetVertexColor()

		ChatFrame7:AddMessage("AloftFrame:DumpRegion(): region " .. tostring(name) .. "/" .. tostring(type) .. "/" .. tostring(texture) .. "/" .. tostring(alpha)
			.. "|" .. tostring(r) .. "-" .. tostring(g) .. "-" .. tostring(b) .. "-" .. tostring(a)
			.. "/" .. floor(255*r) .. "." .. floor(255*g) .. "." .. floor(255*b) .. "." .. floor(255*a)
			.. "/" .. ("|c%02x%02x%02x%02xcolor|r"):format(floor(255*a), floor(255*r), floor(255*g), floor(255*b)))
	end
end
]]

-----------------------------------------------------------------------------
