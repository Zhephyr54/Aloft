local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CrowdControl") or not Aloft:HasModule("CrowdControlSpellNameText") then return end

local AloftCrowdControl = Aloft:GetModule("CrowdControl")
local AloftCrowdControlSpellNameText = Aloft:GetModule("CrowdControlSpellNameText")

local L = AceLibrary("AceLocale-2.2"):new("AloftCrowdControlSpellNameTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

Aloft.Options.args.crowdControl.args.crowdControlSpellNameText =
{
	type = 'group',
	name = L["Spell Name"],
	desc = L["Crowd control bar spell name text options"],
	disabled = function() return not AloftCrowdControl.db.profile.enable end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show spell name on crowd control bar"],
			get = function() return AloftCrowdControlSpellNameText.db.profile.enable end,
			set = function(v) AloftCrowdControlSpellNameText.db.profile.enable = v AloftCrowdControlSpellNameText:Update() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Spell name typeface options"],
			disabled = function() return not AloftCrowdControlSpellNameText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for spell name"],
					get = function() return AloftCrowdControlSpellNameText.db.profile.font end,
					set = function(v)
						AloftCrowdControlSpellNameText.db.profile.font = v
						AloftCrowdControlSpellNameText:Update()
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
					get = function() return AloftCrowdControlSpellNameText.db.profile.fontSize end,
					set = function(value) AloftCrowdControlSpellNameText.db.profile.fontSize = value AloftCrowdControlSpellNameText:Update() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on spell name"],
					get = function() return AloftCrowdControlSpellNameText.db.profile.shadow end,
					set = function(v) AloftCrowdControlSpellNameText.db.profile.shadow = v AloftCrowdControlSpellNameText:Update() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline for spell name"],
					get = function() return AloftCrowdControlSpellNameText.db.profile.outline end,
					set = function(value) AloftCrowdControlSpellNameText.db.profile.outline = value AloftCrowdControlSpellNameText:Update() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'text',
			name = L["Alignment"],
			desc = L["Sets the alignment of the spell name"],
			disabled = function() return not AloftCrowdControlSpellNameText.db.profile.enable end,
			get = function() return AloftCrowdControlSpellNameText.db.profile.alignment end,
			set = function(value) AloftCrowdControlSpellNameText.db.profile.alignment = value AloftCrowdControlSpellNameText:Update() end,
			validate = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust spell name position"],
			disabled = function() return not AloftCrowdControlSpellNameText.db.profile.enable end,
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
					get = function() return AloftCrowdControlSpellNameText.db.profile.offsets.left end,
					set = function(v) AloftCrowdControlSpellNameText.db.profile.offsets.left = v AloftCrowdControlSpellNameText:Update() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCrowdControlSpellNameText.db.profile.offsets.right end,
					set = function(v) AloftCrowdControlSpellNameText.db.profile.offsets.right = v AloftCrowdControlSpellNameText:Update() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCrowdControlSpellNameText.db.profile.offsets.vertical end,
					set = function(v) AloftCrowdControlSpellNameText.db.profile.offsets.vertical = v AloftCrowdControlSpellNameText:Update() end
				},
			},
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the spell name color"],
			disabled = function() return not AloftCrowdControlSpellNameText.db.profile.enable end,
			get = function() return unpack(AloftCrowdControlSpellNameText.db.profile.color) end,
			set = function(r, g, b, a) AloftCrowdControlSpellNameText.db.profile.color = { r, g, b, a } AloftCrowdControlSpellNameText:Update() end,
			hasAlpha = true
		},
	},
}

-----------------------------------------------------------------------------

end)
