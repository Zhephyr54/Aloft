local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftLDB", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftBroker
if not L then return end

-----------------------------------------------------------------------------

if IsAddOnLoaded("Broker2FuBar") then
	DEFAULT_CHAT_FRAME:AddMessage(L["Aloft LDB support disabled itself because Broker2FuBar is loaded. Will attempt to load Aloft direct FuBar support instead."])
	return
end
if not LibStub:GetLibrary("LibDataBroker-1.1", true) then return end
if not LibStub:GetLibrary("AceConfigDialog-3.0", true) then return end

-----------------------------------------------------------------------------

local AloftLDB = Aloft:NewModule("AloftBroker", Aloft, "AceEvent-3.0", "AceHook-3.0", "AceTimer-3.0")
AloftLDB.dynamic = "AloftLDB"

local LibDataBroker = LibStub:GetLibrary("LibDataBroker-1.1", true) and LibStub("LibDataBroker-1.1")
local AceDialog = LibStub:GetLibrary("AceConfigDialog-3.0", true) and LibStub("AceConfigDialog-3.0")

-- local dewdrop = LibStub:GetInstance("Dewdrop-2.0", true) and LibStub("Dewdrop-2.0")

local N = L["Aloft"] .. "-" .. Aloft.version

-----------------------------------------------------------------------------

function AloftLDB:OnInitialize()
	-- ChatFrame7:AddMessage("AloftLDB:OnInitialize(): enter")

	self.initialized = true
end

function AloftLDB:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftLDB:OnEnable(): enter")

	if not self:IsHooked(Aloft, "DisplayEnemyNameplates") then self:RawHook(Aloft, "DisplayEnemyNameplates") end
	if not self:IsHooked(Aloft, "DisplayFriendNameplates") then self:RawHook(Aloft, "DisplayFriendNameplates") end
	
	-- ChatFrame7:AddMessage("AloftLDB:OnEnable(): exit")
end

function AloftLDB:OnDisable()
	-- ChatFrame7:AddMessage("AloftLDB:OnDisable(): enter")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:UnhookAll()

	-- ChatFrame7:AddMessage("AloftLDB:OnDisable(): exit")
end

-----------------------------------------------------------------------------

-- TODO: this is kludgy... but AceConfigDialog does not provide a way to determine if an application's dialog is open; IceHUD does it exactly the same way (basically)
local function isDialogOpen(appName)
	return AceDialog.OpenFrames[appName]
end

-----------------------------------------------------------------------------

function AloftLDB:DisplayEnemyNameplates(this, value)
	self.hooks[this].DisplayEnemyNameplates(this, value)
	-- if (dewdrop) then dewdrop:Refresh() end
end

function AloftLDB:DisplayFriendNameplates(this, value)
	self.hooks[this].DisplayFriendNameplates(this, value)
	-- if (dewdrop) then dewdrop:Refresh() end
end

-----------------------------------------------------------------------------

local AloftDataObject = LibDataBroker:NewDataObject(L["Aloft"], {
    type = "launcher",
    icon = "Interface\\Icons\\Spell_Frost_Wisp",
	text = L["Aloft"],
	-- TODO: enhance to include whether/not nameplates are enabled?
	-- text = L["Aloft"] .. ": " .. Aloft:GetEnemyNameplates() and "Enabled" or "Disabled"
})

-----------------------------------------------------------------------------

function AloftDataObject:OnTooltipShow()
	GameTooltip:ClearLines()
	GameTooltip:AddLine(N)
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(Aloft:GetNameplateDisplayState())
	GameTooltip:AddDoubleLine(L["Hostile Nameplates"]..": ", Aloft:GetEnemyNameplates() and L["Enabled"] or L["Disabled"])
	GameTooltip:AddDoubleLine(L["Friendly Nameplates"]..": ", Aloft:GetFriendNameplates() and L["Enabled"] or L["Disabled"])
	GameTooltip:AddLine(" ")

	GameTooltip:AddLine(L["Click to toggle nameplates."], 0.2, 1, 0.2)
	GameTooltip:AddLine(L["Right-Click to open configuration."], 0.2, 1, 0.2)
end

function AloftDataObject:OnClick(button, down)
	-- ChatFrame7:AddMessage("AloftDataObject:OnClick(): " .. tostring(button) .. "/" .. tostring(down))
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

	AloftDataObject:OnTooltipShow()
	GameTooltip:Show()
end

-----------------------------------------------------------------------------

end)
