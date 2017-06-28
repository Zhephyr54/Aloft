This page is best viewed using the WoWI "default" or "dark" theme. Apologies for any inconvenience.
[color="#7f1f1f"]-----[/color]
The following is adapted from the original project description. Disclaimers at the bottom.
[color="#7f1f1f"]-----[/color]
This is a BETA release. Seeking assistance with any/all localizations (deDE, esES, frFR, koKR, ruRU, zhCN, zhTW, any/all others).
[color="#7f1f1f"]-----[/color]
Aloft is an addon that allows you to customize and enchance how nameplates and nameplate casting bars appear in the game. 

[color="#ff0000"][I][B][size=+1]Aloft is now an Ace3 addon. Please delete any Aloft-2.X.X version completely before installing any Aloft-3.X.X/Aloft-4.X.X version. Your saved variables should be compatible.[/size][/B][/I][/color]

(Thanks to all who helped test the Ace3 version.)

[color="#ff0000"][I][B][size=+1]The Aloft FAQ is [url="http://www.wowinterface.com/portal.php?id=460&a=faq"][U]HERE[/U][/url], please review it.[/size] (And please feel free to request additional information/clarification.)[/B][/I][/color]

[B]NOTE:[/B] The current production release is Aloft-4.0.2 (Ace3), for WoW 4.X (Cataclysm Beta, and North American live realms as of 2010/10/12). Aloft-3.2.2 (Ace3) is still available for WoW 3.X. Aloft 2.8.3 (Ace2) or later is required for WoW 3.2. Some older versions may or may not still be available; send a PM to Acapela for older versions, and include your email address.

[B]NOTE:[/B] The most recent version of [url="http://www.wowinterface.com/downloads/info12959-AloftCastWarningBeta.html"]AloftCastWarning[/url] (AloftCastWarning-1.0.5-1871) is already compatible with WoW 4.X (and Aloft-4.X.X); currently, it appears that no changes to AloftCastWarning will be needed for WoW 4.X (other than a TOC update).

Quick answers to current "problems" (see recent Change Log entries for additional details):
[color="#7f1f1f"]-------------------------[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 4.4.2):[/U][/B][/I]
- AloftCastWarning spellId database is now a "global" (whole account) structure, rather than per-realm
- merged in zhTW localization contributed by WoWInterface user aa9012456
- fixed a few small intermittent LUA errors triggered during module enable
- updated LibBabbleFaction-3.0 to latest/greatest (4.2-release16)
- updated Ace3 to latest/greatest (r1039)[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 4.4.1):[/U][/B][/I]
- fixed problem wih TagCompiler-2.0 (that was introduced in Aloft-4.3.6)
- fixed (subtle) problem with class colors in name text; please watch for side-effects (related to text tags)
- updated LibBabble-Faction-3.0 to latest/greatest (4.2-release1)
- updated Ace3 to latest/greatest (1035)[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 4.4.0):[/U][/B][/I]
- updated to new WoW 4.2 COMBAT_LOG_EVENT_UNFILTERED event format
- added [GroupTargetGUIDCount] tag, to provide an accurate group target count on the player's current target, verified by target GUID
- fixed a small problem in TagCompiler-2.0 (please help watch for side effects in tag syntax)
- updated Ace3 to latest/greatest (r1029)[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 4.3.5):[/U][/B][/I]
- implemented "class" icons on totem nameplates (using spell icons controlled via the AloftClassIcon module).
- enhanced to allow the user to select whether cast/threat bars should be updated "incrementally" (for those not experiencing "malformed borders")
- adjusted usage of PlaceFrame() to facilitate interactive changes to text element typefaces
- fixed typo in AloftVisibilityLocale "ruRU" localization (reported by d07.RiV)
- increased frame delay slightly on frame initialiation, to facilitate PlateBuffs placement (still seeing a few placement artifacts)[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 4.3.4):[/U][/B][/I]
- added a check to AloftRoster UNIT_PET handling, to filter out hostile unitids ("boss[1-4]")
- beefed up name initialization (trying to fix the "no unit name" problem)
- refactored nameplate OnShow/OnUpdate processing, to insure that the Aloft:OnNameplateShow internal event is propagated correctly (trying to fix the "no unit name" problem)
- thanks to Decabah for sharing his/her Aloft shared variables file[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 4.3.3):[/U][/B][/I]
- fixed another problem with non-enUS localizations, in .../Aloft/Aloft/AloftThreatLocale.lua (reported by soso15)
- fixed a problem with AloftRoster trying to access old Ace2 error reporting infrastructure (reported by Myster)
- updated Ace3 to latest/greatest (r1028)[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 4.3.2):[/U][/B][/I]
- routed all cast bar progress through the same processing (involving UnitCastingInfo()/UnitChannelInfo(); still TODO: try restoring the Blizzard cast bar
- fixed a problem preventing the cast bar spell icon from showing in configuration mode
- refactored AloftCastWarning subsystem heavily to regain cast warning bar correctly on target changes
- refactored AloftCastWarning subsystem to handle channeled spell event stream and progress timing correctly; looks like the Blizzard event stream may have changed slightly
- fixed a problem with non-enUS localizations, in .../Aloft/Aloft/AloftLocale.lua, that was preventing Aloft's configuration menu system from loading (reported by StingerSoft and numerous others)
- updated LibBabbleFaction-3.0 to latest/greatest (4.1-release1)
- updated Ace3 to latest/greatest (Release-r1025)[/color]
[color="#ff3f3f"][I][B][U]Recent Changes (Aloft 4.3.1):[/U][/B][/I]
- added a frame delay to nameplate level initialization
- increased frame delay slightly on state icon initialization (state icon may be reanchored after OnShow)
- explicitly nullified frame level for bosses (with "bosses", Blizzard simply hides the underlying default nameplate level text region, and its content may be randomly initialized, or never initialized)
- updated to Ace3 latest/greatest (r1023)[/color]
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
[size=+1]"/aloft gui"[/size]

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