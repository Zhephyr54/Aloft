local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

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
-- NOTE: the above list is out of date; TODO: update it
--
-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftPresets", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftPresets
if not L then return end

-- it's only a module, so that it can be obtained via Aloft:GetModule("Presets")
local AloftPresets = Aloft:NewModule("Presets", Aloft)
AloftPresets.dynamic = "AloftPresets"

-----------------------------------------------------------------------------

AloftPresets.Values = { }
AloftPresets.Last = ""

local presetData = { }

-----------------------------------------------------------------------------

function AloftPresets:OnInitialize()
	self.initialized = true
end

function AloftPresets:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end
end

function AloftPresets:OnDisable()
end

-----------------------------------------------------------------------------

function AloftPresets:AddPreset(name, data)
	presetData[name] = data
	self.Values[name] = name
end

local function SetKeys(db, keys)
	for k,v in pairs(keys) do
		if type(v) == "table" and db[k] then
			SetKeys(db[k], v)
		else
			db[k] = v
		end
	end
end

function AloftPresets:Set(presetName)
	Aloft.AloftDB:ResetProfile()

	-- TODO: save the previous preset aside

	self.Last = presetName
	local preset = presetData[presetName]
	for _, module in Aloft:IterateModules() do
		local data = module.namespace and preset[module.namespace]
		local profile = module.db and module.db.profile -- mined out of AceDB-3.0's internal data structures; there should be a better way
		if data and profile then
			SetKeys(profile, data)
		end
	end

	-- TODO: restore the previous preset, if necessary
end

-----------------------------------------------------------------------------

local preset1 =
{
	castBar =
	{
		texture			= "Otravi",
	},
	frame =
	{
		border		 	= "Blizzard Tooltip",
		height			= 12,
		packingHeight	= 17,
		backgroundAlpha	= 0.5,
	},
	guildText =
	{
		enable			= true,
	},
	healthBar =
	{
		texture			= "Otravi",
		offsetY			= -6,
	},
	healthText =
	{
		enable			= true,
		mode			= "SMART",
		format			= "[Select(IsFriendly, HealthDeficit:Negate:HideZero:Short:HexColor(\"ff8080\"), Select(Health, Health:Short, HealthFraction:Percent))]",
	},
	levelText =
	{
		offsetY				= 11,
		showCreatureType	= true,
		showClassification	= true,
		format				= "[Level][ShortCreatureType][ShortClassification]",
	},
	nameText =
	{
		offsets =
		{
			right		= -16,
			vertical	= 12,
		},
		format			= "[Name][ShortGuild:Prefix(\" - \")]",
	},
}

local preset2 =
{
	castBar =
	{
		texture			= "Smooth",
	},
	commentText =
	{
		enable			= true,
		shadow			= true,
		outline			= "OUTLINE",
		offsetY			= 0,
	},
	frame =
	{
		height			= 10,
		packingHeight	= 15,
		backgroundAlpha	= 0.5,
		backgroundColors =
		{
			friendlyPlayer	= { 0, 0, 0.8 },
			friendlyPet		= { 0, 0.4, 0 },
			friendlyNPC		= { 0, 0.4, 0 },
			friendlyBoss	= { 0, 0.4, 0 },
			hostilePlayer	= { 0.8, 0, 0 },
			hostilePet		= { 0.8, 0, 0 },
			hostileNPC		= { 0.8, 0, 0 },
			hostileBoss		= { 0.8, 0, 0 },
			neutral			= { 0.6, 0.6, 0 },
			pet				= { 0, 0.4, 0 },
			groupPet		= { 0, 0.4, 0 },
		},
	},
	guildText =
	{
		enable			= true,
	},
	healthBar =
	{
		texture			= "Smooth",
		offsetY			= -5,
	},
	healthText =
	{
		enable			= true,
		mode			= "SMART",
		format			= "[Select(IsFriendly, HealthDeficit:Negate:HideZero:Short:HexColor(\"ff8080\"), Select(Health, Health:Short, HealthFraction:Percent))]",
	},
	levelText =
	{
		offsetY				= 11,
		fontShadow			= true,
		outline				= "",
		shadow				= true,
		showCreatureType	= true,
		showClassification	= true,
		format				= "[Level][ShortCreatureType][ShortClassification]",
	},
	nameText =
	{
		outline			= "",
		shadow			= true,
		offsets =
		{
			right		= -16,
			vertical	= 11,
		},
		format			= "[Name][ShortGuild:Prefix(\" - \")]",
	},
}

local preset3 =
{
	castBar =
	{
		texture			= "Charcoal",
	},
	commentText =
	{
		enable			= true,
		shadow			= true,
		outline			= "OUTLINE",
		offsetY			= 0,
	},
	guildText =
	{
		enable			= true,
	},
	healthBar =
	{
		texture			= "Charcoal",
	},
	levelText =
	{
		enable			= false,
	},
	nameText =
	{
		outline			= "OUTLINE",
		shadow			= true,
		alignment		= "CENTER",
		offsets =
		{
			vertical	= 11,
		},
		format			= "[Name][ShortGuild:Prefix(\" - \")]",
	},
}

local presetAcapela =
{
	aloft =
	{
		interval = 0,
	},
	alpha =
	{
		defaultAlpha = 0.55,
		defaultEnable = true,
		nonTargetAlpha = 0.55,
		nonTargetEnable = true,
		targetEnable = true,
	},
	autoShow =
	{
		friendly =
		{
			state =
			{
				flagged = true,
			},
			place =
			{
				party = true,
				battleground = true,
				raid = true,
				arena = true,
				world = true,
			},
		},
		friendlyTotem =
		{
			state =
			{
				resting = true,
				default = true,
				flagged = true,
				combat = true,
				group = true,
			},
			place =
			{
				party = true,
				battleground = true,
				arena = true,
				raid = true,
				world = true,
			},
		},
		friendlyPet =
		{
			state =
			{
				resting = true,
				default = true,
				flagged = true,
				combat = true,
				group = true,
			},
			place =
			{
				party = true,
				battleground = true,
				arena = true,
				raid = true,
				world = true,
			},
		},
		friendlyGuardian =
		{
			state =
			{
				resting = true,
				default = true,
				flagged = true,
				combat = true,
				group = true,
			},
			place =
			{
				party = true,
				battleground = true,
				arena = true,
				raid = true,
				world = true,
			},
		},
	},
	bossIcon =
	{
		point = "RIGHT",
		relativeToPoint = "RIGHT",
		alpha = 0.65,
		size = 15,
	},
	castBar =
	{
		border = "Skinner Border",
		borderColor =
		{
			nil, -- [1]
			0, -- [2]
			0, -- [3]
		},
		height = 11,
		nointerBorder = "Skinner Border",
		nointerBorderColor =
		{
			0.65, -- [1]
			0, -- [2]
			0, -- [3]
		},
		nointerTexture = "Minimalist",
		offsets =
		{
			vertical = -42,
		},
		texture = "Minimalist",
	},
	castBarTimeText =
	{
		fontSize = 11,
	},
	castWarning =
	{
		border = "Skinner Border",
		borderColor =
		{
			nil, -- [1]
			0, -- [2]
			0, -- [3]
		},
		friendly = true,
		height = 11,
		nointerBorder = "Skinner Border",
		nointerBorderColor =
		{
			0.65, -- [1]
			0, -- [2]
			0, -- [3]
		},
		nointerTexture = "Minimalist",
		offsets =
		{
			vertical = -42,
		},
		texture = "Minimalist",
	},
	castWarningSpellNameText =
	{
		fontSize = 11,
	},
	castWarningTimeText =
	{
		fontSize = 11,
	},
	--[[ TODO: this is not working, fix it
	classColors =
	{
		DEATHKNIGHT =
		{
			0.6, -- [1]
			0.18, -- [2]
			0.18, -- [3]
		},
	},
	]]
	classData =
	{
		save = false,
	},
	classIcon =
	{
		enable = true,
		offsetX = -14,
		relativeToPoint = "RIGHT",
		size = 16,
	},
	combatText =
	{
		enableGroup = true,
		enableOther = true,
		effectGroup = true,
		effectOther = true,
		overHealing	= true,
		offsetX = 32,
		offsetY = 1,
		point = "LEFT",
		relativeToPoint = "RIGHT",
	},
	comboPointsText =
	{
		fontSize = 15,
		offsetX = 8,
		point = "LEFT",
		relativeToPoint = "RIGHT",
	},
	commentData =
	{
		includeHostile = true,
		save = false,
	},
	commentText =
	{
		enable = true,
		fontSize = 11,
		format = "[HideIf(GroupTargetCount <= 0):GroupTargetCount:Angle:Red][TargetName:Surround(\"- \",\" -\"):Red]",
		offsetX = 84,
		offsetY = 20,
		point = "BOTTOMLEFT",
		relativeToPoint = "TOPLEFT",
	},
	crowdControlSpellIcon =
	{
		enable = true,
		point = "LEFT",
		size = 11,
	},
	crowdControlSpellNameText =
	{
		enable = true,
		fontSize = 11,
		offsets =
		{
			left = 16,
			vertical = 1,
		},
	},
	crowdControlTimeText =
	{
		enable = true,
		fontSize = 11,
		offsets =
		{
			right = -5,
			vertical = 1,
		},
	},
	frame =
	{
		backgroundAlpha = 0.35,
		backgroundColors =
		{
			unknown =
			{
				0.2, -- [1]
				0.2, -- [2]
				0.2, -- [3]
			},
		},
		border = "RothSquare",
		borderColor =
		{
			0, -- [1]
			0, -- [2]
			0, -- [3]
		},
		colorByClass = true,
		colorHostileByClass = true,
		height = 16,
		offsetY = 0,
		packingHeight = 32,
		packingWidth = 32,
		width = 180,
	},
	glow =
	{
		combatOnly = false,
		explicit = true,
		height = 88,
		override = true,
		style = "Partial Square Glow",
		threatStatusColors =
		{
			{
				1, -- [1]
				[3] = 0,
			}, -- [1]
			{
				nil, -- [1]
				0.5, -- [2]
				0, -- [3]
			}, -- [2]
			{
				0.75, -- [1]
				0, -- [2]
						}, -- [3]
		},
		width = 230,
	},
	guildData =
	{
		save = false,
	},
	guildText =
	{
		enable = true,
		attachToName = false,
		fontSize = 11,
		format = "[Guild:Angle:HealthBarColor][ShortGuild:Surround(\" (\",\")\"):HealthBarColor][PetOwnersName:Surround(\"<\",\"'s Pet>\"):HealthBarColor][Comment:Angle:HealthBarColor][Faction:Surround(\" (\",\")\"):HealthBarColor]",
		offsetX = 84,
		offsetY = 32,
		point = "BOTTOM",
		relativeToPoint = "TOP",
	},
	healthBar =
	{
		border = "Skinner Border",
		borderColor =
		{
			nil, -- [1]
			0, -- [2]
			0, -- [3]
		},
		colorFormat = "[IsTarget:(IsHostile|IsNeutral):\"ff00ff\"]",
		colors =
		{
			unknown =
			{
				0.2, -- [1]
				0.2, -- [2]
				0.2, -- [3]
			},
		},
		height = 16,
		texture = "Minimalist",
	},
	healthText =
	{
		enable = true,
		fontSize = 10,
		format = "[HealthFraction:Percent:Surround(\"(\",\")\")][HealthDeficit:Surround(\" <\",\">\")][Health:Prefix(\" \")][MaxHealth:Prefix(\"/\")]",
		offsetX = 1,
		point = "LEFT",
		relativeToPoint = "LEFT",
	},
	highlight =
	{
		color =
		{
			nil, -- [1]
			nil, -- [2]
			1, -- [3]
			1, -- [4]
		},
		texture = "Outline",
	},
	levelText =
	{
		fontSize = 15,
		format = "[Level][\"[\":HealthBarColor][Class:HealthBarColor][HideIf(~Class):HideIf(~PowerType):\":\":HealthBarColor][ShortPowerTypeName:PowerTypeColor][\"]\":HealthBarColor][ShortCreatureType:IsFriendly:Cyan][ShortCreatureType:~IsFriendly:Red][Select(Level,ShortClassification,Classification)][ShortRace:IsFriendly:Cyan][ShortRace:~IsFriendly:Red]",
		offsetY = 3,
		overrideText = true,
		point = "BOTTOMRIGHT",
		relativeToPoint = "TOPRIGHT",
		showClassification = true,
		showCreatureType = true,
		showRace = true,
	},
	manaBar =
	{
		enable = true,
		border = "Skinner Border",
		borderColor =
		{
			nil, -- [1]
			0, -- [2]
			0, -- [3]
		},
		height = 11,
		offsets =
		{
			vertical = -17,
		},
		powerTypeColors =
		{
			[3] =
			{
				nil, -- [1]
				0.85, -- [2]
			},
			[0] =
			{
				0.33, -- [1]
				0.62, -- [2]
				1, -- [3]
			},
		},
		texture = "Minimalist",
	},
	manaText =
	{
		enable = true,
		format = "[ManaFraction:Percent:Surround(\"(\", \")\")][ManaDeficit:Angle:Prefix(\" \")][Mana:Prefix(\" \")][MaxMana:Prefix(\"/\")]",
		offsetY = -17,
		point = "TOPLEFT",
		relativeToPoint = "TOPLEFT",
	},
	nameText =
	{
		alignment = "RIGHT",
		font = "DorisPP",
		fontSize = 13,
		format = "[IsTarget:\"> \":Red][PlayerTitlePrefix:Suffix(\" \"):HealthBarColor][Name:HealthBarColor][PlayerTitleSuffixSeparated(\", \", \" \"):HealthBarColor][HideIf(Alias==Name):Alias:Surround(\" (\",\")\"):Cyan][IsTarget:\" <\":Red]",
		offsets =
		{
			vertical = 0,
			left = -540,
			right = -187,
		},
		overrideColors = false,
		useAliases = true,
	},
	polymorph =
	{
		border = "Skinner Border",
		borderColor =
		{
			nil, -- [1]
			0, -- [2]
			0, -- [3]
		},
		height = 11,
		offsets =
		{
			vertical = -55,
		},
		speculativeAttach = false,
		texture = "Minimalist",
	},
	raidIcon =
	{
		alpha = 0.65,
		offsetX = -32,
		point = "RIGHT",
		relativeToPoint = "RIGHT",
		size = 28,
	},
	recentlyDamagedIcon =
	{
		enable = true,
		offsetX = 18,
		point = "LEFT",
		relativeToPoint = "RIGHT",
		size = 15,
	},
	spellNameText =
	{
		fontSize = 11,
	},
	stateIcon =
	{
		offsetX = -8,
		relativeToPoint = "TOPRIGHT",
		offsetY = 8,
	},
	targetTracking =
	{
		trackUnique = true,
	},
	threatBar =
	{
		enable = true,
		border = "Skinner Border",
		borderColor =
		{
			nil, -- [1]
			0, -- [2]
			0, -- [3]
		},
		flashBlendMode = "BLEND",
		flashStyle = "Partial Soft Outline",
		flashHeight = 50,
		flashOffsetY = 0,
		flashWidth = 200,
		flashThreshold = 85,
		height = 11,
		offsets =
		{
			vertical = -30,
		},
		texture = "Minimalist",
	},
	threatData =
	{
		AOEEnable = true,
		groupEnable = true,
	},
	threatText =
	{
		enable = true,
		format = "[ThreatFraction:Percent:Surround(\"(\",\")\")][ThreatDeficit:Integer:Angle:Prefix(\" \")][ShortThreatType:Angle:Prefix(\" \")][Threat:Integer:Prefix(\" \")][MaxThreat:Integer:Prefix(\"/\")]",
		offsetY = -30,
		point = "TOPLEFT",
		relativeToPoint = "TOPLEFT",
	},
	visibility =
	{
		showCritters = false,
		showHostilePets = false,
		showHostilePlayers = false,
		showHostileTotems = false,
	},
}

local presetUnitFrame =
{
	alpha =
	{
		targetEnable = true,
		nonTargetAlpha = 0.5,
		nonTargetEnable = true,
		defaultEnable = true,
		defaultAlpha = 0.5,
	},
	autoShow =
	{
		friendly =
		{
			state =
			{
				default = true,
				group = true,
			},
			place =
			{
				party = true,
				world = true,
				raid = true,
			},
		},
		friendlyPet =
		{
			state =
			{
				default = true,
				group = true,
			},
			place =
			{
				party = true,
				world = true,
				raid = true,
			},
		},
		friendlyGuardian =
		{
			state = 
			{
				default = true,
				group = true,
			},
			place =
			{
				party = true,
				world = true,
				raid = true,
			},
		},
		friendlyTotem =
		{
			state =
			{
				default = true,
				group = true,
			},
			place =
			{
				party = true,
				world = true,
				raid = true,
			},
		},
		overlap =
		{
			state =
			{
				resting = true,
				group = true,
				flagged = true,
				default = true,
			},
			place =
			{
				party = true,
				battleground = true,
				raid = true,
				arena = true,
				world = true,
			},
		},
	},
	bossIcon =
	{
		point = "LEFT",
		offsetX = 20,
		relativeToPoint = "LEFT",
		size = 16,
	},
	castBar =
	{
		height = 9,
		offsets =
		{
			vertical = -32,
		},
	},
	castWarning =
	{
		friendly = true,
		offsets =
		{
			vertical = -32,
		},
	},
	castWarningSpellIcon =
	{
	},
	castWarningSpellNameText =
	{
			left = 16,
			right = 0,
	},
	castWarningTimeText =
	{
			left = 0,
			right = -5,
	},
	classData =
	{
		save = false,
	},
	classIcon =
	{
		point = "LEFT",
		offsetX = 5,
		enable = true,
		offsetY = -7,
		size = 16,
	},
	combatText =
	{
		enableGroup = true,
		point = "LEFT",
		offsetX = 30,
		relativeToPoint = "RIGHT",
		enableTarget = true,
	},
	comboPointsText =
	{
		offsetX = -8,
	},
	commentData =
	{
		includeHostile = true,
		save = false,
	},
	crowdControlSpellIcon =
	{
		enable = true,
	},
	crowdControlSpellNameText =
	{
		enable = true,
		fontSize = 11,
		offsets =
		{
			vertical = 1,
			left = 16,
			right = 0,
		},
	},
	crowdControlTimeText =
	{
		enable = true,
		fontSize = 11,
		offsets =
		{
			vertical = 1,
			left = 0,
			right = -5,
		},
	},
	frame =
	{
		backgroundAlpha = 0.50,
		border = "Skinner Border",
		width = 180,
		height = 28,
		packingHeight = 32,
		packingWidth = 32,
	},
	glow =
	{
		width = 226,
		style = "Partial Square Glow",
		height = 126,
		offsetY = 6,
	},
	guildData =
	{
		save = false,
	},
	healthBar =
	{
		offsets =
		{
			vertical = -14,
			left = 1,
			right = -1,
		},
		height = 13,
	},
	healthText =
	{
		point = "BOTTOMRIGHT",
		enable = true,
		font = "Friz Quadrata TT",
		offsetX = -1,
		relativeToPoint = "BOTTOMRIGHT",
		offsetY = 3,
		mode = "SMART",
		format = "[Health]",
	},
	highlight =
	{
		color =
		{
			nil, -- [1]
			nil, -- [2]
			1, -- [3]
			1, -- [4]
		},
		texture = "Outline",
	},
	levelText =
	{
		fontSize = 12,
		point = "TOPRIGHT",
		font = "Friz Quadrata TT",
		relativeToPoint = "TOPRIGHT",
		offsetY = 0,
	},
	manaBar =
	{
		offsets =
		{
			vertical = -31,
		},
		enable = true,
	},
	manaText =
	{
		point = "LEFT",
		enable = true,
		relativeToPoint = "LEFT",
		format = "[ManaFraction:Percent]",
		offsetY = -20,
	},
	nameText =
	{
		offsets =
		{
			vertical = 7,
			right = 120,
		},
		font = "Friz Quadrata TT",
	},
	polymorph =
	{
		offsets =
		{
			vertical = -31,
		},
		height = 9,
	},
	raidIcon =
	{
		offsetX = -46,
		point = "BOTTOMRIGHT",
		relativeToPoint = "BOTTOMRIGHT",
		offsetY = -4,
		alpha = 1,
		size = 22,
	},
	recentlyDamagedIcon =
	{
		offsetX = 8,
		point = "LEFT",
		relativeToPoint = "RIGHT",
		enable = true,
	},
	spellNameText =
	{
		offsets =
		{
			left = 16,
			right = 0,
			vertical = 0,
		},
	},
	stateIcon =
	{
		offsetX = -6,
	},
	threatBar =
	{
		flashStyle = "Partial Soft Outline",
		enable = true,
		offsets =
		{
			vertical = -36,
		},
		flashWidth = 198,
		flashOffsetY = 6,
		flashThreshold = 85,
		flashBlendMode = "BLEND",
		flashHeight = 73,
	},
	threatText =
	{
		enable = true,
		format = "[ThreatFraction:Percent]",
		offsetY = -20,
	},
	visibility =
	{
		showCritters = false,
		showFriendlyPets = false,
		showFriendlyTotems = false,
		showHostilePets = false,
		showHostilePlayers = false,
		showHostileTotems = false,
	},
}

local presetPvP =
{
	alpha =
	{
		nonTargetEnable = true,
		defaultAlpha = 0.65,
		nonTargetAlpha = 0.65,
		defaultEnable = true,
		targetEnable = true,
	},
	bossIcon =
	{
		enable = false,
	},
	castBarTimeText =
	{
		enable = false,
	},
	castWarning =
	{
		enable = false,
	},
	castWarningSpellIcon =
	{
		enable = false,
	},
	castWarningSpellNameText =
	{
		enable = false,
	},
	castWarningTimeText =
	{
		enable = false,
	},
	classData =
	{
		save = false,
	},
	classIcon =
	{
		point = "CENTER",
		relativeToPoint = "CENTER",
		enable = true,
		offsetY = 32,
		size = 48,
	},
	comboPointsText =
	{
		enable = false,
	},
	commentData =
	{
		save = false,
		includeHostile = true,
	},
	crowdControlSpellIcon =
	{
		enable = true,
		point = "LEFT",
		size = 11,
	},
	crowdControlSpellNameText =
	{
		enable = false,
	},
	crowdControlTimeText =
	{
		enable = false,
	},
	frame =
	{
		backgroundAlpha = 0.15,
		colorHostileByClass = true,
		packingHeight = 32,
		packingWidth = -10,
		colorByClass = true,
		width = 50,
		height = 9,
		offsetY = 32,
	},
	glow =
	{
		enable = false,
	},
	guildData =
	{
		save = false,
	},
	healthBar =
	{
		targetOnly = false,
		borderColor =
		{
			0, -- [1]
			0, -- [2]
			0, -- [3]
		},
		height = 9,
		texture = "Minimalist",
	},
	healthText =
	{
		enable = true,
		font = "Friz Quadrata TT",
		fontSize = 8,
		point = "CENTER",
		relativeToPoint = "CENTER",
		format = "[HealthFraction:Percent]",
		offsetY = 1,
	},
	highlight =
	{
		color =
		{
			nil, -- [1]
			nil, -- [2]
			1, -- [3]
			1, -- [4]
		},
		texture = "Outline",
	},
	levelText =
	{
		point = "LEFT",
		showClassification = true,
		showCreatureType = true,
		overrideText = true,
		offsetX = 2,
		fontSize = 13,
		offsetY = 1,
		showRace = true,
		format = "[Level][\"[\"][Class:HealthBarColor][HideIf(~Class):HideIf(~PowerType):\":\":HealthBarColor][ShortPowerTypeName:PowerTypeColor][\"]\"][ShortCreatureType][ShortRace][Select(Level,ShortClassification,Classification)]",
	},
	manaBar =
	{
		powerTypeColors =
		{
			[3] =
			{
				nil, -- [1]
				0.85, -- [2]
			},
			[0] =
			{
				0.33, -- [1]
				0.62, -- [2]
				1, -- [3]
			},
		},
		offsets =
		{
			vertical = -10,
		},
		enable = true,
		targetOnly = false,
		borderColor =
		{
			0, -- [1]
			0, -- [2]
			0, -- [3]
		},
		height = 9,
		texture = "Minimalist",
	},
	manaText =
	{
		fontSize = 8,
		point = "CENTER",
		enable = true,
		font = "Friz Quadrata TT",
		relativeToPoint = "CENTER",
		offsetY = -9,
		format = "[ManaFraction:Percent]",
	},
	nameText =
	{
		fontSize = 13,
		useAliases = true,
		offsets =
		{
			vertical = 1,
			left = -540,
			right = -53,
		},
		colorHostileByClass = true,
		alignment = "RIGHT",
		colorByClass = true,
		format = "[IsTarget:\"> \":Red][PlayerTitlePrefix:Suffix(\" \"):HealthBarColor][Name:ClassColor][PlayerTitleSuffixSeparated(\", \", \" \"):HealthBarColor][HideIf(Alias==Name):Alias:Surround(\" (\",\")\"):Cyan][IsTarget:\" <\":Red]",
	},
	polymorph =
	{
		speculativeAttach = false,
		offsets =
		{
			vertical = -42,
		},
		height = 11,
		borderColor =
		{
				0, -- [1]
				0, -- [2]
				0, -- [3]
		},
		border = "RothSquare",
		texture = "Minimalist",
	},
	raidIcon =
	{
		enable = false,
	},
	spellIcon =
	{
		enable = false,
	},
	spellNameText =
	{
		enable = false,
	},
	stateIcon =
	{
		enable = false,
	},
	threatBar =
	{
		enable = false,
		flashEnable = false,
	},
	visibility =
	{
		showFriendlyTotems = false,
		showHostilePets = false,
		showFriendlyPets = false,
		showCritters = false,
		showHostileTotems = false,
	},
}


-----------------------------------------------------------------------------

AloftPresets:AddPreset(L["Default"], { })
AloftPresets:AddPreset(L["Preset 1"], preset1)
AloftPresets:AddPreset(L["Preset 2"], preset2)
AloftPresets:AddPreset(L["Preset 3"], preset3)
AloftPresets:AddPreset(L["Preset Acapela"], presetAcapela)
AloftPresets:AddPreset(L["Preset Unit Frame"], presetUnitFrame)
AloftPresets:AddPreset(L["Preset PvP"], presetPvP)

-----------------------------------------------------------------------------

end)
