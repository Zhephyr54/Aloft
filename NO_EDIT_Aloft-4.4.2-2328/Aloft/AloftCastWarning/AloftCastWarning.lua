local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

-- ChatFrame7:AddMessage("AloftCastWarning: have globals")

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData", true) -- always on
if not AloftTargetTrackingData then return end

local AloftCastBar = Aloft:GetModule("CastBar", true) -- always on
if not AloftCastBar then return end

-- ChatFrame7:AddMessage("AloftCastWarning: have modules")

local AloftCastWarning = Aloft:NewModule("CastWarning", Aloft, "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
AloftCastWarning.dynamic = "AloftCastWarning"

-- these modules are optional
local AloftAlpha = Aloft:GetModule("Alpha", true)
local AloftVisibility = Aloft:GetModule("Visibility", true)

local SML = LibStub("LibSharedMedia-3.0")

-- ChatFrame7:AddMessage("AloftCastWarning: have externals " .. tostring(Aloft:GetModule("CastWarning", true)))

-----------------------------------------------------------------------------

-- TODO: make these all attributes of AloftCastWarning?

-- needs to be maintained to match the definitions in AloftCastWarningProcess.lua/AloftCastWarningOptions.lua; these masks are lifted from Blizzard; buried somewhere in a global table somewhere
local SPELL_SCHOOL_NONE		= SCHOOL_MASK_NONE
local SPELL_SCHOOL_PHYSICAL	= SCHOOL_MASK_PHYSICAL
local SPELL_SCHOOL_HOLY		= SCHOOL_MASK_HOLY
local SPELL_SCHOOL_FIRE		= SCHOOL_MASK_FIRE
local SPELL_SCHOOL_NATURE		= SCHOOL_MASK_NATURE
local SPELL_SCHOOL_FROST		= SCHOOL_MASK_FROST
local SPELL_SCHOOL_SHADOW		= SCHOOL_MASK_SHADOW
local SPELL_SCHOOL_ARCANE		= SCHOOL_MASK_ARCANE
local SPELL_SCHOOL_HEAL		= 0x40000000 				-- this is an imaginary catch-all school for healing spells; make certain no bits are in common

-- needs to be maintained to match the definitions in AloftCastWarningOptions.lua; these are lifted loosely from Blizzard(tm); Interface\AddOns\Blizzard_CombatLog\Blizzard_CombatLog.lua (i.e. Blizzard combat log processing)
local SPELL_COLOR_NONE		= { 1.00, 1.00, 1.00, 1.00, }	-- this is an imaginary color for spells with no known school (a medium gray)
local SPELL_COLOR_PHYSICAL	= { 0.80, 0.60, 0.40, 1.00, }	-- basically the warrior class color
local SPELL_COLOR_HOLY		= { 1.00, 0.90, 0.50, 1.00, }
local SPELL_COLOR_FIRE		= { 1.00, 0.00, 0.00, 1.00, }	-- red
local SPELL_COLOR_NATURE	= { 0.30, 1.00, 0.30, 1.00, }
local SPELL_COLOR_FROST	= { 0.50, 1.00, 1.00, 1.00, }
local SPELL_COLOR_SHADOW	= { 0.50, 0.50, 1.00, 1.00, }	-- basically the warlock class color
local SPELL_COLOR_ARCANE	= { 1.00, 0.50, 1.00, 1.00, }
local SPELL_COLOR_HEAL		= { 1.00, 0.50, 0.00, 1.00, }	-- this is an imaginary catch-all color for healing spells (yellow-orange)

-- masks processed in array order, and colors assigned based on the first atomic school encountered in order
local SCHOOL_COLOR_ORDER =
{
	[1] = { ["name"] = "Physical",	["school"] = SPELL_SCHOOL_PHYSICAL,	["color"] = SPELL_COLOR_PHYSICAL, },
	[2] = { ["name"] = "Shadow",	["school"] = SPELL_SCHOOL_SHADOW,	["color"] = SPELL_COLOR_SHADOW, },
	[3] = { ["name"] = "Arcane",	["school"] = SPELL_SCHOOL_ARCANE,	["color"] = SPELL_COLOR_ARCANE, },
	[4] = { ["name"] = "Frost",	["school"] = SPELL_SCHOOL_FROST,	["color"] = SPELL_COLOR_FROST, },
	[5] = { ["name"] = "Fire",		["school"] = SPELL_SCHOOL_FIRE,		["color"] = SPELL_COLOR_FIRE, },
	[6] = { ["name"] = "Nature",	["school"] = SPELL_SCHOOL_NATURE,	["color"] = SPELL_COLOR_NATURE, },
	[7] = { ["name"] = "Holy",		["school"] = SPELL_SCHOOL_HOLY,		["color"] = SPELL_COLOR_HOLY, },
	[8] = { ["name"] = "Heal",		["school"] = SPELL_SCHOOL_HEAL,		["color"] = SPELL_COLOR_HEAL, },
	[9] = { ["name"] = "None",		["school"] = SPELL_SCHOOL_NONE,		["color"] = SPELL_COLOR_NONE, },
}
local SCHOOL_COLOR_ORDER_COUNT = 8

-- priority order (indexes into SCHOOL_COLOR_ORDER); needs to be maintained to match the definitions in AloftCastWarningProcess.lua
local SCHOOL_PRIORITY =
{
	[SPELL_SCHOOL_PHYSICAL]	= 1,
	[SPELL_SCHOOL_SHADOW]	= 2,
	[SPELL_SCHOOL_ARCANE]	= 3,
	[SPELL_SCHOOL_FROST]	= 4,
	[SPELL_SCHOOL_FIRE]		= 5,
	[SPELL_SCHOOL_NATURE]	= 6,
	[SPELL_SCHOOL_HOLY]		= 7,
	[SPELL_SCHOOL_HEAL]		= 8,
	[SPELL_SCHOOL_NONE]		= 9,
}
-- NOTE: not currently used; could be used to manage precedence of school type, if the same spell drives multiple effects

-- needs to be maintained to match the definitions in AloftCastWarningSpellProcess.lua
local SUCCESS		= "SUCCESS"
local FAILURE		= "FAILURE"

-----------------------------------------------------------------------------

-- options database (one namespace), will be registered under the parent addon
AloftCastWarning.namespace = "castWarning"
AloftCastWarning.defaults =
{
	profile =
	{
		enable			= true,
		verifyInterval	= 0.33,
		tradeSkill		= false,
		players			= true,
		friendly		= false,
		animate			= true,
		fadeDuration	= 1.50,
		height			= 10,

		offsets =
		{
			left		= 0,
			right		= 0,
			vertical	= -12,
		},

		border			= "None",
		borderEdgeSize	= 16,
		borderInset		= 4,
		borderColor		= { 1, 1, 1, 1 },
		backdropColor	= { 0.25, 0.25, 0.25, 0.5 },
		texture			= "Blizzard",

		nointerBorder			= "None",
		nointerBorderEdgeSize	= 16,
		nointerBorderInset		= 4,
		nointerBorderColor		= { 1, 1, 1, 1 },
		nointerBackdropColor	= { 0.25, 0.25, 0.25, 0.5 },
		nointerTexture			= "Blizzard",

		alphaOverrideEnable	= false,
		alphaOverride	= 0.99,

		powerTypeColors	=
		{
			[SPELL_SCHOOL_NONE]		= SPELL_COLOR_NONE,
			[SPELL_SCHOOL_PHYSICAL]	= SPELL_COLOR_PHYSICAL,
			[SPELL_SCHOOL_HOLY]		= SPELL_COLOR_HOLY,
			[SPELL_SCHOOL_FIRE]		= SPELL_COLOR_FIRE,
			[SPELL_SCHOOL_NATURE]	= SPELL_COLOR_NATURE,
			[SPELL_SCHOOL_FROST]	= SPELL_COLOR_FROST,
			[SPELL_SCHOOL_SHADOW]	= SPELL_COLOR_SHADOW,
			[SPELL_SCHOOL_ARCANE]	= SPELL_COLOR_ARCANE,
			[SPELL_SCHOOL_HEAL]		= SPELL_COLOR_HEAL,
		},
	},
}

-----------------------------------------------------------------------------

local ANIMATE_INTERVAL		= 0.05
local TIMEOUT_INTERVAL		= 5.0
local ACTIVE_CAST_TIMEOUT	= 5.0 -- same as the range maximum for fade duration option

-- backdrop table for initializing visible nameplates
local backdropTable =
{
	-- tile = false,
	-- tileSize = 16,
	bgFile = nil,
	edgeSize = 16,
	edgeFile = nil,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

local castWarningFramePool = { }

AloftCastWarning.activePool = { }

AloftCastWarning.targetGUIdToActiveCast = { }

-----------------------------------------------------------------------------

local GetTime				= GetTime
local UnitClass			= UnitClass
local UnitGUID				= UnitGUID
local UnitName				= UnitName
local UnitRace				= UnitRace
local GetRaidTargetIndex	= GetRaidTargetIndex
local UnitClassification	= UnitClassification
local UnitLevel			= UnitLevel

local CreateFrame			= CreateFrame

local unpack = unpack
local bit_bor = _G.bit.bor
local bit_band = _G.bit.band

-----------------------------------------------------------------------------

function AloftCastWarning:OnInitialize()
	-- ChatFrame7:AddMessage("AloftCastWarning:OnInitialize(): enter")

	-- options database
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end
	-- ChatFrame7:AddMessage("AloftCastWarning:OnInitialize(): db " .. tostring(self.db))

	-- spell database
	self.AloftCastWarningDB = LibStub("AceDB-3.0"):New("AloftCastWarningDB", nil, "Default")
	-- ChatFrame7:AddMessage("AloftCastWarning:OnInitialize(): AloftCastWarningDB " .. tostring(self.AloftCastWarningDB))

	-- TODO: get rid of "realm" once people have a chance to run this version of Aloft
	self.spellIdBase = self.AloftCastWarningDB:RegisterNamespace("spellIdBase", { profile = { }, global = { spells = { }, }, realm = { } })
	-- ChatFrame7:AddMessage("AloftCastWarning:OnInitialize(): spellIdBase " .. tostring(self.spellIdBase))

	-- TODO: get rid of this once people have a chance to run this version of Aloft
	self.spellNameRankBase = self.AloftCastWarningDB:RegisterNamespace("spellNameRankBase", { profile = { }, realm = { } })
	-- ChatFrame7:AddMessage("AloftCastWarning:OnInitialize(): spellNameRankBase " .. tostring(self.spellNameRankBase))

	self.initialized = true
end

function AloftCastWarning:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): enter")
	for index = 1, #SCHOOL_COLOR_ORDER do
		local value = SCHOOL_COLOR_ORDER[index]
		-- ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): " .. ("%d 0x%08x |c%02x%02x%02x%02x%s|r"):format(index, value.school, value.color[4]*255, value.color[1]*255, value.color[2]*255, value.color[3]*255, value.name))
	end

	--[[ just a diagnostic loop
	for index, color in pairs(self.db.profile.powerTypeColors) do
		ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): " .. ("0x%08x |c%02x%02x%02x%02xcolor|r"):format(index, color[4]*255, color[1]*255, color[2]*255, color[3]*255))
	end
	]]

	-- TODO: get rid of these once people have a chance to run this version of Aloft
	for x, _ in pairs(self.spellIdBase.realm) do
		self.spellIdBase.realm[x] = nil -- old implementation, zap it
	end
	for x, _ in pairs(self.spellNameRankBase.realm) do
		self.spellNameRankBase.realm[x] = nil -- old implementation, zap it
	end
	-- NOTE: for some reason just assigning realm = { } did not do the job; something in the way AceDB manages these tables

	-- ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): process spellIdBase " .. tostring(self.spellIdBase))
	-- ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): ----- spellIdBase VERSION -----  " .. tostring(self.spellIdBase.profile.version) .. "/" .. tostring(Aloft.version))
	if not self.spellIdBase.profile.version or self.spellIdBase.profile.version ~= Aloft.version then
		self.spellIdBase.profile.version = Aloft.version
		self.spellIdBase.global.spells = { } -- reset spellid database, version has changed
	else
		-- eliminate all spells recorded in spellIdBase that have not been marked permanent, and/or that have no school, and/or are tradeskills when we don't want tradeskills
		for spellId, spell in pairs(self.spellIdBase.global.spells) do
			if not spell or not spell.id or spellId ~= spell.id or not self:IsSpellEntryValid(spell) then
				-- get rid of spell
				self.spellIdBase.global.spells[spellId] = nil
			end
		end
	end

	self:AdjustOptionValues()

	self:UpdateAll()
end

function AloftCastWarning:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:ReleaseCastWarning(aloftData)
	end
	-- TODO: nil out Aloft.Options?
end

-----------------------------------------------------------------------------

function AloftCastWarning:RequiresData()
	self:RegisterEvents()

	if self.db.profile.players then
		return "isTarget", "race", "class" -- race/class needed for player nameplate identification
	else
		return "isTarget" -- rely solely on raid target assignment (target icons) for nameplate identification
	end
end

function AloftCastWarning:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile.enable then
		self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")

		self:RegisterMessage("AloftTargetTrackingData:OnNameplateTrackingDataChanged", "Update")
		self:RegisterMessage("AloftTargetTrackingData:OnTargetTrackingDataUpdated", "OnTargetTrackingDataUpdated")
		self:RegisterMessage("AloftTargetTrackingData:OnTargetTrackingDataCleared", "OnTargetTrackingDataCleared")

		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "OnCombatLogEvent")

		self:RegisterEvent("UNIT_SPELLCAST_START", "OnUnitSpellcastStart")
		self:RegisterEvent("UNIT_SPELLCAST_DELAYED", "OnUnitSpellcastDelayed")
		self:RegisterEvent("UNIT_SPELLCAST_STOP", "OnUnitSpellcastStop")
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "OnUnitSpellcastSucceeded")
		self:RegisterEvent("UNIT_SPELLCAST_FAILED", "OnUnitSpellcastFailed")
		self:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET", "OnUnitSpellcastFailedQuiet")
		self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "OnUnitSpellcastInterrupted")

		self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START","OnUnitSpellcastChannelStart")
		self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "OnUnitSpellcastChannelUpdate")
		self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP","OnUnitSpellcastChannelStop")

		-- TODO: no longer used? leave it in for now and see if it ever shows
		self:RegisterEvent("UNIT_SPELLMISS", "OnUnitSpellmiss")

		-- TODO: these are not necessary; they are redundant
		-- self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE", "OnUnitSpellcastInterruptible")
		-- self:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE", "OnUnitSpellcastNotInterruptible")

		-- check for timed-data every 5 seconds or so
		self:ScheduleRepeatingTimer(function() AloftCastWarning:OnDataTimeout() end, TIMEOUT_INTERVAL)
	end

	self:RegisterMessage("SharedMedia_SetGlobal", function(message, mediatype, override)
		if mediatype == "statusbar" then
			AloftCastWarning:UpdateAll()
		end
	end)

	self:RegisterMessage("Aloft:SetAll", function(message, type, value)
		if AloftCastWarning.db.profile[type] then
			AloftCastWarning.db.profile[type] = value

			-- special cases for "nointerrupt" side of things
			if type == "texture" then
				AloftCastWarning.db.profile.nointerTexture = value
			elseif type == "border" then
				AloftCastWarning.db.profile.nointerBorder = value
			end

			AloftCastWarning:UpdateAll()
		end
	end)
end

function AloftCastWarning:UpdateCastWarning()
	if (not self.db.profile.enable) then return end -- stub out if disabled

	-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateCastWarning(): process")
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:Update("AloftCastWarning:UpdateCastWarning", aloftData)
	end
end

function AloftCastWarning:UpdateAll()
	if (self.db.profile.enable) then
		self:UpdateCastWarning() -- this iterates visible nameplates
	end
end

function AloftCastWarning:Update(message, aloftData)
	local nameplateId = AloftTargetTrackingData:GetNameplateId(aloftData)
	local targetGUId = nameplateId and AloftTargetTrackingData:GetNameplateGUId(nameplateId)
	local active = targetGUId and self.targetGUIdToActiveCast[targetGUId]
	local now = GetTime()

	-- local layoutFrame = aloftData.layoutFrame
	-- local castFrame = AloftCastBar:GetCastFrame()
	-- ChatFrame7:AddMessage("AloftCastWarning:Update(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.type) .. "/" .. tostring(self.db.profile.players) .. "/" .. tostring(self.db.profile.friendly))
	if (not self.db.profile.enable)
		or (aloftData.invisible) -- TODO: check aloftData.alphaOverride?
		-- or (active and active.endTime <= now)
		-- or (aloftData.isTarget or aloftData:IsTarget())
		or (not self.db.profile.players and (aloftData.type == "friendlyPlayer" or aloftData.type == "hostilePlayer")) -- TODO: use isPlayer for this? TODO: add a final check for nameplate (class) color (to catch transient color changes)?
		or (not self.db.profile.friendly and (aloftData.type == "friendlyPlayer" or aloftData.type == "friendlyNPC")) -- TODO: add a final check for nameplate color (to catch transient color changes)?
		-- or (castFrame and layoutFrame and castFrame:GetParent() == layoutFrame and castFrame:IsVisible()) then -- the target cast bar is visible on the current nameplate; disabled for now, redundant: nameplate isTarget check subsumes this
	then
		-- somewhat complex here; IF (any of):
		--	> module is disabled (quick check)
		--	> the nameplate is invisible (quick check)
		--  <disabled> the associated active spell cast has expired
		--	<disabled> we have the current target nameplate (one visible nameplate is almost always guaranteed to be a target, and usually a quick check)
		--	> we are not tracking players, but we have a player
		--      we check for friendly players first, assuming a PvE application in which most players are friendly (a PvP application would track players and fall through to the friendly check)
		--	> we are not tracking friendlies, but we have a friendly (player/NPC)
		--      we check for friendly players first, assuming applications in which there will be comparatively few NPCs (presumably no application would track friendlies)
		--      we treat neutral NPCs as "hostile" for these purposes, since they are generally attackable NPCs
		-- THEN: cancel any associated active cast warning
		-- ChatFrame7:AddMessage("AloftCastWarning:Update(): disable warning " .. tostring(aloftData.name))
		if active then
			active.disabled = true -- flag this active spell cast as disabled
			if targetGUId and self:VerifyActiveCast(nameplateId, active) then
				-- if we can verify there is an associated/residual active cast on the unit (via a mapped unitid, based on nameplateId), we can clear that active cast
				self:StopCastEvent(aloftData.castWarningFrame) -- stop warning on the active cast
				self:ReleaseActive(targetGUId) -- completely clear the active cast
			end
		end

		-- regardless of a verified active cast, we don't need a cast warning on this nameplate
		self:ReleaseCastWarning(aloftData)

		-- ChatFrame7:AddMessage("AloftCastWarning:Update(): active target " .. tostring(aloftData.name) .. "/" .. tostring(targetGUId))
		return -- stub out here for disabled; disabled is not interesting, and the current target nameplate has its own full-featured cast bar, provided by Blizzard
	end
	-- ChatFrame7:AddMessage("AloftCastWarning:Update(): " .. tostring(aloftData.name) .. "/" .. tostring(nameplateId))

	local targetId

	-- at this point, we are interested in a cast warning bar on any identifiable nameplate that is not the current target for any active spell that has not expired
	local currentTarget = aloftData.isTarget or aloftData:IsTarget()
	if not currentTarget then
		-- ChatFrame7:AddMessage("AloftCastWarning:Update(): not current target " .. tostring(aloftData.name))
		if nameplateId then
			-- ChatFrame7:AddMessage("AloftCastWarning:Update(): nameplateId " .. tostring(aloftData.name) .. "/" .. tostring(nameplateId))
			if targetGUId then
				-- ChatFrame7:AddMessage("AloftCastWarning:Update(): targetGUId " .. tostring(aloftData.name) .. "/" .. tostring(targetGUId))
				-- ChatFrame7:AddMessage("AloftCastWarning:Update(): active " .. tostring(aloftData.name) .. "/" .. tostring(active and active.id) .. "/" .. tostring(aloftData.castWarningFrame) .. "/" .. tostring(aloftData.castWarningEndTime) .. "/" .. tostring(active and active.startTime) .. "/" .. tostring(active and active.endTime) .. "/" .. tostring(now))
				if active and active.startTime and (not aloftData.castWarningFrame or not aloftData.castWarningEndTime or active.startTime >= aloftData.castWarningEndTime) and active.endTime > now then
					-- ChatFrame7:AddMessage("AloftCastWarning:Update(): start/resume warning " .. tostring(aloftData.name) .. "/"  .. tostring(active and active.name))
					local castWarningFrame = self:AcquireCastWarning(aloftData, active.noInterrupt) -- may redundantly return a pre-existing cast bar
					self:StopCastEvent(castWarningFrame) -- stop whatever event may be on a pre-existing cast bar

					-- determine the color for the cast warning bar
					local color = SPELL_COLOR_NONE
					if active.school and active.school > 0 then
						for i=1,SCHOOL_COLOR_ORDER_COUNT do
							local desc = SCHOOL_COLOR_ORDER[i]
							local mask = bit_band(active.school, desc.school)
							if mask > 0 then
								color = desc.color
								break
							end
						end
					end
					if castWarningFrame.castRegion then castWarningFrame.castRegion:SetVertexColor(unpack(color)) end

					-- assign values
					castWarningFrame.nameplateId = nameplateId
					castWarningFrame.targetGUId = targetGUId
					castWarningFrame.lastVerify = now -- mark last verification as "now", if we are starting a cast warning bar for the first time

					-- ChatFrame7:AddMessage("AloftCastWarning:Update(): show cast warning " .. tostring(aloftData.name) .. "/" .. tostring(castWarningFrame.nameplateId) .. "/" .. tostring(self:GetNameplateTargetId(castWarningFrame.nameplateId)) .. "/" .. tostring(castWarningFrame.targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "/" .. tostring(active.startTime) .. "/" .. tostring(active.endTime) .. "/" .. tostring(castWarningFrame.event))
					self:ShowCastWarning(aloftData)

					-- TODO: make this interval a user-controlled option, rather than 20 times a second?
					if self.db.profile.animate then
						-- ChatFrame7:AddMessage("AloftCastWarning:Update(): animate cast bar " .. tostring(aloftData.name) .. "/" .. tostring(active and active.name))
						castWarningFrame.event = self:ScheduleRepeatingTimer(function(aloftData) AloftCastWarning:AnimateActiveCast(aloftData) end, ANIMATE_INTERVAL, aloftData)
					else
						self:AnimateActiveCast(aloftData) -- this drives one "iteration" of the animate, to configure/display the cast warning

						-- ChatFrame7:AddMessage("AloftCastWarning:Update(): schedule release cast bar " .. tostring(aloftData.name) .. "/"  .. tostring(active and active.name))
						castWarningFrame.event = nil
						self:ScheduleTimer(function(aloftData) AloftCastWarning:ReleaseCastWarning(aloftData) end, ((active.endTime > now) and (active.endTime - now)) or 0.0, aloftData)
					end

					-- ChatFrame7:AddMessage("AloftCastWarning:Update(): notify start " .. tostring(castWarningFrame) .. "/" .. tostring(castWarningFrame.targetGUId) .. "/" .. tostring(active.startTime) .. "/" .. tostring(active.Time) .. "/" .. tostring(castWarningFrame.event))
					self:SendMessage("AloftCastWarning:OnCastWarningDataChanged", aloftData, targetGUId, active)
					aloftData.castWarningLastUpdateTime = now
					aloftData.castWarningEndTime = active.endTime

					return -- we have enabled a cast warning bar, we should stub out here
				-- ORIGINAL/obsolete: elseif active and ((active.fadeEndTime and ((self.db.profile.animate and active.fadeEndTime > aloftData.castWarningLastUpdateTime) or (not self.db.profile.animate and active.fadeEndTime > aloftData.castWarningLastUpdateTime))) or (active.endTime and active.endTime > aloftData.castWarningLastUpdateTime)) then
				elseif active and aloftData.castWarningLastUpdateTime and
				   ((active.fadeEndTime and active.fadeEndTime > aloftData.castWarningLastUpdateTime) or
				    (active.endTime and active.endTime > aloftData.castWarningLastUpdateTime)) then
					-- still fading or not ended yet; so, animation presumably already in progress, just trigger a data change event, to switch to fade text, and continue
					-- ChatFrame7:AddMessage("AloftCastWarning:Update(): notify fade " .. tostring(aloftData.name) .. "/"  .. tostring(active and active.name))
					self:SendMessage("AloftCastWarning:OnCastWarningDataChanged", aloftData, targetGUId, active)
					aloftData.castWarningLastUpdateTime = now

					return -- we have updated the cast warning bar, we should stub out here
				else
					-- animation/fade presumably finished; trigger a data change event and release the cast warning
					-- ChatFrame7:AddMessage("AloftCastWarning:Update(): notify finished " .. tostring(aloftData.name) .. "/"  .. tostring(active and active.name))
					self:SendMessage("AloftCastWarning:OnCastWarningDataChanged", aloftData, targetGUId, active)

					-- ChatFrame7:AddMessage("AloftCastWarning:Update(): release cast bar")
					self:ReleaseCastWarning(aloftData)
					return -- we have released the cast warning bar, we should stub out here
				end
			else
				-- ChatFrame7:AddMessage("AloftCastWarning:Update(): no targetId " .. tostring(aloftData.name) .. "/" .. tostring(targetGUId))
			end
		else
			-- ChatFrame7:AddMessage("AloftCastWarning:Update(): no nameplateId " .. tostring(aloftData.name) .. "/" .. tostring(targetGUId))
		end
	else
		-- ChatFrame7:AddMessage("AloftCastWarning:Update(): current target " .. tostring(aloftData.name) .. "/" .. tostring(targetGUId))
	end

	-- fall through to here: if we have no nameplate id and/or no tracked targetGUId and/or no active cast spellId,
	-- or this (via fall through from above) is the current target nameplate, then disable any cast warning bar that
	-- is showing and/or animation that is in progress
	if not (nameplateId and targetGUId and active) or currentTarget then
		-- ChatFrame7:AddMessage("AloftCastWarning:Update(): handle non-spell " .. tostring(aloftData.name))
		local castWarningFrame = aloftData.castWarningFrame
		if castWarningFrame then
			if castWarningFrame.event --[[and self:TimeLeft(castWarningFrame.event)]] then
				self:CancelTimer(castWarningFrame.event, true)
				castWarningFrame.event = nil
				castWarningFrame.value = nil
				-- ChatFrame7:AddMessage("AloftCastWarning:Update(): cancel obsolete event")
			end
			if castWarningFrame:IsVisible() then
				-- ChatFrame7:AddMessage("AloftCastWarning:Update(): release " .. tostring(aloftData.name))
				self:SendMessage("AloftCastWarning:OnCastWarningDataChanged", aloftData, targetGUId, active)
				self:ReleaseCastWarning(aloftData)
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarning:OnIsTargetDataChanged(message, aloftData)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnIsTargetDataChanged(): enter")

	if (self.db.profile.enable) then
		self:ScheduleTimer(function(aloftData) AloftCastWarning:UpdateTargetData(aloftData) end, 0.1, aloftData) -- next frame
	end
end

function AloftCastWarning:OnTargetTrackingDataUpdated(message, targetId, nameplateId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnTargetTrackingDataUpdated(): enter")
	if (self.db.profile.enable) then
		self:UpdateCastWarning()
	end
end

function AloftCastWarning:OnTargetTrackingDataCleared(message, targetId, nameplateId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnTargetTrackingDataCleared(): enter")
	if self.db.profile.enable then
		-- TODO: do we actually have anything to do here?
	end
end

function AloftCastWarning:OnNameplateShow(message, aloftData)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnNameplateShow(): enter")
	self:Update(message, aloftData)
end

function AloftCastWarning:OnNameplateHide(message, aloftData)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnNameplateHide(): enter")
	-- TODO: switch event back and forth between AnimateActiveCast and ReleaseCastWarning when nameplate appears/disappears
	self:StopCastEvent(aloftData.castWarningFrame)
	self:ReleaseCastWarning(aloftData)

	-- self:ScheduleTimer(function(aloftData) AloftCastWarning:ReleaseCastWarning(aloftData) end, 0.0, aloftData) -- next frame
end

function AloftCastWarning:UpdateTargetData(aloftData)
	-- local layoutFrame = aloftData.layoutFrame
	-- local castFrame = AloftCastBar:GetCastFrame()
	-- if not (castFrame and layoutFrame and castFrame:GetParent() == layoutFrame and castFrame:IsVisible()) then -- the target cast bar has become visible
	--	ChatFrame7:AddMessage("AloftCastWarning:UpdateTargetData(): target cast bar NOT present/visible " .. tostring(aloftData.name))
	-- end
	-- ChatFrame7:AddMessage("AloftCastWarning:UpdateTargetData(): ----- TARGET CHANGE ----- " .. tostring(aloftData.name))
	self:Update("AloftCastWarning:UpdateTargetData", aloftData)
end

function AloftCastWarning:OnDataTimeout()
	-- ChatFrame7:AddMessage("AloftCastWarning:OnDataTimeout(): enter")

	-- current time
	local now = GetTime()

	-- time out old GUId<>ActiveCast mappings
	for targetGUId, active in pairs(self.targetGUIdToActiveCast) do
		if not AloftTargetTrackingData:GetGUIdNameplateId(targetGUId) or (active.fadeEndTime and active.fadeEndTime <= now) or ((active.endTime + (ACTIVE_CAST_TIMEOUT * 1000)) <= now) then
			-- no nameplate, or done fading, or ended and timed out
			-- ChatFrame7:AddMessage("AloftCastWarning:OnDataTimeout(): " .. tostring(targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.startTime) .. "/" .. tostring(active.Time))
			self.ReleaseActive(targetGUId)
			-- TODO: flag these timeouts to chat
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarning:AcquireCastWarning(aloftData, noInterrupt)
	-- ChatFrame7:AddMessage("CastWarning/AcquireCastWarning(): acquire " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))
	local nameplateFrame = aloftData.nameplateFrame
	local castWarningFrame = aloftData.castWarningFrame

	if not castWarningFrame then
		castWarningFrame = next(castWarningFramePool)
		if castWarningFrame then
			castWarningFramePool[castWarningFrame] = nil
		else
			castWarningFrame = CreateFrame("Frame", nil, nameplateFrame)
			if not castWarningFrame.castWarningExtraFrame then
				castWarningFrame.castWarningExtraFrame = CreateFrame("Frame", nil, castWarningFrame)
			end
		end

		aloftData.castWarningFrame = castWarningFrame
		castWarningFrame.aloftData = aloftData

		self:SetupBar(aloftData, noInterrupt)
		self:PlaceBar(aloftData, noInterrupt)
	end
	castWarningFrame:SetParent(nameplateFrame)

	return castWarningFrame
end

function AloftCastWarning:ReleaseCastWarning(aloftData)
	-- ChatFrame7:AddMessage("AloftCastWarning:ReleaseCastWarning(): release " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/".. tostring(aloftData.maxMana))
	local castWarningFrame = aloftData.castWarningFrame
	if castWarningFrame then
		-- ChatFrame7:AddMessage("CastWarning/ReleaseCastWarning(): release " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))
		-- this could end up redundantly checking the event; TODO: optimize this
		if castWarningFrame.event --[[and self:TimeLeft(castWarningFrame.event)]] then
			self:CancelTimer(castWarningFrame.event, true)
			castWarningFrame.event = nil
			-- ChatFrame7:AddMessage("AloftCastWarning:ReleaseCastWarning(): cancel event")
		end

		self:HideCastWarning(aloftData)

		aloftData.castWarningLastUpdateTime = 0
		aloftData.castWarningEndTime = nil

		aloftData.castWarningFrame = nil
		castWarningFrame.aloftData = nil

		castWarningFrame.spellCastTime = nil
		castWarningFrame.targetGUId = nil
		castWarningFrame.lastVerify = nil
		castWarningFrame.event = nil
		castWarningFrame.value = nil

		castWarningFrame:SetParent(nil)
		castWarningFramePool[castWarningFrame] = true
	end
end

function AloftCastWarning:GetBorder(aloftData, noInterrupt)
	local border = (noInterrupt and self.db.profile.nointerBorder) or self.db.profile.border
	return ((border ~= "None") and ((noInterrupt and self.db.profile.nointerBorderInset) or self.db.profile.borderInset)) or 0, SML:Fetch("border", border)
	-- return 0, SML:Fetch("border", "None")
end

function AloftCastWarning:SetupBar(aloftData, noInterrupt)
	local nameplateFrame = aloftData.nameplateFrame
	local castWarningFrame = aloftData.castWarningFrame

	local texture, backdropColor, borderColor
	if noInterrupt then
		texture = SML:Fetch("statusbar", self.db.profile.nointerTexture)
		backdropColor = self.db.profile.nointerBackdropColor
		borderColor = self.db.profile.nointerBorderColor
	else
		texture = SML:Fetch("statusbar", self.db.profile.texture)
		backdropColor = self.db.profile.backdropColor
		borderColor = self.db.profile.borderColor
	end
	local inset, edgeFile = self:GetBorder(aloftData, noInterrupt)

	local castRegion = castWarningFrame.castRegion
	if not castRegion then
		castRegion = castWarningFrame:CreateTexture(nil, "ARTWORK")
		castRegion:SetBlendMode("BLEND")
		castWarningFrame.castRegion = castRegion
	end
	castRegion:SetTexture(texture)
	castRegion:ClearAllPoints()
	castRegion:SetPoint("TOPLEFT", castWarningFrame, "TOPLEFT", inset, -inset)
	castRegion:SetPoint("BOTTOMLEFT", castWarningFrame, "BOTTOMLEFT", inset, inset)
	castRegion:Show()
		-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): " .. tostring(aloftData.name) .. "/" .. tostring(castRegion:GetTexture()))

	backdropTable.insets.left = inset
	backdropTable.insets.right = inset
	backdropTable.insets.top = inset
	backdropTable.insets.bottom = inset
	backdropTable.edgeFile = edgeFile
	backdropTable.edgeSize = (noInterrupt and self.db.profile.nointerBorderEdgeSize) or self.db.profile.borderEdgeSize
	backdropTable.bgFile = texture

	castWarningFrame:SetFrameLevel(nameplateFrame:GetFrameLevel())
	-- ChatFrame7:AddMessage("AloftCastBar:SetupFrame(): frame level " .. tostring(aloftData.name) .. "/" .. tostring(castWarningFrame:GetFrameLevel()))
	castWarningFrame:SetBackdrop(backdropTable)
	castWarningFrame:SetBackdropColor(unpack(self.db.profile.backdropColor))
	castWarningFrame:SetBackdropBorderColor(unpack(self.db.profile.borderColor))

	-- This manipulates the cast warning background to always display above the frame background
	local _, backgroundRegion = castWarningFrame:GetRegions()

	backgroundRegion:SetDrawLayer("BACKGROUND")
	backgroundRegion:SetBlendMode("BLEND")
	backgroundRegion:Show()

	-- castWarningFrame.castWarningExtraFrame:Hide()
	-- castWarningFrame:Hide()
end

function AloftCastWarning:PlaceBar(aloftData, noInterrupt)
	local castWarningFrame = aloftData.castWarningFrame
	if castWarningFrame then
		local nameplateFrame = aloftData.nameplateFrame
		local layoutFrame = aloftData.layoutFrame
		local inset, _ = self:GetBorder(aloftData, noInterrupt)

		castWarningFrame:ClearAllPoints()
		castWarningFrame:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", self.db.profile.offsets.left - inset, self.db.profile.offsets.vertical + inset)
		castWarningFrame:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", self.db.profile.offsets.right + inset, self.db.profile.offsets.vertical - self.db.profile.height - inset)

		local castWarningExtraFrame = castWarningFrame.castWarningExtraFrame
		if castWarningExtraFrame then
			castWarningExtraFrame:ClearAllPoints()
			castWarningExtraFrame:SetPoint("TOPLEFT", castWarningFrame, "TOPLEFT", inset, -inset)
			castWarningExtraFrame:SetPoint("BOTTOMRIGHT", castWarningFrame, "BOTTOMRIGHT", -inset, inset)
			-- castWarningExtraFrame:SetStatusBarColor(0, 0, 0, 0)
			castWarningExtraFrame:SetFrameLevel(nameplateFrame:GetFrameLevel() + 1)
			-- ChatFrame7:AddMessage("AloftCastWarning:PlaceBar(): frame level " .. tostring(aloftData.name) .. "/" .. tostring(castWarningExtraFrame:GetFrameLevel()))
		end
	end
end

function AloftCastWarning:ShowCastWarning(aloftData)
	local castWarningFrame = aloftData.castWarningFrame
	if castWarningFrame then
		castWarningFrame:Show()
		-- ChatFrame7:AddMessage("AloftCastWarning:ShowCastWarning(): castWarningFrame " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))

		local castWarningExtraFrame = castWarningFrame.castWarningExtraFrame
		if castWarningExtraFrame then
			castWarningExtraFrame:Show()
			-- ChatFrame7:AddMessage("AloftCastWarning:ShowCastWarning(): castWarningExtraFrame " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))
		end

		if not aloftData.invisible and self.db.profile.alphaOverrideEnable and AloftAlpha then
			aloftData.alphaOverride = self.db.profile.alphaOverride
		--[[
			ChatFrame7:AddMessage("AloftCastWarning:ShowCastWarning(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.alphaOverride))
		else
			ChatFrame7:AddMessage("AloftCastWarning:ShowCastWarning(): alpha override disabled " .. tostring(aloftData.invisible) .. "/" .. tostring(self.db.profile.alphaOverrideEnable) .. "/" .. tostring(AloftAlpha) .. "/" .. tostring(AloftVisibility and AloftVisibility.db.profile.useAlpha))
		--]]
		end
	end
end

function AloftCastWarning:HideCastWarning(aloftData)
	local castWarningFrame = aloftData.castWarningFrame
	if castWarningFrame then
		if not aloftData.invisible then aloftData.alphaOverride = nil end

		local castWarningExtraFrame = castWarningFrame.castWarningExtraFrame
		if castWarningExtraFrame then
			-- some users have reported the occasional residual spell-icon/no-interrupt graphics appearing on nameplates; explicitly hide them
			local castWarningSpellIconRegion = castWarningFrame.castWarningSpellIconRegion
			if castWarningSpellIconRegion then
				castWarningSpellIconRegion:Hide()
			end

			local nointerruptRegion = castWarningFrame.nointerruptRegion
			if nointerruptRegion then
				nointerruptRegion:Hide()
			end

			-- now hide the whole extra frame
			castWarningExtraFrame:Hide()
			-- ChatFrame7:AddMessage("AloftCastWarning:HideCastWarning(): castWarningExtraFrame " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))
		end

		-- finally, hide the cast warning frame
		if castWarningFrame.castRegion then castWarningFrame.castRegion:SetWidth(0) end
		castWarningFrame:Hide()
		-- ChatFrame7:AddMessage("AloftCastWarning:HideCastWarning(): castWarningFrame " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))
	end
end

-----------------------------------------------------------------------------

function AloftCastWarning:CalculateFrameWidth(aloftData, castWarningFrame, mnv, mxv, val, noInterrupt)
	local inset, _ = self:GetBorder(aloftData, noInterrupt)

	-- by hook or by crook, value must end up non-nil
	local width = (val / (mxv - mnv)) * (castWarningFrame:GetWidth() - (2 * inset))
	-- ChatFrame7:AddMessage("AloftCastWarning:CalculateFrameWidth(): " .. tostring(aloftData.name) .. "/" .. tostring(mnv) .. "/" .. tostring(val) .. "/" .. tostring(mxv) .. "/" .. tostring(mxv - val) .. "/" .. tostring(mxv - mnv) .. "/" .. tostring(width))

	return width
end

function AloftCastWarning:AnimateActiveCast(aloftData)
	local now = GetTime()
	aloftData.castWarningLastUpdateTime = now

	local castWarningFrame = aloftData.castWarningFrame
	if not castWarningFrame or not castWarningFrame.targetGUId then return end

	local targetGUId = castWarningFrame.targetGUId
	local active = self.targetGUIdToActiveCast[targetGUId] -- TODO: pass this in, on event creation? or go gather it on each iteration?

	-- TODO: consider checking periodically to see if there is a targetId associated with the nameplate and if that targetId is still casting/channeling the same spell
	-- TODO: make this a "verification interval", separate from the animation interval?
	if active then
		-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): show cast warning " .. tostring(aloftData.name) .. "/" .. tostring(castWarningFrame.targetGUId) .. "/" .. tostring(active) .. "/" .. tostring(active.startTime) .. "<" .. tostring(active.endTime) .. "/" .. tostring(castWarningFrame.event))
		local layoutFrame = aloftData.layoutFrame
		local castFrame = AloftCastBar:GetCastFrame()
		if active.disabled then
			-- cast is over, release the active cast
			self:StopActiveCast(aloftData, castWarningFrame, targetGUId, nil)
			active = nil
		elseif aloftData.isTarget or aloftData:IsTarget()
		   -- or (castFrame and layoutFrame and castFrame:GetParent() == layoutFrame and castFrame:IsVisible()) -- if target cast bar is actually visible and associated with this nameplate; subsumed by the target check
		then
			-- in the middle of animating an actual cast, we want to preemptively drop the cast warning BAR when we have the current target nameplate, but leave the active cast in place
			-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): disable " .. tostring(aloftData.name))
			self:StopActiveCast(aloftData, castWarningFrame, targetGUId, true)
			active = nil
		elseif active.fadeEndTime then -- are we already fading
			if now >= active.fadeEndTime then -- we are done "fading"
				-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): fade done " .. tostring(aloftData.name) .. "/" .. tostring(castWarningFrame.targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "|" .. tostring(active.startTime) .. "<" .. tostring(now) .. "<" .. tostring(active.endTime) .. "|" .. tostring(castWarningFrame.event))
				self:StopActiveCast(aloftData, castWarningFrame, targetGUId, nil)
				active = nil
			end
		else -- we are mot already fading
			if now >= active.endTime then -- spell cast/channel is finished, start fading
				-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): expired, start fade " .. tostring(aloftData.name) .. "/" .. tostring(castWarningFrame.targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "|" .. tostring(active.startTime) .. "<" .. tostring(now) .. "<" .. tostring(active.endTime) .. "|" .. tostring(castWarningFrame.event))
				-- TODO: transition finished casting to a "conclusion" phase, where the cast warning bar time interval changes to an outcome and is faded out
				self:EndActiveCast(targetGUId, active.id, active.name, active.rank, SUCCESS, nil)
				self:SendMessage("AloftCastWarning:OnCastWarningDataChanged", aloftData, targetGUId, active)
				-- segues to a fade, if the user wants it
			elseif castWarningFrame and castWarningFrame.lastVerify and now >= (castWarningFrame.lastVerify + self.db.profile.verifyInterval) then -- time to verify that we are still casting/channeling
				-- spell is still running, and we should verify (if we can)
				-- TODO: some sort of "formal" 3-way logic, instead of overloading false/nil
				-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): verify " .. tostring(aloftData.name) .. "/" .. tostring(castWarningFrame.targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "|" .. tostring(active.startTime) .. "<" .. tostring(now) .. "<" .. tostring(active.endTime) .. "|" .. tostring(castWarningFrame.event))
				local verified = self:VerifyActiveCast(AloftTargetTrackingData:GetGUIdNameplateId(targetGUId), active)
				if verified then -- "true"; have a unitid and can verify still casting/channeling, just update verification time
					castWarningFrame.lastVerify = now
				elseif verified ~= nil then -- "false"; have a unitid and can verify NOT still casting/channeling, get rid of the cast warning
					-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): verification failed, start fade " .. tostring(aloftData.name) .. "/" .. tostring(castWarningFrame.targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "|" .. tostring(active.startTime) .. "<" .. tostring(now) .. "<" .. tostring(active.endTime) .. "|" .. tostring(castWarningFrame.event))
					self:EndActiveCast(targetGUId, active.id, active.name, active.rank, FAILURE, nil)
					self:SendMessage("AloftCastWarning:OnCastWarningDataChanged", aloftData, targetGUId, active)
					-- segues to a fade, if the user wants it
				else -- nil; no unitid so cannot verify one way or the other, just assume all is well, update verification time, effectively let the most recent warning time out normally
					castWarningFrame.lastVerify = now
				end
			end
		end
		-- we reach here if we have an active spell cast, but apparently no cast warning bar... leave this event running, it will clean up the active cast when it is done
		-- TODO: switch event back and forth between AnimateActiveCast and ReleaseCastWarning when nameplate appears/disappears

		if castWarningFrame and active then
			-- TODO: enhance to handle displaying non-animated cast bars... set up start/end times to show full duration of cast, like a channel that does not move
			-- animate the cast bar; TODO: somewhat torturous logic, going to be hard to maintain; see if it can be improved, maybe build some of this into the active cast table up front somehow?
			local mnv = 0
			local mxv = active.endTime - active.startTime
			local val = (active.fadeStartTime and ((active.isChanneled and 0.00000001) or (active.endTime - active.startTime)))
							or (active.isChanneled and (active.endTime - active.startTime - (now - active.startTime))) or (now - active.startTime)
			local alpha = (self.db.profile.animate and active.fadeEndTime and self.db.profile.fadeDuration > 0.0 and active.fadeEndTime > now and (1.0 - (now - active.fadeStartTime) / self.db.profile.fadeDuration)) or 1.0
			-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): animate bar " .. tostring(aloftData.name) .. "/" .. tostring(castWarningFrame.targetGUId) .. "/" .. tostring(active) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "/" .. tostring(castWarningFrame.event) .. "|" .. tostring(now) .. "-" .. tostring(active.startTime) .. "<" .. tostring(active.endTime) .. "|" .. tostring(mnv) .. "<" .. tostring(value) .. "<" .. tostring(mxv) .. "|" .. tostring(alpha) .. "/" .. tostring(trigger))

			castWarningFrame.value = val

			local castRegion = castWarningFrame.castRegion
			local width = self:CalculateFrameWidth(aloftData, castWarningFrame, mnv, mxv, val, active.noInterrupt)
			castRegion:SetWidth(width)

			castWarningFrame:SetAlpha(alpha)
			castWarningFrame.castWarningExtraFrame:SetAlpha(alpha)

			self:SendMessage("AloftCastWarning:OnCastWarningTimeChanged", aloftData, targetGUId, active, val)
			-- if trigger then self:SendMessage("AloftCastWarning:OnCastWarningTimeChanged", aloftData, targetGUId, active) end
		end
	end
end

function AloftCastWarning:StopActiveCast(aloftData, castWarningFrame, targetGUId, hideOnly)
	self:StopCastEvent(castWarningFrame)
	if not hideOnly then
		self:ReleaseActive(targetGUId) -- clear the current spell, unless we are only hiding
	end
	self:Update("AloftCastWarning:StopActiveCast", aloftData)
end

function AloftCastWarning:StopCastEvent(castWarningFrame)
	if castWarningFrame and castWarningFrame.event --[[and self:TimeLeft(castWarningFrame.event)]] then
		self:CancelTimer(castWarningFrame.event, true)
		castWarningFrame.event = nil
		castWarningFrame.value = nil
		-- ChatFrame7:AddMessage("AloftCastWarning:StopCastEvent(): cancel event")
	end
end

-----------------------------------------------------------------------------

-- clear the entire targetGUId<> nameplateId/activeCast tracking map
function AloftCastWarning:ClearAllTargetTracking()
	-- targetGUId > whatever tracking
	for targetGUId, nameplateId in pairs(AloftTargetTrackingData:GetAllGUIdToNameplateId()) do
		self:ReleaseActive(targetGUId)
	end
end

-----------------------------------------------------------------------------

-- take the targetId off of its former nameplateId  (if any)
function AloftCastWarning:ClearTarget(targetId)
	if targetId then
		self:ClearTargetGUId(UnitGUID(targetId))
	end
end

-- clear the targetGUId<> nameplateId/activeCast tracking map for the given targetGUId
function AloftCastWarning:ClearTargetGUId(targetGUId)
	-- ChatFrame7:AddMessage("AloftCastWarning:ClearTargetTracking(): enter")
	if targetGUId then
		self:ReleaseActive(targetGUId)
	end
end

-----------------------------------------------------------------------------

function AloftCastWarning:AcquireActive(startTime, endTime, spell, noInterrupt)
	local active = next(self.activePool)
	if not active then
		-- create new active record
		active = { }
	else
		-- recycle existing active record from the pool
		self.activePool[active] = nil
	end

	-- initialize active record
	active.valid = true
	active.timestamp = startTime
	active.startTime = startTime
	active.endTime = endTime

	-- TODO: just reference spell for most of this; make spell a field in active, instead of copying all of this
	active.subtype = spell.subtype
	active.id = spell.id
	active.name = spell.name
	active.rank = spell.rank
	active.school = spell.school
	active.icon = spell.icon
	active.minRange = spell.minRange
	active.maxRange = spell.maxRange
	active.powerType = spell.powerType
	active.castTime = spell.castTime
	active.isChanneled = spell.isChanneled
	active.noInterrupt = noInterrupt
	-- ChatFrame7:AddMessage("AloftCastWarning:AcquireActive(): " .. tostring(active) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "/" .. tostring(active.noInterrupt) .. "/" .. tostring(active.startTime) .. "/" .. tostring(active.endTime))
	-- ChatFrame7:AddMessage("AloftCastWarning:AcquireActive(): " .. debugstack(1, 4, 3))

	-- make certain these extraneous things are gone
	active.fadeStartTime = nil
	active.fadeEndTime = nil
	active.outcome = nil
	active.extra = nil

	return active
end

function AloftCastWarning:ReleaseActive(targetGUId)
	if targetGUId then
		local active = self.targetGUIdToActiveCast[targetGUId]
		if active then
			-- ChatFrame7:AddMessage("AloftCastWarning:ReleaseActive(): active " .. tostring(targetGUId) .. "/" .. tostring(active) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "/" .. tostring(active.noInterrupt) .. "/" .. tostring(active.startTime) .. "/" .. tostring(active.endTime))
			-- ChatFrame7:AddMessage("AloftCastWarning:AcquireActive(): " .. debugstack(1, 4, 3))

			-- invalidate, but return the active record to the pool
			self.targetGUIdToActiveCast[targetGUId] = nil
			self.activePool[active] = true
			active.valid = nil

			-- make certain everything is gone
			active.timestamp = nil
			active.startTime = nil
			active.endTime = nil

			active.subtype = nil
			active.id = nil
			active.name = nil
			active.rank = nil
			active.school = nil
			active.icon = nil
			active.minRange = nil
			active.maxRange = nil
			active.powerType = nil
			active.castTime = nil
			active.isChanneled = nil
			active.noInterrupt = nil

			active.noInterrupt = nil
			active.fadeStartTime = nil
			active.fadeEndTime = nil
			active.outcome = nil
			active.extra = nil

			active.disabled = nil
		else
			-- ChatFrame7:AddMessage("AloftCastWarning:ReleaseActive(): no active " .. tostring(targetGUId))
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarning:GetNameplateTargetId(nameplateId)
	if AloftTargetTrackingData.nameplateIdToTargetId[nameplateId] then
		for targetId in pairs(AloftTargetTrackingData.nameplateIdToTargetId[nameplateId]) do
			-- TODO: take out this function check after a version or so, once the users have updated
			if targetId and (not AloftTargetTrackingData.CreateTargetNameplateId or nameplateId == AloftTargetTrackingData:CreateTargetNameplateId(targetId)) then
				return targetId
			end
		end
	end
	return nil
end

-----------------------------------------------------------------------------

-- test whether the spell database entry is valid
function AloftCastWarning:IsSpellEntryValid(spell)
	if not spell or not spell.school or not spell.permanent or not spell.id or (not self.db.profile.tradeSkill and spell.isTradeSkill) or spell.castTime <= 0.0 then
		return nil
	end
	return true
end

-----------------------------------------------------------------------------

-- insure that alphaOverride is as close to the user's setting as possible, but at all costs *different* than AloftAlpha/targetAlpha
function AloftCastWarning:AdjustOptionValues()
	local alpha = (AloftAlpha and AloftAlpha.db.profile.targetAlpha) or 1.0

	if self.db.profile.overrideEnabble and self.db.profile.alphaOverride == alpha then
		self.db.profile.alphaOverride = alpha - 0.01
		if self.db.profile.alphaOverride < 0.0 then
			self.db.profile.alphaOverride = alpha + 0.01
		end
	end
end

-----------------------------------------------------------------------------

end)
