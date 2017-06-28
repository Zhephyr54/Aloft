local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Reset Aliases"] = "Reset Aliases"
--[[ enUS ]] L["Empties the alias database"] = "Empties the alias database"

--[[ enUS ]] L["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = "You are about to empty your alias database.\nThis action cannot be undone. Proceed?"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Reset Aliases"] = "별명 초기화"
--[[ koKR ]] L["Empties the alias database"] = "별명 데이터베이스를 삭제합니다."

--[[ koKR ]] L["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = "별명 데이터베이스를 삭제합니다.\n이 동작은 되돌릴 수 없습니다. 계속 하시겠습니까?"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Reset Aliases"] = "Сбросить сокарщения"
--[[ ruRU ]] L["Empties the alias database"] = "Очищает базу данных сокращений"

--[[ ruRU ]] L["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = "Вы хотите сбросить таблицу сокращений имен.\nРезультат будет необратим. Продолжить?"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Reset Aliases"] = "重设绰号"
--[[ zhCN ]] L["Empties the alias database"] = "清空绰号资料库"

--[[ zhCN ]] L["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = "你是否真得要清空绰号资料库？本操作不可逆！"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Reset Aliases"] = "重置別名"
--[[ zhTW ]] L["Empties the alias database"] = "清空別名資料庫"

--[[ zhTW ]] L["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = "你是否真的清空別名資料庫。\n這動作無法復原。進行？"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftAliasDataOptions = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil
