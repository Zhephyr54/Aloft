local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftIsPetData = Aloft:NewModule("IsPetData", "AceEvent-2.0")
local roster = AceLibrary("Roster-2.1")

local L = AceLibrary("AceLocale-2.2"):new("AloftIsPetDataOptions")

-----------------------------------------------------------------------------

AloftIsPetData.db = Aloft:AcquireDBNamespace("isPetData")
Aloft:RegisterDefaults("isPetData", "server", { petNames = { } })
Aloft:RegisterDefaults("isPetData", "profile", { save = false })

-----------------------------------------------------------------------------

local petNames = { }

-----------------------------------------------------------------------------

Aloft.TagData.IsPet =
{
	data = "isPet",
	events = "Aloft:OnIsPetDataChanged",
	tableData = "isPet"
}

-----------------------------------------------------------------------------

function AloftIsPetData.SetSaveData(v)
	AloftIsPetData.db.profile.save = v
	AloftIsPetData.db.server.petNames = (v and petNames) or { }
end

function AloftIsPetData:ProvidesData()
	return "isPet"
end

function AloftIsPetData:EnableDataSource()
	-- Events to update our pet database
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdatePetFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdatePetFromTarget")
end

-----------------------------------------------------------------------------

function AloftIsPetData:OnEnable()
	if self.db.profile.save then
		petNames = self.db.server.petNames
	else
		petNames = { }
	end
end

-----------------------------------------------------------------------------

function AloftIsPetData:UpdateData(aloftData)
	aloftData.isPet = nil
	-- This is so that pets named the same as players we've encountered aren't given ispet incorrectly
	if self:ValidateNameplate(aloftData, aloftData.name) then
		self:AssignValues(aloftData, petNames[aloftData.name] and true or nil)
	end
end


-----------------------------------------------------------------------------

local function IsPet(unitid)
	-- ChatFrame7:AddMessage("AloftIsPetData:IsPet(): " .. unitid .. " player controlled " .. tostring(UnitPlayerControlled(unitid)))
	-- ChatFrame7:AddMessage("AloftIsPetData:IsPet(): " .. unitid .. " player " .. tostring(UnitIsPlayer(unitid)))
	-- ChatFrame7:AddMessage("AloftIsPetData:IsPet(): " .. unitid .. " name " .. tostring(UnitName(unitid)))
	return UnitPlayerControlled(unitid) and not UnitIsPlayer(unitid) and UnitName(unitid) ~= L["Unknown"]
end

function AloftIsPetData:UpdatePetFromMouseOver()
	if IsPet("mouseover") then
		-- ChatFrame7:AddMessage("AloftIsPetData:UpdatePetFromMouseOver(): mouseover is pet")
		self:SetPet("mouseover")
	end
end

function AloftIsPetData:UpdatePetFromTarget()
	if IsPet("target") then
		-- ChatFrame7:AddMessage("AloftIsPetData:UpdatePetFromTarget(): target is pet")
		self:SetPet("target")
	end
end

-----------------------------------------------------------------------------

function AloftIsPetData:SetPet(unitid)
	local name = UnitName(unitid)
	if not name or petNames[name] then return end
	petNames[name] = true

	-- bleah; we can now tell the difference between players and pets of the same name, if the ShowClassColorInVKey CVar is enabled,
	-- but we have to look at all visible nameplates to do it; try to tighten up the checking, so we bomb out on a nameplate as quickly as possible
	local targetNameplate = Aloft:GetTargetNameplate()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if (aloftData.name == name) then
			if aloftData == targetNameplate or self:ValidateNameplate(aloftData, name) then
				self:AssignValues(aloftData, race)
			else
				aloftData.isPet = nil
			end
		end
	end
end

function AloftIsPetData:ValidateNameplate(aloftData, name)
	if aloftData.type == "friendlyNPC" or ((aloftData.type == "hostilePlayer" or aloftData.type == "hostile") and (not Aloft.showClassColorInVKey or not Aloft:GetClassByColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB))) then
		return true
	end
	return false
end

function AloftIsPetData:AssignValues(aloftData, isPet)
	if not aloftData.isPet then
		aloftData.isPet = isPet
		self:TriggerEvent("Aloft:OnIsPetDataChanged", aloftData)
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

