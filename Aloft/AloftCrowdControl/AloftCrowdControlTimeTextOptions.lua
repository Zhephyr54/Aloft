local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CrowdControl") or not Aloft:HasModule("CrowdControlTimeText") then return end

local AloftCrowdControl = Aloft:GetModule("CrowdControl")
local AloftCrowdControlTimeText = Aloft:GetModule("CrowdControlTimeText")

local L = AceLibrary("AceLocale-2.2"):new("AloftCrowdControlTimeTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

Aloft.Options.args.crowdControl.args.crowdControlTimeText =
{
	type = 'group',
	name = L["Time Text"],
	desc = L["Crowd control bar time text options"],
	disabled = function() return not AloftCrowdControl.db.profile.enable end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show crowd control bar time text"],
			get = function() return AloftCrowdControlTimeText.db.profile.enable end,
			set = function(v) AloftCrowdControlTimeText.db.profile.enable = v AloftCrowdControlTimeText:Update() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Crowd control bar time text typeface options"],
			disabled = function() return not AloftCrowdControlTimeText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for crowd control bar time text"],
					get = function() return AloftCrowdControlTimeText.db.profile.font end,
					set = function(v)
						AloftCrowdControlTimeText.db.profile.font = v
						AloftCrowdControlTimeText:Update()
					end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the crowd control bar time text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftCrowdControlTimeText.db.profile.fontSize end,
					set = function(value) AloftCrowdControlTimeText.db.profile.fontSize = value AloftCrowdControlTimeText:Update() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on crowd control bar time text"],
					get = function() return AloftCrowdControlTimeText.db.profile.shadow end,
					set = function(v) AloftCrowdControlTimeText.db.profile.shadow = v AloftCrowdControlTimeText:Update() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline for crowd control bar time text"],
					get = function() return AloftCrowdControlTimeText.db.profile.outline end,
					set = function(value) AloftCrowdControlTimeText.db.profile.outline = value AloftCrowdControlTimeText:Update() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'text',
			name = L["Alignment"],
			desc = L["Sets the alignment of the crowd control bar time text"],
			disabled = function() return not AloftCrowdControlTimeText.db.profile.enable end,
			get = function() return AloftCrowdControlTimeText.db.profile.alignment end,
			set = function(value) AloftCrowdControlTimeText.db.profile.alignment = value AloftCrowdControlTimeText:Update() end,
			validate = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust crowd control bar time text position"],
			disabled = function() return not AloftCrowdControlTimeText.db.profile.enable end,
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
					get = function() return AloftCrowdControlTimeText.db.profile.offsets.left end,
					set = function(v) AloftCrowdControlTimeText.db.profile.offsets.left = v AloftCrowdControlTimeText:Update() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCrowdControlTimeText.db.profile.offsets.right end,
					set = function(v) AloftCrowdControlTimeText.db.profile.offsets.right = v AloftCrowdControlTimeText:Update() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCrowdControlTimeText.db.profile.offsets.vertical end,
					set = function(v) AloftCrowdControlTimeText.db.profile.offsets.vertical = v AloftCrowdControlTimeText:Update() end
				},
			},
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the crowd control bar time text color"],
			disabled = function() return not AloftCrowdControlTimeText.db.profile.enable end,
			get = function() return unpack(AloftCrowdControlTimeText.db.profile.color) end,
			set = function(r, g, b, a) AloftCrowdControlTimeText.db.profile.color = { r, g, b, a } AloftCrowdControlTimeText:Update() end,
			hasAlpha = true
		},
	},
}

-----------------------------------------------------------------------------

end)
