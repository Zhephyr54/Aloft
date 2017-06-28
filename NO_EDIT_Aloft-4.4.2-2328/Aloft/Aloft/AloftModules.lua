local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

-- global on purpose
AloftModules = Aloft:NewModule("Modules", Aloft)
local AloftModules = AloftModules

-----------------------------------------------------------------------------

AloftModules.namespace = "modules"
AloftModules.defaults =
{
	profile =
	{
		AloftLDB = true,
	},
}

-----------------------------------------------------------------------------

local systemCount = 0
local systemNameMap = { }
local systemInitialization = { }

-----------------------------------------------------------------------------

function AloftModules:OnInitialize()
	-- all files have been seen and all dynamic code is read, at this point, so make sure the dynamic code is loaded
	if self.db ~= Aloft.AloftDB:GetNamespace(self.namespace, true) then self.db = Aloft.AloftDB:RegisterNamespace(self.namespace, self.defaults) end
	self:Initialize()
end

function AloftModules:OnEnable()
	self:Activate()
end

function AloftModules:OnDisable()
end

-----------------------------------------------------------------------------

-- save an initializer method in an order list of initializers (in file load order) by addon
function AloftModules:AddInitializer(sysname, method)
	-- TODO: argument checks
	if sysname and method then
		local systemIndex = systemNameMap[sysname]
		if not systemIndex then
			systemCount = systemCount + 1
			systemIndex = systemCount
			systemInitialization[systemIndex] = { name = sysname, count = 0, initializers = { }, }
			systemNameMap[sysname] = systemIndex
		end

		local count = systemInitialization[systemIndex].count + 1
		systemInitialization[systemIndex].count = count
		systemInitialization[systemIndex].initializers[count] = { method = method }
	end
end

-- execute all initializers (in file load order) for all modules, if they have not already been loaded
function AloftModules:Initialize()
	for i = 1, systemCount do
		local initialization = systemInitialization[i]
		if self.db.profile[initialization.name] then
			for j = 1, initialization.count do
				initializer = initialization.initializers[j]
				if not initializer.loaded then
					initializer.method()
					initializer.loaded = true
				end
			end
		end
	end
end

-----------------------------------------------------------------------------

function AloftModules:Activate()
	-- iterate all nameplates, effectively hide them (strip them of data)
	for aloftData in Aloft:IterateVisibleNameplates() do
		Aloft:SendMessage("Aloft:OnNameplateHide", aloftData)
	end

	for name, module in Aloft:IterateModules() do
		-- if the module is dynamic, shut it down
		if module.dynamic then
			if type(module.DisableDataSource) == "function" then module:DisableDataSource() end

			module:Disable()
		end
	end

	-- activate current dynamic modules; TODO: only activate those that are flagged for load
	for name, module in Aloft:IterateModules() do
		-- ChatFrame7:AddMessage("AloftModules:Activate(): " .. tostring(name) .. "/" .. tostring(module.name) .. "/" .. tostring(module.dynamic) .. "/" .. tostring(self.db.profile[module.dynamic]))
		if module.dynamic and self.db.profile[module.dynamic] then
			-- ChatFrame7:AddMessage("AloftModules:Activate(): ----- ACTIVATE ----- " .. tostring(name) .. "/" .. tostring(module.name) .. "/" .. tostring(module.dynamic) .. "/" .. tostring(self.db.profile[module.dynamic]))
			if not module:IsEnabled() then module:Enable() end
		end
	end

	-- activate current dynamic modules; TODO: only activate those that are flagged for load
	for name, module in Aloft:IterateModules() do
		-- ChatFrame7:AddMessage("AloftModules:Activate(): " .. tostring(name) .. "/" .. tostring(module.name) .. "/" .. tostring(module.dynamic) .. "/" .. tostring(self.db.profile[module.dynamic]))
		if module.dynamic and self.db.profile[module.dynamic] then
			-- ChatFrame7:AddMessage("AloftModules:Activate(): ----- ACTIVATE ----- " .. tostring(name) .. "/" .. tostring(module.name) .. "/" .. tostring(module.dynamic) .. "/" .. tostring(self.db.profile[module.dynamic]))
			if not module:IsEnabled() then module:Enable() end
		end
	end

	-- clear out all (possibly obsolete) text tags
	self:Regenerate()

	-- iterate all nameplates, effectively show them (add all data back into them)
	for aloftData in Aloft:IterateVisibleNameplates() do
		if aloftData.name ~= "[invalid]" then
			Aloft:UpdateAloftData(aloftData)
			Aloft:SendMessage("Aloft:OnNameplateShow", aloftData)
		end
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

--[[
      -- from the LUA tutorial
	  function pairsByKeys (t, f)
      local a = {}
      for n in pairs(t) do table.insert(a, n) end
      table.sort(a, f)
      local i = 0      -- iterator variable
      local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i] ]
        end
      end
      return iter
    end
]]