local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------
--
-- To add more presets, create your own files with their data table
-- And add them into Aloft's by using:
--   Aloft:GetModule("Presets"):AddPreset(presetName, presetDataTable)
--
-- The table contains keys which are module db namespaces, and the values
-- that they override from the default
--
-- Guideline list of interrelated variables:
--  healthText: enable, mode, format
--  guildText: enable, attachFormat, attachToName, useShort, showOwn, nameText.format
--  guildText: enable, attachToName, useShort, showOwn, format
--  levelText: enable, showRace, showClassification, showCreatureType, format
--
-----------------------------------------------------------------------------

local L = AloftLocale.AloftPresetsOptions
if not L then return end

local AloftPresets = Aloft:GetModule("Presets", true)
if not AloftPresets then return end

-----------------------------------------------------------------------------

Aloft.Options.args.basic.args.presets =
{
	type = 'select',
	width = 'full',
	name = L["Presets"],
	desc = L["Preset configurations"],
	order = 700,
	disabled = function(i) return not Aloft:IsEnabled() or not AloftPresets:IsEnabled() end,
	get = function(i) return AloftPresets.Last end,
	set = function(i, v) AloftPresets:Set(v) end,
	disabled = function(i) return not Aloft:IsEnabled() end,
	values = AloftPresets.Values,
}

-----------------------------------------------------------------------------

end)
