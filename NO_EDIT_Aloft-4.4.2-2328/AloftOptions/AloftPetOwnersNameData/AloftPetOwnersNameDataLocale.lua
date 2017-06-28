local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

local tL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

--[[ enUS ]] tL["Pet Owner's Names"] = "Pet Owner's Names"
--[[ enUS ]] tL["Select how to show pet owner's names"] = "Select how to show pet owner's names"

--[[ enUS ]] tL["NONE"]	= "None"
--[[ enUS ]] tL["HYPHEN"]	= "Pet - Owner"
--[[ enUS ]] tL["SLASH"]	= "Pet / Owner"
--[[ enUS ]] tL["BRACKET"]	= "Pet (Owner)"
--[[ enUS ]] tL["COLON"]	= "Pet : Owner"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftPetOwnersName"] = "AloftPetOwnersName"
--[[ enUS ]] mL["Gather and display pet owner's names on nameplates"] = "Gather and display pet owner's names on nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

--[[ koKR ]] tL["Pet Owner's Names"] = "소환수 소유자명"
--[[ koKR ]] tL["Select how to show pet owner's names"] = "소솬수 소유자명의 표시 방법을 선택합니다."

--[[ koKR ]] tL["NONE"]	= "없음"
--[[ koKR ]] tL["HYPHEN"]	= "소환수 - 소유자"
--[[ koKR ]] tL["SLASH"]	= "소환수 / 소유자"
--[[ koKR ]] tL["BRACKET"]	= "소환수 (소유자)"
--[[ koKR ]] tL["COLON"]	= "소환수 : 소유자"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftPetOwnersName"] = "AloftPetOwnersName"
--[[ koKR ]] mL["Gather and display pet owner's names on nameplates"] = "Gather and display pet owner's names on nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] tL["Select how to show pet owner's names"] = "Выбрать, как отображать имена владельцев питомцев"
--[[ ruRU ]] tL["Pet Owner's Names"] = "Имена владельцев питомцев"

--[[ ruRU ]] tL["NONE"]	= "Нету"
--[[ ruRU ]] tL["HYPHEN"]	= "Питомец - Хозяин"
--[[ ruRU ]] tL["SLASH"]	= "Питомец / Хозяин"
--[[ ruRU ]] tL["BRACKET"]	= "Питомец (Хозяин)"
--[[ ruRU ]] tL["COLON"]	= "Питомец : Хозяин"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftPetOwnersName"] = "AloftPetOwnersName"
--[[ ruRU ]] mL["Gather and display pet owner's names on nameplates"] = "Отображает имя хозяина питомца"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] tL["Pet Owner's Names"] = "宠物主人名称"
--[[ zhCN ]] tL["Select how to show pet owner's names"] = "设定宠物主人名称的显示方式"

--[[ zhCN ]] tL["NONE"]	= "无"
--[[ zhCN ]] tL["HYPHEN"]	= "宠物名 - 主人名"
--[[ zhCN ]] tL["SLASH"]	= "宠物名 / 主人名"
--[[ zhCN ]] tL["BRACKET"]	= "宠物名（主人名）"
--[[ zhCN ]] tL["COLON"]	= "宠物名 : 主人名"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftPetOwnersName"] = "宠物主人名"
--[[ zhCN ]] mL["Gather and display pet owner's names on nameplates"] = "在姓名板上显示宠物主人的名字"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] tL["Pet Owner's Names"] = "寵物主人的名稱"
--[[ zhTW ]] tL["Select how to show pet owner's names"] = "選擇如何顯示寵物主人的名稱"

--[[ zhTW ]] tL["NONE"]	= "無"
--[[ zhTW ]] tL["HYPHEN"]	= "寵物 - 主人"
--[[ zhTW ]] tL["SLASH"]	= "寵物 / 主人"
--[[ zhTW ]] tL["BRACKET"]	= "寵物 (主人)"
--[[ zhTW ]] tL["COLON"]	= "寵物 : 主人"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftPetOwnersName"] = "Aloft寵物主人名稱"
--[[ zhTW ]] mL["Gather and display pet owner's names on nameplates"] = "在名牌上收集和顯示寵物主人的名稱"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPetOwnersName", function()

-----------------------------------------------------------------------------

AloftLocale.AloftPetOwnersNameTextOptions = setmetatable(tL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
tL = nil

-----------------------------------------------------------------------------

end)
