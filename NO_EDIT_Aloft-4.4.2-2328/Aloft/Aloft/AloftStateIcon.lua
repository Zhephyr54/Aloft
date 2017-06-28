local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftStateIcon = Aloft:NewModule("StateIcon", Aloft, "AceEvent-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

AloftStateIcon.namespace = "stateIcon"
AloftStateIcon.defaults =
{
	profile =
	{
		enable			= true,
		alpha			= 1.0,
		reverse			= false,
		point			= "CENTER",
		relativeToPoint	= "RIGHT",
		offsetX			= -4,
		offsetY			= -1,
		height			= 34,
		width			= 46,
	},
}

-----------------------------------------------------------------------------

-- just a mnemonic, not currently used
local ELITE_NAMEPLATE_ICON = [[Interface\Tooltips\EliteNameplateIcon]]

-----------------------------------------------------------------------------

function AloftStateIcon:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		-- self:SetupFrame("AloftStateIcon:UpdateAll", aloftData)
		self:ScheduleTimer(function(aloftData) AloftStateIcon:DoNameplateShow(aloftData) end, 0.0, aloftData) -- next frame
	end
end

-----------------------------------------------------------------------------

function AloftStateIcon:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftStateIcon:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")
	self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
	self:UpdateAll()
end

function AloftStateIcon:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

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

function AloftStateIcon:SetupFrame(message, aloftData)
	if aloftData then -- apparently we can get here with a nil nameplate
		local stateIconRegion = aloftData.stateIconRegion

		if stateIconRegion --[[and stateIconRegion:IsVisible()]] then
			-- local r, g, b, a = stateIconRegion:GetVertexColor()
			-- local tr, tg, tb = floor(r * 256), floor(g*256), floor(b*256)
			-- ChatFrame7:AddMessage("AloftStateIcon:SetupFrame(): " .. ("|cff%02x%02x%02x%s|r"):format(tr, tg, tb, tostring(aloftData.name) .. "/" .. tostring(tr) .. "." .. tostring(tg) .. "." .. tostring(tb)) .. "/" .. tostring(stateIconRegion:IsVisible()) .. "/" .. tostring(stateIconRegion:GetTexture()))

			if not stateIconRegion.ULx then
				stateIconRegion.ULx, stateIconRegion.ULy, stateIconRegion.LLx, stateIconRegion.LLy, stateIconRegion.URx, stateIconRegion.URy, stateIconRegion.LRx, stateIconRegion.LRy = stateIconRegion:GetTexCoord() -- collect the coordinates currently in use
			end
			if self.db.profile.reverse then
				stateIconRegion:SetTexCoord(stateIconRegion.URx, stateIconRegion.URy, stateIconRegion.LRx, stateIconRegion.LRy, stateIconRegion.ULx, stateIconRegion.ULy, stateIconRegion.LLx, stateIconRegion.LLy) -- flip/mirror horizontally
			else
				stateIconRegion:SetTexCoord(stateIconRegion.ULx, stateIconRegion.ULy, stateIconRegion.LLx, stateIconRegion.LLy, stateIconRegion.URx, stateIconRegion.URy, stateIconRegion.LRx, stateIconRegion.LRy) -- un-flip/mirror horizontally, restore to original values
			end

			self:PlaceFrame(stateIconRegion, aloftData.layoutFrame, self.db.profile, 0, 0) -- this sets alpha to 0 if enable is not true
			stateIconRegion:SetDrawLayer("OVERLAY")
			stateIconRegion:SetBlendMode("BLEND")
		end
	end
end

function AloftStateIcon:OnNameplateShow(message, aloftData)
	-- self:SetupFrame(message, aloftData)
	self:ScheduleTimer(function(aloftData) AloftStateIcon:DoNameplateShow(aloftData) end, 0.15, aloftData) -- a bit more than next frame
end

function AloftStateIcon:DoNameplateShow(aloftData)
	self:SetupFrame("AloftStateIcon:DoNameplateShow", aloftData)
end

-----------------------------------------------------------------------------
