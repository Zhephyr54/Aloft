local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local version, build, date, tocversion = GetBuildInfo()

--[[
	nameplateShowFriends = { text = "UNIT_NAMEPLATES_SHOW_FRIENDS" },
	nameplateShowFriendlyPets = { text = "UNIT_NAMEPLATES_SHOW_FRIENDLY_PETS" },
	nameplateShowFriendlyGuardians = { text = "UNIT_NAMEPLATES_SHOW_FRIENDLY_GUARDIANS" },
	nameplateShowFriendlyTotems = { text = "UNIT_NAMEPLATES_SHOW_FRIENDLY_TOTEMS" },
	nameplateShowEnemies = { text = "UNIT_NAMEPLATES_SHOW_ENEMIES" },
	nameplateShowEnemyPets = { text = "UNIT_NAMEPLATES_SHOW_ENEMY_PETS" },
	nameplateShowEnemyGuardians = { text = "UNIT_NAMEPLATES_SHOW_ENEMY_GUARDIANS" },
	nameplateShowEnemyTotems = { text = "UNIT_NAMEPLATES_SHOW_ENEMY_TOTEMS" },
	nameplateAllowOverlap = { text = "UNIT_NAMEPLATES_ALLOW_OVERLAP" },
]]

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

local AloftAutoShow = Aloft:NewModule("AutoShow", "AceEvent-2.0", "AceHook-2.1")
AloftAutoShow.dynamic = "AloftAutoShow"

-----------------------------------------------------------------------------

AloftAutoShow.db = Aloft:AcquireDBNamespace("autoShow")
Aloft:RegisterDefaults("autoShow", "profile", {
	bounceOverlap	= false,

	allOverlap		= false,
	allEnemyEnable	= true,
	allFriendEnable	= false,

	overlap =
	{
		state =
		{
			combat			= false,
			flagged			= false,
			group			= false,
			resting			= false,
			default			= false,
		},
		place =
		{
			world			= false,
			battleground	= false,
			arena			= false,
			party			= false,
			raid			= false,
		},
	},

	friendly =
	{
		state =
		{
			combat			= false,
			flagged			= false,
			group			= false,
			resting			= false,
			default			= false,
		},
		place =
		{
			world			= false,
			battleground	= false,
			arena			= false,
			party			= false,
			raid			= false,
		},
	},
	friendlyPet =
	{
		state =
		{
			combat			= false,
			flagged			= false,
			group			= false,
			resting			= false,
			default			= false,
		},
		place =
		{
			world			= false,
			battleground	= false,
			arena			= false,
			party			= false,
			raid			= false,
		},
	},
	friendlyGuardian =
	{
		state =
		{
			combat			= false,
			flagged			= false,
			group			= false,
			resting			= false,
			default			= false,
		},
		place =
		{
			world			= false,
			battleground	= false,
			arena			= false,
			party			= false,
			raid			= false,
		},
	},
	friendlyTotem =
	{
		state =
		{
			combat			= false,
			flagged			= false,
			group			= false,
			resting			= false,
			default			= false,
		},
		place =
		{
			world			= false,
			battleground	= false,
			arena			= false,
			party			= false,
			raid			= false,
		},
	},

	enemy =
	{
		state =
		{
			combat			= true,
			flagged			= true,
			group			= true,
			resting			= true,
			default			= true,
		},
		place =
		{
			world			= true,
			battleground	= true,
			arena			= true,
			party			= true,
			raid			= true,
		},
	},
	enemyPet =
	{
		state =
		{
			combat			= true,
			flagged			= true,
			group			= true,
			resting			= true,
			default			= true,
		},
		place =
		{
			world			= true,
			battleground	= true,
			arena			= true,
			party			= true,
			raid			= true,
		},
	},
	enemyGuardian =
	{
		state =
		{
			combat			= true,
			flagged			= true,
			group			= true,
			resting			= true,
			default			= true,
		},
		place =
		{
			world			= true,
			battleground	= true,
			arena			= true,
			party			= true,
			raid			= true,
		},
	},
	enemyTotem =
	{
		state =
		{
			combat			= true,
			flagged			= true,
			group			= true,
			resting			= true,
			default			= true,
		},
		place =
		{
			world			= true,
			battleground	= true,
			arena			= true,
			party			= true,
			raid			= true,
		},
	},
})

-----------------------------------------------------------------------------

local profile

local IsInInstance = IsInInstance
local IsResting = IsResting
local GetNumPartyMembers = GetNumPartyMembers
local GetNumRaidMembers = GetNumRaidMembers
local UnitAffectingCombat = UnitAffectingCombat
local UnitIsPVP = UnitIsPVP
local UnitIsPVPFreeForAll = UnitIsPVPFreeForAll

local unpack = unpack

-----------------------------------------------------------------------------

function AloftAutoShow:OnInitialize()
	profile = self.db.profile
end

function AloftAutoShow:OnEnable()
	self:RegisterEvents()
	self:HookNameplates()

	-- turn on/off namplates based on current state
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnDisable()
	self:UnregisterAllEvents()
	self:UnhookAll()
end

-----------------------------------------------------------------------------

function AloftAutoShow:RegisterEvents()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnPlayerRegenDisabled")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnPlayerRegenEnabled")
	self:RegisterEvent("PLAYER_UPDATE_RESTING", "OnPlayerUpdateResting")
	self:RegisterEvent("RAID_ROSTER_UPDATE", "OnRaidRosterUpdate")
	self:RegisterEvent("PARTY_MEMBERS_CHANGED", "OnPartyMembersChanged")
	-- self:RegisterEvent("ARENA_TEAM_ROSTER_UPDATE", "OnArenaTeamRosterUpdate") -- TODO: determine if this is even needed; this fires repeatedly when things change; don't know what to do about it
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnPlayerEnteringWorld")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA","OnPlayerEnteringWorld")
end

function AloftAutoShow:HookNameplates()
	self:UnhookAll()

	-- ChatFrame7:AddMessage("AloftAutoShow:HookNameplates(): enter")
	self:Hook(Aloft, "SetEnemyNameplateDisplay")
	self:Hook(Aloft, "SetFriendNameplateDisplay")
end

-----------------------------------------------------------------------------

function AloftAutoShow:OnPlayerRegenDisabled()
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnPlayerRegenEnabled()
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnPlayerUpdateResting()
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnRaidRosterUpdate()
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnPartyMembersChanged()
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnArenaTeamRosterUpdate()
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnPlayerEnteringWorld()
	self:ApplyNameplateDisplay()
end

-----------------------------------------------------------------------------

function AloftAutoShow:GetEnemyNameplateDisplay()
	return self:GetNameplateConfig(profile.enemy)
end

function AloftAutoShow:SetEnemyNameplateDisplay(this, value)
	-- ChatFrame7:AddMessage("AloftAutoShow:SetEnemyNameplateDisplay(): " .. tostring(version) .. "/" .. tostring(tocversion))
	if profile.allEnemyEnable then
		self:SetAllEnemyNameplateDisplay(value)
	else
		self:SetNameplateConfig(profile.enemy, value)
	end

	self:ApplyAllNameplateConfig()
end

function AloftAutoShow:SetAllEnemyNameplateDisplay(value)
	-- ChatFrame7:AddMessage("AloftAutoShow:SetAllEnemyNameplateDisplay(): " .. tostring(version) .. "/" .. tostring(tocversion))
	self:SetAllNameplateConfig(profile.enemyTotem, value)
	self:SetAllNameplateConfig(profile.enemyGuardian, value)
	self:SetAllNameplateConfig(profile.enemyPet, value)

	self:SetAllNameplateConfig(profile.enemy, value)
end

function AloftAutoShow:GetFriendNameplateDisplay()
	return self:GetNameplateConfig(profile.friendly)
end

-----------------------------------------------------------------------------

function AloftAutoShow:SetFriendNameplateDisplay(this, value)
	-- ChatFrame7:AddMessage("AloftAutoShow:SetFriendNameplateDisplay(): " .. tostring(version) .. "/" .. tostring(tocversion))
	if profile.allFriendEnable then
		self:SetAllFriendNameplateDisplay(value)
	else
		self:SetNameplateConfig(profile.friendly, value)
	end

	self:ApplyAllNameplateConfig()
end

function AloftAutoShow:SetAllFriendNameplateDisplay(value)
	-- ChatFrame7:AddMessage("AloftAutoShow:SetAllFriendNameplateDisplay(): " .. tostring(version) .. "/" .. tostring(tocversion))
	self:SetAllNameplateConfig(profile.friendlyTotem, value)
	self:SetAllNameplateConfig(profile.friendlyGuardian, value)
	self:SetAllNameplateConfig(profile.friendlyPet, value)

	self:SetAllNameplateConfig(profile.friendly, value)
end

-----------------------------------------------------------------------------

function AloftAutoShow:SetAllNameplateOverlap(value)
	-- ChatFrame7:AddMessage("AloftAutoShow:SetAllNameplateOverlap(): " .. tostring(version) .. "/" .. tostring(tocversion))
	self:SetAllNameplateConfig(profile.overlap, value)
end

-----------------------------------------------------------------------------

function AloftAutoShow:GetNameplateConfig(data)
	local stateValue
	if UnitAffectingCombat("player") then
		stateValue = data.state.combat
	elseif UnitIsPVP("player") or UnitIsPVPFreeForAll("player") then
		stateValue = data.state.flagged
	elseif IsResting() then
		stateValue = data.state.resting
	elseif (GetNumPartyMembers() > 0)  or (GetNumRaidMembers() > 0) then
		stateValue = data.state.group
	else
		stateValue = data.state.default
	end

	local placeValue
	local inInstance, instanceType = IsInInstance()
	if inInstance and instanceType ~= "none"then
		if instanceType == "pvp" then
			placeValue = data.place.battleground
		elseif instanceType == "arena" then
			placeValue = data.place.arena
		elseif instanceType == "party" then
			placeValue = data.place.party
		elseif instanceType == "raid" then
			placeValue = data.place.raid
		else
			placeValue = data.place.world
		end
	else
		placeValue = data.place.world
	end

	return stateValue and placeValue
end

function AloftAutoShow:SetNameplateConfig(data, value)
	if UnitAffectingCombat("player") then
		data.state.combat = value
	elseif UnitIsPVP("player") or UnitIsPVPFreeForAll("player") then
		data.state.flagged = value
	elseif IsResting() then
		data.state.resting = value
	elseif (GetNumPartyMembers() > 0)  or (GetNumRaidMembers() > 0) then
		data.state.group = value
	else
		data.state.default = value
	end

	local inInstance, instanceType = IsInInstance()
	if inInstance and instanceType ~= "none"then
		if instanceType == "pvp" then
			data.place.battleground = value
		elseif instanceType == "arena" then
			data.place.arena = value
		elseif instanceType == "party" then
			data.place.party = value
		elseif instanceType == "raid" then
			data.place.raid = value
		else
			data.place.world = value
		end
	else
		data.place.world = value
	end
end

function AloftAutoShow:SetAllNameplateConfig(data, value)
	data.state.combat = value
	data.state.flagged = value
	data.state.resting = value
	data.state.group = value
	data.state.default = value

	data.place.battleground = value
	data.place.arena = value
	data.place.party = value
	data.place.raid = value
	data.place.world = value
end

-----------------------------------------------------------------------------

function AloftAutoShow:ApplyNameplateDisplay()
	self:ApplyAllNameplateConfig()
end

function AloftAutoShow:ApplyNameplateConfig(cVar, data)
	Aloft:SetNameplateCVar(cVar, self:GetNameplateConfig(data))
end

function AloftAutoShow:ApplyAllNameplateConfig()
	-- ChatFrame7:AddMessage("AloftAutoShow:ApplyAllNameplateConfig(): " .. tostring(version) .. "/" .. tostring(tocversion))

	self:ApplyNameplateConfig("nameplateShowFriendlyTotems", profile.friendlyTotem)
	self:ApplyNameplateConfig("nameplateShowFriendlyGuardians", profile.friendlyGuardian)
	self:ApplyNameplateConfig("nameplateShowFriendlyPets", profile.friendlyPet)

	self:ApplyNameplateConfig("nameplateShowFriends", profile.friendly)

	self:ApplyNameplateConfig("nameplateShowEnemyTotems", profile.enemyTotem)
	self:ApplyNameplateConfig("nameplateShowEnemyGuardians", profile.enemyGuardian)
	self:ApplyNameplateConfig("nameplateShowEnemyPets", profile.enemyPet)

	self:ApplyNameplateConfig("nameplateShowEnemies", profile.enemy)

	local previousOverlap = profile.bounceOverlap and Aloft:GetNameplateCVar("nameplateAllowOverlap")
	self:ApplyNameplateConfig("nameplateAllowOverlap", profile.overlap)
	if profile.bounceOverlap and previousOverlap ~= Aloft:GetNameplateCVar("nameplateAllowOverlap") then
		Aloft:BounceEnemyNameplates()
		Aloft:BounceFriendNameplates()
	end
end

-----------------------------------------------------------------------------

end)
