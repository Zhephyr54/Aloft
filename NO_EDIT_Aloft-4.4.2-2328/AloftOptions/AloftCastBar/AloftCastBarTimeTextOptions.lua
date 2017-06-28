local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastBarTimeText", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftCastBarTimeTextOptions
if not L then return end

local AloftCastBarTimeText = Aloft:GetModule("CastBarTimeText", true)
if not AloftCastBarTimeText then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.castBar.args.castBarTimeText =
{
	type = 'group',
	name = L["Time Text"],
	desc = L["Cast bar time text options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCastBarTimeText:IsEnabled() or not AloftCastBarTimeText.db or not AloftCastBarTimeText.db.profile or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show cast bar time text"],
			disabled = function(i) return not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			get = function(i) return AloftCastBarTimeText.db.profile.enable end,
			set = function(i, v) AloftCastBarTimeText.db.profile.enable = v AloftCastBarTimeText:Update() end,
			order = 1
		},
		typeface =
		{
			type = 'group',
			name = L["Typeface"],
			desc = L["Cast bar time text typeface options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastBarTimeText:IsEnabled() or not AloftCastBarTimeText.db or not AloftCastBarTimeText.db.profile or not AloftCastBarTimeText.db.profile.enable or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			args =
			{
				font =
				{
					type = 'select',
					width = 'full',
					name = L["Font"],
					desc = L["Sets the font for cast bar time text"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.castBar.args.castBarTimeText.args.typeface.args.font.values) do
							if v == AloftCastBarTimeText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftCastBarTimeText.db.profile.font = Aloft.Options.args.castBar.args.castBarTimeText.args.typeface.args.font.values[v]
						AloftCastBarTimeText:Update()
					end,
					values = SML:List("font"),
				},
				fontSize =
				{
					type = 'range',
					width = 'full',
					name = L["Font Size"],
					desc = L["Sets the font height of the cast bar time text"],
					max = 16,
					min = 5,
					step = 1,
					get = function(i) return AloftCastBarTimeText.db.profile.fontSize end,
					set = function(i, value) AloftCastBarTimeText.db.profile.fontSize = value AloftCastBarTimeText:Update() end
				},
				shadow =
				{
					type = 'toggle',
					width = 'full',
					name = L["Font Shadow"],
					desc = L["Show font shadow on cast bar time text"],
					get = function(i) return AloftCastBarTimeText.db.profile.shadow end,
					set = function(i, v) AloftCastBarTimeText.db.profile.shadow = v AloftCastBarTimeText:Update() end
				},
				outline =
				{
					type = 'select',
					width = 'full',
					name = L["Outline"],
					desc = L["Sets the font outline for cast bar time text"],
					get = function(i) return AloftCastBarTimeText.db.profile.outline end,
					set = function(i, value) AloftCastBarTimeText.db.profile.outline = value AloftCastBarTimeText:Update() end,
					values = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'select',
			width = 'full',
			name = L["Alignment"],
			desc = L["Sets the alignment of the cast bar time text"],
			disabled = function(i) return not AloftCastBarTimeText.db.profile.enable or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			get = function(i) return AloftCastBarTimeText.db.profile.alignment end,
			set = function(i, value) AloftCastBarTimeText.db.profile.alignment = value AloftCastBarTimeText:Update() end,
			values = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust cast bar time text position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastBarTimeText:IsEnabled() or not AloftCastBarTimeText.db or not AloftCastBarTimeText.db.profile or not AloftCastBarTimeText.db.profile.enable or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
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
					get = function(i) return AloftCastBarTimeText.db.profile.offsets.left end,
					set = function(i, v) AloftCastBarTimeText.db.profile.offsets.left = v AloftCastBarTimeText:Update() end
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
					get = function(i) return AloftCastBarTimeText.db.profile.offsets.right end,
					set = function(i, v) AloftCastBarTimeText.db.profile.offsets.right = v AloftCastBarTimeText:Update() end
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
					get = function(i) return AloftCastBarTimeText.db.profile.offsets.vertical end,
					set = function(i, v) AloftCastBarTimeText.db.profile.offsets.vertical = v AloftCastBarTimeText:Update() end
				},
			},
		},
		color =
		{
			type = 'color',
			width = 'full',
			name = L["Color"],
			desc = L["Sets the cast bar time text color"],
			disabled = function(i) return not AloftCastBarTimeText.db.profile.enable or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			get = function(i) return unpack(AloftCastBarTimeText.db.profile.color) end,
			set = function(i, r, g, b, a) AloftCastBarTimeText.db.profile.color = { r, g, b, a } AloftCastBarTimeText:Update() end,
			hasAlpha = true
		},
	},
}

-----------------------------------------------------------------------------

end)
