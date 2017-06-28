local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

local L = AceLibrary("AceLocale-2.2"):new("AloftPetOwnersNameTextOptions")

-----------------------------------------------------------------------------

local AloftPetOwnersNameData = Aloft:NewModule("PetOwnersNameData", "AceEvent-2.0")
AloftPetOwnersNameData.dynamic = "AloftPetOwnersName"

local L = AceLibrary("AceLocale-2.2"):new("AloftPetOwnersNameData")
local gratuity = AceLibrary("LibGratuity-3.0")
local roster = AceLibrary("Roster-2.1")

-----------------------------------------------------------------------------

local petOwnersNames = { }

local petTests =
{
	[L["PetTest"]] = true,
	[L["MinionTest"]] = true,
}

-----------------------------------------------------------------------------

Aloft.TagData.PetOwnersName =
{
	data = "petOwnersName",
	events = "Aloft:OnPetOwnersNameDataChanged",
	tableData = "petOwnersName"
}

-----------------------------------------------------------------------------

function AloftPetOwnersNameData:ProvidesData()
	return "petOwnersName"
end

function AloftPetOwnersNameData:RegisterEvents()
	self:UnregisterAllEvents()

	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdatePetOwnersNameFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdatePetOwnersNameFromTarget")
	self:RegisterEvent("RosterLib_RosterUpdated", "UpdatePetOwnersNamesFromRoster")
end

function AloftPetOwnersNameData:EnableDataSource()
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftPetOwnersNameData:OnEnable()
end

function AloftPetOwnersNameData:UpdateData(aloftData)
	aloftData.petOwnersName = nil

	if aloftData.name == L["Unknown"] then return end

	-- This is to stop players that share the same names as pets being incorrectly tagged
	if aloftData.type == "friendlyNPC" or aloftData.type == "hostilePlayer" or aloftData.type == "hostile" then
		self:UpdateNameplate(aloftData, petOwnersNames[aloftData.name])
	end
end

-----------------------------------------------------------------------------

function AloftPetOwnersNameData:UpdatePetOwnersNameFromUnit(unitid)
	if UnitIsPlayer(unitid) or not UnitPlayerControlled(unitid) then return end

	local name, _ = UnitName(unitid)
	if name == L["Unknown"] then return end

	local petOwnersName = self:GetUnitTooltipData(unitid)
	if not petOwnersName or petOwnersName == "" then return end

	local match = false
	for test in pairs(petTests) do
		local localMatch
		petOwnersName, localMatch = petOwnersName:gsub(test, "%1")
		if localMatch > 0 then match = true end
	end
	if not match then return end

	local key = UnitName(unitid)

	-- bleah; we can now tell the difference between players and pets of the same name, if the ShowClassColorInVKey CVar is enabled,
	-- but we have to look at all visible nameplates to do it
	if petOwnersNames[key] ~= petOwnersName then
		petOwnersNames[key] = petOwnersName
		targetNameplate = Aloft:GetTargetNameplate()
		for aloftData in Aloft:IterateVisibleNameplates() do
			if aloftData.name == key then
				if (aloftData == targetNameplate) then
					self:AssignValues(aloftData, petOwnersName)
				else
					self:UpdateNameplate(aloftData, petOwnersName)
				end
			end
		end
	end
end

function AloftPetOwnersNameData:UpdatePetOwnersNameFromMouseOver()
	self:UpdatePetOwnersNameFromUnit("mouseover")
end

function AloftPetOwnersNameData:UpdatePetOwnersNameFromTarget()
	self:UpdatePetOwnersNameFromUnit("target")
end

function AloftPetOwnersNameData:UpdatePetOwnersNamesFromRoster()
	for unit in roster:IterateRoster(true) do
		local owner, match = unit.unitid:gsub("pet", "")
		if match > 0 then
			if owner == "" then owner = "player" end

			local key = unit.name
			local petOwnersName = UnitName(owner)

			-- bleah; we can now tell the difference between players and pets of the same name, if the ShowClassColorInVKey CVar is enabled,
			-- but we have to look at all visible nameplates to do it
			if petOwnersNames[key] ~= petOwnersName then
				petOwnersNames[key] = petOwnersName
				for aloftData in Aloft:IterateVisibleNameplates() do
					if aloftData.name == key then
						self:UpdateNameplate(aloftData, petOwnersName)
					end
				end
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftPetOwnersNameData:UpdateNameplate(aloftData, petOwnersName)
	-- we can now tell the difference between players and pets of the same name, if the ShowClassColorInVKey CVar is enabled;
	-- try to tighten up the checking, so we bomb out on a nameplate as quickly as possible
	if petOwnersName and self:ValidateNameplate(aloftData, petOwnersName) then
		self:AssignValues(aloftData, petOwnersName)
	else
		aloftData.petOwnersName = nil
	end
end

function AloftPetOwnersNameData:ValidateNameplate(aloftData, petOwnersName)
	-- we can now tell the difference between players and pets of the same name, if the ShowClassColorInVKey CVar is enabled;
	-- try to tighten up the checking, so we bomb out on a nameplate as quickly as possible
	if aloftData.type == "friendlyNPC" or (aloftData.type == "hostile" and (not Aloft.showClassColorInVKey or not Aloft:GetClassByColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB))) then
		return true
	end
	return false
end

function AloftPetOwnersNameData:AssignValues(aloftData, petOwnersName)
	if not (aloftData.petOwnersName == petOwnersName) then
		aloftData.petOwnersName = petOwnersName
		self:TriggerEvent("Aloft:OnPetOwnersNameDataChanged", aloftData)
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

-- local version, build, date, tocversion = GetBuildInfo()
function AloftPetOwnersNameData:GetUnitTooltipData(unitid)
	-- ChatFrame7:AddMessage("AloftPetOwnersNameData:GetUnitTooltipData(): VERSION " .. tostring(version) .. "/" .. tostring(build) .. "/" .. tostring(date) .. "/" .. tostring(tocversion) .. " VERSION")

	gratuity:SetUnit(unitid)
	local petOwnersName = gratuity:GetLine(2)

	return petOwnersName
end

-----------------------------------------------------------------------------

end)
