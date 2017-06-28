local Aloft = Aloft
if not Aloft then return end
 
-----------------------------------------------------------------------------

local AloftNameText = Aloft:NewModule("NameText", Aloft, "AceEvent-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

AloftNameText.namespace = "nameText"
AloftNameText.defaults =
{
	profile =
	{
		enable			= true,
		useAliases		= false,
		font			= "Arial Narrow",
		fontSize		= 10,
		format			= "[name]",
		shadow			= false,
		alignment		= "LEFT",
		outline			= "OUTLINE",
		offsets =
		{
			left		= 0,
			right		= 0,
			vertical	= 0,
		},
		overrideColors		= true,
		colorByClass		= false,
		colorHostileByClass	= false,
		colors =
		{
			friendlyPlayer	= { 1, 1, 1 },
			friendlyPet		= { 1, 1, 1 },
			friendlyNPC		= { 1, 1, 1 },
			friendlyBoss	= { 1, 1, 1 },
			hostilePlayer	= { 1, 1, 1 },
			hostilePet		= { 1, 1, 1 },
			hostileNPC		= { 1, 1, 1 },
			hostileBoss		= { 1, 1, 1 },
			neutral			= { 1, 1, 1 },
			pet				= { 1, 1, 1 },
			groupPet		= { 1, 1, 1 },
		},
	},
}

local nameTextColorTimer = nil

-----------------------------------------------------------------------------

Aloft.TagData.WasRecentlyDamaged =
{
	data = "recentlyDamaged",
	events = "Aloft:OnRecentlyDamagedChanged",
	tableData = "recentlyDamaged"
}

-----------------------------------------------------------------------------

function AloftNameText:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:SetupFrame("AloftNameText:UpdateAll", aloftData)
	end

	if self.db.profile.enable then
		if self.db.profile.overrideColors then
			for aloftData in Aloft:IterateVisibleNameplates() do
				self:UpdateText("AloftNameText:UpdateAll", aloftData)
			end
		else
			for aloftData in Aloft:IterateVisibleNameplates() do
				self:UpdateTextNone("AloftNameText:UpdateAll", aloftData)
			end
		end
	end
end

function AloftNameText:RegisterEvents()
	-- ChatFrame7:AddMessage("AloftNameText:RegisterEvents(): enter")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
	nameTextColorTimer = nil

	-- TODO: figure out a way to make this selective, based on recentlyDamaged and profile.overrideColors
	self:InitializeTimer() -- just always track underlying name text color changes
	-- ChatFrame7:AddMessage("AloftNameText:RegisterEvents(): timer initialized")

	self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")

	-- self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateNameFromTarget")

	self:RegisterMessage("Aloft:SetAll", function(message, type, value)
		if AloftNameText.db.profile[type] then
			AloftNameText.db.profile[type] = value
			AloftNameText:UpdateAll()
		end
	end)

	if self.db.profile.enable and self.db.profile.overrideColors then
		local updateTextMethod = "UpdateTextSimple"
		if not self:IsArrayEqual(self.db.profile.colors.friendlyPlayer, self.db.profile.colors.friendlyPet) or
		   not self:IsArrayEqual(self.db.profile.colors.friendlyPlayer, self.db.profile.colors.friendlyNPC) or
		   not self:IsArrayEqual(self.db.profile.colors.friendlyPlayer, self.db.profile.colors.friendlyBoss) or
		   not self:IsArrayEqual(self.db.profile.colors.friendlyPlayer, self.db.profile.colors.hostilePlayer) or
		   not self:IsArrayEqual(self.db.profile.colors.friendlyPlayer, self.db.profile.colors.hostilePet) or
		   not self:IsArrayEqual(self.db.profile.colors.friendlyPlayer, self.db.profile.colors.hostileNPC) or
		   not self:IsArrayEqual(self.db.profile.colors.friendlyPlayer, self.db.profile.colors.hostileBoss) or
		   not self:IsArrayEqual(self.db.profile.colors.friendlyPlayer, self.db.profile.colors.neutral) or
		   not self:IsArrayEqual(self.db.profile.colors.friendlyPlayer, self.db.profile.colors.pet) or
		   not self:IsArrayEqual(self.db.profile.colors.friendlyPlayer, self.db.profile.colors.groupPet) or
		   self.db.profile.colorByClass or
		   self.db.profile.colorHostileByClass then
			updateTextMethod = "UpdateText"
			-- ChatFrame7:AddMessage("AloftNameText:RegisterEvents(): updateTextMethod " .. tostring(updateTextMethod))
		end

		self:RegisterMessage("Aloft:OnNameplateShow", updateTextMethod)
		-- ChatFrame7:AddMessage("AloftNameText:RegisterEvents(): register 1 " .. tostring(updateTextMethod))

		if self.db.profile.colorByClass or self.db.profile.colorHostileByClass then
			-- ChatFrame7:AddMessage("AloftNameText:RequiresData(): register Aloft:OnClassDataChanged")
			self:RegisterMessage("Aloft:OnClassDataChanged", updateTextMethod)
		end

		if not self:IsArrayEqual(self.db.profile.colors.friendlyPet, self.db.profile.colors.friendlyNPC) or
		   not self:IsArrayEqual(self.db.profile.colors.hostilePet, self.db.profile.colors.hostileNPC) then
			self:RegisterMessage("Aloft:OnIsPetDataChanged", updateTextMethod)
		end

		if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethodData.events) then
			self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		if self.textMethodData and self.textMethodData.events then
			for events in pairs(self.textMethodData.events) do
				self:RegisterMessage(events, updateTextMethod)
				-- ChatFrame7:AddMessage("AloftNameText:RegisterEvents(): register 2 " .. tostring(updateTextMethod) .. " " .. tostring(events))
			end
		end
	else
		if self.db.profile.enable then
			self:RegisterMessage("Aloft:OnNameplateShow", "UpdateTextNone")
			-- ChatFrame7:AddMessage("AloftNameText:RegisterEvents(): register 3 UpdateTextNone")

			if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethodData.events) then
				self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
				self.textMethod = self.textMethodData.method
			end
			if self.textMethodData and self.textMethodData.events then
				for events in pairs(self.textMethodData.events) do
					self:RegisterMessage(events, "UpdateTextNone")
					-- ChatFrame7:AddMessage("AloftNameText:RegisterEvents(): register 4 UpdateTextNone " .. tostring(events))
				end
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftNameText:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftNameText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UpdateAll()
end

function AloftNameText:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
	nameTextColorTimer = nil

	for aloftData in Aloft:IterateNameplates() do
		local nameplateFrame = aloftData.nameplateFrame
		local nameTextRegion = aloftData.nameTextRegion

		nameTextRegion:ClearAllPoints()
		nameTextRegion:SetPoint("BOTTOM", nameplateFrame, "CENTER")
		nameTextRegion:SetFont(NAMEPLATE_FONT, 14.5)
		nameTextRegion:SetText(aloftData.name)
		nameTextRegion:SetShadowOffset(1, -1)
		nameTextRegion:Show()
	end
end

-----------------------------------------------------------------------------

function AloftNameText:InitializeTimer()
	if nameTextColorTimer then
		self:CancelTimer(nameTextColorTimer, true)
		nameTextColorTimer = nil
	end

	nameTextColorTimer = self:ScheduleRepeatingTimer(function() AloftNameText:MonitorColor() end, 0.2) -- 5 times a second
end

function Aloft:MonitorColor()
	for aloftData in Aloft:IterateVisibleNameplates() do
		local layoutFrame = aloftData.layoutFrame
		local nameTextRegion = layoutFrame.nameTextRegion
		local origNameTextRegion = aloftData.nameTextRegion
		local r, g, b = origNameTextRegion:GetTextColor()
		r, g, b = floor(r * 256), floor(g*256), floor(b*256)

		if not self.db.profile.overrideColors and
		   (r ~= origNameTextRegion.nameTextR or g ~= origNameTextRegion.nameTextG or b ~= origNameTextRegion.nameTextB) then -- we are tracking, and color has changed
			-- ChatFrame7:AddMessage("Aloft:MonitorColor(): " .. ("|cff%02x%02x%02x%s|r"):format(r, g, b, tostring(aloftData.name) .. "/" .. tostring(Aloft.hooks[origNameTextRegion].GetText(origNameTextRegion)) .. "/" .. tostring(r) .. "." .. tostring(g) .. "." .. tostring(b)))
			if AloftNameText:SyncTextColorRgb(aloftData, r, g, b) then
				origNameTextRegion.nameTextR = r
				origNameTextRegion.nameTextG = g
				origNameTextRegion.nameTextB = b
			end
		end

		local recentlyDamaged = nil
		if r == 255 and g == 0 and b == 0 then -- red
			recentlyDamaged = true
		end

		if recentlyDamaged ~= aloftData.recentlyDamaged then
			aloftData.recentlyDamaged = recentlyDamaged
			self:SendMessage("Aloft:OnRecentlyDamagedChanged", aloftData)
		end
	end
end

-----------------------------------------------------------------------------

-- TODO: provide a way to find out if a piece of data is required anywhere,
--       apply to name and recentlyDamaged, and disable this module if not

function AloftNameText:ProvidesData()
	-- NOTE: this self-hooks the AloftNameText into the data/module heirarchy;
	--       AloftNameText is an always-loaded module, and the [Name] tag is always valid, so this should be harmless,
	--       and it provides an anchor for things like the [Class] tag, if it is needed for various "Color By Class" option(s)
	-- TODO: self-hook AloftLevelText as well, vis [Level]?
	return "name", "recentlyDamaged"
end

function AloftNameText:UpdateData(aloftData)
	-- overrides default behavior, we always want this module active
end

function AloftNameText:EnableDataSource()
	-- overrides default behavior, we always want this module active
	-- TODO: if recentlyDamaged is not required and profile.overrideColors is not enabled, we can disable the repeating timer
	-- ChatFrame7:AddMessage("AloftNameText:EnableDataSource(): required recentlyDamaged/" .. tostring(Aloft:IsDataRequired("recentlyDamaged")))
end

function AloftNameText:DisableDataSource(force)
	-- overrides default behavior, we always want this module active
	-- TODO: if recentlyDamaged is not required and profile.overrideColors is not enabled, we can disable the repeating timer
	-- ChatFrame7:AddMessage("AloftNameText:DisableDataSource(): required recentlyDamaged/" .. tostring(Aloft:IsDataRequired("recentlyDamaged")))
end

local dataRequiredList = { }
function AloftNameText:RequiresData()
	-- ChatFrame7:AddMessage("AloftNameText:RequiresData(): ENTER")

	self:RegisterEvents()
	-- ChatFrame7:AddMessage("AloftNameText:RequiresData(): events registered")

	if not self.db.profile.enable then
		return
	end

	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	if self.db.profile.colorByClass or
	   self.db.profile.colorHostileByClass or
	   not self:IsArrayEqual(self.db.profile.colors.hostileNPC, self.db.profile.colors.hostilePlayer) then
		-- ChatFrame7:AddMessage("AloftNameText:RequiresData(): CLASS")
		table.insert(dataRequiredList, "class")
	end

	if not self:IsArrayEqual(self.db.profile.colors.friendlyPet, self.db.profile.colors.friendlyNPC) or
	   not self:IsArrayEqual(self.db.profile.colors.hostilePet, self.db.profile.colors.hostileNPC) then
		table.insert(dataRequiredList, "isPet")
	end

	if Aloft:IsDataAvailable("unitid") and not self:IsArrayEqual(self.db.profile.colors.friendlyPet, self.db.profile.colors.groupPet) then
		table.insert(dataRequiredList, "unitid")
	end

	if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethodData or not self.textMethodData.data) then
		self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	if self.textMethodData and self.textMethodData.data then
		for data in pairs(self.textMethodData.data) do
			table.insert(dataRequiredList, data)
		end
	end

	--[[
	for i = 1,#dataRequiredList do
		ChatFrame7:AddMessage("AloftNameText:RequiresData(): requires " .. tostring(dataRequiredList[i]))
	end
	]]

	return unpack(dataRequiredList)
end

-----------------------------------------------------------------------------

function AloftNameText:SetupFrame(message, aloftData)
	if aloftData then -- apparently we can get here with a nil nameplate
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		local nameTextRegion = layoutFrame.nameTextRegion

		-- Check if this nameplate already has a name text region assigned to it
		if not nameTextRegion then
			nameTextRegion = aloftData:CreateFontString()
			nameTextRegion:SetParent(layoutFrame)

			layoutFrame.nameTextRegion = nameTextRegion

			if nameTextRegion.SetNonSpaceWrap then
				nameTextRegion:SetNonSpaceWrap(false)
			end
			nameTextRegion:SetDrawLayer("OVERLAY")
		end

		self:PrepareText(nameTextRegion, self.db.profile)

		-- NOTE: no user-selected attach points, just direct placement, therefore no funky inset logic
		nameTextRegion:ClearAllPoints()
		nameTextRegion:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", self.db.profile.offsets.left, self.db.profile.offsets.vertical)
		nameTextRegion:SetPoint("BOTTOMRIGHT", layoutFrame, "BOTTOMRIGHT", self.db.profile.offsets.right, self.db.profile.offsets.vertical)

		if self.db.profile.enable then
			nameTextRegion:Show()
		else
			nameTextRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftNameText:SetTextColor(aloftData, color)
	-- ChatFrame7:AddMessage("AloftNameText:SetTextColor(): " ..
	--	("|cff%02x%02x%02x%s"):format(floor(aloftData.originalHealthBarR*255), floor(aloftData.originalHealthBarG*255), floor(aloftData.originalHealthBarB*255), tostring(aloftData.name) .. "/" .. tostring(aloftData.class)))
	if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethod) then
		self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	-- ChatFrame7:AddMessage("AloftNameText:SetTextColor(): " .. tostring(aloftData.name)
	-- 	.. "/" .. tostring(aloftData.isTarget or aloftData:IsTarget())
	-- 	.. "/" .. tostring(self.textMethodData.functionString))

	local text = self.textMethod(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local nameTextRegion = layoutFrame and layoutFrame.nameTextRegion

	nameTextRegion:SetText(("|cff%02x%02x%02x%s"):format(color[1]*255, color[2]*255, color[3]*255, text))
end

function AloftNameText:SyncTextColorRgb(aloftData, r, g, b)
	local layoutFrame = aloftData.layoutFrame
	local nameTextRegion = layoutFrame and layoutFrame.nameTextRegion

	if nameTextRegion then
		nameTextRegion:SetTextColor(r, g, b, 1)
		return true
	end
	return nil
end

-----------------------------------------------------------------------------

function AloftNameText:UpdateTextSimple(message, aloftData)
	-- ChatFrame7:AddMessage("AloftNameText:UpdateTextSimple(): " .. tostring(aloftData.name))
	-- ChatFrame7:AddMessage("AloftNameText:UpdateTextSimple(): " ..
	-- 	("|cff%02x%02x%02x%s"):format(floor(aloftData.originalHealthBarR*255), floor(aloftData.originalHealthBarG*255), floor(aloftData.originalHealthBarB*255), tostring(aloftData.name) .. "/" .. tostring(aloftData.class)))

	self:SetupFrame(message, aloftData)
	if self.db.profile.colorByClass and aloftData.class then
		local color = Aloft.db.profile.classColors[aloftData.class]
		if color then
			self:SetTextColor(aloftData, color)
			return
		end
	end

	self:SetTextColor(aloftData, self.db.profile.colors.friendlyPlayer)
end

-----------------------------------------------------------------------------

function AloftNameText:ColourFriendlyPlayer(aloftData)
	-- ChatFrame7:AddMessage("AloftNameText:ColourFriendlyPlayer(): " .. tostring(aloftData.name) .. "/" .. tostring(self.db.profile.colorByClass) .. "/" .. tostring(aloftData.class))
	if self.db.profile.colorByClass then
		local class = aloftData.class
		if class then
			local color = Aloft.db.profile.classColors[class]
			if color then
				-- ChatFrame7:AddMessage("AloftNameText:ColourFriendlyPlayer(): " .. tostring(aloftData.name) .. "/" .. tostring(class))
				self:SetTextColor(aloftData, color)
				return
			end
		end
	end
	self:SetTextColor(aloftData, self.db.profile.colors.friendlyPlayer)
end

function AloftNameText:ColourFriendlyNPC(aloftData)
	-- Could be player pet, group pet, friendly pet, friendlyBoss, or friendlyNPC
	if aloftData.name == UnitName("pet") then
		self:SetTextColor(aloftData, self.db.profile.colors.pet)
	elseif aloftData.unitid then
		self:SetTextColor(aloftData, self.db.profile.colors.groupPet)
	elseif aloftData.isPet then
		self:SetTextColor(aloftData, self.db.profile.colors.friendlyPet)
	elseif aloftData.isBoss then
		self:SetTextColor(aloftData, self.db.profile.colors.friendlyBoss)
	else
		self:SetTextColor(aloftData, self.db.profile.colors.friendlyNPC)
	end
end

function AloftNameText:ColourHostile(aloftData)
	-- player, hostile pet, hostile boss, hostileNPC
	local class = aloftData.class
	if class then
		local color = Aloft.db.profile.classColors[class]
		if self.db.profile.colorHostileByClass and color then
			self:SetTextColor(aloftData, color)
		else
			self:SetTextColor(aloftData, self.db.profile.colors.hostilePlayer)
		end
	elseif aloftData.isPet then
		self:SetTextColor(aloftData, self.db.profile.colors.hostilePet)
	elseif aloftData.isBoss then
		self:SetTextColor(aloftData, self.db.profile.colors.hostileBoss)
	else
		self:SetTextColor(aloftData, self.db.profile.colors.hostileNPC)
	end
end

function AloftNameText:ColourNeutral(aloftData)
	local class = aloftData.class
	if class then
		local color = Aloft.db.profile.classColors[class]
		if self.db.profile.colorHostileByClass and color then
			self:SetTextColor(aloftData, color)
		else
			self:SetTextColor(aloftData, self.db.profile.colors.neutral)
		end
	else
		self:SetTextColor(aloftData, self.db.profile.colors.neutral)
	end
end

function AloftNameText:ColourUnknown(aloftData)
end

local nameTextMethods =
{
	["friendlyPlayer"]	= AloftNameText.ColourFriendlyPlayer,
	["friendlyNPC"]		= AloftNameText.ColourFriendlyNPC,
	["hostile"]			= AloftNameText.ColourHostile,
	["hostilePlayer"]	= AloftNameText.ColourHostile,
	["neutral"]			= AloftNameText.ColourNeutral,
	["unknown"]			= AloftNameText.ColourUnknown,
}

function AloftNameText:UpdateText(message, aloftData)
	-- ChatFrame7:AddMessage("AloftNameText:UpdateText(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type))
	-- ChatFrame7:AddMessage("AloftNameText:UpdateText(): " ..
	-- 	("|cff%02x%02x%02x%s"):format(floor(aloftData.originalHealthBarR*255), floor(aloftData.originalHealthBarG*255), floor(aloftData.originalHealthBarB*255), tostring(aloftData.name) .. "/" .. tostring(aloftData.class)))

	self:SetupFrame(message, aloftData)
	nameTextMethods[aloftData.type](self, aloftData)
end

function AloftNameText:UpdateTextNone(message, aloftData)
	-- ChatFrame7:AddMessage("AloftNameText:UpdateTextNone(): " .. tostring(aloftData.name))
	-- ChatFrame7:AddMessage("AloftNameText:UpdateTextNone(): " ..
	-- 	("|cff%02x%02x%02x%s"):format(floor(aloftData.originalHealthBarR*255), floor(aloftData.originalHealthBarG*255), floor(aloftData.originalHealthBarB*255), tostring(aloftData.name) .. "/" .. tostring(aloftData.class)))

	self:SetupFrame(message, aloftData)
	if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethod) then
		self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	-- ChatFrame7:AddMessage("AloftNameText:UpdateTextNone(): " .. tostring(aloftData.name)
	-- 	.. "/" .. tostring(aloftData.isTarget or aloftData:IsTarget())
	-- 	.. "/" .. tostring(self.textMethodData.functionString))

	-- ChatFrame7:AddMessage("AloftNameText:UpdateTextNone(): " .. tostring(message) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(self.textMethodData.functionString))
	local text = self.textMethod(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local nameTextRegion = layoutFrame and layoutFrame.nameTextRegion

	nameTextRegion:SetText(text)
end

-----------------------------------------------------------------------------

function AloftNameText:UpdateNameFromTarget(event)
	self:UpdateFromUnit("target")
end

function AloftNameText:UpdateFromUnit(unitid)
	if UnitIsPlayer(unitid) then return end

	local name, _ = UnitName(unitid)

	self:ScheduleTimer(function(name) AloftNameText:UpdateUnitName(name) end, 0.0, name) -- next frame
end

function AloftNameText:UpdateUnitName(name)
	local aloftData = Aloft:GetTargetNameplate()
	if (aloftData) then
		self:AssignValues(aloftData, name)
	end
end

function AloftNameText:AssignValues(aloftData, name)
	if aloftData.name ~= name then
		local oldName = aloftData.name
		Aloft:SetNameplateName(aloftData, name)
		self:SendMessage("Aloft:OnUnitNameChanged", aloftData)
	end
end

-----------------------------------------------------------------------------
