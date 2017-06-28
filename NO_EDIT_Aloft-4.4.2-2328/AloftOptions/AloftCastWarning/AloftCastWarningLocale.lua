local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-- ChatFrame7:AddMessage("AloftCastWarningLocale: have globals")

-----------------------------------------------------------------------------

local mL = AloftLocale.AloftModules
if not mL then return end

-- ChatFrame7:AddMessage("AloftCastWarningLocale: have modules locale")

local wL = { }

local iL = { }

local nL = { }

local tL = { }

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------


-- Leave enUS locale active as default locale

--[[ enUS ]] wL["Cast Warning"] = "Cast Warning"
--[[ enUS ]] wL["Cast warning options"] = "Cast warning options"

--[[ enUS ]] wL["Enable"] = "Enable"
--[[ enUS ]] wL["Show cast warnings on identifiable enemy nameplates"] = "Show cast warnings on identifiable enemy nameplates"
--[[ enUS ]] wL["Verification Interval"] = "Verification Interval"
--[[ enUS ]] wL["Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"] = "Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"
--[[ enUS ]] wL["Animated Cast Warning"] = "Animated Cast Warning"
--[[ enUS ]] wL["Animate cast warnings as cast bars"] = "Animate cast warnings as cast bars"
--[[ enUS ]] wL["Fade Duration"] = "Fade Duration"
--[[ enUS ]] wL["Sets the fade duration of animated cast warnings (0.0 is no fade)"] = "Sets the fade duration of animated cast warnings (0.0 is no fade)"
--[[ enUS ]] wL["Trade Skills"] = "Trade Skills"
--[[ enUS ]] wL["Show cast warnings for trade skills"] = "Show cast warnings for trade skills"
--[[ enUS ]] wL["Players"] = "Players"
--[[ enUS ]] wL["Show cast warnings for players"] = "Show cast warnings for players"
--[[ enUS ]] wL["Friendly Units"] = "Friendly Units"
--[[ enUS ]] wL["Show cast warnings for friendly units"] = "Show cast warnings for friendly units"

--[[ enUS ]] wL["Position"] = "Position"
--[[ enUS ]] wL["Adjust the cast warning's position"] = "Adjust the cast warning's position"
--[[ enUS ]] wL["Left Offset"] = "Left Offset"
--[[ enUS ]] wL["Sets the offset of the left of the cast warning"] = "Sets the offset of the left of the cast warning"
--[[ enUS ]] wL["Right Offset"] = "Right Offset"
--[[ enUS ]] wL["Sets the offset of the right of the cast warning"] = "Sets the offset of the right of the cast warning"
--[[ enUS ]] wL["Vertical Offset"] = "Vertical Offset"
--[[ enUS ]] wL["Sets the vertical offset of the cast warning"] = "Sets the vertical offset of the cast warning"

--[[ enUS ]] wL["Height"] = "Height"
--[[ enUS ]] wL["Sets the height of the cast warning"] = "Sets the height of the cast warning"

--[[ enUS ]] wL["Interruptable Cast Warning"] = "Interruptable Cast Warning"
--[[ enUS ]] wL["Cast warning appearance for interruptable spells"] = "Cast warning appearance for interruptable spells"
--[[ enUS ]] wL["Uninterruptable Cast Warning"] = "Uninterruptable Cast Warning"
--[[ enUS ]] wL["Cast warning appearance for uninterruptable spells"] = "Cast warning appearance for uninterruptable spells"

--[[ enUS ]] wL["Cast Warning Color"] = "Cast Warning Color"
--[[ enUS ]] wL["Sets the color of the cast warning"] = "Sets the color of the cast warning"
--[[ enUS ]] wL["Backdrop Color"] = "Backdrop Color"
--[[ enUS ]] wL["Sets the backdrop color of the cast warning"] = "Sets the backdrop color of the cast warning"
--[[ enUS ]] wL["Border Edge Size"] = "Border Edge Size"
--[[ enUS ]] wL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ enUS ]] wL["Border Inset"] = "Border Inset"
--[[ enUS ]] wL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ enUS ]] wL["Border Color"] = "Border Color"
--[[ enUS ]] wL["Sets the border color of the cast warning"] = "Sets the border color of the cast warning"
--[[ enUS ]] wL["Border Style"] = "Border Style"
--[[ enUS ]] wL["Sets the style of the cast warning border"] = "Sets the style of the cast warning border"
--[[ enUS ]] wL["Texture"] = "Texture"
--[[ enUS ]] wL["Sets the cast warning texture"] = "Sets the cast warning texture"

--[[ enUS ]] wL["Cast Warning Alpha Override Enable"] = "Cast Warning Alpha Override Enable"
--[[ enUS ]] wL["Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)"
--[[ enUS ]] wL["Cast Warning Alpha Override"] = "Cast Warning Alpha Override"
--[[ enUS ]] wL["Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)"

--[[ enUS ]] wL["Colors"] = "Colors"
--[[ enUS ]] wL["Customize cast warning colors (based on spell school)"] = "Customize cast warning colors (based on spell school)"
--[[ enUS ]] wL["Default"] = "Default"
--[[ enUS ]] wL["Sets the default color for cast warnings from unknown schools"] = "Sets the default color for cast warnings from unknown schools"
--[[ enUS ]] wL["Physical"] = "Physical"
--[[ enUS ]] wL["Sets the color for physical school cast warnings"] = "Sets the color for physical school cast warnings"
--[[ enUS ]] wL["Holy"] = "Holy"
--[[ enUS ]] wL["Sets the color for holy school cast warnings"] = "Sets the color for holy school cast warnings"
--[[ enUS ]] wL["Fire"] = "Fire"
--[[ enUS ]] wL["Sets the color for fire school cast warnings"] = "Sets the color for fire school cast warnings"
--[[ enUS ]] wL["Nature"] = "Nature"
--[[ enUS ]] wL["Sets the color for nature school cast warnings"] = "Sets the color for nature school cast warnings"
--[[ enUS ]] wL["Frost"] = "Frost"
--[[ enUS ]] wL["Sets the color for frost school cast warnings"] = "Sets the color for frost school cast warnings"
--[[ enUS ]] wL["Shadow"] = "Shadow"
--[[ enUS ]] wL["Sets the color for shadow school cast warnings"] = "Sets the color for shadow school cast warnings"
--[[ enUS ]] wL["Arcane"] = "Arcane"
--[[ enUS ]] wL["Sets the color for arcane school cast warnings"] = "Sets the color for arcane school cast warnings"
--[[ enUS ]] wL["Healing"] = "Healing"
--[[ enUS ]] wL["Sets the color for healing school cast warnings"] = "Sets the color for healing school cast warnings"

--[[ enUS ]] wL["Reset to Defaults"] = "Reset to Defaults"
--[[ enUS ]] wL["Resets all colors to their defaults"] = "Resets all colors to their defaults"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftCastWarning"] = "AloftCastWarning"
--[[ enUS ]] mL["Add cast warnings to Aloft unit nameplates"] = "Add cast warnings to Aloft unit nameplates"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellIcon", function()

-----------------------------------------------------------------------------

--[[ enUS ]] iL["Spell Icon"] = "Spell Icon"
--[[ enUS ]] iL["Cast warning spell icon placement options"] = "Cast warning spell icon placement options"
--[[ enUS ]] iL["Enable"] = "Enable"
--[[ enUS ]] iL["Enable cast warning spell icon display on the nameplate"] = "Enable cast warning spell icon display on the nameplate"
--[[ enUS ]] iL["Position"] = "Position"
--[[ enUS ]] iL["Adjust cast warning spell icon position"] = "Adjust cast warning spell icon position"
--[[ enUS ]] iL["Anchor"] = "Anchor"
--[[ enUS ]] iL["Sets the anchor for the cast warning spell icon"] = "Sets the anchor for the cast warning spell icon"
--[[ enUS ]] iL["Anchor To"] = "Anchor To"
--[[ enUS ]] iL["Sets the relative point on the cast warning to anchor the spell icon"] = "Sets the relative point on the cast warning to anchor the spell icon"
--[[ enUS ]] iL["X Offset"] = "X Offset"
--[[ enUS ]] iL["X offset of the cast warning spell icon"] = "X offset of the cast warning spell icon"
--[[ enUS ]] iL["Y Offset"] = "Y Offset"
--[[ enUS ]] iL["Y offset of the cast warning spell icon"] = "Y offset of the cast warning spell icon"
--[[ enUS ]] iL["Size"] = "Size"
--[[ enUS ]] iL["Size in pixels of the cast warning spell icon"] = "Size in pixels of the cast warning spell icon"

--[[ enUS ]] iL["Shield"] = "Shield"
--[[ enUS ]] iL["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon"
--[[ enUS ]] iL["Enable"] = "Enable"
--[[ enUS ]] iL["Enables the shield graphic"] = "Enables the shield graphic"
--[[ enUS ]] iL["Style"] = "Style"
--[[ enUS ]] iL["Sets the shield graphic style"] = "Sets the shield graphic style"
--[[ enUS ]] iL["Color"] = "Color"
--[[ enUS ]] iL["Sets the shield graphic color"] = "Sets the shield graphic color"

--[[ enUS ]] iL["SQUARE"] = "SQUARE"
--[[ enUS ]] iL["ROUND"] = "ROUND"

--[[ enUS ]] iL["TOPLEFT"] = "TOPLEFT"
--[[ enUS ]] iL["TOP"] = "TOP"
--[[ enUS ]] iL["TOPRIGHT"] = "TOPRIGHT"
--[[ enUS ]] iL["LEFT"] = "LEFT"
--[[ enUS ]] iL["CENTER"] = "CENTER"
--[[ enUS ]] iL["RIGHT"] = "RIGHT"
--[[ enUS ]] iL["BOTTOMLEFT"] = "BOTTOMLEFT"
--[[ enUS ]] iL["BOTTOM"] = "BOTTOM"
--[[ enUS ]] iL["BOTTOMRIGHT"] = "BOTTOMRIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftCastWarningSpellIcon"] = "AloftCastWarningSpellIcon"
--[[ enUS ]] mL["Display spell icon on cast warning"] = "Display spell icon on cast warning"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellNameText", function()

-----------------------------------------------------------------------------

--[[ enUS ]] nL["Spell Name"] = "Spell Name"
--[[ enUS ]] nL["Cast warning spell name text options"] = "Cast warning spell name text options"

--[[ enUS ]] nL["Enable"] = "Enable"
--[[ enUS ]] nL["Show cast warning spell name"] = "Show cast warning spell name"
--[[ enUS ]] nL["Display Rank"] = "Display Rank"
--[[ enUS ]] nL["Show cast warning spell rank"] = "Show cast warning spell rank"
--[[ enUS ]] nL["Display Min/Max Range"] = "Display Min/Max Range"
--[[ enUS ]] nL["Show cast warning spell minimum/maximum range"] = "Show cast warning spell minimum/maximum range"
--[[ enUS ]] nL["Display Outcome"] = "Display Outcome"
--[[ enUS ]] nL["Show cast warning spell outcome"] = "Show cast warning spell outcome"
--[[ enUS ]] nL["Display Outcome Reason"] = "Display Outcome Reason"
--[[ enUS ]] nL["Show cast warning spell outcome reason"] = "Show cast warning spell outcome reason"
--[[ enUS ]] nL["Display Outcome Reason"] = "Display Outcome Reason"
--[[ enUS ]] nL["Show cast warning spell outcome reason (failure type, interrupting spell)"] = "Show cast warning spell outcome reason (failure type, interrupting spell)"

--[[ enUS ]] nL["Typeface"] = "Typeface"
--[[ enUS ]] nL["Spell name typeface options"] = "Spell name typeface options"
--[[ enUS ]] nL["Font"] = "Font"
--[[ enUS ]] nL["Sets the font for spell name"] = "Sets the font for spell name"
--[[ enUS ]] nL["Font Size"] = "Font Size"
--[[ enUS ]] nL["Sets the font height of the spell name"] = "Sets the font height of the spell name"
--[[ enUS ]] nL["Font Shadow"] = "Font Shadow"
--[[ enUS ]] nL["Show font shadow on spell name"] = "Show font shadow on spell name"
--[[ enUS ]] nL["Outline"] = "Outline"
--[[ enUS ]] nL["Sets the font outline for spell name"] = "Sets the font outline for spell name"

--[[ enUS ]] nL["Alignment"] = "Alignment"
--[[ enUS ]] nL["Sets the alignment of the spell name"] = "Sets the alignment of the spell name"

--[[ enUS ]] nL["Position"] = "Position"
--[[ enUS ]] nL["Adjust spell name position"] = "Adjust spell name position"
--[[ enUS ]] nL["Left Offset"] = "Left Offset"
--[[ enUS ]] nL["Sets the offset of the left of the text"] = "Sets the offset of the left of the text"
--[[ enUS ]] nL["Right Offset"] = "Right Offset"
--[[ enUS ]] nL["Sets the offset of the right of the text"] = "Sets the offset of the right of the text"
--[[ enUS ]] nL["Vertical Offset"] = "Vertical Offset"
--[[ enUS ]] nL["Sets the vertical offset of the text"] = "Sets the vertical offset of the text"

--[[ enUS ]] nL["Colors"] = "Colors"
--[[ enUS ]] nL["Sets the spell name colors"] = "Sets the spell name colors"
--[[ enUS ]] nL["Cast Color"] = "Cast Color"
--[[ enUS ]] nL["Sets the spell name color during active casting"] = "Sets the spell name color during active casting"
--[[ enUS ]] nL["Fade Color"] = "Fade Color"
--[[ enUS ]] nL["Sets the spell name color during cast warning fade"] = "Sets the spell name color during cast warning fade"

--[[ enUS ]] nL["None"] = "None"
--[[ enUS ]] nL["Normal"] = "Normal"
--[[ enUS ]] nL["Thick"] = "Thick"

--[[ enUS ]] nL["LEFT"] = "LEFT"
--[[ enUS ]] nL["CENTER"] = "CENTER"
--[[ enUS ]] nL["RIGHT"] = "RIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftCastWarningSpellNameText"] = "AloftCastWarningSpellNameText"
--[[ enUS ]] mL["Display spell name on cast warning"] = "Display spell name on cast warning"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningTimeText", function()

-----------------------------------------------------------------------------

--[[ enUS ]] tL["Spell Time"] = "Spell Time"
--[[ enUS ]] tL["Cast warning spell time text options"] = "Cast warning spell time text options"
--[[ enUS ]] tL["Enable"] = "Enable"
--[[ enUS ]] tL["Show cast warning spell time"] = "Show cast warning spell time"
--[[ enUS ]] tL["Typeface"] = "Typeface"
--[[ enUS ]] tL["Spell time typeface options"] = "Spell time typeface options"
--[[ enUS ]] tL["Font"] = "Font"
--[[ enUS ]] tL["Sets the font for spell time"] = "Sets the font for spell time"
--[[ enUS ]] tL["Font Size"] = "Font Size"
--[[ enUS ]] tL["Sets the font height of the spell time"] = "Sets the font height of the spell time"
--[[ enUS ]] tL["Font Shadow"] = "Font Shadow"
--[[ enUS ]] tL["Show font shadow on spell time"] = "Show font shadow on spell time"
--[[ enUS ]] tL["Outline"] = "Outline"
--[[ enUS ]] tL["Sets the font outline for spell time"] = "Sets the font outline for spell time"
--[[ enUS ]] tL["Alignment"] = "Alignment"
--[[ enUS ]] tL["Sets the alignment of the spell time"] = "Sets the alignment of the spell time"
--[[ enUS ]] tL["Position"] = "Position"
--[[ enUS ]] tL["Adjust spell time position"] = "Adjust spell time position"
--[[ enUS ]] tL["Left Offset"] = "Left Offset"
--[[ enUS ]] tL["Sets the offset of the left of the text"] = "Sets the offset of the left of the text"
--[[ enUS ]] tL["Right Offset"] = "Right Offset"
--[[ enUS ]] tL["Sets the offset of the right of the text"] = "Sets the offset of the right of the text"
--[[ enUS ]] tL["Vertical Offset"] = "Vertical Offset"
--[[ enUS ]] tL["Sets the vertical offset of the text"] = "Sets the vertical offset of the text"

--[[ enUS ]] tL["Colors"] = "Colors"
--[[ enUS ]] tL["Sets the spell time colors"] = "Sets the spell time colors"
--[[ enUS ]] tL["Cast Color"] = "Cast Color"
--[[ enUS ]] tL["Sets the spell time color during active casting"] = "Sets the spell time color during active casting"
--[[ enUS ]] tL["Fade Color"] = "Fade Color"
--[[ enUS ]] tL["Sets the spell time color during cast warning fade"] = "Sets the spell time color during cast warning fade"

--[[ enUS ]] tL["None"] = "None"
--[[ enUS ]] tL["Normal"] = "Normal"
--[[ enUS ]] tL["Thick"] = "Thick"

--[[ enUS ]] tL["LEFT"] = "LEFT"
--[[ enUS ]] tL["CENTER"] = "CENTER"
--[[ enUS ]] tL["RIGHT"] = "RIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ enUS ]] mL["AloftCastWarningTimeText"] = "AloftCastWarningTimeText"
--[[ enUS ]] mL["Display time text on cast warning"] = "Display time text on cast warning"

-----------------------------------------------------------------------------

local locale = GetLocale()

-----------------------------------------------------------------------------

if (locale == "koKR") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

--[[ koKR ]] wL["Cast Warning"] = "Cast Warning"
--[[ koKR ]] wL["Cast warning options"] = "Cast warning options"

--[[ koKR ]] wL["Enable"] = "Enable"
--[[ koKR ]] wL["Show cast warnings on identifiable enemy nameplates"] = "Show cast warnings on identifiable enemy nameplates"
--[[ koKR ]] wL["Verification Interval"] = "Verification Interval"
--[[ koKR ]] wL["Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"] = "Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"
--[[ koKR ]] wL["Animated Cast Warning"] = "Animated Cast Warning"
--[[ koKR ]] wL["Animate cast warnings as cast bars"] = "Animate cast warnings as cast bars"
--[[ koKR ]] wL["Fade Duration"] = "Fade Duration"
--[[ koKR ]] wL["Sets the fade duration of animated cast warnings (0.0 is no fade)"] = "Sets the fade duration of animated cast warnings (0.0 is no fade)"
--[[ koKR ]] wL["Trade Skills"] = "Trade Skills"
--[[ koKR ]] wL["Show cast warnings for trade skills"] = "Show cast warnings for trade skills"
--[[ koKR ]] wL["Players"] = "Players"
--[[ koKR ]] wL["Show cast warnings for players"] = "Show cast warnings for players"
--[[ koKR ]] wL["Friendly Units"] = "Friendly Units"
--[[ koKR ]] wL["Show cast warnings for friendly units"] = "Show cast warnings for friendly units"

--[[ koKR ]] wL["Position"] = "Position"
--[[ koKR ]] wL["Adjust the cast warning's position"] = "Adjust the cast warning's position"
--[[ koKR ]] wL["Left Offset"] = "Left Offset"
--[[ koKR ]] wL["Sets the offset of the left of the cast warning"] = "Sets the offset of the left of the cast warning"
--[[ koKR ]] wL["Right Offset"] = "Right Offset"
--[[ koKR ]] wL["Sets the offset of the right of the cast warning"] = "Sets the offset of the right of the cast warning"
--[[ koKR ]] wL["Vertical Offset"] = "Vertical Offset"
--[[ koKR ]] wL["Sets the vertical offset of the cast warning"] = "Sets the vertical offset of the cast warning"

--[[ koKR ]] wL["Height"] = "Height"
--[[ koKR ]] wL["Sets the height of the cast warning"] = "Sets the height of the cast warning"

--[[ koKR ]] wL["Interruptable Cast Warning"] = "Interruptable Cast Warning"
--[[ koKR ]] wL["Cast warning appearance for interruptable spells"] = "Cast warning appearance for interruptable spells"
--[[ koKR ]] wL["Uninterruptable Cast Warning"] = "Uninterruptable Cast Warning"
--[[ koKR ]] wL["Cast warning appearance for uninterruptable spells"] = "Cast warning appearance for uninterruptable spells"

--[[ koKR ]] wL["Cast Warning Color"] = "Cast Warning Color"
--[[ koKR ]] wL["Sets the color of the cast warning"] = "Sets the color of the cast warning"
--[[ koKR ]] wL["Backdrop Color"] = "Backdrop Color"
--[[ koKR ]] wL["Sets the backdrop color of the cast warning"] = "Sets the backdrop color of the cast warning"
--[[ koKR ]] wL["Border Edge Size"] = "Border Edge Size"
--[[ koKR ]] wL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ koKR ]] wL["Border Inset"] = "Border Inset"
--[[ koKR ]] wL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ koKR ]] wL["Border Color"] = "Border Color"
--[[ koKR ]] wL["Sets the border color of the cast warning"] = "Sets the border color of the cast warning"
--[[ koKR ]] wL["Border Style"] = "Border Style"
--[[ koKR ]] wL["Sets the style of the cast warning border"] = "Sets the style of the cast warning border"
--[[ koKR ]] wL["Texture"] = "Texture"
--[[ koKR ]] wL["Sets the cast warning texture"] = "Sets the cast warning texture"

--[[ koKR ]] wL["Cast Warning Alpha Override Enable"] = "Cast Warning Alpha Override Enable"
--[[ koKR ]] wL["Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)"
--[[ koKR ]] wL["Cast Warning Alpha Override"] = "Cast Warning Alpha Override"
--[[ koKR ]] wL["Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)"

--[[ koKR ]] wL["Colors"] = "Colors"
--[[ koKR ]] wL["Customize cast warning colors (based on spell school)"] = "Customize cast warning colors (based on spell school)"
--[[ koKR ]] wL["Default"] = "Default"
--[[ koKR ]] wL["Sets the default color for cast warnings from unknown schools"] = "Sets the default color for cast warnings from unknown schools"
--[[ koKR ]] wL["Physical"] = "Physical"
--[[ koKR ]] wL["Sets the color for physical school cast warnings"] = "Sets the color for physical school cast warnings"
--[[ koKR ]] wL["Holy"] = "Holy"
--[[ koKR ]] wL["Sets the color for holy school cast warnings"] = "Sets the color for holy school cast warnings"
--[[ koKR ]] wL["Fire"] = "Fire"
--[[ koKR ]] wL["Sets the color for fire school cast warnings"] = "Sets the color for fire school cast warnings"
--[[ koKR ]] wL["Nature"] = "Nature"
--[[ koKR ]] wL["Sets the color for nature school cast warnings"] = "Sets the color for nature school cast warnings"
--[[ koKR ]] wL["Frost"] = "Frost"
--[[ koKR ]] wL["Sets the color for frost school cast warnings"] = "Sets the color for frost school cast warnings"
--[[ koKR ]] wL["Shadow"] = "Shadow"
--[[ koKR ]] wL["Sets the color for shadow school cast warnings"] = "Sets the color for shadow school cast warnings"
--[[ koKR ]] wL["Arcane"] = "Arcane"
--[[ koKR ]] wL["Sets the color for arcane school cast warnings"] = "Sets the color for arcane school cast warnings"
--[[ koKR ]] wL["Healing"] = "Healing"
--[[ koKR ]] wL["Sets the color for healing school cast warnings"] = "Sets the color for healing school cast warnings"

--[[ koKR ]] wL["Reset to Defaults"] = "Reset to Defaults"
--[[ koKR ]] wL["Resets all colors to their defaults"] = "Resets all colors to their defaults"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftCastWarning"] = "AloftCastWarning"
--[[ koKR ]] mL["Add cast warnings to Aloft unit nameplates"] = "Add cast warnings to Aloft unit nameplates"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellIcon", function()

-----------------------------------------------------------------------------

--[[ koKR ]] iL["Spell Icon"] = "Spell Icon"
--[[ koKR ]] iL["Cast warning spell icon placement options"] = "Cast warning spell icon placement options"
--[[ koKR ]] iL["Enable"] = "Enable"
--[[ koKR ]] iL["Enable cast warning spell icon display on the nameplate"] = "Enable cast warning spell icon display on the nameplate"
--[[ koKR ]] iL["Position"] = "Position"
--[[ koKR ]] iL["Adjust cast warning spell icon position"] = "Adjust cast warning spell icon position"
--[[ koKR ]] iL["Anchor"] = "Anchor"
--[[ koKR ]] iL["Sets the anchor for the cast warning spell icon"] = "Sets the anchor for the cast warning spell icon"
--[[ koKR ]] iL["Anchor To"] = "Anchor To"
--[[ koKR ]] iL["Sets the relative point on the cast warning to anchor the spell icon"] = "Sets the relative point on the cast warning to anchor the spell icon"
--[[ koKR ]] iL["X Offset"] = "X Offset"
--[[ koKR ]] iL["X offset of the cast warning spell icon"] = "X offset of the cast warning spell icon"
--[[ koKR ]] iL["Y Offset"] = "Y Offset"
--[[ koKR ]] iL["Y offset of the cast warning spell icon"] = "Y offset of the cast warning spell icon"
--[[ koKR ]] iL["Size"] = "Size"
--[[ koKR ]] iL["Size in pixels of the cast warning spell icon"] = "Size in pixels of the cast warning spell icon"

--[[ koKR ]] iL["Shield"] = "Shield"
--[[ koKR ]] iL["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon"
--[[ koKR ]] iL["Enable"] = "Enable"
--[[ koKR ]] iL["Enables the shield graphic"] = "Enables the shield graphic"
--[[ koKR ]] iL["Style"] = "Style"
--[[ koKR ]] iL["Sets the shield graphic style"] = "Sets the shield graphic style"
--[[ koKR ]] iL["Color"] = "Color"
--[[ koKR ]] iL["Sets the shield graphic color"] = "Sets the shield graphic color"

--[[ koKR ]] iL["SQUARE"] = "SQUARE"
--[[ koKR ]] iL["ROUND"] = "ROUND"

--[[ koKR ]] iL["TOPLEFT"] = "TOPLEFT"
--[[ koKR ]] iL["TOP"] = "TOP"
--[[ koKR ]] iL["TOPRIGHT"] = "TOPRIGHT"
--[[ koKR ]] iL["LEFT"] = "LEFT"
--[[ koKR ]] iL["CENTER"] = "CENTER"
--[[ koKR ]] iL["RIGHT"] = "RIGHT"
--[[ koKR ]] iL["BOTTOMLEFT"] = "BOTTOMLEFT"
--[[ koKR ]] iL["BOTTOM"] = "BOTTOM"
--[[ koKR ]] iL["BOTTOMRIGHT"] = "BOTTOMRIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftCastWarningSpellIcon"] = "AloftCastWarningSpellIcon"
--[[ koKR ]] mL["Display spell icon on cast warning"] = "Display spell icon on cast warning"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellNameText", function()

-----------------------------------------------------------------------------

--[[ koKR ]] nL["Spell Name"] = "Spell Name"
--[[ koKR ]] nL["Cast warning spell name text options"] = "Cast warning spell name text options"

--[[ koKR ]] nL["Enable"] = "Enable"
--[[ koKR ]] nL["Show cast warning spell name"] = "Show cast warning spell name"
--[[ koKR ]] nL["Display Rank"] = "Display Rank"
--[[ koKR ]] nL["Show cast warning spell rank"] = "Show cast warning spell rank"
--[[ koKR ]] nL["Display Min/Max Range"] = "Display Min/Max Range"
--[[ koKR ]] nL["Show cast warning spell minimum/maximum range"] = "Show cast warning spell minimum/maximum range"
--[[ koKR ]] nL["Display Outcome"] = "Display Outcome"
--[[ koKR ]] nL["Show cast warning spell outcome"] = "Show cast warning spell outcome"
--[[ koKR ]] nL["Display Outcome Reason"] = "Display Outcome Reason"
--[[ koKR ]] nL["Show cast warning spell outcome reason"] = "Show cast warning spell outcome reason"
--[[ koKR ]] nL["Display Outcome Reason"] = "Display Outcome Reason"
--[[ koKR ]] nL["Show cast warning spell outcome reason (failure type, interrupting spell)"] = "Show cast warning spell outcome reason (failure type, interrupting spell)"

--[[ koKR ]] nL["Typeface"] = "Typeface"
--[[ koKR ]] nL["Spell name typeface options"] = "Spell name typeface options"
--[[ koKR ]] nL["Font"] = "Font"
--[[ koKR ]] nL["Sets the font for spell name"] = "Sets the font for spell name"
--[[ koKR ]] nL["Font Size"] = "Font Size"
--[[ koKR ]] nL["Sets the font height of the spell name"] = "Sets the font height of the spell name"
--[[ koKR ]] nL["Font Shadow"] = "Font Shadow"
--[[ koKR ]] nL["Show font shadow on spell name"] = "Show font shadow on spell name"
--[[ koKR ]] nL["Outline"] = "Outline"
--[[ koKR ]] nL["Sets the font outline for spell name"] = "Sets the font outline for spell name"

--[[ koKR ]] nL["Alignment"] = "Alignment"
--[[ koKR ]] nL["Sets the alignment of the spell name"] = "Sets the alignment of the spell name"

--[[ koKR ]] nL["Position"] = "Position"
--[[ koKR ]] nL["Adjust spell name position"] = "Adjust spell name position"
--[[ koKR ]] nL["Left Offset"] = "Left Offset"
--[[ koKR ]] nL["Sets the offset of the left of the text"] = "Sets the offset of the left of the text"
--[[ koKR ]] nL["Right Offset"] = "Right Offset"
--[[ koKR ]] nL["Sets the offset of the right of the text"] = "Sets the offset of the right of the text"
--[[ koKR ]] nL["Vertical Offset"] = "Vertical Offset"
--[[ koKR ]] nL["Sets the vertical offset of the text"] = "Sets the vertical offset of the text"

--[[ koKR ]] nL["Colors"] = "Colors"
--[[ koKR ]] nL["Sets the spell name colors"] = "Sets the spell name colors"
--[[ koKR ]] nL["Cast Color"] = "Cast Color"
--[[ koKR ]] nL["Sets the spell name color during active casting"] = "Sets the spell name color during active casting"
--[[ koKR ]] nL["Fade Color"] = "Fade Color"
--[[ koKR ]] nL["Sets the spell name color during cast warning fade"] = "Sets the spell name color during cast warning fade"

--[[ koKR ]] nL["None"] = "None"
--[[ koKR ]] nL["Normal"] = "Normal"
--[[ koKR ]] nL["Thick"] = "Thick"

--[[ koKR ]] nL["LEFT"] = "LEFT"
--[[ koKR ]] nL["CENTER"] = "CENTER"
--[[ koKR ]] nL["RIGHT"] = "RIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftCastWarningSpellNameText"] = "AloftCastWarningSpellNameText"
--[[ koKR ]] mL["Display spell name on cast warning"] = "Display spell name on cast warning"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningTimeText", function()

-----------------------------------------------------------------------------

--[[ koKR ]] tL["Spell Time"] = "Spell Time"
--[[ koKR ]] tL["Cast warning spell time text options"] = "Cast warning spell time text options"
--[[ koKR ]] tL["Enable"] = "Enable"
--[[ koKR ]] tL["Show cast warning spell time"] = "Show cast warning spell time"
--[[ koKR ]] tL["Typeface"] = "Typeface"
--[[ koKR ]] tL["Spell time typeface options"] = "Spell time typeface options"
--[[ koKR ]] tL["Font"] = "Font"
--[[ koKR ]] tL["Sets the font for spell time"] = "Sets the font for spell time"
--[[ koKR ]] tL["Font Size"] = "Font Size"
--[[ koKR ]] tL["Sets the font height of the spell time"] = "Sets the font height of the spell time"
--[[ koKR ]] tL["Font Shadow"] = "Font Shadow"
--[[ koKR ]] tL["Show font shadow on spell time"] = "Show font shadow on spell time"
--[[ koKR ]] tL["Outline"] = "Outline"
--[[ koKR ]] tL["Sets the font outline for spell time"] = "Sets the font outline for spell time"
--[[ koKR ]] tL["Alignment"] = "Alignment"
--[[ koKR ]] tL["Sets the alignment of the spell time"] = "Sets the alignment of the spell time"
--[[ koKR ]] tL["Position"] = "Position"
--[[ koKR ]] tL["Adjust spell time position"] = "Adjust spell time position"
--[[ koKR ]] tL["Left Offset"] = "Left Offset"
--[[ koKR ]] tL["Sets the offset of the left of the text"] = "Sets the offset of the left of the text"
--[[ koKR ]] tL["Right Offset"] = "Right Offset"
--[[ koKR ]] tL["Sets the offset of the right of the text"] = "Sets the offset of the right of the text"
--[[ koKR ]] tL["Vertical Offset"] = "Vertical Offset"
--[[ koKR ]] tL["Sets the vertical offset of the text"] = "Sets the vertical offset of the text"

--[[ koKR ]] tL["Colors"] = "Colors"
--[[ koKR ]] tL["Sets the spell time colors"] = "Sets the spell time colors"
--[[ koKR ]] tL["Cast Color"] = "Cast Color"
--[[ koKR ]] tL["Sets the spell time color during active casting"] = "Sets the spell time color during active casting"
--[[ koKR ]] tL["Fade Color"] = "Fade Color"
--[[ koKR ]] tL["Sets the spell time color during cast warning fade"] = "Sets the spell time color during cast warning fade"

--[[ koKR ]] tL["None"] = "None"
--[[ koKR ]] tL["Normal"] = "Normal"
--[[ koKR ]] tL["Thick"] = "Thick"

--[[ koKR ]] tL["LEFT"] = "LEFT"
--[[ koKR ]] tL["CENTER"] = "CENTER"
--[[ koKR ]] tL["RIGHT"] = "RIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ koKR ]] mL["AloftCastWarningTimeText"] = "AloftCastWarningTimeText"
--[[ koKR ]] mL["Display time text on cast warning"] = "Display time text on cast warning"

-----------------------------------------------------------------------------

elseif (locale == "ruRU") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] wL["Cast Warning"] = "Cast Warning"
--[[ ruRU ]] wL["Cast warning options"] = "Cast warning options"

--[[ ruRU ]] wL["Enable"] = "Enable"
--[[ ruRU ]] wL["Show cast warnings on identifiable enemy nameplates"] = "Show cast warnings on identifiable enemy nameplates"
--[[ ruRU ]] wL["Verification Interval"] = "Verification Interval"
--[[ ruRU ]] wL["Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"] = "Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"
--[[ ruRU ]] wL["Animated Cast Warning"] = "Animated Cast Warning"
--[[ ruRU ]] wL["Animate cast warnings as cast bars"] = "Animate cast warnings as cast bars"
--[[ ruRU ]] wL["Fade Duration"] = "Fade Duration"
--[[ ruRU ]] wL["Sets the fade duration of animated cast warnings (0.0 is no fade)"] = "Sets the fade duration of animated cast warnings (0.0 is no fade)"
--[[ ruRU ]] wL["Trade Skills"] = "Trade Skills"
--[[ ruRU ]] wL["Show cast warnings for trade skills"] = "Show cast warnings for trade skills"
--[[ ruRU ]] wL["Players"] = "Players"
--[[ ruRU ]] wL["Show cast warnings for players"] = "Show cast warnings for players"
--[[ ruRU ]] wL["Friendly Units"] = "Friendly Units"
--[[ ruRU ]] wL["Show cast warnings for friendly units"] = "Show cast warnings for friendly units"

--[[ ruRU ]] wL["Position"] = "Position"
--[[ ruRU ]] wL["Adjust the cast warning's position"] = "Adjust the cast warning's position"
--[[ ruRU ]] wL["Left Offset"] = "Left Offset"
--[[ ruRU ]] wL["Sets the offset of the left of the cast warning"] = "Sets the offset of the left of the cast warning"
--[[ ruRU ]] wL["Right Offset"] = "Right Offset"
--[[ ruRU ]] wL["Sets the offset of the right of the cast warning"] = "Sets the offset of the right of the cast warning"
--[[ ruRU ]] wL["Vertical Offset"] = "Vertical Offset"
--[[ ruRU ]] wL["Sets the vertical offset of the cast warning"] = "Sets the vertical offset of the cast warning"

--[[ ruRU ]] wL["Height"] = "Height"
--[[ ruRU ]] wL["Sets the height of the cast warning"] = "Sets the height of the cast warning"

--[[ ruRU ]] wL["Interruptable Cast Warning"] = "Interruptable Cast Warning"
--[[ ruRU ]] wL["Cast warning appearance for interruptable spells"] = "Cast warning appearance for interruptable spells"
--[[ ruRU ]] wL["Uninterruptable Cast Warning"] = "Uninterruptable Cast Warning"
--[[ ruRU ]] wL["Cast warning appearance for uninterruptable spells"] = "Cast warning appearance for uninterruptable spells"

--[[ ruRU ]] wL["Cast Warning Color"] = "Cast Warning Color"
--[[ ruRU ]] wL["Sets the color of the cast warning"] = "Sets the color of the cast warning"
--[[ ruRU ]] wL["Backdrop Color"] = "Backdrop Color"
--[[ ruRU ]] wL["Sets the backdrop color of the cast warning"] = "Sets the backdrop color of the cast warning"
--[[ ruRU ]] wL["Border Edge Size"] = "Border Edge Size"
--[[ ruRU ]] wL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ ruRU ]] wL["Border Inset"] = "Border Inset"
--[[ ruRU ]] wL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ ruRU ]] wL["Border Color"] = "Border Color"
--[[ ruRU ]] wL["Sets the border color of the cast warning"] = "Sets the border color of the cast warning"
--[[ ruRU ]] wL["Border Style"] = "Border Style"
--[[ ruRU ]] wL["Sets the style of the cast warning border"] = "Sets the style of the cast warning border"
--[[ ruRU ]] wL["Texture"] = "Texture"
--[[ ruRU ]] wL["Sets the cast warning texture"] = "Sets the cast warning texture"

--[[ ruRU ]] wL["Cast Warning Override Enable"] = "Cast Warning Override Enable"
--[[ ruRU ]] wL["Enable changing alpha of actively casting units"] = "Enable changing alpha of actively casting units"
--[[ ruRU ]] wL["Cast Warning Override Alpha"] = "Cast Warning Override Alpha"
--[[ ruRU ]] wL["Sets the alpha of actively casting units"] = "Sets the alpha of actively casting units"

--[[ ruRU ]] wL["Colors"] = "Colors"
--[[ ruRU ]] wL["Customize cast warning colors (based on spell school)"] = "Customize cast warning colors (based on spell school)"
--[[ ruRU ]] wL["Default"] = "Default"
--[[ ruRU ]] wL["Sets the default color for cast warnings from unknown schools"] = "Sets the default color for cast warnings from unknown schools"
--[[ ruRU ]] wL["Physical"] = "Physical"
--[[ ruRU ]] wL["Sets the color for physical school cast warnings"] = "Sets the color for physical school cast warnings"
--[[ ruRU ]] wL["Holy"] = "Holy"
--[[ ruRU ]] wL["Sets the color for holy school cast warnings"] = "Sets the color for holy school cast warnings"
--[[ ruRU ]] wL["Fire"] = "Fire"
--[[ ruRU ]] wL["Sets the color for fire school cast warnings"] = "Sets the color for fire school cast warnings"
--[[ ruRU ]] wL["Nature"] = "Nature"
--[[ ruRU ]] wL["Sets the color for nature school cast warnings"] = "Sets the color for nature school cast warnings"
--[[ ruRU ]] wL["Frost"] = "Frost"
--[[ ruRU ]] wL["Sets the color for frost school cast warnings"] = "Sets the color for frost school cast warnings"
--[[ ruRU ]] wL["Shadow"] = "Shadow"
--[[ ruRU ]] wL["Sets the color for shadow school cast warnings"] = "Sets the color for shadow school cast warnings"
--[[ ruRU ]] wL["Arcane"] = "Arcane"
--[[ ruRU ]] wL["Sets the color for arcane school cast warnings"] = "Sets the color for arcane school cast warnings"
--[[ ruRU ]] wL["Healing"] = "Healing"
--[[ ruRU ]] wL["Sets the color for healing school cast warnings"] = "Sets the color for healing school cast warnings"

--[[ ruRU ]] wL["Reset to Defaults"] = "Reset to Defaults"
--[[ ruRU ]] wL["Resets all colors to their defaults"] = "Resets all colors to their defaults"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftCastWarning"] = "AloftCastWarning"
--[[ ruRU ]] mL["Add cast warnings to Aloft unit nameplates"] = "Добавить предупреждения о вражеских заклинаниях к табличкам Aloft"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellIcon", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] iL["Spell Icon"] = "Spell Icon"
--[[ ruRU ]] iL["Cast warning spell icon placement options"] = "Cast warning spell icon placement options"
--[[ ruRU ]] iL["Enable"] = "Enable"
--[[ ruRU ]] iL["Enable cast warning spell icon display on the nameplate"] = "Enable cast warning spell icon display on the nameplate"
--[[ ruRU ]] iL["Position"] = "Position"
--[[ ruRU ]] iL["Adjust cast warning spell icon position"] = "Adjust cast warning spell icon position"
--[[ ruRU ]] iL["Anchor"] = "Anchor"
--[[ ruRU ]] iL["Sets the anchor for the cast warning spell icon"] = "Sets the anchor for the cast warning spell icon"
--[[ ruRU ]] iL["Anchor To"] = "Anchor To"
--[[ ruRU ]] iL["Sets the relative point on the cast warning to anchor the spell icon"] = "Sets the relative point on the cast warning to anchor the spell icon"
--[[ ruRU ]] iL["X Offset"] = "X Offset"
--[[ ruRU ]] iL["X offset of the cast warning spell icon"] = "X offset of the cast warning spell icon"
--[[ ruRU ]] iL["Y Offset"] = "Y Offset"
--[[ ruRU ]] iL["Y offset of the cast warning spell icon"] = "Y offset of the cast warning spell icon"
--[[ ruRU ]] iL["Size"] = "Size"
--[[ ruRU ]] iL["Size in pixels of the cast warning spell icon"] = "Size in pixels of the cast warning spell icon"

--[[ ruRU ]] iL["Shield"] = "Shield"
--[[ ruRU ]] iL["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon"
--[[ ruRU ]] iL["Enable"] = "Enable"
--[[ ruRU ]] iL["Enables the shield graphic"] = "Enables the shield graphic"
--[[ ruRU ]] iL["Style"] = "Style"
--[[ ruRU ]] iL["Sets the shield graphic style"] = "Sets the shield graphic style"
--[[ ruRU ]] iL["Color"] = "Color"
--[[ ruRU ]] iL["Sets the shield graphic color"] = "Sets the shield graphic color"

--[[ ruRU ]] iL["SQUARE"] = "SQUARE"
--[[ ruRU ]] iL["ROUND"] = "ROUND"

--[[ ruRU ]] iL["TOPLEFT"] = "TOPLEFT"
--[[ ruRU ]] iL["TOP"] = "TOP"
--[[ ruRU ]] iL["TOPRIGHT"] = "TOPRIGHT"
--[[ ruRU ]] iL["LEFT"] = "LEFT"
--[[ ruRU ]] iL["CENTER"] = "CENTER"
--[[ ruRU ]] iL["RIGHT"] = "RIGHT"
--[[ ruRU ]] iL["BOTTOMLEFT"] = "BOTTOMLEFT"
--[[ ruRU ]] iL["BOTTOM"] = "BOTTOM"
--[[ ruRU ]] iL["BOTTOMRIGHT"] = "BOTTOMRIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftCastWarningSpellIcon"] = "AloftCastWarningSpellIcon"
--[[ ruRU ]] mL["Display spell icon on cast warning"] = "Display spell icon on cast warning"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellNameText", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] nL["Spell Name"] = "Spell Name"
--[[ ruRU ]] nL["Cast warning spell name text options"] = "Cast warning spell name text options"

--[[ ruRU ]] nL["Enable"] = "Enable"
--[[ ruRU ]] nL["Show cast warning spell name"] = "Show cast warning spell name"
--[[ ruRU ]] nL["Display Rank"] = "Display Rank"
--[[ ruRU ]] nL["Show cast warning spell rank"] = "Show cast warning spell rank"
--[[ ruRU ]] nL["Display Min/Max Range"] = "Display Min/Max Range"
--[[ ruRU ]] nL["Show cast warning spell minimum/maximum range"] = "Show cast warning spell minimum/maximum range"
--[[ ruRU ]] nL["Display Outcome"] = "Display Outcome"
--[[ ruRU ]] nL["Show cast warning spell outcome"] = "Show cast warning spell outcome"
--[[ ruRU ]] nL["Display Outcome Reason"] = "Display Outcome Reason"
--[[ ruRU ]] nL["Show cast warning spell outcome reason"] = "Show cast warning spell outcome reason"
--[[ ruRU ]] nL["Display Outcome Reason"] = "Display Outcome Reason"
--[[ ruRU ]] nL["Show cast warning spell outcome reason (failure type, interrupting spell)"] = "Show cast warning spell outcome reason (failure type, interrupting spell)"

--[[ ruRU ]] nL["Typeface"] = "Typeface"
--[[ ruRU ]] nL["Spell name typeface options"] = "Spell name typeface options"
--[[ ruRU ]] nL["Font"] = "Font"
--[[ ruRU ]] nL["Sets the font for spell name"] = "Sets the font for spell name"
--[[ ruRU ]] nL["Font Size"] = "Font Size"
--[[ ruRU ]] nL["Sets the font height of the spell name"] = "Sets the font height of the spell name"
--[[ ruRU ]] nL["Font Shadow"] = "Font Shadow"
--[[ ruRU ]] nL["Show font shadow on spell name"] = "Show font shadow on spell name"
--[[ ruRU ]] nL["Outline"] = "Outline"
--[[ ruRU ]] nL["Sets the font outline for spell name"] = "Sets the font outline for spell name"

--[[ ruRU ]] nL["Alignment"] = "Alignment"
--[[ ruRU ]] nL["Sets the alignment of the spell name"] = "Sets the alignment of the spell name"

--[[ ruRU ]] nL["Position"] = "Position"
--[[ ruRU ]] nL["Adjust spell name position"] = "Adjust spell name position"
--[[ ruRU ]] nL["Left Offset"] = "Left Offset"
--[[ ruRU ]] nL["Sets the offset of the left of the text"] = "Sets the offset of the left of the text"
--[[ ruRU ]] nL["Right Offset"] = "Right Offset"
--[[ ruRU ]] nL["Sets the offset of the right of the text"] = "Sets the offset of the right of the text"
--[[ ruRU ]] nL["Vertical Offset"] = "Vertical Offset"
--[[ ruRU ]] nL["Sets the vertical offset of the text"] = "Sets the vertical offset of the text"

--[[ ruRU ]] nL["Colors"] = "Colors"
--[[ ruRU ]] nL["Sets the spell name colors"] = "Sets the spell name colors"
--[[ ruRU ]] nL["Cast Color"] = "Cast Color"
--[[ ruRU ]] nL["Sets the spell name color during active casting"] = "Sets the spell name color during active casting"
--[[ ruRU ]] nL["Fade Color"] = "Fade Color"
--[[ ruRU ]] nL["Sets the spell name color during cast warning fade"] = "Sets the spell name color during cast warning fade"

--[[ ruRU ]] nL["None"] = "None"
--[[ ruRU ]] nL["Normal"] = "Normal"
--[[ ruRU ]] nL["Thick"] = "Thick"

--[[ ruRU ]] nL["LEFT"] = "LEFT"
--[[ ruRU ]] nL["CENTER"] = "CENTER"
--[[ ruRU ]] nL["RIGHT"] = "RIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftCastWarningSpellNameText"] = "AloftCastWarningSpellNameText"
--[[ ruRU ]] mL["Display spell name on cast warning"] = "Display spell name on cast warning"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningTimeText", function()

-----------------------------------------------------------------------------

--[[ ruRU ]] tL["Spell Time"] = "Spell Time"
--[[ ruRU ]] tL["Cast warning spell time text options"] = "Cast warning spell time text options"
--[[ ruRU ]] tL["Enable"] = "Enable"
--[[ ruRU ]] tL["Show cast warning spell time"] = "Show cast warning spell time"
--[[ ruRU ]] tL["Typeface"] = "Typeface"
--[[ ruRU ]] tL["Spell time typeface options"] = "Spell time typeface options"
--[[ ruRU ]] tL["Font"] = "Font"
--[[ ruRU ]] tL["Sets the font for spell time"] = "Sets the font for spell time"
--[[ ruRU ]] tL["Font Size"] = "Font Size"
--[[ ruRU ]] tL["Sets the font height of the spell time"] = "Sets the font height of the spell time"
--[[ ruRU ]] tL["Font Shadow"] = "Font Shadow"
--[[ ruRU ]] tL["Show font shadow on spell time"] = "Show font shadow on spell time"
--[[ ruRU ]] tL["Outline"] = "Outline"
--[[ ruRU ]] tL["Sets the font outline for spell time"] = "Sets the font outline for spell time"
--[[ ruRU ]] tL["Alignment"] = "Alignment"
--[[ ruRU ]] tL["Sets the alignment of the spell time"] = "Sets the alignment of the spell time"
--[[ ruRU ]] tL["Position"] = "Position"
--[[ ruRU ]] tL["Adjust spell time position"] = "Adjust spell time position"
--[[ ruRU ]] tL["Left Offset"] = "Left Offset"
--[[ ruRU ]] tL["Sets the offset of the left of the text"] = "Sets the offset of the left of the text"
--[[ ruRU ]] tL["Right Offset"] = "Right Offset"
--[[ ruRU ]] tL["Sets the offset of the right of the text"] = "Sets the offset of the right of the text"
--[[ ruRU ]] tL["Vertical Offset"] = "Vertical Offset"
--[[ ruRU ]] tL["Sets the vertical offset of the text"] = "Sets the vertical offset of the text"

--[[ ruRU ]] tL["Colors"] = "Colors"
--[[ ruRU ]] tL["Sets the spell time colors"] = "Sets the spell time colors"
--[[ ruRU ]] tL["Cast Color"] = "Cast Color"
--[[ ruRU ]] tL["Sets the spell time color during active casting"] = "Sets the spell time color during active casting"
--[[ ruRU ]] tL["Fade Color"] = "Fade Color"
--[[ ruRU ]] tL["Sets the spell time color during cast warning fade"] = "Sets the spell time color during cast warning fade"

--[[ ruRU ]] tL["None"] = "None"
--[[ ruRU ]] tL["Normal"] = "Normal"
--[[ ruRU ]] tL["Thick"] = "Thick"

--[[ ruRU ]] tL["LEFT"] = "LEFT"
--[[ ruRU ]] tL["CENTER"] = "CENTER"
--[[ ruRU ]] tL["RIGHT"] = "RIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ ruRU ]] mL["AloftCastWarningTimeText"] = "AloftCastWarningTimeText"
--[[ ruRU ]] mL["Display time text on cast warning"] = "Display time text on cast warning"

-----------------------------------------------------------------------------

elseif (locale == "zhCN") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] wL["Cast Warning"] = "Cast Warning"
--[[ zhCN ]] wL["Cast warning options"] = "Cast warning options"

--[[ zhCN ]] wL["Enable"] = "Enable"
--[[ zhCN ]] wL["Show cast warnings on identifiable enemy nameplates"] = "Show cast warnings on identifiable enemy nameplates"
--[[ zhCN ]] wL["Verification Interval"] = "Verification Interval"
--[[ zhCN ]] wL["Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"] = "Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"
--[[ zhCN ]] wL["Animated Cast Warning"] = "Animated Cast Warning"
--[[ zhCN ]] wL["Animate cast warnings as cast bars"] = "Animate cast warnings as cast bars"
--[[ zhCN ]] wL["Fade Duration"] = "Fade Duration"
--[[ zhCN ]] wL["Sets the fade duration of animated cast warnings (0.0 is no fade)"] = "Sets the fade duration of animated cast warnings (0.0 is no fade)"
--[[ zhCN ]] wL["Trade Skills"] = "Trade Skills"
--[[ zhCN ]] wL["Show cast warnings for trade skills"] = "Show cast warnings for trade skills"
--[[ zhCN ]] wL["Players"] = "Players"
--[[ zhCN ]] wL["Show cast warnings for players"] = "Show cast warnings for players"
--[[ zhCN ]] wL["Friendly Units"] = "Friendly Units"
--[[ zhCN ]] wL["Show cast warnings for friendly units"] = "Show cast warnings for friendly units"

--[[ zhCN ]] wL["Position"] = "Position"
--[[ zhCN ]] wL["Adjust the cast warning's position"] = "Adjust the cast warning's position"
--[[ zhCN ]] wL["Left Offset"] = "Left Offset"
--[[ zhCN ]] wL["Sets the offset of the left of the cast warning"] = "Sets the offset of the left of the cast warning"
--[[ zhCN ]] wL["Right Offset"] = "Right Offset"
--[[ zhCN ]] wL["Sets the offset of the right of the cast warning"] = "Sets the offset of the right of the cast warning"
--[[ zhCN ]] wL["Vertical Offset"] = "Vertical Offset"
--[[ zhCN ]] wL["Sets the vertical offset of the cast warning"] = "Sets the vertical offset of the cast warning"

--[[ zhCN ]] wL["Height"] = "Height"
--[[ zhCN ]] wL["Sets the height of the cast warning"] = "Sets the height of the cast warning"

--[[ zhCN ]] wL["Interruptable Cast Warning"] = "Interruptable Cast Warning"
--[[ zhCN ]] wL["Cast warning appearance for interruptable spells"] = "Cast warning appearance for interruptable spells"
--[[ zhCN ]] wL["Uninterruptable Cast Warning"] = "Uninterruptable Cast Warning"
--[[ zhCN ]] wL["Cast warning appearance for uninterruptable spells"] = "Cast warning appearance for uninterruptable spells"

--[[ zhCN ]] wL["Cast Warning Color"] = "Cast Warning Color"
--[[ zhCN ]] wL["Sets the color of the cast warning"] = "Sets the color of the cast warning"
--[[ zhCN ]] wL["Backdrop Color"] = "Backdrop Color"
--[[ zhCN ]] wL["Sets the backdrop color of the cast warning"] = "Sets the backdrop color of the cast warning"
--[[ zhCN ]] wL["Border Edge Size"] = "Border Edge Size"
--[[ zhCN ]] wL["Sets the thickness of the border"] = "Sets the thickness of the border"
--[[ zhCN ]] wL["Border Inset"] = "Border Inset"
--[[ zhCN ]] wL["Sets the padding aroundthe border"] = "Sets the padding around the border"
--[[ zhCN ]] wL["Border Color"] = "Border Color"
--[[ zhCN ]] wL["Sets the border color of the cast warning"] = "Sets the border color of the cast warning"
--[[ zhCN ]] wL["Border Style"] = "Border Style"
--[[ zhCN ]] wL["Sets the style of the cast warning border"] = "Sets the style of the cast warning border"
--[[ zhCN ]] wL["Texture"] = "Texture"
--[[ zhCN ]] wL["Sets the cast warning texture"] = "Sets the cast warning texture"

--[[ zhCN ]] wL["Cast Warning Alpha Override Enable"] = "Cast Warning Alpha Override Enable"
--[[ zhCN ]] wL["Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)"
--[[ zhCN ]] wL["Cast Warning Alpha Override"] = "Cast Warning Alpha Override"
--[[ zhCN ]] wL["Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)"

--[[ zhCN ]] wL["Colors"] = "Colors"
--[[ zhCN ]] wL["Customize cast warning colors (based on spell school)"] = "Customize cast warning colors (based on spell school)"
--[[ zhCN ]] wL["Default"] = "Default"
--[[ zhCN ]] wL["Sets the default color for cast warnings from unknown schools"] = "Sets the default color for cast warnings from unknown schools"
--[[ zhCN ]] wL["Physical"] = "Physical"
--[[ zhCN ]] wL["Sets the color for physical school cast warnings"] = "Sets the color for physical school cast warnings"
--[[ zhCN ]] wL["Holy"] = "Holy"
--[[ zhCN ]] wL["Sets the color for holy school cast warnings"] = "Sets the color for holy school cast warnings"
--[[ zhCN ]] wL["Fire"] = "Fire"
--[[ zhCN ]] wL["Sets the color for fire school cast warnings"] = "Sets the color for fire school cast warnings"
--[[ zhCN ]] wL["Nature"] = "Nature"
--[[ zhCN ]] wL["Sets the color for nature school cast warnings"] = "Sets the color for nature school cast warnings"
--[[ zhCN ]] wL["Frost"] = "Frost"
--[[ zhCN ]] wL["Sets the color for frost school cast warnings"] = "Sets the color for frost school cast warnings"
--[[ zhCN ]] wL["Shadow"] = "Shadow"
--[[ zhCN ]] wL["Sets the color for shadow school cast warnings"] = "Sets the color for shadow school cast warnings"
--[[ zhCN ]] wL["Arcane"] = "Arcane"
--[[ zhCN ]] wL["Sets the color for arcane school cast warnings"] = "Sets the color for arcane school cast warnings"
--[[ zhCN ]] wL["Healing"] = "Healing"
--[[ zhCN ]] wL["Sets the color for healing school cast warnings"] = "Sets the color for healing school cast warnings"

--[[ zhCN ]] wL["Reset to Defaults"] = "Reset to Defaults"
--[[ zhCN ]] wL["Resets all colors to their defaults"] = "Resets all colors to their defaults"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftCastWarning"] = "AloftCastWarning"
--[[ zhCN ]] mL["Add cast warnings to Aloft unit nameplates"] = "Add cast warnings to Aloft unit nameplates"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellIcon", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] iL["Spell Icon"] = "Spell Icon"
--[[ zhCN ]] iL["Cast warning spell icon placement options"] = "Cast warning spell icon placement options"
--[[ zhCN ]] iL["Enable"] = "Enable"
--[[ zhCN ]] iL["Enable cast warning spell icon display on the nameplate"] = "Enable cast warning spell icon display on the nameplate"
--[[ zhCN ]] iL["Position"] = "Position"
--[[ zhCN ]] iL["Adjust cast warning spell icon position"] = "Adjust cast warning spell icon position"
--[[ zhCN ]] iL["Anchor"] = "Anchor"
--[[ zhCN ]] iL["Sets the anchor for the cast warning spell icon"] = "Sets the anchor for the cast warning spell icon"
--[[ zhCN ]] iL["Anchor To"] = "Anchor To"
--[[ zhCN ]] iL["Sets the relative point on the cast warning to anchor the spell icon"] = "Sets the relative point on the cast warning to anchor the spell icon"
--[[ zhCN ]] iL["X Offset"] = "X Offset"
--[[ zhCN ]] iL["X offset of the cast warning spell icon"] = "X offset of the cast warning spell icon"
--[[ zhCN ]] iL["Y Offset"] = "Y Offset"
--[[ zhCN ]] iL["Y offset of the cast warning spell icon"] = "Y offset of the cast warning spell icon"
--[[ zhCN ]] iL["Size"] = "Size"
--[[ zhCN ]] iL["Size in pixels of the cast warning spell icon"] = "Size in pixels of the cast warning spell icon"

--[[ zhCN ]] iL["Shield"] = "Shield"
--[[ zhCN ]] iL["Shows a shield graphic around an uninterruptable spell icon"] = "Shows a shield graphic around an uninterruptable spell icon"
--[[ zhCN ]] iL["Enable"] = "Enable"
--[[ zhCN ]] iL["Enables the shield graphic"] = "Enables the shield graphic"
--[[ zhCN ]] iL["Style"] = "Style"
--[[ zhCN ]] iL["Sets the shield graphic style"] = "Sets the shield graphic style"
--[[ zhCN ]] iL["Color"] = "Color"
--[[ zhCN ]] iL["Sets the shield graphic color"] = "Sets the shield graphic color"

--[[ zhCN ]] iL["SQUARE"] = "SQUARE"
--[[ zhCN ]] iL["ROUND"] = "ROUND"

--[[ zhCN ]] iL["TOPLEFT"] = "TOPLEFT"
--[[ zhCN ]] iL["TOP"] = "TOP"
--[[ zhCN ]] iL["TOPRIGHT"] = "TOPRIGHT"
--[[ zhCN ]] iL["LEFT"] = "LEFT"
--[[ zhCN ]] iL["CENTER"] = "CENTER"
--[[ zhCN ]] iL["RIGHT"] = "RIGHT"
--[[ zhCN ]] iL["BOTTOMLEFT"] = "BOTTOMLEFT"
--[[ zhCN ]] iL["BOTTOM"] = "BOTTOM"
--[[ zhCN ]] iL["BOTTOMRIGHT"] = "BOTTOMRIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftCastWarningSpellIcon"] = "AloftCastWarningSpellIcon"
--[[ zhCN ]] mL["Display spell icon on cast warning"] = "Display spell icon on cast warning"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellNameText", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] nL["Spell Name"] = "Spell Name"
--[[ zhCN ]] nL["Cast warning spell name text options"] = "Cast warning spell name text options"

--[[ zhCN ]] nL["Enable"] = "Enable"
--[[ zhCN ]] nL["Show cast warning spell name"] = "Show cast warning spell name"
--[[ zhCN ]] nL["Display Rank"] = "Display Rank"
--[[ zhCN ]] nL["Show cast warning spell rank"] = "Show cast warning spell rank"
--[[ zhCN ]] nL["Display Min/Max Range"] = "Display Min/Max Range"
--[[ zhCN ]] nL["Show cast warning spell minimum/maximum range"] = "Show cast warning spell minimum/maximum range"
--[[ zhCN ]] nL["Display Outcome"] = "Display Outcome"
--[[ zhCN ]] nL["Show cast warning spell outcome"] = "Show cast warning spell outcome"
--[[ zhCN ]] nL["Display Outcome Reason"] = "Display Outcome Reason"
--[[ zhCN ]] nL["Show cast warning spell outcome reason"] = "Show cast warning spell outcome reason"
--[[ zhCN ]] nL["Display Outcome Reason"] = "Display Outcome Reason"
--[[ zhCN ]] nL["Show cast warning spell outcome reason (failure type, interrupting spell)"] = "Show cast warning spell outcome reason (failure type, interrupting spell)"

--[[ zhCN ]] nL["Typeface"] = "Typeface"
--[[ zhCN ]] nL["Spell name typeface options"] = "Spell name typeface options"
--[[ zhCN ]] nL["Font"] = "Font"
--[[ zhCN ]] nL["Sets the font for spell name"] = "Sets the font for spell name"
--[[ zhCN ]] nL["Font Size"] = "Font Size"
--[[ zhCN ]] nL["Sets the font height of the spell name"] = "Sets the font height of the spell name"
--[[ zhCN ]] nL["Font Shadow"] = "Font Shadow"
--[[ zhCN ]] nL["Show font shadow on spell name"] = "Show font shadow on spell name"
--[[ zhCN ]] nL["Outline"] = "Outline"
--[[ zhCN ]] nL["Sets the font outline for spell name"] = "Sets the font outline for spell name"

--[[ zhCN ]] nL["Alignment"] = "Alignment"
--[[ zhCN ]] nL["Sets the alignment of the spell name"] = "Sets the alignment of the spell name"

--[[ zhCN ]] nL["Position"] = "Position"
--[[ zhCN ]] nL["Adjust spell name position"] = "Adjust spell name position"
--[[ zhCN ]] nL["Left Offset"] = "Left Offset"
--[[ zhCN ]] nL["Sets the offset of the left of the text"] = "Sets the offset of the left of the text"
--[[ zhCN ]] nL["Right Offset"] = "Right Offset"
--[[ zhCN ]] nL["Sets the offset of the right of the text"] = "Sets the offset of the right of the text"
--[[ zhCN ]] nL["Vertical Offset"] = "Vertical Offset"
--[[ zhCN ]] nL["Sets the vertical offset of the text"] = "Sets the vertical offset of the text"

--[[ zhCN ]] nL["Colors"] = "Colors"
--[[ zhCN ]] nL["Sets the spell name colors"] = "Sets the spell name colors"
--[[ zhCN ]] nL["Cast Color"] = "Cast Color"
--[[ zhCN ]] nL["Sets the spell name color during active casting"] = "Sets the spell name color during active casting"
--[[ zhCN ]] nL["Fade Color"] = "Fade Color"
--[[ zhCN ]] nL["Sets the spell name color during cast warning fade"] = "Sets the spell name color during cast warning fade"

--[[ zhCN ]] nL["None"] = "None"
--[[ zhCN ]] nL["Normal"] = "Normal"
--[[ zhCN ]] nL["Thick"] = "Thick"

--[[ zhCN ]] nL["LEFT"] = "LEFT"
--[[ zhCN ]] nL["CENTER"] = "CENTER"
--[[ zhCN ]] nL["RIGHT"] = "RIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftCastWarningSpellNameText"] = "AloftCastWarningSpellNameText"
--[[ zhCN ]] mL["Display spell name on cast warning"] = "Display spell name on cast warning"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningTimeText", function()

-----------------------------------------------------------------------------

--[[ zhCN ]] tL["Spell Time"] = "Spell Time"
--[[ zhCN ]] tL["Cast warning spell time text options"] = "Cast warning spell time text options"
--[[ zhCN ]] tL["Enable"] = "Enable"
--[[ zhCN ]] tL["Show cast warning spell time"] = "Show cast warning spell time"
--[[ zhCN ]] tL["Typeface"] = "Typeface"
--[[ zhCN ]] tL["Spell time typeface options"] = "Spell time typeface options"
--[[ zhCN ]] tL["Font"] = "Font"
--[[ zhCN ]] tL["Sets the font for spell time"] = "Sets the font for spell time"
--[[ zhCN ]] tL["Font Size"] = "Font Size"
--[[ zhCN ]] tL["Sets the font height of the spell time"] = "Sets the font height of the spell time"
--[[ zhCN ]] tL["Font Shadow"] = "Font Shadow"
--[[ zhCN ]] tL["Show font shadow on spell time"] = "Show font shadow on spell time"
--[[ zhCN ]] tL["Outline"] = "Outline"
--[[ zhCN ]] tL["Sets the font outline for spell time"] = "Sets the font outline for spell time"
--[[ zhCN ]] tL["Alignment"] = "Alignment"
--[[ zhCN ]] tL["Sets the alignment of the spell time"] = "Sets the alignment of the spell time"
--[[ zhCN ]] tL["Position"] = "Position"
--[[ zhCN ]] tL["Adjust spell time position"] = "Adjust spell time position"
--[[ zhCN ]] tL["Left Offset"] = "Left Offset"
--[[ zhCN ]] tL["Sets the offset of the left of the text"] = "Sets the offset of the left of the text"
--[[ zhCN ]] tL["Right Offset"] = "Right Offset"
--[[ zhCN ]] tL["Sets the offset of the right of the text"] = "Sets the offset of the right of the text"
--[[ zhCN ]] tL["Vertical Offset"] = "Vertical Offset"
--[[ zhCN ]] tL["Sets the vertical offset of the text"] = "Sets the vertical offset of the text"

--[[ zhCN ]] tL["Colors"] = "Colors"
--[[ zhCN ]] tL["Sets the spell time colors"] = "Sets the spell time colors"
--[[ zhCN ]] tL["Cast Color"] = "Cast Color"
--[[ zhCN ]] tL["Sets the spell time color during active casting"] = "Sets the spell time color during active casting"
--[[ zhCN ]] tL["Fade Color"] = "Fade Color"
--[[ zhCN ]] tL["Sets the spell time color during cast warning fade"] = "Sets the spell time color during cast warning fade"

--[[ zhCN ]] tL["None"] = "None"
--[[ zhCN ]] tL["Normal"] = "Normal"
--[[ zhCN ]] tL["Thick"] = "Thick"

--[[ zhCN ]] tL["LEFT"] = "LEFT"
--[[ zhCN ]] tL["CENTER"] = "CENTER"
--[[ zhCN ]] tL["RIGHT"] = "RIGHT"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhCN ]] mL["AloftCastWarningTimeText"] = "AloftCastWarningTimeText"
--[[ zhCN ]] mL["Display time text on cast warning"] = "Display time text on cast warning"

-----------------------------------------------------------------------------

elseif (locale == "zhTW") then

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] wL["Cast Warning"] = "施法警告"
--[[ zhTW ]] wL["Cast warning options"] = "施法警告設定"

--[[ zhTW ]] wL["Enable"] = "啟用"
--[[ zhTW ]] wL["Show cast warnings on identifiable enemy nameplates"] = "在可識別的敵對名牌上顯示施法警告"
--[[ zhTW ]] wL["Verification Interval"] = "驗證間隔"
--[[ zhTW ]] wL["Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"] = "設定在施法警告驗證執行上的比率;定期地來檢查施法單位來驗證哪種法術扔然在施放(0.0 是盡可能快)"
--[[ zhTW ]] wL["Animated Cast Warning"] = "施法警告動畫"
--[[ zhTW ]] wL["Animate cast warnings as cast bars"] = "施法條的施法警告動畫"
--[[ zhTW ]] wL["Fade Duration"] = "變淡期間"
--[[ zhTW ]] wL["Sets the fade duration of animated cast warnings (0.0 is no fade)"] = "設定施法警告動畫的變淡期間(0.0 是不變淡)"
--[[ zhTW ]] wL["Trade Skills"] = "交易技能"
--[[ zhTW ]] wL["Show cast warnings for trade skills"] = "顯示交易技能的施法警告"
--[[ zhTW ]] wL["Players"] = "玩家"
--[[ zhTW ]] wL["Show cast warnings for players"] = "顯示玩家的施法警告"
--[[ zhTW ]] wL["Friendly Units"] = "友好單位"
--[[ zhTW ]] wL["Show cast warnings for friendly units"] = "顯示友好單位的施法警告"

--[[ zhTW ]] wL["Position"] = "位置"
--[[ zhTW ]] wL["Adjust the cast warning's position"] = "施法警告位置"
--[[ zhTW ]] wL["Left Offset"] = "左偏移"
--[[ zhTW ]] wL["Sets the offset of the left of the cast warning"] = "設定施法警告的左偏移"
--[[ zhTW ]] wL["Right Offset"] = "右偏移"
--[[ zhTW ]] wL["Sets the offset of the right of the cast warning"] = "設定施法警告的右偏移"
--[[ zhTW ]] wL["Vertical Offset"] = "垂直偏移"
--[[ zhTW ]] wL["Sets the vertical offset of the cast warning"] = "設定施法警告的垂直偏移"

--[[ zhTW ]] wL["Height"] = "高度"
--[[ zhTW ]] wL["Sets the height of the cast warning"] = "設定施法警告的高度"

--[[ zhTW ]] wL["Interruptable Cast Warning"] = "可中斷施法警告"
--[[ zhTW ]] wL["Cast warning appearance for interruptable spells"] = "可中斷法術的施法警告外觀"
--[[ zhTW ]] wL["Uninterruptable Cast Warning"] = "不可中斷施法警告"
--[[ zhTW ]] wL["Cast warning appearance for uninterruptable spells"] = "不可中斷法術的施法警告外觀"

--[[ zhTW ]] wL["Cast Warning Color"] = "施法警告顏色"
--[[ zhTW ]] wL["Sets the color of the cast warning"] = "設定施法警告的顏色"
--[[ zhTW ]] wL["Backdrop Color"] = "背景顏色"
--[[ zhTW ]] wL["Sets the backdrop color of the cast warning"] = "設定施法警告的背景顏色"
--[[ zhTW ]] wL["Border Edge Size"] = "邊框邊緣大小"
--[[ zhTW ]] wL["Sets the thickness of the border"] = "設定邊框的厚度"
--[[ zhTW ]] wL["Border Inset"] = "邊框崁入"
--[[ zhTW ]] wL["Sets the padding aroundthe border"] = "設定邊框的間距範圍"
--[[ zhTW ]] wL["Border Color"] = "邊框顏色"
--[[ zhTW ]] wL["Sets the border color of the cast warning"] = "設定施法警告的邊框顏色"
--[[ zhTW ]] wL["Border Style"] = "邊框樣式"
--[[ zhTW ]] wL["Sets the style of the cast warning border"] = "設定施法警告的邊框樣式"
--[[ zhTW ]] wL["Texture"] = "材質"
--[[ zhTW ]] wL["Sets the cast warning texture"] = "設定施法警告材質"

--[[ zhTW ]] wL["Cast Warning Alpha Override Enable"] = "施法警告透明度覆蓋啟用"
--[[ zhTW ]] wL["Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "啟用改變啟動施法單位的透明度(在UI載入時需要Aloft透明度模組被啟用"
--[[ zhTW ]] wL["Cast Warning Alpha Override"] = "施法警告透明度覆蓋"
--[[ zhTW ]] wL["Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)"] = "設定改變啟動施法單位的透明度(在UI載入時需要Aloft透明度模組被啟用"

--[[ zhTW ]] wL["Colors"] = "顏色"
--[[ zhTW ]] wL["Customize cast warning colors (based on spell school)"] = "自訂施法警告顏色(根據施法系別)"
--[[ zhTW ]] wL["Default"] = "預設"
--[[ zhTW ]] wL["Sets the default color for cast warnings from unknown schools"] = "設定從未知系別的施法警告的預設顏色"
--[[ zhTW ]] wL["Physical"] = "物理"
--[[ zhTW ]] wL["Sets the color for physical school cast warnings"] = "設定物理系別的施法警告顏色"
--[[ zhTW ]] wL["Holy"] = "神聖"
--[[ zhTW ]] wL["Sets the color for holy school cast warnings"] = "設定神聖系別的施法警告顏色"
--[[ zhTW ]] wL["Fire"] = "火焰"
--[[ zhTW ]] wL["Sets the color for fire school cast warnings"] = "設定火焰系別的施法警告顏色"
--[[ zhTW ]] wL["Nature"] = "自然"
--[[ zhTW ]] wL["Sets the color for nature school cast warnings"] = "設自然聖系別的施法警告顏色"
--[[ zhTW ]] wL["Frost"] = "冰霜"
--[[ zhTW ]] wL["Sets the color for frost school cast warnings"] = "設冰霜聖系別的施法警告顏色"
--[[ zhTW ]] wL["Shadow"] = "暗影"
--[[ zhTW ]] wL["Sets the color for shadow school cast warnings"] = "設定暗影系別的施法警告顏色"
--[[ zhTW ]] wL["Arcane"] = "秘法"
--[[ zhTW ]] wL["Sets the color for arcane school cast warnings"] = "設定秘法系別的施法警告顏色"
--[[ zhTW ]] wL["Healing"] = "治療"
--[[ zhTW ]] wL["Sets the color for healing school cast warnings"] = "設定治療系別的施法警告顏色"

--[[ zhTW ]] wL["Reset to Defaults"] = "重置到預設"
--[[ zhTW ]] wL["Resets all colors to their defaults"] = "重置全部顏色到預設"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftCastWarning"] = "Aloft施法警告"
--[[ zhTW ]] mL["Add cast warnings to Aloft unit nameplates"] = "新增施法警告到Aloft單位名牌"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellIcon", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] iL["Spell Icon"] = "法術圖示"
--[[ zhTW ]] iL["Cast warning spell icon placement options"] = "施法警告法術圖示放置設定"
--[[ zhTW ]] iL["Enable"] = "啟用"
--[[ zhTW ]] iL["Enable cast warning spell icon display on the nameplate"] = "啟用在名牌上的施法警告法術圖示顯示"
--[[ zhTW ]] iL["Position"] = "位置"
--[[ zhTW ]] iL["Adjust cast warning spell icon position"] = "施法警告法術圖示位置"
--[[ zhTW ]] iL["Anchor"] = "錨點"
--[[ zhTW ]] iL["Sets the anchor for the cast warning spell icon"] = "設定施法警告法術圖示的錨點"
--[[ zhTW ]] iL["Anchor To"] = "錨點到"
--[[ zhTW ]] iL["Sets the relative point on the cast warning to anchor the spell icon"] = "設定在施法警告到法術圖示錨點上的相關點"
--[[ zhTW ]] iL["X Offset"] = "X偏移"
--[[ zhTW ]] iL["X offset of the cast warning spell icon"] = "施法警告法術圖示的X偏移"
--[[ zhTW ]] iL["Y Offset"] = "Y偏移"
--[[ zhTW ]] iL["Y offset of the cast warning spell icon"] = "施法警告法術圖示的Y偏移"
--[[ zhTW ]] iL["Size"] = "大小"
--[[ zhTW ]] iL["Size in pixels of the cast warning spell icon"] = "施法警告法術圖示的像素大小"

--[[ zhTW ]] iL["Shield"] = "盾"
--[[ zhTW ]] iL["Shows a shield graphic around an uninterruptable spell icon"] = "在不可中斷法術圖示周圍顯示盾圖形"
--[[ zhTW ]] iL["Enable"] = "啟用"
--[[ zhTW ]] iL["Enables the shield graphic"] = "啟用盾圖形"
--[[ zhTW ]] iL["Style"] = "樣式"
--[[ zhTW ]] iL["Sets the shield graphic style"] = "設定盾圖形樣式"
--[[ zhTW ]] iL["Color"] = "顏色"
--[[ zhTW ]] iL["Sets the shield graphic color"] = "設定盾圖形顏色"

--[[ zhTW ]] iL["SQUARE"] = "正方形"
--[[ zhTW ]] iL["ROUND"] = "圓形"

--[[ zhTW ]] iL["TOPLEFT"] = "上左"
--[[ zhTW ]] iL["TOP"] = "上"
--[[ zhTW ]] iL["TOPRIGHT"] = "上右"
--[[ zhTW ]] iL["LEFT"] = "左"
--[[ zhTW ]] iL["CENTER"] = "中間"
--[[ zhTW ]] iL["RIGHT"] = "右"
--[[ zhTW ]] iL["BOTTOMLEFT"] = "下左"
--[[ zhTW ]] iL["BOTTOM"] = "下"
--[[ zhTW ]] iL["BOTTOMRIGHT"] = "下右"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftCastWarningSpellIcon"] = "Aloft施法警告法術圖示"
--[[ zhTW ]] mL["Display spell icon on cast warning"] = "顯示在施法警告上的法術圖示"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellNameText", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] nL["Spell Name"] = "法術名稱"
--[[ zhTW ]] nL["Cast warning spell name text options"] = "施法警告法術名稱文字設定"

--[[ zhTW ]] nL["Enable"] = "啟用"
--[[ zhTW ]] nL["Show cast warning spell name"] = "顯示施法警告法術名稱"
--[[ zhTW ]] nL["Display Rank"] = "顯示等級"
--[[ zhTW ]] nL["Show cast warning spell rank"] = "顯示施法警告法術等級"
--[[ zhTW ]] nL["Display Min/Max Range"] = "顯示最小/最大範圍"
--[[ zhTW ]] nL["Show cast warning spell minimum/maximum range"] = "顯示施法警告法術最小/最大範圍"
--[[ zhTW ]] nL["Display Outcome"] = "顯示結果"
--[[ zhTW ]] nL["Show cast warning spell outcome"] = "顯示施法警告法術結果"
--[[ zhTW ]] nL["Display Outcome Reason"] = "顯示結果原因"
--[[ zhTW ]] nL["Show cast warning spell outcome reason"] = "顯示施法警告法術結果原因"
--[[ zhTW ]] nL["Display Outcome Reason"] = "顯示結果原因"
--[[ zhTW ]] nL["Show cast warning spell outcome reason (failure type, interrupting spell)"] = "顯示施法警告法術結果原因(失敗類型，可中斷法術)"

--[[ zhTW ]] nL["Typeface"] = "字體"
--[[ zhTW ]] nL["Spell name typeface options"] = "法術名稱字體設定"
--[[ zhTW ]] nL["Font"] = "字型"
--[[ zhTW ]] nL["Sets the font for spell name"] = "設定法術名稱字型"
--[[ zhTW ]] nL["Font Size"] = "字型大小"
--[[ zhTW ]] nL["Sets the font height of the spell name"] = "設定法術名稱的字型高度"
--[[ zhTW ]] nL["Font Shadow"] = "字型陰影"
--[[ zhTW ]] nL["Show font shadow on spell name"] = "在法術名稱上顯示字型陰影"
--[[ zhTW ]] nL["Outline"] = "輪廓"
--[[ zhTW ]] nL["Sets the font outline for spell name"] = "設定法術名稱的字體輪廓"

--[[ zhTW ]] nL["Alignment"] = "對齊"
--[[ zhTW ]] nL["Sets the alignment of the spell name"] = "設定法術名稱的對齊"

--[[ zhTW ]] nL["Position"] = "位置"
--[[ zhTW ]] nL["Adjust spell name position"] = "法術名稱位置"
--[[ zhTW ]] nL["Left Offset"] = "左偏移"
--[[ zhTW ]] nL["Sets the offset of the left of the text"] = "設定文字的左偏移"
--[[ zhTW ]] nL["Right Offset"] = "右偏移"
--[[ zhTW ]] nL["Sets the offset of the right of the text"] = "設定文字的右偏移"
--[[ zhTW ]] nL["Vertical Offset"] = "垂直偏移"
--[[ zhTW ]] nL["Sets the vertical offset of the text"] = "設定文字的垂直偏移"

--[[ zhTW ]] nL["Colors"] = "顏色"
--[[ zhTW ]] nL["Sets the spell name colors"] = "設定法術名稱的顏色"
--[[ zhTW ]] nL["Cast Color"] = "施法顏色"
--[[ zhTW ]] nL["Sets the spell name color during active casting"] = "設定在啟動施法期間法術名稱顏色"
--[[ zhTW ]] nL["Fade Color"] = "變淡顏色"
--[[ zhTW ]] nL["Sets the spell name color during cast warning fade"] = "設定在法術警告變淡期間法術名稱顏色"

--[[ zhTW ]] nL["None"] = "無"
--[[ zhTW ]] nL["Normal"] = "正常"
--[[ zhTW ]] nL["Thick"] = "粗"

--[[ zhTW ]] nL["LEFT"] = "左"
--[[ zhTW ]] nL["CENTER"] = "中間"
--[[ zhTW ]] nL["RIGHT"] = "右"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftCastWarningSpellNameText"] = "Aloft施法警告法術名稱文字"
--[[ zhTW ]] mL["Display spell name on cast warning"] = "顯示在施法警告上的法術名稱"

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningTimeText", function()

-----------------------------------------------------------------------------

--[[ zhTW ]] tL["Spell Time"] = "法術時間"
--[[ zhTW ]] tL["Cast warning spell time text options"] = "施法警告法術時間文字設定"
--[[ zhTW ]] tL["Enable"] = "啟用"
--[[ zhTW ]] tL["Show cast warning spell time"] = "顯示施法警告法術時間"
--[[ zhTW ]] tL["Typeface"] = "字體"
--[[ zhTW ]] tL["Spell time typeface options"] = "法術時間字體設定"
--[[ zhTW ]] tL["Font"] = "字型"
--[[ zhTW ]] tL["Sets the font for spell time"] = "設定法術時間字型"
--[[ zhTW ]] tL["Font Size"] = "字型大小"
--[[ zhTW ]] tL["Sets the font height of the spell time"] = "設定法術時間的字型高度"
--[[ zhTW ]] tL["Font Shadow"] = "字型陰影"
--[[ zhTW ]] tL["Show font shadow on spell time"] = "設定在法術時間上的字型陰影"
--[[ zhTW ]] tL["Outline"] = "輪廓"
--[[ zhTW ]] tL["Sets the font outline for spell time"] = "設定法術時間法術時間的字型輪廓"
--[[ zhTW ]] tL["Alignment"] = "對齊"
--[[ zhTW ]] tL["Sets the alignment of the spell time"] = "設定法術時間法術時間的對齊"
--[[ zhTW ]] tL["Position"] = "位置"
--[[ zhTW ]] tL["Adjust spell time position"] = "法術時間位置"
--[[ zhTW ]] tL["Left Offset"] = "左偏移"
--[[ zhTW ]] tL["Sets the offset of the left of the text"] = "設定文字的左偏移"
--[[ zhTW ]] tL["Right Offset"] = "右偏移"
--[[ zhTW ]] tL["Sets the offset of the right of the text"] = "設定文字的右偏移"
--[[ zhTW ]] tL["Vertical Offset"] = "垂直偏移"
--[[ zhTW ]] tL["Sets the vertical offset of the text"] = "設定文字的垂直偏移"

--[[ zhTW ]] tL["Colors"] = "顏色"
--[[ zhTW ]] tL["Sets the spell time colors"] = "設定法術時間顏色"
--[[ zhTW ]] tL["Cast Color"] = "施法顏色"
--[[ zhTW ]] tL["Sets the spell time color during active casting"] = "設定在啟動施法期間法術時間顏色"
--[[ zhTW ]] tL["Fade Color"] = "變淡顏色"
--[[ zhTW ]] tL["Sets the spell time color during cast warning fade"] = "設定在施法警告變淡期間法術時間顏色"

--[[ zhTW ]] tL["None"] = "無"
--[[ zhTW ]] tL["Normal"] = "正常"
--[[ zhTW ]] tL["Thick"] = "粗"

--[[ zhTW ]] tL["LEFT"] = "左"
--[[ zhTW ]] tL["CENTER"] = "中間"
--[[ zhTW ]] tL["RIGHT"] = "右"

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

--[[ zhTW ]] mL["AloftCastWarningTimeText"] = "Aloft施法警告時間文字"
--[[ zhTW ]] mL["Display time text on cast warning"] = "顯示在施法警告上的時間文字"

-----------------------------------------------------------------------------

end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

AloftLocale.AloftCastWarningOptions = setmetatable(wL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
local wL = nil

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellIcon", function()

-----------------------------------------------------------------------------

AloftLocale.AloftCastWarningSpellIconOptions = setmetatable(iL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
local iL = nil

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellNameText", function()

-----------------------------------------------------------------------------

AloftLocale.AloftCastWarningSpellNameTextOptions = setmetatable(nL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
local nL = nil

-----------------------------------------------------------------------------

end)

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningTimeText", function()

-----------------------------------------------------------------------------

AloftLocale.AloftCastWarningTimeTextOptions = setmetatable(tL, { __index = function(t, k) rawset(t, k, k) error("Aloft: No translation found for '" .. k .. "'") return k end })
local tL = nil

-----------------------------------------------------------------------------

end)

-- ChatFrame7:AddMessage("AloftCastWarningLocale: have all initializers")

-----------------------------------------------------------------------------
