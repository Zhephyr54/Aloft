local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Name Text"] = "Name Text"
--[[ enUS ]] L["Nameplate text options"] = "Nameplate text options"
--[[ enUS ]] L["Enable"] = "Enable"
--[[ enUS ]] L["Show unit names"] = "Show unit names"

--[[ enUS ]] L["Use Aliases"] = "Use Aliases"
--[[ enUS ]] L["Uses user defined aliases"] = "Uses user defined aliases"

--[[ enUS ]] L["Set Alias"] = "Set Alias"
--[[ enUS ]] L["Sets the alias for your current target. An empty alias will return the unit to its original name"] = "Sets the alias for your current target. An empty alias will return the unit to its original name"
--[[ enUS ]] L["<Any String>"] = "<Any String>"

--[[ enUS ]] L["Typeface"] = "Typeface"
--[[ enUS ]] L["Nameplate text typeface options"] = "Nameplate text typeface options"
--[[ enUS ]] L["Font"] = "Font"
--[[ enUS ]] L["Sets the font for nameplate text"] = "Sets the font for nameplate text"
--[[ enUS ]] L["Font Shadow"] = "Font Shadow"
--[[ enUS ]] L["Show font shadow on nameplate text"] = "Show font shadow on nameplate text"
--[[ enUS ]] L["Font Size"] = "Font Size"
--[[ enUS ]] L["Sets the font height of the nameplate text"] = "Sets the font height of the nameplate text"
--[[ enUS ]] L["Outline"] = "Outline"
--[[ enUS ]] L["Sets the font outline for nameplate text"] = "Sets the font outline for nameplate text"

--[[ enUS ]] L["Alignment"] = "Alignment"
--[[ enUS ]] L["Sets the alignment of the nameplate text"] = "Sets the alignment of the nameplate text"

--[[ enUS ]] L["Position"] = "Position"
--[[ enUS ]] L["Adjust nameplate text position"] = "Adjust nameplate text position"
--[[ enUS ]] L["Left Offset"] = "Left Offset"
--[[ enUS ]] L["Sets the offset of the left of the text"] = "Sets the offset of the left of the text"
--[[ enUS ]] L["Right Offset"] = "Right Offset"
--[[ enUS ]] L["Sets the offset of the right of the text"] = "Sets the offset of the right of the text"
--[[ enUS ]] L["Vertical Offset"] = "Vertical Offset"
--[[ enUS ]] L["Sets the vertical offset of the text"] = "Sets the vertical offset of the text"

--[[ enUS ]] L["Override Colors"] = "Override Colors"
--[[ enUS ]] L["Override the games colors for nameplate text"] = "Override the games colors for nameplate text"
--[[ enUS ]] L["Colors"] = "Colors"
--[[ enUS ]] L["Customize colors"] = "Customize colors"

--[[ enUS ]] L["Color by Class"] = "Color by Class"
--[[ enUS ]] L["Sets the name text color according to class"] = "Sets the name text color according to class"
--[[ enUS ]] L["Color Hostile by Class"] = "Color Hostile by Class"
--[[ enUS ]] L["Sets the name text color of hostile players according to class"] = "Sets the name text color of hostile players according to class"
--[[ enUS ]] L["Set All"] = "Set All"
--[[ enUS ]] L["Sets the name text color for all types"] = "Sets the name text color for all types"
--[[ enUS ]] L["Set All Friendly"] = "Set All Friendly"
--[[ enUS ]] L["Sets the name text color for all friendly types"] = "Sets the name text color for all friendly types"
--[[ enUS ]] L["Set All Hostile"] = "Set All Hostile"
--[[ enUS ]] L["Sets the name text color for all hostile types"] = "Sets the name text color for all hostile types"

--[[ enUS ]] L["Pet"] = "Pet"
--[[ enUS ]] L["Sets the name text color for your pet"] = "Sets the name text color for your pet"
--[[ enUS ]] L["Friendly Players"] = "Friendly Players"
--[[ enUS ]] L["Sets the name text color for friendly players"] = "Sets the name text color for friendly players"
--[[ enUS ]] L["Friendly Pets"] = "Friendly Pets"
--[[ enUS ]] L["Sets the name text color for friendly pets"] = "Sets the name text color for friendly pets"
--[[ enUS ]] L["Friendly NPCs"] = "Friendly NPCs"
--[[ enUS ]] L["Sets the name text color for friendly NPC Bosses"] = "Sets the name text color for friendly NPC Bosses"
--[[ enUS ]] L["Friendly Boss"] = "Friendly Boss"
--[[ enUS ]] L["Sets the name text color for friendly NPCs"] = "Sets the name text color for friendly NPCs"
--[[ enUS ]] L["Hostile Players"] = "Hostile Players"
--[[ enUS ]] L["Sets the name text color for hostile players"] = "Sets the name text color for hostile players"
--[[ enUS ]] L["Hostile Pets"] = "Hostile Pets"
--[[ enUS ]] L["Sets the name text color for hostile pets"] = "Sets the name text color for hostile pets"
--[[ enUS ]] L["Hostile NPCs"] = "Hostile NPCs"
--[[ enUS ]] L["Sets the name text color for hostile units"] = "Sets the name text color for hostile units"
--[[ enUS ]] L["Hostile Boss"] = "Hostile Boss"
--[[ enUS ]] L["Sets the name text color for hostile boss units"] = "Sets the name text color for hostile boss units"
--[[ enUS ]] L["Neutral Units"] = "Neutral Units"
--[[ enUS ]] L["Sets the name text color for neutral units"] = "Sets the name text color for neutral units"
--[[ enUS ]] L["Group Pets"] = "Group Pets"
--[[ enUS ]] L["Sets the name text color for group pets"] = "Sets the name text color for group pets"

--[[ enUS ]] L["None"] = "None"
--[[ enUS ]] L["Normal"] = "Normal"
--[[ enUS ]] L["Thick"] = "Thick"

--[[ enUS ]] L["Advanced"] = "Advanced"
--[[ enUS ]] L["Options for expert users"] = "Options for expert users"
--[[ enUS ]] L["Format"] = "Format"
--[[ enUS ]] L["Name tag"] = "Name tag"
--[[ enUS ]] L["<Any tag string>"] = "<Any tag string>"

--[[ enUS ]] L["LEFT"] = "LEFT"
--[[ enUS ]] L["CENTER"] = "CENTER"
--[[ enUS ]] L["RIGHT"] = "RIGHT"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Name Text"] = "이름"
--[[ koKR ]] L["Nameplate text options"] = "이름 설정"
--[[ koKR ]] L["Enable"] = "사용"
--[[ koKR ]] L["Show unit names"] = "대상의 이름을 표시합니다."

--[[ koKR ]] L["Use Aliases"] = "별명 사용"
--[[ koKR ]] L["Uses user defined aliases"] = "사용자가 지정한 별명을 사용합니다."

--[[ koKR ]] L["Set Alias"] = "별명 설정"
--[[ koKR ]] L["Sets the alias for your current target. An empty alias will return the unit to its original name"] = "현재 대상에 대한 별명을 설정합니다. 빈칸으로 두면 대상의 실제 이름을 반환합니다."
--[[ koKR ]] L["<Any String>"] = "<문자열>"

--[[ koKR ]] L["Typeface"] = "서체"
--[[ koKR ]] L["Nameplate text typeface options"] = "이름 서체 설정"
--[[ koKR ]] L["Font"] = "글꼴"
--[[ koKR ]] L["Sets the font for nameplate text"] = "이름의 글꼴을 설정합니다."
--[[ koKR ]] L["Font Shadow"] = "글꼴 그림자"
--[[ koKR ]] L["Show font shadow on nameplate text"] = "이름에 그림자를 표시합니다."
--[[ koKR ]] L["Font Size"] = "글꼴 크기"
--[[ koKR ]] L["Sets the font height of the nameplate text"] = "이름의 높이를 설정합니다."
--[[ koKR ]] L["Outline"] = "테두리"
--[[ koKR ]] L["Sets the font outline for nameplate text"] = "이름의 테두리를 설정합니다."

--[[ koKR ]] L["Alignment"] = "정렬"
--[[ koKR ]] L["Sets the alignment of the nameplate text"] = "이름의 정렬을 설정합니다."

--[[ koKR ]] L["Position"] = "위치"
--[[ koKR ]] L["Adjust nameplate text position"] = "이름 위치 조절"
--[[ koKR ]] L["Left Offset"] = "좌측 좌표"
--[[ koKR ]] L["Sets the offset of the left of the text"] = "이름의 좌측 좌표를 설정합니다."
--[[ koKR ]] L["Right Offset"] = "우측 좌표"
--[[ koKR ]] L["Sets the offset of the right of the text"] = "이름의 우측 좌표를 설정합니다."
--[[ koKR ]] L["Vertical Offset"] = "수직 좌표"
--[[ koKR ]] L["Sets the vertical offset of the text"] = "이름의 수직 좌표를 설정합니다."

--[[ koKR ]] L["Override Colors"] = "색상 적용"
--[[ koKR ]] L["Override the games colors for nameplate text"] = "이름에 게임 색상을 적용합니다."
--[[ koKR ]] L["Colors"] = "색상"
--[[ koKR ]] L["Customize colors"] = "사용자 색상"

--[[ koKR ]] L["Color by Class"] = "직업별 색상"
--[[ koKR ]] L["Sets the name text color according to class"] = "이름 색상에 직업별 색상을 설정합니다."
--[[ koKR ]] L["Color Hostile by Class"] = "적대적 직업별 색상"
--[[ koKR ]] L["Sets the name text color of hostile players according to class"] = "적대적 플레이어의 이름에 직업별 색상을 설정합니다."
--[[ koKR ]] L["Set All"] = "전체 설정"
--[[ koKR ]] L["Sets the name text color for all types"] = "모든 이름의 색상을 설정합니다."
--[[ koKR ]] L["Set All Friendly"] = "전체 우호적 설정"
--[[ koKR ]] L["Sets the name text color for all friendly types"] = "전체 우호적 대상에 대한 이름의 색상을 설정합니다."
--[[ koKR ]] L["Set All Hostile"] = "전체 적대적 설정"
--[[ koKR ]] L["Sets the name text color for all hostile types"] = "전체 적대적 대상에 대한 이름의 색상을 설정합니다."

--[[ koKR ]] L["Pet"] = "소환수"
--[[ koKR ]] L["Sets the name text color for your pet"] = "소환수의 이름 색상을 설정합니다."
--[[ koKR ]] L["Friendly Players"] = "우호적 플레이어"
--[[ koKR ]] L["Sets the name text color for friendly players"] = "우호적 플레이어의 이름 색상을 설정합니다."
--[[ koKR ]] L["Friendly Pets"] = "우호적 소환수"
--[[ koKR ]] L["Sets the name text color for friendly pets"] = "우호적 소환수의 이름 색상을 설정합니다."
--[[ koKR ]] L["Friendly NPCs"] = "우호적 NPC"
--[[ koKR ]] L["Sets the name text color for friendly NPC Bosses"] = "우호적 NPC 보스의 이름 색상을 설정합니다."
--[[ koKR ]] L["Friendly Boss"] = "우호적 보스"
--[[ koKR ]] L["Sets the name text color for friendly NPCs"] = "우호적 NPC의 이름 색상을 설정합니다."
--[[ koKR ]] L["Hostile Players"] = "적대적 플레이어"
--[[ koKR ]] L["Sets the name text color for hostile players"] = "적대적 플레이어의 이름 색상을 설정합니다."
--[[ koKR ]] L["Hostile Pets"] = "적대적 소환수"
--[[ koKR ]] L["Sets the name text color for hostile pets"] = "적대적 소환수의 이름 색상을 설정합니다."
--[[ koKR ]] L["Hostile NPCs"] = "적대적 NPC"
--[[ koKR ]] L["Sets the name text color for hostile units"] = "적대적 NPC의 이름 색상을 설정합니다."
--[[ koKR ]] L["Hostile Boss"] = "적대적 보스"
--[[ koKR ]] L["Sets the name text color for hostile boss units"] = "적대적 보스의 이름 색상을 설정합니다."
--[[ koKR ]] L["Neutral Units"] = "중립적 대상"
--[[ koKR ]] L["Sets the name text color for neutral units"] = "중립적 대상의 이름 색상을 설정합니다."
--[[ koKR ]] L["Group Pets"] = "파티 소환수"
--[[ koKR ]] L["Sets the name text color for group pets"] = "파티 소환수의 이름 색상을 설정합니다."

--[[ koKR ]] L["None"] = "없음"
--[[ koKR ]] L["Normal"] = "기본"
--[[ koKR ]] L["Thick"] = "굵게"

--[[ koKR ]] L["Advanced"] = "고급"
--[[ koKR ]] L["Options for expert users"] = "고급 사용자를 위한 설정입니다."
--[[ koKR ]] L["Format"] = "형식"
--[[ koKR ]] L["Name tag"] = "이름 태그"
--[[ koKR ]] L["<Any tag string>"] = "<태그 문자열>"

--[[ koKR ]] L["LEFT"] = "좌측"
--[[ koKR ]] L["CENTER"] = "가운데"
--[[ koKR ]] L["RIGHT"] = "우측"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[  ruRU ]] L["Name Text"] = "Текст имени"
--[[  ruRU ]] L["Nameplate text options"] = "Настройки текста таблички"
--[[  ruRU ]] L["Enable"] = "Включить"
--[[  ruRU ]] L["Show unit names"] = "Отображать имена единиц"

--[[  ruRU ]] L["Use Aliases"] = "Использовать соответствия имен"
--[[  ruRU ]] L["Uses user defined aliases"] = "Соответствия имен, заданные пользователем"

--[[  ruRU ]] L["Set Alias"] = "Задать сокращение"
--[[  ruRU ]] L["Sets the alias for your current target. An empty alias will return the unit to its original name"] = "Задает сокращение для текущей цели. Пустое сокращение вернет цели изначальное имя"
--[[  ruRU ]] L["<Any String>"] = "<Любая строка>"

--[[  ruRU ]] L["Typeface"] = "Шрифт"
--[[  ruRU ]] L["Nameplate text typeface options"] = "Настройки шрифта таблички"
--[[  ruRU ]] L["Font"] = "Шрифт"
--[[  ruRU ]] L["Sets the font for nameplate text"] = "Задает шрифт для текста на табличках"
--[[  ruRU ]] L["Font Shadow"] = "Тень шрифта"
--[[  ruRU ]] L["Show font shadow on nameplate text"] = "Отображать тень для текста на табличке"
--[[  ruRU ]] L["Font Size"] = "Размер шрифта"
--[[  ruRU ]] L["Sets the font height of the nameplate text"] = "Задает высоту шрифта для текста на табличке"
--[[  ruRU ]] L["Outline"] = "Контур"
--[[  ruRU ]] L["Sets the font outline for nameplate text"] = "Задает окантовку для текста на табличке"

--[[  ruRU ]] L["Alignment"] = "Выравнивание"
--[[  ruRU ]] L["Sets the alignment of the nameplate text"] = "Задает выравнивание текста на табличке"

--[[  ruRU ]] L["Position"] = "Позиция"
--[[  ruRU ]] L["Adjust nameplate text position"] = "Задать место текста на табличке"
--[[  ruRU ]] L["Left Offset"] = "Левое смещение"
--[[  ruRU ]] L["Sets the offset of the left of the text"] = "Задает смещение левого конца текста"
--[[  ruRU ]] L["Right Offset"] = "Правое смещение"
--[[  ruRU ]] L["Sets the offset of the right of the text"] = "Задает смещение правого конца текста"
--[[  ruRU ]] L["Vertical Offset"] = "Вертикальное смещение"
--[[  ruRU ]] L["Sets the vertical offset of the text"] = "Задает вертикальное смещение текста"

--[[  ruRU ]] L["Override Colors"] = "Перезапись цветов"
--[[  ruRU ]] L["Override the games colors for nameplate text"] = "Перезапись цветов игры для текста табличек"
--[[  ruRU ]] L["Colors"] = "Цвета"
--[[  ruRU ]] L["Customize colors"] = "Настройка цветов"

--[[  ruRU ]] L["Color by Class"] = "Окрашивать в цвет класса"
--[[  ruRU ]] L["Sets the name text color according to class"] = "Задает цвет имени в зависимости от класса"
--[[  ruRU ]] L["Color Hostile by Class"] = "Окрашивать враждебных в цвет класса"
--[[  ruRU ]] L["Sets the name text color of hostile players according to class"] = "Задает цвет имени враждебного игрока в зависимости от класс"
--[[  ruRU ]] L["Set All"] = "Задать все"
--[[  ruRU ]] L["Sets the name text color for all types"] = "Задает цвет имени для всех типов"
--[[  ruRU ]] L["Set All Friendly"] = "Задать всех дружественными"
--[[  ruRU ]] L["Sets the name text color for all friendly types"] = "Задает цвет имени для всех дружественных типов"
--[[  ruRU ]] L["Set All Hostile"] = "Задать всех враждебными"
--[[  ruRU ]] L["Sets the name text color for all hostile types"] = "Задает цвет имени для всех враждебных типов"

--[[  ruRU ]] L["Pet"] = "Питомец"
--[[  ruRU ]] L["Sets the name text color for your pet"] = "Задает цвет имени для вашего питомца"
--[[  ruRU ]] L["Friendly Players"] = "Дружественные игроки"
--[[  ruRU ]] L["Sets the name text color for friendly players"] = "Задает цвет имени для дружественных игроков"
--[[  ruRU ]] L["Friendly Pets"] = "Дружественные питомцы"
--[[  ruRU ]] L["Sets the name text color for friendly pets"] = "Задает цвет имени для дружественных питомцев"
--[[  ruRU ]] L["Friendly NPCs"] = "Дружественные НИПы"
--[[  ruRU ]] L["Sets the name text color for friendly NPC Bosses"] = "Задает цвет имени для дружественных НИПов - боссов"
--[[  ruRU ]] L["Friendly Boss"] = "Дружественный босс"
--[[  ruRU ]] L["Sets the name text color for friendly NPCs"] = "Задает цвет имени для дружественных НИПов"
--[[  ruRU ]] L["Hostile Players"] = "Враждебные игроки"
--[[  ruRU ]] L["Sets the name text color for hostile players"] = "Задает цвет имени для враждебных игроков"
--[[  ruRU ]] L["Hostile Pets"] = "Враждебные питомцы"
--[[  ruRU ]] L["Sets the name text color for hostile pets"] = "Задает цвет имени для враждебных питомцев"
--[[  ruRU ]] L["Hostile NPCs"] = "Враждебные НИПы"
--[[  ruRU ]] L["Sets the name text color for hostile units"] = "Задает цвет имени для враждебных объектов"
--[[  ruRU ]] L["Hostile Boss"] = "Враждебный босс"
--[[  ruRU ]] L["Sets the name text color for hostile boss units"] = "Задает цвет имени для враждебных боссов"
--[[  ruRU ]] L["Neutral Units"] = "Нейтральные цели"
--[[  ruRU ]] L["Sets the name text color for neutral units"] = "Задает цвет имени для нейтральных"
--[[  ruRU ]] L["Group Pets"] = "Питомцы группы"
--[[  ruRU ]] L["Sets the name text color for group pets"] = "Задает цвет имен для питомцев группы"

--[[  ruRU ]] L["None"] = "Нет"
--[[  ruRU ]] L["Normal"] = "Обычно"
--[[  ruRU ]] L["Thick"] = "Жирный"

--[[  ruRU ]] L["Advanced"] = "Дополнительно"
--[[  ruRU ]] L["Options for expert users"] = "Настройки для опытных пользователей"
--[[  ruRU ]] L["Format"] = "Формат"
--[[  ruRU ]] L["Name tag"] = "Вид имени"
--[[  ruRU ]] L["<Any tag string>"] = "<Любая строка формата>"

--[[  ruRU ]] L["LEFT"] = "СЛЕВА"
--[[  ruRU ]] L["CENTER"] = "ПО ЦЕНТРУ"
--[[  ruRU ]] L["RIGHT"] = "СПРАВА"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[  zhCN ]] L["Name Text"] = "名称文字"
--[[  zhCN ]] L["Nameplate text options"] = "姓名板文字相关设置"
--[[  zhCN ]] L["Enable"] = "启用"
--[[  zhCN ]] L["Show unit names"] = "显示单位名称"

--[[  zhCN ]] L["Use Aliases"] = "使用绰号"
--[[  zhCN ]] L["Uses user defined aliases"] = "使用自定义绰号"

--[[  zhCN ]] L["Set Alias"] = "设定绰号"
--[[  zhCN ]] L["Sets the alias for your current target. An empty alias will return the unit to its original name"] = "设定当前目标的绰号。如果留空则会重置为目标的原有名称"
--[[  zhCN ]] L["<Any String>"] = "<任意文字>"

--[[  zhCN ]] L["Typeface"] = "式样"
--[[  zhCN ]] L["Nameplate text typeface options"] = "姓名板文字式样设置"
--[[  zhCN ]] L["Font"] = "字体"
--[[  zhCN ]] L["Sets the font for nameplate text"] = "设定姓名板文字的字体"
--[[  zhCN ]] L["Font Shadow"] = "字体阴影"
--[[  zhCN ]] L["Show font shadow on nameplate text"] = "在姓名板文字上显示字体阴影"
--[[  zhCN ]] L["Font Size"] = "字号"
--[[  zhCN ]] L["Sets the font height of the nameplate text"] = "设定姓名板文字的字号"
--[[  zhCN ]] L["Outline"] = "轮廓"
--[[  zhCN ]] L["Sets the font outline for nameplate text"] = "设定姓名板文字的轮廓"

--[[  zhCN ]] L["Alignment"] = "对齐"
--[[  zhCN ]] L["Sets the alignment of the nameplate text"] = "设定姓名板文字的对齐样式"

--[[  zhCN ]] L["Position"] = "位置"
--[[  zhCN ]] L["Adjust nameplate text position"] = "调整姓名板文字的位置"
--[[  zhCN ]] L["Left Offset"] = "向左偏移"
--[[  zhCN ]] L["Sets the offset of the left of the text"] = "设定文字的向左偏移量"
--[[  zhCN ]] L["Right Offset"] = "向右偏移"
--[[  zhCN ]] L["Sets the offset of the right of the text"] = "设定文字的向右偏移量"
--[[  zhCN ]] L["Vertical Offset"] = "垂直偏移"
--[[  zhCN ]] L["Sets the vertical offset of the text"] = "设定文字的垂直偏移量"

--[[  zhCN ]] L["Override Colors"] = "置换颜色"
--[[  zhCN ]] L["Override the games colors for nameplate text"] = "置换姓名板文字的游戏内颜色"
--[[  zhCN ]] L["Colors"] = "颜色"
--[[  zhCN ]] L["Customize colors"] = "自定义颜色"

--[[  zhCN ]] L["Color by Class"] = "根据职业显示颜色"
--[[  zhCN ]] L["Sets the name text color according to class"] = "名称文字颜色使用职业代表色"
--[[  zhCN ]] L["Color Hostile by Class"] = "敌对方单位根据职业显示颜色"
--[[  zhCN ]] L["Sets the name text color of hostile players according to class"] = "敌对方玩家的名称文字颜色使用职业代表色"
--[[  zhCN ]] L["Set All"] = "设定全部"
--[[  zhCN ]] L["Sets the name text color for all types"] = "设定所有单位的名称文字颜色"
--[[  zhCN ]] L["Set All Friendly"] = "设定全部友好方单位"
--[[  zhCN ]] L["Sets the name text color for all friendly types"] = "设定全部友好方单位的名称文字颜色"
--[[  zhCN ]] L["Set All Hostile"] = "设定全部敌对方单位"
--[[  zhCN ]] L["Sets the name text color for all hostile types"] = "设定全部敌对方单位的名称文字颜色"

--[[  zhCN ]] L["Pet"] = "宠物"
--[[  zhCN ]] L["Sets the name text color for your pet"] = "宠物的名称文字颜色"
--[[  zhCN ]] L["Friendly Players"] = "友好方玩家"
--[[  zhCN ]] L["Sets the name text color for friendly players"] = "设定友好方玩家的名称文字颜色"
--[[  zhCN ]] L["Friendly Pets"] = "友好方宠物"
--[[  zhCN ]] L["Sets the name text color for friendly pets"] = "设定友好方宠物的名称文字颜色"
--[[  zhCN ]] L["Friendly NPCs"] = "友好方NPC"
--[[  zhCN ]] L["Sets the name text color for friendly NPC Bosses"] = "设定友好方首领的名称文字颜色"
--[[  zhCN ]] L["Friendly Boss"] = "友好方首领"
--[[  zhCN ]] L["Sets the name text color for friendly NPCs"] = "设定友好方NPC的名称文字颜色"
--[[  zhCN ]] L["Hostile Players"] = "敌对方玩家"
--[[  zhCN ]] L["Sets the name text color for hostile players"] = "设定敌对方玩家的名称文字颜色"
--[[  zhCN ]] L["Hostile Pets"] = "敌对方宠物"
--[[  zhCN ]] L["Sets the name text color for hostile pets"] = "设定敌对方宠物的名称文字颜色"
--[[  zhCN ]] L["Hostile NPCs"] = "敌对方NPC"
--[[  zhCN ]] L["Sets the name text color for hostile units"] = "设定敌对方NPC的名称文字颜色"
--[[  zhCN ]] L["Hostile Boss"] = "敌对方首领"
--[[  zhCN ]] L["Sets the name text color for hostile boss units"] = "设定敌对方首领的名称文字颜色"
--[[  zhCN ]] L["Neutral Units"] = "中立方单位"
--[[  zhCN ]] L["Sets the name text color for neutral units"] = "设定中立方单位的名称文字颜色"
--[[  zhCN ]] L["Group Pets"] = "队友宠物"
--[[  zhCN ]] L["Sets the name text color for group pets"] = "设定队友宠物的名称文字颜色"

--[[  zhCN ]] L["None"] = "无"
--[[  zhCN ]] L["Normal"] = "正常"
--[[  zhCN ]] L["Thick"] = "粗"

--[[  zhCN ]] L["Advanced"] = "高级"
--[[  zhCN ]] L["Options for expert users"] = "高级选项"
--[[  zhCN ]] L["Format"] = "格式"
--[[  zhCN ]] L["Name tag"] = "名称标签"
--[[  zhCN ]] L["<Any tag string>"] = "<任意标签文字>"

--[[  zhCN ]] L["LEFT"] = "左"
--[[  zhCN ]] L["CENTER"] = "中"
--[[  zhCN ]] L["RIGHT"] = "右"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[  zhTW ]] L["Name Text"] = "名稱文字"
--[[  zhTW ]] L["Nameplate text options"] = "名牌文字設定"
--[[  zhTW ]] L["Enable"] = "啟用"
--[[  zhTW ]] L["Show unit names"] = "顯示單位名稱"

--[[  zhTW ]] L["Use Aliases"] = "使用別名"
--[[  zhTW ]] L["Uses user defined aliases"] = "使用自定別名"

--[[  zhTW ]] L["Set Alias"] = "設定別名"
--[[  zhTW ]] L["Sets the alias for your current target. An empty alias will return the unit to its original name"] = "設定目前目標的別名。空的別名會重設回原有名稱"
--[[  zhTW ]] L["<Any String>"] = "<任何文字>"

--[[  zhTW ]] L["Typeface"] = "字體"
--[[  zhTW ]] L["Nameplate text typeface options"] = "名牌文字字體設定"
--[[  zhTW ]] L["Font"] = "字型"
--[[  zhTW ]] L["Sets the font for nameplate text"] = "設定名牌文字的字型"
--[[  zhTW ]] L["Font Shadow"] = "字型陰影"
--[[  zhTW ]] L["Show font shadow on nameplate text"] = "設定名牌文字的字型陰影"
--[[  zhTW ]] L["Font Size"] = "字型大小"
--[[  zhTW ]] L["Sets the font height of the nameplate text"] = "設定名牌文字的字型高度"
--[[  zhTW ]] L["Outline"] = "輪廓"
--[[  zhTW ]] L["Sets the font outline for nameplate text"] = "設定名牌文字的字型輪廓"

--[[  zhTW ]] L["Alignment"] = "對齊"
--[[  zhTW ]] L["Sets the alignment of the nameplate text"] = "設定名牌文字的對齊"

--[[  zhTW ]] L["Position"] = "位置"
--[[  zhTW ]] L["Adjust nameplate text position"] = "調整名牌文字位置"
--[[  zhTW ]] L["Left Offset"] = "左偏移"
--[[  zhTW ]] L["Sets the offset of the left of the text"] = "設定文字的左偏移"
--[[  zhTW ]] L["Right Offset"] = "右偏移"
--[[  zhTW ]] L["Sets the offset of the right of the text"] = "設定文字的右偏移"
--[[  zhTW ]] L["Vertical Offset"] = "垂直偏移"
--[[  zhTW ]] L["Sets the vertical offset of the text"] = "設定文字的垂直偏移"

--[[  zhTW ]] L["Override Colors"] = "覆蓋顏色"
--[[  zhTW ]] L["Override the games colors for nameplate text"] = "覆蓋名牌文字的遊戲顏色"
--[[  zhTW ]] L["Colors"] = "顏色"
--[[  zhTW ]] L["Customize colors"] = "自定顏色"

--[[  zhTW ]] L["Color by Class"] = "著色根據職業"
--[[  zhTW ]] L["Sets the name text color according to class"] = "設定名稱文字顏色根據職業"
--[[  zhTW ]] L["Color Hostile by Class"] = "著色敵對單位根據職業"
--[[  zhTW ]] L["Sets the name text color of hostile players according to class"] = "設定敵對玩家的名稱文字顏色根據職業"
--[[  zhTW ]] L["Set All"] = "設定全部"
--[[  zhTW ]] L["Sets the name text color for all types"] = "設定全部單位的名稱文字顏色"
--[[  zhTW ]] L["Set All Friendly"] = "設定全部友好"
--[[  zhTW ]] L["Sets the name text color for all friendly types"] = "設定全部友好單位的名稱文字顏色"
--[[  zhTW ]] L["Set All Hostile"] = "設定全部敵對"
--[[  zhTW ]] L["Sets the name text color for all hostile types"] = "設定全部敵對單位的名稱文字顏色"

--[[  zhTW ]] L["Pet"] = "寵物"
--[[  zhTW ]] L["Sets the name text color for your pet"] = "設定你的寵物的名稱文字顏色"
--[[  zhTW ]] L["Friendly Players"] = "友好玩家"
--[[  zhTW ]] L["Sets the name text color for friendly players"] = "設定友好玩家的名稱文字顏色"
--[[  zhTW ]] L["Friendly Pets"] = "友好寵物"
--[[  zhTW ]] L["Sets the name text color for friendly pets"] = "設定友好寵物的名稱文字顏色"
--[[  zhTW ]] L["Friendly NPCs"] = "友好NPC"
--[[  zhTW ]] L["Sets the name text color for friendly NPC Bosses"] = "設定友好NPC的名稱文字顏色"
--[[  zhTW ]] L["Friendly Boss"] = "友好首領"
--[[  zhTW ]] L["Sets the name text color for friendly NPCs"] = "設定友好首領的名稱文字顏色"
--[[  zhTW ]] L["Hostile Players"] = "敵對玩家"
--[[  zhTW ]] L["Sets the name text color for hostile players"] = "設定敵對玩家的名稱文字顏色"
--[[  zhTW ]] L["Hostile Pets"] = "敵對寵物"
--[[  zhTW ]] L["Sets the name text color for hostile pets"] = "設定敵對寵物的名稱文字顏色"
--[[  zhTW ]] L["Hostile NPCs"] = "敵對NPC"
--[[  zhTW ]] L["Sets the name text color for hostile units"] = "設定敵對NPC的名稱文字顏色"
--[[  zhTW ]] L["Hostile Boss"] = "敵對玩家"
--[[  zhTW ]] L["Sets the name text color for hostile boss units"] = "設定敵對首領的名稱文字顏色"
--[[  zhTW ]] L["Neutral Units"] = "中立單位"
--[[  zhTW ]] L["Sets the name text color for neutral units"] = "設定中立單位的名稱文字顏色"
--[[  zhTW ]] L["Group Pets"] = "隊伍寵物"
--[[  zhTW ]] L["Sets the name text color for group pets"] = "設定隊伍寵物的名稱文字顏色"

--[[  zhTW ]] L["None"] = "無"
--[[  zhTW ]] L["Normal"] = "正常"
--[[  zhTW ]] L["Thick"] = "粗"

--[[  zhTW ]] L["Advanced"] = "進階"
--[[  zhTW ]] L["Options for expert users"] = "熟練的使用者設定"
--[[  zhTW ]] L["Format"] = "格式"
--[[  zhTW ]] L["Name tag"] = "名稱標籤"
--[[  zhTW ]] L["<Any tag string>"] = "<任何標籤文字>"

--[[  zhTW ]] L["LEFT"] = "左"
--[[  zhTW ]] L["CENTER"] = "中"
--[[  zhTW ]] L["RIGHT"] = "右"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftNameText = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

-----------------------------------------------------------------------------
