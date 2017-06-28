local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAlpha", function()

-----------------------------------------------------------------------------

local AloftAlpha = Aloft:NewModule("Alpha", Aloft, "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
AloftAlpha.dynamic = "AloftAlpha"

local AloftVisibility = nil

-----------------------------------------------------------------------------

AloftAlpha.namespace = "alpha"
AloftAlpha.defaults =
{
	profile =
	{
		targetEnable		= false, -- TODO: basically force targetAlpha to 1.0, and not allow the user to change it; it is too critical to targeting function
		targetAlpha			= 1.0,
		defaultEnable		= false,
		defaultAlpha		= 1.0,
		nonTargetEnable		= false,
		nonTargetAlpha		= 0.80,
		-- interval			= 0.20
	},
}

-----------------------------------------------------------------------------

-- local elapsed = 0
local updateMethodName
local targetNameplate
local targetExists
local targetAlpha = 1.0 -- default

-----------------------------------------------------------------------------

function AloftAlpha:GetUpdateMethodName()
	if self.db.profile.targetEnable then
		if self.db.profile.defaultEnable then
			if self.db.profile.nonTargetEnable then
				return "UpdateAllEnabled"
			else
				return "UpdateAllButNon"
			end
		elseif self.db.profile.nonTargetEnable then
			return "UpdateAllButDefault"
		else
			return "UpdateTargetOnly"
		end
	elseif self.db.profile.defaultEnable then
		if self.db.profile.nonTargetEnable then
			return "UpdateAllButTarget"
		else
			return "UpdateDefaultOnly"
		end
	elseif self.db.profile.nonTargetEnable then
		return "UpdateNonOnly"
	end
	return "UpdateNone"
end

function AloftAlpha:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:UnhookAll()

	updateMethodName = self:GetUpdateMethodName()

	if updateMethodName then
		self:RegisterMessage("Aloft:SetupFrame", "SetupFrame")

		-- Since Aloft requires alpha information to determine target nameplates,
		-- and this module adjusts them, this module then needs to take over
		-- responsibility for determining the target nameplate
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RawHook(Aloft, "GetTargetNameplate", "GetTargetNameplate")

		for aloftData in Aloft:IterateNameplates() do
			-- NOTE: OnUpdate is driven extremely quickly (30 times a second), but apparently Blizzard resets
			--       the alpha of the underlying nameplate at this same frequency, so we have to go along
			self:RawHookScript(aloftData.nameplateFrame, "OnUpdate", updateMethodName)
		end
	end
end

function AloftAlpha:EnableChange()
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftAlpha:OnInitialize()
	-- ChatFrame7:AddMessage("AloftAlpha:OnInitialize(): enter")

	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftAlpha:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:RegisterEvents()
	self:AdjustOptionValues()

	AloftVisibility = Aloft:GetModule("Visibility", true)
end

function AloftAlpha:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:UnhookAll()
end

-----------------------------------------------------------------------------

-- NOTE: the code is still here, but Aloft has abandoned the use of nameplate "original" alpha for the moment;
--       there seem to be too many race conditions, in practical use, between Aloft alpha gyrations and Blizzard
--       switching default alpha (1.0) to non-target alpha (0.6), and all the stuff Aloft has to do
--
--       this seems to confuse target nameplate selection
--
--       TODO: it should be possible, however; will revisit this later, including relying on the Alpha module (when
--             available) to set the isTarget flag

local function UseOriginalAlpha()
	return UnitExists("target") and -- only if a target exists
			AloftVisibility and AloftVisibility:IsEnabled() and AloftVisibility.db and AloftVisibility.db.profile and AloftVisibility.db.profile.useAlpha and AloftVisibility.db.profile.target
end

-- this overrides Aloft:GetTargetNameplate()
function AloftAlpha:GetTargetNameplate(this, unitName)
	-- Since Aloft requires alpha information to determine target nameplates,
	-- and this module adjusts them, this module then needs to take over
	-- responsibility for determining the target nameplate

	if (targetExists and not targetNameplate) then
		local targetName, _ = UnitName("target")
		if not targetName or (unitName and unitName ~= targetName) then
			-- ChatFrame7:AddMessage("AloftAlpha:GetTargetNameplate(): no target" .. tostring(targetName) .. "/" .. tostring(unitName))
			return
		end
		-- ChatFrame7:AddMessage("AloftAlpha:GetTargetNameplate(): seek " .. (targetName or "<NOTARGET>"))

		targetNameplate = Aloft:GetNameplateByAlpha(targetName, 1 --[[ targetAlpha ]], nil --[[ UseOriginalAlpha() ]])
		--[[ if targetNameplate then
			ChatFrame7:AddMessage("AloftAlpha:GetTargetNameplate(): firing Aloft:OnIsTargetDataChanged, gaining target " .. tostring(targetNameplate) .. "/" .. tostring(targetNameplate.name) .. "/" .. tostring(targetNameplate.nameplateFrame:GetAlpha()) .. "/" .. tostring(targetNameplate.isTarget) .. "/" .. tostring(targetNameplate:IsTarget()) .. "/" .. tostring(targetAlpha) .. "/" .. tostring(original) .. "/" .. tostring(targetNameplate.nameplateFrame.originalAlpha))
		end ]]
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

function AloftAlpha:PLAYER_TARGET_CHANGED(event)
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

-- NOTE: the nameplate original alpha is reset by Blizzard on every frame
local function setFrameAlpha(frame, alphaOverride, alpha)
	frame.originalAlpha = frame:GetAlpha()
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
	-- if (elapsed >= self.db.profile.interval) then
		if this:GetAlpha() ~= 1 then -- non-target, target selected
			setFrameAlpha(this, getAlphaOverride(this), self.db.profile.nonTargetAlpha)
 			-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllEnabled(): non-target " .. tostring(this) .. "/" .. tostring(targetNameplate.name) .. "/" .. tostring(self.db.profile.nonTargetAlpha))
		elseif targetExists then -- target, target selected
			targetNameplate = this.aloftData
			targetAlpha = self.db.profile.targetAlpha
			setFrameAlpha(this, getAlphaOverride(this), targetAlpha)
 			-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllEnabled(): target " .. tostring(this) .. "/" .. tostring(targetNameplate.name) .. "/" .. tostring(targetAlpha))
			-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllEnabled(): stack:\n" .. debugstack(1, 4, 4))
		else -- all units, no target selected
			setFrameAlpha(this, getAlphaOverride(this), self.db.profile.defaultAlpha)
 			-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllEnabled(): default " .. tostring(this) .. "/" .. tostring(targetNameplate.name) .. "/" .. tostring(self.db.profile.defaultAlpha))
		end
		-- elapsed = 0
	-- end
	self.hooks[this]["OnUpdate"](this, seconds) -- *must* always chain every event, or the nameplate flickers
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllEnabled(): exit")
end

function AloftAlpha:UpdateAllButNon(this, seconds)
	-- ChatFrame7:AddMessage("AloftAlpha:UpdateAllButNon(): enter")
	-- elapsed = elapsed + seconds
	-- if (elapsed >= self.db.profile.interval) then
		if not targetExists then -- default
			setFrameAlpha(this, getAlphaOverride(this), self.db.profile.defaultAlpha)
		elseif this:GetAlpha() == 1 then -- target
			targetNameplate = this.aloftData
			targetAlpha = self.db.profile.targetAlpha
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
	-- if (elapsed >= self.db.profile.interval) then
		if this:GetAlpha() ~= 1 then
			setFrameAlpha(this, getAlphaOverride(this), self.db.profile.nonTargetAlpha)
		elseif targetExists then
			targetNameplate = this.aloftData
			targetAlpha = self.db.profile.targetAlpha
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
	-- if (elapsed >= self.db.profile.interval) then
		if targetExists and this:GetAlpha() == 1 then
			targetNameplate = this.aloftData
			targetAlpha = self.db.profile.targetAlpha
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
	-- if (elapsed >= self.db.profile.interval) then
		local alphaOverride = getAlphaOverride(this)
		if not targetExists then
			setFrameAlpha(this, getAlphaOverride(this), self.db.profile.defaultAlpha)
		elseif this:GetAlpha() ~= 1 then
			setFrameAlpha(this, getAlphaOverride(this), self.db.profile.nonTargetAlpha)
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
	-- if (elapsed >= self.db.profile.interval) then
		if not targetExists then
			-- ChatFrame7:AddMessage("AloftAlpha:UpdateDefaultOnly(): found default " .. tostring(this) .. "/" .. tostring(this.aloftData and this.aloftData.name))
			setFrameAlpha(this, getAlphaOverride(this), self.db.profile.defaultAlpha)
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
	-- if (elapsed >= self.db.profile.interval) then
		if this:GetAlpha() ~= 1 then
			setFrameAlpha(this, getAlphaOverride(this), self.db.profile.nonTargetAlpha)
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
	-- if (elapsed >= self.db.profile.interval) then
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

function AloftAlpha:SetupFrame(message, aloftData)
	local nameplateFrame = aloftData.nameplateFrame
	if (self:IsHooked(nameplateFrame, "OnUpdate")) then self:Unhook(nameplateFrame, "OnUpdate") end
	self:RawHookScript(nameplateFrame, "OnUpdate", updateMethodName)
end

-----------------------------------------------------------------------------

function AloftAlpha:OnNameplateHide(message, aloftData)
	if targetNameplate == aloftData then
		targetNameplate = nil
	end
end

-----------------------------------------------------------------------------

-- insure that defaultAlpha and nonTargetAlpha are as close to the user's settings as possible, but at all costs *different* than targetAlpha
function AloftAlpha:AdjustOptionValues()
	local alpha = (self.db.profile.targetEnable and self.db.profile.targetAlpha) or 1.0

	if self.db.profile.defaultEnable and self.db.profile.defaultAlpha == alpha then
		self.db.profile.defaultAlpha = alpha - 0.01
		if self.db.profile.defaultAlpha < 0.0 then
			self.db.profile.defaultAlpha = alpha + 0.01
		end
	end
	if self.db.profile.nonTargetEnable and self.db.profile.nonTargetAlpha == alpha then
		self.db.profile.nonTargetAlpha = alpha - 0.01
		if self.db.profile.nonTargetAlpha < 0.0 then
			self.db.profile.nonTargetAlpha = alpha + 0.01
		end
	end
end

-----------------------------------------------------------------------------

end)
