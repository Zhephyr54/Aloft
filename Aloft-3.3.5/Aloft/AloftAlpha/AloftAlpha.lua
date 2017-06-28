local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

local AloftAlpha = Aloft:NewModule("Alpha", "AceEvent-2.0", "AceHook-2.1")
AloftAlpha.dynamic = "AloftAlpha"

-----------------------------------------------------------------------------

AloftAlpha.db = Aloft:AcquireDBNamespace("alpha")
Aloft:RegisterDefaults("alpha", "profile", {
	targetEnable		= false,
	targetAlpha			= 1.0,
	defaultEnable		= false,
	defaultAlpha		= 1.0,
	nonTargetEnable		= false,
	nonTargetAlpha		= 0.80,
	-- interval			= 0.20
})

-----------------------------------------------------------------------------

-- local elapsed = 0
local profile
local updateMethodName
local targetNameplate
local targetExists
local targetAlpha = 1.0 -- default

-----------------------------------------------------------------------------

local function GetUpdateMethodName()
	if profile.targetEnable then
		if profile.defaultEnable then
			if profile.nonTargetEnable then
				return "UpdateAllEnabled"
			else
				return "UpdateAllButNon"
			end
		elseif profile.nonTargetEnable then
			return "UpdateAllButDefault"
		else
			return "UpdateTargetOnly"
		end
	elseif profile.defaultEnable then
		if profile.nonTargetEnable then
			return "UpdateAllButTarget"
		else
			return "UpdateDefaultOnly"
		end
	elseif profile.nonTargetEnable then
		return "UpdateNonOnly"
	end
	return "UpdateNone"
end

function AloftAlpha:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnhookAll()

	updateMethodName = GetUpdateMethodName()

	if updateMethodName then
		self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")

		-- Since Aloft requires alpha information to determine target nameplates,
		-- and this module adjusts them, this module then needs to take over
		-- responsibility for determining the target nameplate
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:Hook(Aloft, "GetTargetNameplate", "GetTargetNameplate")

		for aloftData in Aloft:IterateNameplates() do
			-- NOTE: OnUpdate is driven extremely quickly (30 times a second), but apparently Blizzard resets
			--       the alpha of the underlying nameplate at this same frequency, so we have to go along
			self:HookScript(aloftData.nameplateFrame, "OnUpdate", updateMethodName)
		end
	end
end

function AloftAlpha:EnableChange()
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftAlpha:OnInitialize()
	Aloft:DebugRegister("Alpha")
	profile = self.db.profile
end

function AloftAlpha:OnEnable()
	self:RegisterEvents()
	self:AdjustOptionValues()
end

function AloftAlpha:OnDisable()
end

-----------------------------------------------------------------------------

function AloftAlpha:GetTargetNameplate(this, unitName)
	-- Since Aloft requires alpha information to determine target nameplates,
	-- and this module adjusts them, this module then needs to take over
	-- responsibility for determining the target nameplate
	if (targetExists and not targetNameplate) then
		if not unitName then unitName = UnitName("target") end
		-- ChatFrame7:AddMessage("AloftAlpha:GetTargetNameplate(): seek " .. (unitName or "<NOTARGET>"))

		targetNameplate = Aloft:GetNameplateByAlpha(unitName, targetAlpha)
	end

	-- ChatFrame7:AddMessage("AloftAlpha:GetTargetNameplate(): " .. (targetNameplate and targetNameplate.name or "<NOTARGET>"))
	--[[
	if (not targetNameplate) then
		ChatFrame7:AddMessage("AloftAlpha:GetTargetNameplate(): no nameplate")
	else
		ChatFrame7:AddMessage("AloftAlpha:GetTargetNameplate(): found nameplate " .. aloftData.name)
	end
	]]

	return targetNameplate
end

function AloftAlpha:PLAYER_TARGET_CHANGED()
	targetNameplate = nil
	targetExists = UnitExists("target")
end

-----------------------------------------------------------------------------

local function getAlphaOverride(this)
	local aloftData = this.aloftData
	local alphaOverride = aloftData and aloftData.alphaOverride
	-- if alphaOverride ~= nil then
		-- ChatFrame7:AddMessage("AloftAlpha:getAlphaOverride(): " .. tostring(aloftData.name) .. "/" .. tostring(alphaOverride))
	-- end
	return alphaOverride
	-- return aloftData and aloftData.alphaOverride
end

local function setFrameAlpha(frame, alphaOverride, alpha)
	if alphaOverride ~= nil then
		frame:SetAlpha(alphaOverride)
	else
		frame:SetAlpha(alpha)
	end
end

-----------------------------------------------------------------------------

function AloftAlpha:UpdateAllEnabled(this, seconds)
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllEnabled(): enter")
	-- elapsed = elapsed + seconds
	-- if (elapsed >= profile.interval) then
		if this:GetAlpha() ~= 1 then -- non-target, target selected
			setFrameAlpha(this, getAlphaOverride(this), profile.nonTargetAlpha)
 			-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllEnabled(): non-target " .. tostring(this) .. "/" .. tostring(targetNameplate.name) .. "/" .. tostring(profile.nonTargetAlpha))
		elseif targetExists then -- target, target selected
			targetNameplate = this.aloftData
			targetAlpha = profile.targetAlpha
			setFrameAlpha(this, getAlphaOverride(this), targetAlpha)
 			-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllEnabled(): target " .. tostring(this) .. "/" .. tostring(targetNameplate.name) .. "/" .. tostring(targetAlpha))
			-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllEnabled(): stack:\n" .. debugstack(1, 4, 4))
		else -- all units, no target selected
			setFrameAlpha(this, getAlphaOverride(this), profile.defaultAlpha)
 			-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllEnabled(): default " .. tostring(this) .. "/" .. tostring(targetNameplate.name) .. "/" .. tostring(profile.defaultAlpha))
		end
		-- elapsed = 0
	-- end
	self.hooks[this]["OnUpdate"](this, seconds) -- *must* always chain every event, or the nameplate flickers
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllEnabled(): exit")
end

function AloftAlpha:UpdateAllButNon(this, seconds)
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllButNon(): enter")
	-- elapsed = elapsed + seconds
	-- if (elapsed >= profile.interval) then
		if not targetExists then -- default
			setFrameAlpha(this, getAlphaOverride(this), profile.defaultAlpha)
		elseif this:GetAlpha() == 1 then -- target
			targetNameplate = this.aloftData
			targetAlpha = profile.targetAlpha
			setFrameAlpha(this, getAlphaOverride(this), targetAlpha)
			-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllButDefault(): found " .. tostring(this) .. "/" .. targetNameplate.name)
		else
			local alphaOverride = getAlphaOverride(this)
			if alphaOverride ~= nil then setFrameAlpha(this, alphaOverride, alphaOverride) end
		end
		-- elapsed = 0
	-- end
	self.hooks[this]["OnUpdate"](this, seconds) -- *must* always chain every event, or the nameplate flickers
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllButNon(): exit")
end

function AloftAlpha:UpdateAllButDefault(this, seconds)
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllButDefault(): enter")
	-- elapsed = elapsed + seconds
	-- if (elapsed >= profile.interval) then
		if this:GetAlpha() ~= 1 then
			setFrameAlpha(this, getAlphaOverride(this), profile.nonTargetAlpha)
		elseif targetExists then
			targetNameplate = this.aloftData
			targetAlpha = profile.targetAlpha
			setFrameAlpha(this, getAlphaOverride(this), targetAlpha) -- KLUDGE
			-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllButDefault(): found " .. tostring(this) .. "/" .. targetNameplate.name)
		else
			local alphaOverride = getAlphaOverride(this)
			if alphaOverride ~= nil then setFrameAlpha(this, alphaOverride, alphaOverride) end
		end
		-- elapsed = 0
	-- end
	self.hooks[this]["OnUpdate"](this, seconds) -- *must* always chain every event, or the nameplate flickers
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllButDefault(): exit")
end

function AloftAlpha:UpdateTargetOnly(this, seconds)
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateTargetOnly(): enter")
	-- elapsed = elapsed + seconds
	-- if (elapsed >= profile.interval) then
		if targetExists and this:GetAlpha() == 1 then
			targetNameplate = this.aloftData
			targetAlpha = profile.targetAlpha
			setFrameAlpha(this, getAlphaOverride(this), targetAlpha) -- KLUDGE
			-- ChatFrame7:AddMessage("AloftAlpha:UpdateTargetOnly(): found " .. tostring(this) .. "/" .. targetNameplate.name)
		else
			local alphaOverride = getAlphaOverride(this)
			if alphaOverride ~= nil then setFrameAlpha(this, alphaOverride, alphaOverride) end
		end
		-- elapsed = 0
	-- end
	self.hooks[this]["OnUpdate"](this, seconds) -- *must* always chain every event, or the nameplate flickers
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateTargetOnly(): exit")
end

function AloftAlpha:UpdateAllButTarget(this, seconds)
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllButTarget(): enter")
	-- elapsed = elapsed + seconds
	-- if (elapsed >= profile.interval) then
		local alphaOverride = getAlphaOverride(this)
		if not targetExists then
			setFrameAlpha(this, getAlphaOverride(this), profile.defaultAlpha)
		elseif this:GetAlpha() ~= 1 then
			setFrameAlpha(this, getAlphaOverride(this), profile.nonTargetAlpha)
		else
			targetAlpha = 1
			targetNameplate = this.aloftData
			setFrameAlpha(this, getAlphaOverride(this), targetAlpha) -- KLUDGE
			-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllButTarget(): found " .. tostring(this) .. "/" .. targetNameplate.name)
		end
		-- elapsed = 0
	-- end
	self.hooks[this]["OnUpdate"](this, seconds) -- *must* always chain every event, or the nameplate flickers
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllButTarget(): exit")
end

function AloftAlpha:UpdateDefaultOnly(this, seconds)
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateDefaultOnly(): enter")
	-- elapsed = elapsed + seconds
	-- if (elapsed >= profile.interval) then
		if not targetExists then
			-- ChatFrame7:AddMessage("AloftAlpha:UpdateDefaultOnly(): found default " .. tostring(this) .. "/" .. tostring(this.aloftData and this.aloftData.name))
			setFrameAlpha(this, getAlphaOverride(this), profile.defaultAlpha)
		elseif this:GetAlpha() == 1 then
			targetAlpha = 1
			targetNameplate = this.aloftData
			setFrameAlpha(this, getAlphaOverride(this), targetAlpha) -- KLUDGE
			-- ChatFrame7:AddMessage("AloftAlpha:UpdateDefaultOnly(): found target " .. tostring(this) .. "/" .. tostring(targetNameplate.name))
		else
			local alphaOverride = getAlphaOverride(this)
			if alphaOverride ~= nil then setFrameAlpha(this, alphaOverride, alphaOverride) end
		end
		-- elapsed = 0
	-- end
	self.hooks[this]["OnUpdate"](this, seconds) -- *must* always chain every event, or the nameplate flickers
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateDefaultOnly(): exit")
end

function AloftAlpha:UpdateNonOnly(this, seconds)
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateNonOnly(): enter")
	-- elapsed = elapsed + seconds
	-- if (elapsed >= profile.interval) then
		if this:GetAlpha() ~= 1 then
			setFrameAlpha(this, getAlphaOverride(this), profile.nonTargetAlpha)
		elseif targetExists then
			targetAlpha = 1
			targetNameplate = this.aloftData
			setFrameAlpha(this, getAlphaOverride(this), targetAlpha) -- KLUDGE
			-- ChatFrame7:AddMessage("AloftAlpha:UpdateNonOnly(): found " .. tostring(this) .. "/" .. targetNameplate.name)
		else
			local alphaOverride = getAlphaOverride(this)
			if alphaOverride ~= nil then setFrameAlpha(this, alphaOverride, alphaOverride) end
		end
		-- elapsed = 0
	-- end
	self.hooks[this]["OnUpdate"](this, seconds) -- *must* always chain every event, or the nameplate flickers
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateNonOnly(): exit")
end

-- covers just the alpha override
function AloftAlpha:UpdateNone(this, seconds)
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateNone(): enter")
	-- elapsed = elapsed + seconds
	-- if (elapsed >= profile.interval) then
		local alphaOverride = getAlphaOverride(this)
		if alphaOverride ~= nil then
			setFrameAlpha(this, alphaOverride, alphaOverride)
			-- ChatFrame7:AddMessage("AloftAlpha:UpdateNone(): found " .. tostring(this) .. "/" .. targetNameplate.name)
		end
		-- elapsed = 0
	-- end
	self.hooks[this]["OnUpdate"](this, seconds) -- *must* always chain every event, or the nameplate flickers
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateNone(): exit")
end

-----------------------------------------------------------------------------

function AloftAlpha:SetupFrame(aloftData)
	local nameplateFrame = aloftData.nameplateFrame
	if (self:IsHooked(nameplateFrame, "OnUpdate")) then self:Unhook(nameplateFrame, "OnUpdate") end
	self:HookScript(nameplateFrame, "OnUpdate", updateMethodName)
end

-----------------------------------------------------------------------------

function AloftAlpha:OnNameplateHide(aloftData)
	if targetNameplate == aloftData then
		targetNameplate = nil
	end
end

-----------------------------------------------------------------------------

-- insure that defaultAlpha and nonTargetAlpha are as close to the user's settings as possible, but at all costs *different* than targetAlpha
function AloftAlpha:AdjustOptionValues()
	local alpha = (profile.targetEnable and profile.targetAlpha) or 1.0

	if profile.defaultEnable and profile.defaultAlpha == alpha then
		profile.defaultAlpha = alpha - 0.01
		if profile.defaultAlpha < 0.0 then
			profile.defaultAlpha = alpha + 0.01
		end
	end
	if profile.nonTargetEnable and profile.nonTargetAlpha == alpha then
		profile.nonTargetAlpha = alpha - 0.01
		if profile.nonTargetAlpha < 0.0 then
			profile.nonTargetAlpha = alpha + 0.01
		end
	end
end

-----------------------------------------------------------------------------

end)
