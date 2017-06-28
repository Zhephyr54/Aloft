local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

local AloftGroupTargetCountData = Aloft:NewModule("GroupTargetCountData", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftGroupTargetCountData.dynamic = "AloftTarget"

-----------------------------------------------------------------------------

local groupTargetCount = setmetatable({ }, { __index = function() return 0 end })
local groupTargetGUIDCount = setmetatable({ }, { __index = function() return 0 end })

-----------------------------------------------------------------------------

Aloft.TagData.GroupTargetCount =
{
	data = "groupTargetCount",
	events = "Aloft:OnGroupTargetCountChanged",
	tableData = "groupTargetCount",
	numeric = true
}

Aloft.TagData.GroupTargetGUIDCount =
{
	data = "groupTargetGUIDCount",
	events = "Aloft:OnGroupTargetGUIDCountChanged",
	tableData = "groupTargetGUIDCount",
	numeric = true
}

-----------------------------------------------------------------------------

--[[
local function IsGrouped()
	return GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0
end
Aloft.DataAvailableMethods.groupTargetCount = IsGrouped
]]

-----------------------------------------------------------------------------

function AloftGroupTargetCountData:ProvidesData()
	return "groupTargetCount", "groupTargetGUIDCount"
end

function AloftGroupTargetCountData:EnableDataSource()
	-- ChatFrame7:AddMessage("AloftGroupTargetCountData:EnableDataSource(): enter")
	self:ScheduleRepeatingTimer(function() AloftGroupTargetCountData:Update() end, 0.25) -- 4x per second
end

-----------------------------------------------------------------------------

function AloftGroupTargetCountData:OnInitialize()
	self.initialized = true
end

function AloftGroupTargetCountData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end
end

function AloftGroupTargetCountData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftGroupTargetCountData:UpdateData(aloftData)
	aloftData.groupTargetCount = groupTargetCount[aloftData.name]
end

-----------------------------------------------------------------------------

function AloftGroupTargetCountData:Update()
	-- ChatFrame7:AddMessage("AloftGroupTargetCountData:Update(): enter")

	for k in pairs(groupTargetCount) do
		groupTargetCount[k] = nil
	end
	for k in pairs(groupTargetGUIDCount) do
		groupTargetGUIDCount[k] = nil
	end

	local groupTarget = nil
	local playerTarget = nil
	local playerTargetGUID = nil
	local raidMembers = GetNumRaidMembers()
	if raidMembers > 0 then
		groupTarget = true
		for i=1,raidMembers-1 do		-- Exclude the player, who is the top raid#
			local uid = "raid"..i.."target"
			local name = UnitName(uid)
			local guid = UnitGUID(uid)
			if name then
				groupTargetCount[name] = groupTargetCount[name] + 1
			end
			if guid then
				groupTargetGUIDCount[guid] = groupTargetGUIDCount[guid] + 1
				-- ChatFrame7:AddMessage("AloftGroupTargetCountData:Update(): raid " .. tostring(name) .. "/" .. tostring(guid) .. "/" .. tostring(groupTargetGUIDCount[guid]))
			end
		end
	else
		local partyMembers = GetNumPartyMembers()
		if partyMembers > 0 then
			groupTarget = true
			for i=1,partyMembers do
				local uid = "party"..i.."target"
				local name = UnitName(uid)
				local guid = UnitGUID(uid)
				if name then
					groupTargetCount[name] = groupTargetCount[name] + 1
				end
				if guid then
					groupTargetGUIDCount[guid] = groupTargetGUIDCount[guid] + 1
					-- ChatFrame7:AddMessage("AloftGroupTargetCountData:Update(): group " .. tostring(name) .. "/" .. tostring(guid) .. "/" .. tostring(groupTargetGUIDCount[guid]))
				end
			end
		elseif (UnitExists("pet")) then -- the simplest form of "group": the player with a pet
			playerTarget = UnitName("target") -- just add the player

			local guid = UnitGUID("target")
			if guid then
				groupTargetGUIDCount[guid] = groupTargetGUIDCount[guid] + 1
				-- ChatFrame7:AddMessage("AloftGroupTargetCountData:Update(): player " .. tostring(name) .. "/" .. tostring(guid) .. "/" .. tostring(groupTargetGUIDCount[guid]))
			end
		end
	end
	-- TODO: incorporate race/class and raid target assignment to differentiate counts
	-- TODO: add an option to include pets?

	-- list of nameplates with a modified groupTargetGUIDCount
	local groupTargetGUIDList = { }

	for aloftData in Aloft:IterateVisibleNameplates() do
		-- clear the GUID target count
		local guid = aloftData.groupTargetGUIDCount
		if guid then
			aloftData.groupTargetGUIDCount = nil
			groupTargetGUIDList[aloftData] = true
		end

		-- process the name-based target count
		local count
		if groupTarget then
			count = groupTargetCount[aloftData.name]
		elseif playerTarget == aloftData.name and (aloftData.isTarget or aloftData:IsTarget()) then
			count = 1
		end
		
		if count ~= aloftData.groupTargetCount then -- this clears if needed
			aloftData.groupTargetCount = count
			self:SendMessage("Aloft:OnGroupTargetCountChanged", aloftData)
		end
		-- ChatFrame7:AddMessage("AloftGroupTargetCountData:Update(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.groupTargetCount))
	end

	local targetGUID = UnitGUID("target")
	if targetGUID then
		local aloftData = Aloft:GetTargetNameplate()
		if aloftData then
			local guid = groupTargetGUIDCount[targetGUID]
			if guid then
				aloftData.groupTargetGUIDCount = guid
				groupTargetGUIDList[aloftData] = true
			end
		end
	end

	for aloftData in pairs(groupTargetGUIDList) do
		groupTargetGUIDList[aloftData] = nil
		self:SendMessage("Aloft:OnGroupTargetGUIDCountChanged", aloftData)
	end
end

-----------------------------------------------------------------------------

end)
