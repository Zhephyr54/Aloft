local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

if not Aloft:HasModule("TargetTrackingData") then return end

local AloftTargetNameData = Aloft:NewModule("TargetNameData", "AceEvent-2.0", "AceHook-2.1")
AloftTargetNameData.dynamic = "AloftTarget"

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData")

-----------------------------------------------------------------------------

AloftTargetNameData.db = Aloft:AcquireDBNamespace("targetOfTarget")
Aloft:RegisterDefaults("targetOfTarget", "profile", {
	enable				= true,
	interval			= 0.33, -- update target-of-target 3 times a second (nominally)
})

-----------------------------------------------------------------------------

local profile
local delay = 0.0 -- update delay: next frame
local isUpdating = false
local updateList = { }

local UnitName = UnitName

-----------------------------------------------------------------------------

Aloft.TagData.TargetName =
{
	data = "targetName",
	events = "Aloft:OnTargetNameDataChanged",
	overrideEvents = "Aloft:OnIsTargetDataChanged",
	tableData = "targetName",
}

-----------------------------------------------------------------------------

function AloftTargetNameData:OnInitialize()
	profile = self.db.profile
end

function AloftTargetNameData:OnEnable()
	Aloft.Options.args.AloftTargetTrackingData.args.ToTEnable = AloftTargetNameData.options.enable
	Aloft.Options.args.AloftTargetTrackingData.args.ToTInterval = AloftTargetNameData.options.interval
end

function AloftTargetNameData:OnDisable()
	self:UnregisterAllEvents()
end

function AloftTargetNameData:ProvidesData()
	if profile and profile.enable then
		-- ChatFrame7:AddMessage("AloftTargetNameData:ProvidesData(): targetName")
		return "targetName"
	end
end

function AloftTargetNameData:RequiresData()
	if profile and profile.enable then
		if Aloft:IsDataAvailable("unitid") then
			-- ChatFrame7:AddMessage("AloftTargetNameData:RequiresData(): unitid+isTarget")
			return "unitid", "isTarget"
		else
			-- ChatFrame7:AddMessage("AloftTargetNameData:RequiresData(): unitid")
			return "isTarget"
		end
	end
end

function AloftTargetNameData:EnableDataSource()
	self:UnregisterAllEvents()

	-- ChatFrame7:AddMessage("AloftTargetNameData:EnableDataSource(): invoke")

	-- tracks player/pet/group target changes
	self:RegisterEvent("AloftTargetTrackingData:OnNameplateTrackingDataChanged", "OnNameplateTrackingDataChanged")
	self:RegisterEvent("Aloft:OnUnitidDataChanged", "OnUnitidDataChanged")
	self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
	self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")

	if profile and profile.enable then
		-- for update of target-of-target data on hostile nameplates
		self:ScheduleRepeatingEvent("AloftTargetNameData:UpdateTargetTarget", self.UpdateTargetTarget, profile.interval, self)
	end
end

function AloftTargetNameData:UpdateAll()
end

-----------------------------------------------------------------------------

-- NOTE: we have to jump through all sorts of hoops to update target data, since nameplates can appear/disappear, rather than be
--              selected by the player; these functions are all designed to be driven by "on next frame" sorts of delays
function AloftTargetNameData:UpdateUnitNameplate(aloftData)
	if aloftData.unitid then -- guard here: here is apparently a race condition
		local targetName = UnitName(aloftData.unitid .. "target")
		if targetName ~= aloftData.targetName then
			aloftData.targetName = targetName
			-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateUnitNameplate(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
			AloftTargetNameData:TriggerEvent("Aloft:OnTargetNameDataChanged", aloftData)
		end
	--[[
	else
		ChatFrame7:AddMessage("AloftTargetNameData:UpdateUnitNameplate(): NO UNITID " .. tostring(aloftData.name))
		ChatFrame7:AddMessage("AloftTargetNameData:UpdateUnitNameplate(): " .. debugstack())
	]]
	end
end

function AloftTargetNameData:UpdateNameplate(aloftData)
	if aloftData.isTarget or aloftData:IsTarget() then
		self:UpdateTargetNameplate(aloftData)
	else
		self:ClearNameplate(aloftData)
	end
end

function AloftTargetNameData:UpdateTargetNameplate(aloftData)
	-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateTargetNameplate(): player " .. tostring(aloftData) .. "/".. tostring(aloftData.name) .. "/" .. "targettarget" .. "/" .. tostring(aloftData.targetName))
	local targetName = UnitName("targettarget")
	if targetName ~= aloftData.targetName then
		aloftData.targetName = targetName
		-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateTargetNameplate(): " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.targetName) .. "/" .. tostring(aloftData.targetName))
		AloftTargetNameData:TriggerEvent("Aloft:OnTargetNameDataChanged", aloftData)
	end
	--updateList[aloftData] = true
	--AloftTargetNameData:StartUpdates()
end

function AloftTargetNameData:ClearNameplate(aloftData)
	-- ChatFrame7:AddMessage("AloftTargetNameData:ClearNameplate(): " .. tostring(aloftData) .. "/" .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
	aloftData.targetName = nil
	-- updateList[aloftData] = nil
	if (not aloftData.unitid) then
		-- self:StopUpdates()
	end
	self:TriggerEvent("Aloft:OnTargetNameDataChanged", aloftData)
end

-----------------------------------------------------------------------------

function AloftTargetNameData:OnNameplateTrackingDataChanged(aloftData)
	if aloftData.unitid then
		local eventName = "AloftTargetNameData:OnNameplateTrackingDataChanged:" .. tostring(math.random(1,1000000000))
		-- ChatFrame7:AddMessage("AloftTargetNameData:OnNameplateTrackingDataChanged(): group " .. tostring(eventName) .. "/".. tostring(aloftData) .. "/".. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
		self:ScheduleEvent(eventName, self.UpdateUnitNameplate, delay, self, aloftData)
	else
		local eventName = "AloftTargetNameData:OnNameplateTrackingDataChanged:"..tostring(math.random(1,1000000000))
		-- ChatFrame7:AddMessage("AloftTargetNameData:OnNameplateTrackingDataChanged(): clear " .. tostring(eventName) .. "/".. tostring(aloftData) .. "/".. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
		self:ScheduleEvent(eventName, self.UpdateNameplate, delay, self, aloftData)
	end
end

function AloftTargetNameData:OnUnitidDataChanged(aloftData)
	if aloftData.unitid then
		local eventName = "AloftTargetNameData:OnUnitidDataChanged:" .. tostring(math.random(1,1000000000))
		-- ChatFrame7:AddMessage("AloftTargetNameData:OnUnitidDataChanged(): group " .. tostring(eventName) .. "/".. tostring(aloftData) .. "/".. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
		self:ScheduleEvent(eventName, self.UpdateUnitNameplate, delay, self, aloftData)
	else
		local eventName = "AloftTargetNameData:OnUnitidDataChanged:"..tostring(math.random(1,1000000000))
		-- ChatFrame7:AddMessage("AloftTargetNameData:OnUnitidDataChanged(): clear " .. tostring(eventName) .. "/".. tostring(aloftData) .. "/".. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
		self:ScheduleEvent(eventName, self.UpdateNameplate, delay, self, aloftData)
	end
end

function AloftTargetNameData:OnNameplateShow(aloftData)
	if aloftData.unitid then
		local eventName = "AloftTargetNameData:OnNameplateShow:" .. tostring(math.random(1,1000000000))
		-- ChatFrame7:AddMessage("AloftTargetNameData:OnNameplateShow(): group " .. tostring(eventName) .. "/".. tostring(aloftData) .. "/".. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
		self:ScheduleEvent(eventName, self.UpdateUnitNameplate, delay, self, aloftData)
	else
		local eventName = "AloftTargetNameData:OnNameplateShow:"..tostring(math.random(1,1000000000))
		-- ChatFrame7:AddMessage("AloftTargetNameData:OnNameplateShow(): clear " .. tostring(eventName) .. "/".. tostring(aloftData) .. "/".. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
		self:ScheduleEvent(eventName, self.UpdateNameplate, delay, self, aloftData)
	end
end

function AloftTargetNameData:OnNameplateHide(aloftData)
	self:ClearNameplate(aloftData)
end

-----------------------------------------------------------------------------

function AloftTargetNameData:UpdateData(aloftData)
	-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateData(): process " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
	if aloftData.unitid then
		local eventName = "AloftTargetNameData:TargetNameUpdateUnit:" .. tostring(math.random(1,1000000000))
		-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateData(): group " .. tostring(eventName) .. "/".. tostring(aloftData) .. "/".. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
		self:ScheduleEvent(eventName, self.UpdateUnitNameplate, delay, self, aloftData)
	else
		local eventName = "AloftTargetNameData:TargetNameUpdate:"..tostring(math.random(1,1000000000))
		-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateData(): clear " .. tostring(eventName) .. "/".. tostring(aloftData) .. "/".. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
		self:ScheduleEvent(eventName, self.UpdateNameplate, delay, self, aloftData)
	end
end

--[[ currently dead code
function AloftTargetNameData:StartUpdates()
	if not isUpdating then
		self:ScheduleRepeatingEvent("AloftTargetNameData:Update", self.Update, 0.2, self)
		isUpdating = true
	end
end

function AloftTargetNameData:StopUpdates()
	if isUpdating and not next(updateList) then
		self:CancelScheduledEvent("AloftTargetNameData:Update")
		isUpdating = false
	end
end
]]

function AloftTargetNameData:Update()
	-- ChatFrame7:AddMessage("AloftTargetNameData:Update(): process")
	for aloftData in pairs(updateList) do
		local targetName
		if aloftData.unitid then
			local unitid = aloftData.unitid .. "target"
			targetName = UnitName(unitid)
			-- ChatFrame7:AddMessage("AloftTargetNameData:Update(): grouped " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(targetName))
		elseif aloftData.isTarget or aloftData:IsTarget() then
			targetName = UnitName("targettarget")
			-- ChatFrame7:AddMessage("AloftTargetNameData:Update(): target " .. tostring(aloftData.name) .. "/" .. "targettarget" .. "/" .. tostring(targetName))
		end

		if targetName ~= aloftData.targetName then
			aloftData.targetName = targetName
			-- ChatFrame7:AddMessage("AloftTargetNameData:Update(): change " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName) .. " trigger Aloft:OnTargetNameDataChanged")
			self:TriggerEvent("Aloft:OnTargetNameDataChanged", aloftData)
		end
	end
end

function AloftTargetNameData:UpdateTargetTarget()
	if not profile.enable then return end -- stub out if disabled
	if not AloftTargetTrackingData:IsTargetIdToNameplateIdTracking() then return end -- stub out if no friendly/grouped unit has a target

	-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateTargetTarget(): process")
	for aloftData in Aloft:IterateVisibleNameplates() do
		-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateTargetTarget(): " .. tostring(aloftData.name))
		if not aloftData.unitid and (aloftData.type == "hostilePlayer" or aloftData.type == "hostile" or aloftData.type == "neutral") then -- nameplates with unitids are handled via events
			if aloftData.isTarget or aloftData:IsTarget() then -- TODO: do we really need this?
				-- supply a catchall in case the target enemy nameplate is visible when it obtains a target, i.e. when "targettarget" becomes an active unitid
				self:UpdateTargetNameplate(aloftData)
				-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateTargetTarget(): target " .. tostring(aloftData.name))
			else
				local targetName = nil
				local nameplateId = AloftTargetTrackingData:GetNameplateId(aloftData)

				-- ChatFrame7:AddMessage("AloftTargetNameData:ProcessNonTargetThreat(): nameplate " .. tostring(aloftData.name) .. "/" .. tostring(nameplateId))
				if nameplateId and AloftTargetTrackingData.nameplateIdToTargetId[nameplateId] then
					for targetid in pairs(AloftTargetTrackingData.nameplateIdToTargetId[nameplateId]) do
						local tgtgtid = targetid .. "target" -- this enemy unit's target is the targetting friendly unit's target-of-target; we have to chain through targetids starting with a friendly
						targetName = UnitName(tgtgtid)
						-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateTargetTarget(): targeted " .. tostring(targetid))
						break -- skip out of the targetid loop; only one friendly groupmember is needed to construct a target name
					end
				end
				if targetName ~= aloftData.targetName then
					-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateTargetTarget(): " .. tostring(aloftData.name) .. "/" .. tostring(targetid) .. "/" .. tostring(targetName))
					aloftData.targetName = targetName
					-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateTargetTarget(): update " .. tostring(nameplateId))
					AloftTargetNameData:TriggerEvent("Aloft:OnTargetNameDataChanged", aloftData)
				end
			end
		end
	end
end

-----------------------------------------------------------------------------

end)
