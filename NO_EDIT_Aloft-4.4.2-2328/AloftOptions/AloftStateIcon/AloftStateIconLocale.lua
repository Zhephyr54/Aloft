local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

--[[ enUS ]] L["State Icon"] = "State Icon"
--[[ enUS ]] L["State icon placement options"] = "State icon placement options"
--[[ enUS ]] L["Enable"] = "Enable"
--[[ enUS ]] L["Enable state icon display on the nameplate"] = "Enable state icon display on the nameplate"
--[[ enUS ]] L["Reverse"] = "Reverse"
--[[ enUS ]] L["Reverse the state icon graphic horizontally"] = "Reverse the state icon graphic horizontally"
--[[ enUS ]] L["Height"] = "Height"
--[[ enUS ]] L["Height in pixels of the state icon"] = "Height in pixels of the state icon"
--[[ enUS ]] L["Width"] = "Width"
--[[ enUS ]] L["Width in pixels of the state icon"] = "Width in pixels of the state icon"
--[[ enUS ]] L["Position"] = "Position"
--[[ enUS ]] L["Adjust state icon position"] = "Adjust state icon position"
--[[ enUS ]] L["X Offset"] = "X Offset"
--[[ enUS ]] L["X offset of the state icon"] = "X offset of the state icon"
--[[ enUS ]] L["Y Offset"] = "Y Offset"
--[[ enUS ]] L["Y offset of the state icon"] = "Y offset of the state icon"
--[[ enUS ]] L["Anchor"] = "Anchor"
--[[ enUS ]] L["Sets the anchor for the state icon"] = "Sets the anchor for the state icon"
--[[ enUS ]] L["Anchor To"] = "Anchor To"
--[[ enUS ]] L["Sets the relative point on the health bar to anchor the state icon"] = "Sets the relative point on the health bar to anchor the state icon"
--[[ enUS ]] L["Alpha"] = "Alpha"
--[[ enUS ]] L["Sets the state icon alpha"] = "Sets the state icon alpha"

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

--[[ koKR ]] L["State Icon"] = "보스 아이콘"
--[[ koKR ]] L["State icon placement options"] = "보스 아이콘 배치 설정"
--[[ koKR ]] L["Enable"] = "사용"
--[[ koKR ]] L["Enable state icon display on the nameplate"] = "Enable state icon display on the nameplate"
--[[ koKR ]] L["Reverse"] = "Reverse"
--[[ koKR ]] L["Reverse the state icon graphic horizontally"] = "Reverse the state icon graphic horizontally"
--[[ koKR ]] L["Height"] = "크기"
--[[ koKR ]] L["Height in pixels of the state icon"] = "Height in pixels of the state icon"
--[[ koKR ]] L["Width"] = "크기"
--[[ koKR ]] L["Width in pixels of the state icon"] = "Width in pixels of the state icon"
--[[ koKR ]] L["Position"] = "위치"
--[[ koKR ]] L["Adjust state icon position"] = "Adjust state icon position"
--[[ koKR ]] L["X Offset"] = "X 좌표"
--[[ koKR ]] L["X offset of the state icon"] = "X offset of the state icon"
--[[ koKR ]] L["Y Offset"] = "Y 좌표"
--[[ koKR ]] L["Y offset of the state icon"] = "Y offset of the state icon"
--[[ koKR ]] L["Anchor"] = "앵커"
--[[ koKR ]] L["Sets the anchor for the state icon"] = "Sets the anchor for the state icon"
--[[ koKR ]] L["Anchor To"] = "앵커 위치"
--[[ koKR ]] L["Sets the relative point on the health bar to anchor the state icon"] = "Sets the relative point on the health bar to anchor the state icon"
--[[ koKR ]] L["Alpha"] = "투명도"
--[[ koKR ]] L["Sets the state icon alpha"] = "Sets the state icon alpha"

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

--[[ ruRU ]] L["State Icon"] = "Иконка состояния"
--[[ ruRU ]] L["State icon placement options"] = "Настрокий положения иконки состояния"
--[[ ruRU ]] L["Enable"] = "Включить"
--[[ ruRU ]] L["Enable state icon display on the nameplate"] = "Включает отображение иконки состояния"
--[[ ruRU ]] L["Reverse"] = "Перевернуть"
--[[ ruRU ]] L["Reverse the state icon graphic horizontally"] = "Переварачивает иконку состояния по горизонтале"
--[[ ruRU ]] L["Height"] = "Высота"
--[[ ruRU ]] L["Height in pixels of the state icon"] = "Высота иконки состояния в пикселях"
--[[ ruRU ]] L["Width"] = "Ширина"
--[[ ruRU ]] L["Width in pixels of the state icon"] = "Ширина иконки состояния в пикселях"
--[[ ruRU ]] L["Position"] = "Позиция"
--[[ ruRU ]] L["Adjust state icon position"] = "Задать место иконки состояния"
--[[ ruRU ]] L["X Offset"] = "Смещение по X"
--[[ ruRU ]] L["X offset of the state icon"] = "Смещение значка состояния по Y"
--[[ ruRU ]] L["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] L["Y offset of the state icon"] = "Смещение значка состояния по Y"
--[[ ruRU ]] L["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] L["Sets the anchor for the state icon"] = "Задает прикрепление значка состояния"
--[[ ruRU ]] L["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] L["Sets the relative point on the health bar to anchor the state icon"] = "Задает точку для положения значка состояния относительно полоски здоровья"
--[[ ruRU ]] L["Alpha"] = "Прозрачность"
--[[ ruRU ]] L["Sets the state icon alpha"] = "Задает прозрачность значка состояния"

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

--[[ zhCN ]] L["State Icon"] = "首领图标"
--[[ zhCN ]] L["State icon placement options"] = "首领图标位置相关设置"
--[[ zhCN ]] L["Enable"] = "启用"
--[[ zhCN ]] L["Enable state icon display on the nameplate"] = "Enable state icon display on the nameplate"
--[[ zhCN ]] L["Reverse"] = "Reverse"
--[[ zhCN ]] L["Reverse the state icon graphic horizontally"] = "Reverse the state icon graphic horizontally"
--[[ zhCN ]] L["Height"] = "尺寸"
--[[ zhCN ]] L["Height in pixels of the state icon"] = "Height in pixels of the state icon"
--[[ zhCN ]] L["Width"] = "尺寸"
--[[ zhCN ]] L["Width in pixels of the state icon"] = "Width in pixels of the state icon"
--[[ zhCN ]] L["Position"] = "位置"
--[[ zhCN ]] L["Adjust state icon position"] = "Adjust state icon position"
--[[ zhCN ]] L["X Offset"] = "X轴偏移"
--[[ zhCN ]] L["X offset of the state icon"] = "X offset of the state icon"
--[[ zhCN ]] L["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] L["Y offset of the state icon"] = "Y offset of the state icon"
--[[ zhCN ]] L["Anchor"] = "锚点"
--[[ zhCN ]] L["Sets the anchor for the state icon"] = "Sets the anchor for the state icon"
--[[ zhCN ]] L["Anchor To"] = "固定在"
--[[ zhCN ]] L["Sets the relative point on the health bar to anchor the state icon"] = "Sets the relative point on the health bar to anchor the state icon"
--[[ zhCN ]] L["Alpha"] = "透明度"
--[[ zhCN ]] L["Sets the state icon alpha"] = "Sets the state icon alpha"

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

--[[ zhTW ]] L["State Icon"] = "首領圖示"
--[[ zhTW ]] L["State icon placement options"] = "首領圖示佈局設定"
--[[ zhTW ]] L["Enable"] = "啟用"
--[[ zhTW ]] L["Enable state icon display on the nameplate"] = "在名牌上顯示首領圖示"
--[[ zhTW ]] L["Reverse"] = "反轉"
--[[ zhTW ]] L["Reverse the state icon graphic horizontally"] = "水平反轉首領圖示圖形"
--[[ zhTW ]] L["Height"] = "高度"
--[[ zhTW ]] L["Height in pixels of the state icon"] = "首領圖示像素高度"
--[[ zhTW ]] L["Width"] = "寬度"
--[[ zhTW ]] L["Width in pixels of the state icon"] = "首領圖示像素寬度"
--[[ zhTW ]] L["Position"] = "位置"
--[[ zhTW ]] L["Adjust state icon position"] = "調整首領圖示位置"
--[[ zhTW ]] L["X Offset"] = "X偏移"
--[[ zhTW ]] L["X offset of the state icon"] = "首領圖示的X偏移"
--[[ zhTW ]] L["Y Offset"] = "Y偏移"
--[[ zhTW ]] L["Y offset of the state icon"] = "首領圖示的Y偏移"
--[[ zhTW ]] L["Anchor"] = "錨點"
--[[ zhTW ]] L["Sets the anchor for the state icon"] = "設定首領圖示的錨點"
--[[ zhTW ]] L["Anchor To"] = "錨點到"
--[[ zhTW ]] L["Sets the relative point on the health bar to anchor the state icon"] = "設定在生命條上錨到首領圖示的相關點"
--[[ zhTW ]] L["Alpha"] = "透明度"
--[[ zhTW ]] L["Sets the state icon alpha"] = "設定首領圖示透明度"

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

AloftLocale.AloftStateIcon = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil
