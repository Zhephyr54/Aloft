local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local aL = AloftLocale.Aloft
if not aL then return end

local dL = AloftLocale.AloftRaceData
if not dL then return end

local AloftRaceData = Aloft:NewModule("RaceData", Aloft, "AceEvent-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

AloftRaceData.namespace = "raceData"
AloftRaceData.defaults =
{
	realm =
	{
		playerRaceData =
		{
		},
	},
	profile =
	{
		save = false,
	},
}

------------------------------------------------------------------------------

local playerRaces = { }

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
	method = function(aloftData, value) return value and aloftData.race and dL[aloftData.race] end
}

-----------------------------------------------------------------------------

local function join(t1, t2)
	if not (t1 and type(t1) == "table") then return end
	if not (t2 and type(t2) == "table") then return end

	-- NOTE: just a shallow copy; should only ever be used on "simple" tables (i.e. containing scalar keys/values)
	-- non-destructive merke of t2 into t1; if t1 already has a key/value, leave it
	for k, v in pairs(t2) do
		if not t1[k] then t1[k] = v end -- add the k+v to t1
		t2[k] = nil -- zap k_v in t2
	end
end

-----------------------------------------------------------------------------

local function GetData(name)
	local race = nil
	if name then
		race = playerRaces[name] -- try local cache first
		if name and not race and AloftRaceData.db and AloftRaceData.db.realm then
			race = AloftRaceData.db.realm.playerRaceData[name] -- recover from saved variables, if any
			playerRaces[name] = race -- cache in local
		end
	end
	return race
end

local updateRequired = false
local function AddData(name, race)
	if race == "" then race = nil end
	if name and playerRaces[name] ~= race then
		-- ChatFrame7:AddMessage("AloftRaceData:AddData(): " .. tostring(name) .. "/" .. tostring(race))

		playerRaces[name] = race
		if AloftRaceData.db and AloftRaceData.db.profile and AloftRaceData.db.profile.save and AloftRaceData.db.realm then
			AloftRaceData.db.realm.playerRaceData[name] = race
		end

		updateRequired = true
		return true
	end
	return nil
end

-----------------------------------------------------------------------------

function AloftRaceData:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	-- TODO: added for Aloft-3.1.2; get rid of this in a few versions
	if self.db and self.db.realm then
		if self.db.realm.raceData then
			join(self.db.realm.playerRaceData, self.db.realm.raceData)
			self.db.realm.raceData = nil
		end
	end

	self.initialized = true
end

function AloftRaceData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	if self.db.profile and not self.db.profile.save then
		self.db.realm.playerRaceData = { }
	end
end

function AloftRaceData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftRaceData.SetSaveData(i, v)
	AloftRaceData.db.profile.save = v
	if not v then
		AloftRaceData.db.realm.playerRaceData = { }
	else
		join(AloftRaceData.db.realm.playerRaceData, playerRaces)
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

	self:ScheduleRepeatingTimer(function() if MiniMapBattlefieldFrame.status == "active" then RequestBattlefieldScoreData() end end, 15)
	self:RegisterEvent("UPDATE_BATTLEFIELD_SCORE", "UpdateRaceFromBattlefield")
end

-----------------------------------------------------------------------------

function AloftRaceData:UpdateData(aloftData)
	aloftData.race = nil

	local type = aloftData.type
	local name = aloftData.name

	-- This is so that pets named the same as players we've encountered aren't given a race incorrectly
	if (type == "friendlyPlayer" or type == "hostilePlayer" or type == "hostile") and name ~= aL["Unknown"] then
		self:UpdateNameplate(aloftData, GetData(name))
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
	if aloftData and aloftData.name ~= aL["Unknown"] then
		local race = GetData(aloftData.name)
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

function AloftRaceData:UpdateRaceFromMouseOver(event)
	if UnitIsPlayer("mouseover") then
		local name, _ = UnitName("mouseover")
		local race, _ = UnitRace("mouseover")

		if name and name ~= aL["Unknown"] then
			AddData(name, race)
			self:UpdateVisibleNameplates()
		end
	end
end

function AloftRaceData:UpdateRaceFromTarget(event)
	if UnitIsPlayer("target") then
		local name, _ = UnitName("target")
		local race, _ = UnitRace("target")

		if name and name ~= aL["Unknown"] then
			AddData(name, race)
			self:ScheduleTimer(function() AloftRaceData:DoUpdateTargetNameplate() end, 0.0) -- next frame
		end
	end
end

-- TODO: unify this into a single event somehow
function AloftRaceData:UpdateRaceFromBattlefield(event)
	for i = 1, GetNumBattlefieldScores() do
		local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
		-- ChatFrame7:AddMessage("AloftRaceData:UpdateRaceFromBattlefield(): " .. tostring(name) .. "/" .. tostring(race))
		if name and race then -- it seems that name can, on rare occasions, be nil; perhaps a race condition with zoning in/out?
			name = ("-"):split(name, 2)
			if name ~= aL["Unknown"] then
				AddData(name, race)
			end
		end
	end
	self:UpdateVisibleNameplates()
end

function AloftRaceData:UpdateRaceFromWho(event)
	for i = 1, GetNumWhoResults() do
		local name, _, _, race = GetWhoInfo(i)
		if name and name ~= aL["Unknown"] then
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
		self:SendMessage("Aloft:OnRaceDataChanged", aloftData)
	end

	if (race and aloftData.creatureType) then
		aloftData.creatureType = nil
		self:SendMessage("Aloft:OnCreatureTypeDataChanged", aloftData)
	end
	if (race and aloftData.classification) then
		aloftData.classification = nil
		self:SendMessage("Aloft:OnClassificationDataChanged", aloftData)
	end
	if (race and aloftData.isPet) then
		aloftData.isPet = nil
		self:SendMessage("Aloft:OnIsPetDataChanged", aloftData)
	end
	if (race and aloftData.petOwnersName) then
		aloftData.petOwnersName = nil
		self:SendMessage("Aloft:OnPetOwnersNameDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------
