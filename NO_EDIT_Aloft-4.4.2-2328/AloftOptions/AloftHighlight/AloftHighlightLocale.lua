local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Highlight"] = "Highlight"
--[[ enUS ]] L["Mouseover highlight options"] = "Mouseover highlight options"
--[[ enUS ]] L["Color"] = "Color"
--[[ enUS ]] L["Sets the highlight color"] = "Sets the highlight color"
--[[ enUS ]] L["Texture"] = "Texture"
--[[ enUS ]] L["Sets the highlight texture"] = "Sets the highlight texture"
--[[ enUS ]] L["Blend Mode"] = "Blend Mode"
--[[ enUS ]] L["Sets the blend mode for the highlight texture"] = "Sets the blend mode for the highlight texture"

--[[ enUS ]] L["BLEND"] = "BLEND"
--[[ enUS ]] L["ADD"] = "ADD"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Highlight"] = "강조"
--[[ koKR ]] L["Mouseover highlight options"] = "마우스 오버 시 강조 설정"
--[[ koKR ]] L["Color"] = "색상"
--[[ koKR ]] L["Sets the highlight color"] = "강조 색상을 설정합니다."
--[[ koKR ]] L["Texture"] = "텍스쳐"
--[[ koKR ]] L["Sets the highlight texture"] = "강조 텍스쳐를 설정합니다."
--[[ koKR ]] L["Blend Mode"] = "혼합 모드"
--[[ koKR ]] L["Sets the blend mode for the highlight texture"] = "강조 텍스쳐에 혼합 모드를 설정합니다."

--[[ koKR ]] L["BLEND"] = "혼합"
--[[ koKR ]] L["ADD"] = "추가"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Highlight"] = "Подсветка"
--[[ ruRU ]] L["Mouseover highlight options"] = "Настроки подсветки для цели под курсором"
--[[ ruRU ]] L["Color"] = "Цвет"
--[[ ruRU ]] L["Sets the highlight color"] = "Задает цвета подсветки"
--[[ ruRU ]] L["Texture"] = "Текстура"
--[[ ruRU ]] L["Sets the highlight texture"] = "Задает текстуры подсветки"
--[[ ruRU ]] L["Blend Mode"] = "Режим смешивания"
--[[ ruRU ]] L["Sets the blend mode for the highlight texture"] = "Задает режим смешения для текстуры подсветки"

--[[ ruRU ]] L["BLEND"] = "СМЕШИВАТЬ"
--[[ ruRU ]] L["ADD"] = "ДОБАВИТЬ"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Highlight"] = "高亮"
--[[ zhCN ]] L["Mouseover highlight options"] = "鼠标悬浮目标高亮相关设置"
--[[ zhCN ]] L["Color"] = "颜色"
--[[ zhCN ]] L["Sets the highlight color"] = "设定高亮的颜色"
--[[ zhCN ]] L["Texture"] = "材质"
--[[ zhCN ]] L["Sets the highlight texture"] = "设定高亮的材质"
--[[ zhCN ]] L["Blend Mode"] = "渲染模式"
--[[ zhCN ]] L["Sets the blend mode for the highlight texture"] = "设定高亮的材质渲染模式"

--[[ zhCN ]] L["BLEND"] = "渲染"
--[[ zhCN ]] L["ADD"] = "增加"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Highlight"] = "高亮"
--[[ zhTW ]] L["Mouseover highlight options"] = "滑鼠經過高亮設定"
--[[ zhTW ]] L["Color"] = "顏色"
--[[ zhTW ]] L["Sets the highlight color"] = "設定高亮顏色"
--[[ zhTW ]] L["Texture"] = "材質"
--[[ zhTW ]] L["Sets the highlight texture"] = "設定高亮材質"
--[[ zhTW ]] L["Blend Mode"] = "混合模式"
--[[ zhTW ]] L["Sets the blend mode for the highlight texture"] = "設定高亮材質的混和模式"

--[[ zhTW ]] L["BLEND"] = "混合"
--[[ zhTW ]] L["ADD"] = "增加"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftHighlight = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil