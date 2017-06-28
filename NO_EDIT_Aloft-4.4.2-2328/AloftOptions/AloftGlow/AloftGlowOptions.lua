local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftGlow
if not L then return end

local AloftGlow = Aloft:GetModule("Glow")
if not AloftGlow then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.glow =
{
	type = 'group',
	name = L["Nameplate Glow"],
	desc = L["Health bar will be highlighted when unit is attacking player"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftGlow:IsEnabled() or not AloftGlow.db or not AloftGlow.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Enable glow"],
			order = 1,
			get = function(i)  return AloftGlow.db.profile.enable end,
			set = function(i, v) AloftGlow.db.profile.enable = v AloftGlow:UpdateAll() end,
		},
		healthbar =
		{
			type = 'toggle',
			width = 'full',
			name = L["Use Health Bar"],
			desc = L["Indicate aggro status via health bar color (instead of glow)"],
			order = 2,
			disabled = function(i)  return not AloftGlow.db.profile.enable end,
			get = function(i)  return AloftGlow.db.profile.healthbar end,
			set = function(i, v) AloftGlow.db.profile.healthbar = v AloftGlow:UpdateAll() end,
		},
		invert =
		{
			type = 'toggle',
			width = 'full',
			name = L["Invert"],
			desc = L["Invert glow (disable on targets with aggro, enable on targets without aggro)"],
			order = 3,
			disabled = function(i)  return not AloftGlow.db.profile.enable end,
			get = function(i)  return AloftGlow.db.profile.invert end,
			set = function(i, v) AloftGlow.db.profile.invert = v AloftGlow:UpdateAll() end,
		},
		combatOnly =
		{
			type = 'toggle',
			width = 'full',
			name = L["Invert Only In Combat"],
			desc = L["Display inverted glow only while in combat"],
			order = 4,
			disabled = function(i)  return not AloftGlow.db.profile.enable or not AloftGlow.db.profile.invert end,
			get = function(i)  return AloftGlow.db.profile.combatOnly end,
			set = function(i, v) AloftGlow.db.profile.combatOnly = v AloftGlow:UpdateAll() end,
		},
		invertTankOnly =
		{
			type = 'toggle',
			width = 'full',
			name = L["Invert Only While Tanking"],
			desc = L["Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"],
			order = 5,
			disabled = function(i)  return not AloftGlow.db.profile.enable or not AloftGlow.db.profile.invert end,
			get = function(i)  return AloftGlow.db.profile.invertTankOnly end,
			set = function(i, v) AloftGlow.db.profile.invertTankOnly = v AloftGlow:UpdateAll() end,
		},
		explicit =
		{
			type = 'toggle',
			width = 'full',
			name = L["Explicit Low Threat Indicator"],
			desc = L["Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"],
			order = 6,
			disabled = function(i)  return not AloftGlow.db.profile.enable or not AloftGlow.db.profile.override end,
			get = function(i)  return AloftGlow.db.profile.explicit end,
			set = function(i, v) AloftGlow.db.profile.explicit = v AloftGlow:UpdateAll() end,
		},
		explicitCombatOnly =
		{
			type = 'toggle',
			width = 'full',
			name = L["Explicit Low Threat Indicator Only In Combat"],
			desc = L["Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"],
			order = 7,
			disabled = function(i)  return not AloftGlow.db.profile.enable or not AloftGlow.db.profile.override or not AloftGlow.db.profile.explicit end,
			get = function(i)  return AloftGlow.db.profile.explicitCombatOnly end,
			set = function(i, v) AloftGlow.db.profile.explicitCombatOnly = v AloftGlow:UpdateAll() end,
		},
		recentlyDamagedOnly =
		{
			type = 'toggle',
			width = 'full',
			name = L["Recently Damaged Only"],
			desc = L["Treat the player as 'in combat' only with 'recently damaged' targets"],
			order = 8,
			disabled = function(i) return not AloftGlow.db.profile.enable or not Aloft:GetModule("RecentlyDamagedData", true) or not Aloft:GetModule("RecentlyDamagedData"):IsEnabled() end,
			get = function(i) return AloftGlow.db.profile.recentlyDamagedOnly end,
			set = function(i, v) AloftGlow.db.profile.recentlyDamagedOnly = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
		},
		interval =
		{
			type = 'range',
			width = 'full',
			name = L["Glow Update Interval"],
			desc = L["The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"],
			order = 9,
			min = 0.0,
			max = 5.0,
			step = 0.01,
			disabled = function(i)  return not AloftGlow.db.profile.enable end,
			get = function(i)  return AloftGlow.db.profile.interval end,
			set = function(i, v) AloftGlow.db.profile.interval = v AloftGlow:UpdateAll() end,
		},
		override =
		{
			type = 'toggle',
			width = 'full',
			name = L["Override Color"],
			desc = L["Overrides the glow default color(s)"],
			order = 10,
			disabled = function(i)  return not AloftGlow.db.profile.enable end,
			get = function(i)  return AloftGlow.db.profile.override end,
			set = function(i, v) AloftGlow.db.profile.override = v AloftGlow:UpdateAll() end,
		},
		threatStatusColors =
		{
			type = 'group',
			name = L["Threat Status Colors"],
			desc = L["Customize nameplate glow threat status colors"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftGlow:IsEnabled() or not AloftGlow.db or not AloftGlow.db.profile or not (AloftGlow.db.profile.enable and AloftGlow.db.profile.override) end,
			order = 11,
			args =
			{
				noAggro =
				{
					type = 'color',
					width = 'full',
					name = L["Low Threat"],
					desc = L["Low Threat"],
					order = 1,
					disabled = function(i)  return not AloftGlow.db.profile.explicit end,
					get = function(i)  return unpack(AloftGlow.db.profile.threatStatusColors[0]) end,
					set = function(i, r, g, b) AloftGlow.db.profile.threatStatusColors[0] = { r, g, b, 1.0, } AloftGlow:UpdateAll() end
				},
				overNuking =
				{
					type = 'color',
					width = 'full',
					name = L["Over-Nuking"],
					desc = L["Over-Nuking"],
					order = 2,
					get = function(i)  return unpack(AloftGlow.db.profile.threatStatusColors[1]) end,
					set = function(i, r, g, b) AloftGlow.db.profile.threatStatusColors[1] = { r, g, b, 1.0, } AloftGlow:UpdateAll() end
				},
				losingThreat =
				{
					type = 'color',
					width = 'full',
					name = L["Losing Threat"],
					desc = L["Losing Threat"],
					order = 3,
					get = function(i)  return unpack(AloftGlow.db.profile.threatStatusColors[2]) end,
					set = function(i, r, g, b) AloftGlow.db.profile.threatStatusColors[2] = { r, g, b, 1.0, } AloftGlow:UpdateAll() end
				},
				tankingSecurely =
				{
					type = 'color',
					width = 'full',
					name = L["Tanking Securely"],
					desc = L["Tanking Securely"],
					order = 4,
					get = function(i)  return unpack(AloftGlow.db.profile.threatStatusColors[3]) end,
					set = function(i, r, g, b) AloftGlow.db.profile.threatStatusColors[3] = { r, g, b, 1.0, } AloftGlow:UpdateAll() end
				},
			},
		},
		style =
		{
			type = "select",
			width = 'full',
			name = L["Style"],
			desc = L["Sets the glow style"],
			order = 12,
			disabled = function(i)  return not AloftGlow.db.profile.enable or AloftGlow.db.profile.healthbar end,
			get = function(i)
					for k, v in pairs(Aloft.Options.args.glow.args.style.values) do
						if v == AloftGlow.db.profile.style then
							return k
						end
					end
				end,
			set = function(i, v)
					AloftGlow.db.profile.style = Aloft.Options.args.glow.args.style.values[v]
					AloftGlow:UpdateAll()
				end,
			values = SML:List("glow"),
		},
		size =
		{
			type = 'group',
			name = L["Size"],
			desc = L["Adjust glow size"],
			disabled = function(i)  return not AloftGlow.db.profile.enable or AloftGlow.db.profile.healthbar end,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftGlow:IsEnabled() or not AloftGlow.db or not AloftGlow.db.profile or not AloftGlow.db.profile.enable or AloftGlow.db.profile.healthbar end,
			order = 13,
			args =
			{
				width =
				{
					type = 'range',
					width = 'full',
					name = L["Width"],
					desc = L["Sets the width of the glow"],
					order = 1,
					min = 32,
					max = 768,
					step = 1,
					get = function(i)  return AloftGlow.db.profile.width end,
					set = function(i, v) AloftGlow.db.profile.width = v AloftGlow:UpdateAll() end,
				},
				height =
				{
					type = 'range',
					width = 'full',
					name = L["Height"],
					desc = L["Sets the height of the glow"],
					order = 2,
					min = 4,
					max = 256,
					step = 1,
					get = function(i)  return AloftGlow.db.profile.height end,
					set = function(i, v) AloftGlow.db.profile.height = v AloftGlow:UpdateAll() end,
				},
			}
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the glow position"],
			order = 14,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftGlow:IsEnabled() or not AloftGlow.db or not AloftGlow.db.profile or not AloftGlow.db.profile.enable or AloftGlow.db.profile.healthbar end,
			args =
			{
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the glow"],
					order = 1,
					min = -32,
					max = 32,
					step = 1,
					get = function(i)  return AloftGlow.db.profile.offsetX end,
					set = function(i, v) AloftGlow.db.profile.offsetX = v AloftGlow:UpdateAll() end,
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the glow"],
					order = 2,
					min = -32,
					max = 32,
					step = 1,
					get = function(i)  return AloftGlow.db.profile.offsetY end,
					set = function(i, v) AloftGlow.db.profile.offsetY = v AloftGlow:UpdateAll() end,
				},
			},
		},
		mode =
		{
			type = "select",
			width = 'full',
			name = L["Blend Mode"],
			desc = L["Sets the glow blend mode"],
			order = 15,
			get = function(i)  return AloftGlow.db.profile.blendMode end,
			set = function(i, v) AloftGlow.db.profile.blendMode = v AloftGlow:UpdateAll() end,
			disabled = function(i)  return not AloftGlow.db.profile.enable or AloftGlow.db.profile.healthbar end,
			values = { ["BLEND"] = L["BLEND"], ["ADD"] = L["ADD"] },
		},
	},
}

-----------------------------------------------------------------------------
