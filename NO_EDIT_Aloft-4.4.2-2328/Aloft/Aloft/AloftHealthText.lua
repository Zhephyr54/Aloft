local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftHealthText", function()

-----------------------------------------------------------------------------

local AloftHealthText = Aloft:NewModule("HealthText", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftHealthText.dynamic = "AloftHealthText"

-----------------------------------------------------------------------------

AloftHealthText.namespace = "healthText"
AloftHealthText.defaults =
{
	profile =
	{
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
	},
}

-----------------------------------------------------------------------------

function AloftHealthText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if self.db.profile.enable then
			local layoutFrame = aloftData.layoutFrame
			if layoutFrame then
				local healthTextRegion = layoutFrame.healthTextRegion				
				if healthTextRegion then
					self:PrepareText(healthTextRegion, self.db.profile)
					self:PlaceFrame(healthTextRegion, layoutFrame, self.db.profile, 0, 0)
				end
				if aloftData:IsShown() then
					self:UpdateText("AloftHealthText:UpdateAll", aloftData)
				end
			end
		else
			self:OnNameplateHide("AloftHealthText:UpdateAll", aloftData)
		end
	end
	for layoutFrame in pairs(Aloft.layoutFramePool) do
		local healthTextRegion = layoutFrame.healthTextRegion
		if healthTextRegion then
			self:PrepareText(healthTextRegion, self.db.profile)
			self:PlaceFrame(healthTextRegion, layoutFrame, self.db.profile, 0, 0)
		end
	end
end

-----------------------------------------------------------------------------

function AloftHealthText:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile and self.db.profile.enable then
		self:RegisterMessage("Aloft:OnIsTargetDataChanged", "UpdateText")
		self:RegisterMessage("Aloft:OnSetHealthBarColor", "UpdateText")
		self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")

		self:RegisterMessage("Aloft:SetAll", function(message, type, value)
			if AloftHealthText.db.profile[type] then
				AloftHealthText.db.profile[type] = value
				AloftHealthText:UpdateAll()
			end
		end)

		if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethodData.events) then
			self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		if self.textMethodData and self.textMethodData.events then
			for events in pairs(self.textMethodData.events) do
				self:RegisterMessage(events, "UpdateText")
			end
		end
	end
end

local dataRequiredList = { }
function AloftHealthText:RequiresData()
	-- ChatFrame7:AddMessage("AloftHealthText:RequiresData(): profile " .. tostring(self.db.profile))
	-- ChatFrame7:AddMessage("AloftHealthText:RequiresData(): profile.format " .. tostring(self.db.profile.format))

	self:RegisterEvents()

	if self.db.profile and self.db.profile.enable then
		for i=1,#dataRequiredList do
			dataRequiredList[i] = nil
		end

		if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethodData.data) then
			self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		if self.textMethodData and self.textMethodData.data then
			for data in pairs(self.textMethodData.data) do
				table.insert(dataRequiredList, data)
			end
		end

		return unpack(dataRequiredList)
	end
end

-----------------------------------------------------------------------------

function AloftHealthText:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftHealthText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UpdateAll()
end

function AloftHealthText:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

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

function AloftHealthText:UpdateText(message, aloftData)
	-- ChatFrame7:AddMessage("AloftHealthText:UpdateText(): invoke text method")
	if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethod) then
		self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	-- ChatFrame7:AddMessage("AloftHealthText:UpdateText(): " .. tostring(message) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(self.textMethodData.functionString))
	local text = self.textMethod and self.textMethod(aloftData)
	-- ChatFrame7:AddMessage("AloftHealthText:UpdateText(): " .. tostring(aloftData.name) .. "/" .. tostring(text))

	if text and text ~= "" then
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

			self:PlaceFrame(healthTextRegion, layoutFrame, self.db.profile, 0, 0)
		end

		self:PrepareText(healthTextRegion, self.db.profile)

		-- ChatFrame7:AddMessage("AloftHealthText:UpdateText(): " .. tostring(aloftData.name) .. "/" .. tostring(self.db.profile.offsetX) .. "/" .. tostring(self.db.profile.offsetY) .. "/" .. tostring(hinset) .. "/" .. tostring(vinset))
		healthTextRegion:SetText(text)
		healthTextRegion:Show()

		return
	end
	self:OnNameplateHide(message, aloftData)
end

-----------------------------------------------------------------------------

function AloftHealthText:OnNameplateShow(message, aloftData)
	self:UpdateText(message, aloftData)
end

function AloftHealthText:OnNameplateHide(message, aloftData)
	local layoutFrame = aloftData.layoutFrame
	local healthTextRegion = layoutFrame and layoutFrame.healthTextRegion
	if healthTextRegion then
		healthTextRegion:Hide()
		healthTextRegion:SetText("")
	end
end

-----------------------------------------------------------------------------

end)
