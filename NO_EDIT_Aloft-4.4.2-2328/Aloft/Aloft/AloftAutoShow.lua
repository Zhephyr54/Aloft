local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

-- local version, build, date, tocversion = GetBuildInfo()

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

local AloftAutoShow = Aloft:NewModule("AutoShow", Aloft, "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
AloftAutoShow.dynamic = "AloftAutoShow"

-----------------------------------------------------------------------------

AloftAutoShow.namespace = "autoShow"
AloftAutoShow.defaults =
{
	profile =
	{
		bounceMotion	= false,

		allMotion		= false,
		allEnemyEnable	= true,
		allFriendEnable	= false,

		motionStyle = 1,

		motion =
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
	},
}

-----------------------------------------------------------------------------

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
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftAutoShow:OnEnable()
	-- ChatFrame7:AddMessage("AloftAutoShow:OnEnable(): nameplateMotion " .. tostring(GetCVar("nameplateMotion")))

	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:RegisterEvents()
	self:HookNameplates()

	-- turn namplates on/off based on current state
	-- ChatFrame7:AddMessage("AloftAutoShow:OnEnable(): " .. tostring(self.db) .. "/" .. tostring(self.db and self.db.profile) .. "/" .. tostring(self.db and self.db.profile and self.db.profile.friendlyTotem))
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:UnhookAll()
end

-----------------------------------------------------------------------------

function AloftAutoShow:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

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
	self:RawHook(Aloft, "SetEnemyNameplateDisplay")
	self:RawHook(Aloft, "SetFriendNameplateDisplay")
end

-----------------------------------------------------------------------------

function AloftAutoShow:OnPlayerRegenDisabled(event)
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnPlayerRegenEnabled(event)
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnPlayerUpdateResting(event)
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnRaidRosterUpdate(event)
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnPartyMembersChanged(event)
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnArenaTeamRosterUpdate(event)
	self:ApplyNameplateDisplay()
end

function AloftAutoShow:OnPlayerEnteringWorld(event)
	self:ApplyNameplateDisplay()
end

-----------------------------------------------------------------------------

function AloftAutoShow:GetEnemyNameplateDisplay()
	return self:GetNameplateConfig(self.db.profile.enemy)
end

function AloftAutoShow:SetEnemyNameplateDisplay(this, value)
	-- ChatFrame7:AddMessage("AloftAutoShow:SetEnemyNameplateDisplay(): " .. tostring(version) .. "/" .. tostring(tocversion))
	if self.db.profile.allEnemyEnable then
		-- ChatFrame7:AddMessage("AloftAutoShow:SetEnemyNameplateDisplay(): " .. tostring(value))
		self:SetAllEnemyNameplateDisplay(value)
	else
		self:SetNameplateConfig(self.db.profile.enemy, value)
	end

	self:ApplyAllNameplateConfig()
end

function AloftAutoShow:SetAllEnemyNameplateDisplay(value)
	-- ChatFrame7:AddMessage("AloftAutoShow:SetAllEnemyNameplateDisplay(): " .. tostring(version) .. "/" .. tostring(tocversion))
	self:SetAllNameplateConfig(self.db.profile.enemyTotem, value)
	self:SetAllNameplateConfig(self.db.profile.enemyGuardian, value)
	self:SetAllNameplateConfig(self.db.profile.enemyPet, value)

	self:SetAllNameplateConfig(self.db.profile.enemy, value)
end

function AloftAutoShow:GetFriendNameplateDisplay()
	return self:GetNameplateConfig(self.db.profile.friendly)
end

-----------------------------------------------------------------------------

function AloftAutoShow:SetFriendNameplateDisplay(this, value)
	-- ChatFrame7:AddMessage("AloftAutoShow:SetFriendNameplateDisplay(): " .. tostring(version) .. "/" .. tostring(tocversion))
	if self.db.profile.allFriendEnable then
		-- ChatFrame7:AddMessage("AloftAutoShow:SetFriendNameplateDisplay(): " .. tostring(value))
		self:SetAllFriendNameplateDisplay(value)
	else
		self:SetNameplateConfig(self.db.profile.friendly, value)
	end

	self:ApplyAllNameplateConfig()
end

function AloftAutoShow:SetAllFriendNameplateDisplay(value)
	-- ChatFrame7:AddMessage("AloftAutoShow:SetAllFriendNameplateDisplay(): " .. tostring(version) .. "/" .. tostring(tocversion))
	self:SetAllNameplateConfig(self.db.profile.friendlyTotem, value)
	self:SetAllNameplateConfig(self.db.profile.friendlyGuardian, value)
	self:SetAllNameplateConfig(self.db.profile.friendlyPet, value)

	self:SetAllNameplateConfig(self.db.profile.friendly, value)
end

-----------------------------------------------------------------------------

function AloftAutoShow:SetAllNameplateMotion(value)
	-- ChatFrame7:AddMessage("AloftAutoShow:SetAllNameplateMotion(): " .. tostring(version) .. "/" .. tostring(tocversion))
	self:SetAllNameplateConfig(self.db.profile.motion, value)
end

-----------------------------------------------------------------------------

function AloftAutoShow:GetNameplateConfig(data)
	if not data then
		-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfig(): no data/" .. tostring(data))
		return nil
	end

	local stateValue = nil
	if UnitAffectingCombat("player") then
		stateValue = data.state.combat
	elseif UnitIsPVP("player") or UnitIsPVPFreeForAll("player") then
		stateValue = data.state.flagged
	elseif IsResting() then
		stateValue = data.state.resting
	elseif (GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0) then
		stateValue = data.state.group
	else
		stateValue = data.state.default
	end

	local placeValue
	local place = Aloft:GetPlace()
	if not place then
		placeValue = data.place.world
	elseif place == "pvp" then
		placeValue = data.place.battleground
	elseif place == "arena" then
		placeValue = data.place.arena
	elseif place == "party" then
		placeValue = data.place.party
	elseif place == "raid" then
		placeValue = data.place.raid
	end

	return stateValue and placeValue
end

-- throw-away code, not used except when debugging
function AloftAutoShow:GetNameplateConfigDebug(data)
	if not data then
		-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfigDebug(): no data/" .. tostring(data))
		return nil
	end

	local stateValue = nil
	if UnitAffectingCombat("player") then
		stateValue = data.state.combat
		-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfigDebug(): combat " .. tostring(stateValue))
	elseif UnitIsPVP("player") or UnitIsPVPFreeForAll("player") then
		stateValue = data.state.flagged
		-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfigDebug(): flagged " .. tostring(stateValue))
	elseif IsResting() then
		stateValue = data.state.resting
		-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfigDebug(): resting " .. tostring(stateValue))
	elseif (GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0) then
		stateValue = data.state.group
		-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfigDebug(): group " .. tostring(stateValue))
	else
		stateValue = data.state.default
		-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfigDebug(): default " .. tostring(stateValue))
	end

	local placeValue
	local place = Aloft:GetPlace()
	if not place then
		placeValue = data.place.world
		-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfigDebug(): world " .. tostring(placeValue))
	elseif place == "pvp" then
		placeValue = data.place.battleground
		-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfigDebug(): battleground " .. tostring(placeValue))
	elseif place == "arena" then
		placeValue = data.place.arena
		-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfigDebug(): arena " .. tostring(placeValue))
	elseif place == "party" then
		placeValue = data.place.party
		-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfigDebug(): party " .. tostring(placeValue))
	elseif place == "raid" then
		placeValue = data.place.raid
		-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfigDebug(): raid " .. tostring(placeValue))
	end

	-- ChatFrame7:AddMessage("AloftAutoShow:GetNameplateConfigDebug(): result " .. tostring(stateValue and placeValue))
	return stateValue and placeValue
end

function AloftAutoShow:SetNameplateConfig(data, value)
	if not data then return nil end

	if UnitAffectingCombat("player") then
		data.state.combat = value
	elseif UnitIsPVP("player") or UnitIsPVPFreeForAll("player") then
		data.state.flagged = value
	elseif IsResting() then
		data.state.resting = value
	elseif (GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0) then
		data.state.group = value
	else
		data.state.default = value
	end

	local place = Aloft:GetPlace()
	if not place then
		data.place.world = value
	elseif instanceType == "pvp" then
		data.place.battleground = value
	elseif instanceType == "arena" then
		data.place.arena = value
	elseif instanceType == "party" then
		data.place.party = value
	elseif instanceType == "raid" then
		data.place.raid = value
	end
end

function AloftAutoShow:SetAllNameplateConfig(data, value)
	if not data then return nil end

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
	-- ChatFrame7:AddMessage("AloftAutoShow:ApplyNameplateDisplay(): " .. tostring(self.db) .. "/" .. tostring(self.db and self.db.profile) .. "/" .. tostring(self.db and self.db.profile and self.db.profile.friendlyTotem))
	self:ApplyAllNameplateConfig()
end

function AloftAutoShow:ApplyNameplateConfig(cVar, which, value1, value2)
	-- ChatFrame7:AddMessage("AloftAutoShow:ApplyNameplateConfig(): " .. tostring(cVar) .. "/" .. tostring(data))
	Aloft:SetNameplateCVarX(cVar, which, value1, value2)
end

function AloftAutoShow:ApplyAllNameplateConfig()
	-- ChatFrame7:AddMessage("AloftAutoShow:ApplyAllNameplateConfig(): " .. tostring(version) .. "/" .. tostring(tocversion))
	-- ChatFrame7:AddMessage("AloftAutoShow:ApplyAllNameplateConfig(): " .. tostring(self.db) .. "/" .. tostring(self.db and self.db.profile) .. "/" .. tostring(self.db and self.db.profile and self.db.profile.friendlyTotem))
	-- ChatFrame7:AddMessage("AloftAutoShow:ApplyAllNameplateConfig(): context " .. tostring(self) .. "/" .. tostring(self.db) .. "/" .. tostring(self.db.profile) .. "/" .. tostring(self.db.profile.motion))

	self:ApplyNameplateConfig("nameplateShowFriendlyTotems", self:GetNameplateConfig(self.db.profile.friendlyTotem), 1, 0)
	self:ApplyNameplateConfig("nameplateShowFriendlyGuardians", self:GetNameplateConfig(self.db.profile.friendlyGuardian), 1, 0)
	self:ApplyNameplateConfig("nameplateShowFriendlyPets", self:GetNameplateConfig(self.db.profile.friendlyPet), 1, 0)

	self:ApplyNameplateConfig("nameplateShowFriends", self:GetNameplateConfig(self.db.profile.friendly), 1, 0)

	self:ApplyNameplateConfig("nameplateShowEnemyTotems", self:GetNameplateConfig(self.db.profile.enemyTotem), 1, 0)
	self:ApplyNameplateConfig("nameplateShowEnemyGuardians", self:GetNameplateConfig(self.db.profile.enemyGuardian), 1, 0)
	self:ApplyNameplateConfig("nameplateShowEnemyPets", self:GetNameplateConfig(self.db.profile.enemyPet), 1, 0)

	self:ApplyNameplateConfig("nameplateShowEnemies", self:GetNameplateConfig(self.db.profile.enemy), 1, 0)

	local previousMotion = tonumber(Aloft:GetNameplateCVarX("nameplateMotion"))
	self:ApplyNameplateConfig("nameplateMotion", self:GetNameplateConfig(self.db.profile.motion), self.db.profile.motionStyle, 0)
	-- ChatFrame7:AddMessage("AloftAutoShow:ApplyAllNameplateConfig(): config " .. tostring(previousMotion) .. "/" .. tostring(self:GetNameplateConfigDebug(self.db.profile.motion)) .. "/" .. tostring(Aloft:GetNameplateCVar("nameplateMotion")) .. "/" .. tostring(self.db.profile.motion.state.resting) .. "/" .. tostring(self.db.profile.motion.place.world) --[[ .. "/" .. tostring(self.db.profile.motion) ]] )

	-- local nameplateMotion = GetCVar("nameplateMotion")
	-- local nameplateMotion = Aloft:GetNameplateCVar("nameplateMotion")
	-- ChatFrame7:AddMessage("AloftAutoShow:ApplyAllNameplateConfig(): nameplateMotion " .. tostring(nameplateMotion) .. "/" .. tostring(type(nameplateMotion)) .. "/" .. tostring(self:GetNameplateConfig(self.db.profile.motion)) .. "/" .. tostring(previousMotion) .. "/" .. tostring(self.db.profile.bounceMotion))

	if self.db.profile.bounceMotion and previousMotion ~= tonumber(Aloft:GetNameplateCVarX("nameplateMotion")) then
		-- ChatFrame7:AddMessage("AloftAutoShow:ApplyAllNameplateConfig(): bounce")
		Aloft:BounceEnemyNameplates()
		Aloft:BounceFriendNameplates()
	end
end

-----------------------------------------------------------------------------

end)
