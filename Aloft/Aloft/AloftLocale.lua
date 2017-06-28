-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftOptions")

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Aloft"] = true,
	--[[ enUS ]] ["Unknown"] = true, -- unit name for "Unknown" units

	--[[ enUS ]] ["Enable Startup Message"] = true,

	--[[ enUS ]] ["Class Colors"] = true,
	--[[ enUS ]] ["Customize class colors"] = true,
	--[[ enUS ]] ["class color"] = true,
	--[[ enUS ]] ["Reset to Defaults"] = true,
	--[[ enUS ]] ["Resets all colors to their defaults"] = true,

	-- labels for keybindings; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ enUS ]] ["Show Neutral/Enemy Name Plates"] = true,
	--[[ enUS ]] ["Show Friendly Name Plates"] = true,
	--[[ enUS ]] ["Show All Name Plates"] = true,

	-- player states; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ enUS ]] ["Combat"] = true,
	--[[ enUS ]] ["Flagged/PvP"] = true,
	--[[ enUS ]] ["Resting"] = true,
	--[[ enUS ]] ["Group"] = true,
	--[[ enUS ]] ["Default"] = true,

	-- player locations; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ enUS ]] ["Player Location"] = true,
	--[[ enUS ]] ["World"] = true,
	--[[ enUS ]] ["Battleground"] = true,
	--[[ enUS ]] ["Arena"] = true,
	--[[ enUS ]] ["5-Man Instance"] = true,
	--[[ enUS ]] ["Raid Instance"] = true,

	--[[ enUS ]] ["Data Options"] = true,
	--[[ enUS ]] ["Data options"] = true,

	--[[ enUS ]] ["Load Options"] = true,
	--[[ enUS ]] ["Load options for Aloft modules"] = true,

	--[[ enUS ]] ["Unable to determine module providing data: "] = true,
	--[[ enUS ]] ["Internal error: Dependency list not resolved - cyclic dependency?"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Aloft"] = "Aloft",
	--[[ koKR ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units

	--[[ koKR ]] ["Enable Startup Message"] = "Enable Startup Message",

	--[[ koKR ]] ["Class Colors"] = "Class Colors",
	--[[ koKR ]] ["Customize class colors"] = "Customize class colors",
	--[[ koKR ]] ["class color"] = "class color",
	--[[ koKR ]] ["Reset to Defaults"] = "기본값으로 초기화",
	--[[ koKR ]] ["Resets all colors to their defaults"] = "모든 색상을 기본값으로 초기화합니다.",

	-- labels for keybindings; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ koKR ]] ["Show Neutral/Enemy Name Plates"] = "Show Neutral/Enemy Name Plates",
	--[[ koKR ]] ["Show Friendly Name Plates"] = "Show Friendly Name Plates",
	--[[ koKR ]] ["Show All Name Plates"] = "Show All Name Plates",

	-- player states; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ koKR ]] ["Combat"] = "Combat",
	--[[ koKR ]] ["Flagged/PvP"] = "Flagged/PvP",
	--[[ koKR ]] ["Resting"] = "Resting",
	--[[ koKR ]] ["Group"] = "Group",
	--[[ koKR ]] ["Default"] = "Default",

	-- player locations; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ koKR ]] ["Player Location"] = "Player Location",
	--[[ koKR ]] ["World"] = "World",
	--[[ koKR ]] ["Battleground"] = "Battleground",
	--[[ koKR ]] ["Arena"] = "Arena",
	--[[ koKR ]] ["5-Man Instance"] = "5-Man Instance",
	--[[ koKR ]] ["Raid Instance"] = "Raid Instance",

	--[[ koKR ]] ["Data Options"] = "데이터 설정",
	--[[ koKR ]] ["Data options"] = "데이터에 대한 설정입니다.",

	--[[ koKR ]] ["Load Options"] = "불러오기 설정",
	--[[ koKR ]] ["Load options for Aloft modules"] = "Aloft 모듈들에 대한 불러오기 설정입니다.",

	--[[ koKR ]] ["Unable to determine module providing data: "] = "데이터를 위한 모듈을 결정할 수 없습니다: ",
	--[[ koKR ]] ["Internal error: Dependency list not resolved - cyclic dependency?"] = "내부적 오류: 목록 의존성이 해결되지 않았습니다 - 순환적인 의존성?",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Aloft"] = "Aloft",
	--[[ ruRU ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units

	--[[ ruRU ]] ["Enable Startup Message"] = "Enable Startup Message",

	--[[ ruRU ]] ["Class Colors"] = "Окраска классов",
	--[[ ruRU ]] ["Customize class colors"] = "Настраивать окраски классов",
	--[[ ruRU ]] ["class color"] = "class color",
	--[[ ruRU ]] ["Reset to Defaults"] = "Сброс в настройки по умолчанию",
	--[[ ruRU ]] ["Resets all colors to their defaults"] = "Сбрасывает все цвета в настройки по умолчанию",

	-- labels for keybindings; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ ruRU ]] ["Show Neutral/Enemy Name Plates"] = "Отображать таблички нейтральных/враждебных",							
	--[[ ruRU ]] ["Show Friendly Name Plates"] = "Отображать таблички дружественных",
	--[[ ruRU ]] ["Show All Name Plates"] = "Отображать все таблички",

	-- player states; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ ruRU ]] ["Combat"] = "Бой",
	--[[ ruRU ]] ["Flagged/PvP"] = "Флаг/PvP",
	--[[ ruRU ]] ["Resting"] = "Отдых",
	--[[ ruRU ]] ["Group"] = "Группа",
	--[[ ruRU ]] ["Default"] = "По умолчанию",

	-- player locations; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ ruRU ]] ["Player Location"] = "Местонахождение игрока",
	--[[ ruRU ]] ["World"] = "Мир",
	--[[ ruRU ]] ["Battleground"] = "Поля сражений",
	--[[ ruRU ]] ["Arena"] = "Арена",
	--[[ ruRU ]] ["5-Man Instance"] = "Инстансы на 5-чел",
	--[[ ruRU ]] ["Raid Instance"] = "Рейдовые инстансыe",

	--[[ ruRU ]] ["Data Options"] = "Настройка данных",
	--[[ ruRU ]] ["Data options"] = "Настройка данных",
	
	--[[ ruRU ]] ["Load Options"] = "Настройки загрузки",
	--[[ ruRU ]] ["Load options for Aloft modules"] = "Настройки загрузки для модулей Aloft",

	--[[ ruRU ]] ["Unable to determine module providing data: "] = "Невозможно определить модуль, предоставляющий данные",
	--[[ ruRU ]] ["Internal error: Dependency list not resolved - cyclic dependency?"] = "Внутренняя ошибка: Невозможно разрешить список зависимостей — циклическая зависимость?",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Aloft"] = "Aloft",
	--[[ zhCN ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units

	--[[ zhCN ]] ["Enable Startup Message"] = "Enable Startup Message",

	--[[ zhCN ]] ["Class Colors"] = "职业颜色",
	--[[ zhCN ]] ["Customize class colors"] = "自定义职业颜色",
	--[[ zhCN ]] ["class color"] = "职业颜色",
	--[[ zhCN ]] ["Reset to Defaults"] = "重置为默认",
	--[[ zhCN ]] ["Resets all colors to their defaults"] = "将全部颜色设定重置为默认",

	-- labels for keybindings; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ zhCN ]] ["Show Neutral/Enemy Name Plates"] = "Show Neutral/Enemy Name Plates",
	--[[ zhCN ]] ["Show Friendly Name Plates"] = "Show Friendly Name Plates",
	--[[ zhCN ]] ["Show All Name Plates"] = "Show All Name Plates",

	-- player states; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ zhCN ]] ["Combat"] = "战斗",
	--[[ zhCN ]] ["Flagged/PvP"] = "Flagged/PvP",
	--[[ zhCN ]] ["Resting"] = "休息",
	--[[ zhCN ]] ["Group"] = "小队",
	--[[ zhCN ]] ["Default"] = "默认",

	-- player locations; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ zhCN ]] ["Player Location"] = "Player Location",
	--[[ zhCN ]] ["World"] = "World",
	--[[ zhCN ]] ["Battleground"] = "Battleground",
	--[[ zhCN ]] ["Arena"] = "Arena",
	--[[ zhCN ]] ["5-Man Instance"] = "5-Man Instance",
	--[[ zhCN ]] ["Raid Instance"] = "Raid Instance",

	--[[ zhCN ]] ["Data Options"] = "数据选项",
	--[[ zhCN ]] ["Data options"] = "数据选项",

	--[[ zhCN ]] ["Load Options"] = "加载设置",
	--[[ zhCN ]] ["Load options for Aloft modules"] = "Aloft模块选项",

	--[[ zhCN ]] ["Unable to determine module providing data: "] = "无法确认提供数据的模块",
	--[[ zhCN ]] ["Internal error: Dependency list not resolved - cyclic dependency?"] = "内部错误：未找到依赖列表 - 是否遍历依赖？",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Aloft"] = "Aloft",
	--[[ zhTW ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units

	--[[ zhTW ]] ["Enable Startup Message"] = "Enable Startup Message",

	--[[ zhTW ]] ["Class Colors"] = "職業顏色",
	--[[ zhTW ]] ["Customize class colors"] = "自定義職業顏色",
	--[[ zhTW ]] ["class color"] = "職業顏色",
	--[[ zhTW ]] ["Reset to Defaults"] = "重設回預設值",
	--[[ zhTW ]] ["Resets all colors to their defaults"] = "重設全部顏色回預設值",

	-- labels for keybindings; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ zhTW ]] ["Show Neutral/Enemy Name Plates"] = "Show Neutral/Enemy Name Plates",
	--[[ zhTW ]] ["Show Friendly Name Plates"] = "Show Friendly Name Plates",
	--[[ zhTW ]] ["Show All Name Plates"] = "Show All Name Plates",

	-- player states; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ zhTW ]] ["Combat"] = "戰斗",
	--[[ zhTW ]] ["Flagged/PvP"] = "Flagged/PvP",
	--[[ zhTW ]] ["Resting"] = "休息",
	--[[ zhTW ]] ["Group"] = "小隊",
	--[[ zhTW ]] ["Default"] = "默認",

	-- player locations; should match strings in AloftAutoShow/AloftAutoShowOptions.lua and AloftAutoShow localizations
	--[[ zhTW ]] ["Player Location"] = "Player Location",
	--[[ zhTW ]] ["World"] = "World",
	--[[ zhTW ]] ["Battleground"] = "Battleground",
	--[[ zhTW ]] ["Arena"] = "Arena",
	--[[ zhTW ]] ["5-Man Instance"] = "5-Man Instance",
	--[[ zhTW ]] ["Raid Instance"] = "Raid Instance",

	--[[ zhTW ]] ["Data Options"] = "資料選項",
	--[[ zhTW ]] ["Data options"] = "資料選項",

	--[[ zhTW ]] ["Load Options"] = "載入選項",
	--[[ zhTW ]] ["Load options for Aloft modules"] = "Aloft 模組的載入選項",

	--[[ zhTW ]] ["Unable to determine module providing data: "] = "不能測定模組。資料: ",
	--[[ zhTW ]] ["Internal error: Dependency list not resolved - cyclic dependency?"] = "內部錯誤: 循環倚靠?",
} end)

-----------------------------------------------------------------------------

end
