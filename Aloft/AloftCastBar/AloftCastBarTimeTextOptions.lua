local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CastBarTimeText") then return end

local AloftCastBarTimeText = Aloft:GetModule("CastBarTimeText")

local L = AceLibrary("AceLocale-2.2"):new("AloftCastBarTimeTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

Aloft.Options.args.castBar.args.castBarTimeText =
{
	type = 'group',
	name = L["Time Text"],
	desc = L["Cast bar time text options"],
	disabled = function() return not Aloft:IsActive() or GetCVar("ShowVKeyCastbar") ~= "1" end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show cast bar time text"],
			get = function() return AloftCastBarTimeText.db.profile.enable end,
			set = function(v) AloftCastBarTimeText.db.profile.enable = v AloftCastBarTimeText:Update() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Cast bar time text typeface options"],
			disabled = function() return not AloftCastBarTimeText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for cast bar time text"],
					get = function() return AloftCastBarTimeText.db.profile.font end,
					set = function(v)
						AloftCastBarTimeText.db.profile.font = v
						AloftCastBarTimeText:Update()
					end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the cast bar time text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftCastBarTimeText.db.profile.fontSize end,
					set = function(value) AloftCastBarTimeText.db.profile.fontSize = value AloftCastBarTimeText:Update() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on cast bar time text"],
					get = function() return AloftCastBarTimeText.db.profile.shadow end,
					set = function(v) AloftCastBarTimeText.db.profile.shadow = v AloftCastBarTimeText:Update() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline for cast bar time text"],
					get = function() return AloftCastBarTimeText.db.profile.outline end,
					set = function(value) AloftCastBarTimeText.db.profile.outline = value AloftCastBarTimeText:Update() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'text',
			name = L["Alignment"],
			desc = L["Sets the alignment of the cast bar time text"],
			disabled = function() return not AloftCastBarTimeText.db.profile.enable end,
			get = function() return AloftCastBarTimeText.db.profile.alignment end,
			set = function(value) AloftCastBarTimeText.db.profile.alignment = value AloftCastBarTimeText:Update() end,
			validate = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust cast bar time text position"],
			disabled = function() return not AloftCastBarTimeText.db.profile.enable end,
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
					get = function() return AloftCastBarTimeText.db.profile.offsets.left end,
					set = function(v) AloftCastBarTimeText.db.profile.offsets.left = v AloftCastBarTimeText:Update() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastBarTimeText.db.profile.offsets.right end,
					set = function(v) AloftCastBarTimeText.db.profile.offsets.right = v AloftCastBarTimeText:Update() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastBarTimeText.db.profile.offsets.vertical end,
					set = function(v) AloftCastBarTimeText.db.profile.offsets.vertical = v AloftCastBarTimeText:Update() end
				},
			},
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the cast bar time text color"],
			disabled = function() return not AloftCastBarTimeText.db.profile.enable end,
			get = function() return unpack(AloftCastBarTimeText.db.profile.color) end,
			set = function(r, g, b, a) AloftCastBarTimeText.db.profile.color = { r, g, b, a } AloftCastBarTimeText:Update() end,
			hasAlpha = true
		},
	},
}

-----------------------------------------------------------------------------

end)
