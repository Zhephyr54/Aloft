local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

local dL = AloftLocale.AloftVisibilityData
if not dL then return end

local oT = AloftLocale.AloftVisibilityTotems
if not oT then return end

local AloftVisibility = Aloft:NewModule("Visibility", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftVisibility.dynamic = "AloftVisibility"

local AloftAlpha

-----------------------------------------------------------------------------

AloftVisibility.namespace = "visibility"
AloftVisibility.defaults =
{
	profile =
	{
		target = false,

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
			-- fleshed out below
		},
		hostileTotemColor =
		{
			-- fleshed out below
		},

		showFriendlyTotems = true,
		enableFriendlyTotem =
		{
			-- currently not used
		},
		friendlyTotemColor =
		{
			-- currently not used
		},

		enableHideUnitNames = false,
		hideUnitNames = { },
	},
}

-- flesh out the hostile totem enable flags and exception colors
for name, _ in pairs(Aloft.TotemName) do
	AloftVisibility.defaults.profile.enableHostileTotem[name] = false
	AloftVisibility.defaults.profile.hostileTotemColor[name] = { 1.0, 0.0, 1.0, 1.0, } -- full magenta
end

-----------------------------------------------------------------------------

local inCombat

local InCombatLockdown = InCombatLockdown

-----------------------------------------------------------------------------

function AloftVisibility:Update()
	self:RegisterEvents()

	-- Toggle the visibility to get previously hidden stuff to show
	Aloft:BounceEnemyNameplates()
	Aloft:BounceFriendNameplates()
end

function AloftVisibility:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile then
		self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnPlayerRegenDisabled")
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnPlayerRegenEnabled")

		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")

		if not self.db.profile.showHostilePlayers then
			self:RegisterMessage("Aloft:OnClassDataChanged", "OnClassDataChanged")
		end

		if self.db.profile.target then
			-- ChatFrame7:AddMessage("AloftVisibility:RegisterEvents(): register Aloft:OnIsTargetDataChanged")
			self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
		end

		if self.db.profile.showNeutralUnits and not self.db.profile.showCritters then
			self:RegisterMessage("Aloft:OnCreatureTypeDataChanged", "OnCreatureTypeDataChanged")
		end

		if not self.db.profile.showHostilePets or
		   not self.db.profile.showFriendlyPets then
			self:RegisterMessage("Aloft:OnIsPetDataChanged", "OnIsPetDataChanged")
			self:RegisterMessage("Aloft:OnPetOwnersNameDataChanged", "OnIsPetDataChanged")
		end

		--[[
		if not self.db.profile.showCritters or
		   not self.db.profile.showHostilePlayers or
		   not self.db.profile.showHostilePets or
		   not self.db.profile.showHostileNPCs or
		   not self.db.profile.showHostileTotems or
		   not self.db.profile.showNeutralUnits or
		   not self.db.profile.showFriendlyNPCs or
		   not self.db.profile.showFriendlyPets or
		   not self.db.profile.showGroupPets or
		   not self.db.profile.showPet or
		   self.db.profile.friendlyPlayers ~= "ALL" then
		]]
			-- ChatFrame7:AddMessage("AloftVisibility:RegisterEvents(): register OnNameplateShow")
			self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
			self:RegisterMessage("Aloft:OnUnitidDataChanged", "OnUnitidDataChanged")
		-- end
	end
end

-----------------------------------------------------------------------------

function AloftVisibility:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftVisibility:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	AloftAlpha = Aloft:GetModule("Alpha", true)

	self:RegisterEvents()

	-- ChatFrame7:AddMessage("AloftVisibility:OnEnable(): " .. tostring(AloftVisibility.db.profile.enableHostileTotem[name]) .. "/" .. tostring(AloftVisibility.db.profile.enableFriendlyTotem[name]))
end

function AloftVisibility:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile and
	   (not self.db.profile.showCritters or
	    not self.db.profile.showHostilePlayers or
	    not self.db.profile.showHostilePets or
	    not self.db.profile.showHostileNPCs or
	    not self.db.profile.showHostileTotems or
	    not self.db.profile.showNeutralUnits or
	    not self.db.profile.showFriendlyNPCs or
	    not self.db.profile.showFriendlyPets  or
	    not self.db.profile.showGroupPets or
	    not self.db.profile.showPet or
	    self.db.profile.friendlyPlayers ~= "ALL") then
			Aloft:BounceEnemyNameplates()
			Aloft:BounceFriendNameplates()
	end
end

local dataRequiredList = { }
function AloftVisibility:RequiresData()
	if self.db.profile then
		for i = 1,#dataRequiredList do
			dataRequiredList[i] = nil
		end

		--[[
		if not self.db.profile.showHostilePlayers then
			table.insert(dataRequiredList, "class")
		end
		]]

		if self.db.profile.showHostilePets ~= self.db.profile.showHostileNPCs or
		   self.db.profile.showFriendlyPets ~= self.db.profile.showFriendlyNPCs then
			table.insert(dataRequiredList, "isPet")
			table.insert(dataRequiredList, "petOwnersName")
		end

		if self.db.profile.friendlyPlayers == "GUILDONLY" then
			table.insert(dataRequiredList, "isGuildMember")
		end

		if self.db.profile.showNeutralUnits and not self.db.profile.showCritters then
			table.insert(dataRequiredList, "creatureType")
		end

		if Aloft:IsDataAvailable("unitid") then
			if self.db.profile.friendlyPlayers == "GROUPONLY" or
		   	   self.db.profile.showGroupPets ~= self.db.profile.showFriendlyPets then
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
							-- ChatFrame7:AddMessage("AloftVisibility.showTypeMethods.friendlyPlayer(): " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.hideUnitNames[aloftData.name]))
							if AloftVisibility.db.profile.enableHideUnitNames and AloftVisibility.db.profile.hideUnitNames[aloftData.name] then
								-- ChatFrame7:AddMessage("AloftVisibility.showTypeMethods.friendlyPlayer(): HIDE " .. tostring(aloftData.name))
								AloftVisibility:DoFrameHide(frame, aloftData)
							else
								local friendlyPlayerMethod = friendlyPlayerMethods[AloftVisibility.db.profile.friendlyPlayers]
								if friendlyPlayerMethod then
									friendlyPlayerMethod(frame, aloftData)
								end
							end
						end,
	["friendlyNPC"] = function(frame, aloftData)
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods:[friendlyNPC](): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.nameplateFrame))
						if AloftVisibility.db.profile.enableHideUnitNames and AloftVisibility.db.profile.hideUnitNames[aloftData.name] then
							AloftVisibility:DoFrameHide(frame, aloftData)
						elseif UnitExists("pet") and UnitName("pet") == aloftData.name then
							-- ChatFrame7:AddMessage("AloftVisibility:friendlyPlayerMethods:[friendlyNPC](): pet " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.showPet))
							if not AloftVisibility.db.profile.showPet then
								AloftVisibility:DoFrameHide(frame, aloftData)
							end
						elseif aloftData.unitid then -- Group pet
							-- ChatFrame7:AddMessage("AloftVisibility:friendlyPlayerMethods:[friendlyNPC](): group pet " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.showGroupPets))
							if not AloftVisibility.db.profile.showGroupPets then
								AloftVisibility:DoFrameHide(frame, aloftData)
							end
						elseif Aloft:IsTotem(aloftData) then
							-- order is important here; totems are effectively pets (they meet the IsPet condition in AloftIsPetData, and they have a pet owner's name)
							-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[friendlyNPC](): totem " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.showFriendlyTotems) .. "/" .. tostring(Aloft:GetTotemExceptionColor(aloftData)))
							if not AloftVisibility.db.profile.showFriendlyTotems and not Aloft:GetTotemExceptionColor(aloftData) then -- a totem or trap snake?
								AloftVisibility:DoFrameHide(frame, aloftData)
							end
						elseif aloftData.isPet or aloftData.petOwnersName then
							-- ChatFrame7:AddMessage("AloftVisibility:friendlyPlayerMethods:[friendlyNPC](): friendly  pet " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.showFriendlyPets))
							if not AloftVisibility.db.profile.showFriendlyPets then
								AloftVisibility:DoFrameHide(frame, aloftData)
							end
						else
							if not AloftVisibility.db.profile.showFriendlyNPCs then
								AloftVisibility:DoFrameHide(frame, aloftData)
							end
						end
					  end,
	["neutral"] = function(frame, aloftData)
					if AloftVisibility.db.profile.enableHideUnitNames and AloftVisibility.db.profile.hideUnitNames[aloftData.name] then
						AloftVisibility:DoFrameHide(frame, aloftData)
					elseif not AloftVisibility.db.profile.showNeutralUnits or (not AloftVisibility.db.profile.showCritters and aloftData.creatureType == dL["Critter"]) then
						AloftVisibility:DoFrameHide(frame, aloftData)
					end
				  end,
	["hostile"] = function(frame, aloftData)
					-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostile](): enter")
					if AloftVisibility.db.profile.enableHideUnitNames and AloftVisibility.db.profile.hideUnitNames[aloftData.name] then
						AloftVisibility:DoFrameHide(frame, aloftData)
					elseif aloftData.class then -- Is it a player?
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostile](): player " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.showHostilePlayers))
						if not AloftVisibility.db.profile.showHostilePlayers then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					elseif Aloft:IsTotem(aloftData) then
						-- order is important here; totems are effectively pets (they meet the IsPet condition in AloftIsPetData, and they have a pet owner's name)
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostile](): totem " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.showHostileTotems) .. "/" .. tostring(Aloft:GetTotemExceptionColor(aloftData)))
						if not AloftVisibility.db.profile.showHostileTotems and not Aloft:GetTotemExceptionColor(aloftData) then -- a totem or trap snake?
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					elseif aloftData.isPet or aloftData.petOwnersName then -- a pet?
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostile](): pet " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.showHostilePets))
						if not AloftVisibility.db.profile.showHostilePets then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					else -- an NPC?
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostile](): NPC " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.showHostileNPCs))
						if not AloftVisibility.db.profile.showHostileNPCs then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					end
				  end,
	-- TODO: this is a kludge, needs to be cleaned up; if this is really a hostilePlayer, most of this makes no sense
	["hostilePlayer"] = function(frame, aloftData)
					if AloftVisibility.db.profile.enableHideUnitNames and AloftVisibility.db.profile.hideUnitNames[aloftData.name] then
					-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostilePlayer](): enter")
						AloftVisibility:DoFrameHide(frame, aloftData)
					elseif aloftData.class then -- Is it a player?
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostilePlayer](): player " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.showHostilePlayers))
						if not AloftVisibility.db.profile.showHostilePlayers then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					elseif Aloft:IsTotem(aloftData) then
						-- order is important here; totems are effectively pets (they meet the IsPet condition in AloftIsPetData, and they have a pet owner's name)
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostilePlayer](): totem " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.showHostileTotems) .. "/" .. tostring(Aloft:GetTotemExceptionColor(aloftData)))
						if AloftVisibility.db.profile.showHostileTotems and not Aloft:GetTotemExceptionColor(aloftData) then -- a totem or trap snake?
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					elseif aloftData.isPet or aloftData.petOwnersName then -- a pet?
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostilePlayer](): pet " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.showHostilePets))
						if not AloftVisibility.db.profile.showHostilePets then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					else -- an NPC?
						-- ChatFrame7:AddMessage("AloftVisibility:showTypeMethods[hostilePlayer](): NPC " .. tostring(aloftData.name) .. "/" .. tostring(AloftVisibility.db.profile.showHostileNPCs))
						if not AloftVisibility.db.profile.showHostileNPCs then
							AloftVisibility:DoFrameHide(frame, aloftData)
						end
					end
				  end,
	["unknown"] = function() end,
}

function AloftVisibility:OnClassDataChanged(message, aloftData)
	-- If it was changed, then it must have some value now
	if aloftData.type == "hostilePlayer" or aloftData.type == "hostile" then
		self:OnNameplateShow(message, aloftData)
	end
end

function AloftVisibility:OnCreatureTypeDataChanged(message, aloftData)
	if aloftData.type == "neutral" and aloftData.creatureType == dL["Critter"] then
		self:OnNameplateShow(message, aloftData)
	end
end

function AloftVisibility:OnIsPetDataChanged(message, aloftData)
	if aloftData.type == "friendlyNPC" or aloftData.type == "hostilePlayer" or aloftData.type == "hostile" then
		self:OnNameplateShow(message, aloftData)
	end
end

function AloftVisibility:OnUnitidDataChanged(message, aloftData)
	if aloftData.type == "friendlyPlayer" then
		self:OnNameplateShow(message, aloftData)
	end
end

-- mark the player as being in combat
function AloftVisibility:OnPlayerRegenDisabled(event)
	-- ChatFrame7:AddMessage("AloftTargetNameData:OnPlayerRegenDisabled(): entering combat")

	inCombat = true
end

-- re-apply visibility settings to all visible nameplates on leaving combat (some may have disappeared/appeared during combat, some may need switching from alpha to hidden)
function AloftVisibility:OnPlayerRegenEnabled(event)
	-- ChatFrame7:AddMessage("AloftTargetNameData:OnPlayerRegenEnabled(): exiting combat")

	inCombat = nil
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:OnNameplateShow(event, aloftData)
	end
end

function AloftVisibility:OnIsTargetDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftVisibility:OnIsTargetDataChanged(): " .. tostring(message) .. "/" .. tostring(aloftData.name))
	-- if aloftData.isTarget or aloftData:IsTarget() then ChatFrame7:AddMessage("AloftVisibility:OnIsTargetDataChanged(): " .. tostring(aloftData.name) .. "/TARGET") end

	self:OnNameplateShow(message, aloftData)
end

function AloftVisibility:OnNameplateShow(message, aloftData)
	-- ChatFrame7:AddMessage("AloftVisibility:OnNameplateShow(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.type))
	-- if aloftData.isTarget or aloftData:IsTarget() then ChatFrame7:AddMessage("AloftVisibility:OnNameplateShow(): " .. tostring(aloftData.name) .. "/TARGET") end

	self:ScheduleTimer(function(aloftData) AloftVisibility:DoNameplateShow(aloftData) end, 0.1, aloftData) -- seems to need just a little more than next frame
end

function AloftVisibility:OnNameplateHide(message, aloftData)
	aloftData.alphaOverride = nil
	aloftData.invisible = nil
end

function AloftVisibility:DoNameplateShow(aloftData)
	-- ChatFrame7:AddMessage("AloftVisibility:DoNameplateShow(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.nameplateFrame) .. "/" .. tostring(aloftData.type))
	-- if self.db.profile.target and self.db.profile.useAlpha and AloftAlpha and (aloftData.isTarget or aloftData:IsTarget()) then ChatFrame7:AddMessage("AloftVisibility:DoNameplateShow(): " .. tostring(aloftData.name) .. "/TARGET") end
	-- if self.db.profile.target and self.db.profile.useAlpha and AloftAlpha and not (aloftData.isTarget or aloftData:IsTarget()) then ChatFrame7:AddMessage("AloftVisibility:DoNameplateShow(): " .. tostring(aloftData.name) .. "/NOTARGET") end

	aloftData.alphaOverride = nil
	aloftData.invisible = nil

	showTypeMethods[aloftData.type](aloftData.nameplateFrame, aloftData)
end

-----------------------------------------------------------------------------

function AloftVisibility:DoFrameHide(frame, aloftData)
	-- ChatFrame7:AddMessage("AloftVisibility:DoFrameHide(): " .. tostring(frame) .. "/".. tostring(aloftData.name) .. "/".. tostring(aloftData.nameplateFrame:GetAlpha()))
	-- if self.db.profile.target and self.db.profile.useAlpha and AloftAlpha and (aloftData.isTarget or aloftData:IsTarget()) then ChatFrame7:AddMessage("AloftVisibility:DoFrameHide(): " .. tostring(aloftData.name) .. "/TARGET") end
	-- if self.db.profile.target and self.db.profile.useAlpha and AloftAlpha and not (aloftData.isTarget or aloftData:IsTarget()) then ChatFrame7:AddMessage("AloftVisibility:DoFrameHide(): " .. tostring(aloftData.name) .. "/NOTARGET") end
	if frame then
		local showTarget = self.db.profile.target and self.db.profile.useAlpha and AloftAlpha and AloftAlpha:IsEnabled()
		if not inCombat and not InCombatLockdown() and not showTarget then
			-- should be using nameplate hide

			aloftData.invisible = true

			-- ChatFrame7:AddMessage("AloftVisibility:DoFrameHide(): straight hide " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.nameplateFrame))
			frame:Hide()

			-- TODO: turns out this can be dangerous; hide the nameplate, disable the mouse, and it can intermittently remain disabled, if recycled in combat
			-- frame:EnableMouse(true) -- logic seems inverted; seems to work only intermittently

			-- self:ScheduleEvent(function(frame) AloftVisibility:DoDisableMouse(frame) end, 0.25, frame) -- not even a delay helps
		else
			-- should be using nameplate alpha
			local isTarget = aloftData.isTarget or aloftData:IsTarget()
			-- ChatFrame7:AddMessage("AloftVisibility:DoFrameHide(): consider alpha " .. tostring(aloftData.name) .. "/" .. tostring(showTarget) .. "/" .. tostring(aloftData.isTarget) .. "/" .. tostring(aloftData:IsTarget()))
			if not showTarget or not isTarget then
				aloftData.invisible = true
				aloftData.alphaOverride = 0.0

				-- ChatFrame7:AddMessage("AloftVisibility:DoFrameHide(): alpha hide " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.nameplateFrame))
				frame:SetAlpha(aloftData.alphaOverride)
			end
		end
	end
end

function AloftVisibility:DoFrameShow(frame, aloftData)
	if frame then
		if not inCombat and not InCombatLockdown() then
			frame:Show()
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
	if type == "hostile" and AloftVisibility.db.profile.enableHostileTotem[name] then
		local color = AloftVisibility.db.profile.hostileTotemColor[name]
		-- ChatFrame7:AddMessage("Aloft:GetTotemExceptionColor(): hostile " .. ("|cff%02x%02x%02x%s|r"):format(color[1], color[2], color[3], name))
		return AloftVisibility.db.profile.hostileTotemColor[name]
	elseif type == "friendlyNPC" and AloftVisibility.db.profile.enableFriendlyTotem[name] then
		return AloftVisibility.db.profile.friendlyTotemColor[name]
	end
	return nil
end

-----------------------------------------------------------------------------

end)
