local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftCreatureTypeData = Aloft:NewModule("CreatureTypeData", "AceEvent-2.0")

local L = AceLibrary("AceLocale-2.2"):new("AloftCreatureTypeData")

local AloftVisibility

-----------------------------------------------------------------------------

AloftCreatureTypeData.db = Aloft:AcquireDBNamespace("creatureTypeData")
Aloft:RegisterDefaults("creatureTypeData", "account", {	creatureTypeData = { } })
Aloft:RegisterDefaults("creatureTypeData", "profile", { save = false })

-----------------------------------------------------------------------------

local creatureTypeData = { }

-- this has some obsolete values in it, pending some documentation
local shortCreatureTypeTextLookup =
{
	[L["Beast"]]		= L["ShortBeast"],
	[L["Critter"]]		= L["ShortCritter"],
	[L["Demon"]]		= L["ShortDemon"],
	[L["Dragonkin"]]	= L["ShortDragonkin"],
	[L["Elemental"]]	= L["ShortElemental"],
	[L["Giant"]]		= L["Giant"],
	[L["Humanoid"]]		= L["ShortHumanoid"],
	[L["Mechanical"]]	= L["ShortMechanical"],
	[L["Undead"]]		= L["ShortUndead"],
}

-----------------------------------------------------------------------------

Aloft.TagData.CreatureType =
{
	data = "creatureType",
	events = "Aloft:OnCreatureTypeDataChanged",
	tableData = "creatureType"
}

Aloft.TagData.ShortCreatureType =
{
	data = "creatureType",
	events = "Aloft:OnCreatureTypeDataChanged",
	method = function(aloftData, value) return value and aloftData.creatureType and shortCreatureTypeTextLookup[aloftData.creatureType] or nil end
}

-----------------------------------------------------------------------------

function AloftCreatureTypeData:OnEnable()
	AloftVisibility = Aloft:HasModule("Visibility") and Aloft:GetModule("Visibility")
	if self.db.profile.save then
		creatureTypeData = self.db.account.creatureTypeData
	else
		creatureTypeData = { }
	end
end

-----------------------------------------------------------------------------

function AloftCreatureTypeData.SetSaveData(v)
	AloftCreatureTypeData.db.profile.save = v
	AloftCreatureTypeData.db.server.creatureTypeData = (v and creatureTypeData) or { }
end

function AloftCreatureTypeData:ProvidesData()
	return "creatureType"
end

function AloftCreatureTypeData:EnableDataSource()
	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateCreatureTypeFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateCreatureTypeFromTarget")
end

-----------------------------------------------------------------------------

function AloftCreatureTypeData:UpdateData(aloftData)
	if aloftData.name == L["Unknown"] then return end
	self:UpdateNameplate(aloftData, creatureTypeData[aloftData.name])
end

-----------------------------------------------------------------------------

function AloftCreatureTypeData:UpdateFromUnit(unitid)
	if UnitIsPlayer(unitid) then return end

	-- Don't store creature types that are empty or "not specified" to reduce the database
	local creatureType = UnitCreatureType(unitid)
	local name, _ = UnitName(unitid)

	if not creatureType then return end
	if name == L["Unknown"] then return end
	if creatureType == "" or creatureType == "Not specified" or creatureType == L["Not specified"] then return end

	local name = UnitName(unitid)
	if creatureType == creatureTypeData[name] then return end
	creatureTypeData[name] = creatureType

	local targetNameplate = Aloft:GetTargetNameplate()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData.name == name then
			if aloftData == targetNameplate then
				self:AssignValues(aloftData, creatureType)
			else
				self:UpdateNameplate(aloftData, creatureType)
			end
		end
	end
end

function AloftCreatureTypeData:UpdateCreatureTypeFromMouseOver()
	self:UpdateFromUnit("mouseover")
end

function AloftCreatureTypeData:UpdateCreatureTypeFromTarget()
	self:UpdateFromUnit("target")
end

function AloftCreatureTypeData:OnNameplateShow(aloftData)
	-- check to see if we can infer critter from the data on the nameplate; units without level (bosses/etc) or health are not critters
	if aloftData.type == "neutral" and aloftData.level ~= nil and aloftData.healthBarMaxValue ~= nil and
	   aloftData.level <= ((AloftVisibility and AloftVisibility.db.profile.critterLevel) or 1) and
	   aloftData.healthBarMaxValue <= ((AloftVisibility and AloftVisibility.db.profile.critterHealth) or 8) then
		local creatureType = L["Critter"]
		local name = aloftData.name

		if name ~= L["Unknown"] then
			if creatureType == creatureTypeData[name] then return end
			creatureTypeData[name] = creatureType

			self:UpdateNameplate(aloftData, creatureType)
		end
	end
end

-----------------------------------------------------------------------------

function AloftCreatureTypeData:UpdateNameplate(aloftData, creatureType)
	-- we can now tell the difference between players and pets of the same name, if the ShowClassColorInVKey CVar is enabled;
	-- try to tighten up the checking, so we bomb out on a nameplate as quickly as possible
	if creatureType and self:ValidateNameplate(aloftData, creatureType) then
		self:AssignValues(aloftData, creatureType)
	else
		aloftData.creatureType = nil
	end
end

function AloftCreatureTypeData:ValidateNameplate(aloftData, creatureType)
	return true
end

function AloftCreatureTypeData:AssignValues(aloftData, creatureType)
	if not (aloftData.creatureType == creatureType) then
		aloftData.creatureType = creatureType
		self:TriggerEvent("Aloft:OnCreatureTypeDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------
