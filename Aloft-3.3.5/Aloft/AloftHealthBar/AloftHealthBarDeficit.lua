local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthBarDeficit", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("HealthBar") then return end

local AloftHealthBarDeficit = Aloft:NewModule("HealthBarDeficit", "AceEvent-2.0")
AloftHealthBarDeficit.dynamic = "AloftHealthBarDeficit"

local SML = AceLibrary("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftHealthBarDeficit.healthBarDB = Aloft:AcquireDBNamespace("healthBar")
AloftHealthBarDeficit.db = Aloft:AcquireDBNamespace("healthBarDeficit")
Aloft:RegisterDefaults("healthBarDeficit", "profile", {
	enable = false,
})

-----------------------------------------------------------------------------

local CreateFrame = CreateFrame

-----------------------------------------------------------------------------

local profile
local healthBarProfile
local colors

-----------------------------------------------------------------------------

function AloftHealthBarDeficit:OnInitialize()
	healthBarProfile = self.healthBarDB.profile
	profile = self.db.profile
end

function AloftHealthBarDeficit:OnEnable()
	Aloft:DebugRegister("HealthBarDeficit")
	self:UpdateAll()
	self:UpdateSizesAll()
end

function AloftHealthBarDeficit:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		self:ReleaseDeficitFrame(aloftData)
		aloftData.healthBar:Show()

	end
end

-----------------------------------------------------------------------------

local dataRequiredList = { }
function AloftHealthBarDeficit:RequiresData()
	self:RegisterEvents()
end

function AloftHealthBarDeficit:RegisterEvents()
	self:UnregisterAllEvents()

	if profile and profile.enable then
		self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
		self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
		self:RegisterEvent("Aloft:OnHealthBarValueChanged", "Update")
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterEvent("Aloft:OnSetHealthBarColor", "OnSetHealthBarColor")

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
	end
end

function AloftHealthBarDeficit:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateShow(aloftData)
		self:Update(aloftData)
	end
end

function AloftHealthBarDeficit:UpdateSizesAll()
	-- Aloft:GetModule("HealthBar"):UpdateAll()
	Aloft:GetModule("Frame"):UpdateAll()
	Aloft:GetModule("Overlay"):UpdateAll()
	self:UpdateAll()
end

-----------------------------------------------------------------------------

function AloftHealthBarDeficit:OnIsTargetDataChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBarDeficit:OnIsTargetDataChanged(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	local eventName = "AloftHealthBarDeficit:OnIsTargetDataChanged: " .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.OnNameplateShow, 0.1, self, aloftData) -- next frame
end

function AloftHealthBarDeficit:OnNameplateShow(aloftData)
	if profile.enable then
		aloftData.healthBar:Hide()
		self:AcquireDeficitFrame(aloftData)
	else
		aloftData.healthBar:Show()
		self:ReleaseDeficitFrame(aloftData)
	end
end

function AloftHealthBarDeficit:OnNameplateHide(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBarDeficit:OnNameplateHide(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
	self:ReleaseDeficitFrame(aloftData)
end

function AloftHealthBarDeficit:OnSetHealthBarColor(aloftData)
	if (profile.enable) then
		self:SetNameplateDeficitColor(aloftData)
	end
end

function AloftHealthBarDeficit:Update(aloftData)
	if profile.enable then
		local layoutFrame = aloftData.layoutFrame
		local deficitFrame = layoutFrame and layoutFrame.deficitFrame
		local healthRegion = deficitFrame and deficitFrame.healthRegion

		local deficit = (aloftData.healthBarMaxValue - aloftData.healthBarValue)
		if deficit > 0 then
			local inset, _ = self:GetBorder(aloftData)
			local width = (deficit / aloftData.healthBarMaxValue) * (deficitFrame:GetWidth() - (2 * inset))

			healthRegion:SetWidth(width)
			healthRegion:Show()
		else
			healthRegion:Hide()
		end
		deficitFrame:Show()
	end
end

-----------------------------------------------------------------------------

function AloftHealthBarDeficit:AcquireDeficitFrame(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBarDeficit:AcquireDeficitFrame(): acquire " .. aloftData.name)
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	if not layoutFrame then
		ChatFrame7:AddMessage("AloftHealthBarDeficit:AcquireDeficitFrame(): no layoutFrame " .. tostring(aloftData.name))
		ChatFrame7:AddMessage("AloftHealthBarDeficit:AcquireDeficitFrame(): " .. debugstack())
	end
	local deficitFrame = layoutFrame.deficitFrame

	if not deficitFrame then
		deficitFrame = CreateFrame("Frame", nil, layoutFrame)

		layoutFrame.deficitFrame = deficitFrame
		deficitFrame.layoutFrame = layoutFrame
	end

	self:SetupFrame(aloftData)

	return deficitFrame
end

local backdropTable =
{
	tile = false,
	tileSize = 16,
	edgeSize = 16,
}

function AloftHealthBarDeficit:GetBorder(aloftData)
	if not healthBarProfile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		return ((healthBarProfile.border ~= "None") and 4) or 0, SML:Fetch("border", healthBarProfile.border)
	else
		return 0, SML:Fetch("border", "None")
	end
end

function AloftHealthBarDeficit:SetupFrame(aloftData)
	local deficitFrame = layoutFrame.deficitFrame
	if deficitFrame then
		local nameplateFrame = aloftData.nameplateFrame
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end

		local texture = SML:Fetch("statusbar", healthBarProfile.texture)
		local inset, edgeFile = self:GetBorder(aloftData)
		local level = nameplateFrame:GetFrameLevel()

		deficitFrame:ClearAllPoints()
		deficitFrame:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", healthBarProfile.offsets.left - inset, healthBarProfile.offsets.vertical + inset)
		deficitFrame:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", healthBarProfile.offsets.right + inset, healthBarProfile.offsets.vertical - healthBarProfile.height - inset)
		deficitFrame:SetFrameLevel(level)
		deficitFrame:Show()

		local healthRegion = deficitFrame.healthRegion
		if not healthRegion then
			healthRegion = deficitFrame:CreateTexture(nil, "ARTWORK")
			healthRegion:SetBlendMode("BLEND")
			deficitFrame.healthRegion = healthRegion
		end
		healthRegion:SetTexture(texture)

		-- glue the right of the health region to the right of the deficit frame, we want motion on the left edge of this region; adjusting for the inset is handled by adjusting the width
		healthRegion:ClearAllPoints()
		healthRegion:SetPoint("TOPRIGHT", deficitFrame, "TOPRIGHT", -inset, -inset)
		healthRegion:SetPoint("BOTTOMRIGHT", deficitFrame, "BOTTOMRIGHT", -inset, inset)
		healthRegion:SetWidth(0)
		healthRegion:Hide()
		-- ChatFrame7:AddMessage("AloftHealthBarDeficit:SetupFrame(): health " .. healthRegion:GetDrawLayer())

		backdropTable.insets = { left = inset, right = inset, top = inset, bottom = inset }
		backdropTable.edgeFile = edgeFile
		backdropTable.bgFile = texture

		deficitFrame:SetBackdrop(backdropTable)
		deficitFrame:SetBackdropColor(unpack(healthBarProfile.colors.backdropColor))
		deficitFrame:SetBackdropBorderColor(unpack(healthBarProfile.borderColor))
		deficitFrame:SetAlpha(nameplateFrame:GetAlpha())

		-- This manipulates the healthbar background to always display above the frame background
		-- ChatFrame7:AddMessage("AloftHealthBarDeficit:SetupFrame(): deficit #regions " .. deficitFrame:GetNumRegions())
		local _, backgroundRegion = deficitFrame:GetRegions()

		backgroundRegion:SetDrawLayer("BACKGROUND")
		backgroundRegion:SetBlendMode("BLEND")
		backgroundRegion:Show()

		-- ChatFrame7:AddMessage("AloftHealthBarDeficit:SetupFrame(): backdrop " .. tostring(aloftData.name) .. "/" .. tostring(layoutFrame:GetWidth()) .. "/" .. tostring(layoutFrame:GetHeight()))
		-- ChatFrame7:AddMessage("AloftHealthBarDeficit:SetupFrame(): health " .. tostring(aloftData.name) .. "/" .. tostring(inset) .. "/" .. tostring(deficitFrame:GetWidth()) .. "/" .. tostring(deficitFrame:GetHeight()))
	end
end

function AloftHealthBarDeficit:ReleaseDeficitFrame(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBarDeficit:ReleaseDeficitFrame(): release " .. aloftData.name)
	self:CleanupDeficitFrame(aloftData)
	self:RePoolDeficitFrame(aloftData)
end

function AloftHealthBarDeficit:CleanupDeficitFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local deficitFrame = layoutFrame and layoutFrame.deficitFrame
	if deficitFrame then
		-- if deficitFrame.healthRegion then deficitFrame.healthRegion:Hide() end
	end
end

function AloftHealthBarDeficit:RePoolDeficitFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local deficitFrame = layoutFrame and layoutFrame.deficitFrame
	if deficitFrame then
		deficitFrame:Hide()
	end
end

function AloftHealthBarDeficit:SetNameplateDeficitColor(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthBarDeficit:SetNameplateDeficitColor(): " .. aloftData.name .. " rgb = " .. aloftData.healthBarR .. "/" .. aloftData.healthBarG .. "/" .. aloftData.healthBarB)
	self:SetAtomicDeficitFrameColors(aloftData, aloftData.healthBarR, aloftData.healthBarG, aloftData.healthBarB, healthBarProfile.alpha)
end

function AloftHealthBarDeficit:SetDeficitFrameColor(aloftData, color)
	self:SetAtomicDeficitFrameColors(aloftData, color[1], color[2], color[3], healthBarProfile.alpha)
end

function AloftHealthBarDeficit:SetAtomicDeficitFrameColors(aloftData, hbr, hbg, hbb, hba)
	local layoutFrame = aloftData.layoutFrame
	local deficitFrame = layoutFrame and layoutFrame.deficitFrame
	if deficitFrame and deficitFrame.healthRegion then
		-- local r, g, b, a = self:GetSemiQuasiPseudoComplementColor(hbr, hbg, hbb, hba)
		local r, g, b, a = hbr, hbg, hbb, hba
		deficitFrame.healthRegion:SetVertexColor(r, g, b, a)
	end
end

function AloftHealthBarDeficit:GetSemiQuasiPseudoComplementColor(r, g, b, a)
	local cr = 1.0 - r
	local cg = 1.0 - g
	local cb = 1.0 - b
	local ca = a

	return cr, cg, cb
end

-----------------------------------------------------------------------------

end)
