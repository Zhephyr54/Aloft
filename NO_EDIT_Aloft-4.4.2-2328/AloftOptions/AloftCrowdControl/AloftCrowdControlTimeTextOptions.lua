local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCrowdControl", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftCrowdControlTimeTextOptions
if not L then return end

local AloftCrowdControl = Aloft:GetModule("CrowdControl", true)
if not AloftCrowdControl then return end

local AloftCrowdControlTimeText = Aloft:GetModule("CrowdControlTimeText", true)
if not AloftCrowdControlTimeText then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.crowdControl.args.crowdControlTimeText =
{
	type = 'group',
	name = L["Time Text"],
	desc = L["Crowd control bar time text options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCrowdControl:IsEnabled() or not AloftCrowdControl.db or not AloftCrowdControl.db.profile or not AloftCrowdControl.db.profile.enable or not AloftCrowdControlTimeText:IsEnabled() or not AloftCrowdControlTimeText.db or not AloftCrowdControlTimeText.db.profile end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show crowd control bar time text"],
			get = function(i) return AloftCrowdControlTimeText.db.profile.enable end,
			set = function(i, v) AloftCrowdControlTimeText.db.profile.enable = v AloftCrowdControlTimeText:Update() end,
			order = 1
		},
		typeface =
		{
			type = 'group',
			name = L["Typeface"],
			desc = L["Crowd control bar time text typeface options"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCrowdControl:IsEnabled() or not AloftCrowdControl.db or not AloftCrowdControl.db.profile or not AloftCrowdControl.db.profile.enable or not AloftCrowdControlTimeText:IsEnabled() or not AloftCrowdControlTimeText.db or not AloftCrowdControlTimeText.db.profile or not AloftCrowdControlTimeText.db.profile.enable end,
			args =
			{
				font =
				{
					type = 'select',
					width = 'full',
					name = L["Font"],
					desc = L["Sets the font for crowd control bar time text"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.crowdControl.args.crowdControlTimeText.args.typeface.args.font.values) do
							if v == AloftCrowdControlTimeText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftCrowdControlTimeText.db.profile.font = Aloft.Options.args.crowdControl.args.crowdControlTimeText.args.typeface.args.font.values[v]
						AloftCrowdControlTimeText:Update()
					end,
					values = SML:List("font"),
				},
				fontSize =
				{
					type = 'range',
					width = 'full',
					name = L["Font Size"],
					desc = L["Sets the font height of the crowd control bar time text"],
					max = 16,
					min = 5,
					step = 1,
					get = function(i) return AloftCrowdControlTimeText.db.profile.fontSize end,
					set = function(i, value) AloftCrowdControlTimeText.db.profile.fontSize = value AloftCrowdControlTimeText:Update() end
				},
				shadow =
				{
					type = 'toggle',
					width = 'full',
					name = L["Font Shadow"],
					desc = L["Show font shadow on crowd control bar time text"],
					get = function(i) return AloftCrowdControlTimeText.db.profile.shadow end,
					set = function(i, v) AloftCrowdControlTimeText.db.profile.shadow = v AloftCrowdControlTimeText:Update() end
				},
				outline =
				{
					type = 'select',
					width = 'full',
					name = L["Outline"],
					desc = L["Sets the font outline for crowd control bar time text"],
					get = function(i) return AloftCrowdControlTimeText.db.profile.outline end,
					set = function(i, value) AloftCrowdControlTimeText.db.profile.outline = value AloftCrowdControlTimeText:Update() end,
					values = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'select',
			width = 'full',
			name = L["Alignment"],
			desc = L["Sets the alignment of the crowd control bar time text"],
			disabled = function(i) return not AloftCrowdControlTimeText.db.profile.enable end,
			get = function(i) return AloftCrowdControlTimeText.db.profile.alignment end,
			set = function(i, value) AloftCrowdControlTimeText.db.profile.alignment = value AloftCrowdControlTimeText:Update() end,
			values = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust crowd control bar time text position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCrowdControl:IsEnabled() or not AloftCrowdControl.db or not AloftCrowdControl.db.profile or not AloftCrowdControl.db.profile.enable or not AloftCrowdControlTimeText:IsEnabled() or not AloftCrowdControlTimeText.db or not AloftCrowdControlTimeText.db.profile or not AloftCrowdControlTimeText.db.profile.enable end,
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
					get = function(i) return AloftCrowdControlTimeText.db.profile.offsets.left end,
					set = function(i, v) AloftCrowdControlTimeText.db.profile.offsets.left = v AloftCrowdControlTimeText:Update() end
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
					get = function(i) return AloftCrowdControlTimeText.db.profile.offsets.right end,
					set = function(i, v) AloftCrowdControlTimeText.db.profile.offsets.right = v AloftCrowdControlTimeText:Update() end
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
					get = function(i) return AloftCrowdControlTimeText.db.profile.offsets.vertical end,
					set = function(i, v) AloftCrowdControlTimeText.db.profile.offsets.vertical = v AloftCrowdControlTimeText:Update() end
				},
			},
		},
		color =
		{
			type = 'color',
			width = 'full',
			name = L["Color"],
			desc = L["Sets the crowd control bar time text color"],
			disabled = function(i) return not AloftCrowdControlTimeText.db.profile.enable end,
			get = function(i) return unpack(AloftCrowdControlTimeText.db.profile.color) end,
			set = function(i, r, g, b, a) AloftCrowdControlTimeText.db.profile.color = { r, g, b, a } AloftCrowdControlTimeText:Update() end,
			hasAlpha = true,
		},
	},
}

-----------------------------------------------------------------------------

end)
