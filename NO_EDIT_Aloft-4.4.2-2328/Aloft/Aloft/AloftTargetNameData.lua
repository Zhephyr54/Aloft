local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

AloftModules:AddInitializer("AloftTarget", function()

-----------------------------------------------------------------------------

local AloftTargetTrackingData = Aloft:GetModule("TargetTrackingData") -- always on
if not AloftTargetTrackingData then return end

local AloftTargetNameData = Aloft:NewModule("TargetNameData", Aloft, "AceEvent-3.0", "AceTimer-3.0")
AloftTargetNameData.dynamic = "AloftTarget"

-----------------------------------------------------------------------------

AloftTargetNameData.namespace = "targetOfTarget"
AloftTargetNameData.defaults =
{
	profile =
	{
		enable				= true,
		interval			= 0.33, -- update target-of-target 3 times a second (nominally)
	},
}

-----------------------------------------------------------------------------

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
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end

	self.initialized = true
end

function AloftTargetNameData:OnEnable()
	-- Ace3 now calls OnInitialize only if the addon is available at time of ADDON_LOADED?
	if not self.initialized then self:OnInitialize() end
end

function AloftTargetNameData:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self:CancelAllTimers()
end

-----------------------------------------------------------------------------

function AloftTargetNameData:ProvidesData()
	if self.db.profile and self.db.profile.enable then
		-- ChatFrame7:AddMessage("AloftTargetNameData:ProvidesData(): targetName")
		return "targetName"
	end
end

function AloftTargetNameData:RequiresData()
	if self.db.profile and self.db.profile.enable then
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
	self:UnregisterAllMessages()
	self:CancelAllTimers()

	-- ChatFrame7:AddMessage("AloftTargetNameData:EnableDataSource(): invoke")

	-- tracks player/pet/group target changes
	self:RegisterMessage("AloftTargetTrackingData:OnNameplateTrackingDataChanged", "OnNameplateTrackingDataChanged")
	self:RegisterMessage("Aloft:OnUnitidDataChanged", "OnUnitidDataChanged")
	self:RegisterMessage("Aloft:OnNameplateHide", "OnNameplateHide")
	self:RegisterMessage("Aloft:OnNameplateShow", "OnNameplateShow")

	if self.db.profile and self.db.profile.enable then
		-- for update of target-of-target data on hostile nameplates
		self:ScheduleRepeatingTimer(function() AloftTargetNameData:UpdateTargetTarget() end, self.db.profile.interval)
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
			AloftTargetNameData:SendMessage("Aloft:OnTargetNameDataChanged", aloftData)
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
		AloftTargetNameData:SendMessage("Aloft:OnTargetNameDataChanged", aloftData)
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
	self:SendMessage("Aloft:OnTargetNameDataChanged", aloftData)
end

-----------------------------------------------------------------------------

function AloftTargetNameData:OnNameplateTrackingDataChanged(message, aloftData)
	if aloftData.unitid then
		self:ScheduleTimer(function(aloftData) AloftTargetNameData:UpdateUnitNameplate(aloftData) end, delay, aloftData)
	else
		self:ScheduleTimer(function(aloftData) AloftTargetNameData:UpdateNameplate(aloftData) end, delay, aloftData)
	end
end

function AloftTargetNameData:OnUnitidDataChanged(message, aloftData)
	if aloftData.unitid then
		self:ScheduleTimer(function(aloftData) AloftTargetNameData:UpdateUnitNameplate(aloftData) end, delay, aloftData)
	else
		self:ScheduleTimer(function(aloftData) AloftTargetNameData:UpdateNameplate(aloftData) end, delay, aloftData)
	end
end

function AloftTargetNameData:OnNameplateShow(message, aloftData)
	if aloftData.unitid then
		self:ScheduleTimer(function(aloftData) AloftTargetNameData:UpdateUnitNameplate(aloftData) end, delay, aloftData)
	else
		self:ScheduleTimer(function(aloftData) AloftTargetNameData:UpdateNameplate(aloftData) end, delay, aloftData)
	end
end

function AloftTargetNameData:OnNameplateHide(message, aloftData)
	self:ClearNameplate(aloftData)
end

-----------------------------------------------------------------------------

function AloftTargetNameData:UpdateData(aloftData)
	-- ChatFrame7:AddMessage("AloftTargetNameData:UpdateData(): process " .. tostring(aloftData.name) .. "/" .. tostring(aloftData.unitid) .. "/" .. tostring(aloftData.targetName))
	if aloftData.unitid then
		self:ScheduleTimer(function(aloftData) AloftTargetNameData:UpdateUnitNameplate(aloftData) end, delay, aloftData)
	else
		self:ScheduleTimer(function(aloftData) AloftTargetNameData:UpdateNameplate(aloftData) end, delay, aloftData)
	end
end

--[[ currently dead code
function AloftTargetNameData:StartUpdates()
	if not isUpdating then
		self:ScheduleRepeatingTimer(function() AloftTargetNameData:Update() end, 0.2)
		isUpdating = true
	end
end

function AloftTargetNameData:StopUpdates()
	if isUpdating and not next(updateList) then
		self:CancelAllTimers()
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
			self:SendMessage("Aloft:OnTargetNameDataChanged", aloftData)
		end
	end
end

function AloftTargetNameData:UpdateTargetTarget()
	if not self.db.profile.enable then return end -- stub out if disabled
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
					AloftTargetNameData:SendMessage("Aloft:OnTargetNameDataChanged", aloftData)
				end
			end
		end
	end
end

-----------------------------------------------------------------------------

end)
