local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftCrowdControlSpellNameTextOptions
if not L then return end

local AloftCrowdControl = Aloft:GetModule("CrowdControl", true)
if not AloftCrowdControl then return end

local AloftCrowdControlSpellNameText = Aloft:GetModule("CrowdControlSpellNameText", true)
if not AloftCrowdControlSpellNameText then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.crowdControl.args.crowdControlSpellNameText =
{
	type = 'group',
	name = L["Spell Name"],
	desc = L["Crowd control bar spell name text options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCrowdControl:IsEnabled() or not AloftCrowdControl.db or not AloftCrowdControl.db.profile or not AloftCrowdControl.db.profile.enable or not AloftCrowdControlSpellNameText:IsEnabled() or not AloftCrowdControlSpellNameText.db or not AloftCrowdControlSpellNameText.db.profile end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show spell name on crowd control bar"],
			get = function(i) return AloftCrowdControlSpellNameText.db.profile.enable end,
			set = function(i, v) AloftCrowdControlSpellNameText.db.profile.enable = v AloftCrowdControlSpellNameText:Update() end,
			order = 1
		},
		typeface =
		{
			type = 'group',
			name = L["Typeface"],
			desc = L["Spell name typeface options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCrowdControl:IsEnabled() or not AloftCrowdControl.db or not AloftCrowdControl.db.profile or not AloftCrowdControl.db.profile.enable or not AloftCrowdControlSpellNameText:IsEnabled() or not AloftCrowdControlSpellNameText.db or not AloftCrowdControlSpellNameText.db.profile or not AloftCrowdControlSpellNameText.db.profile.enable end,
			args =
			{
				font =
				{
					type = 'select',
					width = 'full',
					name = L["Font"],
					desc = L["Sets the font for spell name"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.crowdControl.args.crowdControlSpellNameText.args.typeface.args.font.values) do
							if v == AloftCrowdControlSpellNameText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftCrowdControlSpellNameText.db.profile.font = Aloft.Options.args.crowdControl.args.crowdControlSpellNameText.args.typeface.args.font.values[v]
						AloftCrowdControlSpellNameText:Update()
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
					get = function(i) return AloftCrowdControlSpellNameText.db.profile.fontSize end,
					set = function(i, value) AloftCrowdControlSpellNameText.db.profile.fontSize = value AloftCrowdControlSpellNameText:Update() end
				},
				shadow =
				{
					type = 'toggle',
					width = 'full',
					name = L["Font Shadow"],
					desc = L["Show font shadow on spell name"],
					get = function(i) return AloftCrowdControlSpellNameText.db.profile.shadow end,
					set = function(i, v) AloftCrowdControlSpellNameText.db.profile.shadow = v AloftCrowdControlSpellNameText:Update() end
				},
				outline =
				{
					type = 'select',
					width = 'full',
					name = L["Outline"],
					desc = L["Sets the font outline for spell name"],
					get = function(i) return AloftCrowdControlSpellNameText.db.profile.outline end,
					set = function(i, value) AloftCrowdControlSpellNameText.db.profile.outline = value AloftCrowdControlSpellNameText:Update() end,
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
			disabled = function(i) return not AloftCrowdControlSpellNameText.db.profile.enable end,
			get = function(i) return AloftCrowdControlSpellNameText.db.profile.alignment end,
			set = function(i, value) AloftCrowdControlSpellNameText.db.profile.alignment = value AloftCrowdControlSpellNameText:Update() end,
			values = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust spell name position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCrowdControl:IsEnabled() or not AloftCrowdControl.db or not AloftCrowdControl.db.profile or not AloftCrowdControl.db.profile.enable or not AloftCrowdControlSpellNameText:IsEnabled() or not AloftCrowdControlSpellNameText.db or not AloftCrowdControlSpellNameText.db.profile or not AloftCrowdControlSpellNameText.db.profile.enable end,
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
					get = function(i) return AloftCrowdControlSpellNameText.db.profile.offsets.left end,
					set = function(i, v) AloftCrowdControlSpellNameText.db.profile.offsets.left = v AloftCrowdControlSpellNameText:Update() end
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
					get = function(i) return AloftCrowdControlSpellNameText.db.profile.offsets.right end,
					set = function(i, v) AloftCrowdControlSpellNameText.db.profile.offsets.right = v AloftCrowdControlSpellNameText:Update() end
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
					get = function(i) return AloftCrowdControlSpellNameText.db.profile.offsets.vertical end,
					set = function(i, v) AloftCrowdControlSpellNameText.db.profile.offsets.vertical = v AloftCrowdControlSpellNameText:Update() end
				},
			},
		},
		color =
		{
			type = 'color',
			width = 'full',
			name = L["Color"],
			desc = L["Sets the spell name color"],
			disabled = function(i) return not AloftCrowdControlSpellNameText.db.profile.enable end,
			get = function(i) return unpack(AloftCrowdControlSpellNameText.db.profile.color) end,
			set = function(i, r, g, b, a) AloftCrowdControlSpellNameText.db.profile.color = { r, g, b, a } AloftCrowdControlSpellNameText:Update() end,
			hasAlpha = true
		},
	},
}

-----------------------------------------------------------------------------

end)
