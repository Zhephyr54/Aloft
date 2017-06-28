local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Report Status Changes"] = "Report Status Changes"
--[[ enUS ]] L["Prints the status of nameplates whenever they change"] = "Prints the status of nameplates whenever they change"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Report Status Changes"] = "상태 변경 알림"
--[[ koKR ]] L["Prints the status of nameplates whenever they change"] = "이름표의 표시 상태 변경시 대화창에 표시합니다."

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Report Status Changes"] = "Сообщать об изменении статуса"
--[[ ruRU ]] L["Prints the status of nameplates whenever they change"] = "Печатает статус табличек при их изменении"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Report Status Changes"] = "报告状态变化"
--[[ zhCN ]] L["Prints the status of nameplates whenever they change"] = "报告姓名板的状态变化"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Report Status Changes"] = "報告狀態變化"
--[[ zhTW ]] L["Prints the status of nameplates whenever they change"] = "報告名牌的狀態變化"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftReportStatusChangesOptions = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil
