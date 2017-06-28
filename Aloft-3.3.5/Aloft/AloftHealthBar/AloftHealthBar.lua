local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

if not Aloft:HasModule("Frame") then return end

local AloftHealthBar = Aloft:NewModule("HealthBar", "AceEvent-2.0")
local SML = AceLibrary("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftHealthBar.db = Aloft:AcquireDBNamespace("healthBar")
-- AloftHealthBar.frameDB = Aloft:AcquireDBNamespace("frame")
Aloft:RegisterDefaults("healthBar", "profile", {
	texture				= "Blizzard",
	height				= 11,
	alpha				= 1.0,
	colorByClass		= true,
	colorHostileByClass = true,
	targetOnly			= true,
	border				= "None",
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
})

-----------------------------------------------------------------------------

AloftHealthBar.colorMethod = nil
AloftHealthBar.colorMethodData = { }

local profile
local colors

-----------------------------------------------------------------------------

function AloftHealthBar:UpdateAll()
	-- ChatFrame7:AddMessage("AloftHealthBar:UpdateAll(): enter")
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateShow(aloftData)
	end
	-- ChatFrame7:AddMessage("AloftHealthBar:UpdateAll(): exit")
end

function AloftHealthBar:UpdateSizesAll()
	--[[
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateShow(aloftData)
	end
	]]

	Aloft:GetModule("Frame"):UpdateAll() -- this ends up calling AloftHealthBar:UpdateAll()
	Aloft:GetModule("Overlay"):UpdateAll()
end

-----------------------------------------------------------------------------

function AloftHealthBar:RegisterEvents()
	self:UnregisterAllEvents()

	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterEvent("Aloft:OnHealthBarValueChanged", "Update")
	self:RegisterEvent("Aloft:OnHealthBarColorChanged", "OnHealthBarColorChanged")
	self:RegisterEvent("Aloft:OnUnitidDataChanged", "OnUnitidDataChanged")

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

	if profile.colorByClass or -- both friendly and hostile class discovery is of interest
	   profile.colorHostileByClass then
		self:RegisterEvent("Aloft:OnClassDataChanged", "OnClassDataChanged")
	end

	if not self:IsArrayEqual(colors.friendlyPet, colors.friendlyNPC) or
	   not self:IsArrayEqual(colors.hostilePet, colors.hostileNPC) then
		self:RegisterEvent("Aloft:OnIsPetDataChanged", "Update")
	end

	if self.colorMethodData and self.colorMethodData.events then
		for events in pairs(self.colorMethodData.events) do
			-- ChatFrame7:AddMessage("AloftHealthBar:RegisterEvents(): register event " .. events)
			self:RegisterEvent(events, "Update")
		end
	end
end

function AloftHealthBar:OnInitialize()
	profile = self.db.profile
	colors = profile.colors
end

function AloftHealthBar:OnEnable()
	Aloft:DebugRegister("HealthBar")

	self:UpdateAll()
	self:UpdateSizesAll()
end

local defaultBackdropTable = { }

function AloftHealthBar:OnDisable()
	self:UnregisterAllEvents()

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
	end
end

local dataRequiredList = { }
function AloftHealthBar:RequiresData()
	if not self.colorMethodData or not self.colorMethod then
		self.colorMethodData = Aloft:CreateTag(profile.colorFormat, true)
		self.colorMethod = self.colorMethodData.method
	end

	self:RegisterEvents()

	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	if profile.colorByClass or -- both friendly and hostile class discovery is of interest
	   profile.colorHostileByClass or
	   not self:IsArrayEqual(colors.hostileNPC, colors.hostilePlayer) then
		table.insert(dataRequiredList, "class")
	end

	if not self:IsArrayEqual(colors.friendlyPet, colors.friendlyNPC) or
	   not self:IsArrayEqual(colors.hostilePet, colors.hostileNPC) then
		table.insert(dataRequiredList, "isPet")
		table.insert(dataRequiredList, "petOwnersName")
	end

	if Aloft:IsDataAvailable("unitid") and not self:IsArrayEqual(colors.friendlyPet, colors.groupPet) then
		table.insert(dataRequiredList, "unitid")
	end

	if self.colorMethodData and self.colorMethodData.data then
		for data in pairs(self.colorMethodData.data) do
			table.insert(dataRequiredList, data)
		end
	end

	return unpack(dataRequiredList)
end

local backdropTable =
{
	tile = false,
	tileSize = 16,
	edgeSize = 16,
}

function AloftHealthBar:GetBorder(aloftData)
	if not profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		return ((profile.border ~= "None") and 4) or 0, SML:Fetch("border", profile.border)
	else
		return 0, SML:Fetch("border", "None")
	end
end

function AloftHealthBar:SetupFrame(aloftData)
	local healthBar = aloftData.healthBar
	local layoutFrame = aloftData.layoutFrame
	local nameplateFrame = aloftData.nameplateFrame

	local texture = SML:Fetch("statusbar", profile.texture)
	local inset, edgeFile = self:GetBorder(aloftData)
	local level = nameplateFrame:GetFrameLevel()

	healthBar:ClearAllPoints()
	healthBar:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", profile.offsets.left - inset, profile.offsets.vertical + inset)
	healthBar:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", profile.offsets.right + inset, profile.offsets.vertical - profile.height - inset)
	healthBar:SetStatusBarTexture(texture)
	healthBar:SetFrameLevel(level)

	backdropTable.insets = { left = inset, right = inset, top = inset, bottom = inset }
	backdropTable.edgeFile = edgeFile
	backdropTable.bgFile = texture

	healthBar:SetBackdrop(backdropTable)
	healthBar:SetBackdropColor(unpack(profile.colors.backdropColor))
	healthBar:SetBackdropBorderColor(unpack(profile.borderColor))
	-- healthBar:SetAlpha(nameplateFrame:GetAlpha())

	-- This manipulates the healthbar background to always display above the frame background
	local barRegion, backgroundRegion = healthBar:GetRegions()
	-- ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): barRegion texture " .. tostring(barRegion:GetTexture()))
	-- ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): backgroundRegion texture " .. tostring(backgroundRegion:GetTexture()))

	barRegion:ClearAllPoints()
	barRegion:SetPoint("TOPLEFT", healthBar, "TOPLEFT", inset, -inset)
	barRegion:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", -inset, inset)

	barRegion:SetDrawLayer("ARTWORK")
	barRegion:SetBlendMode("BLEND")

	backgroundRegion:SetDrawLayer("BACKGROUND")
	backgroundRegion:SetBlendMode("BLEND")

	-- ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): backdrop " .. tostring(aloftData.name) .. "/" .. tostring(layoutFrame:GetWidth()) .. "/" .. tostring(layoutFrame:GetHeight()))
	-- ChatFrame7:AddMessage("AloftHealthBar:SetupFrame(): health " .. tostring(aloftData.name) .. "/" .. tostring(inset) .. "/" .. tostring(healthBar:GetWidth()) .. "/" .. tostring(healthBar:GetHeight()))
end

function AloftHealthBar:OnNameplateShow(aloftData)
	self:SetupFrame(aloftData)
	self:Update(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:OnNameplateShow(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.nameplateFrame and aloftData.nameplateFrame:GetFrameLevel()) .. "/" .. tostring(aloftData.healthBar and aloftData.healthBar:GetFrameLevel()) .. "/" .. tostring(aloftData.backdropFrame and aloftData.backdropFrame:GetFrameLevel()) .. "/" .. tostring(aloftData.layoutFrame and aloftData.layoutFrame:GetFrameLevel()))
end

function AloftHealthBar:OnIsTargetDataChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:OnIsTargetDataChanged(): enter")
	local eventName = "AloftHealthBar:DoNameplateShow:" .. ":" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.OnNameplateShow, 0.1, self, aloftData) -- a bit more than next frame
end

-----------------------------------------------------------------------------

function AloftHealthBar:SetHealthBarColor(aloftData, color)
	self:SetHealthBarColors(aloftData, color[1], color[2], color[3])
end

function AloftHealthBar:SetHealthBarColors(aloftData, r, g, b)
	-- ChatFrame7:AddMessage("AloftHealthBar:SetHealthBarColors(): " .. aloftData.name .. "/rgb = " .. r .. "." .. g .. "." .. b)
	aloftData.healthBar:SetStatusBarColor(r, g, b, profile.alpha)

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

	local eventName = "Aloft:UpdateHealthBarColor:" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.UpdateHealthBarColor, 0.0, self, aloftData) -- next frame
end

function AloftHealthBar:UpdateHealthBarColor(aloftData)
	self:TriggerEvent("Aloft:OnSetHealthBarColor", aloftData)
end

function AloftHealthBar:ColourFriendlyPlayer(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:ColourFriendlyPlayer(): invoke " .. aloftData.name)
	if profile.colorByClass and aloftData.class then
		local color = Aloft.db.profile.classColors[aloftData.class]
		-- ChatFrame7:AddMessage("AloftHealthBar:ColourFriendlyPlayer(): class " .. aloftData.name .. "/" .. class)
		if color then
			-- aloftData.healthBar:SetStatusBarColor(color.r, color.g, color.b, profile.alpha)
			-- ChatFrame7:AddMessage("AloftHealthBar:ColourFriendlyPlayer(): color " .. aloftData.name)
			self:SetHealthBarColor(aloftData, color)
			return
		end
	end

	-- ChatFrame7:AddMessage("AloftHealthBar:ColourFriendlyPlayer(): color default " .. aloftData.name)
	self:SetHealthBarColor(aloftData, colors.friendlyPlayer)
end

function AloftHealthBar:ColourFriendlyNPC(aloftData)
	-- Could be player pet, group pet, friendly pet, friendlyBoss, or friendlyNPC
	if aloftData.name == UnitName("pet") then
		self:SetHealthBarColor(aloftData, colors.pet)
	elseif aloftData.unitid then
		self:SetHealthBarColor(aloftData, colors.groupPet)
	elseif aloftData.isPet or aloftData.petOwnersName then
		self:SetHealthBarColor(aloftData, colors.friendlyPet)
	elseif aloftData.isBoss then
		self:SetHealthBarColor(aloftData, colors.friendlyBoss)
	else
		self:SetHealthBarColor(aloftData, colors.friendlyNPC)
	end
end

function AloftHealthBar:ColourHostile(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:ColourHostile(): invoke " .. aloftData.name)
	-- player, hostile pet, hostile boss, hostileNPC

	-- ChatFrame7:AddMessage("AloftHealthBar:ColourHostile(): color default " .. aloftData.name)
	local class = aloftData.class
	if class then
		local color = Aloft.db.profile.classColors[aloftData.class]
		if profile.colorHostileByClass and color then
			self:SetHealthBarColor(aloftData, color)
			-- ChatFrame7:AddMessage("AloftHealthBar:ColourHostile(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.class))
		else
			self:SetHealthBarColor(aloftData, colors.hostilePlayer)
			-- ChatFrame7:AddMessage("AloftHealthBar:ColourHostile(): " .. class hostile " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.class))
		end
	elseif Aloft:IsTotem(aloftData) and Aloft.GetTotemExceptionColor then
		local color = Aloft:GetTotemExceptionColor(aloftData) or colors.hostileNPC
		-- ChatFrame7:AddMessage("AloftHealthBar:ColourHostile(): " .. tostring(aloftData.name) .. "/" ..("|cff%02x%02x%02xcolor|r"):format(floor(255*color[1]), floor(255*color[2]), floor(255*color[3])))
		self:SetHealthBarColor(aloftData, color)
	elseif aloftData.isPet or aloftData.petOwnersName then
		self:SetHealthBarColor(aloftData, colors.hostilePet)
	elseif aloftData.isBoss then
		self:SetHealthBarColor(aloftData, colors.hostileBoss)
	else
		self:SetHealthBarColor(aloftData, colors.hostileNPC)
	end
end

function AloftHealthBar:ColourNeutral(aloftData)
	local class = aloftData.class
	if class then
		local color = Aloft.db.profile.classColors[aloftData.class]
		if profile.colorHostileByClass and color then
			self:SetHealthBarColor(aloftData, color)
			-- ChatFrame7:AddMessage("AloftHealthBar:ColourNeutral(): " .. class " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.class))
		else
			self:SetHealthBarColor(aloftData, colors.hostilePlayer)
			-- ChatFrame7:AddMessage("AloftHealthBar:ColourNeutral(): " .. class hostile " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.class))
		end
	elseif Aloft:IsTotem(aloftData) and Aloft.GetTotemExceptionColor then
		local color = Aloft:GetTotemExceptionColor(aloftData) or colors.neutral
		-- ChatFrame7:AddMessage("AloftHealthBar:ColourHostile(): " .. tostring(aloftData.name) .. "/" ..("|cff%02x%02x%02xcolor|r"):format(floor(255*color[1]), floor(255*color[2]), floor(255*color[3])))
		self:SetHealthBarColor(aloftData, color)
	else
		self:SetHealthBarColor(aloftData, colors.neutral)
		-- ChatFrame7:AddMessage("AloftHealthBar:ColourNeutral(): " .. neutral " .. tostring(aloftData.name))
	end
end

function AloftHealthBar:ColourUnknown(aloftData)
	-- Should never be here, but if we are just change the alpha
	local r, g, b = aloftData.healthBar:GetStatusBarColor()

	-- aloftData.healthBar:SetStatusBarColor(r, g, b, profile.alpha)
	self:SetHealthBarColors(aloftData, r, g, b)
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

function AloftHealthBar:OnClassDataChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:OnClassDataChanged(): invoke")
	self:Update(aloftData)
end

function AloftHealthBar:OnHealthBarColorChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:OnHealthBarColorChanged(): invoke")
	self:Update(aloftData)
end

function AloftHealthBar:OnUnitidDataChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBar:OnHealthBarColorChanged(): invoke")
	self:Update(aloftData)
end

function AloftHealthBar:Update(aloftData)
	local override = self.colorMethod(aloftData)
	if #override >= 6 then
		-- ChatFrame7:AddMessage("AloftHealthBar:Update(): color override " .. aloftData.name)
		local rhex, ghex, bhex = override:sub(1, 2), override:sub(3, 4), override:sub(5, 6)
		local color = { tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255 }
		self:SetHealthBarColor(aloftData, color)
		-- aloftData.healthBar:SetStatusBarColor(tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255, profile.alpha)
	elseif not aloftData.noGlow then -- coordinate with nameplate glow processing; when we are not using a glow, we surrender control over health bar colors of targets with threat to the glow module
		local unitType = aloftData.type
		-- ChatFrame7:AddMessage("AloftHealthBar:Update(): color type " .. aloftData.name .. "/" .. unitType)
		healthBarMethods[unitType](self, aloftData)
	end
end

-----------------------------------------------------------------------------
