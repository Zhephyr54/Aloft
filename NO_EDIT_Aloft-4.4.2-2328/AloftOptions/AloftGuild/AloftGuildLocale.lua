local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

local dL = { }

local tL = { }

local oL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] dL["Save Guild Data"] = "Save Guild Data"
--[[ enUS ]] dL["Stores guild information between sessions"] = "Stores guild information between sessions"

-----------------------------------------------------------------------------

--[[ enUS ]] tL["Guild Text"] = "Guild Text"
--[[ enUS ]] tL["Guild text options"] = "Guild text options"
--[[ enUS ]] tL["Enable"] = "Enable"
--[[ enUS ]] tL["Show guild information on nameplates"] = "Show guild information on nameplates"

--[[ enUS ]] tL["Attach to Name"] = "Attach to Name"
--[[ enUS ]] tL["Attaches guild text to name"] = "Attaches guild text to name"
--[[ enUS ]] tL["Attach Format"] = "Attach Format"
--[[ enUS ]] tL["Selects the text format to use"] = "Selects the text format to use"

--[[ enUS ]] tL["HYPHEN"]	= "Name - Guild"
--[[ enUS ]] tL["SLASH"]	= "Name / Guild"
--[[ enUS ]] tL["BRACKET"]	= "Name (Guild)"
--[[ enUS ]] tL["COLON"]	= "Name : Guild"

--[[ enUS ]] tL["Short"] = "Short"
--[[ enUS ]] tL["Use short guild names"] = "Use short guild names"
--[[ enUS ]] tL["Set Short Name"] = "Set Short Name"
--[[ enUS ]] tL["<Any String>"] = "<Any String>"
--[[ enUS ]] tL["Sets the short name for your current target"] = "Sets the short name for your current target"
--[[ enUS ]] tL["Show Own"] = "Show Own"
--[[ enUS ]] tL["Show the guild names of your own guild members"] = "Show the guild names of your own guild members"

--[[ enUS ]] tL["Typeface"] = "Typeface"
--[[ enUS ]] tL["Guild text typeface options"] = "Guild text typeface options"
--[[ enUS ]] tL["Font"] = "Font"
--[[ enUS ]] tL["Sets the font for guild text"] = "Sets the font for guild text"
--[[ enUS ]] tL["Font Size"] = "Font Size"
--[[ enUS ]] tL["Sets the font height of the guild text"] = "Sets the font height of the guild text"
--[[ enUS ]] tL["Font Shadow"] = "Font Shadow"
--[[ enUS ]] tL["Show font shadow on guild text"] = "Show font shadow on guild text"
--[[ enUS ]] tL["Outline"] = "Outline"
--[[ enUS ]] tL["Sets the outline for guild text"] = "Sets the outline for guild text"

--[[ enUS ]] tL["Position"] = "Position"
--[[ enUS ]] tL["Adjust guild text position"] = "Adjust guild text position"
--[[ enUS ]] tL["Anchor"] = "Anchor"
--[[ enUS ]] tL["Sets the anchor for the guild text"] = "Sets the anchor for the guild text"
--[[ enUS ]] tL["Anchor To"] = "Anchor To"
--[[ enUS ]] tL["Sets the relative point on the health bar to anchor the guild text"] = "Sets the relative point on the health bar to anchor the guild text"
--[[ enUS ]] tL["X Offset"] = "X Offset"
--[[ enUS ]] tL["X offset of the guild text"] = "X offset of the guild text"
--[[ enUS ]] tL["Y Offset"] = "Y Offset"
--[[ enUS ]] tL["Y offset of the guild text"] = "Y offset of the guild text"
--[[ enUS ]] tL["Alpha"] = "Alpha"
--[[ enUS ]] tL["Sets the alpha of the guild text"] = "Sets the alpha of the guild text"
--[[ enUS ]] tL["Color"] = "Color"
--[[ enUS ]] tL["Sets the guild text color"] = "Sets the guild text color"

--[[ enUS ]] tL["None"] = "None"
--[[ enUS ]] tL["Normal"] = "Normal"
--[[ enUS ]] tL["Thick"] = "Thick"

--[[ enUS ]] tL["NoSetShortName"] = "|cffff0000You must have a target to set the short name|r"
--[[ enUS ]] tL["ShortNameAdded"] = "Added |cff00ff00%s|r -> |cff00ff00%s|r"

--[[ enUS ]] tL["Advanced"] = "Advanced"
--[[ enUS ]] tL["Options for expert users"] = "Options for expert users"
--[[ enUS ]] tL["Format"] = "Format"
--[[ enUS ]] tL["Guild tag"] = "Guild tag"
--[[ enUS ]] tL["<Any tag string>"] = "<Any tag string>"

--[[ enUS ]] tL["TOPLEFT"] = "TOPLEFT"
--[[ enUS ]] tL["TOP"] = "TOP"
--[[ enUS ]] tL["TOPRIGHT"] = "TOPRIGHT"
--[[ enUS ]] tL["LEFT"] = "LEFT"
--[[ enUS ]] tL["CENTER"] = "CENTER"
--[[ enUS ]] tL["RIGHT"] = "RIGHT"
--[[ enUS ]] tL["BOTTOMLEFT"] = "BOTTOMLEFT"
--[[ enUS ]] tL["BOTTOM"] = "BOTTOM"
--[[ enUS ]] tL["BOTTOMRIGHT"] = "BOTTOMRIGHT"

-----------------------------------------------------------------------------

--[[ enUS ]] oL["Reset Short Guilds"] = "Reset Short Guilds"
--[[ enUS ]] oL["Empties the custom short guild database"] = "Empties the custom short guild database"

--[[ enUS ]] oL["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = "You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftGuild"] = "AloftGuild"
--[[ enUS ]] mL["Gather and display player guild names on nameplates"] = "Gather and display player guild names on nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

--[[ koKR ]] dL["Save Guild Data"] = "길드 데이터 저장"
--[[ koKR ]] dL["Stores guild information between sessions"] = "접속 간 길드 정보를 저장하니다."

-----------------------------------------------------------------------------

--[[ koKR ]] tL["Guild Text"] = "길드정보"
--[[ koKR ]] tL["Guild text options"] = "길드정보 설정"
--[[ koKR ]] tL["Enable"] = "사용"
--[[ koKR ]] tL["Show guild information on nameplates"] = "이름표에 길드정보를 표시합니다."

--[[ koKR ]] tL["Attach to Name"] = "이름에 첨부"
--[[ koKR ]] tL["Attaches guild text to name"] = "이름에 길드 정보를 추가합니다."
--[[ koKR ]] tL["Attach Format"] = "첨부 형식"
--[[ koKR ]] tL["Selects the text format to use"] = "사용할 정보 형식을 선택합니다."

--[[ koKR ]] tL["HYPHEN"]	= "이름  - 길드"
--[[ koKR ]] tL["SLASH"]	= "이름  / 길드"
--[[ koKR ]] tL["BRACKET"]	= "이름  (길드)"
--[[ koKR ]] tL["COLON"]	= "이름  : 길드"

--[[ koKR ]] tL["Short"] = "간략형"
--[[ koKR ]] tL["Use short guild names"] = "짧은 길드명을 사용합니다."
--[[ koKR ]] tL["Set Short Name"] = "짧은 이름 설정"
--[[ koKR ]] tL["<Any String>"] = "<문자열>"
--[[ koKR ]] tL["Sets the short name for your current target"] = "현재 대상에 대해 짧은 이름을 설정합니다."
--[[ koKR ]] tL["Show Own"] = "자신 표시"
--[[ koKR ]] tL["Show the guild names of your own guild members"] = "길드원의 길드명을 표시합니다."

--[[ koKR ]] tL["Typeface"] = "서체"
--[[ koKR ]] tL["Guild text typeface options"] = "길드정보 서체 설정"
--[[ koKR ]] tL["Font"] = "글꼴"
--[[ koKR ]] tL["Sets the font for guild text"] = "길드 정보의 글꼴을 설정합니다."
--[[ koKR ]] tL["Font Size"] = "글꼴 크기"
--[[ koKR ]] tL["Sets the font height of the guild text"] = "길드 정보 글꼴의 높이를 설정합니다."
--[[ koKR ]] tL["Font Shadow"] = "글꼴 그림자"
--[[ koKR ]] tL["Show font shadow on guild text"] = "길드 정보 글꼴의 그림자를 표시합니다."
--[[ koKR ]] tL["Outline"] = "테두리"
--[[ koKR ]] tL["Sets the outline for guild text"] = "길드 정보에 테두리를 설정합니다."

--[[ koKR ]] tL["Position"] = "위치"
--[[ koKR ]] tL["Adjust guild text position"] = "길드 정보 위치 조절"
--[[ koKR ]] tL["Anchor"] = "앵커"
--[[ koKR ]] tL["Sets the anchor for the guild text"] = "길드 정보의 앵커를 설정합니다."
--[[ koKR ]] tL["Anchor To"] = "앵커 위치"
--[[ koKR ]] tL["Sets the relative point on the health bar to anchor the guild text"] = "생명력바에서 길드 정보의 앵커 위치를 설정합니다."
--[[ koKR ]] tL["X Offset"] = "X 좌표"
--[[ koKR ]] tL["X offset of the guild text"] = "길드 정보의 X 좌표 입니다."
--[[ koKR ]] tL["Y Offset"] = "Y 좌표"
--[[ koKR ]] tL["Y offset of the guild text"] = "길드 정보의 Y 좌표 입니다."
--[[ koKR ]] tL["Alpha"] = "투명도"
--[[ koKR ]] tL["Sets the alpha of the guild text"] = "길드 정보의 투명도를 설정합니다."
--[[ koKR ]] tL["Color"] = "색상"
--[[ koKR ]] tL["Sets the guild text color"] = "길드 정보의 색상을 설정합니다."

--[[ koKR ]] tL["None"] = "없음"
--[[ koKR ]] tL["Normal"] = "보통"
--[[ koKR ]] tL["Thick"] = "굵게"

--[[ koKR ]] tL["NoSetShortName"] = "|cffff0000대상에 지정된 짧은 이름이 없습니다.|r"
--[[ koKR ]] tL["ShortNameAdded"] = "|cff00ff00%s|r -> |cff00ff00%s|r 추가됨"

--[[ koKR ]] tL["Advanced"] = "고급"
--[[ koKR ]] tL["Options for expert users"] = "고급 사용자를 위한 설정입니다."
--[[ koKR ]] tL["Format"] = "형식"
--[[ koKR ]] tL["Guild tag"] = "길드 태그"
--[[ koKR ]] tL["<Any tag string>"] = "<태그 문자열>"

--[[ koKR ]] tL["TOPLEFT"] = "좌측 상단"
--[[ koKR ]] tL["TOP"] = "상단"
--[[ koKR ]] tL["TOPRIGHT"] = "우측 상단"
--[[ koKR ]] tL["LEFT"] = "좌측"
--[[ koKR ]] tL["CENTER"] = "가운데"
--[[ koKR ]] tL["RIGHT"] = "우측"
--[[ koKR ]] tL["BOTTOMLEFT"] = "좌측 하단"
--[[ koKR ]] tL["BOTTOM"] = "하단"
--[[ koKR ]] tL["BOTTOMRIGHT"] = "우측 하단"

-----------------------------------------------------------------------------

--[[ koKR ]] oL["Reset Short Guilds"] = "짧은 길드 초기화"
--[[ koKR ]] oL["Empties the custom short guild database"] = "사용자의 짧은 길드 데이터베이스를 삭제합니다."

--[[ koKR ]] oL["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = "당신의 짧은 길드명 데이터를 삭제합니다.\n이 동작은 되돌릴 수 없습니다. 계속 하시겠습니까?"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftGuild"] = "AloftGuild"
--[[ koKR ]] mL["Gather and display player guild names on nameplates"] = "Gather and display player guild names on nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] dL["Save Guild Data"] = "Записать данные о гильдиях"
--[[ ruRU ]] dL["Stores guild information between sessions"] = "Сохранять данные о гильдии между сессиями"

-----------------------------------------------------------------------------

--[[ ruRU ]] tL["Guild Text"] = "Текст гильдии"
--[[ ruRU ]] tL["Guild text options"] = "Настройки текста гильдии"
--[[ ruRU ]] tL["Enable"] = "Включить"
--[[ ruRU ]] tL["Show guild information on nameplates"] = "Отображать информацию о гильдии на табличках"

--[[ ruRU ]] tL["Attach to Name"] = "Присоединить к имени"
--[[ ruRU ]] tL["Attaches guild text to name"] = "Присоединяет гильд-текст к имени"
--[[ ruRU ]] tL["Attach Format"] = "Способ прикрепления"
--[[ ruRU ]] tL["Selects the text format to use"] = "Выбирает, какой формат использовать для текста"

--[[ ruRU ]] tL["HYPHEN"]	= "Имя - Гильдия"
--[[ ruRU ]] tL["SLASH"]	= "Имя / Гильдия"
--[[ ruRU ]] tL["BRACKET"]	= "Имя (Гильдия)"
--[[ ruRU ]] tL["COLON"]	= "Имя : Гильдия"

--[[ ruRU ]] tL["Short"] = "Сокращенное"
--[[ ruRU ]] tL["Use short guild names"] = "Укорачивать имена гильдий"
--[[ ruRU ]] tL["Set Short Name"] = "Задать короткое имя"
--[[ ruRU ]] tL["<Any String>"] = "<Любая строка>"
--[[ ruRU ]] tL["Sets the short name for your current target"] = "Задает сокращенное имя для текущей цели"
--[[ ruRU ]] tL["Show Own"] = "Отображать себя"
--[[ ruRU ]] tL["Show the guild names of your own guild members"] = "Отображать имя гильдии для членов вашей гильдии"

--[[ ruRU ]] tL["Typeface"] = "Шрифт"
--[[ ruRU ]] tL["Guild text typeface options"] = "Опции шрифта текста гильдии"
--[[ ruRU ]] tL["Font"] = "Шрифт"
--[[ ruRU ]] tL["Sets the font for guild text"] = "Задает шрифт для текста гильдии"
--[[ ruRU ]] tL["Font Size"] = "Размер шрифта"
--[[ ruRU ]] tL["Sets the font height of the guild text"] = "Задает высоту шрифта для текста гильдии"
--[[ ruRU ]] tL["Font Shadow"] = "Тень шрифта"
--[[ ruRU ]] tL["Show font shadow on guild text"] = "Отображать тень для текста гильдии"
--[[ ruRU ]] tL["Outline"] = "Контур"
--[[ ruRU ]] tL["Sets the outline for guild text"] = "Задает окантовку для текста гильдии"

--[[ ruRU ]] tL["Position"] = "Позиция"
--[[ ruRU ]] tL["Adjust guild text position"] = "Задать место текста гильдии"
--[[ ruRU ]] tL["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] tL["Sets the anchor for the guild text"] = "Задает прикрепление текста гильдии"
--[[ ruRU ]] tL["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] tL["Sets the relative point on the health bar to anchor the guild text"] = "Задает точку для положения текста гильдии относительно полоски здоровья"
--[[ ruRU ]] tL["X Offset"] = "Смещение по X"
--[[ ruRU ]] tL["X offset of the guild text"] = "Смещение гильд-текста по X"
--[[ ruRU ]] tL["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] tL["Y offset of the guild text"] = "Смещение гильд-текста по Y"
--[[ ruRU ]] tL["Alpha"] = "Прозрачность"
--[[ ruRU ]] tL["Sets the alpha of the guild text"] = "Задает прозрачность текста гильдии"
--[[ ruRU ]] tL["Color"] = "Цвет"
--[[ ruRU ]] tL["Sets the guild text color"] = "Задает цвет текста гильдии"

--[[ ruRU ]] tL["None"] = "Нет"
--[[ ruRU ]] tL["Normal"] = "Обычно"
--[[ ruRU ]] tL["Thick"] = "Жирный"

--[[ ruRU ]] tL["NoSetShortName"] = "|cffff0000У вас должна быть цель чтобы установить сокращение имени|r"
--[[ ruRU ]] tL["ShortNameAdded"] = "Добавлено |cff00ff00%s|r -> |cff00ff00%s|r"

--[[ ruRU ]] tL["Advanced"] = "Дополнительно"
--[[ ruRU ]] tL["Options for expert users"] = "Настройки для опытных пользователей"
--[[ ruRU ]] tL["Format"] = "Формат"
--[[ ruRU ]] tL["Guild tag"] = "Вид гильдии"
--[[ ruRU ]] tL["<Any tag string>"] = "<Любая строка формата>"

--[[ ruRU ]] tL["TOPLEFT"] = "ВВЕРХУ-СЛЕВА"
--[[ ruRU ]] tL["TOP"] = "ВВЕРХУ"
--[[ ruRU ]] tL["TOPRIGHT"] = "ВВЕРХУ-СПРАВА"
--[[ ruRU ]] tL["LEFT"] = "СЛЕВА"
--[[ ruRU ]] tL["CENTER"] = "ПО ЦЕНТРУ"
--[[ ruRU ]] tL["RIGHT"] = "СПРАВА"
--[[ ruRU ]] tL["BOTTOMLEFT"] = "СНИЗУ-СЛЕВА"
--[[ ruRU ]] tL["BOTTOM"] = "СНИЗУ"
--[[ ruRU ]] tL["BOTTOMRIGHT"] = "СНИЗУ-СПРАВА"

-----------------------------------------------------------------------------

--[[ ruRU ]] oL["Reset Short Guilds"] = "Сброс сокращений для гильдий"
--[[ ruRU ]] oL["Empties the custom short guild database"] = "Очищает базу данных сокращенных названий гильдий"

--[[ ruRU ]] oL["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = "Вы хотите сбросить базу сокращенных имен гильдий.\nРезультат будет необратим. Продолжить?"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftGuild"] = "AloftGuild"
--[[ ruRU ]] mL["Gather and display player guild names on nameplates"] = "Отображает название гильдии игрока"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] dL["Save Guild Data"] = "储存公会信息"
--[[ zhCN ]] dL["Stores guild information between sessions"] = "在两次登录的间隔储存公会信息"

-----------------------------------------------------------------------------

--[[ zhCN ]] tL["Guild Text"] = "公会名称文字"
--[[ zhCN ]] tL["Guild text options"] = "公会名称文字相关设置"
--[[ zhCN ]] tL["Enable"] = "启用"
--[[ zhCN ]] tL["Show guild information on nameplates"] = "在姓名板上显示公会信息"

--[[ zhCN ]] tL["Attach to Name"] = "依附姓名"
--[[ zhCN ]] tL["Attaches guild text to name"] = "公会名称文字依附姓名"
--[[ zhCN ]] tL["Attach Format"] = "依附格式"
--[[ zhCN ]] tL["Selects the text format to use"] = "选择文字的"

--[[ zhCN ]] tL["HYPHEN"]	= "名字 - 公会"
--[[ zhCN ]] tL["SLASH"]	= "名字 / 公会"
--[[ zhCN ]] tL["BRACKET"]	= "名字 (公会)"
--[[ zhCN ]] tL["COLON"]	= "名字 : 公会"

--[[ zhCN ]] tL["Short"] = "缩写"
--[[ zhCN ]] tL["Use short guild names"] = "使用公会名称的缩写"
--[[ zhCN ]] tL["Set Short Name"] = "设定公会名称缩写"
--[[ zhCN ]] tL["<Any String>"] = "<任意文字>"
--[[ zhCN ]] tL["Sets the short name for your current target"] = "设定当前目标公会名称的缩写"
--[[ zhCN ]] tL["Show Own"] = "显示自己"
--[[ zhCN ]] tL["Show the guild names of your own guild members"] = "设定自己公会名称的缩写"

--[[ zhCN ]] tL["Typeface"] = "式样"
--[[ zhCN ]] tL["Guild text typeface options"] = "公会名称文字式样设置"
--[[ zhCN ]] tL["Font"] = "字体"
--[[ zhCN ]] tL["Sets the font for guild text"] = "设定公会名称文字的字体"
--[[ zhCN ]] tL["Font Size"] = "字号"
--[[ zhCN ]] tL["Sets the font height of the guild text"] = "设定公会名称文字的字号"
--[[ zhCN ]] tL["Font Shadow"] = "字体阴影"
--[[ zhCN ]] tL["Show font shadow on guild text"] = "显示公会名称文字的字体阴影"
--[[ zhCN ]] tL["Outline"] = "轮廓"
--[[ zhCN ]] tL["Sets the outline for guild text"] = "设定公会名称文字的轮廓"

--[[ zhCN ]] tL["Position"] = "位置"
--[[ zhCN ]] tL["Adjust guild text position"] = "调整设定公会名称文字的位置"
--[[ zhCN ]] tL["Anchor"] = "锚点"
--[[ zhCN ]] tL["Sets the anchor for the guild text"] = "设定公会名称文字的锚点"
--[[ zhCN ]] tL["Anchor To"] = "固定在"
--[[ zhCN ]] tL["Sets the relative point on the health bar to anchor the guild text"] = "设定公会名称文字的固定在生命值显示条的相对位置"
--[[ zhCN ]] tL["X Offset"] = "X轴偏移"
--[[ zhCN ]] tL["X offset of the guild text"] = "公会名称文字的X轴偏移量"
--[[ zhCN ]] tL["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] tL["Y offset of the guild text"] = "公会名称文字的Y轴偏移量"
--[[ zhCN ]] tL["Alpha"] = "透明度"
--[[ zhCN ]] tL["Sets the alpha of the guild text"] = "设定公会名称文字的透明度"
--[[ zhCN ]] tL["Color"] = "颜色"
--[[ zhCN ]] tL["Sets the guild text color"] = "设定公会名称文字的颜色"

--[[ zhCN ]] tL["None"] = "无"
--[[ zhCN ]] tL["Normal"] = "正常"
--[[ zhCN ]] tL["Thick"] = "粗"

--[[ zhCN ]] tL["NoSetShortName"] = "|cffff0000要设定公会简称，你首先需要一个目标|r"
--[[ zhCN ]] tL["ShortNameAdded"] = "增加: |cff00ff00%s|r -> |cff00ff00%s|r"

--[[ zhCN ]] tL["Advanced"] = "高级"
--[[ zhCN ]] tL["Options for expert users"] = "高级设置"
--[[ zhCN ]] tL["Format"] = "格式"
--[[ zhCN ]] tL["Guild tag"] = "公会标签"
--[[ zhCN ]] tL["<Any tag string>"] = "<任意标签文字>"

--[[ zhCN ]] tL["TOPLEFT"] = "左上"
--[[ zhCN ]] tL["TOP"] = "上"
--[[ zhCN ]] tL["TOPRIGHT"] = "右上"
--[[ zhCN ]] tL["LEFT"] = "左"
--[[ zhCN ]] tL["CENTER"] = "中"
--[[ zhCN ]] tL["RIGHT"] = "右"
--[[ zhCN ]] tL["BOTTOMLEFT"] = "左下"
--[[ zhCN ]] tL["BOTTOM"] = "下"
--[[ zhCN ]] tL["BOTTOMRIGHT"] = "右下"

-----------------------------------------------------------------------------

--[[ zhCN ]] oL["Reset Short Guilds"] = "重置公会简称"
--[[ zhCN ]] oL["Empties the custom short guild database"] = "清空公会简称的信息库。"

--[[ zhCN ]] oL["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = "你是否真要清空公会简称信息库？"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftGuild"] = "公会"
--[[ zhCN ]] mL["Gather and display player guild names on nameplates"] = "在姓名板上显示玩家的公会名"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] dL["Save Guild Data"] = "儲存公會資料"
--[[ zhTW ]] dL["Stores guild information between sessions"] = "儲存公會資訊在登錄期間"

-----------------------------------------------------------------------------

--[[ zhTW ]] tL["Guild Text"] = "公會文字"
--[[ zhTW ]] tL["Guild text options"] = "公會文字設定"
--[[ zhTW ]] tL["Enable"] = "啟用"
--[[ zhTW ]] tL["Show guild information on nameplates"] = "在名牌上顯示公會資訊"

--[[ zhTW ]] tL["Attach to Name"] = "附加到名字"
--[[ zhTW ]] tL["Attaches guild text to name"] = "附加公會文字到名稱"
--[[ zhTW ]] tL["Attach Format"] = "附加格式"
--[[ zhTW ]] tL["Selects the text format to use"] = "選擇文字格式來使用"

--[[ zhTW ]] tL["HYPHEN"]	= "名字 - 公會"
--[[ zhTW ]] tL["SLASH"]	= "名字 / 公會"
--[[ zhTW ]] tL["BRACKET"]	= "名字 (公會)"
--[[ zhTW ]] tL["COLON"]	= "名字 : 公會"

--[[ zhTW ]] tL["Short"] = "簡短"
--[[ zhTW ]] tL["Use short guild names"] = "使用簡短公會名稱"
--[[ zhTW ]] tL["Set Short Name"] = "設定簡短名稱"
--[[ zhTW ]] tL["<Any String>"] = "<任何文字>"
--[[ zhTW ]] tL["Sets the short name for your current target"] = "設定目前目標的簡短公會名稱"
--[[ zhTW ]] tL["Show Own"] = "設定自己"
--[[ zhTW ]] tL["Show the guild names of your own guild members"] = "設定自己的簡短公會名稱"

--[[ zhTW ]] tL["Typeface"] = "字體"
--[[ zhTW ]] tL["Guild text typeface options"] = "公會文字字體設定"
--[[ zhTW ]] tL["Font"] = "字型"
--[[ zhTW ]] tL["Sets the font for guild text"] = "設定公會文字的字型"
--[[ zhTW ]] tL["Font Size"] = "字型大小"
--[[ zhTW ]] tL["Sets the font height of the guild text"] = "設定公會文字的字型高度"
--[[ zhTW ]] tL["Font Shadow"] = "字型陰影"
--[[ zhTW ]] tL["Show font shadow on guild text"] = "公會文字上顯示字型陰影"
--[[ zhTW ]] tL["Outline"] = "輪廓"
--[[ zhTW ]] tL["Sets the outline for guild text"] = "設定公會文字的字型輪廓"

--[[ zhTW ]] tL["Position"] = "位置"
--[[ zhTW ]] tL["Adjust guild text position"] = "調整公會文字位置"
--[[ zhTW ]] tL["Anchor"] = "錨點"
--[[ zhTW ]] tL["Sets the anchor for the guild text"] = "設定公會文字的錨點"
--[[ zhTW ]] tL["Anchor To"] = "錨點在"
--[[ zhTW ]] tL["Sets the relative point on the health bar to anchor the guild text"] = "設定在生命條上錨到公會文字的相關點"
--[[ zhTW ]] tL["X Offset"] = "X偏移"
--[[ zhTW ]] tL["X offset of the guild text"] = "公會文字的X偏移"
--[[ zhTW ]] tL["Y Offset"] = "Y偏移"
--[[ zhTW ]] tL["Y offset of the guild text"] = "公會文字的Y偏移"
--[[ zhTW ]] tL["Alpha"] = "透明度"
--[[ zhTW ]] tL["Sets the alpha of the guild text"] = "設定公會文字的透明度"
--[[ zhTW ]] tL["Color"] = "顏色"
--[[ zhTW ]] tL["Sets the guild text color"] = "設定公會文字顏色"

--[[ zhTW ]] tL["None"] = "無"
--[[ zhTW ]] tL["Normal"] = "正常"
--[[ zhTW ]] tL["Thick"] = "粗"

--[[ zhTW ]] tL["NoSetShortName"] = "|cffff0000你需要一個目標設定簡短公會名稱|r"
--[[ zhTW ]] tL["ShortNameAdded"] = "增加: |cff00ff00%s|r -> |cff00ff00%s|r"

--[[ zhTW ]] tL["Advanced"] = "進階"
--[[ zhTW ]] tL["Options for expert users"] = "熟練的使用者設定"
--[[ zhTW ]] tL["Format"] = "格式"
--[[ zhTW ]] tL["Guild tag"] = "公會標籤"
--[[ zhTW ]] tL["<Any tag string>"] = "<任何標籤文字>"

--[[ zhTW ]] tL["TOPLEFT"] = "上左"
--[[ zhTW ]] tL["TOP"] = "上"
--[[ zhTW ]] tL["TOPRIGHT"] = "上右"
--[[ zhTW ]] tL["LEFT"] = "左"
--[[ zhTW ]] tL["CENTER"] = "中"
--[[ zhTW ]] tL["RIGHT"] = "右"
--[[ zhTW ]] tL["BOTTOMLEFT"] = "下左"
--[[ zhTW ]] tL["BOTTOM"] = "下"
--[[ zhTW ]] tL["BOTTOMRIGHT"] = "下右"

-----------------------------------------------------------------------------

--[[ zhTW ]] oL["Reset Short Guilds"] = "重置簡短公會名稱"
--[[ zhTW ]] oL["Empties the custom short guild database"] = "清空自訂簡短公會名稱資料庫"

--[[ zhTW ]] oL["You are about to empty your guild short name database.\nThis action cannot be undone. Proceed?"] = "你是否真的清空簡短公會名稱資料庫\n這動作無法復原。進行?"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftGuild"] = "Aloft公會"
--[[ zhTW ]] mL["Gather and display player guild names on nameplates"] = "在名牌上收集和顯示玩家公會名稱"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

AloftLocale.AloftGuildDataOptions = setmetatable(dL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
dL = nil

AloftLocale.AloftGuildTextOptions = setmetatable(tL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
tL = nil

AloftLocale.AloftShortGuildDataOptions = setmetatable(oL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
oL = nil

-----------------------------------------------------------------------------

end)

