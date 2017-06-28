local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

local AloftGuildData = Aloft:NewModule("GuildData", "AceEvent-2.0")
AloftGuildData.dynamic = "AloftGuild"

local L = AceLibrary("AceLocale-2.2"):new("AloftGuildDataOptions")

-----------------------------------------------------------------------------

AloftGuildData.db = Aloft:AcquireDBNamespace("guildData")
Aloft:RegisterDefaults("guildData", "server", { playerGuilds = { } })
Aloft:RegisterDefaults("guildData", "profile", { save = true })

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

local updateRequired = false
local function AddData(name, guild)
	if guild == "" then
		guild = nil
	end
	if name and playerGuilds[name] ~= guild then
		playerGuilds[name] = guild
		updateRequired = true
	end
end

-----------------------------------------------------------------------------

function AloftGuildData:OnEnable()
	-- ChatFrame7:AddMessage("AloftGuildData:OnEnable(): invoke")
	if self.db.profile.save then
		playerGuilds = self.db.server.playerGuilds
		-- self:UpdateGuildFromGuild()
	else
		playerGuilds = { }
	end
end

-----------------------------------------------------------------------------

function AloftGuildData.SetSaveData(v)
	AloftGuildData.db.profile.save = v
	if AloftGuildData.db.profile.save then
		AloftGuildData.db.server.playerGuilds = playerGuilds
		AloftGuildData:UpdateGuildFromGuild()
	else
		AloftGuildData.db.server.playerGuilds = { }
	end
end

function AloftGuildData:ProvidesData()
	return "guild"
end

function AloftGuildData:EnableDataSource()
	-- Events to update our guild database
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateGuildFromMouseOver")
	self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateGuildFromTarget")
	self:RegisterEvent("GUILD_ROSTER_UPDATE", "UpdateGuildFromGuild")
	self:RegisterEvent("WHO_LIST_UPDATE", "UpdateGuildFromWho")
	self:RegisterEvent("CHAT_MSG_SYSTEM", "UpdateGuildFromWho")

	-- ChatFrame7:AddMessage("AloftGuildData:EnableDataSource(): initialize")
	self:UpdateGuildFromGuild()
end

-----------------------------------------------------------------------------

function AloftGuildData:UpdateData(aloftData)
	aloftData.guild = nil

	-- This is so that pets named the same as players we've encountered aren't given a guild incorrectly
	if aloftData.type == "friendlyPlayer" or aloftData.type == "hostilePlayer" or aloftData.type == "hostile" then
		local guild = playerGuilds[aloftData.name]
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
		local guild = playerGuilds[aloftData.name]
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

function AloftGuildData:UpdateGuildFromMouseOver()
	local name, _ = UnitName("mouseover")
	if UnitIsPlayer("mouseover") and name ~= L["Unknown"] then
		AddData(UnitName("mouseover"), GetGuildInfo("mouseover"))
		self:UpdateVisibleNameplates()
	end
end

function AloftGuildData:UpdateGuildFromTarget()
	local name, _ = UnitName("target")
	if UnitIsPlayer("target") and name ~= L["Unknown"] then
		AddData(UnitName("target"), GetGuildInfo("target"))

		local eventName = "AloftGuildData:UpdateGuildFromTarget:" .. tostring(math.random(1,1000000000))
		self:ScheduleEvent(eventName, self.DoUpdateTargetNameplate, 0.0, self) -- next frame
	end
end

function AloftGuildData:UpdateGuildFromGuild()
	if IsInGuild() then
		local guild = GetGuildInfo("player")
		for i = 1, GetNumGuildMembers(true) do
			local name = GetGuildRosterInfo(i)
			AddData(name, guild)
		end
		self:UpdateVisibleNameplates()
	end
end

function AloftGuildData:UpdateGuildFromWho()
	for i = 1, GetNumWhoResults() do
		local name, guild = GetWhoInfo(i)
		AddData(name, guild)
	end
	self:UpdateVisibleNameplates()
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
	if not (aloftData.guild == guild) then
		aloftData.guild = guild
		self:TriggerEvent("Aloft:OnGuildDataChanged", aloftData)
	end

	if (aloftData.classification) then
		aloftData.classification = nil
		self:TriggerEvent("Aloft:OnClassificationDataChanged", aloftData)
	end
	if (aloftData.isPet) then
		aloftData.isPet = nil
		self:TriggerEvent("Aloft:OnIsPetDataChanged", aloftData)
	end
	if (aloftData.petOwnersName) then
		aloftData.petOwnersName = nil
		self:TriggerEvent("Aloft:OnPetOwnersNameDataChanged", aloftData)
	end
end

-----------------------------------------------------------------------------

end)
