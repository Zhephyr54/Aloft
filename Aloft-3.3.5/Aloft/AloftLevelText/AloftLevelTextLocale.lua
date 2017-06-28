local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftLevelTextOptions")

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Level Text"] = true,
	--[[ enUS ]] ["Level text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Enable level text display on the nameplate"] = true,

	--[[ enUS ]] ["Show Creature Type"] = true,
	--[[ enUS ]] ["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = true,

	--[[ enUS ]] ["Show Classification"] = true,
	--[[ enUS ]] ["Shows +,r,b for elite, rare and bosses after the level"] = true,
	--[[ enUS ]] ["Show Race"] = true,
	--[[ enUS ]] ["Shows unit race after the level"] = true,

	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Level text typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for level text"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the level text"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on level text"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the font outline of the level text"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust level text position"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the level text"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the health bar to anchor the level text"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the level text"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the level text"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["Advanced"] = true,
	--[[ enUS ]] ["Options for expert users"] = true,
	--[[ enUS ]] ["Override Text"] = true,
	--[[ enUS ]] ["Override level text"] = true,
	--[[ enUS ]] ["Format"] = true,
	--[[ enUS ]] ["Level tag"] = true,
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

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Level Text"] = "레벨",
	--[[ koKR ]] ["Level text options"] = "레벨 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Enable level text display on the nameplate"] = "이름표에 레벨을 표시합니다.",

	--[[ koKR ]] ["Show Creature Type"] = "몹 종류 표시",
	--[[ koKR ]] ["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = "야수, 악마, 용족, 정령, 인간형 및 언데드등의 몹 종류를 B,D,K,E,H,U등으로 표시합니다.",

	--[[ koKR ]] ["Show Classification"] = "구분 표시",
	--[[ koKR ]] ["Shows +,r,b for elite, rare and bosses after the level"] = "레벨 뒤에 정예, 희귀, 보스등을 +, r, b 로 표시합니다.",
	--[[ koKR ]] ["Show Race"] = "종족 표시",
	--[[ koKR ]] ["Shows unit race after the level"] = "레벨 뒤에 대상의 종족을 표시합니다.",

	--[[ koKR ]] ["Typeface"] = "서체",
	--[[ koKR ]] ["Level text typeface options"] = "레벨 서체 설정",
	--[[ koKR ]] ["Font"] = "글꼴",
	--[[ koKR ]] ["Sets the font for level text"] = "레벨의 글꼴을 설정합니다.",
	--[[ koKR ]] ["Font Size"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the font height of the level text"] = "레벨의 글자 높이를 설정합니다.",
	--[[ koKR ]] ["Font Shadow"] = "글꼴 그림자",
	--[[ koKR ]] ["Show font shadow on level text"] = "레벨에 그림자를 표시합니다.",
	--[[ koKR ]] ["Outline"] = "테두리",
	--[[ koKR ]] ["Sets the font outline of the level text"] = "레벨의 글자에 테두리를 설정합니다.",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust level text position"] = "레벨 위치 조절",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the level text"] = "레벨의 앵커를 설정합니다.",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the health bar to anchor the level text"] = "생명력 바에서 레벨의 앵커 위치를 설정합니다.",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the level text"] = "레벨의 X 좌표 입니다.",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the level text"] = "레벨의 Y 좌표 입니다.",

	--[[ koKR ]] ["None"] = "없음",
	--[[ koKR ]] ["Normal"] = "기본",
	--[[ koKR ]] ["Thick"] = "굵게",

	--[[ koKR ]] ["Advanced"] = "고급",
	--[[ koKR ]] ["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	--[[ koKR ]] ["Override Text"] = "텍스트 오버라이드",
	--[[ koKR ]] ["Override level text"] = "레벨 텍스트 오버라이드",
	--[[ koKR ]] ["Format"] = "형식",
	--[[ koKR ]] ["Level tag"] = "레벨 태그",
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

elseif (locale == "ruRU") then

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Level Text"] = "Текст уровня",
	--[[ ruRU ]] ["Level text options"] = "Настройки текста уровня",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Enable level text display on the nameplate"] = "Включить текст уровня на табличке",

	--[[ ruRU ]] ["Show Creature Type"] = "Отображать тип существа",
	--[[ ruRU ]] ["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = "Отображает З,Д,Э,В,Н для Зверей(З), Демонов(Д), Драконов(Д), Элементалей(Э), Гуманоидов(Г) и Нежити(Н)",

	--[[ ruRU ]] ["Show Classification"] = "Отображать классификацию",
	--[[ ruRU ]] ["Shows +,r,b for elite, rare and bosses after the level"] = "Отображает +,п,б для элитных, редких и боссов за уровнем",
	--[[ ruRU ]] ["Show Race"] = "Отображать расу",
	--[[ ruRU ]] ["Shows unit race after the level"] = "Отображает расу за уровнем",

	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Level text typeface options"] = "Настройки шрифта текста уровня",
	--[[ ruRU ]] ["Font"] = "Шрифт",
	--[[ ruRU ]] ["Sets the font for level text"] = "Задает шрифт для текста уровня",
	--[[ ruRU ]] ["Font Size"] = "Размер шрифта",
	--[[ ruRU ]] ["Sets the font height of the level text"] = "Задает высоту шрифта для текста уровня",
	--[[ ruRU ]] ["Font Shadow"] = "Тень шрифта",
	--[[ ruRU ]] ["Show font shadow on level text"] = "Отображать тень для текста уровня",
	--[[ ruRU ]] ["Outline"] = "Контур",
	--[[ ruRU ]] ["Sets the font outline of the level text"] = "Задает окантовку для текста уровня",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust level text position"] = "Задать место текста уровня",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the level text"] = "Задает прикрепление текста уровня",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the health bar to anchor the level text"] = "Задает точку для положения текста уровня относительно полоски здоровья",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the level text"] = "Смещение текста уровня по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the level text"] = "Смещение текста уровня по Y",

	--[[ ruRU ]] ["None"] = "Нет",
	--[[ ruRU ]] ["Normal"] = "Обычно",
	--[[ ruRU ]] ["Thick"] = "Жирный",

	--[[ ruRU ]] ["Advanced"] = "Дополнительно",
	--[[ ruRU ]] ["Options for expert users"] = "Настройки для опытных пользователей",
	--[[ ruRU ]] ["Override Text"] = "Перезапись текста",
	--[[ ruRU ]] ["Override level text"] = "Перезапись текста уровня",
	--[[ ruRU ]] ["Format"] = "Формат",
	--[[ ruRU ]] ["Level tag"] = "Вид уровня",
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

elseif (locale == "zhCN") then

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Level Text"] = "等级文字",
	--[[ zhCN ]] ["Level text options"] = "等级文字相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Enable level text display on the nameplate"] = "在姓名板上显示等级文字",

	--[[ zhCN ]] ["Show Creature Type"] = "显示生物类型",
	--[[ zhCN ]] ["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = "使用生物类型缩写",

	--[[ zhCN ]] ["Show Classification"] = "显示分类",
	--[[ zhCN ]] ["Shows +,r,b for elite, rare and bosses after the level"] = "使用分类缩写",
	--[[ zhCN ]] ["Show Race"] = "显示种族",
	--[[ zhCN ]] ["Shows unit race after the level"] = "将种族名称显示在等级之后",

	--[[ zhCN ]] ["Typeface"] = "式样",
	--[[ zhCN ]] ["Level text typeface options"] = "等级文字式样设置",
	--[[ zhCN ]] ["Font"] = "字体",
	--[[ zhCN ]] ["Sets the font for level text"] = "设定等级文字的字体",
	--[[ zhCN ]] ["Font Size"] = "字号",
	--[[ zhCN ]] ["Sets the font height of the level text"] = "设定等级文字的字号",
	--[[ zhCN ]] ["Font Shadow"] = "字体阴影",
	--[[ zhCN ]] ["Show font shadow on level text"] = "设定等级文字的字体阴影",
	--[[ zhCN ]] ["Outline"] = "轮廓",
	--[[ zhCN ]] ["Sets the font outline of the level text"] = "设定等级文字的字体轮廓",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust level text position"] = "调整等級文字的位置",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the level text"] = "设定等级文字的锚点",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the health bar to anchor the level text"] = "设定等級文字固定在生命值显示条的相对位置",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the level text"] = "等级文字的X轴偏移量",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the level text"] = "等级文字的Y轴偏移量",

	--[[ zhCN ]] ["None"] = "无",
	--[[ zhCN ]] ["Normal"] = "正常",
	--[[ zhCN ]] ["Thick"] = "粗",

	--[[ zhCN ]] ["Advanced"] = "高级",
	--[[ zhCN ]] ["Options for expert users"] = "高级设置",
	--[[ zhCN ]] ["Override Text"] = "置换文字",
	--[[ zhCN ]] ["Override level text"] = "置换等级文字",
	--[[ zhCN ]] ["Format"] = "格式",
	--[[ zhCN ]] ["Level tag"] = "等级标签",
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

elseif (locale == "zhTW") then

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] --[[ zhTW ]] ["Level Text"] = "等級文字",
	--[[ zhTW ]] --[[ zhTW ]] ["Level text options"] = "等級文字選項",
	--[[ zhTW ]] --[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] --[[ zhTW ]] ["Enable level text display on the nameplate"] = "在名牌顯示等級文字",

	--[[ zhTW ]] --[[ zhTW ]] ["Show Creature Type"] = "顯示生物類型",
	--[[ zhTW ]] --[[ zhTW ]] ["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = "使用簡短生物類型",

	--[[ zhTW ]] --[[ zhTW ]] ["Show Classification"] = "顯示分類",
	--[[ zhTW ]] --[[ zhTW ]] ["Shows +,r,b for elite, rare and bosses after the level"] = "使用簡短分類",
	--[[ zhTW ]] --[[ zhTW ]] ["Show Race"] = "顯示種族",
	--[[ zhTW ]] --[[ zhTW ]] ["Shows unit race after the level"] = "顯示種族於等級文字之後",

	--[[ zhTW ]] --[[ zhTW ]] ["Typeface"] = "字體",
	--[[ zhTW ]] --[[ zhTW ]] ["Level text typeface options"] = "等級文字字體選項",
	--[[ zhTW ]] --[[ zhTW ]] ["Font"] = "字型",
	--[[ zhTW ]] --[[ zhTW ]] ["Sets the font for level text"] = "等級文字字型",
	--[[ zhTW ]] --[[ zhTW ]] ["Font Size"] = "字型大小",
	--[[ zhTW ]] --[[ zhTW ]] ["Sets the font height of the level text"] = "等級文字字型大小",
	--[[ zhTW ]] --[[ zhTW ]] ["Font Shadow"] = "字型陰影",
	--[[ zhTW ]] --[[ zhTW ]] ["Show font shadow on level text"] = "等級文字字型陰影",
	--[[ zhTW ]] --[[ zhTW ]] ["Outline"] = "輪廓",
	--[[ zhTW ]] --[[ zhTW ]] ["Sets the font outline of the level text"] = "等級文字字型輪廓",

	--[[ zhTW ]] --[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] --[[ zhTW ]] ["Adjust level text position"] = "等級文字位置",
	--[[ zhTW ]] --[[ zhTW ]] ["Anchor"] = "定位點",
	--[[ zhTW ]] --[[ zhTW ]] ["Sets the anchor for the level text"] = "等級文字定位點",
	--[[ zhTW ]] --[[ zhTW ]] ["Anchor To"] = "固定在",
	--[[ zhTW ]] --[[ zhTW ]] ["Sets the relative point on the health bar to anchor the level text"] = "等級文字固定在生命力條的位置",
	--[[ zhTW ]] --[[ zhTW ]] ["X Offset"] = "X位移",
	--[[ zhTW ]] --[[ zhTW ]] ["X offset of the level text"] = "等級文字X位移",
	--[[ zhTW ]] --[[ zhTW ]] ["Y Offset"] = "Y位移",
	--[[ zhTW ]] --[[ zhTW ]] ["Y offset of the level text"] = "等級文字Y位移",

	--[[ zhTW ]] --[[ zhTW ]] ["None"] = "無",
	--[[ zhTW ]] --[[ zhTW ]] ["Normal"] = "正常",
	--[[ zhTW ]] --[[ zhTW ]] ["Thick"] = "粗",

	--[[ zhTW ]] --[[ zhTW ]] ["Advanced"] = "進階",
	--[[ zhTW ]] --[[ zhTW ]] ["Options for expert users"] = "進階選項",
	--[[ zhTW ]] --[[ zhTW ]] ["Override Text"] = "置換文字",
	--[[ zhTW ]] --[[ zhTW ]] ["Override level text"] = "置換等級文字",
	--[[ zhTW ]] --[[ zhTW ]] ["Format"] = "格式",
	--[[ zhTW ]] --[[ zhTW ]] ["Level tag"] = "等級標籤",
	--[[ zhTW ]] --[[ zhTW ]] ["<Any tag string>"] = "<任何標籤文字>",

	--[[ zhTW ]] --[[ zhTW ]] ["TOPLEFT"] = "左上",
	--[[ zhTW ]] --[[ zhTW ]] ["TOP"] = "上",
	--[[ zhTW ]] --[[ zhTW ]] ["TOPRIGHT"] = "右上",
	--[[ zhTW ]] --[[ zhTW ]] ["LEFT"] = "左",
	--[[ zhTW ]] --[[ zhTW ]] ["CENTER"] = "中",
	--[[ zhTW ]] --[[ zhTW ]] ["RIGHT"] = "右",
	--[[ zhTW ]] --[[ zhTW ]] ["BOTTOMLEFT"] = "左下",
	--[[ zhTW ]] --[[ zhTW ]] ["BOTTOM"] = "下",
	--[[ zhTW ]] --[[ zhTW ]] ["BOTTOMRIGHT"] = "右下",
} end)

-----------------------------------------------------------------------------

end
