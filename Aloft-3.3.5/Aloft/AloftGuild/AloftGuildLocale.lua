local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local dL = AceLibrary("AceLocale-2.2"):new("AloftGuildDataOptions")

-----------------------------------------------------------------------------

local tL = AceLibrary("AceLocale-2.2"):new("AloftGuildTextOptions")

-----------------------------------------------------------------------------

local sL = AceLibrary("AceLocale-2.2"):new("AloftShortGuildData")

-----------------------------------------------------------------------------

local oL = AceLibrary("AceLocale-2.2"):new("AloftShortGuildDataOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Save Guild Data"] = true,
	--[[ enUS ]] ["Stores guild information between sessions"] = true,
	
	--[[ enUS ]] ["Unknown"] = true, -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Guild Text"] = true,
	--[[ enUS ]] ["Guild text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show guild information on nameplates"] = true,

	--[[ enUS ]] ["Attach to Name"] = true,
	--[[ enUS ]] ["Attaches guild text to name"] = true,
	--[[ enUS ]] ["Attach Format"] = true,
	--[[ enUS ]] ["Selects the text format to use"] = true,

	--[[ enUS ]] ["HYPHEN"]	= "Name - Guild",
	--[[ enUS ]] ["SLASH"]	= "Name / Guild",
	--[[ enUS ]] ["BRACKET"]	= "Name (Guild)",
	--[[ enUS ]] ["COLON"]	= "Name : Guild",

	--[[ enUS ]] ["Short"] = true,
	--[[ enUS ]] ["Use short guild names"] = true,
	--[[ enUS ]] ["Set Short Name"] = true,
	--[[ enUS ]] ["<Any String>"] = true,
	--[[ enUS ]] ["Sets the short name for your current target"] = true,
	--[[ enUS ]] ["Show Own"] = true,
	--[[ enUS ]] ["Show the guild names of your own guild members"] = true,

	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Guild text typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for guild text"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the guild text"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on guild text"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the outline for guild text"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust guild text position"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the guild text"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the health bar to anchor the guild text"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the guild text"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the guild text"] = true,
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Sets the alpha of the guild text"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the guild text color"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["NoSetShortName"] = "|cffff0000You must have a target to set the short name|r",
	--[[ enUS ]] ["ShortNameAdded"] = "Added |cff00ff00%s|r -> |cff00ff00%s|r",

	--[[ enUS ]] ["Advanced"] = true,
	--[[ enUS ]] ["Options for expert users"] = true,
	--[[ enUS ]] ["Format"] = true,
	--[[ enUS ]] ["Guild tag"] = true,
	--[[ enUS ]] ["<Any tag string>"] = true,

	--[[ enUS ]] ["TOPLEFT"] = true,
	--[[ enUS ]] ["TOP"] = true,
	--[[ enUS ]] ["TOPRIGHT"] = true,
	--[[ enUS ]] ["LEFT"] = true,
	--[[ enUS ]] ["CENTER"] = true,
	--[[ enUS ]] ["RIGHT"] = true,
	--[[ enUS ]] ["BOTTOMLEFT"] = true,
	--[[ enUS ]] ["BOTTOM"] = true,
	--[[ enUS ]] ["BOTTOMRIGHT"] = true,
} end)

-----------------------------------------------------------------------------

sL:RegisterTranslations("enUS", function() return {
	["ShortSubstitutions"] =
	{
		--[[ enUS ]] [" [Aa][Nn][Dd] "]	= " & ",
		--[[ enUS ]] [" [Oo][Ff] "]		= " of ",		-- Forces shortened form "o" to go lower case
		--[[ enUS ]] [" [Oo][Nn] "]		= " on ",		-- Forces shortened form "o" to go lower case
		--[[ enUS ]] [" [Tt][Hh][Ee] "]	= " the ",
		--[[ enUS ]] [" [Ii][Nn] "]		= " in ",
	}
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Reset Short Guilds"] = true,
	--[[ enUS ]] ["Empties the custom short guild database"] = true,

	--[[ enUS ]] ["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Save Guild Data"] = "길드 데이터 저장",
	--[[ koKR ]] ["Stores guild information between sessions"] = "접속 간 길드 정보를 저장하니다.",

	--[[ koKR ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Guild Text"] = "길드정보",
	--[[ koKR ]] ["Guild text options"] = "길드정보 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show guild information on nameplates"] = "이름표에 길드정보를 표시합니다.",

	--[[ koKR ]] ["Attach to Name"] = "이름에 첨부",
	--[[ koKR ]] ["Attaches guild text to name"] = "이름에 길드 정보를 추가합니다.",
	--[[ koKR ]] ["Attach Format"] = "첨부 형식",
	--[[ koKR ]] ["Selects the text format to use"] = "사용할 정보 형식을 선택합니다.",

	--[[ koKR ]] ["HYPHEN"]	= "이름  - 길드",
	--[[ koKR ]] ["SLASH"]	= "이름  / 길드",
	--[[ koKR ]] ["BRACKET"]	= "이름  (길드)",
	--[[ koKR ]] ["COLON"]	= "이름  : 길드",

	--[[ koKR ]] ["Short"] = "간략형",
	--[[ koKR ]] ["Use short guild names"] = "짧은 길드명을 사용합니다.",
	--[[ koKR ]] ["Set Short Name"] = "짧은 이름 설정",
	--[[ koKR ]] ["<Any String>"] = "<문자열>",
	--[[ koKR ]] ["Sets the short name for your current target"] = "현재 대상에 대해 짧은 이름을 설정합니다.",
	--[[ koKR ]] ["Show Own"] = "자신 표시",
	--[[ koKR ]] ["Show the guild names of your own guild members"] = "길드원의 길드명을 표시합니다.",

	--[[ koKR ]] ["Typeface"] = "서체",
	--[[ koKR ]] ["Guild text typeface options"] = "길드정보 서체 설정",
	--[[ koKR ]] ["Font"] = "글꼴",
	--[[ koKR ]] ["Sets the font for guild text"] = "길드 정보의 글꼴을 설정합니다.",
	--[[ koKR ]] ["Font Size"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the font height of the guild text"] = "길드 정보 글꼴의 높이를 설정합니다.",
	--[[ koKR ]] ["Font Shadow"] = "글꼴 그림자",
	--[[ koKR ]] ["Show font shadow on guild text"] = "길드 정보 글꼴의 그림자를 표시합니다.",
	--[[ koKR ]] ["Outline"] = "테두리",
	--[[ koKR ]] ["Sets the outline for guild text"] = "길드 정보에 테두리를 설정합니다.",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust guild text position"] = "길드 정보 위치 조절",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the guild text"] = "길드 정보의 앵커를 설정합니다.",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the health bar to anchor the guild text"] = "생명력바에서 길드 정보의 앵커 위치를 설정합니다.",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the guild text"] = "길드 정보의 X 좌표 입니다.",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the guild text"] = "길드 정보의 Y 좌표 입니다.",
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Sets the alpha of the guild text"] = "길드 정보의 투명도를 설정합니다.",
	--[[ koKR ]] ["Color"] = "색상",
	--[[ koKR ]] ["Sets the guild text color"] = "길드 정보의 색상을 설정합니다.",

	--[[ koKR ]] ["None"] = "없음",
	--[[ koKR ]] ["Normal"] = "보통",
	--[[ koKR ]] ["Thick"] = "굵게",

	--[[ koKR ]] ["NoSetShortName"] = "|cffff0000대상에 지정된 짧은 이름이 없습니다.|r",
	--[[ koKR ]] ["ShortNameAdded"] = "|cff00ff00%s|r -> |cff00ff00%s|r 추가됨",

	--[[ koKR ]] ["Advanced"] = "고급",
	--[[ koKR ]] ["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	--[[ koKR ]] ["Format"] = "형식",
	--[[ koKR ]] ["Guild tag"] = "길드 태그",
	--[[ koKR ]] ["<Any tag string>"] = "<태그 문자열>",

	--[[ koKR ]] ["TOPLEFT"] = "좌측 상단",
	--[[ koKR ]] ["TOP"] = "상단",
	--[[ koKR ]] ["TOPRIGHT"] = "우측 상단",
	--[[ koKR ]] ["LEFT"] = "좌측",
	--[[ koKR ]] ["CENTER"] = "가운데",
	--[[ koKR ]] ["RIGHT"] = "우측",
	--[[ koKR ]] ["BOTTOMLEFT"] = "좌측 하단",
	--[[ koKR ]] ["BOTTOM"] = "하단",
	--[[ koKR ]] ["BOTTOMRIGHT"] = "우측 하단",
} end)

-----------------------------------------------------------------------------

sL:RegisterTranslations("koKR", function() return {
	["ShortSubstitutions"] =
	{
		--[[ koKR ]] [" [Aa][Nn][Dd] "]	= " & ",
		--[[ koKR ]] [" [Oo][Ff] "]		= " of ",		-- Forces shortened form "o" to go lower case
		--[[ koKR ]] [" [Oo][Nn] "]		= " on ",		-- Forces shortened form "o" to go lower case
		--[[ koKR ]] [" [Tt][Hh][Ee] "]	= " the ",
		--[[ koKR ]] [" [Ii][Nn] "]		= " in ",
	}
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Reset Short Guilds"] = "짧은 길드 초기화",
	--[[ koKR ]] ["Empties the custom short guild database"] = "사용자의 짧은 길드 데이터베이스를 삭제합니다.",

	--[[ koKR ]] ["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = "당신의 짧은 길드명 데이터를 삭제합니다.\n이 동작은 되돌릴 수 없습니다. 계속 하시겠습니까?",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Save Guild Data"] = "Записать данные о гильдиях",
	--[[ ruRU ]] ["Stores guild information between sessions"] = "Сохранять данные о гильдии между сессиями",

	--[[ ruRU ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Guild Text"] = "Текст гильдии",
	--[[ ruRU ]] ["Guild text options"] = "Настройки текста гильдии",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show guild information on nameplates"] = "Отображать информацию о гильдии на табличках",

	--[[ ruRU ]] ["Attach to Name"] = "Присоединить к имени",
	--[[ ruRU ]] ["Attaches guild text to name"] = "Присоединяет гильд-текст к имени",
	--[[ ruRU ]] ["Attach Format"] = "Способ прикрепления",
	--[[ ruRU ]] ["Selects the text format to use"] = "Выбирает, какой формат использовать для текста",

	--[[ ruRU ]] ["HYPHEN"]	= "Имя - Гильдия",
	--[[ ruRU ]] ["SLASH"]	= "Имя / Гильдия",
	--[[ ruRU ]] ["BRACKET"]	= "Имя (Гильдия)",
	--[[ ruRU ]] ["COLON"]	= "Имя : Гильдия",

	--[[ ruRU ]] ["Short"] = "Сокращенное",
	--[[ ruRU ]] ["Use short guild names"] = "Укорачивать имена гильдий",
	--[[ ruRU ]] ["Set Short Name"] = "Задать короткое имя",
	--[[ ruRU ]] ["<Any String>"] = "<Любая строка>",
	--[[ ruRU ]] ["Sets the short name for your current target"] = "Задает сокращенное имя для текущей цели",
	--[[ ruRU ]] ["Show Own"] = "Отображать себя",
	--[[ ruRU ]] ["Show the guild names of your own guild members"] = "Отображать имя гильдии для членов вашей гильдии",

	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Guild text typeface options"] = "Опции шрифта текста гильдии",
	--[[ ruRU ]] ["Font"] = "Шрифт",
	--[[ ruRU ]] ["Sets the font for guild text"] = "Задает шрифт для текста гильдии",
	--[[ ruRU ]] ["Font Size"] = "Размер шрифта",
	--[[ ruRU ]] ["Sets the font height of the guild text"] = "Задает высоту шрифта для текста гильдии",
	--[[ ruRU ]] ["Font Shadow"] = "Тень шрифта",
	--[[ ruRU ]] ["Show font shadow on guild text"] = "Отображать тень для текста гильдии",
	--[[ ruRU ]] ["Outline"] = "Контур",
	--[[ ruRU ]] ["Sets the outline for guild text"] = "Задает окантовку для текста гильдии",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust guild text position"] = "Задать место текста гильдии",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the guild text"] = "Задает прикрепление текста гильдии",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the health bar to anchor the guild text"] = "Задает точку для положения текста гильдии относительно полоски здоровья",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the guild text"] = "Смещение гильд-текста по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the guild text"] = "Смещение гильд-текста по Y",
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Sets the alpha of the guild text"] = "Задает прозрачность текста гильдии",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the guild text color"] = "Задает цвет текста гильдии",

	--[[ ruRU ]] ["None"] = "Нет",
	--[[ ruRU ]] ["Normal"] = "Обычно",
	--[[ ruRU ]] ["Thick"] = "Жирный",

	--[[ ruRU ]] ["NoSetShortName"] = "|cffff0000У вас должна быть цель чтобы установить сокращение имени|r",
	--[[ ruRU ]] ["ShortNameAdded"] = "Добавлено |cff00ff00%s|r -> |cff00ff00%s|r",

	--[[ ruRU ]] ["Advanced"] = "Дополнительно",
	--[[ ruRU ]] ["Options for expert users"] = "Настройки для опытных пользователей",
	--[[ ruRU ]] ["Format"] = "Формат",
	--[[ ruRU ]] ["Guild tag"] = "Вид гильдии",
	--[[ ruRU ]] ["<Any tag string>"] = "<Любая строка формата>",

	--[[ ruRU ]] ["TOPLEFT"] = "ВВЕРХУ-СЛЕВА",
	--[[ ruRU ]] ["TOP"] = "ВВЕРХУ",
	--[[ ruRU ]] ["TOPRIGHT"] = "ВВЕРХУ-СПРАВА",
	--[[ ruRU ]] ["LEFT"] = "СЛЕВА",
	--[[ ruRU ]] ["CENTER"] = "ПО ЦЕНТРУ",
	--[[ ruRU ]] ["RIGHT"] = "СПРАВА",
	--[[ ruRU ]] ["BOTTOMLEFT"] = "СНИЗУ-СЛЕВА",
	--[[ ruRU ]] ["BOTTOM"] = "СНИЗУ",
	--[[ ruRU ]] ["BOTTOMRIGHT"] = "СНИЗУ-СПРАВА",
} end)

-----------------------------------------------------------------------------

sL:RegisterTranslations("ruRU", function() return {
	["ShortSubstitutions"] =
	{
		--[[ ruRU ]] [" [Aa][Nn][Dd] "]	= " & ",
		--[[ ruRU ]] [" [Oo][Ff] "]		= " - ",		-- Forces shortened form "o" to go lower case
		--[[ ruRU ]] [" [Oo][Nn] "]		= " on ",		-- Forces shortened form "o" to go lower case
		--[[ ruRU ]] [" [Tt][Hh][Ee] "]	= " ",
		--[[ ruRU ]] [" [Ii][Nn] "]		= " в ",
	}
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Reset Short Guilds"] = "Сброс сокращений для гильдий",
	--[[ ruRU ]] ["Empties the custom short guild database"] = "Очищает базу данных сокращенных названий гильдий",

	--[[ ruRU ]] ["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = "Вы хотите сбросить базу сокращенных имен гильдий.\nРезультат будет необратим. Продолжить?",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Save Guild Data"] = "储存公会信息",
	--[[ zhCN ]] ["Stores guild information between sessions"] = "在两次登录的间隔储存公会信息",

	--[[ zhCN ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Guild Text"] = "公会名称文字",
	--[[ zhCN ]] ["Guild text options"] = "公会名称文字相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show guild information on nameplates"] = "在姓名板上显示公会信息",

	--[[ zhCN ]] ["Attach to Name"] = "依附姓名",
	--[[ zhCN ]] ["Attaches guild text to name"] = "公会名称文字依附姓名",
	--[[ zhCN ]] ["Attach Format"] = "依附格式",
	--[[ zhCN ]] ["Selects the text format to use"] = "选择文字的",

	--[[ zhCN ]] ["HYPHEN"]	= "名字 - 公会",
	--[[ zhCN ]] ["SLASH"]	= "名字 / 公会",
	--[[ zhCN ]] ["BRACKET"]	= "名字 (公会)",
	--[[ zhCN ]] ["COLON"]	= "名字 : 公会",

	--[[ zhCN ]] ["Short"] = "缩写",
	--[[ zhCN ]] ["Use short guild names"] = "使用公会名称的缩写",
	--[[ zhCN ]] ["Set Short Name"] = "设定公会名称缩写",
	--[[ zhCN ]] ["<Any String>"] = "<任意文字>",
	--[[ zhCN ]] ["Sets the short name for your current target"] = "设定当前目标公会名称的缩写",
	--[[ zhCN ]] ["Show Own"] = "显示自己",
	--[[ zhCN ]] ["Show the guild names of your own guild members"] = "设定自己公会名称的缩写",

	--[[ zhCN ]] ["Typeface"] = "式样",
	--[[ zhCN ]] ["Guild text typeface options"] = "公会名称文字式样设置",
	--[[ zhCN ]] ["Font"] = "字体",
	--[[ zhCN ]] ["Sets the font for guild text"] = "设定公会名称文字的字体",
	--[[ zhCN ]] ["Font Size"] = "字号",
	--[[ zhCN ]] ["Sets the font height of the guild text"] = "设定公会名称文字的字号",
	--[[ zhCN ]] ["Font Shadow"] = "字体阴影",
	--[[ zhCN ]] ["Show font shadow on guild text"] = "显示公会名称文字的字体阴影",
	--[[ zhCN ]] ["Outline"] = "轮廓",
	--[[ zhCN ]] ["Sets the outline for guild text"] = "设定公会名称文字的轮廓",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust guild text position"] = "调整设定公会名称文字的位置",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the guild text"] = "设定公会名称文字的锚点",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the health bar to anchor the guild text"] = "设定公会名称文字的固定在生命值显示条的相对位置",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the guild text"] = "公会名称文字的X轴偏移量",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the guild text"] = "公会名称文字的Y轴偏移量",
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Sets the alpha of the guild text"] = "设定公会名称文字的透明度",
	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the guild text color"] = "设定公会名称文字的颜色",

	--[[ zhCN ]] ["None"] = "无",
	--[[ zhCN ]] ["Normal"] = "正常",
	--[[ zhCN ]] ["Thick"] = "粗",

	--[[ zhCN ]] ["NoSetShortName"] = "|cffff0000要设定公会简称，你首先需要一个目标|r",
	--[[ zhCN ]] ["ShortNameAdded"] = "增加: |cff00ff00%s|r -> |cff00ff00%s|r",

	--[[ zhCN ]] ["Advanced"] = "高级",
	--[[ zhCN ]] ["Options for expert users"] = "高级设置",
	--[[ zhCN ]] ["Format"] = "格式",
	--[[ zhCN ]] ["Guild tag"] = "公会标签",
	--[[ zhCN ]] ["<Any tag string>"] = "<任意标签文字>",

	--[[ zhCN ]] ["TOPLEFT"] = "左上",
	--[[ zhCN ]] ["TOP"] = "上",
	--[[ zhCN ]] ["TOPRIGHT"] = "右上",
	--[[ zhCN ]] ["LEFT"] = "左",
	--[[ zhCN ]] ["CENTER"] = "中",
	--[[ zhCN ]] ["RIGHT"] = "右",
	--[[ zhCN ]] ["BOTTOMLEFT"] = "左下",
	--[[ zhCN ]] ["BOTTOM"] = "下",
	--[[ zhCN ]] ["BOTTOMRIGHT"] = "右下",
} end)

-----------------------------------------------------------------------------

sL:RegisterTranslations("zhCN", function() return {
	["ShortSubstitutions"] =
	{
		--[[ zhCN ]] [" [Aa][Nn][Dd] "]	= " & ",
		--[[ zhCN ]] [" [Oo][Ff] "]		= " of ",		-- Forces shortened form "o" to go lower case
		--[[ zhCN ]] [" [Oo][Nn] "]		= " on ",		-- Forces shortened form "o" to go lower case
		--[[ zhCN ]] [" [Tt][Hh][Ee] "]	= " the ",
		--[[ zhCN ]] [" [Ii][Nn] "]		= " in ",
	}
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Reset Short Guilds"] = "重置公会简称",
	--[[ zhCN ]] ["Empties the custom short guild database"] = "清空公会简称的信息库。",

	--[[ zhCN ]] ["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = "你是否真要清空公会简称信息库？",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Save Guild Data"] = "儲存公會資料",
	--[[ zhTW ]] ["Stores guild information between sessions"] = "儲存公會資料",

	--[[ zhTW ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Guild Text"] = "公會文字",
	--[[ zhTW ]] ["Guild text options"] = "公會文字選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show guild information on nameplates"] = "在名牌顯示公會資訊",

	--[[ zhTW ]] ["Attach to Name"] = "依附名字",
	--[[ zhTW ]] ["Attaches guild text to name"] = "公會文字依附名字",
	--[[ zhTW ]] ["Attach Format"] = "依附格式",
	--[[ zhTW ]] ["Selects the text format to use"] = "選擇文字格式",

	--[[ zhTW ]] ["HYPHEN"]	= "名字 - 公會",
	--[[ zhTW ]] ["SLASH"]	= "名字 / 公會",
	--[[ zhTW ]] ["BRACKET"]	= "名字 (公會)",
	--[[ zhTW ]] ["COLON"]	= "名字 : 公會",

	--[[ zhTW ]] ["Short"] = "簡短",
	--[[ zhTW ]] ["Use short guild names"] = "使用簡短公會名字",
	--[[ zhTW ]] ["Set Short Name"] = "設定簡短公會名字",
	--[[ zhTW ]] ["<Any String>"] = "<任何文字>",
	--[[ zhTW ]] ["Sets the short name for your current target"] = "設定目前目標的簡短公會名字",
	--[[ zhTW ]] ["Show Own"] = "設定自己",
	--[[ zhTW ]] ["Show the guild names of your own guild members"] = "設定自己的簡短公會名字",

	--[[ zhTW ]] ["Typeface"] = "字體",
	--[[ zhTW ]] ["Guild text typeface options"] = "公會文字字體選項",
	--[[ zhTW ]] ["Font"] = "字型",
	--[[ zhTW ]] ["Sets the font for guild text"] = "公會文字字型",
	--[[ zhTW ]] ["Font Size"] = "字型大小",
	--[[ zhTW ]] ["Sets the font height of the guild text"] = "公會文字字型大小",
	--[[ zhTW ]] ["Font Shadow"] = "字型陰影",
	--[[ zhTW ]] ["Show font shadow on guild text"] = "公會文字字型陰影",
	--[[ zhTW ]] ["Outline"] = "輪廓",
	--[[ zhTW ]] ["Sets the outline for guild text"] = "公會文字字型輪廓",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust guild text position"] = "公會文字位置",
	--[[ zhTW ]] ["Anchor"] = "定位點",
	--[[ zhTW ]] ["Sets the anchor for the guild text"] = "公會文字定位點",
	--[[ zhTW ]] ["Anchor To"] = "固定在",
	--[[ zhTW ]] ["Sets the relative point on the health bar to anchor the guild text"] = "公會文字固定在生命力條的位置",
	--[[ zhTW ]] ["X Offset"] = "X位移",
	--[[ zhTW ]] ["X offset of the guild text"] = "公會文字X位移",
	--[[ zhTW ]] ["Y Offset"] = "Y位移",
	--[[ zhTW ]] ["Y offset of the guild text"] = "公會文字Y位移",
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Sets the alpha of the guild text"] = "公會文字透明度",
	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the guild text color"] = "公會文字顏色",

	--[[ zhTW ]] ["None"] = "無",
	--[[ zhTW ]] ["Normal"] = "正常",
	--[[ zhTW ]] ["Thick"] = "粗",

	--[[ zhTW ]] ["NoSetShortName"] = "|cffff0000你需要一個目標設定簡短公會名字|r",
	--[[ zhTW ]] ["ShortNameAdded"] = "增加: |cff00ff00%s|r -> |cff00ff00%s|r",

	--[[ zhTW ]] ["Advanced"] = "進階",
	--[[ zhTW ]] ["Options for expert users"] = "進階選項",
	--[[ zhTW ]] ["Format"] = "格式",
	--[[ zhTW ]] ["Guild tag"] = "公會標籤",
	--[[ zhTW ]] ["<Any tag string>"] = "<任何標籤文字>",

	--[[ zhTW ]] ["TOPLEFT"] = "左上",
	--[[ zhTW ]] ["TOP"] = "上",
	--[[ zhTW ]] ["TOPRIGHT"] = "右上",
	--[[ zhTW ]] ["LEFT"] = "左",
	--[[ zhTW ]] ["CENTER"] = "中",
	--[[ zhTW ]] ["RIGHT"] = "右",
	--[[ zhTW ]] ["BOTTOMLEFT"] = "左下",
	--[[ zhTW ]] ["BOTTOM"] = "下",
	--[[ zhTW ]] ["BOTTOMRIGHT"] = "右下",
} end)

-----------------------------------------------------------------------------

sL:RegisterTranslations("zhTW", function() return {
	["ShortSubstitutions"] =
	{
		--[[ zhTW ]] [" [Aa][Nn][Dd] "]	= " & ",
		--[[ zhTW ]] [" [Oo][Ff] "]		= " of ",		-- Forces shortened form "o" to go lower case
		--[[ zhTW ]] [" [Oo][Nn] "]		= " on ",		-- Forces shortened form "o" to go lower case
		--[[ zhTW ]] [" [Tt][Hh][Ee] "]	= " the ",
		--[[ zhTW ]] [" [Ii][Nn] "]		= " in ",
	}
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Reset Short Guilds"] = "重設簡短公會名字",
	--[[ zhTW ]] ["Empties the custom short guild database"] = "清空簡短公會名字資料庫",

	--[[ zhTW ]] ["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = "你是否真的清空簡短公會名字資料庫?",
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

end
