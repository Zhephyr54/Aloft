local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

local AloftCommentText = Aloft:NewModule("CommentText", "AceEvent-2.0")
AloftCommentText.dynamic = "AloftComment"

-----------------------------------------------------------------------------

AloftCommentText.db = Aloft:AcquireDBNamespace("commentText")
Aloft:RegisterDefaults("commentText", "profile", {
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
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftCommentText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if profile and profile.enable then
			local layoutFrame = aloftData.layoutFrame
			if layoutFrame then
				local commentTextRegion = layoutFrame.commentTextRegion
				if commentTextRegion then
					self:PrepareText(commentTextRegion, profile)
					self:PlaceFrame(commentTextRegion, layoutFrame, profile)
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
		local commentTextRegion = layoutFrame.commentTextRegion
		if commentTextRegion then
			self:PrepareText(commentTextRegion, profile)
			self:PlaceFrame(commentTextRegion, layoutFrame, profile)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCommentText:UpdateTag()
	if profile.enable then
		profile.format = "[comment]"
	else
		profile.format = ""
	end

	Aloft:DetermineDataSources()
end

-----------------------------------------------------------------------------

function AloftCommentText:RegisterEvents()
	self:UnregisterAllEvents()

	if profile and profile.enable then
		self:RegisterEvent("Aloft:SetAll", function(type, value)
			if profile[type] then
				profile[type] = value
				self:UpdateAll()
			end
		end)

		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterEvent("Aloft:OnSetHealthBarColor", "UpdateText")

		if not self.textMethodData or not self.textMethodData.events then
			self.textMethodData = Aloft:CreateTag(profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		for events in pairs(self.textMethodData.events) do
			-- ChatFrame7:AddMessage("AloftCommentText:RegisterEvents(): register " .. tostring(events))
			self:RegisterEvent(events, "UpdateText")
		end
	end
end

local dataRequiredList = { }
function AloftCommentText:RequiresData()
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
			-- ChatFrame7:AddMessage("AloftCommentText:RequiresData(): requires " .. tostring(data))
			table.insert(dataRequiredList, data)
		end

		return unpack(dataRequiredList)
	end
end

-----------------------------------------------------------------------------

function AloftCommentText:OnInitialize()
	profile = self.db.profile
end

function AloftCommentText:OnEnable()
	self:UpdateAll()
end

function AloftCommentText:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local layoutFrame = aloftData.layoutFrame
		local commentTextRegion = layoutFrame and layoutFrame.commentTextRegion
		if commentTextRegion then
			commentTextRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftCommentText:UpdateText(aloftData)
	-- ChatFrame7:AddMessage("AloftCommentText:UpdateText(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
	if not self.textMethodData or not self.textMethod then
		self.textMethodData = Aloft:CreateTag(profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	local text = self.textMethod(aloftData)
	-- ChatFrame7:AddMessage("AloftCommentText:UpdateText(): " .. tostring(aloftData.name) .. "/" .. tostring(text))

	if text ~= "" then
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		local commentTextRegion = layoutFrame.commentTextRegion

		-- Check if this nameplate already has a text region assigned to it
		if not commentTextRegion then
			commentTextRegion = aloftData:CreateFontString()

			layoutFrame.commentTextRegion = commentTextRegion

			self:PrepareText(commentTextRegion, profile)
			self:PlaceFrame(commentTextRegion, layoutFrame, profile)
		end
		-- ChatFrame7:AddMessage("AloftCommentText:UpdateText(): assemble " .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(layoutFrame.commentTextRegion:GetText()) .. "/" .. tostring(layoutFrame) .. "/" .. tostring(layoutFrame.commentTextRegion:GetParent()))

		commentTextRegion:SetText(text)
		commentTextRegion:Show()

		-- ChatFrame7:AddMessage("AloftCommentText:UpdateText(): show " .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. layoutFrame.commentTextRegion:GetText())
		return
	end
	-- ChatFrame7:AddMessage("AloftCommentText:UpdateText(): hide " .. tostring(aloftData.name) .. "/" .. tostring(text))
	self:OnNameplateHide(aloftData)
end

-----------------------------------------------------------------------------

function AloftCommentText:OnNameplateShow(aloftData)
	self:UpdateText(aloftData)
	--[[
	local eventName = "AloftCommentText:OnNameplateShow:" .. ":" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.UpdateText, 0.0, self, aloftData) -- next frame
	]]
end

function AloftCommentText:OnNameplateHide(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local commentTextRegion = layoutFrame and layoutFrame.commentTextRegion
	if commentTextRegion then
		commentTextRegion:Hide()
		commentTextRegion:SetText("")
	end
end

-----------------------------------------------------------------------------

end)
