local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

local AloftThreatText = Aloft:NewModule("ThreatText", "AceEvent-2.0")
AloftThreatText.dynamic = "AloftThreat"

local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

-- local AloftThreatBar = Aloft:GetModule("ThreatBar")
AloftThreatText.db = Aloft:AcquireDBNamespace("threatText")
Aloft:RegisterDefaults("threatText", "profile", {
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
	color			= { 1, 1, 1 }
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftThreatText:IsGrouped()
	return (GetNumPartyMembers() + GetNumRaidMembers()) > 0
end

function AloftThreatText:IsEnabled()
	return profile and profile.enable and (self:IsGrouped() or profile.activeWhileSolo)
end

-----------------------------------------------------------------------------

function AloftThreatText:UpdateAll()
	-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): enter")

	-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): iterate nameplates")
	for aloftData in Aloft:IterateVisibleNameplates() do
		-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): process nameplate")
		if self:IsEnabled() then
			local layoutFrame = aloftData.layoutFrame
			if layoutFrame then
				-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): profile enabled, process threat text region")
				local threatTextRegion = layoutFrame.threatTextRegion
				if threatTextRegion then
					-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): prepare/place text")
					self:PrepareText(threatTextRegion, profile)
					self:PlaceFrame(threatTextRegion, layoutFrame, profile)
				end
				-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): check IsShown")
				if aloftData:IsShown() then
					-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): update text")
					self:UpdateText(aloftData)
				end
				-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): process threat text region complete")
			end
		else
			-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): profile disabled, hide text")
			self:OnNameplateHide(aloftData)
		end
		-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): process nameplate complete")
	end
	-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): iterate nameplates complete")

	-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): iterate text region pool")
	for layoutFrame in pairs(Aloft.layoutFramePool) do
		local threatTextRegion = layoutFrame.threatTextRegion
		if threatTextRegion then
			-- ChatFrame7:AddMessage("AloftThreatText:UpdateAll(): prepare text")
			self:PrepareText(threatTextRegion, profile)
			self:PlaceFrame(threatTextRegion, layoutFrame, profile)
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

	if self:IsEnabled() then
		-- ChatFrame7:AddMessage("AloftThreatText:RegisterEvents(): register SetAll")
		self:RegisterEvent("Aloft:SetAll", function(type, value)
			if profile[type] then
				-- ChatFrame7:AddMessage("AloftThreatText:RegisterEvents(): update")
				profile[type] = value
				self:UpdateAll()
			end
		end)

		-- ChatFrame7:AddMessage("AloftThreatText:RegisterEvents(): profile enabled, register atomic events")
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterEvent("Aloft:OnSetHealthBarColor", "UpdateText")

		-- ChatFrame7:AddMessage("AloftThreatText:RegisterEvents(): register text method events")
		if not self.textMethodData or not self.textMethodData.events then
			self.textMethodData = Aloft:CreateTag(profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		for events in pairs(self.textMethodData.events) do
			self:RegisterEvent(events, "UpdateText")
		end
	end

	-- ChatFrame7:AddMessage("AloftThreatText:RegisterEvents(): exit")
end

local dataRequiredList = { }
function AloftThreatText:RequiresData()
	-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): enter")
	-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): profile " .. tostring(profile))
	-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): profile.format " .. tostring(profile.format))

	-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): register events")
	self:RegisterEvents()

	if self:IsEnabled() then
		-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): clear data required")
		for i=1,#dataRequiredList do
			dataRequiredList[i] = nil
		end

		-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): establish data required")
		if not self.textMethodData or not self.textMethodData.data then
			self.textMethodData = Aloft:CreateTag(profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		for data in pairs(self.textMethodData.data) do
			-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): data required " .. tostring(data))
			table.insert(dataRequiredList, data)
		end

		-- ChatFrame7:AddMessage("AloftThreatText:RequiresData(): exit")
		return unpack(dataRequiredList)
	end
end

-----------------------------------------------------------------------------

function AloftThreatText:OnInitialize()
	Aloft:DebugRegister("ThreatText")

	-- ChatFrame7:AddMessage("AloftThreatText:OnInitialize(): enter")

	profile = self.db.profile

	-- ChatFrame7:AddMessage("AloftThreatText:OnInitialize(): exit")
end

function AloftThreatText:OnEnable()
	-- ChatFrame7:AddMessage("AloftThreatText:OnEnable(): enter")

	self:UpdateAll()

	-- ChatFrame7:AddMessage("AloftThreatText:OnEnable(): exit")
end

function AloftThreatText:OnDisable()
	-- ChatFrame7:AddMessage("AloftThreatText:OnDisable(): enter")

	-- ChatFrame7:AddMessage("AloftThreatText:OnDisable(): unregister events")
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateVisibleNameplates() do
		-- ChatFrame7:AddMessage("AloftThreatText:OnDisable(): process nameplate")
		self:OnNameplateHide(aloftData)
	end

	-- ChatFrame7:AddMessage("AloftThreatText:OnDisable(): exit")
end

-----------------------------------------------------------------------------

function AloftThreatText:UpdateText(aloftData)
	-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): enter")

	-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): invoke text method")
	if not self.textMethodData or not self.textMethod then
		self.textMethodData = Aloft:CreateTag(profile.format, true)
		self.textMethod = self.textMethodData.method
	end

	local text = self.textMethod(aloftData)
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

			self:PrepareText(threatTextRegion, profile)
			self:PlaceFrame(threatTextRegion, layoutFrame, profile, 0, 0)
		end

		-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): assign text")
		threatTextRegion:SetText(text)
		threatTextRegion:Show()
		-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): exit")
		return
	end
		
	-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): hide text")
	self:OnNameplateHide(aloftData)

	-- ChatFrame7:AddMessage("AloftThreatText:UpdateText(): exit")
end

-----------------------------------------------------------------------------

function AloftThreatText:OnNameplateShow(aloftData)
	self:UpdateText(aloftData)
	--[[
	local eventName = "AloftThreatText:OnNameplateShow:" .. ":" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.UpdateText, 0.0, self, aloftData) -- next frame
	]]
end

function AloftThreatText:OnNameplateHide(aloftData)
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