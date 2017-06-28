local Aloft = Aloft
if not Aloft then return end
-- local AloftModules = AloftModules
-- if not AloftModules then return end

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CastWarning") or not Aloft:HasModule("TargetTrackingData") then return end

local AloftCastWarningSpellIcon = Aloft:NewModule("CastWarningSpellIcon", "AceEvent-2.0")
-- AloftCastWarningSpellIcon.dynamic = true

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData")
local AloftCastWarning = Aloft:GetModule("CastWarning")

-----------------------------------------------------------------------------

AloftCastWarningSpellIcon.db = Aloft:AcquireDBNamespace("castWarningSpellIcon")
Aloft:RegisterDefaults("castWarningSpellIcon", "profile", {
	enable			= true,
	point			= "LEFT",
	relativeToPoint	= "LEFT",
	offsetX			= 0,
	offsetY			= 0,
	size			= 11,

	nointerShield	= true,
	nointerStyle	= "SQUARE",
	nointerColor	= { 1.0, 1.0, 1.0, 0.65 }, -- white
})

-----------------------------------------------------------------------------

local profile

-- textures for shield graphic
local noInterruptTexture =
{
	["ROUND"]	= [[Interface\Addons\Aloft\Textures\RndNoInterrupt]],
	["SQUARE"]	= [[Interface\Addons\Aloft\Textures\SqrNoInterrupt]],
}

-- determines how shield graphic scales with spell icon
local noInterruptSize =
{
	["ROUND"]	= { w = 2.5, h = 2.5, },
	["SQUARE"]	= { w = 2.5, h = 2.5, },
}

-----------------------------------------------------------------------------

function AloftCastWarningSpellIcon:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if profile.enable then
			self:Update(aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellIcon:RegisterEvents()
	self:UnregisterAllEvents()

	if profile and profile.enable then
		self:RegisterEvent("Aloft:OnNameplateShow", "Update")
		self:RegisterEvent("Aloft:OnSetHealthBarColor", "Update") -- TODO: is this needed?
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterEvent("AloftCastWarning:OnCastWarningDataChanged", "OnCastWarningDataChanged")
	end
end

local dataRequiredList = { }
function AloftCastWarningSpellIcon:RequiresData()
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellIcon:OnInitialize()
	Aloft:DebugRegister("CastWarningSpellIcon")
	profile = self.db.profile
end

function AloftCastWarningSpellIcon:OnEnable()
	self:UpdateAll()
end

function AloftCastWarningSpellIcon:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateHide(aloftData)
	end
	-- TODO: nil out Aloft.Options?
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellIcon:Update(aloftData)
	local nameplateId = AloftTargetTrackingData:GetNameplateId(aloftData)
	if nameplateId then
		local nameplateGUId = AloftTargetTrackingData:GetNameplateGUId(nameplateId)
		if nameplateGUId then
			local active = nameplateGUId and AloftCastWarning:GetActiveCastByGUId(nameplateGUId)

			self:CreateFrame(aloftData, nameplateGUId, active)
		end
	end
end

function AloftCastWarningSpellIcon:OnCastWarningDataChanged(aloftData, nameplateGUId, active)
	self:CreateFrame(aloftData, nameplateGUId, active)
end

function AloftCastWarningSpellIcon:OnNameplateHide(aloftData)
	local castWarningBar = aloftData.castWarningBar
	if castWarningBar then
		local castWarningSpellIconRegion = castWarningBar.castWarningSpellIconRegion
		if castWarningSpellIconRegion then
			castWarningSpellIconRegion:Hide()
		end
		local nointerruptRegion = castWarningBar.nointerruptRegion
		if nointerruptRegion then
			nointerruptRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarningSpellIcon:CreateFrame(aloftData, nameplateGUId, active)
	local castWarningBar = aloftData.castWarningBar
	if nameplateGUId and active and castWarningBar and castWarningBar:IsVisible() then
		-- Check if this nameplate already has a text region assigned to it
		local castWarningSpellIconRegion = castWarningBar.castWarningSpellIconRegion
		if not castWarningSpellIconRegion then
			castWarningSpellIconRegion = castWarningBar.castWarningExtraFrame:CreateTexture(nil, "OVERLAY")
			castWarningBar.castWarningSpellIconRegion = castWarningSpellIconRegion
		end

		local nointerruptRegion = castWarningBar.nointerruptRegion
		if not nointerruptRegion then
			nointerruptRegion = castWarningBar.castWarningExtraFrame:CreateTexture(nil, "BORDER")

			castWarningBar.nointerruptRegion = nointerruptRegion
		end

		self:PlaceFrame(castWarningSpellIconRegion, castWarningBar.castWarningExtraFrame, profile)
		castWarningSpellIconRegion:SetTexture(active.icon)
		castWarningSpellIconRegion:Show()

		if profile.nointerShield and active.noInterrupt then
			local texture = noInterruptTexture[profile.nointerStyle]

			nointerruptRegion:SetTexture(texture)
			nointerruptRegion:SetVertexColor(unpack(profile.nointerColor))
	
			nointerruptRegion:ClearAllPoints()
			nointerruptRegion:SetWidth(noInterruptSize[profile.nointerStyle].w * profile.size)
			nointerruptRegion:SetHeight(noInterruptSize[profile.nointerStyle].h * profile.size)
			nointerruptRegion:SetPoint("CENTER", castWarningSpellIconRegion, "CENTER", 0, 0)
			nointerruptRegion:SetAlpha(1.0)
			nointerruptRegion:Show()

			-- ChatFrame7:AddMessage("AloftCastWarningSpellIcon:CreateFrame() show nointerruptRegion " .. tostring(nointerruptRegion:IsVisible()) .. "/" .. tostring(texture) .. "/" .. tostring(nointerruptRegion:GetTexture()))
		else
			-- ChatFrame7:AddMessage("AloftCastWarningSpellIcon:CreateFrame() hide nointerruptRegion " .. tostring(nointerruptRegion:IsVisible()) .. "/" .. tostring(texture) .. "/" .. tostring(nointerruptRegion:GetTexture()))
			nointerruptRegion:Hide()
		end
	else
		-- ChatFrame7:AddMessage("AloftCastWarningSpellIcon:CreateFrame() hide nameplate")
		self:OnNameplateHide(aloftData)
	end
end

-----------------------------------------------------------------------------

-- end)
