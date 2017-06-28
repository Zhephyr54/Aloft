local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["HostileNameplatesEnabled"] = "Hostile nameplates |cff00ff00enabled|r."
--[[ enUS ]] L["HostileNameplatesDisabled"] = "Hostile nameplates |cffff0000disabled|r."
--[[ enUS ]] L["FriendlyNameplatesEnabled"] = "Friendly nameplates |cff00ff00enabled|r."
--[[ enUS ]] L["FriendlyNameplatesDisabled"] = "Friendly nameplates |cffff0000disabled|r."

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["HostileNameplatesEnabled"] = "적대적 대상의 이름표 : |cff00ff00표시|r."
--[[ koKR ]] L["HostileNameplatesDisabled"] = "적대적 대상의 이름표 : |cffff0000숨김|r."
--[[ koKR ]] L["FriendlyNameplatesEnabled"] = "우호적 대상의 이름표 : |cff00ff00표시|r."
--[[ koKR ]] L["FriendlyNameplatesDisabled"] = "우호적 대상의 이름표 : |cffff0000숨김|r."

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["HostileNameplatesEnabled"] = "Таблички враждебных |cff00ff00включены|r."
--[[ ruRU ]] L["HostileNameplatesDisabled"] = "Таблички враждебных |cffff0000отключены|r."
--[[ ruRU ]] L["FriendlyNameplatesEnabled"] = "Таблички дружественных |cff00ff00включены|r."
--[[ ruRU ]] L["FriendlyNameplatesDisabled"] = "Таблички дружественных |cffff0000отключены|r."

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["HostileNameplatesEnabled"] = "敌对姓名板|cff00ff00已启用|r。"
--[[ zhCN ]] L["HostileNameplatesDisabled"] = "敌对姓名板|cffff0000已禁用|r。"
--[[ zhCN ]] L["FriendlyNameplatesEnabled"] = "友方姓名板|cff00ff00已启用|r。"
--[[ zhCN ]] L["FriendlyNameplatesDisabled"] = "友方姓名板|cffff0000已禁用|r。"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["HostileNameplatesEnabled"] = "敵對名牌|cff00ff00已啟用|r。"
--[[ zhTW ]] L["HostileNameplatesDisabled"] = "敵對名牌|cffff0000已停用|r。"
--[[ zhTW ]] L["FriendlyNameplatesEnabled"] = "友好名牌|cff00ff00已啟用|r。"
--[[ zhTW ]] L["FriendlyNameplatesDisabled"] = "友好名牌|cffff0000已停用|r。"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftReportStatusChanges = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil
