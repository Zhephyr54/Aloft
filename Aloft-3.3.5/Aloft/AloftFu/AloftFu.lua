local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

if not AceLibrary:HasInstance("AceLocale-2.2") then return end
local L = AceLibrary("AceLocale-2.2"):new("AloftFu")

if IsAddOnLoaded("FuBar2Broker") then
	DEFAULT_CHAT_FRAME:AddMessage(L["Aloft FuBar support disabled itself because FuBar2Broker is loaded. Will attempt to load Aloft direct LDB support instead."])
	return
end
if not AceLibrary:HasInstance("FuBarPlugin-2.0") then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

local AloftFu = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceEvent-2.0", "AceHook-2.1", "FuBarPlugin-2.0")
AloftFu.dynamic = "AloftFu"

local waterfall = AceLibrary:HasInstance("Waterfall-1.0") and AceLibrary("Waterfall-1.0")
local dewdrop = AceLibrary:HasInstance("Dewdrop-2.0") and AceLibrary("Dewdrop-2.0")

-----------------------------------------------------------------------------

AloftFu:RegisterDB("AloftFuDB")

AloftFu.title = L["Aloft"]
-- AloftFu.name = "FuBar - " .. L["Aloft"]
AloftFu.hasIcon = "Interface\\Icons\\Spell_Frost_Wisp"
AloftFu.blizzardTooltip = true
AloftFu.defaultPosition = 'LEFT'
AloftFu.hideWithoutStandby = true
AloftFu.independentProfile = true
AloftFu.hasNoColor = true

-----------------------------------------------------------------------------

if not Aloft.Options.args.fubar then
	Aloft.Options.args.extrasSpacer =
	{
		type = 'header',
		order = 900,
	}

	Aloft.Options.args.fubar =
	{
		type = "group",
		name = L["Fubar Options"],
		desc = L["Standard FuBar options"],
		-- args = fubarArgs,
		order = 1000,
	}
end

AloftFu.OnMenuRequest = Aloft.Options
Aloft.Options.args.fubar.args = AceLibrary("FuBarPlugin-2.0"):GetAceOptionsDataTable(AloftFu)

-----------------------------------------------------------------------------

function AloftFu:OnInitialize()
end

function AloftFu:OnEnable()
	self:Hook(Aloft, "DisplayEnemyNameplates")
	self:Hook(Aloft, "DisplayFriendNameplates")
end

function AloftFu:OnDisable()
	self:UnhookAll()
end

-----------------------------------------------------------------------------

function AloftFu:OnTextUpdate()
	self:SetText(L["Aloft"])
end

function AloftFu:OnTooltipUpdate()
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

function AloftFu:OnClick(button, down)
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
		return
	end

	self:UpdateTooltip()
end

-----------------------------------------------------------------------------

function AloftFu:DisplayEnemyNameplates(this, value)
	self.hooks[this].DisplayEnemyNameplates(this, value)
	if (waterfall and waterfall:IsRegistered("Aloft") and waterfall:IsOpen("Aloft")) then waterfall:Refresh("Aloft") end
	if (dewdrop) then dewdrop:Refresh() end
end

function AloftFu:DisplayFriendNameplates(this, value)
	self.hooks[this].DisplayFriendNameplates(this, value)
	if (waterfall and waterfall:IsRegistered("Aloft") and waterfall:IsOpen("Aloft")) then waterfall:Refresh("Aloft") end
	if (dewdrop) then dewdrop:Refresh() end
end

-----------------------------------------------------------------------------

AceLibrary("AceAddon-2.0"):InitializeAddon(AloftFu, "AloftFu")

-----------------------------------------------------------------------------

end)
