local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellNameText", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftCastWarningSpellNameTextOptions
if not L then return end

local AloftCastWarning = Aloft:GetModule("CastWarning", true)
if not AloftCastWarning then return end

local AloftCastWarningSpellNameText = Aloft:GetModule("CastWarningSpellNameText", true)
if not AloftCastWarningSpellNameText then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.castWarning.args.castWarningSpellNameText =
{
	type = 'group',
	name = L["Spell Name"],
	desc = L["Cast warning spell name text options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCastWarning:IsEnabled() or not AloftCastWarning.db or not AloftCastWarning.db.profile or not AloftCastWarning.db.profile.enable or not AloftCastWarningSpellNameText:IsEnabled() or not AloftCastWarningSpellNameText.db or not AloftCastWarningSpellNameText.db.profile end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show cast warning spell name"],
			get = function(i) return AloftCastWarningSpellNameText.db.profile.enable end,
			set = function(i, v) AloftCastWarningSpellNameText.db.profile.enable = v AloftCastWarningSpellNameText:UpdateAll() end,
			order = 1,
		},
		rank =
		{
			type = 'toggle',
			width = 'full',
			name = L["Display Rank"],
			desc = L["Show cast warning spell rank"],
			disabled = function(i) return not AloftCastWarningSpellNameText.db.profile.enable end,
			get = function(i) return AloftCastWarningSpellNameText.db.profile.rank end,
			set = function(i, v) AloftCastWarningSpellNameText.db.profile.rank = v AloftCastWarningSpellNameText:UpdateAll() end,
			order = 2,
		},
		range =
		{
			type = 'toggle',
			width = 'full',
			name = L["Display Min/Max Range"],
			desc = L["Show cast warning spell minimum/maximum range"],
			disabled = function(i) return not AloftCastWarningSpellNameText.db.profile.enable end,
			get = function(i) return AloftCastWarningSpellNameText.db.profile.range end,
			set = function(i, v) AloftCastWarningSpellNameText.db.profile.range = v AloftCastWarningSpellNameText:UpdateAll() end,
			order = 3,
		},
		outcome =
		{
			type = 'toggle',
			width = 'full',
			name = L["Display Outcome"],
			desc = L["Show cast warning spell outcome"],
			disabled = function(i) return not AloftCastWarningSpellNameText.db.profile.enable end,
			get = function(i) return AloftCastWarningSpellNameText.db.profile.outcome end,
			set = function(i, v) AloftCastWarningSpellNameText.db.profile.outcome = v AloftCastWarningSpellNameText:UpdateAll() end,
			order = 4,
		},
		extra =
		{
			type = 'toggle',
			width = 'full',
			name = L["Display Outcome Reason"],
			desc = L["Show cast warning spell outcome reason (failure type, interrupting spell)"],
			disabled = function(i) return not AloftCastWarningSpellNameText.db.profile.enable end,
			get = function(i) return AloftCastWarningSpellNameText.db.profile.extra end,
			set = function(i, v) AloftCastWarningSpellNameText.db.profile.extra = v AloftCastWarningSpellNameText:UpdateAll() end,
			order = 5,
		},
		typeface =
		{
			type = 'group',
			name = L["Typeface"],
			desc = L["Spell name typeface options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastWarning:IsEnabled() or not AloftCastWarning.db or not AloftCastWarning.db.profile or not AloftCastWarning.db.profile.enable or not AloftCastWarningSpellNameText:IsEnabled() or not AloftCastWarningSpellNameText.db or not AloftCastWarningSpellNameText.db.profile or not AloftCastWarningSpellNameText.db.profile.enable end,
			args =
			{
				font =
				{
					type = 'select',
					width = 'full',
					name = L["Font"],
					desc = L["Sets the font for spell name"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.castWarning.args.castWarningSpellNameText.args.typeface.args.font.values) do
							if v == AloftCastWarningSpellNameText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftCastWarningSpellNameText.db.profile.font = Aloft.Options.args.castWarning.args.castWarningSpellNameText.args.typeface.args.font.values[v]
						AloftCastWarningSpellNameText:UpdateAll()
					end,
					values = SML:List("font"),
				},
				fontSize =
				{
					type = 'range',
					width = 'full',
					name = L["Font Size"],
					desc = L["Sets the font height of the spell name"],
					max = 16,
					min = 5,
					step = 1,
					get = function(i) return AloftCastWarningSpellNameText.db.profile.fontSize end,
					set = function(i, value) AloftCastWarningSpellNameText.db.profile.fontSize = value AloftCastWarningSpellNameText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					width = 'full',
					name = L["Font Shadow"],
					desc = L["Show font shadow on spell name"],
					get = function(i) return AloftCastWarningSpellNameText.db.profile.shadow end,
					set = function(i, v) AloftCastWarningSpellNameText.db.profile.shadow = v AloftCastWarningSpellNameText:UpdateAll() end
				},
				outline =
				{
					type = 'select',
					width = 'full',
					name = L["Outline"],
					desc = L["Sets the font outline for spell name"],
					get = function(i) return AloftCastWarningSpellNameText.db.profile.outline end,
					set = function(i, value) AloftCastWarningSpellNameText.db.profile.outline = value AloftCastWarningSpellNameText:UpdateAll() end,
					values = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'select',
			width = 'full',
			name = L["Alignment"],
			desc = L["Sets the alignment of the spell name"],
			disabled = function(i) return not AloftCastWarningSpellNameText.db.profile.enable end,
			get = function(i) return AloftCastWarningSpellNameText.db.profile.alignment end,
			set = function(i, value) AloftCastWarningSpellNameText.db.profile.alignment = value AloftCastWarningSpellNameText:UpdateAll() end,
			values = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust spell name position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastWarning:IsEnabled() or not AloftCastWarning.db or not AloftCastWarning.db.profile or not AloftCastWarning.db.profile.enable or not AloftCastWarningSpellNameText:IsEnabled() or not AloftCastWarningSpellNameText.db or not AloftCastWarningSpellNameText.db.profile or not AloftCastWarningSpellNameText.db.profile.enable end,
			args =
			{
				left =
				{
					type = 'range',
					width = 'full',
					name = L["Left Offset"],
					desc = L["Sets the offset of the left of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function(i) return AloftCastWarningSpellNameText.db.profile.offsets.left end,
					set = function(i, v) AloftCastWarningSpellNameText.db.profile.offsets.left = v AloftCastWarningSpellNameText:UpdateAll() end
				},
				right =
				{
					type = 'range',
					width = 'full',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function(i) return AloftCastWarningSpellNameText.db.profile.offsets.right end,
					set = function(i, v) AloftCastWarningSpellNameText.db.profile.offsets.right = v AloftCastWarningSpellNameText:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					width = 'full',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function(i) return AloftCastWarningSpellNameText.db.profile.offsets.vertical end,
					set = function(i, v) AloftCastWarningSpellNameText.db.profile.offsets.vertical = v AloftCastWarningSpellNameText:UpdateAll() end
				},
			},
		},
		color =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Sets the spell name colors"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastWarning:IsEnabled() or not AloftCastWarning.db or not AloftCastWarning.db.profile or not AloftCastWarning.db.profile.enable or not AloftCastWarningSpellNameText:IsEnabled() or not AloftCastWarningSpellNameText.db or not AloftCastWarningSpellNameText.db.profile or not AloftCastWarningSpellNameText.db.profile.enable end,
			args =
			{
				castColor =
				{
					type = 'color',
					width = 'full',
					name = L["Cast Color"],
					desc = L["Sets the spell name color during active casting"],
					get = function(i) return unpack(AloftCastWarningSpellNameText.db.profile.castColor) end,
					set = function(i, r, g, b, a) AloftCastWarningSpellNameText.db.profile.castColor = { r, g, b, a } AloftCastWarningSpellNameText:UpdateAll() end,
					hasAlpha = true
				},
				fadeColor =
				{
					type = 'color',
					width = 'full',
					name = L["Fade Color"],
					desc = L["Sets the spell name color during cast warning fade"],
					get = function(i) return unpack(AloftCastWarningSpellNameText.db.profile.fadeColor) end,
					set = function(i, r, g, b, a) AloftCastWarningSpellNameText.db.profile.fadeColor = { r, g, b, a } AloftCastWarningSpellNameText:UpdateAll() end,
					hasAlpha = true
				},
			},
		},
	},
}

-----------------------------------------------------------------------------

end)