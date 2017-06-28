local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftNameText = Aloft:NewModule("NameText", "AceEvent-2.0")

-----------------------------------------------------------------------------

AloftNameText.db = Aloft:AcquireDBNamespace("nameText")
Aloft:RegisterDefaults("nameText", "profile", {
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
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftNameText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame(aloftData)
	end

	if profile.enable then
		for aloftData in Aloft:IterateVisibleNameplates() do
			if profile.overrideColors then
				self:UpdateText(aloftData)
			else
				self:UpdateTextNone(aloftData)
			end
		end
	end
end

function AloftNameText:RegisterEvents()
	self:UnregisterAllEvents()
	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")

	-- self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateNameFromTarget")

	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:UpdateAll()
		end
	end)

	if profile.enable and profile.overrideColors then
		local updateTextMethod = "UpdateTextSimple"
		if not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.friendlyPet) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.friendlyNPC) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.friendlyBoss) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.hostilePlayer) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.hostilePet) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.hostileNPC) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.hostileBoss) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.neutral) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.pet) or
		   not self:IsArrayEqual(profile.colors.friendlyPlayer, profile.colors.groupPet) or
		   profile.colorByClass or
		   profile.colorHostileByClass then
			updateTextMethod = "UpdateText"
		end

		self:RegisterEvent("Aloft:OnNameplateShow", updateTextMethod)
		self:RegisterEvent("Aloft:OnSetHealthBarColor", updateTextMethod)

		if profile.colorByClass or profile.colorHostileByClass then
			self:RegisterEvent("Aloft:OnClassDataChanged", updateTextMethod)
		end

		if not self:IsArrayEqual(profile.colors.friendlyPet, profile.colors.friendlyNPC) or
		   not self:IsArrayEqual(profile.colors.hostilePet, profile.colors.hostileNPC) then
			self:RegisterEvent("Aloft:OnIsPetDataChanged", updateTextMethod)
		end

		if not self.textMethodData or not self.textMethodData.events then
			self.textMethodData = Aloft:CreateTag(profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		for events in pairs(self.textMethodData.events) do
			self:RegisterEvent(events, updateTextMethod)
		end
	else
		if profile.enable then
			self:RegisterEvent("Aloft:OnNameplateShow", "UpdateTextNone")

			if not self.textMethodData or not self.textMethodData.events then
				self.textMethodData = Aloft:CreateTag(profile.format, true)
				self.textMethod = self.textMethodData.method
			end
			for events in pairs(self.textMethodData.events) do
				self:RegisterEvent(events, "UpdateTextNone")
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftNameText:OnInitialize()
	profile = self.db.profile
end

function AloftNameText:OnEnable()
	self:UpdateAll()
end

function AloftNameText:OnDisable()
	self:UnregisterAllEvents()

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

local dataRequiredList = { }
function AloftNameText:RequiresData()
	self:RegisterEvents()

	if not profile.enable then
		return
	end

	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	if profile.colorByClass or
	   profile.colorHostileByClass or
	   not self:IsArrayEqual(profile.colors.hostileNPC, profile.colors.hostilePlayer) then
		table.insert(dataRequiredList, "class")
	end

	if not self:IsArrayEqual(profile.colors.friendlyPet, profile.colors.friendlyNPC) or
	   not self:IsArrayEqual(profile.colors.hostilePet, profile.colors.hostileNPC) then
		table.insert(dataRequiredList, "isPet")
	end

	if Aloft:IsDataAvailable("unitid") and not self:IsArrayEqual(profile.colors.friendlyPet, profile.colors.groupPet) then
		table.insert(dataRequiredList, "unitid")
	end

	if not self.textMethodData or not self.textMethodData.data then
		self.textMethodData = Aloft:CreateTag(profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	for data in pairs(self.textMethodData.data) do
		table.insert(dataRequiredList, data)
	end

	return unpack(dataRequiredList)
end

function AloftNameText:SetupFrame(aloftData)
	if aloftData then -- apparently we can get here with a nil nameplate
		local layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		local nameTextRegion = aloftData.nameTextRegion

		nameTextRegion:SetDrawLayer("OVERLAY")
		self:PrepareText(nameTextRegion, profile)

		-- NOTE: no user-selected attach points, just direct placement, therefore no funky inset logic
		nameTextRegion:ClearAllPoints()
		nameTextRegion:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", profile.offsets.left, profile.offsets.vertical)
		nameTextRegion:SetPoint("BOTTOMRIGHT", layoutFrame, "BOTTOMRIGHT", profile.offsets.right, profile.offsets.vertical)

		if profile.enable then
			nameTextRegion:Show()
		else
			nameTextRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftNameText:SetTextColor(aloftData, color)
	-- ChatFrame7:AddMessage("AloftNameText:SetTextColor(): " .. tostring(aloftData.name) .. "/" ..
	--	("%s:0x%02x%02x%02x"):format(tostring(aloftData.class), floor(aloftData.originalHealthBarR*255), floor(aloftData.originalHealthBarG*255), floor(aloftData.originalHealthBarB*255))) end
	if not self.textMethodData or not self.textMethod then
		self.textMethodData = Aloft:CreateTag(profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	local text = self.textMethod(aloftData)
	Aloft:SetNameText(aloftData.nameTextRegion, ("|cff%02x%02x%02x%s"):format(color[1]*255, color[2]*255, color[3]*255, text))
end

function AloftNameText:SetTextColorRgb(aloftData, color)
	-- ChatFrame7:AddMessage("AloftNameText:SetTextColorRgb(): " .. tostring(aloftData.name) .. "/" ..
	--	("%s:0x%02x%02x%02x"):format(tostring(aloftData.class), floor(aloftData.originalHealthBarR*255), floor(aloftData.originalHealthBarG*255), floor(aloftData.originalHealthBarB*255))) end
	if not self.textMethodData or not self.textMethod then
		self.textMethodData = Aloft:CreateTag(profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	local text = self.textMethod(aloftData)
	Aloft:SetNameText(aloftData.nameTextRegion, ("|cff%02x%02x%02x%s"):format(color.r*255, color.g*255, color.b*255, text))
end

-----------------------------------------------------------------------------

function AloftNameText:UpdateTextSimple(aloftData)
	-- ChatFrame7:AddMessage("AloftNameText:UpdateTextSimple(): " .. tostring(aloftData.name) .. "/" ..
	--	("%s:0x%02x%02x%02x"):format(tostring(aloftData.class), floor(aloftData.originalHealthBarR*255), floor(aloftData.originalHealthBarG*255), floor(aloftData.originalHealthBarB*255))) end
	self:SetupFrame(aloftData)
	if profile.colorByClass and aloftData.class then
		local color = Aloft.db.profile.classColors[aloftData.class]
		if color then
			self:SetTextColor(aloftData, color)
			return
		end
	end

	self:SetTextColor(aloftData, profile.colors.friendlyPlayer)
end

-----------------------------------------------------------------------------

function AloftNameText:ColourFriendlyPlayer(aloftData)
	if profile.colorByClass then
		local class = aloftData.class
		if class then
			local color = Aloft.db.profile.classColors[class]
			if color then
				self:SetTextColor(aloftData, color)
				return
			end
		end
	end
	self:SetTextColor(aloftData, profile.colors.friendlyPlayer)
end

function AloftNameText:ColourFriendlyNPC(aloftData)
	-- Could be player pet, group pet, friendly pet, friendlyBoss, or friendlyNPC
	if aloftData.name == UnitName("pet") then
		self:SetTextColor(aloftData, profile.colors.pet)
	elseif aloftData.unitid then
		self:SetTextColor(aloftData, profile.colors.groupPet)
	elseif aloftData.isPet then
		self:SetTextColor(aloftData, profile.colors.friendlyPet)
	elseif aloftData.isBoss then
		self:SetTextColor(aloftData, profile.colors.friendlyBoss)
	else
		self:SetTextColor(aloftData, profile.colors.friendlyNPC)
	end
end

function AloftNameText:ColourHostile(aloftData)
	-- player, hostile pet, hostile boss, hostileNPC
	local class = aloftData.class
	if class then
		local color = Aloft.db.profile.classColors[class]
		if profile.colorHostileByClass and color then
			self:SetTextColor(aloftData, color)
		else
			self:SetTextColor(aloftData, profile.colors.hostilePlayer)
		end
	elseif aloftData.isPet then
		self:SetTextColor(aloftData, profile.colors.hostilePet)
	elseif aloftData.isBoss then
		self:SetTextColor(aloftData, profile.colors.hostileBoss)
	else
		self:SetTextColor(aloftData, profile.colors.hostileNPC)
	end
end

function AloftNameText:ColourNeutral(aloftData)
	local class = aloftData.class
	if class then
		local color = Aloft.db.profile.classColors[class]
		if profile.colorHostileByClass and color then
			self:SetTextColor(aloftData, color)
		else
			self:SetTextColor(aloftData, profile.colors.neutral)
		end
	else
		self:SetTextColor(aloftData, profile.colors.neutral)
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

function AloftNameText:UpdateText(aloftData)
	-- ChatFrame7:AddMessage("AloftNameText:UpdateText(): " .. tostring(aloftData.name) .. "/" ..
	--	("%s:0x%02x%02x%02x"):format(tostring(aloftData.class), floor(aloftData.originalHealthBarR*255), floor(aloftData.originalHealthBarG*255), floor(aloftData.originalHealthBarB*255))) end
	self:SetupFrame(aloftData)
	nameTextMethods[aloftData.type](self, aloftData)
end

function AloftNameText:UpdateTextNone(aloftData)
	-- ChatFrame7:AddMessage("AloftNameText:UpdateText(): " .. tostring(aloftData.name) .. "/" ..
	--	("%s:0x%02x%02x%02x"):format(tostring(aloftData.class), floor(aloftData.originalHealthBarR*255), floor(aloftData.originalHealthBarG*255), floor(aloftData.originalHealthBarB*255))) end
	self:SetupFrame(aloftData)
	if not self.textMethodData or not self.textMethod then
		self.textMethodData = Aloft:CreateTag(profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	local text = self.textMethod(aloftData)
	Aloft:SetNameText(aloftData.nameTextRegion, text)
end

-----------------------------------------------------------------------------

function AloftNameText:UpdateNameFromTarget()
	self:UpdateFromUnit("target")
end

function AloftNameText:UpdateFromUnit(unitid)
	if UnitIsPlayer(unitid) then return end

	local name, _ = UnitName(unitid)

	local eventName = "AloftNameText:UpdateUnitName:" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.UpdateUnitName, 0.0, self, name) -- next frame
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
		self:TriggerEvent("Aloft:OnUnitNameChanged", aloftData)
	end
end

-----------------------------------------------------------------------------
