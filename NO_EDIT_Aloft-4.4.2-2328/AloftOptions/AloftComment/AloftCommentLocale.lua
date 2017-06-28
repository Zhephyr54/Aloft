local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

local oL = { }

local tL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] oL["Comments"] = "Comments"
--[[ enUS ]] oL["Comment options"] = "Comment options"

--[[ enUS ]] oL["Save Comment Data"] = "Save Comment Data"
--[[ enUS ]] oL["Stores comment data between sessions"] = "Stores comment data between sessions"

--[[ enUS ]] oL["Automatic Comments"] = "Automatic Comments"
--[[ enUS ]] oL["Automatically set comments from tooltip tags"] = "Automatically set comments from tooltip tags"

--[[ enUS ]] oL["Include Hostile Units"] = "Include Hostile Units"
--[[ enUS ]] oL["Include hostile units when automatically gathering comments"] = "Include hostile units when automatically gathering comments"

--[[ enUS ]] oL["Reset Comments"] = "Reset Comments"
--[[ enUS ]] oL["Empties the comment database"] = "Empties the comment database"

--[[ enUS ]] oL["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = "You are about to empty your comment database.\nThis action cannot be undone. Proceed?"

-----------------------------------------------------------------------------

--[[ enUS ]] tL["Comment Text"] = "Comment Text"
--[[ enUS ]] tL["Comment text options"] = "Comment text options"
--[[ enUS ]] tL["Enable"] = "Enable"
--[[ enUS ]] tL["Show comments on nameplates"] = "Show comments on nameplates"
--[[ enUS ]] tL["Font"] = "Font"
--[[ enUS ]] tL["Sets the font for comment text"] = "Sets the font for comment text"

--[[ enUS ]] tL["Set Comment"] = "Set Comment"
--[[ enUS ]] tL["Sets the comment for your current target"] = "Sets the comment for your current target"
--[[ enUS ]] tL["<Any String>"] = "<Any String>"

--[[ enUS ]] tL["Typeface"] = "Typeface"
--[[ enUS ]] tL["Comment typeface options"] = "Comment typeface options"
--[[ enUS ]] tL["Font Size"] = "Font Size"
--[[ enUS ]] tL["Sets the font height of the comment text"] = "Sets the font height of the comment text"
--[[ enUS ]] tL["Font Shadow"] = "Font Shadow"
--[[ enUS ]] tL["Show font shadow on comment text"] = "Show font shadow on comment text"
--[[ enUS ]] tL["Outline"] = "Outline"
--[[ enUS ]] tL["Sets the outline for comment text"] = "Sets the outline for comment text"

--[[ enUS ]] tL["Position"] = "Position"
--[[ enUS ]] tL["Adjust comment tag position"] = "Adjust comment tag position"
--[[ enUS ]] tL["Anchor"] = "Anchor"
--[[ enUS ]] tL["Sets the anchor for the comment text"] = "Sets the anchor for the comment text"
--[[ enUS ]] tL["Anchor To"] = "Anchor To"
--[[ enUS ]] tL["Sets the relative point on the health bar to anchor the comment text"] = "Sets the relative point on the health bar to anchor the comment text"
--[[ enUS ]] tL["X Offset"] = "X Offset"
--[[ enUS ]] tL["X offset of the comment text"] = "X offset of the comment text"
--[[ enUS ]] tL["Y Offset"] = "Y Offset"
--[[ enUS ]] tL["Y offset of the comment text"] = "Y offset of the comment text"
--[[ enUS ]] tL["Alpha"] = "Alpha"
--[[ enUS ]] tL["Sets the alpha of the comment text"] = "Sets the alpha of the comment text"
--[[ enUS ]] tL["Color"] = "Color"
--[[ enUS ]] tL["Sets the comment text color"] = "Sets the comment text color"

--[[ enUS ]] tL["None"] = "None"
--[[ enUS ]] tL["Normal"] = "Normal"
--[[ enUS ]] tL["Thick"] = "Thick"

--[[ enUS ]] tL["NoSetComment"] = "|cffff0000You must have a target to set a comment|r"
--[[ enUS ]] tL["CommentAdded"] = "Added |cff00ff00%s|r -> |cff00ff00%s|r"

--[[ enUS ]] tL["Advanced"] = "Advanced"
--[[ enUS ]] tL["Options for expert users"] = "Options for expert users"
--[[ enUS ]] tL["Format"] = "Format"
--[[ enUS ]] tL["Comment tag"] = "Comment tag"
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

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftComment"] = "AloftComment"
--[[ enUS ]] mL["Gather and display comment text on nameplates"] = "Gather and display comment text on nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

--[[ koKR ]] oL["Comments"] = "메모"
--[[ koKR ]] oL["Comment options"] = "메모 설정"

--[[ koKR ]] oL["Save Comment Data"] = "메모 데이터 저장"
--[[ koKR ]] oL["Stores comment data between sessions"] = "접속 간 메모 데이터를 저장합니다."

--[[ koKR ]] oL["Automatic Comments"] = "자동 메모"
--[[ koKR ]] oL["Automatically set comments from tooltip tags"] = "자동으로 툴팁 태그를 메모에 설정합니다."

--[[ koKR ]] oL["Include Hostile Units"] = "적대적 대상 포함"
--[[ koKR ]] oL["Include hostile units when automatically gathering comments"] = "자동 메모 설정 시 적대적 대상도 포함시킵니다."

--[[ koKR ]] oL["Reset Comments"] = "메모 초기화"
--[[ koKR ]] oL["Empties the comment database"] = "메모 데이터를 삭제합니다."

--[[ koKR ]] oL["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = "당신의 메모 데이터를 삭제합니다.\n이 동작은 되돌릴 수 없습니다. 계속 하시겠습니까?"

-----------------------------------------------------------------------------

--[[ koKR ]] tL["Comment Text"] = "메모 글자"
--[[ koKR ]] tL["Comment text options"] = "메모 글자 설정"
--[[ koKR ]] tL["Enable"] = "사용"
--[[ koKR ]] tL["Show comments on nameplates"] = "이름표에 메모를 표시합니다."
--[[ koKR ]] tL["Font"] = "글꼴"
--[[ koKR ]] tL["Sets the font for comment text"] = "메모 글자의 글꼴을 설정합니다."

--[[ koKR ]] tL["Set Comment"] = "메모 설정"
--[[ koKR ]] tL["Sets the comment for your current target"] = "현재 대상에 대한 메모를 설정합니다."
--[[ koKR ]] tL["<Any String>"] = "<문자열>"

--[[ koKR ]] tL["Typeface"] = "서체"
--[[ koKR ]] tL["Comment typeface options"] = "메모 서체 설정"
--[[ koKR ]] tL["Font Size"] = "글꼴 크기"
--[[ koKR ]] tL["Sets the font height of the comment text"] = "메모 글자의 글꼴 높이를 설정합니다."
--[[ koKR ]] tL["Font Shadow"] = "글꼴 그림자"
--[[ koKR ]] tL["Show font shadow on comment text"] = "메모 글자에 그림자를 표시합니다."
--[[ koKR ]] tL["Outline"] = "테두리"
--[[ koKR ]] tL["Sets the outline for comment text"] = "메모 글자에 테두리를 설정합니다."

--[[ koKR ]] tL["Position"] = "위치"
--[[ koKR ]] tL["Adjust comment tag position"] = "메모 태그의 위치를 조절합니다."
--[[ koKR ]] tL["Anchor"] = "앵커"
--[[ koKR ]] tL["Sets the anchor for the comment text"] = "메모 글자의 앵커를 설정합니다."
--[[ koKR ]] tL["Anchor To"] = "앵커 위치"
--[[ koKR ]] tL["Sets the relative point on the health bar to anchor the comment text"] = "생명력바에서 메모 글자의 앵커 위치를 설정합니다."
--[[ koKR ]] tL["X Offset"] = "X 좌표"
--[[ koKR ]] tL["X offset of the comment text"] = "메모 글자의 X 좌표입니다."
--[[ koKR ]] tL["Y Offset"] = "Y 좌표"
--[[ koKR ]] tL["Y offset of the comment text"] = "메모 글자의 Y 좌표입니다."
--[[ koKR ]] tL["Alpha"] = "투명도"
--[[ koKR ]] tL["Sets the alpha of the comment text"] = "메모 글자의 투명도를 설정합니다."
--[[ koKR ]] tL["Color"] = "색상"
--[[ koKR ]] tL["Sets the comment text color"] = "메모 글자의 색상을 설정합니다."

--[[ koKR ]] tL["None"] = "없음"
--[[ koKR ]] tL["Normal"] = "기본"
--[[ koKR ]] tL["Thick"] = "굵게"

--[[ koKR ]] tL["NoSetComment"] = "|cffff0000메모를 설정하려면 대상이 있어야 합니다.|r"
--[[ koKR ]] tL["CommentAdded"] = "|cff00ff00%s|r -> |cff00ff00%s|r 추가됨"

--[[ koKR ]] tL["Advanced"] = "고급"
--[[ koKR ]] tL["Options for expert users"] = "고급 사용자를 위한 설정"
--[[ koKR ]] tL["Format"] = "형식"
--[[ koKR ]] tL["Comment tag"] = "메모 태그"
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

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftComment"] = "AloftComment"
--[[ koKR ]] mL["Gather and display comment text on nameplates"] = "Gather and display comment text on nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] oL["Comments"] = "Комментарии"
--[[ ruRU ]] oL["Comment options"] = "Настройка комментариев"

--[[ ruRU ]] oL["Save Comment Data"] = "Записать данные комментариев"
--[[ ruRU ]] oL["Stores comment data between sessions"] = "Сохранять базу комментариев между сессиями"

--[[ ruRU ]] oL["Automatic Comments"] = "Автоматические комментарии"
--[[ ruRU ]] oL["Automatically set comments from tooltip tags"] = "Автоматически задавать комментарии из подсказок"

--[[ ruRU ]] oL["Include Hostile Units"] = "Включая враждебных"
--[[ ruRU ]] oL["Include hostile units when automatically gathering comments"] = "Включать враждебные цели при автоматическом сборе комментариев"

--[[ ruRU ]] oL["Reset Comments"] = "Сбросить комментарии"
--[[ ruRU ]] oL["Empties the comment database"] = "Очищает базу данных комментариев"

--[[ ruRU ]] oL["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = "Вы хотите сбросить базу комментариев.\nРезультат будет необратим. Продолжить?"

-----------------------------------------------------------------------------

--[[ ruRU ]] tL["Comment Text"] = "Текст комментария"
--[[ ruRU ]] tL["Comment text options"] = "Настройки текста комментария"
--[[ ruRU ]] tL["Enable"] = "Включить"
--[[ ruRU ]] tL["Show comments on nameplates"] = "Отображать комментарии на табличках"
--[[ ruRU ]] tL["Font"] = "Шрифт"
--[[ ruRU ]] tL["Sets the font for comment text"] = "Задает шрифт для текста заклинания"

--[[ ruRU ]] tL["Set Comment"] = "Задать комментарий"
--[[ ruRU ]] tL["Sets the comment for your current target"] = "Задает комментарий для текущей цели"
--[[ ruRU ]] tL["<Any String>"] = "<Любая строка>"

--[[ ruRU ]] tL["Typeface"] = "Шрифт"
--[[ ruRU ]] tL["Comment typeface options"] = "Настройка шрифта комментариев"
--[[ ruRU ]] tL["Font Size"] = "Размер шрифта"
--[[ ruRU ]] tL["Sets the font height of the comment text"] = "Задает высоту шрифта для текста комментария"
--[[ ruRU ]] tL["Font Shadow"] = "Тень шрифта"
--[[ ruRU ]] tL["Show font shadow on comment text"] = "Отображать тень для текста комментария"
--[[ ruRU ]] tL["Outline"] = "Контур"
--[[ ruRU ]] tL["Sets the outline for comment text"] = "Задает окантовку для текста комментария"

--[[ ruRU ]] tL["Position"] = "Позиция"
--[[ ruRU ]] tL["Adjust comment tag position"] = "Задать место комментария"
--[[ ruRU ]] tL["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] tL["Sets the anchor for the comment text"] = "Задает прикрепление текста комментария"
--[[ ruRU ]] tL["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] tL["Sets the relative point on the health bar to anchor the comment text"] = "Задает точку для положения текста комментария относительно полоски здоровья"
--[[ ruRU ]] tL["X Offset"] = "Смещение по X"
--[[ ruRU ]] tL["X offset of the comment text"] = "Смещение текста комментария по X"
--[[ ruRU ]] tL["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] tL["Y offset of the comment text"] = "Смещение текста комментария по Y"
--[[ ruRU ]] tL["Alpha"] = "Прозрачность"
--[[ ruRU ]] tL["Sets the alpha of the comment text"] = "Задает прозрачность текста комментария"
--[[ ruRU ]] tL["Color"] = "Цвет"
--[[ ruRU ]] tL["Sets the comment text color"] = "Задает цвет текста комментариев"

--[[ ruRU ]] tL["None"] = "Нет"
--[[ ruRU ]] tL["Normal"] = "Обычный"
--[[ ruRU ]] tL["Thick"] = "Жирный"

--[[ ruRU ]] tL["NoSetComment"] = "|cffff0000У вас должна быть цель чтобы установить комментарии|r"
--[[ ruRU ]] tL["CommentAdded"] = "Добавлено |cff00ff00%s|r -> |cff00ff00%s|r"

--[[ ruRU ]] tL["Advanced"] = "Дополнительно"
--[[ ruRU ]] tL["Options for expert users"] = "Настройки для опытных пользователей"
--[[ ruRU ]] tL["Format"] = "Формат"
--[[ ruRU ]] tL["Comment tag"] = "Вид комментария"
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

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftComment"] = "AloftComment"
--[[ ruRU ]] mL["Gather and display comment text on nameplates"] = "Отображает текст/комментарии"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] oL["Comments"] = "备注"
--[[ zhCN ]] oL["Comment options"] = "备注选项"

--[[ zhCN ]] oL["Save Comment Data"] = "储存备注信息"
--[[ zhCN ]] oL["Stores comment data between sessions"] = "在两次登录的间隔储存备注信息"

--[[ zhCN ]] oL["Automatic Comments"] = "自动备注"
--[[ zhCN ]] oL["Automatically set comments from tooltip tags"] = "将提示信息自动转为备注"

--[[ zhCN ]] oL["Include Hostile Units"] = "包括敌对方单位"
--[[ zhCN ]] oL["Include hostile units when automatically gathering comments"] = "自动设定备注信息包括敌对方单位"

--[[ zhCN ]] oL["Reset Comments"] = "重置备注"
--[[ zhCN ]] oL["Empties the comment database"] = "清空备注信息库"

--[[ zhCN ]] oL["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = "你是否真得要清空备注信息库？"

-----------------------------------------------------------------------------

--[[ zhCN ]] tL["Comment Text"] = "备注文字"
--[[ zhCN ]] tL["Comment text options"] = "备注文字相关设置"
--[[ zhCN ]] tL["Enable"] = "启用"
--[[ zhCN ]] tL["Show comments on nameplates"] = "在姓名板上显示备注文字"
--[[ zhCN ]] tL["Font"] = "字体"
--[[ zhCN ]] tL["Sets the font for comment text"] = "设定备注文字的字体"

--[[ zhCN ]] tL["Set Comment"] = "设定备注"
--[[ zhCN ]] tL["Sets the comment for your current target"] = "为你的当前目标设定备注"
--[[ zhCN ]] tL["<Any String>"] = "<任意文字>"

--[[ zhCN ]] tL["Typeface"] = "式样"
--[[ zhCN ]] tL["Comment typeface options"] = "备注文字式样设置"
--[[ zhCN ]] tL["Font Size"] = "字号"
--[[ zhCN ]] tL["Sets the font height of the comment text"] = "设定备注文字的字号"
--[[ zhCN ]] tL["Font Shadow"] = "字体阴影"
--[[ zhCN ]] tL["Show font shadow on comment text"] = "显示备注文字的字体阴影"
--[[ zhCN ]] tL["Outline"] = "轮廓"
--[[ zhCN ]] tL["Sets the outline for comment text"] = "设定备注文字的字体輪廓"

--[[ zhCN ]] tL["Position"] = "位置"
--[[ zhCN ]] tL["Adjust comment tag position"] = "调整备注标签的位置"
--[[ zhCN ]] tL["Anchor"] = "锚点"
--[[ zhCN ]] tL["Sets the anchor for the comment text"] = "设定备注文字的锚点"
--[[ zhCN ]] tL["Anchor To"] = "固定在"
--[[ zhCN ]] tL["Sets the relative point on the health bar to anchor the comment text"] = "设定备注文字固定在生命值显示条的相对位置"
--[[ zhCN ]] tL["X Offset"] = "X轴偏移"
--[[ zhCN ]] tL["X offset of the comment text"] = "设定备注文字的X轴偏移量"
--[[ zhCN ]] tL["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] tL["Y offset of the comment text"] = "设定备注文字的Y轴偏移量"
--[[ zhCN ]] tL["Alpha"] = "透明度"
--[[ zhCN ]] tL["Sets the alpha of the comment text"] = "设定备注文字的透明度"
--[[ zhCN ]] tL["Color"] = "颜色"
--[[ zhCN ]] tL["Sets the comment text color"] = "设定备注文字的颜色"

--[[ zhCN ]] tL["None"] = "无"
--[[ zhCN ]] tL["Normal"] = "正常"
--[[ zhCN ]] tL["Thick"] = "粗"

--[[ zhCN ]] tL["NoSetComment"] = "|cffff0000要设定备注，你需要一个目标|r"
--[[ zhCN ]] tL["CommentAdded"] = "增加: |cff00ff00%s|r -> |cff00ff00%s|r"

--[[ zhCN ]] tL["Advanced"] = "高级"
--[[ zhCN ]] tL["Options for expert users"] = "高级设置"
--[[ zhCN ]] tL["Format"] = "格式"
--[[ zhCN ]] tL["Comment tag"] = "备注标签"
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

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftComment"] = "注释"
--[[ zhCN ]] mL["Gather and display comment text on nameplates"] = "在姓名板上显示特定文字"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] oL["Comments"] = "備註"
--[[ zhTW ]] oL["Comment options"] = "備註設定"

--[[ zhTW ]] oL["Save Comment Data"] = "儲存備註資料"
--[[ zhTW ]] oL["Stores comment data between sessions"] = "儲存備註資料"

--[[ zhTW ]] oL["Automatic Comments"] = "自動備註"
--[[ zhTW ]] oL["Automatically set comments from tooltip tags"] = "由提示訊息自動設定備註"

--[[ zhTW ]] oL["Include Hostile Units"] = "包括敵對單位"
--[[ zhTW ]] oL["Include hostile units when automatically gathering comments"] = "自動設定備註包括敵對單位"

--[[ zhTW ]] oL["Reset Comments"] = "重置備註"
--[[ zhTW ]] oL["Empties the comment database"] = "清空備註資料庫"

--[[ zhTW ]] oL["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = "你是否真的清空備註資料庫.\n這動作無法復原。進行？"

-----------------------------------------------------------------------------

--[[ zhTW ]] tL["Comment Text"] = "備註文字"
--[[ zhTW ]] tL["Comment text options"] = "備註文字設定"
--[[ zhTW ]] tL["Enable"] = "啟用"
--[[ zhTW ]] tL["Show comments on nameplates"] = "在名牌上顯示備註"
--[[ zhTW ]] tL["Font"] = "字型"
--[[ zhTW ]] tL["Sets the font for comment text"] = "設定備註文字的字型"

--[[ zhTW ]] tL["Set Comment"] = "設定備註"
--[[ zhTW ]] tL["Sets the comment for your current target"] = "設定目前目標的備註"
--[[ zhTW ]] tL["<Any String>"] = "<任何文字>"

--[[ zhTW ]] tL["Typeface"] = "字體"
--[[ zhTW ]] tL["Comment typeface options"] = "備註文字字體設定"
--[[ zhTW ]] tL["Font Size"] = "字型大小"
--[[ zhTW ]] tL["Sets the font height of the comment text"] = "設定備註文字的字型高度"
--[[ zhTW ]] tL["Font Shadow"] = "字型陰影"
--[[ zhTW ]] tL["Show font shadow on comment text"] = "設定備註文字的字型陰影"
--[[ zhTW ]] tL["Outline"] = "輪廓"
--[[ zhTW ]] tL["Sets the outline for comment text"] = "設定備註文字的字型輪廓"

--[[ zhTW ]] tL["Position"] = "位置"
--[[ zhTW ]] tL["Adjust comment tag position"] = "調整備註標籤位置"
--[[ zhTW ]] tL["Anchor"] = "錨點"
--[[ zhTW ]] tL["Sets the anchor for the comment text"] = "備註文字定位點"
--[[ zhTW ]] tL["Anchor To"] = "錨點到"
--[[ zhTW ]] tL["Sets the relative point on the health bar to anchor the comment text"] = "設定在生命條上錨到備註文字的相關點"
--[[ zhTW ]] tL["X Offset"] = "X偏移"
--[[ zhTW ]] tL["X offset of the comment text"] = "備註文字的X偏移"
--[[ zhTW ]] tL["Y Offset"] = "Y偏移"
--[[ zhTW ]] tL["Y offset of the comment text"] = "備註文字的Y偏移"
--[[ zhTW ]] tL["Alpha"] = "透明度"
--[[ zhTW ]] tL["Sets the alpha of the comment text"] = "設定備註文字的透明度"
--[[ zhTW ]] tL["Color"] = "顏色"
--[[ zhTW ]] tL["Sets the comment text color"] = "設定備註文字顏色"

--[[ zhTW ]] tL["None"] = "無"
--[[ zhTW ]] tL["Normal"] = "正常"
--[[ zhTW ]] tL["Thick"] = "粗"

--[[ zhTW ]] tL["NoSetComment"] = "|cffff0000你需要一個目標設定備註|r"
--[[ zhTW ]] tL["CommentAdded"] = "增加: |cff00ff00%s|r -> |cff00ff00%s|r"

--[[ zhTW ]] tL["Advanced"] = "進階"
--[[ zhTW ]] tL["Options for expert users"] = "熟練的使用者設定"
--[[ zhTW ]] tL["Format"] = "格式"
--[[ zhTW ]] tL["Comment tag"] = "備註標籤"
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

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftComment"] = "Aloft備註"
--[[ zhTW ]] mL["Gather and display comment text on nameplates"] = "在名牌上收集和顯示備註文字"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

AloftLocale.AloftCommentDataOptions = setmetatable(oL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
oL = nil

AloftLocale.AloftCommentTextOptions = setmetatable(tL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
tL = nil

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------
