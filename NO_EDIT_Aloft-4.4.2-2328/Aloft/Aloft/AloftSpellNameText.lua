local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

local AloftCastBar = Aloft:GetModule("CastBar") -- always on
if not AloftCastBar then return end

local AloftSpellNameText = Aloft:NewModule("SpellNameText", Aloft, "AceEvent-3.0")
AloftSpellNameText.dynamic = "AloftCastBarSpellNameText"

-----------------------------------------------------------------------------

AloftSpellNameText.namespace = "spellNameText"
AloftSpellNameText.defaults =
{
	profile =
	{
		enable			= true,
		font			= "Arial Narrow",
		fontSize		= 9,
		shadow			= true,
		alignment		= "LEFT",
		outline			= "",
		offsets =
		{
			left		= 16,
			right		= 0,
			vertical	= 0,
		},
		color			= { 1, 1, 1, 1 },
	},
}

-----------------------------------------------------------------------------

local spellNameTextRegion = nil

-----------------------------------------------------------------------------

function AloftSpellNameText:Update()
	self:CreateFrame()
	self:RegisterEvents()

	if self.db.profile.enable then
		for aloftData in Aloft:IterateVisibleNameplates() do
			self:SetupFrame("AloftSpellNameText:Update", aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftSpellNameText:CreateFrame()
	if not self.db.profile.enable then
		if spellNameTextRegion then
			spellNameTextRegion:Hide()
		end
		return
	end

	if not spellNameTextRegion then
		spellNameTextRegion = UIParent:CreateFontString()
		-- ChatFrame7:AddMessage("AloftSpellNameText:CreateFrame(): " .. tostring(UIParent:GetFrameLevel()))
	end

	self:PrepareText(spellNameTextRegion, self.db.profile)
end

function AloftSpellNameText:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile.enable then
		self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
		self:RegisterMessage("Aloft:OnCastTimeChanged", "UpdateText")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("Aloft:OnCastFrameShow", "OnCastFrameShow")
		self:RegisterMessage("Aloft:OnCastFrameHide", "OnCastFrameHide")
	end
end

-----------------------------------------------------------------------------

function AloftSpellNameText:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftSpellNameText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("Aloft:SetAll", function(message, type, value)
		if AloftSpellNameText.db.profile[type] then
			AloftSpellNameText.db.profile[type] = value
			self:Update()
		end
	end)

	self:Update()
end

function AloftSpellNameText:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if spellNameTextRegion then
		spellNameTextRegion:Hide()
	end
end

function AloftSpellNameText:SetupFrame(message, aloftData)
	if aloftData:IsTarget() then
		self:OnCastFrameShow(message, aloftData)
	end
end

function AloftSpellNameText:UpdateText(message, aloftData)
	local name = nil
	local rank = nil
	if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then
		name = "Spell Name (Rank)"
	else
		name, rank, _, _, _ = AloftCastBar:GetTargetSpellInfo()
	end

	if name then
		local displayName = nil
		if rank and rank ~= "" then
			displayName = name .. " (" .. rank .. ")"
		else
			displayName = name
		end

		-- AloftSpellNameText:OnCastFrameShow(message, aloftData)
		spellNameTextRegion:SetText(displayName)
		spellNameTextRegion:Show()

		-- ChatFrame7:AddMessage("AloftSpellNameText:UpdateText(): " .. tostring(aloftData.name) .. "/" .. tostring(spellNameTextRegion:GetText()))
		-- if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then ChatFrame7:AddMessage("AloftSpellNameText:UpdateText(): config " .. tostring(aloftData.name)) end

		return
	end

	spellNameTextRegion:Hide()
end

function AloftSpellNameText:OnNameplateHide(message, aloftData)
	if aloftData.isTarget or aloftData:IsTarget() then
		self:OnCastFrameHide(message, aloftData)
	end
end

function AloftSpellNameText:OnCastFrameShow(message, aloftData)
	-- ChatFrame7:AddMessage("AloftSpellNameText:OnCastFrameShow(): enter " .. tostring(aloftData.name))

	local castFrame = AloftCastBar:GetCastFrame()
	if castFrame then
		spellNameTextRegion:SetParent(castFrame)
		spellNameTextRegion:SetDrawLayer("OVERLAY")
		-- ChatFrame7:AddMessage("AloftSpellNameText:OnCastFrameShow(): frame level " .. tostring(aloftData.name) .. "/" .. tostring(castFrame:GetFrameLevel()))

		-- ChatFrame7:AddMessage("AloftSpellNameText:OnCastFrameShow(): position")
		spellNameTextRegion:ClearAllPoints()
		spellNameTextRegion:SetPoint("TOPLEFT", castFrame, "TOPLEFT", self.db.profile.offsets.left, self.db.profile.offsets.vertical)
		spellNameTextRegion:SetPoint("BOTTOMRIGHT", castFrame, "BOTTOMRIGHT", self.db.profile.offsets.right, self.db.profile.offsets.vertical)

		-- if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then ChatFrame7:AddMessage("AloftSpellNameText:OnCastFrameShow(): config " .. tostring(aloftData.name)) end
	end
end

function AloftSpellNameText:OnCastFrameHide(message, aloftData)
	-- ChatFrame7:AddMessage("AloftSpellNameText:OnCastFrameHide(): hide")
	spellNameTextRegion:Hide()
end

-- NOTE: not currently used?
function AloftSpellNameText:OnCastBarValueChanged(message, aloftData)
	if self.db.profile.enable and AloftCastBar:IsDisplayEnabled() and spellNameTextRegion then
		local castFrame = AloftCastBar:GetCastFrame()
		if castFrame and castFrame:IsVisible() and (not aloftData.alphaOverride or aloftData.alphaOverride > 0) then
			-- AloftSpellNameText:OnCastFrameShow(message, aloftData)
			spellNameTextRegion:Show()
			return
		end
	else
		-- ChatFrame7:AddMessage("AloftCastBarTimeText:UpdateText(): disabled")
	end

	self:OnCastFrameHide(message, aloftData)
end

-----------------------------------------------------------------------------

end)
