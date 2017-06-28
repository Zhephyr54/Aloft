local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local dL = AceLibrary("AceLocale-2.2"):new("AloftCommentData")

-----------------------------------------------------------------------------

local oL = AceLibrary("AceLocale-2.2"):new("AloftCommentDataOptions")

-----------------------------------------------------------------------------

local tL = AceLibrary("AceLocale-2.2"):new("AloftCommentTextOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Level"] = true,

	--[[ enUS ]] ["Unknown"] = true, -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Comments"] = true,
	--[[ enUS ]] ["Comment options"] = true,

	--[[ enUS ]] ["Save Comment Data"] = true,
	--[[ enUS ]] ["Stores comment data between sessions"] = true,

	--[[ enUS ]] ["Automatic Comments"] = true,
	--[[ enUS ]] ["Automatically set comments from tooltip tags"] = true,

	--[[ enUS ]] ["   Include Hostile Units"] = true,
	--[[ enUS ]] ["Include hostile units when automatically gathering comments"] = true,

	--[[ enUS ]] ["Reset Comments"] = true,
	--[[ enUS ]] ["Empties the comment database"] = true,

	--[[ enUS ]] ["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = true,
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Comment Text"] = true,
	--[[ enUS ]] ["Comment text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show comments on nameplates"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for comment text"] = true,

	--[[ enUS ]] ["Set Comment"] = true,
	--[[ enUS ]] ["Sets the comment for your current target"] = true,
	--[[ enUS ]] ["<Any String>"] = true,

	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Comment typeface options"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the comment text"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on comment text"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the outline for comment text"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust comment tag position"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the comment text"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the health bar to anchor the comment text"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the comment text"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the comment text"] = true,
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Sets the alpha of the comment text"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the comment text color"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["NoSetComment"] = "|cffff0000You must have a target to set a comment|r",
	--[[ enUS ]] ["CommentAdded"] = "Added |cff00ff00%s|r -> |cff00ff00%s|r",

	--[[ enUS ]] ["Advanced"] = true,
	--[[ enUS ]] ["Options for expert users"] = true,
	--[[ enUS ]] ["Format"] = true,
	--[[ enUS ]] ["Comment tag"] = true,
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

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Level"] = "레벨",

	--[[ koKR ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Comments"] = "메모",
	--[[ koKR ]] ["Comment options"] = "메모 설정",

	--[[ koKR ]] ["Save Comment Data"] = "메모 데이터 저장",
	--[[ koKR ]] ["Stores comment data between sessions"] = "접속 간 메모 데이터를 저장합니다.",

	--[[ koKR ]] ["Automatic Comments"] = "자동 메모",
	--[[ koKR ]] ["Automatically set comments from tooltip tags"] = "자동으로 툴팁 태그를 메모에 설정합니다.",

	--[[ koKR ]] ["   Include Hostile Units"] = "   적대적 대상 포함",
	--[[ koKR ]] ["Include hostile units when automatically gathering comments"] = "자동 메모 설정 시 적대적 대상도 포함시킵니다.",

	--[[ koKR ]] ["Reset Comments"] = "메모 초기화",
	--[[ koKR ]] ["Empties the comment database"] = "메모 데이터를 삭제합니다.",

	--[[ koKR ]] ["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = "당신의 메모 데이터를 삭제합니다.\n이 동작은 되돌릴 수 없습니다. 계속 하시겠습니까?",
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Comment Text"] = "메모 글자",
	--[[ koKR ]] ["Comment text options"] = "메모 글자 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show comments on nameplates"] = "이름표에 메모를 표시합니다.",
	--[[ koKR ]] ["Font"] = "글꼴",
	--[[ koKR ]] ["Sets the font for comment text"] = "메모 글자의 글꼴을 설정합니다.",

	--[[ koKR ]] ["Set Comment"] = "메모 설정",
	--[[ koKR ]] ["Sets the comment for your current target"] = "현재 대상에 대한 메모를 설정합니다.",
	--[[ koKR ]] ["<Any String>"] = "<문자열>",

	--[[ koKR ]] ["Typeface"] = "서체",
	--[[ koKR ]] ["Comment typeface options"] = "메모 서체 설정",
	--[[ koKR ]] ["Font Size"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the font height of the comment text"] = "메모 글자의 글꼴 높이를 설정합니다.",
	--[[ koKR ]] ["Font Shadow"] = "글꼴 그림자",
	--[[ koKR ]] ["Show font shadow on comment text"] = "메모 글자에 그림자를 표시합니다.",
	--[[ koKR ]] ["Outline"] = "테두리",
	--[[ koKR ]] ["Sets the outline for comment text"] = "메모 글자에 테두리를 설정합니다.",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust comment tag position"] = "메모 태그의 위치를 조절합니다.",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the comment text"] = "메모 글자의 앵커를 설정합니다.",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the health bar to anchor the comment text"] = "생명력바에서 메모 글자의 앵커 위치를 설정합니다.",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the comment text"] = "메모 글자의 X 좌표입니다.",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the comment text"] = "메모 글자의 Y 좌표입니다.",
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Sets the alpha of the comment text"] = "메모 글자의 투명도를 설정합니다.",
	--[[ koKR ]] ["Color"] = "색상",
	--[[ koKR ]] ["Sets the comment text color"] = "메모 글자의 색상을 설정합니다.",

	--[[ koKR ]] ["None"] = "없음",
	--[[ koKR ]] ["Normal"] = "기본",
	--[[ koKR ]] ["Thick"] = "굵게",

	--[[ koKR ]] ["NoSetComment"] = "|cffff0000메모를 설정하려면 대상이 있어야 합니다.|r",
	--[[ koKR ]] ["CommentAdded"] = "|cff00ff00%s|r -> |cff00ff00%s|r 추가됨",

	--[[ koKR ]] ["Advanced"] = "고급",
	--[[ koKR ]] ["Options for expert users"] = "고급 사용자를 위한 설정",
	--[[ koKR ]] ["Format"] = "형식",
	--[[ koKR ]] ["Comment tag"] = "메모 태그",
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

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Level"] = "Уровень",

	--[[ ruRU ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Comments"] = "Комментарии",
	--[[ ruRU ]] ["Comment options"] = "Настройка комментариев",

	--[[ ruRU ]] ["Save Comment Data"] = "Записать данные комментариев",
	--[[ ruRU ]] ["Stores comment data between sessions"] = "Сохранять базу комментариев между сессиями",

	--[[ ruRU ]] ["Automatic Comments"] = "Автоматические комментарии",
	--[[ ruRU ]] ["Automatically set comments from tooltip tags"] = "Автоматически задавать комментарии из подсказок",

	--[[ ruRU ]] ["   Include Hostile Units"] = " Включая враждебных",
	--[[ ruRU ]] ["Include hostile units when automatically gathering comments"] = "Включать враждебные цели при автоматическом сборе комментариев",

	--[[ ruRU ]] ["Reset Comments"] = "Сбросить комментарии",
	--[[ ruRU ]] ["Empties the comment database"] = "Очищает базу данных комментариев",

	--[[ ruRU ]] ["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = "Вы хотите сбросить базу комментариев.\nРезультат будет необратим. Продолжить?",
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Comment Text"] = "Текст комментария",
	--[[ ruRU ]] ["Comment text options"] = "Настройки текста комментария",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show comments on nameplates"] = "Отображать комментарии на табличках",
	--[[ ruRU ]] ["Font"] = "Шрифт",
	--[[ ruRU ]] ["Sets the font for comment text"] = "Задает шрифт для текста заклинания",

	--[[ ruRU ]] ["Set Comment"] = "Задать комментарий",
	--[[ ruRU ]] ["Sets the comment for your current target"] = "Задает комментарий для текущей цели",
	--[[ ruRU ]] ["<Any String>"] = "<Любая строка>",

	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Comment typeface options"] = "Настройка шрифта комментариев",
	--[[ ruRU ]] ["Font Size"] = "Размер шрифта",
	--[[ ruRU ]] ["Sets the font height of the comment text"] = "Задает высоту шрифта для текста комментария",
	--[[ ruRU ]] ["Font Shadow"] = "Тень шрифта",
	--[[ ruRU ]] ["Show font shadow on comment text"] = "Отображать тень для текста комментария",
	--[[ ruRU ]] ["Outline"] = "Контур",
	--[[ ruRU ]] ["Sets the outline for comment text"] = "Задает окантовку для текста комментария",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust comment tag position"] = "Задать место комментария",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the comment text"] = "Задает прикрепление текста комментария",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the health bar to anchor the comment text"] = "Задает точку для положения текста комментария относительно полоски здоровья",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the comment text"] = "Смещение текста комментария по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the comment text"] = "Смещение текста комментария по Y",
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Sets the alpha of the comment text"] = "Задает прозрачность текста комментария",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the comment text color"] = "Задает цвет текста комментариев",

	--[[ ruRU ]] ["None"] = "Нет",
	--[[ ruRU ]] ["Normal"] = "Обычный",
	--[[ ruRU ]] ["Thick"] = "Жирный",

	--[[ ruRU ]] ["NoSetComment"] = "|cffff0000У вас должна быть цель чтобы установить комментарии|r",
	--[[ ruRU ]] ["CommentAdded"] = "Добавлено |cff00ff00%s|r -> |cff00ff00%s|r",

	--[[ ruRU ]] ["Advanced"] = "Дополнительно",
	--[[ ruRU ]] ["Options for expert users"] = "Настройки для опытных пользователей",
	--[[ ruRU ]] ["Format"] = "Формат",
	--[[ ruRU ]] ["Comment tag"] = "Вид комментария",
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

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Level"] = "等级",

	--[[ zhCN ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Comments"] = "备注",
	--[[ zhCN ]] ["Comment options"] = "备注选项",

	--[[ zhCN ]] ["Save Comment Data"] = "储存备注信息",
	--[[ zhCN ]] ["Stores comment data between sessions"] = "在两次登录的间隔储存备注信息",

	--[[ zhCN ]] ["Automatic Comments"] = "自动备注",
	--[[ zhCN ]] ["Automatically set comments from tooltip tags"] = "将提示信息自动转为备注",

	--[[ zhCN ]] ["   Include Hostile Units"] = "   包括敌对方单位",
	--[[ zhCN ]] ["Include hostile units when automatically gathering comments"] = "自动设定备注信息包括敌对方单位",

	--[[ zhCN ]] ["Reset Comments"] = "重置备注",
	--[[ zhCN ]] ["Empties the comment database"] = "清空备注信息库",

	--[[ zhCN ]] ["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = "你是否真得要清空备注信息库？",
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Comment Text"] = "备注文字",
	--[[ zhCN ]] ["Comment text options"] = "备注文字相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show comments on nameplates"] = "在姓名板上显示备注文字",
	--[[ zhCN ]] ["Font"] = "字体",
	--[[ zhCN ]] ["Sets the font for comment text"] = "设定备注文字的字体",

	--[[ zhCN ]] ["Set Comment"] = "设定备注",
	--[[ zhCN ]] ["Sets the comment for your current target"] = "为你的当前目标设定备注",
	--[[ zhCN ]] ["<Any String>"] = "<任意文字>",

	--[[ zhCN ]] ["Typeface"] = "式样",
	--[[ zhCN ]] ["Comment typeface options"] = "备注文字式样设置",
	--[[ zhCN ]] ["Font Size"] = "字号",
	--[[ zhCN ]] ["Sets the font height of the comment text"] = "设定备注文字的字号",
	--[[ zhCN ]] ["Font Shadow"] = "字体阴影",
	--[[ zhCN ]] ["Show font shadow on comment text"] = "显示备注文字的字体阴影",
	--[[ zhCN ]] ["Outline"] = "轮廓",
	--[[ zhCN ]] ["Sets the outline for comment text"] = "设定备注文字的字体輪廓",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust comment tag position"] = "调整备注标签的位置",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the comment text"] = "设定备注文字的锚点",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the health bar to anchor the comment text"] = "设定备注文字固定在生命值显示条的相对位置",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the comment text"] = "设定备注文字的X轴偏移量",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the comment text"] = "设定备注文字的Y轴偏移量",
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Sets the alpha of the comment text"] = "设定备注文字的透明度",
	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the comment text color"] = "设定备注文字的颜色",

	--[[ zhCN ]] ["None"] = "无",
	--[[ zhCN ]] ["Normal"] = "正常",
	--[[ zhCN ]] ["Thick"] = "粗",

	--[[ zhCN ]] ["NoSetComment"] = "|cffff0000要设定备注，你需要一个目标|r",
	--[[ zhCN ]] ["CommentAdded"] = "增加: |cff00ff00%s|r -> |cff00ff00%s|r",

	--[[ zhCN ]] ["Advanced"] = "高级",
	--[[ zhCN ]] ["Options for expert users"] = "高级设置",
	--[[ zhCN ]] ["Format"] = "格式",
	--[[ zhCN ]] ["Comment tag"] = "备注标签",
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

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Level"] = "等級",

	--[[ zhTW ]] ["Unknown"] = "Unknown", -- unit name for "Unknown" units
} end)

-----------------------------------------------------------------------------

oL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Comments"] = "備註",
	--[[ zhTW ]] ["Comment options"] = "備註選項",

	--[[ zhTW ]] ["Save Comment Data"] = "儲存備註資料",
	--[[ zhTW ]] ["Stores comment data between sessions"] = "儲存備註資料",

	--[[ zhTW ]] ["Automatic Comments"] = "自動備註",
	--[[ zhTW ]] ["Automatically set comments from tooltip tags"] = "由提示訊息自動設定備註",

	--[[ zhTW ]] ["   Include Hostile Units"] = "   包括敵對單位",
	--[[ zhTW ]] ["Include hostile units when automatically gathering comments"] = "自動設定備註包括敵對單位",

	--[[ zhTW ]] ["Reset Comments"] = "重設備註",
	--[[ zhTW ]] ["Empties the comment database"] = "清空備註資料庫",

	--[[ zhTW ]] ["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = "你是否真的清空備註資料庫?",
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Comment Text"] = "備註文字",
	--[[ zhTW ]] ["Comment text options"] = "備註文字選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show comments on nameplates"] = "在名牌顯示備註",
	--[[ zhTW ]] ["Font"] = "字型",
	--[[ zhTW ]] ["Sets the font for comment text"] = "備註文字字型",

	--[[ zhTW ]] ["Set Comment"] = "設定備註",
	--[[ zhTW ]] ["Sets the comment for your current target"] = "設定目前目標的備註",
	--[[ zhTW ]] ["<Any String>"] = "<任何文字>",

	--[[ zhTW ]] ["Typeface"] = "字體",
	--[[ zhTW ]] ["Comment typeface options"] = "備註文字字體選項",
	--[[ zhTW ]] ["Font Size"] = "字型大小",
	--[[ zhTW ]] ["Sets the font height of the comment text"] = "備註文字字型大小",
	--[[ zhTW ]] ["Font Shadow"] = "字型陰影",
	--[[ zhTW ]] ["Show font shadow on comment text"] = "備註文字字型陰影",
	--[[ zhTW ]] ["Outline"] = "輪廓",
	--[[ zhTW ]] ["Sets the outline for comment text"] = "備註文字字型輪廓",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust comment tag position"] = "備註標籤位置",
	--[[ zhTW ]] ["Anchor"] = "定位點",
	--[[ zhTW ]] ["Sets the anchor for the comment text"] = "備註文字定位點",
	--[[ zhTW ]] ["Anchor To"] = "固定在",
	--[[ zhTW ]] ["Sets the relative point on the health bar to anchor the comment text"] = "備註文字固定在生命力條的位置",
	--[[ zhTW ]] ["X Offset"] = "X位移",
	--[[ zhTW ]] ["X offset of the comment text"] = "備註文字X位移",
	--[[ zhTW ]] ["Y Offset"] = "Y位移",
	--[[ zhTW ]] ["Y offset of the comment text"] = "備註文字Y位移",
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Sets the alpha of the comment text"] = "備註文字透明度",
	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the comment text color"] = "備註文字顏色",

	--[[ zhTW ]] ["None"] = "無",
	--[[ zhTW ]] ["Normal"] = "正常",
	--[[ zhTW ]] ["Thick"] = "粗",

	--[[ zhTW ]] ["NoSetComment"] = "|cffff0000你需要一個目標設定備註|r",
	--[[ zhTW ]] ["CommentAdded"] = "增加: |cff00ff00%s|r -> |cff00ff00%s|r",

	--[[ zhTW ]] ["Advanced"] = "進階",
	--[[ zhTW ]] ["Options for expert users"] = "進階選項",
	--[[ zhTW ]] ["Format"] = "格式",
	--[[ zhTW ]] ["Comment tag"] = "備註標籤",
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

end)

-----------------------------------------------------------------------------

end
