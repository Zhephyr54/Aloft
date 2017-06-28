local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftFrame = Aloft:NewModule("Frame", "AceEvent-2.0")

local SML = AceLibrary("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftFrame.db = Aloft:AcquireDBNamespace("frame")
AloftFrame.healthBarDB = Aloft:AcquireDBNamespace("healthBar")
Aloft:RegisterDefaults("frame", "profile", {
	enableMouse			= true,
	background			= "Solid",
	targetOnly			= false,
	border				= "None",
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
})

-----------------------------------------------------------------------------

AloftFrame.colorMethod = nil
AloftFrame.colorMethodData = { }

local frameUpdateList = { }

local profile
local backgroundColors
local backgroundColorMethod

-----------------------------------------------------------------------------

function AloftFrame:UpdateAll()
	-- ChatFrame7:AddMessage("AloftFrame:UpdateAll(): enter")

	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame(aloftData)
	end
	if profile and profile.enable then
		for layoutFrame in pairs(Aloft.layoutFramePool) do
			local backdropFrame = layoutFrame.backdropFrame
			if backdropFrame then
				backdropFrame:Hide()
			end
		end
	end

	Aloft:GetModule("HealthBar"):UpdateAll()
	if Aloft:HasModule("ManaBar") then Aloft:GetModule("ManaBar"):UpdateAll() end
	if Aloft:HasModule("ThreatBar") then Aloft:GetModule("ThreatBar"):UpdateAll() end
	if Aloft:HasModule("CrowdControl") then Aloft:GetModule("CrowdControl"):UpdateAll() end

	-- ChatFrame7:AddMessage("AloftFrame:UpdateAll(): exit")
end

function AloftFrame:RegisterEvents()
	self:UnregisterAllEvents()

	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnCombatFinished")

	-- no background, the default
	backgroundColorMethod = AloftFrame.ClearBackdropColor

    -- Si cette méthode est appelée avant OnInitialize
    -- permet d'éviter que profile soit non initialisé
    if (profile == nil) then AloftFrame:OnInitialize() end
    
	if (profile.backgroundAlpha ~= 0) and
	   (not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.friendlyPet) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.friendlyNPC) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.friendlyBoss) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.hostilePlayer) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.hostilePet) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.hostileNPC) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.hostileBoss) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.neutral) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.pet) or
		not self:IsArrayEqual(backgroundColors.friendlyPlayer, backgroundColors.groupPet) or
		profile.colorByClass or
		profile.colorHostileByClass or
		profile.colorFormat ~= "") then

		if not profile.colorByClass and
		   not profile.colorHostileByClass and
		   (self:IsArrayEqual(backgroundColors.friendlyNPC, backgroundColors.friendlyPet) and
			self:IsArrayEqual(backgroundColors.friendlyNPC, backgroundColors.friendlyBoss) and
			self:IsArrayEqual(backgroundColors.friendlyNPC, backgroundColors.pet) and
			self:IsArrayEqual(backgroundColors.friendlyNPC, backgroundColors.groupPet)) and
		   (self:IsArrayEqual(backgroundColors.hostilePlayer, backgroundColors.hostilePet) and
			self:IsArrayEqual(backgroundColors.hostilePlayer, backgroundColors.hostileNPC) and
			self:IsArrayEqual(backgroundColors.hostilePlayer, backgroundColors.hostileBoss)) then
			-- type colors in background
			backgroundColorMethod = AloftFrame.SetBackdropColorByType
		else
			-- class colors in background
			backgroundColorMethod = AloftFrame.SetBackdropColor
		end
	end

	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnNameplateShow")

	if profile.backgroundAlpha ~= 0 then
		if profile.colorByClass or profile.colorHostileByClass then
			self:RegisterEvent("Aloft:OnClassDataChanged", "OnNameplateShow")
		end

		if not self:IsArrayEqual(backgroundColors.friendlyPet, backgroundColors.friendlyNPC) or
		   not self:IsArrayEqual(backgroundColors.hostilePet, backgroundColors.hostileNPC) then
			self:RegisterEvent("Aloft:OnIsPetDataChanged", "OnNameplateShow")
		end
		for events in pairs(self.colorMethodData.events) do
			self:RegisterEvent(events, "OnNameplateShow")
		end
	end

end

-----------------------------------------------------------------------------

function AloftFrame:OnInitialize()
	profile = self.db.profile
	backgroundColors = profile.backgroundColors

	AloftCrowdControl = Aloft:HasModule("CrowdControl") and Aloft:GetModule("CrowdControl")
	AloftManaBar = Aloft:HasModule("ManaBar") and Aloft:GetModule("ManaBar")
	AloftThreatBar = Aloft:HasModule("ThreatBar") and Aloft:GetModule("ThreatBar")
end

function AloftFrame:OnEnable()
	--AloftManaBar = Aloft:HasModule("ManaBar") and Aloft:GetModule("ManaBar")
	--AloftThreatBar = Aloft:HasModule("ThreatBar") and Aloft:GetModule("ThreatBar")
	self:UpdateAll()
end

function AloftFrame:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local layoutFrame = aloftData.layoutFrame
		if layoutFrame then
			local backdropFrame = layoutFrame.backdropFrame
			if backdropFrame then
				backdropFrame:Hide()
			end
		end
	end
end

local dataRequiredList = { }
function AloftFrame:RequiresData()
	if not self.colorMethodData or not self.colorMethod then
		self.colorMethodData = Aloft:CreateTag(profile.colorFormat, true)
		self.colorMethod = self.colorMethodData.method
		-- ChatFrame7:AddMessage("AloftFrame:RequiresData(): establish color method")
	end

	self:RegisterEvents()

	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	if profile.backgroundAlpha ~= 0 then
		if profile.colorByClass or
		   profile.colorHostileByClass or
		   not self:IsArrayEqual(backgroundColors.hostileNPC, backgroundColors.hostilePlayer) then
			table.insert(dataRequiredList, "class")
		end

		if not self:IsArrayEqual(backgroundColors.friendlyPet, backgroundColors.friendlyNPC) or
		   not self:IsArrayEqual(backgroundColors.hostilePet, backgroundColors.hostileNPC) then
			table.insert(dataRequiredList, "isPet")
		end

		if Aloft:IsDataAvailable("unitid") and not self:IsArrayEqual(backgroundColors.friendlyPet, backgroundColors.groupPet) then
			table.insert(dataRequiredList, "unitid")
		end

		for data in pairs(self.colorMethodData.data) do
			table.insert(dataRequiredList, data)
		end
	end

	return unpack(dataRequiredList)
end

-----------------------------------------------------------------------------

local backdropTable =
{
	tile = false,
	tileSize = 16,
	edgeSize = 16,
}

function AloftFrame:GetBorder(aloftData)
	if not profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		return ((profile.border ~= "None") and 4) or 0, SML:Fetch("border", profile.border)
	else
		return 0, SML:Fetch("border", "None")
	end
end

function AloftFrame:SetupFrame(aloftData)
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

	-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): show " .. tostring(aloftData.name))

	-- if not aloftData.nameplateFrame:IsShown() then return end -- stub out if hidden
	local nameplateFrame = aloftData.nameplateFrame
	if InCombatLockdown() then
		frameUpdateList[aloftData] = true
		-- return -- TODO: watch this carefully
	else
		-- nameplate setup cannot occur during combat, but all of the rest of this can
		nameplateFrame:SetWidth(profile.packingWidth+profile.width)
		nameplateFrame:SetHeight(profile.packingHeight+profile.height)
		if not aloftData.invisible then
			if profile.enableMouse then
				-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): enable mouse " .. tostring(aloftData.name) .. "/" .. tostring(profile.enableMouse) .. "/" .. tostring(false))
				nameplateFrame:EnableMouse(false) -- logic seems inverted
			else
				-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): disable mouse " .. tostring(aloftData.name) .. "/" .. tostring(profile.enableMouse) .. "/" .. tostring(true))
				nameplateFrame:EnableMouse(true) -- logic seems inverted
			end
		else
			-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): invisible mouse " .. tostring(aloftData.name) .. "/" .. tostring(profile.enableMouse) .. "/" .. tostring(true))
			nameplateFrame:EnableMouse(true) -- logic seems inverted
		end
		-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): nameplate frame level " .. tostring(nameplateFrame:GetFrameLevel()))
		-- nameplateFrame:SetFrameLevel(1) -- highlight region and other objects should lay out on the very top
	end

	local layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	if layoutFrame then
		-- place the reference frame
		layoutFrame:ClearAllPoints()
		layoutFrame:SetPoint("CENTER", nameplateFrame, "CENTER", profile.offsetX, profile.offsetY)

		-- size the reference frame
		layoutFrame:SetWidth(profile.width)
		layoutFrame:SetHeight(profile.height)
	else
		-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): nil layoutFrame " .. tostring(aloftData.name))
	end

	local texture = SML:Fetch("background", profile.background)
	local inset, edgeFile = self:GetBorder(aloftData)
	local level = nameplateFrame:GetFrameLevel()

	-- ChatFrame7:AddMessage("AloftFrame:SetupFrame(): backdrop " .. tostring(aloftData.name))
	local backdropFrame = self:AcquireBackdropFrame(aloftData)
	backdropFrame:SetFrameLevel((level > 0 and level - 1) or 0)
	backdropFrame:SetAlpha(1)
	backdropFrame:Hide()

	-- always place the backdrop frame relative to the nameplate frame
	backdropFrame:SetWidth(profile.width + (2 * inset))
	backdropFrame:SetHeight(profile.height + (2 * inset))

	backdropFrame:ClearAllPoints()
	backdropFrame:SetPoint("CENTER", nameplateFrame, "CENTER", profile.offsetX, profile.offsetY) -- NOTE: positionally coupling layoutFrame to backdropFrame seems to result in display artifacts

	backdropTable.insets = { left = inset, right = inset, top = inset, bottom = inset }
	backdropTable.edgeFile = edgeFile
	backdropTable.bgFile = texture

	backdropFrame:SetBackdrop(backdropTable)
	backdropFrame:SetBackdropBorderColor(unpack(profile.borderColor))
	self:ClearBackdropColor(aloftData)
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
	if backdropFrame then
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

-----------------------------------------------------------------------------

function AloftFrame:SetBackgroundColor(aloftData, color)
	if color then
		self:SetAtomicBackgroundColor(aloftData, color[1], color[2], color[3], profile.backgroundAlpha)
	-- else
	--	ChatFrame7:AddMessage("AloftFrame:SetBackgroundColor(): no color " .. debugstack())
	end
end

function AloftFrame:SetBackgroundColorRgb(aloftData, color)
	if color then
		self:SetAtomicBackgroundColor(aloftData, color.r, color.g, color.b, profile.backgroundAlpha)
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
		if (a <= 0 and profile.border == "None") or aloftData.name == "[invalid]" then
			--[[
			ChatFrame7:AddMessage("AloftFrame:SetAtomicBackgroundColor(): hide " .. tostring(aloftData.name) .. "/" .. tostring(aloftData) .. "/" .. tostring(a) .. "/" .. tostring(profile.border))
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

			backdropFrame:SetBackdropColor(r, g, b, a)
			backdropFrame:Show()

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

-----------------------------------------------------------------------------

function AloftFrame:OnNameplateShow(aloftData)
	self:DoNameplateShow(aloftData)
	--[[
	local eventName = "AloftFrame:DoNameplateShow:" .. ":" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.DoNameplateShow, 0.0, self, aloftData) -- seems to need a little bit more than next frame in order to get background alpha correct
	]]
end

function AloftFrame:OnNameplateHide(aloftData)
	frameUpdateList[aloftData] = nil
	self:ReleaseBackdropFrame(aloftData)
end

function AloftFrame:OnIsTargetDataChanged(aloftData)
	self:OnNameplateShow(aloftData)
end

function AloftFrame:OnCombatFinished()
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateShow(aloftData)
		frameUpdateList[aloftData] = nil
	end
end

-----------------------------------------------------------------------------

function AloftFrame:DoNameplateShow(aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:DoNameplateShow(): show " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:SetupFrame(aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:DoNameplateShow(): set backdrop color")
	backgroundColorMethod(self, aloftData)
	-- ChatFrame7:AddMessage("AloftFrame:DoNameplateShow(): backdrop color set")
	-- ChatFrame7:AddMessage("AloftFrame:OnNameplateShow(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:GetFrameLevel()) .. "/" .. tostring(aloftData.healthBar and aloftData.healthBar:GetFrameLevel()) .. "/" .. tostring(layoutFrame.backdropFrame and layoutFrame.backdropFrame:GetFrameLevel()) .. "/" .. tostring(aloftData.layoutFrame and aloftData.layoutFrame:GetFrameLevel()))
end

-----------------------------------------------------------------------------

function AloftFrame:ColourFriendlyPlayer(aloftData)
	if profile.colorByClass then
		local class = aloftData.class
		if class then
			local color = Aloft.db.profile.classColors[class]
			if color then
				self:SetBackgroundColor(aloftData, color)
				return
			end
		end
	end
	self:SetBackgroundColor(aloftData, backgroundColors.friendlyPlayer)
end

function AloftFrame:ColourFriendlyNPC(aloftData)
	-- Could be player pet, group pet, friendly pet, friendlyBoss, or friendlyNPC
	if aloftData.name == UnitName("pet") then
		self:SetBackgroundColor(aloftData, backgroundColors.pet)
	elseif aloftData.unitid then
		self:SetBackgroundColor(aloftData, backgroundColors.groupPet)
	elseif aloftData.isPet then
		self:SetBackgroundColor(aloftData, backgroundColors.friendlyPet)
	elseif aloftData.isBoss then
		self:SetBackgroundColor(aloftData, backgroundColors.friendlyBoss)
	else
		self:SetBackgroundColor(aloftData, backgroundColors.friendlyNPC)
	end
end

function AloftFrame:ColourHostile(aloftData)
	-- player, hostile pet, hostile boss, hostileNPC
	if profile.colorHostileByClass then
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
		self:SetBackgroundColor(aloftData, backgroundColors.hostilePlayer)
	elseif aloftData.isPet then
		self:SetBackgroundColor(aloftData, backgroundColors.hostilePet)
	elseif aloftData.isBoss then
		self:SetBackgroundColor(aloftData, backgroundColors.hostileBoss)
	else
		self:SetBackgroundColor(aloftData, backgroundColors.hostileNPC)
	end
end

function AloftFrame:ColourNeutral(aloftData)
	self:SetBackgroundColor(aloftData, backgroundColors.neutral)
end

function AloftFrame:ColourUnknown(aloftData)
	self:SetBackgroundColor(aloftData, backgroundColors.unknown)
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
	if not self.colorMethodData or not self.colorMethod then
		self.colorMethodData = Aloft:CreateTag(profile.colorFormat, true)
		self.colorMethod = self.colorMethodData.method
		-- ChatFrame7:AddMessage("AloftFrame:SetBackdropColor(): establish color method")
	end

	local override = (self.colorMethod and self.colorMethod(aloftData)) or nil
	if override and #override >= 6 then
		local rhex, ghex, bhex = override:sub(1, 2), override:sub(3, 4), override:sub(5, 6)
		self:SetAtomicBackgroundColor(aloftData, tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255, profile.backgroundAlpha)
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

	if not self.colorMethodData or not self.colorMethod then
		self.colorMethodData = Aloft:CreateTag(profile.colorFormat, true)
		self.colorMethod = self.colorMethodData.method
		-- ChatFrame7:AddMessage("AloftFrame:SetBackdropColorByType(): establish color method")
	end

	local override = (self.colorMethod and self.colorMethod(aloftData)) or nil
	if override and #override >= 6 then
		local rhex, ghex, bhex = override:sub(1, 2), override:sub(3, 4), override:sub(5, 6)
		-- ChatFrame7:AddMessage("AloftFrame:SetBackdropColorByType(): set override color")
		self:SetAtomicBackgroundColor(aloftData, tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255, profile.backgroundAlpha)
	else
		-- ChatFrame7:AddMessage("AloftFrame:SetBackdropColorByType(): set background color " .. tostring(aloftData.name))
		self:SetBackgroundColor(aloftData, backgroundColors[backgroundTypeColorLookup[aloftData.type]])
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
