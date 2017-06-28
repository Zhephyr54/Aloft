local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftIsTargetData = Aloft:NewModule("IsTargetData", Aloft, "AceEvent-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

local lastTarget = nil
local targetExists = nil
local interval = 0.1 -- somewhat fuzzy, tuned empirically; should be just next frame (0.0), sometimes needs more

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

-- this data source overrides DisableDataSource because we still want target change events to be caught even if this data source isn't used at the moment
function AloftIsTargetData:DisableDataSource()
	-- ChatFrame7:AddMessage("AloftIsTargetData:DisableDataSource(): enter")
	self:RemoveAloftData("isTarget")
	-- ChatFrame7:AddMessage("AloftIsTargetData:DisableDataSource(): exit")
end

function AloftIsTargetData:RegisterEvents()
	-- ChatFrame7:AddMessage("AloftIsTargetData:RegisterEvents(): enter")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")

	-- ChatFrame7:AddMessage("AloftIsTargetData:RegisterEvents(): PLAYER_TARGET_CHANGED")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnPlayerTargetChanged")

	self:RegisterEvent("PLAYER_FOCUS_CHANGED", "OnPlayerFocusChanged")
	self:RegisterEvent("UNIT_TARGET", "OnUnitTargetChanged")
	self:RegisterEvent("CVAR_UPDATE", "OnCVarUpdate")
end

-----------------------------------------------------------------------------

function AloftIsTargetData:OnInitialize()
	self.initialized = true
end

function AloftIsTargetData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:RegisterEvents()
end

function AloftIsTargetData:OnDisable()
	-- ChatFrame7:AddMessage("AloftIsTargetData:OnDisable(): enter")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftIsTargetData:OnPlayerTargetChanged(event, value)
	-- ChatFrame7:AddMessage("AloftIsTargetData:OnPlayerTargetChanged(): enter " .. tostring(event) .. "/" .. tostring(value))

	targetExists = UnitExists("target")

	if lastTarget then
		local target = lastTarget

		lastTarget.isTarget = nil
		lastTarget = nil

		-- ChatFrame7:AddMessage("IsTargetData:OnPlayerTargetChanged(): firing Aloft:OnIsTargetDataChanged, leaving target " .. tostring(target.name))
		self:SendMessage("Aloft:OnIsTargetDataChanged", target)
	end

	-- At this stage, the nameplates still haven't updated their alpha, so we have to do it on next frame
	-- ChatFrame7:AddMessage("AloftIsTargetData:OnPlayerTargetChanged(): firing AloftIsTargetData:Update, target " .. tostring(targetExists) .. "/" .. tostring(UnitName("target")))
	self:ScheduleTimer(function() AloftIsTargetData:Update() end, interval) -- next frame

	-- ChatFrame7:AddMessage("IsTargetData:OnPlayerTargetChanged(): exit")
end

function AloftIsTargetData:OnPlayerFocusChanged(event)
	-- ChatFrame7:AddMessage("IsTargetData:OnPlayerFocusChanged(): enter")

	self:SendMessage("Aloft:OnIsFocusDataChanged")

	-- ChatFrame7:AddMessage("IsTargetData:OnPlayerFocusChanged(): exit")
end

-- TODO: is this really more efficient? can we locate this in a better place?
local unitIdFilter =
{
	["player"]	= true,
	["target"]	= true,
	["focus"]	= true,
}
function AloftIsTargetData:OnUnitTargetChanged(event, unitid)
	-- ChatFrame7:AddMessage("IsTargetData:OnUnitTargetChanged(): " .. tostring(event) .. "/" .. tostring(unitid))
	if not unitIdFilter[unitid] then -- filtered unitids are either handled elsewhere or not of interest
		local aloftData = Aloft:GetUnitNameplate(unitid) -- attempt to locate the nameplate for the unitid
		-- ChatFrame7:AddMessage("IsTargetData:OnUnitTargetChanged(): " .. tostring(unitid) .. "/" .. tostring(aloftData and aloftData.name))

		-- update even if there is no nameplate (which may simply not be visible at the moment), so that the data is ready and waiting when the nameplate appears
		-- ChatFrame7:AddMessage("IsTargetData:OnUnitTargetChanged(): " .. tostring(aloftData.name) .. "/" .. tostring(unitid) .. " triggering Aloft:OnUnitTargetDataChanged")
		self:SendMessage("Aloft:OnUnitTargetDataChanged", aloftData, unitid) -- this drives the TargetNameData module, which in turn handles "next frame delay" display issues
		-- TODO: make certain other functionality (bars/text) that might be interested in target changes don't need a "next frame delay";
		--              if so, it might be best to centralize this here, as we do for player target
	end
end

-- re-acquire target if its nameplate re-appears
function AloftIsTargetData:OnNameplateShow(message, aloftData)
	self:ScheduleTimer(function(aloftData) AloftIsTargetData:DoNameplateShow(aloftData) end, interval, aloftData) -- next frame
end

-- drop target if its nameplate disappears
function AloftIsTargetData:OnNameplateHide(message, aloftData)
	if lastTarget == aloftData then
		lastTarget.isTarget = nil
		lastTarget = nil
		-- ChatFrame7:AddMessage("IsTargetData:OnNameplateHide(): firing Aloft:OnIsTargetDataChanged, leaving target " .. tostring(aloftData.name))
		self:SendMessage("Aloft:OnIsTargetDataChanged", aloftData)
	end
end

function AloftIsTargetData:OnCVarUpdate(event, name, value)
	-- ChatFrame7:AddMessage("CVAR " .. tostring(event) .. "/" .. tostring(name) .. "/" .. tostring(value))
	-- TODO: set to check the CVar for enable/disable
end

-----------------------------------------------------------------------------

-- re-acquire target if its nameplate re-appears
function AloftIsTargetData:DoNameplateShow(aloftData)
	if aloftData.nameplateFrame and aloftData:IsTarget() then -- need to actually go to display alpha here, we are setting the isTarget flag
		lastTarget = aloftData
		lastTarget.isTarget = true
		-- ChatFrame7:AddMessage("IsTargetData:DoNameplateShow(): firing Aloft:OnIsTargetDataChanged, gaining target " .. tostring(aloftData) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(aloftData.nameplateFrame:GetAlpha()) .. "/" .. tostring(aloftData.isTarget) .. "/" .. tostring(aloftData:IsTarget()))
		self:SendMessage("Aloft:OnIsTargetDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftIsTargetData:UpdateData(aloftData)
	aloftData.isTarget = aloftData:IsTarget() -- need to actually go to the underlying alpha here, we need to check the isTarget flag
	-- ChatFrame7:AddMessage("IsTargetData:UpdateData(): new target is " .. aloftData.name .. "/" .. tostring(aloftData.isTarget))

	if aloftData.isTarget then
		if lastTarget and lastTarget ~= aloftData then
			lastTarget.isTarget = nil
			self:SendMessage("Aloft:OnIsTargetDataChanged", lastTarget)
		end
		lastTarget = aloftData
	end
end

function AloftIsTargetData:Update()
	if targetExists then
		-- ChatFrame7:AddMessage("AloftIsTargetData:Update(): target exists " .. tostring(targetExists) .. "/" .. tostring(lastTarget and lastTarget.name))
		lastTarget = Aloft:GetTargetNameplate() -- need to actually go to the underlying alpha here, we are setting the isTarget flag
		if lastTarget --[[ and lastTarget:IsTarget() ]] then
			-- ChatFrame7:AddMessage("IsTargetData:Update(): firing Aloft:OnIsTargetDataChanged, gaining target " .. tostring(lastTarget) .. "/" .. tostring(lastTarget.name) .. "/" .. tostring(lastTarget.nameplateFrame:GetAlpha()) .. "/" .. tostring(lastTarget.isTarget) .. "/" .. tostring(lastTarget:IsTarget()))
			lastTarget.isTarget = true
			self:SendMessage("Aloft:OnIsTargetDataChanged", lastTarget)
			-- NOTE: this does not result in the event firing if the target has no visible nameplate; i.e. disabled (hostile/friendly), an unflagged enemy player, or is at sufficient range that a healthbar is not visible, etc
		end
	else
		-- ChatFrame7:AddMessage("AloftIsTargetData:Update(): no target")
		if lastTarget then
			lastTarget.isTarget = nil
			lastTarget = nil
		end
	end
end

-----------------------------------------------------------------------------
