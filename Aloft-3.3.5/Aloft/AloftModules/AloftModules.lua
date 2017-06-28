local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

-- global on purpose
AloftModules = Aloft:NewModule("Modules")
local AloftModules = AloftModules

-----------------------------------------------------------------------------

AloftModules.db = Aloft:AcquireDBNamespace("modules")
Aloft:RegisterDefaults("modules", "profile", {
	AloftLDB = true,
})

-----------------------------------------------------------------------------

local systemCount = 0
local systemNameMap = { }
local systemInitialization = { }
local profile

-----------------------------------------------------------------------------

function AloftModules:OnInitialize()
	profile = self.db.profile

	-- all files have been seen and all dynamic code is read, at this point, so make sure the dynamic code is loaded
	self:Initialize()
end

function AloftModules:OnEnable()
	self:Activate()
end

function AloftModules:OnDisable()
end

-----------------------------------------------------------------------------

-- save an initializer in an order list of initializers (in file load order) by addon
function AloftModules:AddInitializer(sysname, initializer)
	-- TODO: argument checks
	if sysname and initializer then
		local systemIndex = systemNameMap[sysname]
		if not systemIndex then
			systemCount = systemCount + 1
			systemIndex = systemCount
			systemInitialization[systemIndex] = { name = sysname, count = 0, initializers = { }, }
			systemNameMap[sysname] = systemIndex
		end

		local count = systemInitialization[systemIndex].count + 1
		systemInitialization[systemIndex].count = count
		systemInitialization[systemIndex].initializers[count] = initializer
	end
end

-- execute all initializers (in file load order) for all modules, if they have not already been loaded
function AloftModules:Initialize()
	for i = 1, systemCount do
		local initialization = systemInitialization[i]
		if (profile[initialization.name] and not initialization.loaded) then
			for j = 1, initialization.count do
				initializer = initialization.initializers[j]
				initializer()
			end
			initialization.loaded = true
		end
	end
end

-----------------------------------------------------------------------------

function AloftModules:Activate()
	-- iterate all nameplates, effectively hide them (strip them of data)
	for aloftData in Aloft:IterateVisibleNameplates() do
		Aloft:TriggerEvent("Aloft:OnNameplateHide", aloftData)
	end

	for _, module in Aloft:IterateModules() do
		-- if the module is dynamic, shut it down
		if module.dynamic then
			if type(module.DisableDataSource) == "function" then module:DisableDataSource() end
			if type(module.OnDisable) == "function" then module:OnDisable() end
			Aloft:ToggleModuleActive(module, false)
		end
	end

	-- activate current dynamic modules; TODO: only activate those that are flagged for load
	for _, module in Aloft:IterateModules() do
		-- ChatFrame7:AddMessage("AloftModules:Activate(): " .. tostring(module) .. "/" .. tostring(module.name) .. "/" .. tostring(module.dynamic) .. "/" .. tostring(profile[module.dynamic]))
		if module.dynamic and profile[module.dynamic] then
			Aloft:ToggleModuleActive(module, true)
			if type(module.OnInitialize) == "function" then module:OnInitialize() end
			if type(module.OnEnable) == "function" then module:OnEnable() end
		end
	end

	-- clear out all (possibly obsolete) text tags
	self:Regenerate()

	-- iterate all nameplates, effectively show them (add all data back into them)
	for aloftData in Aloft:IterateNameplates() do
		Aloft:UpdateAloftData(aloftData)
		Aloft:TriggerEvent("Aloft:OnNameplateShow", aloftData)
	end
end

function AloftModules:Regenerate()
	-- clear out text tags
	Aloft:InvalidateCompileCache()
	for _, module in Aloft:IterateModules() do
		-- reset any text tag data that may be cached; we may be adding new tags
		if (module.textMethodData) then module.textMethodData = nil end
		if (module.textMethod) then module.textMethod = nil end
	end

	-- this will re-establish text tags as needed, including any that may have just been enabled
	Aloft:DetermineDataSources()

	Aloft:BounceEnemyNameplates()
	Aloft:BounceFriendNameplates()
end

-----------------------------------------------------------------------------
