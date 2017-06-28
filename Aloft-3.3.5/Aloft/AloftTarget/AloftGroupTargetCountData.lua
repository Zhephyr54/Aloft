local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

local AloftGroupTargetCountData = Aloft:NewModule("GroupTargetCountData", "AceEvent-2.0")
AloftGroupTargetCountData.dynamic = "AloftTarget"

-----------------------------------------------------------------------------

local groupTargetCount = setmetatable({ }, { __index = function() return 0 end })

-----------------------------------------------------------------------------

Aloft.TagData.GroupTargetCount =
{
	data = "groupTargetCount",
	events = "Aloft:OnGroupTargetCountChanged",
	tableData = "groupTargetCount",
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
	return "groupTargetCount"
end

function AloftGroupTargetCountData:EnableDataSource()
	self:ScheduleRepeatingEvent("AloftGroupTargetCountUpdate", self.Update, 0.25, self) -- 4x per second
end

-----------------------------------------------------------------------------

function AloftGroupTargetCountData:UpdateData(aloftData)
	aloftData.groupTargetCount = groupTargetCount[aloftData.name]
end

-----------------------------------------------------------------------------

function AloftGroupTargetCountData:Update()
	for k in pairs(groupTargetCount) do
		groupTargetCount[k] = nil
	end

	local groupTarget = nil
	local playerTarget = nil
	local raidMembers = GetNumRaidMembers()
	if raidMembers > 0 then
		groupTarget = true
		for i=1,raidMembers-1 do		-- Exclude the player, who is the top raid#
			local name = UnitName("raid"..i.."target")
			if name then
				groupTargetCount[name] = groupTargetCount[name] + 1
			end
		end
	else
		local partyMembers = GetNumPartyMembers()
		if partyMembers > 0 then
			groupTarget = true
			for i=1,partyMembers do
				local name = UnitName("party"..i.."target")
				if name then
					groupTargetCount[name] = groupTargetCount[name] + 1
				end
			end
		elseif (UnitExists("pet")) then -- the simplest form of "group": the player with a pet
			playerTarget = UnitName("target") -- just add the player
		end
	end
	-- TODO: incorporate race/class and raid target assignment to differentiate counts
	-- TODO: add an option to include pets?

	for aloftData in Aloft:IterateVisibleNameplates() do
		local count
		if (groupTarget) then
			count = groupTargetCount[aloftData.name]
		elseif playerTarget == aloftData.name and (aloftData.isTarget or aloftData:IsTarget()) then
			count = 1
		end
		if count ~= aloftData.groupTargetCount then -- this clears if needed
			aloftData.groupTargetCount = count
			self:TriggerEvent("Aloft:OnGroupTargetCountChanged", aloftData)
		end
	end
end

-----------------------------------------------------------------------------

end)
