local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

local L = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftRecentlyDamaged", function()

-----------------------------------------------------------------------------

--[[ enUS ]] L["Recently Damaged Icon"] = "Recently Damaged Icon"
--[[ enUS ]] L["Recently damaged icon placement options"] = "Recently damaged icon placement options"
--[[ enUS ]] L["Enable"] = "Enable"
--[[ enUS ]] L["Enable recently damaged icon display on the nameplate"] = "Enable recently damaged icon display on the nameplate"
--[[ enUS ]] L["Size"] = "Size"
--[[ enUS ]] L["Size in pixels of the recently damaged icon"] = "Size in pixels of the recently damaged icon"
--[[ enUS ]] L["Position"] = "Position"
--[[ enUS ]] L["Adjust recently damaged icon position"] = "Adjust recently damaged icon position"
--[[ enUS ]] L["X Offset"] = "X Offset"
--[[ enUS ]] L["X offset of the recently damaged icon"] = "X offset of the recently damaged icon"
--[[ enUS ]] L["Y Offset"] = "Y Offset"
--[[ enUS ]] L["Y offset of the recently damaged icon"] = "Y offset of the recently damaged icon"
--[[ enUS ]] L["Anchor"] = "Anchor"
--[[ enUS ]] L["Sets the anchor for the recently damaged icon"] = "Sets the anchor for the recently damaged icon"
--[[ enUS ]] L["Anchor To"] = "Anchor To"
--[[ enUS ]] L["Sets the relative point on the health bar to anchor the recently damaged icon"] = "Sets the relative point on the health bar to anchor the recently damaged icon"
--[[ enUS ]] L["Alpha"] = "Alpha"
--[[ enUS ]] L["Sets the recently damaged icon alpha"] = "Sets the recently damaged icon alpha"

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

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftRecentlyDamaged"] = "AloftRecentlyDamaged"
--[[ enUS ]] mL["Display recently damaged icon on nameplates"] = "Display recently damaged icon on nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftRecentlyDamaged", function()

-----------------------------------------------------------------------------

--[[ koKR ]] L["Recently Damaged Icon"] = "최근 데미지 아이콘"
--[[ koKR ]] L["Recently damaged icon placement options"] = "최근 데미지 아이콘 배치 설정"
--[[ koKR ]] L["Enable"] = "사용"
--[[ koKR ]] L["Enable recently damaged icon display on the nameplate"] = "이름표에 최근 입힌 데미지 아이콘을 표시합니다."
--[[ koKR ]] L["Size"] = "크기"
--[[ koKR ]] L["Size in pixels of the recently damaged icon"] = "최근 데미지 아이콘의 크기입니다."
--[[ koKR ]] L["Position"] = "위치"
--[[ koKR ]] L["Adjust recently damaged icon position"] = "최근 데미지 아이콘 위치 조절"
--[[ koKR ]] L["X Offset"] = "X 좌표"
--[[ koKR ]] L["X offset of the recently damaged icon"] = "최근 데미지 아이콘의 X 좌표 입니다."
--[[ koKR ]] L["Y Offset"] = "Y 좌표"
--[[ koKR ]] L["Y offset of the recently damaged icon"] = "최근 데미지 아이콘의 Y 좌표 입니다."
--[[ koKR ]] L["Anchor"] = "앵커"
--[[ koKR ]] L["Sets the anchor for the recently damaged icon"] = "최근 데미지 아이콘의 앵커를 설정합니다."
--[[ koKR ]] L["Anchor To"] = "앵커 위치"
--[[ koKR ]] L["Sets the relative point on the health bar to anchor the recently damaged icon"] = "생명력 바에서 최근 데미지 아이콘의 앵커 위치를 설정합니다."
--[[ koKR ]] L["Alpha"] = "투명도"
--[[ koKR ]] L["Sets the recently damaged icon alpha"] = "최근 데미지 아이콘의 투명도를 설정합니다."

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

end)

-----------------------------------------------------------------------------

--[[ koKR ]] L["AloftRecentlyDamaged"] = "AloftRecentlyDamaged"
--[[ koKR ]] L["Display recently damaged icon on nameplates"] = "Display recently damaged icon on nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftRecentlyDamaged", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Recently Damaged Icon"] = "Значок недавно поврежденных"
--[[ ruRU ]] L["Recently damaged icon placement options"] = "Настройки положения для значка недавно поврежденных"
--[[ ruRU ]] L["Enable"] = "Включить"
--[[ ruRU ]] L["Enable recently damaged icon display on the nameplate"] = "Включить значок недавно поврежденного на табличке"
--[[ ruRU ]] L["Size"] = "Размер"
--[[ ruRU ]] L["Size in pixels of the recently damaged icon"] = "Размер значка недавно поврежденного в пикселях"
--[[ ruRU ]] L["Position"] = "Позиция"
--[[ ruRU ]] L["Adjust recently damaged icon position"] = "Задать место значка недавно поврежденного"
--[[ ruRU ]] L["X Offset"] = "Смещение по X"
--[[ ruRU ]] L["X offset of the recently damaged icon"] = "Смещение значка недавно поврежденного по Х"
--[[ ruRU ]] L["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] L["Y offset of the recently damaged icon"] = "Смещение значка недавно поврежденного по Y"
--[[ ruRU ]] L["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] L["Sets the anchor for the recently damaged icon"] = "Задает прикрепление значка недавно поврежденного"
--[[ ruRU ]] L["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] L["Sets the relative point on the health bar to anchor the recently damaged icon"] = "Задает точку для положения значка недавно поврежденного относительно полоски здоровья"
--[[ ruRU ]] L["Alpha"] = "Прозрачность"
--[[ ruRU ]] L["Sets the recently damaged icon alpha"] = "Задает прозрачность значка недавно поврежденного"

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

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftRecentlyDamaged"] = "AloftRecentlyDamaged"
--[[ ruRU ]] mL["Display recently damaged icon on nameplates"] = "Отображает конку недавнего урона"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftRecentlyDamaged", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Recently Damaged Icon"] = "最近受伤图标"
--[[ zhCN ]] L["Recently damaged icon placement options"] = "最近受伤图标位置相关设置"
--[[ zhCN ]] L["Enable"] = "启用"
--[[ zhCN ]] L["Enable recently damaged icon display on the nameplate"] = "在姓名板上显示最近受伤图标"
--[[ zhCN ]] L["Size"] = "尺寸"
--[[ zhCN ]] L["Size in pixels of the recently damaged icon"] = "最近受伤图标的尺寸"
--[[ zhCN ]] L["Position"] = "位置"
--[[ zhCN ]] L["Adjust recently damaged icon position"] = "调整最近受伤图标的位置"
--[[ zhCN ]] L["X Offset"] = "X轴偏移"
--[[ zhCN ]] L["X offset of the recently damaged icon"] = "最近受伤图标的X轴偏移量"
--[[ zhCN ]] L["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] L["Y offset of the recently damaged icon"] = "最近受伤图标的Y轴偏移量"
--[[ zhCN ]] L["Anchor"] = "锚点"
--[[ zhCN ]] L["Sets the anchor for the recently damaged icon"] = "设定最近受伤图标的锚点"
--[[ zhCN ]] L["Anchor To"] = "固定在"
--[[ zhCN ]] L["Sets the relative point on the health bar to anchor the recently damaged icon"] = "设定最近受伤图标固定在生命值显示条的相对位置"
--[[ zhCN ]] L["Alpha"] = "透明度"
--[[ zhCN ]] L["Sets the recently damaged icon alpha"] = "设定最近受伤图标的透明度"

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

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftRecentlyDamaged"] = "最近受伤害"
--[[ zhCN ]] mL["Display recently damaged icon on nameplates"] = "在姓名板上显示最近受伤害图标"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftRecentlyDamaged", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Recently Damaged Icon"] = "最近受傷害圖示"
--[[ zhTW ]] L["Recently damaged icon placement options"] = "最近受傷害圖示佈局設定"
--[[ zhTW ]] L["Enable"] = "啟用"
--[[ zhTW ]] L["Enable recently damaged icon display on the nameplate"] = "啟用在名牌上顯示最近受傷害圖示"
--[[ zhTW ]] L["Size"] = "大小"
--[[ zhTW ]] L["Size in pixels of the recently damaged icon"] = "最近受傷害圖示的像素大小"
--[[ zhTW ]] L["Position"] = "位置"
--[[ zhTW ]] L["Adjust recently damaged icon position"] = "調整最近受傷害圖示位置"
--[[ zhTW ]] L["X Offset"] = "X偏移"
--[[ zhTW ]] L["X offset of the recently damaged icon"] = "最近受傷害圖示的X偏移"
--[[ zhTW ]] L["Y Offset"] = "Y偏移"
--[[ zhTW ]] L["Y offset of the recently damaged icon"] = "最近受傷害圖示的Y偏移"
--[[ zhTW ]] L["Anchor"] = "錨點"
--[[ zhTW ]] L["Sets the anchor for the recently damaged icon"] = "設定最近受傷害圖示的錨點"
--[[ zhTW ]] L["Anchor To"] = "錨點到"
--[[ zhTW ]] L["Sets the relative point on the health bar to anchor the recently damaged icon"] = "設定在生命條上到瞄到最近受傷害圖示的相關點"
--[[ zhTW ]] L["Alpha"] = "透明度"
--[[ zhTW ]] L["Sets the recently damaged icon alpha"] = "設定最近受傷害圖示透明度"

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

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftRecentlyDamaged"] = "Aloft最近受傷害"
--[[ zhTW ]] mL["Display recently damaged icon on nameplates"] = "在名牌上顯示最近受傷害圖示"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftRecentlyDamaged", function()

-----------------------------------------------------------------------------

AloftLocale.AloftRecentlyDamaged = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

-----------------------------------------------------------------------------

end)
