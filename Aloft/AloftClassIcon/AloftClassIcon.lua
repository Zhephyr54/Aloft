local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

local AloftClassIcon = Aloft:NewModule("ClassIcon", "AceEvent-2.0")
AloftClassIcon.dynamic = "AloftClassIcon"

-----------------------------------------------------------------------------

AloftClassIcon.db = Aloft:AcquireDBNamespace("classIcon")
Aloft:RegisterDefaults("classIcon", "profile", {
	enable			= false,
	alpha			= 1.0,
	point			= "RIGHT",
	relativeToPoint	= "LEFT",
	offsetX			= 0,
	offsetY			= 0,
	size			= 12
})

-----------------------------------------------------------------------------

local profile

local unpack = unpack

-----------------------------------------------------------------------------

function AloftClassIcon:OnInitialize()
	profile = self.db.profile
end

function AloftClassIcon:OnEnable()
	self:UpdateAll()
end

function AloftClassIcon:OnDisable()
	self:UnregisterAllEvents()

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
	if profile and profile.enable then
		for aloftData in Aloft:IterateNameplates() do
			local layoutFrame = aloftData.layoutFrame
			local classIconRegion = layoutFrame and layoutFrame.classIconRegion
			if classIconRegion then
				self:PlaceFrame(classIconRegion, layoutFrame, profile, 0, 0)
			end
			self:Update(aloftData)
		end
		for layoutFrame in pairs(Aloft.layoutFramePool) do
			local classIconRegion = layoutFrame.classIconRegion
			if classIconRegion then
				self:PlaceFrame(classIconRegion, layoutFrame, profile, 0, 0)
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
	local classIconRegion = self:SetupFrame(aloftData)

	if classIconRegion then
		-- ChatFrame7:AddMessage("AloftClassIcon:Update(): show " .. tostring(aloftData.name))
		classIconRegion:Show()
	else
		-- ChatFrame7:AddMessage("AloftClassIcon:Update(): hide " .. tostring(aloftData.name))
		self:OnNameplateHide(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftClassIcon:RequiresData()
	if profile and profile.enable then
		return "class"
	end
end

function AloftClassIcon:RegisterEvents()
	if profile and profile.enable then
		self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterEvent("Aloft:OnClassDataChanged", "OnClassDataChanged")
	else
		self:CancelEvent("Aloft:SetupFrame")
		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnNameplateHide")
		self:CancelEvent("Aloft:OnClassDataChanged")
	end
end

-----------------------------------------------------------------------------

function AloftClassIcon:SetupFrame(aloftData)
	if aloftData.class then
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		local classIconRegion = layoutFrame.classIconRegion

		-- Check if this nameplate already has a class icon assigned to it
		if not classIconRegion then
			classIconRegion = aloftData:CreateTexture()
			classIconRegion:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")

			layoutFrame.classIconRegion = classIconRegion

			self:PlaceFrame(classIconRegion, layoutFrame, profile, 0, 0)
		end

		-- always assign at least a blank region of the texture; here when we originally discover the nameplate
		local l, r, t, b  = self:GetClassIconTexCoord(aloftData.class)
		classIconRegion:SetTexCoord(l, r, t, b );
		return classIconRegion
	end

	-- ChatFrame7:AddMessage("AloftClassIcon:SetupFrame(): no classIconRegion " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.class))
	return nil
end

-----------------------------------------------------------------------------

function AloftClassIcon:OnClassDataChanged(aloftData)
	self:Update(aloftData)
end

function AloftClassIcon:OnNameplateShow(aloftData)
	self:Update(aloftData)
end

function AloftClassIcon:OnNameplateHide(aloftData)
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
	if (class) then
		local texCoord = classButtons[class]
		if (texCoord) then
			return unpack(texCoord)
		end
	end
	return 0.5, 0.75, 0.5, 0.75 -- a blank area of the texture file
end

-----------------------------------------------------------------------------

end)
