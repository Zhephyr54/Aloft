local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftFu
if not L then return end

-----------------------------------------------------------------------------

if IsAddOnLoaded("FuBar2Broker") then
	DEFAULT_CHAT_FRAME:AddMessage(L["Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."])
	return
end
if not LibStub:GetLibrary("LibFuBarPlugin-3.0", true) then DEFAULT_CHAT_FRAME:AddMessage("Aloft: no LibFuBarPlugin-3.0") return end
-- if not LibStub:GetLibrary("AceGUI-3.0", true) then return end
if not LibStub:GetLibrary("AceConfigDialog-3.0", true) then return end
if not LibStub:GetLibrary("AceDB-3.0", true) then return end

-----------------------------------------------------------------------------

local AloftFu = Aloft:NewModule("Fu", Aloft, "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0", "LibFuBarPlugin-3.0")
AloftFu.dynamic = "AloftFu"

-- local AceGUI = LibStub("AceGUI-3.0")
local AceDialog = LibStub("AceConfigDialog-3.0")
local AceDB = LibStub("AceDB-3.0")

-- local dewdrop = AceLibrary:HasInstance("Dewdrop-2.0") and AceLibrary("Dewdrop-2.0")

-- local F = AceGUI:Create("Frame")
local N = L["Aloft"] .. "-" .. Aloft.version

-----------------------------------------------------------------------------

AloftFu.namespace = "fu"
AloftFu.defaults =
{
	profile =
	{
		showIcon			= true,
		showText			= true,
		hideMinimapButton	= false,
	},
}


-----------------------------------------------------------------------------

function AloftFu:OnInitialize()
	-- ChatFrame7:AddMessage("AloftFu:OnInitialize(): enter")

	AloftFu.title = L["Aloft"]
	-- AloftFu.name = L["Aloft"]
	-- NOTE: the "name" member is used by Ace3 to identify modules; naming the module like this confuses Ace3, which results in (for instance) Aloft:OnEnable() being driven redundantly during module load

	-- separate options database
	self:SetFuBarOption("iconPath", "Interface\\Icons\\Spell_Frost_Wisp")
	self:SetFuBarOption("tooltipType", "GameTooltip")
	self:SetFuBarOption("configType", "None") -- configType needs to be "None", in order to get RightButtonUp semantices to work correctly with AceConfigDialog-3.0
	self:SetFuBarOption("cannotDetachTooltip", true)
	self:SetFuBarOption("hideWithoutStandby", true)
	self:SetFuBarOption("hasNoColor", true)

	-- these are not necessary, should be "None"
	-- self:SetFuBarOption("configType", "AceConfigDialog-3.0")
	-- self:SetFuBarOption("aceConfig30", N)

	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end
	-- if not self.db then self.db = AceDB:New("AloftFuDB", nil, "Default") end

	-- ChatFrame7:AddMessage("AloftFu:OnInitialize(): exit")

	self.initialized = true
end

function AloftFu:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftFu:OnEnable(): enter")

	if not self:IsHooked(Aloft, "DisplayEnemyNameplates") then self:RawHook(Aloft, "DisplayEnemyNameplates") end
	if not self:IsHooked(Aloft, "DisplayFriendNameplates") then self:RawHook(Aloft, "DisplayFriendNameplates") end
	
	if self.db.profile.hideMinimapButton then
		AloftFu:Hide()
	else
		AloftFu:Show()
	end

	-- ChatFrame7:AddMessage("AloftFu:OnEnable(): exit")
end

function AloftFu:OnDisable()
	-- ChatFrame7:AddMessage("AloftFu:OnDisable(): enter")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:UnhookAll()

	-- ChatFrame7:AddMessage("AloftFu:OnDisable(): exit")
end

-----------------------------------------------------------------------------

-- TODO: this is kludgy... but AceConfigDialog does not provide a way to determine if an application's dialog is open; IceHUD does it exactly the same way (basically)
local function isDialogOpen(appName)
	return AceDialog.OpenFrames[appName]
end

-----------------------------------------------------------------------------

function AloftFu:DisplayEnemyNameplates(this, value)
	self.hooks[this].DisplayEnemyNameplates(this, value)
	-- if (dewdrop) then dewdrop:Refresh() end
end

function AloftFu:DisplayFriendNameplates(this, value)
	self.hooks[this].DisplayFriendNameplates(this, value)
	-- if (dewdrop) then dewdrop:Refresh() end
end

-----------------------------------------------------------------------------

function AloftFu.OnUpdateFuBarText(self)
	self:SetFuBarText(L["Aloft"])
end

function AloftFu.OnUpdateFuBarTooltip(self)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(N)
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(Aloft:GetNameplateDisplayState() .. ":")
	GameTooltip:AddDoubleLine(L["Hostile Nameplates"]..": ", Aloft:GetEnemyNameplates() and L["Enabled"] or L["Disabled"])
	GameTooltip:AddDoubleLine(L["Friendly Nameplates"]..": ", Aloft:GetFriendNameplates() and L["Enabled"] or L["Disabled"])
	GameTooltip:AddLine(" ")

	GameTooltip:AddLine(L["Click to toggle nameplates."], 0.2, 1, 0.2)
	GameTooltip:AddLine(L["Right-Click to open configuration."], 0.2, 1, 0.2)
end

function AloftFu:OnFuBarClick(button)
	-- ChatFrame7:AddMessage("AloftFu:OnFuBarClick(): " .. tostring(button))
	if button == "LeftButton" and not IsControlKeyDown() and not IsAltKeyDown() then
		if not IsShiftKeyDown() then
			AceDialog:Close(N)
			local enabled = Aloft:GetEnemyNameplates()
			if enabled then
				Aloft:DisplayEnemyNameplates(false)
			else
				Aloft:DisplayEnemyNameplates(true)
			end
			-- TODO: enhance to include whether/not nameplates are enabled
			-- self.text = L["Aloft"] .. ": " .. enabled and "Enabled" or "Disabled"
			-- if (dewdrop) then dewdrop:Refresh() end
		--[[
		elseif (IsShiftKeyDown()) then
			GameTooltip:Hide()
			if isDialogOpen(N) then
				AceDialog:Close(N)
			else
				AceDialog:Open(N)
			end
			return
		]]
		end
	elseif button == "RightButton" and not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown() then
		GameTooltip:Hide()
		-- ChatFrame7:AddMessage("AloftFu:OnFuBarClick(): " .. tostring(N))
		if isDialogOpen(N) then
			AceDialog:Close(N)
		else
			Aloft:EnableOptions()
			AceDialog:Open(N)
		end
		-- 	if (dewdrop and dewdrop:IsOpen(self)) then
		-- 		dewdrop:Close()
		-- 	elseif (dewdrop) then
		-- 		dewdrop:Open(self, 'children', Aloft.Options)
		-- 	end
		return
	end

	self:UpdateFuBarTooltip()
	GameTooltip:Show()
end

-----------------------------------------------------------------------------

-- LibStub("AceAddon-3.0"):InitializeAddon(AloftFu, "AloftFu")

-----------------------------------------------------------------------------

end)
