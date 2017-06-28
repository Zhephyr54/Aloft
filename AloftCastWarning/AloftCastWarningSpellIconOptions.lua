local Aloft = Aloft
if not Aloft then return end
-- local AloftModules = AloftModules
-- if not AloftModules then return end

-----------------------------------------------------------------------------

-- AloftModules:AddInitializer("AloftCastWarning", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("CastWarning") or not Aloft:HasModule("CastWarningSpellIcon") then return end

local AloftCastWarning = Aloft:GetModule("CastWarning")
local AloftCastWarningSpellIcon = Aloft:GetModule("CastWarningSpellIcon")

local L = AceLibrary("AceLocale-2.2"):new("AloftCastWarningSpellIconOptions")

-----------------------------------------------------------------------------

Aloft.Options.args.castWarning.args.castWarningSpellIcon =
{
	type = 'group',
	name = L["Spell Icon"],
	desc = L["Cast warning spell icon placement options"],
	disabled = function() return not AloftCastWarning.aloftDB.profile.enable end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Enable cast warning spell icon display on the nameplate"],
			get = function() return AloftCastWarningSpellIcon.db.profile.enable end,
			set = function(v) AloftCastWarningSpellIcon.db.profile.enable = v AloftCastWarningSpellIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust cast warning spell icon position"],
			disabled = function() return not AloftCastWarningSpellIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the cast warning spell icon"],
					get = function() return AloftCastWarningSpellIcon.db.profile.point end,
					set = function(v) AloftCastWarningSpellIcon.db.profile.point = v AloftCastWarningSpellIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the cast warning to anchor the spell icon"],
					get = function() return AloftCastWarningSpellIcon.db.profile.relativeToPoint end,
					set = function(v) AloftCastWarningSpellIcon.db.profile.relativeToPoint = v AloftCastWarningSpellIcon:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the cast warning spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastWarningSpellIcon.db.profile.offsetX end,
					set = function(v) AloftCastWarningSpellIcon.db.profile.offsetX = v AloftCastWarningSpellIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the cast warning spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCastWarningSpellIcon.db.profile.offsetY end,
					set = function(v) AloftCastWarningSpellIcon.db.profile.offsetY = v AloftCastWarningSpellIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			name = L["Size"],
			desc = L["Size in pixels of the cast warning spell icon"],
			min = 4,
			max = 32,
			step = 1,
			disabled = function() return not AloftCastWarningSpellIcon.db.profile.enable end,
			get = function() return AloftCastWarningSpellIcon.db.profile.size end,
			set = function(v) AloftCastWarningSpellIcon.db.profile.size = v AloftCastWarningSpellIcon:UpdateAll() end
		},
		shield =
		{
			type = 'group',
			name = L["Shield"],
			desc = L["Shows a shield graphic around an uninterruptable spell icon"],
			disabled = function() return not AloftCastWarningSpellIcon.db.profile.enable end,
			args =
			{
				enable =
				{
					type = 'toggle',
					name = L["Enable"],
					desc = L["Enables the shield graphic"],
					get = function() return AloftCastWarningSpellIcon.db.profile.nointerShield end,
					set = function(v)
						AloftCastWarningSpellIcon.db.profile.nointerShield = v
						AloftCastWarningSpellIcon:UpdateAll()
					end,
				},
				style =
				{
					type = "text",
					name = L["Style"],
					desc = L["Sets the shield graphic style"],
					order = 8,
					disabled = function() return not AloftCastWarningSpellIcon.db.profile.enable or not AloftCastWarningSpellIcon.db.profile.nointerShield end,
					get = function() return AloftCastWarningSpellIcon.db.profile.nointerStyle end,
					set = function(v) AloftCastWarningSpellIcon.db.profile.nointerStyle = v AloftCastWarningSpellIcon:UpdateAll() end,
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
					disabled = function() return not AloftCastWarningSpellIcon.db.profile.enable or not AloftCastWarningSpellIcon.db.profile.nointerShield end,
					get = function() return unpack(AloftCastWarningSpellIcon.db.profile.nointerColor) end,
					set = function(r, g, b, a) AloftCastWarningSpellIcon.db.profile.nointerColor = { r, g, b, a } AloftCastWarningSpellIcon:UpdateAll() end,
					hasAlpha = true,
				},
			},
		},
	},
}

-----------------------------------------------------------------------------

-- end)
