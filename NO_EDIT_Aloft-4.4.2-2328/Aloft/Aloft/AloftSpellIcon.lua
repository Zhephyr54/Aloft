local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftCastBar = Aloft:GetModule("CastBar") -- always on
if not AloftCastBar then return end

local AloftSpellIcon = Aloft:NewModule("SpellIcon", Aloft, "AceEvent-3.0")

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftSpellIcon.namespace = "spellIcon"
AloftSpellIcon.defaults =
{
	profile =
	{
		enable			= true,
		point			= "LEFT",
		relativeToPoint	= "LEFT",
		offsetX			= 0,
		offsetY			= 0,
		size			= 11,

		nointerShield	= true,
		nointerStyle	= "SQUARE",
		nointerColor	= { 1.0, 1.0, 1.0, 0.65 }, -- white
		nointerScale	= 2.5,
		nointerOffsetX	= 0,
		nointerOffsetY	= 0,
	},
}

-----------------------------------------------------------------------------

-- textures for shield graphic
SML:Register("shield",	"ROUND",			[[Interface\Addons\Aloft\Textures\RndNoInterrupt]])
SML:Register("shield",	"SQUARE",			[[Interface\Addons\Aloft\Textures\SqrNoInterrupt]])
SML:Register("shield",	"BLIZZARD",			[[Interface\CastingBar\UI-CastingBar-Arena-Shield]])

local configSpellIconTexture = [[Interface\Icons\Spell_Nature_Polymorph]]

local spellIconRegion
local nointerruptRegion

-----------------------------------------------------------------------------

function AloftSpellIcon:UpdateAll()
	if Aloft:IsConfigModeEnabled() then
		local aloftData = Aloft:GetTargetNameplate()
		if aloftData then
			self:OnCastFrameShow("AloftSpellIcon:UpdateAll", aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftSpellIcon:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftSpellIcon:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
	self:RegisterMessage("Aloft:OnCastFrameShow", "OnCastFrameShow")
	self:RegisterMessage("Aloft:OnCastFrameHide", "OnCastFrameHide")
	self:RegisterMessage("Aloft:OnCastTimeChanged", "OnCastTimeChanged")
	self:UpdateAll()
end

function AloftSpellIcon:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		local bSpellIconRegion = aloftData.spellIconRegion

		bSpellIconRegion:ClearAllPoints()
		bSpellIconRegion:SetPoint("CENTER", aloftData.nameplateFrame, "BOTTOMLEFT", 13.33, 10.29)
		bSpellIconRegion:SetWidth(14.5)
		bSpellIconRegion:SetHeight(14.5)
		bSpellIconRegion:SetParent(aloftData.nameplateFrame)

		if spellIconRegion then
			spellIconRegion:Hide()

			-- ChatFrame7:AddMessage("AloftSpellIcon:OnDisable(): hide " .. tostring(aloftData.name))
		end
		if nointerruptRegion then
			nointerruptRegion:Hide()
		end
	end
end

function AloftSpellIcon:OnNameplateShow(message, aloftData)
end

function AloftSpellIcon:OnNameplateHide(message, aloftData)
	-- if aloftData.isTarget or aloftData:IsTarget() then
	--	self:OnCastFrameHide(message, aloftData)
	-- end
end

-- TODO: propagate this to name text, level text, boss icon, and/or other "default" nameplate components as needed
function AloftSpellIcon:GetInset(aloftData, noInterrupt)
	if noInterrupt then
		return ((AloftCastBar.db.profile.border ~= "None") and 4) or 0
	else
		return ((AloftCastBar.db.profile.nointerBorder ~= "None") and 4) or 0
	end
end

function AloftSpellIcon:OnCastFrameShow(message, aloftData)
	-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameShow(): enter " .. tostring(aloftData.name))
	-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameShow(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData) .. "/" .. tostring(aloftData.layoutFrame) .. "/" .. tostring(nointerruptRegion) .. "/" .. tostring(aloftData.spellIconRegion))
	-- if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameShow(): config enter " .. tostring(aloftData.name) .. "/" .. tostring(Aloft:IsConfigModeEnabled()) .. "/" .. tostring(aloftData.isTarget or aloftData:IsTarget())) end

	local bSpellIconRegion = aloftData.spellIconRegion
	if bSpellIconRegion then bSpellIconRegion:SetAlpha(0.0) end -- always hide the Blizzard spell icon, regardless of other outcome

	if self.db.profile.enable then
		-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameShow(): enable " .. tostring(aloftData.name))
		local castFrame = AloftCastBar:GetCastFrame()
		if castFrame then
			local texture = (Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) and configSpellIconTexture) or (bSpellIconRegion and bSpellIconRegion.GetTexture and bSpellIconRegion:GetTexture())

			if not spellIconRegion then
				spellIconRegion = castFrame:CreateTexture(nil, "OVERLAY")
				-- spellIconRegion:SetDrawLayer("OVERLAY") -- TODO: redundant
				spellIconRegion:SetBlendMode("BLEND")
				-- spellIconRegion:SetParent(castFrame) -- TODO: redundant
			end

			spellIconRegion:SetTexture(texture)
			spellIconRegion:SetWidth(self.db.profile.size)
			spellIconRegion:SetHeight(self.db.profile.size)
			-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameShow(): spell icon initialized " .. ("|T%s:0|t"):format(texture) .. "/" .. ("|T%s:0|t"):format(spellIconRegion:GetTexture(texture)))

			local inset = self:GetInset(aloftData, castFrame.noInterrupt)
			local hinset, vinset = Aloft:AdjustFrame(inset, self.db.profile.relativeToPoint)

			self:PlaceFrame(spellIconRegion, castFrame, self.db.profile, hinset, vinset)

			if self.db.profile.nointerShield then
				if not nointerruptRegion then
					nointerruptRegion = castFrame:CreateTexture(nil, "BORDER")
					-- nointerruptRegion:SetDrawLayer("BORDER") -- TODO: redundant
					nointerruptRegion:SetBlendMode("BLEND")
					-- nointerruptRegion:SetParent(castFrame) -- TODO: redundant
				end

				-- the nointerrupt graphic is a shield-like graphic that centers on the spell icon.
				local noITexture = SML:Fetch("shield", self.db.profile.nointerStyle)
				-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameShow(): " .. tostring(aloftData.name) .. "/" .. tostring(self.db.profile.nointerStyle) .. "/" .. tostring(noITexture))

				nointerruptRegion:SetTexture(noITexture)
				nointerruptRegion:SetVertexColor(unpack(self.db.profile.nointerColor))

				nointerruptRegion:ClearAllPoints()
				nointerruptRegion:SetWidth(self.db.profile.nointerScale * self.db.profile.size)
				nointerruptRegion:SetHeight(self.db.profile.nointerScale * self.db.profile.size)
				nointerruptRegion:SetPoint("CENTER", spellIconRegion, "CENTER", self.db.profile.nointerOffsetX, self.db.profile.nointerOffsetY)
				nointerruptRegion:SetAlpha(1.0)

				-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameShow() show nointerruptRegion " .. tostring(nointerruptRegion:IsVisible()) .. "/" .. tostring(nointerruptRegion:IsShown()) .. "/" .. tostring(nointerruptRegion:GetParent() and nointerruptRegion:GetParent():IsVisible()) .. "/" .. tostring(nointerruptRegion:GetParent() and nointerruptRegion:GetParent():IsShown()) .. "/" .. tostring(texture) .. "/" .. tostring(nointerruptRegion:GetTexture()))
			end
			-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameShow(): noInterrupt " .. tostring(castFrame.noInterrupt))
		end
		-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameShow(): layout " .. tostring(aloftData.name) .. "/" .. tostring(aloftData) .. "/" .. tostring(layoutFrame) .. "/" .. tostring(nointerruptRegion) .. "/" .. tostring(spellIconRegion))
		-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameShow(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.layoutFrame and aloftData.layoutFrame:GetFrameLevel()) .. "/" .. tostring(castFrame and castFrame:GetFrameLevel()))
	end
end

function AloftSpellIcon:OnCastFrameHide(message, aloftData)
	-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameHide(): hide " .. tostring(aloftData.name))

	if nointerruptRegion then
		nointerruptRegion:Hide()
	end
	if spellIconRegion then
		spellIconRegion:Hide()

		-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameHide(): hide " .. tostring(aloftData.name))
	end
	
	local bSpellIconRegion = aloftData.spellIconRegion
	if bSpellIconRegion then bSpellIconRegion:SetAlpha(0.0) end
end

function AloftSpellIcon:OnCastTimeChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameShow(): enter " .. tostring(aloftData.name))
	-- if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then ChatFrame7:AddMessage("AloftSpellIcon:OnCastTimeChanged(): config enter " .. tostring(aloftData.name) .. "/" .. tostring(Aloft:IsConfigModeEnabled()) .. "/" .. tostring(aloftData.isTarget or aloftData:IsTarget()) .. "/" .. tostring(aloftData.spellIconRegion) .. "/" .. tostring(nointerruptRegion) .. "/" .. tostring(self.db.profile.enable) .. "/" .. tostring(AloftCastBar:IsDisplayEnabled())) end

	local bSpellIconRegion = aloftData.spellIconRegion
	if bSpellIconRegion then bSpellIconRegion:SetAlpha(0.0) end -- always hide the Blizzard spell icon, regardless of other outcome

	if self.db.profile.enable and AloftCastBar:IsDisplayEnabled() then
		-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastTimeChanged(): step 1 " .. tostring(aloftData.name) .. "/" .. tostring(self.db.profile.enable) .. "/" .. tostring(AloftCastBar:IsDisplayEnabled()) .. "/" .. tostring(spellIconRegion) .. "/" .. tostring(nointerruptRegion))
		 if spellIconRegion or nointerruptRegion then
			-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastTimeChanged(): step 2 " .. tostring(aloftData.name) .. "/" .. tostring(spellIconRegion) .. "/" .. tostring(nointerruptRegion) .. "/" .. tostring(aloftData.alphaOverride) .. "/" .. tostring(castFrame and castFrame:IsVisible()))
			local castFrame = AloftCastBar:GetCastFrame()
			if (not aloftData.alphaOverride or aloftData.alphaOverride > 0) and castFrame and castFrame:IsVisible() --[[ and castFrame:GetParent() == aloftData.nameplateFrame ]] then
				-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastFrameShow(): " .. tostring(aloftData.name) .. "/" .. tostring(spellIconRegion) .. "/" .. tostring(nointerruptRegion) .. "/" .. tostring(castFrame.noInterrupt))
				-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastTimeChanged(): step 3 " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.alphaOverride) .. "/" .. tostring(castFrame) .. "/" .. tostring(castFrame and castFrame:IsVisible()))

				-- NOTE: looks like Blizzard may at least partially re-assemble the default spell icon region on every frame; hide regularly
				local texture = (Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) and configSpellIconTexture) or (bSpellIconRegion and bSpellIconRegion.GetTexture and bSpellIconRegion:GetTexture())

				if spellIconRegion then
					spellIconRegion:SetParent(castFrame)
					spellIconRegion:SetTexture(texture) -- re-initialize spell icon texture regularly (in case the spell being cast changes without detection)
					spellIconRegion:Show()

					-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastTimeChanged(): show " .. tostring(aloftData.name) .. "/" .. tostring(spellIconRegion:IsVisible()) .. "/" .. tostring(spellIconRegion:GetAlpha()) .. "/" .. ("|T%s:0|t"):format(spellIconRegion:GetTexture(texture)))
				end
				if nointerruptRegion then
					if castFrame.noInterrupt and self.db.profile.nointerShield then
						nointerruptRegion:Show()
					else
						nointerruptRegion:Hide()
					end
				end

				-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastTimeChanged(): show " .. tostring(aloftData.name))
				-- if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then ChatFrame7:AddMessage("AloftSpellIcon:OnCastTimeChanged(): config " .. tostring(aloftData.name) .. "/" .. tostring(castFrame.noInterrupt) .. "/" .. tostring(spellIconRegion and spellIconRegion:IsVisible()) .. "/" .. tostring(nointerruptRegion and nointerruptRegion:IsVisible())) end
				return
			else
				-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastTimeChanged(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.layoutFrame and aloftData.layoutFrame:GetFrameLevel()) .. "/" .. tostring(castFrame and castFrame:GetFrameLevel()))
			end
		end
	else
		-- ChatFrame7:AddMessage("AloftSpellIcon:OnCastTimeChanged(): disabled")
	end

	self:OnCastFrameHide(message, aloftData)
end

-----------------------------------------------------------------------------
