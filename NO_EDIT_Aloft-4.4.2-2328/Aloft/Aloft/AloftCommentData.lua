local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

local L = AloftLocale.Aloft
if not L then return end

local AloftCommentData = Aloft:NewModule("CommentData", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftCommentData.dynamic = "AloftComment"

local gratuity = LibStub("LibGratuity-3.0")

-----------------------------------------------------------------------------

AloftCommentData.namespace = "commentData"
AloftCommentData.defaults =
{
	realm =
	{
		unitCommentData =
		{
		},
	},
	profile =
	{
		save = true,
		auto = true,
		includeHostile = false
	},
}

-----------------------------------------------------------------------------

local comments = { }

-----------------------------------------------------------------------------

Aloft.TagData.Comment =
{
	data = "comment",
	events = "Aloft:OnCommentDataChanged",
	tableData = "comment"
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
	local comment = nil
	if name then
		comment = comments[name] -- try local cache first
		if name and not comment and AloftCommentData.db and AloftCommentData.db.realm then
			comment = AloftCommentData.db.realm.unitCommentData[name] -- recover from saved variables, if any
			comments[name] = comment -- cache in local
		end
	end
	return comment
end

local updateRequired = false
local function AddData(name, comment)
	if comment == "" then comment = nil end
	if name and comments[name] ~= comment then
		-- ChatFrame7:AddMessage("AloftCommentData:AddData(): " .. tostring(name) .. "/" .. tostring(comment))

		comments[name] = comment
		if AloftCommentData.db and AloftCommentData.db.profile and AloftCommentData.db.profile.save and AloftCommentData.db.realm then
			AloftCommentData.db.realm.unitCommentData[name] = comment
		end

		updateRequired = true
	end
end

-----------------------------------------------------------------------------

function AloftCommentData:ProvidesData()
	return "comment"
end

function AloftCommentData:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	-- ChatFrame7:AddMessage("AloftCommentData:RegisterEvents(): enter")

	if self.db.profile.auto then
		-- ChatFrame7:AddMessage("AloftCommentData:RegisterEvents(): register events")
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateCommentFromMouseOver")
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateCommentFromTarget")
	end
end

function AloftCommentData:EnableDataSource()
	-- ChatFrame7:AddMessage("AloftCommentData:EnableDataSource(): enter")

	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftCommentData:OnInitialize()
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	-- TODO: added for Aloft-3.1.2; get rid of this in a few versions
	if self.db and self.db.realm then
		if self.db.realm.comments then
			join(self.db.realm.unitCommentData, self.db.realm.comments)
			self.db.realm.comments = nil
		end
	end

	self.initialized = true
end

function AloftCommentData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end

	if self.db.profile and not self.db.profile.save then
		self.db.realm.unitCommentData = { }
	end
end

function AloftCommentData:OnDisable()
	-- ChatFrame7:AddMessage("AloftCommentData:OnDisable(): enter")

	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

function AloftCommentData:UpdateData(aloftData)
	aloftData.comment = GetData(aloftData.name)
end

-----------------------------------------------------------------------------

function AloftCommentData.SetSaveData(i, v)
	AloftCommentData.db.profile.save = v
	if not v then
		AloftCommentData.db.realm.unitCommentData = { }
	else
		join(AloftCommentData.db.realm.unitCommentData, comments)
	end
end

function AloftCommentData:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData.name ~= L["Unknown"] then
			local comment = GetData(aloftData.name)
			if aloftData.comment ~= comment then
				aloftData.comment = comment
				self:SendMessage("Aloft:OnCommentDataChanged", aloftData)
			end
		end
	end
end

function AloftCommentData:SetCommentForTarget(comment)
	local name, _ = UnitName("target")
	if name and name ~= L["Unknown"] then
		AddData(name, comment)
		self:UpdateAll()
		return name
	end
end

function AloftCommentData:ClearAllData()
	comments = { }
	AloftCommentData.db.realm.unitCommentData = { }
	self:UpdateAll()
end

-----------------------------------------------------------------------------

function AloftCommentData:UpdateCommentFromUnit(unitid)
	local key, _ = UnitName(unitid)
	-- ChatFrame7:AddMessage("AloftCommentData:UpdateCommentFromUnit(): enter " .. tostring(unitid) .. "/" .. tostring(key))

	if key and not GetData(key) and not UnitIsPlayer(unitid) and not UnitPlayerControlled(unitid) and key ~= L["Unknown"] then
		if not self.db.profile.includeHostile and not UnitIsFriend("player", unitid) then
			-- ChatFrame7:AddMessage("AloftCommentData:UpdateCommentFromUnit(): disallow hostile " .. tostring(unitid) .. "/" .. tostring(key))
			return
		end

		local comment = self:GetUnitTooltipData(unitid)
		-- ChatFrame7:AddMessage("AloftCommentData:UpdateCommentFromUnit(): " .. tostring(unitid) .. "/" .. tostring(key) .. "/" .. tostring(comment))

		if comment and comment ~= "" and comment:find(L["Level"]) ~= 1 then
			AddData(key, comment)
			for aloftData in Aloft:IterateVisibleNameplates() do
				if aloftData.name == key then
					aloftData.comment = comment
					
					-- ChatFrame7:AddMessage("AloftCommentData:UpdateCommentFromUnit(): message " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.comment))
					self:SendMessage("Aloft:OnCommentDataChanged", aloftData)
				end
			end
		end
	end
end

function AloftCommentData:UpdateCommentFromMouseOver(event)
	-- ChatFrame7:AddMessage("AloftCommentData:UpdateCommentFromMouseOver(): enter")
	self:UpdateCommentFromUnit("mouseover")
end

function AloftCommentData:UpdateCommentFromTarget(event)
	-- ChatFrame7:AddMessage("AloftCommentData:UpdateCommentFromTarget(): enter")
	self:UpdateCommentFromUnit("target")
end

-----------------------------------------------------------------------------

-- local version, build, date, tocversion = GetBuildInfo()
function AloftCommentData:GetUnitTooltipData(unitid)
	-- ChatFrame7:AddMessage("AloftCommentData:GetUnitTooltipData(): VERSION " .. tostring(version) .. "/" .. tostring(build) .. "/" .. tostring(date) .. "/" .. tostring(tocversion) .. " VERSION")

	gratuity:SetUnit(unitid)
	local comment = gratuity:GetLine(2)
	-- ChatFrame7:AddMessage("AloftCommentData:GetUnitTooltipData(): " .. tostring(UnitName(unitid)) .. "/" .. tostring(comment))
	if Aloft.Reputation[comment] then -- if tooltip:2 is a reputation (Blizzard keeps sticking a reputation string into the tooltip on the PTR)
		comment = gratuity:GetLine(3)
		-- ChatFrame7:AddMessage("AloftCommentData:GetUnitTooltipData(): " .. tostring(UnitName(unitid)) .. "/" .. tostring(comment))
	end

	return comment
end

-----------------------------------------------------------------------------

end)
