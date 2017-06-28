local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftSpellNameTextOptions
if not L then return end

local AloftSpellNameText = Aloft:GetModule("SpellNameText", true)
if not AloftSpellNameText then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.castBar.args.spellNameText =
{
	type = 'group',
	name = L["Spell Name"],
	desc = L["Cast bar spell name text options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftSpellNameText:IsEnabled() or not AloftSpellNameText.db or not AloftSpellNameText.db.profile or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show spell name on cast bar"],
			disabled = function(i) return not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			get = function(i) return AloftSpellNameText.db.profile.enable end,
			set = function(i, v) AloftSpellNameText.db.profile.enable = v AloftSpellNameText:Update() end,
			order = 1
		},
		typeface =
		{
			type = 'group',
			name = L["Typeface"],
			desc = L["Spell name typeface options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftSpellNameText:IsEnabled() or not AloftSpellNameText.db or not AloftSpellNameText.db.profile or not AloftSpellNameText.db.profile.enable or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			args =
			{
				font =
				{
					type = 'select',
					width = 'full',
					name = L["Font"],
					desc = L["Sets the font for spell name"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.castBar.args.spellNameText.args.typeface.args.font.values) do
							if v == AloftSpellNameText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftSpellNameText.db.profile.font = Aloft.Options.args.castBar.args.spellNameText.args.typeface.args.font.values[v]
						AloftSpellNameText:Update()
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
					get = function(i) return AloftSpellNameText.db.profile.fontSize end,
					set = function(i, value) AloftSpellNameText.db.profile.fontSize = value AloftSpellNameText:Update() end
				},
				shadow =
				{
					type = 'toggle',
					width = 'full',
					name = L["Font Shadow"],
					desc = L["Show font shadow on spell name"],
					get = function(i) return AloftSpellNameText.db.profile.shadow end,
					set = function(i, v) AloftSpellNameText.db.profile.shadow = v AloftSpellNameText:Update() end
				},
				outline =
				{
					type = 'select',
					width = 'full',
					name = L["Outline"],
					desc = L["Sets the font outline for spell name"],
					get = function(i) return AloftSpellNameText.db.profile.outline end,
					set = function(i, value) AloftSpellNameText.db.profile.outline = value AloftSpellNameText:Update() end,
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
			disabled = function(i) return not AloftSpellNameText.db.profile.enable or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			get = function(i) return AloftSpellNameText.db.profile.alignment end,
			set = function(i, value) AloftSpellNameText.db.profile.alignment = value AloftSpellNameText:Update() end,
			values = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust spell name position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftSpellNameText:IsEnabled() or not AloftSpellNameText.db or not AloftSpellNameText.db.profile or not AloftSpellNameText.db.profile.enable or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
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
					get = function(i) return AloftSpellNameText.db.profile.offsets.left end,
					set = function(i, v) AloftSpellNameText.db.profile.offsets.left = v AloftSpellNameText:Update() end
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
					get = function(i) return AloftSpellNameText.db.profile.offsets.right end,
					set = function(i, v) AloftSpellNameText.db.profile.offsets.right = v AloftSpellNameText:Update() end
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
					get = function(i) return AloftSpellNameText.db.profile.offsets.vertical end,
					set = function(i, v) AloftSpellNameText.db.profile.offsets.vertical = v AloftSpellNameText:Update() end
				},
			},
		},
		color =
		{
			type = 'color',
			width = 'full',
			name = L["Color"],
			desc = L["Sets the spell name color"],
			disabled = function(i) return not AloftSpellNameText.db.profile.enable or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			get = function(i) return unpack(AloftSpellNameText.db.profile.color) end,
			set = function(i, r, g, b, a) AloftSpellNameText.db.profile.color = { r, g, b, a } AloftSpellNameText:Update() end,
			hasAlpha = true
		},
	},
}

-----------------------------------------------------------------------------

end)
