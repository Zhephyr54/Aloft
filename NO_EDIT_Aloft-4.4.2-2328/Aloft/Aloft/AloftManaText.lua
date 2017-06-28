local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

local AloftManaText = Aloft:NewModule("ManaText", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftManaText.dynamic = "AloftMana"

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftManaText.namespace = "manaText"
AloftManaText.defaults =
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
		color			= { 1, 1, 1 },
		--always			= true,
	},
}

-----------------------------------------------------------------------------

function AloftManaText:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if self.db.profile.enable then
			local layoutFrame = aloftData.layoutFrame
			if layoutFrame then
				local manaTextRegion = layoutFrame.manaTextRegion
				if manaTextRegion then
					self:PrepareText(manaTextRegion, self.db.profile)
					self:PlaceFrame(manaTextRegion, layoutFrame, self.db.profile)
				end
				if aloftData:IsShown() then
					self:UpdateText("AloftManaText:UpdateAll", aloftData)
				end
			end
		else
			self:OnNameplateHide("AloftManaText:UpdateAll", aloftData)
		end
	end
	for layoutFrame in pairs(Aloft.layoutFramePool) do
		local manaTextRegion = layoutFrame.manaTextRegion
		if manaTextRegion then
			self:PrepareText(manaTextRegion, self.db.profile)
			self:PlaceFrame(manaTextRegion, layoutFrame, self.db.profile, 0, 0)
		end
	end
end

-----------------------------------------------------------------------------

function AloftManaText:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile and self.db.profile.enable then
		self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("Aloft:OnSetHealthBarColor", "UpdateText")

		self:RegisterMessage("Aloft:SetAll", function(message, type, value)
			if AloftManaText.db.profile[type] then
				AloftManaText.db.profile[type] = value
				AloftManaText:UpdateAll()
			end
		end)

		if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethod or not self.textMethodData or not self.textMethodData.events) then
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
function AloftManaText:RequiresData()
	self:RegisterEvents()

	if self.db.profile and self.db.profile.enable then
		for i=1,#dataRequiredList do
			dataRequiredList[i] = nil
		end

		if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethod or not self.textMethodData or not self.textMethodData.events) then
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

function AloftManaText:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftManaText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftManaText:OnEnable(): enter")

	self:UpdateAll()
end

function AloftManaText:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateHide("AloftManaText:OnDisable", aloftData)
	end
	-- TODO: nil out Aloft.Options
end

-----------------------------------------------------------------------------

function AloftManaText:UpdateText(message, aloftData)
	-- ChatFrame7:AddMessage("AloftManaText:UpdateText(): invoke text method")
	if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethod) then
		self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	local text = self.textMethod and self.textMethod(aloftData)
	-- ChatFrame7:AddMessage("AloftManaText:UpdateText(): text " .. tostring(text))

	if text and text ~= "" then
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		local manaTextRegion = layoutFrame.manaTextRegion

		-- Check if this nameplate already has a text region assigned to it
		if not manaTextRegion then
			manaTextRegion = aloftData:CreateFontString()

			layoutFrame.manaTextRegion = manaTextRegion

			self:PlaceFrame(manaTextRegion, layoutFrame, self.db.profile, 0, 0)
		end

		self:PrepareText(manaTextRegion, self.db.profile)

		-- ChatFrame7:AddMessage("AloftManaText:UpdateText(): " .. tostring(aloftData.name)
		-- 	.. "/" .. tostring(text)
		-- 	.. "/" .. tostring(self.textMethodData.functionString))

		manaTextRegion:SetText(text)
		manaTextRegion:Show()

		return
	end
	self:OnNameplateHide(message, aloftData)
end

-----------------------------------------------------------------------------

function AloftManaText:OnNameplateShow(message, aloftData)
	self:UpdateText(message, aloftData)
end

function AloftManaText:OnNameplateHide(message, aloftData)
	local layoutFrame = aloftData.layoutFrame
	local manaTextRegion = layoutFrame and layoutFrame.manaTextRegion
	if manaTextRegion then
		manaTextRegion:Hide()
		manaTextRegion:SetText("")
	end
end

-----------------------------------------------------------------------------

end)
