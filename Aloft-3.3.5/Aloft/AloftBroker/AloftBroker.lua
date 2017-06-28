local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

if not AceLibrary:HasInstance("AceLocale-2.2") then return end
local L = AceLibrary("AceLocale-2.2"):new("AloftLDB")

-----------------------------------------------------------------------------

if IsAddOnLoaded("Broker2FuBar") then
	DEFAULT_CHAT_FRAME:AddMessage(L["Aloft LDB support disabled itself because Broker2FuBar is loaded. Will attempt to load Aloft direct FuBar support instead."])
	return
end
if not AceLibrary:HasInstance("LibDataBroker-1.1") then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftLDB", function()

-----------------------------------------------------------------------------

local AloftLDB = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.1")
AloftLDB.dynamic = "AloftLDB"

local libDataBroker = AceLibrary:HasInstance("LibDataBroker-1.1") and AceLibrary("LibDataBroker-1.1")
local acehook = AceLibrary:HasInstance("AceHook-2.1") and AceLibrary("AceHook-2.1")
local waterfall = AceLibrary:HasInstance("Waterfall-1.0") and AceLibrary("Waterfall-1.0")
local dewdrop = AceLibrary:HasInstance("Dewdrop-2.0") and AceLibrary("Dewdrop-2.0")

-----------------------------------------------------------------------------

function AloftLDB:OnEnable()
	self:Hook(Aloft, "DisplayEnemyNameplates")
	self:Hook(Aloft, "DisplayFriendNameplates")
end

function AloftLDB:OnDisable()
	self:UnhookAll()
end

-----------------------------------------------------------------------------

function AloftLDB:DisplayEnemyNameplates(this, value)
	self.hooks[this].DisplayEnemyNameplates(this, value)
	if (waterfall and waterfall:IsRegistered("Aloft") and waterfall:IsOpen("Aloft")) then waterfall:Refresh("Aloft") end
	if (dewdrop) then dewdrop:Refresh() end
end

function AloftLDB:DisplayFriendNameplates(this, value)
	self.hooks[this].DisplayFriendNameplates(this, value)
	if (waterfall and waterfall:IsRegistered("Aloft") and waterfall:IsOpen("Aloft")) then waterfall:Refresh("Aloft") end
	if (dewdrop) then dewdrop:Refresh() end
end

-----------------------------------------------------------------------------

local AloftDataObject = libDataBroker:NewDataObject(L["Aloft"], {
    type = "launcher",
    icon = "Interface\\Icons\\Spell_Frost_Wisp",
	text = L["Aloft"],
	-- TODO: enhance to include whether/not nameplates are enabled?
	-- text = L["Aloft"] .. ": " .. Aloft:GetEnemyNameplates() and "Enabled" or "Disabled"
})

-----------------------------------------------------------------------------

function AloftDataObject:OnTooltipShow()
	GameTooltip:ClearLines()
	GameTooltip:AddLine(L["Aloft"] .. " " .. tostring(Aloft.version))
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(Aloft:GetNameplateDisplayState() .. ":")
	GameTooltip:AddDoubleLine(L["Hostile Nameplates"]..": ", Aloft:GetEnemyNameplates() and L["Enabled"] or L["Disabled"])
	GameTooltip:AddDoubleLine(L["Friendly Nameplates"]..": ", Aloft:GetFriendNameplates() and L["Enabled"] or L["Disabled"])
	GameTooltip:AddLine(" ")
	GameTooltip:AddLine(L["Click to toggle nameplates."], 0.2, 1, 0.2)
	if Aloft.Options.args.waterfall then
		GameTooltip:AddLine(L["Shift-Click to open configuration."], 0.2, 1, 0.2)
	end
end

function AloftDataObject:OnClick(button, down)
	if (button == "LeftButton") then
		if (IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown()) then
			GameTooltip:Hide()
			if (waterfall and waterfall:IsRegistered("Aloft")) then
				if waterfall:IsOpen("Aloft") then
					waterfall:Close("Aloft")
				else
					waterfall:Open("Aloft")
				end
			end
			if (dewdrop) then dewdrop:Close() end
			return
		elseif (not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown()) then
			local enabled = Aloft:GetEnemyNameplates()
			if enabled then
				Aloft:DisplayEnemyNameplates(false)
			else
				Aloft:DisplayEnemyNameplates(true)
			end
			-- TODO: enhance to include whether/not nameplates are enabled
			-- self.text = L["Aloft"] .. ": " .. enabled and "Enabled" or "Disabled"
			if (waterfall and waterfall:IsRegistered("Aloft") and waterfall:IsOpen("Aloft")) then waterfall:Refresh("Aloft") end
			if (dewdrop) then dewdrop:Refresh() end
		end
	elseif (button == "RightButton" and not IsShiftKeyDown() and not IsControlKeyDown() and not IsAltKeyDown()) then
		GameTooltip:Hide()
		if (waterfall and waterfall:IsRegistered("Aloft") and waterfall:IsOpen("Aloft")) then
			waterfall:Close("Aloft")
		end
		if (dewdrop and dewdrop:IsOpen(self)) then
			dewdrop:Close()
		elseif (dewdrop) then
			dewdrop:Open(self, 'children', Aloft.Options)
		end
		return
	end

	AloftDataObject:OnTooltipShow()
	GameTooltip:Show()
end

-----------------------------------------------------------------------------

AceLibrary("AceAddon-2.0"):InitializeAddon(AloftLDB, "AloftLDB")

-----------------------------------------------------------------------------

end)
