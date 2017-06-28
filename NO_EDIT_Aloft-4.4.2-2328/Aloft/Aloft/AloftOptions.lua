local Aloft = Aloft
if not Aloft then return end

if not AloftLocale or not AloftLocale.Aloft then return end

-----------------------------------------------------------------------------

local AceDialog = LibStub("AceConfigDialog-3.0")

local L = AloftLocale.Aloft

local N = L["Aloft"] .. "-" .. Aloft.version

-----------------------------------------------------------------------------

-- just the absolute minimum of options required to trigger loading of AloftOptions, at which point the rest will appear
Aloft.Options =
{
	handler = Aloft,
	type = 'group',
	args =
	{
		options =
		{
			type = 'execute',
			name = L["Load Options"],
			func = function(i) --[[InterfaceOptionsFrame_OpenToCategory(Aloft.optionsFrame)]] Aloft:EnableOptions() --[[AceDialog:Open(N)]] end,
			order = 950,
			-- dialogHidden = true,
			dropdownHidden = true,
			cmdHidden = true,
			-- guiHidden = true,
		},
		gui =
		{
			type = 'execute',
			name = L["gui"],
			func = function(i) --[[InterfaceOptionsFrame_OpenToCategory(Aloft.optionsFrame)]] Aloft:EnableOptions() AceDialog:Open(N) end,
			order = 950,
			guiHidden = true,
		},
	},
}

-----------------------------------------------------------------------------
