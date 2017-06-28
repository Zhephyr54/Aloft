local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

local AloftVisibility = Aloft:NewModule("Visibility", "AceEvent-2.0")
AloftVisibility.dynamic = "AloftVisibility"

local AloftAlpha = Aloft:HasModule("Alpha") and Aloft:GetModule("Alpha")

local L = AceLibrary("AceLocale-2.2"):new("AloftVisibilityData")
local oT = AceLibrary("AceLocale-2.2"):new("AloftVisibilityTotems")

-----------------------------------------------------------------------------

AloftVisibility.db = Aloft:AcquireDBNamespace("visibility")
Aloft:RegisterDefaults("visibility", "profile", {
	showHostilePlayers = true,
	showHostilePets = true,
	showHostileNPCs = true,

	friendlyPlayers = "ALL",
	showPet = true,
	showGroupPets = true,
	showFriendlyPets = true,
	showFriendlyNPCs = true,

	showNeutralUnits = true,

	showCritters = true,
	critterLevel = 1,
	critterHealth = 8,

	useAlpha = true, -- now restricted to combat, not a generic alternative to "hiding"

	showHostileTotems = true,
	enableHostileTotem =
	{
		[oT["Tremor Totem"]]	= false,
		[oT["Grounding Totem"]]	= false,
		[oT["Earthbind Totem"]]	= false,
		[oT["Cleansing Totem"]]	= false,
		[oT["Mana Tide Totem"]]	= false,
	},
	hostileTotemColor =
	{
		[oT["Tremor Totem"]]	= { 1.0, 0.0, 1.0, 1.0, },	-- full magenta
		[oT["Grounding Totem"]]	= { 1.0, 0.0, 1.0, 1.0, },	-- full magenta
		[oT["Earthbind Totem"]]	= { 1.0, 0.0, 1.0, 1.0, },	-- full magenta
		[oT["Cleansing Totem"]]	= { 1.0, 0.0, 1.0, 1.0, },	-- full magenta
		[oT["Mana Tide Totem"]]	= { 1.0, 0.0, 1.0, 1.0, },	-- full magenta
	},

	showFriendlyTotems = true,
	enableFriendlyTotem =
	{
		[oT["Tremor Totem"]]	= false,
		[oT["Grounding Totem"]]	= false,
		[oT["Earthbind Totem"]]	= false,
		[oT["Cleansing Totem"]]	= false,
		[oT["Mana Tide Totem"]]	= false,
	},
	friendlyTotemColor =
	{
		[oT["Tremor Totem"]]	= { 1.0, 0.0, 1.0, 1.0, },	-- full magenta
		[oT["Grounding Totem"]]	= { 1.0, 0.0, 1.0, 1.0, },	-- full magenta
		[oT["Earthbind Totem"]]	= { 1.0, 0.0, 1.0, 1.0, },	-- full magenta
		[oT["Cleansing Totem"]]	= { 1.0, 0.0, 1.0, 1.0, },	-- full magenta
		[oT["Mana Tide Totem"]]	= { 1.0, 0.0, 1.0, 1.0, },	-- full magenta
	},

	enableHideUnitNames = false,
	hideUnitNames = { },
})

-----------------------------------------------------------------------------

local profile
local inCombat

local InCombatLockdown = InCombatLockdown

AloftVisibility.UnitNameDST = { }

-----------------------------------------------------------------------------

function AloftVisibility:Update()
	self:RegisterEvents()

	-- Toggle the visibility to get previously hidden stuff to show
	Aloft:BounceEnemyNameplates()
	Aloft:BounceFriendNameplates()
end

function AloftVisibility:RegisterEvents()
	self:UnregisterAllEvents()

	if profile then
		self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnPlayerRegenDisabled")
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnPlayerRegenEnabled")

		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")

		if not profile.showHostilePlayers then
			self:RegisterEvent("Aloft:OnClassDataChanged", "OnClassDataChanged")
		end

		if profile.showNeutralUnits and not profile.showCritters then
			self:RegisterEvent("Aloft:OnCreatureTypeDataChanged", "OnCreatureTypeDataChanged")
		end

		if not profile.showHostilePets or
		   not profile.showFriendlyPets then
			self:RegisterEvent("Aloft:OnIsPetDataChanged", "OnIsPetDataChanged")
			self:RegisterEvent("Aloft:OnPetOwnersNameDataChanged", "OnIsPetDataChanged")
		end

		if not profile.showCritters or
		   not profile.showHostilePlayers or
		   not profile.showHostilePets or
		   not profile.showHostileNPCs or
		   not profile.showHostileTotems or
		   not profile.showNeutralUnits or
		   not profile.showFriendlyNPCs or
		   not profile.showFriendlyPets or
		   not profile.showGroupPets or
		   not profile.showPet or
		   profile.friendlyPlayers ~= "ALL" then
			self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
			self:RegisterEvent("Aloft:OnUnitidDataChanged", "OnUnitidDataChanged")
		end
	end
end

-----------------------------------------------------------------------------

function AloftVisibility:OnInitialize()
	profile = self.db.profile
end

function AloftVisibility:OnEnable()
	self:RegisterEvents()

	for k, _ in pairs(profile.hideUnitNames) do
		Aloft:AddDST(self.UnitNameDST, k)
	end
end

function AloftVisibility:OnDisable()
	self:UnregisterAllEvents()

	if profile and
	   (not profile.showCritters or
	    not profile.showHostilePlayers or
	    not profile.showHostilePets or
	    not profile.showHostileNPCs or
	    not profile.showHostileTotems or
	    not profile.showNeutralUnits or
	    not profile.showFriendlyNPCs or
	    not profile.showFriendlyPets  or
	    not profile.showGroupPets or
	    not profile.showPet or
	    profile.friendlyPlayers ~= "ALL") then
			Aloft:BounceEnemyNameplates()
			Aloft:BounceFriendNameplates()
	end
end

local dataRequiredList = { }
function AloftVisibility:RequiresData()
	if profile then
		for i = 1,#dataRequiredList do
			dataRequiredList[i] = nil
		end

		--[[
		if not profile.showHostilePlayers then
			table.insert(dataRequiredList, "class")
		end
		]]

		if profile.showHostilePets ~= profile.showHostileNPCs or
		   profile.showFriendlyPets ~= profile.showFriendlyNPCs then
			table.insert(dataRequiredList, "isPet")
			table.insert(dataRequiredList, "petOwnersName")
		end

		if profile.friendlyPlayers == "GUILDONLY" then
			table.insert(dataRequiredList, "isGuildMember")
		end

		if profile.showNeutralUnits and not profile.showCritters then
			table.insert(dataRequiredList, "creatureType")
		end

		if Aloft:IsDataAvailable("unitid") then
			if profile.friendlyPlayers == "GROUPONLY" or
		   	   profile.showGroupPets ~= profile.showFriendlyPets then
				table.insert(dataRequiredList, "unitid")
			end
		end

		return unpack(dataRequiredList)
	end
end

-----------------------------------------------------------------------------

local friendlyPlayerMethods =
{
	["ALL"] = function() end,
	["GUILDONLY"] = function(frame, aloftData)
						if not aloftData.isGuildMember then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					end,
	["GROUPONLY"] =	function(frame, aloftData)
						-- ChatFrame7:AddMessage("AloftVisibility:friendlyPlayerMethods:GROUPONLY(): -----")
						-- ChatFrame7:AddMessage("AloftVisibility:friendlyPlayerMethods:GROUPONLY(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. ((aloftData.unitid == nil and ("/" .. debugstack())) or ""))
						-- ChatFrame7:AddMessage("AloftVisibility:friendlyPlayerMethods:GROUPONLY(): -----")
						if not aloftData.unitid then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					end,
	["NONE"] = function(frame, aloftData) AloftVisibility:DoFrameHide(frame, aloftData) end,
}

local showTypeMethods =
{
	["friendlyPlayer"] = function(frame, aloftData)
							if profile.enableHideUnitNames and Aloft:IsDSTValue(AloftVisibility.UnitNameDST, aloftData.name) then
								AloftVisibility:DoFrameHide(frame, aloftData)
							else
								local friendlyPlayerMethod = friendlyPlayerMethods[profile.friendlyPlayers]
								if friendlyPlayerMethod then
									friendlyPlayerMethod(frame, aloftData)
								end
							end
						end,
	["friendlyNPC"] = function(frame, aloftData)
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods:[friendlyNPC](): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))
						if profile.enableHideUnitNames and Aloft:IsDSTValue(AloftVisibility.UnitNameDST, aloftData.name) then
							AloftVisibility:DoFrameHide(frame, aloftData)
						elseif UnitExists("pet") and UnitName("pet") == aloftData.name then
							-- ChatFrame7:AddMessage("AloftVisibility:friendlyPlayerMethods:[friendlyNPC](): pet " .. tostring(aloftData.name) .. "/" .. tostring(profile.showPet))
							if not profile.showPet then
								AloftVisibility:DoFrameHide(frame, aloftData)
							end
						elseif aloftData.unitid then -- Group pet
							-- ChatFrame7:AddMessage("AloftVisibility:friendlyPlayerMethods:[friendlyNPC](): group pet " .. tostring(aloftData.name) .. "/" .. tostring(profile.showGroupPets))
							if not profile.showGroupPets then
								AloftVisibility:DoFrameHide(frame, aloftData)
							end
						elseif Aloft:IsTotem(aloftData) then
							-- order is important here; totems are effectively pets (they meet the IsPet condition in AloftIsPetData, and they have a pet owner's name)
							-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[friendlyNPC](): totem " .. tostring(aloftData.name) .. "/" .. tostring(profile.showFriendlyTotems) .. "/" .. tostring(Aloft:GetTotemExceptionColor(aloftData)))
							if not profile.showFriendlyTotems and not Aloft:GetTotemExceptionColor(aloftData) then -- a totem or trap snake?
								AloftVisibility:DoFrameHide(frame, aloftData)
							end
						elseif aloftData.isPet or aloftData.petOwnersName then
							-- ChatFrame7:AddMessage("AloftVisibility:friendlyPlayerMethods:[friendlyNPC](): friendly  pet " .. tostring(aloftData.name) .. "/" .. tostring(profile.showFriendlyPets))
							if not profile.showFriendlyPets then
								AloftVisibility:DoFrameHide(frame, aloftData)
							end
						else
							if not profile.showFriendlyNPCs then
								AloftVisibility:DoFrameHide(frame, aloftData)
							end
						end
					  end,
	["neutral"] = function(frame, aloftData)
					if profile.enableHideUnitNames and Aloft:IsDSTValue(AloftVisibility.UnitNameDST, aloftData.name) then
						AloftVisibility:DoFrameHide(frame, aloftData)
					elseif not profile.showNeutralUnits or (not profile.showCritters and aloftData.creatureType == L["Critter"]) then
						AloftVisibility:DoFrameHide(frame, aloftData)
					end
				  end,
	["hostile"] = function(frame, aloftData)
					-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostile](): enter")
					if profile.enableHideUnitNames and Aloft:IsDSTValue(AloftVisibility.UnitNameDST, aloftData.name) then
						AloftVisibility:DoFrameHide(frame, aloftData)
					elseif aloftData.class then -- Is it a player?
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostile](): player " .. tostring(aloftData.name) .. "/" .. tostring(profile.showHostilePlayers))
						if not profile.showHostilePlayers then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					elseif Aloft:IsTotem(aloftData) then
						-- order is important here; totems are effectively pets (they meet the IsPet condition in AloftIsPetData, and they have a pet owner's name)
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostile](): totem " .. tostring(aloftData.name) .. "/" .. tostring(profile.showHostileTotems) .. "/" .. tostring(Aloft:GetTotemExceptionColor(aloftData)))
						if not profile.showHostileTotems and not Aloft:GetTotemExceptionColor(aloftData) then -- a totem or trap snake?
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					elseif aloftData.isPet or aloftData.petOwnersName then -- a pet?
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostile](): pet " .. tostring(aloftData.name) .. "/" .. tostring(profile.showHostilePets))
						if not profile.showHostilePets then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					else -- an NPC?
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostile](): NPC " .. tostring(aloftData.name) .. "/" .. tostring(profile.showHostileNPCs))
						if not profile.showHostileNPCs then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					end
				  end,
	-- TODO: this is a kludge, needs to be cleaned up; if this is really a hostilePlayer, most of this makes no sense
	["hostilePlayer"] = function(frame, aloftData)
					if profile.enableHideUnitNames and Aloft:IsDSTValue(AloftVisibility.UnitNameDST, aloftData.name) then
					-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostilePlayer](): enter")
						AloftVisibility:DoFrameHide(frame, aloftData)
					elseif aloftData.class then -- Is it a player?
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostilePlayer](): player " .. tostring(aloftData.name) .. "/" .. tostring(profile.showHostilePlayers))
						if not profile.showHostilePlayers then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					elseif Aloft:IsTotem(aloftData) then
						-- order is important here; totems are effectively pets (they meet the IsPet condition in AloftIsPetData, and they have a pet owner's name)
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostilePlayer](): totem " .. tostring(aloftData.name) .. "/" .. tostring(profile.showHostileTotems) .. "/" .. tostring(Aloft:GetTotemExceptionColor(aloftData)))
						if profile.showHostileTotems and not Aloft:GetTotemExceptionColor(aloftData) then -- a totem or trap snake?
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					elseif aloftData.isPet or aloftData.petOwnersName then -- a pet?
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostilePlayer](): pet " .. tostring(aloftData.name) .. "/" .. tostring(profile.showHostilePets))
						if not profile.showHostilePets then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					else -- an NPC?
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostilePlayer](): NPC " .. tostring(aloftData.name) .. "/" .. tostring(profile.showHostileNPCs))
						if not profile.showHostileNPCs then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					end
				  end,
	["unknown"] = function() end,
}

function AloftVisibility:OnClassDataChanged(aloftData)
	-- If it was changed, then it must have some value now
	if aloftData.type == "hostilePlayer" or aloftData.type == "hostile" then
		self:OnNameplateShow(aloftData)
	end
end

function AloftVisibility:OnCreatureTypeDataChanged(aloftData)
	if aloftData.type == "neutral" and aloftData.creatureType == L["Critter"] then
		self:OnNameplateShow(aloftData)
	end
end

function AloftVisibility:OnIsPetDataChanged(aloftData)
	if aloftData.type == "friendlyNPC" or aloftData.type == "hostilePlayer" or aloftData.type == "hostile" then
		self:OnNameplateShow(aloftData)
	end
end

function AloftVisibility:OnUnitidDataChanged(aloftData)
	if aloftData.type == "friendlyPlayer" then
		self:OnNameplateShow(aloftData)
	end
end

-- mark the player as being in combat
function AloftVisibility:OnPlayerRegenDisabled()
	-- ChatFrame7:AddMessage("AloftTargetNameData:OnPlayerRegenDisabled(): entering combat")

	inCombat = true
end

-- re-apply visibility settings to all visible nameplates on leaving combat (some may have disappeared/appeared during combat, some may need switching from alpha to hidden)
function AloftVisibility:OnPlayerRegenEnabled()
	-- ChatFrame7:AddMessage("AloftTargetNameData:OnPlayerRegenEnabled(): exiting combat")

	inCombat = nil
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateShow(aloftData)
	end
end

function AloftVisibility:OnNameplateShow(aloftData)
	local eventName = "AloftVisibility:DoNameplateShow:" .. tostring(math.random(1,1000000000))
	-- ChatFrame7:AddMessage("AloftTargetNameData:OnNameplateShow(): " .. tostring(eventName) .. "/".. tostring(aloftData) .. "/".. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))
	self:ScheduleEvent(eventName, self.DoNameplateShow, 0.1, self, aloftData) -- seems to need just a little more than next frame
end

function AloftVisibility:OnNameplateHide(aloftData)
	aloftData.alphaOverride = nil
	aloftData.invisible = nil
end

function AloftVisibility:DoNameplateShow(aloftData)
	showTypeMethods[aloftData.type](aloftData.nameplateFrame, aloftData)
end

-----------------------------------------------------------------------------

function AloftVisibility:DoFrameHide(frame, aloftData)
	-- ChatFrame7:AddMessage("AloftTargetNameData:DoFrameHide(): " .. tostring(frame) .. "/".. tostring(aloftData.name))
	if frame then
		self:OnNameplateHide(aloftData) -- clean out old data
		if inCombat or InCombatLockdown() then
			if profile.useAlpha and AloftAlpha then
				aloftData.invisible = true
				aloftData.alphaOverride = 0.0
				-- ChatFrame7:AddMessage("AloftVisibility:DoFrameHide(): alpha " .. tostring(aloftData.name))

				frame:SetAlpha(aloftData.alphaOverride)
				-- remember: cannot disable the mouse in combat; must wait until after combat
			end
			-- there is nothing more we can do in combat
		else
			aloftData.invisible = true
			-- ChatFrame7:AddMessage("AloftVisibility:DoFrameHide(): hide " .. tostring(aloftData.name) .. "/" .. tostring(true))

			frame:Hide()

			-- TODO: turns out this can be dangerous; hide the nameplate, disable the mouse, and it can intermittently remain disabled, if recycled in combat
			-- frame:EnableMouse(true) -- logic seems inverted; seems to work only intermittently

			-- local eventName = "AloftVisibility:DoDisableMouse:" .. tostring(math.random(1,1000000000))
			-- self:ScheduleEvent(eventName, self.DoDisableMouse, 0.25, self, frame) -- not even a delay helps
		end
	end
end

function AloftVisibility:DoDisableMouse(frame)
	-- ChatFrame7:AddMessage("AloftTargetNameData:DoDisableMouse(): " .. tostring(frame) .. "/".. tostring(aloftData.name))
	-- TODO: turns out this can be dangerous; hide the nameplate, disable the mouse, and it can intermittently remain disabled, if recycled in combat
	-- frame:EnableMouse(true) -- logic seems inverted; seems to work only intermittently
end

-- assumes the caller will check with Aloft:IsTotem() first, but fairly harmless if this does not happen
function Aloft:GetTotemExceptionColor(aloftData)
	local type = aloftData.type
	local name = aloftData.name
	if type == "hostile" and (profile.showHostileTotems or profile.enableHostileTotem[name]) then
		return profile.hostileTotemColor[name]
	elseif type == "friendlyNPC" and (profile.showFriendlyTotems or profile.enableFriendlyTotem[name]) then
		return profile.friendlyTotemColor[name]
	end
	return nil
end

-----------------------------------------------------------------------------

end)
