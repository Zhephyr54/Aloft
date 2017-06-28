local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Level Text"] = "Level Text"
--[[ enUS ]] L["Level text options"] = "Level text options"
--[[ enUS ]] L["Enable"] = "Enable"
--[[ enUS ]] L["Enable level text display on the nameplate"] = "Enable level text display on the nameplate"

--[[ enUS ]] L["Show Creature Type"] = "Show Creature Type"
--[[ enUS ]] L["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = "Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"

--[[ enUS ]] L["Show Classification"] = "Show Classification"
--[[ enUS ]] L["Shows +,r,b for elite, rare and bosses after the level"] = "Shows +,r,b for elite, rare and bosses after the level"
--[[ enUS ]] L["Show Race"] = "Show Race"
--[[ enUS ]] L["Shows unit race after the level"] = "Shows unit race after the level"

--[[ enUS ]] L["Typeface"] = "Typeface"
--[[ enUS ]] L["Level text typeface options"] = "Level text typeface options"
--[[ enUS ]] L["Font"] = "Font"
--[[ enUS ]] L["Sets the font for level text"] = "Sets the font for level text"
--[[ enUS ]] L["Font Size"] = "Font Size"
--[[ enUS ]] L["Sets the font height of the level text"] = "Sets the font height of the level text"
--[[ enUS ]] L["Font Shadow"] = "Font Shadow"
--[[ enUS ]] L["Show font shadow on level text"] = "Show font shadow on level text"
--[[ enUS ]] L["Outline"] = "Outline"
--[[ enUS ]] L["Sets the font outline of the level text"] = "Sets the font outline of the level text"

--[[ enUS ]] L["Position"] = "Position"
--[[ enUS ]] L["Adjust level text position"] = "Adjust level text position"
--[[ enUS ]] L["Anchor"] = "Anchor"
--[[ enUS ]] L["Sets the anchor for the level text"] = "Sets the anchor for the level text"
--[[ enUS ]] L["Anchor To"] = "Anchor To"
--[[ enUS ]] L["Sets the relative point on the health bar to anchor the level text"] = "Sets the relative point on the health bar to anchor the level text"
--[[ enUS ]] L["X Offset"] = "X Offset"
--[[ enUS ]] L["X offset of the level text"] = "X offset of the level text"
--[[ enUS ]] L["Y Offset"] = "Y Offset"
--[[ enUS ]] L["Y offset of the level text"] = "Y offset of the level text"

--[[ enUS ]] L["None"] = "None"
--[[ enUS ]] L["Normal"] = "Normal"
--[[ enUS ]] L["Thick"] = "Thick"

--[[ enUS ]] L["Advanced"] = "Advanced"
--[[ enUS ]] L["Options for expert users"] = "Options for expert users"
--[[ enUS ]] L["Override Text"] = "Override Text"
--[[ enUS ]] L["Override level text"] = "Override level text"
--[[ enUS ]] L["Format"] = "Format"
--[[ enUS ]] L["Level tag"] = "Level tag"
--[[ enUS ]] L["<Any tag string>"] = "<Any tag string>"

--[[ enUS ]] L["TOPLEFT"] = "TOPLEFT"
--[[ enUS ]] L["TOP"] = "TOP"
--[[ enUS ]] L["TOPRIGHT"] = "TOPRIGHT"
--[[ enUS ]] L["LEFT"] = "LEFT"
--[[ enUS ]] L["CENTER"] = "CENTER"
--[[ enUS ]] L["RIGHT"] = "RIGHT"
--[[ enUS ]] L["BOTTOMLEFT"] = "BOTTOMLEFT"
--[[ enUS ]] L["BOTTOM"] = "BOTTOM"
--[[ enUS ]] L["BOTTOMRIGHT"] = "BOTTOMRIGHT"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

--[[ koKR ]] L["Level Text"] = "레벨"
--[[ koKR ]] L["Level text options"] = "레벨 설정"
--[[ koKR ]] L["Enable"] = "사용"
--[[ koKR ]] L["Enable level text display on the nameplate"] = "이름표에 레벨을 표시합니다."

--[[ koKR ]] L["Show Creature Type"] = "몹 종류 표시"
--[[ koKR ]] L["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = "야수, 악마, 용족, 정령, 인간형 및 언데드등의 몹 종류를 B,D,K,E,H,U등으로 표시합니다."

--[[ koKR ]] L["Show Classification"] = "구분 표시"
--[[ koKR ]] L["Shows +,r,b for elite, rare and bosses after the level"] = "레벨 뒤에 정예, 희귀, 보스등을 +, r, b 로 표시합니다."
--[[ koKR ]] L["Show Race"] = "종족 표시"
--[[ koKR ]] L["Shows unit race after the level"] = "레벨 뒤에 대상의 종족을 표시합니다."

--[[ koKR ]] L["Typeface"] = "서체"
--[[ koKR ]] L["Level text typeface options"] = "레벨 서체 설정"
--[[ koKR ]] L["Font"] = "글꼴"
--[[ koKR ]] L["Sets the font for level text"] = "레벨의 글꼴을 설정합니다."
--[[ koKR ]] L["Font Size"] = "글꼴 크기"
--[[ koKR ]] L["Sets the font height of the level text"] = "레벨의 글자 높이를 설정합니다."
--[[ koKR ]] L["Font Shadow"] = "글꼴 그림자"
--[[ koKR ]] L["Show font shadow on level text"] = "레벨에 그림자를 표시합니다."
--[[ koKR ]] L["Outline"] = "테두리"
--[[ koKR ]] L["Sets the font outline of the level text"] = "레벨의 글자에 테두리를 설정합니다."

--[[ koKR ]] L["Position"] = "위치"
--[[ koKR ]] L["Adjust level text position"] = "레벨 위치 조절"
--[[ koKR ]] L["Anchor"] = "앵커"
--[[ koKR ]] L["Sets the anchor for the level text"] = "레벨의 앵커를 설정합니다."
--[[ koKR ]] L["Anchor To"] = "앵커 위치"
--[[ koKR ]] L["Sets the relative point on the health bar to anchor the level text"] = "생명력 바에서 레벨의 앵커 위치를 설정합니다."
--[[ koKR ]] L["X Offset"] = "X 좌표"
--[[ koKR ]] L["X offset of the level text"] = "레벨의 X 좌표 입니다."
--[[ koKR ]] L["Y Offset"] = "Y 좌표"
--[[ koKR ]] L["Y offset of the level text"] = "레벨의 Y 좌표 입니다."

--[[ koKR ]] L["None"] = "없음"
--[[ koKR ]] L["Normal"] = "기본"
--[[ koKR ]] L["Thick"] = "굵게"

--[[ koKR ]] L["Advanced"] = "고급"
--[[ koKR ]] L["Options for expert users"] = "고급 사용자를 위한 설정입니다."
--[[ koKR ]] L["Override Text"] = "텍스트 오버라이드"
--[[ koKR ]] L["Override level text"] = "레벨 텍스트 오버라이드"
--[[ koKR ]] L["Format"] = "형식"
--[[ koKR ]] L["Level tag"] = "레벨 태그"
--[[ koKR ]] L["<Any tag string>"] = "<태그 문자열>"

--[[ koKR ]] L["TOPLEFT"] = "좌측 상단"
--[[ koKR ]] L["TOP"] = "상단"
--[[ koKR ]] L["TOPRIGHT"] = "우측 상단"
--[[ koKR ]] L["LEFT"] = "좌측"
--[[ koKR ]] L["CENTER"] = "가운데"
--[[ koKR ]] L["RIGHT"] = "우측"
--[[ koKR ]] L["BOTTOMLEFT"] = "좌측 하단"
--[[ koKR ]] L["BOTTOM"] = "하단"
--[[ koKR ]] L["BOTTOMRIGHT"] = "우측 하단"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

--[[ ruRU ]] L["Level Text"] = "Текст уровня"
--[[ ruRU ]] L["Level text options"] = "Настройки текста уровня"
--[[ ruRU ]] L["Enable"] = "Включить"
--[[ ruRU ]] L["Enable level text display on the nameplate"] = "Включить текст уровня на табличке"

--[[ ruRU ]] L["Show Creature Type"] = "Отображать тип существа"
--[[ ruRU ]] L["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = "Отображает З,Д,Э,В,Н для Зверей(З), Демонов(Д), Драконов(Д), Элементалей(Э), Гуманоидов(Г) и Нежити(Н)"

--[[ ruRU ]] L["Show Classification"] = "Отображать классификацию"
--[[ ruRU ]] L["Shows +,r,b for elite, rare and bosses after the level"] = "Отображает +,п,б для элитных, редких и боссов за уровнем"
--[[ ruRU ]] L["Show Race"] = "Отображать расу"
--[[ ruRU ]] L["Shows unit race after the level"] = "Отображает расу за уровнем"

--[[ ruRU ]] L["Typeface"] = "Шрифт"
--[[ ruRU ]] L["Level text typeface options"] = "Настройки шрифта текста уровня"
--[[ ruRU ]] L["Font"] = "Шрифт"
--[[ ruRU ]] L["Sets the font for level text"] = "Задает шрифт для текста уровня"
--[[ ruRU ]] L["Font Size"] = "Размер шрифта"
--[[ ruRU ]] L["Sets the font height of the level text"] = "Задает высоту шрифта для текста уровня"
--[[ ruRU ]] L["Font Shadow"] = "Тень шрифта"
--[[ ruRU ]] L["Show font shadow on level text"] = "Отображать тень для текста уровня"
--[[ ruRU ]] L["Outline"] = "Контур"
--[[ ruRU ]] L["Sets the font outline of the level text"] = "Задает окантовку для текста уровня"

--[[ ruRU ]] L["Position"] = "Позиция"
--[[ ruRU ]] L["Adjust level text position"] = "Задать место текста уровня"
--[[ ruRU ]] L["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] L["Sets the anchor for the level text"] = "Задает прикрепление текста уровня"
--[[ ruRU ]] L["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] L["Sets the relative point on the health bar to anchor the level text"] = "Задает точку для положения текста уровня относительно полоски здоровья"
--[[ ruRU ]] L["X Offset"] = "Смещение по X"
--[[ ruRU ]] L["X offset of the level text"] = "Смещение текста уровня по X"
--[[ ruRU ]] L["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] L["Y offset of the level text"] = "Смещение текста уровня по Y"

--[[ ruRU ]] L["None"] = "Нет"
--[[ ruRU ]] L["Normal"] = "Обычно"
--[[ ruRU ]] L["Thick"] = "Жирный"

--[[ ruRU ]] L["Advanced"] = "Дополнительно"
--[[ ruRU ]] L["Options for expert users"] = "Настройки для опытных пользователей"
--[[ ruRU ]] L["Override Text"] = "Перезапись текста"
--[[ ruRU ]] L["Override level text"] = "Перезапись текста уровня"
--[[ ruRU ]] L["Format"] = "Формат"
--[[ ruRU ]] L["Level tag"] = "Вид уровня"
--[[ ruRU ]] L["<Any tag string>"] = "<Любая строка формата>"

--[[ ruRU ]] L["TOPLEFT"] = "ВВЕРХУ-СЛЕВА"
--[[ ruRU ]] L["TOP"] = "ВВЕРХУ"
--[[ ruRU ]] L["TOPRIGHT"] = "ВВЕРХУ-СПРАВА"
--[[ ruRU ]] L["LEFT"] = "СЛЕВА"
--[[ ruRU ]] L["CENTER"] = "ПО ЦЕНТРУ"
--[[ ruRU ]] L["RIGHT"] = "СПРАВА"
--[[ ruRU ]] L["BOTTOMLEFT"] = "СНИЗУ-СЛЕВА"
--[[ ruRU ]] L["BOTTOM"] = "СНИЗУ"
--[[ ruRU ]] L["BOTTOMRIGHT"] = "СНИЗУ-СПРАВА"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

--[[ zhCN ]] L["Level Text"] = "等级文字"
--[[ zhCN ]] L["Level text options"] = "等级文字相关设置"
--[[ zhCN ]] L["Enable"] = "启用"
--[[ zhCN ]] L["Enable level text display on the nameplate"] = "在姓名板上显示等级文字"

--[[ zhCN ]] L["Show Creature Type"] = "显示生物类型"
--[[ zhCN ]] L["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = "使用生物类型缩写"

--[[ zhCN ]] L["Show Classification"] = "显示分类"
--[[ zhCN ]] L["Shows +,r,b for elite, rare and bosses after the level"] = "使用分类缩写"
--[[ zhCN ]] L["Show Race"] = "显示种族"
--[[ zhCN ]] L["Shows unit race after the level"] = "将种族名称显示在等级之后"

--[[ zhCN ]] L["Typeface"] = "式样"
--[[ zhCN ]] L["Level text typeface options"] = "等级文字式样设置"
--[[ zhCN ]] L["Font"] = "字体"
--[[ zhCN ]] L["Sets the font for level text"] = "设定等级文字的字体"
--[[ zhCN ]] L["Font Size"] = "字号"
--[[ zhCN ]] L["Sets the font height of the level text"] = "设定等级文字的字号"
--[[ zhCN ]] L["Font Shadow"] = "字体阴影"
--[[ zhCN ]] L["Show font shadow on level text"] = "设定等级文字的字体阴影"
--[[ zhCN ]] L["Outline"] = "轮廓"
--[[ zhCN ]] L["Sets the font outline of the level text"] = "设定等级文字的字体轮廓"

--[[ zhCN ]] L["Position"] = "位置"
--[[ zhCN ]] L["Adjust level text position"] = "调整等級文字的位置"
--[[ zhCN ]] L["Anchor"] = "锚点"
--[[ zhCN ]] L["Sets the anchor for the level text"] = "设定等级文字的锚点"
--[[ zhCN ]] L["Anchor To"] = "固定在"
--[[ zhCN ]] L["Sets the relative point on the health bar to anchor the level text"] = "设定等級文字固定在生命值显示条的相对位置"
--[[ zhCN ]] L["X Offset"] = "X轴偏移"
--[[ zhCN ]] L["X offset of the level text"] = "等级文字的X轴偏移量"
--[[ zhCN ]] L["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] L["Y offset of the level text"] = "等级文字的Y轴偏移量"

--[[ zhCN ]] L["None"] = "无"
--[[ zhCN ]] L["Normal"] = "正常"
--[[ zhCN ]] L["Thick"] = "粗"

--[[ zhCN ]] L["Advanced"] = "高级"
--[[ zhCN ]] L["Options for expert users"] = "高级设置"
--[[ zhCN ]] L["Override Text"] = "置换文字"
--[[ zhCN ]] L["Override level text"] = "置换等级文字"
--[[ zhCN ]] L["Format"] = "格式"
--[[ zhCN ]] L["Level tag"] = "等级标签"
--[[ zhCN ]] L["<Any tag string>"] = "<任意标签文字>"

--[[ zhCN ]] L["TOPLEFT"] = "左上"
--[[ zhCN ]] L["TOP"] = "上"
--[[ zhCN ]] L["TOPRIGHT"] = "右上"
--[[ zhCN ]] L["LEFT"] = "左"
--[[ zhCN ]] L["CENTER"] = "中"
--[[ zhCN ]] L["RIGHT"] = "右"
--[[ zhCN ]] L["BOTTOMLEFT"] = "左下"
--[[ zhCN ]] L["BOTTOM"] = "下"
--[[ zhCN ]] L["BOTTOMRIGHT"] = "右下"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

--[[ zhTW ]] L["Level Text"] = "等級文字"
--[[ zhTW ]] L["Level text options"] = "等級文字設定"
--[[ zhTW ]] L["Enable"] = "啟用"
--[[ zhTW ]] L["Enable level text display on the nameplate"] = "啟用在名牌上等級文字顯示"

--[[ zhTW ]] L["Show Creature Type"] = "顯示生物類型"
--[[ zhTW ]] L["Shows B,D,K,E,H,U for Beast, Demon, Dragonkin, Elemental, Humanoid and Undead creatures"] = "使用簡短生物類型"

--[[ zhTW ]] L["Show Classification"] = "顯示分類"
--[[ zhTW ]] L["Shows +,r,b for elite, rare and bosses after the level"] = "使用簡短分類"
--[[ zhTW ]] L["Show Race"] = "顯示種族"
--[[ zhTW ]] L["Shows unit race after the level"] = "顯示種族於等級文字之後"

--[[ zhTW ]] L["Typeface"] = "字體"
--[[ zhTW ]] L["Level text typeface options"] = "等級文字字體設定"
--[[ zhTW ]] L["Font"] = "字型"
--[[ zhTW ]] L["Sets the font for level text"] = "設定等級文字的字型"
--[[ zhTW ]] L["Font Size"] = "字型大小"
--[[ zhTW ]] L["Sets the font height of the level text"] = "設定等級文字的字型高度"
--[[ zhTW ]] L["Font Shadow"] = "字型陰影"
--[[ zhTW ]] L["Show font shadow on level text"] = "設定等級文字的字型陰影"
--[[ zhTW ]] L["Outline"] = "輪廓"
--[[ zhTW ]] L["Sets the font outline of the level text"] = "設定等級文字的字型輪廓"

--[[ zhTW ]] L["Position"] = "位置"
--[[ zhTW ]] L["Adjust level text position"] = "調整等級文字位置"
--[[ zhTW ]] L["Anchor"] = "錨點"
--[[ zhTW ]] L["Sets the anchor for the level text"] = "設定等級文字的錨點"
--[[ zhTW ]] L["Anchor To"] = "錨點到"
--[[ zhTW ]] L["Sets the relative point on the health bar to anchor the level text"] = "設定在生命條上瞄到等級文字的相關點"
--[[ zhTW ]] L["X Offset"] = "X偏移"
--[[ zhTW ]] L["X offset of the level text"] = "等級文字的X偏移"
--[[ zhTW ]] L["Y Offset"] = "Y偏移"
--[[ zhTW ]] L["Y offset of the level text"] = "等級文字的Y偏移"

--[[ zhTW ]] L["None"] = "無"
--[[ zhTW ]] L["Normal"] = "正常"
--[[ zhTW ]] L["Thick"] = "粗"

--[[ zhTW ]] L["Advanced"] = "進階"
--[[ zhTW ]] L["Options for expert users"] = "熟練的使用者設定"
--[[ zhTW ]] L["Override Text"] = "覆蓋文字"
--[[ zhTW ]] L["Override level text"] = "覆蓋等級文字"
--[[ zhTW ]] L["Format"] = "格式"
--[[ zhTW ]] L["Level tag"] = "等級標籤"
--[[ zhTW ]] L["<Any tag string>"] = "<任何標籤文字>"

--[[ zhTW ]] L["TOPLEFT"] = "上左"
--[[ zhTW ]] L["TOP"] = "上"
--[[ zhTW ]] L["TOPRIGHT"] = "上右"
--[[ zhTW ]] L["LEFT"] = "左"
--[[ zhTW ]] L["CENTER"] = "中"
--[[ zhTW ]] L["RIGHT"] = "右"
--[[ zhTW ]] L["BOTTOMLEFT"] = "下左"
--[[ zhTW ]] L["BOTTOM"] = "下"
--[[ zhTW ]] L["BOTTOMRIGHT"] = "下右"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftLevelText = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil