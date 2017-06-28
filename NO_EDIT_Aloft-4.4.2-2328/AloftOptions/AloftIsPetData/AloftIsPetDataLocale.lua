local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Save Pet Data"] = "Save Pet Data"
--[[ enUS ]] L["Stores pet information between sessions"] = "Stores pet information between sessions"
	
-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Save Pet Data"] = "소환수 데이터 저장"
--[[ koKR ]] L["Stores pet information between sessions"] = "접속 간 소환수 정보를 저장합니다."

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Save Pet Data"] = "Записать данные о питомцах"
--[[ ruRU ]] L["Stores pet information between sessions"] = "Сохранять данные о питомцах между сессиями"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Save Pet Data"] = "储存宠物信息"
--[[ zhCN ]] L["Stores pet information between sessions"] = "在两次登录的间隔储存宠物信息"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Save Pet Data"] = "儲存寵物資料"
--[[ zhTW ]] L["Stores pet information between sessions"] = "儲存寵物資訊在登錄期間"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftIsPetDataOptions = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil
