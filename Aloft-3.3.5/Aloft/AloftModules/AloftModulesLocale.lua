local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftModulesOptions")

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Modules"] = true,
	--[[ enUS ]] ["Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"] = true,

	--[[ enUS ]] ["AloftAlpha"] = true,
	--[[ enUS ]] ["Control the relative transparency of nameplates"] = true,

	--[[ enUS ]] ["AloftAutoShow"] = true,
	--[[ enUS ]] ["Automatically show/hide nameplates based on various events and conditions"] = true,

	--[[ enUS ]] ["AloftBanzai"] = true,
	--[[ enUS ]] ["Uses LibBanzai to hightlight group member nameplates that have aggro"] = true,

	--[[ enUS ]] ["AloftCastBarSpellNameText"] = true,
	--[[ enUS ]] ["Display spell name on cast bar"] = true,

	--[[ enUS ]] ["AloftCastBarTimeText"] = true,
	--[[ enUS ]] ["Display cast bar time text"] = true,

	--[[ enUS ]] ["AloftClassIcon"] = true,
	--[[ enUS ]] ["Display class icons on nameplates"] = true,

	--[[ enUS ]] ["AloftCombatText"] = true,
	--[[ enUS ]] ["Display combat text on group member nameplates"] = true,

	--[[ enUS ]] ["AloftComment"] = true,
	--[[ enUS ]] ["Gather and display text on nameplates"] = true,

	--[[ enUS ]] ["AloftCrowdControl"] = true,
	--[[ enUS ]] ["Display crowd control timers on nameplates when possible"] = true,

	--[[ enUS ]] ["AloftFu"] = true,
	--[[ enUS ]] ["Provide a FuBar interface for Aloft"] = true,

	--[[ enUS ]] ["AloftGuild"] = true,
	--[[ enUS ]] ["Gather and display player guild names on nameplates"] = true,

	--[[ enUS ]] ["AloftHealthBarDeficit"] = true,
	--[[ enUS ]] ["Modifiy Aloft nameplate health bars to deficit form"] = true,

	--[[ enUS ]] ["AloftHealthText"] = true,
	--[[ enUS ]] ["Display health data and text on nameplates"] = true,

	--[[ enUS ]] ["AloftLDB"] = true,
	--[[ enUS ]] ["Provide a LibDataBroker-1.1 interface for Aloft"] = true,

	--[[ enUS ]] ["AloftMana"] = true,
	--[[ enUS ]] ["Display mana data, bars, and text on nameplates"] = true,

	--[[ enUS ]] ["AloftPetOwnersName"] = true,
	--[[ enUS ]] ["Gather and display pet owner's names on nameplates"] = true,

	--[[ enUS ]] ["AloftPlayerTitle"] = true,
	--[[ enUS ]] ["Gather and display player titles on nameplates"] = true,

	--[[ enUS ]] ["AloftPresets"] = true,
	--[[ enUS ]] ["Enable access to preset configurations"] = true,

	--[[ enUS ]] ["AloftRecentlyDamaged"] = true,
	--[[ enUS ]] ["Display recently damaged icon on nameplates"] = true,

	--[[ enUS ]] ["AloftStackedPointsText"] = true,
	--[[ enUS ]] ["Display stacked points (combo point/lacerate/sunder counts) on nameplates"] = true,

	--[[ enUS ]] ["AloftTarget"] = true,
	--[[ enUS ]] ["Display target name and group target count on nameplates"] = true,

	--[[ enUS ]] ["AloftThreat"] = true,
	--[[ enUS ]] ["Display threat data, bars, and text on nameplates"] = true,

	--[[ enUS ]] ["AloftVisibility"] = true,
	--[[ enUS ]] ["Control the visibility of various types of nameplates"] = true,

	--[[ enUS ]] ["Regenerate Text Tags"] = true,
	--[[ enUS ]] ["Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"] = true,

	--[[ enUS ]] ["Reload UI"] = true,
	--[[ enUS ]] ["Reload the user interface to synchronize all modules"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Modules"] = "Modules",
	--[[ koKR ]] ["Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"] = "Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)",

	--[[ koKR ]] ["AloftAlpha"] = "AloftAlpha",
	--[[ koKR ]] ["Control the relative transparency of nameplates"] = "Control the relative transparency of nameplates",

	--[[ koKR ]] ["AloftAutoShow"] = "AloftAutoShow",
	--[[ koKR ]] ["Automatically show/hide nameplates based on various events and conditions"] = "Automatically show/hide nameplates based on various events and conditions",

	--[[ koKR ]] ["AloftBanzai"] = "AloftBanzai",
	--[[ koKR ]] ["Uses LibBanzai to hightlight group member nameplates that have aggro"] = "Uses LibBanzai to hightlight group member nameplates that have aggro",

	--[[ koKR ]] ["AloftCastBarSpellNameText"] = "AloftCastBarSpellNameText",
	--[[ koKR ]] ["Display spell name on cast bar"] = "Display spell name on cast bar",

	--[[ koKR ]] ["AloftCastBarTimeText"] = "AloftCastBarTimeText",
	--[[ koKR ]] ["Display cast bar time text"] = "Display cast bar time text",

	--[[ koKR ]] ["AloftClassIcon"] = "AloftClassIcon",
	--[[ koKR ]] ["Display class icons on nameplates"] = "Display class icons on nameplates",

	--[[ koKR ]] ["AloftCombatText"] = "AloftCombatText",
	--[[ koKR ]] ["Display combat text on group member nameplates"] = "Display combat text on group member nameplates",

	--[[ koKR ]] ["AloftComment"] = "AloftComment",
	--[[ koKR ]] ["Gather and display text on nameplates"] = "Gather and display text on nameplates",

	--[[ koKR ]] ["AloftCrowdControl"] = "AloftCrowdControl",
	--[[ koKR ]] ["Display crowd control timers on nameplates when possible"] = "Display crowd control timers on nameplates when possible",

	--[[ koKR ]] ["AloftFu"] = "AloftFu",
	--[[ koKR ]] ["Provide a FuBar interface for Aloft"] = "Provide a FuBar interface for Aloft",

	--[[ koKR ]] ["AloftGuild"] = "AloftGuild",
	--[[ koKR ]] ["Gather and display player guild names on nameplates"] = "Gather and display player guild names on nameplates",

	--[[ koKR ]] ["AloftHealthBarDeficit"] = "AloftHealthBarDeficit",
	--[[ koKR ]] ["Modifiy Aloft nameplate health bars to deficit form"] = "Modifiy Aloft nameplate health bars to deficit form",

	--[[ koKR ]] ["AloftLDB"] = "AloftLDB",
	--[[ koKR ]] ["Provide a LibDataBroker-1.1 interface for Aloft"] = "Provide a LibDataBroker-1.1 interface for Aloft",

	--[[ koKR ]] ["AloftMana"] = "AloftMana",
	--[[ koKR ]] ["Display mana data, bars, and text on nameplates"] = "Show mana data, bars, and text on nameplates",

	--[[ koKR ]] ["AloftPetOwnersName"] = "AloftPetOwnersName",
	--[[ koKR ]] ["Gather and display pet owner's names on nameplates"] = "Gather and display pet owner's names on nameplates",

	--[[ koKR ]] ["AloftPlayerTitle"] = "AloftPlayerTitle",
	--[[ koKR ]] ["Gather and display player titles on nameplates"] = "Gather and display player titles on nameplates",

	--[[ koKR ]] ["AloftPresets"] = "AloftPresets",
	--[[ koKR ]] ["Enable access to preset configurations"] = "Enable access to preset configurations",

	--[[ koKR ]] ["AloftRecentlyDamaged"] = "AloftRecentlyDamaged",
	--[[ koKR ]] ["Display recently damaged icon on nameplates"] = "Display recently damaged icon on nameplates",

	--[[ koKR ]] ["AloftStackedPointsText"] = "AloftStackedPointsText",
	--[[ koKR ]] ["Display stacked points (combo point/lacerate/sunder counts) on nameplates"] = "Display stacked points (combo point/lacerate/sunder counts) on nameplates",

	--[[ koKR ]] ["AloftTarget"] = "AloftTarget",
	--[[ koKR ]] ["Display target name and group target count on nameplates"] = "Display target name and group target count on nameplates",

	--[[ koKR ]] ["AloftThreat"] = "Aloft Threat",
	--[[ koKR ]] ["Display threat data, bars, and text on nameplates"] = "Show threat data, bars, and text on nameplates",

	--[[ koKR ]] ["AloftVisibility"] = "AloftVisibility",
	--[[ koKR ]] ["Control the visibility of various types of nameplates"] = "Control the visibility of various types of nameplates",

	--[[ koKR ]] ["Regenerate Text Tags"] = "Regenerate Text Tags",
	--[[ koKR ]] ["Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"] = "Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload",

	--[[ koKR ]] ["Reload UI"] = "Reload UI",
	--[[ koKR ]] ["Reload the user interface to synchronize all modules"] = "Reload the user interface to synchronize all modules",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Modules"] = "Модули",
	--[[ ruRU ]] ["Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"] = "Дополнительные модули Aloft (если включены загружаются диновично; для отключения, отмените выбор и перезагрузите пользовательский интерфейс)",

	--[[ ruRU ]] ["AloftAlpha"] = "AloftAlpha",
	--[[ ruRU ]] ["Control the relative transparency of nameplates"] = "Настройки прозрачности табличек",

	--[[ ruRU ]] ["AloftAutoShow"] = "AloftAutoShow",
	--[[ ruRU ]] ["Automatically show/hide nameplates based on various events and conditions"] = "Автоматически показывает/скрывает таблички основываясь на различных критериях и событиях",

	--[[ ruRU ]] ["AloftBanzai"] = "AloftBanzai",
	--[[ ruRU ]] ["Uses LibBanzai to hightlight group member nameplates that have aggro"] = "Использует LibBanzai для выделения табличек участников группы с угрозой",

	--[[ ruRU ]] ["AloftCastBarSpellNameText"] = "AloftCastBarSpellNameText",
	--[[ ruRU ]] ["Display spell name on cast bar"] = "Отображение названия заклинаний на полоске заклинаний",

	--[[ ruRU ]] ["AloftCastBarTimeText"] = "AloftCastBarTimeText",
	--[[ ruRU ]] ["Display cast bar time text"] = "Отображает время на полоске заклинаний",

	--[[ ruRU ]] ["AloftClassIcon"] = "AloftClassIcon",
	--[[ ruRU ]] ["Display class icons on nameplates"] = "Отображает иконку класса на табличке",

	--[[ ruRU ]] ["AloftCombatText"] = "AloftCombatText",
	--[[ ruRU ]] ["Display combat text on group member nameplates"] = "Отображает текст боя на табличках участников группы",

	--[[ ruRU ]] ["AloftComment"] = "AloftComment",
	--[[ ruRU ]] ["Gather and display text on nameplates"] = "Отображает текст/комментарии",

	--[[ ruRU ]] ["AloftCrowdControl"] = "AloftCrowdControl",
	--[[ ruRU ]] ["Display crowd control timers on nameplates when possible"] = "Если это возможно, отображает таймеры контроля",

	--[[ ruRU ]] ["AloftFu"] = "AloftFu",
	--[[ ruRU ]] ["Provide a FuBar interface for Aloft"] = "Обеспечивать интерфейсов Aloftа FuBar",

	--[[ ruRU ]] ["AloftGuild"] = "AloftGuild",
	--[[ ruRU ]] ["Gather and display player guild names on nameplates"] = "Отображает название гильдии игрока",

	--[[ ruRU ]] ["AloftHealthBarDeficit"] = "AloftHealthBarDeficit",
	--[[ ruRU ]] ["Modifiy Aloft nameplate health bars to deficit form"] = "Изменяет полосу таблички здоровья на значение недостатка",

	--[[ ruRU ]] ["AloftHealthText"] = "AloftHealthText",
	--[[ ruRU ]] ["Display health data and text on nameplates"] = "Отображает данные/тект здоровья",

	--[[ ruRU ]] ["AloftLDB"] = "AloftLDB",
	--[[ ruRU ]] ["Provide a LibDataBroker-1.1 interface for Aloft"] = "беспечивать интерфейсов Aloftа LibDataBroker-1.1",

	--[[ ruRU ]] ["AloftMana"] = "AloftMana",
	--[[ ruRU ]] ["Display mana data, bars, and text on nameplates"] = "Отображает данные/тект/полосы маны",

	--[[ ruRU ]] ["AloftPetOwnersName"] = "AloftPetOwnersName",
	--[[ ruRU ]] ["Gather and display pet owner's names on nameplates"] = "Отображает имя хозяина питомца",

	--[[ ruRU ]] ["AloftPlayerTitle"] = "AloftPlayerTitle",
	--[[ ruRU ]] ["Gather and display player titles on nameplates"] = "Отображает титул игрока",

	--[[ ruRU ]] ["AloftPresets"] = "AloftPresets",
	--[[ ruRU ]] ["Enable access to preset configurations"] = "Включает доступ к предустановкам настроек",

	--[[ ruRU ]] ["AloftRecentlyDamaged"] = "AloftRecentlyDamaged",
	--[[ ruRU ]] ["Display recently damaged icon on nameplates"] = "Отображает конку недавнего урона",

	--[[ ruRU ]] ["AloftStackedPointsText"] = "AloftStackedPointsText",
	--[[ ruRU ]] ["Display stacked points (combo point/lacerate/sunder counts) on nameplates"] = "Отображает стаки (значение приёмов в серии/растерзать/раскол брони)",

	--[[ ruRU ]] ["AloftTarget"] = "AloftTarget",
	--[[ ruRU ]] ["Display target name and group target count on nameplates"] = "Отображает имя цели и номер группы",

	--[[ ruRU ]] ["AloftThreat"] = "AloftThreat",
	--[[ ruRU ]] ["Display threat data, bars, and text on nameplates"] = "Отображает текст/полосы/данные по угрозе",

	--[[ ruRU ]] ["AloftVisibility"] = "AloftVisibility",
	--[[ ruRU ]] ["Control the visibility of various types of nameplates"] = "Различные настройки отображения",

	--[[ ruRU ]] ["Regenerate Text Tags"] = "Восстанавление текстовых тегов",
	--[[ ruRU ]] ["Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"] = "Очистка и восстанавление всех текстовых тегов (помогает избавиться от проблем !!Ошибка тега!! без перезагрузки пользовательского интерфейса",

	--[[ ruRU ]] ["Reload UI"] = "Reload UI",
	--[[ ruRU ]] ["Reload the user interface to synchronize all modules"] = "Перезагружает пользовательский интерфейс для синхронизации всех модулей",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Modules"] = "模块",
	--[[ zhCN ]] ["Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"] = "Aloft的额外模块（选中后动态加载；取消选择后重载UI卸载）",

	--[[ zhCN ]] ["AloftAlpha"] = "透明度",
	--[[ zhCN ]] ["Control the relative transparency of nameplates"] = "控制姓名板的透明度",

	--[[ zhCN ]] ["AloftAutoShow"] = "自动显示",
	--[[ zhCN ]] ["Automatically show/hide nameplates based on various events and conditions"] = "在特定事件和状态下自动显示/隐藏姓名板",

	--[[ zhCN ]] ["AloftBanzai"] = "仇恨指示",
	--[[ zhCN ]] ["Uses LibBanzai to hightlight group member nameplates that have aggro"] = "使用LibBanzai来红色高亮获得仇恨的小队成员姓名板",

	--[[ zhCN ]] ["AloftCastBarSpellNameText"] = "施法条法术名",
	--[[ zhCN ]] ["Display spell name on cast bar"] = "在施法条上显示法术名",

	--[[ zhCN ]] ["AloftCastBarTimeText"] = "施法时间",
	--[[ zhCN ]] ["Display cast bar time text"] = "在施法条上显示时间",

	--[[ zhCN ]] ["AloftClassIcon"] = "职业图标",
	--[[ zhCN ]] ["Display class icons on nameplates"] = "在姓名板上显示职业图标",

	--[[ zhCN ]] ["AloftCombatText"] = "战斗文字",
	--[[ zhCN ]] ["Display combat text on group member nameplates"] = "在小队成员的姓名板上显示战斗文字",

	--[[ zhCN ]] ["AloftComment"] = "注释",
	--[[ zhCN ]] ["Gather and display text on nameplates"] = "在姓名板上显示特定文字",

	--[[ zhCN ]] ["AloftCrowdControl"] = "控场效果",
	--[[ zhCN ]] ["Display crowd control timers on nameplates when possible"] = "可能的情况在姓名板上显示控场效果计时器",

	--[[ zhCN ]] ["AloftFu"] = "FuBar支持",
	--[[ zhCN ]] ["Provide a FuBar interface for Aloft"] = "为Aloft提供Fubar支持",

	--[[ zhCN ]] ["AloftGuild"] = "公会",
	--[[ zhCN ]] ["Gather and display player guild names on nameplates"] = "在姓名板上显示玩家的公会名",

	--[[ zhCN ]] ["AloftHealthBarDeficit"] = "生命条亏减",
	--[[ zhCN ]] ["Modifiy Aloft nameplate health bars to deficit form"] = "将Aloft的生命值条显示为亏减模式",

	--[[ zhCN ]] ["AloftHealthText"] = "生命值",
	--[[ zhCN ]] ["Display health data and text on nameplates"] = "在姓名板上显示生命值数据和文字",

	--[[ zhCN ]] ["AloftLDB"] = "LDB支持",
	--[[ zhCN ]] ["Provide a LibDataBroker-1.1 interface for Aloft"] = "为Aloft提供LibDataBroker支持",

	--[[ zhCN ]] ["AloftMana"] = "法力值",
	--[[ zhCN ]] ["Display mana data, bars, and text on nameplates"] = "在姓名板上显示法力值数据和法力条",

	--[[ zhCN ]] ["AloftPetOwnersName"] = "宠物主人名",
	--[[ zhCN ]] ["Gather and display pet owner's names on nameplates"] = "在姓名板上显示宠物主人的名字",

	--[[ zhCN ]] ["AloftPlayerTitle"] = "玩家称号",
	--[[ zhCN ]] ["Gather and display player titles on nameplates"] = "在姓名板上显示玩家称号",

	--[[ zhCN ]] ["AloftPresets"] = "预设样式",
	--[[ zhCN ]] ["Enable access to preset configurations"] = "调用预设的配置文件",

	--[[ zhCN ]] ["AloftRecentlyDamaged"] = "最近受伤害",
	--[[ zhCN ]] ["Display recently damaged icon on nameplates"] = "在姓名板上显示最近受伤害图标",

	--[[ zhCN ]] ["AloftStackedPointsText"] = "累积点数文本",
	--[[ zhCN ]] ["Display stacked points (combo point/lacerate/sunder counts) on nameplates"] = "显示累积点数（连击点/割裂/破甲层数）",

	--[[ zhCN ]] ["AloftTarget"] = "目标",
	--[[ zhCN ]] ["Display target name and group target count on nameplates"] = "在姓名板上显示目标名称和小队中选中的数量",

	--[[ zhCN ]] ["AloftThreat"] = "威胁值",
	--[[ zhCN ]] ["Display threat data, bars, and text on nameplates"] = "在姓名板上显示威胁值数据、计量条和文本",

	--[[ zhCN ]] ["AloftVisibility"] = "可见度",
	--[[ zhCN ]] ["Control the visibility of various types of nameplates"] = "Control the visibility of various types of nameplates",

	--[[ zhCN ]] ["Regenerate Text Tags"] = "重新生成文本标签",
	--[[ zhCN ]] ["Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"] = "清除并重新生成所有的文本标签（有时可以在不进行重载的情况下解决标签错误问题）",

	--[[ zhCN ]] ["Reload UI"] = "重载界面",
	--[[ zhCN ]] ["Reload the user interface to synchronize all modules"] = "重载用户界面以进行模块同步",
} end)


-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Modules"] = "模組",
	--[[ zhTW ]] ["Aloft optional modules (loaded dynamically when selected; de-select and reload UI to unload)"] = "Aloft的額外模組（選中後動態載入；取消選擇後重載UI卸載）",

	--[[ zhTW ]] ["AloftAlpha"] = "透明度",
	--[[ zhTW ]] ["Control the relative transparency of nameplates"] = "控制名牌的透明度",

	--[[ zhTW ]] ["AloftAutoShow"] = "自動顯示",
	--[[ zhTW ]] ["Automatically show/hide nameplates based on various events and conditions"] = "自動在特定的事件和狀態下顯示/隱藏名牌",

	--[[ zhTW ]] ["AloftBanzai"] = "仇恨指示",
	--[[ zhTW ]] ["Uses LibBanzai to hightlight group member nameplates that have aggro"] = "使用LibBanzai來紅色高亮獲得仇恨的小隊成員名牌",

	--[[ zhTW ]] ["AloftCastBarSpellNameText"] = "施法條法術名",
	--[[ zhTW ]] ["Display spell name on cast bar"] = "在施法條上顯示法術名",

	--[[ zhTW ]] ["AloftCastBarTimeText"] = "施法時間",
	--[[ zhTW ]] ["Display cast bar time text"] = "在施法條上顯示時間",

	--[[ zhTW ]] ["AloftClassIcon"] = "職業圖示",
	--[[ zhTW ]] ["Display class icons on nameplates"] = "在名牌上顯示職業圖示",

	--[[ zhTW ]] ["AloftCombatText"] = "戰鬥文字",
	--[[ zhTW ]] ["Display combat text on group member nameplates"] = "在小隊成員的名牌上顯示戰鬥文字",

	--[[ zhTW ]] ["AloftComment"] = "注釋",
	--[[ zhTW ]] ["Gather and display text on nameplates"] = "在名牌上顯示特定文字",

	--[[ zhTW ]] ["AloftCrowdControl"] = "控場效果",
	--[[ zhTW ]] ["Display crowd control timers on nameplates when possible"] = "可能的情況在名牌上顯示控場效果計時器",

	--[[ zhTW ]] ["AloftFu"] = "FuBar支持",
	--[[ zhTW ]] ["Provide a FuBar interface for Aloft"] = "為Aloft提供Fubar支援",

	--[[ zhTW ]] ["AloftGuild"] = "公會",
	--[[ zhTW ]] ["Gather and display player guild names on nameplates"] = "在名牌上顯示玩家的公會名",

	--[[ zhTW ]] ["AloftHealthBarDeficit"] = "生命條虧減",
	--[[ zhTW ]] ["Modifiy Aloft nameplate health bars to deficit form"] = "將Aloft的生命值條顯示為虧減模式",

	--[[ zhTW ]] ["AloftHealthText"] = "生命值",
	--[[ zhTW ]] ["Display health data and text on nameplates"] = "在名牌上顯示生命值數據和文字",

	--[[ zhTW ]] ["AloftLDB"] = "LDB支持",
	--[[ zhTW ]] ["Provide a LibDataBroker-1.1 interface for Aloft"] = "為Aloft提供LibDataBroker支援",

	--[[ zhTW ]] ["AloftMana"] = "法力值",
	--[[ zhTW ]] ["Display mana data, bars, and text on nameplates"] = "在名牌上顯示法力值資料和法力條",

	--[[ zhTW ]] ["AloftPetOwnersName"] = "寵物主人名",
	--[[ zhTW ]] ["Gather and display pet owner's names on nameplates"] = "在名牌上顯示寵物主人的名字",

	--[[ zhTW ]] ["AloftPlayerTitle"] = "玩家稱號",
	--[[ zhTW ]] ["Gather and display player titles on nameplates"] = "在名牌上顯示玩家稱號",

	--[[ zhTW ]] ["AloftPresets"] = "預設樣式",
	--[[ zhTW ]] ["Enable access to preset configurations"] = "調用預設的設定檔",

	--[[ zhTW ]] ["AloftRecentlyDamaged"] = "最近受傷害",
	--[[ zhTW ]] ["Display recently damaged icon on nameplates"] = "在名牌上顯示最近受傷害圖示",

	--[[ zhTW ]] ["AloftStackedPointsText"] = "累積點數文本",
	--[[ zhTW ]] ["Display stacked points (combo point/lacerate/sunder counts) on nameplates"] = "顯示累積點數（連擊點/割裂/破甲層數）",

	--[[ zhTW ]] ["AloftTarget"] = "目標",
	--[[ zhTW ]] ["Display target name and group target count on nameplates"] = "在名牌上顯示目標名稱和小隊中選中的數量",

	--[[ zhTW ]] ["AloftThreat"] = "威脅值",
	--[[ zhTW ]] ["Display threat data, bars, and text on nameplates"] = "在名牌上顯示威脅值資料、計量條和文本",

	--[[ zhTW ]] ["AloftVisibility"] = "可見度",
	--[[ zhTW ]] ["Control the visibility of various types of nameplates"] = "Control the visibility of various types of nameplates",

	--[[ zhTW ]] ["Regenerate Text Tags"] = "重新生成文本標籤",
	--[[ zhTW ]] ["Clear and regenerate all text tags (may help to clear !!Tag Error!! problems without a full UI reload"] = "清除並重新生成所有的文本標籤（有時可以在不進行重載的情況下解決標籤錯誤問題）",

	--[[ zhTW ]] ["Reload UI"] = "重載介面",
	--[[ zhTW ]] ["Reload the user interface to synchronize all modules"] = "重載使用者介面以進行模組同步",
} end)

-----------------------------------------------------------------------------

end
