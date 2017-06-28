local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("Visibility") then return end

local AloftVisibility = Aloft:GetModule("Visibility")
local AloftAlpha = Aloft:HasModule("Alpha") and Aloft:GetModule("Alpha")

local L = AceLibrary("AceLocale-2.2"):new("AloftVisibilityOptions")
local oT = AceLibrary("AceLocale-2.2"):new("AloftVisibilityTotems")

-----------------------------------------------------------------------------

Aloft.Options.args.visibility =
{
	type = 'group',
	name = L["Visibility"],
	desc = L["Extra visibility options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		friendlyPlayers =
		{
			type = 'text',
			name = L["Friendly Players"],
			desc = L["Selects which friendly players to show"],
			get = function() return AloftVisibility.db.profile.friendlyPlayers end,
			set = function(v) AloftVisibility.db.profile.friendlyPlayers = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			validate = { ["ALL"] = L["All"], ["GUILDONLY"] = L["Guild Only"], ["GROUPONLY"] = L["Group Only"], ["NONE"] = L["None"] },
			order = 2,
		},
		showPet =
		{
			type = 'toggle',
			name = L["Show Pet"],
			desc = L["Shows nameplates for your pets"],
			get = function() return AloftVisibility.db.profile.showPet end,
			set = function(v) AloftVisibility.db.profile.showPet = v AloftVisibility:Update() end,
			order = 3,
		},
		showGroupPets =
		{
			type = 'toggle',
			name = L["Show Group Pets"],
			desc = L["Shows nameplates for group pets"],
			get = function() return AloftVisibility.db.profile.showGroupPets end,
			set = function(v) AloftVisibility.db.profile.showGroupPets = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 4,
		},
		showFriendlyPets =
		{
			type = 'toggle',
			name = L["Show Friendly Pets"],
			desc = L["Shows nameplates for friendly pets"],
			get = function() return AloftVisibility.db.profile.showFriendlyPets end,
			set = function(v) AloftVisibility.db.profile.showFriendlyPets = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 5,
		},
		showFriendlyNPCs =
		{
			type = 'toggle',
			name = L["Show Friendly NPCs"],
			desc = L["Show friendly NPCs"],
			get = function() return AloftVisibility.db.profile.showFriendlyNPCs end,
			set = function(v) AloftVisibility.db.profile.showFriendlyNPCs= v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 6,
		},
		showFriendlyTotems =
		{
			type = 'toggle',
			name = L["Show Friendly Totems/Trap Snakes/Bloodworms"],
			desc = L["Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"],
			order = 7,
			get = function() return AloftVisibility.db.profile.showFriendlyTotems end,
			set = function(v) AloftVisibility.db.profile.showFriendlyTotems = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
		},
		showHostilePlayers =
		{
			type = 'toggle',
			name = L["Show Hostile Players"],
			desc = L["Shows nameplates for hostile players"],
			get = function() return AloftVisibility.db.profile.showHostilePlayers end,
			set = function(v) AloftVisibility.db.profile.showHostilePlayers = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 8,
		},
		showHostilePets =
		{
			type = 'toggle',
			name = L["Show Hostile Pets"],
			desc = L["Shows nameplates for hostile pets"],
			get = function() return AloftVisibility.db.profile.showHostilePets  end,
			set = function(v) AloftVisibility.db.profile.showHostilePets = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 9,
		},
		showHostileNPCs =
		{
			type = 'toggle',
			name = L["Show Hostile NPCs"],
			desc = L["Show hostile NPCs"],
			get = function() return AloftVisibility.db.profile.showHostileNPCs end,
			set = function(v) AloftVisibility.db.profile.showHostileNPCs = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 10,
		},
		showHostileTotems =
		{
			type = 'group',
			name = L["Show Hostile Totems/Trap Snakes/Bloodworms"],
			desc = L["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"],
			order = 11,
			args =
			{
				enable =
				{
					type = 'toggle',
					name = L["Enable"],
					desc = L["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"],
					order = 1,
					get = function() return AloftVisibility.db.profile.showHostileTotems end,
					set = function(v) AloftVisibility.db.profile.showHostileTotems = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
				},
				exception =
				{
					type = 'group',
					name = L["Exceptions"],
					desc = L["Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"],
					order = 2,
					args =
					{
						enableTremorTotem =
						{
							type = 'toggle',
							name = L["Enable Tremor Totem"],
							desc = L["Explicitly shows nameplates for hostile tremor totems (with a dedicated color)"],
							order = 1,
							disabled = function() return AloftVisibility.db.profile.showHostileTotems end,
							get = function() return AloftVisibility.db.profile.enableHostileTotem[oT["Tremor Totem"]] end,
							set = function(v) AloftVisibility.db.profile.enableHostileTotem[oT["Tremor Totem"]] = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
						},
						tremorTotemColor =
						{
							type = 'color',
							name = L["Dedicated Tremor Totem Color"],
							desc = L["Sets the dedicated color for hostile tremor totem nameplates"],
							order = 2,
							disabled = function() return not AloftVisibility.db.profile.showHostileTotems and not AloftVisibility.db.profile.enableHostileTotem[oT["Tremor Totem"]] end,
							get = function() return unpack(AloftVisibility.db.profile.hostileTotemColor[oT["Tremor Totem"]]) end,
							set = function(r, g, b, a) AloftVisibility.db.profile.hostileTotemColor[oT["Tremor Totem"]] = { r, g, b, a } AloftVisibility:Update() end,
							hasAlpha = true,
						},
						enableGroundingTotem =
						{
							type = 'toggle',
							name = L["Enable Grounding Totem"],
							desc = L["Explicitly shows nameplates for hostile grounding totems (with a dedicated color)"],
							order = 3,
							disabled = function() return AloftVisibility.db.profile.showHostileTotems end,
							get = function() return AloftVisibility.db.profile.enableHostileTotem[oT["Grounding Totem"]] end,
							set = function(v) AloftVisibility.db.profile.enableHostileTotem[oT["Grounding Totem"]] = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
						},
						groundingTotemColor =
						{
							type = 'color',
							name = L["Dedicated Grounding Totem Color"],
							desc = L["Sets the dedicated color for hostile grounding totem nameplates"],
							order = 4,
							disabled = function() return not AloftVisibility.db.profile.showHostileTotems and not AloftVisibility.db.profile.enableHostileTotem[oT["Grounding Totem"]] end,
							get = function() return unpack(AloftVisibility.db.profile.hostileTotemColor[oT["Grounding Totem"]]) end,
							set = function(r, g, b, a) AloftVisibility.db.profile.hostileTotemColor[oT["Grounding Totem"]] = { r, g, b, a } AloftVisibility:Update() end,
							hasAlpha = true,
						},
						enableEarthbindTotem =
						{
							type = 'toggle',
							name = L["Enable Earthbind Totem"],
							desc = L["Explicitly shows nameplates for hostile earthbind totems (with a dedicated color)"],
							order = 5,
							disabled = function() return AloftVisibility.db.profile.showHostileTotems end,
							get = function() return AloftVisibility.db.profile.enableHostileTotem[oT["Earthbind Totem"]] end,
							set = function(v) AloftVisibility.db.profile.enableHostileTotem[oT["Earthbind Totem"]] = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
						},
						earthbindTotemColor =
						{
							type = 'color',
							name = L["Dedicated Earthbind Totem Color"],
							desc = L["Sets the dedicated color for hostile earthbind totem nameplates"],
							order = 6,
							disabled = function() return not AloftVisibility.db.profile.showHostileTotems and not AloftVisibility.db.profile.enableHostileTotem[oT["Earthbind Totem"]] end,
							get = function() return unpack(AloftVisibility.db.profile.hostileTotemColor[oT["Earthbind Totem"]]) end,
							set = function(r, g, b, a) AloftVisibility.db.profile.hostileTotemColor[oT["Earthbind Totem"]] = { r, g, b, a } AloftVisibility:Update() end,
							hasAlpha = true,
						},
						enableCleansingTotem =
						{
							type = 'toggle',
							name = L["Enable Cleansing Totem"],
							desc = L["Explicitly shows nameplates for hostile cleansing totems (with a dedicated color)"],
							order = 7,
							disabled = function() return AloftVisibility.db.profile.showHostileTotems end,
							get = function() return AloftVisibility.db.profile.enableHostileTotem[oT["Cleansing Totem"]] end,
							set = function(v) AloftVisibility.db.profile.enableHostileTotem[oT["Cleansing Totem"]] = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
						},
						cleansingTotemColor =
						{
							type = 'color',
							name = L["Dedicated Cleansing Totem Color"],
							desc = L["Sets the dedicated color for hostile cleansing totem nameplates"],
							order = 8,
							disabled = function() return not AloftVisibility.db.profile.showHostileTotems and not AloftVisibility.db.profile.enableHostileTotem[oT["Cleansing Totem"]] end,
							get = function() return unpack(AloftVisibility.db.profile.hostileTotemColor[oT["Cleansing Totem"]]) end,
							set = function(r, g, b, a) AloftVisibility.db.profile.hostileTotemColor[oT["Cleansing Totem"]] = { r, g, b, a } AloftVisibility:Update() end,
							hasAlpha = true,
						},
						enableManaTideTotem =
						{
							type = 'toggle',
							name = L["Enable Mana Tide Totem"],
							desc = L["Explicitly shows nameplates for hostile mana tide totems (with a dedicated color)"],
							order = 9,
							disabled = function() return AloftVisibility.db.profile.showHostileTotems end,
							get = function() return AloftVisibility.db.profile.enableHostileTotem[oT["Mana Tide Totem"]] end,
							set = function(v) AloftVisibility.db.profile.enableHostileTotem[oT["Mana Tide Totem"]] = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
						},
						manaTideTotemColor =
						{
							type = 'color',
							name = L["Dedicated Mana Tide Totem Color"],
							desc = L["Sets the dedicated color for hostile mana tide totem nameplates"],
							order = 10,
							disabled = function() return not AloftVisibility.db.profile.showHostileTotems and not AloftVisibility.db.profile.enableHostileTotem[oT["Mana Tide Totem"]] end,
							get = function() return unpack(AloftVisibility.db.profile.hostileTotemColor[oT["Mana Tide Totem"]]) end,
							set = function(r, g, b, a) AloftVisibility.db.profile.hostileTotemColor[oT["Mana Tide Totem"]] = { r, g, b, a } AloftVisibility:Update() end,
							hasAlpha = true,
						},
					},
				},
			},
		},
		showNeutralUnits =
		{
			type = 'toggle',
			name = L["Show Neutral Units"],
			desc = L["Show neutral units"],
			get = function() return AloftVisibility.db.profile.showNeutralUnits end,
			set = function(v) AloftVisibility.db.profile.showNeutralUnits = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 12,
		},
		critters =
		{
			type = 'group',
			name = L["Critters"],
			desc = L["Visibility options for critters"],
			order = 13,
			args =
			{
				showCritters =
				{
					type = 'toggle',
					name = L["Show Critters"],
					desc = L["Shows nameplates for critters"],
					disabled = function() return not AloftVisibility.db.profile.showNeutralUnits end,
					get = function() return AloftVisibility.db.profile.showCritters end,
					set = function(v) AloftVisibility.db.profile.showCritters = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
					order = 11
				},
				critterLevel =
				{
					type = 'range',
					name = L["Critter Level"],
					desc = L["Assume neutral units below this level are 'critters'"],
					min = 1,
					max = 8,
					step = 1,
					get = function() return AloftVisibility.db.profile.critterLevel end,
					set = function(v) AloftVisibility.db.profile.critterLevel = v Aloft:DetermineDataSources() AloftVisibility:Update() end
				},
				critterHealth =
				{
					type = 'range',
					name = L["Critter Health"],
					desc = L["Assume neutral units below this health are 'critters'"],
					min = 1,
					max = 80,
					step = 1,
					get = function() return AloftVisibility.db.profile.critterHealth end,
					set = function(v) AloftVisibility.db.profile.critterHealth = v Aloft:DetermineDataSources() AloftVisibility:Update() end
				},
			},
		},
		useAlpha =
		{
			type = 'toggle',
			name = L["Use Nameplate Alpha In Combat"],
			desc = L["Controls nameplate visibility in combat by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load, and the nameplate remains mouse-sensitive until combat ends)"],
			disabled = function() return not AloftAlpha end,
			get = function() return AloftVisibility.db.profile.useAlpha end,
			set = function(v) AloftVisibility.db.profile.useAlpha = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = -1,
		},
		spacer  =
		{
			type = 'header',
			order = -2,
		},
		unitNames =
		{
			type = 'group',
			name = L["Hide Unit Names"],
			desc = L["Hide nameplates by unit name"],
			order = -3,
			args =
			{
				enable =
				{
					type = 'toggle',
					name = L["Enable"],
					desc = L["Hide nameplates by unit name"],
					order = 1,
					get = function() return AloftVisibility.db.profile.enableHideUnitNames end,
					set =	function(v)
								AloftVisibility.db.profile.enableHideUnitNames = v
								Aloft:DetermineDataSources() AloftVisibility:Update()
							end,
				},
				target =
				{
					type = "execute",
					name = L["Hide Current Target"],
					desc = L["Add current target to list of unit names to hide"],
					order = 2,
					disabled = function() return not AloftVisibility.db.profile.enableHideUnitNames end,
					func  =	function()
								local name, _ = UnitName("target")
								if name then
									ChatFrame7:AddMessage("AloftVisibility.unitName.target.func(): " .. tostring(name))
									AloftVisibility.db.profile.hideUnitNames[name] = name
									Aloft:AddDST(AloftVisibility.UnitNameDST, name)
									-- TODO: add to digital search tree
									Aloft:DetermineDataSources()
									AloftVisibility:Update()
								end
							end,
				},
				input =
				{
					type = 'text',
					name = L["Hide Unit Name"],
					desc = L["Add given name to list of unit names to hide"],
					usage = L["Enter any unit name, then enter <return>"],
					order = 3,
					disabled = function() return not AloftVisibility.db.profile.enableHideUnitNames end,
					get = function() return nil end,
					set =	function(v)
								if v then
									ChatFrame7:AddMessage("AloftVisibility.unitName.input.set(): " .. tostring(v))
									AloftVisibility.db.profile.hideUnitNames[name] = name
									Aloft:AddDST(AloftVisibility.UnitNameDST, name)
									-- TODO: add to digital search tree
									Aloft:DetermineDataSources()
									AloftVisibility:Update()
								end
							 end,
				},
				delete = {
					type = 'text',
					name = L["Delete Unit Name"],
					desc = L["Delete from list of unit names to hide"],
					usage = L["Select a unit name to delete it from the list"],
					order = 4,
					disabled = function() return not AloftVisibility.db.profile.enableHideUnitNames end,
					get = function() return nil end,
					set =	function(v)
								ChatFrame7:AddMessage("AloftVisibility.unitName.delete.set(): " .. tostring(v))
								-- TODO: delete from digital search tree
								AloftVisibility.db.profile.hideUnitNames[v] = nil
								Aloft:DelDST(AloftVisibility.UnitNameDST, v)
								Aloft:DetermineDataSources()
								AloftVisibility:Update()
							end,
					validate = AloftVisibility.db.profile.hideUnitNames,
				},
			},
		},
	},
}

-----------------------------------------------------------------------------

end)
