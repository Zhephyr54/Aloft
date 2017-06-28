local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

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

if not Aloft:HasModule("Presets") then return end

local AloftPresets = Aloft:GetModule("Presets")
local L = AceLibrary("AceLocale-2.2"):new("AloftPresets")

-----------------------------------------------------------------------------

Aloft.Options.args.presets.type = 'text'
Aloft.Options.args.presets.name = L["Presets"]
Aloft.Options.args.presets.desc = L["Preset configurations"]
Aloft.Options.args.presets.order = 700
Aloft.Options.args.presets.get = function() return lastPreset end
Aloft.Options.args.presets.set = function(v) AloftPresets:Set(v) end
Aloft.Options.args.presets.disabled = function() return not Aloft:IsActive() end

-----------------------------------------------------------------------------

end)
