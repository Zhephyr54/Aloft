local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftHealthBar = Aloft:GetModule("HealthBar") -- always on
if not AloftHealthBar then return end

local AloftGlow = Aloft:NewModule("Glow", Aloft, "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

AloftGlow.namespace = "glow"
AloftGlow.defaults =
{
	profile =
	{
		enable				= true,
		explicit			= false,	-- enable explicit "low threat" status indication
		explicitCombatOnly	= true,	-- enable explicit "low threat" status indication in combat only
		invert				= false,	-- disable on targets with aggro, enable on targets without aggro
		combatOnly			= true,	-- invert only in combat (legacy name, for saved variables compatibility)
		invertTankOnly		= false,	-- invert only when "tanking"
		recentlyDamagedOnly	= false,	-- only recently damaged units receive a glow
		healthbar			= false,	-- change the healthbar color, instead of using a glow
		interval			= 0.33,		-- update glow 5 times a second (nominally)
		width				= 140,
		height				= 45,
		offsetX				= 0,
		offsetY				= 0,
		override			= false,
		color				= { 1.0, 0.0, 0.0, 1.0 }, -- red
		-- style				= "THRQTRSQUAREGLOW",
		style				= "3/4 Square Glow",
		blendMode			= "BLEND",
		threatStatusColors =
		{
			-- alpha is not currently used here, these are really just placeholders
			[0]		= { 0.00, 1.00, 0.00, 1.00, },	-- "gray" equivalent (translate gray glow to green; low aggro)
			[1]		= { 0.00, 1.00, 1.00, 1.00, },	-- "yellow" equivalent (tranlate glow to a bright cyan; you are at risk of pulling/losing aggro)
			[2]		= { 1.00, 0.00, 1.00, 1.00, },	-- "orange" equivalent (tranlate glow to a bright magenta; you are really close to pulling/losing aggro)
			[3]		= { 1.00, 0.67, 0.00, 1.00, },	-- "red" equivalent (tranlate glow to a bright orange; this target is securely yours; at variance with Blizzard's "red" to make it clear that glow is working)
		},
	},
}

-----------------------------------------------------------------------------

local unpack=unpack

local inCombat
local isTank = nil

local UnitClass = UnitClass
local UnitAura = UnitAura
local GetShapeshiftForm = GetShapeshiftForm

local _, playerClass = UnitClass("player")

local threatColorStatusMap = { }
local threatStatusColorMap = { }

SML:Register("glow",	"Hard Outline",			[[Interface\Addons\Aloft\Textures\Outline]])
SML:Register("glow",	"Soft Outline",			[[Interface\AddOns\Aloft\Textures\SoftOutline]])
SML:Register("glow",	"Partial Soft Outline",	[[Interface\AddOns\Aloft\Textures\PartialSoftOutline]])
SML:Register("glow",	"3/4 Soft Outline",		[[Interface\AddOns\Aloft\Textures\ThrQrtrSoftOutline]])
SML:Register("glow",	"Extra Soft Outline",	[[Interface\AddOns\Aloft\Textures\ExtraSoftOutline]])
SML:Register("glow",	"Oval Outline",			[[Interface\AddOns\Aloft\Textures\OvalOutline]])
SML:Register("glow",	"Oval Glow",			[[Interface\AddOns\Aloft\Textures\OvalGlow]])
SML:Register("glow",	"Square Glow",			[[Interface\AddOns\Aloft\Textures\SquareGlow]])
SML:Register("glow",	"Partial Square Glow",	[[Interface\AddOns\Aloft\Textures\PartialSquareGlow]])
SML:Register("glow",	"3/4 Square Glow",		[[Interface\AddOns\Aloft\Textures\ThrQrtrSquareGlow]])

-----------------------------------------------------------------------------

Aloft.TagData.DisplayedThreatStatus =
{
	data = "displayedThreatStatus",
	events = "Aloft:OnDisplayedThreatStatusChanged",
	tableData = "displayedThreatStatus",
	numeric = true
}

-----------------------------------------------------------------------------

function AloftGlow:UpdateAll()
	if self.db.profile and self.db.profile.enable then
		if self.db.profile.healthbar then
			for aloftData in Aloft:IterateNameplates() do
				self:ReleaseGlowFrame(aloftData)
			end
		else
			-- ChatFrame7:AddMessage("AloftGlow:OnEnable(): iterate all nameplates, setup and place")
			for aloftData in Aloft:IterateNameplates() do
				local layoutFrame = aloftData.layoutFrame
				local glowFrame = layoutFrame and layoutFrame.glowFrame
				if glowFrame then
					self:SetupGlowFrame(glowFrame)
					self:PlaceGlowFrame(aloftData)

				end
				if aloftData.noGlow then
					aloftData.noGlow = nil
					AloftHealthBar:Update(aloftData)
				end
			end
			for layoutFrame in pairs(Aloft.layoutFramePool) do
				local glowFrame = layoutFrame.glowFrame
				if glowFrame then
					self:SetupGlowFrame(glowFrame)
				end
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftGlow:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftGlow:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	self:RegisterEvents()

	-- construct a lookup map for threat status color that will allow us to manage aggro glow on nameplates
	for status = 0, 3 do
		local tr, tg, tb = GetThreatStatusColor(status)
		threatStatusColorMap[status] = { tr, tg, tb, 1.0 }

		-- construct a coarser approximation of thecolor; blizzard's floating-point numbers are not necessarily consistent
		local r, g, b = floor(tr * 256), floor(tg * 256), floor(tb * 256)
		-- ChatFrame7:AddMessage("AloftGlow:OnEnable(): color " .. ("|cff%02x%02x%02x%s|r"):format(r, g, b, status .. "-" .. tostring(r) .. "/" .. tostring(g)  .. "/" .. tostring(b)))

		-- initialize the threat color status map
		if (not threatColorStatusMap[r]) then threatColorStatusMap[r] = { } end
		if (not threatColorStatusMap[r][g]) then threatColorStatusMap[r][g] = { } end
		threatColorStatusMap[r][g][b] = status
		-- ChatFrame7:AddMessage("AloftGlow:OnEnable(): status " .. status .. "/" .. r .. "." .. g .. "."  .. b)

		-- ChatFrame7:AddMessage("AloftGlow:OnEnable(): " .. ("%s:%03d.%03d.%03d"):format(status, floor(color.r*100), floor(color.g*100), floor(color.b*100)))
		-- ChatFrame7:AddMessage("AloftGlow:OnEnable(): " .. ("%s:0x%02x%02x%02x"):format(status, floor(color.r*255), floor(color.g*255), floor(color.b*255)))
	end

	self:GetIsTank()
	self:UpdateAll()
end

function AloftGlow:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	for aloftData in Aloft:IterateVisibleNameplates() do
		self:ReleaseGlowFrame(aloftData)
		if aloftData.noGlow then
			aloftData.noGlow = nil
			AloftHealthBar:Update(aloftData)
		end
	end
end

function AloftGlow:RegisterEvents()
	-- ChatFrame7:AddMessage("AloftGlow:RegisterEvents(): invoke")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	if self.db.profile and self.db.profile.enable then
		-- if not self.db.profile.healthbar then self:RegisterMessage("Aloft:SetupFrame", "SetupFrame") end
		-- self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterMessage("Aloft:OnIsTargetDataChanged", "OnIsTargetDataChanged")
		self:RegisterMessage("Aloft:OnConfigModeChanged", "OnConfigModeChanged")

		if playerClass == "WARRIOR" or playerClass == "DEATHKNIGHT" or playerClass == "DRUID" then
			-- ChatFrame7:AddMessage("AloftGlow:RegisterEvents(): " .. tostring(playerClass) .. "/UPDATE_SHAPESHIFT_FORM")
			self:RegisterEvent("UPDATE_SHAPESHIFT_FORM", "OnUpdateShapeshiftForm") -- for defensive stance, frost presence, dire/bear form
		end
		if playerClass == "PALADIN" then
			-- ChatFrame7:AddMessage("AloftGlow:RegisterEvents(): " .. tostring(playerClass) .. "/UNIT_AURA")
			self:RegisterEvent("UNIT_AURA", "OnUnitAura") -- for righteous fury
		end

		self:RegisterEvent("PLAYER_REGEN_DISABLED", "OnPlayerRegenDisabled")
		self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnPlayerRegenEnabled")

		-- ChatFrame7:AddMessage("AloftGlow:RegisterEvents(): set up DoGlowUpdate")
		self:ScheduleRepeatingTimer(function() AloftGlow:DoGlowUpdate() end, self.db.profile.interval)
	end
end

function AloftGlow:OnNameplateShow(message, aloftData)
end

function AloftGlow:OnNameplateHide(message, aloftData)
	self:ReleaseGlowFrame(aloftData)

	--[[
	self:ScheduleTimer(function(aloftData) AloftGlow:ReleaseGlowFrame(aloftData) end, 0.0, aloftData) -- next frame
	]]
	aloftData.noGlow = nil
end

-- changing stances/forms
function AloftGlow:OnUpdateShapeshiftForm(event)
	self:GetIsTank() -- is the player now a tank?
	-- ChatFrame7:AddMessage("AloftGlow:OnUpdateShapeshiftForm(): " .. tostring(playerClass) .. "/" .. tostring(isTank))
	self:UpdateAll()
end

-- changing auras
function AloftGlow:OnUnitAura(event, unitid)
	if unitid == "player" then
		-- has the player's tank status changed?
		if self:GetIsTankChanged() then
			-- ChatFrame7:AddMessage("AloftGlow:OnUnitAura(): " .. tostring(playerClass))
			self:UpdateAll() -- only update if the player's tank status has changed, due to acquiring an aura (righteous fury, etc)
			-- NOTE: players gain/lose auras all the time, due to talent/item procs; we are only interested in this when they go from being a tank to not being a tank, or vis-a-versa
			--       otherwise, the nameplate glow flickers continuously, on all visible nameplates... which is really annoying
		end
	end
end

-- enter combat
function AloftGlow:OnPlayerRegenDisabled(event)
	inCombat = true
	self:UpdateAll()
end

-- exit combat
function AloftGlow:OnPlayerRegenEnabled(event)
	inCombat = nil
	self:UpdateAll()
end

function AloftGlow:OnIsTargetDataChanged(message, aloftData)
	self:UpdateAll()
end

function AloftGlow:OnConfigModeChanged(message)
	self:UpdateAll()
end

-- TODO: watch for unitid changes, hook/unhook on that basis as well
function AloftGlow:SetupFrame(message, aloftData)
	--[[
	local nativeGlowRegion = aloftData.nativeGlowRegion
	self:RawHook(nativeGlowRegion, "Show", "ShowFlash", true)
	self:RawHook(nativeGlowRegion, "Hide", "HideFlash", true)
	self:RawHook(nativeGlowRegion, "SetVertexColor", "FlashColor", true)
	self:RawHook(nativeGlowRegion, "SetAlpha", "FlashAlpha", true)
	self:RawHook(nameplateFrame, "SetBackdrop", "NameplateBackdrop", true)
	-- TODO: also try SetBlendMode, SetAllPoints
	]]
end

function AloftGlow:DoGlowUpdate()
	-- ChatFrame7:AddMessage("AloftGlow:DoGlowUpdate(): invoke")
	if self.db.profile.enable then
		-- ChatFrame7:AddMessage("AloftGlow:DoGlowUpdate(): profile enable")
		local targetAloftData = (Aloft:IsConfigModeEnabled() and Aloft:GetTargetNameplate()) or nil
		for aloftData in Aloft:IterateVisibleNameplates() do
			local clean = true -- poor-man's "continue"; re-set below

			local displayedThreatStatusChanged = nil
			if targetAloftData == aloftData then
				local color = (self.db.profile.override and self.db.profile.threatStatusColors[2]) or threatStatusColorMap[2]

				clean = self:ShowGlow(aloftData, color)

				aloftData.displayedThreatStatus = 2
				displayedThreatStatusChanged = true
			elseif aloftData.type == "hostilePlayer" or aloftData.type == "hostile" or aloftData.type == "neutral" then
				-- ChatFrame7:AddMessage("AloftGlow:DoGlowUpdate(): aloftData " .. tostring(aloftData.name))
				local nativeGlowRegion = aloftData.nativeGlowRegion -- Blizzard glow

				-- slave the Aloft glow (progression inverted, if necessary) to the Blizzard glow; the Blizzard glow now has an "empty" texture,
				-- but it is still there, we can obtain its visibility and color, as modified by the WoW client)
				local status
				local originalStatus
				local invert = self.db.profile.invert and (not self.db.profile.combatOnly or (inCombat and (not self.db.profile.recentlyDamagedOnly or not Aloft:GetModule("RecentlyDamagedData", true) or not Aloft:GetModule("RecentlyDamagedData"):IsEnabled() or aloftData.recentlyDamaged))) and (not self.db.profile.invertTankOnly or isTank)
				if nativeGlowRegion:IsShown() then
					local r, g, b, a = nativeGlowRegion:GetVertexColor()
					originalStatus = self:GetThreatStatusByColor(r, g, b)
					if invert then status = abs(originalStatus - 3) else status = originalStatus end -- keep this between 0 and 3; the status color for 0 does not seem to be used; maybe has an alpha of 0?
					-- ChatFrame7:AddMessage("AloftGlow:DoGlowUpdate(): visible status " .. tostring(aloftData.name) .. "/" ..  tostring(status) .. "/" .. ("|c%02x%02x%02x%02xoriginal|r"):format(a*255, r*255, g*255, b*255))
				else
					originalStatus = 0
					status = (invert and 3) or 0
				end

				if aloftData.displayedThreatStatus ~= originalStatus then
					aloftData.displayedThreatStatus = originalStatus
					displayedThreatStatusChanged = true
				end

				-- TODO: look into doing this more efficiently?
				-- TODO: recentlyDamaged semantics seem to have changed? nameTextRegion text color actually does seem to indicate not the mere fact of combat, but some sort of recent damage (times out in 5 seconds)
				if status > 0 or (self.db.profile.explicit and (not self.db.profile.explicitCombatOnly or (inCombat and (not self.db.profile.recentlyDamagedOnly or aloftData.recentlyDamaged)))) then
					-- establish the color
					local color = (self.db.profile.override and self.db.profile.threatStatusColors[status]) or threatStatusColorMap[status]

					clean = self:ShowGlow(aloftData, color)
				end
			end

			if displayedThreatStatusChanged then
				self:SendMessage("Aloft:OnDisplayedThreatStatusChanged", aloftData)
			end

			if clean then
				self:ReleaseGlowFrame(aloftData)
				-- ChatFrame7:AddMessage("AloftGlow:DoGlowUpdate(): clean glow " .. tostring(aloftData.name))

				if aloftData.noGlow then
					aloftData.noGlow = nil
					AloftHealthBar:Update(aloftData)
					-- ChatFrame7:AddMessage("AloftGlow:DoGlowUpdate(): clean healthbar " .. tostring(aloftData.name))
				end
			end
		end
	else
		for aloftData in Aloft:IterateVisibleNameplates() do
			self:ReleaseGlowFrame(aloftData)
		end
	end
end

function AloftGlow:ShowGlow(aloftData, color)
	local clean = true
	if self.db.profile.healthbar then
		-- ChatFrame7:AddMessage("AloftGlow:DoGlowUpdate(): healthbar " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.recentlyDamaged) .. "/" ..  tostring(status) .. "/" .. tostring(self.db.profile.invert) .. "/" .. tostring(self.db.profile.combatOnly) .. "/" .. tostring(inCombat))
		aloftData.noGlow = true -- flag this on the nameplate
		AloftHealthBar:SetHealthBarColor(aloftData, color) -- set the color
		-- ChatFrame7:AddMessage("AloftGlow:DoGlowUpdate(): healthbar update " .. tostring(aloftData.name) .. "/" ..  tostring(status) .. "/" .. ("|c%02x%02x%02x%02xcolor|r"):format(color[4]*255, color[1]*255, color[2]*255, color[3]*255))

		-- if there is a residual glow, and we are using healthbars, release the glow
		self:ReleaseGlowFrame(aloftData)

		clean = nil -- poor-man's "continue"; fall through below
	else
		-- ChatFrame7:AddMessage("AloftGlow:DoGlowUpdate(): glow " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.recentlyDamaged) .. "/" ..  tostring(status) .. "/" .. tostring(self.db.profile.invert) .. "/" .. tostring(self.db.profile.combatOnly) .. "/" .. tostring(inCombat))
		local glowFrame = self:AcquireGlowFrame(aloftData)
		if not glowFrame:IsShown() then
			glowFrame:Show()
			-- ChatFrame7:AddMessage("AloftGlow:DoGlowUpdate(): glow frame show " .. tostring(aloftData.name) .. "/"  .. tostring(status))
		end

		glowFrame.glowRegion:SetVertexColor(unpack(color)) -- set the color
		-- ChatFrame7:AddMessage("AloftGlow:DoGlowUpdate(): glow update " .. tostring(aloftData.name) .. "/" ..  tostring(status) .. "/" .. ("|c%02x%02x%02x%02xcolor|r"):format(color[4]*255, color[1]*255, color[2]*255, color[3]*255))

		-- if nameplate is flagged, and we are using glows, reset healthbar color
		if aloftData.noGlow then
			aloftData.noGlow = nil
			AloftHealthBar:Update(aloftData)
		end

		clean = nil -- poor-man's "continue"; fall through below
	end

	return clean
end

--[[
function AloftGlow:ShowFlash(this)
	local aloftData = this.aloftData
	-- ChatFrame7:AddMessage("AloftGlow:ShowFlash(): flash show " .. tostring(this.aloftData.name))
	self.hooks[this].Show(this)
end

function AloftGlow:HideFlash(this)
	local aloftData = this.aloftData
	-- ChatFrame7:AddMessage("AloftGlow:HideFlash(): flash hide " .. tostring(this.aloftData.name))
	self.hooks[this].Hide(this)
end

function AloftGlow:FlashColor(this, r, g, b, a)
	local aloftData = this.aloftData
	-- ChatFrame7:AddMessage("AloftGlow:FlashColor(): flash color " .. tostring(this.aloftData.name))
	self.hooks[this].SetVertexColor(this, r, g, b, a)
end

function AloftGlow:FlashAlpha(this, a)
	local aloftData = this.aloftData
	-- ChatFrame7:AddMessage("AloftGlow:FlashAlpha(): flash alpha " .. tostring(this.aloftData.name))
	self.hooks[this].SetAlpha(this, a)
end

function AloftGlow:NameplateBackdrop(this, t)
	local aloftData = this.aloftData
	-- ChatFrame7:AddMessage("AloftGlow:NameplateBackdrop(): nameplate backdrop " .. tostring(this.aloftData.name))
	self.hooks[this].SetBackdrop(this, t)
end
]]

function AloftGlow:AcquireGlowFrame(aloftData)
	-- ChatFrame7:AddMessage("AloftGlow:AcquireGlowFrame(): acquire " .. tostring(this.aloftData.name))
	local layoutFrame = aloftData.layoutFrame
	if not layoutFrame then
		layoutFrame = Aloft:AcquireLayoutFrame(aloftData)
	end
	if not layoutFrame then
		ChatFrame7:AddMessage("AloftGlow:AcquireGlowFrame(): no layoutFrame " .. tostring(aloftData.name))
		ChatFrame7:AddMessage("AloftGlow:AcquireGlowFrame(): " .. debugstack())
	end
	local glowFrame = layoutFrame.glowFrame

	if not glowFrame then
		glowFrame = CreateFrame("Frame", nil, layoutFrame)

		layoutFrame.glowFrame = glowFrame
		glowFrame.layoutFrame = layoutFrame
		glowFrame.elapsed = 0

		-- ChatFrame7:AddMessage("AloftGlow:AcquireGlowFrame(): setup")
		self:SetupGlowFrame(glowFrame)
	end

	self:PlaceGlowFrame(aloftData)

	return glowFrame
end

function AloftGlow:SetupGlowFrame(glowFrame)
	local glowRegion = glowFrame.glowRegion
	if (not glowRegion) then
		glowRegion = glowFrame:CreateTexture(nil, "BACKGROUND") -- this is on purpose, to layer below other textures
		glowFrame.glowRegion = glowRegion
	end

	local texture = SML:Fetch("glow", self.db.profile.style)

	-- ChatFrame7:AddMessage("AloftGlow:SetupGlowFrame(): texture " .. tostring(texture) .. " - " .. tostring(glowRegion:GetTexture()))
	-- glowRegion:SetTexture(glowTexture[self.db.profile.style])
	glowRegion:SetTexture(texture)
	-- ChatFrame7:AddMessage("AloftGlow:SetupGlowFrame(): texture " .. tostring(texture) .. " - " .. tostring(glowRegion:GetTexture()))
	glowRegion:SetBlendMode(self.db.profile.blendMode)
	-- ChatFrame7:AddMessage("AloftGlow:SetupGlowFrame(): texture " .. tostring(glowRegion:GetTexture()))

	glowRegion:ClearAllPoints()
	glowRegion:SetAllPoints(glowFrame) -- conform to the underlying glow frame
	glowRegion:Show()

	glowFrame:SetWidth(self.db.profile.width)
	glowFrame:SetHeight(self.db.profile.height)
	-- glowFrame:Hide()
end

function AloftGlow:PlaceGlowFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local glowFrame = layoutFrame and layoutFrame.glowFrame
	if glowFrame then
		local nameplateFrame = aloftData.nameplateFrame
		local level = nameplateFrame:GetFrameLevel()

		-- ChatFrame7:AddMessage("AloftGlow:PlaceGlowFrame(): place " .. tostring(aloftData.name))
		glowFrame:ClearAllPoints()
		glowFrame:SetPoint("CENTER", layoutFrame.healthFrame, "CENTER", self.db.profile.offsetX, self.db.profile.offsetY)
		glowFrame:SetFrameLevel(level) -- above the backdrop frame, but below all artwork
	end
end

function AloftGlow:ReleaseGlowFrame(aloftData)
	-- ChatFrame7:AddMessage("AloftGlow:ReleaseGlowFrame(): release " .. tostring(aloftData.name))
	self:CleanupGlowFrame(aloftData)
	self:RePoolGlowFrame(aloftData)
end

function AloftGlow:CleanupGlowFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local glowFrame = layoutFrame and layoutFrame.glowFrame
	if glowFrame then
		-- if glowFrame.glowRegion then glowFrame.glowRegion:Hide() end
	end
end

function AloftGlow:RePoolGlowFrame(aloftData)
	local layoutFrame = aloftData.layoutFrame
	local glowFrame = layoutFrame and layoutFrame.glowFrame
	if glowFrame then
		glowFrame:Hide()
	end
end

-----------------------------------------------------------------------------

local wasTank = nil
function AloftGlow:GetIsTankChanged()
	local tmp = wasTank
	wasTank = self:GetIsTank()

	return tmp ~= wasTank
end

-- /script ChatFrame7:AddMessage(tostring(GetShapeshiftForm(false)))
-- /script DEFAULT_CHAT_FRAME:AddMessage(tostring(GetShapeshiftForm(false)))

function AloftGlow:GetIsTank()
	local tmp = nil
	if playerClass == "WARRIOR" then
		tmp = (GetShapeshiftForm(false) == 2) or nil	-- defensive stance
	elseif playerClass == "DEATHKNIGHT" then
		tmp = (GetShapeshiftForm(false) == 1) or nil	-- blood presence (was frost presence; blood now with WoW 4.0.1)
	elseif playerClass == "DRUID" then
		tmp = (GetShapeshiftForm(false) == 1) or nil	-- dire/bear form
	elseif playerClass == "PALADIN" then
		tmp = (UnitAura("player", "Righteous Fury", nil, "HELPFUL|PLAYER") and true) or nil
	end

	-- ChatFrame7:AddMessage("AloftGlow:GetIsTank(): " .. tostring(playerClass) .. "/" .. tostring(value))
	isTank = tmp
	return isTank
end

function AloftGlow:GetThreatStatusByColor(sbr, sbg, sbb)
	-- construct a coarser approximation of our color; blizzard's floating-point numbers are not necessarily consistent
	local r, g, b = floor(sbr * 256), floor(sbg * 256), floor(sbb * 256)

	-- ChatFrame7:AddMessage("AloftGlow:GetThreatStatusByColor(): " .. ("|cff%02x%02x%02x%s|r"):format(r, g, b, tostring(r) .. "/" .. tostring(g)  .. "/" .. tostring(b)))

	-- extract the threat status from the threat color status map; jump through hoops in case the color is not perfect/exact
	-- NOTE: this checking could be expanded to include +2/-2 and beyond, just in case
	local redColorStatusMap = threatColorStatusMap[r] or threatColorStatusMap[r + 1] or threatColorStatusMap[r - 1]
	if (redColorStatusMap) then
		local grnColorStatusMap = redColorStatusMap[g] or redColorStatusMap[g + 1] or redColorStatusMap[g - 1]
		if (grnColorStatusMap) then
			local status = grnColorStatusMap[b] or grnColorStatusMap[b + 1] or grnColorStatusMap[b - 1]
			if (status and status >= 0) then
				-- ChatFrame7:AddMessage("AloftGlow:GetThreatStatusByColor(): " .. tostring(status))
				return status
			end
		end
	end
	return 0
end

-----------------------------------------------------------------------------
