local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftNameTextOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Name Text"] = true,
	--[[ enUS ]] ["Nameplate text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show unit names"] = true,

	--[[ enUS ]] ["Use Aliases"] = true,
	--[[ enUS ]] ["Uses user defined aliases"] = true,

	--[[ enUS ]] ["Set Alias"] = true,
	--[[ enUS ]] ["Sets the alias for your current target. An empty alias will return the unit to its original name"] = true,
	--[[ enUS ]] ["<Any String>"] = true,

	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Nameplate text typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for nameplate text"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on nameplate text"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the nameplate text"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the font outline for nameplate text"] = true,

	--[[ enUS ]] ["Alignment"] = true,
	--[[ enUS ]] ["Sets the alignment of the nameplate text"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust nameplate text position"] = true,
	--[[ enUS ]] ["Left Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the left of the text"] = true,
	--[[ enUS ]] ["Right Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the right of the text"] = true,
	--[[ enUS ]] ["Vertical Offset"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the text"] = true,

	--[[ enUS ]] ["Override Colors"] = true,
	--[[ enUS ]] ["Override the games colors for nameplate text"] = true,
	--[[ enUS ]] ["Colors"] = true,
	--[[ enUS ]] ["Customize colors"] = true,

	--[[ enUS ]] ["Color by Class"] = true,
	--[[ enUS ]] ["Sets the name text color according to class"] = true,
	--[[ enUS ]] ["Color Hostile by Class"] = true,
	--[[ enUS ]] ["Sets the name text color of hostile players according to class"] = true,
	--[[ enUS ]] ["Set All"] = true,
	--[[ enUS ]] ["Sets the name text color for all types"] = true,
	--[[ enUS ]] ["Set All Friendly"] = true,
	--[[ enUS ]] ["Sets the name text color for all friendly types"] = true,
	--[[ enUS ]] ["Set All Hostile"] = true,
	--[[ enUS ]] ["Sets the name text color for all hostile types"] = true,

	--[[ enUS ]] ["Pet"] = true,
	--[[ enUS ]] ["Sets the name text color for your pet"] = true,
	--[[ enUS ]] ["Friendly Players"] = true,
	--[[ enUS ]] ["Sets the name text color for friendly players"] = true,
	--[[ enUS ]] ["Friendly Pets"] = true,
	--[[ enUS ]] ["Sets the name text color for friendly pets"] = true,
	--[[ enUS ]] ["Friendly NPCs"] = true,
	--[[ enUS ]] ["Sets the name text color for friendly NPC Bosses"] = true,
	--[[ enUS ]] ["Friendly Boss"] = true,
	--[[ enUS ]] ["Sets the name text color for friendly NPCs"] = true,
	--[[ enUS ]] ["Hostile Players"] = true,
	--[[ enUS ]] ["Sets the name text color for hostile players"] = true,
	--[[ enUS ]] ["Hostile Pets"] = true,
	--[[ enUS ]] ["Sets the name text color for hostile pets"] = true,
	--[[ enUS ]] ["Hostile NPCs"] = true,
	--[[ enUS ]] ["Sets the name text color for hostile units"] = true,
	--[[ enUS ]] ["Hostile Boss"] = true,
	--[[ enUS ]] ["Sets the name text color for hostile boss units"] = true,
	--[[ enUS ]] ["Neutral Units"] = true,
	--[[ enUS ]] ["Sets the name text color for neutral units"] = true,
	--[[ enUS ]] ["Group Pets"] = true,
	--[[ enUS ]] ["Sets the name text color for group pets"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["Advanced"] = true,
	--[[ enUS ]] ["Options for expert users"] = true,
	--[[ enUS ]] ["Format"] = true,
	--[[ enUS ]] ["Name tag"] = true,
	--[[ enUS ]] ["<Any tag string>"] = true,

	--[[ enUS ]] ["LEFT"] = true,
	--[[ enUS ]] ["CENTER"] = true,
	--[[ enUS ]] ["RIGHT"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Name Text"] = "이름",
	--[[ koKR ]] ["Nameplate text options"] = "이름 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show unit names"] = "대상의 이름을 표시합니다.",

	--[[ koKR ]] ["Use Aliases"] = "별명 사용",
	--[[ koKR ]] ["Uses user defined aliases"] = "사용자가 지정한 별명을 사용합니다.",

	--[[ koKR ]] ["Set Alias"] = "별명 설정",
	--[[ koKR ]] ["Sets the alias for your current target. An empty alias will return the unit to its original name"] = "현재 대상에 대한 별명을 설정합니다. 빈칸으로 두면 대상의 실제 이름을 반환합니다.",
	--[[ koKR ]] ["<Any String>"] = "<문자열>",

	--[[ koKR ]] ["Typeface"] = "서체",
	--[[ koKR ]] ["Nameplate text typeface options"] = "이름 서체 설정",
	--[[ koKR ]] ["Font"] = "글꼴",
	--[[ koKR ]] ["Sets the font for nameplate text"] = "이름의 글꼴을 설정합니다.",
	--[[ koKR ]] ["Font Shadow"] = "글꼴 그림자",
	--[[ koKR ]] ["Show font shadow on nameplate text"] = "이름에 그림자를 표시합니다.",
	--[[ koKR ]] ["Font Size"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the font height of the nameplate text"] = "이름의 높이를 설정합니다.",
	--[[ koKR ]] ["Outline"] = "테두리",
	--[[ koKR ]] ["Sets the font outline for nameplate text"] = "이름의 테두리를 설정합니다.",

	--[[ koKR ]] ["Alignment"] = "정렬",
	--[[ koKR ]] ["Sets the alignment of the nameplate text"] = "이름의 정렬을 설정합니다.",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust nameplate text position"] = "이름 위치 조절",
	--[[ koKR ]] ["Left Offset"] = "좌측 좌표",
	--[[ koKR ]] ["Sets the offset of the left of the text"] = "이름의 좌측 좌표를 설정합니다.",
	--[[ koKR ]] ["Right Offset"] = "우측 좌표",
	--[[ koKR ]] ["Sets the offset of the right of the text"] = "이름의 우측 좌표를 설정합니다.",
	--[[ koKR ]] ["Vertical Offset"] = "수직 좌표",
	--[[ koKR ]] ["Sets the vertical offset of the text"] = "이름의 수직 좌표를 설정합니다.",

	--[[ koKR ]] ["Override Colors"] = "색상 적용",
	--[[ koKR ]] ["Override the games colors for nameplate text"] = "이름에 게임 색상을 적용합니다.",
	--[[ koKR ]] ["Colors"] = "색상",
	--[[ koKR ]] ["Customize colors"] = "사용자 색상",

	--[[ koKR ]] ["Color by Class"] = "직업별 색상",
	--[[ koKR ]] ["Sets the name text color according to class"] = "이름 색상에 직업별 색상을 설정합니다.",
	--[[ koKR ]] ["Color Hostile by Class"] = "적대적 직업별 색상",
	--[[ koKR ]] ["Sets the name text color of hostile players according to class"] = "적대적 플레이어의 이름에 직업별 색상을 설정합니다.",
	--[[ koKR ]] ["Set All"] = "전체 설정",
	--[[ koKR ]] ["Sets the name text color for all types"] = "모든 이름의 색상을 설정합니다.",
	--[[ koKR ]] ["Set All Friendly"] = "전체 우호적 설정",
	--[[ koKR ]] ["Sets the name text color for all friendly types"] = "전체 우호적 대상에 대한 이름의 색상을 설정합니다.",
	--[[ koKR ]] ["Set All Hostile"] = "전체 적대적 설정",
	--[[ koKR ]] ["Sets the name text color for all hostile types"] = "전체 적대적 대상에 대한 이름의 색상을 설정합니다.",

	--[[ koKR ]] ["Pet"] = "소환수",
	--[[ koKR ]] ["Sets the name text color for your pet"] = "소환수의 이름 색상을 설정합니다.",
	--[[ koKR ]] ["Friendly Players"] = "우호적 플레이어",
	--[[ koKR ]] ["Sets the name text color for friendly players"] = "우호적 플레이어의 이름 색상을 설정합니다.",
	--[[ koKR ]] ["Friendly Pets"] = "우호적 소환수",
	--[[ koKR ]] ["Sets the name text color for friendly pets"] = "우호적 소환수의 이름 색상을 설정합니다.",
	--[[ koKR ]] ["Friendly NPCs"] = "우호적 NPC",
	--[[ koKR ]] ["Sets the name text color for friendly NPC Bosses"] = "우호적 NPC 보스의 이름 색상을 설정합니다.",
	--[[ koKR ]] ["Friendly Boss"] = "우호적 보스",
	--[[ koKR ]] ["Sets the name text color for friendly NPCs"] = "우호적 NPC의 이름 색상을 설정합니다.",
	--[[ koKR ]] ["Hostile Players"] = "적대적 플레이어",
	--[[ koKR ]] ["Sets the name text color for hostile players"] = "적대적 플레이어의 이름 색상을 설정합니다.",
	--[[ koKR ]] ["Hostile Pets"] = "적대적 소환수",
	--[[ koKR ]] ["Sets the name text color for hostile pets"] = "적대적 소환수의 이름 색상을 설정합니다.",
	--[[ koKR ]] ["Hostile NPCs"] = "적대적 NPC",
	--[[ koKR ]] ["Sets the name text color for hostile units"] = "적대적 NPC의 이름 색상을 설정합니다.",
	--[[ koKR ]] ["Hostile Boss"] = "적대적 보스",
	--[[ koKR ]] ["Sets the name text color for hostile boss units"] = "적대적 보스의 이름 색상을 설정합니다.",
	--[[ koKR ]] ["Neutral Units"] = "중립적 대상",
	--[[ koKR ]] ["Sets the name text color for neutral units"] = "중립적 대상의 이름 색상을 설정합니다.",
	--[[ koKR ]] ["Group Pets"] = "파티 소환수",
	--[[ koKR ]] ["Sets the name text color for group pets"] = "파티 소환수의 이름 색상을 설정합니다.",

	--[[ koKR ]] ["None"] = "없음",
	--[[ koKR ]] ["Normal"] = "기본",
	--[[ koKR ]] ["Thick"] = "굵게",

	--[[ koKR ]] ["Advanced"] = "고급",
	--[[ koKR ]] ["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	--[[ koKR ]] ["Format"] = "형식",
	--[[ koKR ]] ["Name tag"] = "이름 태그",
	--[[ koKR ]] ["<Any tag string>"] = "<태그 문자열>",

	--[[ koKR ]] ["LEFT"] = "좌측",
	--[[ koKR ]] ["CENTER"] = "가운데",
	--[[ koKR ]] ["RIGHT"] = "우측",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Name Text"] = "Текст имени",
	--[[ ruRU ]] ["Nameplate text options"] = "Настройки текста таблички",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show unit names"] = "Отображать имена единиц",

	--[[ ruRU ]] ["Use Aliases"] = "Использовать соответствия имен",
	--[[ ruRU ]] ["Uses user defined aliases"] = "Соответствия имен, заданные пользователем",

	--[[ ruRU ]] ["Set Alias"] = "Задать сокращение",
	--[[ ruRU ]] ["Sets the alias for your current target. An empty alias will return the unit to its original name"] = "Задает сокращение для текущей цели. Пустое сокращение вернет цели изначальное имя",
	--[[ ruRU ]] ["<Any String>"] = "<Любая строка>",

	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Nameplate text typeface options"] = "Настройки шрифта таблички",
	--[[ ruRU ]] ["Font"] = "Шрифт",
	--[[ ruRU ]] ["Sets the font for nameplate text"] = "Задает шрифт для текста на табличках",
	--[[ ruRU ]] ["Font Shadow"] = "Тень шрифта",
	--[[ ruRU ]] ["Show font shadow on nameplate text"] = "Отображать тень для текста на табличке",
	--[[ ruRU ]] ["Font Size"] = "Размер шрифта",
	--[[ ruRU ]] ["Sets the font height of the nameplate text"] = "Задает высоту шрифта для текста на табличке",
	--[[ ruRU ]] ["Outline"] = "Контур",
	--[[ ruRU ]] ["Sets the font outline for nameplate text"] = "Задает окантовку для текста на табличке",

	--[[ ruRU ]] ["Alignment"] = "Выравнивание",
	--[[ ruRU ]] ["Sets the alignment of the nameplate text"] = "Задает выравнивание текста на табличке",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust nameplate text position"] = "Задать место текста на табличке",
	--[[ ruRU ]] ["Left Offset"] = "Левое смещение",
	--[[ ruRU ]] ["Sets the offset of the left of the text"] = "Задает смещение левого конца текста",
	--[[ ruRU ]] ["Right Offset"] = "Правое смещение",
	--[[ ruRU ]] ["Sets the offset of the right of the text"] = "Задает смещение правого конца текста",
	--[[ ruRU ]] ["Vertical Offset"] = "Вертикальное смещение",
	--[[ ruRU ]] ["Sets the vertical offset of the text"] = "Задает вертикальное смещение текста",

	--[[ ruRU ]] ["Override Colors"] = "Перезапись цветов",
	--[[ ruRU ]] ["Override the games colors for nameplate text"] = "Перезапись цветов игры для текста табличек",
	--[[ ruRU ]] ["Colors"] = "Цвета",
	--[[ ruRU ]] ["Customize colors"] = "Настройка цветов",

	--[[ ruRU ]] ["Color by Class"] = "Окрашивать в цвет класса",
	--[[ ruRU ]] ["Sets the name text color according to class"] = "Задает цвет имени в зависимости от класса",
	--[[ ruRU ]] ["Color Hostile by Class"] = "Окрашивать враждебных в цвет класса",
	--[[ ruRU ]] ["Sets the name text color of hostile players according to class"] = "Задает цвет имени враждебного игрока в зависимости от класс",
	--[[ ruRU ]] ["Set All"] = "Задать все",
	--[[ ruRU ]] ["Sets the name text color for all types"] = "Задает цвет имени для всех типов",
	--[[ ruRU ]] ["Set All Friendly"] = "Задать всех дружественными",
	--[[ ruRU ]] ["Sets the name text color for all friendly types"] = "Задает цвет имени для всех дружественных типов",
	--[[ ruRU ]] ["Set All Hostile"] = "Задать всех враждебными",
	--[[ ruRU ]] ["Sets the name text color for all hostile types"] = "Задает цвет имени для всех враждебных типов",

	--[[ ruRU ]] ["Pet"] = "Питомец",
	--[[ ruRU ]] ["Sets the name text color for your pet"] = "Задает цвет имени для вашего питомца",
	--[[ ruRU ]] ["Friendly Players"] = "Дружественные игроки",
	--[[ ruRU ]] ["Sets the name text color for friendly players"] = "Задает цвет имени для дружественных игроков",
	--[[ ruRU ]] ["Friendly Pets"] = "Дружественные питомцы",
	--[[ ruRU ]] ["Sets the name text color for friendly pets"] = "Задает цвет имени для дружественных питомцев",
	--[[ ruRU ]] ["Friendly NPCs"] = "Дружественные НИПы",
	--[[ ruRU ]] ["Sets the name text color for friendly NPC Bosses"] = "Задает цвет имени для дружественных НИПов - боссов",
	--[[ ruRU ]] ["Friendly Boss"] = "Дружественный босс",
	--[[ ruRU ]] ["Sets the name text color for friendly NPCs"] = "Задает цвет имени для дружественных НИПов",
	--[[ ruRU ]] ["Hostile Players"] = "Враждебные игроки",
	--[[ ruRU ]] ["Sets the name text color for hostile players"] = "Задает цвет имени для враждебных игроков",
	--[[ ruRU ]] ["Hostile Pets"] = "Враждебные питомцы",
	--[[ ruRU ]] ["Sets the name text color for hostile pets"] = "Задает цвет имени для враждебных питомцев",
	--[[ ruRU ]] ["Hostile NPCs"] = "Враждебные НИПы",
	--[[ ruRU ]] ["Sets the name text color for hostile units"] = "Задает цвет имени для враждебных объектов",
	--[[ ruRU ]] ["Hostile Boss"] = "Враждебный босс",
	--[[ ruRU ]] ["Sets the name text color for hostile boss units"] = "Задает цвет имени для враждебных боссов",
	--[[ ruRU ]] ["Neutral Units"] = "Нейтральные цели",
	--[[ ruRU ]] ["Sets the name text color for neutral units"] = "Задает цвет имени для нейтральных",
	--[[ ruRU ]] ["Group Pets"] = "Питомцы группы",
	--[[ ruRU ]] ["Sets the name text color for group pets"] = "Задает цвет имен для питомцев группы",

	--[[ ruRU ]] ["None"] = "Нет",
	--[[ ruRU ]] ["Normal"] = "Обычно",
	--[[ ruRU ]] ["Thick"] = "Жирный",

	--[[ ruRU ]] ["Advanced"] = "Дополнительно",
	--[[ ruRU ]] ["Options for expert users"] = "Настройки для опытных пользователей",
	--[[ ruRU ]] ["Format"] = "Формат",
	--[[ ruRU ]] ["Name tag"] = "Вид имени",
	--[[ ruRU ]] ["<Any tag string>"] = "<Любая строка формата>",

	--[[ ruRU ]] ["LEFT"] = "СЛЕВА",
	--[[ ruRU ]] ["CENTER"] = "ПО ЦЕНТРУ",
	--[[ ruRU ]] ["RIGHT"] = "СПРАВА",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Name Text"] = "名称文字",
	--[[ zhCN ]] ["Nameplate text options"] = "姓名板文字相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show unit names"] = "显示单位名称",

	--[[ zhCN ]] ["Use Aliases"] = "使用绰号",
	--[[ zhCN ]] ["Uses user defined aliases"] = "使用自定义绰号",

	--[[ zhCN ]] ["Set Alias"] = "设定绰号",
	--[[ zhCN ]] ["Sets the alias for your current target. An empty alias will return the unit to its original name"] = "设定当前目标的绰号。如果留空则会重置为目标的原有名称",
	--[[ zhCN ]] ["<Any String>"] = "<任意文字>",

	--[[ zhCN ]] ["Typeface"] = "式样",
	--[[ zhCN ]] ["Nameplate text typeface options"] = "姓名板文字式样设置",
	--[[ zhCN ]] ["Font"] = "字体",
	--[[ zhCN ]] ["Sets the font for nameplate text"] = "设定姓名板文字的字体",
	--[[ zhCN ]] ["Font Shadow"] = "字体阴影",
	--[[ zhCN ]] ["Show font shadow on nameplate text"] = "在姓名板文字上显示字体阴影",
	--[[ zhCN ]] ["Font Size"] = "字号",
	--[[ zhCN ]] ["Sets the font height of the nameplate text"] = "设定姓名板文字的字号",
	--[[ zhCN ]] ["Outline"] = "轮廓",
	--[[ zhCN ]] ["Sets the font outline for nameplate text"] = "设定姓名板文字的轮廓",

	--[[ zhCN ]] ["Alignment"] = "对齐",
	--[[ zhCN ]] ["Sets the alignment of the nameplate text"] = "设定姓名板文字的对齐样式",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust nameplate text position"] = "调整姓名板文字的位置",
	--[[ zhCN ]] ["Left Offset"] = "向左偏移",
	--[[ zhCN ]] ["Sets the offset of the left of the text"] = "设定文字的向左偏移量",
	--[[ zhCN ]] ["Right Offset"] = "向右偏移",
	--[[ zhCN ]] ["Sets the offset of the right of the text"] = "设定文字的向右偏移量",
	--[[ zhCN ]] ["Vertical Offset"] = "垂直偏移",
	--[[ zhCN ]] ["Sets the vertical offset of the text"] = "设定文字的垂直偏移量",

	--[[ zhCN ]] ["Override Colors"] = "置换颜色",
	--[[ zhCN ]] ["Override the games colors for nameplate text"] = "置换姓名板文字的游戏内颜色",
	--[[ zhCN ]] ["Colors"] = "颜色",
	--[[ zhCN ]] ["Customize colors"] = "自定义颜色",

	--[[ zhCN ]] ["Color by Class"] = "根据职业显示颜色",
	--[[ zhCN ]] ["Sets the name text color according to class"] = "名称文字颜色使用职业代表色",
	--[[ zhCN ]] ["Color Hostile by Class"] = "敌对方单位根据职业显示颜色",
	--[[ zhCN ]] ["Sets the name text color of hostile players according to class"] = "敌对方玩家的名称文字颜色使用职业代表色",
	--[[ zhCN ]] ["Set All"] = "设定全部",
	--[[ zhCN ]] ["Sets the name text color for all types"] = "设定所有单位的名称文字颜色",
	--[[ zhCN ]] ["Set All Friendly"] = "设定全部友好方单位",
	--[[ zhCN ]] ["Sets the name text color for all friendly types"] = "设定全部友好方单位的名称文字颜色",
	--[[ zhCN ]] ["Set All Hostile"] = "设定全部敌对方单位",
	--[[ zhCN ]] ["Sets the name text color for all hostile types"] = "设定全部敌对方单位的名称文字颜色",

	--[[ zhCN ]] ["Pet"] = "宠物",
	--[[ zhCN ]] ["Sets the name text color for your pet"] = "宠物的名称文字颜色",
	--[[ zhCN ]] ["Friendly Players"] = "友好方玩家",
	--[[ zhCN ]] ["Sets the name text color for friendly players"] = "设定友好方玩家的名称文字颜色",
	--[[ zhCN ]] ["Friendly Pets"] = "友好方宠物",
	--[[ zhCN ]] ["Sets the name text color for friendly pets"] = "设定友好方宠物的名称文字颜色",
	--[[ zhCN ]] ["Friendly NPCs"] = "友好方NPC",
	--[[ zhCN ]] ["Sets the name text color for friendly NPC Bosses"] = "设定友好方首领的名称文字颜色",
	--[[ zhCN ]] ["Friendly Boss"] = "友好方首领",
	--[[ zhCN ]] ["Sets the name text color for friendly NPCs"] = "设定友好方NPC的名称文字颜色",
	--[[ zhCN ]] ["Hostile Players"] = "敌对方玩家",
	--[[ zhCN ]] ["Sets the name text color for hostile players"] = "设定敌对方玩家的名称文字颜色",
	--[[ zhCN ]] ["Hostile Pets"] = "敌对方宠物",
	--[[ zhCN ]] ["Sets the name text color for hostile pets"] = "设定敌对方宠物的名称文字颜色",
	--[[ zhCN ]] ["Hostile NPCs"] = "敌对方NPC",
	--[[ zhCN ]] ["Sets the name text color for hostile units"] = "设定敌对方NPC的名称文字颜色",
	--[[ zhCN ]] ["Hostile Boss"] = "敌对方首领",
	--[[ zhCN ]] ["Sets the name text color for hostile boss units"] = "设定敌对方首领的名称文字颜色",
	--[[ zhCN ]] ["Neutral Units"] = "中立方单位",
	--[[ zhCN ]] ["Sets the name text color for neutral units"] = "设定中立方单位的名称文字颜色",
	--[[ zhCN ]] ["Group Pets"] = "队友宠物",
	--[[ zhCN ]] ["Sets the name text color for group pets"] = "设定队友宠物的名称文字颜色",

	--[[ zhCN ]] ["None"] = "无",
	--[[ zhCN ]] ["Normal"] = "正常",
	--[[ zhCN ]] ["Thick"] = "粗",

	--[[ zhCN ]] ["Advanced"] = "高级",
	--[[ zhCN ]] ["Options for expert users"] = "高级选项",
	--[[ zhCN ]] ["Format"] = "格式",
	--[[ zhCN ]] ["Name tag"] = "名称标签",
	--[[ zhCN ]] ["<Any tag string>"] = "<任意标签文字>",

	--[[ zhCN ]] ["LEFT"] = "左",
	--[[ zhCN ]] ["CENTER"] = "中",
	--[[ zhCN ]] ["RIGHT"] = "右",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Name Text"] = "名字文字",
	--[[ zhTW ]] ["Nameplate text options"] = "名牌文字選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show unit names"] = "顯示單位名字",

	--[[ zhTW ]] ["Use Aliases"] = "使用別名",
	--[[ zhTW ]] ["Uses user defined aliases"] = "使用自定別名",

	--[[ zhTW ]] ["Set Alias"] = "設定別名",
	--[[ zhTW ]] ["Sets the alias for your current target. An empty alias will return the unit to its original name"] = "設定目前目標的別名。空的別名會重設回原有名字",
	--[[ zhTW ]] ["<Any String>"] = "<任何文字>",

	--[[ zhTW ]] ["Typeface"] = "字體",
	--[[ zhTW ]] ["Nameplate text typeface options"] = "名牌文字字體選項",
	--[[ zhTW ]] ["Font"] = "字型",
	--[[ zhTW ]] ["Sets the font for nameplate text"] = "名牌文字字型",
	--[[ zhTW ]] ["Font Shadow"] = "字型陰影",
	--[[ zhTW ]] ["Show font shadow on nameplate text"] = "名牌文字字型陰影",
	--[[ zhTW ]] ["Font Size"] = "字型大小",
	--[[ zhTW ]] ["Sets the font height of the nameplate text"] = "名牌文字字型大小",
	--[[ zhTW ]] ["Outline"] = "輪廓",
	--[[ zhTW ]] ["Sets the font outline for nameplate text"] = "名牌文字字型輪廓",

	--[[ zhTW ]] ["Alignment"] = "對齊",
	--[[ zhTW ]] ["Sets the alignment of the nameplate text"] = "名牌文字對齊",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust nameplate text position"] = "名牌文字位置",
	--[[ zhTW ]] ["Left Offset"] = "左位移",
	--[[ zhTW ]] ["Sets the offset of the left of the text"] = "文字左位移",
	--[[ zhTW ]] ["Right Offset"] = "右位移",
	--[[ zhTW ]] ["Sets the offset of the right of the text"] = "文字右位移",
	--[[ zhTW ]] ["Vertical Offset"] = "垂直位移",
	--[[ zhTW ]] ["Sets the vertical offset of the text"] = "文字垂直位移",

	--[[ zhTW ]] ["Override Colors"] = "置換顏色",
	--[[ zhTW ]] ["Override the games colors for nameplate text"] = "置換名牌文字的遊戲顏色",
	--[[ zhTW ]] ["Colors"] = "顏色",
	--[[ zhTW ]] ["Customize colors"] = "自定顏色",

	--[[ zhTW ]] ["Color by Class"] = "根據職業上色",
	--[[ zhTW ]] ["Sets the name text color according to class"] = "名字文字顏色使用職業顏色",
	--[[ zhTW ]] ["Color Hostile by Class"] = "敵對單位根據職業上色",
	--[[ zhTW ]] ["Sets the name text color of hostile players according to class"] = "敵對玩家的名字文字顏色使用職業顏色",
	--[[ zhTW ]] ["Set All"] = "設定全部",
	--[[ zhTW ]] ["Sets the name text color for all types"] = "設定全部單位的名字文字顏色",
	--[[ zhTW ]] ["Set All Friendly"] = "設定全部友好",
	--[[ zhTW ]] ["Sets the name text color for all friendly types"] = "設定全部友好單位的名字文字顏色",
	--[[ zhTW ]] ["Set All Hostile"] = "設定全部敵對",
	--[[ zhTW ]] ["Sets the name text color for all hostile types"] = "設定全部敵對單位的名字文字顏色",

	--[[ zhTW ]] ["Pet"] = "寵物",
	--[[ zhTW ]] ["Sets the name text color for your pet"] = "寵物的名字文字顏色",
	--[[ zhTW ]] ["Friendly Players"] = "友好玩家",
	--[[ zhTW ]] ["Sets the name text color for friendly players"] = "友好玩家的名字文字顏色",
	--[[ zhTW ]] ["Friendly Pets"] = "友好寵物",
	--[[ zhTW ]] ["Sets the name text color for friendly pets"] = "友好寵物的名字文字顏色",
	--[[ zhTW ]] ["Friendly NPCs"] = "友好NPC",
	--[[ zhTW ]] ["Sets the name text color for friendly NPC Bosses"] = "友好NPC的名字文字顏色",
	--[[ zhTW ]] ["Friendly Boss"] = "友好首領",
	--[[ zhTW ]] ["Sets the name text color for friendly NPCs"] = "友好首領的名字文字顏色",
	--[[ zhTW ]] ["Hostile Players"] = "敵對玩家",
	--[[ zhTW ]] ["Sets the name text color for hostile players"] = "敵對玩家的名字文字顏色",
	--[[ zhTW ]] ["Hostile Pets"] = "敵對寵物",
	--[[ zhTW ]] ["Sets the name text color for hostile pets"] = "敵對寵物的名字文字顏色",
	--[[ zhTW ]] ["Hostile NPCs"] = "敵對NPC",
	--[[ zhTW ]] ["Sets the name text color for hostile units"] = "敵對NPC的名字文字顏色",
	--[[ zhTW ]] ["Hostile Boss"] = "敵對玩家",
	--[[ zhTW ]] ["Sets the name text color for hostile boss units"] = "敵對首領的名字文字顏色",
	--[[ zhTW ]] ["Neutral Units"] = "中立單位",
	--[[ zhTW ]] ["Sets the name text color for neutral units"] = "中立單位的名字文字顏色",
	--[[ zhTW ]] ["Group Pets"] = "團體寵物",
	--[[ zhTW ]] ["Sets the name text color for group pets"] = "團體寵物的名字文字顏色",

	--[[ zhTW ]] ["None"] = "無",
	--[[ zhTW ]] ["Normal"] = "正常",
	--[[ zhTW ]] ["Thick"] = "粗",

	--[[ zhTW ]] ["Advanced"] = "進階",
	--[[ zhTW ]] ["Options for expert users"] = "進階選項",
	--[[ zhTW ]] ["Format"] = "格式",
	--[[ zhTW ]] ["Name tag"] = "名字標籤",
	--[[ zhTW ]] ["<Any tag string>"] = "<任何標籤文字>",

	--[[ zhTW ]] ["LEFT"] = "左",
	--[[ zhTW ]] ["CENTER"] = "中",
	--[[ zhTW ]] ["RIGHT"] = "右",
} end)

-----------------------------------------------------------------------------

end
