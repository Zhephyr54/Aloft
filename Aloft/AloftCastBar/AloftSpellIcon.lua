local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftCastBar = Aloft:HasModule("CastBar") and Aloft:GetModule("CastBar")
if not AloftCastBar then return end

local AloftSpellIcon = Aloft:NewModule("SpellIcon", "AceEvent-2.0")

-----------------------------------------------------------------------------

AloftSpellIcon.db = Aloft:AcquireDBNamespace("spellIcon")
Aloft:RegisterDefaults("spellIcon", "profile", {
	enable			= true,
	point			= "LEFT",
	relativeToPoint	= "LEFT",
	offsetX			= 0,
	offsetY			= 0,
	size			= 11,

	nointerShield	= true,
	nointerStyle	= "SQUARE",
	nointerColor		= { 1.0, 1.0, 1.0, 0.65 }, -- white
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

function AloftSpellIcon:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if aloftData:IsTarget() then
			self:OnCastBarShow(aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftSpellIcon:OnInitialize()
	profile = self.db.profile
end

function AloftSpellIcon:OnEnable()
	self:RegisterEvent("Aloft:OnCastBarShow", "OnCastBarShow")
	self:RegisterEvent("Aloft:OnCastBarHide", "OnCastBarHide")
	self:UpdateAll()
end

function AloftSpellIcon:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local layoutFrame = aloftData.layoutFrame
		local spellIconRegion = aloftData.spellIconRegion
		local nointerruptRegion = layoutFrame and layoutFrame.nointerruptRegion

		spellIconRegion:ClearAllPoints()
		spellIconRegion:SetPoint("CENTER", aloftData.nameplateFrame, "BOTTOMLEFT", 13.33, 10.29)
		spellIconRegion:SetWidth(14.5)
		spellIconRegion:SetHeight(14.5)
		spellIconRegion:SetParent(aloftData.nameplateFrame)

		if nointerruptRegion then
			nointerruptRegion:Hide()
		end
	end
end

-- TODO: propagate this to name text, level text, boss icon, and/or other "default" nameplate components as needed
function AloftSpellIcon:GetInset(aloftData, noInterrupt)
	if noInterrupt then
		return ((AloftCastBar.db.profile.border ~= "None") and 4) or 0
	else
		return ((AloftCastBar.db.profile.nointerBorder ~= "None") and 4) or 0
	end
end

function AloftSpellIcon:OnCastBarShow(aloftData)
	-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastBarShow(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData) .. "/" .. tostring(aloftData.layoutFrame) .. "/" .. tostring(aloftData.layoutFrame and aloftData.layoutFrame.nointerruptRegion) .. "/" .. tostring(aloftData.spellIconRegion))
	local layoutFrame = aloftData.layoutFrame
	local spellIconRegion = aloftData.spellIconRegion
	local nointerruptRegion = layoutFrame and layoutFrame.nointerruptRegion

	if profile.enable then
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		if not layoutFrame then
			ChatFrame7:AddMessage("AloftSpellIcon:OnCastBarShow(): no layoutFrame " .. tostring(aloftData.name))
			ChatFrame7:AddMessage("AloftSpellIcon:OnCastBarShow(): " .. debugstack())
		end

		local _, noInterrupt = AloftCastBar:GetTargetSpellInfo()

		spellIconRegion:SetParent(layoutFrame)
		spellIconRegion:SetDrawLayer("OVERLAY")
		spellIconRegion:SetBlendMode("BLEND")
		spellIconRegion:Show()

		if not nointerruptRegion then
			nointerruptRegion = aloftData:CreateTexture()
			nointerruptRegion:SetDrawLayer("BORDER")
			nointerruptRegion:SetBlendMode("BLEND")
			nointerruptRegion:SetParent(layoutFrame)

			layoutFrame.nointerruptRegion = nointerruptRegion
		end
		-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastBarShow(): layout " .. tostring(aloftData.name) .. "/" .. tostring(aloftData) .. "/" .. tostring(layoutFrame) .. "/" .. tostring(nointerruptRegion) .. "/" .. tostring(spellIconRegion))

		local inset = self:GetInset(aloftData, noInterrupt)
		local hinset, vinset = self:AdjustFrame(inset, profile.relativeToPoint)
		local castBar = aloftData.castBar
		self:PlaceFrame(spellIconRegion, castBar, profile, hinset, vinset)
		-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastBarShow(): noInterrupt " .. tostring(noInterrupt))

		if profile.nointerShield and noInterrupt then
			-- the nointerrupt graphic is a shield-like graphic that scales with the spell icon, and center on the spell icon.
			local texture = noInterruptTexture[profile.nointerStyle]

			nointerruptRegion:SetTexture(texture)
			nointerruptRegion:SetVertexColor(unpack(profile.nointerColor))
	
			nointerruptRegion:ClearAllPoints()
			nointerruptRegion:SetWidth(noInterruptSize[profile.nointerStyle].w * profile.size)
			nointerruptRegion:SetHeight(noInterruptSize[profile.nointerStyle].h * profile.size)
			nointerruptRegion:SetPoint("CENTER", spellIconRegion, "CENTER", 0, 0)
			nointerruptRegion:SetAlpha(1.0)
			nointerruptRegion:Show()

			-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastBarShow() show nointerruptRegion " .. tostring(nointerruptRegion:IsVisible()) .. "/" .. tostring(nointerruptRegion:IsShown()) .. "/" .. tostring(nointerruptRegion:GetParent() and nointerruptRegion:GetParent():IsVisible()) .. "/" .. tostring(nointerruptRegion:GetParent() and nointerruptRegion:GetParent():IsShown()) .. "/" .. tostring(texture) .. "/" .. tostring(nointerruptRegion:GetTexture()))
		elseif nointerruptRegion then
			-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastBarShow() hide nointerruptRegion " .. tostring(nointerruptRegion:IsVisible()) .. "/" .. tostring(nointerruptRegion:IsShown()) .. "/" .. tostring(nointerruptRegion:GetParent() and nointerruptRegion:GetParent():IsVisible()) .. "/" .. tostring(nointerruptRegion:GetParent() and nointerruptRegion:GetParent():IsShown()) .. "/" .. tostring(texture) .. "/" .. tostring(nointerruptRegion:GetTexture()))
			nointerruptRegion:Hide()
		end
	else
		-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastBarShow(): hide " .. tostring(aloftData.name) .. "/" .. tostring(aloftData) .. "/" .. tostring(layoutFrame) .. "/" .. tostring(nointerruptRegion) .. "/" .. tostring(spellIconRegion))
		if nointerruptRegion then
			nointerruptRegion:Hide()
		end
		if spellIconRegion then
			-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastBarShow(): hide spell icon")
			spellIconRegion:Hide()
		end

	end

	self:ScheduleRepeatingEvent("AloftSpellIcon:UpdateCastBar", self.UpdateCastBar, 0.1, self, aloftData)
end

function AloftSpellIcon:OnCastBarHide(aloftData)
	self:CancelScheduledEvent("AloftSpellIcon:UpdateCastBar")

	local layoutFrame = aloftData.layoutFrame
	local spellIconRegion = aloftData.spellIconRegion
	local nointerruptRegion = layoutFrame and layoutFrame.nointerruptRegion

	if nointerruptRegion then
		nointerruptRegion:Hide()
	end
	if spellIconRegion then
		-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastBarHide(): hide spell icon")
		spellIconRegion:Hide()
	end
end

-----------------------------------------------------------------------------

function AloftSpellIcon:UpdateCastBar(aloftData)
	if not profile.enable then
		local layoutFrame = aloftData.layoutFrame
		local spellIconRegion = aloftData.spellIconRegion
		local nointerruptRegion = layoutFrame and layoutFrame.nointerruptRegion

		if nointerruptRegion then
			-- ChatFrame7:AddMessage("AloftSpellIcon:UpdateCastBar(): hide nointerruptRegion")
			nointerruptRegion:Hide()
		end
		if spellIconRegion then
			-- ChatFrame7:AddMessage("AloftSpellIcon:UpdateCastBar(): hide spell icon")
			spellIconRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------
