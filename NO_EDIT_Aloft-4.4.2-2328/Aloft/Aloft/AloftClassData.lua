local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.Aloft
if not L then return end

local AloftRoster = Aloft:GetModule("Roster") -- always on
if not AloftRoster then return end

local AloftClassData = Aloft:NewModule("ClassData", Aloft, "AceEvent-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

AloftClassData.namespace = "classData"
AloftClassData.defaults =
{
	realm =
	{
		playerClassData =
		{ 
		},
	},
	profile =
	{
		save = true,
	},
}

-----------------------------------------------------------------------------

-- normalize all known forms of "data tracking" class name returned by the Blizzard API to what is expected in indexes to LOCALIZED_CLASS_NAMES_MALE/LOCALIZED_CLASS_NAMES_FEMALE
local normalClassNames =
{
	["DRUID"]			= "DRUID",
	["HUNTER"]			= "HUNTER",
	["MAGE"]			= "MAGE",
	["PALADIN"]			= "PALADIN",
	["PRIEST"]			= "PRIEST",
	["ROGUE"]			= "ROGUE",
	["SHAMAN"]			= "SHAMAN",
	["WARLOCK"]			= "WARLOCK",
	["WARRIOR"]			= "WARRIOR",
	["DEATHKNIGHT"]		= "DEATHKNIGHT",
	["DEATH KNIGHT"]	= "DEATHKNIGHT",
}

-- lookup for localized class names (normal->localized); this is from Blizzard's FrameXML/Constants.lua
local BL = LOCALIZED_CLASS_NAMES_MALE -- from FrameXML/Constants.lua; TODO: enhance to make these gender-specific?

-- reverse-lookup for localized class names (localized->normal)
local BR =
{
	[BL["DRUID"]]		= "DRUID",
	[BL["HUNTER"]]		= "HUNTER",
	[BL["MAGE"]]		= "MAGE",
	[BL["PALADIN"]] 	= "PALADIN",
	[BL["PRIEST"]]		= "PRIEST",
	[BL["ROGUE"]]		= "ROGUE",
	[BL["SHAMAN"]]		= "SHAMAN",
	[BL["WARLOCK"]] 	= "WARLOCK",
	[BL["WARRIOR"]] 	= "WARRIOR",
	[BL["DEATHKNIGHT"]]	= "DEATHKNIGHT",
}

local playerClasses = { }

-----------------------------------------------------------------------------

local UnitName = UnitName
local UnitClass = UnitClass
local UnitIsPlayer = UnitIsPlayer
local RequestBattlefieldScoreData = RequestBattlefieldScoreData
local GetBattlefieldScore = GetBattlefieldScore
local GetNumBattlefieldScores = GetNumBattlefieldScores
local GetWhoInfo = GetWhoInfo
local GetFriendInfo = GetFriendInfo
local GetNumGuildMembers = GetNumGuildMembers
local GetGuildRosterInfo = GetGuildRosterInfo

-----------------------------------------------------------------------------

Aloft.TagData.Class =
{
	data = "class",
	events = "Aloft:OnClassDataChanged",
	method = function(data, prior)
				return prior and BL[data.class]
			 end
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
	local class = nil
	if name then
		class = playerClasses[name] -- try local cache first
		if name and not class and AloftClassData.db and AloftClassData.db.realm then
			class = AloftClassData.db.realm.playerClassData[name] -- recover from saved variables, if any
			playerClasses[name] = class -- cache in local
		end
	end
	return class
end

local updateRequired = false
local function AddData(name, class)
	if class == "" then class = nil end
	if name and playerClasses[name] ~= class then
		-- ChatFrame7:AddMessage("AloftClassData:AddData(): " .. tostring(name) .. "/" .. tostring(class))

		playerClasses[name] = class
		if AloftClassData.db and AloftClassData.db.profile and AloftClassData.db.profile.save and AloftClassData.db.realm then
			AloftClassData.db.realm.playerClassData[name] = class
		end

		updateRequired = true
	end
end

-----------------------------------------------------------------------------

function AloftClassData:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	-- TODO: added for Aloft-3.1.2; get rid of this in a few versions
	if self.db and self.db.realm then
		if self.db.realm.playerClasses then
			join(self.db.realm.playerClassData, self.db.realm.playerClasses)
			self.db.realm.playerClasses = nil
		end
	end

	self.initialized = true
end

function AloftClassData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftClassData:OnEnable(): invoke")
	if self.db and self.db.profile and self.db.realm and not self.db.profile.save then
		self.db.realm.playerClassData = { }
		-- self:UpdateClassesFromGuild("AloftClassData:OnEnable")
		-- self:UpdateClassesFromFriends("AloftClassData:OnEnable")
	end

	-- NOTE: in some languages, class names will be gender-specific; right now, Aloft doesn't worry about this, so the gender of units is irrelevant

	--[[
	for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		ChatFrame7:AddMessage("AloftClassData:OnEnable():   male " .. tostring(k) .. "/" .. tostring(v))
	end
	]]

	--[[
	for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
		ChatFrame7:AddMessage("AloftClassData:OnEnable(): remale " .. tostring(k) .. "/" .. tostring(v))
	end
	]]
end

function AloftClassData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftClassData.SetSaveData(i, v)
	AloftClassData.db.profile.save = v
	if not v then
		AloftClassData.db.realm.playerClassData = { }
	else
		AloftClassData:UpdateClassesFromGuild("AloftClassData:SetSaveData")
		AloftClassData:UpdateClassesFromFriends("AloftClassData:SetSaveData")
		join(AloftClassData.db.realm.playerClassData, playerClasses)
	end
end

function AloftClassData:ProvidesData()
	-- ChatFrame7:AddMessage("AloftClassData:ProvidesData(): enter")
	return "class"
end

function AloftClassData:EnableDataSource()
	-- ChatFrame7:AddMessage("AloftClassData:EnableDataSource(): enter")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	-- Events to update our class database
	-- ChatFrame7:AddMessage("AloftClassData:EnableDataSource(): UPDATE_MOUSEOVER_UNIT")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateClassFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateClassFromTarget")
	self:RegisterEvent("GUILD_ROSTER_UPDATE", "UpdateClassesFromGuild")
	self:RegisterEvent("WHO_LIST_UPDATE", "UpdateClassesFromWho")
	self:RegisterEvent("CHAT_MSG_SYSTEM", "UpdateClassesFromWho")
	self:RegisterEvent("FRIENDLIST_UPDATE", "UpdateClassesFromFriends")

	-- Update stuff from battlegrounds
	self:ScheduleRepeatingTimer(function() if MiniMapBattlefieldFrame.status == "active" then RequestBattlefieldScoreData() end end, 15)
	self:RegisterEvent("UPDATE_BATTLEFIELD_SCORE", "UpdateClassesFromBattlefield")

	self:RegisterMessage("Aloft:OnHealthBarColorChanged", "OnHealthBarColorChanged")
	self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")

	self:RegisterMessage("AloftRoster_RosterUpdated", "UpdateClassesFromRoster")

	-- ChatFrame7:AddMessage("AloftClassData:EnableDataSource(): initialize")
	self:UpdateClassesFromGuild("AloftClassData:EnableDataSource")
	self:UpdateClassesFromFriends("AloftClassData:EnableDataSource")
end

-----------------------------------------------------------------------------

function AloftClassData:UpdateData(aloftData)
	aloftData.class = nil

	-- This is so that pets named the same as players we've encountered aren't given a class incorrectly
	if aloftData.type == "friendlyPlayer" or aloftData.type == "hostilePlayer" or aloftData.type == "hostile" then
		self:UpdateNameplate(aloftData, GetData(aloftData.name))
	end
end

-----------------------------------------------------------------------------

function AloftClassData:UpdateVisibleNameplates()
	if updateRequired then
		targetNameplate = Aloft:GetTargetNameplate()
		for aloftData in Aloft:IterateVisibleNameplates() do
			self:UpdateVisibleNameplate(aloftData, targetNameplate)
		end
	end
	updateRequired = false
end

function AloftClassData:UpdateVisibleNameplate(aloftData, targetNameplate)
	-- ChatFrame7:AddMessage("AloftClassData:UpdateVisibleNameplate(): enter")
	if aloftData and aloftData.name ~= L["Unknown"] then
		local class = GetData(aloftData.name)
		-- ChatFrame7:AddMessage("AloftClassData:UpdateVisibleNameplate(): check " .. tostring(aloftData.name) .. "/" .. tostring(class))
		if (class and aloftData == targetNameplate) then
			-- ChatFrame7:AddMessage("AloftClassData:UpdateVisibleNameplate(): target " .. tostring(aloftData.name) .. "/" .. tostring(class))
			self:AssignValues(aloftData, class)
		else
			-- ChatFrame7:AddMessage("AloftClassData:UpdateVisibleNameplate(): ambient " .. tostring(aloftData.name) .. "/" .. tostring(class))
			self:UpdateNameplate(aloftData, class)
		end
	end
end

function AloftClassData:DoUpdateTargetNameplate()
	-- ChatFrame7:AddMessage("AloftClassData:DoUpdateTargetNameplate(): enter")
	local targetNameplate = Aloft:GetTargetNameplate() -- target nameplate may not be visible at the moment
	if targetNameplate then
		-- ChatFrame7:AddMessage("AloftClassData:DoUpdateTargetNameplate(): target nameplate")
		self:UpdateVisibleNameplate(targetNameplate, targetNameplate)
	end
end

-----------------------------------------------------------------------------

function AloftClassData:UpdateClassFromMouseOver(event)
	-- ChatFrame7:AddMessage("AloftClassData:UpdateClassFromMouseOver(): enter")
	if UnitIsPlayer("mouseover") then
		local _, class = UnitClass("mouseover")
		-- ChatFrame7:AddMessage("AloftClassData:UpdateClassFromMouseOver(): " .. tostring(class))
		if class then
			local name, _ = UnitName("mouseover")
			-- ChatFrame7:AddMessage("AloftClassData:UpdateClassFromMouseOver(): " .. tostring(name) .. "/" .. tostring(class))

			if name and name ~= L["Unknown"] then
				AddData(name, normalClassNames[class:upper()])
				self:UpdateVisibleNameplates()
			end
		end
	end
end

function AloftClassData:UpdateClassFromTarget(event)
	-- ChatFrame7:AddMessage("AloftClassData:UpdateClassFromTarget(): enter")
	if UnitIsPlayer("target") then
		local _, class = UnitClass("target")
		-- ChatFrame7:AddMessage("AloftClassData:UpdateClassFromTarget(): " .. tostring(class))
		if class then
			local name, _ = UnitName("target")

			if name and name ~= L["Unknown"] then
				-- ChatFrame7:AddMessage("AloftClassData:UpdateClassFromTarget(): " .. tostring(name) .. "/" .. tostring(class))
				AddData(name, normalClassNames[class:upper()])

				self:ScheduleTimer(function() AloftClassData:DoUpdateTargetNameplate() end, 0.0) -- next frame
			end
		end
	end
end

function AloftClassData:UpdateClassesFromGuild(event)
	if IsInGuild() then
		for i = 1, GetNumGuildMembers(true) do
			local name, _, _, _, class = GetGuildRosterInfo(i)
			if name and name ~= L["Unknown"] and class and BR[class] then
				-- ChatFrame7:AddMessage("AloftClassData:UpdateClassesFromGuild(): " .. tostring(name) .. "/" .. tostring(class) .. "/" .. tostring(BR[class]) .. "/" .. normalClassNames[BR[class]:upper()])
				AddData(name, normalClassNames[BR[class]:upper()])
			end
		end
		self:UpdateVisibleNameplates()
	end
end

function AloftClassData:UpdateClassesFromWho(event)
	for i = 1, GetNumWhoResults() do
		local name, _, _, _, class = GetWhoInfo(i)
		if name and name ~= L["Unknown"] and class and BR[class] then
			AddData(name, normalClassNames[BR[class]:upper()])
		end
	end
	self:UpdateVisibleNameplates()
end

function AloftClassData:UpdateClassesFromRoster(message)
	for unit in AloftRoster:IterateRoster(false) do
		if unit.name and unit.name ~= L["Unknown"] and unit.class then
			AddData(unit.name, normalClassNames[unit.class:upper()])
		end
	end
	self:UpdateVisibleNameplates()
end

-- TODO: unify this into a single event somehow
function AloftClassData:UpdateClassesFromBattlefield(event)
	for i = 1, GetNumBattlefieldScores() do
		-- using class token here (arg 10), not the localized class (arg 9)
		local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
		-- rank has been deprecated in WoW 4.X

		-- verify the raw data from GetBattlefieldScore
		--[[
		ChatFrame7:AddMessage("AloftClassData:UpdateClassesFromBattlefield(): score #" .. tostring(i)
																						.. "/" .. tostring("N:") .. tostring(name)
																						.. "/" .. tostring("KB:") .. tostring(killingBlows)
																						.. "/" .. tostring("HK:") .. tostring(honorableKills)
																						.. "/" .. tostring("D:") .. tostring(deaths)
																						.. "/" .. tostring("HG:") .. tostring(honorGained)
																						.. "/" .. tostring("F:") .. tostring(faction)
																						.. "/" .. tostring("K:") .. tostring(rank)
																						.. "/" .. tostring("R:") .. tostring(race)
																						.. "/" .. tostring("C:") .. tostring(class)
																						.. "/" .. tostring("CT:") .. tostring(classToken)
																						.. "/" .. tostring("DD:") .. tostring(damageDone)
																						.. "/" .. tostring("HD:") .. tostring(healingDone))
		]]

		-- use the classToken, it is in english/caps already
		if name and name ~= L["Unknown"] and classToken and type(classToken) == "string" then
			name = ("-"):split(name, 2)
			AddData(name, normalClassNames[classToken:upper()])
		else
			-- class is not a string, or name is unknown
			-- ChatFrame7:AddMessage("AloftClassData:UpdateClassesFromBattlefield(): name " .. tostring(name) .. " classToken " .. tostring(classToken) .. " type " .. type(classToken))
		end
	end
	self:UpdateVisibleNameplates()
end

function AloftClassData:UpdateClassesFromFriends(event)
	for i = 1, GetNumFriends() do
		local name, _, class = GetFriendInfo(i)
		if name and name ~= L["Unknown"] and class and BR[class] then
			AddData(name, normalClassNames[BR[class]:upper()])
		end
	end
	self:UpdateVisibleNameplates()
end

-----------------------------------------------------------------------------

function AloftClassData:OnHealthBarColorChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftClassData:OnHealthBarColorChanged(): " .. tostring(aloftData.type) .. "/" .. tostring(Aloft.showClassColorInVKey))
	if (aloftData.type == "hostilePlayer" or aloftData.type == "hostile") and Aloft.showClassColorInVKey then -- hostile and class color in nameplate
		-- TODO: figure out a way to clean up this redundant color lookup
		local class = Aloft:GetClassByColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB)
		if class and aloftData.name ~= L["Unknown"] then
			AddData(aloftData.name, normalClassNames[class:upper()])
		end
	end
	self:UpdateVisibleNameplate(aloftData, Aloft:GetTargetNameplate())
end

function AloftClassData:OnNameplateShow(message, aloftData)
	-- ChatFrame7:AddMessage("AloftClassData:OnNameplateShow(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(Aloft.showClassColorInVKey)
	--	.. "/" .. tostring(floor(aloftData.originalHealthBarR * 256)) .. "." .. tostring(floor(aloftData.originalHealthBarG * 256)) .. "." .. tostring(floor(aloftData.originalHealthBarB * 256)))
	if (aloftData.type == "hostilePlayer" or aloftData.type == "hostile") and Aloft.showClassColorInVKey then -- hostile and class color in nameplate
		-- TODO: figure out a way to clean up this redundant color lookup
		local class = Aloft:GetClassByColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB)
		if class and aloftData.name ~= L["Unknown"] then
			AddData(aloftData.name, normalClassNames[class:upper()])
		end
	end
	self:UpdateVisibleNameplate(aloftData, Aloft:GetTargetNameplate())
end

-----------------------------------------------------------------------------

function AloftClassData:UpdateNameplate(aloftData, class)
	-- we can now tell the difference between players and pets of the same name, if the ShowClassColorInVKey CVar is enabled;
	-- try to tighten up the checking, so we bomb out on a nameplate as quickly as possible
	if class and self:ValidateNameplate(aloftData, class) then
		self:AssignValues(aloftData, class)
	else
		aloftData.class = nil
	end
end

function AloftClassData:ValidateNameplate(aloftData, class)
	if aloftData.type == "friendlyPlayer" or ((aloftData.type == "hostilePlayer" or aloftData.type == "hostile") and Aloft.showClassColorInVKey and class == Aloft:GetClassByColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB)) then
		return true
	end
	return false
end

function AloftClassData:AssignValues(aloftData, class)
	-- ChatFrame7:AddMessage("AloftClassData:AssignValues(): " .. tostring(aloftData.name) .. "/" .. tostring(class))
	if aloftData.class ~= class then
		aloftData.class = class
		self:SendMessage("Aloft:OnClassDataChanged", aloftData)
		-- ChatFrame7:AddMessage("AloftClassData:AssignValues(): trigger " .. tostring(aloftData.name) .. "/" .. tostring(class))
	end

	if (aloftData.classification) then
		aloftData.classification = nil
		self:SendMessage("Aloft:OnClassificationDataChanged", aloftData)
	end
	if (aloftData.isPet) then
		aloftData.isPet = nil
		self:SendMessage("Aloft:OnIsPetDataChanged", aloftData)
	end
	if (aloftData.petOwnersName) then
		aloftData.petOwnersName = nil
		self:SendMessage("Aloft:OnPetOwnersNameDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------

function AloftClassData:GetClass(name)
	return GetData(name)
end

-----------------------------------------------------------------------------
