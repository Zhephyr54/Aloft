local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

local AloftThreatData = Aloft:GetModule("ThreatData", true)
if not AloftThreatData then return end

local AloftThreatText = Aloft:NewModule("ThreatText", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftThreatText.dynamic = "AloftThreat"

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftThreatText.namespace = "threatText"
AloftThreatText.defaults =
{
	profile =
	{
		enable			= false,
		activeWhileSolo	= true,
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
	},
}

-----------------------------------------------------------------------------

function AloftThreatText:IsGrouped()
	return (GetNumPartyMembers() + GetNumRaidMembers()) > 0
end

-- NOTE: need to name this something other than "IsEnabled()", since Ace3 uses that
function AloftThreatText:IsActive()
	return self:IsEnabled() and self.db and self.db.profile and self.db.profile.enable and (self:IsGrouped() or self.db.profile.activeWhileSolo)
end

-----------------------------------------------------------------------------

function AloftThreatText:UpdateAll()
	-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): enter")

	-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): iterate nameplates")
	for aloftData in Aloft:IterateVisibleNameplates() do
		-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): process nameplate")
		if self:IsActive() then
			local layoutFrame = aloftData.layoutFrame
			if layoutFrame then
				-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): self.db.profile enabled, process threat text region")
				local threatTextRegion = layoutFrame.threatTextRegion
				if threatTextRegion then
					-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): prepare/place text")
					self:PrepareText(threatTextRegion, self.db.profile)
					self:PlaceFrame(threatTextRegion, layoutFrame, self.db.profile)
				end
				-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): check IsShown")
				if aloftData:IsShown() then
					-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): update text")
					self:UpdateText("AloftThreatText:UpdateAll", aloftData)
				end
				-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): process threat text region complete")
			end
		else
			-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): self.db.profile disabled, hide text")
			self:OnNameplateHide("AloftThreatText:UpdateAll", aloftData)
		end
		-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): process nameplate complete")
	end
	-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): iterate nameplates complete")

	-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): iterate text region pool")
	for layoutFrame in pairs(Aloft.layoutFramePool) do
		local threatTextRegion = layoutFrame.threatTextRegion
		if threatTextRegion then
			-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): prepare text")
			self:PrepareText(threatTextRegion, self.db.profile)
			self:PlaceFrame(threatTextRegion, layoutFrame, self.db.profile)
			-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): prepare text complete")
		end
	end
	-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): iterate region pool complete")

	-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): exit")
end

-----------------------------------------------------------------------------

function AloftThreatText:RegisterEvents()
	-- ChatFrame7:AddMessage("AloftThreatText:RegisterEvents(): enter")

	-- ChatFrame7:AddMessage("AloftThreatText:RegisterEvents(): unregister events")
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self:IsActive() then
		-- ChatFrame7:AddMessage("AloftThreatText:RegisterEvents(): register SetAll")
		self:RegisterMessage("Aloft:SetAll", function(message, type, value)
			if AloftThreatText.db.profile[type] then
				-- ChatFrame7:AddMessage("AloftThreatText:RegisterEvents(): update")
				AloftThreatText.db.profile[type] = value
				AloftThreatText:UpdateAll()
			end
		end)

		-- ChatFrame7:AddMessage("AloftThreatText:RegisterEvents(): self.db.profile enabled, register atomic events")
		self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("Aloft:OnSetHealthBarColor", "UpdateText")

		-- ChatFrame7:AddMessage("AloftThreatText:RegisterEvents(): register text method events")
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

	-- ChatFrame7:AddMessage("AloftThreatText:RegisterEvents(): exit")
end

local dataRequiredList = { }
function AloftThreatText:RequiresData()
	-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): enter")
	-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): self.db.profile " .. tostring(self.db.profile))
	-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): self.db.profile.format " .. tostring(self.db.profile.format))

	-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): register events")
	self:RegisterEvents()

	if self:IsActive() then
		-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): clear data required")
		for i=1,#dataRequiredList do
			dataRequiredList[i] = nil
		end

		-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): establish data required")
		if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethodData.data) then
			self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		if self.textMethodData and self.textMethodData.data then
			for data in pairs(self.textMethodData.data) do
				-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): data required " .. tostring(data))
				table.insert(dataRequiredList, data)
			end
		end

		-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): exit")
		return unpack(dataRequiredList)
	end
end

-----------------------------------------------------------------------------

function AloftThreatText:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftThreatText:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftThreatText:OnEnable(): enter")

	self:UpdateAll()

	-- ChatFrame7:AddMessage("AloftThreatText:OnEnable(): exit")
end

function AloftThreatText:OnDisable()
	-- ChatFrame7:AddMessage("AloftThreatText:OnDisable(): enter")

	-- ChatFrame7:AddMessage("AloftThreatText:OnDisable(): unregister events")
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateVisibleNameplates() do
		-- ChatFrame7:AddMessage("AloftThreatText:OnDisable(): process nameplate")
		self:OnNameplateHide("AloftThreatText:OnDisable", aloftData)
	end

	-- ChatFrame7:AddMessage("AloftThreatText:OnDisable(): exit")
end

-----------------------------------------------------------------------------

function AloftThreatText:UpdateText(message, aloftData)
	-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): enter")

	-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): invoke text method")
	if self.db.profile.format and self.db.profile.format ~= "" and (not self.textMethodData or not self.textMethod) then
		self.textMethodData = Aloft:CreateTag(self.db.profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	local text = self.textMethod and self.textMethod(aloftData)
	-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): text " .. tostring(text))

	if text ~= "" then
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		local threatTextRegion = layoutFrame.threatTextRegion

		-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): process text")
		-- Check if this nameplate already has a text region assigned to it
		if not threatTextRegion then
			threatTextRegion = aloftData:CreateFontString()

			layoutFrame.threatTextRegion = threatTextRegion

			self:PlaceFrame(threatTextRegion, layoutFrame, self.db.profile, 0, 0)
		end

		self:PrepareText(threatTextRegion, self.db.profile)

		-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): assign text")
		threatTextRegion:SetText(text)
		threatTextRegion:Show()
		-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): exit")
		return
	end
		
	-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): hide text")
	self:OnNameplateHide(message, aloftData)

	-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): exit")
end

-----------------------------------------------------------------------------

function AloftThreatText:OnNameplateShow(message, aloftData)
	self:UpdateText(message, aloftData)
	-- self:ScheduleEvent(function(arg) AloftThreatText:UpdateText(arg.message, arg.aloftData) end, 0.0, { message = message, aloftData = aloftData, }) -- next frame
end

function AloftThreatText:OnNameplateHide(message, aloftData)
	-- ChatFrame7:AddMessage("AloftThreatText:OnNameplateHide(): enter")

	local layoutFrame = aloftData.layoutFrame
	local threatTextRegion = layoutFrame and layoutFrame.threatTextRegion
	if threatTextRegion then
		-- ChatFrame7:AddMessage("AloftThreatText:OnNameplateHide(): recycle text region")
		threatTextRegion:Hide()

		-- attempted workaround for some threatbar screen artifacts;
		-- looks like the WoW client is trying to optimize text region updates and is forgetting to update whenever
		-- the text regions are hidden; we whack it over the head here; seems to help
		-- TODO: continue experimenting with this, and see if the overhead can be reduced
		threatTextRegion:SetText("")
	end
	-- ChatFrame7:AddMessage("AloftThreatText:OnNameplateHide(): exit")
end

-----------------------------------------------------------------------------

end)