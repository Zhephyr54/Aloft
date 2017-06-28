local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

local AloftCommentText = Aloft:NewModule("CommentText", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftCommentText.dynamic = "AloftComment"

-----------------------------------------------------------------------------

AloftCommentText.namespace = "commentText"
AloftCommentText.defaults =
{
	profile =
	{
		enable			= false,
		alpha			= 1,
		point			= "CENTER",
		relativeToPoint	= "CENTER",
		offsetX			= 0,
		offsetY			= -10,
		font			= "Arial Narrow",
		fontSize		= 9,
		shadow			= false,
		outline			= "OUTLINE",
		format			= "[comment]",
		color			= { 1, 1, 1 }
	},
}

-----------------------------------------------------------------------------

function AloftCommentText:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if self.db.profile and self.db.profile.enable then
			local layoutFrame = aloftData.layoutFrame
			if layoutFrame then
				local commentTextRegion = layoutFrame.commentTextRegion
				if commentTextRegion then
					self:PrepareText(commentTextRegion, self.db.profile)
					self:PlaceFrame(commentTextRegion, layoutFrame, self.db.profile)
				end
				if aloftData:IsShown() then
					self:UpdateText("AloftCommentText:UpdateAll", aloftData)
				end
			end
		else
			self:OnNameplateHide("AloftCommentText:UpdateAll", aloftData)
		end
	end
	for layoutFrame in pairs(Aloft.layoutFramePool) do
		local commentTextRegion = layoutFrame.commentTextRegion
		if commentTextRegion then
			self:PrepareText(commentTextRegion, self.db.profile)
			self:PlaceFrame(commentTextRegion, layoutFrame, self.db.profile)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCommentText:UpdateTag()
	if self.db.profile.enable then
		self.db.profile.format = "[comment]"
	else
		self.db.profile.format = ""
	end

	Aloft:DetermineDataSources()
end

-----------------------------------------------------------------------------

function AloftCommentText:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	-- ChatFrame7:AddMessage("AloftCommentText:RegisterEvents(): enter")

	if self.db.profile and self.db.profile.enable then
		self:RegisterMessage("Aloft:SetAll", function(message, type, value)
			if AloftCommentText.db.profile[type] then
				AloftCommentText.db.profile[type] = value
				AloftCommentText:UpdateAll()
			end
		end)

		self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("Aloft:OnSetHealthBarColor", "UpdateText")

		if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethodData.events) then
			self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		if self.textMethodData and self.textMethodData.events then
			for events in pairs(self.textMethodData.events) do
				-- ChatFrame7:AddMessage("AloftCommentText:RegisterEvents(): register " .. tostring(events))
				self:RegisterMessage(events, "UpdateText")
			end
		end
	end
end

local dataRequiredList = { }
function AloftCommentText:RequiresData()
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
				-- ChatFrame7:AddMessage("AloftCommentText:RequiresData(): requires " .. tostring(data))
				table.insert(dataRequiredList, data)
			end
		end

		return unpack(dataRequiredList)
	end
end

-----------------------------------------------------------------------------

function AloftCommentText:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftCommentText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:UpdateAll()
end

function AloftCommentText:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		local layoutFrame = aloftData.layoutFrame
		local commentTextRegion = layoutFrame and layoutFrame.commentTextRegion
		if commentTextRegion then
			commentTextRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftCommentText:UpdateText(message, aloftData)
	-- ChatFrame7:AddMessage("AloftCommentText:UpdateText(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
	if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethod) then
		self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	-- ChatFrame7:AddMessage("AloftCommentText:UpdateText(): " .. tostring(message) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(self.textMethodData.functionString))
	local text = self.textMethod and self.textMethod(aloftData)
	-- ChatFrame7:AddMessage("AloftCommentText:UpdateText(): " .. tostring(aloftData.name) .. "/" .. tostring(text))

	if text and text ~= "" then
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		local commentTextRegion = layoutFrame.commentTextRegion

		-- Check if this nameplate already has a text region assigned to it
		if not commentTextRegion then
			commentTextRegion = aloftData:CreateFontString()

			layoutFrame.commentTextRegion = commentTextRegion

			self:PlaceFrame(commentTextRegion, layoutFrame, self.db.profile)
		end
		-- ChatFrame7:AddMessage("AloftCommentText:UpdateText(): assemble " .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(layoutFrame.commentTextRegion:GetText()) .. "/" .. tostring(layoutFrame) .. "/" .. tostring(layoutFrame.commentTextRegion:GetParent()))

		self:PrepareText(commentTextRegion, self.db.profile)

		commentTextRegion:SetText(text)
		commentTextRegion:Show()

		-- ChatFrame7:AddMessage("AloftCommentText:UpdateText(): show " .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. layoutFrame.commentTextRegion:GetText())
		return
	end
	-- ChatFrame7:AddMessage("AloftCommentText:UpdateText(): hide " .. tostring(aloftData.name) .. "/" .. tostring(text))
	self:OnNameplateHide(message, aloftData)
end

-----------------------------------------------------------------------------

function AloftCommentText:OnNameplateShow(message, aloftData)
	self:UpdateText(message, aloftData)
	--[[
	self:ScheduleTimer(function(aloftData) AloftCommentText:UpdateText("AloftCommentText:OnNameplateShow", aloftData) end, 0.0, aloftData) -- next frame
	]]
end

function AloftCommentText:OnNameplateHide(message, aloftData)
	local layoutFrame = aloftData.layoutFrame
	local commentTextRegion = layoutFrame and layoutFrame.commentTextRegion
	if commentTextRegion then
		commentTextRegion:Hide()
		commentTextRegion:SetText("")
	end
end

-----------------------------------------------------------------------------

end)
