local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftCommentTextOptions
if not L then return end

local AloftCommentText = Aloft:GetModule("CommentText", true)
if not AloftCommentText then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.comment =
{
	type = 'group',
	name = L["Comment Text"],
	desc = L["Comment text options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCommentText:IsEnabled() or not AloftCommentText.db or not AloftCommentText.db.profile end,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Show comments on nameplates"],
			get = function(i) return AloftCommentText.db.profile.enable end,
			set = function(i, v) AloftCommentText.db.profile.enable = v AloftCommentText:UpdateTag() AloftCommentText:UpdateAll() end,
			order = 1
		},
		setComment =
		{
			type = 'input',
			width = 'full',
			name = L["Set Comment"],
			desc = L["Sets the comment for your current target"],
			usage = L["<Any String>"],
			disabled = function(i) return not AloftCommentText.db.profile.enable end,
			get = function(i) return "" end,
			set = function(i, v)
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
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCommentText:IsEnabled() or not AloftCommentText.db or not AloftCommentText.db.profile or not AloftCommentText.db.profile.enable end,
			args =
			{
				font =
				{
					type = 'select',
					width = 'full',
					name = L["Font"],
					desc = L["Sets the font for comment text"],
					get = function(i)
						for k, v in pairs(Aloft.Options.args.comment.args.typeface.args.font.values) do
							if v == AloftCommentText.db.profile.font then
								return k
							end
						end
					end,
					set = function(i, v)
						AloftCommentText.db.profile.font = Aloft.Options.args.comment.args.typeface.args.font.values[v]
						AloftCommentText:UpdateAll()
					end,
					values = SML:List("font"),
				},
				fontSize =
				{
					type = 'range',
					width = 'full',
					name = L["Font Size"],
					desc = L["Sets the font height of the comment text"],
					max = 16,
					min = 5,
					step = 1,
					get = function(i) return AloftCommentText.db.profile.fontSize end,
					set = function(i, value) AloftCommentText.db.profile.fontSize = value AloftCommentText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					width = 'full',
					name = L["Font Shadow"],
					desc = L["Show font shadow on comment text"],
					get = function(i) return AloftCommentText.db.profile.shadow end,
					set = function(i, v) AloftCommentText.db.profile.shadow = v AloftCommentText:UpdateAll() end
				},
				outline =
				{
					type = 'select',
					width = 'full',
					name = L["Outline"],
					desc = L["Sets the outline for comment text"],
					get = function(i) return AloftCommentText.db.profile.outline end,
					set = function(i, value) AloftCommentText.db.profile.outline = value AloftCommentText:UpdateAll() end,
					values = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust comment tag position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCommentText:IsEnabled() or not AloftCommentText.db or not AloftCommentText.db.profile or not AloftCommentText.db.profile.enable end,
			args =
			{
				anchor = {
					type = 'select',
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the comment text"],
					get = function(i) return AloftCommentText.db.profile.point end,
					set = function(i, v) AloftCommentText.db.profile.point = v AloftCommentText:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = 'select',
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the health bar to anchor the comment text"],
					get = function(i) return AloftCommentText.db.profile.relativeToPoint end,
					set = function(i, v) AloftCommentText.db.profile.relativeToPoint = v AloftCommentText:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the comment text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftCommentText.db.profile.offsetX end,
					set = function(i, v) AloftCommentText.db.profile.offsetX = v AloftCommentText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the comment text"],
					min = -128,
					max = 128,
					step = 1,
					get = function(i) return AloftCommentText.db.profile.offsetY end,
					set = function(i, v) AloftCommentText.db.profile.offsetY = v AloftCommentText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			width = 'full',
			name = L["Alpha"],
			desc = L["Sets the alpha of the comment text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function(i) return not AloftCommentText.db.profile.enable end,
			get = function(i) return AloftCommentText.db.profile.alpha end,
			set = function(i, v) AloftCommentText.db.profile.alpha = v AloftCommentText:UpdateAll() end
		},
		color =
		{
			type = 'color',
			width = 'full',
			name = L["Color"],
			desc = L["Sets the comment text color"],
			disabled = function(i) return not AloftCommentText.db.profile.enable end,
			get = function(i) return unpack(AloftCommentText.db.profile.color) end,
			set = function(i, r, g, b, a) AloftCommentText.db.profile.color = { r, g, b, a } AloftCommentText:UpdateAll() end,
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCommentText:IsEnabled() or not AloftCommentText.db or not AloftCommentText.db.profile or not AloftCommentText.db.profile.enable end,
			args =
			{
				format =
				{
					type = 'input',
					width = 'full',
					name = L["Format"],
					desc = L["Comment tag"],
					usage = L["<Any tag string>"],
					get = function(i) return Aloft:HighlightTagSyntax(AloftCommentText.db.profile.format) end,
					set =	function(i, v)
								AloftCommentText.db.profile.format = Aloft:FixTagCasing(v)
								AloftCommentText.textMethodData = nil
								AloftCommentText.textMethod = nil
								Aloft:DetermineDataSources()
								AloftCommentText:UpdateAll()
							end,
					disabled = function(i) return not Aloft:IsEnabled() or not AloftCommentText:IsEnabled() or not AloftCommentText.db or not AloftCommentText.db.profile or not AloftCommentText.db.profile.enable end,
				}
			},
		},
	},
}

-----------------------------------------------------------------------------

end)
