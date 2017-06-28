local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarSpellNameText", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("SpellNameText") then return end

local AloftSpellNameText = Aloft:GetModule("SpellNameText")

local L = AceLibrary("AceLocale-2.2"):new("AloftSpellNameTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

Aloft.Options.args.castBar.args.spellNameText =
{
	type = 'group',
	name = L["Spell Name"],
	desc = L["Cast bar spell name text options"],
	disabled = function() return not Aloft:IsActive() or GetCVar("ShowVKeyCastbar") ~= "1" end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show spell name on cast bar"],
			get = function() return AloftSpellNameText.db.profile.enable end,
			set = function(v) AloftSpellNameText.db.profile.enable = v AloftSpellNameText:Update() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Spell name typeface options"],
			disabled = function() return not AloftSpellNameText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for spell name"],
					get = function() return AloftSpellNameText.db.profile.font end,
					set = function(v)
						AloftSpellNameText.db.profile.font = v
						AloftSpellNameText:Update()
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
					get = function() return AloftSpellNameText.db.profile.fontSize end,
					set = function(value) AloftSpellNameText.db.profile.fontSize = value AloftSpellNameText:Update() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on spell name"],
					get = function() return AloftSpellNameText.db.profile.shadow end,
					set = function(v) AloftSpellNameText.db.profile.shadow = v AloftSpellNameText:Update() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline for spell name"],
					get = function() return AloftSpellNameText.db.profile.outline end,
					set = function(value) AloftSpellNameText.db.profile.outline = value AloftSpellNameText:Update() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'text',
			name = L["Alignment"],
			desc = L["Sets the alignment of the spell name"],
			disabled = function() return not AloftSpellNameText.db.profile.enable end,
			get = function() return AloftSpellNameText.db.profile.alignment end,
			set = function(value) AloftSpellNameText.db.profile.alignment = value AloftSpellNameText:Update() end,
			validate = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust spell name position"],
			disabled = function() return not AloftSpellNameText.db.profile.enable end,
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
					get = function() return AloftSpellNameText.db.profile.offsets.left end,
					set = function(v) AloftSpellNameText.db.profile.offsets.left = v AloftSpellNameText:Update() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftSpellNameText.db.profile.offsets.right end,
					set = function(v) AloftSpellNameText.db.profile.offsets.right = v AloftSpellNameText:Update() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftSpellNameText.db.profile.offsets.vertical end,
					set = function(v) AloftSpellNameText.db.profile.offsets.vertical = v AloftSpellNameText:Update() end
				},
			},
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the spell name color"],
			disabled = function() return not AloftSpellNameText.db.profile.enable end,
			get = function() return unpack(AloftSpellNameText.db.profile.color) end,
			set = function(r, g, b, a) AloftSpellNameText.db.profile.color = { r, g, b, a } AloftSpellNameText:Update() end,
			hasAlpha = true
		},
	},
}

-----------------------------------------------------------------------------

end)
