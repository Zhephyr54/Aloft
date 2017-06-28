local Aloft = Aloft
if not Aloft or not Aloft:HasModule("Glow") then return end

-----------------------------------------------------------------------------

local AloftGlow = Aloft:GetModule("Glow")

local L = AceLibrary("AceLocale-2.2"):new("AloftGlowOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.glow =
{
	type = 'group',
	name = L["Nameplate Glow"],
	desc = L["Health bar will be highlighted when unit is attacking player"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable glow"],
			order = 1,
			get = function() return AloftGlow.db.profile.enable end,
			set = function(v) AloftGlow.db.profile.enable = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
		},
		healthbar =
		{
			type = 'toggle',
			name = L["Use Health Bar"],
			desc = L["Indicate aggro status via health bar color (instead of glow)"],
			order = 2,
			disabled = function() return not AloftGlow.db.profile.enable end,
			get = function() return AloftGlow.db.profile.healthbar end,
			set = function(v) AloftGlow.db.profile.healthbar = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
		},
		invert =
		{
			type = 'toggle',
			name = L["Invert"],
			desc = L["Invert glow (disable on targets with aggro, enable on targets without aggro)"],
			order = 3,
			disabled = function() return not AloftGlow.db.profile.enable end,
			get = function() return AloftGlow.db.profile.invert end,
			set = function(v) AloftGlow.db.profile.invert = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
		},
		combatOnly =
		{
			type = 'toggle',
			name = L["Invert Only In Combat"],
			desc = L["Display inverted glow only while in combat"],
			order = 4,
			disabled = function() return not AloftGlow.db.profile.enable or not AloftGlow.db.profile.invert end,
			get = function() return AloftGlow.db.profile.combatOnly end,
			set = function(v) AloftGlow.db.profile.combatOnly = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
		},
		invertTankOnly =
		{
			type = 'toggle',
			name = L["Invert Only While Tanking"],
			desc = L["Invert glow only while tanking (Warrior/Defensive Stance, Death Knight/Frost Presence, Druid/Bear Form, Paladin/Righteous Fury)"],
			order = 5,
			disabled = function() return not AloftGlow.db.profile.enable or not AloftGlow.db.profile.invert end,
			get = function() return AloftGlow.db.profile.invertTankOnly end,
			set = function(v) AloftGlow.db.profile.invertTankOnly = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
		},
		explicit =
		{
			type = 'toggle',
			name = L["Explicit Low Threat Indicator"],
			desc = L["Indicate 'Low Threat' status explicitly as a glow or nameplate color (or if 'Invert' is enabled, indicate 'Securely Tanking' status explicitly)"],
			order = 6,
			disabled = function() return not AloftGlow.db.profile.enable or not AloftGlow.db.profile.override end,
			get = function() return AloftGlow.db.profile.explicit end,
			set = function(v) AloftGlow.db.profile.explicit = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
		},
		explicitCombatOnly =
		{
			type = 'toggle',
			name = L["Explicit Low Threat Indicator Only In Combat"],
			desc = L["Indicate 'Low Threat' status explicitly as a glow or nameplate color only in combat"],
			order = 7,
			disabled = function() return not AloftGlow.db.profile.enable or not AloftGlow.db.profile.override or not AloftGlow.db.profile.explicit end,
			get = function() return AloftGlow.db.profile.explicitCombatOnly end,
			set = function(v) AloftGlow.db.profile.explicitCombatOnly = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
		},
		recentlyDamagedOnly =
		{
			type = 'toggle',
			name = L["Recently Damaged Only"],
			desc = L["Treat the player as 'in combat' only with 'recently damaged' targets"],
			order = 8,
			disabled = function() return not AloftGlow.db.profile.enable or not Aloft:HasModule("RecentlyDamagedData") or not Aloft:IsModuleActive("RecentlyDamagedData") end,
			get = function() return AloftGlow.db.profile.recentlyDamagedOnly end,
			set = function(v) AloftGlow.db.profile.recentlyDamagedOnly = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
		},
		interval =
		{
			type = 'range',
			name = L["Glow Update Interval"],
			desc = L["The amount of time, in seconds, between glow updates (0.0 is as fast as possible)"],
			order = 9,
			min = 0.0,
			max = 5.0,
			step = 0.01,
			disabled = function() return not AloftGlow.db.profile.enable end,
			get = function() return AloftGlow.db.profile.interval end,
			set = function(v) AloftGlow.db.profile.interval = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
		},
		override =
		{
			type = 'toggle',
			name = L["Override Color"],
			desc = L["Overrides the glow default color(s)"],
			order = 10,
			disabled = function() return not AloftGlow.db.profile.enable end,
			get = function() return AloftGlow.db.profile.override end,
			set = function(v) AloftGlow.db.profile.override = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
		},
		threatStatusColors =
		{
			type = 'group',
			name = L["Threat Status Colors"],
			desc = L["Customize nameplate glow threat status colors"],
			disabled = function() return not (AloftGlow.db.profile.enable and AloftGlow.db.profile.override) end,
			order = 11,
			args =
			{
				noAggro =
				{
					type = 'color',
					name = L["Low Threat"],
					desc = L["Low Threat"],
					order = 1,
					disabled = function() return not AloftGlow.db.profile.explicit end,
					get = function() return unpack(AloftGlow.db.profile.threatStatusColors[0]) end,
					set = function(r, g, b) AloftGlow.db.profile.threatStatusColors[0] = { r, g, b, 1.0, } AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end
				},
				overNuking =
				{
					type = 'color',
					name = L["Over-Nuking"],
					desc = L["Over-Nuking"],
					order = 2,
					get = function() return unpack(AloftGlow.db.profile.threatStatusColors[1]) end,
					set = function(r, g, b) AloftGlow.db.profile.threatStatusColors[1] = { r, g, b, 1.0, } AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end
				},
				losingThreat =
				{
					type = 'color',
					name = L["Losing Threat"],
					desc = L["Losing Threat"],
					order = 3,
					get = function() return unpack(AloftGlow.db.profile.threatStatusColors[2]) end,
					set = function(r, g, b) AloftGlow.db.profile.threatStatusColors[2] = { r, g, b, 1.0, } AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end
				},
				tankingSecurely =
				{
					type = 'color',
					name = L["Tanking Securely"],
					desc = L["Tanking Securely"],
					order = 4,
					get = function() return unpack(AloftGlow.db.profile.threatStatusColors[3]) end,
					set = function(r, g, b) AloftGlow.db.profile.threatStatusColors[3] = { r, g, b, 1.0, } AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end
				},
			},
		},
		style =
		{
			type = "text",
			name = L["Style"],
			desc = L["Sets the glow style"],
			order = 12,
			disabled = function() return not AloftGlow.db.profile.enable or AloftGlow.db.profile.healthbar end,
			get = function() return AloftGlow.db.profile.style end,
			set = function(v) AloftGlow.db.profile.style = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
			validate = {
				["HARD"]				= L["HARD"],
				["SOFT"]				= L["SOFT"],
				["PRTLSOFT"]			= L["PRTLSOFT"],
				["THRQTRSOFT"]			= L["THRQTRSOFT"],
				["EXTRASOFT"]			= L["EXTRASOFT"],
				["OVAL"]				= L["OVAL"],
				["OVALGLOW"]			= L["OVALGLOW"],
				["SQUAREGLOW"]			= L["SQUAREGLOW"],
				["PRTLSQUAREGLOW"]		= L["PRTLSQUAREGLOW"],
				["THRQTRSQUAREGLOW"]	= L["THRQTRSQUAREGLOW"],
			},
		},
		size =
		{
			type = 'group',
			name = L["Size"],
			desc = L["Adjust glow size"],
			disabled = function() return not AloftGlow.db.profile.enable or AloftGlow.db.profile.healthbar end,
			order = 13,
			args =
			{
				width =
				{
					type = 'range',
					name = L["Width"],
					desc = L["Sets the width of the glow"],
					order = 1,
					min = 32,
					max = 768,
					step = 1,
					get = function() return AloftGlow.db.profile.width end,
					set = function(v) AloftGlow.db.profile.width = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
				},
				height =
				{
					type = 'range',
					name = L["Height"],
					desc = L["Sets the height of the glow"],
					order = 2,
					min = 4,
					max = 256,
					step = 1,
					get = function() return AloftGlow.db.profile.height end,
					set = function(v) AloftGlow.db.profile.height = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
				},
			}
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the glow position"],
			order = 14,
			disabled = function() return not AloftGlow.db.profile.enable or AloftGlow.db.profile.healthbar end,
			args =
			{
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the glow"],
					order = 1,
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftGlow.db.profile.offsetX end,
					set = function(v) AloftGlow.db.profile.offsetX = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the glow"],
					order = 2,
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftGlow.db.profile.offsetY end,
					set = function(v) AloftGlow.db.profile.offsetY = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
				},
			},
		},
		mode =
		{
			type = "text",
			name = L["Blend Mode"],
			desc = L["Sets the glow blend mode"],
			order = 15,
			get = function() return AloftGlow.db.profile.blendMode end,
			set = function(v) AloftGlow.db.profile.blendMode = v AloftGlow:RegisterEvents() AloftGlow:UpdateAll() end,
			disabled = function() return not AloftGlow.db.profile.enable or AloftGlow.db.profile.healthbar end,
			validate = { ["BLEND"] = L["BLEND"], ["ADD"] = L["ADD"] },
		},
	},
}

-----------------------------------------------------------------------------
