local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftGuild", function()

-----------------------------------------------------------------------------

local L = AloftLocale.AloftShortGuildData
if not L then return end

local AloftShortGuildData = Aloft:NewModule("ShortGuildData", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftShortGuildData.dynamic = "AloftGuild"

-----------------------------------------------------------------------------

AloftShortGuildData.namespace = "shortGuildData"
AloftShortGuildData.defaults =
{
	realm =
	{
		shortGuildList = { }
	},
}

-----------------------------------------------------------------------------

local shortGuildCache = { }

-----------------------------------------------------------------------------

Aloft.TagData.ShortGuild =
{
	data = "shortGuild",
	events = "Aloft:OnShortGuildDataChanged",
	overrideEvents = "Aloft:OnGuildDataChanged",
	tableData = "shortGuild"
}

-----------------------------------------------------------------------------

function AloftShortGuildData:ProvidesData()
	return "shortGuild"
end

function AloftShortGuildData:RequiresData()
	return "guild"
end

function AloftShortGuildData:EnableDataSource()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	self:RegisterMessage("Aloft:OnGuildDataChanged", "OnGuildDataChanged")
end

-----------------------------------------------------------------------------

function AloftShortGuildData:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftShortGuildData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end
end

function AloftShortGuildData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftShortGuildData:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		local guild = aloftData.guild

		if guild then
			local shortGuild = self.db.realm.shortGuildList[guild] or shortGuildCache[guild]
			-- we prefer to use the long list, because the user creates those abbreviations

			if aloftData.shortGuild ~= shortGuild then
				aloftData.shortGuild = shortGuild
				self:TriggerEvent("Aloft:OnShortGuildDataChanged", aloftData)
			end
		end
	end
end

function AloftShortGuildData:AddData(guild, abbreviation)
	self.db.realm.shortGuildList[guild] = abbreviation
	self:UpdateAll()
end

function AloftShortGuildData:ClearAllData()
	for k in pairs(shortGuildCache) do
		shortGuildCache[k] = nil
	end
	for k in pairs(self.db.realm.shortGuildList) do
		self.db.realm.shortGuildList[k] = nil
	end
	self:UpdateAll()
end

function AloftShortGuildData:CreateShortName(guild)
	local _, numberOfSpaces = guild:gsub(" ", "")

	if numberOfSpaces == 0 then
		return guild:sub(1, 4)
	end

	-- This code replaces 2-word guild names with the first two characters of each word
	-- In practise I preferred not having the extra chars, than having the more obvious distinction
--	if numberOfSpaces == 1 then
--		return guild:gsub("(%a%a?)%a*%A*", "%1")
--	end

	for k,v in pairs(L) do
		guild = guild:gsub(k, v)
	end

	return guild:gsub("(%a)%a*%A*", "%1")
end

-----------------------------------------------------------------------------

function AloftShortGuildData:UpdateData(aloftData)
	aloftData.shortGuild = nil

	local guild = aloftData.guild
	if guild then
		local shortGuild =  self.db.realm.shortGuildList[guild] or shortGuildCache[guild]
		-- we prefer to use the long list, because the user creates those abbreviations

		if not shortGuild then
			shortGuild = self:CreateShortName(guild)
			shortGuildCache[guild] = shortGuild
			-- when we create short guild names on the fly, we store them only in the cache, and throw them away at the end of the session
		end

		aloftData.shortGuild = shortGuild
	end
end

function AloftShortGuildData:OnGuildDataChanged(message, aloftData)
	self:UpdateData(aloftData)
	self:SendMessage("Aloft:OnShortGuildDataChanged", aloftData)
end

-----------------------------------------------------------------------------

end)
