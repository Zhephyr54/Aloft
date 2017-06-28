local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

local AloftGuildText = Aloft:NewModule("GuildText", "AceEvent-2.0")
AloftGuildText.dynamic = "AloftGuild"

-----------------------------------------------------------------------------

AloftGuildText.db = Aloft:AcquireDBNamespace("guildText")
Aloft:RegisterDefaults("guildText", "profile", {
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
	color			= { 1, 1, 1 }
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftGuildText:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		if profile and profile.enable then
			if profile.attachToName then
				self:OnNameplateHide(aloftData)
			else
				local layoutFrame = aloftData.layoutFrame
				if layoutFrame then
					local guildTextRegion = layoutFrame.guildTextRegion				
					if guildTextRegion then
						self:PrepareText(guildTextRegion, profile)
						self:PlaceFrame(guildTextRegion, layoutFrame, profile)
					end
					if aloftData:IsShown() then
						self:UpdateText(aloftData)
					end
				end
			end
		else
			self:OnNameplateHide(aloftData)
		end
	end
	for layoutFrame in pairs(Aloft.layoutFramePool) do
		local guildTextRegion = layoutFrame.guildTextRegion
		if guildTextRegion then
			self:PrepareText(guildTextRegion, profile)
			self:PlaceFrame(guildTextRegion, layoutFrame, profile)
		end
	end
end

-----------------------------------------------------------------------------

function AloftGuildText:RegisterEvents()
	self:UnregisterAllEvents()

	if profile and profile.enable then
		self:RegisterEvent("Aloft:SetAll", function(type, value)
											if profile[type] then
												profile[type] = value
												self:UpdateAll()
											end
										   end)

									   if not profile.attachToName then
			self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
			self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
			self:RegisterEvent("Aloft:OnSetHealthBarColor", "UpdateText")

			if not self.textMethodData or not self.textMethodData.events then
				self.textMethodData = Aloft:CreateTag(profile.format, true)
				self.textMethod = self.textMethodData.method
			end
			for events in pairs(self.textMethodData.events) do
				-- ChatFrame7:AddMessage("AloftGuildText:RegisterEvents(): register event " .. tostring(events))
				self:RegisterEvent(events, "UpdateText")
			end
		end
	end
end

local dataRequiredList = { }
function AloftGuildText:RequiresData()
	-- ChatFrame7:AddMessage("AloftGuildText:RequiresData(): enter")

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
			-- ChatFrame7:AddMessage("AloftGuildText:RequiresData(): requires data " .. tostring(data))
			table.insert(dataRequiredList, data)
		end

		-- ChatFrame7:AddMessage("AloftGuildText:RequiresData(): exit")
		return unpack(dataRequiredList)
	end
end

-----------------------------------------------------------------------------

function AloftGuildText:OnInitialize()
	profile = self.db.profile
end

function AloftGuildText:OnEnable()
	Aloft:DebugRegister("GuildText")
	-- ChatFrame7:AddMessage("AloftGuildText:OnEnable(): invoke")
	self:UpdateAll()
end

function AloftGuildText:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local layoutFrame = aloftData.layoutFrame
		local guildTextRegion = layoutFrame and layoutFrame.guildTextRegion
		if guildTextRegion then
			guildTextRegion:Hide()
		end
	end
end

-----------------------------------------------------------------------------

function AloftGuildText:UpdateText(aloftData)
	if not self.textMethodData or not self.textMethod then
		self.textMethodData = Aloft:CreateTag(profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	local text = self.textMethod(aloftData)

	if text ~= "" then
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		local guildTextRegion = layoutFrame.guildTextRegion

		-- Check if this nameplate already has a text region assigned to it
		if not guildTextRegion then
			guildTextRegion = aloftData:CreateFontString()

			layoutFrame.guildTextRegion = guildTextRegion

			self:PrepareText(guildTextRegion, profile)
			self:PlaceFrame(guildTextRegion, layoutFrame, profile)
		end

		guildTextRegion:SetText(text)
		guildTextRegion:Show()
		-- ChatFrame7:AddMessage("AloftCombatText:PostCombatText(): show " .. tostring(aloftData.name) .. "/" .. tostring(text) .. "/" .. tostring(layoutFrame.guildTextRegion:GetText()))
		return
	end
	self:OnNameplateHide(aloftData)
end

-----------------------------------------------------------------------------

function AloftGuildText:OnNameplateShow(aloftData)
	self:UpdateText(aloftData)
end

function AloftGuildText:OnNameplateHide(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local guildTextRegion = layoutFrame and layoutFrame.guildTextRegion
	if guildTextRegion then
		guildTextRegion:Hide()
		guildTextRegion:SetText("")
	end
end

-----------------------------------------------------------------------------

end)
