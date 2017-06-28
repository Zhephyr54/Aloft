local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftClassificationData = Aloft:NewModule("ClassificationData", "AceEvent-2.0")

local L = AceLibrary("AceLocale-2.2"):new("AloftClassificationData")

-----------------------------------------------------------------------------

AloftClassificationData.db = Aloft:AcquireDBNamespace("classificationData")
Aloft:RegisterDefaults("classificationData", "account", { unitClassifications = { } })
Aloft:RegisterDefaults("classificationData", "profile", { save = false })

-----------------------------------------------------------------------------

local unitClassifications = { }

local classificationText =
{
	rare		= L["rare"],
	elite		= L["elite"],
	rareelite	= L["rareelite"],
	worldboss	= L["worldboss"],
}

local shortClassificationText =
{
	rare		= L["shortrare"],
	elite		= L["shortelite"],
	rareelite	= L["shortrareelite"],
	worldboss	= L["shortworldboss"],
}

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

function AloftClassificationData.SetSaveData(v)
	AloftClassificationData.db.profile.save = v
	AloftClassificationData.db.account.unitClassifications = (v and unitClassifications) or { }
end

function AloftClassificationData:ProvidesData()
	return "classification"
end

function AloftClassificationData:EnableDataSource()
	-- Events to update our unit classification database
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateClassificationFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateClassificationFromTarget")
end

-----------------------------------------------------------------------------

function AloftClassificationData:OnEnable()
	if self.db.profile.save then
		unitClassifications = self.db.account.unitClassifications
	else
		unitClassifications = { }
	end
end

-----------------------------------------------------------------------------

function AloftClassificationData:UpdateData(aloftData)
	if aloftData.name == L["Unknown"] then return end
	self:UpdateNameplate(aloftData, unitClassifications[(aloftData.level or -1)..aloftData.name])
end

-----------------------------------------------------------------------------

function AloftClassificationData:UpdateFromUnit(unitid)
	if UnitIsPlayer(unitid) then return end

	local name, _ = UnitName(unitid)
	if name == L["Unknown"] then return end

	-- Don't store normal unit classifications to reduce the database
	local classification = UnitClassification(unitid)
	if not classification then return end
	if classification == "normal" then return end

	local level = UnitLevel(unitid)
	local key = level..name
	if classification == unitClassifications[key] then return end
	unitClassifications[key] = classification

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

function AloftClassificationData:UpdateClassificationFromMouseOver()
	self:UpdateFromUnit("mouseover")
end

function AloftClassificationData:UpdateClassificationFromTarget()
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
	if not (aloftData.classification == classification) then
		aloftData.classification = classification
		self:TriggerEvent("Aloft:OnClassificationDataChanged", aloftData)
	end

	if (aloftData.race) then
		aloftData.race = nil
		self:TriggerEvent("Aloft:OnRaceDataChanged", aloftData)
	end
	if (aloftData.class) then
		aloftData.class = nil
		self:TriggerEvent("Aloft:OnClassDataChanged", aloftData)
	end
	if (aloftData.guild) then
		aloftData.guild = nil
		self:TriggerEvent("Aloft:OnGuildDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------
