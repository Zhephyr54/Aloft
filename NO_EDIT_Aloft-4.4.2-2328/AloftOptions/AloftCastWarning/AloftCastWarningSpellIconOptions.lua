local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftCastWarningSpellIcon", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftCastWarningSpellIconOptions
if not L then return end

local AloftCastWarning = Aloft:GetModule("CastWarning", true)
if not AloftCastWarning then return end

local AloftCastWarningSpellIcon = Aloft:GetModule("CastWarningSpellIcon", true)
if not AloftCastWarningSpellIcon then return end

-----------------------------------------------------------------------------

Aloft.Options.args.castWarning.args.castWarningSpellIcon =
{
	type = 'group',
	name = L["Spell Icon"],
	desc = L["Cast warning spell icon placement options"],
	disabled = function(i) return not Aloft:IsEnabled() or not AloftCastWarning:IsEnabled() or not AloftCastWarning.db or not AloftCastWarning.db.profile or not AloftCastWarning.db.profile.enable or not AloftCastWarningSpellIcon:IsEnabled() or not AloftCastWarningSpellIcon.db or not AloftCastWarningSpellIcon.db.profile end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Enable cast warning spell icon display on the nameplate"],
			get = function(i) return AloftCastWarningSpellIcon.db.profile.enable end,
			set = function(i, v) AloftCastWarningSpellIcon.db.profile.enable = v AloftCastWarningSpellIcon:UpdateAll() end,
			order = 1,
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust cast warning spell icon position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastWarning:IsEnabled() or not AloftCastWarning.db or not AloftCastWarning.db.profile or not AloftCastWarning.db.profile.enable or not AloftCastWarningSpellIcon:IsEnabled() or not AloftCastWarningSpellIcon.db or not AloftCastWarningSpellIcon.db.profile or not AloftCastWarningSpellIcon.db.profile.enable end,
			args =
			{
				anchor = {
					type = 'select',
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the cast warning spell icon"],
					get = function(i) return AloftCastWarningSpellIcon.db.profile.point end,
					set = function(i, v) AloftCastWarningSpellIcon.db.profile.point = v AloftCastWarningSpellIcon:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = 'select',
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the cast warning to anchor the spell icon"],
					get = function(i) return AloftCastWarningSpellIcon.db.profile.relativeToPoint end,
					set = function(i, v) AloftCastWarningSpellIcon.db.profile.relativeToPoint = v AloftCastWarningSpellIcon:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the cast warning spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function(i) return AloftCastWarningSpellIcon.db.profile.offsetX end,
					set = function(i, v) AloftCastWarningSpellIcon.db.profile.offsetX = v AloftCastWarningSpellIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the cast warning spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function(i) return AloftCastWarningSpellIcon.db.profile.offsetY end,
					set = function(i, v) AloftCastWarningSpellIcon.db.profile.offsetY = v AloftCastWarningSpellIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			width = 'full',
			name = L["Size"],
			desc = L["Size in pixels of the cast warning spell icon"],
			min = 4,
			max = 32,
			step = 1,
			disabled = function(i) return not AloftCastWarningSpellIcon.db.profile.enable end,
			get = function(i) return AloftCastWarningSpellIcon.db.profile.size end,
			set = function(i, v) AloftCastWarningSpellIcon.db.profile.size = v AloftCastWarningSpellIcon:UpdateAll() end
		},
		shield =
		{
			type = 'group',
			name = L["Shield"],
			desc = L["Shows a shield graphic around an uninterruptable spell icon"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftCastWarning:IsEnabled() or not AloftCastWarning.db or not AloftCastWarning.db.profile or not AloftCastWarning.db.profile.enable or not AloftCastWarningSpellIcon:IsEnabled() or not AloftCastWarningSpellIcon.db or not AloftCastWarningSpellIcon.db.profile or not AloftCastWarningSpellIcon.db.profile.enable end,
			args =
			{
				enable =
				{
					type = 'toggle',
					width = 'full',
					name = L["Enable"],
					desc = L["Enables the shield graphic"],
					get = function(i) return AloftCastWarningSpellIcon.db.profile.nointerShield end,
					set = function(i, v)
						AloftCastWarningSpellIcon.db.profile.nointerShield = v
						AloftCastWarningSpellIcon:UpdateAll()
					end,
				},
				style =
				{
					type = 'select',
					width = 'full',
					name = L["Style"],
					desc = L["Sets the shield graphic style"],
					order = 8,
					disabled = function(i) return not AloftCastWarningSpellIcon.db.profile.enable or not AloftCastWarningSpellIcon.db.profile.nointerShield end,
					get = function(i) return AloftCastWarningSpellIcon.db.profile.nointerStyle end,
					set = function(i, v) AloftCastWarningSpellIcon.db.profile.nointerStyle = v AloftCastWarningSpellIcon:UpdateAll() end,
					values =
					{
						["ROUND"]				= L["ROUND"],
						["SQUARE"]				= L["SQUARE"],
					},
				},
				color =
				{
					type = 'color',
					width = 'full',
					name = L["Color"],
					desc = L["Sets the shield graphic color"],
					order = 1,
					disabled = function(i) return not AloftCastWarningSpellIcon.db.profile.enable or not AloftCastWarningSpellIcon.db.profile.nointerShield end,
					get = function(i) return unpack(AloftCastWarningSpellIcon.db.profile.nointerColor) end,
					set = function(i, r, g, b, a) AloftCastWarningSpellIcon.db.profile.nointerColor = { r, g, b, a } AloftCastWarningSpellIcon:UpdateAll() end,
					hasAlpha = true,
				},
			},
		},
	},
}

-----------------------------------------------------------------------------

end)
