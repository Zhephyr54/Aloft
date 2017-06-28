local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftClassData = Aloft:NewModule("ClassData", "AceEvent-2.0")

local L = AceLibrary("AceLocale-2.2"):new("AloftClassDataOptions")
local roster = AceLibrary("Roster-2.1")

-----------------------------------------------------------------------------

AloftClassData.db = Aloft:AcquireDBNamespace("classData")
Aloft:RegisterDefaults("classData", "server", { playerClasses = { } } )
Aloft:RegisterDefaults("classData", "profile", { save = true } )

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

-----------------------------------------------------------------------------

local playerClasses = { }

----------------------------------------------------------------------------

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

local updateRequired = false
local function AddData(name, class)
	if playerClasses[name] ~= class then
		-- ChatFrame7:AddMessage("AloftClassData:AddData(): " .. tostring(name) .. "/" .. tostring(class))
		playerClasses[name] = class
		updateRequired = true
	end
	return class
end

-----------------------------------------------------------------------------

function AloftClassData:OnEnable()
	-- ChatFrame7:AddMessage("AloftClassData:OnEnable(): invoke")
	if self.db.profile.save then
		playerClasses = self.db.server.playerClasses
		-- self:UpdateClassesFromGuild()
		-- self:UpdateClassesFromFriends()
	else
		self.db.server.playerClasses = { }
		playerClasses = { }
	end

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

-----------------------------------------------------------------------------

function AloftClassData.SetSaveData(v)
	AloftClassData.db.profile.save = v
	if AloftClassData.db.profile.save then
		AloftClassData.db.server.playerClasses = playerClasses
		AloftClassData:UpdateClassesFromGuild()
		AloftClassData:UpdateClassesFromFriends()
	else
		AloftClassData.db.server.playerClasses = { }
	end
end

function AloftClassData:ProvidesData()
	return "class"
end

function AloftClassData:EnableDataSource()
	-- Events to update our class database
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateClassFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateClassFromTarget")
	self:RegisterEvent("GUILD_ROSTER_UPDATE", "UpdateClassesFromGuild")
	self:RegisterEvent("WHO_LIST_UPDATE", "UpdateClassesFromWho")
	self:RegisterEvent("CHAT_MSG_SYSTEM", "UpdateClassesFromWho")
	self:RegisterEvent("RosterLib_RosterUpdated", "UpdateClassesFromRoster")

	self:RegisterEvent("FRIENDLIST_UPDATE", "UpdateClassesFromFriends")

	-- Update stuff from battlegrounds
	self:ScheduleRepeatingEvent("AloftClassDataBattlefieldUpdate", function() if MiniMapBattlefieldFrame.status == "active" then RequestBattlefieldScoreData() end end, 15)
	self:RegisterEvent("UPDATE_BATTLEFIELD_SCORE", "UpdateClassesFromBattlefield")

	self:RegisterEvent("Aloft:OnHealthBarColorChanged", "OnHealthBarColorChanged")
	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")

	-- ChatFrame7:AddMessage("AloftClassData:EnableDataSource(): initialize")
	self:UpdateClassesFromGuild()
	self:UpdateClassesFromFriends()
end

-----------------------------------------------------------------------------

function AloftClassData:UpdateData(aloftData)
	aloftData.class = nil

	-- This is so that pets named the same as players we've encountered aren't given a class incorrectly
	if aloftData.type == "friendlyPlayer" or aloftData.type == "hostilePlayer" or aloftData.type == "hostile" then
		local class = playerClasses[aloftData.name]
		self:UpdateNameplate(aloftData, class)
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
		local class = playerClasses[aloftData.name]
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

function AloftClassData:UpdateClassFromMouseOver()
	if UnitIsPlayer("mouseover") then
		local _, class = UnitClass("mouseover")
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

function AloftClassData:UpdateClassFromTarget()
	if UnitIsPlayer("target") then
		local _, class = UnitClass("target")
		if class then
			local name, _ = UnitName("target")

			if name and name ~= L["Unknown"] then
				-- ChatFrame7:AddMessage("AloftClassData:UpdateClassFromTarget(): " .. tostring(name) .. "/" .. tostring(class))
				AddData(name, normalClassNames[class:upper()])

				local eventName = "AloftClassData:UpdateClassFromTarget:" .. tostring(math.random(1,1000000000))
				self:ScheduleEvent(eventName, self.DoUpdateTargetNameplate, 0.0, self) -- next frame
			end
		end
	end
end

function AloftClassData:UpdateClassesFromGuild()
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

function AloftClassData:UpdateClassesFromWho()
	for i = 1, GetNumWhoResults() do
		local name, _, _, _, class = GetWhoInfo(i)
		if name and name ~= L["Unknown"] and class and BR[class] then
			AddData(name, normalClassNames[BR[class]:upper()])
		end
	end
	self:UpdateVisibleNameplates()
end

function AloftClassData:UpdateClassesFromRoster()
	for unit in roster:IterateRoster(false) do
		if unit.name and unit.name ~= L["Unknown"] and unit.class then
			AddData(unit.name, normalClassNames[unit.class:upper()])
		end
	end
	self:UpdateVisibleNameplates()
end

-- TODO: unify this into a single event somehow
function AloftClassData:UpdateClassesFromBattlefield()
	for i = 1, GetNumBattlefieldScores() do
		-- using class token here (arg 10), not the localized class (arg 9)
		local name, _, _, _, _, _, _, _, _, class, _, _ = GetBattlefieldScore(i)
		if name and name ~= L["Unknown"] and class then
			name = ("-"):split(name, 2)
			AddData(name, normalClassNames[class:upper()])
		end
	end
	self:UpdateVisibleNameplates()
end

function AloftClassData:UpdateClassesFromFriends()
	for i = 1, GetNumFriends() do
		local name, _, class = GetFriendInfo(i)
		if name and name ~= L["Unknown"] and class and BR[class] then
			AddData(name, normalClassNames[BR[class]:upper()])
		end
	end
	self:UpdateVisibleNameplates()
end

-----------------------------------------------------------------------------

function AloftClassData:OnHealthBarColorChanged(aloftData)
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

function AloftClassData:OnNameplateShow(aloftData)
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

function AloftClassData:GetClass(name)
	return playerClasses[name]
end

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
	if not aloftData.class ~= class then
		aloftData.class = class
		self:TriggerEvent("Aloft:OnClassDataChanged", aloftData)
		-- ChatFrame7:AddMessage("AloftClassData:AssignValues(): trigger " .. tostring(aloftData.name) .. "/" .. tostring(class))
	end

	if (aloftData.classification) then
		aloftData.classification = nil
		self:TriggerEvent("Aloft:OnClassificationDataChanged", aloftData)
	end
	if (aloftData.isPet) then
		aloftData.isPet = nil
		self:TriggerEvent("Aloft:OnIsPetDataChanged", aloftData)
	end
	if (aloftData.petOwnersName) then
		aloftData.petOwnersName = nil
		self:TriggerEvent("Aloft:OnPetOwnersNameDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------
