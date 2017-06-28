local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

local L = AloftLocale.Aloft
if not L then return end

local AloftGuildData = Aloft:NewModule("GuildData", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftGuildData.dynamic = "AloftGuild"

-----------------------------------------------------------------------------

AloftGuildData.namespace = "guildData"
AloftGuildData.defaults =
{
	profile =
	{
		{
			save = true,
		},
	},
	realm =
	{
		playerGuildData =
		{
		}
	},
}

-----------------------------------------------------------------------------

local playerGuilds = { }

-----------------------------------------------------------------------------

Aloft.TagData.Guild =
{
	data = "guild",
	events = "Aloft:OnGuildDataChanged",
	tableData = "guild"
}

-----------------------------------------------------------------------------

local function join(t1, t2)
	if not (t1 and type(t1) == "table") then return end
	if not (t2 and type(t2) == "table") then return end

	-- NOTE: just a shallow copy; should only ever be used on "simple" tables (i.e. containing scalar keys/values)
	-- non-destructive merke of t2 into t1; if t1 already has a key/value, leave it
	for k, v in pairs(t2) do
		if not t1[k] then t1[k] = v end -- add the k+v to t1
		t2[k] = nil -- zap k_v in t2
	end
end

-----------------------------------------------------------------------------

local function GetData(name)
	local guild = nil
	if name then
		guild = playerGuilds[name] -- try local cache first
		if name and not guild and AloftGuildData.db and AloftGuildData.db.realm then
			guild = AloftGuildData.db.realm.playerGuildData[name] -- recover from saved variables, if any
			playerGuilds[name] = guild -- cache in local
		end
	end
	return guild
end

local updateRequired = false
local function AddData(name, guild)
	if guild == "" then guild = nil end
	if name and playerGuilds[name] ~= guild then
		-- ChatFrame7:AddMessage("AloftGuildData:AddData(): " .. tostring(name) .. "/" .. tostring(guild))

		playerGuilds[name] = guild
		if AloftGuildData.db and AloftGuildData.db.profile and AloftGuildData.db.profile.save and AloftGuildData.db.realm then
			AloftGuildData.db.realm.playerGuildData[name] = guild
		end

		updateRequired = true
	end
end

-----------------------------------------------------------------------------

function AloftGuildData:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	-- TODO: added for Aloft-3.1.2; get rid of this in a few versions
	if self.db and self.db.realm then
		if self.db.realm.playerGuilds then
			join(self.db.realm.playerGuildData, self.db.realm.playerGuilds)
			self.db.realm.playerGuilds = nil
		end
	end

	self.initialized = true
end

function AloftGuildData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftGuildData:OnEnable(): invoke")
	if self.db and self.db.profile and self.db.realm and not self.db.profile.save then
		self.db.realm.playerGuildData = { }
		-- self:UpdateGuildFromGuild("AloftGuildData:OnEnable")
	end
end

function AloftGuildData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftGuildData.SetSaveData(i, v)
	AloftGuildData.db.profile.save = v
	if not v then
		AloftGuildData.db.realm.playerGuildData = { }
	else
		AloftGuildData:UpdateGuildFromGuild("AloftGuildData.SetSaveData")
		join(AloftGuildData.db.realm.playerGuildData, playerGuilds)
	end
end

function AloftGuildData:ProvidesData()
	return "guild"
end

function AloftGuildData:EnableDataSource()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	-- Events to update our guild database
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateGuildFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateGuildFromTarget")
	self:RegisterEvent("GUILD_ROSTER_UPDATE", "UpdateGuildFromGuild")
	self:RegisterEvent("WHO_LIST_UPDATE", "UpdateGuildFromWho")
	self:RegisterEvent("CHAT_MSG_SYSTEM", "UpdateGuildFromWho")

	-- ChatFrame7:AddMessage("AloftGuildData:EnableDataSource(): initialize")
	self:UpdateGuildFromGuild("AloftGuildData:EnableDataSource")
end

-----------------------------------------------------------------------------

function AloftGuildData:UpdateData(aloftData)
	aloftData.guild = nil

	-- This is so that pets named the same as players we've encountered aren't given a guild incorrectly
	if aloftData.type == "friendlyPlayer" or aloftData.type == "hostilePlayer" or aloftData.type == "hostile" then
		local guild = GetData(aloftData.name)
		self:UpdateNameplate(aloftData, guild)
	end
end

-----------------------------------------------------------------------------

function AloftGuildData:UpdateVisibleNameplates()
	if updateRequired then
		targetNameplate = Aloft:GetTargetNameplate()
		for aloftData in Aloft:IterateVisibleNameplates() do
			self:UpdateVisibleNameplate(aloftData, targetNameplate)
		end
	end
	updateRequired = false
end

function AloftGuildData:UpdateVisibleNameplate(aloftData, targetNameplate)
	-- ChatFrame7:AddMessage("AloftGuildData:UpdateVisibleNameplate(): enter")
	if aloftData and aloftData.name ~= L["Unknown"] then
		local guild = GetData(aloftData.name)
		-- ChatFrame7:AddMessage("AloftGuildData:UpdateVisibleNameplate(): check " .. tostring(aloftData.name) .. "/" .. tostring(guild))
		if (guild and aloftData == targetNameplate) then
			-- ChatFrame7:AddMessage("AloftGuildData:UpdateVisibleNameplate(): target " .. tostring(aloftData.name) .. "/" .. tostring(guild))
			self:AssignValues(aloftData, guild)
		else
			-- ChatFrame7:AddMessage("AloftGuildData:UpdateVisibleNameplate(): ambient " .. tostring(aloftData.name) .. "/" .. tostring(guild))
			self:UpdateNameplate(aloftData, guild)
		end
	end
end

function AloftGuildData:DoUpdateTargetNameplate()
	-- ChatFrame7:AddMessage("AloftGuildData:DoUpdateTargetNameplate(): enter")
	local targetNameplate = Aloft:GetTargetNameplate() -- target nameplate may not be visible at the moment
	if targetNameplate then
		-- ChatFrame7:AddMessage("AloftGuildData:DoUpdateTargetNameplate(): target nameplate")
		self:UpdateVisibleNameplate(targetNameplate, targetNameplate)
	end
end

-----------------------------------------------------------------------------

function AloftGuildData:UpdateGuildFromMouseOver(event)
	local name, _ = UnitName("mouseover")
	if UnitIsPlayer("mouseover") and name ~= L["Unknown"] then
		AddData(UnitName("mouseover"), GetGuildInfo("mouseover"))
		self:UpdateVisibleNameplates()
	end
end

function AloftGuildData:UpdateGuildFromTarget(event)
	local name, _ = UnitName("target")
	if UnitIsPlayer("target") and name ~= L["Unknown"] then
		AddData(UnitName("target"), GetGuildInfo("target"))

		self:ScheduleTimer(function() AloftGuildData:DoUpdateTargetNameplate() end, 0.0) -- next frame
	end
end

function AloftGuildData:UpdateGuildFromGuild(event)
	if IsInGuild() then
		local guild = GetGuildInfo("player")
		for i = 1, GetNumGuildMembers(true) do
			local name = GetGuildRosterInfo(i)
			AddData(name, guild)
		end
		self:UpdateVisibleNameplates()
	end
end

function AloftGuildData:UpdateGuildFromWho(event)
	for i = 1, GetNumWhoResults() do
		local name, guild = GetWhoInfo(i)
		AddData(name, guild)
	end
	self:UpdateVisibleNameplates(event)
end

-----------------------------------------------------------------------------

function AloftGuildData:UpdateNameplate(aloftData, guild)
	-- we can now tell the difference between players and pets of the same name, if the ShowClassColorInVKey CVar is enabled;
	-- try to tighten up the checking, so we bomb out on a nameplate as quickly as possible
	if guild and self:ValidateNameplate(aloftData, guild) then
		self:AssignValues(aloftData, guild)
	else
		aloftData.guild = nil
	end
end

function AloftGuildData:ValidateNameplate(aloftData, guild)
	if aloftData.type == "friendlyPlayer" or ((aloftData.type == "hostilePlayer" or aloftData.type == "hostile") and Aloft.showClassColorInVKey and Aloft:GetClassByColor(aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB)) then
		return true
	end
	return false
end

function AloftGuildData:AssignValues(aloftData, guild)
	if aloftData.guild ~= guild then
		aloftData.guild = guild
		self:SendMessage("Aloft:OnGuildDataChanged", aloftData)
	end

	if (aloftData.classification) then
		aloftData.classification = nil
		self:SendMessage("Aloft:OnClassificationDataChanged", aloftData)
	end
	if (aloftData.isPet) then
		aloftData.isPet = nil
		self:SendMessage("Aloft:OnIsPetDataChanged", aloftData)
	end
	if (aloftData.petOwnersName) then
		aloftData.petOwnersName = nil
		self:SendMessage("Aloft:OnPetOwnersNameDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------

end)
