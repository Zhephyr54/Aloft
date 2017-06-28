local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local oL = { }

-----------------------------------------------------------------------------

--[[ enUS ]] oL["Save Creature Type Data"] = "Save Creature Type Data"
--[[ enUS ]] oL["Stores creature type information between sessions"] = "Stores creature type information between sessions"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] oL["Save Creature Type Data"] = "몹 종류 데이터를 저장합니다."
--[[ koKR ]] oL["Stores creature type information between sessions"] = "접속 간 몹 종류 정보를 저장합니다."

-----------------------------------------------------------------------------

elseif (GetLocale() == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] oL["Save Creature Type Data"] = "Записать данные о типах существ"
--[[ ruRU ]] oL["Stores creature type information between sessions"] = "Сохранять данные о типах существ между сессиями"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] oL["Save Creature Type Data"] = "保存生物类型资料"
--[[ zhCN ]] oL["Stores creature type information between sessions"] = "在每次连接之间保存生物类型数据"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] oL["Save Creature Type Data"] = "儲存生物類型資料"
--[[ zhTW ]] oL["Stores creature type information between sessions"] = "儲存生物類型資訊在登錄期間"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftCreatureTypeDataOptions = setmetatable(oL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
oL = nil
