local Aloft = Aloft
if not Aloft then return end
-- local AloftModules = AloftModules
-- if not AloftModules then return end

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CastWarning") or not Aloft:HasModule("CastWarningTimeText") then return end

local AloftCastWarning = Aloft:GetModule("CastWarning")
local AloftCastWarningTimeText = Aloft:GetModule("CastWarningTimeText")

local L = AceLibrary("AceLocale-2.2"):new("AloftCastWarningTimeTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

Aloft.Options.args.castWarning.args.castWarningTimeText =
{
	type = 'group',
	name = L["Spell Time"],
	desc = L["Cast warning spell time text options"],
	disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show cast warning spell time"],
			get = function() return AloftCastWarningTimeText.db.profile.enable end,
			set = function(v) AloftCastWarningTimeText.db.profile.enable = v AloftCastWarningTimeText:UpdateAll() end,
			order = 1
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Spell time typeface options"],
			disabled = function() return not AloftCastWarningTimeText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for spell time"],
					get = function() return AloftCastWarningTimeText.db.profile.font end,
					set = function(v)
						AloftCastWarningTimeText.db.profile.font = v
						AloftCastWarningTimeText:UpdateAll()
					end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the spell time"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftCastWarningTimeText.db.profile.fontSize end,
					set = function(value) AloftCastWarningTimeText.db.profile.fontSize = value AloftCastWarningTimeText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on spell time"],
					get = function() return AloftCastWarningTimeText.db.profile.shadow end,
					set = function(v) AloftCastWarningTimeText.db.profile.shadow = v AloftCastWarningTimeText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the font outline for spell time"],
					get = function() return AloftCastWarningTimeText.db.profile.outline end,
					set = function(value) AloftCastWarningTimeText.db.profile.outline = value AloftCastWarningTimeText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		alignment =
		{
			type = 'text',
			name = L["Alignment"],
			desc = L["Sets the alignment of the spell time"],
			disabled = function() return not AloftCastWarningTimeText.db.profile.enable end,
			get = function() return AloftCastWarningTimeText.db.profile.alignment end,
			set = function(value) AloftCastWarningTimeText.db.profile.alignment = value AloftCastWarningTimeText:UpdateAll() end,
			validate = {["LEFT"]= L["LEFT"], ["CENTER"]= L["CENTER"], ["RIGHT"]= L["RIGHT"] },
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust spell time position"],
			disabled = function() return not AloftCastWarningTimeText.db.profile.enable end,
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
					get = function() return AloftCastWarningTimeText.db.profile.offsets.left end,
					set = function(v) AloftCastWarningTimeText.db.profile.offsets.left = v AloftCastWarningTimeText:UpdateAll() end
				},
				right =
				{
					type = 'range',
					name = L["Right Offset"],
					desc = L["Sets the offset of the right of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastWarningTimeText.db.profile.offsets.right end,
					set = function(v) AloftCastWarningTimeText.db.profile.offsets.right = v AloftCastWarningTimeText:UpdateAll() end
				},
				vertical =
				{
					type = 'range',
					name = L["Vertical Offset"],
					desc = L["Sets the vertical offset of the text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastWarningTimeText.db.profile.offsets.vertical end,
					set = function(v) AloftCastWarningTimeText.db.profile.offsets.vertical = v AloftCastWarningTimeText:UpdateAll() end
				},
			},
		},
		color =
		{
			type = 'group',
			name = L["Colors"],
			desc = L["Sets the spell time colors"],
			disabled = function() return not AloftCastWarningTimeText.db.profile.enable end,
			args =
			{
				castColor =
				{
					type = 'color',
					name = L["Cast Color"],
					desc = L["Sets the spell time color during active casting"],
					get = function() return unpack(AloftCastWarningTimeText.db.profile.castColor) end,
					set = function(r, g, b, a) AloftCastWarningTimeText.db.profile.castColor = { r, g, b, a } AloftCastWarningSpellNameText:UpdateAll() end,
					hasAlpha = true
				},
				fadeColor =
				{
					type = 'color',
					name = L["Fade Color"],
					desc = L["Sets the spell time color during cast warning fade"],
					get = function() return unpack(AloftCastWarningTimeText.db.profile.fadeColor) end,
					set = function(r, g, b, a) AloftCastWarningTimeText.db.profile.fadeColor = { r, g, b, a } AloftCastWarningSpellNameText:UpdateAll() end,
					hasAlpha = true
				},
			},
		},
	},
}

-----------------------------------------------------------------------------

-- end)