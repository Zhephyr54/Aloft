local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CommentText") then return end
local AloftCommentText = Aloft:GetModule("CommentText")

local L = AceLibrary("AceLocale-2.2"):new("AloftCommentTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

Aloft.Options.args.comment =
{
	type = 'group',
	name = L["Comment Text"],
	desc = L["Comment text options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show comments on nameplates"],
			get = function() return AloftCommentText.db.profile.enable end,
			set = function(v) AloftCommentText.db.profile.enable = v AloftCommentText:UpdateTag() AloftCommentText:UpdateAll() end,
			order = 1
		},
		setComment =
		{
			type = 'text',
			name = L["Set Comment"],
			desc = L["Sets the comment for your current target"],
			usage = L["<Any String>"],
			disabled = function() return not AloftCommentText.db.profile.enable end,
			get = function() return "" end,
			set = function(v)
					local setFor = Aloft:GetModule("CommentData"):SetCommentForTarget(v)
					if setFor then
						Aloft:Print(string.format(L["CommentAdded"], setFor, v))
					else
						Aloft:Print(L["NoSetComment"])
					end
				  end,
			order = 2
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Comment typeface options"],
			disabled = function() return not AloftCommentText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for comment text"],
					get = function() return AloftCommentText.db.profile.font end,
					set = function(v)
						AloftCommentText.db.profile.font = v
						AloftCommentText:UpdateAll()
					end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the comment text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftCommentText.db.profile.fontSize end,
					set = function(value) AloftCommentText.db.profile.fontSize = value AloftCommentText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on comment text"],
					get = function() return AloftCommentText.db.profile.shadow end,
					set = function(v) AloftCommentText.db.profile.shadow = v AloftCommentText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the outline for comment text"],
					get = function() return AloftCommentText.db.profile.outline end,
					set = function(value) AloftCommentText.db.profile.outline = value AloftCommentText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust comment tag position"],
			disabled = function() return not AloftCommentText.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the comment text"],
					get = function() return AloftCommentText.db.profile.point end,
					set = function(v) AloftCommentText.db.profile.point = v AloftCommentText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the comment text"],
					get = function() return AloftCommentText.db.profile.relativeToPoint end,
					set = function(v) AloftCommentText.db.profile.relativeToPoint = v AloftCommentText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the comment text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftCommentText.db.profile.offsetX end,
					set = function(v) AloftCommentText.db.profile.offsetX = v AloftCommentText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the comment text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftCommentText.db.profile.offsetY end,
					set = function(v) AloftCommentText.db.profile.offsetY = v AloftCommentText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the alpha of the comment text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftCommentText.db.profile.enable end,
			get = function() return AloftCommentText.db.profile.alpha end,
			set = function(v) AloftCommentText.db.profile.alpha = v AloftCommentText:UpdateAll() end
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the comment text color"],
			disabled = function() return not AloftCommentText.db.profile.enable end,
			get = function() return unpack(AloftCommentText.db.profile.color) end,
			set = function(r, g, b, a) AloftCommentText.db.profile.color = { r, g, b, a } AloftCommentText:UpdateAll() end,
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function() return not AloftCommentText.db.profile.enable end,
			args =
			{
				format =
				{
					type = 'text',
					name = L["Format"],
					desc = L["Comment tag"],
					usage = L["<Any tag string>"],
					get = function() return Aloft:HighlightTagSyntax(AloftCommentText.db.profile.format) end,
					set =	function(v)
								AloftCommentText.db.profile.format = Aloft:FixTagCasing(v)
								AloftCommentText.textMethodData = nil
								AloftCommentText.textMethod = nil
								Aloft:DetermineDataSources()
								AloftCommentText:UpdateAll()
							end,
				}
			},
		},
	},
}

-----------------------------------------------------------------------------

end)
