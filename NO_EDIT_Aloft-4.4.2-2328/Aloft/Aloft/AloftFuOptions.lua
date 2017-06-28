local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftFu", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftFu
if not L then return end

local AloftFu = Aloft:GetModule("Fu", true)
if not AloftFu then return end

-----------------------------------------------------------------------------

Aloft.Options.args.fubar =
{
	type = 'group',
	name = L["Fubar"],
	desc = L["Standard FuBar options"],
	order = 1000,
	disabled = function(i) return not Aloft:IsEnabled() or not AloftFu:IsEnabled() or not AloftFu.db or not AloftFu.db.profile end,
	args =
	{
		icon =
		{
			type = 'toggle',
			width = "full",
			name = L["Show FuBar icon"],
			desc = L["Show the FuBar plugin's icon on the panel."],
			order = 1,
			get = function(i) return AloftFu:IsFuBarIconShown() end,
			set = function(i, v) AloftFu:ToggleFuBarIconShown() end,
		},
		text =
		{
			type = 'toggle',
			width = "full",
			name = L["Show FuBar text"],
			desc = L["Show the FuBar plugin's text on the panel."],
			order = 2,
			get = function(i) return AloftFu:IsFuBarTextShown() end,
			set = function(i, v) AloftFu:ToggleFuBarTextShown() end,
		},
		position =
		{
			type = 'select',
			width = "full",
			name = L["Position on FuBar"],
			desc = L["Position the FuBar plugin on the panel."],
			order = 3,
			get = function(i) return AloftFu:GetPanel() and AloftFu:GetPanel():GetPluginSide(AloftFu) end,
			set = function(i, v)
				if AloftFu:GetPanel() then
					AloftFu:GetPanel():SetPluginSide(AloftFu, v)
				end
			end,
			disabled = function(i) return AloftFu:IsFuBarMinimapAttached() end,
			values =
			{
				["LEFT"] = L["Left"], ["RIGHT"] = L["Right"], ["CENTER"] = L["Center"],
			},
		},
		minimapAttach =
		{
			type = 'toggle',
			width = "full",
			name = L["Attach FuBar plugin to minimap"],
			desc = L["Attach the FuBar plugin to the minimap instead of the panel."],
			get = function(i) return AloftFu:IsFuBarMinimapAttached() end,
			set = function(i, v) AloftFu:ToggleFuBarMinimapAttached() end,
			order = 4,
		},
		hide =
		{
			type = 'toggle',
			width = "full",
			name = L["Hide FuBar Plugin Panel/Minimap Button"],
			desc = L["Hide the FuBar plugin from the panel or minimap, leaving the addon running."],
			order = 5,
			get = function(i) return AloftFu.db.profile.hideMinimapButton end,
			set = function(i, v) 
				AloftFu.db.profile.hideMinimapButton = v
				if v then
					AloftFu:Hide()
				else
					AloftFu:Show()
				end
			end,
		},
	},
}

-----------------------------------------------------------------------------

end)
