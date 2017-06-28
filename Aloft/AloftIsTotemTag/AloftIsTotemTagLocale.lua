local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

Aloft.IsTotemLocale = { }
Aloft.IsTotemLocale["default"] = { }

local L = Aloft.IsTotemLocale["default"]

-- shaman totems
--[[ enUS ]] table.insert(L, " Totem$")
--[[ enUS ]] table.insert(L, " Totem [IVX]+$")

-- hunter snake trap spawn
--[[ enUS ]] table.insert(L, "^Viper$")
--[[ enUS ]] table.insert(L, "^Venomous Snake$")

-- death knight bloodworms
--[[ enUS ]] table.insert(L, "^Bloodworm$") -- so far, this seems to be the only NPC of this name on record

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if locale ~= "enUS" then
	Aloft.IsTotemLocale[locale] = { }
	L = Aloft.IsTotemLocale[locale]
end

-----------------------------------------------------------------------------

if (locale == "deDE") then

-----------------------------------------------------------------------------

-- shaman totems
--[[ deDE ]] table.insert(L, "^Totem ")
--[[ deDE ]] table.insert(L, "^Totem .+ [IVX]+")

-- hunter snake trap spawn
--[[ deDE ]] table.insert(L, "^Viper$")
--[[ deDE ]] table.insert(L, "^Giftige Schlange$")

-- death knight bloodworms
--[[ deDE ]] table.insert(L, "^Blutwurm$") -- so far, this seems to be the only NPC of this name on record

-----------------------------------------------------------------------------

elseif (locale == "koKR") then

-----------------------------------------------------------------------------

-- shaman totems
--[[koKR]] table.insert(L, " 토템$")

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

-- shaman totems
--[[ ruRU ]] table.insert(L, "^Тотем .+[ IVX]*$") -- original McFLY submission
--[[ ruRU ]] table.insert(L, "^Тотем .+ [IVX]+$")
--[[ ruRU ]] --table.insert(L, "Тотем.*[IVX]*$") -- slight tweak, hopefully more forgiving

-- hunter snake trap spawn
--[[ ruRU ]] table.insert(L, "[^ ]Гадюка$")
--[[ ruRU ]] table.insert(L, "^Гадюка$")
--[[ ruRU ]] table.insert(L, "[^ ]Ядовитая змея$")
--[[ ruRU ]] table.insert(L, "^Ядовитая змея$")

-- death knight bloodworms
--[[ ruRU ]] table.insert(L, "^Кровочерви$") -- so far, this seems to be the only NPC of this name on record

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

-- shaman totems
--[[ zhCN ]] table.insert(L, "图腾$")

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

-- shaman totems
--[[ zhTW ]] table.insert(L, "圖騰$")

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

local T = { }

T["Searing Totem"]		= "Searing Totem"
T["Searing Totem II"]	= "Searing Totem II"
T["Searing Totem III"]	= "Searing Totem III"
T["Searing Totem IV"]	= "Searing Totem IV"
T["Searing Totem V"]	= "Searing Totem V"
T["Searing Totem VI"]	= "Searing Totem VI"
T["Searing Totem VII"]	= "Searing Totem VII"
T["Searing Totem VIII"]	= "Searing Totem VIII"
T["Searing Totem IX"]	= "Searing Totem IX"
T["Searing Totem X"]	= "Searing Totem X"

local locale = GetLocale()

if locale == "deDE" then

T["Searing Totem"]		= "Totem der Verbrennung"
T["Searing Totem II"]	= "Totem der Verbrennung II"
T["Searing Totem III"]	= "Totem der Verbrennung III"
T["Searing Totem IV"]	= "Totem der Verbrennung IV"
T["Searing Totem V"]	= "Totem der Verbrennung V"
T["Searing Totem VI"]	= "Totem der Verbrennung VI"
T["Searing Totem VII"]	= "Totem der Verbrennung VII"
T["Searing Totem VIII"]	= "Totem der Verbrennung VIII"
T["Searing Totem IX"]	= "Totem der Verbrennung IX"
T["Searing Totem X"]	= "Totem der Verbrennung X"

elseif locale == "esES" then

T["Searing Totem"]		= "Tótem abrasador"
T["Searing Totem II"]	= "Tótem abrasador II"
T["Searing Totem III"]	= "Tótem abrasador III"
T["Searing Totem IV"]	= "Tótem abrasador IV"
T["Searing Totem V"]	= "Tótem abrasador V"
T["Searing Totem VI"]	= "Tótem abrasador VI"
T["Searing Totem VII"]	= "Tótem abrasador VII"
T["Searing Totem VIII"]	= "Tótem abrasador VIII"
T["Searing Totem IX"]	= "Tótem abrasador IX"
T["Searing Totem X"]	= "Tótem abrasador X"

elseif locale == "frFR" then

T["Searing Totem"]		= "Totem incendiaire"
T["Searing Totem II"]	= "Totem incendiaire II"
T["Searing Totem III"]	= "Totem incendiaire III"
T["Searing Totem IV"]	= "Totem incendiaire IV"
T["Searing Totem V"]	= "Totem incendiaire V"
T["Searing Totem VI"]	= "Totem incendiaire VI"
T["Searing Totem VII"]	= "Totem incendiaire VII"
T["Searing Totem VIII"]	= "Totem incendiaire VIII"
T["Searing Totem IX"]	= "Totem incendiaire IX"
T["Searing Totem X"]	= "Totem incendiaire X"


elseif locale == "koKR" then

T["Searing Totem"]		= "Searing Totem"
T["Searing Totem II"]	= "Searing Totem II"
T["Searing Totem III"]	= "Searing Totem III"
T["Searing Totem IV"]	= "Searing Totem IV"
T["Searing Totem V"]	= "Searing Totem V"
T["Searing Totem VI"]	= "Searing Totem VI"
T["Searing Totem VII"]	= "Searing Totem VII"
T["Searing Totem VIII"]	= "Searing Totem VIII"
T["Searing Totem IX"]	= "Searing Totem IX"
T["Searing Totem X"]	= "Searing Totem X"

elseif locale == "ruRU" then

T["Searing Totem"]		= "Опаляющий тотем"
T["Searing Totem II"]	= "Опаляющий тотем II"
T["Searing Totem III"]	= "Опаляющий тотем III"
T["Searing Totem IV"]	= "Опаляющий тотем IV"
T["Searing Totem V"]	= "Опаляющий тотем V"
T["Searing Totem VI"]	= "Опаляющий тотем VI"
T["Searing Totem VII"]	= "Опаляющий тотем VII"
T["Searing Totem VIII"]	= "Опаляющий тотем VIII"
T["Searing Totem IX"]	= "Опаляющий тотем IX"
T["Searing Totem X"]	= "Опаляющий тотем X"

elseif locale == "zhCN" then

T["Searing Totem"]		= "Searing Totem"
T["Searing Totem II"]	= "Searing Totem II"
T["Searing Totem III"]	= "Searing Totem III"
T["Searing Totem IV"]	= "Searing Totem IV"
T["Searing Totem V"]	= "Searing Totem V"
T["Searing Totem VI"]	= "Searing Totem VI"
T["Searing Totem VII"]	= "Searing Totem VII"
T["Searing Totem VIII"]	= "Searing Totem VIII"
T["Searing Totem IX"]	= "Searing Totem IX"
T["Searing Totem X"]	= "Searing Totem X"

elseif locale == "zhTW" then

T["Searing Totem"]		= "Searing Totem"
T["Searing Totem II"]	= "Searing Totem II"
T["Searing Totem III"]	= "Searing Totem III"
T["Searing Totem IV"]	= "Searing Totem IV"
T["Searing Totem V"]	= "Searing Totem V"
T["Searing Totem VI"]	= "Searing Totem VI"
T["Searing Totem VII"]	= "Searing Totem VII"
T["Searing Totem VIII"]	= "Searing Totem VIII"
T["Searing Totem IX"]	= "Searing Totem IX"
T["Searing Totem X"]	= "Searing Totem X"

end

Aloft.IsTotemTagNames = setmetatable(T, { __index = function(t, k) rawset(t, k, k) print("Aloft: No translation found for '" .. k .. "'") return k end })
T = nil
	
Aloft.IsTotemTagDST = { }
for _, value in pairs(Aloft.IsTotemTagNames) do
	Aloft:AddDST(Aloft.IsTotemTagDST, value)
end