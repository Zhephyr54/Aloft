local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftClassData
if not L then return end

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Save Class Data"] = "Save Class Data"
--[[ enUS ]] L["Stores player class information between sessions"] = "Stores player class information between sessions"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Save Class Data"] = "직업 데이터 저장"
--[[ koKR ]] L["Stores player class information between sessions"] = "접속 간 플레이어 직업 정보를 저장합니다."

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Save Class Data"] = "Записать информацию о классах"
--[[ ruRU ]] L["Stores player class information between sessions"] = "Сохранять данные о классах игроков между сессиями"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Save Class Data"] = "储存职业信息"
--[[ zhCN ]] L["Stores player class information between sessions"] = "在两次登录的间隔储存职业信息"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Save Class Data"] = "儲存職業資料"
--[[ zhTW ]] L["Stores player class information between sessions"] = "儲存玩家職業資訊在登錄期間"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftClassDataOptions = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil
