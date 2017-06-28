local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftGlowOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Nameplate Glow"] = true,
	--[[ enUS ]] ["Health bar will be highlighted when unit is attacking player"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Enable glow"] = true,
	--[[ enUS ]] ["Invert"] = true,
	--[[ enUS ]] ["Invert glow (disable on targets with aggro, enable on targets without aggro)"] = true,
	--[[ enUS ]] ["Invert Only In Combat"] = true,
	--[[ enUS ]] ["Display inverted glow only while in combat"] = true,
	--[[ enUS ]] ["Glow Update Interval"] = true,
	--[[ enUS ]] ["The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"] = true,
	--[[ enUS ]] ["Use Health Bar"] = true,
	--[[ enUS ]] ["Indicate aggro status via health bar color (instead of glow)"] = true,
	--[[ enUS ]] ["Explicit Low Threat Indicator"] = true,
	--[[ enUS ]] ["Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"] = true,

	--[[ enUS ]] ["Explicit Low Threat Indicator Only In Combat"] = true,
	--[[ enUS ]] ["Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"] = true,
	--[[ enUS ]] ["Invert Only While Tanking"] = true,
	--[[ enUS ]] ["Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"] = true,
	--[[ enUS ]] ["Recently Damaged Only"] = true,
	--[[ enUS ]] ["Treat the player as 'in combat' only with 'recently damaged' targets"] = true,

	--[[ enUS ]] ["Size"] = true,
	--[[ enUS ]] ["Adjust glow size"] = true,
	--[[ enUS ]] ["Width"] = true,
	--[[ enUS ]] ["Sets the width of the glow"] = true,
	--[[ enUS ]] ["Height"] = true,
	--[[ enUS ]] ["Sets the height of the glow"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust the glow position"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the glow"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the glow"] = true,

	--[[ enUS ]] ["Style"] = true,
	--[[ enUS ]] ["Sets the glow style"] = true,
	--[[ enUS ]] ["Override Color"] = true,
	--[[ enUS ]] ["Overrides the glow default color(s)"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the glow color"] = true,
	--[[ enUS ]] ["Blend Mode"] = true,
	--[[ enUS ]] ["Sets the glow blend mode"] = true,

	--[[ enUS ]] ["BLEND"] = true,
	--[[ enUS ]] ["ADD"] = true,

	--[[ enUS ]] ["HARD"] = true,
	--[[ enUS ]] ["SOFT"] = true,
	--[[ enUS ]] ["PRTLSOFT"]= true,
	--[[ enUS ]] ["THRQTRSOFT"] = true,
	--[[ enUS ]] ["EXTRASOFT"] = true,
	--[[ enUS ]] ["OVAL"] = true,
	--[[ enUS ]] ["OVALGLOW"] = true,
	--[[ enUS ]] ["SQUAREGLOW"] = true,
	--[[ enUS ]] ["PRTLSQUAREGLOW"] = true,
	--[[ enUS ]] ["THRQTRSQUAREGLOW"] = true,

	--[[ enUS ]] ["Threat Status Colors"] = true,
	--[[ enUS ]] ["Customize nameplate glow threat status colors"] = true,
	--[[ enUS ]] ["Low Threat"] = true,
	--[[ enUS ]] ["Over-Nuking"] = true,
	--[[ enUS ]] ["Losing Threat"] = true,
	--[[ enUS ]] ["Tanking Securely"] = true,
} end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

L:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Nameplate Glow"] = "Nameplate Glow",
	--[[ koKR ]] ["Health bar will be highlighted when unit is attacking player"] = "Health bar will be highlighted when unit is attacking player",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Enable glow"] = "Enable glow",
	--[[ koKR ]] ["Invert"] = "Invert",
	--[[ koKR ]] ["Invert glow (disable on targets with aggro, enable on targets without aggro)"] = "Invert glow (disable on targets with aggro, enable on targets without aggro)",
	--[[ koKR ]] ["Invert Only In Combat"] = "Invert Only In Combat",
	--[[ koKR ]] ["Display inverted glow only while in combat"] = "Display inverted glow only while in combat",
	--[[ koKR ]] ["Glow Update Interval"] = "Glow Update Interval",
	--[[ koKR ]] ["The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between glow updates (0.0 is as fast as possible)",
	--[[ koKR ]] ["Use Health Bar"] = "Use Health Bar",
	--[[ koKR ]] ["Indicate aggro status via health bar color (instead of glow)"] = "Indicate aggro status via health bar color (instead of glow)",
	--[[ koKR ]] ["Explicit Low Threat Indicator"] = "Explicit Low Threat Indicator",
	--[[ koKR ]] ["Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)",

	--[[ koKR ]] ["Explicit Low Threat Indicator Only In Combat"] = "Explicit Low Threat Indicator Only In Combat",
	--[[ koKR ]] ["Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat",
	--[[ koKR ]] ["Invert Only While Tanking"] = "Invert Only While Tanking",
	--[[ koKR ]] ["Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"] = "Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)",
	--[[ koKR ]] ["Recently Damaged Only"] = "Recently Damaged Only",
	--[[ koKR ]] ["Treat the player as 'in combat' only with 'recently damaged' targets"] = "Treat the player as 'in combat' only with 'recently damaged' targets",

	--[[ koKR ]] ["Size"] = "크기",
	--[[ koKR ]] ["Adjust glow size"] = "Adjust glow size",
	--[[ koKR ]] ["Width"] = "너비",
	--[[ koKR ]] ["Sets the width of the glow"] = "Sets the width of the glow",
	--[[ koKR ]] ["Height"] = "높이",
	--[[ koKR ]] ["Sets the height of the glow"] = "Sets the height of the glow",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust the glow position"] = "Adjust the glow position",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the glow"] = "X offset of the glow",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the glow"] = "Y offset of the glow",

	--[[ koKR ]] ["Style"] = "Style",
	--[[ koKR ]] ["Sets the glow style"] = "Sets the glow style",
	--[[ koKR ]] ["Override Color"] = "Override Color",
	--[[ koKR ]] ["Overrides the glow default color(s)"] = "Overrides the glow default color(s)",
	--[[ koKR ]] ["Color"] = "Color",
	--[[ koKR ]] ["Sets the glow color"] = "Sets the glow color",
	--[[ koKR ]] ["Blend Mode"] = "Blend Mode",
	--[[ koKR ]] ["Sets the glow blend mode"] = "Sets the glow blend mode",

	--[[ koKR ]] ["BLEND"] = "혼합",
	--[[ koKR ]] ["ADD"] = "추가",

	--[[ koKR ]] ["HARD"] = "HARD",
	--[[ koKR ]] ["SOFT"] = "SOFT",
	--[[ koKR ]] ["PRTLSOFT"] = "PRTLSOFT",
	--[[ koKR ]] ["THRQTRSOFT"] = "THRQTRSOFT",
	--[[ koKR ]] ["EXTRASOFT"] = "EXTRASOFT",
	--[[ koKR ]] ["OVAL"] = "OVAL",
	--[[ koKR ]] ["OVALGLOW"] = "OVALGLOW",
	--[[ koKR ]] ["SQUAREGLOW"] = "SQUAREGLOW",
	--[[ koKR ]] ["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW",
	--[[ koKR ]] ["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW",

	--[[ koKR ]] ["Threat Status Colors"] = "Threat Status Colors",
	--[[ koKR ]] ["Customize nameplate glow threat status colors"] = "Customize nameplate glow threat status colors",
	--[[ koKR ]] ["Low Threat"] = "Low Threat",
	--[[ koKR ]] ["Over-Nuking"] = "Over-Nuking",
	--[[ koKR ]] ["Losing Threat"] = "Losing Threat",
	--[[ koKR ]] ["Tanking Securely"] = "Tanking Securely",
} end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

L:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Nameplate Glow"] = "Свечение таблички",
	--[[ ruRU ]] ["Health bar will be highlighted when unit is attacking player"] = "Полоса здоровья будет выделяться, когда персонаж/существо нападает на игрока",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Enable glow"] = "Включить свечение",
	--[[ ruRU ]] ["Invert"] = "Инвертировать",
	--[[ ruRU ]] ["Invert glow (disable on targets with aggro, enable on targets without aggro)"] = "Инвертировать свечение (отключить на цели с аггро, включить на цели без аггро)",
	--[[ ruRU ]] ["Invert Only In Combat"] = "Инвертировать только в бою",
	--[[ ruRU ]] ["Display inverted glow only while in combat"] = "Инвертировать свечение только когда вы находитесь в бою",
	--[[ ruRU ]] ["Glow Update Interval"] = "Интервал обновления свечения",
	--[[ ruRU ]] ["The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"] = "Время в секундах между обновлениями свечения (0.0 максимальная скорость)",
	--[[ ruRU ]] ["Use Health Bar"] = "Исп полосу здоровья",
	--[[ ruRU ]] ["Indicate aggro status via health bar color (instead of glow)"] = "Отображение статуса аггро цветом в полосе здоровья (вместо отсвета)",
	--[[ ruRU ]] ["Explicit Low Threat Indicator"] = "Индикатор низкой угрозы",
	--[[ ruRU ]] ["Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"] = "Показывать статус 'Мало угрозы' свечениев в цвете на табличке (или если включено 'Инвертировать', показывать статус 'Безопасное танкование')",

	--[[ ruRU ]] ["Explicit Low Threat Indicator Only In Combat"] = "Explicit Low Threat Indicator Only In Combat",
	--[[ ruRU ]] ["Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat",
	--[[ ruRU ]] ["Invert Only While Tanking"] = "Invert Only While Tanking",
	--[[ ruRU ]] ["Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"] = "Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)",
	--[[ ruRU ]] ["Recently Damaged Only"] = "Recently Damaged Only",
	--[[ ruRU ]] ["Treat the player as 'in combat' only with 'recently damaged' targets"] = "Treat the player as 'in combat' only with 'recently damaged' targets",

	--[[ ruRU ]] ["Size"] = "Размер",
	--[[ ruRU ]] ["Adjust glow size"] = "Задать размер свечения",
	--[[ ruRU ]] ["Width"] = "Ширина",
	--[[ ruRU ]] ["Sets the width of the glow"] = "Задает ширину свечения",
	--[[ ruRU ]] ["Height"] = "Высота",
	--[[ ruRU ]] ["Sets the height of the glow"] = "Задает высоту свечения",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust the glow position"] = "Задать место свечения",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the glow"] = "Смещение свечения по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the glow"] = "Смещение свечения по Y",

	--[[ ruRU ]] ["Style"] = "Стиль",
	--[[ ruRU ]] ["Sets the glow style"] = "Задает стиль свечения",
	--[[ ruRU ]] ["Override Color"] = "Перезапись цвета",
	--[[ ruRU ]] ["Overrides the glow default color(s)"] = "Перезапись цвета(ов) по умолчанию для свечения",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the glow color"] = "Задает цвет свечения",
	--[[ ruRU ]] ["Blend Mode"] = "Режим смешивания",
	--[[ ruRU ]] ["Sets the glow blend mode"] = "Задает тип смешения для свечения",

	--[[ ruRU ]] ["BLEND"] = "СМЕШИВАТЬ",
	--[[ ruRU ]] ["ADD"] = "ДОБАВИТЬ",

	--[[ ruRU ]] ["HARD"] = "СИЛЬНОЕ",
	--[[ ruRU ]] ["SOFT"] = "МЯГКОЕ",
	--[[ ruRU ]] ["PRTLSOFT"] = "PRTLSOFT",
	--[[ ruRU ]] ["THRQTRSOFT"] = "THRQTRSOFT",
	--[[ ruRU ]] ["EXTRASOFT"] = "СВЕРХМЯГКОЕ",
	--[[ ruRU ]] ["OVAL"] = "ОВАЛ",
	--[[ ruRU ]] ["OVALGLOW"] = "ОВАЛСВЕЧЕНИЕ",
	--[[ ruRU ]] ["SQUAREGLOW"] = "КВАДРАТНОЕ СВЕЧЕНИЕ",
	--[[ ruRU ]] ["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW",
	--[[ ruRU ]] ["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW",

	--[[ ruRU ]] ["Threat Status Colors"] = "Цвет статуса угрозы",
	--[[ ruRU ]] ["Customize nameplate glow threat status colors"] = "Настройка цвета свечения статуса угрозы",
	--[[ ruRU ]] ["Low Threat"] = "Мало угрозы",
	--[[ ruRU ]] ["Over-Nuking"] = "Over-Nuking",
	--[[ ruRU ]] ["Losing Threat"] = "Losing Threat",
	--[[ ruRU ]] ["Tanking Securely"] = "Безопасное танкование",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Nameplate Glow"] = "姓名板发光",
	--[[ zhCN ]] ["Health bar will be highlighted when unit is attacking player"] = "正在攻击玩家的单位的生命条会高亮显示",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Enable glow"] = "启用发光",
	--[[ zhCN ]] ["Invert"] = "反向",
	--[[ zhCN ]] ["Invert glow (disable on targets with aggro, enable on targets without aggro)"] = "反向发光（无仇恨目标发光，有仇恨则不发光）",
	--[[ zhCN ]] ["Invert Only In Combat"] = "Invert Only In Combat",
	--[[ zhCN ]] ["Display inverted glow only while in combat"] = "Display inverted glow only while in combat",
	--[[ zhCN ]] ["Glow Update Interval"] = "发光更新频率",
	--[[ zhCN ]] ["The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"] = "两次闪光间的时间间隔（秒为单位，0为最快）",
	--[[ zhCN ]] ["Use Health Bar"] = "Use Health Bar",
	--[[ zhCN ]] ["Indicate aggro status via health bar color (instead of glow)"] = "Indicate aggro status via health bar color (instead of glow)",
	--[[ zhCN  ]] ["Explicit Low Threat Indicator"] = "Explicit Low Threat Indicator",
	--[[ zhCN  ]] ["Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)",

	--[[ zhCN ]] ["Explicit Low Threat Indicator Only In Combat"] = "Explicit Low Threat Indicator Only In Combat",
	--[[ zhCN ]] ["Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat",
	--[[ zhCN ]] ["Invert Only While Tanking"] = "Invert Only While Tanking",
	--[[ zhCN ]] ["Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"] = "Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)",
	--[[ zhCN ]] ["Recently Damaged Only"] = "Recently Damaged Only",
	--[[ zhCN ]] ["Treat the player as 'in combat' only with 'recently damaged' targets"] = "Treat the player as 'in combat' only with 'recently damaged' targets",

	--[[ zhCN ]] ["Size"] = "尺寸",
	--[[ zhCN ]] ["Adjust glow size"] = "调整闪烁范围",
	--[[ zhCN ]] ["Width"] = "宽度",
	--[[ zhCN ]] ["Sets the width of the glow"] = "闪烁宽度",
	--[[ zhCN ]] ["Height"] = "高度",
	--[[ zhCN ]] ["Sets the height of the glow"] = "闪烁高度",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust the glow position"] = "调整闪烁位置",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the glow"] = "闪烁横向偏移",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the glow"] = "闪烁纵向偏移",

	--[[ zhCN ]] ["Style"] = "样式",
	--[[ zhCN ]] ["Sets the glow style"] = "设置发光样式",
	--[[ zhCN ]] ["Override Color"] = "强制使用颜色",
	--[[ zhCN ]] ["Overrides the glow default color(s)"] = "强制使用闪光颜色",
	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the glow color"] = "闪光颜色",
	--[[ zhCN ]] ["Blend Mode"] = "渐变模式",
	--[[ zhCN ]] ["Sets the glow blend mode"] = "发光使用渐变模式",

	--[[ zhCN ]] ["BLEND"] = "渲染",
	--[[ zhCN ]] ["ADD"] = "增加",

	--[[ zhCN ]] ["HARD"] = "软边",
	--[[ zhCN ]] ["SOFT"] = "硬边",
	--[[ zhCN ]] ["PRTLSOFT"] = "PRTLSOFT",
	--[[ zhCN ]] ["THRQTRSOFT"] = "THRQTRSOFT",
	--[[ zhCN ]] ["EXTRASOFT"] = "超软边",
	--[[ zhCN ]] ["OVAL"] = "OVAL",
	--[[ zhCN ]] ["OVALGLOW"] = "OVALGLOW",
	--[[ zhCN ]] ["SQUAREGLOW"] = "SQUAREGLOW",
	--[[ zhCN ]] ["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW",
	--[[ zhCN ]] ["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW",

	--[[ zhCN ]] ["Threat Status Colors"] = "Threat Status Colors",
	--[[ zhCN ]] ["Customize nameplate glow threat status colors"] = "Customize nameplate glow threat status colors",
	--[[ zhCN ]] ["Low Threat"] = "Low Threat",
	--[[ zhCN ]] ["Over-Nuking"] = "Over-Nuking",
	--[[ zhCN ]] ["Losing Threat"] = "Losing Threat",
	--[[ zhCN ]] ["Tanking Securely"] = "Tanking Securely",
} end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

L:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Nameplate Glow"] = "姓名板發光",
	--[[ zhTW ]] ["Health bar will be highlighted when unit is attacking player"] = "正在攻擊玩家的單位的生命條會高亮顯示",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Enable glow"] = "啟用發光",
	--[[ zhTW ]] ["Invert"] = "反向",
	--[[ zhTW ]] ["Invert glow (disable on targets with aggro, enable on targets without aggro)"] = "反向發光（無仇恨目標發光，有仇恨則不發光）",
	--[[ zhTW ]] ["Invert Only In Combat"] = "Invert Only In Combat",
	--[[ zhTW ]] ["Display inverted glow only while in combat"] = "Display inverted glow only while in combat",
	--[[ zhTW ]] ["Glow Update Interval"] = "發光更新頻率",
	--[[ zhTW ]] ["The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"] = "兩次閃光間的時間間隔（秒為單位，0為最快）",
	--[[ zhTW ]] ["Use Health Bar"] = "Use Health Bar",
	--[[ zhTW ]] ["Indicate aggro status via health bar color (instead of glow)"] = "Indicate aggro status via health bar color (instead of glow)",
	--[[ zhTW ]] ["Explicit Low Threat Indicator"] = "Explicit Low Threat Indicator",
	--[[ zhTW ]] ["Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)",

	--[[ zhTW ]] ["Explicit Low Threat Indicator Only In Combat"] = "Explicit Low Threat Indicator Only In Combat",
	--[[ zhTW ]] ["Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"] = "Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat",
	--[[ zhTW ]] ["Invert Only While Tanking"] = "Invert Only While Tanking",
	--[[ zhTW ]] ["Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"] = "Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)",
	--[[ zhTW ]] ["Recently Damaged Only"] = "Recently Damaged Only",
	--[[ zhTW ]] ["Treat the player as 'in combat' only with 'recently damaged' targets"] = "Treat the player as 'in combat' only with 'recently damaged' targets",

	--[[ zhTW ]] ["Size"] = "尺寸",
	--[[ zhTW ]] ["Adjust glow size"] = "調整閃爍範圍",
	--[[ zhTW ]] ["Width"] = "寬度",
	--[[ zhTW ]] ["Sets the width of the glow"] = "閃爍寬度",
	--[[ zhTW ]] ["Height"] = "高度",
	--[[ zhTW ]] ["Sets the height of the glow"] = "閃爍高度",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust the glow position"] = "調整閃爍位置",
	--[[ zhTW ]] ["X Offset"] = "X軸偏移",
	--[[ zhTW ]] ["X offset of the glow"] = "閃爍橫向偏移",
	--[[ zhTW ]] ["Y Offset"] = "Y軸偏移",
	--[[ zhTW ]] ["Y offset of the glow"] = "閃爍縱向偏移",

	--[[ zhTW ]] ["Style"] = "樣式",
	--[[ zhTW ]] ["Sets the glow style"] = "設置發光樣式",
	--[[ zhTW ]] ["Override Color"] = "強制使用顏色",
	--[[ zhTW ]] ["Overrides the glow default color(s)"] = "強制使用閃光顏色",
	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the glow color"] = "閃光顏色",
	--[[ zhTW ]] ["Blend Mode"] = "漸變模式",
	--[[ zhTW ]] ["Sets the glow blend mode"] = "發光使用漸變模式",

	--[[ zhTW ]] ["BLEND"] = "渲染",
	--[[ zhTW ]] ["ADD"] = "增加",

	--[[ zhTW ]] ["HARD"] = "軟邊",
	--[[ zhTW ]] ["SOFT"] = "硬邊",
	--[[ zhTW ]] ["PRTLSOFT"] = "PRTLSOFT",
	--[[ zhTW ]] ["THRQTRSOFT"] = "THRQTRSOFT",
	--[[ zhTW ]] ["EXTRASOFT"] = "超軟邊",
	--[[ zhTW ]] ["OVAL"] = "OVAL",
	--[[ zhTW ]] ["OVALGLOW"] = "OVALGLOW",
	--[[ zhTW ]] ["SQUAREGLOW"] = "SQUAREGLOW",
	--[[ zhTW ]] ["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW",
	--[[ zhTW ]] ["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW",

	--[[ zhTW ]] ["Threat Status Colors"] = "Threat Status Colors",
	--[[ zhTW ]] ["Customize nameplate glow threat status colors"] = "Customize nameplate glow threat status colors",
	--[[ zhTW ]] ["Low Threat"] = "Low Threat",
	--[[ zhTW ]] ["Over-Nuking"] = "Over-Nuking",
	--[[ zhTW ]] ["Losing Threat"] = "Losing Threat",
	--[[ zhTW ]] ["Tanking Securely"] = "Tanking Securely",
} end)

-----------------------------------------------------------------------------

end
