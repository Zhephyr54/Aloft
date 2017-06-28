local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local aL = AloftLocale.Aloft
if not aL then return end

local dL = AloftLocale.AloftCreatureTypeData
if not dL then return end

local AloftCreatureTypeData = Aloft:NewModule("CreatureTypeData", Aloft, "AceEvent-3.0", "AceTimer-3.0")

local AloftVisibility

-----------------------------------------------------------------------------

AloftCreatureTypeData.namespace = "creatureTypeData"
AloftCreatureTypeData.defaults =
{
	realm =
	{
		unitCreatureTypeData =
		{
		},
	},
	profile =
	{
		save = false,
	},
}

-----------------------------------------------------------------------------

-- this has some obsolete values in it, pending some documentation
local shortCreatureTypeTextLookup =
{
	[dL["Beast"]]		= dL["ShortBeast"],
	[dL["Critter"]]		= dL["ShortCritter"],
	[dL["Demon"]]		= dL["ShortDemon"],
	[dL["Dragonkin"]]	= dL["ShortDragonkin"],
	[dL["Elemental"]]	= dL["ShortElemental"],
	[dL["Giant"]]		= dL["Giant"],
	[dL["Humanoid"]]	= dL["ShortHumanoid"],
	[dL["Mechanical"]]	= dL["ShortMechanical"],
	[dL["Undead"]]		= dL["ShortUndead"],
}

local unitCreatureTypes = { }

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
	local creatureType = nil
	if name then
		creatureType = unitCreatureTypes[name] -- try local cache first
		if name and not creatureType and AloftCreatureTypeData.db and AloftCreatureTypeData.db.realm then
			creatureType = AloftCreatureTypeData.db.realm.unitCreatureTypeData[name] -- recover from saved variables, if any
			unitCreatureTypes[name] = creatureType -- cache in local
		end
	end
	return creatureType
end

local function AddData(name, creatureType)
	if creatureType == "" then creatureType = nil end
	if name and unitCreatureTypes[name] ~= creatureType then
		unitCreatureTypes[name] = creatureType
		if AloftCreatureTypeData.db and AloftCreatureTypeData.db.profile and AloftCreatureTypeData.db.profile.save and AloftCreatureTypeData.db.realm then
			AloftCreatureTypeData.db.realm.unitCreatureTypeData[name] = creatureType
		end
		return true
	end
	return nil
end

-----------------------------------------------------------------------------

function AloftCreatureTypeData:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	-- TODO: added for Aloft-3.1.2; get rid of this in a few versions
	if self.db and self.db.realm then
		if self.db.realm.creatureTypeData then
			join(self.db.realm.unitCreatureTypeData, self.db.realm.creatureTypeData)
			self.db.realm.creatureTypeData = nil
		end
	end

	self.initialized = true
end

function AloftCreatureTypeData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	AloftVisibility = Aloft:GetModule("Visibility", true)
	if self.db and self.db.profile and self.db.realm and not self.db.profile.save then
		self.db.realm.unitCreatureTypeData = { }
	end
end

function AloftCreatureTypeData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftCreatureTypeData.SetSaveData(i, v)
	AloftCreatureTypeData.db.profile.save = v
	if not v then
		AloftCreatureTypeData.db.realm.unitCreatureTypeData = { }
	else
		join(AloftCreatureTypeData.db.realm.unitCreatureTypeData, unitCreatureTypes)
	end
end

function AloftCreatureTypeData:ProvidesData()
	return "creatureType"
end

function AloftCreatureTypeData:EnableDataSource()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateCreatureTypeFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateCreatureTypeFromTarget")
end

-----------------------------------------------------------------------------

function AloftCreatureTypeData:UpdateData(aloftData)
	if aloftData.name == aL["Unknown"] then return end
	self:UpdateNameplate(aloftData, GetData(aloftData.name))
end

-----------------------------------------------------------------------------

function AloftCreatureTypeData:UpdateFromUnit(unitid)
	if UnitIsPlayer(unitid) then return end

	-- Don't store creature types that are empty or "not specified" to reduce the database
	local creatureType = UnitCreatureType(unitid)
	local name, _ = UnitName(unitid)

	if not creatureType then return end
	if name == aL["Unknown"] then return end
	if creatureType == "" or creatureType == "Not specified" or creatureType == dL["Not specified"] then return end

	local name = UnitName(unitid)
	if not AddData(name, creatureType) then return end

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

function AloftCreatureTypeData:UpdateCreatureTypeFromMouseOver(event)
	self:UpdateFromUnit("mouseover")
end

function AloftCreatureTypeData:UpdateCreatureTypeFromTarget(event)
	self:UpdateFromUnit("target")
end

function AloftCreatureTypeData:OnNameplateShow(message, aloftData)
	-- check to see if we can infer critter from the data on the nameplate; units without level (bosses/etc) or health are not critters
	if aloftData.type == "neutral" and aloftData.level ~= nil and aloftData.healthBarMaxValue ~= nil and
	   aloftData.level <= ((AloftVisibility and AloftVisibility.db.profile.critterLevel) or 1) and
	   aloftData.healthBarMaxValue <= ((AloftVisibility and AloftVisibility.db.profile.critterHealth) or 8) then
		local creatureType = dL["Critter"]
		local name = aloftData.name

		if name ~= aL["Unknown"] then
			if AddData(name, creatureType) then
				self:UpdateNameplate(aloftData, creatureType)
			end
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
	if aloftData.creatureType ~= creatureType then
		aloftData.creatureType = creatureType
		self:SendMessage("Aloft:OnCreatureTypeDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------
