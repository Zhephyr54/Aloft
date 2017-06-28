local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local oL = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] oL["Save Classification Data"] = "Save Classification Data"
--[[ enUS ]] oL["Stores unit classification information between sessions"] = "Stores unit classification information between sessions"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] oL["Save Classification Data"] = "구분 데이터 저장"
--[[ koKR ]] oL["Stores unit classification information between sessions"] = "각 접속간 대상의 구분 정보를 저장합니다."

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] oL["Save Classification Data"] = "Записать данные о классификации"
--[[ ruRU ]] oL["Stores unit classification information between sessions"] = "Сохранять данные по классификации объектов между сессиями"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] oL["Save Classification Data"] = "储存分类信息"
--[[ zhCN ]] oL["Stores unit classification information between sessions"] = "在两次登录的间隔储存分类信息"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] oL["Save Classification Data"] = "儲存分類資料"
--[[ zhTW ]] oL["Stores unit classification information between sessions"] = "儲存分類資訊在登錄期間"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftClassificationDataOptions = setmetatable(oL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
oL = nil
