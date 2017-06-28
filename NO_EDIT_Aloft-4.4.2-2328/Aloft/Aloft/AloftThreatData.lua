local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftThreatData
if not L then return end

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData", true)
if not AloftTargetTrackingData then return end

local AloftThreatData = Aloft:NewModule("ThreatData", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftThreatData.dynamic = "AloftThreat"

-----------------------------------------------------------------------------

AloftThreatData.namespace = "threatData"
AloftThreatData.defaults =
{
	profile =
	{
		AOEEnable	= false,	-- approximate AOE threat
		groupEnable	= false,	-- approximate group threat
		interval	= 0.33,		-- update AOE/group threat 3 times a second, as driven by target threat events
	},
}

-----------------------------------------------------------------------------

local targetGUId

-- TODO: must match similar string in ThreatBar.lua and in localization LUA; TODO: fix this, make it centrally sourced
-- threat types
local THREAT_RANGED	= "Ranged"
local THREAT_MELEE		= "Melee"
local THREAT_TANK		= "Tank"
local THREAT_GROUP		= "Group"

local SHORT_THREAT_TYPES = {
	[THREAT_RANGED]		= "R",
	[THREAT_MELEE]		= "M",
	[THREAT_TANK]		= "K",
	[THREAT_GROUP]		= "G",
}

local math_floor = _G.math.floor

local GetTime= GetTime
local CheckInteractDistance = CheckInteractDistance
local UnitGUID = UnitGUID
local UnitExists = UnitExists
local UnitIsDead = UnitIsDead
local UnitCanAttack = UnitCanAttack
local UnitIsFriend = UnitIsFriend
local UnitPlayerControlled = UnitPlayerControlled
local UnitIsVisible = UnitIsVisible
local UnitThreatSituation = UnitThreatSituation
local UnitDetailedThreatSituation = UnitDetailedThreatSituation

-----------------------------------------------------------------------------

-----------------------------------------------------------------------------

Aloft.TagData.ThreatStatus =
{
	data = "threatStatus",
	events = "Aloft:OnThreatDataChanged",
	tableData = "threatStatus",
	numeric = true
}

Aloft.TagData.Threat =
{
	data = "threat",
	events = "Aloft:OnThreatDataChanged",
	tableData = "threat",
	numeric = true
}

-- the tank's threat (including when the player is the tank), adjusted for inflation
Aloft.TagData.MaxThreat =
{
	data = "maxThreat",
	events = "Aloft:OnThreatDataChanged",
	tableData = "maxThreat",
	numeric = true
}

-- the threat to exceed in order to steal aggro, depending on who you are
Aloft.TagData.MaxThreatGain =
{
	data = "maxThreatGain",
	events = "Aloft:OnThreatDataChanged",
	tableData = "maxThreatGain",
	numeric = true
}

-- the relationship (ration) between MaxThreat and MaxThreatGain (the multiplier used)
Aloft.TagData.ThreatMulti =
{
	data = "threatMulti",
	events = "Aloft:OnThreatDataChanged",
	tableData = "threatMulti",
	numeric = true
}

Aloft.TagData.ThreatDeficit =
{
	data = "threatDeficit",
	events = "Aloft:OnThreatDataChanged",
	tableData = "threatDeficit",
	numeric = true
}

Aloft.TagData.ThreatFraction =
{
	data = "threatFraction",
	events = "Aloft:OnThreatDataChanged",
	tableData = "threatFraction",
	numeric = true
}

Aloft.TagData.ThreatType =
{
	data = "threatType",
	events = "Aloft:OnThreatDataChanged",
	tableData = "threatType",
}

Aloft.TagData.ShortThreatType =
{
	data = "shortThreatType",
	events = "Aloft:OnThreatDataChanged",
	tableData = "shortThreatType",
}

-----------------------------------------------------------------------------

function AloftThreatData:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftThreatData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	if Aloft.Options.args.threatBar and Aloft.Options.args.threatBar.args then
		Aloft.Options.args.threatBar.args.AOEEnable = AloftThreatData.options.AOEEnable
		Aloft.Options.args.threatBar.args.groupEnable = AloftThreatData.options.groupEnable
		Aloft.Options.args.threatBar.args.interval = AloftThreatData.options.interval
	end
end

function AloftThreatData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftThreatData:ProvidesData()
	-- ChatFrame7:AddMessage("AloftThreatData:ProvidesData(): invoke")
	return "threat", "maxThreat", "maxThreatGain", "threatMulti", "threatDeficit", "threatFraction", "threatType", "shortThreatType"
end

function AloftThreatData:RequiresData()
	-- ChatFrame7:AddMessage("AloftThreatData:RequiresData(): invoke")
	-- NOTE: data is always collected, for all viable unitids (including pets and guardians); whether this is active is a function of if the threat bar/threat text modules
	return "unitid", "isTarget"
end

function AloftThreatData:EnableDataSource()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	-- ChatFrame7:AddMessage("AloftThreatData:EnableDataSource(): enter")

	-- TODO: set threat bar/text self.db.profile.enable flag to false

	-- ChatFrame7:AddMessage("AloftThreatData:EnableDataSource(): register native events")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "OnPlayerTargetChanged") -- threat needs this event directly, to make sure target GUID caching is done properly

	-- ChatFrame7:AddMessage("AloftThreatData:EnableDataSource(): register threat events")
	self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", "OnUnitThreatListUpdate")
	self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", "OnUnitThreatSituationUpdate")

	-- ChatFrame7:AddMessage("AloftThreatData:EnableDataSource(): register Aloft events")
	self:RegisterMessage("Aloft:OnUnitidDataChanged", "OnUnitidDataChanged")
	self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
	self:RegisterMessage("Aloft:OnUnitTargetDataChanged", "OnUnitTargetDataChanged")
	-- TODO: make active while solo an option, or like omen: options for solo, battlegrounds, instances, and etc; for threat on pets

	self:RegisterMessage("Aloft:OnConfigModeChanged", "OnConfigModeChanged")

	local enable = ((Aloft:GetModule("ThreatBar", true) and Aloft:GetModule("ThreatBar").db.profile.enable) or
					    (Aloft:GetModule("ThreatText", true) and Aloft:GetModule("ThreatText").db.profile.enable)) and
						(self.db.profile and (self.db.profile.AOEEnable or self.db.profile.groupEnable))
	if enable then
		-- for update of target-of-target data on hostile nameplates
		-- ChatFrame7:AddMessage("AloftThreatData:EnableDataSource(): schedule")
		self:ScheduleRepeatingTimer(function() AloftThreatData:ProcessNonTargetThreatList() end, self.db.profile.interval)
	end

	-- ChatFrame7:AddMessage("AloftThreatData:EnableDataSource(): exit")
end

function AloftThreatData:DisableDataSource()
	-- ChatFrame7:AddMessage("AloftThreatData:DisableDataSource(): enter")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
	-- ChatFrame7:AddMessage("AloftThreatData:DisableDataSource(): all events unregistered")

	-- ChatFrame7:AddMessage("AloftThreatData:DisableDataSource(): exit")
end

-- local cache of the target's GUID (if any); this value is event-driven and managed by the method AloftThreatData:OnIsTargetDataChanged()
function AloftThreatData:GetTargetGUId()
	if not targetGUId then targetGUId = UnitGUID("target") end
	return targetGUId
end

-----------------------------------------------------------------------------

function AloftThreatData:OnPlayerTargetChanged(event)
	-- ChatFrame7:AddMessage("AloftThreatData():OnPlayerTargetChanged(): enter")

	-- zap the cache
	targetGUId = nil

	-- update AOE/Group threat
	AloftThreatData:ProcessNonTargetThreatList()

	-- ChatFrame7:AddMessage("AloftThreatData:OnPlayerTargetChanged(): exit")
end

function AloftThreatData:OnUnitThreatListUpdate(event, targetId)
	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatListUpdate(): enter")

	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatListUpdate(): targetId " .. (targetId or "<NOTARGET>"))
	if (targetId == nil) or (targetId ~= "target") then
		-- this is not an interesting event
		-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatListUpdate(): no targetId " .. tostring(targetId))
		return
	end

	local targetGUId = UnitGUID(targetId) -- TODO: redundant, given the preceeding check
	if (targetGUId == nil) or (targetGUId ~= self:GetTargetGUId()) then
		-- this is not an interesting event
		-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatListUpdate(): threat event not relevant to current target " .. tostring(targetId))
		return
	end

	-- insure that we have a ameplate
	aloftData = Aloft:GetTargetNameplate()
	if not aloftData then
		-- a nameplate icould not be found
		-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatListUpdate(): threat event could not recover Aloft nameplate " .. tostring(targetId))
		return
	end

	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatListUpdate(): clear threat")
	self:ClearThreatData(aloftData)

	local tgtgtGUId = UnitGUID("targettarget")

	-- update threat for discovered grouped/player unit nameplate against target
	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatListUpdate(): update nameplate")
	local maxThreat = self:ProcessThreatUpdate(aloftData, "player", Aloft:GetPlayerGUId(), targetId, targetGUId, tgtgtGUId, nil)

	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatListUpdate(): trigger " .. tostring(aloftData.name))
	self:SendMessage("Aloft:OnThreatDataChanged", aloftData)

	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatListUpdate(): exit")
end

-- we use this as a "threat clear" event; it seems to fire at the beginning and end of combat
function AloftThreatData:OnUnitThreatSituationUpdate(event, unitid)
	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatSituationUpdate(): " .. enter")

	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatSituationUpdate(): unitid " .. (unitid or "<NOTARGET>"))
	if (unitid == nil) or (unitid == "player") then
		-- this is not an interesting event
		-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatSituationUpdate(): no unitid " .. tostring(unitid))
		return
	end
	-- TODO: use these events anyway, as a means of ticking over threat more often?

	-- insure that we have a nameplate
	aloftData = Aloft:GetUnitNameplate(unitid)
	if not aloftData then
		-- a nameplate icould not be found
		-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatSituationUpdate(): threat event could not recover Aloft nameplate " .. tostring(unitid))
		return
	end

	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatSituationUpdate(): clear " .. aloftData.name .. "/" .. originId)
	self:ClearThreatData(aloftData)

	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatSituationUpdate(): trigger " .. tostring(aloftData.name))
	self:SendMessage("Aloft:OnThreatDataChanged", aloftData)

	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitThreatSituationUpdate(): exit")
end

-----------------------------------------------------------------------------

function AloftThreatData:OnUnitidDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitidDataChanged(): enter")

	self:UpdateThreatData(aloftData)

	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitidDataChanged(): exit")
end

function AloftThreatData:OnIsTargetDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftThreatData:OnIsTargetDataChanged(): enter")

	self:UpdateThreatData(aloftData)

	-- ChatFrame7:AddMessage("AloftThreatData:OnIsTargetDataChanged(): exit")
end

function AloftThreatData:OnUnitTargetDataChanged(message, aloftData, unitid)
	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitTargetDataChanged(): enter")

	self:UpdateThreatData(aloftData)

	-- ChatFrame7:AddMessage("AloftThreatData:OnUnitTargetDataChanged(): exit")
end

function AloftThreatData:OnConfigModeChanged(message)
	-- ChatFrame7:AddMessage("AloftThreatData:OnConfigModeChanged(): update threat")
	self:UpdateThreatData(Aloft:GetTargetNameplate())
end

-----------------------------------------------------------------------------

function AloftThreatData:UpdateData(aloftData)
	-- ChatFrame7:AddMessage("AloftThreatData:UpdateData(): enter")

	self:UpdateThreatData(aloftData)

	-- ChatFrame7:AddMessage("AloftThreatData:UpdateData(): exit")
end

function AloftThreatData:UpdateThreatData(aloftData)
	-- ChatFrame7:AddMessage("AloftThreatData:UpdateThreatData(): enter")

	-- stub out if this event is for a nameplate that cannot currently be found (could be turned off or out of range)
	local force = false
	if aloftData then
		local update = false
		local maxThreat = 0
		local isTarget = aloftData.isTarget or aloftData:IsTarget()
		local unitid = aloftData.unitid
		local unitGUId = aloftData.unitguid
		local targetGUId = self:GetTargetGUId()
		local tgtgtGUId = UnitGUID("targettarget")

		-- ChatFrame7:AddMessage("AloftThreatData:UpdateThreatData(): clear nameplate " .. tostring(aloftData.name))
		self:ClearThreatData(aloftData)

		-- ChatFrame7:AddMessage("AloftThreatData:UpdateThreatData(): update nameplate threat")
		if isTarget then
			local playerGUId = Aloft:GetPlayerGUId()
			if Aloft:IsConfigModeEnabled() then
				local AloftThreatBar = Aloft:GetModule("ThreatBar", true)
				local AloftThreatBarProfile = AloftThreatBar and AloftThreatBar.db and AloftThreatBar.db.profile
	
				maxThreat = 234567
				local threat = (AloftThreatBarProfile and AloftThreatBarProfile.flashEnable and ((AloftThreatBarProfile.flashThreshold + 0.1) / 100) * maxThreat) or 123456

				local threatType, threatMulti = self:GetThreatType(playerGUId, "target", tgtgtGUId)

				self:SetThreatData(aloftData, 2, threat, maxThreat, threatMulti, threatType)
				-- ChatFrame7:AddMessage("AloftThreatData:UpdateThreatData(): CONFIG " .. tostring(unitid) .. "/"  .. (unitGUId or "") .. "/".. aloftData.name .. "/".. aloftData.threatType .. "/" .. aloftData.threatMulti)
			else
				-- ChatFrame7:AddMessage("AloftThreatData:UpdateThreatData(): update target nameplate " .. tostring(aloftData.name) )
				maxThreat = self:ProcessThreatUpdate(aloftData, "player", playerGUId, "target", targetGUId, tgtgtGUId, nil)
				-- if maxThreat then ChatFrame7:AddMessage("AloftThreatData:UpdateThreatData(): " .. "player/" .. "/"  .. (playerGUId or "") .. aloftData.name .. "/".. aloftData.threatType .. "/" .. aloftData.threatMulti) end
			end
		elseif unitid and unitGUId then
			-- ChatFrame7:AddMessage("AloftThreatData:UpdateThreatData(): update friendly grouped nameplate " .. tostring(aloftData.name) .. "/" .. tostring(unitid) .. "/" .. tostring(unitGUId))
			maxThreat = self:ProcessThreatUpdate(aloftData, unitid, unitGUId, "target", targetGUId, tgtgtGUId, nil)
			-- if maxThreat then ChatFrame7:AddMessage("AloftThreatData:UpdateThreatData(): " .. unitid .. "/"  .. (unitGUId or "") .. "/".. aloftData.name .. "/".. aloftData.threatType .. "/" .. aloftData.threatMulti) end
		else
			-- ChatFrame7:AddMessage("AloftThreatData:UpdateThreatData(): " ..  "leave clear " .. tostring(aloftData.name))
			force = true -- we are losing our target here, force all threat display to go away
		end

		-- ChatFrame7:AddMessage("AloftThreatData:UpdateThreatData(): trigger " .. tostring(aloftData.name))
		self:SendMessage("Aloft:OnThreatDataChanged", aloftData)
	end

	-- ChatFrame7:AddMessage("AloftThreatData:UpdateThreatData(): exit")
end

-----------------------------------------------------------------------------

function AloftThreatData:ProcessThreatUpdate(aloftData, originId, originGUId, targetId, targetGUId, tgtgtGUId, threat)
	-- ChatFrame7:AddMessage("AloftThreatData:ProcessThreatUpdate(): enter; target unit <" .. targetId .. ">")
	if not (targetId and targetGUId) then
		-- ChatFrame7:AddMessage("AloftThreatData:ProcessThreatUpdate(): no targetId/targetGUId " .. tostring(targetId) .. "/" .. tostring(targetGUId))
		return nil
	end

	if not self:ValidateThreatUpdate(originId, originGUId, targetId, targetGUID) then
		-- ChatFrame7:AddMessage("AloftThreatData:ProcessThreatUpdate(): invalid update")
		return
	end

	local maxThreat

	-- construct threat data for this nameplate, usingargument unitids
	-- Aloft:DumpNameplateHeirarchy(aloftData)
	local isTanking, status, scaledPercent, rawPercent, threatValue = UnitDetailedThreatSituation(originId, targetId)
	-- ChatFrame7:AddMessage("AloftThreatData:ProcessThreatUpdate(): " .. tostring(aloftData.name) .. "/" .. tostring(originId) .. "/" .. tostring(targetId) .. " UnitDetailedThreatSituation " .. "/" .. tostring(isTanking) .. "/" .. tostring(state) .. "/" .. tostring(scaledPercent) .. "/" .. tostring(rawPercent) .. "/" .. tostring(threatValue))

	if threatValue then
		-- Blizzard's native threat API does not supply an absolute maximum amount of threat; it has to be calculated
		-- we conform to the generic pattern of Threat-2.0 here: threat, maxThreat, a threat gain multiplier, and whether or not the player is "targettarget"
		maxThreat = ((isTanking) and
			((scaledPercent) and ((100.0 / scaledPercent) * threatValue) or 0)) or -- rawPercent goes to 255 for the tank?
			((rawPercent) and ((100.0 / rawPercent) * threatValue) or 0)
		threat = threatValue
		-- if threat and maxThreat and threat > maxThreat then maxThreat = threat end -- normalize, so we can't go over 100%? apparently no longer necessary on WoW 3.0.2+ live
		-- ChatFrame7:AddMessage("AloftThreatData:ProcessThreatUpdate(): " .. originId .. "/" .. targetId .. "/" .. threat)
		-- TODO: check threat/maxThreat for 0 here? skip if 0? threat bar only needed if threat/threatMax > 0?

		local threatType, threatMulti = self:GetThreatType(originGUId, targetId, tgtgtGUId)
		-- ChatFrame7:AddMessage("AloftThreatData:ProcessThreatUpdate(): " ..  tostring(aloftData.name) .. "/" .. tostring(originId) .. "/" .. tostring(targetId) .. " Derived " .. tostring(maxThreat) .. "/" .. tostring(threat) .. "/" .. tostring(math_floor((maxThreat * threatMulti) + 0.5)))

		-- ChatFrame7:AddMessage("AloftThreatData:ProcessThreatUpdate(): update nameplate")
		self:SetThreatData(aloftData, status, threat, maxThreat, threatMulti, threatType)
	end

	-- ChatFrame7:AddMessage("AloftThreatData:ProcessThreatUpdate(): exit")
	return maxThreat
end

-- processes threat not involving the current target (we receive UI events for the current target)
function AloftThreatData:ProcessNonTargetThreatList()
	-- ChatFrame7:AddMessage("AloftThreatData:ProcessNonTargetThreatList: enter")

	local targetNameplate = Aloft:GetTargetNameplate()
	local targetTracking = AloftTargetTrackingData:IsTargetIdToNameplateIdTracking()

	-- ChatFrame7:AddMessage("AloftThreatData:ProcessNonTargetThreatList: perform nameplate threat updates")
	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData ~= targetNameplate and not (aloftData.isTarget or aloftData:IsTarget()) then -- trust threat events to deliver threat for the player's current target
			local trigger = (aloftData.maxThreat and aloftData.maxThreat > 0 and true) or nil

			-- ChatFrame7:AddMessage("AloftThreatData:ProcessNonTargetThreatList: clear nameplate " .. tostring(aloftData.name))
			self:ClearThreatData(aloftData)

			local originId = aloftData.unitid
			local targetGUId = self:GetTargetGUId()
			-- ChatFrame7:AddMessage("AloftThreatData:ProcessNonTargetThreatList: nameplate " .. tostring(aloftData.name) .. "/" .. tostring(originId) .. "/" .. tostring(aloftData.unitguid) .. "/" .. tostring(targetGUId) .. "/" .. tostring(trigger))

			if self.db.profile.groupEnable and originId and targetGUId and (aloftData.type == "friendlyPlayer" or aloftData.type == "friendlyNPC") then -- friendly/groupmember threat versus player's active target
				local originGUId = aloftData.unitguid

				-- ChatFrame7:AddMessage("AloftThreatData:ProcessNonTargetThreatList(): friendly " .. tostring(aloftData.name) .. "/" .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(targetGUId))
				if originId and originGUId and self:ProcessNonTargetThreat(aloftData, originId, originGUId, "target", targetGUId) then
					trigger = true
				end
			elseif self.db.profile.AOEEnable and targetTracking and (aloftData.type == "hostilePlayer" or aloftData.type == "hostile" or aloftData.type == "neutral") then -- hostile/AOE threat versus player, if we have targets tracked
				local nameplateId = AloftTargetTrackingData:GetNameplateId(aloftData)

				if nameplateId and AloftTargetTrackingData.nameplateIdToTargetId[nameplateId] then
					for proxyTargetId in pairs(AloftTargetTrackingData.nameplateIdToTargetId[nameplateId]) do
						local proxyTargetGUId = (proxyTargetId and UnitGUID(proxyTargetId)) or nil

						-- ChatFrame7:AddMessage("AloftThreatData:ProcessNonTargetThreatList(): hostile " .. tostring(aloftData.name) .. "/" .. tostring(proxyTargetId) .. "/" .. tostring(proxyTargetGUId) .. "/" .. tostring(nameplateId))
						if proxyTargetId and proxyTargetGUId and self:ProcessNonTargetThreat(aloftData, "player", Aloft:GetPlayerGUId(), proxyTargetId, proxyTargetGUId) then
							trigger = true
						end
						break -- skip out of the unitid loop; only one friendly groupmember is needed to construct a target name
					end
				end
			end

			if trigger then
				-- ChatFrame7:AddMessage("AloftThreatData:ProcessNonTargetThreatList(): trigger " .. tostring(aloftData.name))
				self:SendMessage("Aloft:OnThreatDataChanged", aloftData)
			end
		end
	end

	-- ChatFrame7:AddMessage("AloftThreatData:ProcessNonTargetThreatList(): exit")
end

function AloftThreatData:ProcessNonTargetThreat(aloftData, originId, originGUId, targetId, targetGUId)
	local tgtgtGUId = (targetId and UnitGUID(targetId .. "target")) or nil
	local maxThreat = self:ProcessThreatUpdate(aloftData, originId, originGUId, targetId, targetGUId, tgtgtGUId, nil)
	-- ChatFrame7:AddMessage("AloftThreatData:ProcessNonTargetThreatList(): results " .. tostring(aloftData.name) .. "/" .. tostring(tgtgtGUId) .. "/" .. tostring(maxThreat))

	if maxThreat and maxThreat > 0 then return true end
	return nil
end

-----------------------------------------------------------------------------

-- generalized so that we can call it on "origin" and "target" unitids of all sorts (including groupmember unitids, and groupmember targets)
function AloftThreatData:ValidateThreatUpdate(originId, originGUId, targetId, targetGUID)
	-- ChatFrame7:AddMessage("AloftThreatData:ValidateThreatUpdate(): validate update " .. tostring(originId) .. "/" .. tostring(targetId))
	local status = UnitThreatSituation(originId, targetId) -- changed semantics in 3.1, now "0" is a valid return, indicating "not tanking"/"normal threat"
	if not status then
		-- ChatFrame7:AddMessage("AloftThreatData:ValidateThreatUpdate(): invalid update, threat is not active " .. tostring(originId) .. "/" .. tostring(targetId) .. "/" .. tostring(status))
		return false
	elseif not UnitExists(targetId) then
		-- ChatFrame7:AddMessage("AloftThreatData:ValidateThreatUpdate(): invalid update, target unit does not exist " .. tostring(originId) .. "/" .. tostring(targetId))
		return false
	elseif UnitIsDead(targetId) then
		-- ChatFrame7:AddMessage("AloftThreatData:ValidateThreatUpdate(): invalid update, target unit is dead " .. tostring(originId) .. "/" .. tostring(targetId))
		return false
	elseif not UnitCanAttack(originId, targetId) then
		-- ChatFrame7:AddMessage("AloftThreatData:ValidateThreatUpdate(): invalid update, cannot attack target unit " .. tostring(originId) .. "/" .. tostring(targetId))
		return false
	elseif UnitIsFriend(originId, targetId) then
		-- ChatFrame7:AddMessage("AloftThreatData:ValidateThreatUpdate(): invalid update, friend of target unit " .. tostring(originId) .. "/" .. tostring(targetId))
		return false
	elseif originId == "player" and UnitPlayerControlled(targetId) then
		-- ChatFrame7:AddMessage("AloftThreatData:ValidateThreatUpdate(): invalid update, target unit is player controlled " .. tostring(originId) .. "/" .. tostring(targetId))
		return false
	end

	-- ChatFrame7:AddMessage("AloftThreatData:ValidateThreatUpdate(): valid update")
	return true
end

function AloftThreatData:ClearThreatData(aloftData)
	-- ChatFrame7:AddMessage("AloftThreatData:ClearThreatData(): enter")

	if aloftData.threat then
		aloftData.threatStatus = nil
		aloftData.threat = nil
		aloftData.maxThreat = nil
		aloftData.maxThreatGain = nil
		aloftData.threatMulti = nil
		aloftData.threatDeficit = nil
		aloftData.threatFraction = nil
		aloftData.threatType = nil
		aloftData.shortThreatType = nil

		-- ChatFrame7:AddMessage("AloftThreatData:ClearThreatData(): clear " .. (aloftData.unitid or "") .. "/" .. aloftData.name)
	end

	-- ChatFrame7:AddMessage("AloftThreatData:ClearThreatData(): exit")
end

function AloftThreatData:SetThreatData(aloftData, status, threat, maxThreat, threatMulti, threatType)
	-- ChatFrame7:AddMessage("AloftThreatData:SetThreatData(): enter")

	if maxThreat and maxThreat > 0 then
		-- Blizzard(tm)'s threat API, at least, generates some really funky numbers; we want to be able to test for equality w/o worrying about residual arithmetic
		aloftData.threatStatus = status or 0
		aloftData.threat = math_floor(threat + 0.5)
		aloftData.maxThreat = math_floor(maxThreat + 0.5) or 0
		aloftData.maxThreatGain = math_floor((maxThreat * threatMulti) + 0.5)
		aloftData.threatMulti = threatMulti
		aloftData.threatDeficit = math_floor(maxThreat - threat + 0.5)
		aloftData.threatType = L[threatType]
		aloftData.shortThreatType = L[SHORT_THREAT_TYPES[threatType]]

		-- round off and put back into correct form
		local fraction = (threat and maxThreat and maxThreat > 0) and ceil((threat / maxThreat) * 100.0) or 0
		aloftData.threatFraction = fraction / 100.0

		-- ChatFrame7:AddMessage("AloftThreatData:SetThreatData(): set " .. aloftData.name .. "/" .. (aloftData.unitid or "") or "/" .. aloftData.name .. "/" .. aloftData.shortThreatType .. "/" .. aloftData.threatType .. "/" .. aloftData.threat .. "/" .. aloftData.maxThreat .. "/" .. aloftData.threatMulti  .. "/" .. aloftData.threatFraction .. "/" .. aloftData.threatDeficit)
	end

	-- ChatFrame7:AddMessage("AloftThreatData:SetThreatData(): exit")
end

function AloftThreatData:GetThreatType(originGUId, targetId, tgtgtGUId)
	-- ChatFrame7:AddMessage("AloftThreatData:GetThreatType(): enter")

	-- calculate threat gain/threat type; basic logic lifted from other threat meters/displays (Omen2 and IceHUD_Threat)
	-- TODO: incorporate (originGUId == UnitGUID("targettarget")) here? always flag targettarget as tank/maxthreat? see what Threat-2.0 returns for targettarget
	local threatMulti = 1.0 -- default threat gain multiplier
	local threatType = THREAT_GROUP -- default threat type
	if tgtgtGUId and originGUId == tgtgtGUId then
		-- ChatFrame7:AddMessage("AloftThreatData:GetThreatType(): targettarget")
		threatType = THREAT_TANK
		-- threatMulti stays the same
	elseif originGUId == Aloft:GetPlayerGUId() then
		if UnitIsVisible(targetId) and CheckInteractDistance(targetId, 3) then -- logic pulled from Threat-2.0
			-- ChatFrame7:AddMessage("AloftThreatData:GetThreatType(): player melee")
			-- player has common threat within melee range; this uses the WoW API CheckInteractDistance(), and actually checks Duel initiation distance (9.9 yards in WoW 2.4.3)
			threatType = THREAT_MELEE
			threatMulti = 1.1
		else
			-- ChatFrame7:AddMessage("AloftThreatData:GetThreatType(): player range")
			-- player has common threat outside melee range
			threatType = THREAT_RANGED
			threatMulti = 1.3
		end
	end
	-- ChatFrame7:AddMessage("AloftThreatData:GetThreatType(): " .. originGUId .. "/" .. targetId .. "/" .. (tgtgtGUId or "<NOTGTGT>") .. "/" .. threatType .. "/" .. threatMulti)

	-- ChatFrame7:AddMessage("AloftThreatData:GetThreatType(): exit")
	return threatType, threatMulti
end

-----------------------------------------------------------------------------

end)