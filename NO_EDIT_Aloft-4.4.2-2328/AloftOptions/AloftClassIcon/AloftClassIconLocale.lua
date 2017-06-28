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

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

-- TODO: on the surface, this wastes space in the enUS locale; the metatable could just return the canonical string as the localization;
--       BUT, this serves as a default locale, and also will permit the metatable to check/notify on missing locale strings

--[[ enUS ]] L["Class Icon"] = "Class Icon"
--[[ enUS ]] L["Class icon placement options"] = "Class icon placement options"
--[[ enUS ]] L["Enable"] = "Enable"
--[[ enUS ]] L["Enable class icon display on the nameplate"] = "Enable class icon display on the nameplate"
--[[ enUS ]] L["Size"] = "Size"
--[[ enUS ]] L["Size in pixels of the class icon"] = "Size in pixels of the class icon"
--[[ enUS ]] L["Position"] = "Position"
--[[ enUS ]] L["Adjust class icon position"] = "Adjust class icon position"
--[[ enUS ]] L["X Offset"] = "X Offset"
--[[ enUS ]] L["X offset of the class icon"] = "X offset of the class icon"
--[[ enUS ]] L["Y Offset"] = "Y Offset"
--[[ enUS ]] L["Y offset of the class icon"] = "Y offset of the class icon"
--[[ enUS ]] L["Anchor"] = "Anchor"
--[[ enUS ]] L["Sets the anchor for the class icon"] = "Sets the anchor for the class icon"
--[[ enUS ]] L["Anchor To"] = "Anchor To"
--[[ enUS ]] L["Sets the relative point on the health bar to anchor the class icon"] = "Sets the relative point on the health bar to anchor the class icon"
--[[ enUS ]] L["Alpha"] = "Alpha"
--[[ enUS ]] L["Sets the class icon alpha"] = "Sets the class icon alpha"

--[[ enUS ]] L["Totem Enable"] = "Totem Enable"
--[[ enUS ]] L["Enable totem icon display on the nameplate"] = "Enable totem icon display on the nameplate"
--[[ enUS ]] L["Totem Crop"] = "Totem Crop"
--[[ enUS ]] L["Percentage to crop off the outside of the totem icon"] = "Percentage to crop off the outside of the totem icon"

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

--[[ enUS ]] mL["AloftClassIcon"] = "AloftClassIcon"
--[[ enUS ]] mL["Display class icons on nameplates"] = "Display class icons on nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

--[[ koKR ]] L["Class Icon"] = "Class Icon"
--[[ koKR ]] L["Class icon placement options"] = "Class icon placement options"
--[[ koKR ]] L["Enable"] = "사용"
--[[ koKR ]] L["Enable class icon display on the nameplate"] = "Enable class icon display on the nameplate"
--[[ koKR ]] L["Size"] = "크기"
--[[ koKR ]] L["Size in pixels of the class icon"] = "Size in pixels of the class icon"
--[[ koKR ]] L["Position"] = "위치"
--[[ koKR ]] L["Adjust class icon position"] = "Adjust class icon position"
--[[ koKR ]] L["X Offset"] = "X 좌표"
--[[ koKR ]] L["X offset of the class icon"] = "X offset of the class icon"
--[[ koKR ]] L["Y Offset"] = "Y 좌표"
--[[ koKR ]] L["Y offset of the class icon"] = "Y offset of the class icon"
--[[ koKR ]] L["Anchor"] = "앵커"
--[[ koKR ]] L["Sets the anchor for the class icon"] = "Sets the anchor for the class icon"
--[[ koKR ]] L["Anchor To"] = "앵커 위치"
--[[ koKR ]] L["Sets the relative point on the health bar to anchor the class icon"] = "Sets the relative point on the health bar to anchor the class icon"
--[[ koKR ]] L["Alpha"] = "투명도"
--[[ koKR ]] L["Sets the class icon alpha"] = "Sets the class icon alpha"

--[[ koKR ]] L["Totem Enable"] = "Totem Enable"
--[[ koKR ]] L["Enable totem icon display on the nameplate"] = "Enable totem icon display on the nameplate"
--[[ koKR ]] L["Totem Crop"] = "Totem Crop"
--[[ koKR ]] L["Percentage to crop off the outside of the totem icon"] = "Percentage to crop off the outside of the totem icon"

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

--[[ koKR ]] mL["AloftClassIcon"] = "AloftClassIcon"
--[[ koKR ]] mL["Display class icons on nameplates"] = "Display class icons on nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Class Icon"] = "Значок класса"
--[[ ruRU ]] L["Class icon placement options"] = "Настройка размещения значка класса"
--[[ ruRU ]] L["Enable"] = "Включить"
--[[ ruRU ]] L["Enable class icon display on the nameplate"] = "Включить отображение значка класса на табличке"
--[[ ruRU ]] L["Size"] = "Размер"
--[[ ruRU ]] L["Size in pixels of the class icon"] = "Размер значка класса в пикселях"
--[[ ruRU ]] L["Position"] = "Позиция"
--[[ ruRU ]] L["Adjust class icon position"] = "Задать место значка класса"
--[[ ruRU ]] L["X Offset"] = "Смещение по X"
--[[ ruRU ]] L["X offset of the class icon"] = "Смещение значка класса по X"
--[[ ruRU ]] L["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] L["Y offset of the class icon"] = "Смещение значка класса по Y"
--[[ ruRU ]] L["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] L["Sets the anchor for the class icon"] = "Задает прикрепление значка класса"
--[[ ruRU ]] L["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] L["Sets the relative point on the health bar to anchor the class icon"] = "Задает точку для положения значка класса относительно полоски здоровья"
--[[ ruRU ]] L["Alpha"] = "Прозрачность"
--[[ ruRU ]] L["Sets the class icon alpha"] = "Задает прозрачность значка класса"

--[[ ruRU ]] L["Totem Enable"] = "Totem Enable"
--[[ ruRU ]] L["Enable totem icon display on the nameplate"] = "Enable totem icon display on the nameplate"
--[[ ruRU ]] L["Totem Crop"] = "Totem Crop"
--[[ ruRU ]] L["Percentage to crop off the outside of the totem icon"] = "Percentage to crop off the outside of the totem icon"

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

--[[ ruRU ]] mL["AloftClassIcon"] = "AloftClassIcon"
--[[ ruRU ]] mL["Display class icons on nameplates"] = "Отображает иконку класса на табличке"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Class Icon"] = "职业图标"
--[[ zhCN ]] L["Class icon placement options"] = "职业图标位置选项"
--[[ zhCN ]] L["Enable"] = "启用"
--[[ zhCN ]] L["Enable class icon display on the nameplate"] = "在姓名板上显示职业图标"
--[[ zhCN ]] L["Size"] = "尺寸"
--[[ zhCN ]] L["Size in pixels of the class icon"] = "职业图标的大小（单位为像素）"
--[[ zhCN ]] L["Position"] = "位置"
--[[ zhCN ]] L["Adjust class icon position"] = "职业图标位置"
--[[ zhCN ]] L["X Offset"] = "X轴偏移"
--[[ zhCN ]] L["X offset of the class icon"] = "职业图标横轴偏移"
--[[ zhCN ]] L["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] L["Y offset of the class icon"] = "职业图标纵轴偏移"
--[[ zhCN ]] L["Anchor"] = "锚点"
--[[ zhCN ]] L["Sets the anchor for the class icon"] = "职业图标锚点"
--[[ zhCN ]] L["Anchor To"] = "固定在"
--[[ zhCN ]] L["Sets the relative point on the health bar to anchor the class icon"] = "设置职业图标要依附到生命条的哪个位置"
--[[ zhCN ]] L["Alpha"] = "透明度"
--[[ zhCN ]] L["Sets the class icon alpha"] = "设置职业图标透明度"

--[[ zhCN ]] L["Totem Enable"] = "Totem Enable"
--[[ zhCN ]] L["Enable totem icon display on the nameplate"] = "Enable totem icon display on the nameplate"
--[[ zhCN ]] L["Totem Crop"] = "Totem Crop"
--[[ zhCN ]] L["Percentage to crop off the outside of the totem icon"] = "Percentage to crop off the outside of the totem icon"

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

--[[ zhCN ]] mL["AloftClassIcon"] = "职业图标"
--[[ zhCN ]] mL["Display class icons on nameplates"] = "在姓名板上显示职业图标"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Class Icon"] = "職業圖示"
--[[ zhTW ]] L["Class icon placement options"] = "職業圖示位置設定"
--[[ zhTW ]] L["Enable"] = "啟用"
--[[ zhTW ]] L["Enable class icon display on the nameplate"] = "啟用在名牌上顯示職業圖示"
--[[ zhTW ]] L["Size"] = "大小"
--[[ zhTW ]] L["Size in pixels of the class icon"] = "職業圖示的像素大小"
--[[ zhTW ]] L["Position"] = "位置"
--[[ zhTW ]] L["Adjust class icon position"] = "調整職業圖示位置"
--[[ zhTW ]] L["X Offset"] = "X偏移"
--[[ zhTW ]] L["X offset of the class icon"] = "職業圖示的X偏移"
--[[ zhTW ]] L["Y Offset"] = "Y偏移"
--[[ zhTW ]] L["Y offset of the class icon"] = "職業圖示的Y偏移"
--[[ zhTW ]] L["Anchor"] = "錨點"
--[[ zhTW ]] L["Sets the anchor for the class icon"] = "設定職業圖示的錨點"
--[[ zhTW ]] L["Anchor To"] = "錨點到"
--[[ zhTW ]] L["Sets the relative point on the health bar to anchor the class icon"] = "設定在生命條上錨到職業圖示的相關點"
--[[ zhTW ]] L["Alpha"] = "透明度"
--[[ zhTW ]] L["Sets the class icon alpha"] = "設定職業圖示透明度"

--[[ zhTW ]] L["Totem Enable"] = "圖騰啟用"
--[[ zhTW ]] L["Enable totem icon display on the nameplate"] = "啟用在名牌上的圖騰圖示顯示"
--[[ zhTW ]] L["Totem Crop"] = "圖騰裁切"
--[[ zhTW ]] L["Percentage to crop off the outside of the totem icon"] = "以百分比來關閉裁切圖騰圖示的外觀"

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

--[[ zhTW ]] mL["AloftClassIcon"] = "Aloft職業圖示"
--[[ zhTW ]] mL["Display class icons on nameplates"] = "在名牌上顯示職業圖示"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftClassIcon", function()

-----------------------------------------------------------------------------

AloftLocale.AloftClassIcon = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil

-----------------------------------------------------------------------------

end)
