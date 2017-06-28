local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

local aL = AloftLocale.Aloft
if not aL then return end

local dL = AloftLocale.AloftPlayerTitleData
if not dL then return end

local AloftPlayerTitleData = Aloft:NewModule("PlayerTitleData", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftPlayerTitleData.dynamic = "AloftPlayerTitle"

local gratuity = LibStub("LibGratuity-3.0")

-----------------------------------------------------------------------------

AloftPlayerTitleData.namespace = "titleData"
AloftPlayerTitleData.defaults =
{
	profile =
	{
		save = false,
	},
	realm =
	{
		playerTitlePrefixData =
		{
		},
		playerTitleSuffixData =
		{
		},
	},
}

-----------------------------------------------------------------------------

local playerTitlePrefixes = { }
local playerTitleSuffixes = { }

local PREFIX_TEST	= "PrefixTest"
local SUFFIX_TEST1	= "SuffixTest1"
local SUFFIX_TEST2	= "SuffixTest2"

local SUFFIX_SEP = ":" -- separator string

local titleTests =
{
	[PREFIX_TEST]	= dL[PREFIX_TEST],
	[SUFFIX_TEST1]	= dL[SUFFIX_TEST1],
	[SUFFIX_TEST2]	= dL[SUFFIX_TEST2],
}

-----------------------------------------------------------------------------

Aloft.TagData.PlayerTitlePrefix =
{
	data = "playerTitlePrefix",
	events = "Aloft:OnPlayerTitleDataChanged",
	tableData = "playerTitlePrefix"
}

Aloft.TagData.PlayerTitleSuffix =
{
	data = "playerTitleSuffix",
	events = "Aloft:OnPlayerTitleDataChanged",
	tableData = "playerTitleSuffix"
}

Aloft.TagData.PlayerTitleSuffixSeparated =
{
	method = function(data, value, sep1, sep2)
		-- ChatFrame7:AddMessage("AloftPlayerTitleData:TagData.PlayerTitleSuffixSeparated.method(): " .. tostring(data.isTitleSeparated) .. "/" .. tostring(data.playerTitleSuffix) .. "/" .. tostring(sep1) .. "/" .. tostring(sep2) .. "/")
		return (value and data.playerTitleSuffix and ((data.isTitleSeparated and sep1) or sep2) .. data.playerTitleSuffix) or ""
	end,
	noGuaranteeChange = true,
	parameterTypes = { "string", "string" }
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

local function GetPrefixData(name)
	local prefix = nil
	if name then
		prefix = playerTitlePrefixes[name] -- try local cache first
		if not prefix and AloftPlayerTitleData.db and AloftPlayerTitleData.db.realm then
			prefix = AloftPlayerTitleData.db.realm.playerTitlePrefixData[name] -- recover from saved variables, if any
			playerTitlePrefixes[name] = prefix -- cache in local
		end
	end
	return prefix
end

local function AddPrefixData(name, prefix)
	if prefix == "" then prefix = nil end
	if name and playerTitlePrefixes[name] ~= prefix then
		playerTitlePrefixes[name] = prefix
		if AloftPlayerTitleData.db and AloftPlayerTitleData.db.profile and AloftPlayerTitleData.db.profile.save and AloftPlayerTitleData.db.realm then
			AloftPlayerTitleData.db.realm.playerTitlePrefixData[name] = prefix
		end
		return true
	end
	return nil
end

local function GetSuffixData(name)
	local prefix = nil
	if name then
		suffix = playerTitleSuffixes[name] -- try local cache first
		if not suffix and AloftPlayerTitleData.db and AloftPlayerTitleData.db.realm then
			suffix = AloftPlayerTitleData.db.realm.playerTitleSuffixData[name] -- recover from saved variables, if any
			playerTitleSuffixes[name] = suffix -- cache in local
		end
	end
	return suffix
end

local function AddSuffixData(name, suffix)
	if suffix == "" then suffix = nil end
	if name and playerTitleSuffixes[name] ~= suffix then
		playerTitleSuffixes[name] = suffix
		if AloftPlayerTitleData.db and AloftPlayerTitleData.db.profile and AloftPlayerTitleData.db.profile.save and AloftPlayerTitleData.db.realm then
			AloftPlayerTitleData.db.realm.playerTitleSuffixData[name] = suffix
		end
		return true
	end
	return nil
end

-----------------------------------------------------------------------------

function AloftPlayerTitleData.SetSaveData(i, v)
	AloftPlayerTitleData.db.profile.save = v
	if not v then
		AloftPlayerTitleData.db.realm.playerTitlePrefixData = { }
		AloftPlayerTitleData.db.realm.playerTitleSuffixData = { }
	else
		join(AloftPlayerTitleData.db.realm.playerTitlePrefixData, playerTitlePrefixes)
		join(AloftPlayerTitleData.db.realm.playerTitleSuffixData, playerTitleSuffixes)
	end
end

function AloftPlayerTitleData:ProvidesData()
	return "playerTitlePrefix", "playerTitleSuffix"
end

function AloftPlayerTitleData:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdatePlayerTitleFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdatePlayerTitleFromTarget")
	-- self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
end

function AloftPlayerTitleData:EnableDataSource()
	self:RegisterEvents()
end

function AloftPlayerTitleData:UpdateData(aloftData)
	local name = aloftData.name
	if name == aL["Unknown"] then return end

	aloftData.playerTitlePrefix = nil
	aloftData.playerTitleSuffix = nil

	-- recover SavedVariables stored data
	local suffix = nil
	local isSeparated = nil
	local prefix = GetPrefixData(name)
	local storedSuffix = GetSuffixData(name)

	if storedSuffix and (storedSuffix:byte(1) == SUFFIX_SEP:byte(1)) then
		isSeparated = true
		suffix = storedSuffix:sub(2) -- strip off initial character/separator
		-- ChatFrame7:AddMessage("AloftPlayerTitleData:UpdateData(): separated suffix " .. tostring(name) .. "/" .. tostring(isSeparated) .. "/" .. tostring(suffix) .. "/" .. tostring(storedSuffix))
	else
		suffix = storedSuffix -- use whole string
		-- ChatFrame7:AddMessage("AloftPlayerTitleData:UpdateData(): UNseparated suffix " .. tostring(name) .. "/" .. tostring(isSeparated) .. "/" .. tostring(suffix) .. "/" .. tostring(storedSuffix))
	end

	-- apply to nameplate
	-- ChatFrame7:AddMessage("AloftPlayerTitleData:UpdateData(): " .. tostring(name) .. "/" .. tostring(prefix) .. "/" .. tostring(suffix))
	self:UpdateNameplate(aloftData, prefix, suffix, isSeparated)
end

-----------------------------------------------------------------------------

function AloftPlayerTitleData:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	-- TODO: added for Aloft-3.1.1; get rid of this in a few versions
	-- compatibility/conversion, vis old saved variables
	if self.db and self.db.realm then
		if self.db.realm.playerTitlePrefixes then
			join(self.db.realm.playerTitlePrefixData, self.db.realm.playerTitlePrefixes)
			self.db.realm.playerTitlePrefixes = nil
		end
		if self.db.server and self.db.server.playerTitlePrefixes then
			join(self.db.realm.playerTitlePrefixData, self.db.server.playerTitlePrefixes)
			self.db.server.playerTitlePrefixes = nil
		end
		if self.db.realm.playerTitleSuffixes then
			join(self.db.realm.playerTitleSuffixData, self.db.realm.playerTitleSuffixes)
			self.db.realm.playerTitleSuffixes = nil
		end
		if self.db.server and self.db.server.playerTitleSuffixes then
			join(self.db.realm.playerTitleSuffixData, self.db.server.playerTitleSuffixes)
			self.db.server.playerTitleSuffixes = nil
		end
	end

	self.initialized = true
end

function AloftPlayerTitleData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	if self.db and self.db.profile and self.db.realm and not self.db.profile.save then
		self.db.realm.playerTitlePrefixData = { }
		self.db.realm.playerTitleSuffixData = { }
	end
	-- ChatFrame7:AddMessage("AloftPlayerTitleData:OnEnable(): " .. tostring(self.db.profile.save))
end

function AloftPlayerTitleData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

local currentRealm = GetRealmName()
function AloftPlayerTitleData:UpdatePlayerTitleFromUnit(unitid)
	if not UnitIsPlayer(unitid) then return end
	if not UnitIsFriend("player", unitid) and not UnitIsPVP(unitid) then return end

	local name, realm = UnitName(unitid)
	if name == aL["Unknown"] then return end

	gratuity:SetUnit(unitid)

	local tooltip = gratuity:GetLine(1)
	if not name or not tooltip or tooltip == "" or not tooltip:find(name) then return end
	if realm and (realm ~= currentRealm) then return end -- TODO: disable this when we figure out cross-realm tooltip formatting
	-- try to make certain we have a good tooltip, containing the unit's name, and not for a cross-realm player

	local prefix = nil
	local suffix = nil
	local storedSuffix = nil
	local isSeparated = nil
	local xname = name
	local dbname = name
	--[[ TODO: enable this when we figure out cross-realm tooltip formatting
	if realm and (realm ~= currentRealm) then
		xname = name .. " - " .. realm -- TODO: the problem is here... how are cross-realm tooltips formatted?
		dbname = name .. "-" .. realm
	end
	-- ChatFrame7:AddMessage("AloftPlayerTitleData:UpdatePlayerTitleFromUnit(): " .. tostring(currentRealm) .. "/" .. tostring(realm) .. "/" .. tostring(xname) .. "/" .. tostring(tooltip)) end
	]]

	-- only one title can be active at once; stop parsing as soon as we find it
	_, prefix = self:PerformTitleTest(tooltip, titleTests[PREFIX_TEST], "%1", xname)
	if not prefix then
		_, suffix = self:PerformTitleTest(tooltip, titleTests[SUFFIX_TEST1], "%2", xname) -- with a comma separator
		if not suffix then
			_, suffix = self:PerformTitleTest(tooltip, titleTests[SUFFIX_TEST2], "%2", xname) -- without a comma separator
		else
			isSeparated = true
		end
	end

	-- format SavedVariables storage if the original title contained a separator
	if isSeparated then
		if suffix then storedSuffix = SUFFIX_SEP .. suffix end
		-- ChatFrame7:AddMessage("AloftPlayerTitleData:UpdatePlayerTitleFromUnit(): separated suffix " .. tostring(name) .. "/" .. tostring(isSeparated) .. "/" .. tostring(suffix) .. "/" .. tostring(storedSuffix))
	else
		storedSuffix = suffix
		-- ChatFrame7:AddMessage("AloftPlayerTitleData:UpdatePlayerTitleFromUnit(): UNseparated suffix " .. tostring(name) .. "/" .. tostring(isSeparated) .. "/" .. tostring(suffix) .. "/" .. tostring(storedSuffix))
	end

	-- ChatFrame7:AddMessage("AloftPlayerTitleData:UpdatePlayerTitleFromUnit(): " .. tostring(unitid) .. "/" .. tostring(dbname) .. "/" .. tostring(prefix) .. "/" .. tostring(storedSuffix))
	if AddPrefixData(dbname, prefix) or AddSuffixData(dbname, storedSuffix) then
		targetNameplate = Aloft:GetTargetNameplate()
		for aloftData in Aloft:IterateVisibleNameplates() do
			if aloftData.name == dbname then -- TODO: figure out if this should also be adjusted for realm
				if (aloftData == targetNameplate) then
					self:AssignValues(aloftData, prefix, suffix, isSeparated)
				else
					self:UpdateNameplate(aloftData, prefix, suffix, isSeparated)
				end
			end
		end
	end
	-- ChatFrame7:AddMessage("AloftPlayerTitleData:UpdatePlayerTitleFromUnit(): " .. tostring(unitid) .. "/" .. tostring(dbname) .. "/" .. tostring(playerTitlePrefixes[dbname]) .. "/" .. tostring(self.db.realm.playerTitlePrefixData[dbname]) .. "/" .. tostring(playerTitleSuffixes[dbname]) .. "/" .. tostring(self.db.realm.playerTitleSuffixData[dbname]))
end

function AloftPlayerTitleData:UpdatePlayerTitleFromMouseOver(message)
	self:UpdatePlayerTitleFromUnit("mouseover")
end

function AloftPlayerTitleData:UpdatePlayerTitleFromTarget(message)
	-- add a frame delay on target change
	self:ScheduleTimer(function(unitid) AloftPlayerTitleData:UpdatePlayerTitleFromUnit(unitid) end, 0.0, "target") -- next frame, for target
end

--[[
function AloftPlayerTitleData:OnNameplateHide(message, aloftData)
	aloftData.playerTitlePrefix = nil
	aloftData.playerTitleSuffix = nil
	aloftData.isTitleSeparated = nil
end
]]

-----------------------------------------------------------------------------

function AloftPlayerTitleData:PerformTitleTest(tooltip, raw, ordinal, name)
	local test = raw:format(name)

	local title, match = tooltip:gsub(test, ordinal)
	if match == 0 then title = nil end
	return match > 0, title
end

function AloftPlayerTitleData:ValidateNameplate(aloftData, prefix, suffix)
	if aloftData.type == "friendlyPlayer" or aloftData.type == "hostilePlayer" or aloftData.type == "hostile" then
		return true
	end
	return false
end

function AloftPlayerTitleData:UpdateNameplate(aloftData, prefix, suffix, isSeparated)
	if self:ValidateNameplate(aloftData, prefix, suffix) then
		self:AssignValues(aloftData, prefix, suffix, isSeparated)
	else
		aloftData.playerTitlePrefix = nil
		aloftData.playerTitleSuffix = nil
		aloftData.isTitleSeparated = nil
	end
end

function AloftPlayerTitleData:AssignValues(aloftData, prefix, suffix, isSeparated)
	if (aloftData.playerTitlePrefix ~= prefix) or (aloftData.playerTitleSuffix ~= suffix) then
		aloftData.playerTitlePrefix = prefix
		aloftData.playerTitleSuffix = suffix
		aloftData.isTitleSeparated = isSeparated
		self:SendMessage("Aloft:OnPlayerTitleDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------

end)