local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

-- TODO: must match similar string in ThreatBar.lua and in localization LUA; TODO: fix this, make it centrally sourced

-- threat types
local THREAT_RANGED	= "Ranged"
local THREAT_MELEE		= "Melee"
local THREAT_TANK		= "Tank"
local THREAT_GROUP		= "Group"

local SHORT_THREAT_TYPES = {
	[THREAT_RANGED]	= "R",
	[THREAT_MELEE]	= "M",
	[THREAT_TANK]	= "K",
	[THREAT_GROUP]	= "G",
}

-----------------------------------------------------------------------------

local dL = AceLibrary("AceLocale-2.2"):new("AloftThreatData")

-----------------------------------------------------------------------------

local bL = AceLibrary("AceLocale-2.2"):new("AloftThreatBarOptions")

-----------------------------------------------------------------------------

local tL = AceLibrary("AceLocale-2.2"):new("AloftThreatTextOptions")

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
dL:RegisterTranslations("enUS", function() return {
	-- long forms
	--[[ enUS ]] [THREAT_RANGED]						= true,
	--[[ enUS ]] [THREAT_MELEE]							= true,
	--[[ enUS ]] [THREAT_TANK]							= true,
	--[[ enUS ]] [THREAT_GROUP]							= true,

	-- short forms
	--[[ enUS ]] [SHORT_THREAT_TYPES[THREAT_RANGED]]	= true,
	--[[ enUS ]] [SHORT_THREAT_TYPES[THREAT_MELEE]]		= true,
	--[[ enUS ]] [SHORT_THREAT_TYPES[THREAT_TANK]]		= true,
	--[[ enUS ]] [SHORT_THREAT_TYPES[THREAT_GROUP]]		= true,

	--[[ enUS ]] ["AOE Threat"] = true,
	--[[ enUS ]] ["Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"] = true,
	--[[ enUS ]] ["Group Threat"] = true,
	--[[ enUS ]] ["Attempt to approximate threat for visible friendly units versus the player's current target"] = true,
	--[[ enUS ]] ["AOE/Group Threat Update Interval"] = true,
	--[[ enUS ]] ["The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"] = true,
} end)

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
bL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Threat Bar"] = true,
	--[[ enUS ]] ["Threat Bar options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show threat bars on group member nameplates"] = true,
	--[[ enUS ]] ["Active While Solo"] = true,
	--[[ enUS ]] ["Show threat bars on nameplates while solo (for classes with pets and guardians)"] = true,

	--[[ enUS ]] ["Texture"] = true,
	--[[ enUS ]] ["Sets the threat bar texture"] = true,
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Sets the threat bar alpha"] = true,

	--[[ enUS ]] ["Height"] = true,
	--[[ enUS ]] ["Sets the height of the threat bar"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust the threat bar's position"] = true,
	--[[ enUS ]] ["Left Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the left of the threat bar"] = true,
	--[[ enUS ]] ["Right Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the right of the threat bar"] = true,
	--[[ enUS ]] ["Vertical Offset"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the threat bar"] = true,

	--[[ enUS ]] ["Colors"] = true,
	--[[ enUS ]] ["Customize colors"] = true,
	--[[ enUS ]] ["Backdrop Color"] = true,
	--[[ enUS ]] ["Sets the backdrop color of the threat bar"] = true,
	--[[ enUS ]] ["Common Threat Color"] = true,
	--[[ enUS ]] ["Sets the threat color for the threat bar when indicating common threat"] = true,
	--[[ enUS ]] ["Maximum Threat Color"] = true,
	--[[ enUS ]] ["Sets the threat color for the threat bar when indicating maximum threat"] = true,

	--[[ enUS ]] ["Reset to Defaults"] = true,
	--[[ enUS ]] ["Resets all colors to their defaults"] = true,

	--[[ enUS ]] ["Border"] = true,
	--[[ enUS ]] ["Border options"] = true,
	--[[ enUS ]] ["Target Only"] = true,
	--[[ enUS ]] ["Enables the border on the current target only"] = true,
	--[[ enUS ]] ["Border Color"] = true,
	--[[ enUS ]] ["Sets the border color of the threat bar"] = true,
	--[[ enUS ]] ["Border Style"] = true,
	--[[ enUS ]] ["Sets the style of the threat bar border"] = true,

	--[[ enUS ]] ["Threat Gain"] = true,
	--[[ enUS ]] ["Threat gain threshold indicator for the player's target nameplate"] = true,
	--[[ enUS ]] ["Show maximum threat threshold on the player's target nameplate"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar"] = true,
	--[[ enUS ]] ["Threat Gain Color"] = true,
	--[[ enUS ]] ["Sets the color of the maximum threat threshold on the player's target nameplate"] = true,

	--[[ enUS ]] ["Threat Flash"] = true,
	--[[ enUS ]] ["Health bar will be highlighted when unit has maximum threat"] = true,
	--[[ enUS ]] ["Show threat flash"] = true,
	--[[ enUS ]] ["Invert"] = true,
	--[[ enUS ]] ["Invert threat flash (enable on targets below the threshold)"] = true,
	--[[ enUS ]] ["Threshold"] = true,
	--[[ enUS ]] ["The percentage of maximum threat at which flash appears"] = true,

	--[[ enUS ]] ["Size"] = true,
	--[[ enUS ]] ["Adjust threat flash size"] = true,
	--[[ enUS ]] ["Width"] = true,
	--[[ enUS ]] ["Sets the width of the threat flash"] = true,
	--[[ enUS ]] ["Height"] = true,
	--[[ enUS ]] ["Sets the height of the threat flash"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust the threat flash position"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the threat flash"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the threat flash"] = true,

	--[[ enUS ]] ["Style"] = true,
	--[[ enUS ]] ["Sets the threat flash style"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the threat flash color"] = true,
	--[[ enUS ]] ["Blend Mode"] = true,
	--[[ enUS ]] ["Sets the threat flash blend mode"] = true,
	--[[ enUS ]] ["Resets the threat flash color to its default"] = true,
	--[[ enUS ]] ["Resets the maximum threat threshold color to its default"] = true,
	--[[ enUS ]] ["Reset Color to Default"] = true,

	--[[ enUS ]] ["Advanced"] = true,
	--[[ enUS ]] ["Options for expert users"] = true,
	--[[ enUS ]] ["<Any tag string>"] = true,

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
} end)

-----------------------------------------------------------------------------

-- leave "enUS" active at all times, as a default locale
tL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Threat Text"] = true,
	--[[ enUS ]] ["Threat text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show threat text on nameplates"] = true,
	--[[ enUS ]] ["Active While Solo"] = true,
	--[[ enUS ]] ["Show threat text on nameplates while solo (for classes with pets and guardians)"] = true,

	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Threat text typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for threat text"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the threat text"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on threat text"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the outline for threat text"] = true,
	--[[ enUS ]] ["Mode"] = true,
	--[[ enUS ]] ["Choose what to show for threat text"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust threat text position"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the threat text"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the threat bar to anchor the threat text"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the threat text"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the threat text"] = true,
	--[[ enUS ]] ["Alpha"] = true,
	--[[ enUS ]] ["Sets the alpha of the threat text"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the threat text color"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["Percent"] = true,
	--[[ enUS ]] ["Threat"] = true,
	--[[ enUS ]] ["Threat & Percent"] = true,
	--[[ enUS ]] ["Deficit"] = true,
	--[[ enUS ]] ["Full"] = true,

	--[[ enUS ]] ["Advanced"] = true,
	--[[ enUS ]] ["Options for expert users"] = true,
	--[[ enUS ]] ["Format"] = true,
	--[[ enUS ]] ["Threat tag"] = true,
	--[[ enUS ]] ["<Any tag string>"] = true,

	--[[ enUS ]] ["TOPLEFT"] = true,
	--[[ enUS ]] ["TOP"] = true,
	--[[ enUS ]] ["TOPRIGHT"] = true,
	--[[ enUS ]] ["LEFT"] = true,
	--[[ enUS ]] ["CENTER"] = true,
	--[[ enUS ]] ["RIGHT"] = true,
	--[[ enUS ]] ["BOTTOMLEFT"] = true,
	--[[ enUS ]] ["BOTTOM"] = true,
	--[[ enUS ]] ["BOTTOMRIGHT"] = true,
} end)

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("koKR", function() return {
	-- long forms
	--[[ koKR ]] [THREAT_RANGED]						= "Ranged",
	--[[ koKR ]] [THREAT_MELEE]							= "Melee",
	--[[ koKR ]] [THREAT_TANK]							= "Tank",
	--[[ koKR ]] [THREAT_GROUP]							= "Group",

	-- short forms
	--[[ koKR ]] [SHORT_THREAT_TYPES[THREAT_RANGED]]	= "R",
	--[[ koKR ]] [SHORT_THREAT_TYPES[THREAT_MELEE]]		= "M",
	--[[ koKR ]] [SHORT_THREAT_TYPES[THREAT_TANK]]		= "T",
	--[[ koKR ]] [SHORT_THREAT_TYPES[THREAT_GROUP]]		= "G",

	--[[ koKR ]] ["AOE Threat"] = "AOE Threat",
	--[[ koKR ]] ["Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"] = "Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)",
	--[[ koKR ]] ["Group Threat"] = "Group Threat",
	--[[ koKR ]] ["Attempt to approximate threat for visible friendly units versus the player's current target"] = "Attempt to approximate threat for visible friendly units versus the player's current target",
	--[[ koKR ]] ["AOE/Group Threat Update Interval"] = "AOE/Group Threat Update Interval",
	--[[ koKR ]] ["The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)",
} end)

-----------------------------------------------------------------------------

bL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Threat Bar"] = "위협바",
	--[[ koKR ]] ["Threat Bar options"] = "위협바 설정",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show threat bars on group member nameplates"] = "Show threat bars on group member nameplates",
	--[[ koKR ]] ["Active While Solo"] = "Active While Solo",
	--[[ koKR ]] ["Show threat bars on nameplates while solo (for classes with pets and guardians)"] = "Show threat bars on nameplates while solo (for classes with pets and guardians)",

	--[[ koKR ]] ["Texture"] = "텍스쳐",
	--[[ koKR ]] ["Sets the threat bar texture"] = "위협바의 텍스쳐를 설정합니다.",
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Sets the threat bar alpha"] = "위협바의 투명도를 설정합니다.",

	--[[ koKR ]] ["Height"] = "높이",
	--[[ koKR ]] ["Sets the height of the threat bar"] = "위협바의 높이를 설정합니다.",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust the threat bar's position"] = "위협바의 위치를 조절합니다.",
	--[[ koKR ]] ["Left Offset"] = "좌측 좌표",
	--[[ koKR ]] ["Sets the offset of the left of the threat bar"] = "위협바의 좌측 좌표를 설정합니다.",
	--[[ koKR ]] ["Right Offset"] = "우측 좌표",
	--[[ koKR ]] ["Sets the offset of the right of the threat bar"] = "위협바의 우측 좌표를 설정합니다.",
	--[[ koKR ]] ["Vertical Offset"] = "수직 좌표",
	--[[ koKR ]] ["Sets the vertical offset of the threat bar"] = "위협바의 수직 좌표를 설정합니다.",

	--[[ koKR ]] ["Colors"] = "색상",
	--[[ koKR ]] ["Customize colors"] = "사용자 색상",
	--[[ koKR ]] ["Backdrop Color"] = "배경 색상",
	--[[ koKR ]] ["Sets the backdrop color of the threat bar"] = "Sets the backdrop color of the threat bar",
	--[[ koKR ]] ["Common Threat Color"] = "Common Threat Color",
	--[[ koKR ]] ["Sets the threat color for the threat bar when indicating common threat"] = "Sets the threat color for the threat bar when indicating common threat",
	--[[ koKR ]] ["Maximum Threat Color"] = "Maximum Threat Color",
	--[[ koKR ]] ["Sets the threat color for the threat bar when indicating maximum threat"] = "Sets the threat color for the threat bar when indicating maximum threat",

	--[[ koKR ]] ["Reset to Defaults"] = "기본값 초기화",
	--[[ koKR ]] ["Resets all colors to their defaults"] = "모든 색상을 기본값으로 초기화합니다.",

	--[[ koKR ]] ["Border"] = "Border",
	--[[ koKR ]] ["Border options"] = "Border options",
	--[[ koKR ]] ["Target Only"] = "Target Only",
	--[[ koKR ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ koKR ]] ["Border Color"] = "테두리 색상",
	--[[ koKR ]] ["Sets the border color of the threat bar"] = "Sets the border color of the threat bar",
	--[[ koKR ]] ["Border Style"] = "테두리 스타일",
	--[[ koKR ]] ["Sets the style of the threat bar border"] = "Sets the style of the threat bar border",

	--[[ koKR ]] ["Threat Gain"] = "Threat Gain",
	--[[ koKR ]] ["Threat gain threshold indicator for the player's target nameplate"] = "Threat gain threshold indicator for the player's target nameplate",
	--[[ koKR ]] ["Show maximum threat threshold on the player's target nameplate"] = "Show maximum threat threshold on the player's target nameplate",
	--[[ koKR ]] ["Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar"] = "Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar",
	--[[ koKR ]] ["Threat Gain Color"] = "Threat Gain Color",
	--[[ koKR ]] ["Sets the color of the maximum threat threshold on the player's target nameplate"] = "Sets the color of the maximum threat threshold on the player's target nameplate",

	--[[ koKR ]] ["Threat Flash"] = "Threat Flash",
	--[[ koKR ]] ["Health bar will be highlighted when unit has maximum threat"] = "Health bar will be highlighted when unit has maximum threat",
	--[[ koKR ]] ["Show threat flash"] = "Show threat flash",
	--[[ koKR ]] ["Invert"] = "Invert",
	--[[ koKR ]] ["Invert threat flash (enable on targets below the threshold)"] = "Invert threat flash (enable on targets below the threshold)",
	--[[ koKR ]] ["Threshold"] = "Threshold",
	--[[ koKR ]] ["The percentage of maximum threat at which flash appears"] = "The percentage of maximum threat at which flash appears",

	--[[ koKR ]] ["Size"] = "크기",
	--[[ koKR ]] ["Adjust threat flash size"] = "Adjust threat flash size",
	--[[ koKR ]] ["Width"] = "너비",
	--[[ koKR ]] ["Sets the width of the threat flash"] = "Sets the width of the threat flash",
	--[[ koKR ]] ["Height"] = "높이",
	--[[ koKR ]] ["Sets the height of the threat flash"] = "Sets the height of the threat flash",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust the threat flash position"] = "Adjust the threat flash position",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the threat flash"] = "X offset of the threat flash",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the threat flash"] = "Y offset of the threat flash",

	--[[ koKR ]] ["Style"] = "Style",
	--[[ koKR ]] ["Sets the threat flash style"] = "Sets the threat flash style",
	--[[ koKR ]] ["Color"] = "색상",
	--[[ koKR ]] ["Sets the threat flash color"] = "Sets the threat flash color",
	--[[ koKR ]] ["Blend Mode"] = "혼합 모드",
	--[[ koKR ]] ["Sets the threat flash blend mode"] = "Sets the threat flash blend mode",
	--[[ koKR ]] ["Resets the threat flash color to its default"] = "Resets the threat flash color to its default",
	--[[ koKR ]] ["Resets the maximum threat threshold color to its default"] = "Resets the maximum threat threshold color to its default",
	--[[ koKR ]] ["Reset Color to Default"] = "Reset Color to Default",

	--[[ koKR ]] ["Advanced"] = "고급",
	--[[ koKR ]] ["Options for expert users"] = "고급 사용자를 위한 설정",
	--[[ koKR ]] ["<Any tag string>"] = "<태그 문자열>",

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
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Threat Text"] = "Threat Text",
	--[[ koKR ]] ["Threat text options"] = "Threat text options",
	--[[ koKR ]] ["Enable"] = "사용",
	--[[ koKR ]] ["Show threat text on nameplates"] = "Show threat text on nameplates",
	--[[ koKR ]] ["Active While Solo"] = "Active While Solo",
	--[[ koKR ]] ["Show threat text on nameplates while solo (for classes with pets and guardians)"] = "Show threat text on nameplates while solo (for classes with pets and guardians)",

	--[[ koKR ]] ["Typeface"] = "서체",
	--[[ koKR ]] ["Threat text typeface options"] = "Threat text typeface options",
	--[[ koKR ]] ["Font"] = "글꼴",
	--[[ koKR ]] ["Sets the font for threat text"] = "Sets the font for threat text",
	--[[ koKR ]] ["Font Size"] = "글꼴 크기",
	--[[ koKR ]] ["Sets the font height of the threat text"] = "Sets the font height of the threat text",
	--[[ koKR ]] ["Font Shadow"] = "글꼴 그림자",
	--[[ koKR ]] ["Show font shadow on threat text"] = "Show font shadow on threat text",
	--[[ koKR ]] ["Outline"] = "테두리",
	--[[ koKR ]] ["Sets the outline for threat text"] = "Sets the outline for threat text",
	--[[ koKR ]] ["Mode"] = "모드",
	--[[ koKR ]] ["Choose what to show for threat text"] = "Choose what to show for threat text",

	--[[ koKR ]] ["Position"] = "위치",
	--[[ koKR ]] ["Adjust threat text position"] = "Adjust threat text position",
	--[[ koKR ]] ["Anchor"] = "앵커",
	--[[ koKR ]] ["Sets the anchor for the threat text"] = "Sets the anchor for the threat text",
	--[[ koKR ]] ["Anchor To"] = "앵커 위치",
	--[[ koKR ]] ["Sets the relative point on the threat bar to anchor the threat text"] = "Sets the relative point on the threat bar to anchor the threat text",
	--[[ koKR ]] ["X Offset"] = "X 좌표",
	--[[ koKR ]] ["X offset of the threat text"] = "X offset of the threat text",
	--[[ koKR ]] ["Y Offset"] = "Y 좌표",
	--[[ koKR ]] ["Y offset of the threat text"] = "Y offset of the threat text",
	--[[ koKR ]] ["Alpha"] = "투명도",
	--[[ koKR ]] ["Sets the alpha of the threat text"] = "Sets the alpha of the threat text",
	--[[ koKR ]] ["Color"] = "색상",
	--[[ koKR ]] ["Sets the threat text color"] = "Sets the threat text color",

	--[[ koKR ]] ["None"] = "없음",
	--[[ koKR ]] ["Normal"] = "기본",
	--[[ koKR ]] ["Thick"] = "굵게",

	--[[ koKR ]] ["Percent"] = "Percent",
	--[[ koKR ]] ["Threat"] = "Threat",
	--[[ koKR ]] ["Threat & Percent"] = "Threat & Percent",
	--[[ koKR ]] ["Deficit"] = "Deficit",
	--[[ koKR ]] ["Full"] = "Full",

	--[[ koKR ]] ["Advanced"] = "고급",
	--[[ koKR ]] ["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	--[[ koKR ]] ["Format"] = "형식",
	--[[ koKR ]] ["Threat tag"] = "Threat tag",
	--[[ koKR ]] ["<Any tag string>"] = "<태그 문자열>",

	--[[ koKR ]] ["TOPLEFT"] = "좌측 상단",
	--[[ koKR ]] ["TOP"] = "상단",
	--[[ koKR ]] ["TOPRIGHT"] = "우측 상단",
	--[[ koKR ]] ["LEFT"] = "좌측",
	--[[ koKR ]] ["CENTER"] = "가운데",
	--[[ koKR ]] ["RIGHT"] = "우측",
	--[[ koKR ]] ["BOTTOMLEFT"] = "좌측 하단",
	--[[ koKR ]] ["BOTTOM"] = "하단",
	--[[ koKR ]] ["BOTTOMRIGHT"] = "우측 하단",
} end)

end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("ruRU", function() return {
	-- long forms
	--[[ ruRU ]] [THREAT_RANGED]						= "Дальний бой",
	--[[ ruRU ]] [THREAT_MELEE]							= "Ближний бой",
	--[[ ruRU ]] [THREAT_TANK]							= "Танк",
	--[[ ruRU ]] [THREAT_GROUP]							= "Группа",

	--[[ ruRU ]] [SHORT_THREAT_TYPES[THREAT_RANGED]]	= "Бб",
	--[[ ruRU ]] [SHORT_THREAT_TYPES[THREAT_MELEE]]		= "Дб",
	--[[ ruRU ]] [SHORT_THREAT_TYPES[THREAT_TANK]]		= "Т",
	--[[ ruRU ]] [SHORT_THREAT_TYPES[THREAT_GROUP]]		= "Г",

	--[[ ruRU ]] ["AOE Threat"] = "Масс угроза",
	--[[ ruRU ]] ["Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"] = "Попытаться подсчитать  приблизительное значение угрозы для видимох враждебнох единиц против игрока (	кроме игрока нынешней цели)",
	--[[ ruRU ]] ["Group Threat"] = "Угроза группы",
	--[[ ruRU ]] ["Attempt to approximate threat for visible friendly units versus the player's current target"] = "Попытаться подсчитать  приблизительное значение угрозы для видимых дружественных единиц против игрока\существа текущей цели",
	--[[ ruRU ]] ["AOE/Group Threat Update Interval"] = "Скорость обновления угрозы МАСС/Группы",
	--[[ ruRU ]] ["The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"] = "Значение времени в секундах, между обновлениеми угрозы активной/обширной-группы (0.0 максимальная скорость)",
} end)

-----------------------------------------------------------------------------

bL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Threat Bar"] = "Полоска угрозы",
	--[[ ruRU ]] ["Threat Bar options"] = "Настройки полоски угрозы",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show threat bars on group member nameplates"] = "Отображать полоски угрозы на табличках участников группы",
	--[[ ruRU ]] ["Active While Solo"] = "Включено, когда один",
	--[[ ruRU ]] ["Show threat bars on nameplates while solo (for classes with pets and guardians)"] = "Отображать полоски угрозы на табличках когда один (для классов с питомцами и защитниками)",

	--[[ ruRU ]] ["Texture"] = "Текстура",
	--[[ ruRU ]] ["Sets the threat bar texture"] = "Задает текстуру полоски угрозы",
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Sets the threat bar alpha"] = "Задает прозрачность полоски угрозы",

	--[[ ruRU ]] ["Height"] = "Высота",
	--[[ ruRU ]] ["Sets the height of the threat bar"] = "Задает высоту полоски угрозы",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust the threat bar's position"] = "Задать место полоски угрозы",
	--[[ ruRU ]] ["Left Offset"] = "Левое смещение",
	--[[ ruRU ]] ["Sets the offset of the left of the threat bar"] = "Задает смещение правого конца полоски угрозы",
	--[[ ruRU ]] ["Right Offset"] = "Правое смещение",
	--[[ ruRU ]] ["Sets the offset of the right of the threat bar"] = "Задает смещение правого конца полоски угрозы",
	--[[ ruRU ]] ["Vertical Offset"] = "Вертикальное смещение",
	--[[ ruRU ]] ["Sets the vertical offset of the threat bar"] = "Задает вертикальное смещение полоски угрозы",

	--[[ ruRU ]] ["Colors"] = "Цвета",
	--[[ ruRU ]] ["Customize colors"] = "Настройка цветов",
	--[[ ruRU ]] ["Backdrop Color"] = "Цвет тени",
	--[[ ruRU ]] ["Sets the backdrop color of the threat bar"] = "Задает цвет тени полоски угрозы",
	--[[ ruRU ]] ["Common Threat Color"] = "Цвет общей угрозы",
	--[[ ruRU ]] ["Sets the threat color for the threat bar when indicating common threat"] = "Задает цвет угрозы для полоски угрозы при отображении обычной угрозы",
	--[[ ruRU ]] ["Maximum Threat Color"] = "Цвет максимальной угрозы",
	--[[ ruRU ]] ["Sets the threat color for the threat bar when indicating maximum threat"] = "Задает цвет угрозы для полоски угрозы при отображении максимальной угрозы",

	--[[ ruRU ]] ["Reset to Defaults"] = "Сбросить настройки",
	--[[ ruRU ]] ["Resets all colors to their defaults"] = "Сбрасывает все цвета в настройки по умолчанию",

	--[[ ruRU ]] ["Border"] = "Края",
	--[[ ruRU ]] ["Border options"] = "Настройки краев",
	--[[ ruRU ]] ["Target Only"] = "Только цель",
	--[[ ruRU ]] ["Enables the border on the current target only"] = "Включить края только для текущей цели",
	--[[ ruRU ]] ["Border Color"] = "Цвет рамки",
	--[[ ruRU ]] ["Sets the border color of the threat bar"] = "Задает цвет рамки таблички угрозы",
	--[[ ruRU ]] ["Border Style"] = "Стиль рамки",
	--[[ ruRU ]] ["Sets the style of the threat bar border"] = "Задает стиль рамки таблички угрозы",

	--[[ ruRU ]] ["Threat Gain"] = "Получение угрозы",
	--[[ ruRU ]] ["Threat gain threshold indicator for the player's target nameplate"] = "Уровень угрозы для начала индикации на табличке игрока",
	--[[ ruRU ]] ["Show maximum threat threshold on the player's target nameplate"] = "Отображать максимальный уровень угрозы на табличке цели",
	--[[ ruRU ]] ["Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar"] = "Задает вертикальное смещение уровня максимальной угрозы относительно полоски угрозы",
	--[[ ruRU ]] ["Threat Gain Color"] = "Цвет получения угрозы",
	--[[ ruRU ]] ["Sets the color of the maximum threat threshold on the player's target nameplate"] = "Задает цвет максимального уровня угрозы на табличке цели",

	--[[ ruRU ]] ["Threat Flash"] = "Вспышка угрозы",
	--[[ ruRU ]] ["Health bar will be highlighted when unit has maximum threat"] = "Полоса здоровья будет подсвечиваться когда игрок/существо достигает макс угрозы",
	--[[ ruRU ]] ["Show threat flash"] = "Отображать вспышку угрозы",
	--[[ ruRU ]] ["Invert"] = "Инвертировать",
	--[[ ruRU ]] ["Invert threat flash (enable on targets below the threshold)"] = "Инвертировать вспышку угрозы (включить на целях ниже порога)",
	--[[ ruRU ]] ["Threshold"] = "Смещение",
	--[[ ruRU ]] ["The percentage of maximum threat at which flash appears"] = "Процент от максимального уровня угрозы, при котором появляется вспышка",

	--[[ ruRU ]] ["Size"] = "Размер",
	--[[ ruRU ]] ["Adjust threat flash size"] = "Задать место вспышки угрозы",
	--[[ ruRU ]] ["Width"] = "Ширина",
	--[[ ruRU ]] ["Sets the width of the threat flash"] = "Задает ширину вспышки угрозы",
	--[[ ruRU ]] ["Height"] = "Высота",
	--[[ ruRU ]] ["Sets the height of the threat flash"] = "Задает высоту вспышки угрозы",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust the threat flash position"] = "Задать место вспышки угрозы",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the threat flash"] = "Смещение вспышки угрозы по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the threat flash"] = "Смещение вспышки угрозы по Y",

	--[[ ruRU ]] ["Style"] = "Стиль",
	--[[ ruRU ]] ["Sets the threat flash style"] = "Задает стиль вспышки угрозы",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the threat flash color"] = "Задает цвет вспышки угрозы",
	--[[ ruRU ]] ["Blend Mode"] = "Режим смешивания",
	--[[ ruRU ]] ["Sets the threat flash blend mode"] = "Задает тип смешения вспышки угрозы",
	--[[ ruRU ]] ["Resets the threat flash color to its default"] = "Сброс цвета вспышки угрозы в цвет по умолчанию",
	--[[ ruRU ]] ["Resets the maximum threat threshold color to its default"] = "Сброс цвета максимальной пороговой угрозы в цвет по умолчанию",
	--[[ ruRU ]] ["Reset Color to Default"] = "Сбросить цвет на изначальный",

	--[[ ruRU ]] ["Advanced"] = "Дополнительно",
	--[[ ruRU ]] ["Options for expert users"] = "Настройки для опытных пользователей",
	--[[ ruRU ]] ["<Any tag string>"] = "<Любая строка формата>",

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
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Threat Text"] = "Текст угрозы",
	--[[ ruRU ]] ["Threat text options"] = "Настройки текста угрозы",
	--[[ ruRU ]] ["Enable"] = "Включить",
	--[[ ruRU ]] ["Show threat text on nameplates"] = "Отображать текст угрозы на табличках",
	--[[ ruRU ]] ["Active While Solo"] = "Включено, когда один",
	--[[ ruRU ]] ["Show threat text on nameplates while solo (for classes with pets and guardians)"] = "Отображать текст угрозы когда один (для классов с питомцами и защитниками)",

	--[[ ruRU ]] ["Typeface"] = "Шрифт",
	--[[ ruRU ]] ["Threat text typeface options"] = "Настройки шрифта текста угрозы",
	--[[ ruRU ]] ["Font"] = "Шрифт",
	--[[ ruRU ]] ["Sets the font for threat text"] = "Задает шрифт для текста угрозы",
	--[[ ruRU ]] ["Font Size"] = "Размер шрифта",
	--[[ ruRU ]] ["Sets the font height of the threat text"] = "Задает высоту шрифта для текста угрозы",
	--[[ ruRU ]] ["Font Shadow"] = "Тень шрифта",
	--[[ ruRU ]] ["Show font shadow on threat text"] = "Отображать тень для текста угрозы",
	--[[ ruRU ]] ["Outline"] = "Контур",
	--[[ ruRU ]] ["Sets the outline for threat text"] = "Задает контур для текста угрозы",
	--[[ ruRU ]] ["Mode"] = "Режим",
	--[[ ruRU ]] ["Choose what to show for threat text"] = "Выбрать, что показывать в тексте угрозы",

	--[[ ruRU ]] ["Position"] = "Позиция",
	--[[ ruRU ]] ["Adjust threat text position"] = "Задать позицию значения угрозы",
	--[[ ruRU ]] ["Anchor"] = "Точка прикрепления",
	--[[ ruRU ]] ["Sets the anchor for the threat text"] = "Задает прикрепление текста угрозы",
	--[[ ruRU ]] ["Anchor To"] = "Прикрепить к",
	--[[ ruRU ]] ["Sets the relative point on the threat bar to anchor the threat text"] = "Задает точку для положения текста угрозы относительно полоски угрозы",
	--[[ ruRU ]] ["X Offset"] = "Смещение по X",
	--[[ ruRU ]] ["X offset of the threat text"] = "Смещение текста угрозы по X",
	--[[ ruRU ]] ["Y Offset"] = "Смещение по Y",
	--[[ ruRU ]] ["Y offset of the threat text"] = "Смещение текста угрозы по Y",
	--[[ ruRU ]] ["Alpha"] = "Прозрачность",
	--[[ ruRU ]] ["Sets the alpha of the threat text"] = "Задает прозрачность текста угрозы",
	--[[ ruRU ]] ["Color"] = "Цвет",
	--[[ ruRU ]] ["Sets the threat text color"] = "Задает цвет текста угрозы",

	--[[ ruRU ]] ["None"] = "Нет",
	--[[ ruRU ]] ["Normal"] = "Обычно",
	--[[ ruRU ]] ["Thick"] = "Жирный",

	--[[ ruRU ]] ["Percent"] = "Проценты",
	--[[ ruRU ]] ["Threat"] = "Угроза",
	--[[ ruRU ]] ["Threat & Percent"] = "Угроза & Проценты",
	--[[ ruRU ]] ["Deficit"] = "Дефицит",
	--[[ ruRU ]] ["Full"] = "Полное",

	--[[ ruRU ]] ["Advanced"] = "Дополнительно",
	--[[ ruRU ]] ["Options for expert users"] = "Настройки для опытных пользователей",
	--[[ ruRU ]] ["Format"] = "Формат",
	--[[ ruRU ]] ["Threat tag"] = "Формат угрозы",
	--[[ ruRU ]] ["<Any tag string>"] = "<Любая строка формата>",

	--[[ ruRU ]] ["TOPLEFT"] = "ВВЕРХУ-СЛЕВА",
	--[[ ruRU ]] ["TOP"] = "ВВЕРХУ",
	--[[ ruRU ]] ["TOPRIGHT"] = "ВВЕРХУ-СПРАВА",
	--[[ ruRU ]] ["LEFT"] = "СЛЕВА",
	--[[ ruRU ]] ["CENTER"] = "ПО ЦЕНТРУ",
	--[[ ruRU ]] ["RIGHT"] = "СПРАВА",
	--[[ ruRU ]] ["BOTTOMLEFT"] = "СНИЗУ-СЛЕВА",
	--[[ ruRU ]] ["BOTTOM"] = "СНИЗУ",
	--[[ ruRU ]] ["BOTTOMRIGHT"] = "СНИЗУ-СПРАВА",
} end)

end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhCN", function() return {
	-- long forms
	--[[ zhCN ]] [THREAT_RANGED]						= "Ranged",
	--[[ zhCN ]] [THREAT_MELEE]							= "Melee",
	--[[ zhCN ]] [THREAT_TANK]							= "Tank",
	--[[ zhCN ]] [THREAT_GROUP]							= "Group",

	-- short forms
	--[[ zhCN ]] [SHORT_THREAT_TYPES[THREAT_RANGED]]	= "R",
	--[[ zhCN ]] [SHORT_THREAT_TYPES[THREAT_MELEE]]		= "M",
	--[[ zhCN ]] [SHORT_THREAT_TYPES[THREAT_TANK]]		= "T",
	--[[ zhCN ]] [SHORT_THREAT_TYPES[THREAT_GROUP]]		= "G",

	--[[ zhCN ]] ["AOE Threat"] = "AOE Threat",
	--[[ zhCN ]] ["Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"] = "Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)",
	--[[ zhCN ]] ["Group Threat"] = "Group Threat",
	--[[ zhCN ]] ["Attempt to approximate threat for visible friendly units versus the player's current target"] = "Attempt to approximate threat for visible friendly units versus the player's current target",
	--[[ zhCN ]] ["AOE/Group Threat Update Interval"] = "AOE/Group Threat Update Interval",
	--[[ zhCN ]] ["The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)",
} end)

-----------------------------------------------------------------------------

bL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Threat Bar"] = "威胁值显示条",
	--[[ zhCN ]] ["Threat Bar options"] = "威胁值显示条相关设置",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show threat bars on group member nameplates"] = "在小队成员的姓名板上显示威胁值",
	--[[ zhCN ]] ["Active While Solo"] = "单人时也启用",
	--[[ zhCN ]] ["Show threat bars on nameplates while solo (for classes with pets and guardians)"] = "单人时也启用",

	--[[ zhCN ]] ["Texture"] = "材质",
	--[[ zhCN ]] ["Sets the threat bar texture"] = "设定威胁值显示条的材质",
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Sets the threat bar alpha"] = "设定威胁值显示条的透明度",

	--[[ zhCN ]] ["Height"] = "高度",
	--[[ zhCN ]] ["Sets the height of the threat bar"] = "设定威胁值显示条的高度",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust the threat bar's position"] = "调整威胁值显示条的位置",
	--[[ zhCN ]] ["Left Offset"] = "向左偏移",
	--[[ zhCN ]] ["Sets the offset of the left of the threat bar"] = "设定威胁值显示条的向左偏移量",
	--[[ zhCN ]] ["Right Offset"] = "向右偏移",
	--[[ zhCN ]] ["Sets the offset of the right of the threat bar"] = "设定威胁值显示条的向右偏移量",
	--[[ zhCN ]] ["Vertical Offset"] = "垂直偏移",
	--[[ zhCN ]] ["Sets the vertical offset of the threat bar"] = "设定威胁值显示条的垂直偏移量",

	--[[ zhCN ]] ["Colors"] = "颜色",
	--[[ zhCN ]] ["Customize colors"] = "自定义颜色",
	--[[ zhCN ]] ["Backdrop Color"] = "背景颜色",
	--[[ zhCN ]] ["Sets the backdrop color of the threat bar"] = "设置威胁值条的背景颜色",
	--[[ zhCN ]] ["Common Threat Color"] = "普通威胁颜色",
	--[[ zhCN ]] ["Sets the threat color for the threat bar when indicating common threat"] = "设置普通威胁状态的威胁条颜色",
	--[[ zhCN ]] ["Maximum Threat Color"] = "最大威胁颜色",
	--[[ zhCN ]] ["Sets the threat color for the threat bar when indicating maximum threat"] = "设置最大威胁状态的威胁条颜色",

	--[[ zhCN ]] ["Reset to Defaults"] = "重置为默认值",
	--[[ zhCN ]] ["Resets all colors to their defaults"] = "将全部颜色设定重置为默认",

	--[[ zhCN ]] ["Border"] = "Border",
	--[[ zhCN ]] ["Border options"] = "Border options",
	--[[ zhCN ]] ["Target Only"] = "Target Only",
	--[[ zhCN ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ zhCN ]] ["Border Color"] = "边框颜色",
	--[[ zhCN ]] ["Sets the border color of the threat bar"] = "Sets the border color of the threat bar",
	--[[ zhCN ]] ["Border Style"] = "边框样式",
	--[[ zhCN ]] ["Sets the style of the threat bar border"] = "Sets the style of the threat bar border",

	--[[ zhCN ]] ["Threat Gain"] = "获得仇恨",
	--[[ zhCN ]] ["Threat gain threshold indicator for the player's target nameplate"] = "玩家目标姓名板上的获得仇恨阀值指示器",
	--[[ zhCN ]] ["Show maximum threat threshold on the player's target nameplate"] = "在玩家目标姓名板上显示最大威胁阀值",
	--[[ zhCN ]] ["Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar"] = "设置最大威胁阀值相对于威胁条其他部分的垂直偏移",
	--[[ zhCN ]] ["Threat Gain Color"] = "获得仇恨颜色",
	--[[ zhCN ]] ["Sets the color of the maximum threat threshold on the player's target nameplate"] = "设置玩家目标姓名板上的最大威胁阀值颜色",

	--[[ zhCN ]] ["Threat Flash"] = "威胁闪烁",
	--[[ zhCN ]] ["Health bar will be highlighted when unit has maximum threat"] = "在该单位获得最大威胁值时高亮其生命条",
	--[[ zhCN ]] ["Invert"] = "Invert",
	--[[ zhCN ]] ["Invert threat flash (enable on targets below the threshold)"] = "Invert threat flash (enable on targets below the threshold)",
	--[[ zhCN ]] ["Show threat flash"] = "使用威胁闪烁",
	--[[ zhCN ]] ["Threshold"] = "Threshold",
	--[[ zhCN ]] ["The percentage of maximum threat at which flash appears"] = "The percentage of maximum threat at which flash appears",

	--[[ zhCN ]] ["Size"] = "尺寸",
	--[[ zhCN ]] ["Adjust threat flash size"] = "Adjust threat flash size",
	--[[ zhCN ]] ["Width"] = "宽度",
	--[[ zhCN ]] ["Sets the width of the threat flash"] = "Sets the width of the threat flash",
	--[[ zhCN ]] ["Height"] = "高度",
	--[[ zhCN ]] ["Sets the height of the threat flash"] = "Sets the height of the threat flash",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust the threat flash position"] = "Adjust the threat flash position",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the threat flash"] = "X offset of the threat flash",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the threat flash"] = "Y offset of the threat flash",

	--[[ zhCN ]] ["Style"] = "Style",
	--[[ zhCN ]] ["Sets the threat flash style"] = "Sets the threat flash style",
	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the threat flash color"] = "设置威胁闪烁的高亮颜色",
	--[[ zhCN ]] ["Blend Mode"] = "渐变模式",
	--[[ zhCN ]] ["Sets the threat flash blend mode"] = "为仇恨闪烁使用渐变模式",
	--[[ zhCN ]] ["Resets the threat flash color to its default"] = "重置威胁闪烁的高亮颜色",
	--[[ zhCN ]] ["Resets the maximum threat threshold color to its default"] = "重置最大仇恨威胁指示的颜色",
	--[[ zhCN ]] ["Reset Color to Default"] = "重置颜色",

	--[[ zhCN ]] ["Advanced"] = "高级",
	--[[ zhCN ]] ["Options for expert users"] = "高级设置",
	--[[ zhCN ]] ["<Any tag string>"] = "<任意标签文字>",

	--[[ zhCN ]] ["BLEND"] = "渲染",
	--[[ zhCN ]] ["ADD"] = "增加",

	--[[ zhCN ]] ["HARD"] = "HARD",
	--[[ zhCN ]] ["SOFT"] = "SOFT",
	--[[ zhCN ]] ["PRTLSOFT"] = "PRTLSOFT",
	--[[ zhCN ]] ["THRQTRSOFT"] = "THRQTRSOFT",
	--[[ zhCN ]] ["EXTRASOFT"] = "EXTRASOFT",
	--[[ zhCN ]] ["OVAL"] = "OVAL",
	--[[ zhCN ]] ["OVALGLOW"] = "OVALGLOW",
	--[[ zhCN ]] ["SQUAREGLOW"] = "SQUAREGLOW",
	--[[ zhCN ]] ["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW",
	--[[ zhCN ]] ["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW",
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Threat Text"] = "威胁值文字",
	--[[ zhCN ]] ["Threat text options"] = "威胁值文字选项",
	--[[ zhCN ]] ["Enable"] = "启用",
	--[[ zhCN ]] ["Show threat text on nameplates"] = "在姓名板上显示威胁值文字",
	--[[ zhCN ]] ["Active While Solo"] = "单人时也启用",
	--[[ zhCN ]] ["Show threat text on nameplates while solo (for classes with pets and guardians)"] = "单人时也启用",

	--[[ zhCN ]] ["Typeface"] = "式样",
	--[[ zhCN ]] ["Threat text typeface options"] = "威胁值文字样式选项",
	--[[ zhCN ]] ["Font"] = "字体",
	--[[ zhCN ]] ["Sets the font for threat text"] = "设置威胁值字体",
	--[[ zhCN ]] ["Font Size"] = "字号",
	--[[ zhCN ]] ["Sets the font height of the threat text"] = "设置威胁值文字大小",
	--[[ zhCN ]] ["Font Shadow"] = "字体阴影",
	--[[ zhCN ]] ["Show font shadow on threat text"] = "为威胁值文字使用阴影",
	--[[ zhCN ]] ["Outline"] = "轮廓",
	--[[ zhCN ]] ["Sets the outline for threat text"] = "设置威胁值文字描边",
	--[[ zhCN ]] ["Mode"] = "模式",
	--[[ zhCN ]] ["Choose what to show for threat text"] = "选择威胁值文字要显示的内容",

	--[[ zhCN ]] ["Position"] = "位置",
	--[[ zhCN ]] ["Adjust threat text position"] = "调整威胁值文字位置",
	--[[ zhCN ]] ["Anchor"] = "锚点",
	--[[ zhCN ]] ["Sets the anchor for the threat text"] = "设置威胁值文字的锚点",
	--[[ zhCN ]] ["Anchor To"] = "固定在",
	--[[ zhCN ]] ["Sets the relative point on the threat bar to anchor the threat text"] = "设置威胁值文字要依附到威胁值条的哪个位置",
	--[[ zhCN ]] ["X Offset"] = "X轴偏移",
	--[[ zhCN ]] ["X offset of the threat text"] = "威胁值文字的横向偏移",
	--[[ zhCN ]] ["Y Offset"] = "Y轴偏移",
	--[[ zhCN ]] ["Y offset of the threat text"] = "威胁值文字的纵向偏移",
	--[[ zhCN ]] ["Alpha"] = "透明度",
	--[[ zhCN ]] ["Sets the alpha of the threat text"] = "威胁值文字的透明度",
	--[[ zhCN ]] ["Color"] = "颜色",
	--[[ zhCN ]] ["Sets the threat text color"] = "威胁值文字颜色",

	--[[ zhCN ]] ["None"] = "无",
	--[[ zhCN ]] ["Normal"] = "正常",
	--[[ zhCN ]] ["Thick"] = "粗",

	--[[ zhCN ]] ["Percent"] = "百分比",
	--[[ zhCN ]] ["Threat"] = "威胁值",
	--[[ zhCN ]] ["Threat & Percent"] = "威胁值和百分比",
	--[[ zhCN ]] ["Deficit"] = "亏减",
	--[[ zhCN ]] ["Full"] = "全部",

	--[[ zhCN ]] ["Advanced"] = "高级",
	--[[ zhCN ]] ["Options for expert users"] = "高级设置",
	--[[ zhCN ]] ["Format"] = "格式",
	--[[ zhCN ]] ["Threat tag"] = "威胁标签",
	--[[ zhCN ]] ["<Any tag string>"] = "<任意标签文字>",

	--[[ zhCN ]] ["TOPLEFT"] = "左上",
	--[[ zhCN ]] ["TOP"] = "上",
	--[[ zhCN ]] ["TOPRIGHT"] = "右上",
	--[[ zhCN ]] ["LEFT"] = "左",
	--[[ zhCN ]] ["CENTER"] = "中",
	--[[ zhCN ]] ["RIGHT"] = "右",
	--[[ zhCN ]] ["BOTTOMLEFT"] = "左下",
	--[[ zhCN ]] ["BOTTOM"] = "下",
	--[[ zhCN ]] ["BOTTOMRIGHT"] = "右下",
} end)

end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

dL:RegisterTranslations("zhTW", function() return {
	-- long forms
	--[[ zhTW ]] [THREAT_RANGED]						= "Ranged",
	--[[ zhTW ]] [THREAT_MELEE]							= "Melee",
	--[[ zhTW ]] [THREAT_TANK]							= "Tank",
	--[[ zhTW ]] [THREAT_GROUP]							= "Group",

	-- short forms
	--[[ zhTW ]] [SHORT_THREAT_TYPES[THREAT_RANGED]]	= "R",
	--[[ zhTW ]] [SHORT_THREAT_TYPES[THREAT_MELEE]]		= "M",
	--[[ zhTW ]] [SHORT_THREAT_TYPES[THREAT_TANK]]		= "T",
	--[[ zhTW ]] [SHORT_THREAT_TYPES[THREAT_GROUP]]		= "G",

	--[[ zhTW ]] ["AOE Threat"] = "AOE Threat",
	--[[ zhTW ]] ["Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"] = "Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)",
	--[[ zhTW ]] ["Group Threat"] = "Group Threat",
	--[[ zhTW ]] ["Attempt to approximate threat for visible friendly units versus the player's current target"] = "Attempt to approximate threat for visible friendly units versus the player's current target",
	--[[ zhTW ]] ["AOE/Group Threat Update Interval"] = "AOE/Group Threat Update Interval",
	--[[ zhTW ]] ["The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)",
} end)

-----------------------------------------------------------------------------

bL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Threat Bar"] = "威脅值條",
	--[[ zhTW ]] ["Threat Bar options"] = "威脅值條選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show threat bars on group member nameplates"] = "在隊伍成員",
	--[[ zhTW ]] ["Active While Solo"] = "單人下也顯示",
	--[[ zhTW ]] ["Show threat bars on nameplates while solo (for classes with pets and guardians)"] = "在單人作戰時也顯示威脅值條（例如有寵物的職業）",

	--[[ zhTW ]] ["Texture"] = "紋理",
	--[[ zhTW ]] ["Sets the threat bar texture"] = "威脅值條紋理",
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Sets the threat bar alpha"] = "威脅值條透明度",

	--[[ zhTW ]] ["Height"] = "高度",
	--[[ zhTW ]] ["Sets the height of the threat bar"] = "威脅值條高度",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust the threat bar's position"] = "威脅值條位置",
	--[[ zhTW ]] ["Left Offset"] = "左位移",
	--[[ zhTW ]] ["Sets the offset of the left of the threat bar"] = "威脅值條左位移",
	--[[ zhTW ]] ["Right Offset"] = "右位移",
	--[[ zhTW ]] ["Sets the offset of the right of the threat bar"] = "威脅值條右位移",
	--[[ zhTW ]] ["Vertical Offset"] = "垂直位移",
	--[[ zhTW ]] ["Sets the vertical offset of the threat bar"] = "威脅值條垂直位移",

	--[[ zhTW ]] ["Colors"] = "顏色",
	--[[ zhTW ]] ["Customize colors"] = "自定顏色",
	--[[ zhTW ]] ["Backdrop Color"] = "背景顏色",
	--[[ zhTW ]] ["Sets the backdrop color of the threat bar"] = "設置威脅值條背景顏色",
	--[[ zhTW ]] ["Common Threat Color"] = "普通威脅顏色",
	--[[ zhTW ]] ["Sets the threat color for the threat bar when indicating common threat"] = "設置普通威脅的威脅值條顏色",
	--[[ zhTW ]] ["Maximum Threat Color"] = "最大威脅顏色",
	--[[ zhTW ]] ["Sets the threat color for the threat bar when indicating maximum threat"] = "設置最大威脅的威脅值條顏色",

	--[[ zhTW ]] ["Reset to Defaults"] = "重設回預設值",
	--[[ zhTW ]] ["Resets all colors to their defaults"] = "重設全部顏色回預設值",

	--[[ zhTW ]] ["Border"] = "Border",
	--[[ zhTW ]] ["Border options"] = "Border options",
	--[[ zhTW ]] ["Target Only"] = "Target Only",
	--[[ zhTW ]] ["Enables the border on the current target only"] = "Enables the border on the current target only",
	--[[ zhTW ]] ["Border Color"] = "邊框顏色",
	--[[ zhTW ]] ["Sets the border color of the threat bar"] = "Sets the border color of the threat bar",
	--[[ zhTW ]] ["Border Style"] = "邊框樣式",
	--[[ zhTW ]] ["Sets the style of the threat bar border"] = "Sets the style of the threat bar border",

	--[[ zhTW ]] ["Threat Gain"] = "獲得仇恨",
	--[[ zhTW ]] ["Threat gain threshold indicator for the player's target nameplate"] = "玩家目標姓名板上顯示的最大威脅閥值指示器",
	--[[ zhTW ]] ["Show maximum threat threshold on the player's target nameplate"] = "在玩家目標姓名板上顯示最大威脅閥值",
	--[[ zhTW ]] ["Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar"] = "設置最大威脅值指示相對威脅值條其他部分的偏移",
	--[[ zhTW ]] ["Threat Gain Color"] = "獲得仇恨顏色",
	--[[ zhTW ]] ["Sets the color of the maximum threat threshold on the player's target nameplate"] = "設置目標姓名板上的最大仇恨閥值指示器顏色",

	--[[ zhTW ]] ["Threat Flash"] = "威脅閃動",
	--[[ zhTW ]] ["Health bar will be highlighted when unit has maximum threat"] = "在該單位獲得最大威脅時突出其生命條",
	--[[ zhTW ]] ["Show threat flash"] = "顯示威脅閃動",
	--[[ zhTW ]] ["Invert"] = "Invert",
	--[[ zhTW ]] ["Invert threat flash (enable on targets below the threshold)"] = "Invert threat flash (enable on targets below the threshold)",
	--[[ zhTW ]] ["Threshold"] = "Threshold",
	--[[ zhTW ]] ["The percentage of maximum threat at which flash appears"] = "The percentage of maximum threat at which flash appears",

	--[[ zhTW ]] ["Size"] = "大小",
	--[[ zhTW ]] ["Adjust threat flash size"] = "Adjust threat flash size",
	--[[ zhTW ]] ["Width"] = "寬度",
	--[[ zhTW ]] ["Sets the width of the threat flash"] = "Sets the width of the threat flash",
	--[[ zhTW ]] ["Height"] = "高度",
	--[[ zhTW ]] ["Sets the height of the threat flash"] = "Sets the height of the threat flash",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust the threat flash position"] = "Adjust the threat flash position",
	--[[ zhTW ]] ["X Offset"] = "X位移",
	--[[ zhTW ]] ["X offset of the threat flash"] = "X offset of the threat flash",
	--[[ zhTW ]] ["Y Offset"] = "Y位移",
	--[[ zhTW ]] ["Y offset of the threat flash"] = "Y offset of the threat flash",

	--[[ zhTW ]] ["Style"] = "Style",
	--[[ zhTW ]] ["Sets the threat flash style"] = "Sets the threat flash style",
	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the threat flash color"] = "設置威脅值高亮顏色",
	--[[ zhTW ]] ["Blend Mode"] = "漸變模式",
	--[[ zhTW ]] ["Sets the threat flash blend mode"] = "使威脅值閃動使用漸變顏色",
	--[[ zhTW ]] ["Resets the threat flash color to its default"] = "重置威脅值閃動顏色",
	--[[ zhTW ]] ["Resets the maximum threat threshold color to its default"] = "將最大威脅指示顏色重置",
	--[[ zhTW ]] ["Reset Color to Default"] = "重置顏色",

	--[[ zhTW ]] ["Advanced"] = "進階",
	--[[ zhTW ]] ["Options for expert users"] = "進階選項",
	--[[ zhTW ]] ["<Any tag string>"] = "<任何標籤文字>",

	--[[ zhTW ]] ["BLEND"] = "混合",
	--[[ zhTW ]] ["ADD"] = "增加",

	--[[ zhTW ]] ["HARD"] = "HARD",
	--[[ zhTW ]] ["SOFT"] = "SOFT",
	--[[ zhTW ]] ["PRTLSOFT"] = "PRTLSOFT",
	--[[ zhTW ]] ["THRQTRSOFT"] = "THRQTRSOFT",
	--[[ zhTW ]] ["EXTRASOFT"] = "EXTRASOFT",
	--[[ zhTW ]] ["OVAL"] = "OVAL",
	--[[ zhTW ]] ["OVALGLOW"] = "OVALGLOW",
	--[[ zhTW ]] ["SQUAREGLOW"] = "SQUAREGLOW",
	--[[ zhTW ]] ["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW",
	--[[ zhTW ]] ["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW",
} end)

-----------------------------------------------------------------------------

tL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Threat Text"] = "威脅值文本",
	--[[ zhTW ]] ["Threat text options"] = "威脅值文本選項",
	--[[ zhTW ]] ["Enable"] = "啟用",
	--[[ zhTW ]] ["Show threat text on nameplates"] = "在姓名板上顯示威脅值文本",
	--[[ zhTW ]] ["Active While Solo"] = "單人作戰時啟用",
	--[[ zhTW ]] ["Show threat text on nameplates while solo (for classes with pets and guardians)"] = "在單人作戰時也顯示威脅值條（例如有寵物的職業）",

	--[[ zhTW ]] ["Typeface"] = "式樣",
	--[[ zhTW ]] ["Threat text typeface options"] = "威脅值文本式樣選項",
	--[[ zhTW ]] ["Font"] = "字型",
	--[[ zhTW ]] ["Sets the font for threat text"] = "設置威脅值文本字型",
	--[[ zhTW ]] ["Font Size"] = "字型大小",
	--[[ zhTW ]] ["Sets the font height of the threat text"] = "設置威脅值文本字型高度",
	--[[ zhTW ]] ["Font Shadow"] = "字型陰影",
	--[[ zhTW ]] ["Show font shadow on threat text"] = "設置威脅值文本字型陰影",
	--[[ zhTW ]] ["Outline"] = "輪廓",
	--[[ zhTW ]] ["Sets the outline for threat text"] = "設置威脅值文本輪廓",
	--[[ zhTW ]] ["Mode"] = "模式",
	--[[ zhTW ]] ["Choose what to show for threat text"] = "選擇威脅值文本顯示的內容",

	--[[ zhTW ]] ["Position"] = "位置",
	--[[ zhTW ]] ["Adjust threat text position"] = "調整威脅值文本位置",
	--[[ zhTW ]] ["Anchor"] = "定位點",
	--[[ zhTW ]] ["Sets the anchor for the threat text"] = "設置威脅值文本的定位點",
	--[[ zhTW ]] ["Anchor To"] = "依附到",
	--[[ zhTW ]] ["Sets the relative point on the threat bar to anchor the threat text"] = "設置威脅值文本要依附到威脅值條的哪個位置",
	--[[ zhTW ]] ["X Offset"] = "X位移",
	--[[ zhTW ]] ["X offset of the threat text"] = "威脅值文本的橫向偏移",
	--[[ zhTW ]] ["Y Offset"] = "Y位移",
	--[[ zhTW ]] ["Y offset of the threat text"] = "威脅值文本的縱向偏移",
	--[[ zhTW ]] ["Alpha"] = "透明度",
	--[[ zhTW ]] ["Sets the alpha of the threat text"] = "威脅值文本透明度",
	--[[ zhTW ]] ["Color"] = "顏色",
	--[[ zhTW ]] ["Sets the threat text color"] = "設置威脅值文本顏色",

	--[[ zhTW ]] ["None"] = "無",
	--[[ zhTW ]] ["Normal"] = "正常",
	--[[ zhTW ]] ["Thick"] = "粗",

	--[[ zhTW ]] ["Percent"] = "百分比",
	--[[ zhTW ]] ["Threat"] = "威脅值",
	--[[ zhTW ]] ["Threat & Percent"] = "威脅值和百分比",
	--[[ zhTW ]] ["Deficit"] = "虧減模式",
	--[[ zhTW ]] ["Full"] = "全部",

	--[[ zhTW ]] ["Advanced"] = "進階",
	--[[ zhTW ]] ["Options for expert users"] = "進階選項",
	--[[ zhTW ]] ["Format"] = "格式",
	--[[ zhTW ]] ["Threat tag"] = "威脅值標簽",
	--[[ zhTW ]] ["<Any tag string>"] = "<任何標籤文字>",

	--[[ zhTW ]] ["TOPLEFT"] = "左上",
	--[[ zhTW ]] ["TOP"] = "上",
	--[[ zhTW ]] ["TOPRIGHT"] = "右上",
	--[[ zhTW ]] ["LEFT"] = "左",
	--[[ zhTW ]] ["CENTER"] = "中",
	--[[ zhTW ]] ["RIGHT"] = "右",
	--[[ zhTW ]] ["BOTTOMLEFT"] = "左下",
	--[[ zhTW ]] ["BOTTOM"] = "下",
	--[[ zhTW ]] ["BOTTOMRIGHT"] = "右下",
} end)

end)

-----------------------------------------------------------------------------

end
