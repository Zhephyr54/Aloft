local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.Aloft
if not L then return end

local AloftIsPetData = Aloft:NewModule("IsPetData", Aloft, "AceEvent-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

AloftIsPetData.namespace = "isPetData"
AloftIsPetData.defaults =
{
	realm =
	{
		unitIsPetData =
		{
		},
	},
	profile =
	{
		save = false,
	},
}

-----------------------------------------------------------------------------

local unitIsPet = { }

-----------------------------------------------------------------------------

Aloft.TagData.IsPet =
{
	data = "isPet",
	events = "Aloft:OnIsPetDataChanged",
	tableData = "isPet"
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
	local isPet = nil
	if name then
		isPet = unitIsPet[name] -- try local cache first
		if name and not isPet and AloftIsPetData.db and AloftIsPetData.db.realm then
			isPet = AloftIsPetData.db.realm.unitIsPetData[name] -- recover from saved variables, if any
			unitIsPet[name] = isPet -- cache in local
		end
	end
	return isPet
end

local function AddData(name)
	if name and not unitIsPet[name] then
		-- ChatFrame7:AddMessage("AloftIsPetData:AddData(): " .. tostring(name) .. "/" .. tostring(isPet))

		unitIsPet[name] = true
		if AloftIsPetData.db and AloftIsPetData.db.profile and AloftIsPetData.db.profile.save and AloftIsPetData.db.realm then
			AloftIsPetData.db.realm.unitIsPetData[name] = true
		end

		return true
	end
	return nil
end

-----------------------------------------------------------------------------

function AloftIsPetData.SetSaveData(i, v)
	AloftIsPetData.db.profile.save = v
	if not v then
		AloftIsPetData.db.realm.unitIsPetData = { }
	else
		join(AloftIsPetData.db.realm.unitIsPetData, unitIsPet)
	end
end

function AloftIsPetData:ProvidesData()
	return "isPet"
end

function AloftIsPetData:EnableDataSource()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	-- Events to update our pet database
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdatePetFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdatePetFromTarget")
end

-----------------------------------------------------------------------------

function AloftIsPetData:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	-- TODO: added for Aloft-3.1.2; get rid of this in a few versions
	if self.db and self.db.realm then
		if self.db.realm.petNames then
			join(self.db.realm.unitIsPetData, self.db.realm.petNames)
			self.db.realm.petNames = nil
		end
		if self.db.realm.isPetData then
			join(self.db.realm.unitIsPetData, self.db.realm.isPetData)
			self.db.realm.isPetData = nil
		end
	end

	self.initialized = true
end

function AloftIsPetData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	if self.db.profile and not self.db.profile.save then
		self.db.realm.unitIsPetData = { }
	end
end

function AloftIsPetData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftIsPetData:UpdateData(aloftData)
	aloftData.isPet = nil
	-- This is so that pets named the same as players we've encountered aren't given ispet incorrectly
	if self:ValidateNameplate(aloftData, aloftData.name) then
		self:AssignValues(aloftData, (GetData(aloftData.name) and true) or nil)
	end
end


-----------------------------------------------------------------------------

local function IsPet(unitid)
	-- ChatFrame7:AddMessage("AloftIsPetData:IsPet(): " .. unitid .. " player controlled " .. tostring(UnitPlayerControlled(unitid)))
	-- ChatFrame7:AddMessage("AloftIsPetData:IsPet(): " .. unitid .. " player " .. tostring(UnitIsPlayer(unitid)))
	-- ChatFrame7:AddMessage("AloftIsPetData:IsPet(): " .. unitid .. " name " .. tostring(UnitName(unitid)))
	return UnitPlayerControlled(unitid) and not UnitIsPlayer(unitid) and UnitName(unitid) ~= L["Unknown"]
end

function AloftIsPetData:UpdatePetFromMouseOver(event)
	if IsPet("mouseover") then
		-- ChatFrame7:AddMessage("AloftIsPetData:UpdatePetFromMouseOver(): mouseover is pet")
		self:SetPet("mouseover")
	end
end

function AloftIsPetData:UpdatePetFromTarget(event)
	if IsPet("target") then
		-- ChatFrame7:AddMessage("AloftIsPetData:UpdatePetFromTarget(): target is pet")
		self:SetPet("target")
	end
end

-----------------------------------------------------------------------------

function AloftIsPetData:SetPet(unitid)
	local name = UnitName(unitid)

	AddData(name)

	-- bleah; we can now tell the difference between players and pets of the same name, if the ShowClassColorInVKey CVar is enabled,
	-- but we have to look at all visible nameplates to do it; try to tighten up the checking, so we bomb out on a nameplate as quickly as possible
	local targetNameplate = Aloft:GetTargetNameplate()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if (aloftData.name == name) then
			if aloftData == targetNameplate or self:ValidateNameplate(aloftData, name) then
				self:AssignValues(aloftData, true)
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
		self:SendMessage("Aloft:OnIsPetDataChanged", aloftData)
	end

	if isPet then
		if aloftData.race then
			aloftData.race = nil
			self:SendMessage("Aloft:OnRaceDataChanged", aloftData)
		end
		if aloftData.class then
			aloftData.class = nil
			self:SendMessage("Aloft:OnClassDataChanged", aloftData)
		end
		if aloftData.guild then
			aloftData.guild = nil
			self:SendMessage("Aloft:OnGuildDataChanged", aloftData)
		end
	end
end

-----------------------------------------------------------------------------

