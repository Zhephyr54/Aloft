local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPlayerTitle", function()

-----------------------------------------------------------------------------

local AloftPlayerTitleData = Aloft:NewModule("PlayerTitleData", "AceEvent-2.0")
AloftPlayerTitleData.dynamic = "AloftPlayerTitle"

local L = AceLibrary("AceLocale-2.2"):new("AloftPlayerTitleData")
local gratuity = AceLibrary("LibGratuity-3.0")
local roster = AceLibrary("Roster-2.1")

-----------------------------------------------------------------------------

AloftPlayerTitleData.db = Aloft:AcquireDBNamespace("titleData")
Aloft:RegisterDefaults("titleData", "server", { playerTitlePrefixData = { }, playerTitleSuffixData = { } })
Aloft:RegisterDefaults("titleData", "profile", { save = false })

-----------------------------------------------------------------------------

local playerTitlePrefixes = { }
local playerTitleSuffixes = { }

local PREFIX_TEST	= "PrefixTest"
local SUFFIX_TEST1	= "SuffixTest1"
local SUFFIX_TEST2	= "SuffixTest2"

local SUFFIX_SEP = ":" -- separator string

local titleTests =
{
	[PREFIX_TEST]	= L[PREFIX_TEST],
	[SUFFIX_TEST1]	= L[SUFFIX_TEST1],
	[SUFFIX_TEST2]	= L[SUFFIX_TEST2],
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
		-- if (Aloft:IsLogEnbl("PlayerTitleData", 5)) then Aloft:Log("PlayerTitleData", "TagData.PlayerTitleSuffixSeparated.method", 5, tostring(data.isTitleSeparated) .. "/" .. tostring(data.playerTitleSuffix) .. "/" .. tostring(sep1) .. "/" .. tostring(sep2) .. "/") end
		return (value and data.playerTitleSuffix and ((data.isTitleSeparated and sep1) or sep2) .. data.playerTitleSuffix) or ""
	end,
	noGuaranteeChange = true,
	parameterTypes = { "string", "string" }
}

-----------------------------------------------------------------------------

function AloftPlayerTitleData.SetSaveData(v)
	AloftPlayerTitleData.db.profile.save = v
	AloftPlayerTitleData.db.server.playerTitlePrefixData = (v and playerTitlePrefixes) or { }
	AloftPlayerTitleData.db.server.playerTitleSuffixData = (v and playerTitleSuffixes) or { }
end

function AloftPlayerTitleData:ProvidesData()
	return "playerTitlePrefix", "playerTitleSuffix"
end

function AloftPlayerTitleData:RegisterEvents()
	self:UnregisterAllEvents()

	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdatePlayerTitleFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdatePlayerTitleFromTarget")
	--self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
end

function AloftPlayerTitleData:EnableDataSource()
	self:RegisterEvents()
end

function AloftPlayerTitleData:UpdateData(aloftData)
	if aloftData.name == L["Unknown"] then return end

	aloftData.playerTitlePrefix = nil
	aloftData.playerTitleSuffix = nil

	-- recover SavedVariables stored data
	local suffix = nil
	local isSeparated = nil
	local storedSuffix = playerTitleSuffixes[aloftData.name]
	if storedSuffix and (storedSuffix:byte(1) == SUFFIX_SEP:byte(1)) then
		isSeparated = true
		suffix = storedSuffix:sub(2) -- strip off initial character/separator
	else
		suffix = storedSuffix -- use whole string
	end

	-- apply to nameplate
	self:UpdateNameplate(aloftData, playerTitlePrefixes[aloftData.name], suffix, isSeparated)
end

-----------------------------------------------------------------------------

function AloftPlayerTitleData:OnInitialize()
end

function AloftPlayerTitleData:OnEnable()
	if self.db.profile.save then
		playerTitlePrefixes = self.db.server.playerTitlePrefixData
		playerTitleSuffixes = self.db.server.playerTitleSuffixData
	else
		playerTitlePrefixes = { }
		playerTitleSuffixes = { }
	end
end


function AloftPlayerTitleData:OnDisable()
end

-----------------------------------------------------------------------------

local currentRealm = GetRealmName()
function AloftPlayerTitleData:UpdatePlayerTitleFromUnit(unitid)
	if not UnitIsPlayer(unitid) then return end
	if not UnitIsFriend("player", unitid) and not UnitIsPVP(unitid) then return end

	local name, realm = UnitName(unitid)
	if name == L["Unknown"] then return end

	gratuity:SetUnit(unitid)

	local tooltip = gratuity:GetLine(1)
	if not name or not tooltip or tooltip == "" or not tooltip:find(name) then return end
	if realm and (realm ~= currentRealm) then return end -- TODO: disable this when we figure out cross-realm tooltip formatting
	-- try to make certain we have a good tooltip, containing the unit's name, and not for a cross-realm player

	local prefix
	local suffix
	local storedSuffix
	local isSeparated
	local xname = name
	local dbname = name
	--[[ TODO: enable this when we figure out cross-realm tooltip formatting
	if realm and (realm ~= currentRealm) then
		xname = name .. " - " .. realm -- TODO: the problem is here... how are cross-realm tooltips formatted?
		dbname = name .. "-" .. realm
	end
	-- if (Aloft:IsLogEnbl("PlayerTitleData", 5)) then Aloft:Log("PlayerTitleData", "UpdatePlayerTitleFromUnit", 5, tostring(currentRealm) .. "/" .. tostring(realm) .. "/" .. tostring(xname) .. "/" .. tostring(tooltip)) end
	]]

	-- only one title can be active at once; stop parsing as soon as we find it
	_, prefix = self:PerformTitleTest(tooltip, titleTests[PREFIX_TEST], "%1", xname)
	if not prefix then
		_, suffix = self:PerformTitleTest(tooltip, titleTests[SUFFIX_TEST1], "%2", xname)
		if not suffix then
			_, suffix = self:PerformTitleTest(tooltip, titleTests[SUFFIX_TEST2], "%2", xname)
		else
			isSeparated = true
		end
	end

	-- format SavedVariables storage if the original title contained a separator
	if isSeparated then
		storedSuffix = SUFFIX_SEP .. suffix
	else
		storedSuffix = suffix
	end

	if playerTitlePrefixes[dbname] ~= prefix or playerTitleSuffixes[dbname] ~= storedSuffix then
		playerTitlePrefixes[dbname] = prefix
		playerTitleSuffixes[dbname] = storedSuffix
		targetNameplate = Aloft:GetTargetNameplate()
		for aloftData in Aloft:IterateVisibleNameplates() do
			if aloftData.name == name then -- TODO: figure out if this should also be adjusted for realm
				if (aloftData == targetNameplate) then
					self:AssignValues(aloftData, prefix, suffix, isSeparated)
				else
					self:UpdateNameplate(aloftData, prefix, suffix, isSeparated)
				end
			end
		end
	end
end

function AloftPlayerTitleData:UpdatePlayerTitleFromMouseOver()
	self:UpdatePlayerTitleFromUnit("mouseover")
end

function AloftPlayerTitleData:UpdatePlayerTitleFromTarget()
	-- add a frame delay on target change
	local eventName = "AloftPlayerTitleData:UpdatePlayerTitleFromUnit:" .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.UpdatePlayerTitleFromUnit, 0.0, self, "target") -- next frame, for target
end

--[[
function AloftPlayerTitleData:OnNameplateHide(aloftData)
	aloftData.playerTitlePrefix = nil
	aloftData.playerTitleSuffix = nil
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
		self:TriggerEvent("Aloft:OnPlayerTitleDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------

end)
