local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftMana", function()

-----------------------------------------------------------------------------

local AloftManaText = Aloft:NewModule("ManaText", "AceEvent-2.0")
AloftManaText.dynamic = "AloftMana"

local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

AloftManaText.db = Aloft:AcquireDBNamespace("manaText")
Aloft:RegisterDefaults("manaText", "profile", {
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
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftManaText:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if profile.enable then
			local layoutFrame = aloftData.layoutFrame
			if layoutFrame then
				local manaTextRegion = layoutFrame.manaTextRegion
				if manaTextRegion then
					self:PrepareText(manaTextRegion, profile)
					self:PlaceFrame(manaTextRegion, layoutFrame, profile)
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
		local manaTextRegion = layoutFrame.manaTextRegion
		if manaTextRegion then
			self:PrepareText(manaTextRegion, profile)
			self:PlaceFrame(manaTextRegion, layoutFrame, profile, 0, 0)
		end
	end
end

-----------------------------------------------------------------------------

function AloftManaText:RegisterEvents()
	self:UnregisterAllEvents()

	if profile and profile.enable then
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterEvent("Aloft:OnSetHealthBarColor", "UpdateText")

		self:RegisterEvent("Aloft:SetAll", function(type, value)
			if profile[type] then
				profile[type] = value
				self:UpdateAll()
			end
		end)

		if not self.textMethod or not self.textMethodData or not self.textMethodData.events then
			self.textMethodData = Aloft:CreateTag(profile.format, true)
			self.textMethod = self.textMethodData.method
		end
		for events in pairs(self.textMethodData.events) do
			self:RegisterEvent(events, "UpdateText")
		end
	end
end

local dataRequiredList = { }
function AloftManaText:RequiresData()
	self:RegisterEvents()

	if profile and profile.enable then
		for i=1,#dataRequiredList do
			dataRequiredList[i] = nil
		end

		if not self.textMethod or not self.textMethodData or not self.textMethodData.events then
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

function AloftManaText:OnInitialize()
	profile = self.db.profile
end

function AloftManaText:OnEnable()
	Aloft:DebugRegister("ManaText")

	self:UpdateAll()
end

function AloftManaText:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateHide(aloftData)
	end
	-- TODO: nil out Aloft.Options
end

-----------------------------------------------------------------------------

function AloftManaText:UpdateText(aloftData)
	--if (Aloft:IsLogEnbl("ManaText", 5)) then Aloft:Log("ManaText", "UpdateText", 5, "invoke text method") end
	if not self.textMethodData or not self.textMethod then
		self.textMethodData = Aloft:CreateTag(profile.format, true)
		self.textMethod = self.textMethodData.method
	end
	local text = self.textMethod(aloftData)
	--if (Aloft:IsLogEnbl("ManaText", 3)) then Aloft:Log("ManaText", "UpdateText", 3, "text " .. tostring(text)) end

	if text ~= "" then
		local layoutFrame = aloftData.layoutFrame
		if not layoutFrame then
			layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
		end
		local manaTextRegion = layoutFrame.manaTextRegion

		-- Check if this nameplate already has a text region assigned to it
		if not manaTextRegion then
			manaTextRegion = aloftData:CreateFontString()

			layoutFrame.manaTextRegion = manaTextRegion

			self:PrepareText(manaTextRegion, profile)
			self:PlaceFrame(manaTextRegion, layoutFrame, profile, 0, 0)
		end

		-- ChatFrame7:AddMessage("AloftManaText:UpdateText(): " .. tostring(aloftData.name)
		-- 	.. "/" .. tostring(text)
		-- 	.. "/" .. tostring(self.textMethodData.functionString))

		manaTextRegion:SetText(text)
		manaTextRegion:Show()

		return
	end
	self:OnNameplateHide(aloftData)
end

-----------------------------------------------------------------------------

function AloftManaText:OnNameplateShow(aloftData)
	self:UpdateText(aloftData)
end

function AloftManaText:OnNameplateHide(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local manaTextRegion = layoutFrame and layoutFrame.manaTextRegion
	if manaTextRegion then
		manaTextRegion:Hide()
		manaTextRegion:SetText("")
	end
end

-----------------------------------------------------------------------------

end)
