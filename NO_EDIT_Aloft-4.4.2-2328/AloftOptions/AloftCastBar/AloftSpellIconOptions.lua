local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local L = AloftLocale.AloftSpellIconOptions
if not L then return end

local AloftSpellIcon = Aloft:GetModule("SpellIcon", true)
if not AloftSpellIcon then return end

local SML = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------------

Aloft.Options.args.castBar.args.spellIcon =
{
	type = 'group',
	name = L["Spell Icon"],
	desc = L["Spell icon placement options"],
	disabled = function(i)
					-- ChatFrame7:AddMessage("Aloft.Options.args.castBar.args.spellIcon.disabled(): " .. tostring(AloftSpellIcon:IsEnabled()) .. "/" .. tostring(AloftSpellIcon:IsEnabled()) .. "/" .. tostring(AloftSpellIcon.db and AloftSpellIcon.db.profile) .. "/" .. tostring(Aloft:GetNameplateCVar("ShowVKeyCastbar")))
					return not Aloft:IsEnabled() or not AloftSpellIcon:IsEnabled() or not AloftSpellIcon.db or not AloftSpellIcon.db.profile or not Aloft:GetNameplateCVar("ShowVKeyCastbar")
			   end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			width = 'full',
			name = L["Enable"],
			desc = L["Enable spell icon display on the nameplate"],
			disabled = function(i) return not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			get = function(i) return AloftSpellIcon.db.profile.enable end,
			set = function(i, v) AloftSpellIcon.db.profile.enable = v AloftSpellIcon:UpdateAll() end,
			order = 1
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust spell icon position"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftSpellIcon:IsEnabled() or not AloftSpellIcon.db or not AloftSpellIcon.db.profile or not AloftSpellIcon.db.profile.enable or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			args =
			{
				anchor = {
					type = 'select',
					width = 'full',
					name = L["Anchor"],
					desc = L["Sets the anchor for the spell icon"],
					get = function(i) return AloftSpellIcon.db.profile.point end,
					set = function(i, v) AloftSpellIcon.db.profile.point = v AloftSpellIcon:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = 'select',
					width = 'full',
					name = L["Anchor To"],
					desc = L["Sets the relative point on the cast bar to anchor the spell icon"],
					get = function(i) return AloftSpellIcon.db.profile.relativeToPoint end,
					set = function(i, v) AloftSpellIcon.db.profile.relativeToPoint = v AloftSpellIcon:UpdateAll() end,
					values = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X offset of the spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function(i) return AloftSpellIcon.db.profile.offsetX end,
					set = function(i, v) AloftSpellIcon.db.profile.offsetX = v AloftSpellIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y offset of the spell icon"],
					min = -32,
					max = 32,
					step = 1,
					get = function(i) return AloftSpellIcon.db.profile.offsetY end,
					set = function(i, v) AloftSpellIcon.db.profile.offsetY = v AloftSpellIcon:UpdateAll() end
				},
			},
		},
		size =
		{
			type = 'range',
			width = 'full',
			name = L["Size"],
			desc = L["Size in pixels of the spell icon"],
			min = 4,
			max = 32,
			step = 1,
			disabled = function(i) return not AloftSpellIcon.db.profile.enable or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			get = function(i) return AloftSpellIcon.db.profile.size end,
			set = function(i, v) AloftSpellIcon.db.profile.size = v AloftSpellIcon:UpdateAll() end
		},
		shield =
		{
			type = 'group',
			width = 'full',
			name = L["Shield"],
			desc = L["Shows a shield graphic around an uninterruptable spell icon"],
			disabled = function(i) return not Aloft:IsEnabled() or not AloftSpellIcon:IsEnabled() or not AloftSpellIcon.db or not AloftSpellIcon.db.profile or not AloftSpellIcon.db.profile.enable or not Aloft:GetNameplateCVar("ShowVKeyCastbar") end,
			args =
			{
				enable =
				{
					type = 'toggle',
					width = 'full',
					name = L["Enable"],
					desc = L["Enables the shield graphic"],
					get = function(i) return AloftSpellIcon.db.profile.nointerShield end,
					set = function(i, v)
						AloftSpellIcon.db.profile.nointerShield = v
						AloftSpellIcon:UpdateAll()
					end,
				},
				style =
				{
					type = 'select',
					width = 'full',
					name = L["Style"],
					desc = L["Sets the shield graphic style"],
					order = 8,
					disabled = function(i) return not AloftSpellIcon.db.profile.enable or not AloftSpellIcon.db.profile.nointerShield end,
					get = function(i)
						for k, v in pairs(Aloft.Options.args.castBar.args.spellIcon.args.shield.args.style.values) do
							if v == AloftSpellIcon.db.profile.nointerStyle then
								-- ChatFrame7:AddMessage("Aloft.Options.args.castBar.args.spellIcon.args.shield.args.style.get(): " .. tostring(k))
								return k
							end
						end
					end,
					set = function(i, v)
						AloftSpellIcon.db.profile.nointerStyle = Aloft.Options.args.castBar.args.spellIcon.args.shield.args.style.values[v]
						-- ChatFrame7:AddMessage("Aloft.Options.args.castBar.args.spellIcon.args.shield.args.style.set(): " .. tostring(AloftSpellIcon.db.profile.nointerStyle))
						AloftSpellIcon:UpdateAll()
					end,
					values = SML:List("shield"),
				},
				scale =
				{
					type = 'range',
					width = 'full',
					name = L["Scale"],
					desc = L["Scale of the shield graphic"],
					min = 1,
					max = 8,
					step = 0.01,
					disabled = function(i) return not AloftSpellIcon.db.profile.enable or not AloftSpellIcon.db.profile.nointerShield end,
					get = function(i) return AloftSpellIcon.db.profile.nointerScale end,
					set = function(i, v) AloftSpellIcon.db.profile.nointerScale = v AloftSpellIcon:UpdateAll() end
				},
				color =
				{
					type = 'color',
					width = 'full',
					name = L["Color"],
					desc = L["Sets the shield graphic color"],
					order = 1,
					disabled = function(i) return not AloftSpellIcon.db.profile.enable or not AloftSpellIcon.db.profile.nointerShield end,
					get = function(i) return unpack(AloftSpellIcon.db.profile.nointerColor) end,
					set = function(i, r, g, b, a) AloftSpellIcon.db.profile.nointerColor = { r, g, b, a } AloftSpellIcon:UpdateAll() end,
					hasAlpha = true,
				},
				offsetX =
				{
					type = 'range',
					width = 'full',
					name = L["X Offset"],
					desc = L["X Offset"],
					min = -32,
					max = 32,
					step = 1,
					disabled = function(i) return not AloftSpellIcon.db.profile.enable or not AloftSpellIcon.db.profile.nointerShield end,
					get = function(i) return AloftSpellIcon.db.profile.nointerOffsetX end,
					set = function(i, v) AloftSpellIcon.db.profile.nointerOffsetX = v AloftSpellIcon:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					width = 'full',
					name = L["Y Offset"],
					desc = L["Y Offset"],
					min = -32,
					max = 32,
					step = 1,
					disabled = function(i) return not AloftSpellIcon.db.profile.enable or not AloftSpellIcon.db.profile.nointerShield end,
					get = function(i) return AloftSpellIcon.db.profile.nointerOffsetY end,
					set = function(i, v) AloftSpellIcon.db.profile.nointerOffsetY = v AloftSpellIcon:UpdateAll() end
				},
			},
		},
	},
}

-----------------------------------------------------------------------------
