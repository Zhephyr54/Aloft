local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

-- initialize the set of totems

-- list initially lifted from TidyPlates_ThreatPlates
local TotemSpellId =
{
	-- Air Totems
	 8177, -- Grounding Totem
	 8512, -- Windfury Totem
	 3738, -- Wrath of Air Totem

	-- Earth Totems
	 2062, -- Earth Elemental Totem
	 2484, -- Earthbind Totem
	 5730, -- Stoneclaw Totem
	 8071, -- Stoneskin Totem
	 8075, -- Strength of Earth Totem
	 8143, -- Tremor Totem

	-- Fire Totems
	 2894, -- Fire Elemental Totem
	 8227, -- Flametongue Totem
	 8190, -- Magma Totem
	 3599, -- Searing Totem

	-- Water Totems
	 8184, -- Elemental Resistance Totem
	 5394, -- Healing Stream Totem
	 5675, -- Mana Spring Totem
	16190, -- Mana Tide Totem
	87718, -- Totem of Tranquil Mind
}

local _, _, SnakeIcon, _, _, _, _, _, _ = GetSpellInfo(34600)
local _, _, BloodwormIcon, _, _, _, _, _, _ = GetSpellInfo(49542)

Aloft.TotemName = { }
local totemName = Aloft.TotemName

Aloft.IsTotemMap = { }
local totemMap = Aloft.IsTotemMap

for i, spellId in ipairs(TotemSpellId) do
	local name, _, icon, _, _, _, _, _, _ = GetSpellInfo(spellId)
	-- ChatFrame7:AddMessage("AloftIsTotemTagLocale: " .. tostring(spellId) .. "/" .. tostring(name) .. "/" .. tostring(icon))

	totemName[name] = true
	totemMap[name] = icon
end

-- TODO: add localized names for Viper/Venemous Snake/Bloodworm... along with icons for the associated trap/talent?

-----------------------------------------------------------------------------

-- hunter snake trap spawn
--[[ enUS ]] totemMap["Viper"] = SnakeIcon
--[[ enUS ]] totemMap["Venomous Snake"] = SnakeIcon

-- death knight bloodworms
--[[ enUS ]] totemMap["Bloodworm"] = BloodwormIcon

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "deDE") then

-----------------------------------------------------------------------------

-- hunter snake trap spawn
--[[ deDE ]] totemMap["Viper"] = SnakeIcon
--[[ deDE ]] totemMap["Giftige Schlange"] = SnakeIcon

-- death knight bloodworms
--[[ deDE ]] totemMap["Blutwurm"] = BloodwormIcon

-----------------------------------------------------------------------------

elseif (locale == "frFR") then

-----------------------------------------------------------------------------

-- hunter snake trap spawn
--[[ frFR ]] totemMap["Vipère"] = SnakeIcon
--[[ frFR ]] totemMap["Serpent venimeux"] = SnakeIcon

-- death knight bloodworms
--[[ frFR ]] totemMap["Ver de sang"] = BloodwormIcon

-----------------------------------------------------------------------------

elseif (locale == "koKR") then

-----------------------------------------------------------------------------

-- TODO: snake trap spawn, death knight bloodworms

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

-- hunter snake trap spawn
--[[ ruRU ]] totemMap["Гадюка"] = SnakeIcon
--[[ ruRU ]] totemMap["Ядовитая змея"] = SnakeIcon

-- death knight bloodworms
--[[ ruRU ]] totemMap["Кровочерви"] = BloodwormIcon

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

-- TODO: snake trap spawn, death knight bloodworms

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

-- hunter snake trap spawn
--[[ zhTW ]] totemMap["蝮蛇"] = SnakeIcon
--[[ zhTW ]] totemMap["毒蛇"] = SnakeIcon

-- death knight bloodworms
--[[ zhTW ]] totemMap["血蟲"] = BloodwormIcon

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

-- there is no locale/metatable, everything is in the map

-----------------------------------------------------------------------------
