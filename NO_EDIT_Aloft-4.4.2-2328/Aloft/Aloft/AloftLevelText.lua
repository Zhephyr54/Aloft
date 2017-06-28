local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

-- local AloftHealthBar = Aloft:GetModule("HealthBar") -- always on
-- if not AloftHealthBar then return end

local AloftLevelText = Aloft:NewModule("LevelText", Aloft, "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

AloftLevelText.namespace = "levelText"
AloftLevelText.defaults =
{
	profile =
	{
		enable				= true,
		font				= "Arial Narrow",
		fontSize			= 8,
		outline				= "OUTLINE",
		shadow				= false,
		point				= "RIGHT",
		relativeToPoint		= "RIGHT",
		offsetX				= 0,
		offsetY				= 0,
		showCreatureType	= false,
		showClassification	= false,
		showRace			= false,
		overrideText		= false,
		format				= "",
	},
}

-----------------------------------------------------------------------------

--[[
function AloftLevelText:DumpCoords(arg)
	-- local point, relativeTo, relativePoint, xOfs, yOfs = arg.object:GetPoint(self.db.profile.point)
	local left = arg.object:GetLeft()
	local right = arg.object:GetRight()
	local top = arg.object:GetTop()
	local bottom = arg.object:GetBottom()
	ChatFrame7:AddMessage(arg.caller .. ": " .. tostring(arg.name) .. "/" .. tostring(top) .. "/" .. tostring(left) .. "/" .. tostring(bottom) .. "/" .. tostring(right))
end
]]

--[[
-- TODO: propagate this to name text, level text, boss icon, and/or other "default" nameplate components as needed
function AloftLevelText:GetInset(aloftData)
	return ((AloftHealthBar.db.profile.border ~= "None") and 4) or 0
end
]]

function AloftLevelText:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateShow("AloftLevelText:UpdateAll", aloftData)
	end
end

function AloftLevelText:RegisterEvents()
	-- ChatFrame7:AddMessage("AloftLevelText:RegisterEvents(): enter")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	-- self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateLevelFromTarget")
	self:RegisterEvent("UNIT_LEVEL", "OnUnitLevel")

	self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
	self:RegisterMessage("Aloft:SetAll", function(message, type, value)
										if AloftLevelText.db.profile[type] then
											AloftLevelText.db.profile[type] = value
											AloftLevelText:UpdateAll()
										end
									  end)

	if self.db.profile.enable then
		if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethod or not self.textMethodData.events) then
			self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		if self.textMethodData and self.textMethodData.events then
			for events in pairs(self.textMethodData.events) do
				-- ChatFrame7:AddMessage("AloftLevelText:RequiresData(): " .. register " .. tostring(events))
				self:RegisterMessage(events, "UpdateText") -- pure data-related update
			end
		end
	end

	self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow") -- full setup/initialization on nameplate show

	-- ChatFrame7:AddMessage("AloftLevelText:RegisterEvents(): enter")
end

local dataRequiredList = { }
function AloftLevelText:RequiresData()
	self:RegisterEvents()

	if not self.db.profile.enable or not self.db.profile.overrideText then
		return
	end

	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethod or not self.textMethodData.data) then
		self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	if self.textMethodData and self.textMethodData.data then
		for data in pairs(self.textMethodData.data) do
			-- ChatFrame7:AddMessage("AloftLevelText:RequiresData(): requires " .. tostring(data))
			table.insert(dataRequiredList, data)
		end
	end

	return unpack(dataRequiredList)
end

-----------------------------------------------------------------------------

function AloftLevelText:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftLevelText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UpdateAll()
end

function AloftLevelText:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		local nameplateFrame = aloftData.nameplateFrame
		local levelTextRegion = aloftData.levelTextRegion

		levelTextRegion:ClearAllPoints()
		levelTextRegion:SetPoint("CENTER", nameplateFrame, "BOTTOMRIGHT", -13.331, 10.288)
		levelTextRegion:SetFont(NAMEPLATE_FONT, 11)
		levelTextRegion:SetShadowOffset(1, -1)
		levelTextRegion:SetAlpha(1)
		levelTextRegion:SetText(tostring(aloftData.level or -1))
		-- ChatFrame7:AddMessage("AloftLevelText:OnDisable(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.level))
	end
	self:UnhookAll()
end

function AloftLevelText:SetupFrame(message, aloftData)
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	local aLevelTextRegion = layoutFrame.levelTextRegion

	-- Check if this nameplate already has a level text region assigned to it
	if not aLevelTextRegion then
		aLevelTextRegion = aloftData:CreateFontString()
		aLevelTextRegion:SetParent(layoutFrame)

		layoutFrame.levelTextRegion = aLevelTextRegion

		if aLevelTextRegion.SetNonSpaceWrap then
			aLevelTextRegion:SetNonSpaceWrap(false)
		end
		aLevelTextRegion:SetDrawLayer("OVERLAY")
	end

	-- if aloftData.name == "[invalid]" or not self.db or not self.db.profile or not self.db.profile.font or not self.db.profile.fontSize or not self.db.profile.outline then
		-- ChatFrame7:AddMessage("AloftLevelText:SetupFrame(): " .. tostring(aloftData.name) .. "/" .. tostring(aLevelTextRegion) .. "/" .. tostring(self.db) .. "/" .. tostring(self.db.profile) .. "/" .. tostring(self.db.profile.font) .. "/" .. tostring(self.db.profile.fontSize) .. "/" .. tostring(self.db.profile.outline) --[[.. "/" .. tostring(SML:Fetch("font", self.db.profile.font))]])
		-- ChatFrame7:AddMessage("AloftLevelText:SetupFrame(): " .. debugstack())
	-- end

	self:PrepareText(aLevelTextRegion, self.db.profile)
	self:PlaceFrame(aLevelTextRegion, layoutFrame, self.db.profile, 0, 0)
	-- self:ScheduleTimer(function(aloftData) AloftLevelText:DoPlaceFrame(aloftData) end, 0.0, aloftData)

	-- NOTE: we no longer hook the text region as a way of detecting changes to level text; we listen for the UNIT_LEVEL event instead;
	--       possible pathology, which we choose to live with: visible friendly units without unitids could level, and the nameplate
	--       would have to bounce in order to pick up the change

	local bLevelTextRegion = aloftData.levelTextRegion
	-- if not self:IsHooked(bLevelTextRegion, "GetText") then self:RawHook(bLevelTextRegion, "GetText", "GetLevelTextRegionText", true) end
	-- if not self:IsHooked(bLevelTextRegion, "SetText") then self:RawHook(bLevelTextRegion, "SetText", "SetLevelTextRegionText", true) end
	bLevelTextRegion:Hide()
end

--[[
-- NOTE: we no longer hook the text region as a way of detecting changes to level text; we listen for the UNIT_LEVEL event instead;
--       possible pathology, which we choose to live with: visible friendly units without unitids could level, and the nameplate
--       would have to bounce in order to pick up the change
function AloftLevelText:GetLevelTextRegionText(this)
	local level = this.aloftData.level
	if level then return level end
	return self.hooks[this].GetText(this)
end
]]

--[[
function AloftLevelText:SetLevelTextRegionText(this, text)
	local aloftData = this.aloftData
	
	local level = text:match("%d+")
	if level and level ~= tostring(aloftData.level) then
		aloftData.level = tonumber(level)
	end

	if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethod) then
		self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
		self.textMethod = self.textMethodData.method
	end

	self.hooks[this].SetText( this, text )
end
]]

function AloftLevelText:UpdateText(message, aloftData)
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	local aLevelTextRegion = layoutFrame.levelTextRegion

	if not aLevelTextRegion then return end -- stub out if not yet initialized

	if self.db.profile.enable then
		if self.db.profile.overrideText then
			if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethod) then
				self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
				self.textMethod = self.textMethodData.method
			end
			-- ChatFrame7:AddMessage("AloftLevelText:RequiresData(): " .. tostring(aloftData.name) .. "/" ..
			--	("%s:0x%02x%02x%02x"):format(tostring(aloftData.class), floor(aloftData.originalHealthBarR*255), floor(aloftData.originalHealthBarG*255), floor(aloftData.originalHealthBarB*255)))

			-- handle the case where the format tag is "empty" and there is no text method
			local text = (self.textMethod and self.textMethod(aloftData)) or ""

			-- ChatFrame7:AddMessage("AloftLevelText:UpdateText(): 1 " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.level) .. "/" .. tostring(text))
			-- ChatFrame7:AddMessage("AloftLevelText:UpdateText(): 1 " .. debugstack(1, 8, 8))
			aLevelTextRegion:SetTextColor(aloftData.levelTextR, aloftData.levelTextG, aloftData.levelTextB) -- color for default text, selectively overidden by format
			aLevelTextRegion:SetText(text)
			aLevelTextRegion:Show()
			-- TODO: sniff/transfer color from underlying Blizzard level text region
		else
			if aloftData.level and aloftData.level > 0 then
				 -- unless text is overidden, it just devolves to the level
				local text = tostring(aloftData.level)

				-- ChatFrame7:AddMessage("AloftLevelText:UpdateText(): 2 " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.level) .. "/" .. tostring(text))
				aLevelTextRegion:SetTextColor(aloftData.levelTextR, aloftData.levelTextG, aloftData.levelTextB)
				aLevelTextRegion:SetText(text)
				aLevelTextRegion:Show()
				-- TODO: sniff/transfer color from underlying Blizzard level text region
			else
				aLevelTextRegion:Hide()
			end
		end
	else
		aLevelTextRegion:Hide()
	end

	aloftData.levelTextRegion:Hide()
end

function AloftLevelText:OnNameplateShow(message, aloftData)
	-- ChatFrame7:AddMessage("AloftLevelText:OnNameplateShow(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.level))
	self:SetupFrame(message, aloftData)
	self:UpdateText(message, aloftData)
end

function AloftLevelText:OnUnitLevel(message, unitid)
	self:UpdateFromUnit(unitid)
end

--[[
function AloftLevelText:DoPlaceFrame(aloftData)
	self:PlaceFrame(aloftData.levelTextRegion, aloftData.layoutFrame, self.db.profile, 0, 0)
	ChatFrame7:AddMessage("DoPlaceFrame:UpdateAll(): place frame " .. tostring(aloftData.name) .. "/" .. tostring(aloftData))
end
]]

-----------------------------------------------------------------------------

function AloftLevelText:UpdateLevelFromTarget()
	self:UpdateFromUnit("target")
end

function AloftLevelText:UpdateFromUnit(unitid)
	if UnitIsPlayer(unitid) then return end

	local level = UnitLevel(unitid)
	-- ChatFrame7:AddMessage("AloftLevelText:UpdateFromUnit(): " .. tostring(UnitName(unitid)) .. "/" .. tostring(level))
	if level == -1 then level = nil end

	self:ScheduleTimer(function(arg) AloftLevelText:UpdateUnitLevel(arg.unitid, arg.level) end, 0.0, { unitid = unitid, level = level }) -- next frame
end

function AloftLevelText:UpdateUnitLevel(unitid, level)
	local aloftData = Aloft:GetUnitNameplate(unitid)
	if aloftData then
		self:AssignValues(aloftData, level)
	end
end

function AloftLevelText:AssignValues(aloftData, level)
	if aloftData.level ~= level then
		local oldLevel = aloftData.level
		aloftData.level = level

		--[[
		if aloftData.isBoss then
			ChatFrame7:AddMessage("AloftLevelText:AssignValues(): " .. tostring(aloftData.name) .. "/" .. tostring(level))
		end
		]]

		self:SendMessage("Aloft:OnUnitLevelChanged", aloftData, oldLevel) -- this recurses (if needed) back into this module and updates the level text
	end
end

-----------------------------------------------------------------------------
