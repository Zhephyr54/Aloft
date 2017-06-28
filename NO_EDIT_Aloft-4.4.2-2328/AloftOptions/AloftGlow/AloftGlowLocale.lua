local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = { }

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] L["Nameplate Glow"] = "Nameplate Glow"
--[[ enUS ]] L["Health bar will be highlighted when unit is attacking player"] = "Health bar will be highlighted when unit is attacking player"
--[[ enUS ]] L["Enable"] = "Enable"
--[[ enUS ]] L["Enable glow"] = "Enable glow"
--[[ enUS ]] L["Invert"] = "Invert"
--[[ enUS ]] L["Invert glow (disable on targets with aggro, enable on targets without aggro)"] = "Invert glow (disable on targets with aggro, enable on targets without aggro)"
--[[ enUS ]] L["Invert Only In Combat"] = "Invert Only In Combat"
--[[ enUS ]] L["Display inverted glow only while in combat"] = "Display inverted glow only while in combat"
--[[ enUS ]] L["Glow Update Interval"] = "Glow Update Interval"
--[[ enUS ]] L["The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"
--[[ enUS ]] L["Use Health Bar"] = "Use Health Bar"
--[[ enUS ]] L["Indicate aggro status via health bar color (instead of glow)"] = "Indicate aggro status via health bar color (instead of glow)"
--[[ enUS ]] L["Explicit Low Threat Indicator"] = "Explicit Low Threat Indicator"
--[[ enUS ]] L["Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"

--[[ enUS ]] L["Explicit Low Threat Indicator Only In Combat"] = "Explicit Low Threat Indicator Only In Combat"
--[[ enUS ]] L["Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"
--[[ enUS ]] L["Invert Only While Tanking"] = "Invert Only While Tanking"
--[[ enUS ]] L["Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"] = "Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"
--[[ enUS ]] L["Recently Damaged Only"] = "Recently Damaged Only"
--[[ enUS ]] L["Treat the player as 'in combat' only with 'recently damaged' targets"] = "Treat the player as 'in combat' only with 'recently damaged' targets"

--[[ enUS ]] L["Size"] = "Size"
--[[ enUS ]] L["Adjust glow size"] = "Adjust glow size"
--[[ enUS ]] L["Width"] = "Width"
--[[ enUS ]] L["Sets the width of the glow"] = "Sets the width of the glow"
--[[ enUS ]] L["Height"] = "Height"
--[[ enUS ]] L["Sets the height of the glow"] = "Sets the height of the glow"

--[[ enUS ]] L["Position"] = "Position"
--[[ enUS ]] L["Adjust the glow position"] = "Adjust the glow position"
--[[ enUS ]] L["X Offset"] = "X Offset"
--[[ enUS ]] L["X offset of the glow"] = "X offset of the glow"
--[[ enUS ]] L["Y Offset"] = "Y Offset"
--[[ enUS ]] L["Y offset of the glow"] = "Y offset of the glow"

--[[ enUS ]] L["Style"] = "Style"
--[[ enUS ]] L["Sets the glow style"] = "Sets the glow style"
--[[ enUS ]] L["Override Color"] = "Override Color"
--[[ enUS ]] L["Overrides the glow default color(s)"] = "Overrides the glow default color(s)"
--[[ enUS ]] L["Color"] = "Color"
--[[ enUS ]] L["Sets the glow color"] = "Sets the glow color"
--[[ enUS ]] L["Blend Mode"] = "Blend Mode"
--[[ enUS ]] L["Sets the glow blend mode"] = "Sets the glow blend mode"

--[[ enUS ]] L["BLEND"] = "BLEND"
--[[ enUS ]] L["ADD"] = "ADD"

--[[ enUS ]] L["HARD"] = "HARD"
--[[ enUS ]] L["SOFT"] = "SOFT"
--[[ enUS ]] L["PRTLSOFT"]= "PRTLSOFT"
--[[ enUS ]] L["THRQTRSOFT"] = "THRQTRSOFT"
--[[ enUS ]] L["EXTRASOFT"] = "EXTRASOFT"
--[[ enUS ]] L["OVAL"] = "OVAL"
--[[ enUS ]] L["OVALGLOW"] = "OVALGLOW"
--[[ enUS ]] L["SQUAREGLOW"] = "SQUAREGLOW"
--[[ enUS ]] L["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW"
--[[ enUS ]] L["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW"

--[[ enUS ]] L["Threat Status Colors"] = "Threat Status Colors"
--[[ enUS ]] L["Customize nameplate glow threat status colors"] = "Customize nameplate glow threat status colors"
--[[ enUS ]] L["Low Threat"] = "Low Threat"
--[[ enUS ]] L["Over-Nuking"] = "Over-Nuking"
--[[ enUS ]] L["Losing Threat"] = "Losing Threat"
--[[ enUS ]] L["Tanking Securely"] = "Tanking Securely"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

--[[ koKR ]] L["Nameplate Glow"] = "Nameplate Glow"
--[[ koKR ]] L["Health bar will be highlighted when unit is attacking player"] = "Health bar will be highlighted when unit is attacking player"
--[[ koKR ]] L["Enable"] = "사용"
--[[ koKR ]] L["Enable glow"] = "Enable glow"
--[[ koKR ]] L["Invert"] = "Invert"
--[[ koKR ]] L["Invert glow (disable on targets with aggro, enable on targets without aggro)"] = "Invert glow (disable on targets with aggro, enable on targets without aggro)"
--[[ koKR ]] L["Invert Only In Combat"] = "Invert Only In Combat"
--[[ koKR ]] L["Display inverted glow only while in combat"] = "Display inverted glow only while in combat"
--[[ koKR ]] L["Glow Update Interval"] = "Glow Update Interval"
--[[ koKR ]] L["The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"
--[[ koKR ]] L["Use Health Bar"] = "Use Health Bar"
--[[ koKR ]] L["Indicate aggro status via health bar color (instead of glow)"] = "Indicate aggro status via health bar color (instead of glow)"
--[[ koKR ]] L["Explicit Low Threat Indicator"] = "Explicit Low Threat Indicator"
--[[ koKR ]] L["Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"

--[[ koKR ]] L["Explicit Low Threat Indicator Only In Combat"] = "Explicit Low Threat Indicator Only In Combat"
--[[ koKR ]] L["Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"
--[[ koKR ]] L["Invert Only While Tanking"] = "Invert Only While Tanking"
--[[ koKR ]] L["Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"] = "Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"
--[[ koKR ]] L["Recently Damaged Only"] = "Recently Damaged Only"
--[[ koKR ]] L["Treat the player as 'in combat' only with 'recently damaged' targets"] = "Treat the player as 'in combat' only with 'recently damaged' targets"

--[[ koKR ]] L["Size"] = "크기"
--[[ koKR ]] L["Adjust glow size"] = "Adjust glow size"
--[[ koKR ]] L["Width"] = "너비"
--[[ koKR ]] L["Sets the width of the glow"] = "Sets the width of the glow"
--[[ koKR ]] L["Height"] = "높이"
--[[ koKR ]] L["Sets the height of the glow"] = "Sets the height of the glow"

--[[ koKR ]] L["Position"] = "위치"
--[[ koKR ]] L["Adjust the glow position"] = "Adjust the glow position"
--[[ koKR ]] L["X Offset"] = "X 좌표"
--[[ koKR ]] L["X offset of the glow"] = "X offset of the glow"
--[[ koKR ]] L["Y Offset"] = "Y 좌표"
--[[ koKR ]] L["Y offset of the glow"] = "Y offset of the glow"

--[[ koKR ]] L["Style"] = "Style"
--[[ koKR ]] L["Sets the glow style"] = "Sets the glow style"
--[[ koKR ]] L["Override Color"] = "Override Color"
--[[ koKR ]] L["Overrides the glow default color(s)"] = "Overrides the glow default color(s)"
--[[ koKR ]] L["Color"] = "Color"
--[[ koKR ]] L["Sets the glow color"] = "Sets the glow color"
--[[ koKR ]] L["Blend Mode"] = "Blend Mode"
--[[ koKR ]] L["Sets the glow blend mode"] = "Sets the glow blend mode"

--[[ koKR ]] L["BLEND"] = "혼합"
--[[ koKR ]] L["ADD"] = "추가"

--[[ koKR ]] L["HARD"] = "HARD"
--[[ koKR ]] L["SOFT"] = "SOFT"
--[[ koKR ]] L["PRTLSOFT"] = "PRTLSOFT"
--[[ koKR ]] L["THRQTRSOFT"] = "THRQTRSOFT"
--[[ koKR ]] L["EXTRASOFT"] = "EXTRASOFT"
--[[ koKR ]] L["OVAL"] = "OVAL"
--[[ koKR ]] L["OVALGLOW"] = "OVALGLOW"
--[[ koKR ]] L["SQUAREGLOW"] = "SQUAREGLOW"
--[[ koKR ]] L["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW"
--[[ koKR ]] L["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW"

--[[ koKR ]] L["Threat Status Colors"] = "Threat Status Colors"
--[[ koKR ]] L["Customize nameplate glow threat status colors"] = "Customize nameplate glow threat status colors"
--[[ koKR ]] L["Low Threat"] = "Low Threat"
--[[ koKR ]] L["Over-Nuking"] = "Over-Nuking"
--[[ koKR ]] L["Losing Threat"] = "Losing Threat"
--[[ koKR ]] L["Tanking Securely"] = "Tanking Securely"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

--[[ ruRU ]] L["Nameplate Glow"] = "Свечение таблички"
--[[ ruRU ]] L["Health bar will be highlighted when unit is attacking player"] = "Полоса здоровья будет выделяться, когда персонаж/существо нападает на игрока"
--[[ ruRU ]] L["Enable"] = "Включить"
--[[ ruRU ]] L["Enable glow"] = "Включить свечение"
--[[ ruRU ]] L["Invert"] = "Инвертировать"
--[[ ruRU ]] L["Invert glow (disable on targets with aggro, enable on targets without aggro)"] = "Инвертировать свечение (отключить на цели с аггро, включить на цели без аггро)"
--[[ ruRU ]] L["Invert Only In Combat"] = "Инвертировать только в бою"
--[[ ruRU ]] L["Display inverted glow only while in combat"] = "Инвертировать свечение только когда вы находитесь в бою"
--[[ ruRU ]] L["Glow Update Interval"] = "Интервал обновления свечения"
--[[ ruRU ]] L["The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"] = "Время в секундах между обновлениями свечения (0.0 максимальная скорость)"
--[[ ruRU ]] L["Use Health Bar"] = "Исп полосу здоровья"
--[[ ruRU ]] L["Indicate aggro status via health bar color (instead of glow)"] = "Отображение статуса аггро цветом в полосе здоровья (вместо отсвета)"
--[[ ruRU ]] L["Explicit Low Threat Indicator"] = "Индикатор низкой угрозы"
--[[ ruRU ]] L["Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"] = "Показывать статус 'Мало угрозы' свечениев в цвете на табличке (или если включено 'Инвертировать', показывать статус 'Безопасное танкование')"

--[[ ruRU ]] L["Explicit Low Threat Indicator Only In Combat"] = "Explicit Low Threat Indicator Only In Combat"
--[[ ruRU ]] L["Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"
--[[ ruRU ]] L["Invert Only While Tanking"] = "Invert Only While Tanking"
--[[ ruRU ]] L["Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"] = "Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"
--[[ ruRU ]] L["Recently Damaged Only"] = "Recently Damaged Only"
--[[ ruRU ]] L["Treat the player as 'in combat' only with 'recently damaged' targets"] = "Treat the player as 'in combat' only with 'recently damaged' targets"

--[[ ruRU ]] L["Size"] = "Размер"
--[[ ruRU ]] L["Adjust glow size"] = "Задать размер свечения"
--[[ ruRU ]] L["Width"] = "Ширина"
--[[ ruRU ]] L["Sets the width of the glow"] = "Задает ширину свечения"
--[[ ruRU ]] L["Height"] = "Высота"
--[[ ruRU ]] L["Sets the height of the glow"] = "Задает высоту свечения"

--[[ ruRU ]] L["Position"] = "Позиция"
--[[ ruRU ]] L["Adjust the glow position"] = "Задать место свечения"
--[[ ruRU ]] L["X Offset"] = "Смещение по X"
--[[ ruRU ]] L["X offset of the glow"] = "Смещение свечения по X"
--[[ ruRU ]] L["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] L["Y offset of the glow"] = "Смещение свечения по Y"

--[[ ruRU ]] L["Style"] = "Стиль"
--[[ ruRU ]] L["Sets the glow style"] = "Задает стиль свечения"
--[[ ruRU ]] L["Override Color"] = "Перезапись цвета"
--[[ ruRU ]] L["Overrides the glow default color(s)"] = "Перезапись цвета(ов) по умолчанию для свечения"
--[[ ruRU ]] L["Color"] = "Цвет"
--[[ ruRU ]] L["Sets the glow color"] = "Задает цвет свечения"
--[[ ruRU ]] L["Blend Mode"] = "Режим смешивания"
--[[ ruRU ]] L["Sets the glow blend mode"] = "Задает тип смешения для свечения"

--[[ ruRU ]] L["BLEND"] = "СМЕШИВАТЬ"
--[[ ruRU ]] L["ADD"] = "ДОБАВИТЬ"

--[[ ruRU ]] L["HARD"] = "СИЛЬНОЕ"
--[[ ruRU ]] L["SOFT"] = "МЯГКОЕ"
--[[ ruRU ]] L["PRTLSOFT"] = "PRTLSOFT"
--[[ ruRU ]] L["THRQTRSOFT"] = "THRQTRSOFT"
--[[ ruRU ]] L["EXTRASOFT"] = "СВЕРХМЯГКОЕ"
--[[ ruRU ]] L["OVAL"] = "ОВАЛ"
--[[ ruRU ]] L["OVALGLOW"] = "ОВАЛСВЕЧЕНИЕ"
--[[ ruRU ]] L["SQUAREGLOW"] = "КВАДРАТНОЕ СВЕЧЕНИЕ"
--[[ ruRU ]] L["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW"
--[[ ruRU ]] L["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW"

--[[ ruRU ]] L["Threat Status Colors"] = "Цвет статуса угрозы"
--[[ ruRU ]] L["Customize nameplate glow threat status colors"] = "Настройка цвета свечения статуса угрозы"
--[[ ruRU ]] L["Low Threat"] = "Мало угрозы"
--[[ ruRU ]] L["Over-Nuking"] = "Over-Nuking"
--[[ ruRU ]] L["Losing Threat"] = "Losing Threat"
--[[ ruRU ]] L["Tanking Securely"] = "Безопасное танкование"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

--[[ zhCN ]] L["Nameplate Glow"] = "姓名板发光"
--[[ zhCN ]] L["Health bar will be highlighted when unit is attacking player"] = "正在攻击玩家的单位的生命条会高亮显示"
--[[ zhCN ]] L["Enable"] = "启用"
--[[ zhCN ]] L["Enable glow"] = "启用发光"
--[[ zhCN ]] L["Invert"] = "反向"
--[[ zhCN ]] L["Invert glow (disable on targets with aggro, enable on targets without aggro)"] = "反向发光（无仇恨目标发光，有仇恨则不发光）"
--[[ zhCN ]] L["Invert Only In Combat"] = "Invert Only In Combat"
--[[ zhCN ]] L["Display inverted glow only while in combat"] = "Display inverted glow only while in combat"
--[[ zhCN ]] L["Glow Update Interval"] = "发光更新频率"
--[[ zhCN ]] L["The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"] = "两次闪光间的时间间隔（秒为单位，0为最快）"
--[[ zhCN ]] L["Use Health Bar"] = "Use Health Bar"
--[[ zhCN ]] L["Indicate aggro status via health bar color (instead of glow)"] = "Indicate aggro status via health bar color (instead of glow)"
--[[ zhCN  ]] L["Explicit Low Threat Indicator"] = "Explicit Low Threat Indicator"
--[[ zhCN  ]] L["Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"

--[[ zhCN ]] L["Explicit Low Threat Indicator Only In Combat"] = "Explicit Low Threat Indicator Only In Combat"
--[[ zhCN ]] L["Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"
--[[ zhCN ]] L["Invert Only While Tanking"] = "Invert Only While Tanking"
--[[ zhCN ]] L["Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"] = "Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"
--[[ zhCN ]] L["Recently Damaged Only"] = "Recently Damaged Only"
--[[ zhCN ]] L["Treat the player as 'in combat' only with 'recently damaged' targets"] = "Treat the player as 'in combat' only with 'recently damaged' targets"

--[[ zhCN ]] L["Size"] = "尺寸"
--[[ zhCN ]] L["Adjust glow size"] = "调整闪烁范围"
--[[ zhCN ]] L["Width"] = "宽度"
--[[ zhCN ]] L["Sets the width of the glow"] = "闪烁宽度"
--[[ zhCN ]] L["Height"] = "高度"
--[[ zhCN ]] L["Sets the height of the glow"] = "闪烁高度"

--[[ zhCN ]] L["Position"] = "位置"
--[[ zhCN ]] L["Adjust the glow position"] = "调整闪烁位置"
--[[ zhCN ]] L["X Offset"] = "X轴偏移"
--[[ zhCN ]] L["X offset of the glow"] = "闪烁横向偏移"
--[[ zhCN ]] L["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] L["Y offset of the glow"] = "闪烁纵向偏移"

--[[ zhCN ]] L["Style"] = "样式"
--[[ zhCN ]] L["Sets the glow style"] = "设置发光样式"
--[[ zhCN ]] L["Override Color"] = "强制使用颜色"
--[[ zhCN ]] L["Overrides the glow default color(s)"] = "强制使用闪光颜色"
--[[ zhCN ]] L["Color"] = "颜色"
--[[ zhCN ]] L["Sets the glow color"] = "闪光颜色"
--[[ zhCN ]] L["Blend Mode"] = "渐变模式"
--[[ zhCN ]] L["Sets the glow blend mode"] = "发光使用渐变模式"

--[[ zhCN ]] L["BLEND"] = "渲染"
--[[ zhCN ]] L["ADD"] = "增加"

--[[ zhCN ]] L["HARD"] = "软边"
--[[ zhCN ]] L["SOFT"] = "硬边"
--[[ zhCN ]] L["PRTLSOFT"] = "PRTLSOFT"
--[[ zhCN ]] L["THRQTRSOFT"] = "THRQTRSOFT"
--[[ zhCN ]] L["EXTRASOFT"] = "超软边"
--[[ zhCN ]] L["OVAL"] = "OVAL"
--[[ zhCN ]] L["OVALGLOW"] = "OVALGLOW"
--[[ zhCN ]] L["SQUAREGLOW"] = "SQUAREGLOW"
--[[ zhCN ]] L["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW"
--[[ zhCN ]] L["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW"

--[[ zhCN ]] L["Threat Status Colors"] = "Threat Status Colors"
--[[ zhCN ]] L["Customize nameplate glow threat status colors"] = "Customize nameplate glow threat status colors"
--[[ zhCN ]] L["Low Threat"] = "Low Threat"
--[[ zhCN ]] L["Over-Nuking"] = "Over-Nuking"
--[[ zhCN ]] L["Losing Threat"] = "Losing Threat"
--[[ zhCN ]] L["Tanking Securely"] = "Tanking Securely"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

--[[ zhTW ]] L["Nameplate Glow"] = "名牌發光"
--[[ zhTW ]] L["Health bar will be highlighted when unit is attacking player"] = "正在攻擊玩家的單位的生命條會高亮顯示"
--[[ zhTW ]] L["Enable"] = "啟用"
--[[ zhTW ]] L["Enable glow"] = "啟用發光"
--[[ zhTW ]] L["Invert"] = "反向"
--[[ zhTW ]] L["Invert glow (disable on targets with aggro, enable on targets without aggro)"] = "反向發光(無仇恨目標發光，有仇恨則不發光)"
--[[ zhTW ]] L["Invert Only In Combat"] = "只在戰鬥中反轉"
--[[ zhTW ]] L["Display inverted glow only while in combat"] = "只在戰鬥中反轉發光顯示"
--[[ zhTW ]] L["Glow Update Interval"] = "發光更新頻率"
--[[ zhTW ]] L["The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"] = "兩次閃光間的時間間隔（秒為單位，0為最快）"
--[[ zhTW ]] L["Use Health Bar"] = "使用生命條"
--[[ zhTW ]] L["Indicate aggro status via health bar color (instead of glow)"] = "透過仇恨來標示生命條狀態(而不是發光)"
--[[ zhTW ]] L["Explicit Low Threat Indicator"] = "明確的低仇恨指示"
--[[ zhTW ]] L["Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"] = "明確'低仇恨'狀態作為發光或名牌顏色(或如果'反轉'啟用，明確低標示'坦克穩固'狀態'"

--[[ zhTW ]] L["Explicit Low Threat Indicator Only In Combat"] = "只在戰鬥中明確的低仇恨指示"
--[[ zhTW ]] L["Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"] = "明確'低仇恨'狀態在戰鬥中作為發光或名牌顏色"
--[[ zhTW ]] L["Invert Only While Tanking"] = "只在坦克時反轉"
--[[ zhTW ]] L["Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"] = "反轉發光只在坦克時(戰士/防禦姿態、死亡騎士/血領域、德魯伊/熊型態，聖騎士/正義之怒)"
--[[ zhTW ]] L["Recently Damaged Only"] = "只在最近可傷害"
--[[ zhTW ]] L["Treat the player as 'in combat' only with 'recently damaged' targets"] = "'戰鬥中'仇恨的玩家，只顯示'最近可傷害'目標"

--[[ zhTW ]] L["Size"] = "大小"
--[[ zhTW ]] L["Adjust glow size"] = "調整發光大小"
--[[ zhTW ]] L["Width"] = "寬度"
--[[ zhTW ]] L["Sets the width of the glow"] = "設定發光的寬度"
--[[ zhTW ]] L["Height"] = "高度"
--[[ zhTW ]] L["Sets the height of the glow"] = "設定發光的高度"

--[[ zhTW ]] L["Position"] = "位置"
--[[ zhTW ]] L["Adjust the glow position"] = "調整發光位置"
--[[ zhTW ]] L["X Offset"] = "X偏移"
--[[ zhTW ]] L["X offset of the glow"] = "發光的X偏移"
--[[ zhTW ]] L["Y Offset"] = "Y偏移"
--[[ zhTW ]] L["Y offset of the glow"] = "發光的Y偏移"

--[[ zhTW ]] L["Style"] = "樣式"
--[[ zhTW ]] L["Sets the glow style"] = "設定發光樣式"
--[[ zhTW ]] L["Override Color"] = "覆蓋顏色"
--[[ zhTW ]] L["Overrides the glow default color(s)"] = "覆蓋預設發光顏色"
--[[ zhTW ]] L["Color"] = "顏色"
--[[ zhTW ]] L["Sets the glow color"] = "設定發光顏色"
--[[ zhTW ]] L["Blend Mode"] = "混和模式"
--[[ zhTW ]] L["Sets the glow blend mode"] = "設定發光混和模式"

--[[ zhTW ]] L["BLEND"] = "混合"
--[[ zhTW ]] L["ADD"] = "增加"

--[[ zhTW ]] L["HARD"] = "生硬"
--[[ zhTW ]] L["SOFT"] = "柔和"
--[[ zhTW ]] L["PRTLSOFT"] = "PRTL柔和"
--[[ zhTW ]] L["THRQTRSOFT"] = "THRQTR柔和"
--[[ zhTW ]] L["EXTRASOFT"] = "超軟邊"
--[[ zhTW ]] L["OVAL"] = "橢圓形"
--[[ zhTW ]] L["OVALGLOW"] = "橢圓形發光"
--[[ zhTW ]] L["SQUAREGLOW"] = "正方形發光"
--[[ zhTW ]] L["PRTLSQUAREGLOW"] = "PRTL正方形發光"
--[[ zhTW ]] L["THRQTRSQUAREGLOW"] = "THRQTR正方形發光"

--[[ zhTW ]] L["Threat Status Colors"] = "仇恨狀態顏色"
--[[ zhTW ]] L["Customize nameplate glow threat status colors"] = "自訂名牌發光的仇恨狀態顏色"
--[[ zhTW ]] L["Low Threat"] = "低仇恨"
--[[ zhTW ]] L["Over-Nuking"] = "超過仇恨"
--[[ zhTW ]] L["Losing Threat"] = "失去仇恨"
--[[ zhTW ]] L["Tanking Securely"] = "坦克穩固"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftLocale.AloftGlow = setmetatable(L, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
L = nil