local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftOptions")
local BL = LOCALIZED_CLASS_NAMES_MALE -- from FrameXML/Constants.lua; TODO: enhance to make these gender-specific?

-----------------------------------------------------------------------------

Aloft.Options =
{
	handler = Aloft,
	type = 'group',
	args =
	{
		enableStartMessage =
		{
			type = 'toggle',
			name = L["Enable Startup Message"],
			desc = L["Enable Startup Message"],
			get = function() return Aloft.db.profile.startMessageEnable end,
			set = function(v) Aloft.db.profile.startMessageEnable = v end,
			order = 1,
		},
		classColors =
		{
			type = 'group',
			name = L["Class Colors"],
			desc = L["Customize class colors"],
			args =
			{
				druid =
				{
					type = 'color',
					name = BL["DRUID"],
					desc = BL["DRUID"] .. " " .. L["class color"],
					get = function() return unpack(Aloft.db.profile.classColors["DRUID"]) end,
					set = function(r, g, b) Aloft.db.profile.classColors["DRUID"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				hunter =
				{
					type = 'color',
					name = BL["HUNTER"],
					desc = BL["HUNTER"] .. " " .. L["class color"],
					get = function() return unpack(Aloft.db.profile.classColors["HUNTER"]) end,
					set = function(r, g, b) Aloft.db.profile.classColors["HUNTER"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				mage =
				{
					type = 'color',
					name = BL["MAGE"],
					desc = BL["MAGE"] .. " " .. L["class color"],
					get = function() return unpack(Aloft.db.profile.classColors["MAGE"]) end,
					set = function(r, g, b) Aloft.db.profile.classColors["MAGE"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				paladin =
				{
					type = 'color',
					name = BL["PALADIN"],
					desc = BL["PALADIN"] .. " " .. L["class color"],
					get = function() return unpack(Aloft.db.profile.classColors["PALADIN"]) end,
					set = function(r, g, b) Aloft.db.profile.classColors["PALADIN"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				priest =
				{
					type = 'color',
					name = BL["PRIEST"],
					desc = BL["PRIEST"] .. " " .. L["class color"],
					get = function() return unpack(Aloft.db.profile.classColors["PRIEST"]) end,
					set = function(r, g, b) Aloft.db.profile.classColors["PRIEST"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				rogue =
				{
					type = 'color',
					name = BL["ROGUE"],
					desc = BL["ROGUE"] .. " " .. L["class color"],
					get = function() return unpack(Aloft.db.profile.classColors["ROGUE"]) end,
					set = function(r, g, b) Aloft.db.profile.classColors["ROGUE"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				shaman =
				{
					type = 'color',
					name = BL["SHAMAN"],
					desc = BL["SHAMAN"] .. " " .. L["class color"],
					get = function() return unpack(Aloft.db.profile.classColors["SHAMAN"]) end,
					set = function(r, g, b) Aloft.db.profile.classColors["SHAMAN"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				warlock =
				{
					type = 'color',
					name = BL["WARLOCK"],
					desc = BL["WARLOCK"] .. " " .. L["class color"],
					get = function() return unpack(Aloft.db.profile.classColors["WARLOCK"]) end,
					set = function(r, g, b) Aloft.db.profile.classColors["WARLOCK"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				warrior =
				{
					type = 'color',
					name = BL["WARRIOR"],
					desc = BL["WARRIOR"] .. " " .. L["class color"],
					get = function() return unpack(Aloft.db.profile.classColors["WARRIOR"]) end,
					set = function(r, g, b) Aloft.db.profile.classColors["WARRIOR"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				deathknight =
				{
					type = 'color',
					name = BL["DEATHKNIGHT"],
					desc = BL["DEATHKNIGHT"] .. " " .. L["class color"],
					get = function() return unpack(Aloft.db.profile.classColors["DEATHKNIGHT"]) end,
					set = function(r, g, b) Aloft.db.profile.classColors["DEATHKNIGHT"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				reset =
				{
					type = "execute",
					name = L["Reset to Defaults"],
					desc = L["Resets all colors to their defaults"],
					order = -1,
					func  = function()
								local colors = Aloft.db.profile.classColors
								colors["DRUID"]			= { RAID_CLASS_COLORS["DRUID"].r,			RAID_CLASS_COLORS["DRUID"].g,		RAID_CLASS_COLORS["DRUID"].b, }
								colors["HUNTER"]		= { RAID_CLASS_COLORS["HUNTER"].r,			RAID_CLASS_COLORS["HUNTER"].g,		RAID_CLASS_COLORS["HUNTER"].b, }
								colors["MAGE"]			= { RAID_CLASS_COLORS["MAGE"].r,			RAID_CLASS_COLORS["MAGE"].g,		RAID_CLASS_COLORS["MAGE"].b, }
								colors["PALADIN"]		= { RAID_CLASS_COLORS["PALADIN"].r,		RAID_CLASS_COLORS["PALADIN"].g,		RAID_CLASS_COLORS["PALADIN"].b, }
								colors["PRIEST"]		= { RAID_CLASS_COLORS["PRIEST"].r,			RAID_CLASS_COLORS["PRIEST"].g,		RAID_CLASS_COLORS["PRIEST"].b, }
								colors["ROGUE"]			= { RAID_CLASS_COLORS["ROGUE"].r,			RAID_CLASS_COLORS["ROGUE"].g,		RAID_CLASS_COLORS["ROGUE"].b, }
								colors["SHAMAN"]		= { RAID_CLASS_COLORS["SHAMAN"].r,			RAID_CLASS_COLORS["SHAMAN"].g,		RAID_CLASS_COLORS["SHAMAN"].b, }
								colors["WARLOCK"]		= { RAID_CLASS_COLORS["WARLOCK"].r,		RAID_CLASS_COLORS["WARLOCK"].g,		RAID_CLASS_COLORS["WARLOCK"].b, }
								colors["WARRIOR"]		= { RAID_CLASS_COLORS["WARRIOR"].r,		RAID_CLASS_COLORS["WARRIOR"].g,		RAID_CLASS_COLORS["WARRIOR"].b, }
								colors["DEATHKNIGHT"]	= { RAID_CLASS_COLORS["DEATHKNIGHT"].r,	RAID_CLASS_COLORS["DEATHKNIGHT"].g,	RAID_CLASS_COLORS["DEATHKNIGHT"].b, }
								Aloft:DetermineDataSources()
							end,
				},
			},
		},
		moduleSpacer  =
		{
			type = 'header',
			order = 10,
		},
		dataSpacer =
		{
			type = 'header',
			order = 500,
		},
		data =
		{
			type = 'group',
			name = L["Data Options"],
			desc = L["Data options"],
			order = 600,
			disabled = function() return not next(Aloft.Options.args.data.args) end,
			args = { },
		}
	},
}

-----------------------------------------------------------------------------
