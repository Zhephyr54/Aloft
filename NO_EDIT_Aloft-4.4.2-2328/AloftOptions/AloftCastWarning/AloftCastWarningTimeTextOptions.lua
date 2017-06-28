local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningTimeText", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftCastWarningTimeTextOptions
if not L then return end

local AloftCastWarning = Aloft:GetModule("CastWarning", true)
if not AloftCastWarning then return end

local AloftCastWarningTimeText = Aloft:GetModule("CastWarningTimeText", true)
if not AloftCastWarningTimeText then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.castWarning.args.castWarningTimeText =
{
	type = 'group',
	name = L["Spell Time"],
	desc = L["Cast warning spell time text options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCastWarning:IsEnabled() or not AloftCastWarning.db or not AloftCastWarning.db.profile or not AloftCastWarning.db.profile.enable or not AloftCastWarningTimeText:IsEnabled() or not AloftCastWarningTimeText.db or not AloftCastWarningTimeText.db.profile end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show cast warning spell time"],
			get = function(i) return AloftCastWarningTimeText.db.profile.enable end,
			set = function(i, v) AloftCastWarningTimeText.db.profile.enable = v AloftCastWarningTimeText:UpdateAll() end,
			order = 1
		},
		typeface =
		{
			type = 'group',
			name = L["Typeface"],
			desc = L["Spell time typeface options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastWarning:IsEnabled() or not AloftCastWarning.db or not AloftCastWarning.db.profile or not AloftCastWarning.db.profile.enable or not AloftCastWarningTimeText:IsEnabled() or not AloftCastWarningTimeText.db or not AloftCastWarningTimeText.db.profile or not AloftCastWarningTimeText.db.profile.enable end,
			args =
			{
				font =
				{
					type = 'select',
					width = 'full',
					name = L["Font"],
					desc = L["Sets the font for spell time"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.castWarning.args.castWarningTimeText.args.typeface.args.font.values) do
							if v == AloftCastWarningTimeText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftCastWarningTimeText.db.profile.font = Aloft.Options.args.castWarning.args.castWarningTimeText.args.typeface.args.font.values[v]
						AloftCastWarningTimeText:UpdateAll()
					end,
					values = SML:List("font"),
				},
				fontSize =
				{
					type = 'range',
					width = 'full',
					name = L["Font Size"],
					desc = L["Sets the font height of the spell time"],
					max = 16,
					min = 5,
					step = 1,
					get = function(i) return AloftCastWarningTimeText.db.profile.fontSize end,
					set = function(i, value) AloftCastWarningTimeText.db.profile.fontSize = value AloftCastWarningTimeText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					width = 'full',
					name = L["Font Shadow"],
					desc = L["Show font shadow on spell time"],
					get = function(i) return AloftCastWarningTimeText.db.profile.shadow end,
					set = function(i, v) AloftCastWarningTimeText.db.profile.shadow = v AloftCastWarningTimeText:UpdateAll() end
				},
				outline =
				{
					type = 'select',
					width = 'full',
					name = L["Outline"],
					desc = L["Sets the font outline for spell time"],
					get = function(i) return AloftCastWarningTimeText.db.profile.outline end,
					set = function(i, value) AloftCastWarningTimeText.db.profile.outline = value AloftCastWarningTimeText:UpdateAll() end,
					values = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'select',
			width = 'full',
			name = L["Alignment"],
			desc = L["Sets the alignment of the spell time"],
			disabled = function(i) return not AloftCastWarningTimeText.db.profile.enable end,
			get = function(i) return AloftCastWarningTimeText.db.profile.alignment end,
			set = function(i, value) AloftCastWarningTimeText.db.profile.alignment = value AloftCastWarningTimeText:UpdateAll() end,
			values = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust spell time position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastWarning:IsEnabled() or not AloftCastWarning.db or not AloftCastWarning.db.profile or not AloftCastWarning.db.profile.enable or not AloftCastWarningTimeText:IsEnabled() or not AloftCastWarningTimeText.db or not AloftCastWarningTimeText.db.profile or not AloftCastWarningTimeText.db.profile.enable end,
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
					get = function(i) return AloftCastWarningTimeText.db.profile.offsets.left end,
					set = function(i, v) AloftCastWarningTimeText.db.profile.offsets.left = v AloftCastWarningTimeText:UpdateAll() end
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
					get = function(i) return AloftCastWarningTimeText.db.profile.offsets.right end,
					set = function(i, v) AloftCastWarningTimeText.db.profile.offsets.right = v AloftCastWarningTimeText:UpdateAll() end
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
					get = function(i) return AloftCastWarningTimeText.db.profile.offsets.vertical end,
					set = function(i, v) AloftCastWarningTimeText.db.profile.offsets.vertical = v AloftCastWarningTimeText:UpdateAll() end
				},
			},
		},
		color =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Sets the spell time colors"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastWarning:IsEnabled() or not AloftCastWarning.db or not AloftCastWarning.db.profile or not AloftCastWarning.db.profile.enable or not AloftCastWarningTimeText:IsEnabled() or not AloftCastWarningTimeText.db or not AloftCastWarningTimeText.db.profile or not AloftCastWarningTimeText.db.profile.enable end,
			args =
			{
				castColor =
				{
					type = 'color',
					width = 'full',
					name = L["Cast Color"],
					desc = L["Sets the spell time color during active casting"],
					get = function(i) return unpack(AloftCastWarningTimeText.db.profile.castColor) end,
					set = function(i, r, g, b, a) AloftCastWarningTimeText.db.profile.castColor = { r, g, b, a } AloftCastWarningSpellNameText:UpdateAll() end,
					hasAlpha = true
				},
				fadeColor =
				{
					type = 'color',
					width = 'full',
					name = L["Fade Color"],
					desc = L["Sets the spell time color during cast warning fade"],
					get = function(i) return unpack(AloftCastWarningTimeText.db.profile.fadeColor) end,
					set = function(i, r, g, b, a) AloftCastWarningTimeText.db.profile.fadeColor = { r, g, b, a } AloftCastWarningSpellNameText:UpdateAll() end,
					hasAlpha = true
				},
			},
		},
	},
}

-----------------------------------------------------------------------------

end)