local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftCastBar = Aloft:NewModule("CastBar", Aloft, "AceEvent-3.0", "AceTimer-3.0")

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftCastBar.namespace = "castBar"
AloftCastBar.defaults =
{
	profile =
	{
		offsets =
		{
			left		= 0,
			right		= 0,
			vertical	= -12,
		},
		height			= 10,
		incremental		= true,

		border			= "None",
		borderEdgeSize	= 16,
		borderInset		= 4,
		borderColor		= { 1, 1, 1, 1 },
		backdropColor	= { 0.25, 0.25, 0.25, 0.5 },
		color			= { 1.0, 0.7, 0.0, 1.0 },
		texture			= "Blizzard",

		nointerBorder			= "None",
		nointerBorderEdgeSize	= 16,
		nointerBorderInset		= 4,
		nointerBorderColor		= { 1, 1, 1, 1 },
		nointerBackdropColor	= { 0.25, 0.25, 0.25, 0.5 },
		nointerTexture			= "Blizzard",
		nointerColor			= { 1.0, 0.0, 0.0, 1.0 },
	},
}

-----------------------------------------------------------------------------

local inset
local castFrame
local interval = 0.05

local targetCastEndTime

-- backdrop table for initializing visible nameplates
local backdropTable =
{
	-- tile = false,
	-- tileSize = 16,
	bgFile = nil,
	edgeSize = 16,
	edgeFile = nil,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

-- backdrop table for resetting nameplates when they are hidden
local defaultBackdropTable =
{
	-- tile = false,
	-- tileSize = 0,
	bgFile = nil,
	-- edgeSize = 0,
	edgeFile = nil,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

local BORDER_INIT_ATTEMPTS = 2

-----------------------------------------------------------------------------

function AloftCastBar:UpdateAll()
	if Aloft:IsConfigModeEnabled() then
		local aloftData = Aloft:GetTargetNameplate()
		if aloftData then
			self:OnCastBarShow("AloftCastBar:UpdateAll", aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastBar:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end
end

function AloftCastBar:OnEnable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
	self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
	self:RegisterMessage("Aloft:OnCastBarShow", "OnCastBarShow")
	self:RegisterMessage("Aloft:OnCastBarHide", "OnCastBarHide")
	self:RegisterMessage("Aloft:OnCastBarValueChanged", "OnCastBarValueChanged")
	self:RegisterMessage("Aloft:OnCastTimeChanged", "Update")

	self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
	self:RegisterMessage("Aloft:OnConfigModeChanged", "OnConfigModeChanged")

	-- self:RegisterEvent("CVAR_UPDATE", "OnCVarUpdate")

	self:RegisterMessage("SharedMedia_SetGlobal", function(message, mediatype, override)
		if mediatype == "statusbar" then
			self:UpdateAll()
		end
	end)

	self:RegisterMessage("Aloft:SetAll", function(message, type, value)
		if AloftCastBar.db.profile[type] then
			AloftCastBar.db.profile[type] = value

			-- special cases for "nointerrupt" side of things
			if type == "texture" then
				AloftCastBar.db.profile.nointerTexture = value
			elseif type == "border" then
				AloftCastBar.db.profile.nointerBorder = value
			end

			self:UpdateAll()
		end
	end)

	self:UpdateAll()
end

function AloftCastBar:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		local nameplateFrame = aloftData.nameplateFrame
		local castBar = aloftData.castBar

		castBar:ClearAllPoints()
		castBar:SetPoint("BOTTOMRIGHT", aloftData.castBarOverlayRegion, "BOTTOMRIGHT", -4.5, 4.5)
		castBar:SetWidth(116.5)
		castBar:SetHeight(10.18)
		castBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		castBar:SetBackdrop(defaultBackdropTable)
		castBar:SetBackdropColor(0, 0, 0, 0)
		castBar:SetBackdropBorderColor(0, 0, 0, 0)

		castBar:SetFrameLevel(nameplateFrame:GetFrameLevel())
		if castFrame then castFrame:Hide() end
		-- castBar:Show()

		-- TODO: hide castFrame
	end
end

function AloftCastBar:IsDisplayEnabled()
	-- ChatFrame7:AddMessage("AloftCastBar:IsDisplayEnabled(): " .. tostring(type(GetCVar("ShowVKeyCastbar"))) .. "/" .. tostring(GetCVar("ShowVKeyCastbar")) .. "/" .. tostring(GetCVar("ShowVKeyCastbar") == "1"))
	return Aloft:GetNameplateCVar("ShowVKeyCastbar")
end

-- function AloftCastBar:OnCVarUpdate(event, name, value)
	-- ChatFrame7:AddMessage("AloftCastBar:OnCVarUpdate(): " .. tostring(event) .. "/" .. tostring(name) .. "/" .. tostring(type(value)) .. "/" .. tostring(value))
-- end

-----------------------------------------------------------------------------

function AloftCastBar:GetCastFrame()
	-- TODO: flesh this out to actually create the castFrame
	return castFrame
end

function AloftCastBar:AcquireCastFrame(aloftData, noInterrupt)
	-- ChatFrame7:AddMessage("AloftCastBar:AcquireCastFrame(): acquire " .. tostring(aloftData.name) .. "/" .. tostring(noInterrupt))

	if not castFrame then
		castFrame = CreateFrame("Frame", nil, nil)
	end

	castFrame.noInterrupt = noInterrupt
	self:SetupFrame("AloftCastBar:AcquireCastFrame", aloftData)

	-- ChatFrame7:AddMessage("AloftCastBar:AcquireCastFrame(): " .. tostring(aloftData.name) .. "/" .. tostring(castFrame) .. "/" .. tostring(castFrame and castFrame.noInterrupt))
	return castFrame
end

function AloftCastBar:NeedsBorder(aloftData, noInterrupt)
	if noInterrupt then
		return self.db.profile.nointerBorder ~= "None"
	else
		return self.db.profile.border ~= "None"
	end
end

function AloftCastBar:GetBorder(aloftData, noInterrupt)
	if noInterrupt then
		return ((self.db.profile.nointerBorder ~= "None") and self.db.profile.nointerBorderInset) or 0, SML:Fetch("border", self.db.profile.nointerBorder)
		-- return 0, SML:Fetch("border", "None")
	else
		return ((self.db.profile.border ~= "None") and self.db.profile.borderInset) or 0, SML:Fetch("border", self.db.profile.border)
		-- return 0, SML:Fetch("border", "None")
	end
end

function AloftCastBar:SetupFrame(message, aloftData)
	if castFrame then
		local texture, color, backdropColor, borderColor
		if castFrame.noInterrupt then
			texture = SML:Fetch("statusbar", self.db.profile.nointerTexture)
			color = self.db.profile.nointerColor
			backdropColor = self.db.profile.nointerBackdropColor
			borderColor = self.db.profile.nointerBorderColor
			-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): nointerrupt " .. tostring(aloftData.name))
		else
			texture = SML:Fetch("statusbar", self.db.profile.texture)
			color = self.db.profile.color
			backdropColor = self.db.profile.backdropColor
			borderColor = self.db.profile.borderColor
			-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): interrupt " .. tostring(aloftData.name))
		end
		local inset, edgeFile = self:GetBorder(aloftData, castFrame.noInterrupt)

		local castRegion = castFrame.castRegion
		if not castRegion then
			castRegion = castFrame:CreateTexture(nil, "ARTWORK")
			-- castRegion:SetDrawLayer("ARTWORK") -- TODO: redundant
			castRegion:SetBlendMode("BLEND")
			-- castRegion:SetParent(castFrame) -- TODO: redundant

			castFrame.castRegion = castRegion
		end

		castRegion:SetParent(castFrame) -- TODO: redundant
		castRegion:SetTexture(texture)
		castRegion:SetVertexColor(unpack(color))

		castRegion:ClearAllPoints()
		castRegion:SetPoint("TOPLEFT", castFrame, "TOPLEFT", inset, -inset)
		castRegion:SetPoint("BOTTOMLEFT", castFrame, "BOTTOMLEFT", inset, inset)
		castRegion:Show()
		-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): " .. tostring(aloftData.name) .. "/" .. tostring(castRegion:GetTexture()))

		backdropTable.insets.left = inset
		backdropTable.insets.right = inset
		backdropTable.insets.top = inset
		backdropTable.insets.bottom = inset
		backdropTable.edgeFile = edgeFile
		backdropTable.edgeSize = (castFrame.noInterrupt and self.db.profile.nointerBorderEdgeSize) or self.db.profile.borderEdgeSize
		backdropTable.bgFile = texture

		castFrame:SetBackdrop(backdropTable)
		castFrame:SetBackdropBorderColor(unpack(borderColor))

		--[[
		local sr, sg, sb, sa = aloftData.castBarShieldRegion:GetVertexColor()
		ChatFrame7:AddMessage("AloftCastBar:UpdateCastBar(): " .. tostring(aloftData.name) .. "|"
			.. "|" .. tostring(sr) .. "-" .. tostring(sg) .. "-" .. tostring(sb) .. "-" .. tostring(sa)
				.. "/" .. floor(255*sr) .. "." .. floor(255*sg) .. "." .. floor(255*sb) .. "." .. floor(255*sa)
				.. "/" .. ("|c%02x%02x%02x%02xshield color|r"):format(floor(255*sa), floor(255*sr), floor(255*sg), floor(255*sb)))
		]]

		-- this manipulates the cast bar background always display above the frame background
		local _, _, _, _, backgroundRegion = castFrame:GetRegions()

		if backgroundRegion and backgroundRegion.SetBlendMode then
			-- NOTE: as the castFrame has regions added to it, for name text/time text, backgroundRegion will eventually appear in the correct region location
			-- TODO: kludgy, do something about this
			backgroundRegion:SetDrawLayer("BACKGROUND") -- TODO: redundant
			backgroundRegion:SetBlendMode("BLEND")
			-- backgroundRegion:SetParent(castFrame) -- TODO: redundant

			backgroundRegion:Show()
			-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): background region " .. tostring(aloftData.name) .. "/" .. tostring(backgroundRegion:GetTexture()))
		else
			-- ChatFrame7:AddMessage("AloftCastBar:UpdateCastBar(): no background region " .. tostring(aloftData.name) .. "/" .. tostring(castFrame:GetNumRegions()))
		end

		if aloftData and (aloftData.isTarget or aloftData:IsTarget()) then
			local layoutFrame = aloftData.layoutFrame
			if not layoutFrame then
				layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
			end
			if not layoutFrame then
				ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): no layoutFrame " .. tostring(aloftData.name))
				ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): " .. debugstack())
			end
			-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): " .. tostring(aloftData.name) .. "/" .. tostring(castFrame))

			local nameplateFrame = aloftData.nameplateFrame
			castFrame:SetParent(nameplateFrame)
			-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): attach " .. tostring(aloftData.name) .. "/" .. tostring(aloftData) .. "/" .. tostring(castFrame))

			castFrame:SetFrameLevel(nameplateFrame:GetFrameLevel())
			-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): frame level " .. tostring(aloftData.name) .. "/" .. tostring(layoutFrame:GetFrameLevel()) .. "/" .. tostring(castFrame:GetFrameLevel()))

			-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): cast bar frame level " .. tostring(aloftData.nameplateFrame:GetFrameLevel()))
			castFrame:ClearAllPoints()
			castFrame:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", self.db.profile.offsets.left - inset, self.db.profile.offsets.vertical + inset)
			castFrame:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", self.db.profile.offsets.right + inset, self.db.profile.offsets.vertical - self.db.profile.height - inset)

			-- tricky logic here: if we are in config mode, and we currently have a target nameplate, then we do NOT want to hide: castFrame is currently showing on the current target nameplate
			if not Aloft:IsConfigModeEnabled() then
				-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): hide " .. tostring(aloftData.name) .. "/" .. tostring(debugstack(1, 100, 100)))
				castFrame:Hide()
				-- NOTE: under active spell-cast conditions (i.e. not config mode): don't show the castFrame here; we don't show until the default cast bar values begin to change
			end

			-- NOTE: hiding default cast bar via alpha does not seem to effect the alpha of bar/background colors
			local r, g, b, a = unpack(backdropColor)
			local _, _, _, castBarAlpha = aloftData.castBar:GetStatusBarColor()
			a = a * castBarAlpha

			castFrame:SetBackdropColor(r, g, b, a)
		end
	end
end

function AloftCastBar:ReleaseCastFrame(aloftData)
	-- ChatFrame7:AddMessage("AloftCastBar:ReleaseCastFrame(): release " .. aloftData.name)

	self:CancelAllTimers()

	self:CleanupCastFrame(aloftData)
	self:RePoolCastFrame(aloftData)
	targetCastEndTime = nil
end

function AloftCastBar:CleanupCastFrame(aloftData)
	if castFrame then
		castFrame.noInterrupt = nil
		castFrame.elapsedTime = nil
		-- if castFrame.castRegion then castFrame.castRegion:Hide() end
		self:ClearBackdrop(castFrame)
		castFrame:Hide()
		-- ChatFrame7:AddMessage("AloftCastBar:CleanupCastFrame(): clear " .. tostring(aloftData.name) .. "/" .. tostring(aloftData) .. "/" .. tostring(castFrame))
	end
end

function AloftCastBar:RePoolCastFrame(aloftData)
	if castFrame then
		-- clear the frame-delay flag, this bar should be initialized when re-used
		castFrame.init = nil

		castFrame:SetParent(nil) -- disassociate from nameplate when cast is done
		-- ChatFrame7:AddMessage("AloftCastBar:RePoolCastFrame(): detach " .. tostring(aloftData.name) .. "/" .. tostring(aloftData) .. "/" .. tostring(castFrame))
	end
end

function AloftCastBar:ClearBackdrop(castFrame)
	if castFrame then
		castFrame:SetBackdropColor(0, 0, 0, 0)
		castFrame:SetBackdropBorderColor(0, 0, 0, 0)

		-- NOTE: doing this on nameplate hide may case #132 crashes
		-- castFrame:SetBackdrop(defaultBackdropTable)
	end
end

-----------------------------------------------------------------------------

function AloftCastBar:OnNameplateHide(message, aloftData)
	if aloftData.isTarget or aloftData:IsTarget() then
		-- ChatFrame7:AddMessage("AloftCastBar:OnNameplateHide(): hide " .. tostring(aloftData.name))
		-- if Aloft:IsConfigModeEnabled() then ChatFrame7:AddMessage("AloftCastBar:OnNameplateHide(): release " .. tostring(aloftData.name)) end
		self:ReleaseCastFrame(aloftData)
		-- self:SendMessage("Aloft:OnCastFrameHide", aloftData)
	end
end

-- NOTE: when cast bar is disabled (i.e. via Blizzard "Combat>Cast Bar>On Nameplates"),
--       Blizzard delivers an "OnShow" event, followed immediately by an "OnHide" event, and no "OnValueChanged" events;
--       and apparently, in the process, it shows the default target spell cast icon for a few frames, and leaves it

-- it is assumed here that aloftData represents the current target cast bar
function AloftCastBar:OnCastBarShow(message, aloftData)
	-- ChatFrame7:AddMessage("AloftCastBar:OnCastBarShow(): enter " .. tostring(aloftData.name))

	local castBar = aloftData.castBar
	if castBar then castBar:SetAlpha(0.0) end -- always hide the Blizzard cast bar, regardless of other outcome

	if self:IsDisplayEnabled() then
		if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then

			self:AcquireCastFrame(aloftData, true)

			castFrame:Show() -- NOTE: needs to be made visible here to insure that other modules can detect IsVisible and provide their elements

			self:SendMessage("Aloft:OnCastFrameShow", aloftData)
			self:SendMessage("Aloft:OnCastTimeChanged", aloftData)
			-- ChatFrame7:AddMessage("AloftCastBar:OnCastBarShow(): config " .. tostring(aloftData.name) .. "/" .. tostring(castFrame:GetFrameLevel()))

			return
		else
			local name, _, elapsedTime, endTime, noInterrupt = self:GetTargetSpellInfo()

			-- it is possible for "endTime" to be nil here, on interrupt (race condition between cast bar showing and cast already being interrupted)
			targetCastEndTime = (endTime and endTime / 1000.0) or nil
			-- ChatFrame7:AddMessage("AloftCastBar:OnCastBarShow(): acquire " .. tostring(aloftData.name) .. "/" .. tostring(name) .. "/" .. tostring(targetCastEndTime) .. "/" .. tostring(GetTime()) .. "/" .. tostring(noInterrupt))

			if name then
				self:AcquireCastFrame(aloftData, noInterrupt)

				castFrame.elapsedTime = (elapsedTime > 0.0 and (elapsedTime / 1000.0)) or 0.0

				castFrame:Show()
				self:ScheduleRepeatingTimer(function(aloftData) AloftCastBar:DoCastBarValueChanged(aloftData) end, interval, aloftData)

				-- ChatFrame7:AddMessage("AloftCastBar:OnCastBarShow(): show " .. tostring(aloftData.name) .. "/" .. tostring(name) .. "/" .. tostring(noInterrupt) .. "/" .. tostring(castFrame:GetFrameLevel()))
				self:SendMessage("Aloft:OnCastFrameShow", aloftData)

				return
			end
		end
	else
		-- ChatFrame7:AddMessage("AloftCastBar:OnCastBarShow(): disabled")
	end

	-- ChatFrame7:AddMessage("AloftCastBar:OnCastBarShow(): hide " .. tostring(aloftData.name) .. "/" .. tostring(castFrame and castFrame:GetFrameLevel()))
	-- if Aloft:IsConfigModeEnabled() then ChatFrame7:AddMessage("AloftCastBar:OnCastBarShow(): release " .. tostring(aloftData.name) .. "/" .. tostring(debugstack(1, 100, 100))) end
	self:ReleaseCastFrame(aloftData)
	self:SendMessage("Aloft:OnCastFrameHide", aloftData)
end

function AloftCastBar:OnCastBarHide(message, aloftData)
	-- ChatFrame7:AddMessage("AloftCastBar:OnCastBarHide(): enter " .. tostring(aloftData.name))
	-- self:SendMessage("Aloft:OnCastFrameHide", aloftData)
	-- let normal update process hide castFrame
end

function AloftCastBar:OnIsTargetDataChanged(message, aloftData)
	if Aloft:IsConfigModeEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then
		-- ChatFrame7:AddMessage("AloftCastBar:OnIsTargetDataChanged(): enter " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.isTarget))
		self:ScheduleTimer(function(aloftData) AloftCastBar:OnCastBarShow("AloftCastBar:OnIsTargetDataChanged", aloftData) end, 0.0, aloftData) -- next frame
		-- NOTE: currently, this is really only used by "preview" mode, so the degree of delay here is not a big deal
	else
		self:ReleaseCastFrame(aloftData)
	end
end

function AloftCastBar:OnConfigModeChanged(message)
	local aloftData = Aloft:GetTargetNameplate()
	if aloftData then
		if Aloft:IsConfigModeEnabled() then
			self:OnCastBarShow("AloftBossIcon:OnConfigModeChanged", aloftData)
		else
			self:ReleaseCastFrame(aloftData)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastBar:OnCastBarValueChanged(message, aloftData)
	self:DoCastBarValueChanged(aloftData)
end

function AloftCastBar:DoCastBarValueChanged(aloftData)
	local name, _, elapsedTime, endTime, noInterrupt = self:GetTargetSpellInfo()

	if castFrame then
		if name then
			castFrame.elapsedTime = (elapsedTime > 0.0 and (elapsedTime / 1000.0)) or 0.0

			-- ChatFrame7:AddMessage("AloftCastBar:DoCastBarValueChanged(): " .. tostring(aloftData.name) .. "/" .. tostring(name) .. "/" .. tostring(castFrame.elapsedTime))
		else
			castFrame.elapsedTime = nil
		end
	end
	self:SendMessage("Aloft:OnCastTimeChanged", aloftData)
end

-----------------------------------------------------------------------------

function AloftCastBar:CalculateFrameWidth(aloftData, castFrame)
	local inset, _ = self:GetBorder(aloftData, castFrame.noInterrupt)

	-- by hook or by crook, value must end up non-nil
	local castBar = aloftData.castBar
	local value = castFrame.elapsedTime or 0.0
	local minValue, maxValue = castBar:GetMinMaxValues()
	local width = ((maxValue and maxValue > 0) and (value / maxValue) * (castFrame:GetWidth() - (2 * inset))) or 0

	return minValue, value, maxValue, width
end

function AloftCastBar:Update(message, aloftData)
	-- ChatFrame7:AddMessage("AloftCastBar:Update(): enter " .. tostring(aloftData.name))

	local castBar = aloftData.castBar
	if castBar then castBar:SetAlpha(0.0) end -- always hide the Blizzard cast bar, regardless of other outcome

	if self:IsDisplayEnabled() and (aloftData.isTarget or aloftData:IsTarget()) then
		if Aloft:IsConfigModeEnabled() then
			local inset, _ = self:GetBorder(aloftData, true)
			local width = 0.7 * (castFrame:GetWidth() - (2 * inset))
			local castRegion = castFrame.castRegion
			-- ChatFrame7:AddMessage("AloftCastBar:Update(): config " .. tostring(aloftData.name) .. "/" .. tostring(castFrame:GetWidth()) .. "/" .. tostring(width))

			castRegion:SetWidth(width)
			castFrame:Show()

			-- ChatFrame7:AddMessage("AloftCastBar:Update(): config " .. tostring(aloftData.name) .. "/" .. tostring(castFrame:GetFrameLevel()))
			return
		elseif castFrame and aloftData.nameplateFrame:IsVisible() and (not aloftData.alphaOverride or aloftData.alphaOverride > 0) and
		   targetCastEndTime and targetCastEndTime >= GetTime() and self:IsTargetCasting() then
			-- TODO: record the endTime, and check current time against it here
			local minValue, value, maxValue, width = self:CalculateFrameWidth(aloftData, castFrame)
			if (value >= minValue) and (value <= maxValue) then
				local castRegion = castFrame.castRegion
				if width and width > 0 and castRegion then
					-- ChatFrame7:AddMessage("AloftCastBar:Update(): " .. tostring(aloftData.name) .. "/" .. tostring(value) .. "/" .. tostring(width))

					if AloftCastBar:NeedsBorder(aloftData, noInterrupt) and self.db.profile.incremental and (not castFrame.init or castFrame.init < BORDER_INIT_ATTEMPTS) then
						castRegion:SetWidth(1) -- width is initially bogus, updated after a frame delay below
					end
					castFrame:Show() -- show on every value change

					if AloftCastBar:NeedsBorder(aloftData, noInterrupt) and self.db.profile.incremental then
						-- frame delay to set the real width; hopefully avoids the "missing/malformed border" issue
						self:ScheduleTimer(function(arg) AloftCastBar:DoShowCastFrame(arg) end, 0.0, width) -- one frame
					else
						self:DoShowCastFrame(width)
					end

					return
				end
			end
		end
	else
		-- ChatFrame7:AddMessage("AloftCastBar:Update(): disabled or not target")
	end

	-- ChatFrame7:AddMessage("AloftCastBar:Update(): hide " .. tostring(aloftData.name) .. "/" .. tostring(castFrame:GetFrameLevel()))
	-- if Aloft:IsConfigModeEnabled() then ChatFrame7:AddMessage("AloftCastBar:Update(): hide " .. tostring(aloftData.name)) end
	self:ReleaseCastFrame(aloftData)
	self:SendMessage("Aloft:OnCastFrameHide", aloftData) -- for some reason, this works much better here (frame update delay issues?)
end

function AloftCastBar:DoShowCastFrame(width)
	if castFrame then
		castFrame.castRegion:SetWidth(width)

		-- flag as having been through the first frame-delay
		if castFrame then
			if not castFrame.init then
				castFrame.init = 0
			else
				castFrame.init = castFrame.init + 1
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastBar:GetTargetSpellInfo()
	local now = GetTime() * 1000 -- convert to milliseconds

	local _, rank, displayName, _, startTime, endTime, _, castId, noInterrupt = UnitCastingInfo("target")
	if displayName then
		local elapsedTime = now - startTime
		-- ChatFrame7:AddMessage("AloftCastBar:GetTargetSpellInfo(): casting " .. tostring(UnitName("target")) .. "/" .. tostring(displayName) .. "/" .. tostring(castId) .. "/" .. tostring(endTime) .. "/" .. tostring(noInterrupt))
		return displayName, rank, elapsedTime, endTime, noInterrupt
	end
	_, rank, displayName, _, startTime, endTime, _, noInterrupt = UnitChannelInfo("target")
	if displayName then
		local elapsedTime = endTime - startTime - (now - startTime)
		-- ChatFrame7:AddMessage("AloftCastBar:GetTargetSpellInfo(): channel " .. tostring(UnitName("target")) .. "/" .. tostring(displayName) .. "/" .. tostring(castId) .. "/" .. tostring(endTime) .. "/" .. tostring(noInterrupt))
		return displayName, rank, elapsedTime, endTime, noInterrupt
	end
	return nil, nil, nil, nil
end

function AloftCastBar:IsTargetCasting()
	local name, _, _, _, _, _, _, _, _ = UnitCastingInfo("target")
	if not name then
		name, _, _, _, _, _, _, _ = UnitChannelInfo("target")
	end
	return name
end

-----------------------------------------------------------------------------
