local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftTargetTrackingData = Aloft:NewModule("TargetTrackingData", "AceEvent-2.0", "AceHook-2.1")

local roster = AceLibrary("Roster-2.1")

-----------------------------------------------------------------------------

AloftTargetTrackingData.db = Aloft:AcquireDBNamespace("targetTracking")
Aloft:RegisterDefaults("targetTracking", "profile", {
	trackUnique	= false,
--[[
	focusEnable		= false,
	focusInterval	= 1.00, -- update group focus once a second (nominally)
]]
})

-----------------------------------------------------------------------------

local profile
local inInstance
local instanceType

local TIMEOUT_INTERVAL = 5.0
local NAMEPLATE_TIMEOUT	= 300.0	--  5 minutes

-- map unitid <> unit GUID for friendly group-members; this can tell us which combat log events to watch for
AloftTargetTrackingData.guidToUnitid = { }
AloftTargetTrackingData.unitidToGUId = { }

-- map nameplateId <> unitid for active group targets with identifiable nameplates
AloftTargetTrackingData.nameplateIdToTargetId = { }
AloftTargetTrackingData.targetIdToNameplateId = { }

-- map GUID to nameplateId for "identifiable" nameplates; these include mouseover targets, and are timed out after a while
AloftTargetTrackingData.targetGUIdToNameplateId = { }
AloftTargetTrackingData.targetGUIdToNameplateTime = { }
AloftTargetTrackingData.nameplateIdToTargetGUId = { }

-- TODO: some sort of tracking by raid assignment, so that if the GUID that owns a raid assignment changes, any old one that is already assigned can be eliminated?
--       not really feasible until RAID_TARGET_UPDATE event carries a raid assignment index; currently, this REQUIRES a mouseover, AFTER the raid target assignment has been made

local UnitName				= UnitName
local UnitRace				= UnitRace
local UnitClass			= UnitClass
local UnitClassification	= UnitClassification
local UnitExists			= UnitExists
local UnitIsDead			= UnitIsDead
local UnitIsFriend			= UnitIsFriend
local UnitLevel			= UnitLevel
local UnitPlayerControlled	= UnitPlayerControlled
local GetRaidTargetIndex	= GetRaidTargetIndex
local IsInInstance			= IsInInstance

-----------------------------------------------------------------------------

function AloftTargetTrackingData:OnInitialize()
	profile = self.db.profile
end

function AloftTargetTrackingData:OnEnable()
	inInstance, instanceType = IsInInstance()
end

function AloftTargetTrackingData:OnDisable()
	self:UnregisterAllEvents()
end

-----------------------------------------------------------------------------

function AloftTargetTrackingData:ProvidesData()
end

function AloftTargetTrackingData:RequiresData()
	self:RegisterEvents()

	-- TODO: add race/class here?
	if Aloft:IsDataAvailable("unitid") then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:RequiresData(): unitid+isTarget")
		return "unitid", "isTarget"
	else
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:RequiresData(): unitid")
		return "isTarget"
	end
end

function AloftTargetTrackingData:EnableDataSource()
end

function AloftTargetTrackingData:RegisterEvents()
	self:UnregisterAllEvents()

	-- ChatFrame7:AddMessage("AloftTargetTrackingData:RegisterEvents(): invoke")

	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnPlayerEnteringWorld")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA","OnPlayerEnteringWorld")
	-- self:RegisterEvent("UNIT_PET", "OnUnitPet")

	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "OnMouseover")
	self:RegisterEvent("RAID_TARGET_UPDATE", "OnRaidTargetUpdate")

	self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
	self:RegisterEvent("Aloft:OnIsFocusDataChanged", "OnIsFocusDataChanged")
	self:RegisterEvent("Aloft:OnUnitTargetDataChanged", "OnUnitTargetDataChanged")
	self:RegisterEvent("Aloft:OnUnitidDataChanged", "OnUnitidDataChanged")

	self:RegisterEvent("RosterLib_RosterUpdated", "OnRosterUpdate")

	-- check for timed-data every 5 seconds or so
	self:ScheduleRepeatingEvent("AloftTargetTrackingData:TimeoutData", self.OnDataTimeout, TIMEOUT_INTERVAL, self)

	--[[
	if profile and profile.focusEnable then
		-- for update of focus targets
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:RegisterEvents(): schedule")
		self:ScheduleRepeatingEvent("AloftTargetTrackingData:CreateGroupFocusTracking", self.CreateGroupFocusTracking, profile.focusInterval, self)
	end
	]]
end

-----------------------------------------------------------------------------

function AloftTargetTrackingData:UpdateAll()
	self:ClearTracking()
	self:CreateTracking()
end

-----------------------------------------------------------------------------

function AloftTargetTrackingData:OnPlayerEnteringWorld()
	self:ClearTracking()
	self:CreateTracking()
end

--[[
function AloftTargetTrackingData:OnUnitPet(unitId)
	if unitId == "player" then
		self:ClearUnitTracking("pet", nil)
		if UnitExists("pet") then
			self:UpdateUnitTracking("pet", nil)
		end
	end
end
]]

function AloftTargetTrackingData:OnRaidTargetUpdate()
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:OnRaidTargetUpdate(): " .. tostring(arg1) .. "/" .. tostring(arg2) .. "/" .. tostring(arg3))
	-- BITCH: the raid assignment index involved here is not provided by the event; makes it difficult to track anything by raid assignment index
	--        currently, this REQUIRES a mouseover, AFTER the raid target assignment has been made
	-- self:ClearTracking()
	-- self:CreateTracking()
end

-- rebuild the target tracking map
function AloftTargetTrackingData:OnRosterUpdate()
	self:ClearTracking()
	self:CreateTracking()
end

-- TODO: is this needed?
function AloftTargetTrackingData:OnIsTargetDataChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:OnIsTargetDataChanged(): enter " ..  tostring(aloftData and aloftData.name))
	self:ScheduleEvent("AloftTargetTrackingData:UpdateTargetData", self.UpdateTargetData, 0.0, self, aloftData) -- next frame
end

function AloftTargetTrackingData:UpdateTargetData(aloftData)
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateTargetData(): enter " ..  tostring(aloftData and aloftData.name))
	-- if aloftData.isTarget or aloftData:IsTarget() then -- we are always interested in changes to the player's target, whether we are acquiring or losing it
		self:TrackUnitTarget("player", aloftData)
	-- end
end

function AloftTargetTrackingData:OnIsFocusDataChanged(aloftData)
	self:ClearUnitFocus("player")
	self:UpdateUnitFocus("player")
end

function AloftTargetTrackingData:OnUnitTargetDataChanged(aloftData, unitid)
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:OnUnitTargetDataChanged(): " ..  tostring(unitid))
	if unitid then
		self:TrackUnitTarget(unitid, aloftData)
	end
end

-- TODO: do we really need to handle this event?
function AloftTargetTrackingData:OnUnitidDataChanged(aloftData)
	self:ClearTracking()
	self:CreateTracking()
end

--[[
function AloftTargetTrackingData:CreateGroupFocusTracking()
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:CreateGroupFocusTracking(): " ..  "enter")
	if roster then
		for unit in roster:IterateRoster(false) do -- no pets for focus
			-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateGroupFocus(): " ..  tostring(unit.unitid))
			self:ClearUnitFocus(unit.unitid)
			self:UpdateUnitFocus(unit.unitid)
		end
	end
end
]]

-----------------------------------------------------------------------------

-- clear the target tracking map
function AloftTargetTrackingData:ClearTracking()
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:ClearTracking(): enter " .. debugstack())
	self:TriggerEvent("AloftTargetTrackingData:OnTargetTrackingDataClearAll")

	-- clean out targetid <> target nameplateid tracking
	for nameplateId in pairs(AloftTargetTrackingData.nameplateIdToTargetId) do
		for targetId in pairs(AloftTargetTrackingData.nameplateIdToTargetId[nameplateId]) do
			AloftTargetTrackingData.nameplateIdToTargetId[nameplateId][targetId] = nil
		end
		AloftTargetTrackingData.nameplateIdToTargetId[nameplateId] = nil
	end
	for targetId in pairs(AloftTargetTrackingData.targetIdToNameplateId) do
		AloftTargetTrackingData.targetIdToNameplateId[targetId] = nil
	end

	-- NOTE: we allow any residual targetGUId <> nameplateId mapping to time out; as long as there is no-one in the group holding the nameplateId as a target...
	--       this is because we cannot track what index is involved in raid target assignments, when they occur, otherwise we could at least clear whatever nameplate is already associated with an index when it is (re)set

	-- clean out GUID <> unitid tracking
	for guid in pairs(self.guidToUnitid) do
		self.guidToUnitid[guid] = nil
	end
	for unitid in pairs(self.unitidToGUId) do
		self.unitidToGUId[unitid] = nil
	end
end

-- build the target tracking map
function AloftTargetTrackingData:CreateTracking()
	-- update venue-based tracking
	self:CreateVenueTracking()

	-- update target tracking for the roster
	if roster then
		for unit in roster:IterateRoster(true) do
			-- ChatFrame7:AddMessage("AloftTargetTrackingData:CreateTracking(): " ..  tostring(unit.unitid))
			self:UpdateUnitTracking(unit.unitid, nil) -- set the unitid's new tracked GUID

			self:TrackUnitTarget(unit.unitid, nil) -- track the unitid's target
		end
	end

	-- clear/update player GUId
	self:ClearUnitTracking("player", nil)
	self:UpdateUnitTracking("player", nil)

	--[[
	self:ClearUnitTracking("pet", nil)
	if UnitExists("pet") then
		self:UpdateUnitTracking("pet", nil)
	end
	]]

	-- update player focus
	self:UpdateUnitFocus("player")
end

function AloftTargetTrackingData:CreateVenueTracking()
	inInstance, instanceType = IsInInstance()
	if inInstance and instanceType == "arena" then
		local unitid
		for i = 1, 5 do
			unitid = "arena" .. i
			if UnitExists(unitid) then
				self:UpdateUnitTracking(unitid, nil)
			end
			unitid = "arenapet" .. i
			if UnitExists(unitid) then
				-- TODO: detect that an opponent has brought out a pet dynamically, and track that?
			end
		end
	end
	-- TODO: what to do if opponents are not loaded yet, and/or are returning "Unknown Entity"? detect via calls to UnitName() and re-loop?
end

-----------------------------------------------------------------------------

-- get a unitid's cached GUID
function AloftTargetTrackingData:GetUnitGUId(unitid)
	--[[
	for k, v in pairs(self.unitidToGUId) do
		ChatFrame7:AddMessage("AloftTargetTrackingData:GetUnitGUId(): content " .. tostring(k) .. "<>" .. tostring(v))
	end
	]]
	if unitid then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:GetUnitGUId(): mapped " .. tostring(unitid) .. "<>" .. tostring(self.unitidToGUId[unitid]))
		return self.unitidToGUId[unitid]
	end
	return nil
end

function AloftTargetTrackingData:GetGUIdUnitid(originGUId)
	--[[
	for k, v in pairs(self.guidToUnitid) do
		ChatFrame7:AddMessage("AloftTargetTrackingData:GetGUIdUnitid(): content " .. tostring(k) .. "<>" .. tostring(v))
	end
	]]
	if originGUId then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:GetGUIdUnitid(): mapped " .. tostring(originGUId) .. "<>" .. tostring(self.guidToUnitid[originGUId]))
		return self.guidToUnitid[originGUId]
	end
	return nil
end

-- get a nameplate's cached GUID
function AloftTargetTrackingData:GetNameplateGUId(nameplateId)
	--[[
	for k, v in pairs(self.nameplateIdToTargetGUId) do
		ChatFrame7:AddMessage("AloftTargetTrackingData:GetNameplateGUId(): content " .. tostring(k) .. "<>" .. tostring(v))
	end
	]]
	if nameplateId then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:GetNameplateGUId(): mapped " .. tostring(nameplateId) .. "<>" .. tostring(self.nameplateIdToTargetGUId[nameplateId]))
		return self.nameplateIdToTargetGUId[nameplateId]
	end
	return nil
end

-- get a GUID's cached nameplate
function AloftTargetTrackingData:GetGUIdNameplateId(targetGUId, diagnostic)
	--[[
	for k, v in pairs(self.targetGUIdToNameplateId) do
		ChatFrame7:AddMessage("AloftTargetTrackingData:GetGUIdNameplateId(): content " .. tostring(k) .. "<>" .. tostring(v))
	end
	]]
	if targetGUId then
		local nameplateId = self.targetGUIdToNameplateId[targetGUId]
		-- if diagnostic then ChatFrame7:AddMessage("AloftTargetTrackingData:GetGUIdNameplateId(): " .. tostring(targetGUId) .. "/" .. tostring(self.targetGUIdToNameplateId[targetGUId]) .. "/" .. tostring(self.targetGUIdToNameplateTime[targetGUId]) .. "/" .. tostring(nameplateId and self.nameplateIdToTargetGUId[nameplateId])) end
		return nameplateId
	else
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:GetGUIdNameplateId(): no targetGUId " .. debugstack())
	end
	return nil
end

-- get the GUId <> nameplateId map
function AloftTargetTrackingData:GetAllGUIdToNameplateId()
	--[[
	for k, v in pairs(self.targetGUIdToNameplateId) do
		ChatFrame7:AddMessage("AloftTargetTrackingData:GetAllGUIdToNameplateId(): content " .. tostring(k) .. "<>" .. tostring(v))
	end
	]]
	return self.targetGUIdToNameplateId
end

-----------------------------------------------------------------------------

-- adjust a unit's target tracking
function AloftTargetTrackingData:TrackUnitTarget(unitid, aloftData)
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:TrackUnitTarget(): enter " .. tostring(unitid) .. "/" .. tostring(aloftData and aloftData.name))
	if unitid then
		-- TODO: clean this up
		if unitid ~= "player" then
			-- ChatFrame7:AddMessage("AloftTargetTrackingData:TrackUnitTarget(): clear/track " .. tostring(unitid) .. " target")
			self:ClearUnitTarget(unitid)
			self:UpdateUnitTarget(unitid) -- this will fail to track a target, if none exists
		else
			-- player has no base unitid
			-- ChatFrame7:AddMessage("AloftTargetTrackingData:TrackUnitTarget(): clear/track player target")
			self:ClearUnitTarget("")
			self:UpdateUnitTarget("") -- this will fail to track a target, if none exists
		end

		if not aloftData then
			if unitid ~= "player" then
				aloftData = Aloft:GetUnitNameplate(unitid)
			else
				aloftData = Aloft:GetTargetNameplate()
			end
		end	
	end

	-- note that in some cases, such as for player primary target changes, this will just filter OnIsTargetDataChanged events through as OnNameplateTrackingDataChanged
	if aloftData then
		self:TriggerEvent("AloftTargetTrackingData:OnNameplateTrackingDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------

-- take the unitid target off of its former nameplate target (if any)
function AloftTargetTrackingData:ClearUnitTarget(unitid)
	self:ClearUnitTracking(unitid, "target")
end

-- put the unitid onto its current target (if any)
-- tracking potentially friendly units with raid icons is OK... we will not bother with updating target names unless the affected nameplate has no unitid/etc
function AloftTargetTrackingData:UpdateUnitTarget(unitid)
	self:UpdateUnitTracking(unitid, "target")
end

-----------------------------------------------------------------------------

-- take the unitid focus off of its former nameplate target (if any)
function AloftTargetTrackingData:ClearUnitFocus(unitid)
	if unitid == "player" then
		self:ClearUnitTracking("", "focus")
	end
end

-- put the unitid onto its current focus (if any)
-- tracking potentially friendly units with raid icons is OK... we will not bother with updating target names unless the affected nameplate has no unitid/etc
function AloftTargetTrackingData:UpdateUnitFocus(unitid)
	if unitid == "player" then
		self:UpdateUnitTracking("", "focus")
	end
end

-----------------------------------------------------------------------------

function AloftTargetTrackingData:ClearGUIdTracking(targetGUId)
	if targetGUId then
		local nameplateId = self.targetGUIdToNameplateId[targetGUId]
		if nameplateId then self.nameplateIdToTargetGUId[nameplateId] = nil end
		self.targetGUIdToNameplateId[targetGUId] = nil
		self.targetGUIdToNameplateTime[targetGUId] = nil
	end
end

-- take the unitid off of its former nameplate target (if any)
function AloftTargetTrackingData:ClearUnitTracking(unitid, suffix)
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:ClearUnitTracking(): " ..  "process " .. tostring(unitid) .. "/" .. tostring(suffix))

	if not unitid then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:ClearUnitTracking(): no " .. tostring(unitid) .. "/" .. tostring(suffix))
		return
	end

	local targetId = unitid .. (suffix or "")
	local nameplateId = AloftTargetTrackingData.targetIdToNameplateId[targetId]

	self:TriggerEvent("AloftTargetTrackingData:OnTargetTrackingDataCleared", targetId, nameplateId)

	if nameplateId then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:ClearUnitTracking(): <<<<< " .. tostring(targetId) .. "/" .. tostring(suffix) .. "/"  ..  tostring(AloftTargetTrackingData.targetIdToNameplateId[targetId]) .. "/" .. tostring(AloftTargetTrackingData.nameplateIdToTargetId[nameplateId][targetId]))
		AloftTargetTrackingData.targetIdToNameplateId[targetId] = nil
		AloftTargetTrackingData.nameplateIdToTargetId[nameplateId][targetId] = nil
		for _ in pairs(AloftTargetTrackingData.nameplateIdToTargetId[nameplateId]) do return end -- stub out if there are still targetid associations
		AloftTargetTrackingData.nameplateIdToTargetId[nameplateId] = nil -- no further targetId associations, nil for garbage recovery
	end

	local targetGUId = UnitGUID(targetId)
	nameplateId = targetGUId and self.targetGUIdToNameplateId[targetGUId]

	if nameplateId then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:ClearUnitTracking(): <<<<< " .. tostring(targetGUId) .. "/" .. tostring(self.targetGUIdToNameplateId[targetGUId]) .. "/" .. tostring(self.targetGUIdToNameplateTime[targetGUId]) .. "/" .. tostring(nameplateId and self.nameplateIdToTargetGUId[nameplateId]) .. "/" .. tostring(targetId))
		self.targetGUIdToNameplateId[targetGUId] = nil
		self.targetGUIdToNameplateTime[targetGUId] = nil
		self.nameplateIdToTargetGUId[nameplateId] = nil
	end

	-- for friendly group-members only
	if not suffix and targetGUId then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:ClearUnitTracking(): clear groupmember " .. "/" .. tostring(targetGUId) .. "/" .. tostring(self.guidToUnitid[targetGUId]) .. "/" .. tostring(targetId) .. "/" .. tostring(self.unitidToGUId[targetId]))
		self.unitidToGUId[targetId] = nil
		self.guidToUnitid[targetGUId] = nil
	end
end

-- put the unitid onto its current target (if any)
-- tracking potentially friendly units with raid icons is OK... we will not bother with updating target names unless the affected nameplate has no unitid/etc
function AloftTargetTrackingData:UpdateUnitTracking(unitid, suffix)
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateUnitTracking(): " ..  "process " .. tostring(unitid) .. "/" .. tostring(suffix))

	if not unitid then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateUnitTracking(): " ..  "no " .. tostring(unitid) .. "/" .. tostring(suffix))
		return
	end

	local targetId = unitid ..  (suffix or "")
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateUnitTracking(): targetId " .. tostring(targetId))

	if not UnitExists(targetId) then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateUnitTracking(): " ..  "not exists " .. tostring(targetId))
		return
	end
	if UnitIsDead(targetId) then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateUnitTracking(): " ..  "dead " .. tostring(targetId))
		return
	end
	--[[
	if UnitIsFriend("player", targetId) then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateUnitTracking(): " ..  "friend " .. tostring(targetId))
		return
	end
	]]
	--[[
	if UnitPlayerControlled(targetId) then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateUnitTracking(): " ..  "player controlled " .. tostring(targetId))
		return
	end
	]]
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateUnitTracking(): " ..  "live/exists " .. tostring(targetId))

	local targetGUId = UnitGUID(targetId)
	self:ClearGUIdTracking(targetGUId)

	local name = UnitName(targetId)
	local race, _ = UnitRace(targetId) -- assuming that if there is a race, the unit name is unique (i.e. a player char)
	local _, class = UnitClass(targetId) -- assuming that if there is a class, the unit name is unique (i.e. a player char)
	local raidTargetIndex = GetRaidTargetIndex(targetId) -- the target is required to have a raid icon assigned
	local isUnique = self:IsUnique(name, UnitClassification(targetId), UnitLevel(targetId))

	-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateUnitTracking(): " .. tostring(targetId) .. "/" .. tostring(race) .. "/" .. tostring(class) .. "/" .. tostring(raidTargetIndex) .. "/" .. tostring(isUnique))
	if targetGUId and ((race and class) or raidTargetIndex or isUnique) then
		local nameplateId
		if race and class then
			nameplateId = self:FormatNameplateId(name, true, nil, nil)
		elseif raidTargetIndex or isUnique then
			nameplateId = self:FormatNameplateId(name, nil, raidTargetIndex, isUnique)
		end

		AloftTargetTrackingData.targetIdToNameplateId[targetId] = nameplateId
		if (not AloftTargetTrackingData.nameplateIdToTargetId[nameplateId]) then AloftTargetTrackingData.nameplateIdToTargetId[nameplateId] = { } end
		AloftTargetTrackingData.nameplateIdToTargetId[nameplateId][targetId] = true
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateUnitTracking(): " .. tostring(unitid) .. "/" .. tostring(suffix) .. "/"  .. tostring(targetId) .. "/"  ..  tostring(self.targetIdToNameplateId[targetId]) .. "/" .. tostring(self.nameplateIdToTargetId[nameplateId][targetId]))

		self.nameplateIdToTargetGUId[nameplateId] = targetGUId
		self.targetGUIdToNameplateId[targetGUId] = nameplateId
		self.targetGUIdToNameplateTime[targetGUId] = GetTime()
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateUnitTracking(): >>>>> " .. tostring(targetGUId) .. "/" .. tostring(self.targetGUIdToNameplateId[targetGUId]) .. "/" .. tostring(self.targetGUIdToNameplateTime[targetGUId]) .. "/"  ..  tostring(nameplate and self.nameplateIdToTargetGUId[nameplateId]) .. "/" .. tostring(name))

		-- ChatFrame7:AddMessage("AloftTargetTrackingData:UpdateUnitTracking(): trigger " .. tostring(unitid) .. "/" .. tostring(suffix) .. "/"  .. tostring(targetId) .. "/" .. tostring(targetGUId))
		self:TriggerEvent("AloftTargetTrackingData:OnTargetTrackingDataUpdated", targetId, nameplateId)
	end

	-- for non-targets/friendly group-members only
	if not suffix then
		self.unitidToGUId[targetId] = targetGUId
		self.guidToUnitid[targetGUId] = targetId
	end
end

--[[
-- put the targetGUId onto its current target (if any)
-- tracking potentially friendly units with raid icons is OK... we will not bother with updating target names unless the affected nameplate has no targetid/etc
function AloftCastWarning:TrackTarget(targetId, nameplateId)
	-- ChatFrame7:AddMessage("AloftCastWarning:TrackTarget(): targetid " .. tostring(targetId))

	local targetGUId = UnitGUID(targetId)
	-- ChatFrame7:AddMessage("AloftCastWarning:TrackTarget(): " .. tostring(targetId) .. "/" .. tostring(targetGUId))
	if targetGUId and nameplateId then
		-- targetGUId<>nameplateId tracking
		self.nameplateIdToTargetGUId[nameplateId] = targetGUId
		self.targetGUIdToNameplateId[targetGUId] = nameplateId
		self.targetGUIdToNameplateTime[targetGUId] = GetTime()
		-- ChatFrame7:AddMessage("AloftCastWarning:TrackTarget(): " ..  .. tostring(targetId) .. "/"  .. tostring(self.nameplateIdToTargetGUId[nameplateId]) .. "/" .. tostring(self.targetGUIdToNameplateId[targetGUId]) .. "/" .. tostring(self.targetGUIdToNameplateTime[targetGUId]))
		-- ChatFrame7:AddMessage("AloftCastWarning:TrackTarget(): " .. tostring(targetId) .. "/"  .. tostring(self.nameplateIdToTargetGUId[nameplateId]) .. "/" .. tostring(self.targetGUIdToNameplateId[targetGUId]) .. "/" .. tostring(self.targetGUIdToNameplateTime[targetGUId]))
	end
	-- local name = UnitName(targetId)
	-- local classification = UnitClassification(targetId)
	-- local creaturetype = UnitCreatureType(targetId)
	-- ChatFrame7:AddMessage("TRACK " .. tostring(targetId)  .. "/" .. tostring(name) .. "/" .. tostring(targetClssfctn) .. "/" .. tostring(creaturetype))
end
]]

-----------------------------------------------------------------------------

-- records targetGUId<>nameplateId tracking on mouseover targets; no targetIds are tracked here, this is just to maximize the targetGUId<>nameplateId tracking space
function AloftTargetTrackingData:OnMouseover()
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:OnMouseover(): invoke")
	if self:VerifyTargetId("mouseover") then
		local targetGUId = UnitGUID("mouseover")
		self:ClearGUIdTracking(targetGUId)

		local name = UnitName("mouseover")
		local race, _ = UnitRace("mouseover")
		local _, class = UnitClass("mouseover")
		local raidTargetIndex = GetRaidTargetIndex("mouseover")
		local isUnique = AloftTargetTrackingData:IsUnique(name, UnitClassification("mouseover"), UnitLevel("mouseover"))

		if targetGUId and ((race and class) or raidTargetIndex or isUnique) then
			local nameplateId
			if race and class then
				nameplateId = AloftTargetTrackingData:FormatNameplateId(name, true, nil, nil)
			elseif raidTargetIndex or isUnique then
				nameplateId = AloftTargetTrackingData:FormatNameplateId(name, nil, raidTargetIndex, isUnique)
			end

			if targetGUId and nameplateId then
				self.targetGUIdToNameplateId[targetGUId] = nameplateId
				self.targetGUIdToNameplateTime[targetGUId] = GetTime()
				self.nameplateIdToTargetGUId[nameplateId] = targetGUId
				-- ChatFrame7:AddMessage("AloftTargetTrackingData:OnMouseover(): >>>>> " .. tostring(targetGUId) .. "/" .. tostring(self.targetGUIdToNameplateId[targetGUId]) .. "/" .. tostring(self.targetGUIdToNameplateTime[targetGUId]) .. "/" .. tostring(self.nameplateIdToTargetGUId[nameplateId]) .. "/" .. tostring(name))
			else
				-- ChatFrame7:AddMessage("AloftTargetTrackingData:OnMouseover(): no " .. tostring(name) .. "/" .. tostring(nameplateId) .. "/" .. tostring(targetGUId))
			end
		end
	else
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:OnMouseover(): invalid target")
	end
end
-- TODO: use unit tracking methods that already exist

function AloftTargetTrackingData:VerifyTargetId(targetId)
	if not UnitExists(targetId) then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:VerifyTargetId(): non-existent " .. tostring(targetId))
		return nil
	end
	if UnitIsDead(targetId) then
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:VerifyTargetId(): is dead " .. tostring(targetId))
		return nil
	end
	return true
end

function AloftTargetTrackingData:OnDataTimeout()
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:OnDataTimeout(): enter")

	-- current time
	local now = GetTime()

	-- time out old targetGUId<>nameplateId tracking, as long as there are no groupmembers currently holding target on the nameplateId
	for targetGUId, nameplateId in pairs(self.targetGUIdToNameplateId) do
		if not AloftTargetTrackingData.nameplateIdToTargetId[nameplateId] then
			local trackTime = self.targetGUIdToNameplateTime[targetGUId]
			if trackTime and (trackTime + (NAMEPLATE_TIMEOUT * 1000)) <= now then
				-- ChatFrame7:AddMessage("AloftTargetTrackingData:OnDataTimeout(): <<<<< " .. tostring(self.nameplateIdToTargetGUId[nameplateId]) .. "/" .. tostring(self.targetGUIdToNameplateId[targetGUId]) .. "/" .. tostring(self.targetGUIdToNameplateTime[targetGUId]))
				self.targetGUIdToNameplateId[targetGUId] = nil
				self.targetGUIdToNameplateTime[targetGUId] = nil
				self.nameplateIdToTargetGUId[nameplateId] = nil
				-- TODO: flag these timeouts to chat
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftTargetTrackingData:IsTargetIdToNameplateIdTracking()
	for k in pairs(AloftTargetTrackingData.targetIdToNameplateId) do
		-- ChatFrame7:AddMessage("AloftTargetTrackingData:IsTargetIdToNameplateIdTracking(): TGTGT " .. tostring(k) .. " has target " .. tostring(AloftTargetTrackingData.targetIdToNameplateId[k]))
		if k then return true end -- there is tracking
	end
	return false -- there is no tracking
end

-- construct a nameplate id from a nameplate
function AloftTargetTrackingData:GetNameplateId(aloftData)
	if ((aloftData.type == "hostilePlayer" or aloftData.type == "hostile") and ((aloftData.class and aloftData.race) or (Aloft.showClassColorInVKey and Aloft:GetClassByColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB)))) or aloftData.type == "friendlyPlayer" then
		--[[
		ChatFrame7:AddMessage("AloftTargetTrackingData:GetNameplateId(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(aloftData.race) .. "/" .. tostring(aloftData.class))
		local color = Aloft:GetClassByColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB)
		if color then
			ChatFrame7:AddMessage("AloftTargetTrackingData:GetNameplateId(): " .. tostring(color[1]) .. "-" .. tostring(color[2]) .. "-" .. tostring(color[3])
			.. "/" .. floor(255*color[1]) .. "." .. floor(255*color[2]) .. "." .. floor(255*color[3])
			.. "/" .. ("|cff%02x%02x%02xcolor|r"):format(floor(255*color[1]), floor(255*color[2]), floor(255*color[3])))
		end
		]]

		-- this is a player
		return self:FormatNameplateId(aloftData.name, true, nil, nil)
	else
		local raidIconRegion = aloftData.raidIconRegion
		local raidIconIndex = (raidIconRegion:IsShown() and self:GetRaidIconIndex(raidIconRegion)) or nil
		local isUnique = self:IsUnique(aloftData.name, aloftData.classification, aloftData.level)

		-- ChatFrame7:AddMessage("AloftTargetTrackingData:GetNameplateId(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(raidIconIndex) .. "/" .. tostring(isUnique))

		-- this is uniquely identifiable
		return self:FormatNameplateId(aloftData.name, nil, raidIconIndex, isUnique)
	end

	-- none of the above
	return nil
	-- TODO: fix this if/else logic, this determination is not made here anyway
end

-- construct a nameplate id from a "target" unitId
function AloftTargetTrackingData:CreateTargetNameplateId(targetId)
	if targetId and UnitExists(targetId) then
		local name, _ = UnitName(targetId)
		local _, class = UnitClass(targetId)
		local race, _ = UnitRace(targetId)
		if class and race then
			-- this is a player
			return self:FormatNameplateId(name, true, nil, nil)
		else
			local classification = UnitClassification(targetId)
			local level = UnitLevel(targetId) or -1
			local raidIconIndex = GetRaidTargetIndex(targetId)
			local isUnique = self:IsUnique(name, classification, level)

			-- ChatFrame7:AddMessage("AloftTargetTrackingData:CreateTargetNameplateId(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(raidIconIndex) .. "/" .. tostring(isUnique))

			-- this is uniquely identifiable
			return self:FormatNameplateId(name, nil, raidIconIndex, isUnique)
		end
	end

	-- none of the above
	return nil
	-- TODO: fix this if/else logic, this determination is not made here anyway
end

--[[
-- construct a nameplate id from a nameplate
function AloftTargetTrackingData:GetNameplateId(aloftData)
	-- TODO: add boss icon?
	-- TODO: can we detect the combination of rare and elite?
	local race = aloftData.race -- assuming that if there is a race, the unit name is unique (i.e. a player char)
	local class = aloftData.class -- assuming that if there is a class, the unit name is unique (i.e. a player char)
	local raidIconRegion = aloftData.raidIconRegion
	local raidIconIndex = (raidIconRegion:IsShown() and self:GetRaidIconIndex(raidIconRegion)) or nil
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:GetNameplateId(): " .. tostring(aloftData.name) .. "/" .. tostring(race) .. "/" .. tostring(class) .. "/" .. tostring(raidIconIndex))

	return self:FormatNameplateId(aloftData.name, raidIconIndex, race, class)
end
]]

-- construct a nameplate id from a set of parameters
function AloftTargetTrackingData:FormatNameplateId(name, player, raidIconIndex, unique)
	if player then
		return name
	elseif raidIconIndex or unique then -- must be uniquely identifiable
		return name .. ((raidIconIndex and ("-" .. tostring(raidIconIndex))) or "") .. ((unique and ("-Unique")) or "")
	end
	return nil
end

--[[
-- construct a nameplate id from a set of parameters
function AloftTargetTrackingData:FormatNameplateId(name, raidIconIndex, race, class)
	if (race and class) or raidIconIndex then
		local nameplateId = name ..
			((raidIconIndex and ("-" .. tostring(raidIconIndex))) or "") ..
			(((race and class) and ("-" .. tostring(race) .. "-" .. tostring(class))) or "")
		return nameplateId
	end
	return nil
end
]]

-- NOTE: this is pretty kludgy; where these icons appear in Blizzard's texture file is an internal detail, and could change w/o warning
function AloftTargetTrackingData:GetRaidIconIndex(raidIconRegion)
	local left, right, top, bottom = raidIconRegion:GetTexCoord()
	index = ((right / 0.25) * 4) + (left / 0.25) + 1 -- offsets within the Blizzard texture file, empirically reverse engineered via Texture:GetTexCoord()
	return index
end

function AloftTargetTrackingData:IsUnique(name, classification, level)
	-- ChatFrame7:AddMessage("AloftTargetTrackingData:IsUnique(): " .. tostring(name) .. "/" .. tostring(classification) .. "/" .. tostring(level) .. "|" .. tostring(profile.trackUniqueElite) .. "/" .. tostring(inInstance) .. "/" .. tostring(((profile.trackUniqueElite and ((inInstance and classification == "elite" and (not level or level < 0)) or classification == "rareelite" or classification == "rare" or classification == "worldboss") and name ~= "[invalid]") and true) or nil))
	return ((profile.trackUniqueElite and ((inInstance and classification == "elite" and (not level or level < 0)) or classification == "rareelite" or classification == "rare" or classification == "worldboss") and name ~= "[invalid]") and true) or nil
end

--[[ raid icon offsets as of WoW 3.0.2, 2008/10/22
1/0.00/0.00/0.00/0.25
2/0.25/0.00/0.25/0.25
3/0.50/0.00/0.50/0.25
4/0.75/0.00/0.75/0.25
5/0.00/0.25/0.00/0.50
6/0.25/0.25/0.25/0.50
7/0.50/0.25/0.50/0.50
8/0.75/0.25/0.75/0.50
]]

-----------------------------------------------------------------------------
