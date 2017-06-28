local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftIsTargetData = Aloft:NewModule("IsTargetData", "AceEvent-2.0")

-----------------------------------------------------------------------------

local lastTarget = nil
local targetExists = nil

-----------------------------------------------------------------------------

Aloft.TagData.IsTarget =
{
	data = "isTarget",
	events = "Aloft:OnIsTargetDataChanged",
	tableData = "isTarget"
}

-----------------------------------------------------------------------------

function AloftIsTargetData:ProvidesData()
	return "isTarget"
end

function AloftIsTargetData:EnableDataSource()
	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnPlayerTargetChanged")
	self:RegisterEvent("PLAYER_FOCUS_CHANGED", "OnPlayerFocusChanged")
	self:RegisterEvent("UNIT_TARGET", "OnUnitTargetChanged")
	self:RegisterEvent("CVAR_UPDATE", "OnCVarUpdate")
end

-----------------------------------------------------------------------------

function AloftIsTargetData:OnEnable()
	Aloft:DebugRegister("IsTargetData")
end

-----------------------------------------------------------------------------

function AloftIsTargetData:OnPlayerTargetChanged()
	-- ChatFrame7:AddMessage("IsTargetData:OnPlayerTargetChanged(): enter")

	targetExists = UnitExists("target")

	if lastTarget then
		local target = lastTarget

		lastTarget.isTarget = nil
		lastTarget = nil

		-- ChatFrame7:AddMessage("IsTargetData:OnPlayerTargetChanged(): firing Aloft:OnIsTargetDataChanged, leaving target " .. tostring(target.name))
		self:TriggerEvent("Aloft:OnIsTargetDataChanged", target)
	end

	-- At this stage, the nameplates still haven't updated their alpha, so we have to do it on next frame
	-- ChatFrame7:AddMessage("AloftIsTargetData:OnPlayerTargetChanged(): firing AloftIsTargetData:Update")
	self:ScheduleEvent("Aloft:IsTargetDataUpdate", self.Update, 0.0, self)

	-- ChatFrame7:AddMessage("IsTargetData:OnPlayerTargetChanged(): exit")
end

function AloftIsTargetData:OnPlayerFocusChanged()
	-- ChatFrame7:AddMessage("IsTargetData:OnPlayerFocusChanged(): enter")

	self:TriggerEvent("Aloft:OnIsFocusDataChanged")

	-- ChatFrame7:AddMessage("IsTargetData:OnPlayerFocusChanged(): exit")
end

-- TODO: is this really more efficient? can we locate this in a better place?
local unitIdFilter =
{
	["player"]	= true,
	["target"]	= true,
	["focus"]	= true,
}
function AloftIsTargetData:OnUnitTargetChanged(unitid)
	if not unitIdFilter[unitid] then -- filtered unitids are either handled elsewhere or not of interest
		local aloftData = Aloft:GetUnitNameplate(unitid) -- attempt to locate the nameplate for the unitid
		-- ChatFrame7:AddMessage("IsTargetData:OnUnitTargetChanged(): " .. tostring(unitid) .. "/" .. tostring(aloftData and aloftData.name))

		-- update even if there is no nameplate (which may simply not be visible at the moment), so that the data is ready and waiting when the nameplate appears
		-- ChatFrame7:AddMessage("IsTargetData:OnUnitTargetChanged(): " .. tostring(aloftData.name) .. "/" .. tostring(unitid) .. " triggering Aloft:OnUnitTargetDataChanged")
		self:TriggerEvent("Aloft:OnUnitTargetDataChanged", aloftData, unitid) -- this drives the TargetNameData module, which in turn handles "next frame delay" display issues
		-- TODO: make certain other functionality (bars/text) that might be interested in target changes don't need a "next frame delay";
		--              if so, it might be best to centralize this here, as we do for player target
	end
end

-- re-acquire target if its nameplate re-appears
function AloftIsTargetData:OnNameplateShow(aloftData)
	local eventName = "AloftIsTargetData:DoNameplateShow: :" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.DoNameplateShow, 0.0, self, aloftData) -- next frame
end

-- drop target if its nameplate disappears
function AloftIsTargetData:OnNameplateHide(aloftData)
	if lastTarget == aloftData then
		lastTarget.isTarget = nil
		lastTarget = nil
		-- ChatFrame7:AddMessage("IsTargetData:OnNameplateHide(): firing Aloft:OnIsTargetDataChanged, leaving target " .. tostring(aloftData.name))
		self:TriggerEvent("Aloft:OnIsTargetDataChanged", aloftData)
	end
end

function AloftIsTargetData:OnCVarUpdate(name, value)
	-- ChatFrame7:AddMessage("CVAR " .. tostring(name) .. "/" .. tostring(value))
	-- TODO: set to check the CVar for enable/disable
end

-----------------------------------------------------------------------------

-- re-acquire target if its nameplate re-appears
function AloftIsTargetData:DoNameplateShow(aloftData)
	if targetExists and aloftData.nameplateFrame:GetAlpha() == 1 then
		lastTarget = aloftData
		lastTarget.isTarget = true
		-- ChatFrame7:AddMessage("IsTargetData:DoNameplateShow(): firing Aloft:OnIsTargetDataChanged, gaining target " .. tostring(aloftData.name))
		self:TriggerEvent("Aloft:OnIsTargetDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftIsTargetData:UpdateData(aloftData)
	aloftData.isTarget = aloftData:IsTarget()
	-- ChatFrame7:AddMessage("IsTargetData:UpdateData(): new target is " .. aloftData.name .. "/" .. tostring(aloftData.isTarget))

	if aloftData.isTarget then
		if lastTarget and lastTarget ~= aloftData then
			lastTarget.isTarget = nil
			self:TriggerEvent("Aloft:OnIsTargetDataChanged", lastTarget)
		end
		lastTarget = aloftData
	end
end

function AloftIsTargetData:Update()
	-- ChatFrame7:AddMessage("AloftIsTargetData:Update(): " .. tostring(targetExists))
	if targetExists then
		lastTarget = Aloft:GetTargetNameplate()
		-- ChatFrame7:AddMessage("AloftIsTargetData:Update(): firing Aloft:OnIsTargetDataChanged, target exists " .. tostring(lastTarget and lastTarget.name))
		if lastTarget then
			lastTarget.isTarget = true
			-- ChatFrame7:AddMessage("IsTargetData:Update(): firing Aloft:OnIsTargetDataChanged, gaining target " .. tostring(lastTarget.name))
			self:TriggerEvent("Aloft:OnIsTargetDataChanged", lastTarget)
			-- NOTE: this does not result in the event firing if the target has no visible nameplate; disabled (hostile/friendly), an unflagged enemy player, or is at sufficient range that a healthbar is not visible, etc
		end
	else
		if lastTarget then
			lastTarget.isTarget = nil
			lastTarget = nil
		end
	end
end

-----------------------------------------------------------------------------
