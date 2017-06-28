local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftRoster = Aloft:GetModule("Roster") -- always on
if not AloftRoster then return end

local AloftUnitidData = Aloft:NewModule("UnitidData", Aloft, "AceEvent-3.0", "AceTimer-3.0")

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
	self.initialized = true
end

function AloftUnitidData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftUnitidData:OnEnable(): enter")
	self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")

	if AloftRoster then
		self:RegisterMessage("AloftRoster_RosterUpdated", "OnRosterUpdated")
	end
	-- ChatFrame7:AddMessage("AloftUnitidData:OnEnable(): exit")
end

function AloftUnitidData:OnDisable()
	-- ChatFrame7:AddMessage("AloftUnitidData:OnDisable(): enter")
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
	-- ChatFrame7:AddMessage("AloftUnitidData:OnDisable(): exit")
end

function AloftUnitidData:EnableDataSource()
	-- ChatFrame7:AddMessage("AloftUnitidData:EnableDataSource(): enter")
	-- ChatFrame7:AddMessage("AloftUnitidData:EnableDataSource(): exit")
end

-- this data source overrides DisableDataSource because we still want RosterUpdated events to be caught even if this data source isn't used at the moment
function AloftUnitidData:DisableDataSource()
	-- ChatFrame7:AddMessage("AloftUnitidData:DisableDataSource(): enter")
	self:RemoveAloftData("unitid")
	-- ChatFrame7:AddMessage("AloftUnitidData:DisableDataSource(): exit")
end

function AloftUnitidData:OnNameplateShow(message, aloftData)
	self:DoUpdateData(aloftData)
end

function AloftUnitidData:OnNameplateHide(message, aloftData)
	aloftData.unitid = nil
	aloftData.unitguid = nil
end

function AloftUnitidData:OnRosterUpdated(message)
	-- ChatFrame7:AddMessage("AloftUnitidData:RosterUpdated(): enter")

	self:ScheduleTimer(function() AloftUnitidData:DoRosterUpdated() end, 0.0) -- next frame

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
end

function AloftUnitidData:DoUpdateData(aloftData)
	-- ChatFrame7:AddMessage("AloftUnitidData:DoUpdateData(): enter")

	local oldUnitid = aloftData.unitid
	if aloftData.type == "friendlyPlayer" or aloftData.type == "friendlyNPC" then
		local unitid = self:ConvertUnitId(aloftData.name, AloftRoster and AloftRoster:GetUnitIDFromName(aloftData.name))
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
		self:SendMessage("Aloft:OnUnitidDataChanged", aloftData, oldUnitid)
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
