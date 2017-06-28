local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("HealthData") then return end

local AloftHealthText = Aloft:NewModule("HealthText", "AceEvent-2.0")
AloftHealthText.dynamic = "AloftHealthText"

-----------------------------------------------------------------------------

AloftHealthText.db = Aloft:AcquireDBNamespace("healthText")
Aloft:RegisterDefaults("healthText", "profile", {
	enable			= false,
	alpha			= 1,
	point			= "RIGHT",
	relativeToPoint	= "RIGHT",
	offsetX			= 0,
	offsetY			= 0,
	font			= "Arial Narrow",
	fontSize		= 9,
	shadow			= false,
	outline			= "OUTLINE",
	mode			= "PERCENT",
	format			= "",
	color			= { 1, 1, 1 }
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftHealthText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if profile.enable then
			local layoutFrame = aloftData.layoutFrame
			if layoutFrame then
				local healthTextRegion = layoutFrame.healthTextRegion				
				if healthTextRegion then
					self:PrepareText(healthTextRegion, profile)
					self:PlaceFrame(healthTextRegion, layoutFrame, profile, 0, 0)
				end
				if aloftData:IsShown() then
					self:UpdateText(aloftData)
				end
			end
		else
			self:OnNameplateHide(aloftData)
		end
	end
	for layoutFrame in pairs(Aloft.layoutFramePool) do
		local healthTextRegion = layoutFrame.healthTextRegion
		if healthTextRegion then
			self:PrepareText(healthTextRegion, profile)
			self:PlaceFrame(healthTextRegion, layoutFrame, profile, 0, 0)
		end
	end
end

-----------------------------------------------------------------------------

function AloftHealthText:RegisterEvents()
	self:UnregisterAllEvents()

	if profile and profile.enable then
		self:RegisterEvent("Aloft:OnIsTargetDataChanged", "UpdateText")
		self:RegisterEvent("Aloft:OnSetHealthBarColor", "UpdateText")
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")

		self:RegisterEvent("Aloft:SetAll", function(type, value)
			if profile[type] then
				profile[type] = value
				self:UpdateAll()
			end
		end)

		if not self.textMethodData or not self.textMethodData.events then
			self.textMethodData = Aloft:CreateTag(profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		for events in pairs(self.textMethodData.events) do
			self:RegisterEvent(events, "UpdateText")
		end
	end
end

local dataRequiredList = { }
function AloftHealthText:RequiresData()
	-- ChatFrame7:AddMessage("AloftHealthText:RequiresData(): profile " .. tostring(profile))
	-- ChatFrame7:AddMessage("AloftHealthText:RequiresData(): profile.format " .. tostring(profile.format))

	self:RegisterEvents()

	if profile and profile.enable then
		for i=1,#dataRequiredList do
			dataRequiredList[i] = nil
		end

		if not self.textMethodData or not self.textMethodData.data then
			self.textMethodData = Aloft:CreateTag(profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		for data in pairs(self.textMethodData.data) do
			table.insert(dataRequiredList, data)
		end

		return unpack(dataRequiredList)
	end
end

-----------------------------------------------------------------------------

function AloftHealthText:OnInitialize()
	profile = self.db.profile
end

function AloftHealthText:OnEnable()
	Aloft:DebugRegister("HealthText")
	self:UpdateAll()
end

function AloftHealthText:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local layoutFrame = aloftData.layoutFrame
		if layoutFrame then
			local healthTextRegion = layoutFrame and layoutFrame.healthTextRegion
			if healthTextRegion then
				healthTextRegion:Hide()
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftHealthText:UpdateText(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthText:UpdateText(): invoke text method")
	if not self.textMethodData or not self.textMethod then
		self.textMethodData = Aloft:CreateTag(profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	local text = self.textMethod(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthText:UpdateText(): text " .. tostring(text))

	if text ~= "" then
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		local healthTextRegion = layoutFrame.healthTextRegion

		-- Check if this nameplate already has a text region assigned to it
		if not healthTextRegion then
			healthTextRegion = aloftData:CreateFontString()
			healthTextRegion:SetParent(layoutFrame)

			layoutFrame.healthTextRegion = healthTextRegion

			self:PrepareText(healthTextRegion, profile)
			self:PlaceFrame(healthTextRegion, layoutFrame, profile, 0, 0)
		end

		-- ChatFrame7:AddMessage("AloftHealthText:UpdateText(): " .. tostring(aloftData.name) .. "/" .. tostring(profile.offsetX) .. "/" .. tostring(profile.offsetY) .. "/" .. tostring(hinset) .. "/" .. tostring(vinset))
		healthTextRegion:SetText(text)
		healthTextRegion:Show()
		return
	end
	self:OnNameplateHide(aloftData)
end

-----------------------------------------------------------------------------

function AloftHealthText:OnNameplateShow(aloftData)
	self:UpdateText(aloftData)
end

function AloftHealthText:OnNameplateHide(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local healthTextRegion = layoutFrame and layoutFrame.healthTextRegion
	if healthTextRegion then
		healthTextRegion:Hide()
		healthTextRegion:SetText("")
	end
end

-----------------------------------------------------------------------------

end)
