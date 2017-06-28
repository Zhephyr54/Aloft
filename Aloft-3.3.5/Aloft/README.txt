This page is best viewed using the WoWI "default" or "dark" theme. Apologies for any inconvenience.
[color="#7f1f1f"]-----[/color]
The following is adapted from the original project description. Disclaimers at the bottom.
[color="#7f1f1f"]-----[/color]
This is a BETA release. Seeking assistance with any/all localizations (deDE, esES, frFR, koKR, ruRU, zhCN, zhTW, any/all others).
[color="#7f1f1f"]-----[/color]

Aloft is an addon that allows you to customize and enchance how nameplates and nameplate casting bars appear in the game. 

[color="#ff0000"][I][B][size=+1]The Aloft FAQ is [url="http://www.wowinterface.com/portal.php?id=460&a=faq"][U]HERE[/U][/url], please review it.[/size] (And please feel free to request additional information/clarification.)[/B][/I][/color]

[B]NOTE:[/B] Aloft 2.8.3 or later is required for WoW 3.2. Aloft 2.8.12 or later is required for WoW 3.3.

Quick answers to current "problems" (see recent Change Log entries for additional details):
[color="#7f1f1f"]-------------------------[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 2.8.15):[/U][/B][/I]
- tried to fix a few problems related to text tags, concatenating opposing conditions, and "attempt to concatenate boolean value" errors; those of you with a lot of custom tags, please report any problems
- added a "[Type]" text tag; returns a string, see AloftTags.rtf
- added an "[IsPlayer]" text tag; returns a boolean (LUA-style, true/not-nil or nol), whether unit is/is-not a friendly player or hostile flagged player
- added an option to "bounce" (toggle) nameplates when AloftAutoShow changes nameplate overlap settings automatically (disabled by default; option under "Overlap Name Plates" options)
- applied a fix to SetFrameLevel() processing to prevent the value from going out of range
- validated with WoW 3.3.2-11403 (02-Feb-2010 in north america)[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 2.8.14):[/U][/B][/I]
- adjusted all frame levels, now relative against the underlying nameplate frame
- applied a blend mode on all texture regions (including backdrops) to "improve" behavior of UI object layering
- latest/greatest CallbackHandler-1.0 (from Ace3)[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 2.8.13):[/U][/B][/I]
- fixed tooltip scraping to locate unit comments and pet owner's names correctly
- fixed problem with target tracking that had broken AloftCastWarning
- attempted fix to LUA recursive loop when encountering "Unknown" units (for those of you who actually encounter "Unknown" units, please help test)[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 2.8.12):[/U][/B][/I]
- intended for WoW 3.3 only; WoW 3.1/3.2 users, please continue using earlier versions
- adjusted tooltip scraping to account for the faction level that now appears on line 2 of all tooltips; not exhaustively tested, watch for bugs
- moved show/hide options entirely to "AloftAutoShow" module (Blizzard offers these as standard UI options in WoW 3.3); these are no longer available through Aloft except via the "AloftAutoShow" module
- enhanced the "AloftAutoShow" options to offer automated control over all the new Blizzard nameplate options (WoW 3.3); includes nameplate overlap; this causes a SavedVariables change, please reconfigure all profiles and watch out for crashes
- enhanced cast bar spell icon processing to explicitly show/hide the icon when the UI shows/hides the cast bar (attempted workaround for Zukuu's problem)
- expanded attempts to handle "Unknown" units, including applying a nameplate health bar color (user options, under "Health Bar>Colors>Unknown" and "Frame>Background>Colors>Unknown"); these changes are untested, and will only work in "enUS" locale
- changed default setting for "Nameplate Glow>Threat Status Colors>Low Threat" from "red" to "green" (to differentiate from Blizzard threat colors)
- updated Acapela preset with new auto-show options[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 2.8.11a):[/U][/B][/I]
- Aloft no longer disables the mouse for "hidden" nameplates; too many unintended side-effects when the WoW client recycles nameplates[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 2.8.11):[/U][/B][/I]
- enhanced Aloft to switch "hidden" nameplates over from zero (0) alpha to "hidden", when combat ends; changed associated Aloft "Visibility" option to "Use Nameplate Alpha In Combat"
- enhanced Aloft to disable the mouse on "hidden" nameplates, when combat ends (works intermittently)
- attempted to apply some fixes (in a few selected places in Aloft) to disable data-gathering on "Unknown" units, as well as updating formerly "Unknown" units when they become known; needs testing (i cannot reproduce these issues)
- switched Aloft's Combat Text module over to use COMBAT_LOG_* events (as opposed to the UNIT_COMBAT event), which allows Aloft to track combat log activity based on UnitGUID, and display combat text on "identifiable" non-target/non-group nameplates (with the usual limitations: unit name must be unique, or the unit must have a raid target assignment, etc)
- added new options to Aloft's Combat Text module to allow additional filtration of combat text display
- aligned the spell school colors used by Aloft's Combat Text module more closely with Blizzard's standard combat log spell colors; please help test to insure that "white damage" actually displays as "white" (or whatever color you have "Combat Text>Colors>Text" set to)
- fixed a defect in UnitID data gathering that was causing group UnitIDs to be updated redundantly
- nameplate glows now recognize changes to stance/form/presence/aura, and update all visible nameplates accordingly, even in combat
- separated Nameplate Glow "invert" logic from Nameplate Glow "explicit low threat" logic, so that they work independently; those of you who "invert" nameplate glows, please help test and tell me if this works "better"
- made the use of "recently damaged" a user option under Nameplate Glow (defaults to false); "recently damaged" is not a generic "in combat" indicator, it really does indicate "recently damaged" (i.e. damaged in what looks like the past 5 seconds); dunno if this is a recent Blizzard change, or if i was confused all along
- updated "Acapela" preset with small changes to alpha settings
- added a visibility filter capability based on unit name (finally identified an "efficient" way to do it); build/maintain your own list of "invisible"/"hidden" unit names, under Aloft's "Visibility>Unit Name" options[/color]
[color="#7f1f1f"]---[/color]
[color="#bf3f7f"][B]Aloft's new [Truncate] text tag[/B]
[I]
Aloft has a new text tag (requested by user EmpireDawn): [B][Truncate][/B].
[/I]
Aloft's [Truncate] tag is not exactly like LibDogTags3.0 (because Aloft's tag syntax is not exactly like LibDogTags3.0). By default, with Aloft's [Truncate] tag, no form of "ellipses" or continuation text is incorporated.

The "canonical" form of this tag is: [B][value:Truncate(number{,string})][/B]

In Aloft's syntax, the "number" argument (the first argument, which is mandatory) specifies the number of characters to truncate "value" to. And if present, the "string" argument (the second argument, which is optional, and must be explicitly specified by the user; there is no default) is appended to the truncated value in the resulting text as a "continuation" or "ellipses" string (to flag that "value" has been truncated). The "string" does not count towards "number".Examples:

[LIST]
[*]["MyName":Truncate(5)] becomes "MyNam"
[*]["MyName":Truncate(5,"...")] becomes "MyNam..."
[/LIST][/color]
[color="#7f1f1f"]---[/color]
[color="#1f9f9f"][B]!!Tag Error!! Problems? Aloft options have disappeared? Aloft Presets not available or not loading properly?[/B]
[I]
A lot of Aloft functionality is now "dynamic" (not loaded by default). Enable this dynamic Aloft functionality via Aloft's "Modules" options. (See the screen shot of Aloft's options on the WoWInterface page for Aloft.)
[/I]
[U]!!Tag Error!! Issues:[/U] If you have "!!Tag Error!!" problems, either enable modules carefully one at a time until the problem(s) goes away, or (especially for custom text tag configurations) look at the document "AloftTags.rtf" (bundled with Aloft, in .../Interface/AddOns/Aloft/AloftTags.rtf), which details which text tags are supplied by which modules. A more detailed procedure is provided below.

[U]Missing Options:[/U] If a module is not enabled, its options will not be present (as if the module was physically absent). If options seem to be missing in Aloft's waterfall, check to see if the associated module is enabled in Aloft's "Modules" options. Enable the module, and its options should appear "on the spot". (Only the AloftLDB module is loaded by default, to save memory.)

[U]Presets:[/U] Aloft "dynamic" modules must be enabled before presets can be applied to them, and the "AloftPresets" module itself must be enabled before presets can be used at all. (the AloftPresets module is disabled by default to save memory.) A more detailed procedure is provided below.

[B][I]!!Tag Error!! procedure[/I][/B], with nameplates displayed/visible:
[LIST]
[*]Enable a module (ideally only one, one at a time), as desired
[*]Inspect visible nameplates, see if one or more "!!Tag Error!!" problems are gone
[*]If not, disable the module again (you probably don't need the module in order to validate a text tag)
[*]Continue by enabling another module...
[*]When complete, reload your UI
[/LIST]
[B][I]Presets procedure[/I][/B]:
[LIST]
[*]Enable all modules (or, for experienced users, just desired modules)
[*]Enable "AloftPresets" module
[*]Select the desired preset
[*]Disable undesired modules
[*]Disable the "AlotPresets" module
[*]Reload your UI (and if it appears you need to engage in "excessive" UI reloading, temporarily disable all other addons except Aloft first)
[*]Adjust the appearance of Aloft, in detail via options for enabled modules, as desired
[*](optional) Save your options as a named profile
[/LIST]
To "goose" Aloft, try to [B][I]Force Rebuilding of Text Tags[/I][/B], with nameplates displayed/visible:
[LIST]
[*]click on the "Regenerate Text Tags" button/option under Aloft's "Modules" options
[*]"cycle" or "bounce" all enemy/friendly nameplates (by disabling/reenabling all visible nameplates via keybindings or Aloft's basic "Show" options at the very top of the options menu)
[/LIST]
Rinse/Repeat any/all of the above, as needed, to arrive at the desired configuration.[/color]
[color="#7f1f1f"]-------------------------[/color]

Options:

[size=+1]"/aloft"[/size]
[size=+1]"/aloft waterfall"[/size]

Direct support for FuBar ([url="http://www.wowace.com/projects/fubar/"]here[/url] and [url="http://wow.curse.com/downloads/wow-addons/details/fubar.aspx"]here[/url]) and LibDataBroker-1.1 are incorporated.

Under WoW 3.0.2 and later, Aloft no longer requires (nor can it even benefit from) external libraries for health estimation (i.e. MobHealth3, LibMobHealth-4.0, MobInfo2) or threat (i.e. Threat-2.0)
[color="#7f1f1f"]-----[/color]
The customization options in Aloft allow you to change the size, shape, anchors, font, font options, textures and colors of:
1. Name text
2. Level Text
3. Health Bar
4. Mana Bar
5. Cast Bar
6. Spell Icon
7. Boss Icon
8. Raid Icon
9. Mouseover Highlight

Aloft also enhances the display by providing options for:
1. Health text - you can display health percentage, health, or health deficit right on the nameplate
2. Spell name - Aloft will place the spell name right on the casting bar
3. Spell casting timer - Displays the remaining casting time
4. Combo Points/Lacerate/Sunder text - Displayed on current target's nameplate for druids (while in the relevant form), rogues, and warriors
5. Recently Damaged icon - Displays an icon next to any unit that has recently taken damage
6. Finer visibility control - A collection of options that give you specific control over which nameplates are shown - eg. You can hide friendly pets, out-of-guild players, and lots more
7. Guild Text - Show guild information right on the nameplate. Shows abbreviated forms by default.
8. Border and backdrop color
9. Comments - Show "Banker", "Flight Master" and other automatically gathered comments, or your own custom ones right on the nameplate
10. Mana Bar/Text - show group member/pet/summon mana, energy, rage
11. Combat Text - display all damage and healing done to group members or targets right on the plate.
12. Pets Owner's Names
13. Polymorph Timer/Shackle Undead/Banish Timer bars
14. Unit Aliases
15. Class Icons
16. Player Titles (PvP, Reputation, and Achievement titles, segregated by prefix or suffix)
17. Experimental: Target-of-target subsystem; see FAQ
18. Keybindings for toggling enemy nameplates, friendly nameplates, and all nameplates
19. Integrated with SharedMedia (for extra fonts and textures: [url="http://www.wowace.com/projects/sharedmedia/"]SharedMedia[/url])

Finally, Aloft (this UPDATED version) provides a full-featured threat indicator capability:
1. Player threat displayed on player target's nameplate (the player has no bar-style nameplate)
2. Group threat (including pets/summons) displayed on group nameplates; see FAQ
3. Threat bar and threat text capabilities
4. Threat bar and threat text can be enabled independently
5. Can be enabled while solo (for pet-owning classes)
6. Control over display colors to indicate common threat and maximum threat thresholds
7. Threat gain threshold display (i.e. omen-style "aggro bar") capability for player threat
8. Threat threshold nameplate "glow" (separate from aggro glow, see below); Threshold can be customized
9. Experiemntal: AOE threat subsystem; threat displayed on hostile nameplates for units other than the player's current/active/primary target; see FAQ

As well, on a related note, Aloft provides:
10. Aggro namplate "glow" (for AOE tanking/etc), replacing the Blizzard native aggro "glow"; Note that aggro glow is completely separate from threat system

NOTE: Aggro nameplate "glow" will only be displayed if the underlying Blizzard "Display->Display Aggro Warning" is enabled for the state you are in (i.e. Always/Party/Instance, etc)
[color="#7f1f1f"]-----[/color]
Other threat addons (thanks to their authors for unknowningly providing example code for Aloft's current threat implementation):
Omen3: [url="http://wow.curse.com/downloads/wow-addons/details/omen-threat-meter.aspx"]Omen[/url]
IceHUD_Threat (now obsolete; primary target threat is a direct feature of IceHUD): [url="http://wow.curse.com/downloads/wow-addons/details/ice-hud.aspx"]IceHUD[/url], [url="http://www.wowinterface.com/downloads/info7773-IceHUDThreat.html"]IceHUD_Threat[/url]
ZThreatMeter (now apparently obsolete): [url="http://www.wowinterface.com/downloads/info10856-ZThreatMeter.html"]ZThreatMeter[/url]
[color="#7f1f1f"]-----[/color]
All of the additional options are written to require no additional overhead if they're not enabled (though they will occupy memory when Aloft is loaded).

Aloft is designed to be easily extensible. All of the functionality is separated into discrete modules which should make it relatively easy for people to tinker with adding their own functionality. 

If you want additional texture options, make sure you install SharedMedia. For additional font options, ClearFont2 and its fontpacks provide a number of extra font choices. 

Documentation for the text tag format is included with the addon (look at the file AloftTag.rtf). Please also look at CREDITS.txt and CHANGELOG.txt for a history of the project.

Aloft is still (again?) a work in progress. Defect reports, feature requests, and code reviews are welcome.

On behalf of all the original contributors, Acapela hopes you enjoy it. 
[color="#7f1f1f"]-----[/color]
DISCLAIMER: Acapela is not the original author of this addon. Please refer to README.txt, CREDITS.txt, and CHANGELOG_WOWACE.txt for more information on the history of Aloft.

Aloft has been updated. It would be branded a "fan update" except the original author(s) have long since vanished, and Aloft is in fact being actively maintained, for the forseable future, by Acapela.

Acapela intends to host the addon here at WoWInterface (SVN and distribution).
NOTE: The addon is not maintained by Acapela at either of WoWAce or CurseForge (though earlier/"original" versions are still available there).
The WoWAce revision on which this version is based is r80814 ([url]http://www.wowace.com/projects/aloft/[/url]; this is WAY out of date, now a WoWAce "obsolete" project; the WoWAce version was not transferred to Curse).

Please report all errors as they are discovered (either in the comments for Aloft here on WoWInterface, or via the WoWInterface bug report mechanism), and Acapela will attempt to resolve them and apply a fix.

Acapela will participate in the forum thread for Aloft at WoWInterface ([url]http://www.wowinterface.com/forums/showthread.php?t=18093[/url]), as well as the commentary associated with the page for the addon itself at WoWInterface.
Acapela will continue to participate in the the original official forum thread at WoWAce ([url]http://forums.wowace.com/showthread.php?t=5437[/url]).
A private message to "acapela" at WoWInterface will also reach him.

Acapela does not want Aloft to die, so Acapela will make every effort to find someone to take over should he find himself unable to continue with this commitment. If anyone would be interested in participating in development, please contact Acapela.

NOTE: Current users of Aloft should backup/delete their .../Interface/Addons/Aloft folder before installing this version of Aloft.
      It would also probably be a good idea, to avoid problems, to backup/delete your .../WTF/Account/<WoWUsername>/SavedVariables/Aloft.lua file as well.
[color="#7f1f1f"]----------[/color]
As always, Aloft is free with your materials, but if you want to donate: [paypal]4257989[/paypal]