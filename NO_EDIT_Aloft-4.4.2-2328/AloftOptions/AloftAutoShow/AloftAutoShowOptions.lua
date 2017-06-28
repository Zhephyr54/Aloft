local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

-- local version, build, date, tocversion = GetBuildInfo()

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftAutoShow", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftAutoShowOptions
if not L then return end

local AloftAutoShow = Aloft:GetModule("AutoShow", true)
if not AloftAutoShow then return end

-----------------------------------------------------------------------------

 -- magic values from the Blizzard default UI CVars for "Nameplate Motion Type"
local motionValues = { }
motionValues[1] = "STACK"
motionValues[2] = "SPREAD"

-----------------------------------------------------------------------------

Aloft.Options.args.motion =
{
	type = 'group',
	name = L["Name Plate Motion"],
	desc = L["Motion of nameplates when they might overlap"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile end,
	order = 2,
	args =
	{
		styleHeader =
		{
			type = "header",
			name = L["Name Plate Motion"],
			desc = L["Motion of nameplates when they might overlap"],
			order = 1,
		},
		bounce =
		{
			type = 'toggle',
			name = L["Bounce Nameplates on Motion Change"],
			desc = L["Quicky toggle nameplates (bounce) when motion settings are automatically changed"],
			order = 2,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile end,
			get = function(i) return AloftAutoShow.db.profile.bounceMotion end,
			set = function(i, v) AloftAutoShow.db.profile.bounceMotion = v end,
		},
		all =
		{
			type = 'toggle',
			width = 'full',
			name = L["Set All"],
			desc = L["Automate all nameplate motion"],
			order = 3,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile end,
			get = function(i) return AloftAutoShow.db.profile.allMotion end,
			set = function(i, v) AloftAutoShow.db.profile.allMotion = v AloftAutoShow:SetAllNameplateMotion(v) AloftAutoShow:ApplyNameplateDisplay() end,
		},
		motionStyle =
		{
			type = 'select',
			style = 'radio',
			width = 'full',
			name = L["Motion Style"],
			desc = L["Motion Style"],
			order = 4,
			get = function(i)
				for k, v in pairs(Aloft.Options.args.motion.args.motionStyle.values) do
					if k == AloftAutoShow.db.profile.motionStyle then
						-- ChatFrame7:AddMessage("Aloft.Options.args.motion.args.motionStyle.get(): " .. tostring(k) .. "/" .. tostring(v) .. "/" .. tostring(AloftAutoShow.db.profile.motionStyle))
						return k
					end
				end
			end,
			set = function(i, v)
				-- ChatFrame7:AddMessage("Aloft.Options.args.motion.args.motionStyle.set(): " .. tostring(v))
				AloftAutoShow.db.profile.motionStyle = v
				AloftAutoShow:ApplyNameplateDisplay()
			end,
			values = motionValues,
		},
		stateHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player State"],
			desc = L["Nameplate motion based on player state (subject to Visibility options)"],
			order = 10,
		},
		combat =
		{
			type = 'toggle',
			width = 'full',
			name = L["Combat"],
			desc = L["Nameplate motion on entering/exiting combat (subject to Visibility options)"],
			order = 11,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.motion end,
			get = function(i) return AloftAutoShow.db.profile.motion.state.combat end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allMotion then AloftAutoShow:SetAllNameplateMotion(v) else AloftAutoShow.db.profile.motion.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			width = 'full',
			name = L["Flagged/PvP"],
			desc = L["Nameplate motion on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 12,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.motion end,
			get = function(i) return AloftAutoShow.db.profile.motion.state.flagged end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allMotion then AloftAutoShow:SetAllNameplateMotion(v) else AloftAutoShow.db.profile.motion.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			width = 'full',
			name = L["Resting"],
			desc = L["Nameplate motion on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 13,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.motion end,
			get = function(i) return AloftAutoShow.db.profile.motion.state.resting end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allMotion then AloftAutoShow:SetAllNameplateMotion(v) else AloftAutoShow.db.profile.motion.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			width = 'full',
			name = L["Group"],
			desc = L["Nameplate motion on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 14,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.motion end,
			get = function(i) return AloftAutoShow.db.profile.motion.state.group end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allMotion then AloftAutoShow:SetAllNameplateMotion(v) else AloftAutoShow.db.profile.motion.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			width = 'full',
			name = L["Default"],
			desc = L["Nameplate motion by default (subject to Visibility options)"],
			order = 15,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.motion end,
			get = function(i) return AloftAutoShow.db.profile.motion.state.default end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allMotion then AloftAutoShow:SetAllNameplateMotion(v) else AloftAutoShow.db.profile.motion.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player Location"],
			desc = L["Nameplate motion based on player location (subject to Visibility options)"],
			order = 20,
		},
		world =
		{
			type = 'toggle',
			width = 'full',
			name = L["World"],
			desc = L["Nameplate motion on entering/exiting the world (subject to Visibility options)"],
			order = 21,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.motion end,
			get = function(i) return AloftAutoShow.db.profile.motion.place.world end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allMotion then AloftAutoShow:SetAllNameplateMotion(v) else AloftAutoShow.db.profile.motion.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			width = 'full',
			name = L["Battleground"],
			desc = L["Nameplate motion on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 22,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.motion end,
			get = function(i) return AloftAutoShow.db.profile.motion.place.battleground end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allMotion then AloftAutoShow:SetAllNameplateMotion(v) else AloftAutoShow.db.profile.motion.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			width = 'full',
			name = L["Arena"],
			desc = L["Nameplate motion on entering/exiting arenas (subject to Visibility options)"],
			order = 23,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.motion end,
			get = function(i) return AloftAutoShow.db.profile.motion.place.arena end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allMotion then AloftAutoShow:SetAllNameplateMotion(v) else AloftAutoShow.db.profile.motion.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			width = 'full',
			name = L["5-Man Instance"],
			desc = L["Nameplate motion on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 24,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.motion end,
			get = function(i) return AloftAutoShow.db.profile.motion.place.party end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allMotion then AloftAutoShow:SetAllNameplateMotion(v) else AloftAutoShow.db.profile.motion.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			width = 'full',
			name = L["Raid Instance"],
			desc = L["Nameplate motion on entering/exiting raid instances (subject to Visibility options)"],
			order = 25,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.motion end,
			get = function(i) return AloftAutoShow.db.profile.motion.place.raid end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allMotion then AloftAutoShow:SetAllNameplateMotion(v) else AloftAutoShow.db.profile.motion.place.raid = v end
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
	disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile end,
	order = 3,
	args =
	{
		all =
		{
			type = 'toggle',
			width = 'full',
			name = L["Set All"],
			desc = L["Auto-show/hide all neutral and hostile nameplates (subject to Visibility options)"],
			order = 1,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile end,
			get = function(i) return AloftAutoShow.db.profile.allEnemyEnable end,
			set = function(i, v) AloftAutoShow.db.profile.allEnemyEnable = v AloftAutoShow:SetAllEnemyNameplateDisplay(v) AloftAutoShow:ApplyNameplateDisplay() end,
		},
		default =
		{
			type = 'group',
			name = L["All Nameplates"],
			desc = L["All nameplates"],
			args =
			{
				stateHeader =
				{
					type = 'header',
					width = 'full',
					name = L["Player State"],
					desc = L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"],
					order = 1,
				},
				combat =
				{
					type = 'toggle',
					width = 'full',
					name = L["Combat"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"],
					order = 2,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemy end,
					get = function(i) return AloftAutoShow.db.profile.enemy.state.combat end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.state.combat = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				flagged =
				{
					type = 'toggle',
					width = 'full',
					name = L["Flagged/PvP"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
					order = 3,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemy end,
					get = function(i) return AloftAutoShow.db.profile.enemy.state.flagged end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.state.flagged = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				resting =
				{
					type = 'toggle',
					width = 'full',
					name = L["Resting"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
					order = 4,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemy end,
					get = function(i) return AloftAutoShow.db.profile.enemy.state.resting end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.state.resting = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				group =
				{
					type = 'toggle',
					width = 'full',
					name = L["Group"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
					order = 5,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemy end,
					get = function(i) return AloftAutoShow.db.profile.enemy.state.group end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.state.group = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				default =
				{
					type = 'toggle',
					width = 'full',
					name = L["Default"],
					desc = L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"],
					order = 6,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemy end,
					get = function(i) return AloftAutoShow.db.profile.enemy.state.default end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.state.default = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				placeHeader =
				{
					type = 'header',
					width = 'full',
					name = L["Player Location"],
					desc = L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"],
					order = 7,
				},
				world =
				{
					type = 'toggle',
					width = 'full',
					name = L["World"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"],
					order = 8,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemy end,
					get = function(i) return AloftAutoShow.db.profile.enemy.place.world end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.place.world = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				battleground =
				{
					type = 'toggle',
					width = 'full',
					name = L["Battleground"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
					order = 9,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemy end,
					get = function(i) return AloftAutoShow.db.profile.enemy.place.battleground end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.place.battleground = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				arena =
				{
					type = 'toggle',
					width = 'full',
					name = L["Arena"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"],
					order = 10,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemy end,
					get = function(i) return AloftAutoShow.db.profile.enemy.place.arena end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.place.arena = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				party =
				{
					type = 'toggle',
					width = 'full',
					name = L["5-Man Instance"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
					order = 11,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemy end,
					get = function(i) return AloftAutoShow.db.profile.enemy.place.party end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemy.place.party = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				raid =
				{
					type = 'toggle',
					width = 'full',
					name = L["Raid Instance"],
					desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"],
					order = 12,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemy end,
					get = function(i) return AloftAutoShow.db.profile.enemy.place.raid end,
					set = function(i, v)
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
	type = 'group',
	name = L["Pet Nameplates"],
	desc = L["Pet nameplates"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile end,
	args =
	{
		stateHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player State"],
			desc = L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"],
				order = 1,
		},
		combat =
		{
			type = 'toggle',
			width = 'full',
			name = L["Combat"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 2,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyPet end,
			get = function(i) return AloftAutoShow.db.profile.enemyPet.state.combat end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			width = 'full',
			name = L["Flagged/PvP"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 3,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyPet end,
			get = function(i) return AloftAutoShow.db.profile.enemyPet.state.flagged end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			width = 'full',
			name = L["Resting"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 4,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyPet end,
			get = function(i) return AloftAutoShow.db.profile.enemyPet.state.resting end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			width = 'full',
			name = L["Group"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 5,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyPet end,
			get = function(i) return AloftAutoShow.db.profile.enemyPet.state.group end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			width = 'full',
			name = L["Default"],
			desc = L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"],
			order = 6,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyPet end,
			get = function(i) return AloftAutoShow.db.profile.enemyPet.state.default end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player Location"],
			desc = L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"],
			order = 7,
		},
		world =
		{
			type = 'toggle',
			width = 'full',
			name = L["World"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 8,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyPet end,
			get = function(i) return AloftAutoShow.db.profile.enemyPet.place.world end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			width = 'full',
			name = L["Battleground"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 9,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyPet end,
			get = function(i) return AloftAutoShow.db.profile.enemyPet.place.battleground end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			width = 'full',
			name = L["Arena"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 10,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyPet end,
			get = function(i) return AloftAutoShow.db.profile.enemyPet.place.arena end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			width = 'full',
			name = L["5-Man Instance"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 11,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyPet end,
			get = function(i) return AloftAutoShow.db.profile.enemyPet.place.party end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			width = 'full',
			name = L["Raid Instance"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 12,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyPet end,
			get = function(i) return AloftAutoShow.db.profile.enemyPet.place.raid end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyPet.place.raid = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
	},
}

Aloft.Options.args.show.args.guardian =
{
	type = 'group',
	name = L["Guardian Nameplates"],
	desc = L["Guardian nameplates"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile end,
	args =
	{
		stateHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player State"],
			desc = L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"],
			order = 1,
		},
		combat =
		{
			type = 'toggle',
			width = 'full',
			name = L["Combat"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 2,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.enemyGuardian.state.combat end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			width = 'full',
			name = L["Flagged/PvP"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 3,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.enemyGuardian.state.flagged end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			width = 'full',
			name = L["Resting"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 4,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.enemyGuardian.state.resting end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			width = 'full',
			name = L["Group"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 5,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.enemyGuardian.state.group end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			width = 'full',
			name = L["Default"],
			desc = L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"],
			order = 6,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.enemyGuardian.state.default end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player Location"],
			desc = L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"],
			order = 7,
		},
		world =
		{
			type = 'toggle',
			width = 'full',
			name = L["World"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 8,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.enemyGuardian.place.world end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			width = 'full',
			name = L["Battleground"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 9,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.enemyGuardian.place.battleground end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			width = 'full',
			name = L["Arena"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 10,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.enemyGuardian.place.arena end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			width = 'full',
			name = L["5-Man Instance"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 11,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.enemyGuardian.place.party end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			width = 'full',
			name = L["Raid Instance"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 12,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.enemyGuardian.place.raid end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyGuardian.place.raid = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
	},
}

Aloft.Options.args.show.args.totem =
{
	type = 'group',
	name = L["Totem Nameplates"],
	desc = L["Totem nameplates"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile end,
	args =
	{
		stateHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player State"],
			desc = L["Auto-show/hide all neutral and hostile nameplates based on player state (subject to Visibility options)"],
			order = 1,
		},
		combat =
		{
			type = 'toggle',
			width = 'full',
			name = L["Combat"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 2,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyTotem end,
			get = function(i) return AloftAutoShow.db.profile.enemyTotem.state.combat end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			width = 'full',
			name = L["Flagged/PvP"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 3,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyTotem end,
			get = function(i) return AloftAutoShow.db.profile.enemyTotem.state.flagged end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			width = 'full',
			name = L["Resting"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 4,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyTotem end,
			get = function(i) return AloftAutoShow.db.profile.enemyTotem.state.resting end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			width = 'full',
			name = L["Group"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 5,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyTotem end,
			get = function(i) return AloftAutoShow.db.profile.enemyTotem.state.group end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			width = 'full',
			name = L["Default"],
			desc = L["Auto-show/hide all neutral and hostile nameplates by default (subject to Visibility options)"],
			order = 6,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyTotem end,
			get = function(i) return AloftAutoShow.db.profile.enemyTotem.state.default end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player Location"],
			desc = L["Auto-show/hide all neutral and hostile nameplates based on player location (subject to Visibility options)"],
			order = 7,
		},
		world =
		{
			type = 'toggle',
			width = 'full',
			name = L["World"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 8,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyTotem end,
			get = function(i) return AloftAutoShow.db.profile.enemyTotem.place.world end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			width = 'full',
			name = L["Battleground"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 9,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyTotem end,
			get = function(i) return AloftAutoShow.db.profile.enemyTotem.place.battleground end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			width = 'full',
			name = L["Arena"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 10,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyTotem end,
			get = function(i) return AloftAutoShow.db.profile.enemyTotem.place.arena end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			width = 'full',
			name = L["5-Man Instance"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 11,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyTotem end,
			get = function(i) return AloftAutoShow.db.profile.enemyTotem.place.party end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allEnemyEnable then AloftAutoShow:SetAllEnemyNameplateDisplay(v) else AloftAutoShow.db.profile.enemyTotem.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			width = 'full',
			name = L["Raid Instance"],
			desc = L["Auto-show/hide all neutral and hostile nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 12,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.enemyTotem end,
			get = function(i) return AloftAutoShow.db.profile.enemyTotem.place.raid end,
			set = function(i, v)
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
	disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile end,
	order = 4,
	args =
	{
		all =
		{
			type = 'toggle',
			width = 'full',
			name = L["Set All"],
			desc = L["Auto-show/hide all friendly nameplates (subject to Visibility options)"],
			order = 1,
			get = function(i) return AloftAutoShow.db.profile.allFriendEnable end,
			set = function(i, v) AloftAutoShow.db.profile.allFriendEnable = v AloftAutoShow:SetAllFriendNameplateDisplay(v) AloftAutoShow:ApplyNameplateDisplay() end,
		},
		default =
		{
			type = 'group',
			width = 'full',
			name = L["All Nameplates"],
			desc = L["All nameplates"],
			args =
			{
				stateHeader =
				{
					type = 'header',
					width = 'full',
					name = L["Player State"],
					desc = L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"],
					order = 1,
				},
				combat =
				{
					type = 'toggle',
					width = 'full',
					name = L["Combat"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"],
					order = 2,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendly end,
					get = function(i) return AloftAutoShow.db.profile.friendly.state.combat end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.state.combat = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				flagged =
				{
					type = 'toggle',
					width = 'full',
					name = L["Flagged/PvP"],
					desc = L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
					order = 3,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendly end,
					get = function(i) return AloftAutoShow.db.profile.friendly.state.flagged end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.state.flagged = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				resting =
				{
					type = 'toggle',
					width = 'full',
					name = L["Resting"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
					order = 4,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendly end,
					get = function(i) return AloftAutoShow.db.profile.friendly.state.resting end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.state.resting = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				group =
				{
					type = 'toggle',
					width = 'full',
					name = L["Group"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
					order = 5,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendly end,
					get = function(i) return AloftAutoShow.db.profile.friendly.state.group end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.state.group = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				default =
				{
					type = 'toggle',
					width = 'full',
					name = L["Default"],
					desc = L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"],
					order = 6,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendly end,
					get = function(i) return AloftAutoShow.db.profile.friendly.state.default end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.state.default = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				placeHeader =
				{
					type = 'header',
					width = 'full',
					name = L["Player Location"],
					desc = L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"],
					order = 7,
				},
				world =
				{
					type = 'toggle',
					width = 'full',
					name = L["World"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"],
					order = 8,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendly end,
					get = function(i) return AloftAutoShow.db.profile.friendly.place.world end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.place.world = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				battleground =
				{
					type = 'toggle',
					width = 'full',
					name = L["Battleground"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
					order = 9,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendly end,
					get = function(i) return AloftAutoShow.db.profile.friendly.place.battleground end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.place.battleground = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				arena =
				{
					type = 'toggle',
					width = 'full',
					name = L["Arena"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"],
					order = 10,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendly end,
					get = function(i) return AloftAutoShow.db.profile.friendly.place.arena end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.place.arena = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				party =
				{
					type = 'toggle',
					width = 'full',
					name = L["5-Man Instance"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
					order = 11,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendly end,
					get = function(i) return AloftAutoShow.db.profile.friendly.place.party end,
					set = function(i, v)
						if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendly.place.party = v end
						AloftAutoShow:ApplyNameplateDisplay()
					end,
				},
				raid =
				{
					type = 'toggle',
					width = 'full',
					name = L["Raid Instance"],
					desc = L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"],
					order = 12,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendly end,
					get = function(i) return AloftAutoShow.db.profile.friendly.place.raid end,
					set = function(i, v)
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
	type = 'group',
	name = L["Pet Nameplates"],
	desc = L["Pet nameplates"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile end,
	args =
	{
		stateHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player State"],
			desc = L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"],
			order = 1,
		},
		combat =
		{
			type = 'toggle',
			width = 'full',
			name = L["Combat"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 2,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyPet end,
			get = function(i) return AloftAutoShow.db.profile.friendlyPet.state.combat end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			width = 'full',
			name = L["Flagged/PvP"],
			desc = L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 3,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyPet end,
			get = function(i) return AloftAutoShow.db.profile.friendlyPet.state.flagged end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			width = 'full',
			name = L["Resting"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 4,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyPet end,
			get = function(i) return AloftAutoShow.db.profile.friendlyPet.state.resting end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			width = 'full',
			name = L["Group"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 5,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyPet end,
			get = function(i) return AloftAutoShow.db.profile.friendlyPet.state.group end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			width = 'full',
			name = L["Default"],
			desc = L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"],
			order = 6,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyPet end,
			get = function(i) return AloftAutoShow.db.profile.friendlyPet.state.default end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player Location"],
			desc = L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"],
			order = 7,
		},
		world =
		{
			type = 'toggle',
			width = 'full',
			name = L["World"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 8,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyPet end,
			get = function(i) return AloftAutoShow.db.profile.friendlyPet.place.world end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			width = 'full',
			name = L["Battleground"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 9,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyPet end,
			get = function(i) return AloftAutoShow.db.profile.friendlyPet.place.battleground end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			width = 'full',
			name = L["Arena"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 10,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyPet end,
			get = function(i) return AloftAutoShow.db.profile.friendlyPet.place.arena end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			width = 'full',
			name = L["5-Man Instance"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 11,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyPet end,
			get = function(i) return AloftAutoShow.db.profile.friendlyPet.place.party end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			width = 'full',
			name = L["Raid Instance"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 12,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyPet end,
			get = function(i) return AloftAutoShow.db.profile.friendlyPet.place.raid end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyPet.place.raid = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
	},
}

Aloft.Options.args.showFriendly.args.guardian =
{
	type = 'group',
	name = L["Guardian Nameplates"],
	desc = L["Guardian nameplates"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile end,
	args =
	{
		stateHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player State"],
			desc = L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"],
			order = 1,
		},
		combat =
		{
			type = 'toggle',
			width = 'full',
			name = L["Combat"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 2,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.friendlyGuardian.state.combat end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			width = 'full',
			name = L["Flagged/PvP"],
			desc = L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 3,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.friendlyGuardian.state.flagged end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			width = 'full',
			name = L["Resting"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 4,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.friendlyGuardian.state.resting end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			width = 'full',
			name = L["Group"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 5,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.friendlyGuardian.state.group end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			width = 'full',
			name = L["Default"],
			desc = L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"],
			order = 6,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.friendlyGuardian.state.default end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player Location"],
			desc = L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"],
			order = 7,
		},
		world =
		{
			type = 'toggle',
			width = 'full',
			name = L["World"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 8,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.friendlyGuardian.place.world end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			width = 'full',
			name = L["Battleground"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 9,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.friendlyGuardian.place.battleground end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			width = 'full',
			name = L["Arena"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 10,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.friendlyGuardian.place.arena end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			width = 'full',
			name = L["5-Man Instance"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 11,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.friendlyGuardian.place.party end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			width = 'full',
			name = L["Raid Instance"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 12,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyGuardian end,
			get = function(i) return AloftAutoShow.db.profile.friendlyGuardian.place.raid end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyGuardian.place.raid = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
	},
}

Aloft.Options.args.showFriendly.args.totem =
{
	type = 'group',
	name = L["Totem Nameplates"],
	desc = L["Totem nameplates"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile end,
	args =
	{
		stateHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player State"],
			desc = L["Auto-show/hide all friendly nameplates based on player state (subject to Visibility options)"],
			order = 1,
		},
		combat =
		{
			type = 'toggle',
			width = 'full',
			name = L["Combat"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting combat (subject to Visibility options)"],
			order = 2,
			get = function(i) return AloftAutoShow.db.profile.friendlyTotem.state.combat end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.state.combat = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		flagged =
		{
			type = 'toggle',
			width = 'full',
			name = L["Flagged/PvP"],
			desc = L["Auto-show/hide all friendly nameplates on flagging/unflagging for PvP (and not in combat; subject to Visibility options)"],
			order = 3,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyTotem end,
			get = function(i) return AloftAutoShow.db.profile.friendlyTotem.state.flagged end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.state.flagged = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		resting =
		{
			type = 'toggle',
			width = 'full',
			name = L["Resting"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting resting state (and not in combat or flagged; subject to Visibility options)"],
			order = 4,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyTotem end,
			get = function(i) return AloftAutoShow.db.profile.friendlyTotem.state.resting end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.state.resting = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		group =
		{
			type = 'toggle',
			width = 'full',
			name = L["Group"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting groups (and not in combat, flagged, or resting; subject to Visibility options)"],
			order = 5,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyTotem end,
			get = function(i) return AloftAutoShow.db.profile.friendlyTotem.state.group end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.state.group = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		default =
		{
			type = 'toggle',
			width = 'full',
			name = L["Default"],
			desc = L["Auto-show/hide all friendly nameplates by default (subject to Visibility options)"],
			order = 6,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyTotem end,
			get = function(i) return AloftAutoShow.db.profile.friendlyTotem.state.default end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.state.default = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		placeHeader =
		{
			type = 'header',
			width = 'full',
			name = L["Player Location"],
			desc = L["Auto-show/hide all friendly nameplates based on player location (subject to Visibility options)"],
			order = 7,
		},
		world =
		{
			type = 'toggle',
			width = 'full',
			name = L["World"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting the world (subject to Visibility options)"],
			order = 8,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyTotem end,
			get = function(i) return AloftAutoShow.db.profile.friendlyTotem.place.world end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.place.world = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		battleground =
		{
			type = 'toggle',
			width = 'full',
			name = L["Battleground"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting battlegrounds (subject to Visibility options)"],
			order = 9,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyTotem end,
			get = function(i) return AloftAutoShow.db.profile.friendlyTotem.place.battleground end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.place.battleground = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		arena =
		{
			type = 'toggle',
			width = 'full',
			name = L["Arena"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting arenas (subject to Visibility options)"],
			order = 10,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyTotem end,
			get = function(i) return AloftAutoShow.db.profile.friendlyTotem.place.arena end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.place.arena = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		party =
		{
			type = 'toggle',
			width = 'full',
			name = L["5-Man Instance"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting 5-man instances (subject to Visibility options)"],
			order = 11,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyTotem end,
			get = function(i) return AloftAutoShow.db.profile.friendlyTotem.place.party end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.place.party = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
		raid =
		{
			type = 'toggle',
			width = 'full',
			name = L["Raid Instance"],
			desc = L["Auto-show/hide all friendly nameplates on entering/exiting raid instances (subject to Visibility options)"],
			order = 12,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftAutoShow:IsEnabled() or not AloftAutoShow.db or not AloftAutoShow.db.profile or not AloftAutoShow.db.profile.friendlyTotem end,
			get = function(i) return AloftAutoShow.db.profile.friendlyTotem.place.raid end,
			set = function(i, v)
				if AloftAutoShow.db.profile.allFriendEnable then AloftAutoShow:SetAllFriendNameplateDisplay(v) else AloftAutoShow.db.profile.friendlyTotem.place.raid = v end
				AloftAutoShow:ApplyNameplateDisplay()
			end,
		},
	},
}

-----------------------------------------------------------------------------

end)
