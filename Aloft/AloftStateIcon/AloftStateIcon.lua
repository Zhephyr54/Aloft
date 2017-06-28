local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftStateIcon = Aloft:NewModule("StateIcon", "AceEvent-2.0")

-----------------------------------------------------------------------------

AloftStateIcon.db = Aloft:AcquireDBNamespace("stateIcon")
Aloft:RegisterDefaults("stateIcon", "profile", {
	enable			= true,
	alpha			= 1.0,
	reverse			= false,
	point			= "CENTER",
	relativeToPoint	= "RIGHT",
	offsetX			= -4,
	offsetY			= -1,
	height			= 34,
	width			= 46,
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftStateIcon:UpdateAll()
	for aloftData in Aloft:IterateNameplates() do
		self:SetupFrame(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftStateIcon:OnInitialize()
	profile = self.db.profile
end

function AloftStateIcon:OnEnable()
	self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")
	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	self:UpdateAll()
end

function AloftStateIcon:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateNameplates() do
		local stateIconRegion = aloftData.stateIconRegion

		if stateIconRegion then
			stateIconRegion:ClearAllPoints()
			stateIconRegion:SetPoint("CENTER", aloftData.levelTextRegion, "CENTER", 4.70, 1.57)
			stateIconRegion:SetWidth(46)
			stateIconRegion:SetHeight(34)
			stateIconRegion:SetAlpha(1)
			if stateIconRegion.ULx then
				stateIconRegion:SetTexCoord(stateIconRegion.ULx, stateIconRegion.ULy, stateIconRegion.LLx, stateIconRegion.LLy, stateIconRegion.URx, stateIconRegion.URy, stateIconRegion.LRx, stateIconRegion.LRy) -- un-flip/mirror horizontally, restore to original values
			end
			stateIconRegion:SetDrawLayer("OVERLAY")
		end
	end
end

function AloftStateIcon:SetupFrame(aloftData)
	if aloftData then -- apparently we can get here with a nil nameplate
		local stateIconRegion = aloftData.stateIconRegion

		if stateIconRegion --[[and stateIconRegion:IsVisible()]] then
			if not stateIconRegion.ULx then
				stateIconRegion.ULx, stateIconRegion.ULy, stateIconRegion.LLx, stateIconRegion.LLy, stateIconRegion.URx, stateIconRegion.URy, stateIconRegion.LRx, stateIconRegion.LRy = stateIconRegion:GetTexCoord() -- collect the coordinates currently in use
			end
			if profile.reverse then
				stateIconRegion:SetTexCoord(stateIconRegion.URx, stateIconRegion.URy, stateIconRegion.LRx, stateIconRegion.LRy, stateIconRegion.ULx, stateIconRegion.ULy, stateIconRegion.LLx, stateIconRegion.LLy) -- flip/mirror horizontally
			else
				stateIconRegion:SetTexCoord(stateIconRegion.ULx, stateIconRegion.ULy, stateIconRegion.LLx, stateIconRegion.LLy, stateIconRegion.URx, stateIconRegion.URy, stateIconRegion.LRx, stateIconRegion.LRy) -- un-flip/mirror horizontally, restore to original values
			end

			-- NOTE: odd artifacts ensue when we attach to layoutFrame; works better when we attach to levelTextRegion
			self:PlaceFrame(stateIconRegion, aloftData.layoutFrame, profile, 0, 0)
			stateIconRegion:SetDrawLayer("OVERLAY")
			stateIconRegion:SetBlendMode("BLEND")
		end
	end
end

function AloftStateIcon:OnNameplateShow(aloftData)
	self:SetupFrame(aloftData)
	--[[
	local eventName = "AloftClassIcon:OnNameplateShow:" .. ":" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.DoNameplateShow, 0.0, self, aloftData) -- next frame
	]]
end

function AloftStateIcon:DoNameplateShow(aloftData)
	self:SetupFrame(aloftData)
end

-----------------------------------------------------------------------------
