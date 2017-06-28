local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local AloftClassificationData = Aloft:NewModule("ClassificationData", Aloft, "AceEvent-3.0", "AceTimer-3.0")

local aL = AloftLocale.Aloft
if not aL then return end

local dL = AloftLocale.AloftClassificationData
if not dL then return end

-----------------------------------------------------------------------------

AloftClassificationData.namespace = "classificationData"
AloftClassificationData.defaults =
{
	realm =
	{
		unitClassificationData =
		{
		},
	},
	profile =
	{
		save = false,
	},
}

-----------------------------------------------------------------------------

local classificationText =
{
	rare		= dL["rare"],
	elite		= dL["elite"],
	rareelite	= dL["rareelite"],
	worldboss	= dL["worldboss"],
}

local shortClassificationText =
{
	rare		= dL["shortrare"],
	elite		= dL["shortelite"],
	rareelite	= dL["shortrareelite"],
	worldboss	= dL["shortworldboss"],
}

local unitClassifications = { }

-----------------------------------------------------------------------------

Aloft.TagData.Classification =
{
	data = "classification",
	events = "Aloft:OnClassificationDataChanged",
	method = function(aloftData, value)
				return value and aloftData.classification and classificationText[aloftData.classification]
			 end
}

Aloft.TagData.ShortClassification =
{
	data = "classification",
	events = "Aloft:OnClassificationDataChanged",
	method = function(aloftData, value)
				return value and aloftData.classification and shortClassificationText[aloftData.classification]
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

local function GetData(key)
	local classification = nil
	if key then
		classification = unitClassifications[key] -- try local cache first
		if key and not classification and AloftClassificationData.db and AloftClassificationData.db.realm then
			classification = AloftClassificationData.db.realm.unitClassificationData[key] -- recover from saved variables, if any
			unitClassifications[key] = classification -- cache in local
		end
	end
	return classification
end

local function AddData(key, classification)
	if classification == "" then classification = nil end
	if key and unitClassifications[key] ~= classification then
		unitClassifications[key] = classification
		if AloftClassificationData.db and AloftClassificationData.db.profile and AloftClassificationData.db.profile.save and AloftClassificationData.db.realm then
			AloftClassificationData.db.realm.unitClassificationData[key] = classification
		end
		return true
	end
	return nil
end

-----------------------------------------------------------------------------

function AloftClassificationData.SetSaveData(i, v)
	AloftClassificationData.db.profile.save = v
	if not v then
		AloftClassificationData.db.realm.unitClassificationData = { }
	else
		join(AloftClassificationData.db.realm.unitClassificationData, unitClassifications)
	end
end

function AloftClassificationData:ProvidesData()
	return "classification"
end

function AloftClassificationData:EnableDataSource()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	-- Events to update our unit classification database
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateClassificationFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateClassificationFromTarget")
end

-----------------------------------------------------------------------------

function AloftClassificationData:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	-- TODO: added for Aloft-3.1.2; get rid of this in a few versions
	if self.db and self.db.realm then
		if self.db.realm.unitClassifications then
			join(self.db.realm.unitClassificationData, self.db.realm.unitClassifications)
			self.db.realm.unitClassifications = nil
		end
	end

	self.initialized = true
end

function AloftClassificationData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	if self.db and self.db.profile and self.db.realm and not self.db.profile.save then
		self.db.realm.unitClassificationData = { }
	end
end

function AloftClassificationData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftClassificationData:UpdateData(aloftData)
	if aloftData.name == aL["Unknown"] then return end
	self:UpdateNameplate(aloftData, GetData((aloftData.level or -1)..aloftData.name))
end

-----------------------------------------------------------------------------

function AloftClassificationData:UpdateFromUnit(unitid)
	if UnitIsPlayer(unitid) then return end

	local name, _ = UnitName(unitid)
	if name == aL["Unknown"] then return end

	local classification = UnitClassification(unitid)
	-- ChatFrame7:AddMessage("AloftClassificationData:UpdateFromUnit(): " .. tostring(UnitName(unitid)) .. "/" .. tostring(classification))

	-- Don't store normal/trivial unit classifications to reduce the database
	if not classification then return end
	if classification == "normal" or classification == "trivial" then return end

	local level = UnitLevel(unitid)
	local key = level..name
	if not AddData(key, classification) then return end

	-- AloftData uses level as nil for tag purposes if its indeterminate
	if level == -1 then level = nil end

	local targetNameplate = Aloft:GetTargetNameplate()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData.name == name and aloftData.level == level then
			if aloftData == targetNameplate then
				self:AssignValues(aloftData, classification)
			else
				self:UpdateNameplate(aloftData, classification)
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftClassificationData:UpdateClassificationFromMouseOver(event)
	self:UpdateFromUnit("mouseover")
end

function AloftClassificationData:UpdateClassificationFromTarget(event)
	self:UpdateFromUnit("target")
end

-----------------------------------------------------------------------------

function AloftClassificationData:UpdateNameplate(aloftData, classification)
	-- we can now tell the difference between players and pets of the same name, if the ShowClassColorInVKey CVar is enabled;
	-- try to tighten up the checking, so we bomb out on a nameplate as quickly as possible
	if classification and self:ValidateNameplate(aloftData, classification) then
		self:AssignValues(aloftData, classification)
	else
		aloftData.classification = nil
	end
end

function AloftClassificationData:ValidateNameplate(aloftData, classification)
	if aloftData.type == "friendlyNPC" or ((aloftData.type == "hostilePlayer" or aloftData.type == "hostile") and (not Aloft.showClassColorInVKey or not Aloft:GetClassByColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB))) then
		return true
	end
	return false
end

function AloftClassificationData:AssignValues(aloftData, classification)
	if aloftData.classification ~= classification then
		aloftData.classification = classification
		self:SendMessage("Aloft:OnClassificationDataChanged", aloftData)
	end

	if (aloftData.race) then
		aloftData.race = nil
		self:SendMessage("Aloft:OnRaceDataChanged", aloftData)
	end
	if (aloftData.class) then
		aloftData.class = nil
		self:SendMessage("Aloft:OnClassDataChanged", aloftData)
	end
	if (aloftData.guild) then
		aloftData.guild = nil
		self:SendMessage("Aloft:OnGuildDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------
