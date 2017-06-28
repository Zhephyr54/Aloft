-----------------------------------------------------------------------------

local Aloft = Aloft
if (not Aloft) then return end

-----------------------------------------------------------------------------

local AloftLevelText = Aloft:NewModule("LevelText", "AceEvent-2.0", "AceHook-2.1")

-----------------------------------------------------------------------------

AloftLevelText.db = Aloft:AcquireDBNamespace("levelText")
Aloft:RegisterDefaults("levelText", "profile", {
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
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftLevelText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		local levelTextRegion = aloftData.levelTextRegion
		if profile.enable then
			local layoutFrame = aloftData.layoutFrame
			if layoutFrame then
				levelTextRegion:SetDrawLayer("OVERLAY")
				self:PrepareText(levelTextRegion, profile)
				self:PlaceFrame(levelTextRegion, layoutFrame, profile, 0, 0)

				if profile.overrideText then
					if not self.textMethodData or not self.textMethod then
						self.textMethodData = Aloft:CreateTag(profile.format, true)
						self.textMethod = self.textMethodData.method
					end
					levelTextRegion:SetText(self.textMethod(aloftData))
					levelTextRegion:Show()
				else
					levelTextRegion:SetText(aloftData.level or -1)
					if aloftData.level then
						levelTextRegion:Show()
					else
						levelTextRegion:Hide()
					end
				end

				return
			end
		end
		levelTextRegion:Hide()
	end
end

function AloftLevelText:RegisterEvents()
	self:UnregisterAllEvents()

	-- self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateLevelFromTarget")

	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:SetAll", function(type, value)
										if profile[type] then
											profile[type] = value
											self:UpdateAll()
										end
									  end)
    
    -- Si cette méthode est appelée avant OnInitialize
    -- permet d'éviter que profile soit non initialisé
    if (profile == nil) then AloftLevelText:OnInitialize() end
    
	if profile.enable then
		if profile.overrideText then
			if not self.textMethodData or not self.textMethodData.events or not self.textMethod then
				self.textMethodData = Aloft:CreateTag(profile.format, true)
				self.textMethod = self.textMethodData.method
			end
			for events in pairs(self.textMethodData.events) do
				--if (Aloft:IsLogEnbl("LevelText", 1)) then Aloft:Log("LevelText", "RegisterEvents", 1, "register " .. tostring(events))
				self:RegisterEvent(events, "UpdateText")
			end
			self:RegisterEvent("Aloft:OnNameplateShow", "PlaceAndUpdateLevelTextOnNameplateShow")
			self:RegisterEvent("Aloft:OnSetHealthBarColor", "UpdateText")
		else
			self:RegisterEvent("Aloft:OnNameplateShow", "PlaceLevelTextOnNameplateShow")
		end
	else
		self:RegisterEvent("Aloft:OnNameplateShow", "HideLevelTextOnNameplateShow")
	end
end

local dataRequiredList = { }
function AloftLevelText:RequiresData()
	self:RegisterEvents()

	if not profile.enable or not profile.overrideText then
		return
	end

	for i = 1,#dataRequiredList do
		dataRequiredList[i] = nil
	end

	if not self.textMethodData or not self.textMethodData.data or not self.textMethod then
		self.textMethodData = Aloft:CreateTag(profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	for data in pairs(self.textMethodData.data) do
		--if (Aloft:IsLogEnbl("LevelText", 1)) then Aloft:Log("LevelText", "RequiresData", 1, "requires " .. tostring(data))
		table.insert(dataRequiredList, data)
	end

	return unpack(dataRequiredList)
end

-----------------------------------------------------------------------------

function AloftLevelText:OnInitialize()
	profile = self.db.profile
end

function AloftLevelText:OnEnable()
	self:UpdateAll()
end

function AloftLevelText:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local nameplateFrame = aloftData.nameplateFrame
		local levelTextRegion = aloftData.levelTextRegion

		levelTextRegion:ClearAllPoints()
		levelTextRegion:SetPoint("CENTER", nameplateFrame, "BOTTOMRIGHT", -13.331, 10.288)
		levelTextRegion:SetFont(NAMEPLATE_FONT, 11)
		levelTextRegion:SetShadowOffset(1, -1)
		levelTextRegion:SetAlpha(1)
		levelTextRegion:SetText(aloftData.level or -1)
	end
	self:UnhookAll()
end

function AloftLevelText:SetupFrame(aloftData)
	local layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	local levelTextRegion = aloftData.levelTextRegion

	levelTextRegion:SetDrawLayer("OVERLAY")
	self:PrepareText(levelTextRegion, profile)
	self:PlaceFrame(levelTextRegion, layoutFrame, profile, 0, 0)

	self:Hook(levelTextRegion, "GetText", "GetLevelTextRegionText", true)
	self:Hook(levelTextRegion, "SetText", "SetLevelTextRegionText", true)
end

function AloftLevelText:GetLevelTextRegionText(this)
	local level = this.aloftData.level
	if level then return level end
	return self.hooks[this].GetText(this)
end

function AloftLevelText:SetLevelTextRegionText(this, text)
	--[[
	local aloftData = this.aloftData
	
	local level = text:match("%d+")
	if level and level ~= tostring(aloftData.level) then
		aloftData.level = tonumber(level)
	end

	if not self.textMethodData or not self.textMethod then
		self.textMethodData = Aloft:CreateTag(profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	]]

	self.hooks[this].SetText( this, text )
end

function AloftLevelText:UpdateText(aloftData)
	--if (Aloft:IsLogEnbl("LevelText", 1)) then Aloft:Log("LevelText", "UpdateText", 1, tostring(aloftData.name) .. "/" ..
	--	("%s:0x%02x%02x%02x"):format(tostring(aloftData.class), floor(aloftData.originalHealthBarR*255), floor(aloftData.originalHealthBarG*255), floor(aloftData.originalHealthBarB*255))) end
	if not self.textMethodData or not self.textMethod then
		self.textMethodData = Aloft:CreateTag(profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	aloftData.levelTextRegion:SetText( self.textMethod(aloftData) )
end

function AloftLevelText:PlaceAndUpdateLevelTextOnNameplateShow(aloftData)
	local levelTextRegion = aloftData.levelTextRegion

	if aloftData.isBoss then
		levelTextRegion:SetTextColor(1, 0, 0)
	end

	levelTextRegion:SetDrawLayer("OVERLAY")
	self:PrepareText(levelTextRegion, profile)
	self:PlaceFrame(levelTextRegion, aloftData.layoutFrame, profile, 0, 0)
	levelTextRegion:Show()

	self:UpdateText(aloftData)
end

function AloftLevelText:PlaceLevelTextOnNameplateShow(aloftData)
	local levelTextRegion = aloftData.levelTextRegion

	levelTextRegion:SetDrawLayer("OVERLAY")
	self:PrepareText(levelTextRegion, profile)
	self:PlaceFrame(levelTextRegion, aloftData.layoutFrame, profile, 0, 0)
end

function AloftLevelText:HideLevelTextOnNameplateShow(aloftData)
	aloftData.levelTextRegion:Hide()
end

-----------------------------------------------------------------------------

function AloftLevelText:UpdateLevelFromTarget()
	self:UpdateFromUnit("target")
end

function AloftLevelText:UpdateFromUnit(unitid)
	if UnitIsPlayer(unitid) then return end

	local level = UnitLevel(unitid)
	if level == -1 then level = nil end

	local eventName = "AloftLevelText:UpdateUnitLevel:" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.UpdateUnitLevel, 0.0, self, level) -- next frame
end

function AloftLevelText:UpdateUnitLevel(level)
	local aloftData = Aloft:GetTargetNameplate()
	if (aloftData) then
		self:AssignValues(aloftData, level)
	end
end

function AloftLevelText:AssignValues(aloftData, level)
	if aloftData.level ~= level then
		local oldLevel = aloftData.level
		aloftData.level = level
		self:TriggerEvent("Aloft:OnUnitLevelChanged", aloftData, oldLevel)
	end
end

-----------------------------------------------------------------------------
