local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

local version, build, date, tocversion = GetBuildInfo()

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("AutoShow") then return end

local AloftAutoShow = Aloft:GetModule("AutoShow")
local L = AceLibrary("AceLocale-2.2"):new("AloftAutoShowOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.overlap =
{
	type = 'group',
	name = L["Overlap Name Plates"],
	desc = L["Overlap nameplates"],
	order = 2,
	args =
	{
		optionHeader =
		{
			type = "header",
			name = L["Overlap Options"],
			desc = L["Options controlling auto-overlap"],
			order = 1,
		},
		bounceOverlap =
		{
			type = 'toggle',
			name = L["Bounce Nameplates on Overlap Change"],
			desc = L["Quicky toggle nameplates (bounce) when overlap settings are automatically changed"],
			order = 3,
			get = function() return AloftAutoShow.db.profile.bounceOverlap end,
			set = function(v) AloftAutoShow.db.profile.bounceOverlap = v end,
		},
		all =
		{
			type = 'toggle',
			name = L["Set All"],
			desc = L["Auto-overlap all nameplates"],
			order = 3,
			get = function() return AloftAutoShow.db.profile.allOverlap end,
			set = function(v) AloftAutoShow.db.profile.allOverlap = v AloftAutoShow:SetAllNameplateOverlap(v) AloftAutoShow:ApplyNameplateDisplay() end,
		},
		stateHeader =
		{
			type = "header",
			name = L["Player State"],
			desc = L["Auto-overlap all nameplates based on player state (subject to Visibility options)"],
			order = 4,
		},
		combat =
		{
			type = 'toggle',
			name = L["Combat"],
			desc = L["Auto-overlap all nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 5,
			get = function() return AloftAutoShow.db.profile.overlap.state.combat end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllNameplateOverlap(v) else AloftAutoShow.db.profile.overlap.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			name = L["Flagged/PvP"],
			desc = L["Auto-overlap all nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 6,
			get = function() return AloftAutoShow.db.profile.overlap.state.flagged end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllNameplateOverlap(v) else AloftAutoShow.db.profile.overlap.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			name = L["Resting"],
			desc = L["Auto-overlap all nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 7,
			get = function() return AloftAutoShow.db.profile.overlap.state.resting end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllNameplateOverlap(v) else AloftAutoShow.db.profile.overlap.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			name = L["Group"],
			desc = L["Auto-overlap all nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 8,
			get = function() return AloftAutoShow.db.profile.overlap.state.group end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllNameplateOverlap(v) else AloftAutoShow.db.profile.overlap.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			name = L["Default"],
			desc = L["Auto-overlap all nameplates by default (subject to Visibility options)"],
			order = 9,
			get = function() return AloftAutoShow.db.profile.overlap.state.default end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllNameplateOverlap(v) else AloftAutoShow.db.profile.overlap.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = "header",
			name = L["Player Location"],
			desc = L["Auto-overlap all nameplates based on player location (subject to Visibility options)"],
			order = 10,
		},
		world =
		{
			type = 'toggle',
			name = L["World"],
			desc = L["Auto-overlap all nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 11,
			get = function() return AloftAutoShow.db.profile.overlap.place.world end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllNameplateOverlap(v) else AloftAutoShow.db.profile.overlap.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			name = L["Battleground"],
			desc = L["Auto-overlap all nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 12,
			get = function() return AloftAutoShow.db.profile.overlap.place.battleground end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllNameplateOverlap(v) else AloftAutoShow.db.profile.overlap.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			name = L["Arena"],
			desc = L["Auto-overlap all nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 13,
			get = function() return AloftAutoShow.db.profile.overlap.place.arena end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllNameplateOverlap(v) else AloftAutoShow.db.profile.overlap.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			name = L["5-Man Instance"],
			desc = L["Auto-overlap all nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 14,
			get = function() return AloftAutoShow.db.profile.overlap.place.party end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllNameplateOverlap(v) else AloftAutoShow.db.profile.overlap.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			name = L["Raid Instance"],
			desc = L["Auto-overlap all nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 15,
			get = function() return AloftAutoShow.db.profile.overlap.place.raid end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllNameplateOverlap(v) else AloftAutoShow.db.profile.overlap.place.raid = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
	},
}

Aloft.Options.args.show =
{
	type = 'group',
	name = L["Show Neutral/Enemy Name Plates"],
	desc = L["Show nameplates for neutral or hostile units"],
	order = 3,
	args =
	{
		all =
		{
			type = 'toggle',
			name = L["Set All"],
			desc = L["Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"],
			order = 1,
			get = function() return AloftAutoShow.db.profile.allEnemyEnable end,
			set = function(v) AloftAutoShow.db.profile.allEnemyEnable = v AloftAutoShow:SetAllEnemyNameplateDisplay(v) AloftAutoShow:ApplyNameplateDisplay() end,
		},
		default =
		{
			type = "group",
			name = L["All Nameplates"],
			desc = L["All nameplates"],
			args =
			{
				stateHeader =
				{
					type = "header",
					name = L["Player State"],
					desc = L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"],
					order = 1,
				},
				combat =
				{
					type = 'toggle',
					name = L["Combat"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"],
					order = 2,
					get = function() return AloftAutoShow.db.profile.enemy.state.combat end,
					set = function(v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.state.combat = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				flagged =
				{
					type = 'toggle',
					name = L["Flagged/PvP"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
					order = 3,
					get = function() return AloftAutoShow.db.profile.enemy.state.flagged end,
					set = function(v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.state.flagged = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				resting =
				{
					type = 'toggle',
					name = L["Resting"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
					order = 4,
					get = function() return AloftAutoShow.db.profile.enemy.state.resting end,
					set = function(v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.state.resting = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				group =
				{
					type = 'toggle',
					name = L["Group"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
					order = 5,
					get = function() return AloftAutoShow.db.profile.enemy.state.group end,
					set = function(v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.state.group = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				default =
				{
					type = 'toggle',
					name = L["Default"],
					desc = L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"],
					order = 6,
					get = function() return AloftAutoShow.db.profile.enemy.state.default end,
					set = function(v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.state.default = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				placeHeader =
				{
					type = "header",
					name = L["Player Location"],
					desc = L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"],
					order = 7,
				},
				world =
				{
					type = 'toggle',
					name = L["World"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"],
					order = 8,
					get = function() return AloftAutoShow.db.profile.enemy.place.world end,
					set = function(v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.place.world = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				battleground =
				{
					type = 'toggle',
					name = L["Battleground"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
					order = 9,
					get = function() return AloftAutoShow.db.profile.enemy.place.battleground end,
					set = function(v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.place.battleground = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				arena =
				{
					type = 'toggle',
					name = L["Arena"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"],
					order = 10,
					get = function() return AloftAutoShow.db.profile.enemy.place.arena end,
					set = function(v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.place.arena = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				party =
				{
					type = 'toggle',
					name = L["5-Man Instance"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
					order = 11,
					get = function() return AloftAutoShow.db.profile.enemy.place.party end,
					set = function(v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.place.party = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				raid =
				{
					type = 'toggle',
					name = L["Raid Instance"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"],
					order = 12,
					get = function() return AloftAutoShow.db.profile.enemy.place.raid end,
					set = function(v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.place.raid = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
			},
		},
	},
}

Aloft.Options.args.show.args.pet =
{
	type = "group",
	name = L["Pet Nameplates"],
	desc = L["Pet nameplates"],
	args =
	{
		stateHeader =
		{
			type = "header",
			name = L["Player State"],
			desc = L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"],
				order = 1,
		},
		combat =
		{
			type = 'toggle',
			name = L["Combat"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 2,
			get = function() return AloftAutoShow.db.profile.enemyPet.state.combat end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			name = L["Flagged/PvP"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 3,
			get = function() return AloftAutoShow.db.profile.enemyPet.state.flagged end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			name = L["Resting"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 4,
			get = function() return AloftAutoShow.db.profile.enemyPet.state.resting end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			name = L["Group"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 5,
			get = function() return AloftAutoShow.db.profile.enemyPet.state.group end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			name = L["Default"],
			desc = L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"],
			order = 6,
			get = function() return AloftAutoShow.db.profile.enemyPet.state.default end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = "header",
			name = L["Player Location"],
			desc = L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"],
			order = 7,
		},
		world =
		{
			type = 'toggle',
			name = L["World"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 8,
			get = function() return AloftAutoShow.db.profile.enemyPet.place.world end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			name = L["Battleground"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 9,
			get = function() return AloftAutoShow.db.profile.enemyPet.place.battleground end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			name = L["Arena"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 10,
			get = function() return AloftAutoShow.db.profile.enemyPet.place.arena end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			name = L["5-Man Instance"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 11,
			get = function() return AloftAutoShow.db.profile.enemyPet.place.party end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			name = L["Raid Instance"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 12,
			get = function() return AloftAutoShow.db.profile.enemyPet.place.raid end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.place.raid = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
	},
}

Aloft.Options.args.show.args.guardian =
{
	type = "group",
	name = L["Guardian Nameplates"],
	desc = L["Guardian nameplates"],
	args =
	{
		stateHeader =
		{
			type = "header",
			name = L["Player State"],
			desc = L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"],
			order = 1,
		},
		combat =
		{
			type = 'toggle',
			name = L["Combat"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 2,
			get = function() return AloftAutoShow.db.profile.enemyGuardian.state.combat end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			name = L["Flagged/PvP"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 3,
			get = function() return AloftAutoShow.db.profile.enemyGuardian.state.flagged end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			name = L["Resting"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 4,
			get = function() return AloftAutoShow.db.profile.enemyGuardian.state.resting end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			name = L["Group"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 5,
			get = function() return AloftAutoShow.db.profile.enemyGuardian.state.group end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			name = L["Default"],
			desc = L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"],
			order = 6,
			get = function() return AloftAutoShow.db.profile.enemyGuardian.state.default end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = "header",
			name = L["Player Location"],
			desc = L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"],
			order = 7,
		},
		world =
		{
			type = 'toggle',
			name = L["World"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 8,
			get = function() return AloftAutoShow.db.profile.enemyGuardian.place.world end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			name = L["Battleground"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 9,
			get = function() return AloftAutoShow.db.profile.enemyGuardian.place.battleground end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			name = L["Arena"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 10,
			get = function() return AloftAutoShow.db.profile.enemyGuardian.place.arena end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			name = L["5-Man Instance"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 11,
			get = function() return AloftAutoShow.db.profile.enemyGuardian.place.party end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			name = L["Raid Instance"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 12,
			get = function() return AloftAutoShow.db.profile.enemyGuardian.place.raid end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.place.raid = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
	},
}

Aloft.Options.args.show.args.totem =
{
	type = "group",
	name = L["Totem Nameplates"],
	desc = L["Totem nameplates"],
	args =
	{
		stateHeader =
		{
			type = "header",
			name = L["Player State"],
			desc = L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"],
			order = 1,
		},
		combat =
		{
			type = 'toggle',
			name = L["Combat"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 2,
			get = function() return AloftAutoShow.db.profile.enemyTotem.state.combat end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			name = L["Flagged/PvP"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 3,
			get = function() return AloftAutoShow.db.profile.enemyTotem.state.flagged end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			name = L["Resting"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 4,
			get = function() return AloftAutoShow.db.profile.enemyTotem.state.resting end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			name = L["Group"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 5,
			get = function() return AloftAutoShow.db.profile.enemyTotem.state.group end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			name = L["Default"],
			desc = L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"],
			order = 6,
			get = function() return AloftAutoShow.db.profile.enemyTotem.state.default end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = "header",
			name = L["Player Location"],
			desc = L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"],
			order = 7,
		},
		world =
		{
			type = 'toggle',
			name = L["World"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 8,
			get = function() return AloftAutoShow.db.profile.enemyTotem.place.world end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			name = L["Battleground"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 9,
			get = function() return AloftAutoShow.db.profile.enemyTotem.place.battleground end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			name = L["Arena"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 10,
			get = function() return AloftAutoShow.db.profile.enemyTotem.place.arena end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			name = L["5-Man Instance"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 11,
			get = function() return AloftAutoShow.db.profile.enemyTotem.place.party end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			name = L["Raid Instance"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 12,
			get = function() return AloftAutoShow.db.profile.enemyTotem.place.raid end,
			set = function(v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.place.raid = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
	},
}

Aloft.Options.args.showFriendly =
{
	type = 'group',
	name = L["Show Friendly Name Plates"],
	desc = L["Show nameplates for friendly units"],
	order = 4,
	args =
	{
		all =
		{
			type = 'toggle',
			name = L["Set All"],
			desc = L["Auto-show/hide all friendly nameplates (subject to Visibility options)"],
			order = 1,
			get = function() return AloftAutoShow.db.profile.allFriendEnable end,
			set = function(v) AloftAutoShow.db.profile.allFriendEnable = v AloftAutoShow:SetAllFriendNameplateDisplay(v) AloftAutoShow:ApplyNameplateDisplay() end,
		},
		default =
		{
			type = "group",
			name = L["All Nameplates"],
			desc = L["All nameplates"],
			args =
			{
				stateHeader =
				{
					type = "header",
					name = L["Player State"],
					desc = L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"],
					order = 1,
				},
				combat =
				{
					type = 'toggle',
					name = L["Combat"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"],
					order = 2,
					get = function() return AloftAutoShow.db.profile.friendly.state.combat end,
					set = function(v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.state.combat = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				flagged =
				{
					type = 'toggle',
					name = L["Flagged/PvP"],
					desc = L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
					order = 3,
					get = function() return AloftAutoShow.db.profile.friendly.state.flagged end,
					set = function(v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.state.flagged = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				resting =
				{
					type = 'toggle',
					name = L["Resting"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
					order = 4,
					get = function() return AloftAutoShow.db.profile.friendly.state.resting end,
					set = function(v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.state.resting = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				group =
				{
					type = 'toggle',
					name = L["Group"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
					order = 5,
					get = function() return AloftAutoShow.db.profile.friendly.state.group end,
					set = function(v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.state.group = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				default =
				{
					type = 'toggle',
					name = L["Default"],
					desc = L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"],
					order = 6,
					get = function() return AloftAutoShow.db.profile.friendly.state.default end,
					set = function(v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.state.default = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				placeHeader =
				{
					type = "header",
					name = L["Player Location"],
					desc = L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"],
					order = 7,
				},
				world =
				{
					type = 'toggle',
					name = L["World"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"],
					order = 8,
					get = function() return AloftAutoShow.db.profile.friendly.place.world end,
					set = function(v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.place.world = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				battleground =
				{
					type = 'toggle',
					name = L["Battleground"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
					order = 9,
					get = function() return AloftAutoShow.db.profile.friendly.place.battleground end,
					set = function(v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.place.battleground = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				arena =
				{
					type = 'toggle',
					name = L["Arena"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"],
					order = 10,
					get = function() return AloftAutoShow.db.profile.friendly.place.arena end,
					set = function(v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.place.arena = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				party =
				{
					type = 'toggle',
					name = L["5-Man Instance"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
					order = 11,
					get = function() return AloftAutoShow.db.profile.friendly.place.party end,
					set = function(v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.place.party = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				raid =
				{
					type = 'toggle',
					name = L["Raid Instance"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"],
					order = 12,
					get = function() return AloftAutoShow.db.profile.friendly.place.raid end,
					set = function(v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.place.raid = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
			},
		},
	},
}

Aloft.Options.args.showFriendly.args.pet =
{
	type = "group",
	name = L["Pet Nameplates"],
	desc = L["Pet nameplates"],
	args =
	{
		stateHeader =
		{
			type = "header",
			name = L["Player State"],
			desc = L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"],
			order = 1,
		},
		combat =
		{
			type = 'toggle',
			name = L["Combat"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 2,
			get = function() return AloftAutoShow.db.profile.friendlyPet.state.combat end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			name = L["Flagged/PvP"],
			desc = L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 3,
			get = function() return AloftAutoShow.db.profile.friendlyPet.state.flagged end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			name = L["Resting"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 4,
			get = function() return AloftAutoShow.db.profile.friendlyPet.state.resting end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			name = L["Group"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 5,
			get = function() return AloftAutoShow.db.profile.friendlyPet.state.group end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			name = L["Default"],
			desc = L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"],
			order = 6,
			get = function() return AloftAutoShow.db.profile.friendlyPet.state.default end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = "header",
			name = L["Player Location"],
			desc = L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"],
			order = 7,
		},
		world =
		{
			type = 'toggle',
			name = L["World"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 8,
			get = function() return AloftAutoShow.db.profile.friendlyPet.place.world end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			name = L["Battleground"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 9,
			get = function() return AloftAutoShow.db.profile.friendlyPet.place.battleground end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			name = L["Arena"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 10,
			get = function() return AloftAutoShow.db.profile.friendlyPet.place.arena end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			name = L["5-Man Instance"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 11,
			get = function() return AloftAutoShow.db.profile.friendlyPet.place.party end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			name = L["Raid Instance"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 12,
			get = function() return AloftAutoShow.db.profile.friendlyPet.place.raid end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.place.raid = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
	},
}

Aloft.Options.args.showFriendly.args.guardian =
{
	type = "group",
	name = L["Guardian Nameplates"],
	desc = L["Guardian nameplates"],
	args =
	{
		stateHeader =
		{
			type = "header",
			name = L["Player State"],
			desc = L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"],
			order = 1,
		},
		combat =
		{
			type = 'toggle',
			name = L["Combat"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 2,
			get = function() return AloftAutoShow.db.profile.friendlyGuardian.state.combat end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			name = L["Flagged/PvP"],
			desc = L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 3,
			get = function() return AloftAutoShow.db.profile.friendlyGuardian.state.flagged end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			name = L["Resting"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 4,
			get = function() return AloftAutoShow.db.profile.friendlyGuardian.state.resting end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			name = L["Group"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 5,
			get = function() return AloftAutoShow.db.profile.friendlyGuardian.state.group end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			name = L["Default"],
			desc = L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"],
			order = 6,
			get = function() return AloftAutoShow.db.profile.friendlyGuardian.state.default end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = "header",
			name = L["Player Location"],
			desc = L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"],
			order = 7,
		},
		world =
		{
			type = 'toggle',
			name = L["World"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 8,
			get = function() return AloftAutoShow.db.profile.friendlyGuardian.place.world end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			name = L["Battleground"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 9,
			get = function() return AloftAutoShow.db.profile.friendlyGuardian.place.battleground end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			name = L["Arena"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 10,
			get = function() return AloftAutoShow.db.profile.friendlyGuardian.place.arena end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			name = L["5-Man Instance"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 11,
			get = function() return AloftAutoShow.db.profile.friendlyGuardian.place.party end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			name = L["Raid Instance"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 12,
			get = function() return AloftAutoShow.db.profile.friendlyGuardian.place.raid end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.place.raid = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
	},
}

Aloft.Options.args.showFriendly.args.totem =
{
	type = "group",
	name = L["Totem Nameplates"],
	desc = L["Totem nameplates"],
	args =
	{
		stateHeader =
		{
			type = "header",
			name = L["Player State"],
			desc = L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"],
			order = 1,
		},
		combat =
		{
			type = 'toggle',
			name = L["Combat"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 2,
			get = function() return AloftAutoShow.db.profile.friendlyTotem.state.combat end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			name = L["Flagged/PvP"],
			desc = L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 3,
			get = function() return AloftAutoShow.db.profile.friendlyTotem.state.flagged end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			name = L["Resting"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 4,
			get = function() return AloftAutoShow.db.profile.friendlyTotem.state.resting end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			name = L["Group"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 5,
			get = function() return AloftAutoShow.db.profile.friendlyTotem.state.group end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			name = L["Default"],
			desc = L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"],
			order = 6,
			get = function() return AloftAutoShow.db.profile.friendlyTotem.state.default end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = "header",
			name = L["Player Location"],
			desc = L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"],
			order = 7,
		},
		world =
		{
			type = 'toggle',
			name = L["World"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 8,
			get = function() return AloftAutoShow.db.profile.friendlyTotem.place.world end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			name = L["Battleground"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 9,
			get = function() return AloftAutoShow.db.profile.friendlyTotem.place.battleground end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			name = L["Arena"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 10,
			get = function() return AloftAutoShow.db.profile.friendlyTotem.place.arena end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			name = L["5-Man Instance"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 11,
			get = function() return AloftAutoShow.db.profile.friendlyTotem.place.party end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			name = L["Raid Instance"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 12,
			get = function() return AloftAutoShow.db.profile.friendlyTotem.place.raid end,
			set = function(v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.place.raid = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
	},
}

-----------------------------------------------------------------------------

end)
