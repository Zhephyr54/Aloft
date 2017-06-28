local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftThreat", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("ThreatText") then return end

local AloftThreatText = Aloft:GetModule("ThreatText")
local L = AceLibrary("AceLocale-2.2"):new("AloftThreatTextOptions")
local SML = AceLibrary("LibSharedMedia-3.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

local threatTags =
{
	NONE				= "",
	PERCENT				= "[ThreatFraction:Percent]",
	THREAT				= "[Threat]",
	THREATANDPERCENT	= "[Threat:Short:Suffix(\" (\")][ThreatFraction:Percent:Suffix(\")\")]",
	DEFICIT				= "[ThreatDeficit:HideZero:Short]",
	FULL				= "[Threat:Short:Suffix(\"/\")][MaxThreat:Short:Suffix(\" (\")][ThreatFraction:Percent:Suffix(\")\")]",
}

-----------------------------------------------------------------------------

AloftThreatText.options =
{
	type = 'group',
	name = L["Threat Text"],
	desc = L["Threat text options"],
	disabled = function() return not Aloft:IsActive() end,
	order = -1,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show threat text on nameplates"],
			get = function() return AloftThreatText.db.profile.enable end,
			set = function(v) AloftThreatText.db.profile.enable = v AloftThreatText:UpdateTag() AloftThreatText:UpdateAll() end,
			order = 1,
		},
		activeWhileSolo =
		{
			type = 'toggle',
			name = L["Active While Solo"],
			desc = L["Show threat text on nameplates while solo (for classes with pets and guardians)"],
			disabled = function() return not AloftThreatText.db.profile.enable end,
			get = function() return AloftThreatText.db.profile.activeWhileSolo end,
			set = function(v) AloftThreatText.db.profile.activeWhileSolo = v AloftThreatText:UpdateTag() AloftThreatText:UpdateAll() end,
			order = 2,
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Threat text typeface options"],
			disabled = function() return not AloftThreatText.db.profile.enable end,
			order = 3,
			args =
			{
				font =
				{
					type = "text",
					name = L["Font"],
					desc = L["Sets the font for threat text"],
					get = function() return AloftThreatText.db.profile.font end,
					set = function(v)
						AloftThreatText.db.profile.font = v
						AloftThreatText:UpdateAll()
					end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the threat text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftThreatText.db.profile.fontSize end,
					set = function(value) AloftThreatText.db.profile.fontSize = value AloftThreatText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on threat text"],
					get = function() return AloftThreatText.db.profile.shadow end,
					set = function(v) AloftThreatText.db.profile.shadow = v AloftThreatText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the outline for threat text"],
					get = function() return AloftThreatText.db.profile.outline end,
					set = function(value) AloftThreatText.db.profile.outline = value AloftThreatText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		mode =
		{
			type = 'text',
			name = L["Mode"],
			desc = L["Choose what to show for threat text"],
			disabled = function() return not AloftThreatText.db.profile.enable end,
			get = function() return AloftThreatText.db.profile.mode end,
			set = function(value) AloftThreatText.db.profile.mode = value AloftThreatText:UpdateTag() AloftThreatText:UpdateAll() end,
			validate = { PERCENT = L["Percent"], THREAT = L["Threat"], THREATANDPERCENT = L["Threat & Percent"], DEFICIT = L["Deficit"], FULL = L["Full"] },
			order = 3,
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust threat text position"],
			disabled = function() return not AloftThreatText.db.profile.enable end,
			order = 3,
			args =
			{
				anchor = {
					type = "text",
					name = L["Anchor"],
					desc = L["Sets the anchor for the threat text"],
					get = function() return AloftThreatText.db.profile.point end,
					set = function(v) AloftThreatText.db.profile.point = v AloftThreatText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text",
					name = L["Anchor To"],
					desc = L["Sets the relative point on the threat bar to anchor the threat text"],
					get = function() return AloftThreatText.db.profile.relativeToPoint end,
					set = function(v) AloftThreatText.db.profile.relativeToPoint = v AloftThreatText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the threat text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftThreatText.db.profile.offsetX end,
					set = function(v) AloftThreatText.db.profile.offsetX = v AloftThreatText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the threat text"],
					min = -128,
					max = 128,
					step = 1,
					get = function() return AloftThreatText.db.profile.offsetY end,
					set = function(v) AloftThreatText.db.profile.offsetY = v AloftThreatText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the alpha of the threat text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			order = 3,
			disabled = function() return not AloftThreatText.db.profile.enable end,
			get = function() return AloftThreatText.db.profile.alpha end,
			set = function(v) AloftThreatText.db.profile.alpha = v AloftThreatText:UpdateAll() end
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the threat text color"],
			disabled = function() return not AloftThreatText.db.profile.enable end,
			get = function() return unpack(AloftThreatText.db.profile.color) end,
			set = function(r, g, b, a) AloftThreatText.db.profile.color = { r, g, b, a } AloftThreatText:UpdateAll() end,
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function() return not AloftThreatText.db.profile.enable end,
			args =
			{
				format =
				{
					type = 'text',
					name = L["Format"],
					desc = L["Threat tag"],
					usage = L["<Any tag string>"],
					get = function() return Aloft:HighlightTagSyntax(AloftThreatText.db.profile.format) end,
					set =	function(v)
								AloftThreatText.db.profile.format = Aloft:FixTagCasing(v)
								AloftThreatText.textMethodData = nil
								AloftThreatText.textMethod = nil
								Aloft:DetermineDataSources()
								AloftThreatText:UpdateAll()
							end,
				}
			},
		},
	},
}

-- stitch the options in based on what optional dependencies are enabled; the TOC will have guaranteed load order if they are enabled
if (Aloft.Options.args.threatBar and Aloft.Options.args.threatBar.args) then
	Aloft.Options.args.threatBar.args.threatText = AloftThreatText.options
else
	AloftThreatText.options.order = nil -- reorder to take the place of the bar options (sort alphabetically)
	Aloft.Options.args.threatText = AloftThreatText.options
end

-----------------------------------------------------------------------------

function AloftThreatText:UpdateTag()
	local tag = self.db.profile.mode
	--if (Aloft:IsLogEnbl("ThreatText", 3)) then Aloft:Log("ThreatText", "UpdateTag", 3, "tag " .. tostring(tag)) end
	if not self.db.profile.enable then tag = "NONE"	end
	self.db.profile.format = threatTags[tag]

	self.textMethodData = nil
	self.textMethod = nil

	Aloft:DetermineDataSources()
end

-----------------------------------------------------------------------------

end)