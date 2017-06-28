local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Modules"] = "Modules"
--[[ enUS ]] L["Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"] = "Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"

--[[ enUS ]] L["Regenerate Text Tags"] = "Regenerate Text Tags"
--[[ enUS ]] L["Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"] = "Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"

--[[ enUS ]] L["Reload UI"] = "Reload UI"
--[[ enUS ]] L["Reload the user interface to synchronize all modules"] = "Reload the user interface to synchronize all modules"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Modules"] = "Modules"
--[[ koKR ]] L["Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"] = "Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"

--[[ koKR ]] L["Regenerate Text Tags"] = "Regenerate Text Tags"
--[[ koKR ]] L["Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"] = "Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"

--[[ koKR ]] L["Reload UI"] = "Reload UI"
--[[ koKR ]] L["Reload the user interface to synchronize all modules"] = "Reload the user interface to synchronize all modules"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Modules"] = "Модули"
--[[ ruRU ]] L["Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"] = "Дополнительные модули Aloft (если включены загружаются диновично; для отключения, отмените выбор и перезагрузите пользовательский интерфейс)"

--[[ ruRU ]] L["Regenerate Text Tags"] = "Восстанавление текстовых тегов"
--[[ ruRU ]] L["Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"] = "Очистка и восстанавление всех текстовых тегов (помогает избавиться от проблем !!Ошибка тега!! без перезагрузки пользовательского интерфейса"

--[[ ruRU ]] L["Reload UI"] = "Reload UI"
--[[ ruRU ]] L["Reload the user interface to synchronize all modules"] = "Перезагружает пользовательский интерфейс для синхронизации всех модулей"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Modules"] = "模块"
--[[ zhCN ]] L["Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"] = "Aloft的额外模块（选中后动态加载；取消选择后重载UI卸载）"

--[[ zhCN ]] L["Regenerate Text Tags"] = "重新生成文本标签"
--[[ zhCN ]] L["Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"] = "清除并重新生成所有的文本标签（有时可以在不进行重载的情况下解决标签错误问题）"

--[[ zhCN ]] L["Reload UI"] = "重载界面"
--[[ zhCN ]] L["Reload the user interface to synchronize all modules"] = "重载用户界面以进行模块同步"


-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Modules"] = "模組"
--[[ zhTW ]] L["Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"] = "Aloft可選擇的模組（選中後動態載入；取消選擇後重載UI卸載）"

--[[ zhTW ]] L["Regenerate Text Tags"] = "重新生成文本標籤"
--[[ zhTW ]] L["Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"] = "清除並重新生成所有的文本標籤（有時可以在不進行重載的情況下解決標籤錯誤問題）"

--[[ zhTW ]] L["Reload UI"] = "重載介面"
--[[ zhTW ]] L["Reload the user interface to synchronize all modules"] = "重載使用者介面來同步所有模組"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftModules = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil