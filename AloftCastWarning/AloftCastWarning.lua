local Aloft = Aloft
if not Aloft then return end
-- local AloftModules = AloftModules
-- if not AloftModules then return end

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("TargetTrackingData") then return end

local AloftCastWarning = Aloft:NewModule("CastWarning", "AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0", "AceHook-2.1")
-- AloftCastWarning.dynamic = true

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData") -- always on
local AloftAlpha = Aloft:HasModule("Alpha") and Aloft:GetModule("Alpha")
local AloftVisibility = Aloft:HasModule("Visibility") and Aloft:GetModule("Visibility")

local roster = AceLibrary("Roster-2.1")
local SML = AceLibrary("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

-- TODO: make these all attributes of AloftCastWarning

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

-- options database (one namespace), over under the parent addon
AloftCastWarning.aloftDB = Aloft:AcquireDBNamespace("castWarning")
Aloft:RegisterDefaults("castWarning", "profile", {
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
	borderColor		= { 1, 1, 1, 1 },
	backdropColor	= { 0.25, 0.25, 0.25, 0.5 },
	texture			= "Blizzard",

	nointerBorder			= "None",
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
})

-- spell database (two namespaces)
AloftCastWarning:RegisterDB("AloftCastWarningDB")

AloftCastWarning.spellNameRankBase = AloftCastWarning:AcquireDBNamespace("spellNameRankBase")
AloftCastWarning:RegisterDefaults("spellNameRankBase", "server", { })

AloftCastWarning.spellIdBase = AloftCastWarning:AcquireDBNamespace("spellIdBase")
AloftCastWarning:RegisterDefaults("spellIdBase", "server", { })

-----------------------------------------------------------------------------

local ANIMATE_INTERVAL		= 0.05
local TIMEOUT_INTERVAL		= 5.0
local ACTIVE_CAST_TIMEOUT	= 5.0 -- same as the range maximum for fade duration option

local profile
local aloftFrameProfile
local spellIdProfile
local spellNameRankProfile
local castWarningBarPool = { }

local backdropTable =
{
	tile = false,
	tileSize = 16,
	edgeSize = 16,
	-- insets = { left = 0, right = 0, top = 0, bottom = 0 }
}

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
	Aloft:DebugRegister("CastWarning")

	profile = self.aloftDB.profile
	spellIdProfile = self.spellIdBase.profile
	spellNameRankProfile = self.spellNameRankBase.profile
end

function AloftCastWarning:OnEnable()
	-- ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): enter")
	for index = 1, #SCHOOL_COLOR_ORDER do
		local value = SCHOOL_COLOR_ORDER[index]
		-- ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): " .. ("%d 0x%08x |c%02x%02x%02x%02x%s|r"):format(index, value.school, value.color[4]*255, value.color[1]*255, value.color[2]*255, value.color[3]*255, value.name))
	end

	--[[
	for index, color in pairs(profile.powerTypeColors) do
		ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): " .. ("0x%08x |c%02x%02x%02x%02xcolor|r"):format(index, color[4]*255, color[1]*255, color[2]*255, color[3]*255))
	end
	]]

	-- eliminate all spells recorded in spellIdProfle that have not been marked permanent, and/or that have no school, and/or are tradeskills when we don't want tradeskills
	for spellId, record in pairs(spellIdProfile) do
		local origin = record.origin
		local name = record.name
		local rank = record.rank
		local spell = origin and name and rank and spellNameRankProfile[origin] and spellNameRankProfile[origin][name] and spellNameRankProfile[origin][name][rank]

		if spell and spell.id == spellId then
			if not spell.school or not spell.permanent or (not profile.tradeSkill and spell.isTradeSkill) then
				-- get rid of spell
				spellIdProfile[spellId] = nil
				spellNameRankProfile[origin][name][rank] = nil
			end
		else
			-- if it exists (by this spellId) only in spellIdProfile, get rid of it
			spellIdProfile[spellId] = nil
		end
	end

	-- eliminate all spells recorded in spellNameRankProfile that have not been marked permanent, and/or that have no school, and/or are tradeskills when we don't want tradeskills
	-- ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): process spellNameRankProfile")
	for origin, nameList in pairs(spellNameRankProfile) do
		-- ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): origin " .. tostring(origin))
		if nameList then
			for name, rankList in pairs(nameList) do
				-- ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): name " .. tostring(origin) .. "/" .. tostring(name))
				if rankList then
					for rank, spell in pairs(rankList) do
						-- ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): rank " .. tostring(origin) .. "/" .. tostring(name) .. "/" .. tostring(rank))
						-- if spell then ChatFrame7:AddMessage("AloftCastWarning:OnEnable(): spell " .. tostring(spell.id) .. "/" .. tostring(spell.name) .. "/" .. tostring(spell.rank) .. "/" .. tostring(spell.origin)) end
						if not spell or not spell.school or not spell.permanent or not spell.id or (not profile.tradeSkill and spell.isTradeSkill) then
							-- get rid of spell
							if spell and spell.id then spellIdProfile[spell.id] = nil end
							spellNameRankProfile[origin][name][rank] = nil
						elseif not spellIdProfile[spell.id] then
							-- add this back in to spellIdProfile
							spellIdProfile[spell.id] = { ["origin"] = spell.origin, ["name"] = spell.name, ["rank"] = spell.rank, }
						end
					end
				end
			end
		end
	end

	-- eliminate all empty tables in the spellNameRankProfile heirarchy
	for origin, nameList in pairs(spellNameRankProfile) do
		local nameListEmpty = true
		if nameList then
			for name, rankList in pairs(nameList) do
				nameListEmpty = nil
				local rankListEmpty = true
				if rankList then
					for rank, spell in pairs(rankList) do
						rankListEmpty = nil
						break
					end
					if name and rankListEmpty then spellNameRankProfile[origin][name] = nil end
				end
			end
		end
		if origin and nameListEmpty then spellNameRankProfile[origin] = nil end
	end
	-- TODO: this does not handle empty tables created in the process

	self:RegisterEvent("SharedMedia_SetGlobal", function(mediatype, override)
		if mediatype == "statusbar" then
			self:UpdateAll()
		end
	end)

	self:RegisterEvent("Aloft:SetAll", function(type, value)
		if profile[type] then
			profile[type] = value
			self:UpdateAll()
		end
	end)

	aloftFrameProfile = Aloft:GetModule("Frame").db.profile

	self:AdjustOptionValues()

	self:UpdateAll()
end

function AloftCastWarning:OnDisable()
	self:UnregisterAllEvents()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:ReleaseCastWarning(aloftData)
	end
	-- TODO: nil out Aloft.Options?
end

-----------------------------------------------------------------------------

function AloftCastWarning:RequiresData()
	self:RegisterEvents()

	if profile.players then
		return "isTarget", "race", "class" -- race/class needed for player nameplate identification
	else
		return "isTarget" -- rely solely on raid target assignment (target icons) for nameplate identification
	end
end

function AloftCastWarning:RegisterEvents()
	if profile.enable then
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterEvent("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")

		self:RegisterEvent("AloftTargetTrackingData:OnNameplateTrackingDataChanged", "Update")
		self:RegisterEvent("AloftTargetTrackingData:OnTargetTrackingDataUpdated", "OnTargetTrackingDataUpdated")
		self:RegisterEvent("AloftTargetTrackingData:OnTargetTrackingDataCleared", "OnTargetTrackingDataCleared")

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

		self:RegisterEvent("UNIT_SPELLMISS", "OnUnitSpellmiss")

		self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE", "OnUnitSpellcastInterruptible")
		self:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE", "OnUnitSpellcastNotInterruptible")

		-- check for timed-data every 5 seconds or so
		self:ScheduleRepeatingEvent("AloftCastWarning:TimeoutData", self.OnDataTimeout, TIMEOUT_INTERVAL, self)
	else
		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnNameplateHide")
		self:CancelEvent("Aloft:OnIsTargetDataChanged")

		self:CancelEvent("AloftTargetTrackingData:OnNameplateTrackingDataChanged")
		self:CancelEvent("AloftTargetTrackingData:OnTargetTrackingDataUpdated")
		self:CancelEvent("AloftTargetTrackingData:OnTargetTrackingDataCleared")

		self:CancelEvent("COMBAT_LOG_EVENT_UNFILTERED")

		self:CancelEvent("UNIT_SPELLCAST_START")
		self:CancelEvent("UNIT_SPELLCAST_DELAYED")
		self:CancelEvent("UNIT_SPELLCAST_STOP")
		self:CancelEvent("UNIT_SPELLCAST_SUCCEEDED")
		self:CancelEvent("UNIT_SPELLCAST_FAILED")
		self:CancelEvent("UNIT_SPELLCAST_FAILED_QUIET")
		self:CancelEvent("UNIT_SPELLCAST_INTERRUPTED")

		self:CancelEvent("UNIT_SPELLCAST_CHANNEL_START")
		self:CancelEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
		self:CancelEvent("UNIT_SPELLCAST_CHANNEL_STOP")

		self:CancelEvent("UNIT_SPELLMISS")

		self:CancelScheduledEvent("AloftCastWarning:TimeoutData")
	end
end

function AloftCastWarning:UpdateCastWarning()
	if (not profile.enable) then return end -- stub out if disabled

	-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateCastWarning(): process")
	for aloftData in Aloft:IterateVisibleNameplates() do
		self:Update(aloftData)
	end
end

function AloftCastWarning:UpdateAll()
	if (profile.enable) then
		self:UpdateCastWarning() -- this iterates visible nameplates
	end
end

function AloftCastWarning:Update(aloftData)
	local nameplateId = AloftTargetTrackingData:GetNameplateId(aloftData)
	local targetGUId = AloftTargetTrackingData:GetNameplateGUId(nameplateId)
	local active = targetGUId and self.targetGUIdToActiveCast[targetGUId]

	if ((aloftData.isTarget or aloftData:IsTarget()) and aloftData.castBar:IsVisible()) or aloftData.invisible then
		-- if we have the target nameplate with an active cast bar, and we can verify there is no active cast on the target, clear any associated/residual active cast 
		-- if aloftData.castBar:IsVisible() then ChatFrame7:AddMessage("AloftCastWarning:Update(): Blizzard cast IS bar visible " .. "/" .. tostring(aloftData.name)) end
		if active then
			active.target = true -- flag the active spell cast as having used the target cast bar
			if self:VerifyActiveCast(nameplateId, active) then
				self:StopCastEvent(aloftData.castWarningBar)
				self:ReleaseActive(targetGUId) -- clear the current spell
			end
		end
		self:ReleaseCastWarning(aloftData)
		-- ChatFrame7:AddMessage("AloftCastWarning:Update(): active target " .. tostring(aloftData.name) .. "/" .. tostring(targetGUId))
		return -- stub out the current target; the current target nameplate has its own full-featured cast bar, provided by Blizzard
	end
	-- ChatFrame7:AddMessage("AloftCastWarning:Update(): " .. tostring(aloftData.name) .. "/" .. tostring(nameplateId))

	local targetId

	if nameplateId then
		-- ChatFrame7:AddMessage("AloftCastWarning:Update(): targetGUId " .. tostring(aloftData.name) .. "/" .. tostring(targetGUId))
		if targetGUId then
			local now = GetTime()
			active = self.targetGUIdToActiveCast[targetGUId]
			-- ChatFrame7:AddMessage("AloftCastWarning:Update(): spellId " .. tostring(aloftData.name) .. "/" .. tostring(active and active.id) .. "/" .. tostring(active and active.name) .. "/" .. tostring(active and active.rank))
			if active and active.startTime and (not aloftData.castWarningBar or not aloftData.castWarningEndTime or active.startTime >= aloftData.castWarningEndTime) then
				local castWarningBar = self:AcquireCastWarning(aloftData, active.noInterrupt) -- may redundantly return a pre-existing cast bar
				self:StopCastEvent(castWarningBar) -- stop whatever event may be on a pre-existing cast bar

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
				castWarningBar:SetStatusBarColor(unpack(color))

				-- assign values
				castWarningBar.nameplateId = nameplateId
				castWarningBar.targetGUId = targetGUId
				castWarningBar.lastVerify = now -- mark last verification as "now", if we are starting a cast warning bar for the first time
				castWarningBar.eventName = "AloftCastWarning:AnimateActiveCast:" .. nameplateId .. ":" .. tostring(math.random(1,1000000000))

				-- ChatFrame7:AddMessage("AloftCastWarning:Update(): show cast warning " .. tostring(aloftData.name) .. "/" .. tostring(castWarningBar.nameplateId) .. "/" .. tostring(self:GetNameplateTargetId(castWarningBar.nameplateId)) .. "/" .. tostring(castWarningBar.targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "/" .. tostring(active.startTime) .. "/" .. tostring(active.endTime) .. "/" .. tostring(castWarningBar.eventName))
				self:ShowCastWarning(aloftData)

				-- TODO: make this interval a user-controlled option, rather than 20 times a second?
				if profile.animate then
					-- ChatFrame7:AddMessage("AloftCastWarning:Update(): animate cast bar " .. tostring(aloftData.name) .. "/" .. tostring(active and active.name))
					self:ScheduleRepeatingEvent(castWarningBar.eventName, self.AnimateActiveCast, ANIMATE_INTERVAL, self, aloftData)
				else
					self:AnimateActiveCast(aloftData) -- this drives one "iteration" of the animate, to configure/display the cast warning

					-- ChatFrame7:AddMessage("AloftCastWarning:Update(): schedule release cast bar " .. tostring(aloftData.name) .. "/"  .. tostring(active and active.name))
					self:ScheduleEvent(castWarningBar.eventName, self.ReleaseCastWarning, ((active.endTime > now) and (active.endTime - now)) or 0.0, self, aloftData)
				end

				-- ChatFrame7:AddMessage("AloftCastWarning:Update(): notify start " .. tostring(castWarningBar) .. "/" .. tostring(castWarningBar.targetGUId) .. "/" .. tostring(active.startTime) .. "/" .. tostring(active.Time) .. "/" .. tostring(castWarningBar.eventName))
				self:TriggerEvent("AloftCastWarning:OnCastWarningDataChanged", aloftData, targetGUId, active)
				aloftData.castWarningLastUpdateTime = now
				aloftData.castWarningEndTime = active.endTime

				return -- we have enabled a cast warning bar, we should stub out here
			elseif active and ((active.fadeEndTime and ((profile.animate and active.fadeEndTime > aloftData.castWarningLastUpdateTime) or (not profile.animate and active.fadeEndTime > aloftData.castWarningLastUpdateTime))) or (active.endTime and active.endTime > aloftData.castWarningLastUpdateTime)) then
				-- still fading or not ended yet; so, animation presumably already in progress, just trigger a data change event, to switch to fade text, and continue
				-- ChatFrame7:AddMessage("AloftCastWarning:Update(): notify fade " .. tostring(aloftData.name) .. "/"  .. tostring(active and active.name))
				self:TriggerEvent("AloftCastWarning:OnCastWarningDataChanged", aloftData, targetGUId, active)
				aloftData.castWarningLastUpdateTime = now

				return -- we have updated the cast warning bar, we should stub out here
			else
				-- animation/fade presumably finished; trigger a data change event and release the cast warning
				-- ChatFrame7:AddMessage("AloftCastWarning:Update(): notify finished " .. tostring(aloftData.name) .. "/"  .. tostring(active and active.name))
				self:TriggerEvent("AloftCastWarning:OnCastWarningDataChanged", aloftData, targetGUId, active)

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

	-- fall through to here: if we have no nameplate id and/or no tracked targetGUId and/or no active cast spellId, then disable any cast warning bar that is showing and/or animation that is in progress
	if not (nameplateId and targetGUId and active) then
		-- ChatFrame7:AddMessage("AloftCastWarning:Update(): handle non-spell " .. tostring(aloftData.name))
		local castWarningBar = aloftData.castWarningBar
		if castWarningBar then
			if castWarningBar.eventName --[[and self:IsEventRegistered(castWarningBar.eventName)]] then
				self:CancelScheduledEvent(castWarningBar.eventName)
				castWarningBar.eventName = nil
				-- ChatFrame7:AddMessage("AloftCastWarning:Update(): cancel obsolete event")
			end
			if castWarningBar:IsVisible() then
				-- ChatFrame7:AddMessage("AloftCastWarning:Update(): release " .. tostring(aloftData.name))
				self:TriggerEvent("AloftCastWarning:OnCastWarningDataChanged", aloftData, targetGUId, active)
				self:ReleaseCastWarning(aloftData)
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftCastWarning:OnIsTargetDataChanged(aloftData)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnIsTargetDataChanged(): enter")

	if (profile.enable) then
		self:ScheduleEvent("AloftCastWarning:UpdateTargetData", self.UpdateTargetData, 0.1, self, aloftData) -- next frame
	end
end

function AloftCastWarning:OnTargetTrackingDataUpdated(targetId, nameplateId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnTargetTrackingDataUpdated(): enter")
	if (profile.enable) then
		self:UpdateCastWarning()
	end
end

function AloftCastWarning:OnTargetTrackingDataCleared(targetId, nameplateId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnTargetTrackingDataCleared(): enter")
	if profile.enable then
		-- TODO: do we actually have anything to do here?
	end
end

function AloftCastWarning:OnNameplateShow(aloftData)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnNameplateShow(): enter")
	self:Update(aloftData)
end

function AloftCastWarning:OnNameplateHide(aloftData)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnNameplateHide(): enter")
	-- TODO: switch event back and forth between AnimateActiveCast and ReleaseCastWarning when nameplate appears/disappears
	self:StopCastEvent(aloftData.castWarningBar)
	self:ReleaseCastWarning(aloftData)

	--[[
	local eventName = "AloftCastWarning:OnNameplateHide: " .. tostring(math.random(1,1000000000))
	self:ScheduleEvent(eventName, self.ReleaseCastWarning, 0.0, self, aloftData) -- next frame
	]]
end

function AloftCastWarning:UpdateTargetData(aloftData)
	-- if not aloftData.castBar:IsVisible() then ChatFrame7:AddMessage("AloftCastWarning:UpdateTargetData(): Blizzard cast bar NOT visible " .. "/" .. tostring(aloftData.name)) end
	self:Update(aloftData)
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
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	if not layoutFrame then
		ChatFrame7:AddMessage("AloftCastWarning:AcquireCastWarning(): no layoutFrame " .. tostring(aloftData.name))
		ChatFrame7:AddMessage("AloftCastWarning:AcquireCastWarning(): " .. debugstack())
	end
	local castWarningBar = aloftData.castWarningBar

	if not castWarningBar then
		castWarningBar = next(castWarningBarPool)
		if castWarningBar then
			castWarningBarPool[castWarningBar] = nil
		else
			castWarningBar = CreateFrame("StatusBar", nil, layoutFrame)
			if not castWarningBar.castWarningExtraFrame then
				castWarningBar.castWarningExtraFrame = CreateFrame("StatusBar", nil, castWarningBar)
			end
		end

		aloftData.castWarningBar = castWarningBar
		castWarningBar.aloftData = aloftData

		self:SetupBar(aloftData, noInterrupt)
		self:PlaceBar(aloftData, noInterrupt)
	end
	castWarningBar:SetParent(layoutFrame)

	return castWarningBar
end

function AloftCastWarning:ReleaseCastWarning(aloftData)
	-- ChatFrame7:AddMessage("AloftCastWarning:ReleaseCastWarning(): release " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/".. tostring(aloftData.maxMana))
	local castWarningBar = aloftData.castWarningBar
	if castWarningBar then
		-- ChatFrame7:AddMessage("CastWarning/ReleaseCastWarning(): release " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))
		-- this could end up redundantly checking the event; TODO: optimize this
		if castWarningBar.eventName --[[and self:IsEventRegistered(castWarningBar.eventName)]] then
			self:CancelScheduledEvent(castWarningBar.eventName)
			-- ChatFrame7:AddMessage("AloftCastWarning:ReleaseCastWarning(): cancel event")
		end

		self:HideCastWarning(aloftData)

		aloftData.castWarningLastUpdateTime = 0
		aloftData.castWarningEndTime = nil

		aloftData.castWarningBar = nil
		castWarningBar.aloftData = nil

		castWarningBar.spellCastTime = nil
		castWarningBar.targetGUId = nil
		castWarningBar.lastVerify = nil
		castWarningBar.eventName = nil

		castWarningBar:SetParent(nil)
		castWarningBarPool[castWarningBar] = true
	end
end

function AloftCastWarning:GetBorder(aloftData, noInterrupt)
	if not profile.targetOnly or (aloftData and (aloftData.isTarget or aloftData:IsTarget())) then
		-- ChatFrame7:AddMessage("AloftHealthBar:GetBorder(): border " .. tostring(profile.border))
		return ((profile.border ~= "None") and 4) or 0, SML:Fetch("border", profile.border)
	else
		return 0, SML:Fetch("border", "None")
	end
end

function AloftCastWarning:SetupBar(aloftData, noInterrupt)
	local nameplateFrame = aloftData.nameplateFrame
	local castWarningBar = aloftData.castWarningBar

	local texture, backdropColor, borderColor
	if noInterrupt then
		texture = SML:Fetch("statusbar", profile.nointerTexture)
		backdropColor = profile.nointerBackdropColor
		borderColor = profile.nointerBorderColor
	else
		texture = SML:Fetch("statusbar", profile.texture)
		backdropColor = profile.backdropColor
		borderColor = profile.borderColor
	end
	local inset, edgeFile = self:GetBorder(aloftData, noInterrupt)

	backdropTable.bgFile = texture
	backdropTable.edgeFile = edgeFile
	backdropTable.insets = { left = inset, right = inset, top = inset, bottom = inset }

	castWarningBar:SetFrameLevel(nameplateFrame:GetFrameLevel())
	castWarningBar:SetStatusBarTexture(texture)

	castWarningBar:SetBackdrop(backdropTable)
	castWarningBar:SetBackdropColor(unpack(profile.backdropColor))
	castWarningBar:SetBackdropBorderColor(unpack(profile.borderColor))

	-- This manipulates the cast warning background to always display above the frame background
	local barRegion, backgroundRegion = castWarningBar:GetRegions()

	barRegion:ClearAllPoints()
	barRegion:SetPoint("TOPLEFT", castWarningBar, "TOPLEFT", inset, -inset)
	barRegion:SetPoint("BOTTOMRIGHT", castWarningBar, "BOTTOMRIGHT", -inset, inset)
	barRegion:SetDrawLayer("ARTWORK")
	barRegion:SetBlendMode("BLEND")
	barRegion:Show()

	backgroundRegion:SetDrawLayer("BACKGROUND")
	backgroundRegion:SetBlendMode("BLEND")
	backgroundRegion:Show()

	-- castWarningBar.castWarningExtraFrame:Hide()
	-- castWarningBar:Hide()
end

function AloftCastWarning:PlaceBar(aloftData, noInterrupt)
	local castWarningBar = aloftData.castWarningBar
	if castWarningBar then
		local nameplateFrame = aloftData.nameplateFrame
		local layoutFrame = aloftData.layoutFrame
		local inset, _ = self:GetBorder(aloftData, noInterrupt)

		castWarningBar:ClearAllPoints()
		castWarningBar:SetPoint("TOPLEFT", layoutFrame, "TOPLEFT", profile.offsets.left - inset, profile.offsets.vertical + inset)
		castWarningBar:SetPoint("BOTTOMRIGHT", layoutFrame, "TOPRIGHT", profile.offsets.right + inset, profile.offsets.vertical - profile.height - inset)

		local castWarningExtraFrame = castWarningBar.castWarningExtraFrame
		if castWarningExtraFrame then
			castWarningExtraFrame:ClearAllPoints()
			castWarningExtraFrame:SetPoint("TOPLEFT", castWarningBar, "TOPLEFT", inset, -inset)
			castWarningExtraFrame:SetPoint("BOTTOMRIGHT", castWarningBar, "BOTTOMRIGHT", -inset, inset)
			castWarningExtraFrame:SetStatusBarColor(0, 0, 0, 0)
			castWarningExtraFrame:SetFrameLevel(nameplateFrame:GetFrameLevel() + 1)
		end
	end
end

function AloftCastWarning:ShowCastWarning(aloftData)
	local castWarningBar = aloftData.castWarningBar
	if castWarningBar then
		castWarningBar:Show()
		-- ChatFrame7:AddMessage("AloftCastWarning:ShowCastWarning(): castWarningBar " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))

		local castWarningExtraFrame = castWarningBar.castWarningExtraFrame
		if castWarningExtraFrame then
			castWarningExtraFrame:Show()
			-- ChatFrame7:AddMessage("AloftCastWarning:ShowCastWarning(): castWarningExtraFrame " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))
		end

		if not aloftData.invisible and profile.alphaOverrideEnable and AloftAlpha then
			aloftData.alphaOverride = profile.alphaOverride
		--[[
			ChatFrame7:AddMessage("AloftCastWarning:ShowCastWarning(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.alphaOverride))
		else
			ChatFrame7:AddMessage("AloftCastWarning:ShowCastWarning(): alpha override disabled " .. tostring(aloftData.invisible) .. "/" .. tostring(profile.alphaOverrideEnable) .. "/" .. tostring(AloftAlpha) .. "/" .. tostring(AloftVisibility and AloftVisibility.db.profile.useAlpha))
		--]]
		end
	end
end

function AloftCastWarning:HideCastWarning(aloftData)
	local castWarningBar = aloftData.castWarningBar
	if castWarningBar then
		if not aloftData.invisible then aloftData.alphaOverride = nil end

		local castWarningExtraFrame = castWarningBar.castWarningExtraFrame
		if castWarningExtraFrame then
			castWarningExtraFrame:Hide()
			-- ChatFrame7:AddMessage("AloftCastWarning:HideCastWarning(): castWarningExtraFrame " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))
		end

		castWarningBar:Hide()
		castWarningBar:SetValue(0)
		castWarningBar:SetMinMaxValues(0, 0)
		-- ChatFrame7:AddMessage("AloftCastWarning:HideCastWarning(): castWarningBar " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid))
	end
end

-----------------------------------------------------------------------------

function AloftCastWarning:AnimateActiveCast(aloftData)
	local now = GetTime()
	aloftData.castWarningLastUpdateTime = now

	local castWarningBar = aloftData.castWarningBar
	if not castWarningBar or not castWarningBar.targetGUId then return end

	local targetGUId = castWarningBar.targetGUId
	local active = self.targetGUIdToActiveCast[targetGUId] -- TODO: pass this in, on event creation? or go gather it on each iteration?

	-- TODO: consider checking periodically to see if there is a targetId associated with the nameplate and if that targetId is still casting/channeling the same spell
	-- TODO: make this a "verification interval", separate from the animation interval?
	if active then
		-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): show cast warning " .. tostring(aloftData.name) .. "/" .. tostring(castWarningBar.targetGUId) .. "/" .. tostring(active) .. "/" .. tostring(active.startTime) .. "<" .. tostring(active.endTime) .. "/" .. tostring(castWarningBar.eventName))
		if aloftData.castBar:IsVisible() or active.target then -- the target cast bar has become visible, or this spellcast began as the target cast bar
			-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): Blizzard cast IS bar visible " .. "/" .. tostring(aloftData.name))
			self:StopActiveCast(aloftData, castWarningBar, targetGUId)
			active = nil
		elseif active.fadeEndTime then -- are we already fading
			if now >= active.fadeEndTime then -- we are done "fading"
				-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): fade done " .. tostring(aloftData.name) .. "/" .. tostring(castWarningBar.targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "|" .. tostring(active.startTime) .. "<" .. tostring(now) .. "<" .. tostring(active.endTime) .. "|" .. tostring(castWarningBar.eventName))
				self:StopActiveCast(aloftData, castWarningBar, targetGUId)
				active = nil
			end
		else -- we are mot already fading
			if now >= active.endTime then -- spell cast/channel is finished, start fading
				-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): expired, start fade " .. tostring(aloftData.name) .. "/" .. tostring(castWarningBar.targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "|" .. tostring(active.startTime) .. "<" .. tostring(now) .. "<" .. tostring(active.endTime) .. "|" .. tostring(castWarningBar.eventName))
				-- TODO: transition finished casting to a "conclusion" phase, where the cast warning bar time interval changes to an outcome and is faded out
				self:EndActiveCast(targetGUId, active.id, active.name, active.rank, SUCCESS, nil)
				self:TriggerEvent("AloftCastWarning:OnCastWarningDataChanged", aloftData, targetGUId, active)
				-- segues to a fade, if the user wants it
			elseif castWarningBar and castWarningBar.lastVerify and now >= (castWarningBar.lastVerify + profile.verifyInterval) then -- time to verify that we are still casting/channeling
				-- spell is still running, and we should verify
				-- TODO: some sort of "formal" 3-way logic, instead of overloading false/nil
				-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): verify " .. tostring(aloftData.name) .. "/" .. tostring(castWarningBar.targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "|" .. tostring(active.startTime) .. "<" .. tostring(now) .. "<" .. tostring(active.endTime) .. "|" .. tostring(castWarningBar.eventName))
				local verified = self:VerifyActiveCast(AloftTargetTrackingData:GetGUIdNameplateId(targetGUId), active)
				if verified then -- "true"; have a unitid and can verify still casting/channeling, just update verification time
					castWarningBar.lastVerify = now
				elseif verified ~= nil then -- "false"; have a unitid and can verify NOT still casting/channeling, get rid of the cast warning
					-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): verification failed, start fade " .. tostring(aloftData.name) .. "/" .. tostring(castWarningBar.targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "|" .. tostring(active.startTime) .. "<" .. tostring(now) .. "<" .. tostring(active.endTime) .. "|" .. tostring(castWarningBar.eventName))
					self:EndActiveCast(targetGUId, active.id, active.name, active.rank, FAILURE, nil)
					self:TriggerEvent("AloftCastWarning:OnCastWarningDataChanged", aloftData, targetGUId, active)
					-- segues to a fade, if the user wants it
				else -- nil; no unitid so cannot verify one way or the other, just update verification time, effectively let the cast warning time out normally
					castWarningBar.lastVerify = now
				end
			end
		end
		-- if we have an active spell cast, but no cast warning bar... leave this event running, it will clean up the active cast when it is done
		-- TODO: switch event back and forth between AnimateActiveCast and ReleaseCastWarning when nameplate appears/disappears
		
		if castWarningBar and active then
			-- TODO: enhance to handle displaying non-animated cast bars... set up start/end times to show full duration of cast, like a channel that does not move
			-- animate the cast bar; TODO: somewhat torturous logic, going to be hard to maintain; see if it can be improved, maybe build some of this into the active cast table up front somehow?
			local mnv = (not profile.animate and -active.endTime) or (active.channel and -active.endTime) or active.startTime
			local mxv = (not profile.animate and -active.startTime) or (active.channel and -active.startTime) or active.endTime
			local value = (not profile.animate and -active.startTime) or (active.channel and ((active.fadeStartTime and -active.endTime) or -now)) or ((active.fadeStartTime and active.endTime) or now)
			local alpha = (profile.animate and active.fadeEndTime and profile.fadeDuration > 0.0 and active.fadeEndTime > now and (1.0 - (now - active.fadeStartTime) / profile.fadeDuration)) or 1.0
			-- ChatFrame7:AddMessage("AloftCastWarning:AnimateActiveCast(): animate bar " .. tostring(aloftData.name) .. "/" .. tostring(castWarningBar.targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "/" .. tostring(castWarningBar.eventName) .. "|" .. tostring(active.startTime) .. "<" .. tostring(active.endTime) .. "|" .. tostring(mnv) .. "<" .. tostring(value) .. "<" .. tostring(mxv) .. "|" .. tostring(alpha) .. "/" .. tostring(trigger))

			castWarningBar:SetMinMaxValues(mnv, mxv)
			castWarningBar:SetValue(value)

			castWarningBar:SetAlpha(alpha)
			castWarningBar.castWarningExtraFrame:SetAlpha(alpha)

			self:TriggerEvent("AloftCastWarning:OnCastWarningTimeChanged", aloftData, targetGUId, active)
			-- if trigger then self:TriggerEvent("AloftCastWarning:OnCastWarningTimeChanged", aloftData, targetGUId, active) end
		end
	end
end

function AloftCastWarning:StopActiveCast(aloftData, castWarningBar, targetGUId)
	self:StopCastEvent(castWarningBar)
	self:ReleaseActive(targetGUId) -- clear the current spell
	self:Update(aloftData)
end

function AloftCastWarning:StartRepeatingCastEvent(aloftData, nameplateId, processor, interval)
	castWarningBar.eventName = "AloftCastWarning:AnimateActiveCast:" .. nameplateId .. ":" .. tostring(math.random(1,1000000000))
	self:ScheduleRepeatingEvent(castWarningBar.eventName, processor, interval, self, aloftData)
end

function AloftCastWarning:StartCastEvent(aloftData, nameplateId, processor, interval)
	local castWarningBar = aloftData.castWarningBar

	self:StopCastEvent(castWarningBar)

	castWarningBar.eventName = "AloftCastWarning:AnimateActiveCast:" .. nameplateId .. ":" .. tostring(math.random(1,1000000000))
	self:ScheduleRepeatingEvent(castWarningBar.eventName, processor, interval, self, aloftData)
end

function AloftCastWarning:StopCastEvent(castWarningBar)
	if castWarningBar and castWarningBar.eventName --[[and self:IsEventRegistered(castWarningBar.eventName)]] then
		self:CancelScheduledEvent(castWarningBar.eventName)
		castWarningBar.eventName = nil
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
	-- ChatFrame7:AddMessage("AloftCastWarning:AcquireActive(): " .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank) .. "/" .. tostring(active.noInterrupt))
	-- ChatFrame7:AddMessage("AloftCastWarning:AcquireActive(): " .. debugstack())

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
			-- ChatFrame7:AddMessage("AloftCastWarning:ReleaseActive(): active " .. tostring(targetGUId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank))

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

			active.target = nil
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

-- insure that alphaOverride is as close to the user's setting as possible, but at all costs *different* than AloftAlpha/targetAlpha
function AloftCastWarning:AdjustOptionValues()
	local alpha = (AloftAlpha and AloftAlpha.db.profile.targetAlpha) or 1.0

	if profile.overrideEnabble and profile.alphaOverride == alpha then
		profile.alphaOverride = alpha - 0.01
		if profile.alphaOverride < 0.0 then
			profile.alphaOverride = alpha + 0.01
		end
	end
end

-----------------------------------------------------------------------------

-- end)
