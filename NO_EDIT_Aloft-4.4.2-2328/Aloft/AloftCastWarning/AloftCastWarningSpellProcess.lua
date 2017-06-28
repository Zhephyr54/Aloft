local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

-- ChatFrame7:AddMessage("AloftCastWarningSpellProcess: have globals")

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData", true)
if not AloftTargetTrackingData then return end

local AloftCastWarning = Aloft:GetModule("CastWarning", true)
if not AloftCastWarning then return end

-- ChatFrame7:AddMessage("AloftCastWarningSpellProcess: have modules " .. tostring(Aloft:GetModule("CastWarning", true)))

-----------------------------------------------------------------------------

-- TODO: make these all attributes of AloftCastWarning

-- needs to be maintained to match the definitions in AloftCastWarning.lua/AloftCastWarningOptions.lua; these masks are lifted from Blizzard; buried somewhere in a global table somewhere
local SPELL_SCHOOL_NONE		= SCHOOL_MASK_NONE
local SPELL_SCHOOL_PHYSICAL	= SCHOOL_MASK_PHYSICAL
local SPELL_SCHOOL_HOLY		= SCHOOL_MASK_HOLY
local SPELL_SCHOOL_FIRE		= SCHOOL_MASK_FIRE
local SPELL_SCHOOL_NATURE		= SCHOOL_MASK_NATURE
local SPELL_SCHOOL_FROST		= SCHOOL_MASK_FROST
local SPELL_SCHOOL_SHADOW		= SCHOOL_MASK_SHADOW
local SPELL_SCHOOL_ARCANE		= SCHOOL_MASK_ARCANE
local SPELL_SCHOOL_HEAL		= 0x40000000 				-- this is an imaginary catch-all school for healing spells; make certain no bits are in common

-- priority order (indexes into SCHOOL_COLOR_ORDER); needs to be maintained to match the definitions in AloftCastWarning.lua
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

-----------------------------------------------------------------------------

-- needs to be maintained to match the definitions in AloftCastWarning.lua
local SUCCEEDED	= "SUCCEEDED"
local FAILED		= "FAILED"
local CREATE		= "CREATE"
local INTERRUPTED	= "INTERRUPTED"
local MISSED		= "MISSED"
local BROKEN		= "BROKEN"
local REMOVED		= "REMOVED"
local DELAYED		= "DELAYED"

-----------------------------------------------------------------------------

local COMBATLOG_OBJECT_TYPE_MASK	= 0x0000FC00
local COMBATLOG_OBJECT_TYPE_PET	= 0x00001000
local COMBATLOG_OBJECT_TYPE_NPC	= 0x00000800
local COMBATLOG_OBJECT_TYPE_PLAYER	= 0x00000400

-----------------------------------------------------------------------------

local UnitExists			= UnitExists
local UnitIsDead			= UnitIsDead
local UnitIsEnemy			= UnitIsEnemy
local UnitIsFriend			= UnitIsFriend
local UnitCanAttack		= UnitCanAttack
local UnitPlayerControlled	= UnitPlayerControlled

local GetSpellInfo		= GetSpellInfo
local UnitCastingInfo	= UnitCastingInfo
local UnitChannelInfo	= UnitChannelInfo


local bit_band = _G.bit.band

-----------------------------------------------------------------------------

function AloftCastWarning:GetActiveCastByGUId(originGUId)
	return self.targetGUIdToActiveCast[originGUId]
end

function AloftCastWarning:GetSpellBySpellId(spellId)
	-- ChatFrame7:AddMessage("AloftCastWarning:GetSpellBySpellId(): " .. tostring(spellId))
	if spellId and self.spellIdBase.global.spells then
		local spell = self.spellIdBase.global.spells[spellId]
		return spell
	end
	return nil
end

-----------------------------------------------------------------------------

function AloftCastWarning:RecordSpellUnitInfo(subtype, originId, spellId, spellName)
	local spell
	local typ, origin = self:GetUnitOriginType(originId)

	if origin then
		spell = self:GetSpellBySpellId(spellId)
		-- ChatFrame7:AddMessage("AloftCastWarning:RecordSpellUnitInfo(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(originId))
		if not spell then
			local castName, castRank, castDisplayName, castIcon, castStartTime, castEndTime, isCastTradeSkill, isCastChanneled, noInterrupt = self:GetUnitCastInfo(originId)
			local elapsedTime = (castEndTime and castStartTime and (castEndTime - castStartTime)) or 0.0
			if castName == spellName then
				if elapsedTime > 0.0 then
					spell =
					{
						["recorded"]		= GetTime(), -- so that impermanent spells can be timed out after a while
						["subtype"]			= subtype,
						["origin"]			= origin,
						["id"]				= spellId,
						["name"]			= spellName,
						["rank"]			= castRank or "", -- Blizzard is deprecating rank, we are just recording it here
						["icon"]			= castIcon,
						["castTime"]		= elapsedTime,
						["isChanneled"]		= isCastChanneled,

						["isTradeSkill"]	= (isCastTradeSkill and true) or nil,

						["unit"]			= true, -- track style of origin, so we know when we are complete
					}

					self.spellIdBase.global.spells[spellId] = spell
				end
				-- the case where elapsedTime <= 0.0 is expected, and no spell record should be created
			else
				-- ChatFrame7:AddMessage("AloftCastWarning:RecordSpellUnitInfo(): spell data mismatch, please report this; " .. tostring(subtype) .. "/" .. tostring(originId) .. "/" .. tostring(castName) .. "/" .. tostring(spellName) .. "/" .. tostring(typ) .. "/" .. tostring(origin))
			end
		else
			-- ChatFrame7:AddMessage("AloftCastWarning:RecordSpellUnitInfo(): spell data MATCH; " .. tostring(subtype) .. "/" .. tostring(originId) .. "/" .. tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellName) .. "/" .. tostring(typ) .. "/" .. tostring(origin))
			if not spell.unit or not spell.complete then
				local castName, castRank, castDisplayName, castIcon, castStartTime, castEndTime, isCastTradeSkill, isCastChanneled, noInterrupt = self:GetUnitCastInfo(originId)
				local elapsedTime = (castEndTime and castStartTime and (castEndTime - castStartTime)) or 0.0
				self:MergeSpellUnitInfo(spell, isCastChanneled, isCastTradeSkill, elapsedTime)
			end
		end
	else
		-- ChatFrame7:AddMessage("AloftCastWarning:RecordSpellUnitInfo(): no spell origin, please report this; " .. tostring(subtype) .. "/" .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(typ) .. "/" .. tostring(origin))
	end

	-- ChatFrame7:AddMessage("AloftCastWarning:RecordSpellUnitInfo(): return " .. tostring(spell and spell.id) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank) .. "/" .. tostring(spell and spell.isChanneled) .. "/" .. tostring(spell and spell.castTime))
	return spell
end

function AloftCastWarning:UpdateSpellUnitInfo(spell, isChanneled, isTradeSkill, elapsedTime)
	if spell then
		self:MergeSpellUnitInfo(spell, isChanneled, isTradeSkill, elapsedTime)
	end
end

-- merge 
function AloftCastWarning:MergeSpellUnitInfo(spell, isChanneled, isTradeSkill, elapsedTime)
	if spell and not (spell.permanent or spell.unit) then
		spell.castTime		= max(spell.castTime, elapsedTime)
		spell.isChanneled	= isChanneled
		spell.isTradeSkill	= (isTradeSkill and true) or nil

		spell.unit = true
	end

	if spell.complete and spell.info and spell.unit then
		spell.permanent = true
		spell.info = nil
		spell.unit = nil
	end
end

function AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, isChanneled, effective)
	local spell
	local typ, origin = self:GetLogOriginType(originFlags, originFlags2)

	if origin then
		-- ChatFrame7:AddMessage("AloftCastWarning:RecordSpellLogInfo(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(originFlags) .. "/" .. tostring(spellSchool))
		spell = self:GetSpellBySpellId(spellId)
		if not spell then
			local spellName, spellRank, spellIcon, spellCost, spellIsFunnel, spellPowerType, spellCastTime, spellMinRange, spellMaxRange = self:GetSpellCastInfo(spellId)
			-- ChatFrame7:AddMessage("AloftCastWarning:RecordSpellLogInfo(): " .. "/" .. tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank))
			if spellName and (spellCastTime > 0.0 or (spellSchool and spellSchool ~= 0) or isChanneled) then
				-- TODO: under what circumstances will spellCastTime be <= 0.0?
				spell =
				{
					["recorded"]	= GetTime(), -- so that impermanent spells can be timed out after a while
					["subtype"]		= subtype,
					["origin"]		= origin,
					["id"]			= spellId,
					["name"]		= spellName,
					["rank"]		= spellRank or "", -- Blizzard is deprecating rank, we are just recording it here
					["icon"]		= spellIcon,
					["castTime"]	= spellCastTime,
					["isChanneled"]	= isChanneled,

					["powerType"]	= spellPowerType,
					["minRange"]	= spellMinRange,
					["maxRange"]	= spellMaxRange,
					["school"]		= spellSchool,

					["info"]		= true, -- track style of origin, so we know when we are complete
				}

				self.spellIdBase.global.spells[spellId] = spell
			else
				-- ChatFrame7:AddMessage("AloftCastWarning:RecordSpellLogInfo(): spell data mismatch, please report this; " .. tostring(subtype) .. "/" .. tostring(originFlags) .. "/" .. tostring(spellId) .. "/" .. tostring(spellSchool) .. "/" .. tostring(isChanneled) .. "/" .. tostring(spellCastTime))
			end
		else
			-- ChatFrame7:AddMessage("AloftCastWarning:RecordSpellLogInfo(): spell data MATCH; " .. tostring(subtype) .. "/" .. tostring(originFlags) .. "/" .. tostring(spellId) .. "/" .. tostring(spell.name) .. "/" .. tostring(spellSchool) .. "/" .. tostring(isChanneled) .. "/" .. tostring(spellCastTime))
			if not spell.info or not spell.complete then
				local spellInfoName, spellRank, spellIcon, spellCost, spellIsFunnel, spellPowerType, spellCastTime, spellMinRange, spellMaxRange = self:GetSpellCastInfo(spellId)
				self:MergeSpellLogInfo(spell, subtype, origin, spellSchool, spellCastTime, isChanneled, spellPowerType, spellMinRange, spellMaxRange, effective)
			end
		end
	else
		-- ChatFrame7:AddMessage("AloftCastWarning:RecordSpellLogInfo(): no spell origin, please report this; " .. tostring(subtype) .. "/" .. tostring(originFlags) .. "/" .. tostring(spellId) .. "/" .. tostring(typ) .. "/" .. tostring(origin))
	end

	-- ChatFrame7:AddMessage("AloftCastWarning:RecordSpellLogInfo(): return " .. tostring(spell and spell.id) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank) .. "/" .. tostring(spell and spell.isChanneled) .. "/" .. tostring(spell and spell.castTime))
	return spell
end

function AloftCastWarning:MergeSpellLogInfo(spell, subtype, origin, spellSchool, spellCastTime, spellIsChanneled, spellPowerType, spellMinRange, spellMaxRange, effective)
	if spell and not (spell.permanent or spell.info) then
		spell.school		= spellSchool
		spell.castTime		= max(spell.castTime, spellCastTime)
		spell.powerType		= spellPowerType
		spell.minRange		= spellMinRange
		spell.maxRange		= spellMaxRange

		if not spell.isChanneled then spell.isChanneled = spellIsChanneled end

		spell.info			= true
	end

	if effective and not spell.complete then
		spell.complete = subtype
	end
	if spell.complete and spell.info and spell.unit then
		spell.permanent = true
		spell.info = nil
		spell.unit = nil
	end
end

function AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)
	-- ChatFrame7:AddMessage("AloftCastWarning:UpdateSpellSchool(): "  .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(spellSchool))
	local spell = AloftCastWarning:GetSpellBySpellId(spellId)
	if spell and not (spell.school and spell.school > 0) then
		spell.school = spellSchool
		-- ChatFrame7:AddMessage("AloftCastWarning:UpdateSpellSchool(): updated " .. tostring(spellId) .. "/" .. tostring(spell.school))
	end
end

-----------------------------------------------------------------------------

local function range_damage(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, spellDamage, spellOverkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:RANGE_DAMAGE(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(spellSchool))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)

	--[[
	-- TODO: format resist/block/absorb/etc into an extra string
	if AloftCastWarning:EndActiveCast(originGUId, spellId, spellName, nil, SUCCEEDED, nil) then
		AloftCastWarning:UpdateCastWarning()
	end
	]]
end

local function range_missed(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, missType, amountMissed)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:RANGE_MISSED(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(missType))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)

	--[[
	if AloftCastWarning:EndActiveCast(originGUId, spellId, spellName, nil, MISSED, missType) then
		AloftCastWarning:UpdateCastWarning()
	end
	]]
end

-----------------------------------------------------------------------------

local function spell_cast_start(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_CAST_START(): nameplate " .. tostring(subtype) .. "/" .. tostring(originGUId) .. "/" .. tostring(AloftTargetTrackingData:GetGUIdNameplateId(originGUId)) .. "/" .. tostring(spellId))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, false)
	-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_CAST_START(): record " .. tostring(subtype) .. "/" .. tostring(originGUId) .. "/" .. tostring(AloftTargetTrackingData:GetGUIdNameplateId(originGUId)) .. "/" .. tostring(originFlags) .. "/" .. tostring(spellId) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))

	if spell and AloftCastWarning:StartActiveLogCast(timestamp, originGUId, originFlags, originFlags2, subtype, spellId, spell) then
		AloftCastWarning:UpdateCastWarning()
	end
end

local function spell_damage(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, spellDamage, spellOverkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_DAMAGE(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(spellSchool))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, school)

	-- TODO: format resist/block/absorb/etc into an extra string?
	if AloftCastWarning:EndActiveCast(originGUId, spellId, spellName, nil, SUCCESS, nil) then
		AloftCastWarning:UpdateCastWarning()
	end
end

local function spell_heal(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, amount, overhealing, critical)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_HEAL(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(spellSchool))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)

	if AloftCastWarning:EndActiveCast(originGUId, spellId, spellName, nil, SUCCEEDED, nil) then
		AloftCastWarning:UpdateCastWarning()
	end
end

local function spell_missed(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, missType, amountMissed)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_MISSED(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(missType))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)

	if AloftCastWarning:EndActiveCast(originGUId, spellId, spellName, nil, MISSED, missType) then
		AloftCastWarning:UpdateCastWarning()
	end
end

-----------------------------------------------------------------------------

-- NOTE: *_CAST_SUCCESS is invoked when channeled spells start and/or instant cast events occur
local function spell_cast_success(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_CAST_SUCCESS(): " .. tostring(subtype) .. "/" .. tostring(spellId))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, false)
	-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_CAST_SUCCESS(): " .. tostring(spell and spell.id) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.isChanneled))
	if spell and spell.isChanneled and AloftCastWarning:StartActiveLogCast(timestamp, originGUId, originFlags, originFlags2, subtype, spellId, spell) then
		AloftCastWarning:UpdateCastWarning()
	end
end

local function spell_cast_failed(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, failedType)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_CAST_FAILED(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(failedType))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, false)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)

	if spell and AloftCastWarning:EndActiveCast(originGUId, spellId, spellName, nil, FAILED, failedType) then
		AloftCastWarning:UpdateCastWarning()
	end
end

local function spell_interrupt(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, extraSpellID, extraSpellName, extraSchool)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_INTERRUPT(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(extraSpellID) .. "/" .. tostring(extraSpellName) .. "/" .. tostring(extraSchool))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, false)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)

	if AloftCastWarning:EndActiveCast(originGUId, spellId, spellName, nil, INTERRUPT, extraSpellName) then
		AloftCastWarning:UpdateCastWarning()
	end
end

-----------------------------------------------------------------------------

local function spell_resurrect(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_RESURRECT(): " .. tostring(subtype) .. "/" .. tostring(spellId))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)

	if AloftCastWarning:EndActiveCast(originGUId, spellId, spellName, nil, SUCCEEDED, nil) then
		AloftCastWarning:UpdateCastWarning()
	end
end

local function spell_summon(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_SUMMON(): " .. tostring(subtype) .. "/" .. tostring(spellId))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)

	if AloftCastWarning:EndActiveCast(originGUId, spellId, spellName, nil, SUCCEEDED, nil) then
		AloftCastWarning:UpdateCastWarning()
	end
end

local function spell_create(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_CREATE(): " .. tostring(subtype) .. "/" .. tostring(spellId))
	end

	-- TODO: a spell outcome here?
	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, false)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)

	if AloftCastWarning:EndActiveCast(originGUId, spellId, spellName, nil, CREATE, nil) then
		AloftCastWarning:UpdateCastWarning()
	end
end

-----------------------------------------------------------------------------

local function spell_periodic_damage(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, spellDamage, spellOverkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_PERIODIC_DAMAGE(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(spellSchool))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)
end

local function spell_periodic_heal(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, amount, overhealing, critical)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_PERIODIC_HEAL(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(spellSchool))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)
end

local function spell_periodic_missed(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, missType, amountMissed)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_PERIODIC_MISSED(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(missType))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)
end

-----------------------------------------------------------------------------

local function spell_aura_applied(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, auraType)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_AURA_APPLIED(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(auraType))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, true, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)
end

local function spell_aura_applied_dose(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, auraType, amount)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_AURA_APPLIED_DOSE(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(auraType) .. "/" .. tostring(amount))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)
end

local function spell_aura_broken(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, auraType)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_AURA_BROKEN(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(auraType))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, false)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)
end

local function spell_aura_broken_spell(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, extraSpellID, extraSpellName, extraSchool, auraType)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_AURA_BROKEN_SPELL(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(extraSpellID) .. "/" .. tostring(extraSpellName) .. "/" .. tostring(extraSchool) .. "/" .. tostring(auraType))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, false)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)
end

local function spell_aura_refresh(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, auraType)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_AURA_REFRESH(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(auraType))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, true)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)
end

local function spell_aura_removed(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, auraType)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_AURA_REMOVED(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(auraType))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, true, false)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)
end

local function spell_aura_removed_dose(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, auraType, amount)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SPELL_AURA_REMOVED_DOSE(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(amount))
	end

	local spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, spellSchool, originFlags, originFlags2, nil, false)
	AloftCastWarning:UpdateSpellSchool(subtype, spellId, spellSchool)
end

-----------------------------------------------------------------------------

local function swing_damage(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SWING_DAMAGE(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(spellSchool))
	end
	-- TODO: "attack" seems to be spellid 6603, use that somehow?
end

local function swing_missed(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, missType, amountMissed)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:SWING_MISSED(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(missType))
	end
	-- TODO: "attack" seems to be spellid 6603, use that somehow?
end

-----------------------------------------------------------------------------

local function damage_shield(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, spellDamage, spellOverkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:DAMAGE_SHIELD(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(spellSchool))
	end
end

local function damage_shield_missed(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, missType, amountMissed)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:DAMAGE_SHIELD_MISSED(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(missType))
	end
end

-----------------------------------------------------------------------------

local function damage_split(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, spellId, spellName, spellSchool, spellDamage, spellOverkill, school, resisted, blocked, absorbed, critical, glancing, crushing)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:DAMAGE_SPLIT(): " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(spellSchool))
	end
end

-----------------------------------------------------------------------------

local function unit_died(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags)
	if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:unit_died(): " .. tostring(subtype) .. "/" .. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(targetGUId) .. "/" .. tostring(targetName))
	end
	-- TODO: erase active cast mapping/active cast warning, if any
end

-----------------------------------------------------------------------------

local subtypeDispatchMethods =
{
	-- prefix: RANGE_
	-- TODO: add additional RANGE_ events
	["RANGE_DAMAGE"]			= range_damage,
	["RANGE_MISSED"]			= range_missed,

	-- prefix: SPELL_
	-- TODO: add additional SPELL_ events
	["SPELL_CAST_START"]		= spell_cast_start,
	["SPELL_DAMAGE"]			= spell_damage,
	["SPELL_HEAL"]				= spell_heal,
	["SPELL_MISSED"]			= spell_missed,

	["SPELL_CAST_SUCCESS"]		= spell_cast_success,
	["SPELL_CAST_FAILED"]		= spell_cast_failed,
	["SPELL_INTERRUPT"]			= spell_interrupt,

	["SPELL_RESURRECT"]			= spell_resurrect,
	["SPELL_SUMMON"]			= spell_summon,
	["SPELL_CREATE"]			= spell_create,

	-- ["SPELL_DRAIN"]				= spell_drain,
	-- ["SPELL_ENERGIZE"]			= spell_energize,
	-- ["SPELL_LEECH"]				= spell_leech,

	-- prefix: SPELL_PERIODIC_
	["SPELL_PERIODIC_DAMAGE"]	= spell_periodic_damage,
	["SPELL_PERIODIC_HEAL"]		= spell_periodic_heal,
	["SPELL_PERIODIC_MISSED"]	= spell_periodic_missed,

	-- ["SPELL_PERIODIC_DRAIN"]		= spell_drain,
	-- ["SPELL_PERIODIC_ENERGIZE"]	= spell_energize,
	-- ["SPELL_PERIODIC_LEECH"]		= spell_leech,

	-- prefix: SPELL_AURA_
	["SPELL_AURA_APPLIED"]		= spell_aura_applied,
	["SPELL_AURA_APPLIED_DOSE"]	= spell_aura_applied_dose,
	["SPELL_AURA_BROKEN"]		= spell_aura_broken,
	["SPELL_AURA_BROKEN_SPELL"]	= spell_aura_broken_spell,
	["SPELL_AURA_REFRESH"]		= spell_aura_refresh,
	["SPELL_AURA_REMOVED"]		= spell_aura_removed,
	["SPELL_AURA_REMOVED_DOSE"]	= spell_aura_removed_dose,

	-- ["SPELL_EXTRA_ATTACKS"]		= spell_extra_attacks,

	-- prefix: SWING_; NOTE: no spell duration on these
	-- ["SWING_DAMAGE"]			= swing_damage,
	-- ["SWING_MISSED"]			= swing_missed,

	-- prefix: DAMAGE_SHIELD; NOTE: no spell duration on these
	-- ["DAMAGE_SHIELD"]			= damage_shield,
	-- ["DAMAGE_SHIELD_MISSED"]	= damage_shield_missed,

	-- unknown; NOTE: no spell duration on these
	-- ["DAMAGE_SPLIT"]			= damage_split,

	-- unit death
	["UNIT_DIED"]				= unit_died,
}

-----------------------------------------------------------------------------

-- COMBAT_LOG_* event support

function AloftCastWarning:OnCombatLogEvent(event, timestamp, subtype, hideCaster, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, suffix1, suffix2, suffix3, suffix4, suffix5, suffix6, suffix7, suffix8, suffix9, suffix10, suffix11, suffix12)
	-- local unit
	-- if AloftTargetTrackingData:GetGUIdNameplateId(originGUId) then
	-- 	unit = "origin"
	-- elseif AloftTargetTrackingData:GetGUIdNameplateId(targetGUId) then
	-- 	unit = "target"
	-- end
	-- if unit then
	--	ChatFrame7:AddMessage("AloftCastWarning:OnCombatLogEvent(): " .. tostring(timestamp) .. "/" .. tostring(subtype) .. "|"
	--		.. tostring(originGUId) .. "/" .. tostring(originName) .. "/" .. tostring(originFlags) .. "|"
	--		.. tostring(targetGUId) .. "/" .. tostring(targetName) .. "/" .. tostring(targetFlags) .. "|"
	--		.. tostring(spellId) .. "/" .. tostring(spellName) .. "|"
	--		.. tostring(suffix1) .. "/" .. tostring(suffix2) .. "/" .. tostring(suffix3) .. "/" .. tostring(suffix4) .. "/" .. tostring(suffix5) .. "/" .. tostring(suffix6) .. "/" .. tostring(suffix7) .. "/" .. tostring(suffix8) .. "/" .. tostring(suffix9) .. "/" .. tostring(suffix10) .. "/" .. tostring(suffix11) .. "/" .. tostring(suffix12))
	-- end

	-- TODO: filter against playerGUId?

	dispatchMethod = subtypeDispatchMethods[subtype]
	if dispatchMethod then
		dispatchMethod(timestamp, subtype, originGUId, originName, originFlags, originFlags2, targetGUId, targetName, targetFlags, targetFlags2, suffix1, suffix2, suffix3, suffix4, suffix5, suffix6, suffix7, suffix8, suffix9, suffix10, suffix11, suffix12)
	end
end

-----------------------------------------------------------------------------

-- UNIT_SPELLCAST_* support

function AloftCastWarning:OnUnitSpellcastStart(event, originId, spellName, spellRank, spellLineId, spellId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastStart(): " .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spellLineId) .. "/" .. tostring(spellId))
	local castName, castRank, castDisplayName, castIcon, castStartTime, castEndTime, isCastTradeSkill, castId, noInterrupt = UnitCastingInfo(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastStart(): " .. tostring(originId) .. "/" .. tostring(noInterrupt) .. "/" .. tostring(castName) .. "/" .. tostring(castRank) .. "/" .. tostring(castDisplayName) .. "/" .. tostring(castIcon) .. "/" .. tostring(startTime) .. "/" .. tostring(endTime) .. "/" .. tostring(isCastTradeSkill) .. "/" .. tostring(castId))

	local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastStart(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLCAST_START")

	local spell = self:RecordSpellUnitInfo("UNIT_SPELLCAST_START", originId, spellId, spellName)

	-- TODO: filter against playerGUId?

	if spell and AloftCastWarning:StartActiveUnitCast(GetTime(), originId, originGUId, "UNIT_SPELLCAST_START", spellName, spellRank, spell) then
		AloftCastWarning:UpdateCastWarning()
	end
end

function AloftCastWarning:OnUnitSpellcastDelayed(event, originId, spellName, spellRank, spellLineId, spellId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastDelayed(): " .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spellLineId) .. "/" .. tostring(spellId))
	local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastDelayed(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLCAST_DELAYED")

	local spell = self:RecordSpellUnitInfo("UNIT_SPELLCAST_DELAYED", originId, spellId, spellName)
end

function AloftCastWarning:OnUnitSpellcastStop(event, originId, spellName, spellRank, spellLineId, spellId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastStop(): " .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spellLineId) .. "/" .. tostring(spellId))
	local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastStop(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLCAST_STOP")

	-- TODO: filter against playerGUId?

	local spell = self:RecordSpellUnitInfo("UNIT_SPELLCAST_STOP", originId, spellId, spellName)

	if AloftCastWarning:EndActiveCast(originGUId, nil, spellName, spellRank, nil, nil) then
		AloftCastWarning:UpdateCastWarning()
	end
end

function AloftCastWarning:OnUnitSpellcastSucceeded(event, originId, spellName, spellRank, spellLineId, spellId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastSucceeded(): " .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spellLineId) .. "/" .. tostring(spellId))
	local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastSucceeded(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLCAST_SUCCEEDED")

	-- TODO: filter against playerGUId?

	local spell = self:RecordSpellUnitInfo("UNIT_SPELLCAST_SUCCEEDED", originId, spellId, spellName)

	if AloftCastWarning:EndActiveCast(originGUId, nil, spellName, spellRank, SUCCEEDED, nil) then
		AloftCastWarning:UpdateCastWarning()
	end
end

function AloftCastWarning:OnUnitSpellcastFailed(event, originId, spellName, spellRank, spellLineId, spellId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastFailed(): " .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spellLineId) .. "/" .. tostring(spellId))
	local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastFailed(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLCAST_FAILED")

	-- TODO: filter against playerGUId?

	local spell = self:RecordSpellUnitInfo("UNIT_SPELLCAST_FAILED", originId, spellId, spellName)

	if AloftCastWarning:EndActiveCast(originGUId, nil, spellName, spellRank, FAILED, nil) then
		AloftCastWarning:UpdateCastWarning()
	end
end

function AloftCastWarning:OnUnitSpellcastFailedQuiet(event, originId, spellName, spellRank, spellLineId, spellId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastFailedQuiet(): " .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spellLineId) .. "/" .. tostring(spellId))
	local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastFailedQuiet(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLCAST_FAILED_QUIET")

	local spell = self:RecordSpellUnitInfo("UNIT_SPELLCAST_FAILED_QUIET", originId, spellId, spellName)

	if AloftCastWarning:EndActiveCast(originGUId, nil, spellName, spellRank, FAILED, nil) then
		AloftCastWarning:UpdateCastWarning()
	end
end

function AloftCastWarning:OnUnitSpellcastInterrupted(event, originId, spellName, spellRank, spellLineId, spellId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastInterrupted(): " .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spellLineId) .. "/" .. tostring(spellId))
	local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastInterrupted(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLCAST_INTERRUPTED")

	-- TODO: filter against playerGUId?

	local spell = self:RecordSpellUnitInfo("UNIT_SPELLCAST_INTERRUPTED", originId, spellId, spellName)

	if AloftCastWarning:EndActiveCast(originGUId, nil, spellName, spellRank, INTERRUPTED, nil) then
		AloftCastWarning:UpdateCastWarning()
	end
end

function AloftCastWarning:OnUnitSpellcastChannelStart(event, originId, spellName, spellRank, spellLineId, spellId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastChannelStart(): " .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spellLineId) .. "/" .. tostring(spellId))
	local channelName, channelRank, channelDisplayName, channelIcon, channelStartTime, channelEndTime, isChannelTradeSkill, noInterrupt = UnitChannelInfo(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastChannelStart(): " .. tostring(originId) .. "/" .. tostring(noInterrupt) .. "/" .. tostring(channelName) .. "/" .. tostring(channelRank) .. "/" .. tostring(channelDisplayName) .. "/" .. tostring(channelIcon) .. "/" .. tostring(startTime) .. "/" .. tostring(endTime) .. "/" .. tostring(isChannelTradeSkill) .. "/" .. tostring(castId))

	local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastChannelStart(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLCAST_START")

	local spell = self:RecordSpellUnitInfo("UNIT_SPELLCAST_CHANNEL_START", originId, spellId, spellName)

	-- TODO: filter against playerGUId?

	if spell and AloftCastWarning:StartActiveUnitCast(GetTime(), originId, originGUId, "UNIT_SPELLCAST_CHANNEL_START", spellName, spellRank, spell) then
		AloftCastWarning:UpdateCastWarning()
	end
end

function AloftCastWarning:OnUnitSpellcastChannelUpdate(event, originId, spellName, spellRank, spellLineId, spellId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastChannelUpdate(): " .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spellLineId) .. "/" .. tostring(spellId))
	local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastChannelUpdate(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLCAST_CHANNEL_UPDATE")

	-- TODO: filter against playerGUId?

	local spell = self:RecordSpellUnitInfo("UNIT_SPELLCAST_CHANNEL_UPDATE", originId, spellId, spellName)
end

function AloftCastWarning:OnUnitSpellcastChannelStop(event, originId, spellName, spellRank, spellLineId, spellId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastChannelStop(): " .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spellLineId) .. "/" .. tostring(spellId))
	local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastChannelStop(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLCAST_CHANNEL_STOP")

	-- TODO: filter against playerGUId?

	local spell = self:RecordSpellUnitInfo("UNIT_SPELLCAST_CHANNEL_STOP", originId, spellId, spellName)

	if AloftCastWarning:EndActiveCast(originGUId, nil, spellName, spellRank, nil, nil) then
		AloftCastWarning:UpdateCastWarning()
	end
end

-- this is apparently obsolete, 
function AloftCastWarning:OnUnitSpellmiss(event, originId, action)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellmiss(): " .. tostring(originId) .. "/" .. tostring(action))
	-- local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellmiss(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLMISSED")

	-- TODO: filter against playerGUId?

	-- local spell = self:RecordSpellUnitInfo("UNIT_SPELLMISSED", originId, spellName, spellRank)

	-- if AloftCastWarning:EndActiveCast(originGUId, nil, spellName, spellRank, MISSED, action) then
	--	AloftCastWarning:UpdateCastWarning()
	-- end
end

-----------------------------------------------------------------------------

function AloftCastWarning:OnUnitSpellcastInterruptible(event, originId, spellName, spellRank)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastInterruptible(): " .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank))
	-- local castName, castRank, castDisplayName, castIcon, castStartTime, castEndTime, isCastTradeSkill, castId, noInterrupt = UnitCastingInfo(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastInterruptible(): " .. tostring(originId) .. "/" .. tostring(noInterrupt) .. "/" .. tostring(castName) .. "/" .. tostring(castRank) .. "/" .. tostring(castDisplayName) .. "/" .. tostring(castIcon) .. "/" .. tostring(startTime) .. "/" .. tostring(endTime) .. "/" .. tostring(isCastTradeSkill) .. "/" .. tostring(castId))

	--[[
	local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastInterruptible(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLCAST_START")

	local spell = self:RecordSpellUnitInfo("UNIT_SPELLCAST_INTERRUPTIBLE", originId, spellName, spellRank)

	-- TODO: filter against playerGUId?

	if spell and AloftCastWarning:StartActiveUnitCast(GetTime(), originId, originGUId, "UNIT_SPELLCAST_INTERRUPTIBLE", spellName, spellRank, spell) then
		AloftCastWarning:UpdateCastWarning()
	end
	]]
end

function AloftCastWarning:OnUnitSpellcastNotInterruptible(event, originId, spellName, spellRank)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastNotInterruptible(): " .. tostring(originId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank))
	-- local castName, castRank, castDisplayName, castIcon, castStartTime, castEndTime, isCastTradeSkill, castId, noInterrupt = UnitCastingInfo(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastNotInterruptible(): " .. tostring(originId) .. "/" .. tostring(noInterrupt) .. "/" .. tostring(castName) .. "/" .. tostring(castRank) .. "/" .. tostring(castDisplayName) .. "/" .. tostring(castIcon) .. "/" .. tostring(startTime) .. "/" .. tostring(endTime) .. "/" .. tostring(isCastTradeSkill) .. "/" .. tostring(castId))

	--[[
	local originGUId = AloftTargetTrackingData:GetUnitGUId(originId)
	-- ChatFrame7:AddMessage("AloftCastWarning:OnUnitSpellcastNotInterruptible(): " .. tostring(originId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. "UNIT_SPELLCAST_START")

	local spell = self:RecordSpellUnitInfo("UNIT_SPELLCAST_NOT_INTERRUPTIBLE", originId, spellName, spellRank)

	-- TODO: filter against playerGUId?

	if spell and AloftCastWarning:StartActiveUnitCast(GetTime(), originId, originGUId, "UNIT_SPELLCAST_NOT_INTERRUPTIBLE", spellName, spellRank, spell) then
		AloftCastWarning:UpdateCastWarning()
	end
	]]
end

-----------------------------------------------------------------------------

function AloftCastWarning:StartActiveLogCast(timestamp, originGUId, originFlags, originFlags2, subtype, spellId, spell)
	-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): enter " .. tostring(subtype) .. "/" .. tostring(originGUId) .. "/" .. tostring(originFlags) .. "/" .. tostring(spellId) .. "/" .. tostring(spell and spell.id) .. "/" .. tostring(spell and spell.name))

	if AloftTargetTrackingData:GetGUIdUnitid(originGUId) then
		-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): track UNIT_SPELLCAST_* " .. tostring(originGUId) .. "/" .. tostring(AloftTargetTrackingData:GetGUIdUnitid(originGUId)) .. "/" .. tostring(spellId) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))
		return -- this GUID can be tracked via UNIT_SPELLCAST_* events; friendly/grouped or arena
	end
	if not spell then
		-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): no spell for " .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(originFlags))
		return -- could not identify spell
	end

	local now = GetTime()
	local active = self:GetActiveCastByGUId(originGUId)
	-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): " .. tostring(subtype) .. "/" .. tostring(originGUId) .. "/" .. tostring(active) .. "/" .. tostring(spell and spell.id) .. "-" .. tostring(active and active.id) .. "/" .. tostring(spell and spell.name) .. "-" .. tostring(active and active.name) .. "/" .. tostring(active and active.rank) .. "/" .. tostring(active and active.noInterrupt) .. "/" .. tostring(active and active.startTime) .. "/" .. tostring(active and active.endTime) .. "/" .. tostring(now))
	if active then
		-- NOTE: comparing on the basis of (deprecated) name/rank because in certain cases the first tick of a channeled spell
		--       has a different spellId than subsequent ticks (example, Warlock Rain of Fire: 5740>42223, as of 2011/04/27)
		-- TODO: recheck for this, when possible
		if active and spell and active.name == spell.name and active.rank == spell.rank and active.endTime > now then -- same (or functionally equivalent) spell, has not finished casting
			-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): already active " .. tostring(originGUId) .. "/" .. tostring(AloftTargetTrackingData:GetGUIdUnitid(originGUId)) .. "/" .. tostring(spellId) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))
			return nil -- stub out if the spell is already active; this allows us to ignore multiple events for the same spell
		end
	end

	local nameplateId = AloftTargetTrackingData:GetGUIdNameplateId(originGUId)
	-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): nameplateId " .. tostring(originGUId) .. "/" .. tostring(nameplateId) .. "/" .. tostring(originFlags) .. "/" .. tostring(subtype) .. "/" .. tostring(spellId) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))

	-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): check nameplateId " .. tostring(originGUId) .. "/" .. tostring(nameplateId) .. "/" .. tostring(originFlags) .. "/" .. tostring(spellId) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank) .. "/" .. tostring(spell and spell.castTime))
	if nameplateId then
		-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): seek targetId " .. tostring(originGUId) .. "/" .. tostring(nameplateId) .. "/" .. tostring(originFlags) .. "/" .. tostring(spellId) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))
		local targetId = self:GetNameplateTargetId(nameplateId)
		if targetId then -- if we have a targetId
			-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): iterate targetId " .. tostring(originGUId) .. "/" .. tostring(nameplateId) .. "/" .. tostring(originFlags) .. "/" .. tostring(spellId) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))
			active = self:ProcessActiveCast(originGUId, targetId, spell)
			-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): targetId active " .. tostring(active))
			-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): active " .. tostring(nameplateId) .. "/" .. tostring(targetId) .. "/" .. tostring(originGUId) .. "/" .. tostring(originFlags) .. "/" .. tostring(active and active.id) .. "/" .. tostring(active and active.name) .. "/" .. tostring(active and active.rank))
		else
			-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): NO targetId " .. tostring(nameplateId) .. "/" .. tostring(originGUId) .. "/" .. tostring(spellId) .. "/" .. tostring(spellName))
			if not spell then
				-- spell was not found/collected at the top, attempt to record it in some basic form here; theoretically, we should never get here
				spell = AloftCastWarning:RecordSpellLogInfo(subtype, spellId, nil, originFlags, originFlags2, nil, false)
			end

			-- NOTE: comparing on the basis of (deprecated) name/rank because in certain cases the first tick of a channeled spell
			--       has a different spellId than subsequent ticks (example, Warlock Rain of Fire: 5740>42223, as of 2011/04/27)
			-- TODO: recheck for this, when possible
			if spell and spell.castTime > 0.0 and (not active or active.name ~= spell.name or active.rank ~= spell.rank or now > active.endTime) then
				-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): anonymous active " .. tostring(active) .. "/" .. tostring(spell.id) .. "/" .. tostring(active and active.id) .. "/" .. tostring(active and active.endTime) .. "/" .. tostring(now))
				active = self:AcquireActive(now, now + spell.castTime, spell, nil)
			else
				-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveLogCast(): failsafe ".. tostring(originGUId) .. "/"  .. tostring(subtype) .. "/"  .. tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(subtype))
			end
		end

		if active and self.targetGUIdToActiveCast[originGUId] ~= active then
			self:ReleaseActive(originGUId) -- if active has changed materially enough (we have a verified targetId, or active is a different spell), release the old one
			self.targetGUIdToActiveCast[originGUId] = active
			return true
		end
	end
	return nil
end

function AloftCastWarning:StartActiveUnitCast(timestamp, targetId, originGUId, subtype, spellName, spellRank, spell)
	-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveUnitCast(): enter " .. tostring(targetId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))

	if not originGUId then
		-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveUnitCast(): track COMBAT_LOG_* " .. tostring(originGUId) .. "/" .. tostring(AloftTargetTrackingData:GetGUIdUnitid(originGUId)) .. "/" .. tostring(spellId) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))
		return -- this GUID must be tracked via COMBAT_LOG_* events; not friendly/grouped nor arena
	end
	if not spell then
		-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveUnitCast(): no spell for " .. tostring(subtype) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(targetId))
		return -- could not identify spell
	end
	-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveUnitCast(): continue 1 " .. tostring(targetId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))

	local nameplateId = AloftTargetTrackingData:GetGUIdNameplateId(originGUId)
	local active = self:GetActiveCastByGUId(originGUId)
	if active and active.name == spellName and active.rank == spellRank and active.endTime > timestamp then -- same spell, has not finished casting
		-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveUnitCast(): already active " .. tostring(originGUId) .. "/" .. tostring(AloftTargetTrackingData:GetGUIdUnitid(originGUId)) .. "/" .. tostring(spellId) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))
		return -- stub out if the spell is already active; this allows us to ignore multiple events for the same spell
	end
	active = nil
	-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveUnitCast(): continue 2 " .. tostring(targetId) .. "/" .. tostring(nameplateId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))

	if nameplateId and spell.castTime > 0 then
		if targetId then -- if we have a targetId
			active = self:ProcessActiveCast(originGUId, targetId, spell)
			-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveUnitCast(): active " .. tostring(targetId) .. "/" .. tostring(nameplateId) .. "/" .. tostring(originGUId) .. "/" .. tostring(active and active.id) .. "/" .. tostring(active and active.name) .. "/" .. tostring(active and active.rank))
		end

		if active and active ~= self.targetGUIdToActiveCast[originGUId] then
			self.targetGUIdToActiveCast[originGUId] = active
			-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveUnitCast(): assign active " .. tostring(targetId) .. "/" .. tostring(nameplateId) .. "/" .. tostring(originGUId) .. "/" .. tostring(active and active.id) .. "/" .. tostring(active and active.name) .. "/" .. tostring(active and active.rank))
			return true
		else
			-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveUnitCast(): no active " .. tostring(targetId) .. "/" .. tostring(nameplateId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))
		end
	end
	-- ChatFrame7:AddMessage("AloftCastWarning:StartActiveUnitCast(): exit " .. tostring(targetId) .. "/" .. tostring(nameplateId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spell and spell.name) .. "/" .. tostring(spell and spell.rank))
	return false
end

function AloftCastWarning:EndActiveCast(originGUId, spellId, spellName, spellRank, outcome, extra)
	if not originGUId then
		-- ChatFrame7:AddMessage("AloftCastWarning:EndActiveCast(): no originGUId")
		return nil
	end
	
	local nameplateId = AloftTargetTrackingData:GetGUIdNameplateId(originGUId)
	if not nameplateId then
		-- ChatFrame7:AddMessage("AloftCastWarning:EndActiveCast(): no nameplateId")
		return nil
	end

	-- ChatFrame7:AddMessage("AloftCastWarning:EndActiveCast(): attempt " .. tostring(originGUId) .. "/" .. tostring(nameplateId) .. "/" .. tostring(self.targetGUIdToActiveCast[originGUId]))
	local active = self.targetGUIdToActiveCast[originGUId]
	if active and not active.fadeEndTime and ((spellId and spellId == active.id) or (spellName and spellRank and spellName == active.name and spellRank == active.rank)) and (not AloftCastWarning:VerifyActiveCast(nameplateId, active)) then
		-- ChatFrame7:AddMessage("AloftCastWarning:EndActiveCast(): end " .. tostring(nameplateId) .. "/" .. tostring(originGUId) .. "/" .. tostring(outcome) .. "/" .. tostring(extra) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank))
		active.outcome = outcome
		active.extra = extra
		active.fadeStartTime = GetTime()
		active.fadeEndTime = active.fadeStartTime + AloftCastWarning.db.profile.fadeDuration

		return true
	end
	-- ChatFrame7:AddMessage("AloftCastWarning:EndActiveCast(): no end")
	return nil
end

-----------------------------------------------------------------------------

function AloftCastWarning:ProcessActiveCast(originGUId, targetId, spell)
	local castName, castRank, castDisplayName, castIcon, castStartTime, castEndTime, isCastTradeSkill, isCastChanneled, noInterrupt = self:GetUnitCastInfo(targetId)
	-- ChatFrame7:AddMessage("AloftCastWarning:ProcessActiveCast(): update " .. tostring(originGUId) .. "/" .. tostring(targetId) .. "/" .. tostring(noInterrupt) .. "/" .. tostring(spell.id) .. "/" .. tostring(spell.name) .. "/" .. tostring(spell.rank) .. "/" .. tostring(isCastChanneled) .. "/" .. tostring(isCastTradeSkill) .. "/" .. tostring(elapsedTime) .. "/" .. tostring(noInterrupt))

	local active
	if spell and castName == spell.name and spell.castTime > 0 then -- casting
		local elapsedTime = (castEndTime and castStartTime and (castEndTime - castStartTime)) or 0.0
		-- ChatFrame7:AddMessage("AloftCastWarning:ProcessActiveCast(): update " .. tostring(originGUId) .. "/" .. tostring(targetId) .. "/" .. tostring(spell.id) .. "/" .. tostring(spell.name) .. "/" .. tostring(spell.rank) .. "/" .. tostring(isCastChanneled) .. "/" .. tostring(isCastTradeSkill) .. "/" .. tostring(elapsedTime))
		self:UpdateSpellUnitInfo(spell, isCastChanneled, isCastTradeSkill, elapsedTime)
		-- ChatFrame7:AddMessage("AloftCastWarning:ProcessActiveCast(): activate " .. tostring(originGUId) .. "/" .. tostring(targetId) .. "/" .. tostring(spell.id) .. "/" .. tostring(spell.name) .. "/" .. tostring(spell.rank) .. "/" .. tostring(self.targetGUIdToActiveCast[originGUId] and true) .. "/" .. tostring(self.targetGUIdToActiveCast[originGUId] and self.targetGUIdToActiveCast[originGUId].id) .. "/" .. tostring(not isCastTradeSkill or AloftCastWarning.db.profile.tradeSkill) .. "/" .. tostring(self:VerifyTargetId(targetId)))

		active = self.targetGUIdToActiveCast[originGUId]
		if (not active or active.id ~= spell.id or castStartTime > active.endTime) and (AloftCastWarning.db.profile.tradeSkill or not isCastTradeSkill) and self:VerifyTargetId(targetId) then
			local now = castStartTime or GetTime()
			active = self:AcquireActive(now, castEndTime or (now + spell.castTime), spell, noInterrupt)
			-- ChatFrame7:AddMessage("AloftCastWarning:ProcessActiveCast(): new active " .. tostring(originGUId) .. "/" .. tostring(targetId) .. "/" .. tostring(spell.id) .. "/" .. tostring(spell.name) .. "/" .. tostring(spell.rank))
		else
			-- ChatFrame7:AddMessage("AloftCastWarning:ProcessActiveCast(): already active " .. tostring(originGUId) .. "/" .. tostring(targetId) .. "/" .. tostring(spell.id) .. "/" .. tostring(spell.name) .. "/" .. tostring(spell.rank))
			active = nil
		end
	else
		-- ChatFrame7:AddMessage("AloftCastWarning:ProcessActiveCast(): mismatch " .. tostring(originGUId) .. "/" .. tostring(targetId) .. "/" .. tostring(castName) .. "<>" .. tostring(spell.name) .. "/" .. tostring(castRank) .. "<>" .. tostring(spell.rank))
	end
	return active
end

-- NOTE: instant-cast spells will generate a UNIT_SPELLCAST_SUCCEEDED from the player (and other units), but there will be no UnitCasting/ChannelInfo() for the originating unit
-- TODO: some sort of "formal" 3-way logic, instead of overloading false/nil; LUA has nno enumeration type? make them attributes of AloftCastWarning?
-- TODO: re-use the same block of locals
function AloftCastWarning:GetUnitCastInfo(targetId)
	local castName, castRank, castDisplayName, castIcon, castStartTime, castEndTime, isCastTradeSkill, castId, noInterrupt = UnitCastingInfo(targetId)
	-- ChatFrame7:AddMessage("AloftCastWarning:GetUnitCastInfo(): raw " .. tostring(targetId) .. "/" .. tostring(castName) .. "/" .. tostring(castRank) .. "/" .. tostring(castDisplayName) .. "/" .. tostring(castIcon) .. "/" .. tostring(castStartTime) .. "/" .. tostring(castEndTime) .. "/" .. tostring(isCastTradeSkill) .. "/" .. tostring(castId) .. "/" .. tostring(noInterrupt))
	
	if castName then
		local startTime = (castStartTime and castStartTime / 1000.0) or 0.0 -- cast times are reported in milliseconds, stored in seconds
		local endTime = (castEndTime and castEndTime / 1000.0) or 0.0 -- cast times are reported in milliseconds, stored in seconds
		-- ChatFrame7:AddMessage("AloftCastWarning:GetUnitCastInfo(): cast " .. tostring(targetId) .. "/" .. tostring(castName) .. "/" .. tostring(castRank) .. "/" .. tostring(castDisplayName) .. "/" .. tostring(castIcon) .. "/" .. tostring(startTime) .. "/" .. tostring(endTime) .. "/" .. tostring(isCastTradeSkill) .. "/" .. tostring(castId) .. "/" .. tostring(noInterrupt))
		return castName, castRank or "", castDisplayName, castIcon, startTime, endTime, (isCastTradeSkill and true) or false, false, noInterrupt
	else -- a channeled spell
		local channelName, channelRank, channelDisplayName, channelIcon, channelStartTime, channelEndTime, isChannelTradeSkill, noInterrupt = UnitChannelInfo(targetId)
		if channelName then
			local startTime = (channelStartTime and channelStartTime / 1000.0) or 0.0 -- cast times are reported in milliseconds, stored in seconds
			local endTime = (channelEndTime and channelEndTime / 1000.0) or 0.0 -- cast times are reported in milliseconds, stored in seconds
			-- ChatFrame7:AddMessage("AloftCastWarning:GetUnitCastInfo(): channel " .. tostring(targetId) .. "/" .. tostring(channelName) .. "/" .. tostring(channelRank) .. "/" .. tostring(channelDisplayName) .. "/" .. tostring(channelIcon) .. "/" .. tostring(startTime) .. "/" .. tostring(endTime) .. "/" .. tostring(isChannelTradeSkill) .. "/" .. tostring(castId) .. "/" .. tostring(noInterrupt))
			return channelName, channelRank or "", channelDisplayName, channelIcon, startTime, endTime, (isChannelTradeSkill and true) or false, true, noInterrupt
		end
	end
	-- ChatFrame7:AddMessage("AloftCastWarning:GetUnitCastInfo(): none " .. tostring(targetId))
	return nil, nil, nil, nil, nil, nil, nil, nil, nil -- return nil here, distinct from returning true/false up above (for the channeled indicator); this indicates "we don't know"
end

-- TODO: re-use the same block of locals
function AloftCastWarning:GetSpellCastInfo(spellId)
	-- ChatFrame7:AddMessage("AloftCastWarning:GetSpellCastInfo(): " .. tostring(spellId))
	-- ChatFrame7:AddMessage("AloftCastWarning:GetSpellCastInfo(): " .. debugstack())
	local spellName, spellRank, spellIcon, spellCost, spellIsFunnel, spellPowerType, spellCastTime, spellMinRange, spellMaxRange = GetSpellInfo(spellId)
	if spellName then
		local castTime = (spellCastTime and spellCastTime / 1000.0) or 0.0 -- cast times are reported in milliseconds, stored in seconds
		-- ChatFrame7:AddMessage("AloftCastWarning:GetSpellCastInfo(): cast " .. tostring(spellId) .. "/" .. tostring(spellName) .. "/" .. tostring(spellRank) .. "/" .. tostring(spellIcon) .. "/" .. tostring(spellCost) .. "/" .. tostring(spellIsFunnel) .. "/" .. tostring(spellPowerType) .. "/" .. tostring(castTime) .. "/" .. tostring(spellMinRange) .. "/" .. tostring(spellMaxRange))
		return spellName, spellRank, spellIcon, spellCost, spellIsFunnel, spellPowerType, castTime, spellMinRange, spellMaxRange
	end
	-- ChatFrame7:AddMessage("AloftCastWarning:GetSpellCastInfo(): none " .. tostring(spellId))
	return nil, nil, nil, nil, nil, nil, nil, nil, nil
end

-- TODO: some sort of "formal" 3-way logic, instead of overloading false/nil; LUA has no enumeration type? make them attributes of AloftCastWarning?
function AloftCastWarning:VerifyActiveCast(nameplateId, active)
	local targetId = self:GetNameplateTargetId(nameplateId)
	if nameplateId and targetId and active then
		if self:VerifyTargetId(targetId) then
			local castName, castRank, castDisplayName, castIcon, castStartTime, castEndTime, isCastTradeSkill, isCastChanneled, noInterrupt = self:GetUnitCastInfo(targetId)
			if castName and castName == active.name and castRank == active.rank and (not isCastTradeSkill or AloftCastWarning.db.profile.tradeSkill) then
				return true
			else
				-- ChatFrame7:AddMessage("AloftCastWarning:VerifyActiveCast(): NOT cast " .. tostring(nameplateId) .. "/" .. tostring(targetId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(castName) .. "/" .. tostring(active.rank) .. "/" .. tostring(castRank))
				return false -- we are verifiably not casting
			end
		else
			-- ChatFrame7:AddMessage("AloftCastWarning:VerifyActiveCast(): invalid targetId " .. tostring(nameplateId) .. "/" .. tostring(targetId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank))
			return false -- we have a verifiably nonexistent/dead/whatever targetId
		end
	else
		-- ChatFrame7:AddMessage("AloftCastWarning:VerifyActiveCast(): NO targetId " .. tostring(nameplateId) .. "/" .. tostring(active.id) .. "/" .. tostring(active.name) .. "/" .. tostring(active.rank))
		-- no targetId, we can't determine anything
	end
	return nil -- return nil here, distinct from returning false up above; this indicates "we can't positively verify anything"
end

function AloftCastWarning:VerifyTargetId(targetId)
	if not AloftTargetTrackingData:VerifyTargetId(targetId) then
		-- not a valid/identifiable targetId
		-- ChatFrame7:AddMessage("AloftCastWarning:VerifyTargetId(): base invalid " .. tostring(targetId))
		return nil
	end
	-- if not self.db.profile.friendly and (UnitIsFriend("player", targetId) or UnitPlayerControlled(targetId)) then
	if not self.db.profile.friendly and not UnitCanAttack("player", targetId) then -- same-faction duel opponents are still "friendly", neutrals are not "enemies"
	-- if not self.db.profile.friendly and not UnitIsEnemy("player", targetId) then -- same-faction duel opponents are still "friendly"
		-- is not an "enemy", and we are not tracking friendlies
		-- ChatFrame7:AddMessage("AloftCastWarning:VerifyTargetId(): is \"friendly\" " .. tostring(targetId))
		return nil
	end
	if not self.db.profile.players and UnitIsPlayer(targetId) then
		-- is a player, and we are not tracking players
		-- ChatFrame7:AddMessage("AloftCastWarning:VerifyTargetId(): is player " .. tostring(targetId))
		return nil
	end
	return true
end

-----------------------------------------------------------------------------

function AloftCastWarning:GetLogOriginType(originFlags, originFlags2)
	local value = bit_band(originFlags, COMBATLOG_OBJECT_TYPE_MASK)
	if value == COMBATLOG_OBJECT_TYPE_PLAYER then
		return value, "player"
	elseif value == COMBATLOG_OBJECT_TYPE_NPC then
		return value, "NPC"
	elseif value == COMBATLOG_OBJECT_TYPE_PET then
		return value, "pet"
	end
	return 0, nil
end

function AloftCastWarning:GetUnitOriginType(targetId)
	if UnitIsPlayer(targetId) then
		return COMBATLOG_OBJECT_TYPE_PLAYER, "player"
	else
		if UnitPlayerControlled(targetId) then
			return COMBATLOG_OBJECT_TYPE_PET, "pet"
		else
			return COMBATLOG_OBJECT_TYPE_NPC, "NPC"
		end
	end
	return 0, nil
end

-----------------------------------------------------------------------------

end)
