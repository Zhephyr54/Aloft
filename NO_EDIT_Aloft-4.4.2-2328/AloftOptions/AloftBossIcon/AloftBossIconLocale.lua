local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

--[[ enUS ]] L["Boss Icon"] = "Boss Icon"
--[[ enUS ]] L["Boss icon placement options"] = "Boss icon placement options"
--[[ enUS ]] L["Enable"] = "Enable"
--[[ enUS ]] L["Enable boss icon display on the nameplate"] = "Enable boss icon display on the nameplate"
--[[ enUS ]] L["Size"] = "Size"
--[[ enUS ]] L["Size in pixels of the boss icon"] = "Size in pixels of the boss icon"
--[[ enUS ]] L["Position"] = "Position"
--[[ enUS ]] L["Adjust boss icon position"] = "Adjust boss icon position"
--[[ enUS ]] L["X Offset"] = "X Offset"
--[[ enUS ]] L["X offset of the boss icon"] = "X offset of the boss icon"
--[[ enUS ]] L["Y Offset"] = "Y Offset"
--[[ enUS ]] L["Y offset of the boss icon"] = "Y offset of the boss icon"
--[[ enUS ]] L["Anchor"] = "Anchor"
--[[ enUS ]] L["Sets the anchor for the boss icon"] = "Sets the anchor for the boss icon"
--[[ enUS ]] L["Anchor To"] = "Anchor To"
--[[ enUS ]] L["Sets the relative point on the health bar to anchor the boss icon"] = "Sets the relative point on the health bar to anchor the boss icon"
--[[ enUS ]] L["Alpha"] = "Alpha"
--[[ enUS ]] L["Sets the boss icon alpha"] = "Sets the boss icon alpha"

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

-----------------------------------------------------------------------------

--[[ koKR ]] L["Boss Icon"] = "보스 아이콘"
--[[ koKR ]] L["Boss icon placement options"] = "보스 아이콘 배치 설정"
--[[ koKR ]] L["Enable"] = "사용"
--[[ koKR ]] L["Enable boss icon display on the nameplate"] = "이름표에 보스 아이콘을 표시합니다."
--[[ koKR ]] L["Size"] = "크기"
--[[ koKR ]] L["Size in pixels of the boss icon"] = "보스 아이콘의 크기입니다."
--[[ koKR ]] L["Position"] = "위치"
--[[ koKR ]] L["Adjust boss icon position"] = "보스 아이콘 위치 조절"
--[[ koKR ]] L["X Offset"] = "X 좌표"
--[[ koKR ]] L["X offset of the boss icon"] = "보스 아이콘의 X 좌표 입니다."
--[[ koKR ]] L["Y Offset"] = "Y 좌표"
--[[ koKR ]] L["Y offset of the boss icon"] = "보스 아이콘의 Y 좌표 입니다."
--[[ koKR ]] L["Anchor"] = "앵커"
--[[ koKR ]] L["Sets the anchor for the boss icon"] = "보스 아이콘의 앵커를 설정합니다."
--[[ koKR ]] L["Anchor To"] = "앵커 위치"
--[[ koKR ]] L["Sets the relative point on the health bar to anchor the boss icon"] = "생명력바에서 보스 아이콘의 앵커 위치를 설정합니다."
--[[ koKR ]] L["Alpha"] = "투명도"
--[[ koKR ]] L["Sets the boss icon alpha"] = "보스 아이콘의 투명도를 설정합니다."

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

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Boss Icon"] = "Иконка босса"
--[[ ruRU ]] L["Boss icon placement options"] = "Настрокий положения иконки босса"
--[[ ruRU ]] L["Enable"] = "Включить"
--[[ ruRU ]] L["Enable boss icon display on the nameplate"] = "Включить отображение значка босса на табличке"
--[[ ruRU ]] L["Size"] = "Размер"
--[[ ruRU ]] L["Size in pixels of the boss icon"] = "Размер значка босса в пикселях"
--[[ ruRU ]] L["Position"] = "Позиция"
--[[ ruRU ]] L["Adjust boss icon position"] = "Задать место иконки босса"
--[[ ruRU ]] L["X Offset"] = "Смещение по X"
--[[ ruRU ]] L["X offset of the boss icon"] = "Смещение значка босса по X"
--[[ ruRU ]] L["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] L["Y offset of the boss icon"] = "Смещение значка босса по Y"
--[[ ruRU ]] L["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] L["Sets the anchor for the boss icon"] = "Задает прикрепление значка босса"
--[[ ruRU ]] L["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] L["Sets the relative point on the health bar to anchor the boss icon"] = "Задает точку для положения значка босса относительно полоски здоровья"
--[[ ruRU ]] L["Alpha"] = "Прозрачность"
--[[ ruRU ]] L["Sets the boss icon alpha"] = "Задает прозрачность значка босса"

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

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Boss Icon"] = "首领图标"
--[[ zhCN ]] L["Boss icon placement options"] = "首领图标位置相关设置"
--[[ zhCN ]] L["Enable"] = "启用"
--[[ zhCN ]] L["Enable boss icon display on the nameplate"] = "在姓名板上显示首领图标"
--[[ zhCN ]] L["Size"] = "尺寸"
--[[ zhCN ]] L["Size in pixels of the boss icon"] = "首领图标的像素尺寸"
--[[ zhCN ]] L["Position"] = "位置"
--[[ zhCN ]] L["Adjust boss icon position"] = "调整首领图标的位置"
--[[ zhCN ]] L["X Offset"] = "X轴偏移"
--[[ zhCN ]] L["X offset of the boss icon"] = "首领图标的X轴偏移量"
--[[ zhCN ]] L["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] L["Y offset of the boss icon"] = "首领图标的Y轴偏移量"
--[[ zhCN ]] L["Anchor"] = "锚点"
--[[ zhCN ]] L["Sets the anchor for the boss icon"] = "设定首领图标的锚点"
--[[ zhCN ]] L["Anchor To"] = "固定在"
--[[ zhCN ]] L["Sets the relative point on the health bar to anchor the boss icon"] = "设定首领图标固定在生命值显示条的相对位置"
--[[ zhCN ]] L["Alpha"] = "透明度"
--[[ zhCN ]] L["Sets the boss icon alpha"] = "设定首领图标的透明度"

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

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Boss Icon"] = "首領圖示"
--[[ zhTW ]] L["Boss icon placement options"] = "首領圖示佈局設定"
--[[ zhTW ]] L["Enable"] = "啟用"
--[[ zhTW ]] L["Enable boss icon display on the nameplate"] = "在名牌上顯示首領圖示"
--[[ zhTW ]] L["Size"] = "大小"
--[[ zhTW ]] L["Size in pixels of the boss icon"] = "首領圖示的像素大小"
--[[ zhTW ]] L["Position"] = "位置"
--[[ zhTW ]] L["Adjust boss icon position"] = "調整首領圖示位置"
--[[ zhTW ]] L["X Offset"] = "X偏移"
--[[ zhTW ]] L["X offset of the boss icon"] = "首領圖示的X偏移"
--[[ zhTW ]] L["Y Offset"] = "Y偏移"
--[[ zhTW ]] L["Y offset of the boss icon"] = "首領圖示的Y偏移"
--[[ zhTW ]] L["Anchor"] = "錨點"
--[[ zhTW ]] L["Sets the anchor for the boss icon"] = "設定首領圖示的錨點"
--[[ zhTW ]] L["Anchor To"] = "錨點到"
--[[ zhTW ]] L["Sets the relative point on the health bar to anchor the boss icon"] = "設定在生命條上錨到首領圖示的相關點"
--[[ zhTW ]] L["Alpha"] = "透明度"
--[[ zhTW ]] L["Sets the boss icon alpha"] = "設定首領圖示透明度"

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

AloftLocale.AloftBossIconOptions = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil
