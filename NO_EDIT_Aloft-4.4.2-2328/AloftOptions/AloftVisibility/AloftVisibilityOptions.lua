local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftVisibility", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftVisibilityOptions
if not L then return end

local oT = AloftLocale.AloftVisibilityTotems
if not oT then return end

local AloftVisibility = Aloft:GetModule("Visibility", true)
if not AloftVisibility then return end

-----------------------------------------------------------------------------

Aloft.Options.args.visibility =
{
	type = 'group',
	name = L["Visibility"],
	desc = L["Extra visibility options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftVisibility:IsEnabled() or not AloftVisibility.db or not AloftVisibility.db.profile end,
	args =
	{
		target =
		{
			type = 'toggle',
			width = 'full',
			name = L["Always Show Current Target"],
			desc = L["Always shows the current target nameplate (overrides other visibility options, requires use of alpha)"],
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("Alpha", true) and Aloft:GetModule("Alpha"):IsEnabled()) or not AloftVisibility:IsEnabled() or not AloftVisibility.db or not AloftVisibility.db.profile or not AloftVisibility.db.profile.useAlpha end,
			get = function(i) return AloftVisibility.db.profile.target end,
			set = function(i, v) AloftVisibility.db.profile.target = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 1,
		},
		friendlyPlayers =
		{
			type = 'select',
			width = 'full',
			name = L["Friendly Players"],
			desc = L["Selects which friendly players to show"],
			get = function(i) return AloftVisibility.db.profile.friendlyPlayers end,
			set = function(i, v) AloftVisibility.db.profile.friendlyPlayers = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			values = { ["ALL"] = L["All"], ["GUILDONLY"] = L["Guild Only"], ["GROUPONLY"] = L["Group Only"], ["NONE"] = L["None"] },
			order = 2,
		},
		showPet =
		{
			type = 'toggle',
			width = 'full',
			name = L["Show Pet"],
			desc = L["Shows nameplates for your pets"],
			get = function(i) return AloftVisibility.db.profile.showPet end,
			set = function(i, v) AloftVisibility.db.profile.showPet = v AloftVisibility:Update() end,
			order = 3,
		},
		showGroupPets =
		{
			type = 'toggle',
			width = 'full',
			name = L["Show Group Pets"],
			desc = L["Shows nameplates for group pets"],
			get = function(i) return AloftVisibility.db.profile.showGroupPets end,
			set = function(i, v) AloftVisibility.db.profile.showGroupPets = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 4,
		},
		showFriendlyPets =
		{
			type = 'toggle',
			width = 'full',
			name = L["Show Friendly Pets"],
			desc = L["Shows nameplates for friendly pets"],
			get = function(i) return AloftVisibility.db.profile.showFriendlyPets end,
			set = function(i, v) AloftVisibility.db.profile.showFriendlyPets = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 5,
		},
		showFriendlyNPCs =
		{
			type = 'toggle',
			width = 'full',
			name = L["Show Friendly NPCs"],
			desc = L["Show friendly NPCs"],
			get = function(i) return AloftVisibility.db.profile.showFriendlyNPCs end,
			set = function(i, v) AloftVisibility.db.profile.showFriendlyNPCs= v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 6,
		},
		showFriendlyTotems =
		{
			type = 'toggle',
			width = 'full',
			name = L["Show Friendly Totems/Trap Snakes/Bloodworms"],
			desc = L["Shows nameplates for friendly totems/trap snakes/bloodworms (only affects nameplates while out of combat)"],
			order = 7,
			get = function(i) return AloftVisibility.db.profile.showFriendlyTotems end,
			set = function(i, v) AloftVisibility.db.profile.showFriendlyTotems = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
		},
		showHostilePlayers =
		{
			type = 'toggle',
			width = 'full',
			name = L["Show Hostile Players"],
			desc = L["Shows nameplates for hostile players"],
			get = function(i) return AloftVisibility.db.profile.showHostilePlayers end,
			set = function(i, v) AloftVisibility.db.profile.showHostilePlayers = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 8,
		},
		showHostilePets =
		{
			type = 'toggle',
			width = 'full',
			name = L["Show Hostile Pets"],
			desc = L["Shows nameplates for hostile pets"],
			get = function(i) return AloftVisibility.db.profile.showHostilePets  end,
			set = function(i, v) AloftVisibility.db.profile.showHostilePets = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 9,
		},
		showHostileNPCs =
		{
			type = 'toggle',
			width = 'full',
			name = L["Show Hostile NPCs"],
			desc = L["Show hostile NPCs"],
			get = function(i) return AloftVisibility.db.profile.showHostileNPCs end,
			set = function(i, v) AloftVisibility.db.profile.showHostileNPCs = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 10,
		},
		showHostileTotems =
		{
			type = 'group',
			name = L["Show Hostile Totems/Trap Snakes/Bloodworms"],
			desc = L["Shows nameplates for hostile totems/trap snakes/bloodworms (only affects nameplates while out of combat)"],
			order = 11,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftVisibility:IsEnabled() or not AloftVisibility.db or not AloftVisibility.db.profile end,
			args =
			{
				enable =
				{
					type = 'toggle',
					width = 'full',
					name = L["All"],
					name = L["All"],
					order = 1,
					get = function(i) return AloftVisibility.db.profile.showHostileTotems end,
					set = function(i, v) AloftVisibility.db.profile.showHostileTotems = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
				},
				exceptionHeader =
				{
					type = "header",
					name = L["Exceptions"],
					desc = L["Even if nameplates for hostile totems/trap snakes/bloodworms are hidden, display these (with a dedicated color)"],
					order = 2,
				},
			},
			-- NOTE: showHostileTotems is fleshed out at the bottom, based on data extracted via GetSpellInfo
		},
		showNeutralUnits =
		{
			type = 'toggle',
			width = 'full',
			name = L["Show Neutral Units"],
			desc = L["Show neutral units"],
			get = function(i) return AloftVisibility.db.profile.showNeutralUnits end,
			set = function(i, v) AloftVisibility.db.profile.showNeutralUnits = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = 12,
		},
		critters =
		{
			type = 'group',
			name = L["Critters"],
			desc = L["Visibility options for critters"],
			order = 13,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftVisibility:IsEnabled() or not AloftVisibility.db or not AloftVisibility.db.profile or not AloftVisibility.db.profile.showNeutralUnits end,
			args =
			{
				showCritters =
				{
					type = 'toggle',
					width = 'full',
					name = L["Show Critters"],
					desc = L["Shows nameplates for critters"],
					get = function(i) return AloftVisibility.db.profile.showCritters end,
					set = function(i, v) AloftVisibility.db.profile.showCritters = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
					order = 11
				},
				critterLevel =
				{
					type = 'range',
					width = 'full',
					name = L["Critter Level"],
					desc = L["Assume neutral units below this level are 'critters'"],
					min = 1,
					max = 8,
					step = 1,
					get = function(i) return AloftVisibility.db.profile.critterLevel end,
					set = function(i, v) AloftVisibility.db.profile.critterLevel = v Aloft:DetermineDataSources() AloftVisibility:Update() end
				},
				critterHealth =
				{
					type = 'range',
					width = 'full',
					name = L["Critter Health"],
					desc = L["Assume neutral units below this health are 'critters'"],
					min = 1,
					max = 80,
					step = 1,
					get = function(i) return AloftVisibility.db.profile.critterHealth end,
					set = function(i, v) AloftVisibility.db.profile.critterHealth = v Aloft:DetermineDataSources() AloftVisibility:Update() end
				},
			},
		},
		useAlpha =
		{
			type = 'toggle',
			width = 'full',
			name = L["Use Nameplate Alpha"],
			desc = L["Controls nameplate visibility in combat or when target nameplate is always shown by setting nameplate alpha to 0 (requires AloftAlpha module to be enabled at UI load)"],
			disabled = function(i) return not Aloft:IsEnabled() or not (Aloft:GetModule("Alpha", true) and Aloft:GetModule("Alpha"):IsEnabled()) or not AloftVisibility:IsEnabled() or not AloftVisibility.db or not AloftVisibility.db.profile end,
			get = function(i) return AloftVisibility.db.profile.useAlpha end,
			set = function(i, v) AloftVisibility.db.profile.useAlpha = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
			order = -1,
		},
		unitNames =
		{
			type = 'group',
			name = L["Hide Unit Names"],
			desc = L["Hide nameplates by unit name"],
			order = -3,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftVisibility:IsEnabled() or not AloftVisibility.db or not AloftVisibility.db.profile end,
			args =
			{
				enable =
				{
					type = 'toggle',
					width = 'full',
					name = L["Enable"],
					desc = L["Hide nameplates by unit name"],
					order = 1,
					get = function(i) return AloftVisibility.db.profile.enableHideUnitNames end,
					set =	function(i, v)
								AloftVisibility.db.profile.enableHideUnitNames = v
								Aloft:DetermineDataSources() AloftVisibility:Update()
							end,
				},
				target =
				{
					type = 'execute',
					width = 'full',
					name = L["Hide Current Target"],
					desc = L["Add current target to list of unit names to hide"],
					order = 2,
					disabled = function(i) return not AloftVisibility.db.profile.enableHideUnitNames end,
					func  =	function(i)
								local name, _ = UnitName("target")
								if name then
									-- ChatFrame7:AddMessage("AloftVisibility.unitName.target.func(): " .. tostring(name))
									AloftVisibility.db.profile.hideUnitNames[name] = name
									Aloft:DetermineDataSources()
									AloftVisibility:Update()
								end
							end,
				},
				input =
				{
					type = 'input',
					width = 'full',
					name = L["Hide Unit Name"],
					desc = L["Add given name to list of unit names to hide"],
					usage = L["Enter any unit name, then enter <return>"],
					order = 3,
					disabled = function(i) return not AloftVisibility.db.profile.enableHideUnitNames end,
					get = function(i) return nil end,
					set =	function(i, v)
								if v then
									-- ChatFrame7:AddMessage("AloftVisibility.unitName.input.set(): " .. tostring(v))
									AloftVisibility.db.profile.hideUnitNames[v] = v
									Aloft:DetermineDataSources()
									AloftVisibility:Update()
								end
							 end,
				},
				delete = {
					type = 'select',
					width = 'full',
					name = L["Delete Unit Name"],
					desc = L["Select from list of unit names to delete"],
					order = 4,
					disabled = function(i) return not AloftVisibility.db.profile.enableHideUnitNames end,
					get = function(i) return nil end,
					set =	function(i, v)
								-- ChatFrame7:AddMessage("AloftVisibility.unitName.delete.set(): " .. tostring(v))
								AloftVisibility.db.profile.hideUnitNames[v] = nil
								Aloft:DetermineDataSources()
								AloftVisibility:Update()
							end,
					values = function(i) return AloftVisibility.db.profile.hideUnitNames end, -- Ace3 apparently does not like empty tables
				},
			},
		},
	},
}

-- flesh out showHostileTotems, based on data extracted via GetSpellInfo
for name, _ in pairs(Aloft.TotemName) do
	local order = 3

	Aloft.Options.args.visibility.args.showHostileTotems.args[name] =
	{
		type = 'group',
		name = name,
		desc = name,
		order = order,
		inline = true,
		args =
		{
			enable =
			{
				type = 'toggle',
				-- width = 'normal',
				name = L["Enable"],
				desc = L["Enable"],
				order = 2,
				disabled = function(i) return AloftVisibility.db.profile.showHostileTotems end,
				get = function(i) return AloftVisibility.db.profile.enableHostileTotem[i.arg] end,
				set = function(i, v) AloftVisibility.db.profile.enableHostileTotem[i.arg] = v Aloft:DetermineDataSources() AloftVisibility:Update() end,
				arg = name,
			},
			color =
			{
				type = 'color',
				-- width = 'normal',
				name = L["Color"],
				desc = L["Color"],
				order = 3,
				disabled = function(i) return not AloftVisibility.db.profile.showHostileTotems and not AloftVisibility.db.profile.enableHostileTotem[i.arg] end,
				get = function(i)
						-- ChatFrame7:AddMessage("Aloft.Options.args.visibility.args.showHostileTotems.args: " .. tostring(i.arg))
						return unpack(AloftVisibility.db.profile.hostileTotemColor[i.arg])
					  end,
				set = function(i, r, g, b, a) AloftVisibility.db.profile.hostileTotemColor[i.arg] = { r, g, b, a } AloftVisibility:Update() end,
				hasAlpha = true,
				arg = name,
			},
		},
	}

	order = order + 1
end

-----------------------------------------------------------------------------

end)
