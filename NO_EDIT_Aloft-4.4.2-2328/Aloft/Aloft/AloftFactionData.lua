local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFaction", function()

-- ChatFrame7:AddMessage("AloftFactionData: found globals")

local aL = AloftLocale.Aloft
if not aL then return end

-- ChatFrame7:AddMessage("AloftFactionData: found Aloft locale")

local fL = AloftLocale.AloftFactionFilter
if not fL then return end

-- ChatFrame7:AddMessage("AloftFactionData: found filter locale")

-----------------------------------------------------------------------------

local AloftFactionData = Aloft:NewModule("FactionData", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftFactionData.dynamic = "AloftFaction"

-- ChatFrame7:AddMessage("AloftFactionData: created module")

local gratuity = LibStub("LibGratuity-3.0")
local babble = LibStub("LibBabble-Faction-3.0")

-- ChatFrame7:AddMessage("AloftFactionData: found gratuity/babble")

-- babble lookup tables for faction names
local B = babble:GetUnstrictLookupTable() -- english base
local BR = babble:GetReverseLookupTable() -- localized base

-- ChatFrame7:AddMessage("AloftFactionData: found/created all externals")

-----------------------------------------------------------------------------

AloftFactionData.namespace = "factionData"
AloftFactionData.defaults =
{
	realm =
	{
		unitFactionData =
		{
		},
	},
	profile =
	{
		save = false,
	},
}

-----------------------------------------------------------------------------

local factions = { }

-----------------------------------------------------------------------------

Aloft.TagData.Faction =
{
	data = "faction",
	events = "Aloft:OnFactionDataChanged",
	tableData = "faction"
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
	local faction = nil
	if name then
		faction = factions[name] -- try local cache first
		if name and not faction and AloftFactionData.db and AloftFactionData.db.realm then
			faction = AloftFactionData.db.realm.unitFactionData[name] -- recover from saved variables, if any
			factions[name] = faction -- cache in local
		end
	end
	return faction
end

local updateRequired = false
local function AddData(name, faction)
	if faction == "" then faction = nil end
	if name and factions[name] ~= faction then
		-- ChatFrame7:AddMessage("AloftFactionData:AddData(): " .. tostring(name) .. "/" .. tostring(faction))

		factions[name] = faction
		if AloftFactionData.db and AloftFactionData.db.profile and AloftFactionData.db.profile.save and AloftFactionData.db.realm then
			AloftFactionData.db.realm.unitFactionData[name] = faction
		end

		updateRequired = true
	end
end

-----------------------------------------------------------------------------

function AloftFactionData:ProvidesData()
	return "faction"
end

function AloftFactionData:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	-- ChatFrame7:AddMessage("AloftFactionData:RegisterEvents(): enter")

	-- ChatFrame7:AddMessage("AloftFactionData:RegisterEvents(): register events")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateFactionFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateFactionFromTarget")
end

function AloftFactionData:EnableDataSource()
	-- ChatFrame7:AddMessage("AloftFactionData:EnableDataSource(): enter")

	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftFactionData:OnInitialize()
	-- ChatFrame7:AddMessage("AloftFactionData:OnInitialize(): enter")

	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	-- TODO: added for Aloft-3.1.2; get rid of this in a few versions
	if self.db and self.db.realm then
		if self.db.realm.factions then
			join(self.db.realm.unitFactionData, self.db.realm.factions)
			self.db.realm.factions = nil
		end
	end

	self.initialized = true
end

function AloftFactionData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftFactionData:OnEnable(): enter")

	if self.db.profile and not self.db.profile.save then
		self.db.realm.unitFactionData = { }
	end
end

function AloftFactionData:OnDisable()
	-- ChatFrame7:AddMessage("AloftFactionData:OnDisable(): enter")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

function AloftFactionData:UpdateData(aloftData)
	aloftData.faction = GetData(aloftData.name)
end

-----------------------------------------------------------------------------

function AloftFactionData.SetSaveData(i, v)
	AloftFactionData.db.profile.save = v
	if not v then
		AloftFactionData.db.realm.unitFactionData = { }
	else
		join(AloftFactionData.db.realm.unitFactionData, factions)
	end
end

function AloftFactionData:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData.name ~= aL["Unknown"] then
			local faction = GetData(aloftData.name)
			if aloftData.faction ~= faction then
				aloftData.faction = faction
				self:SendMessage("Aloft:OnFactionDataChanged", aloftData)
			end
		end
	end
end

function AloftFactionData:SetFactionForTarget(faction)
	local name, _ = UnitName("target")
	if name and name ~= aL["Unknown"] then
		AddData(name, faction)
		self:UpdateAll()
		return name
	end
end

function AloftFactionData:ClearAllData()
	factions = { }
	AloftFactionData.db.realm.unitFactionData = { }
	self:UpdateAll()
end

-----------------------------------------------------------------------------

function AloftFactionData:UpdateFactionFromUnit(unitid)
	local key, _ = UnitName(unitid)
	-- ChatFrame7:AddMessage("AloftFactionData:UpdateFactionFromUnit(): enter " .. tostring(unitid) .. "/" .. tostring(key))

	if key and not GetData(key) and not UnitIsPlayer(unitid) and not UnitPlayerControlled(unitid) and key ~= aL["Unknown"] then
		local faction = self:GetUnitTooltipData(unitid)
		-- ChatFrame7:AddMessage("AloftFactionData:UpdateFactionFromUnit(): " .. tostring(unitid) .. "/" .. tostring(key) .. "/" .. tostring(faction))

		if faction and faction ~= "" then -- level is filtered out in AloftFactionData:GetUnitTooltipData()
			AddData(key, faction)
			for aloftData in Aloft:IterateVisibleNameplates() do
				if aloftData.name == key then
					aloftData.faction = faction
					
					-- ChatFrame7:AddMessage("AloftFactionData:UpdateFactionFromUnit(): message " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.faction))
					self:SendMessage("Aloft:OnFactionDataChanged", aloftData)
				end
			end
		end
	end
end

function AloftFactionData:UpdateFactionFromMouseOver(event)
	-- ChatFrame7:AddMessage("AloftFactionData:UpdateFactionFromMouseOver(): enter")
	self:UpdateFactionFromUnit("mouseover")
end

function AloftFactionData:UpdateFactionFromTarget(event)
	-- ChatFrame7:AddMessage("AloftFactionData:UpdateFactionFromTarget(): enter")
	self:UpdateFactionFromUnit("target")
end

-----------------------------------------------------------------------------

-- local version, build, date, tocversion = GetBuildInfo()
function AloftFactionData:GetUnitTooltipData(unitid)
	local faction

	-- ChatFrame7:AddMessage("AloftFactionData:GetUnitTooltipData(): VERSION " .. tostring(version) .. "/" .. tostring(build) .. "/" .. tostring(date) .. "/" .. tostring(tocversion) .. " VERSION")

	gratuity:SetUnit(unitid)

	local lines = gratuity:NumLines(10) -- rummage up to the first 10 lines of the tooltip
	for line = 2, lines do -- iterate through lines 2-onwards of the tooltip, we want to locate the unit level text
		local level = gratuity:GetLine(line)
		if not level or level == "" then break end -- we have run off the end of the tooltip
		if level:find(aL["Level"]) == 1 then
			faction = gratuity:GetLine(line + 1) -- faction text appears on the line after the level text
			-- ChatFrame7:AddMessage("AloftFactionData:GetUnitTooltipData(): " .. tostring(UnitName(unitid)) .. "/" .. tostring(level) .. "/" .. tostring(faction))
			break -- we have the data we need, of whatever form
		end
	end

	-- filter out unrelated data; if it exists, but is one of the static patterns, or in neither of babble's tables (localized or not)...
	if faction and (self:IsFactionFiltered(faction) or not (B[faction] or BR[faction])) then
		faction = nil
	end

	return faction
end

function AloftFactionData:IsFactionFiltered(faction)
	if faction and fL then
		for i = 1, #fL do
			if faction:find(fL[i]) then return true end
		end
	end
	return nil
end

-----------------------------------------------------------------------------

end)
