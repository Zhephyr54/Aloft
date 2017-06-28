local Aloft = Aloft
if not Aloft then return end
-- local AloftModules = AloftModules
-- if not AloftModules then return end

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CastWarning") or not Aloft:HasModule("CastWarningSpellNameText") then return end

local AloftCastWarning = Aloft:GetModule("CastWarning")
local AloftCastWarningSpellNameText = Aloft:GetModule("CastWarningSpellNameText")

local L = AceLibrary("AceLocale-2.2"):new("AloftCastWarningSpellNameTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

Aloft.Options.args.castWarning.args.castWarningSpellNameText =
{
	type = 'group',
	name = L["Spell Name"],
	desc = L["Cast warning spell name text options"],
	disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show cast warning spell name"],
			get = function() return AloftCastWarningSpellNameText.db.profile.enable end,
			set = function(v) AloftCastWarningSpellNameText.db.profile.enable = v AloftCastWarningSpellNameText:UpdateAll() end,
			order = 1,
		},
		rank =
		{
			type = 'toggle',
			name = L["Display Rank"],
			desc = L["Show cast warning spell rank"],
			disabled = function() return not AloftCastWarningSpellNameText.db.profile.enable end,
			get = function() return AloftCastWarningSpellNameText.db.profile.rank end,
			set = function(v) AloftCastWarningSpellNameText.db.profile.rank = v AloftCastWarningSpellNameText:UpdateAll() end,
			order = 2,
		},
		range =
		{
			type = 'toggle',
			name = L["Display Min/Max Range"],
			desc = L["Show cast warning spell minimum/maximum range"],
			disabled = function() return not AloftCastWarningSpellNameText.db.profile.enable end,
			get = function() return AloftCastWarningSpellNameText.db.profile.range end,
			set = function(v) AloftCastWarningSpellNameText.db.profile.range = v AloftCastWarningSpellNameText:UpdateAll() end,
			order = 3,
		},
		outcome =
		{
			type = 'toggle',
			name = L["Display Outcome"],
			desc = L["Show cast warning spell outcome"],
			disabled = function() return not AloftCastWarningSpellNameText.db.profile.enable end,
			get = function() return AloftCastWarningSpellNameText.db.profile.outcome end,
			set = function(v) AloftCastWarningSpellNameText.db.profile.outcome = v AloftCastWarningSpellNameText:UpdateAll() end,
			order = 4,
		},
		extra =
		{
			type = 'toggle',
			name = L["Display Outcome Reason"],
			desc = L["Show cast warning spell outcome reason (failure type, interrupting spell)"],
			disabled = function() return not AloftCastWarningSpellNameText.db.profile.enable end,
			get = function() return AloftCastWarningSpellNameText.db.profile.extra end,
			set = function(v) AloftCastWarningSpellNameText.db.profile.extra = v AloftCastWarningSpellNameText:UpdateAll() end,
			order = 5,
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Spell name typeface options"],
			disabled = function() return not AloftCastWarningSpellNameText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for spell name"],
					get = function() return AloftCastWarningSpellNameText.db.profile.font end,
					set = function(v)
						AloftCastWarningSpellNameText.db.profile.font = v
						AloftCastWarningSpellNameText:UpdateAll()
					end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the spell name"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftCastWarningSpellNameText.db.profile.fontSize end,
					set = function(value) AloftCastWarningSpellNameText.db.profile.fontSize = value AloftCastWarningSpellNameText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on spell name"],
					get = function() return AloftCastWarningSpellNameText.db.profile.shadow end,
					set = function(v) AloftCastWarningSpellNameText.db.profile.shadow = v AloftCastWarningSpellNameText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline for spell name"],
					get = function() return AloftCastWarningSpellNameText.db.profile.outline end,
					set = function(value) AloftCastWarningSpellNameText.db.profile.outline = value AloftCastWarningSpellNameText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'text',
			name = L["Alignment"],
			desc = L["Sets the alignment of the spell name"],
			disabled = function() return not AloftCastWarningSpellNameText.db.profile.enable end,
			get = function() return AloftCastWarningSpellNameText.db.profile.alignment end,
			set = function(value) AloftCastWarningSpellNameText.db.profile.alignment = value AloftCastWarningSpellNameText:UpdateAll() end,
			validate = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust spell name position"],
			disabled = function() return not AloftCastWarningSpellNameText.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastWarningSpellNameText.db.profile.offsets.left end,
					set = function(v) AloftCastWarningSpellNameText.db.profile.offsets.left = v AloftCastWarningSpellNameText:UpdateAll() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastWarningSpellNameText.db.profile.offsets.right end,
					set = function(v) AloftCastWarningSpellNameText.db.profile.offsets.right = v AloftCastWarningSpellNameText:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastWarningSpellNameText.db.profile.offsets.vertical end,
					set = function(v) AloftCastWarningSpellNameText.db.profile.offsets.vertical = v AloftCastWarningSpellNameText:UpdateAll() end
				},
			},
		},
		color =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Sets the spell name colors"],
			disabled = function() return not AloftCastWarningSpellNameText.db.profile.enable end,
			args =
			{
				castColor =
				{
					type = 'color',
					name = L["Cast Color"],
					desc = L["Sets the spell name color during active casting"],
					get = function() return unpack(AloftCastWarningSpellNameText.db.profile.castColor) end,
					set = function(r, g, b, a) AloftCastWarningSpellNameText.db.profile.castColor = { r, g, b, a } AloftCastWarningSpellNameText:UpdateAll() end,
					hasAlpha = true
				},
				fadeColor =
				{
					type = 'color',
					name = L["Fade Color"],
					desc = L["Sets the spell name color during cast warning fade"],
					get = function() return unpack(AloftCastWarningSpellNameText.db.profile.fadeColor) end,
					set = function(r, g, b, a) AloftCastWarningSpellNameText.db.profile.fadeColor = { r, g, b, a } AloftCastWarningSpellNameText:UpdateAll() end,
					hasAlpha = true
				},
			},
		},
	},
}

-----------------------------------------------------------------------------

-- end)