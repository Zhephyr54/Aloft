local Aloft = Aloft
if not Aloft or not Aloft:HasModule("SpellIcon") then return end

-----------------------------------------------------------------------------

local AloftSpellIcon = Aloft:GetModule("SpellIcon")
local SML = AceLibrary("LibSharedMedia-3.0")
local L = AceLibrary("AceLocale-2.2"):new("AloftSpellIconOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.castBar.args.spellIcon =
{
	type = 'group',
	name = L["Spell Icon"],
	desc = L["Spell icon placement options"],
	disabled = function() return not Aloft:IsActive() or GetCVar("ShowVKeyCastbar") ~= "1" end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable spell icon display on the nameplate"],
			get = function() return AloftSpellIcon.db.profile.enable end,
			set = function(v) AloftSpellIcon.db.profile.enable = v AloftSpellIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust spell icon position"],
			disabled = function() return not AloftSpellIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the spell icon"],
					get = function() return AloftSpellIcon.db.profile.point end,
					set = function(v) AloftSpellIcon.db.profile.point = v AloftSpellIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the cast bar to anchor the spell icon"],
					get = function() return AloftSpellIcon.db.profile.relativeToPoint end,
					set = function(v) AloftSpellIcon.db.profile.relativeToPoint = v AloftSpellIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftSpellIcon.db.profile.offsetX end,
					set = function(v) AloftSpellIcon.db.profile.offsetX = v AloftSpellIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftSpellIcon.db.profile.offsetY end,
					set = function(v) AloftSpellIcon.db.profile.offsetY = v AloftSpellIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			name = L["Size"],
			desc = L["Size in pixels of the spell icon"],
			min = 4,
			max = 32,
			step = 1,
			disabled = function() return not AloftSpellIcon.db.profile.enable end,
			get = function() return AloftSpellIcon.db.profile.size end,
			set = function(v) AloftSpellIcon.db.profile.size = v AloftSpellIcon:UpdateAll() end
		},
		shield =
		{
			type = 'group',
			name = L["Shield"],
			desc = L["Shows a shield graphic around an uninterruptable spell icon"],
			disabled = function() return not AloftSpellIcon.db.profile.enable end,
			args =
			{
				enable =
				{
					type = 'toggle',
					name = L["Enable"],
					desc = L["Enables the shield graphic"],
					get = function() return AloftSpellIcon.db.profile.nointerShield end,
					set = function(v)
						AloftSpellIcon.db.profile.nointerShield = v
						AloftSpellIcon:UpdateAll()
					end,
				},
				style =
				{
					type = "text",
					name = L["Style"],
					desc = L["Sets the shield graphic style"],
					order = 8,
					disabled = function() return not AloftSpellIcon.db.profile.enable or not AloftSpellIcon.db.profile.nointerShield end,
					get = function() return AloftSpellIcon.db.profile.nointerStyle end,
					set = function(v) AloftSpellIcon.db.profile.nointerStyle = v AloftSpellIcon:UpdateAll() end,
					validate =
					{
						["ROUND"]				= L["ROUND"],
						["SQUARE"]				= L["SQUARE"],
					},
				},
				color =
				{
					type = 'color',
					name = L["Color"],
					desc = L["Sets the shield graphic color"],
					order = 1,
					disabled = function() return not AloftSpellIcon.db.profile.enable or not AloftSpellIcon.db.profile.nointerShield end,
					get = function() return unpack(AloftSpellIcon.db.profile.nointerColor) end,
					set = function(r, g, b, a) AloftSpellIcon.db.profile.nointerColor = { r, g, b, a } AloftSpellIcon:UpdateAll() end,
					hasAlpha = true,
				},
			},
		},
	},
}

-----------------------------------------------------------------------------
