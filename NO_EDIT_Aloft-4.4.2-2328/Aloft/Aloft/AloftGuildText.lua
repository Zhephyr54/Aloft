local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

local AloftGuildText = Aloft:NewModule("GuildText", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftGuildText.dynamic = "AloftGuild"

-----------------------------------------------------------------------------

AloftGuildText.namespace = "guildText"
AloftGuildText.defaults =
{
	profile =
	{
		enable			= false,
		useShort		= true,
		showOwn			= true,
		attachToName	= true,
		attachFormat	= "HYPHEN",
		alpha			= 1,
		point			= "BOTTOMLEFT",
		relativeToPoint	= "TOPLEFT",
		offsetX			= 0,
		offsetY			= 0,
		font			= "Arial Narrow",
		fontSize		= 9,
		shadow			= false,
		outline			= "OUTLINE",
		format			= "[guild]",
		color			= { 1, 1, 1 },
	},
}

-----------------------------------------------------------------------------

function AloftGuildText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if self.db.profile and self.db.profile.enable then
			if self.db.profile.attachToName then
				self:OnNameplateHide("AloftGuildText:UpdateAll", aloftData)
			else
				local layoutFrame = aloftData.layoutFrame
				if layoutFrame then
					local guildTextRegion = layoutFrame.guildTextRegion				
					if guildTextRegion then
						self:PrepareText(guildTextRegion, self.db.profile)
						self:PlaceFrame(guildTextRegion, layoutFrame, self.db.profile)
					end
					if aloftData:IsShown() then
						self:UpdateText("AloftGuildText:UpdateAll", aloftData)
					end
				end
			end
		else
			self:OnNameplateHide("AloftGuildText:UpdateAll", aloftData)
		end
	end
	for layoutFrame in pairs(Aloft.layoutFramePool) do
		local guildTextRegion = layoutFrame.guildTextRegion
		if guildTextRegion then
			self:PrepareText(guildTextRegion, self.db.profile)
			self:PlaceFrame(guildTextRegion, layoutFrame, self.db.profile)
		end
	end
end

-----------------------------------------------------------------------------

function AloftGuildText:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile and self.db.profile.enable then
		self:RegisterMessage("Aloft:SetAll",	function(message, type, value)
													if AloftGuildText.db.profile[type] then
														AloftGuildText.db.profile[type] = value
														AloftGuildText:UpdateAll()
													end
												end)

		if not self.db.profile.attachToName then
			self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
			self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
			self:RegisterMessage("Aloft:OnSetHealthBarColor", "UpdateText")

			if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethodData.events) then
				self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
				self.textMethod = self.textMethodData.method
			end
			if self.textMethodData and self.textMethodData.events then
				for events in pairs(self.textMethodData.events) do
					-- ChatFrame7:AddMessage("AloftGuildText:RegisterEvents(): register event " .. tostring(events))
					self:RegisterMessage(events, "UpdateText")
				end
			end
		end
	end
end

local dataRequiredList = { }
function AloftGuildText:RequiresData()
	-- ChatFrame7:AddMessage("AloftGuildText:RequiresData(): enter")

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
				-- ChatFrame7:AddMessage("AloftGuildText:RequiresData(): requires data " .. tostring(data))
				table.insert(dataRequiredList, data)
			end
		end

		-- ChatFrame7:AddMessage("AloftGuildText:RequiresData(): exit")
		return unpack(dataRequiredList)
	end
end

-----------------------------------------------------------------------------

function AloftGuildText:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftGuildText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftGuildText:OnEnable(): invoke")
	self:UpdateAll()
end

function AloftGuildText:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateNameplates() do
		local layoutFrame = aloftData.layoutFrame
		local guildTextRegion = layoutFrame and layoutFrame.guildTextRegion
		if guildTextRegion then
			guildTextRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftGuildText:UpdateText(message, aloftData)
	-- ChatFrame7:AddMessage("AloftGuildText:UpdateText(): enter " .. tostring(aloftData.name))
	if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethod) then
		self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	local text = self.textMethod and self.textMethod(aloftData)
	-- ChatFrame7:AddMessage("AloftGuildText:UpdateText(): text " .. tostring(self.db.profile.format) .. "/" .. tostring(self.textMethod) .. "/" .. tostring(aloftData.comment) .. "/" .. tostring(text))

	if text and text ~= "" then
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		local guildTextRegion = layoutFrame.guildTextRegion

		-- Check if this nameplate already has a text region assigned to it
		if not guildTextRegion then
			guildTextRegion = aloftData:CreateFontString()

			layoutFrame.guildTextRegion = guildTextRegion

			self:PlaceFrame(guildTextRegion, layoutFrame, self.db.profile)
		end

		self:PrepareText(guildTextRegion, self.db.profile)

		guildTextRegion:SetText(text)
		guildTextRegion:Show()

		-- ChatFrame7:AddMessage("AloftGuildText:UpdateText(): show " .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(layoutFrame.guildTextRegion:GetText()))
		return
	end
	self:OnNameplateHide(message, aloftData)
end

-----------------------------------------------------------------------------

function AloftGuildText:OnNameplateShow(message, aloftData)
	self:UpdateText(message, aloftData)
end

function AloftGuildText:OnNameplateHide(message, aloftData)
	local layoutFrame = aloftData.layoutFrame
	local guildTextRegion = layoutFrame and layoutFrame.guildTextRegion
	if guildTextRegion then
		guildTextRegion:Hide()
		guildTextRegion:SetText("")
	end
end

-----------------------------------------------------------------------------

end)
