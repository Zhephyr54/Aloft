local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCombatText", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftCombatText
if not L then return end

local AloftCombatText = Aloft:GetModule("CombatText", true)
if not AloftCombatText then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

-- needs to be maintained to match the definitions in AloftCombatTextOptions.lua; these are lifted loosely from Blizzard(tm); Interface\AddOns\Blizzard_CombatLog\Blizzard_CombatLog.lua (i.e. Blizzard combat log processing)
local SPELL_COLOR_NONE		= { 1.00, 1.00, 1.00, }	-- this is an imaginary color for spells with no known school (a medium gray)
local SPELL_COLOR_PHYSICAL	= { 0.80, 0.60, 0.40, }	-- basically the warrior class color
local SPELL_COLOR_HOLY		= { 1.00, 0.90, 0.50, }
local SPELL_COLOR_FIRE		= { 1.00, 0.00, 0.00, }	-- red
local SPELL_COLOR_NATURE	= { 0.30, 1.00, 0.30, }
local SPELL_COLOR_FROST	= { 0.50, 1.00, 1.00, }
local SPELL_COLOR_SHADOW	= { 0.50, 0.50, 1.00, }	-- basically the warlock class color
local SPELL_COLOR_ARCANE	= { 1.00, 0.50, 1.00, }
local SPELL_COLOR_HEAL		= { 1.00, 0.50, 0.00, }	-- this is an imaginary catch-all color for healing spells (yellow-orange)
local SPELL_COLOR_ENERGIZE	= { 0.41, 0.80, 0.94, }	-- for energize activity

-----------------------------------------------------------------------------

Aloft.Options.args.combatText =
{
	type = 'group',
	name = L["Combat Text"],
	desc = L["Combat text options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCombatText:IsEnabled() or not AloftCombatText.db or not AloftCombatText.db.profile end,
	args =
	{
		enableTarget =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable Target"],
			desc = L["Show combat text on target nameplates"],
			get = function(i) return AloftCombatText.db.profile.enableTarget end,
			set = function(i, v) AloftCombatText.db.profile.enableTarget = v AloftCombatText:UpdateAll() end,
			order = 1
		},
		enableGroup =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable Group"],
			desc = L["Show combat text on group member nameplates"],
			get = function(i) return AloftCombatText.db.profile.enableGroup end,
			set = function(i, v) AloftCombatText.db.profile.enableGroup = v AloftCombatText:UpdateAll() end,
			order = 2
		},
		enableOther =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable Other"],
			desc = L["Show combat text on other nameplates"],
			get = function(i) return AloftCombatText.db.profile.enableOther end,
			set = function(i, v) AloftCombatText.db.profile.enableOther = v AloftCombatText:UpdateAll() end,
			order = 3
		},
		effectPlayer =
		{
			type = 'toggle',
			width = 'full',
			name = L["Damage/Healing By Player"],
			desc = L["Show combat text for damage/healing done by the player"],
			disabled = function(i) return not (AloftCombatText.db.profile.enableTarget or AloftCombatText.db.profile.enableGroup or AloftCombatText.db.profile.enableOther) end,
			get = function(i) return AloftCombatText.db.profile.effectPlayer end,
			set = function(i, v) AloftCombatText.db.profile.effectPlayer = v AloftCombatText:UpdateAll() end,
			order = 4
		},
		effectGroup =
		{
			type = 'toggle',
			width = 'full',
			name = L["Damage/Healing By Group"],
			desc = L["Show combat text for damage/healing done by group members (including pets)"],
			disabled = function(i) return not (AloftCombatText.db.profile.enableTarget or AloftCombatText.db.profile.enableGroup or AloftCombatText.db.profile.enableOther) end,
			get = function(i) return AloftCombatText.db.profile.effectGroup end,
			set = function(i, v) AloftCombatText.db.profile.effectGroup = v AloftCombatText:UpdateAll() end,
			order = 5
		},
		effectOther =
		{
			type = 'toggle',
			width = 'full',
			name = L["Damage/Healing By Other"],
			desc = L["Show combat text for damage/healing done by other units"],
			disabled = function(i) return not (AloftCombatText.db.profile.enableTarget or AloftCombatText.db.profile.enableGroup or AloftCombatText.db.profile.enableOther) end,
			get = function(i) return AloftCombatText.db.profile.effectOther end,
			set = function(i, v) AloftCombatText.db.profile.effectOther = v AloftCombatText:UpdateAll() end,
			order = 6
		},
		overHealing =
		{
			type = 'toggle',
			width = 'full',
			name = L["Include Overhealing"],
			desc = L["Show combat text for healing that includes overhealing"],
			disabled = function(i) return not (AloftCombatText.db.profile.enableTarget or AloftCombatText.db.profile.enableGroup or AloftCombatText.db.profile.enableOther) end,
			get = function(i) return AloftCombatText.db.profile.overHealing end,
			set = function(i, v) AloftCombatText.db.profile.overHealing = v AloftCombatText:UpdateAll() end,
			order = 7
		},
		typeface =
		{
			type = 'group',
			name = L["Typeface"],
			desc = L["Combat text typeface options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCombatText:IsEnabled() or not AloftCombatText.db or not AloftCombatText.db.profile or not (AloftCombatText.db.profile.enableTarget or AloftCombatText.db.profile.enableGroup or AloftCombatText.db.profile.enableOther) end,
			args =
			{
				font =
				{
					type = 'select',
					width = 'full',
					name = L["Font"],
					desc = L["Sets the font for combat text"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.combatText.args.typeface.args.font.values) do
							if v == AloftCombatText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftCombatText.db.profile.font = Aloft.Options.args.combatText.args.typeface.args.font.values[v]
						AloftCombatText:UpdateAll()
					end,
					values = SML:List("font"),
				},
				fontSize =
				{
					type = 'range',
					width = 'full',
					name = L["Font Size"],
					desc = L["Sets the font height of the combat text"],
					max = 40,
					min = 5,
					step = 1,
					get = function(i) return AloftCombatText.db.profile.fontSize end,
					set = function(i, value) AloftCombatText.db.profile.fontSize = value AloftCombatText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					width = 'full',
					name = L["Font Shadow"],
					desc = L["Show font shadow on combat text"],
					get = function(i) return AloftCombatText.db.profile.shadow end,
					set = function(i, v) AloftCombatText.db.profile.shadow = v AloftCombatText:UpdateAll() end
				},
				outline =
				{
					type = 'select',
					width = 'full',
					name = L["Outline"],
					desc = L["Sets the outline for combat text"],
					get = function(i) return AloftCombatText.db.profile.outline end,
					set = function(i, value) AloftCombatText.db.profile.outline = value AloftCombatText:UpdateAll() end,
					values = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust combat text position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCombatText:IsEnabled() or not AloftCombatText.db or not AloftCombatText.db.profile or not (AloftCombatText.db.profile.enableTarget or AloftCombatText.db.profile.enableGroup or AloftCombatText.db.profile.enableOther) end,
			args =
			{
				anchor = {
					type = 'select',
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the combat text"],
					get = function(i) return AloftCombatText.db.profile.point end,
					set = function(i, v) AloftCombatText.db.profile.point = v AloftCombatText:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = 'select',
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the combat text"],
					get = function(i) return AloftCombatText.db.profile.relativeToPoint end,
					set = function(i, v) AloftCombatText.db.profile.relativeToPoint = v AloftCombatText:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the combat text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftCombatText.db.profile.offsetX end,
					set = function(i, v) AloftCombatText.db.profile.offsetX = v AloftCombatText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the combat text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftCombatText.db.profile.offsetY end,
					set = function(i, v) AloftCombatText.db.profile.offsetY = v AloftCombatText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			width = 'full',
			name = L["Alpha"],
			desc = L["Sets the alpha of the combat text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function(i) return not (AloftCombatText.db.profile.enableTarget or AloftCombatText.db.profile.enableGroup or AloftCombatText.db.profile.enableOther) end,
			get = function(i) return AloftCombatText.db.profile.alpha end,
			set = function(i, v) AloftCombatText.db.profile.alpha = v AloftCombatText:UpdateAll() end
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize colors"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCombatText:IsEnabled() or not AloftCombatText.db or not AloftCombatText.db.profile or not (AloftCombatText.db.profile.enableTarget or AloftCombatText.db.profile.enableGroup or AloftCombatText.db.profile.enableOther) end,
			args =
			{
				physical =
				{
					type = 'color',
					width = 'full',
					name = L["Physical"],
					desc = L["Sets the color for physical damage"],
					order = 1,
					get = function(i) return unpack(AloftCombatText.db.profile.colors[1]) end,
					set = function(i, r, g, b) AloftCombatText.db.profile.colors[1] = { r, g, b } end,
				},
				holy =
				{
					type = 'color',
					width = 'full',
					name = L["Holy"],
					desc = L["Sets the color for holy damage"],
					order = 2,
					get = function(i) return unpack(AloftCombatText.db.profile.colors[2]) end,
					set = function(i, r, g, b) AloftCombatText.db.profile.colors[2] = { r, g, b } end,
				},
				fire =
				{
					type = 'color',
					width = 'full',
					name = L["Fire"],
					desc = L["Sets the color for fire damage"],
					order = 2,
					get = function(i) return unpack(AloftCombatText.db.profile.colors[4]) end,
					set = function(i, r, g, b) AloftCombatText.db.profile.colors[4] = { r, g, b } end,
				},
				nature =
				{
					type = 'color',
					width = 'full',
					name = L["Nature"],
					desc = L["Sets the color for nature damage"],
					order = 2,
					get = function(i) return unpack(AloftCombatText.db.profile.colors[8]) end,
					set = function(i, r, g, b) AloftCombatText.db.profile.colors[8] = { r, g, b } end,
				},
				frost =
				{
					type = 'color',
					width = 'full',
					name = L["Frost"],
					desc = L["Sets the color for frost damage"],
					order = 2,
					get = function(i) return unpack(AloftCombatText.db.profile.colors[16]) end,
					set = function(i, r, g, b) AloftCombatText.db.profile.colors[16] = { r, g, b } end,
				},
				shadow =
				{
					type = 'color',
					width = 'full',
					name = L["Shadow"],
					desc = L["Sets the color for shadow damage"],
					order = 2,
					get = function(i) return unpack(AloftCombatText.db.profile.colors[32]) end,
					set = function(i, r, g, b) AloftCombatText.db.profile.colors[32] = { r, g, b } end,
				},
				arcane =
				{
					type = 'color',
					width = 'full',
					name = L["Arcane"],
					desc = L["Sets the color for arcane damage"],
					order = 2,
					get = function(i) return unpack(AloftCombatText.db.profile.colors[64]) end,
					set = function(i, r, g, b) AloftCombatText.db.profile.colors[64] = { r, g, b } end,
				},
				heal =
				{
					type = 'color',
					width = 'full',
					name = L["Heal"],
					desc = L["Sets the color for healing"],
					order = 3,
					get = function(i) return unpack(AloftCombatText.db.profile.colors.heal) end,
					set = function(i, r, g, b) AloftCombatText.db.profile.colors.heal = { r, g, b } end,
				},
				text =
				{
					type = 'color',
					width = 'full',
					name = L["Text"],
					desc = L["Sets the color for text feedback"],
					order = 3,
					get = function(i) return unpack(AloftCombatText.db.profile.colors.text) end,
					set = function(i, r, g, b) AloftCombatText.db.profile.colors.text = { r, g, b } end,
				},
				reset =
				{
					type = 'execute',
					width = 'full',
					name = L["Reset"],
					desc = L["Resets all of the colors to default"],
					order = -1,
					func = function(i)
								AloftCombatText.db.profile.colors[1]		= SPELL_COLOR_PHYSICAL	-- Physical
								AloftCombatText.db.profile.colors[2]		= SPELL_COLOR_HOLY 		-- Holy
								AloftCombatText.db.profile.colors[4]		= SPELL_COLOR_FIRE		-- Fire
								AloftCombatText.db.profile.colors[8]		= SPELL_COLOR_NATURE	-- Nature
								AloftCombatText.db.profile.colors[16]		= SPELL_COLOR_FROST		-- Frost
								AloftCombatText.db.profile.colors[32]		= SPELL_COLOR_SHADOW	-- Shadow
								AloftCombatText.db.profile.colors[64]		= SPELL_COLOR_ARCANE	-- Arcane

								AloftCombatText.db.profile.colors.energize	= SPELL_COLOR_ENERGIZE
								AloftCombatText.db.profile.colors.text		= SPELL_COLOR_NONE
								AloftCombatText.db.profile.colors.heal		= SPELL_COLOR_HEAL
							end
				},
				setAll =
				{
					type = 'color',
					width = 'full',
					name = L["Set All"],
					desc = L["Sets all of the colors"],
					get = function(i) return unpack(AloftCombatText.db.profile.colors[1]) end,
					set = function(i, r, g, b)
							AloftCombatText.db.profile.colors[1] 		= { r, g, b, }	-- Physical
							AloftCombatText.db.profile.colors[2] 		= { r, g, b, }	-- Holy
							AloftCombatText.db.profile.colors[4]		= { r, g, b, }	-- Fire
							AloftCombatText.db.profile.colors[8]		= { r, g, b, }	-- Nature
							AloftCombatText.db.profile.colors[16]		= { r, g, b, }	-- Frost
							AloftCombatText.db.profile.colors[32]		= { r, g, b, }	-- Shadow
							AloftCombatText.db.profile.colors[64]		= { r, g, b, }	-- Arcane

							AloftCombatText.db.profile.colors.energize	= { r, g, b, }
							AloftCombatText.db.profile.colors.text		= { r, g, b, }
							AloftCombatText.db.profile.colors.heal		= { r, g, b, }
						  end,
					order = -1,
				},
			},
		},
	},
}

-----------------------------------------------------------------------------

end)
