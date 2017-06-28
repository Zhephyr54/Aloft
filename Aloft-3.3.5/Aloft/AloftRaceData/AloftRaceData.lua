local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftRaceData = Aloft:NewModule("RaceData", "AceEvent-2.0")

local L = AceLibrary("AceLocale-2.2"):new("AloftRaceData")

-----------------------------------------------------------------------------

AloftRaceData.db = Aloft:AcquireDBNamespace("raceData")
Aloft:RegisterDefaults("raceData", "server", {	raceData = { } })
Aloft:RegisterDefaults("raceData", "profile", { save = false })

------------------------------------------------------------------------------

local raceData = { }

----------------------------------------------------------------------------

local UnitName = UnitName
local UnitRace = UnitRace
local UnitIsPlayer = UnitIsPlayer
local RequestBattlefieldScoreData = RequestBattlefieldScoreData
local GetBattlefieldScore = GetBattlefieldScore
local GetNumBattlefieldScores = GetNumBattlefieldScores
local GetWhoInfo = GetWhoInfo

----------------------------------------------------------------------------

Aloft.TagData.Race =
{
	data = "race",
	events = "Aloft:OnRaceDataChanged",
	tableData = "race"
}

Aloft.TagData.ShortRace =
{
	data = "race",
	events = "Aloft:OnRaceDataChanged",
	method = function(aloftData, value) return value and aloftData.race and L[aloftData.race] end
}

-----------------------------------------------------------------------------

local updateRequired = false
local function AddData(name, race)
	if race == "" then
		race = nil
	end
	if name and race and raceData[name] ~= race then
		raceData[name] = race
		updateRequired = true
	end
	return race
end

-----------------------------------------------------------------------------

function AloftRaceData:OnEnable()
	if self.db.profile.save then
		raceData = self.db.server.raceData
	else
		raceData = { }
	end
end

-----------------------------------------------------------------------------

function AloftRaceData.SetSaveData(v)
	AloftRaceData.db.profile.save = v
	if AloftRaceData.db.profile.save then
		AloftRaceData.db.server.raceData = raceData
	else
		AloftRaceData.db.server.raceData = { }
	end
end

function AloftRaceData:ProvidesData()
	return "race"
end

function AloftRaceData:EnableDataSource()
	-- Events to update our race database
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateRaceFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateRaceFromTarget")
	self:RegisterEvent("WHO_LIST_UPDATE", "UpdateRaceFromWho")
	self:RegisterEvent("CHAT_MSG_SYSTEM", "UpdateRaceFromWho")

	self:ScheduleRepeatingEvent("AloftRaceDataBattlefieldUpdate", function() if MiniMapBattlefieldFrame.status == "active" then RequestBattlefieldScoreData() end end, 15)
	self:RegisterEvent("UPDATE_BATTLEFIELD_SCORE", "UpdateRaceFromBattlefield")
end

-----------------------------------------------------------------------------

function AloftRaceData:UpdateData(aloftData)
	aloftData.race = nil

	local type = aloftData.type
	local name = aloftData.name

	-- This is so that pets named the same as players we've encountered aren't given a race incorrectly
	if (type == "friendlyPlayer" or type == "hostilePlayer" or type == "hostile") and name ~= L["Unknown"] then
		self:UpdateNameplate(aloftData, raceData[name])
	end
end

-----------------------------------------------------------------------------

function AloftRaceData:UpdateVisibleNameplates()
	if updateRequired then
		targetNameplate = Aloft:GetTargetNameplate()
		for aloftData in Aloft:IterateVisibleNameplates() do
			self:UpdateVisibleNameplate(aloftData, targetNameplate)
		end
	end
	updateRequired = false
end

function AloftRaceData:UpdateVisibleNameplate(aloftData, targetNameplate)
	-- ChatFrame7:AddMessage("AloftRaceData:UpdateVisibleNameplate(): enter")
	if aloftData and aloftData.name ~= L["Unknown"] then
		local race = raceData[aloftData.name]
		-- ChatFrame7:AddMessage("AloftRaceData:UpdateVisibleNameplate(): check " .. tostring(aloftData.name) .. "/" .. tostring(race))
		if (race and aloftData == targetNameplate) then
			-- ChatFrame7:AddMessage("AloftRaceData:UpdateVisibleNameplate(): target " .. tostring(aloftData.name) .. "/" .. tostring(race))
			self:AssignValues(aloftData, race)
		else
			-- ChatFrame7:AddMessage("AloftRaceData:UpdateVisibleNameplate(): ambient " .. tostring(aloftData.name) .. "/" .. tostring(race))
			self:UpdateNameplate(aloftData, race)
		end
	end
end

function AloftRaceData:DoUpdateTargetNameplate()
	-- ChatFrame7:AddMessage("AloftRaceData:DoUpdateTargetNameplate(): enter")
	local targetNameplate = Aloft:GetTargetNameplate() -- target nameplate may not be visible at the moment
	if targetNameplate then
		-- ChatFrame7:AddMessage("AloftRaceData:DoUpdateTargetNameplate(): target nameplate")
		self:UpdateVisibleNameplate(targetNameplate, targetNameplate)
	end
end

-----------------------------------------------------------------------------

function AloftRaceData:UpdateRaceFromMouseOver()
	if UnitIsPlayer("mouseover") then
		local name, _ = UnitName("mouseover")
		local race, _ = UnitRace("mouseover")

		if name and name ~= L["Unknown"] then
			AddData(name, race)
			self:UpdateVisibleNameplates()
		end
	end
end

function AloftRaceData:UpdateRaceFromTarget()
	if UnitIsPlayer("target") then
		local name, _ = UnitName("target")
		local race, _ = UnitRace("target")

		if name and name ~= L["Unknown"] then
			AddData(name, race)

			local eventName = "AloftRaceData:UpdateRaceFromTarget:" .. tostring(math.random(1,1000000000))
			self:ScheduleEvent(eventName, self.DoUpdateTargetNameplate, 0.0, self) -- next frame
		end
	end
end

-- TODO: unify this into a single event somehow
function AloftRaceData:UpdateRaceFromBattlefield()
	for i = 1, GetNumBattlefieldScores() do
		local name, _, _, _, _, _, _, race, _, _, _, _ = GetBattlefieldScore(i)
		name = ("-"):split(name, 2)
		if name ~= L["Unknown"] then
			AddData(name, race)
		end
	end
	self:UpdateVisibleNameplates()
end

function AloftRaceData:UpdateRaceFromWho()
	for i = 1, GetNumWhoResults() do
		local name, _, _, race = GetWhoInfo(i)
		if name and name ~= L["Unknown"] then
			AddData(name, race)
		end
	end
	self:UpdateVisibleNameplates()
end

-----------------------------------------------------------------------------

function AloftRaceData:UpdateNameplate(aloftData, race)
	-- we can now tell the difference between players and pets of the same name, if the ShowClassColorInVKey CVar is enabled;
	-- try to tighten up the checking, so we bomb out on a nameplate as quickly as possible
	if race and self:ValidateNameplate(aloftData, race) then
		self:AssignValues(aloftData, race)
	else
		self:AssignValues(aloftData, nil)
	end
end

function AloftRaceData:ValidateNameplate(aloftData, race)
	if aloftData.type == "friendlyPlayer" or ((aloftData.type == "hostilePlayer" or aloftData.type == "hostile") and Aloft.showClassColorInVKey and Aloft:GetClassByColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB)) then
		return true
	end
	return false
end

function AloftRaceData:AssignValues(aloftData, race)
	if aloftData.race ~= race then
		aloftData.race = race
		self:TriggerEvent("Aloft:OnRaceDataChanged", aloftData)
	end

	if (race and aloftData.creatureType) then
		aloftData.creatureType = nil
		self:TriggerEvent("Aloft:OnCreatureTypeDataChanged", aloftData)
	end
	if (race and aloftData.classification) then
		aloftData.classification = nil
		self:TriggerEvent("Aloft:OnClassificationDataChanged", aloftData)
	end
	if (race and aloftData.isPet) then
		aloftData.isPet = nil
		self:TriggerEvent("Aloft:OnIsPetDataChanged", aloftData)
	end
	if (race and aloftData.petOwnersName) then
		aloftData.petOwnersName = nil
		self:TriggerEvent("Aloft:OnPetOwnersNameDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------
