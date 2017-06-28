Aloft "Cast Warning"

DISCLAIMER: this addon is experimental; your results may vary

how does this thing work?

- this addon is heavily reliant on GUIDs (http://www.wowwiki.com/API_UnitGUID) and unitids (http://www.wowwiki.com/UnitId)
- this is packaged as a separate addon (NOT an Aloft "module"), must be explicitly enabled by the user from the Blizzard addon screen, and requires Aloft v2.7.7 (or later) to function properly
- when Aloft is present and configured, this addon will insert its options into Aloft's; these options can be access via the Aloft waterfall, under "Cast Warning"
- the addon requires "identifiable" nameplates; this means the unit owning the nameplate must have either a raid target assignment (i.e. a raid target icon), possess a race/class (i.e. a player), or both
- mouseover or target any unit with an identifiable nameplate, and the addon will "record" that unit's GUID, and associate that GUID with the information required to identify the related nameplate when it becomes visible
- the addon will watch the combat log for all spell cast activity associated with "recorded" GUIDs/units
- when relevant spell cast activity is detected for a recorded GUID/unit with a visible, identifiable nameplate, a "cast warning" for the spell will be displayed on the nameplate
- the "cast warning" for a spell will look like a normal Aloft cast bar (if the "Animate" option is enabled), or like a small full health bar (if the "Animate" option is disabled)
- the player's current target has a dedicated castbar; this addon only operates on units other than the player's current target
- if a "recorded" unit has an active unitid, the addon can determine additional information, specifically whether the spell has been cancelled by the caster
- valid active unitids include the current player's focus target and the target(s) of friendly groupmembers (including pets)

some additional detail:

- for a spell to become "detectable" by the addon, it must first be cast by a unit with an active unitid (as descrived above); from that point forward, the addon will "remember" the spell (see below)
	> this decision was made after experimentation; without this restriction, all sorts of "crap" from the combat log would get tracked, making it harder for the addon to separate the wheat from the chaff
- for efficiency reasons, no effort is currently made to adjust for talents/etc; spell range is reported solely from GetSpellInfo, and the longest detectable cast duration (among the information provided by UnitCastingInfo/UnitChannelInfo/GetSpellInfo) is assumed
- spells must have a cast duration in order to be flagged usefully by this addon (the whole point is to put a visible warning on nameplates so that spells can be interrupted by the player); a scrolling combat text addon (SCT, MSBT, Parrot, etc), can be used to provide additional detail on instant-cast activity
- "recorded" GUIDs and nameplate identification information time out after a while (about 3 minutes, refreshed as mouseover/target activity occurs); under pathological circumstances (i.e. simply leaving combat log range), it can be impossible to determine when a GUID/etc is no longer valid/useful, so some mechanism is required to get rid of obsolete tracking information
	> TODO: delete this information when nameplates go out of range; delete this information when the associated unit "dies"; both of these optimizations should be possible
- if a nameplate goes out of range or otherwise becomes "invisible", it should be moused over or targeted again to insure a record of the owning unit's GUID and the associated nameplate identification information
- cancelling a spell is not flagged to the combat log except for the caster, so in some cases (i.e. if there is no active unitid, and/or if "Animate" is disabled; see below) the addon has to assume the full duration of the cast, and will operate accordingly
	> this means the cast warning could remain visible, and/or continue to be animated as if the spell were still being cast, even when the spell has been cancelled by the caster
- enemy players possess nameplates only when they are flagged for PvP, therefore enemy players will display cast warnings only when they are flagged for PvP
- the cast warning bar will be colored based on spell school
	> spell "school colors" are exposed as options by the addon (based on values provided by Blizzard's standard combat log), so the user can customize them
	> hybrid schools like "shadowfrost" are not treated as separate schools, they are combined with "pure" schools (i.e. "shadowfrost" displays as "shadow")
		- TODO: these can be treated as separate schools, if enough users want this; however, colors for these schools would be needed, and too many colors make my head hurt
	> Blizzard does not currently provide any direct mechanism for simply querying the school of a spell (i.e. GetSpellInfo does not include this information, for some inscrutable reason); this school information appears only in certain combat log events
	> the addon must "learn" spell school information by watching spell cast activity by targeted unitids, and it must connect this school information with additional information collected when spell casting starts
	> non-damage spells (summons, heals, etc) do not have an explicit/detectable spell school of any sort; healing is, however, reported explicitly in the combat log, so a "pseudo-school" is included in the addon for healing spells
	> this "learned" information is stored in the addon's Saved Variables file, so that it can be referenced in future sessions
	> this "learning" process could take a little time
	> until/unless the addon observes a spell doing damage (or healing), it will be colored as a cast warning using the "Default" school color
	> things like summons never do damage (nor heal), and will always be colored using the "Default" school color; auras are typically instant cast (and will typically not be relevant)

various options and their purposes/effects:

- disabling the option "Animated" will result in the addon displaying a simple full-width bar on the nameplate, which will disappear when the full cast duration of the spell expires
	> this is intended for the purpose of "efficiency" in crowded situations
	> this saves the addon the overhead of checking regularly to see if the spell has been cancelled by the caster
	> this saves the addon the overhead of graphically animating a cast bar
- the addon option "Trade Skills" controls whether cast warnings are displayed for trade skills (disabled by default)
- the addon option "Players" controls whether cast warnings are displayed for player characters (enabled by default)
- the addon option "Friendly Units" controls whether cast warnings are displayed for friendly units (disabled by default)
- to restrict the addon to tracking enemy players only, enable "Players" and disable "Friendly Units" (this is the default configuration)
- the addon option "Verification Interval" controls how often the addon checks to see whether the spell has been cancelled by the caster
	> this option is ignored unless "Animated" is enabled; remember that the purpose of disabling "Animated" is to reduce the addon's workload, improve "efficiency", etc
- the addon option "Fade Duration" enables a slow fadeout of the cast warning bar once the spell being cast has completed
	> this option is ignored unless "Animated" is enabled; setting this to 0.0 makes the cast warning disappear as soon as the spell has finished casting
- additional options under "Spell Name Text" control what textual information about a spell is displayed
	> this information includes: spell name, spell rank, spell range, spell outcome (success, failed, interrupted, etc), and in certain failure/interrupt cases, the reason for failure/interrupt
	> only spell name is enabled by default (space on the cast warning can be limited)
- the addon options "Spell Icon" and "Spell Time" are considered self-explanatory (look at the tooltips for these options)

- the main Aloft addon carries presets for this module, under the "Acapela" preset; this puts the cast warning in the same location as the target cast bar; NOTE: there is no way to apply these presets selectively

other relevant references to underlying mechanics (if you are interested, and there is information you feel might be relevant to what the addon displays):

GetSpellInfo - http://www.wowwiki.com/API_GetSpellInfo
UnitCastingInfo - http://www.wowwiki.com/API_UnitCastingInfo
UnitChannelInfo - http://www.wowwiki.com/API_UnitChannelInfo (not currently documented, but functionally identical to UnitCastingInfo, only for channeled spells)

feel free to experiment with the addon, and report any breakage, feature requests, and etc via the Aloft comments and/or bug reporting mechanism
please be on watch both for functional defects in the addon, and for any problems with performance/throughput (real or perceived); NOTE: coverage of combat log events is likely not yet complete
when reporting errors of any sort, please be prepared to assist the author in understanding and reproducing the error; an incredibly detailed bug report may not be required, but a dialog with the author may ensue, and will be very important to solving the problem
