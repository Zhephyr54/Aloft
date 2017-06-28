local Aloft = Aloft
if not Aloft then return end
-- local AloftModules = AloftModules
-- if not AloftModules then return end

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

local wL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningOptions")

wL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Cast Warning"] = true,
	--[[ enUS ]] ["Cast warning options"] = true,

	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show cast warnings on identifiable enemy nameplates"] = true,
	--[[ enUS ]] ["Verification Interval"] = true,
	--[[ enUS ]] ["Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"] = true,
	--[[ enUS ]] ["Animated Cast Warning"] = true,
	--[[ enUS ]] ["Animate cast warnings as cast bars"] = true,
	--[[ enUS ]] ["Fade Duration"] = true,
	--[[ enUS ]] ["Sets the fade duration of animated cast warnings (0.0 is no fade)"] = true,
	--[[ enUS ]] ["Trade Skills"] = true,
	--[[ enUS ]] ["Show cast warnings for trade skills"] = true,
	--[[ enUS ]] ["Players"] = true,
	--[[ enUS ]] ["Show cast warnings for players"] = true,
	--[[ enUS ]] ["Friendly Units"] = true,
	--[[ enUS ]] ["Show cast warnings for friendly units"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust the cast warning's position"] = true,
	--[[ enUS ]] ["Left Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the left of the cast warning"] = true,
	--[[ enUS ]] ["Right Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the right of the cast warning"] = true,
	--[[ enUS ]] ["Vertical Offset"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the cast warning"] = true,

	--[[ enUS ]] ["Height"] = true,
	--[[ enUS ]] ["Sets the height of the cast warning"] = true,

	--[[ enUS ]] ["Interruptable Cast Warning"] = true,
	--[[ enUS ]] ["Cast warning appearance for interruptable spells"] = true,
	--[[ enUS ]] ["Uninterruptable Cast Warning"] = true,
	--[[ enUS ]] ["Cast warning appearance for uninterruptable spells"] = true,

	--[[ enUS ]] ["Cast Warning Color"] = true,
	--[[ enUS ]] ["Sets the color of the cast warning"] = true,
	--[[ enUS ]] ["Backdrop Color"] = true,
	--[[ enUS ]] ["Sets the backdrop color of the cast warning"] = true,
	--[[ enUS ]] ["Border Color"] = true,
	--[[ enUS ]] ["Sets the border color of the cast warning"] = true,
	--[[ enUS ]] ["Border Style"] = true,
	--[[ enUS ]] ["Sets the style of the cast warning border"] = true,
	--[[ enUS ]] ["Texture"] = true,
	--[[ enUS ]] ["Sets the cast warning texture"] = true,

	--[[ enUS ]] ["Cast Warning Alpha Override Enable"] = true,
	--[[ enUS ]] ["Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = true,
	--[[ enUS ]] ["Cast Warning Alpha Override"] = true,
	--[[ enUS ]] ["Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = true,

	--[[ enUS ]] ["Colors"] = true,
	--[[ enUS ]] ["Customize cast warning colors (based on spell school)"] = true,
	--[[ enUS ]] ["Default"] = true,
	--[[ enUS ]] ["Sets the default color for cast warnings from unknown schools"] = true,
	--[[ enUS ]] ["Physical"] = true,
	--[[ enUS ]] ["Sets the color for physical school cast warnings"] = true,
	--[[ enUS ]] ["Holy"] = true,
	--[[ enUS ]] ["Sets the color for holy school cast warnings"] = true,
	--[[ enUS ]] ["Fire"] = true,
	--[[ enUS ]] ["Sets the color for fire school cast warnings"] = true,
	--[[ enUS ]] ["Nature"] = true,
	--[[ enUS ]] ["Sets the color for nature school cast warnings"] = true,
	--[[ enUS ]] ["Frost"] = true,
	--[[ enUS ]] ["Sets the color for frost school cast warnings"] = true,
	--[[ enUS ]] ["Shadow"] = true,
	--[[ enUS ]] ["Sets the color for shadow school cast warnings"] = true,
	--[[ enUS ]] ["Arcane"] = true,
	--[[ enUS ]] ["Sets the color for arcane school cast warnings"] = true,
	--[[ enUS ]] ["Healing"] = true,
	--[[ enUS ]] ["Sets the color for healing school cast warnings"] = true,

	--[[ enUS ]] ["Reset to Defaults"] = true,
	--[[ enUS ]] ["Resets all colors to their defaults"] = true,
} end)

-----------------------------------------------------------------------------

local iL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningSpellIconOptions")

iL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Spell Icon"] = true,
	--[[ enUS ]] ["Cast warning spell icon placement options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Enable cast warning spell icon display on the nameplate"] = true,
	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust cast warning spell icon position"] = true,
	--[[ enUS ]] ["Anchor"] = true,
	--[[ enUS ]] ["Sets the anchor for the cast warning spell icon"] = true,
	--[[ enUS ]] ["Anchor To"] = true,
	--[[ enUS ]] ["Sets the relative point on the cast warning to anchor the spell icon"] = true,
	--[[ enUS ]] ["X Offset"] = true,
	--[[ enUS ]] ["X offset of the cast warning spell icon"] = true,
	--[[ enUS ]] ["Y Offset"] = true,
	--[[ enUS ]] ["Y offset of the cast warning spell icon"] = true,
	--[[ enUS ]] ["Size"] = true,
	--[[ enUS ]] ["Size in pixels of the cast warning spell icon"] = true,

	--[[ enUS ]] ["Shield"] = true,
	--[[ enUS ]] ["Shows a shield graphic around an uninterruptable spell icon"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Enables the shield graphic"] = true,
	--[[ enUS ]] ["Style"] = true,
	--[[ enUS ]] ["Sets the shield graphic style"] = true,
	--[[ enUS ]] ["Color"] = true,
	--[[ enUS ]] ["Sets the shield graphic color"] = true,

	--[[ enUS ]] ["SQUARE"] = true,
	--[[ enUS ]] ["ROUND"] = true,

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

local nL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningSpellNameTextOptions")

-- leave "enUS" active at all times, as a default locale
nL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Spell Name"] = true,
	--[[ enUS ]] ["Cast warning spell name text options"] = true,

	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show cast warning spell name"] = true,
	--[[ enUS ]] ["Display Rank"] = true,
	--[[ enUS ]] ["Show cast warning spell rank"] = true,
	--[[ enUS ]] ["Display Min/Max Range"] = true,
	--[[ enUS ]] ["Show cast warning spell minimum/maximum range"] = true,
	--[[ enUS ]] ["Display Outcome"] = true,
	--[[ enUS ]] ["Show cast warning spell outcome"] = true,
	--[[ enUS ]] ["Display Outcome Reason"] = true,
	--[[ enUS ]] ["Show cast warning spell outcome reason"] = true,
	--[[ enUS ]] ["Display Outcome Reason"] = true,
	--[[ enUS ]] ["Show cast warning spell outcome reason (failure type, interrupting spell)"] = true,

	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Spell name typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for spell name"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the spell name"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on spell name"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the font outline for spell name"] = true,

	--[[ enUS ]] ["Alignment"] = true,
	--[[ enUS ]] ["Sets the alignment of the spell name"] = true,

	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust spell name position"] = true,
	--[[ enUS ]] ["Left Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the left of the text"] = true,
	--[[ enUS ]] ["Right Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the right of the text"] = true,
	--[[ enUS ]] ["Vertical Offset"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the text"] = true,

	--[[ enUS ]] ["Colors"] = true,
	--[[ enUS ]] ["Sets the spell name colors"] = true,
	--[[ enUS ]] ["Cast Color"] = true,
	--[[ enUS ]] ["Sets the spell name color during active casting"] = true,
	--[[ enUS ]] ["Fade Color"] = true,
	--[[ enUS ]] ["Sets the spell name color during cast warning fade"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["LEFT"] = true,
	--[[ enUS ]] ["CENTER"] = true,
	--[[ enUS ]] ["RIGHT"] = true,
} end)

-----------------------------------------------------------------------------

local tL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningTimeTextOptions")

tL:RegisterTranslations("enUS", function() return {
	--[[ enUS ]] ["Spell Time"] = true,
	--[[ enUS ]] ["Cast warning spell time text options"] = true,
	--[[ enUS ]] ["Enable"] = true,
	--[[ enUS ]] ["Show cast warning spell time"] = true,
	--[[ enUS ]] ["Typeface"] = true,
	--[[ enUS ]] ["Spell time typeface options"] = true,
	--[[ enUS ]] ["Font"] = true,
	--[[ enUS ]] ["Sets the font for spell time"] = true,
	--[[ enUS ]] ["Font Size"] = true,
	--[[ enUS ]] ["Sets the font height of the spell time"] = true,
	--[[ enUS ]] ["Font Shadow"] = true,
	--[[ enUS ]] ["Show font shadow on spell time"] = true,
	--[[ enUS ]] ["Outline"] = true,
	--[[ enUS ]] ["Sets the font outline for spell time"] = true,
	--[[ enUS ]] ["Alignment"] = true,
	--[[ enUS ]] ["Sets the alignment of the spell time"] = true,
	--[[ enUS ]] ["Position"] = true,
	--[[ enUS ]] ["Adjust spell time position"] = true,
	--[[ enUS ]] ["Left Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the left of the text"] = true,
	--[[ enUS ]] ["Right Offset"] = true,
	--[[ enUS ]] ["Sets the offset of the right of the text"] = true,
	--[[ enUS ]] ["Vertical Offset"] = true,
	--[[ enUS ]] ["Sets the vertical offset of the text"] = true,

	--[[ enUS ]] ["Colors"] = true,
	--[[ enUS ]] ["Sets the spell time colors"] = true,
	--[[ enUS ]] ["Cast Color"] = true,
	--[[ enUS ]] ["Sets the spell time color during active casting"] = true,
	--[[ enUS ]] ["Fade Color"] = true,
	--[[ enUS ]] ["Sets the spell time color during cast warning fade"] = true,

	--[[ enUS ]] ["None"] = true,
	--[[ enUS ]] ["Normal"] = true,
	--[[ enUS ]] ["Thick"] = true,

	--[[ enUS ]] ["LEFT"] = true,
	--[[ enUS ]] ["CENTER"] = true,
	--[[ enUS ]] ["RIGHT"] = true,
} end)

-----------------------------------------------------------------------------

-- end)

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------


local wL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningOptions")

wL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Cast Warning"] = "Cast Warning",
	--[[ koKR ]] ["Cast warning options"] = "Cast warning options",

	--[[ koKR ]] ["Enable"] = "Enable",
	--[[ koKR ]] ["Show cast warnings on identifiable enemy nameplates"] = "Show cast warnings on identifiable enemy nameplates",
	--[[ koKR ]] ["Verification Interval"] = "Verification Interval",
	--[[ koKR ]] ["Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"] = "Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)",
	--[[ koKR ]] ["Animated Cast Warning"] = "Animated Cast Warning",
	--[[ koKR ]] ["Animate cast warnings as cast bars"] = "Animate cast warnings as cast bars",
	--[[ koKR ]] ["Fade Duration"] = "Fade Duration",
	--[[ koKR ]] ["Sets the fade duration of animated cast warnings (0.0 is no fade)"] = "Sets the fade duration of animated cast warnings (0.0 is no fade)",
	--[[ koKR ]] ["Trade Skills"] = "Trade Skills",
	--[[ koKR ]] ["Show cast warnings for trade skills"] = "Show cast warnings for trade skills",
	--[[ koKR ]] ["Players"] = "Players",
	--[[ koKR ]] ["Show cast warnings for players"] = "Show cast warnings for players",
	--[[ koKR ]] ["Friendly Units"] = "Friendly Units",
	--[[ koKR ]] ["Show cast warnings for friendly units"] = "Show cast warnings for friendly units",

	--[[ koKR ]] ["Position"] = "Position",
	--[[ koKR ]] ["Adjust the cast warning's position"] = "Adjust the cast warning's position",
	--[[ koKR ]] ["Left Offset"] = "Left Offset",
	--[[ koKR ]] ["Sets the offset of the left of the cast warning"] = "Sets the offset of the left of the cast warning",
	--[[ koKR ]] ["Right Offset"] = "Right Offset",
	--[[ koKR ]] ["Sets the offset of the right of the cast warning"] = "Sets the offset of the right of the cast warning",
	--[[ koKR ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ koKR ]] ["Sets the vertical offset of the cast warning"] = "Sets the vertical offset of the cast warning",

	--[[ koKR ]] ["Height"] = "Height",
	--[[ koKR ]] ["Sets the height of the cast warning"] = "Sets the height of the cast warning",

	--[[ koKR ]] ["Interruptable Cast Warning"] = "Interruptable Cast Warning",
	--[[ koKR ]] ["Cast warning appearance for interruptable spells"] = "Cast warning appearance for interruptable spells",
	--[[ koKR ]] ["Uninterruptable Cast Warning"] = "Uninterruptable Cast Warning",
	--[[ koKR ]] ["Cast warning appearance for uninterruptable spells"] = "Cast warning appearance for uninterruptable spells",

	--[[ koKR ]] ["Cast Warning Color"] = "Cast Warning Color",
	--[[ koKR ]] ["Sets the color of the cast warning"] = "Sets the color of the cast warning",
	--[[ koKR ]] ["Backdrop Color"] = "Backdrop Color",
	--[[ koKR ]] ["Sets the backdrop color of the cast warning"] = "Sets the backdrop color of the cast warning",
	--[[ koKR ]] ["Border Color"] = "Border Color",
	--[[ koKR ]] ["Sets the border color of the cast warning"] = "Sets the border color of the cast warning",
	--[[ koKR ]] ["Border Style"] = "Border Style",
	--[[ koKR ]] ["Sets the style of the cast warning border"] = "Sets the style of the cast warning border",
	--[[ koKR ]] ["Texture"] = "Texture",
	--[[ koKR ]] ["Sets the cast warning texture"] = "Sets the cast warning texture",

	--[[ koKR ]] ["Cast Warning Alpha Override Enable"] = "Cast Warning Alpha Override Enable",
	--[[ koKR ]] ["Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)",
	--[[ koKR ]] ["Cast Warning Alpha Override"] = "Cast Warning Alpha Override",
	--[[ koKR ]] ["Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)",

	--[[ koKR ]] ["Colors"] = "Colors",
	--[[ koKR ]] ["Customize cast warning colors (based on spell school)"] = "Customize cast warning colors (based on spell school)",
	--[[ koKR ]] ["Default"] = "Default",
	--[[ koKR ]] ["Sets the default color for cast warnings from unknown schools"] = "Sets the default color for cast warnings from unknown schools",
	--[[ koKR ]] ["Physical"] = "Physical",
	--[[ koKR ]] ["Sets the color for physical school cast warnings"] = "Sets the color for physical school cast warnings",
	--[[ koKR ]] ["Holy"] = "Holy",
	--[[ koKR ]] ["Sets the color for holy school cast warnings"] = "Sets the color for holy school cast warnings",
	--[[ koKR ]] ["Fire"] = "Fire",
	--[[ koKR ]] ["Sets the color for fire school cast warnings"] = "Sets the color for fire school cast warnings",
	--[[ koKR ]] ["Nature"] = "Nature",
	--[[ koKR ]] ["Sets the color for nature school cast warnings"] = "Sets the color for nature school cast warnings",
	--[[ koKR ]] ["Frost"] = "Frost",
	--[[ koKR ]] ["Sets the color for frost school cast warnings"] = "Sets the color for frost school cast warnings",
	--[[ koKR ]] ["Shadow"] = "Shadow",
	--[[ koKR ]] ["Sets the color for shadow school cast warnings"] = "Sets the color for shadow school cast warnings",
	--[[ koKR ]] ["Arcane"] = "Arcane",
	--[[ koKR ]] ["Sets the color for arcane school cast warnings"] = "Sets the color for arcane school cast warnings",
	--[[ koKR ]] ["Healing"] = "Healing",
	--[[ koKR ]] ["Sets the color for healing school cast warnings"] = "Sets the color for healing school cast warnings",

	--[[ koKR ]] ["Reset to Defaults"] = "Reset to Defaults",
	--[[ koKR ]] ["Resets all colors to their defaults"] = "Resets all colors to their defaults",
} end)

-----------------------------------------------------------------------------

local iL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningSpellIconOptions")

iL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Spell Icon"] = "Spell Icon",
	--[[ koKR ]] ["Cast warning spell icon placement options"] = "Cast warning spell icon placement options",
	--[[ koKR ]] ["Enable"] = "Enable",
	--[[ koKR ]] ["Enable cast warning spell icon display on the nameplate"] = "Enable cast warning spell icon display on the nameplate",
	--[[ koKR ]] ["Position"] = "Position",
	--[[ koKR ]] ["Adjust cast warning spell icon position"] = "Adjust cast warning spell icon position",
	--[[ koKR ]] ["Anchor"] = "Anchor",
	--[[ koKR ]] ["Sets the anchor for the cast warning spell icon"] = "Sets the anchor for the cast warning spell icon",
	--[[ koKR ]] ["Anchor To"] = "Anchor To",
	--[[ koKR ]] ["Sets the relative point on the cast warning to anchor the spell icon"] = "Sets the relative point on the cast warning to anchor the spell icon",
	--[[ koKR ]] ["X Offset"] = "X Offset",
	--[[ koKR ]] ["X offset of the cast warning spell icon"] = "X offset of the cast warning spell icon",
	--[[ koKR ]] ["Y Offset"] = "Y Offset",
	--[[ koKR ]] ["Y offset of the cast warning spell icon"] = "Y offset of the cast warning spell icon",
	--[[ koKR ]] ["Size"] = "Size",
	--[[ koKR ]] ["Size in pixels of the cast warning spell icon"] = "Size in pixels of the cast warning spell icon",

	--[[ koKR ]] ["Shield"] = "Shield",
	--[[ koKR ]] ["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon",
	--[[ koKR ]] ["Enable"] = "Enable",
	--[[ koKR ]] ["Enables the shield graphic"] = "Enables the shield graphic",
	--[[ koKR ]] ["Style"] = "Style",
	--[[ koKR ]] ["Sets the shield graphic style"] = "Sets the shield graphic style",
	--[[ koKR ]] ["Color"] = "Color",
	--[[ koKR ]] ["Sets the shield graphic color"] = "Sets the shield graphic color",

	--[[ koKR ]] ["SQUARE"] = "SQUARE",
	--[[ koKR ]] ["ROUND"] = "ROUND",

	--[[ koKR ]] ["TOPLEFT"] = "TOPLEFT",
	--[[ koKR ]] ["TOP"] = "TOP",
	--[[ koKR ]] ["TOPRIGHT"] = "TOPRIGHT",
	--[[ koKR ]] ["LEFT"] = "LEFT",
	--[[ koKR ]] ["CENTER"] = "CENTER",
	--[[ koKR ]] ["RIGHT"] = "RIGHT",
	--[[ koKR ]] ["BOTTOMLEFT"] = "BOTTOMLEFT",
	--[[ koKR ]] ["BOTTOM"] = "BOTTOM",
	--[[ koKR ]] ["BOTTOMRIGHT"] = "BOTTOMRIGHT",
} end)

-----------------------------------------------------------------------------

local nL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningSpellNameTextOptions")

-- leave "koKR" active at all times, as a default locale
nL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Spell Name"] = "Spell Name",
	--[[ koKR ]] ["Cast warning spell name text options"] = "Cast warning spell name text options",

	--[[ koKR ]] ["Enable"] = "Enable",
	--[[ koKR ]] ["Show cast warning spell name"] = "Show cast warning spell name",
	--[[ koKR ]] ["Display Rank"] = "Display Rank",
	--[[ koKR ]] ["Show cast warning spell rank"] = "Show cast warning spell rank",
	--[[ koKR ]] ["Display Min/Max Range"] = "Display Min/Max Range",
	--[[ koKR ]] ["Show cast warning spell minimum/maximum range"] = "Show cast warning spell minimum/maximum range",
	--[[ koKR ]] ["Display Outcome"] = "Display Outcome",
	--[[ koKR ]] ["Show cast warning spell outcome"] = "Show cast warning spell outcome",
	--[[ koKR ]] ["Display Outcome Reason"] = "Display Outcome Reason",
	--[[ koKR ]] ["Show cast warning spell outcome reason"] = "Show cast warning spell outcome reason",
	--[[ koKR ]] ["Display Outcome Reason"] = "Display Outcome Reason",
	--[[ koKR ]] ["Show cast warning spell outcome reason (failure type, interrupting spell)"] = "Show cast warning spell outcome reason (failure type, interrupting spell)",

	--[[ koKR ]] ["Typeface"] = "Typeface",
	--[[ koKR ]] ["Spell name typeface options"] = "Spell name typeface options",
	--[[ koKR ]] ["Font"] = "Font",
	--[[ koKR ]] ["Sets the font for spell name"] = "Sets the font for spell name",
	--[[ koKR ]] ["Font Size"] = "Font Size",
	--[[ koKR ]] ["Sets the font height of the spell name"] = "Sets the font height of the spell name",
	--[[ koKR ]] ["Font Shadow"] = "Font Shadow",
	--[[ koKR ]] ["Show font shadow on spell name"] = "Show font shadow on spell name",
	--[[ koKR ]] ["Outline"] = "Outline",
	--[[ koKR ]] ["Sets the font outline for spell name"] = "Sets the font outline for spell name",

	--[[ koKR ]] ["Alignment"] = "Alignment",
	--[[ koKR ]] ["Sets the alignment of the spell name"] = "Sets the alignment of the spell name",

	--[[ koKR ]] ["Position"] = "Position",
	--[[ koKR ]] ["Adjust spell name position"] = "Adjust spell name position",
	--[[ koKR ]] ["Left Offset"] = "Left Offset",
	--[[ koKR ]] ["Sets the offset of the left of the text"] = "Sets the offset of the left of the text",
	--[[ koKR ]] ["Right Offset"] = "Right Offset",
	--[[ koKR ]] ["Sets the offset of the right of the text"] = "Sets the offset of the right of the text",
	--[[ koKR ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ koKR ]] ["Sets the vertical offset of the text"] = "Sets the vertical offset of the text",

	--[[ koKR ]] ["Colors"] = "Colors",
	--[[ koKR ]] ["Sets the spell name colors"] = "Sets the spell name colors",
	--[[ koKR ]] ["Cast Color"] = "Cast Color",
	--[[ koKR ]] ["Sets the spell name color during active casting"] = "Sets the spell name color during active casting",
	--[[ koKR ]] ["Fade Color"] = "Fade Color",
	--[[ koKR ]] ["Sets the spell name color during cast warning fade"] = "Sets the spell name color during cast warning fade",

	--[[ koKR ]] ["None"] = "None",
	--[[ koKR ]] ["Normal"] = "Normal",
	--[[ koKR ]] ["Thick"] = "Thick",

	--[[ koKR ]] ["LEFT"] = "LEFT",
	--[[ koKR ]] ["CENTER"] = "CENTER",
	--[[ koKR ]] ["RIGHT"] = "RIGHT",
} end)

-----------------------------------------------------------------------------

local tL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningTimeTextOptions")

tL:RegisterTranslations("koKR", function() return {
	--[[ koKR ]] ["Spell Time"] = "Spell Time",
	--[[ koKR ]] ["Cast warning spell time text options"] = "Cast warning spell time text options",
	--[[ koKR ]] ["Enable"] = "Enable",
	--[[ koKR ]] ["Show cast warning spell time"] = "Show cast warning spell time",
	--[[ koKR ]] ["Typeface"] = "Typeface",
	--[[ koKR ]] ["Spell time typeface options"] = "Spell time typeface options",
	--[[ koKR ]] ["Font"] = "Font",
	--[[ koKR ]] ["Sets the font for spell time"] = "Sets the font for spell time",
	--[[ koKR ]] ["Font Size"] = "Font Size",
	--[[ koKR ]] ["Sets the font height of the spell time"] = "Sets the font height of the spell time",
	--[[ koKR ]] ["Font Shadow"] = "Font Shadow",
	--[[ koKR ]] ["Show font shadow on spell time"] = "Show font shadow on spell time",
	--[[ koKR ]] ["Outline"] = "Outline",
	--[[ koKR ]] ["Sets the font outline for spell time"] = "Sets the font outline for spell time",
	--[[ koKR ]] ["Alignment"] = "Alignment",
	--[[ koKR ]] ["Sets the alignment of the spell time"] = "Sets the alignment of the spell time",
	--[[ koKR ]] ["Position"] = "Position",
	--[[ koKR ]] ["Adjust spell time position"] = "Adjust spell time position",
	--[[ koKR ]] ["Left Offset"] = "Left Offset",
	--[[ koKR ]] ["Sets the offset of the left of the text"] = "Sets the offset of the left of the text",
	--[[ koKR ]] ["Right Offset"] = "Right Offset",
	--[[ koKR ]] ["Sets the offset of the right of the text"] = "Sets the offset of the right of the text",
	--[[ koKR ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ koKR ]] ["Sets the vertical offset of the text"] = "Sets the vertical offset of the text",

	--[[ koKR ]] ["Colors"] = "Colors",
	--[[ koKR ]] ["Sets the spell time colors"] = "Sets the spell time colors",
	--[[ koKR ]] ["Cast Color"] = "Cast Color",
	--[[ koKR ]] ["Sets the spell time color during active casting"] = "Sets the spell time color during active casting",
	--[[ koKR ]] ["Fade Color"] = "Fade Color",
	--[[ koKR ]] ["Sets the spell time color during cast warning fade"] = "Sets the spell time color during cast warning fade",

	--[[ koKR ]] ["None"] = "None",
	--[[ koKR ]] ["Normal"] = "Normal",
	--[[ koKR ]] ["Thick"] = "Thick",

	--[[ koKR ]] ["LEFT"] = "LEFT",
	--[[ koKR ]] ["CENTER"] = "CENTER",
	--[[ koKR ]] ["RIGHT"] = "RIGHT",
} end)

-----------------------------------------------------------------------------

-- end)

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------


local wL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningOptions")

wL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Cast Warning"] = "Cast Warning",
	--[[ ruRU ]] ["Cast warning options"] = "Cast warning options",

	--[[ ruRU ]] ["Enable"] = "Enable",
	--[[ ruRU ]] ["Show cast warnings on identifiable enemy nameplates"] = "Show cast warnings on identifiable enemy nameplates",
	--[[ ruRU ]] ["Verification Interval"] = "Verification Interval",
	--[[ ruRU ]] ["Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"] = "Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)",
	--[[ ruRU ]] ["Animated Cast Warning"] = "Animated Cast Warning",
	--[[ ruRU ]] ["Animate cast warnings as cast bars"] = "Animate cast warnings as cast bars",
	--[[ ruRU ]] ["Fade Duration"] = "Fade Duration",
	--[[ ruRU ]] ["Sets the fade duration of animated cast warnings (0.0 is no fade)"] = "Sets the fade duration of animated cast warnings (0.0 is no fade)",
	--[[ ruRU ]] ["Trade Skills"] = "Trade Skills",
	--[[ ruRU ]] ["Show cast warnings for trade skills"] = "Show cast warnings for trade skills",
	--[[ ruRU ]] ["Players"] = "Players",
	--[[ ruRU ]] ["Show cast warnings for players"] = "Show cast warnings for players",
	--[[ ruRU ]] ["Friendly Units"] = "Friendly Units",
	--[[ ruRU ]] ["Show cast warnings for friendly units"] = "Show cast warnings for friendly units",

	--[[ ruRU ]] ["Position"] = "Position",
	--[[ ruRU ]] ["Adjust the cast warning's position"] = "Adjust the cast warning's position",
	--[[ ruRU ]] ["Left Offset"] = "Left Offset",
	--[[ ruRU ]] ["Sets the offset of the left of the cast warning"] = "Sets the offset of the left of the cast warning",
	--[[ ruRU ]] ["Right Offset"] = "Right Offset",
	--[[ ruRU ]] ["Sets the offset of the right of the cast warning"] = "Sets the offset of the right of the cast warning",
	--[[ ruRU ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ ruRU ]] ["Sets the vertical offset of the cast warning"] = "Sets the vertical offset of the cast warning",

	--[[ ruRU ]] ["Height"] = "Height",
	--[[ ruRU ]] ["Sets the height of the cast warning"] = "Sets the height of the cast warning",

	--[[ ruRU ]] ["Interruptable Cast Warning"] = "Interruptable Cast Warning",
	--[[ ruRU ]] ["Cast warning appearance for interruptable spells"] = "Cast warning appearance for interruptable spells",
	--[[ ruRU ]] ["Uninterruptable Cast Warning"] = "Uninterruptable Cast Warning",
	--[[ ruRU ]] ["Cast warning appearance for uninterruptable spells"] = "Cast warning appearance for uninterruptable spells",

	--[[ ruRU ]] ["Cast Warning Color"] = "Cast Warning Color",
	--[[ ruRU ]] ["Sets the color of the cast warning"] = "Sets the color of the cast warning",
	--[[ ruRU ]] ["Backdrop Color"] = "Backdrop Color",
	--[[ ruRU ]] ["Sets the backdrop color of the cast warning"] = "Sets the backdrop color of the cast warning",
	--[[ ruRU ]] ["Border Color"] = "Border Color",
	--[[ ruRU ]] ["Sets the border color of the cast warning"] = "Sets the border color of the cast warning",
	--[[ ruRU ]] ["Border Style"] = "Border Style",
	--[[ ruRU ]] ["Sets the style of the cast warning border"] = "Sets the style of the cast warning border",
	--[[ ruRU ]] ["Texture"] = "Texture",
	--[[ ruRU ]] ["Sets the cast warning texture"] = "Sets the cast warning texture",

	--[[ ruRU ]] ["Cast Warning Override Enable"] = "Cast Warning Override Enable",
	--[[ ruRU ]] ["Enable changing alpha of actively casting units"] = "Enable changing alpha of actively casting units",
	--[[ ruRU ]] ["Cast Warning Override Alpha"] = "Cast Warning Override Alpha",
	--[[ ruRU ]] ["Sets the alpha of actively casting units"] = "Sets the alpha of actively casting units",

	--[[ ruRU ]] ["Colors"] = "Colors",
	--[[ ruRU ]] ["Customize cast warning colors (based on spell school)"] = "Customize cast warning colors (based on spell school)",
	--[[ ruRU ]] ["Default"] = "Default",
	--[[ ruRU ]] ["Sets the default color for cast warnings from unknown schools"] = "Sets the default color for cast warnings from unknown schools",
	--[[ ruRU ]] ["Physical"] = "Physical",
	--[[ ruRU ]] ["Sets the color for physical school cast warnings"] = "Sets the color for physical school cast warnings",
	--[[ ruRU ]] ["Holy"] = "Holy",
	--[[ ruRU ]] ["Sets the color for holy school cast warnings"] = "Sets the color for holy school cast warnings",
	--[[ ruRU ]] ["Fire"] = "Fire",
	--[[ ruRU ]] ["Sets the color for fire school cast warnings"] = "Sets the color for fire school cast warnings",
	--[[ ruRU ]] ["Nature"] = "Nature",
	--[[ ruRU ]] ["Sets the color for nature school cast warnings"] = "Sets the color for nature school cast warnings",
	--[[ ruRU ]] ["Frost"] = "Frost",
	--[[ ruRU ]] ["Sets the color for frost school cast warnings"] = "Sets the color for frost school cast warnings",
	--[[ ruRU ]] ["Shadow"] = "Shadow",
	--[[ ruRU ]] ["Sets the color for shadow school cast warnings"] = "Sets the color for shadow school cast warnings",
	--[[ ruRU ]] ["Arcane"] = "Arcane",
	--[[ ruRU ]] ["Sets the color for arcane school cast warnings"] = "Sets the color for arcane school cast warnings",
	--[[ ruRU ]] ["Healing"] = "Healing",
	--[[ ruRU ]] ["Sets the color for healing school cast warnings"] = "Sets the color for healing school cast warnings",

	--[[ ruRU ]] ["Reset to Defaults"] = "Reset to Defaults",
	--[[ ruRU ]] ["Resets all colors to their defaults"] = "Resets all colors to their defaults",
} end)

-----------------------------------------------------------------------------

local iL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningSpellIconOptions")

iL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Spell Icon"] = "Spell Icon",
	--[[ ruRU ]] ["Cast warning spell icon placement options"] = "Cast warning spell icon placement options",
	--[[ ruRU ]] ["Enable"] = "Enable",
	--[[ ruRU ]] ["Enable cast warning spell icon display on the nameplate"] = "Enable cast warning spell icon display on the nameplate",
	--[[ ruRU ]] ["Position"] = "Position",
	--[[ ruRU ]] ["Adjust cast warning spell icon position"] = "Adjust cast warning spell icon position",
	--[[ ruRU ]] ["Anchor"] = "Anchor",
	--[[ ruRU ]] ["Sets the anchor for the cast warning spell icon"] = "Sets the anchor for the cast warning spell icon",
	--[[ ruRU ]] ["Anchor To"] = "Anchor To",
	--[[ ruRU ]] ["Sets the relative point on the cast warning to anchor the spell icon"] = "Sets the relative point on the cast warning to anchor the spell icon",
	--[[ ruRU ]] ["X Offset"] = "X Offset",
	--[[ ruRU ]] ["X offset of the cast warning spell icon"] = "X offset of the cast warning spell icon",
	--[[ ruRU ]] ["Y Offset"] = "Y Offset",
	--[[ ruRU ]] ["Y offset of the cast warning spell icon"] = "Y offset of the cast warning spell icon",
	--[[ ruRU ]] ["Size"] = "Size",
	--[[ ruRU ]] ["Size in pixels of the cast warning spell icon"] = "Size in pixels of the cast warning spell icon",

	--[[ ruRU ]] ["Shield"] = "Shield",
	--[[ ruRU ]] ["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon",
	--[[ ruRU ]] ["Enable"] = "Enable",
	--[[ ruRU ]] ["Enables the shield graphic"] = "Enables the shield graphic",
	--[[ ruRU ]] ["Style"] = "Style",
	--[[ ruRU ]] ["Sets the shield graphic style"] = "Sets the shield graphic style",
	--[[ ruRU ]] ["Color"] = "Color",
	--[[ ruRU ]] ["Sets the shield graphic color"] = "Sets the shield graphic color",

	--[[ ruRU ]] ["SQUARE"] = "SQUARE",
	--[[ ruRU ]] ["ROUND"] = "ROUND",

	--[[ ruRU ]] ["TOPLEFT"] = "TOPLEFT",
	--[[ ruRU ]] ["TOP"] = "TOP",
	--[[ ruRU ]] ["TOPRIGHT"] = "TOPRIGHT",
	--[[ ruRU ]] ["LEFT"] = "LEFT",
	--[[ ruRU ]] ["CENTER"] = "CENTER",
	--[[ ruRU ]] ["RIGHT"] = "RIGHT",
	--[[ ruRU ]] ["BOTTOMLEFT"] = "BOTTOMLEFT",
	--[[ ruRU ]] ["BOTTOM"] = "BOTTOM",
	--[[ ruRU ]] ["BOTTOMRIGHT"] = "BOTTOMRIGHT",
} end)

-----------------------------------------------------------------------------

local nL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningSpellNameTextOptions")

-- leave "ruRU" active at all times, as a default locale
nL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Spell Name"] = "Spell Name",
	--[[ ruRU ]] ["Cast warning spell name text options"] = "Cast warning spell name text options",

	--[[ ruRU ]] ["Enable"] = "Enable",
	--[[ ruRU ]] ["Show cast warning spell name"] = "Show cast warning spell name",
	--[[ ruRU ]] ["Display Rank"] = "Display Rank",
	--[[ ruRU ]] ["Show cast warning spell rank"] = "Show cast warning spell rank",
	--[[ ruRU ]] ["Display Min/Max Range"] = "Display Min/Max Range",
	--[[ ruRU ]] ["Show cast warning spell minimum/maximum range"] = "Show cast warning spell minimum/maximum range",
	--[[ ruRU ]] ["Display Outcome"] = "Display Outcome",
	--[[ ruRU ]] ["Show cast warning spell outcome"] = "Show cast warning spell outcome",
	--[[ ruRU ]] ["Display Outcome Reason"] = "Display Outcome Reason",
	--[[ ruRU ]] ["Show cast warning spell outcome reason"] = "Show cast warning spell outcome reason",
	--[[ ruRU ]] ["Display Outcome Reason"] = "Display Outcome Reason",
	--[[ ruRU ]] ["Show cast warning spell outcome reason (failure type, interrupting spell)"] = "Show cast warning spell outcome reason (failure type, interrupting spell)",

	--[[ ruRU ]] ["Typeface"] = "Typeface",
	--[[ ruRU ]] ["Spell name typeface options"] = "Spell name typeface options",
	--[[ ruRU ]] ["Font"] = "Font",
	--[[ ruRU ]] ["Sets the font for spell name"] = "Sets the font for spell name",
	--[[ ruRU ]] ["Font Size"] = "Font Size",
	--[[ ruRU ]] ["Sets the font height of the spell name"] = "Sets the font height of the spell name",
	--[[ ruRU ]] ["Font Shadow"] = "Font Shadow",
	--[[ ruRU ]] ["Show font shadow on spell name"] = "Show font shadow on spell name",
	--[[ ruRU ]] ["Outline"] = "Outline",
	--[[ ruRU ]] ["Sets the font outline for spell name"] = "Sets the font outline for spell name",

	--[[ ruRU ]] ["Alignment"] = "Alignment",
	--[[ ruRU ]] ["Sets the alignment of the spell name"] = "Sets the alignment of the spell name",

	--[[ ruRU ]] ["Position"] = "Position",
	--[[ ruRU ]] ["Adjust spell name position"] = "Adjust spell name position",
	--[[ ruRU ]] ["Left Offset"] = "Left Offset",
	--[[ ruRU ]] ["Sets the offset of the left of the text"] = "Sets the offset of the left of the text",
	--[[ ruRU ]] ["Right Offset"] = "Right Offset",
	--[[ ruRU ]] ["Sets the offset of the right of the text"] = "Sets the offset of the right of the text",
	--[[ ruRU ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ ruRU ]] ["Sets the vertical offset of the text"] = "Sets the vertical offset of the text",

	--[[ ruRU ]] ["Colors"] = "Colors",
	--[[ ruRU ]] ["Sets the spell name colors"] = "Sets the spell name colors",
	--[[ ruRU ]] ["Cast Color"] = "Cast Color",
	--[[ ruRU ]] ["Sets the spell name color during active casting"] = "Sets the spell name color during active casting",
	--[[ ruRU ]] ["Fade Color"] = "Fade Color",
	--[[ ruRU ]] ["Sets the spell name color during cast warning fade"] = "Sets the spell name color during cast warning fade",

	--[[ ruRU ]] ["None"] = "None",
	--[[ ruRU ]] ["Normal"] = "Normal",
	--[[ ruRU ]] ["Thick"] = "Thick",

	--[[ ruRU ]] ["LEFT"] = "LEFT",
	--[[ ruRU ]] ["CENTER"] = "CENTER",
	--[[ ruRU ]] ["RIGHT"] = "RIGHT",
} end)

-----------------------------------------------------------------------------

local tL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningTimeTextOptions")

tL:RegisterTranslations("ruRU", function() return {
	--[[ ruRU ]] ["Spell Time"] = "Spell Time",
	--[[ ruRU ]] ["Cast warning spell time text options"] = "Cast warning spell time text options",
	--[[ ruRU ]] ["Enable"] = "Enable",
	--[[ ruRU ]] ["Show cast warning spell time"] = "Show cast warning spell time",
	--[[ ruRU ]] ["Typeface"] = "Typeface",
	--[[ ruRU ]] ["Spell time typeface options"] = "Spell time typeface options",
	--[[ ruRU ]] ["Font"] = "Font",
	--[[ ruRU ]] ["Sets the font for spell time"] = "Sets the font for spell time",
	--[[ ruRU ]] ["Font Size"] = "Font Size",
	--[[ ruRU ]] ["Sets the font height of the spell time"] = "Sets the font height of the spell time",
	--[[ ruRU ]] ["Font Shadow"] = "Font Shadow",
	--[[ ruRU ]] ["Show font shadow on spell time"] = "Show font shadow on spell time",
	--[[ ruRU ]] ["Outline"] = "Outline",
	--[[ ruRU ]] ["Sets the font outline for spell time"] = "Sets the font outline for spell time",
	--[[ ruRU ]] ["Alignment"] = "Alignment",
	--[[ ruRU ]] ["Sets the alignment of the spell time"] = "Sets the alignment of the spell time",
	--[[ ruRU ]] ["Position"] = "Position",
	--[[ ruRU ]] ["Adjust spell time position"] = "Adjust spell time position",
	--[[ ruRU ]] ["Left Offset"] = "Left Offset",
	--[[ ruRU ]] ["Sets the offset of the left of the text"] = "Sets the offset of the left of the text",
	--[[ ruRU ]] ["Right Offset"] = "Right Offset",
	--[[ ruRU ]] ["Sets the offset of the right of the text"] = "Sets the offset of the right of the text",
	--[[ ruRU ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ ruRU ]] ["Sets the vertical offset of the text"] = "Sets the vertical offset of the text",

	--[[ ruRU ]] ["Colors"] = "Colors",
	--[[ ruRU ]] ["Sets the spell time colors"] = "Sets the spell time colors",
	--[[ ruRU ]] ["Cast Color"] = "Cast Color",
	--[[ ruRU ]] ["Sets the spell time color during active casting"] = "Sets the spell time color during active casting",
	--[[ ruRU ]] ["Fade Color"] = "Fade Color",
	--[[ ruRU ]] ["Sets the spell time color during cast warning fade"] = "Sets the spell time color during cast warning fade",

	--[[ ruRU ]] ["None"] = "None",
	--[[ ruRU ]] ["Normal"] = "Normal",
	--[[ ruRU ]] ["Thick"] = "Thick",

	--[[ ruRU ]] ["LEFT"] = "LEFT",
	--[[ ruRU ]] ["CENTER"] = "CENTER",
	--[[ ruRU ]] ["RIGHT"] = "RIGHT",
} end)

-----------------------------------------------------------------------------

-- end)

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------


local wL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningOptions")

wL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Cast Warning"] = "Cast Warning",
	--[[ zhCN ]] ["Cast warning options"] = "Cast warning options",

	--[[ zhCN ]] ["Enable"] = "Enable",
	--[[ zhCN ]] ["Show cast warnings on identifiable enemy nameplates"] = "Show cast warnings on identifiable enemy nameplates",
	--[[ zhCN ]] ["Verification Interval"] = "Verification Interval",
	--[[ zhCN ]] ["Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"] = "Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)",
	--[[ zhCN ]] ["Animated Cast Warning"] = "Animated Cast Warning",
	--[[ zhCN ]] ["Animate cast warnings as cast bars"] = "Animate cast warnings as cast bars",
	--[[ zhCN ]] ["Fade Duration"] = "Fade Duration",
	--[[ zhCN ]] ["Sets the fade duration of animated cast warnings (0.0 is no fade)"] = "Sets the fade duration of animated cast warnings (0.0 is no fade)",
	--[[ zhCN ]] ["Trade Skills"] = "Trade Skills",
	--[[ zhCN ]] ["Show cast warnings for trade skills"] = "Show cast warnings for trade skills",
	--[[ zhCN ]] ["Players"] = "Players",
	--[[ zhCN ]] ["Show cast warnings for players"] = "Show cast warnings for players",
	--[[ zhCN ]] ["Friendly Units"] = "Friendly Units",
	--[[ zhCN ]] ["Show cast warnings for friendly units"] = "Show cast warnings for friendly units",

	--[[ zhCN ]] ["Position"] = "Position",
	--[[ zhCN ]] ["Adjust the cast warning's position"] = "Adjust the cast warning's position",
	--[[ zhCN ]] ["Left Offset"] = "Left Offset",
	--[[ zhCN ]] ["Sets the offset of the left of the cast warning"] = "Sets the offset of the left of the cast warning",
	--[[ zhCN ]] ["Right Offset"] = "Right Offset",
	--[[ zhCN ]] ["Sets the offset of the right of the cast warning"] = "Sets the offset of the right of the cast warning",
	--[[ zhCN ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ zhCN ]] ["Sets the vertical offset of the cast warning"] = "Sets the vertical offset of the cast warning",

	--[[ zhCN ]] ["Height"] = "Height",
	--[[ zhCN ]] ["Sets the height of the cast warning"] = "Sets the height of the cast warning",

	--[[ zhCN ]] ["Interruptable Cast Warning"] = "Interruptable Cast Warning",
	--[[ zhCN ]] ["Cast warning appearance for interruptable spells"] = "Cast warning appearance for interruptable spells",
	--[[ zhCN ]] ["Uninterruptable Cast Warning"] = "Uninterruptable Cast Warning",
	--[[ zhCN ]] ["Cast warning appearance for uninterruptable spells"] = "Cast warning appearance for uninterruptable spells",

	--[[ zhCN ]] ["Cast Warning Color"] = "Cast Warning Color",
	--[[ zhCN ]] ["Sets the color of the cast warning"] = "Sets the color of the cast warning",
	--[[ zhCN ]] ["Backdrop Color"] = "Backdrop Color",
	--[[ zhCN ]] ["Sets the backdrop color of the cast warning"] = "Sets the backdrop color of the cast warning",
	--[[ zhCN ]] ["Border Color"] = "Border Color",
	--[[ zhCN ]] ["Sets the border color of the cast warning"] = "Sets the border color of the cast warning",
	--[[ zhCN ]] ["Border Style"] = "Border Style",
	--[[ zhCN ]] ["Sets the style of the cast warning border"] = "Sets the style of the cast warning border",
	--[[ zhCN ]] ["Texture"] = "Texture",
	--[[ zhCN ]] ["Sets the cast warning texture"] = "Sets the cast warning texture",

	--[[ zhCN ]] ["Cast Warning Alpha Override Enable"] = "Cast Warning Alpha Override Enable",
	--[[ zhCN ]] ["Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)",
	--[[ zhCN ]] ["Cast Warning Alpha Override"] = "Cast Warning Alpha Override",
	--[[ zhCN ]] ["Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)",

	--[[ zhCN ]] ["Colors"] = "Colors",
	--[[ zhCN ]] ["Customize cast warning colors (based on spell school)"] = "Customize cast warning colors (based on spell school)",
	--[[ zhCN ]] ["Default"] = "Default",
	--[[ zhCN ]] ["Sets the default color for cast warnings from unknown schools"] = "Sets the default color for cast warnings from unknown schools",
	--[[ zhCN ]] ["Physical"] = "Physical",
	--[[ zhCN ]] ["Sets the color for physical school cast warnings"] = "Sets the color for physical school cast warnings",
	--[[ zhCN ]] ["Holy"] = "Holy",
	--[[ zhCN ]] ["Sets the color for holy school cast warnings"] = "Sets the color for holy school cast warnings",
	--[[ zhCN ]] ["Fire"] = "Fire",
	--[[ zhCN ]] ["Sets the color for fire school cast warnings"] = "Sets the color for fire school cast warnings",
	--[[ zhCN ]] ["Nature"] = "Nature",
	--[[ zhCN ]] ["Sets the color for nature school cast warnings"] = "Sets the color for nature school cast warnings",
	--[[ zhCN ]] ["Frost"] = "Frost",
	--[[ zhCN ]] ["Sets the color for frost school cast warnings"] = "Sets the color for frost school cast warnings",
	--[[ zhCN ]] ["Shadow"] = "Shadow",
	--[[ zhCN ]] ["Sets the color for shadow school cast warnings"] = "Sets the color for shadow school cast warnings",
	--[[ zhCN ]] ["Arcane"] = "Arcane",
	--[[ zhCN ]] ["Sets the color for arcane school cast warnings"] = "Sets the color for arcane school cast warnings",
	--[[ zhCN ]] ["Healing"] = "Healing",
	--[[ zhCN ]] ["Sets the color for healing school cast warnings"] = "Sets the color for healing school cast warnings",

	--[[ zhCN ]] ["Reset to Defaults"] = "Reset to Defaults",
	--[[ zhCN ]] ["Resets all colors to their defaults"] = "Resets all colors to their defaults",
} end)

-----------------------------------------------------------------------------

local iL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningSpellIconOptions")

iL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Spell Icon"] = "Spell Icon",
	--[[ zhCN ]] ["Cast warning spell icon placement options"] = "Cast warning spell icon placement options",
	--[[ zhCN ]] ["Enable"] = "Enable",
	--[[ zhCN ]] ["Enable cast warning spell icon display on the nameplate"] = "Enable cast warning spell icon display on the nameplate",
	--[[ zhCN ]] ["Position"] = "Position",
	--[[ zhCN ]] ["Adjust cast warning spell icon position"] = "Adjust cast warning spell icon position",
	--[[ zhCN ]] ["Anchor"] = "Anchor",
	--[[ zhCN ]] ["Sets the anchor for the cast warning spell icon"] = "Sets the anchor for the cast warning spell icon",
	--[[ zhCN ]] ["Anchor To"] = "Anchor To",
	--[[ zhCN ]] ["Sets the relative point on the cast warning to anchor the spell icon"] = "Sets the relative point on the cast warning to anchor the spell icon",
	--[[ zhCN ]] ["X Offset"] = "X Offset",
	--[[ zhCN ]] ["X offset of the cast warning spell icon"] = "X offset of the cast warning spell icon",
	--[[ zhCN ]] ["Y Offset"] = "Y Offset",
	--[[ zhCN ]] ["Y offset of the cast warning spell icon"] = "Y offset of the cast warning spell icon",
	--[[ zhCN ]] ["Size"] = "Size",
	--[[ zhCN ]] ["Size in pixels of the cast warning spell icon"] = "Size in pixels of the cast warning spell icon",

	--[[ zhCN ]] ["Shield"] = "Shield",
	--[[ zhCN ]] ["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon",
	--[[ zhCN ]] ["Enable"] = "Enable",
	--[[ zhCN ]] ["Enables the shield graphic"] = "Enables the shield graphic",
	--[[ zhCN ]] ["Style"] = "Style",
	--[[ zhCN ]] ["Sets the shield graphic style"] = "Sets the shield graphic style",
	--[[ zhCN ]] ["Color"] = "Color",
	--[[ zhCN ]] ["Sets the shield graphic color"] = "Sets the shield graphic color",

	--[[ zhCN ]] ["SQUARE"] = "SQUARE",
	--[[ zhCN ]] ["ROUND"] = "ROUND",

	--[[ zhCN ]] ["TOPLEFT"] = "TOPLEFT",
	--[[ zhCN ]] ["TOP"] = "TOP",
	--[[ zhCN ]] ["TOPRIGHT"] = "TOPRIGHT",
	--[[ zhCN ]] ["LEFT"] = "LEFT",
	--[[ zhCN ]] ["CENTER"] = "CENTER",
	--[[ zhCN ]] ["RIGHT"] = "RIGHT",
	--[[ zhCN ]] ["BOTTOMLEFT"] = "BOTTOMLEFT",
	--[[ zhCN ]] ["BOTTOM"] = "BOTTOM",
	--[[ zhCN ]] ["BOTTOMRIGHT"] = "BOTTOMRIGHT",
} end)

-----------------------------------------------------------------------------

local nL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningSpellNameTextOptions")

-- leave "zhCN" active at all times, as a default locale
nL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Spell Name"] = "Spell Name",
	--[[ zhCN ]] ["Cast warning spell name text options"] = "Cast warning spell name text options",

	--[[ zhCN ]] ["Enable"] = "Enable",
	--[[ zhCN ]] ["Show cast warning spell name"] = "Show cast warning spell name",
	--[[ zhCN ]] ["Display Rank"] = "Display Rank",
	--[[ zhCN ]] ["Show cast warning spell rank"] = "Show cast warning spell rank",
	--[[ zhCN ]] ["Display Min/Max Range"] = "Display Min/Max Range",
	--[[ zhCN ]] ["Show cast warning spell minimum/maximum range"] = "Show cast warning spell minimum/maximum range",
	--[[ zhCN ]] ["Display Outcome"] = "Display Outcome",
	--[[ zhCN ]] ["Show cast warning spell outcome"] = "Show cast warning spell outcome",
	--[[ zhCN ]] ["Display Outcome Reason"] = "Display Outcome Reason",
	--[[ zhCN ]] ["Show cast warning spell outcome reason"] = "Show cast warning spell outcome reason",
	--[[ zhCN ]] ["Display Outcome Reason"] = "Display Outcome Reason",
	--[[ zhCN ]] ["Show cast warning spell outcome reason (failure type, interrupting spell)"] = "Show cast warning spell outcome reason (failure type, interrupting spell)",

	--[[ zhCN ]] ["Typeface"] = "Typeface",
	--[[ zhCN ]] ["Spell name typeface options"] = "Spell name typeface options",
	--[[ zhCN ]] ["Font"] = "Font",
	--[[ zhCN ]] ["Sets the font for spell name"] = "Sets the font for spell name",
	--[[ zhCN ]] ["Font Size"] = "Font Size",
	--[[ zhCN ]] ["Sets the font height of the spell name"] = "Sets the font height of the spell name",
	--[[ zhCN ]] ["Font Shadow"] = "Font Shadow",
	--[[ zhCN ]] ["Show font shadow on spell name"] = "Show font shadow on spell name",
	--[[ zhCN ]] ["Outline"] = "Outline",
	--[[ zhCN ]] ["Sets the font outline for spell name"] = "Sets the font outline for spell name",

	--[[ zhCN ]] ["Alignment"] = "Alignment",
	--[[ zhCN ]] ["Sets the alignment of the spell name"] = "Sets the alignment of the spell name",

	--[[ zhCN ]] ["Position"] = "Position",
	--[[ zhCN ]] ["Adjust spell name position"] = "Adjust spell name position",
	--[[ zhCN ]] ["Left Offset"] = "Left Offset",
	--[[ zhCN ]] ["Sets the offset of the left of the text"] = "Sets the offset of the left of the text",
	--[[ zhCN ]] ["Right Offset"] = "Right Offset",
	--[[ zhCN ]] ["Sets the offset of the right of the text"] = "Sets the offset of the right of the text",
	--[[ zhCN ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ zhCN ]] ["Sets the vertical offset of the text"] = "Sets the vertical offset of the text",

	--[[ zhCN ]] ["Colors"] = "Colors",
	--[[ zhCN ]] ["Sets the spell name colors"] = "Sets the spell name colors",
	--[[ zhCN ]] ["Cast Color"] = "Cast Color",
	--[[ zhCN ]] ["Sets the spell name color during active casting"] = "Sets the spell name color during active casting",
	--[[ zhCN ]] ["Fade Color"] = "Fade Color",
	--[[ zhCN ]] ["Sets the spell name color during cast warning fade"] = "Sets the spell name color during cast warning fade",

	--[[ zhCN ]] ["None"] = "None",
	--[[ zhCN ]] ["Normal"] = "Normal",
	--[[ zhCN ]] ["Thick"] = "Thick",

	--[[ zhCN ]] ["LEFT"] = "LEFT",
	--[[ zhCN ]] ["CENTER"] = "CENTER",
	--[[ zhCN ]] ["RIGHT"] = "RIGHT",
} end)

-----------------------------------------------------------------------------

local tL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningTimeTextOptions")

tL:RegisterTranslations("zhCN", function() return {
	--[[ zhCN ]] ["Spell Time"] = "Spell Time",
	--[[ zhCN ]] ["Cast warning spell time text options"] = "Cast warning spell time text options",
	--[[ zhCN ]] ["Enable"] = "Enable",
	--[[ zhCN ]] ["Show cast warning spell time"] = "Show cast warning spell time",
	--[[ zhCN ]] ["Typeface"] = "Typeface",
	--[[ zhCN ]] ["Spell time typeface options"] = "Spell time typeface options",
	--[[ zhCN ]] ["Font"] = "Font",
	--[[ zhCN ]] ["Sets the font for spell time"] = "Sets the font for spell time",
	--[[ zhCN ]] ["Font Size"] = "Font Size",
	--[[ zhCN ]] ["Sets the font height of the spell time"] = "Sets the font height of the spell time",
	--[[ zhCN ]] ["Font Shadow"] = "Font Shadow",
	--[[ zhCN ]] ["Show font shadow on spell time"] = "Show font shadow on spell time",
	--[[ zhCN ]] ["Outline"] = "Outline",
	--[[ zhCN ]] ["Sets the font outline for spell time"] = "Sets the font outline for spell time",
	--[[ zhCN ]] ["Alignment"] = "Alignment",
	--[[ zhCN ]] ["Sets the alignment of the spell time"] = "Sets the alignment of the spell time",
	--[[ zhCN ]] ["Position"] = "Position",
	--[[ zhCN ]] ["Adjust spell time position"] = "Adjust spell time position",
	--[[ zhCN ]] ["Left Offset"] = "Left Offset",
	--[[ zhCN ]] ["Sets the offset of the left of the text"] = "Sets the offset of the left of the text",
	--[[ zhCN ]] ["Right Offset"] = "Right Offset",
	--[[ zhCN ]] ["Sets the offset of the right of the text"] = "Sets the offset of the right of the text",
	--[[ zhCN ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ zhCN ]] ["Sets the vertical offset of the text"] = "Sets the vertical offset of the text",

	--[[ zhCN ]] ["Colors"] = "Colors",
	--[[ zhCN ]] ["Sets the spell time colors"] = "Sets the spell time colors",
	--[[ zhCN ]] ["Cast Color"] = "Cast Color",
	--[[ zhCN ]] ["Sets the spell time color during active casting"] = "Sets the spell time color during active casting",
	--[[ zhCN ]] ["Fade Color"] = "Fade Color",
	--[[ zhCN ]] ["Sets the spell time color during cast warning fade"] = "Sets the spell time color during cast warning fade",

	--[[ zhCN ]] ["None"] = "None",
	--[[ zhCN ]] ["Normal"] = "Normal",
	--[[ zhCN ]] ["Thick"] = "Thick",

	--[[ zhCN ]] ["LEFT"] = "LEFT",
	--[[ zhCN ]] ["CENTER"] = "CENTER",
	--[[ zhCN ]] ["RIGHT"] = "RIGHT",
} end)

-----------------------------------------------------------------------------

-- end)

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------


local wL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningOptions")

wL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Cast Warning"] = "Cast Warning",
	--[[ zhTW ]] ["Cast warning options"] = "Cast warning options",

	--[[ zhTW ]] ["Enable"] = "Enable",
	--[[ zhTW ]] ["Show cast warnings on identifiable enemy nameplates"] = "Show cast warnings on identifiable enemy nameplates",
	--[[ zhTW ]] ["Verification Interval"] = "Verification Interval",
	--[[ zhTW ]] ["Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"] = "Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)",
	--[[ zhTW ]] ["Animated Cast Warning"] = "Animated Cast Warning",
	--[[ zhTW ]] ["Animate cast warnings as cast bars"] = "Animate cast warnings as cast bars",
	--[[ zhTW ]] ["Fade Duration"] = "Fade Duration",
	--[[ zhTW ]] ["Sets the fade duration of animated cast warnings (0.0 is no fade)"] = "Sets the fade duration of animated cast warnings (0.0 is no fade)",
	--[[ zhTW ]] ["Trade Skills"] = "Trade Skills",
	--[[ zhTW ]] ["Show cast warnings for trade skills"] = "Show cast warnings for trade skills",
	--[[ zhTW ]] ["Players"] = "Players",
	--[[ zhTW ]] ["Show cast warnings for players"] = "Show cast warnings for players",
	--[[ zhTW ]] ["Friendly Units"] = "Friendly Units",
	--[[ zhTW ]] ["Show cast warnings for friendly units"] = "Show cast warnings for friendly units",

	--[[ zhTW ]] ["Position"] = "Position",
	--[[ zhTW ]] ["Adjust the cast warning's position"] = "Adjust the cast warning's position",
	--[[ zhTW ]] ["Left Offset"] = "Left Offset",
	--[[ zhTW ]] ["Sets the offset of the left of the cast warning"] = "Sets the offset of the left of the cast warning",
	--[[ zhTW ]] ["Right Offset"] = "Right Offset",
	--[[ zhTW ]] ["Sets the offset of the right of the cast warning"] = "Sets the offset of the right of the cast warning",
	--[[ zhTW ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ zhTW ]] ["Sets the vertical offset of the cast warning"] = "Sets the vertical offset of the cast warning",

	--[[ zhTW ]] ["Height"] = "Height",
	--[[ zhTW ]] ["Sets the height of the cast warning"] = "Sets the height of the cast warning",

	--[[ zhTW ]] ["Interruptable Cast Warning"] = "Interruptable Cast Warning",
	--[[ zhTW ]] ["Cast warning appearance for interruptable spells"] = "Cast warning appearance for interruptable spells",
	--[[ zhTW ]] ["Uninterruptable Cast Warning"] = "Uninterruptable Cast Warning",
	--[[ zhTW ]] ["Cast warning appearance for uninterruptable spells"] = "Cast warning appearance for uninterruptable spells",

	--[[ zhTW ]] ["Cast Warning Color"] = "Cast Warning Color",
	--[[ zhTW ]] ["Sets the color of the cast warning"] = "Sets the color of the cast warning",
	--[[ zhTW ]] ["Backdrop Color"] = "Backdrop Color",
	--[[ zhTW ]] ["Sets the backdrop color of the cast warning"] = "Sets the backdrop color of the cast warning",
	--[[ zhTW ]] ["Border Color"] = "Border Color",
	--[[ zhTW ]] ["Sets the border color of the cast warning"] = "Sets the border color of the cast warning",
	--[[ zhTW ]] ["Border Style"] = "Border Style",
	--[[ zhTW ]] ["Sets the style of the cast warning border"] = "Sets the style of the cast warning border",
	--[[ zhTW ]] ["Texture"] = "Texture",
	--[[ zhTW ]] ["Sets the cast warning texture"] = "Sets the cast warning texture",

	--[[ zhTW ]] ["Cast Warning Alpha Override Enable"] = "Cast Warning Alpha Override Enable",
	--[[ zhTW ]] ["Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)",
	--[[ zhTW ]] ["Cast Warning Alpha Override"] = "Cast Warning Alpha Override",
	--[[ zhTW ]] ["Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)",

	--[[ zhTW ]] ["Colors"] = "Colors",
	--[[ zhTW ]] ["Customize cast warning colors (based on spell school)"] = "Customize cast warning colors (based on spell school)",
	--[[ zhTW ]] ["Default"] = "Default",
	--[[ zhTW ]] ["Sets the default color for cast warnings from unknown schools"] = "Sets the default color for cast warnings from unknown schools",
	--[[ zhTW ]] ["Physical"] = "Physical",
	--[[ zhTW ]] ["Sets the color for physical school cast warnings"] = "Sets the color for physical school cast warnings",
	--[[ zhTW ]] ["Holy"] = "Holy",
	--[[ zhTW ]] ["Sets the color for holy school cast warnings"] = "Sets the color for holy school cast warnings",
	--[[ zhTW ]] ["Fire"] = "Fire",
	--[[ zhTW ]] ["Sets the color for fire school cast warnings"] = "Sets the color for fire school cast warnings",
	--[[ zhTW ]] ["Nature"] = "Nature",
	--[[ zhTW ]] ["Sets the color for nature school cast warnings"] = "Sets the color for nature school cast warnings",
	--[[ zhTW ]] ["Frost"] = "Frost",
	--[[ zhTW ]] ["Sets the color for frost school cast warnings"] = "Sets the color for frost school cast warnings",
	--[[ zhTW ]] ["Shadow"] = "Shadow",
	--[[ zhTW ]] ["Sets the color for shadow school cast warnings"] = "Sets the color for shadow school cast warnings",
	--[[ zhTW ]] ["Arcane"] = "Arcane",
	--[[ zhTW ]] ["Sets the color for arcane school cast warnings"] = "Sets the color for arcane school cast warnings",
	--[[ zhTW ]] ["Healing"] = "Healing",
	--[[ zhTW ]] ["Sets the color for healing school cast warnings"] = "Sets the color for healing school cast warnings",

	--[[ zhTW ]] ["Reset to Defaults"] = "Reset to Defaults",
	--[[ zhTW ]] ["Resets all colors to their defaults"] = "Resets all colors to their defaults",
} end)

-----------------------------------------------------------------------------

local iL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningSpellIconOptions")

iL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Spell Icon"] = "Spell Icon",
	--[[ zhTW ]] ["Cast warning spell icon placement options"] = "Cast warning spell icon placement options",
	--[[ zhTW ]] ["Enable"] = "Enable",
	--[[ zhTW ]] ["Enable cast warning spell icon display on the nameplate"] = "Enable cast warning spell icon display on the nameplate",
	--[[ zhTW ]] ["Position"] = "Position",
	--[[ zhTW ]] ["Adjust cast warning spell icon position"] = "Adjust cast warning spell icon position",
	--[[ zhTW ]] ["Anchor"] = "Anchor",
	--[[ zhTW ]] ["Sets the anchor for the cast warning spell icon"] = "Sets the anchor for the cast warning spell icon",
	--[[ zhTW ]] ["Anchor To"] = "Anchor To",
	--[[ zhTW ]] ["Sets the relative point on the cast warning to anchor the spell icon"] = "Sets the relative point on the cast warning to anchor the spell icon",
	--[[ zhTW ]] ["X Offset"] = "X Offset",
	--[[ zhTW ]] ["X offset of the cast warning spell icon"] = "X offset of the cast warning spell icon",
	--[[ zhTW ]] ["Y Offset"] = "Y Offset",
	--[[ zhTW ]] ["Y offset of the cast warning spell icon"] = "Y offset of the cast warning spell icon",
	--[[ zhTW ]] ["Size"] = "Size",
	--[[ zhTW ]] ["Size in pixels of the cast warning spell icon"] = "Size in pixels of the cast warning spell icon",

	--[[ zhTW ]] ["Shield"] = "Shield",
	--[[ zhTW ]] ["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon",
	--[[ zhTW ]] ["Enable"] = "Enable",
	--[[ zhTW ]] ["Enables the shield graphic"] = "Enables the shield graphic",
	--[[ zhTW ]] ["Style"] = "Style",
	--[[ zhTW ]] ["Sets the shield graphic style"] = "Sets the shield graphic style",
	--[[ zhTW ]] ["Color"] = "Color",
	--[[ zhTW ]] ["Sets the shield graphic color"] = "Sets the shield graphic color",

	--[[ zhTW ]] ["SQUARE"] = "SQUARE",
	--[[ zhTW ]] ["ROUND"] = "ROUND",

	--[[ zhTW ]] ["TOPLEFT"] = "TOPLEFT",
	--[[ zhTW ]] ["TOP"] = "TOP",
	--[[ zhTW ]] ["TOPRIGHT"] = "TOPRIGHT",
	--[[ zhTW ]] ["LEFT"] = "LEFT",
	--[[ zhTW ]] ["CENTER"] = "CENTER",
	--[[ zhTW ]] ["RIGHT"] = "RIGHT",
	--[[ zhTW ]] ["BOTTOMLEFT"] = "BOTTOMLEFT",
	--[[ zhTW ]] ["BOTTOM"] = "BOTTOM",
	--[[ zhTW ]] ["BOTTOMRIGHT"] = "BOTTOMRIGHT",
} end)

-----------------------------------------------------------------------------

local nL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningSpellNameTextOptions")

-- leave "zhTW" active at all times, as a default locale
nL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Spell Name"] = "Spell Name",
	--[[ zhTW ]] ["Cast warning spell name text options"] = "Cast warning spell name text options",

	--[[ zhTW ]] ["Enable"] = "Enable",
	--[[ zhTW ]] ["Show cast warning spell name"] = "Show cast warning spell name",
	--[[ zhTW ]] ["Display Rank"] = "Display Rank",
	--[[ zhTW ]] ["Show cast warning spell rank"] = "Show cast warning spell rank",
	--[[ zhTW ]] ["Display Min/Max Range"] = "Display Min/Max Range",
	--[[ zhTW ]] ["Show cast warning spell minimum/maximum range"] = "Show cast warning spell minimum/maximum range",
	--[[ zhTW ]] ["Display Outcome"] = "Display Outcome",
	--[[ zhTW ]] ["Show cast warning spell outcome"] = "Show cast warning spell outcome",
	--[[ zhTW ]] ["Display Outcome Reason"] = "Display Outcome Reason",
	--[[ zhTW ]] ["Show cast warning spell outcome reason"] = "Show cast warning spell outcome reason",
	--[[ zhTW ]] ["Display Outcome Reason"] = "Display Outcome Reason",
	--[[ zhTW ]] ["Show cast warning spell outcome reason (failure type, interrupting spell)"] = "Show cast warning spell outcome reason (failure type, interrupting spell)",

	--[[ zhTW ]] ["Typeface"] = "Typeface",
	--[[ zhTW ]] ["Spell name typeface options"] = "Spell name typeface options",
	--[[ zhTW ]] ["Font"] = "Font",
	--[[ zhTW ]] ["Sets the font for spell name"] = "Sets the font for spell name",
	--[[ zhTW ]] ["Font Size"] = "Font Size",
	--[[ zhTW ]] ["Sets the font height of the spell name"] = "Sets the font height of the spell name",
	--[[ zhTW ]] ["Font Shadow"] = "Font Shadow",
	--[[ zhTW ]] ["Show font shadow on spell name"] = "Show font shadow on spell name",
	--[[ zhTW ]] ["Outline"] = "Outline",
	--[[ zhTW ]] ["Sets the font outline for spell name"] = "Sets the font outline for spell name",

	--[[ zhTW ]] ["Alignment"] = "Alignment",
	--[[ zhTW ]] ["Sets the alignment of the spell name"] = "Sets the alignment of the spell name",

	--[[ zhTW ]] ["Position"] = "Position",
	--[[ zhTW ]] ["Adjust spell name position"] = "Adjust spell name position",
	--[[ zhTW ]] ["Left Offset"] = "Left Offset",
	--[[ zhTW ]] ["Sets the offset of the left of the text"] = "Sets the offset of the left of the text",
	--[[ zhTW ]] ["Right Offset"] = "Right Offset",
	--[[ zhTW ]] ["Sets the offset of the right of the text"] = "Sets the offset of the right of the text",
	--[[ zhTW ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ zhTW ]] ["Sets the vertical offset of the text"] = "Sets the vertical offset of the text",

	--[[ zhTW ]] ["Colors"] = "Colors",
	--[[ zhTW ]] ["Sets the spell name colors"] = "Sets the spell name colors",
	--[[ zhTW ]] ["Cast Color"] = "Cast Color",
	--[[ zhTW ]] ["Sets the spell name color during active casting"] = "Sets the spell name color during active casting",
	--[[ zhTW ]] ["Fade Color"] = "Fade Color",
	--[[ zhTW ]] ["Sets the spell name color during cast warning fade"] = "Sets the spell name color during cast warning fade",

	--[[ zhTW ]] ["None"] = "None",
	--[[ zhTW ]] ["Normal"] = "Normal",
	--[[ zhTW ]] ["Thick"] = "Thick",

	--[[ zhTW ]] ["LEFT"] = "LEFT",
	--[[ zhTW ]] ["CENTER"] = "CENTER",
	--[[ zhTW ]] ["RIGHT"] = "RIGHT",
} end)

-----------------------------------------------------------------------------

local tL = AceLibrary("AceLocale-2.2"):new("AloftCastWarningTimeTextOptions")

tL:RegisterTranslations("zhTW", function() return {
	--[[ zhTW ]] ["Spell Time"] = "Spell Time",
	--[[ zhTW ]] ["Cast warning spell time text options"] = "Cast warning spell time text options",
	--[[ zhTW ]] ["Enable"] = "Enable",
	--[[ zhTW ]] ["Show cast warning spell time"] = "Show cast warning spell time",
	--[[ zhTW ]] ["Typeface"] = "Typeface",
	--[[ zhTW ]] ["Spell time typeface options"] = "Spell time typeface options",
	--[[ zhTW ]] ["Font"] = "Font",
	--[[ zhTW ]] ["Sets the font for spell time"] = "Sets the font for spell time",
	--[[ zhTW ]] ["Font Size"] = "Font Size",
	--[[ zhTW ]] ["Sets the font height of the spell time"] = "Sets the font height of the spell time",
	--[[ zhTW ]] ["Font Shadow"] = "Font Shadow",
	--[[ zhTW ]] ["Show font shadow on spell time"] = "Show font shadow on spell time",
	--[[ zhTW ]] ["Outline"] = "Outline",
	--[[ zhTW ]] ["Sets the font outline for spell time"] = "Sets the font outline for spell time",
	--[[ zhTW ]] ["Alignment"] = "Alignment",
	--[[ zhTW ]] ["Sets the alignment of the spell time"] = "Sets the alignment of the spell time",
	--[[ zhTW ]] ["Position"] = "Position",
	--[[ zhTW ]] ["Adjust spell time position"] = "Adjust spell time position",
	--[[ zhTW ]] ["Left Offset"] = "Left Offset",
	--[[ zhTW ]] ["Sets the offset of the left of the text"] = "Sets the offset of the left of the text",
	--[[ zhTW ]] ["Right Offset"] = "Right Offset",
	--[[ zhTW ]] ["Sets the offset of the right of the text"] = "Sets the offset of the right of the text",
	--[[ zhTW ]] ["Vertical Offset"] = "Vertical Offset",
	--[[ zhTW ]] ["Sets the vertical offset of the text"] = "Sets the vertical offset of the text",

	--[[ zhTW ]] ["Colors"] = "Colors",
	--[[ zhTW ]] ["Sets the spell time colors"] = "Sets the spell time colors",
	--[[ zhTW ]] ["Cast Color"] = "Cast Color",
	--[[ zhTW ]] ["Sets the spell time color during active casting"] = "Sets the spell time color during active casting",
	--[[ zhTW ]] ["Fade Color"] = "Fade Color",
	--[[ zhTW ]] ["Sets the spell time color during cast warning fade"] = "Sets the spell time color during cast warning fade",

	--[[ zhTW ]] ["None"] = "None",
	--[[ zhTW ]] ["Normal"] = "Normal",
	--[[ zhTW ]] ["Thick"] = "Thick",

	--[[ zhTW ]] ["LEFT"] = "LEFT",
	--[[ zhTW ]] ["CENTER"] = "CENTER",
	--[[ zhTW ]] ["RIGHT"] = "RIGHT",
} end)

-----------------------------------------------------------------------------

-- end)

-----------------------------------------------------------------------------

end