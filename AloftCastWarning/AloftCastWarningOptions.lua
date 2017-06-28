local Aloft = Aloft
if not Aloft then return end
-- local AloftModules = AloftModules
-- if not AloftModules then return end

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CastWarning") then return end

local AloftCastWarning = Aloft:GetModule("CastWarning")
local AloftAlpha = Aloft:HasModule("Alpha") and Aloft:GetModule("Alpha")

local L = AceLibrary("AceLocale-2.2"):new("AloftCastWarningOptions")

local SML = AceLibrary("LibSharedMedia-3.0")
local SML_statusbar = SML:List("statusbar")
local SML_border = SML:List("border")

-----------------------------------------------------------------------------

-- TODO: make these all attributes of AloftCastWarning

-- needs to be maintained to match the definitions in AloftCastWarning.lua/AloftCastWarningSpellProcess.lua; these masks are lifted from Blizzard; buried somewhere in a global table somewhere
local SPELL_SCHOOL_NONE		= SCHOOL_MASK_NONE
local SPELL_SCHOOL_PHYSICAL	= SCHOOL_MASK_PHYSICAL
local SPELL_SCHOOL_HOLY		= SCHOOL_MASK_HOLY
local SPELL_SCHOOL_FIRE		= SCHOOL_MASK_FIRE
local SPELL_SCHOOL_NATURE		= SCHOOL_MASK_NATURE
local SPELL_SCHOOL_FROST		= SCHOOL_MASK_FROST
local SPELL_SCHOOL_SHADOW		= SCHOOL_MASK_SHADOW
local SPELL_SCHOOL_ARCANE		= SCHOOL_MASK_ARCANE
local SPELL_SCHOOL_HEAL		= 0x40000000 				-- this is an imaginary catch-all school for healing spells; make certain no bits are in common

-- needs to be maintained to match the definitions in AloftCastWarning.lua; these are lifted loosely from Blizzard(tm); Interface\AddOns\Blizzard_CombatLog\Blizzard_CombatLog.lua (i.e. Blizzard combat log processing)
local SPELL_COLOR_NONE		= { 1.00, 1.00, 1.00, 1.00, }	-- this is an imaginary color for spells with no known school (a medium gray)
local SPELL_COLOR_PHYSICAL	= { 0.80, 0.60, 0.40, 1.00, }	-- basically the warrior class color
local SPELL_COLOR_HOLY		= { 1.00, 0.90, 0.50, 1.00, }
local SPELL_COLOR_FIRE		= { 1.00, 0.00, 0.00, 1.00, }	-- red
local SPELL_COLOR_NATURE	= { 0.30, 1.00, 0.30, 1.00, }
local SPELL_COLOR_FROST	= { 0.50, 1.00, 1.00, 1.00, }
local SPELL_COLOR_SHADOW	= { 0.50, 0.50, 1.00, 1.00, }	-- basically the warlock class color
local SPELL_COLOR_ARCANE	= { 1.00, 0.50, 1.00, 1.00, }
local SPELL_COLOR_HEAL		= { 1.00, 0.50, 0.00, 1.00, }	-- this is an imaginary catch-all color for healing spells (yellow-orange)

-----------------------------------------------------------------------------

Aloft.Options.args.castWarning =
{
	type = 'group',
	name = L["Cast Warning"],
	desc = L["Cast warning options"] .. " (" .. AloftCastWarning.version .. ")",
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show cast warnings on identifiable enemy nameplates"],
			order = 1,
			get = function() return AloftCastWarning.aloftDB.profile.enable end,
			set = function(v) AloftCastWarning.aloftDB.profile.enable = v Aloft:DetermineDataSources() AloftCastWarning:UpdateAll() end,
		},
		castWarningOverrideEnable =
		{
			type = 'toggle',
			name = L["Cast Warning Alpha Override Enable"],
			desc = L["Enable changing alpha of actively casting units (requires AloftAlpha module to be enabled at UI load)"],
			order = 2,
			disabled = function() return not AloftCastWarning.aloftDB.profile.enable or not AloftAlpha end,
			get = function() return AloftCastWarning.aloftDB.profile.alphaOverrideEnable end,
			set = function(v)
					AloftCastWarning.aloftDB.profile.alphaOverrideEnable = v
					if AloftAlpha then AloftAlpha:EnableChange() end
			end,
		},
		castWarningOverrideAlpha =
		{
			type = 'range',
			name = L["Cast Warning Alpha Override"],
			desc = L["Sets the alpha value of actively casting units (requires AloftAlpha module to be enabled at UI load)"],
			order = 3,
			min = 0.01,
			max = 1,
			step = 0.01,
			disabled = function() return not AloftCastWarning.aloftDB.profile.enable or not AloftCastWarning.aloftDB.profile.alphaOverrideEnable or not AloftAlpha end,
			get = function() return AloftCastWarning.aloftDB.profile.alphaOverride end,
			set = function(v) AloftCastWarning.aloftDB.profile.alphaOverride = v AloftCastWarning:AdjustOptionValues() end,
		},
		verifyInterval =
		{
			type = 'range',
			name = L["Verification Interval"],
			desc = L["Sets the rate at which spell cast verification is performed; this queries the casting unit regularly, after cast activity begins, to verify what spell (if any) is still being cast (0.0 is as fast as possible)"],
			order = 4,
			min = 0.0,
			max = 5.0,
			step = 0.01,
			disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
			get = function() return AloftCastWarning.aloftDB.profile.verifyInterval end,
			set = function(v) AloftCastWarning.aloftDB.profile.verifyInterval = v AloftCastWarning:UpdateAll() end
		},
		tradeSkill =
		{
			type = 'toggle',
			name = L["Trade Skills"],
			desc = L["Show cast warnings for trade skills"],
			order = 5,
			disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
			get = function() return AloftCastWarning.aloftDB.profile.tradeSkill end,
			set = function(v) AloftCastWarning.aloftDB.profile.tradeSkill = v Aloft:DetermineDataSources() AloftCastWarning:UpdateAll() end,
		},
		players =
		{
			type = 'toggle',
			name = L["Players"],
			desc = L["Show cast warnings for players"],
			order = 6,
			disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
			get = function() return AloftCastWarning.aloftDB.profile.players end,
			set = function(v) AloftCastWarning.aloftDB.profile.players = v Aloft:DetermineDataSources() AloftCastWarning:UpdateAll() end,
		},
		friendly =
		{
			type = 'toggle',
			name = L["Friendly Units"],
			desc = L["Show cast warnings for friendly units"],
			order = 7,
			disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
			get = function() return AloftCastWarning.aloftDB.profile.friendly end,
			set = function(v) AloftCastWarning.aloftDB.profile.friendly = v Aloft:DetermineDataSources() AloftCastWarning:UpdateAll() end,
		},
		animate =
		{
			type = 'toggle',
			name = L["Animated Cast Warning"],
			desc = L["Animate cast warnings as cast bars"],
			order = 8,
			disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
			get = function() return AloftCastWarning.aloftDB.profile.animate end,
			set = function(v) AloftCastWarning.aloftDB.profile.animate = v Aloft:DetermineDataSources() AloftCastWarning:UpdateAll() end,
		},
		fadeDuration =
		{
			type = 'range',
			name = L["Fade Duration"],
			desc = L["Sets the fade duration of animated cast warnings (0.0 is no fade)"],
			order = 9,
			min = 0.0,
			max = 5.0, -- same as the ACTIVE_CAST_TIMEOUT constant in AloftCastWarning.lua
			step = 0.1,
			order = 7,
			disabled = function() return not (AloftCastWarning.aloftDB.profile.enable and AloftCastWarning.aloftDB.profile.animate) end,
			get = function() return AloftCastWarning.aloftDB.profile.fadeDuration end,
			set = function(v) AloftCastWarning.aloftDB.profile.fadeDuration = v AloftCastWarning:UpdateAll() end
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust the cast warning's position"],
			order = 10,
			disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the cast warning"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftCastWarning.aloftDB.profile.offsets.left end,
					set = function(v) AloftCastWarning.aloftDB.profile.offsets.left = v AloftCastWarning:UpdateAll() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the cast warning"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftCastWarning.aloftDB.profile.offsets.right end,
					set = function(v) AloftCastWarning.aloftDB.profile.offsets.right = v AloftCastWarning:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the cast warning"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftCastWarning.aloftDB.profile.offsets.vertical end,
					set = function(v) AloftCastWarning.aloftDB.profile.offsets.vertical = v AloftCastWarning:UpdateAll() end
				},
			},
		},
		height =
		{
			type = 'range',
			name = L["Height"],
			desc = L["Sets the height of the cast warning"],
			order = 11,
			min = 2,
			max = 32,
			step = 1,
			disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
			get = function() return AloftCastWarning.aloftDB.profile.height end,
			set = function(v) AloftCastWarning.aloftDB.profile.height = v AloftCastWarning:UpdateAll() end
		},
		interruptable =
		{
			type = 'group',
			name = L["Interruptable Cast Warning"],
			desc = L["Cast warning appearance for interruptable spells"],
			order = 12,
			disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
			args =
			{
				texture =
				{
					type = "text",
					name = L["Texture"],
					desc = L["Sets the cast warning texture"],
					order = 1,
					get = function() return AloftCastWarning.aloftDB.profile.texture end,
					set = function(v)
						AloftCastWarning.aloftDB.profile.texture = v
						AloftCastWarning:UpdateAll()
					end,
					validate = SML_statusbar,
				},
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the cast warning"],
					order = 2,
					get = function() return unpack(AloftCastWarning.aloftDB.profile.backdropColor) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.backdropColor = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
				},
				border =
				{
					type = 'text',
					name = L["Border Style"],
					desc = L["Sets the style of the cast warning border"],
					order = 3,
					get = function() return AloftCastWarning.aloftDB.profile.border end,
					set = function(v)
						AloftCastWarning.aloftDB.profile.border = v
						AloftCastWarning:UpdateAll()
					end,
					validate = SML_border,
				},
				borderColor =
				{
					type = 'color',
					name = L["Border Color"],
					desc = L["Sets the border color of the cast warning"],
					order = 4,
					disabled = function() return AloftCastWarning.aloftDB.profile.border == "None" end,
					get = function() return unpack(AloftCastWarning.aloftDB.profile.borderColor) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.borderColor = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
				},
			},
		},
		uninterruptable =
		{
			type = 'group',
			name = L["Uninterruptable Cast Warning"],
			desc = L["Cast warning appearance for uninterruptable spells"],
			order = 13,
			disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
			args =
			{
				texture =
				{
					type = "text",
					name = L["Texture"],
					desc = L["Sets the cast warning texture"],
					order = 1,
					get = function() return AloftCastWarning.aloftDB.profile.nointerTexture end,
					set = function(v)
						AloftCastWarning.aloftDB.profile.nointerTexture = v
						AloftCastWarning:UpdateAll()
					end,
					validate = SML_statusbar,
				},
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the cast warning"],
					order = 2,
					get = function() return unpack(AloftCastWarning.aloftDB.profile.nointerBackdropColor) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.nointerBackdropColor = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
				},
				border =
				{
					type = 'text',
					name = L["Border Style"],
					desc = L["Sets the style of the cast warning border"],
					order = 3,
					get = function() return AloftCastWarning.aloftDB.profile.nointerBorder end,
					set = function(v)
						AloftCastWarning.aloftDB.profile.nointerBorder = v
						AloftCastWarning:UpdateAll()
					end,
					validate = SML_border,
				},
				borderColor =
				{
					type = 'color',
					name = L["Border Color"],
					desc = L["Sets the border color of the cast warning"],
					order = 4,
					disabled = function() return AloftCastWarning.aloftDB.profile.nointerBorder == "None" end,
					get = function() return unpack(AloftCastWarning.aloftDB.profile.nointerBorderColor) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.nointerBorderColor = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
				},
			},
		},
		colors =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Customize cast warning colors (based on spell school)"],
			order = 14,
			disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
			args =
			{
				backdrop =
				{
					type = 'color',
					name = L["Backdrop Color"],
					desc = L["Sets the backdrop color of the cast warning"],
					get = function() return unpack(AloftCastWarning.aloftDB.profile.backdropColor) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.backdropColor = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
					order = 1,
				},
				default =
				{
					type = 'color',
					name = L["Default"],
					desc = L["Sets the default color for cast warnings from unknown schools"],
					get = function() return unpack(AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_NONE]) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_NONE] = { r, g, b, a, } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
					order = 2,
				},
				physical =
				{
					type = 'color',
					name = L["Physical"],
					desc = L["Sets the color for physical school cast warnings"],
					get = function() return unpack(AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_PHYSICAL]) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_PHYSICAL] = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
					order = 3,
				},
				holy =
				{
					type = 'color',
					name = L["Holy"],
					desc = L["Sets the color for holy school cast warnings"],
					get = function() return unpack(AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_HOLY]) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_HOLY] = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
					order = 4,
				},
				fire =
				{
					type = 'color',
					name = L["Fire"],
					desc = L["Sets the color for fire school cast warnings"],
					get = function() return unpack(AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_FIRE]) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_FIRE] = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
					order = 5,
				},
				nature =
				{
					type = 'color',
					name = L["Nature"],
					desc = L["Sets the color for nature school cast warnings"],
					get = function() return unpack(AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_NATURE]) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_NATURE] = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
					order = 6,
				},
				frost =
				{
					type = 'color',
					name = L["Frost"],
					desc = L["Sets the color for frost school cast warnings"],
					get = function() return unpack(AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_FROST]) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_FROST] = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
					order = 7,
				},
				shadow =
				{
					type = 'color',
					name = L["Shadow"],
					desc = L["Sets the color for shadow school cast warnings"],
					get = function() return unpack(AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_SHADOW]) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_SHADOW] = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
					order = 8,
				},
				arcane =
				{
					type = 'color',
					name = L["Arcane"],
					desc = L["Sets the color for arcane school cast warnings"],
					get = function() return unpack(AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_ARCANE]) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_ARCANE] = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
					order = 9,
				},
				heal =
				{
					type = 'color',
					name = L["Healing"],
					desc = L["Sets the color for healing school cast warnings"],
					get = function() return unpack(AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_HEAL]) end,
					set = function(r, g, b, a) AloftCastWarning.aloftDB.profile.powerTypeColors[SPELL_SCHOOL_HEAL] = { r, g, b, a } AloftCastWarning:UpdateAll() end,
					hasAlpha = true,
					order = 10,
				},
				reset =
				{
					type = "execute",
					name = L["Reset to Defaults"],
					desc = L["Resets all colors to their defaults"],
					order = -1,
					func  = function()
								AloftCastWarning.aloftDB.profile.backdropColor	= { 0.25, 0.25, 0.25, 0.5 }
								AloftCastWarning.aloftDB.profile.powerTypeColors	=
								{
									[SPELL_SCHOOL_NONE]		= SPELL_COLOR_NONE,
									[SPELL_SCHOOL_PHYSICAL]	= SPELL_COLOR_PHYSICAL,
									[SPELL_SCHOOL_HOLY]		= SPELL_COLOR_HOLY,
									[SPELL_SCHOOL_FIRE]		= SPELL_COLOR_FIRE,
									[SPELL_SCHOOL_NATURE]	= SPELL_COLOR_NATURE,
									[SPELL_SCHOOL_FROST]	= SPELL_COLOR_FROST,
									[SPELL_SCHOOL_SHADOW]	= SPELL_COLOR_SHADOW,
									[SPELL_SCHOOL_ARCANE]	= SPELL_COLOR_ARCANE,
									[SPELL_SCHOOL_HEAL]		= SPELL_COLOR_HEAL,
								},
								AloftCastWarning:UpdateAll()
							end,
				},
			}
		},
	},
}

-----------------------------------------------------------------------------

-- end)
