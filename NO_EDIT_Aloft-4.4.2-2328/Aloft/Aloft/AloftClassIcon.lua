local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

local AloftClassIcon = Aloft:NewModule("ClassIcon", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftClassIcon.dynamic = "AloftClassIcon"

-----------------------------------------------------------------------------

AloftClassIcon.namespace = "classIcon"
AloftClassIcon.defaults =
{
	profile =
	{
		enable			= false,
		totemEnable		= true,
		totemCrop		= 0.08,
		alpha			= 1.0,
		point			= "RIGHT",
		relativeToPoint	= "LEFT",
		offsetX			= 0,
		offsetY			= 0,
		size			= 12,
	},
}

-----------------------------------------------------------------------------

local unpack = unpack

-----------------------------------------------------------------------------

function AloftClassIcon:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftClassIcon:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UpdateAll()
end

function AloftClassIcon:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		local layoutFrame = aloftData.layoutFrame
		local classIconRegion = layoutFrame and layoutFrame.classIconRegion
		if classIconRegion then
			classIconRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftClassIcon:UpdateAll()
	if self.db.profile and self.db.profile.enable then
		for aloftData in Aloft:IterateNameplates() do
			local layoutFrame = aloftData.layoutFrame
			local classIconRegion = layoutFrame and layoutFrame.classIconRegion
			if classIconRegion then
				self:PlaceFrame(classIconRegion, layoutFrame, self.db.profile, 0, 0)
			end
			self:Update(aloftData)
		end
		for layoutFrame in pairs(Aloft.layoutFramePool) do
			local classIconRegion = layoutFrame.classIconRegion
			if classIconRegion then
				self:PlaceFrame(classIconRegion, layoutFrame, self.db.profile, 0, 0)
			end
		end
	else
		for aloftData in Aloft:IterateNameplates() do
			local layoutFrame = aloftData.layoutFrame
			local classIconRegion = layoutFrame and layoutFrame.classIconRegion
			if classIconRegion then
				classIconRegion:Hide()
			end
		end
	end

	self:RegisterEvents()
end

function AloftClassIcon:Update(aloftData)
	local classIconRegion = self:SetupFrame("AloftClassIcon:Update", aloftData)

	if classIconRegion then
		-- ChatFrame7:AddMessage("AloftClassIcon:Update(): show " .. tostring(aloftData.name))
		classIconRegion:Show()
	else
		-- ChatFrame7:AddMessage("AloftClassIcon:Update(): hide " .. tostring(aloftData.name))
		self:OnNameplateHide("AloftClassIcon:Update", aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftClassIcon:RequiresData()
	if self.db.profile and self.db.profile.enable then
		return "class"
	end
end

function AloftClassIcon:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile and self.db.profile.enable then
		self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
		self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("Aloft:OnClassDataChanged", "OnClassDataChanged")
	end
end

-----------------------------------------------------------------------------

function AloftClassIcon:CreateRegion(aloftData, texture)
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	local classIconRegion = layoutFrame.classIconRegion

	-- Check if this nameplate already has a class icon assigned to it
	if not classIconRegion then
		classIconRegion = aloftData:CreateTexture()

		layoutFrame.classIconRegion = classIconRegion

		self:PlaceFrame(classIconRegion, layoutFrame, self.db.profile, 0, 0)
	end
	classIconRegion:SetTexture(texture)

	return classIconRegion
end

function AloftClassIcon:SetupFrame(message, aloftData)
	if aloftData.class then
		local classIconRegion = self:CreateRegion(aloftData, "Interface\\WorldStateFrame\\Icons-Classes")
		local l, r, t, b  = self:GetClassIconTexCoord(aloftData.class)

		classIconRegion:SetTexCoord(l, r, t, b)

		return classIconRegion
	elseif self.db.profile and self.db.profile.totemEnable then
		local totemIcon = Aloft:IsTotem(aloftData)
		if totemIcon then
			local classIconRegion = self:CreateRegion(aloftData, totemIcon)
			local crop = self.db.profile.totemCrop

			classIconRegion:SetTexCoord(0 + crop, 1 - crop, 0 + crop, 1 - crop) -- full texture (less crop of the border)

			return classIconRegion
		end
	end

	-- ChatFrame7:AddMessage("AloftClassIcon:SetupFrame(): no classIconRegion " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.class))
	return nil
end

-----------------------------------------------------------------------------

function AloftClassIcon:OnClassDataChanged(message, aloftData)
	self:Update(aloftData)
end

function AloftClassIcon:OnNameplateShow(message, aloftData)
	self:Update(aloftData)
end

function AloftClassIcon:OnNameplateHide(message, aloftData)
	local layoutFrame = aloftData.layoutFrame
	local classIconRegion = layoutFrame and layoutFrame.classIconRegion
	if classIconRegion then
		classIconRegion:Hide()
	end
end

-----------------------------------------------------------------------------

-- borrowed from Blizzard's FrameXML/Constants.lua/WorldStateFrame.lua/WorldStateScoreFrame_Update() and XPerl
local classButtons = CLASS_ICON_TCOORDS -- now sourcing from Constants.lua, which seems to duplicate stuff from WorldStateFrame.lua/CLASS_BUTTONS
function AloftClassIcon:GetClassIconTexCoord(class)
	if class then
		local texCoord = classButtons[class]
		if texCoord then
			return unpack(texCoord)
		end
	end
	return 0.5, 0.75, 0.5, 0.75 -- a blank area of the texture file
end

-----------------------------------------------------------------------------

end)
