local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.Aloft
if not L then return end

local BL = LOCALIZED_CLASS_NAMES_MALE -- from FrameXML/Constants.lua; TODO: enhance to make these gender-specific?
if not BL then return end

local N = L["Aloft"] .. "-" .. Aloft.version

-----------------------------------------------------------------------------
-- merge into the existing options table
Aloft.Options.args.basic =
{
	type = 'group',
	-- childGroups = "tab",
	order = 0,
	name = L["Aloft"],
	desc = L["Aloft"],
	disabled = function(i) return not Aloft:IsEnabled() or not Aloft.db or not Aloft.db.profile end,
	args =
	{
		enableConfigMode =
		{
			type = 'toggle',
			width = "full",
			name = L["Enable Configuration Mode"],
			desc = L["Enable Configuration Mode"],
			get = function(i) return Aloft.db.profile.configMode end,
			set = function(i, v) Aloft.db.profile.configMode = v Aloft:SendMessage("Aloft:OnConfigModeChanged") end,
			order = 1,
		},
		enableStartMessage =
		{
			type = 'toggle',
			width = "full",
			name = L["Enable Startup Message"],
			desc = L["Enable Startup Message"],
			get = function(i) return Aloft.db.profile.startMessageEnable end,
			set = function(i, v) Aloft.db.profile.startMessageEnable = v end,
			order = 2,
		},
		--[[ TODO: dead code, delete after testing
		enableBloatTest =
		{
			type = 'toggle',
			width = "full",
			name = L["Enable \"bloattest\""],
			desc = L["Perform \"/console bloattest 1\" at startup"],
			get = function(i) return Aloft.db.profile.enableBloatTest end,
			set = function(i, v) Aloft.db.profile.enableBloatTest = v Aloft:ApplyBloatTest() end,
			order = 2,
		},
		]]
		interval =
		{
			type = 'range',
			width = 'full',
			name = L["Nameplate Initialization Interval"],
			desc = L["The amount of time, in seconds, between proactive attempts to detect nameplates that are not yet visible (0.0 is as fast as possible; CAREFUL!)"],
			order = 7,
			min = 0.0,
			max = 5.0,
			step = 0.01,
			disabled = function(i) return not Aloft:IsEnabled() or not Aloft.db or not Aloft.db.profile end,
			get = function(i) return Aloft.db.profile.interval end,
			set = function(i, v) Aloft.db.profile.interval = v Aloft:InitializeTimer() Aloft:DetermineDataSources() end,
		},
		classColors =
		{
			type = 'group',
			name = L["Class Colors"],
			desc = L["Customize class colors"],
			disabled = function(i) return not Aloft:IsEnabled() or not Aloft.db or not Aloft.db.profile end,
			order = 9,
			args =
			{
				druid =
				{
					type = 'color',
					width = "full",
					name = BL["DRUID"],
					desc = BL["DRUID"] .. " " .. L["class color"],
					get = function(i) return unpack(Aloft.db.profile.classColors["DRUID"]) end,
					set = function(i, r, g, b) Aloft.db.profile.classColors["DRUID"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				hunter =
				{
					type = 'color',
					width = "full",
					name = BL["HUNTER"],
					desc = BL["HUNTER"] .. " " .. L["class color"],
					get = function(i) return unpack(Aloft.db.profile.classColors["HUNTER"]) end,
					set = function(i, r, g, b) Aloft.db.profile.classColors["HUNTER"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				mage =
				{
					type = 'color',
					width = "full",
					name = BL["MAGE"],
					desc = BL["MAGE"] .. " " .. L["class color"],
					get = function(i) return unpack(Aloft.db.profile.classColors["MAGE"]) end,
					set = function(i, r, g, b) Aloft.db.profile.classColors["MAGE"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				paladin =
				{
					type = 'color',
					width = "full",
					name = BL["PALADIN"],
					desc = BL["PALADIN"] .. " " .. L["class color"],
					get = function(i) return unpack(Aloft.db.profile.classColors["PALADIN"]) end,
					set = function(i, r, g, b) Aloft.db.profile.classColors["PALADIN"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				priest =
				{
					type = 'color',
					width = "full",
					name = BL["PRIEST"],
					desc = BL["PRIEST"] .. " " .. L["class color"],
					get = function(i) return unpack(Aloft.db.profile.classColors["PRIEST"]) end,
					set = function(i, r, g, b) Aloft.db.profile.classColors["PRIEST"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				rogue =
				{
					type = 'color',
					width = "full",
					name = BL["ROGUE"],
					desc = BL["ROGUE"] .. " " .. L["class color"],
					get = function(i) return unpack(Aloft.db.profile.classColors["ROGUE"]) end,
					set = function(i, r, g, b) Aloft.db.profile.classColors["ROGUE"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				shaman =
				{
					type = 'color',
					width = "full",
					name = BL["SHAMAN"],
					desc = BL["SHAMAN"] .. " " .. L["class color"],
					get = function(i) return unpack(Aloft.db.profile.classColors["SHAMAN"]) end,
					set = function(i, r, g, b) Aloft.db.profile.classColors["SHAMAN"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				warlock =
				{
					type = 'color',
					width = "full",
					name = BL["WARLOCK"],
					desc = BL["WARLOCK"] .. " " .. L["class color"],
					get = function(i) return unpack(Aloft.db.profile.classColors["WARLOCK"]) end,
					set = function(i, r, g, b) Aloft.db.profile.classColors["WARLOCK"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				warrior =
				{
					type = 'color',
					width = "full",
					name = BL["WARRIOR"],
					desc = BL["WARRIOR"] .. " " .. L["class color"],
					get = function(i) return unpack(Aloft.db.profile.classColors["WARRIOR"]) end,
					set = function(i, r, g, b) Aloft.db.profile.classColors["WARRIOR"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				deathknight =
				{
					type = 'color',
					width = "full",
					name = BL["DEATHKNIGHT"],
					desc = BL["DEATHKNIGHT"] .. " " .. L["class color"],
					get = function(i) return unpack(Aloft.db.profile.classColors["DEATHKNIGHT"]) end,
					set = function(i, r, g, b) Aloft.db.profile.classColors["DEATHKNIGHT"] = { r, g, b } Aloft:DetermineDataSources() end
				},
				reset =
				{
					type = 'execute',
					width = "full",
					name = L["Reset to Defaults"],
					desc = L["Resets all colors to their defaults"],
					order = -1,
					func  = function(i)
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
	},
}

-----------------------------------------------------------------------------

-- merge into the existing options table
Aloft.Options.args.data =
{
	type = 'group',
	name = L["Data Options"],
	desc = L["Data options"],
	order = 600,
	disabled = function(i) return not next(Aloft.Options.args.data.args) end,
	args = { }, -- placeholder
}

-----------------------------------------------------------------------------
