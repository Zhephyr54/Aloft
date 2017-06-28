local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

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

local mL = AloftLocale.AloftModules
if not mL then return end

local dL = { }

local bL = { }

local tL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

-- Leave enUS locale active as default locale

--[[ enUS ]] dL["AOE Threat"] = "AOE Threat"
--[[ enUS ]] dL["Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"] = "Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"
--[[ enUS ]] dL["Group Threat"] = "Group Threat"
--[[ enUS ]] dL["Attempt to approximate threat for visible friendly units versus the player's current target"] = "Attempt to approximate threat for visible friendly units versus the player's current target"
--[[ enUS ]] dL["AOE/Group Threat Update Interval"] = "AOE/Group Threat Update Interval"
--[[ enUS ]] dL["The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"

-----------------------------------------------------------------------------

--[[ enUS ]] bL["Threat Bar"] = "Threat Bar"
--[[ enUS ]] bL["Threat Bar options"] = "Threat Bar options"
--[[ enUS ]] bL["Enable"] = "Enable"
--[[ enUS ]] bL["Show threat bars on group member nameplates"] = "Show threat bars on group member nameplates"
--[[ enUS ]] bL["Active While Solo"] = "Active While Solo"
--[[ enUS ]] bL["Show threat bars on nameplates while solo (for classes with pets and guardians)"] = "Show threat bars on nameplates while solo (for classes with pets and guardians)"

--[[ enUS ]] bL["Texture"] = "Texture"
--[[ enUS ]] bL["Sets the threat bar texture"] = "Sets the threat bar texture"
--[[ enUS ]] bL["Alpha"] = "Alpha"
--[[ enUS ]] bL["Sets the threat bar alpha"] = "Sets the threat bar alpha"

--[[ enUS ]] bL["Height"] = "Height"
--[[ enUS ]] bL["Sets the height of the threat bar"] = "Sets the height of the threat bar"

--[[ enUS ]] bL["Position"] = "Position"
--[[ enUS ]] bL["Adjust the threat bar's position"] = "Adjust the threat bar's position"
--[[ enUS ]] bL["Left Offset"] = "Left Offset"
--[[ enUS ]] bL["Sets the offset of the left of the threat bar"] = "Sets the offset of the left of the threat bar"
--[[ enUS ]] bL["Right Offset"] = "Right Offset"
--[[ enUS ]] bL["Sets the offset of the right of the threat bar"] = "Sets the offset of the right of the threat bar"
--[[ enUS ]] bL["Vertical Offset"] = "Vertical Offset"
--[[ enUS ]] bL["Sets the vertical offset of the threat bar"] = "Sets the vertical offset of the threat bar"

--[[ enUS ]] bL["Colors"] = "Colors"
--[[ enUS ]] bL["Customize colors"] = "Customize colors"
--[[ enUS ]] bL["Backdrop Color"] = "Backdrop Color"
--[[ enUS ]] bL["Sets the backdrop color of the threat bar"] = "Sets the backdrop color of the threat bar"
--[[ enUS ]] bL["Common Threat Color"] = "Common Threat Color"
--[[ enUS ]] bL["Sets the threat color for the threat bar when indicating common threat"] = "Sets the threat color for the threat bar when indicating common threat"
--[[ enUS ]] bL["Maximum Threat Color"] = "Maximum Threat Color"
--[[ enUS ]] bL["Sets the threat color for the threat bar when indicating maximum threat"] = "Sets the threat color for the threat bar when indicating maximum threat"

--[[ enUS ]] bL["Reset to Defaults"] = "Reset to Defaults"
--[[ enUS ]] bL["Resets all colors to their defaults"] = "Resets all colors to their defaults"

--[[ enUS ]] bL["Border"] = "Border"
--[[ enUS ]] bL["Border options"] = "Border options"
--[[ enUS ]] bL["Target Only"] = "Target Only"
--[[ enUS ]] bL["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ enUS ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ enUS ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ enUS ]] bL["Border Inset"] = "Border Inset"
--[[ enUS ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ enUS ]] bL["Border Color"] = "Border Color"
--[[ enUS ]] bL["Sets the border color of the threat bar"] = "Sets the border color of the threat bar"
--[[ enUS ]] bL["Border Style"] = "Border Style"
--[[ enUS ]] bL["Sets the style of the threat bar border"] = "Sets the style of the threat bar border"

--[[ enUS ]] bL["Threat Gain"] = "Threat Gain"
--[[ enUS ]] bL["Threat gain threshold indicator for the player's target nameplate"] = "Threat gain threshold indicator for the player's target nameplate"
--[[ enUS ]] bL["Show maximum threat threshold on the player's target nameplate"] = "Show maximum threat threshold on the player's target nameplate"
--[[ enUS ]] bL["Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar"] = "Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar"
--[[ enUS ]] bL["Threat Gain Color"] = "Threat Gain Color"
--[[ enUS ]] bL["Sets the color of the maximum threat threshold on the player's target nameplate"] = "Sets the color of the maximum threat threshold on the player's target nameplate"

--[[ enUS ]] bL["Threat Flash"] = "Threat Flash"
--[[ enUS ]] bL["Health bar will be highlighted when unit has maximum threat"] = "Health bar will be highlighted when unit has maximum threat"
--[[ enUS ]] bL["Show threat flash"] = "Show threat flash"
--[[ enUS ]] bL["Invert"] = "Invert"
--[[ enUS ]] bL["Invert threat flash (enable on targets below the threshold)"] = "Invert threat flash (enable on targets below the threshold)"
--[[ enUS ]] bL["Threshold"] = "Threshold"
--[[ enUS ]] bL["The percentage of maximum threat at which flash appears"] = "The percentage of maximum threat at which flash appears"

--[[ enUS ]] bL["Size"] = "Size"
--[[ enUS ]] bL["Adjust threat flash size"] = "Adjust threat flash size"
--[[ enUS ]] bL["Width"] = "Width"
--[[ enUS ]] bL["Sets the width of the threat flash"] = "Sets the width of the threat flash"
--[[ enUS ]] bL["Height"] = "Height"
--[[ enUS ]] bL["Sets the height of the threat flash"] = "Sets the height of the threat flash"

--[[ enUS ]] bL["Position"] = "Position"
--[[ enUS ]] bL["Adjust the threat flash position"] = "Adjust the threat flash position"
--[[ enUS ]] bL["X Offset"] = "X Offset"
--[[ enUS ]] bL["X offset of the threat flash"] = "X offset of the threat flash"
--[[ enUS ]] bL["Y Offset"] = "Y Offset"
--[[ enUS ]] bL["Y offset of the threat flash"] = "Y offset of the threat flash"

--[[ enUS ]] bL["Style"] = "Style"
--[[ enUS ]] bL["Sets the threat flash style"] = "Sets the threat flash style"
--[[ enUS ]] bL["Color"] = "Color"
--[[ enUS ]] bL["Sets the threat flash color"] = "Sets the threat flash color"
--[[ enUS ]] bL["Blend Mode"] = "Blend Mode"
--[[ enUS ]] bL["Sets the threat flash blend mode"] = "Sets the threat flash blend mode"
--[[ enUS ]] bL["Resets the threat flash color to its default"] = "Resets the threat flash color to its default"
--[[ enUS ]] bL["Resets the maximum threat threshold color to its default"] = "Resets the maximum threat threshold color to its default"
--[[ enUS ]] bL["Reset Color to Default"] = "Reset Color to Default"

--[[ enUS ]] bL["Incremetal"] = "Incremetal"
--[[ enUS ]] bL["Update incrementally; workaround for malformed borders, only relevant when borders are enabled"] = "Update incrementally; workaround for malformed borders, only relevant when borders are enabled"

--[[ enUS ]] bL["Advanced"] = "Advanced"
--[[ enUS ]] bL["Options for expert users"] = "Options for expert users"
--[[ enUS ]] bL["<Any tag string>"] = "<Any tag string>"

--[[ enUS ]] bL["BLEND"] = "BLEND"
--[[ enUS ]] bL["ADD"] = "ADD"

--[[ enUS ]] bL["HARD"] = "HARD"
--[[ enUS ]] bL["SOFT"] = "SOFT"
--[[ enUS ]] bL["PRTLSOFT"]= "PRTLSOFT"
--[[ enUS ]] bL["THRQTRSOFT"] = "THRQTRSOFT"
--[[ enUS ]] bL["EXTRASOFT"] = "EXTRASOFT"
--[[ enUS ]] bL["OVAL"] = "OVAL"
--[[ enUS ]] bL["OVALGLOW"] = "OVALGLOW"
--[[ enUS ]] bL["SQUAREGLOW"] = "SQUAREGLOW"
--[[ enUS ]] bL["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW"
--[[ enUS ]] bL["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW"

-----------------------------------------------------------------------------

--[[ enUS ]] tL["Threat Text"] = "Threat Text"
--[[ enUS ]] tL["Threat text options"] = "Threat text options"
--[[ enUS ]] tL["Enable"] = "Enable"
--[[ enUS ]] tL["Show threat text on nameplates"] = "Show threat text on nameplates"
--[[ enUS ]] tL["Active While Solo"] = "Active While Solo"
--[[ enUS ]] tL["Show threat text on nameplates while solo (for classes with pets and guardians)"] = "Show threat text on nameplates while solo (for classes with pets and guardians)"

--[[ enUS ]] tL["Typeface"] = "Typeface"
--[[ enUS ]] tL["Threat text typeface options"] = "Threat text typeface options"
--[[ enUS ]] tL["Font"] = "Font"
--[[ enUS ]] tL["Sets the font for threat text"] = "Sets the font for threat text"
--[[ enUS ]] tL["Font Size"] = "Font Size"
--[[ enUS ]] tL["Sets the font height of the threat text"] = "Sets the font height of the threat text"
--[[ enUS ]] tL["Font Shadow"] = "Font Shadow"
--[[ enUS ]] tL["Show font shadow on threat text"] = "Show font shadow on threat text"
--[[ enUS ]] tL["Outline"] = "Outline"
--[[ enUS ]] tL["Sets the outline for threat text"] = "Sets the outline for threat text"
--[[ enUS ]] tL["Mode"] = "Mode"
--[[ enUS ]] tL["Choose what to show for threat text"] = "Choose what to show for threat text"

--[[ enUS ]] tL["Position"] = "Position"
--[[ enUS ]] tL["Adjust threat text position"] = "Adjust threat text position"
--[[ enUS ]] tL["Anchor"] = "Anchor"
--[[ enUS ]] tL["Sets the anchor for the threat text"] = "Sets the anchor for the threat text"
--[[ enUS ]] tL["Anchor To"] = "Anchor To"
--[[ enUS ]] tL["Sets the relative point on the threat bar to anchor the threat text"] = "Sets the relative point on the threat bar to anchor the threat text"
--[[ enUS ]] tL["X Offset"] = "X Offset"
--[[ enUS ]] tL["X offset of the threat text"] = "X offset of the threat text"
--[[ enUS ]] tL["Y Offset"] = "Y Offset"
--[[ enUS ]] tL["Y offset of the threat text"] = "Y offset of the threat text"
--[[ enUS ]] tL["Alpha"] = "Alpha"
--[[ enUS ]] tL["Sets the alpha of the threat text"] = "Sets the alpha of the threat text"
--[[ enUS ]] tL["Color"] = "Color"
--[[ enUS ]] tL["Sets the threat text color"] = "Sets the threat text color"

--[[ enUS ]] tL["None"] = "None"
--[[ enUS ]] tL["Normal"] = "Normal"
--[[ enUS ]] tL["Thick"] = "Thick"

--[[ enUS ]] tL["Percent"] = "Percent"
--[[ enUS ]] tL["Threat"] = "Threat"
--[[ enUS ]] tL["Threat & Percent"] = "Threat & Percent"
--[[ enUS ]] tL["Deficit"] = "Deficit"
--[[ enUS ]] tL["Full"] = "Full"

--[[ enUS ]] tL["Advanced"] = "Advanced"
--[[ enUS ]] tL["Options for expert users"] = "Options for expert users"
--[[ enUS ]] tL["Format"] = "Format"
--[[ enUS ]] tL["Threat tag"] = "Threat tag"
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

--[[ enUS ]] mL["AloftThreat"] = "AloftThreat"
--[[ enUS ]] mL["Display threat data, bars, and text on nameplates"] = "Display threat data, bars, and text on nameplates"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

--[[ koKR ]] dL["AOE Threat"] = "AOE Threat"
--[[ koKR ]] dL["Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"] = "Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"
--[[ koKR ]] dL["Group Threat"] = "Group Threat"
--[[ koKR ]] dL["Attempt to approximate threat for visible friendly units versus the player's current target"] = "Attempt to approximate threat for visible friendly units versus the player's current target"
--[[ koKR ]] dL["AOE/Group Threat Update Interval"] = "AOE/Group Threat Update Interval"
--[[ koKR ]] dL["The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"

-----------------------------------------------------------------------------

--[[ koKR ]] bL["Threat Bar"] = "위협바"
--[[ koKR ]] bL["Threat Bar options"] = "위협바 설정"
--[[ koKR ]] bL["Enable"] = "사용"
--[[ koKR ]] bL["Show threat bars on group member nameplates"] = "Show threat bars on group member nameplates"
--[[ koKR ]] bL["Active While Solo"] = "Active While Solo"
--[[ koKR ]] bL["Show threat bars on nameplates while solo (for classes with pets and guardians)"] = "Show threat bars on nameplates while solo (for classes with pets and guardians)"

--[[ koKR ]] bL["Texture"] = "텍스쳐"
--[[ koKR ]] bL["Sets the threat bar texture"] = "위협바의 텍스쳐를 설정합니다."
--[[ koKR ]] bL["Alpha"] = "투명도"
--[[ koKR ]] bL["Sets the threat bar alpha"] = "위협바의 투명도를 설정합니다."

--[[ koKR ]] bL["Height"] = "높이"
--[[ koKR ]] bL["Sets the height of the threat bar"] = "위협바의 높이를 설정합니다."

--[[ koKR ]] bL["Position"] = "위치"
--[[ koKR ]] bL["Adjust the threat bar's position"] = "위협바의 위치를 조절합니다."
--[[ koKR ]] bL["Left Offset"] = "좌측 좌표"
--[[ koKR ]] bL["Sets the offset of the left of the threat bar"] = "위협바의 좌측 좌표를 설정합니다."
--[[ koKR ]] bL["Right Offset"] = "우측 좌표"
--[[ koKR ]] bL["Sets the offset of the right of the threat bar"] = "위협바의 우측 좌표를 설정합니다."
--[[ koKR ]] bL["Vertical Offset"] = "수직 좌표"
--[[ koKR ]] bL["Sets the vertical offset of the threat bar"] = "위협바의 수직 좌표를 설정합니다."

--[[ koKR ]] bL["Colors"] = "색상"
--[[ koKR ]] bL["Customize colors"] = "사용자 색상"
--[[ koKR ]] bL["Backdrop Color"] = "배경 색상"
--[[ koKR ]] bL["Sets the backdrop color of the threat bar"] = "Sets the backdrop color of the threat bar"
--[[ koKR ]] bL["Common Threat Color"] = "Common Threat Color"
--[[ koKR ]] bL["Sets the threat color for the threat bar when indicating common threat"] = "Sets the threat color for the threat bar when indicating common threat"
--[[ koKR ]] bL["Maximum Threat Color"] = "Maximum Threat Color"
--[[ koKR ]] bL["Sets the threat color for the threat bar when indicating maximum threat"] = "Sets the threat color for the threat bar when indicating maximum threat"

--[[ koKR ]] bL["Reset to Defaults"] = "기본값 초기화"
--[[ koKR ]] bL["Resets all colors to their defaults"] = "모든 색상을 기본값으로 초기화합니다."

--[[ koKR ]] bL["Border"] = "Border"
--[[ koKR ]] bL["Border options"] = "Border options"
--[[ koKR ]] bL["Target Only"] = "Target Only"
--[[ koKR ]] bL["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ koKR ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ koKR ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ koKR ]] bL["Border Inset"] = "Border Inset"
--[[ koKR ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ koKR ]] bL["Border Color"] = "테두리 색상"
--[[ koKR ]] bL["Sets the border color of the threat bar"] = "Sets the border color of the threat bar"
--[[ koKR ]] bL["Border Style"] = "테두리 스타일"
--[[ koKR ]] bL["Sets the style of the threat bar border"] = "Sets the style of the threat bar border"

--[[ koKR ]] bL["Threat Gain"] = "Threat Gain"
--[[ koKR ]] bL["Threat gain threshold indicator for the player's target nameplate"] = "Threat gain threshold indicator for the player's target nameplate"
--[[ koKR ]] bL["Show maximum threat threshold on the player's target nameplate"] = "Show maximum threat threshold on the player's target nameplate"
--[[ koKR ]] bL["Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar"] = "Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar"
--[[ koKR ]] bL["Threat Gain Color"] = "Threat Gain Color"
--[[ koKR ]] bL["Sets the color of the maximum threat threshold on the player's target nameplate"] = "Sets the color of the maximum threat threshold on the player's target nameplate"

--[[ koKR ]] bL["Threat Flash"] = "Threat Flash"
--[[ koKR ]] bL["Health bar will be highlighted when unit has maximum threat"] = "Health bar will be highlighted when unit has maximum threat"
--[[ koKR ]] bL["Show threat flash"] = "Show threat flash"
--[[ koKR ]] bL["Invert"] = "Invert"
--[[ koKR ]] bL["Invert threat flash (enable on targets below the threshold)"] = "Invert threat flash (enable on targets below the threshold)"
--[[ koKR ]] bL["Threshold"] = "Threshold"
--[[ koKR ]] bL["The percentage of maximum threat at which flash appears"] = "The percentage of maximum threat at which flash appears"

--[[ koKR ]] bL["Size"] = "크기"
--[[ koKR ]] bL["Adjust threat flash size"] = "Adjust threat flash size"
--[[ koKR ]] bL["Width"] = "너비"
--[[ koKR ]] bL["Sets the width of the threat flash"] = "Sets the width of the threat flash"
--[[ koKR ]] bL["Height"] = "높이"
--[[ koKR ]] bL["Sets the height of the threat flash"] = "Sets the height of the threat flash"

--[[ koKR ]] bL["Position"] = "위치"
--[[ koKR ]] bL["Adjust the threat flash position"] = "Adjust the threat flash position"
--[[ koKR ]] bL["X Offset"] = "X 좌표"
--[[ koKR ]] bL["X offset of the threat flash"] = "X offset of the threat flash"
--[[ koKR ]] bL["Y Offset"] = "Y 좌표"
--[[ koKR ]] bL["Y offset of the threat flash"] = "Y offset of the threat flash"

--[[ koKR ]] bL["Style"] = "Style"
--[[ koKR ]] bL["Sets the threat flash style"] = "Sets the threat flash style"
--[[ koKR ]] bL["Color"] = "색상"
--[[ koKR ]] bL["Sets the threat flash color"] = "Sets the threat flash color"
--[[ koKR ]] bL["Blend Mode"] = "혼합 모드"
--[[ koKR ]] bL["Sets the threat flash blend mode"] = "Sets the threat flash blend mode"
--[[ koKR ]] bL["Resets the threat flash color to its default"] = "Resets the threat flash color to its default"
--[[ koKR ]] bL["Resets the maximum threat threshold color to its default"] = "Resets the maximum threat threshold color to its default"
--[[ koKR ]] bL["Reset Color to Default"] = "Reset Color to Default"

--[[ koKR ]] bL["Incremetal"] = "Incremetal"
--[[ koKR ]] bL["Update incrementally; workaround for malformed borders, only relevant when borders are enabled"] = "Update incrementally; workaround for malformed borders, only relevant when borders are enabled"

--[[ koKR ]] bL["Advanced"] = "고급"
--[[ koKR ]] bL["Options for expert users"] = "고급 사용자를 위한 설정"
--[[ koKR ]] bL["<Any tag string>"] = "<태그 문자열>"

--[[ koKR ]] bL["BLEND"] = "혼합"
--[[ koKR ]] bL["ADD"] = "추가"

--[[ koKR ]] bL["HARD"] = "HARD"
--[[ koKR ]] bL["SOFT"] = "SOFT"
--[[ koKR ]] bL["PRTLSOFT"] = "PRTLSOFT"
--[[ koKR ]] bL["THRQTRSOFT"] = "THRQTRSOFT"
--[[ koKR ]] bL["EXTRASOFT"] = "EXTRASOFT"
--[[ koKR ]] bL["OVAL"] = "OVAL"
--[[ koKR ]] bL["OVALGLOW"] = "OVALGLOW"
--[[ koKR ]] bL["SQUAREGLOW"] = "SQUAREGLOW"
--[[ koKR ]] bL["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW"
--[[ koKR ]] bL["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW"

-----------------------------------------------------------------------------

--[[ koKR ]] tL["Threat Text"] = "Threat Text"
--[[ koKR ]] tL["Threat text options"] = "Threat text options"
--[[ koKR ]] tL["Enable"] = "사용"
--[[ koKR ]] tL["Show threat text on nameplates"] = "Show threat text on nameplates"
--[[ koKR ]] tL["Active While Solo"] = "Active While Solo"
--[[ koKR ]] tL["Show threat text on nameplates while solo (for classes with pets and guardians)"] = "Show threat text on nameplates while solo (for classes with pets and guardians)"

--[[ koKR ]] tL["Typeface"] = "서체"
--[[ koKR ]] tL["Threat text typeface options"] = "Threat text typeface options"
--[[ koKR ]] tL["Font"] = "글꼴"
--[[ koKR ]] tL["Sets the font for threat text"] = "Sets the font for threat text"
--[[ koKR ]] tL["Font Size"] = "글꼴 크기"
--[[ koKR ]] tL["Sets the font height of the threat text"] = "Sets the font height of the threat text"
--[[ koKR ]] tL["Font Shadow"] = "글꼴 그림자"
--[[ koKR ]] tL["Show font shadow on threat text"] = "Show font shadow on threat text"
--[[ koKR ]] tL["Outline"] = "테두리"
--[[ koKR ]] tL["Sets the outline for threat text"] = "Sets the outline for threat text"
--[[ koKR ]] tL["Mode"] = "모드"
--[[ koKR ]] tL["Choose what to show for threat text"] = "Choose what to show for threat text"

--[[ koKR ]] tL["Position"] = "위치"
--[[ koKR ]] tL["Adjust threat text position"] = "Adjust threat text position"
--[[ koKR ]] tL["Anchor"] = "앵커"
--[[ koKR ]] tL["Sets the anchor for the threat text"] = "Sets the anchor for the threat text"
--[[ koKR ]] tL["Anchor To"] = "앵커 위치"
--[[ koKR ]] tL["Sets the relative point on the threat bar to anchor the threat text"] = "Sets the relative point on the threat bar to anchor the threat text"
--[[ koKR ]] tL["X Offset"] = "X 좌표"
--[[ koKR ]] tL["X offset of the threat text"] = "X offset of the threat text"
--[[ koKR ]] tL["Y Offset"] = "Y 좌표"
--[[ koKR ]] tL["Y offset of the threat text"] = "Y offset of the threat text"
--[[ koKR ]] tL["Alpha"] = "투명도"
--[[ koKR ]] tL["Sets the alpha of the threat text"] = "Sets the alpha of the threat text"
--[[ koKR ]] tL["Color"] = "색상"
--[[ koKR ]] tL["Sets the threat text color"] = "Sets the threat text color"

--[[ koKR ]] tL["None"] = "없음"
--[[ koKR ]] tL["Normal"] = "기본"
--[[ koKR ]] tL["Thick"] = "굵게"

--[[ koKR ]] tL["Percent"] = "Percent"
--[[ koKR ]] tL["Threat"] = "Threat"
--[[ koKR ]] tL["Threat & Percent"] = "Threat & Percent"
--[[ koKR ]] tL["Deficit"] = "Deficit"
--[[ koKR ]] tL["Full"] = "Full"

--[[ koKR ]] tL["Advanced"] = "고급"
--[[ koKR ]] tL["Options for expert users"] = "고급 사용자를 위한 설정입니다."
--[[ koKR ]] tL["Format"] = "형식"
--[[ koKR ]] tL["Threat tag"] = "Threat tag"
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

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftThreat"] = "Aloft Threat"
--[[ koKR ]] mL["Display threat data, bars, and text on nameplates"] = "Show threat data, bars, and text on nameplates"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] dL["AOE Threat"] = "Масс угроза"
--[[ ruRU ]] dL["Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"] = "Попытаться подсчитать  приблизительное значение угрозы для видимох враждебнох единиц против игрока (	кроме игрока нынешней цели)"
--[[ ruRU ]] dL["Group Threat"] = "Угроза группы"
--[[ ruRU ]] dL["Attempt to approximate threat for visible friendly units versus the player's current target"] = "Попытаться подсчитать  приблизительное значение угрозы для видимых дружественных единиц против игрока\существа текущей цели"
--[[ ruRU ]] dL["AOE/Group Threat Update Interval"] = "Скорость обновления угрозы МАСС/Группы"
--[[ ruRU ]] dL["The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"] = "Значение времени в секундах, между обновлениеми угрозы активной/обширной-группы (0.0 максимальная скорость)"

-----------------------------------------------------------------------------

--[[ ruRU ]] bL["Threat Bar"] = "Полоска угрозы"
--[[ ruRU ]] bL["Threat Bar options"] = "Настройки полоски угрозы"
--[[ ruRU ]] bL["Enable"] = "Включить"
--[[ ruRU ]] bL["Show threat bars on group member nameplates"] = "Отображать полоски угрозы на табличках участников группы"
--[[ ruRU ]] bL["Active While Solo"] = "Включено, когда один"
--[[ ruRU ]] bL["Show threat bars on nameplates while solo (for classes with pets and guardians)"] = "Отображать полоски угрозы на табличках когда один (для классов с питомцами и защитниками)"

--[[ ruRU ]] bL["Texture"] = "Текстура"
--[[ ruRU ]] bL["Sets the threat bar texture"] = "Задает текстуру полоски угрозы"
--[[ ruRU ]] bL["Alpha"] = "Прозрачность"
--[[ ruRU ]] bL["Sets the threat bar alpha"] = "Задает прозрачность полоски угрозы"

--[[ ruRU ]] bL["Height"] = "Высота"
--[[ ruRU ]] bL["Sets the height of the threat bar"] = "Задает высоту полоски угрозы"

--[[ ruRU ]] bL["Position"] = "Позиция"
--[[ ruRU ]] bL["Adjust the threat bar's position"] = "Задать место полоски угрозы"
--[[ ruRU ]] bL["Left Offset"] = "Левое смещение"
--[[ ruRU ]] bL["Sets the offset of the left of the threat bar"] = "Задает смещение правого конца полоски угрозы"
--[[ ruRU ]] bL["Right Offset"] = "Правое смещение"
--[[ ruRU ]] bL["Sets the offset of the right of the threat bar"] = "Задает смещение правого конца полоски угрозы"
--[[ ruRU ]] bL["Vertical Offset"] = "Вертикальное смещение"
--[[ ruRU ]] bL["Sets the vertical offset of the threat bar"] = "Задает вертикальное смещение полоски угрозы"

--[[ ruRU ]] bL["Colors"] = "Цвета"
--[[ ruRU ]] bL["Customize colors"] = "Настройка цветов"
--[[ ruRU ]] bL["Backdrop Color"] = "Цвет тени"
--[[ ruRU ]] bL["Sets the backdrop color of the threat bar"] = "Задает цвет тени полоски угрозы"
--[[ ruRU ]] bL["Common Threat Color"] = "Цвет общей угрозы"
--[[ ruRU ]] bL["Sets the threat color for the threat bar when indicating common threat"] = "Задает цвет угрозы для полоски угрозы при отображении обычной угрозы"
--[[ ruRU ]] bL["Maximum Threat Color"] = "Цвет максимальной угрозы"
--[[ ruRU ]] bL["Sets the threat color for the threat bar when indicating maximum threat"] = "Задает цвет угрозы для полоски угрозы при отображении максимальной угрозы"

--[[ ruRU ]] bL["Reset to Defaults"] = "Сбросить настройки"
--[[ ruRU ]] bL["Resets all colors to their defaults"] = "Сбрасывает все цвета в настройки по умолчанию"

--[[ ruRU ]] bL["Border"] = "Края"
--[[ ruRU ]] bL["Border options"] = "Настройки краев"
--[[ ruRU ]] bL["Target Only"] = "Только цель"
--[[ ruRU ]] bL["Enables the border on the current target only"] = "Включить края только для текущей цели"
--[[ ruRU ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ ruRU ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ ruRU ]] bL["Border Inset"] = "Border Inset"
--[[ ruRU ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ ruRU ]] bL["Border Color"] = "Цвет рамки"
--[[ ruRU ]] bL["Sets the border color of the threat bar"] = "Задает цвет рамки таблички угрозы"
--[[ ruRU ]] bL["Border Style"] = "Стиль рамки"
--[[ ruRU ]] bL["Sets the style of the threat bar border"] = "Задает стиль рамки таблички угрозы"

--[[ ruRU ]] bL["Threat Gain"] = "Получение угрозы"
--[[ ruRU ]] bL["Threat gain threshold indicator for the player's target nameplate"] = "Уровень угрозы для начала индикации на табличке игрока"
--[[ ruRU ]] bL["Show maximum threat threshold on the player's target nameplate"] = "Отображать максимальный уровень угрозы на табличке цели"
--[[ ruRU ]] bL["Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar"] = "Задает вертикальное смещение уровня максимальной угрозы относительно полоски угрозы"
--[[ ruRU ]] bL["Threat Gain Color"] = "Цвет получения угрозы"
--[[ ruRU ]] bL["Sets the color of the maximum threat threshold on the player's target nameplate"] = "Задает цвет максимального уровня угрозы на табличке цели"

--[[ ruRU ]] bL["Threat Flash"] = "Вспышка угрозы"
--[[ ruRU ]] bL["Health bar will be highlighted when unit has maximum threat"] = "Полоса здоровья будет подсвечиваться когда игрок/существо достигает макс угрозы"
--[[ ruRU ]] bL["Show threat flash"] = "Отображать вспышку угрозы"
--[[ ruRU ]] bL["Invert"] = "Инвертировать"
--[[ ruRU ]] bL["Invert threat flash (enable on targets below the threshold)"] = "Инвертировать вспышку угрозы (включить на целях ниже порога)"
--[[ ruRU ]] bL["Threshold"] = "Смещение"
--[[ ruRU ]] bL["The percentage of maximum threat at which flash appears"] = "Процент от максимального уровня угрозы, при котором появляется вспышка"

--[[ ruRU ]] bL["Size"] = "Размер"
--[[ ruRU ]] bL["Adjust threat flash size"] = "Задать место вспышки угрозы"
--[[ ruRU ]] bL["Width"] = "Ширина"
--[[ ruRU ]] bL["Sets the width of the threat flash"] = "Задает ширину вспышки угрозы"
--[[ ruRU ]] bL["Height"] = "Высота"
--[[ ruRU ]] bL["Sets the height of the threat flash"] = "Задает высоту вспышки угрозы"

--[[ ruRU ]] bL["Position"] = "Позиция"
--[[ ruRU ]] bL["Adjust the threat flash position"] = "Задать место вспышки угрозы"
--[[ ruRU ]] bL["X Offset"] = "Смещение по X"
--[[ ruRU ]] bL["X offset of the threat flash"] = "Смещение вспышки угрозы по X"
--[[ ruRU ]] bL["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] bL["Y offset of the threat flash"] = "Смещение вспышки угрозы по Y"

--[[ ruRU ]] bL["Style"] = "Стиль"
--[[ ruRU ]] bL["Sets the threat flash style"] = "Задает стиль вспышки угрозы"
--[[ ruRU ]] bL["Color"] = "Цвет"
--[[ ruRU ]] bL["Sets the threat flash color"] = "Задает цвет вспышки угрозы"
--[[ ruRU ]] bL["Blend Mode"] = "Режим смешивания"
--[[ ruRU ]] bL["Sets the threat flash blend mode"] = "Задает тип смешения вспышки угрозы"
--[[ ruRU ]] bL["Resets the threat flash color to its default"] = "Сброс цвета вспышки угрозы в цвет по умолчанию"
--[[ ruRU ]] bL["Resets the maximum threat threshold color to its default"] = "Сброс цвета максимальной пороговой угрозы в цвет по умолчанию"
--[[ ruRU ]] bL["Reset Color to Default"] = "Сбросить цвет на изначальный"

--[[ ruRU ]] bL["Incremetal"] = "Incremetal"
--[[ ruRU ]] bL["Update incrementally; workaround for malformed borders, only relevant when borders are enabled"] = "Update incrementally; workaround for malformed borders, only relevant when borders are enabled"

--[[ ruRU ]] bL["Advanced"] = "Дополнительно"
--[[ ruRU ]] bL["Options for expert users"] = "Настройки для опытных пользователей"
--[[ ruRU ]] bL["<Any tag string>"] = "<Любая строка формата>"

--[[ ruRU ]] bL["BLEND"] = "СМЕШИВАТЬ"
--[[ ruRU ]] bL["ADD"] = "ДОБАВИТЬ"

--[[ ruRU ]] bL["HARD"] = "СИЛЬНОЕ"
--[[ ruRU ]] bL["SOFT"] = "МЯГКОЕ"
--[[ ruRU ]] bL["PRTLSOFT"] = "PRTLSOFT"
--[[ ruRU ]] bL["THRQTRSOFT"] = "THRQTRSOFT"
--[[ ruRU ]] bL["EXTRASOFT"] = "СВЕРХМЯГКОЕ"
--[[ ruRU ]] bL["OVAL"] = "ОВАЛ"
--[[ ruRU ]] bL["OVALGLOW"] = "ОВАЛСВЕЧЕНИЕ"
--[[ ruRU ]] bL["SQUAREGLOW"] = "КВАДРАТНОЕ СВЕЧЕНИЕ"

-----------------------------------------------------------------------------

--[[ ruRU ]] tL["Threat Text"] = "Текст угрозы"
--[[ ruRU ]] tL["Threat text options"] = "Настройки текста угрозы"
--[[ ruRU ]] tL["Enable"] = "Включить"
--[[ ruRU ]] tL["Show threat text on nameplates"] = "Отображать текст угрозы на табличках"
--[[ ruRU ]] tL["Active While Solo"] = "Включено, когда один"
--[[ ruRU ]] tL["Show threat text on nameplates while solo (for classes with pets and guardians)"] = "Отображать текст угрозы когда один (для классов с питомцами и защитниками)"

--[[ ruRU ]] tL["Typeface"] = "Шрифт"
--[[ ruRU ]] tL["Threat text typeface options"] = "Настройки шрифта текста угрозы"
--[[ ruRU ]] tL["Font"] = "Шрифт"
--[[ ruRU ]] tL["Sets the font for threat text"] = "Задает шрифт для текста угрозы"
--[[ ruRU ]] tL["Font Size"] = "Размер шрифта"
--[[ ruRU ]] tL["Sets the font height of the threat text"] = "Задает высоту шрифта для текста угрозы"
--[[ ruRU ]] tL["Font Shadow"] = "Тень шрифта"
--[[ ruRU ]] tL["Show font shadow on threat text"] = "Отображать тень для текста угрозы"
--[[ ruRU ]] tL["Outline"] = "Контур"
--[[ ruRU ]] tL["Sets the outline for threat text"] = "Задает контур для текста угрозы"
--[[ ruRU ]] tL["Mode"] = "Режим"
--[[ ruRU ]] tL["Choose what to show for threat text"] = "Выбрать, что показывать в тексте угрозы"

--[[ ruRU ]] tL["Position"] = "Позиция"
--[[ ruRU ]] tL["Adjust threat text position"] = "Задать позицию значения угрозы"
--[[ ruRU ]] tL["Anchor"] = "Точка прикрепления"
--[[ ruRU ]] tL["Sets the anchor for the threat text"] = "Задает прикрепление текста угрозы"
--[[ ruRU ]] tL["Anchor To"] = "Прикрепить к"
--[[ ruRU ]] tL["Sets the relative point on the threat bar to anchor the threat text"] = "Задает точку для положения текста угрозы относительно полоски угрозы"
--[[ ruRU ]] tL["X Offset"] = "Смещение по X"
--[[ ruRU ]] tL["X offset of the threat text"] = "Смещение текста угрозы по X"
--[[ ruRU ]] tL["Y Offset"] = "Смещение по Y"
--[[ ruRU ]] tL["Y offset of the threat text"] = "Смещение текста угрозы по Y"
--[[ ruRU ]] tL["Alpha"] = "Прозрачность"
--[[ ruRU ]] tL["Sets the alpha of the threat text"] = "Задает прозрачность текста угрозы"
--[[ ruRU ]] tL["Color"] = "Цвет"
--[[ ruRU ]] tL["Sets the threat text color"] = "Задает цвет текста угрозы"

--[[ ruRU ]] tL["None"] = "Нет"
--[[ ruRU ]] tL["Normal"] = "Обычно"
--[[ ruRU ]] tL["Thick"] = "Жирный"

--[[ ruRU ]] tL["Percent"] = "Проценты"
--[[ ruRU ]] tL["Threat"] = "Угроза"
--[[ ruRU ]] tL["Threat & Percent"] = "Угроза & Проценты"
--[[ ruRU ]] tL["Deficit"] = "Дефицит"
--[[ ruRU ]] tL["Full"] = "Полное"

--[[ ruRU ]] tL["Advanced"] = "Дополнительно"
--[[ ruRU ]] tL["Options for expert users"] = "Настройки для опытных пользователей"
--[[ ruRU ]] tL["Format"] = "Формат"
--[[ ruRU ]] tL["Threat tag"] = "Формат угрозы"
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

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftThreat"] = "AloftThreat"
--[[ ruRU ]] mL["Display threat data, bars, and text on nameplates"] = "Отображает текст/полосы/данные по угрозе"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] dL["AOE Threat"] = "AOE Threat"
--[[ zhCN ]] dL["Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"] = "Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"
--[[ zhCN ]] dL["Group Threat"] = "Group Threat"
--[[ zhCN ]] dL["Attempt to approximate threat for visible friendly units versus the player's current target"] = "Attempt to approximate threat for visible friendly units versus the player's current target"
--[[ zhCN ]] dL["AOE/Group Threat Update Interval"] = "AOE/Group Threat Update Interval"
--[[ zhCN ]] dL["The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"] = "The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"

-----------------------------------------------------------------------------

--[[ zhCN ]] bL["Threat Bar"] = "威胁值显示条"
--[[ zhCN ]] bL["Threat Bar options"] = "威胁值显示条相关设置"
--[[ zhCN ]] bL["Enable"] = "启用"
--[[ zhCN ]] bL["Show threat bars on group member nameplates"] = "在小队成员的姓名板上显示威胁值"
--[[ zhCN ]] bL["Active While Solo"] = "单人时也启用"
--[[ zhCN ]] bL["Show threat bars on nameplates while solo (for classes with pets and guardians)"] = "单人时也启用"

--[[ zhCN ]] bL["Texture"] = "材质"
--[[ zhCN ]] bL["Sets the threat bar texture"] = "设定威胁值显示条的材质"
--[[ zhCN ]] bL["Alpha"] = "透明度"
--[[ zhCN ]] bL["Sets the threat bar alpha"] = "设定威胁值显示条的透明度"

--[[ zhCN ]] bL["Height"] = "高度"
--[[ zhCN ]] bL["Sets the height of the threat bar"] = "设定威胁值显示条的高度"

--[[ zhCN ]] bL["Position"] = "位置"
--[[ zhCN ]] bL["Adjust the threat bar's position"] = "调整威胁值显示条的位置"
--[[ zhCN ]] bL["Left Offset"] = "向左偏移"
--[[ zhCN ]] bL["Sets the offset of the left of the threat bar"] = "设定威胁值显示条的向左偏移量"
--[[ zhCN ]] bL["Right Offset"] = "向右偏移"
--[[ zhCN ]] bL["Sets the offset of the right of the threat bar"] = "设定威胁值显示条的向右偏移量"
--[[ zhCN ]] bL["Vertical Offset"] = "垂直偏移"
--[[ zhCN ]] bL["Sets the vertical offset of the threat bar"] = "设定威胁值显示条的垂直偏移量"

--[[ zhCN ]] bL["Colors"] = "颜色"
--[[ zhCN ]] bL["Customize colors"] = "自定义颜色"
--[[ zhCN ]] bL["Backdrop Color"] = "背景颜色"
--[[ zhCN ]] bL["Sets the backdrop color of the threat bar"] = "设置威胁值条的背景颜色"
--[[ zhCN ]] bL["Common Threat Color"] = "普通威胁颜色"
--[[ zhCN ]] bL["Sets the threat color for the threat bar when indicating common threat"] = "设置普通威胁状态的威胁条颜色"
--[[ zhCN ]] bL["Maximum Threat Color"] = "最大威胁颜色"
--[[ zhCN ]] bL["Sets the threat color for the threat bar when indicating maximum threat"] = "设置最大威胁状态的威胁条颜色"

--[[ zhCN ]] bL["Reset to Defaults"] = "重置为默认值"
--[[ zhCN ]] bL["Resets all colors to their defaults"] = "将全部颜色设定重置为默认"

--[[ zhCN ]] bL["Border"] = "Border"
--[[ zhCN ]] bL["Border options"] = "Border options"
--[[ zhCN ]] bL["Target Only"] = "Target Only"
--[[ zhCN ]] bL["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ zhCN ]] bL["Border Edge Size"] = "Border Edge Size"
--[[ zhCN ]] bL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ zhCN ]] bL["Border Inset"] = "Border Inset"
--[[ zhCN ]] bL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ zhCN ]] bL["Border Color"] = "边框颜色"
--[[ zhCN ]] bL["Sets the border color of the threat bar"] = "Sets the border color of the threat bar"
--[[ zhCN ]] bL["Border Style"] = "边框样式"
--[[ zhCN ]] bL["Sets the style of the threat bar border"] = "Sets the style of the threat bar border"

--[[ zhCN ]] bL["Threat Gain"] = "获得仇恨"
--[[ zhCN ]] bL["Threat gain threshold indicator for the player's target nameplate"] = "玩家目标姓名板上的获得仇恨阀值指示器"
--[[ zhCN ]] bL["Show maximum threat threshold on the player's target nameplate"] = "在玩家目标姓名板上显示最大威胁阀值"
--[[ zhCN ]] bL["Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar"] = "设置最大威胁阀值相对于威胁条其他部分的垂直偏移"
--[[ zhCN ]] bL["Threat Gain Color"] = "获得仇恨颜色"
--[[ zhCN ]] bL["Sets the color of the maximum threat threshold on the player's target nameplate"] = "设置玩家目标姓名板上的最大威胁阀值颜色"

--[[ zhCN ]] bL["Threat Flash"] = "威胁闪烁"
--[[ zhCN ]] bL["Health bar will be highlighted when unit has maximum threat"] = "在该单位获得最大威胁值时高亮其生命条"
--[[ zhCN ]] bL["Invert"] = "Invert"
--[[ zhCN ]] bL["Invert threat flash (enable on targets below the threshold)"] = "Invert threat flash (enable on targets below the threshold)"
--[[ zhCN ]] bL["Show threat flash"] = "使用威胁闪烁"
--[[ zhCN ]] bL["Threshold"] = "Threshold"
--[[ zhCN ]] bL["The percentage of maximum threat at which flash appears"] = "The percentage of maximum threat at which flash appears"

--[[ zhCN ]] bL["Size"] = "尺寸"
--[[ zhCN ]] bL["Adjust threat flash size"] = "Adjust threat flash size"
--[[ zhCN ]] bL["Width"] = "宽度"
--[[ zhCN ]] bL["Sets the width of the threat flash"] = "Sets the width of the threat flash"
--[[ zhCN ]] bL["Height"] = "高度"
--[[ zhCN ]] bL["Sets the height of the threat flash"] = "Sets the height of the threat flash"

--[[ zhCN ]] bL["Position"] = "位置"
--[[ zhCN ]] bL["Adjust the threat flash position"] = "Adjust the threat flash position"
--[[ zhCN ]] bL["X Offset"] = "X轴偏移"
--[[ zhCN ]] bL["X offset of the threat flash"] = "X offset of the threat flash"
--[[ zhCN ]] bL["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] bL["Y offset of the threat flash"] = "Y offset of the threat flash"

--[[ zhCN ]] bL["Style"] = "Style"
--[[ zhCN ]] bL["Sets the threat flash style"] = "Sets the threat flash style"
--[[ zhCN ]] bL["Color"] = "颜色"
--[[ zhCN ]] bL["Sets the threat flash color"] = "设置威胁闪烁的高亮颜色"
--[[ zhCN ]] bL["Blend Mode"] = "渐变模式"
--[[ zhCN ]] bL["Sets the threat flash blend mode"] = "为仇恨闪烁使用渐变模式"
--[[ zhCN ]] bL["Resets the threat flash color to its default"] = "重置威胁闪烁的高亮颜色"
--[[ zhCN ]] bL["Resets the maximum threat threshold color to its default"] = "重置最大仇恨威胁指示的颜色"
--[[ zhCN ]] bL["Reset Color to Default"] = "重置颜色"

--[[ zhCN ]] bL["Incremetal"] = "Incremetal"
--[[ zhCN ]] bL["Update incrementally; workaround for malformed borders, only relevant when borders are enabled"] = "Update incrementally; workaround for malformed borders, only relevant when borders are enabled"

--[[ zhCN ]] bL["Advanced"] = "高级"
--[[ zhCN ]] bL["Options for expert users"] = "高级设置"
--[[ zhCN ]] bL["<Any tag string>"] = "<任意标签文字>"

--[[ zhCN ]] bL["BLEND"] = "渲染"
--[[ zhCN ]] bL["ADD"] = "增加"

--[[ zhCN ]] bL["HARD"] = "HARD"
--[[ zhCN ]] bL["SOFT"] = "SOFT"
--[[ zhCN ]] bL["PRTLSOFT"] = "PRTLSOFT"
--[[ zhCN ]] bL["THRQTRSOFT"] = "THRQTRSOFT"
--[[ zhCN ]] bL["EXTRASOFT"] = "EXTRASOFT"
--[[ zhCN ]] bL["OVAL"] = "OVAL"
--[[ zhCN ]] bL["OVALGLOW"] = "OVALGLOW"
--[[ zhCN ]] bL["SQUAREGLOW"] = "SQUAREGLOW"
--[[ zhCN ]] bL["PRTLSQUAREGLOW"] = "PRTLSQUAREGLOW"
--[[ zhCN ]] bL["THRQTRSQUAREGLOW"] = "THRQTRSQUAREGLOW"

-----------------------------------------------------------------------------

--[[ zhCN ]] tL["Threat Text"] = "威胁值文字"
--[[ zhCN ]] tL["Threat text options"] = "威胁值文字选项"
--[[ zhCN ]] tL["Enable"] = "启用"
--[[ zhCN ]] tL["Show threat text on nameplates"] = "在姓名板上显示威胁值文字"
--[[ zhCN ]] tL["Active While Solo"] = "单人时也启用"
--[[ zhCN ]] tL["Show threat text on nameplates while solo (for classes with pets and guardians)"] = "单人时也启用"

--[[ zhCN ]] tL["Typeface"] = "式样"
--[[ zhCN ]] tL["Threat text typeface options"] = "威胁值文字样式选项"
--[[ zhCN ]] tL["Font"] = "字体"
--[[ zhCN ]] tL["Sets the font for threat text"] = "设置威胁值字体"
--[[ zhCN ]] tL["Font Size"] = "字号"
--[[ zhCN ]] tL["Sets the font height of the threat text"] = "设置威胁值文字大小"
--[[ zhCN ]] tL["Font Shadow"] = "字体阴影"
--[[ zhCN ]] tL["Show font shadow on threat text"] = "为威胁值文字使用阴影"
--[[ zhCN ]] tL["Outline"] = "轮廓"
--[[ zhCN ]] tL["Sets the outline for threat text"] = "设置威胁值文字描边"
--[[ zhCN ]] tL["Mode"] = "模式"
--[[ zhCN ]] tL["Choose what to show for threat text"] = "选择威胁值文字要显示的内容"

--[[ zhCN ]] tL["Position"] = "位置"
--[[ zhCN ]] tL["Adjust threat text position"] = "调整威胁值文字位置"
--[[ zhCN ]] tL["Anchor"] = "锚点"
--[[ zhCN ]] tL["Sets the anchor for the threat text"] = "设置威胁值文字的锚点"
--[[ zhCN ]] tL["Anchor To"] = "固定在"
--[[ zhCN ]] tL["Sets the relative point on the threat bar to anchor the threat text"] = "设置威胁值文字要依附到威胁值条的哪个位置"
--[[ zhCN ]] tL["X Offset"] = "X轴偏移"
--[[ zhCN ]] tL["X offset of the threat text"] = "威胁值文字的横向偏移"
--[[ zhCN ]] tL["Y Offset"] = "Y轴偏移"
--[[ zhCN ]] tL["Y offset of the threat text"] = "威胁值文字的纵向偏移"
--[[ zhCN ]] tL["Alpha"] = "透明度"
--[[ zhCN ]] tL["Sets the alpha of the threat text"] = "威胁值文字的透明度"
--[[ zhCN ]] tL["Color"] = "颜色"
--[[ zhCN ]] tL["Sets the threat text color"] = "威胁值文字颜色"

--[[ zhCN ]] tL["None"] = "无"
--[[ zhCN ]] tL["Normal"] = "正常"
--[[ zhCN ]] tL["Thick"] = "粗"

--[[ zhCN ]] tL["Percent"] = "百分比"
--[[ zhCN ]] tL["Threat"] = "威胁值"
--[[ zhCN ]] tL["Threat & Percent"] = "威胁值和百分比"
--[[ zhCN ]] tL["Deficit"] = "亏减"
--[[ zhCN ]] tL["Full"] = "全部"

--[[ zhCN ]] tL["Advanced"] = "高级"
--[[ zhCN ]] tL["Options for expert users"] = "高级设置"
--[[ zhCN ]] tL["Format"] = "格式"
--[[ zhCN ]] tL["Threat tag"] = "威胁标签"
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

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftThreat"] = "威胁值"
--[[ zhCN ]] mL["Display threat data, bars, and text on nameplates"] = "在姓名板上显示威胁值数据、计量条和文本"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] dL["AOE Threat"] = "AOE仇恨"
--[[ zhTW ]] dL["Attempt to approximate threat for visible hostile units versus the player (other than the player's current target)"] = "嘗試概略估算敵對單位與玩家的仇恨(除了玩家的目前目標)"
--[[ zhTW ]] dL["Group Threat"] = "隊伍仇恨"
--[[ zhTW ]] dL["Attempt to approximate threat for visible friendly units versus the player's current target"] = "嘗試概略計算友好單位與玩家目前目標的仇恨"
--[[ zhTW ]] dL["AOE/Group Threat Update Interval"] = "AOE/隊伍仇恨更新間隔"
--[[ zhTW ]] dL["The amount of time, in seconds, between proactive/group-wide threat updates (0.0 is as fast as possible)"] = "單位時間，幾秒內，主動/隊伍範圍仇恨更新間隔(0.0 是盡可能快)"

-----------------------------------------------------------------------------

--[[ zhTW ]] bL["Threat Bar"] = "仇恨條"
--[[ zhTW ]] bL["Threat Bar options"] = "仇恨條設定"
--[[ zhTW ]] bL["Enable"] = "啟用"
--[[ zhTW ]] bL["Show threat bars on group member nameplates"] = "在隊伍成員名牌上顯示仇恨條"
--[[ zhTW ]] bL["Active While Solo"] = "單人下也顯示"
--[[ zhTW ]] bL["Show threat bars on nameplates while solo (for classes with pets and guardians)"] = "在單人時在名牌上顯示仇恨條（例如有寵物和守護者的職業）"

--[[ zhTW ]] bL["Texture"] = "材質"
--[[ zhTW ]] bL["Sets the threat bar texture"] = "設定仇恨條材質"
--[[ zhTW ]] bL["Alpha"] = "透明度"
--[[ zhTW ]] bL["Sets the threat bar alpha"] = "設定仇恨條透明度"

--[[ zhTW ]] bL["Height"] = "高度"
--[[ zhTW ]] bL["Sets the height of the threat bar"] = "設定仇恨條的高度"

--[[ zhTW ]] bL["Position"] = "位置"
--[[ zhTW ]] bL["Adjust the threat bar's position"] = "調整仇恨條的位置"
--[[ zhTW ]] bL["Left Offset"] = "左偏移"
--[[ zhTW ]] bL["Sets the offset of the left of the threat bar"] = "設定仇恨條的左偏移"
--[[ zhTW ]] bL["Right Offset"] = "右偏移"
--[[ zhTW ]] bL["Sets the offset of the right of the threat bar"] = "設定仇恨條的右偏移"
--[[ zhTW ]] bL["Vertical Offset"] = "垂直偏移"
--[[ zhTW ]] bL["Sets the vertical offset of the threat bar"] = "設定仇恨條的垂直偏移"

--[[ zhTW ]] bL["Colors"] = "顏色"
--[[ zhTW ]] bL["Customize colors"] = "自定顏色"
--[[ zhTW ]] bL["Backdrop Color"] = "背景顏色"
--[[ zhTW ]] bL["Sets the backdrop color of the threat bar"] = "設定仇恨條的背景顏色"
--[[ zhTW ]] bL["Common Threat Color"] = "普通威脅顏色"
--[[ zhTW ]] bL["Sets the threat color for the threat bar when indicating common threat"] = "設定普通威脅的仇恨條顏色"
--[[ zhTW ]] bL["Maximum Threat Color"] = "最大威脅顏色"
--[[ zhTW ]] bL["Sets the threat color for the threat bar when indicating maximum threat"] = "設定最大威脅的仇恨條顏色"

--[[ zhTW ]] bL["Reset to Defaults"] = "重置到預設"
--[[ zhTW ]] bL["Resets all colors to their defaults"] = "重置全部顏色到預設"

--[[ zhTW ]] bL["Border"] = "邊框"
--[[ zhTW ]] bL["Border options"] = "邊框設定"
--[[ zhTW ]] bL["Target Only"] = "只在目標"
--[[ zhTW ]] bL["Enables the border on the current target only"] = "Enables the border on the current target only"
--[[ zhTW ]] bL["Border Edge Size"] = "邊框邊緣大小"
--[[ zhTW ]] bL["Sets the thickness of the border"] = "設定邊框的厚度"
--[[ zhTW ]] bL["Border Inset"] = "邊框崁入"
--[[ zhTW ]] bL["Sets the padding aroundthe border"] = "設定邊框的間距範圍"
--[[ zhTW ]] bL["Border Color"] = "邊框顏色"
--[[ zhTW ]] bL["Sets the border color of the threat bar"] = "設定仇恨條的邊框顏色"
--[[ zhTW ]] bL["Border Style"] = "邊框樣式"
--[[ zhTW ]] bL["Sets the style of the threat bar border"] = "設定仇恨條邊框的樣式"

--[[ zhTW ]] bL["Threat Gain"] = "獲得仇恨"
--[[ zhTW ]] bL["Threat gain threshold indicator for the player's target nameplate"] = "玩家目標名牌上顯示的威脅獲得門檻指示"
--[[ zhTW ]] bL["Show maximum threat threshold on the player's target nameplate"] = "在玩家目標名牌上顯示最大威脅門檻"
--[[ zhTW ]] bL["Sets the vertical offset of the maximum threat threshold, relative to the rest of the threat bar"] = "設定最大仇恨門檻的垂直偏移，相對仇恨條的停止"
--[[ zhTW ]] bL["Threat Gain Color"] = "仇恨獲得顏色"
--[[ zhTW ]] bL["Sets the color of the maximum threat threshold on the player's target nameplate"] = "設定在玩家目標名牌上最大仇恨門檻的顏色"

--[[ zhTW ]] bL["Threat Flash"] = "仇恨閃爍"
--[[ zhTW ]] bL["Health bar will be highlighted when unit has maximum threat"] = "當單位獲得最大威脅時突出其生命條"
--[[ zhTW ]] bL["Show threat flash"] = "顯示仇恨閃爍"
--[[ zhTW ]] bL["Invert"] = "反轉"
--[[ zhTW ]] bL["Invert threat flash (enable on targets below the threshold)"] = "反轉仇恨閃爍(啟用在目標門檻之下上)"
--[[ zhTW ]] bL["Threshold"] = "門檻"
--[[ zhTW ]] bL["The percentage of maximum threat at which flash appears"] = "在閃爍允許最大仇恨百分比"

--[[ zhTW ]] bL["Size"] = "大小"
--[[ zhTW ]] bL["Adjust threat flash size"] = "調整仇恨閃爍大小"
--[[ zhTW ]] bL["Width"] = "寬度"
--[[ zhTW ]] bL["Sets the width of the threat flash"] = "設定仇恨閃爍的寬度"
--[[ zhTW ]] bL["Height"] = "高度"
--[[ zhTW ]] bL["Sets the height of the threat flash"] = "設定仇恨閃爍的高度"

--[[ zhTW ]] bL["Position"] = "位置"
--[[ zhTW ]] bL["Adjust the threat flash position"] = "調整仇恨閃爍位置"
--[[ zhTW ]] bL["X Offset"] = "X偏移"
--[[ zhTW ]] bL["X offset of the threat flash"] = "仇恨閃爍的X偏移"
--[[ zhTW ]] bL["Y Offset"] = "Y偏移"
--[[ zhTW ]] bL["Y offset of the threat flash"] = "仇恨閃爍的Y偏移"

--[[ zhTW ]] bL["Style"] = "樣式"
--[[ zhTW ]] bL["Sets the threat flash style"] = "設定仇恨閃爍樣式"
--[[ zhTW ]] bL["Color"] = "顏色"
--[[ zhTW ]] bL["Sets the threat flash color"] = "設定仇恨閃爍顏色"
--[[ zhTW ]] bL["Blend Mode"] = "混合模式"
--[[ zhTW ]] bL["Sets the threat flash blend mode"] = "設定仇恨閃爍混合模式"
--[[ zhTW ]] bL["Resets the threat flash color to its default"] = "重置仇恨閃爍顏色到預設"
--[[ zhTW ]] bL["Resets the maximum threat threshold color to its default"] = "重置最大威脅門檻顏色到預設"
--[[ zhTW ]] bL["Reset Color to Default"] = "重置顏色到預設"

--[[ zhTW ]] bL["Incremetal"] = "增量"
--[[ zhTW ]] bL["Update incrementally; workaround for malformed borders, only relevant when borders are enabled"] = "立即更新;變形邊框的應變措施，只跟當邊框啟用有關"

--[[ zhTW ]] bL["Advanced"] = "進階"
--[[ zhTW ]] bL["Options for expert users"] = "熟練的使用者設定"
--[[ zhTW ]] bL["<Any tag string>"] = "<任何標籤文字>"

--[[ zhTW ]] bL["BLEND"] = "混合"          
--[[ zhTW ]] bL["ADD"] = "增加"

--[[ zhTW ]] bL["HARD"] = "生硬"
--[[ zhTW ]] bL["SOFT"] = "柔和"
--[[ zhTW ]] bL["PRTLSOFT"] = "PRTL柔和"
--[[ zhTW ]] bL["THRQTRSOFT"] = "THRQTR柔和"
--[[ zhTW ]] bL["EXTRASOFT"] = "EXTRA柔和"
--[[ zhTW ]] bL["OVAL"] = "橢圓形"
--[[ zhTW ]] bL["OVALGLOW"] = "橢圓形發光"
--[[ zhTW ]] bL["SQUAREGLOW"] = "正方形發光"
--[[ zhTW ]] bL["PRTLSQUAREGLOW"] = "PRTL正方形發光"
--[[ zhTW ]] bL["THRQTRSQUAREGLOW"] = "THRQTR正方形發光"

-----------------------------------------------------------------------------

--[[ zhTW ]] tL["Threat Text"] = "仇恨文字"
--[[ zhTW ]] tL["Threat text options"] = "仇恨文字設定"
--[[ zhTW ]] tL["Enable"] = "啟用"
--[[ zhTW ]] tL["Show threat text on nameplates"] = "在名牌上顯示仇恨文字"
--[[ zhTW ]] tL["Active While Solo"] = "單人時顯示"
--[[ zhTW ]] tL["Show threat text on nameplates while solo (for classes with pets and guardians)"] = "在單人時在名牌上顯示仇恨文字（例如有寵物和守護者的職業）"

--[[ zhTW ]] tL["Typeface"] = "字體"
--[[ zhTW ]] tL["Threat text typeface options"] = "仇恨文字字體設定"
--[[ zhTW ]] tL["Font"] = "字型"
--[[ zhTW ]] tL["Sets the font for threat text"] = "設定仇恨文字的字型"
--[[ zhTW ]] tL["Font Size"] = "字型大小"
--[[ zhTW ]] tL["Sets the font height of the threat text"] = "設定仇恨文字的字型高度"
--[[ zhTW ]] tL["Font Shadow"] = "字型陰影"
--[[ zhTW ]] tL["Show font shadow on threat text"] = "設定仇恨文字的字型陰影"
--[[ zhTW ]] tL["Outline"] = "輪廓"
--[[ zhTW ]] tL["Sets the outline for threat text"] = "設定仇恨文字的輪廓"
--[[ zhTW ]] tL["Mode"] = "模式"
--[[ zhTW ]] tL["Choose what to show for threat text"] = "選擇仇恨文字顯示什麼"

--[[ zhTW ]] tL["Position"] = "位置"
--[[ zhTW ]] tL["Adjust threat text position"] = "調整仇恨文字位置"
--[[ zhTW ]] tL["Anchor"] = "錨點"
--[[ zhTW ]] tL["Sets the anchor for the threat text"] = "設定仇恨文字的錨點"
--[[ zhTW ]] tL["Anchor To"] = "依附到"
--[[ zhTW ]] tL["Sets the relative point on the threat bar to anchor the threat text"] = "設定在仇恨條上錨到仇恨文字的相關點"
--[[ zhTW ]] tL["X Offset"] = "X偏移"
--[[ zhTW ]] tL["X offset of the threat text"] = "仇恨文字的X偏移"
--[[ zhTW ]] tL["Y Offset"] = "Y偏移"
--[[ zhTW ]] tL["Y offset of the threat text"] = "仇恨文字的Y偏移"
--[[ zhTW ]] tL["Alpha"] = "透明度"
--[[ zhTW ]] tL["Sets the alpha of the threat text"] = "設定仇恨文字的透明度"
--[[ zhTW ]] tL["Color"] = "顏色"
--[[ zhTW ]] tL["Sets the threat text color"] = "設定仇恨文字顏色"

--[[ zhTW ]] tL["None"] = "無"
--[[ zhTW ]] tL["Normal"] = "正常"
--[[ zhTW ]] tL["Thick"] = "粗"

--[[ zhTW ]] tL["Percent"] = "百分比"
--[[ zhTW ]] tL["Threat"] = "仇恨"
--[[ zhTW ]] tL["Threat & Percent"] = "仇恨和百分比"
--[[ zhTW ]] tL["Deficit"] = "虧減"
--[[ zhTW ]] tL["Full"] = "完整"

--[[ zhTW ]] tL["Advanced"] = "進階"
--[[ zhTW ]] tL["Options for expert users"] = "熟練的使用者設定"
--[[ zhTW ]] tL["Format"] = "格式"
--[[ zhTW ]] tL["Threat tag"] = "仇恨標簽"
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

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftThreat"] = "Aloft仇恨"
--[[ zhTW ]] mL["Display threat data, bars, and text on nameplates"] = "在名牌上顯示仇恨資料、條和文字"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

AloftLocale.AloftThreatDataOptions = setmetatable(dL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
dL = nil

-----------------------------------------------------------------------------

AloftLocale.AloftThreatBarOptions = setmetatable(bL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
bL = nil

-----------------------------------------------------------------------------

AloftLocale.AloftThreatTextOptions = setmetatable(tL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
tL = nil

-----------------------------------------------------------------------------

end)
