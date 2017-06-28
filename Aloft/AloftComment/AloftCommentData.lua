local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftComment", function()

-----------------------------------------------------------------------------

local AloftCommentData = Aloft:NewModule("CommentData", "AceEvent-2.0")
AloftCommentData.dynamic = "AloftComment"

local L = AceLibrary("AceLocale-2.2"):new("AloftCommentData")
local gratuity = AceLibrary("LibGratuity-3.0")

-----------------------------------------------------------------------------

AloftCommentData.db = Aloft:AcquireDBNamespace("commentData")
Aloft:RegisterDefaults("commentData", "account", { comments = { } })
Aloft:RegisterDefaults("commentData", "profile", { save = true, auto = true, includeHostile = false })

-----------------------------------------------------------------------------

local comments = { }
local profile

-----------------------------------------------------------------------------

Aloft.TagData.Comment =
{
	data = "comment",
	events = "Aloft:OnCommentDataChanged",
	tableData = "comment"
}

-----------------------------------------------------------------------------

function AloftCommentData:ProvidesData()
	return "comment"
end

function AloftCommentData:RegisterEvents()
	self:UnregisterAllEvents()
	if profile.auto then
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateCommentFromMouseOver")
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateCommentFromTarget")
	end
end

function AloftCommentData:EnableDataSource()
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftCommentData:OnInitialize()
	profile = self.db.profile
end

function AloftCommentData:OnEnable()
	if profile and profile.save then
		comments = self.db.account.comments
	else
		comments = { }
	end
end

function AloftCommentData:UpdateData(aloftData)
	aloftData.comment = comments[aloftData.name]
end

-----------------------------------------------------------------------------

function AloftCommentData:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData.name ~= L["Unknown"] then
			local comment = comments[aloftData.name]
			if aloftData.comment ~= comment then
				aloftData.comment = comment
				self:TriggerEvent("Aloft:OnCommentDataChanged", aloftData)
			end
		end
	end
end

function AloftCommentData:SetCommentForTarget(comment)
	local name, _ = UnitName("target")
	if name and name ~= L["Unknown"] then
		comments[name] = comment ~= "" and comment or nil
		self:UpdateAll()
		return name
	end
end

function AloftCommentData.SetSaveData(v)
	AloftCommentData.db.profile.save = v
	AloftCommentData.db.server.comments = (v and comments) or { }
end

function AloftCommentData:ClearAllData()
	for k in pairs(comments) do
		comments[k] = nil
	end
	self:UpdateAll()
end

-----------------------------------------------------------------------------

function AloftCommentData:UpdateCommentFromUnit(unitid)
	local key, _ = UnitName(unitid)
	if key and not comments[key] and not UnitPlayerControlled(unitid) and not UnitIsPlayer(unitid) and key ~= L["Unknown"] then
		if not profile.includeHostile and not UnitIsFriend("player", unitid) then
			return
		end

		local comment = self:GetUnitTooltipData(unitid)
		if comment and comment ~= "" and comment:find(L["Level"]) ~= 1 then
			comments[key] = comment
			for aloftData in Aloft:IterateVisibleNameplates() do
				if aloftData.name == key then
					aloftData.comment = comment
					self:TriggerEvent("Aloft:OnCommentDataChanged", aloftData)
				end
			end
		end
	end
end

function AloftCommentData:UpdateCommentFromMouseOver()
	self:UpdateCommentFromUnit("mouseover")
end

function AloftCommentData:UpdateCommentFromTarget()
	self:UpdateCommentFromUnit("target")
end

-----------------------------------------------------------------------------

-- local version, build, date, tocversion = GetBuildInfo()
function AloftCommentData:GetUnitTooltipData(unitid)
	-- ChatFrame7:AddMessage("Aloft:GetUnitTooltipData(): VERSION " .. tostring(version) .. "/" .. tostring(build) .. "/" .. tostring(date) .. "/" .. tostring(tocversion) .. " VERSION")

	gratuity:SetUnit(unitid)
	local comment = gratuity:GetLine(2)

	return comment
end

-----------------------------------------------------------------------------

end)
