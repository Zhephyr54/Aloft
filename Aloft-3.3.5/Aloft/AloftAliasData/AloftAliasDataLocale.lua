local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftAliasDataOptions")

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Reset Aliases"] = true,
	--[[ enUS ]] ["Empties the alias database"] = true,

	--[[ enUS ]] ["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Reset Aliases"] = "별명 초기화",
	--[[ koKR ]] ["Empties the alias database"] = "별명 데이터베이스를 삭제합니다.",

	--[[ koKR ]] ["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = "별명 데이터베이스를 삭제합니다.\n이 동작은 되돌릴 수 없습니다. 계속 하시겠습니까?",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Reset Aliases"] = "Сбросить сокарщения",
	--[[ ruRU ]] ["Empties the alias database"] = "Очищает базу данных сокращений",

	--[[ ruRU ]] ["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = "Вы хотите сбросить таблицу сокращений имен.\nРезультат будет необратим. Продолжить?",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Reset Aliases"] = "重设绰号",
	--[[ zhCN ]] ["Empties the alias database"] = "清空绰号资料库",

	--[[ zhCN ]] ["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = "你是否真得要清空绰号资料库？本操作不可逆！",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Reset Aliases"] = "重設別名",
	--[[ zhTW ]] ["Empties the alias database"] = "清空別名資料庫",

	--[[ zhTW ]] ["You are about to empty your alias database.\nThis action cannot be undone. Proceed?"] = "你是否真的清空別名資料庫?",
} end)

-----------------------------------------------------------------------------

end
