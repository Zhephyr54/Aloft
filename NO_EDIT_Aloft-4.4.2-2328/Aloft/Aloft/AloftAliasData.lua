local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local AloftAliasData = Aloft:NewModule("AliasData", Aloft, "AceEvent-3.0", "AceTimer-3.0")

-----------------------------------------------------------------------------

AloftAliasData.namespace = "aliasData"
AloftAliasData.defaults =
{
	realm =
	{
		aliasList =
		{
		},
	},
}

-----------------------------------------------------------------------------

Aloft.TagData.Alias =
{
	data = "alias",
	events = "Aloft:OnAliasDataChanged",
	tableData = "alias"
}

-----------------------------------------------------------------------------

function AloftAliasData:ProvidesData()
	return "alias"
end

-----------------------------------------------------------------------------

function AloftAliasData:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftAliasData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	-- ChatFrame7:AddMessage("AloftAliasData:OnEnable(): enter")
end

function AloftAliasData:OnDisable()
end

-----------------------------------------------------------------------------

function AloftAliasData:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		local alias = self.db.realm.aliasList[aloftData.name] or aloftData.name

		if aloftData.alias ~= alias then
			aloftData.alias = alias
			self:SendMessage("Aloft:OnAliasDataChanged", aloftData)
		end
	end
end

function AloftAliasData:SetAlias(name, alias)
	if not name then return end

	self.db.realm.aliasList[name] = alias ~= "" and alias or nil
	alias = self.db.realm.aliasList[name] or name

	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData.name == name then
			aloftData.alias = alias
			self:SendMessage("Aloft:OnAliasDataChanged", aloftData)
		end
	end
end

function AloftAliasData:ClearAllData()
	for k in pairs(self.db.realm.aliasList) do
		self.db.realm.aliasList[k] = nil
	end
	self:UpdateAll()
end

-----------------------------------------------------------------------------

function AloftAliasData:UpdateData(aloftData)
	aloftData.alias = self.db.realm.aliasList[aloftData.name] or aloftData.name
end

-----------------------------------------------------------------------------
