local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local oL = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] oL["Save Race Data"] = "Save Race Data"
--[[ enUS ]] oL["Stores race information between sessions"] = "Stores race information between sessions"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then
	
-----------------------------------------------------------------------------

--[[ koKR ]] oL["Save Race Data"] = "종족 데이터 저장"
--[[ koKR ]] oL["Stores race information between sessions"] = "접속 간 종족 정보를 저장합니다."

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then
	
-----------------------------------------------------------------------------

--[[ ruRU ]] oL["Save Race Data"] = "Записать данные о расах"
--[[ ruRU ]] oL["Stores race information between sessions"] = "Сохранять данные о расе между сессиями"
	
-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

--[[ zhCN ]] oL["Save Race Data"] = "储存种族信息"
--[[ zhCN ]] oL["Stores race information between sessions"] = "在两次登录的间隔储存种族信息"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then
	
-----------------------------------------------------------------------------

--[[ zhTW ]] oL["Save Race Data"] = "儲存種族資料"
--[[ zhTW ]] oL["Stores race information between sessions"] = "儲存種族資訊在登錄期間"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftRaceDataOptions = setmetatable(oL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
oL = nil
