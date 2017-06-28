local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftUnitidData = Aloft:NewModule("UnitidData", "AceEvent-2.0")
local roster = AceLibrary("Roster-2.1")

-----------------------------------------------------------------------------

local playerName = UnitName("player") -- cache of player's name

-----------------------------------------------------------------------------

Aloft.TagData.UnitID =
{
	data = "unitid",
	events = "Aloft:OnUnitidDataChanged",
	tableData = "unitid"
}

-----------------------------------------------------------------------------

function AloftUnitidData:IsGrouped()
	return (GetNumPartyMembers() + GetNumRaidMembers()) > 0
end

-----------------------------------------------------------------------------

function AloftUnitidData:RequiresData()
	-- ChatFrame7:AddMessage("AloftUnitidData:RequiresData(): invoke")
	-- eg. return "class", "isPetName", "isGuildMember"
end

function AloftUnitidData:ProvidesData()
	-- ChatFrame7:AddMessage("AloftUnitidData:ProvidesData(): invoke")
	return "unitid"
end

-----------------------------------------------------------------------------

function AloftUnitidData:OnInitialize()
end

function AloftUnitidData:OnEnable()
	Aloft:DebugRegister("UnitidData")

	-- ChatFrame7:AddMessage("AloftUnitidData:OnEnable(): enter")
	self:RegisterEvent("RosterLib_RosterUpdated", "OnRosterUpdated")
	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	-- ChatFrame7:AddMessage("AloftUnitidData:OnEnable(): exit")
end

function AloftUnitidData:OnDisable()
	-- ChatFrame7:AddMessage("AloftUnitidData:OnDisable(): enter")
	self:UnregisterAllEvents()
	-- ChatFrame7:AddMessage("AloftUnitidData:OnDisable(): exit")
end

function AloftUnitidData:EnableDataSource()
	-- ChatFrame7:AddMessage("AloftUnitidData:EnableDataSource(): enter")
	-- ChatFrame7:AddMessage("AloftUnitidData:EnableDataSource(): exit")
end

-- This data source overrides DisableDataSource because we still want RosterUpdated events to be caught even if this data source isn't used at the moment
function AloftUnitidData:DisableDataSource()
	-- ChatFrame7:AddMessage("AloftUnitidData:DisableDataSource(): enter")
	self:RemoveAloftData("unitid")
	-- ChatFrame7:AddMessage("AloftUnitidData:DisableDataSource(): exit")
end

--[[
function AloftUnitidData:OnRosterUpdated()
	local eventName = "AloftUnitidData:UpdateRoster:" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.UpdateRoster, 0.1, self) -- give Aloft a moment at least to assign names
end
]]

function AloftUnitidData:OnNameplateShow(aloftData)
	self:UpdateData(aloftData)
end

function AloftUnitidData:OnNameplateHide(aloftData)
	aloftData.unitid = nil
	aloftData.unitguid = nil
end

function AloftUnitidData:OnRosterUpdated()
	-- ChatFrame7:AddMessage("AloftUnitidData:RosterUpdated(): enter")

	local eventName = "AloftUnitidData:DoRosterUpdated:" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.DoRosterUpdated, 0.0, self) -- next frame

	--[[
	-- DetermineDataSources updates all data. We want to trigger events if data has changed
	-- so we iterate the frames before calling DetermineDataSources
	--
	-- Some modules determine which events to listen to depending on the availability of unitid
	-- So if we are now grouped, determine which have changed, then call DetermineDataSources, then trigger the events
	-- Otherwise we trigger the events before calling DetermineDataSources

	local grouped = self:IsGrouped()
	local updateList = nil

	-- ChatFrame7:AddMessage("AloftUnitidData:DisableDataSource(): ROSTER")

	for aloftData in Aloft:IterateVisibleNameplates() do
		local unitid = self:ConvertUnitId(aloftData.name, roster:GetUnitIDFromName(aloftData.name))
		ChatFrame7:AddMessage("AloftUnitidData:OnRosterUpdated(): " .. tostring(aloftData.name) .. "/" .. tostring(roster:GetUnitIDFromName(aloftData.name)) .. "/" .. tostring(unitid))
		if aloftData.unitid ~= unitid then
			if grouped then
				-- this marks for update after Aloft:DetermineDataSources() is invoked
				updateList = updateList or { }
				table.insert(updateList, aloftData)
			elseif unitid and aloftData == Aloft:GetUnitNameplate(unitid) then
				aloftData.unitid = unitid
				aloftData.unitguid = UnitGUID(unitid)
				-- ChatFrame7:AddMessage("AloftUnitidData:DisableDataSource(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.unitguid))
				self:TriggerEvent("Aloft:OnUnitidDataChanged", aloftData)
			else
				-- make certain unitid and unitGUId are both good and dead
				aloftData.unitid = nil
				aloftData.unitguid = nil
				-- ChatFrame7:AddMessage("AloftUnitidData:DisableDataSource(): " .. tostring(aloftData.name))
				self:TriggerEvent("Aloft:OnUnitidDataChanged", aloftData)
			end
		end
	end

	-- this ultimately invokes UpdateData() below, on visible nameplates
	Aloft:DetermineDataSources()

	if updateList then
		for _,aloftData in pairs(updateList) do
			ChatFrame7:AddMessage("AloftUnitidData:OnRosterUpdated(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))
			self:TriggerEvent("Aloft:OnUnitidDataChanged", aloftData)
		end
	end
	]]

	-- ChatFrame7:AddMessage("AloftUnitidData:RosterUpdated(): exit")
end

function AloftUnitidData:DoRosterUpdated()
	-- ChatFrame7:AddMessage("AloftUnitidData:DoRosterUpdated(): invoke")
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:DoUpdateData(aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftUnitidData:UpdateData(aloftData)
	self:DoUpdateData(aloftData)
	--[[
	local eventName = "AloftUnitidData:DoUpdateData:" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.DoUpdateData, 0.0, self, aloftData) -- next frame
	]]
end

function AloftUnitidData:DoUpdateData(aloftData)
	-- ChatFrame7:AddMessage("AloftUnitidData:DoUpdateData(): enter")

	local oldUnitid = aloftData.unitid
	if aloftData.type == "friendlyPlayer" or aloftData.type == "friendlyNPC" then
		local unitid = self:ConvertUnitId(aloftData.name, roster:GetUnitIDFromName(aloftData.name))
		if oldUnitid ~= unitid then
			if unitid then
				aloftData.unitid = unitid
				aloftData.unitguid = UnitGUID(unitid)
				-- ChatFrame7:AddMessage("AloftUnitidData:DoUpdateData(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.unitguid))
			else
				aloftData.unitid = nil
				aloftData.unitguid = nil
				-- ChatFrame7:AddMessage("AloftUnitidData:DoUpdateData(): " .. tostring(aloftData.name))
			end
		end
	else
		aloftData.unitid = nil
		aloftData.unitguid = nil
	end
	if oldUnitid ~= aloftData.unitid then
		self:TriggerEvent("Aloft:OnUnitidDataChanged", aloftData, oldUnitid)
	end
	-- ChatFrame7:AddMessage("AloftUnitidData:DoUpdateData(): exit")
end

-----------------------------------------------------------------------------

function AloftUnitidData:ConvertUnitId(name, unitid)
	-- special handling for the player's own case when named the same as the player; groupmate's pets will have "pet" in the unitid,
	-- players cannot have the same name, and the player him/her-self has no nameplate; the assumption is made that someone else's pet
	-- will not be named the same as the player (i don't know how to handle that case)
	if unitid and name == playerName and not unitid:find("pet") then
		if unitid == "player" then
			-- the ungrouped player, convert to the (only) pet
			return "pet"
		else
			-- a grouped player, convert to the associated pet
			local prefix = unitid:match("%a+")
			local index = unitid:match("%d+")
			return prefix .. "pet" .. index
		end
	end
	return unitid
end

-----------------------------------------------------------------------------
