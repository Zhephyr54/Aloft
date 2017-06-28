local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local TagCompiler = LibStub("TagCompiler-2.0")

-----------------------------------------------------------------------------

local white = { 1.0, 1.0, 1.0, }

-----------------------------------------------------------------------------

Aloft.TagData =
{
	["!TagError"] = function(x) Aloft:Print(x) end,
--	["!TagDebug"] = function(x) Aloft:Debug(x) end
}

-----------------------------------------------------------------------------

for k,v in pairs(TagCompiler.CommonTagData) do
	Aloft.TagData[k] = v
end

-----------------------------------------------------------------------------

Aloft.TagData.IsPlayer =
{
	tableData = "isPlayer",
}

Aloft.TagData.Type =
{
	tableData = "type",
}

Aloft.TagData.HealthBarDeficit =
{
	events = "Aloft:OnHealthBarValueChanged",
	compileString = function(dataTable, prior) return string.format("%s%s(data.healthBarMaxValue - data.healthBarValue)", prior or "", prior and " and " or "") end,
	guaranteeResult = true,
	numeric = true
}

Aloft.TagData.HealthBarDeficit =
{
	events = "Aloft:OnHealthBarValueChanged",
	compileString = function(dataTable, prior) return string.format("%s%s(data.healthBarMaxValue - data.healthBarValue)", prior or "", prior and " and " or "") end,
	guaranteeResult = true,
	numeric = true
}

Aloft.TagData.HealthBarMaxValue =
{
	events = "Aloft:OnHealthBarValueChanged",
	tableData = "healthBarMaxValue",
	guaranteeResult = true,
	numeric = true
}

Aloft.TagData.HealthBarValue =
{
	events = "Aloft:OnHealthBarValueChanged",
	tableData = "healthBarValue",
	guaranteeResult = true,
	numeric = true
}

Aloft.TagData.HealthFraction =
{
	events = "Aloft:OnHealthBarValueChanged",
	compileString = function(dataTable, prior) return string.format("data.healthBarValue and data.healthBarMaxValue and data.healthBarMaxValue > 0 and %s%s(ceil(100.0 * (data.healthBarValue / data.healthBarMaxValue)) / 100.0)", prior or "", prior and " and " or "") end,
	guaranteeResult = true,
	numeric = true
}

Aloft.TagData.IsGroup =
{
	compileString = function(dataTable, prior) return string.format("data.healthBarMaxValue ~= 100%s%s", prior and " and " or "", prior or "") end,
	noGuaranteeChange = true
}

Aloft.TagData.IsNotGroup =
{
	compileString = function(dataTable, prior) return string.format("data.healthBarMaxValue == 100%s%s", prior and " and " or "", prior or "") end,
	noGuaranteeChange = true
}

Aloft.TagData.IsBoss = { tableData = "isBoss" }
Aloft.TagData.IsElite = { tableData = "isElite" }

Aloft.TagData.IsFriendly =
{
	compileString = function(dataTable, prior)
						return string.format("(data.type == \"friendlyPlayer\" or data.type == \"friendlyNPC\")%s%s", prior and " and " or "", prior or "")
					end
}

Aloft.TagData.IsFriendlyNPC =
{
	compileString = function(dataTable, prior) return string.format("data.type == \"friendlyNPC\"%s%s", prior and " and " or "", prior or "") end
}

Aloft.TagData.IsFriendlyPlayer =
{
	compileString = function(dataTable, prior) return string.format("data.type == \"friendlyPlayer\"%s%s", prior and " and " or "", prior or "") end
}

Aloft.TagData.IsHostile =
{
	compileString = function(dataTable, prior) return string.format("data.type == \"hostile\"%s%s", prior and " and " or "", prior or "") end
}

Aloft.TagData.IsNeutral =
{
	compileString = function(dataTable, prior) return string.format("data.type == \"neutral\"%s%s", prior and " and " or "", prior or "") end
}

Aloft.TagData.IsMaxHealth =
{
	events = "Aloft:OnHealthBarValueChanged",
	compileString = function(dataTable, prior) return string.format("data.healthBarValue == data.healthBarMaxValue%s%s", prior and " and " or "", prior or "") end
}

Aloft.TagData.Level =
{
	-- TODO: self-hook AloftLevelText as well, vis [Level]?
	events = "Aloft:OnUnitLevelChanged",
	tableData = "level", numeric = true,
}

Aloft.TagData.Name =
{
	-- NOTE: the data field here allows the AloftNameText module to self-hook itself into the data/module heirarchy;
	--       AloftNameText is an always-loaded module, and the [Name] tag is always valid, so this should be harmless,
	--       and it provides an anchor for things like the [Class] tag, if it is needed for various "Color By Class" option(s)
	data = "name",
	events = "Aloft:OnUnitNameChanged",
	tableData = "name",
	guaranteeResult = true
}

Aloft.TagData.HealthBarColor =
{
	events = "Aloft:OnSetHealthBarColor",
	method = function(aloftData, value)
		local healthBarR = aloftData.healthBarR
		local healthBarG = aloftData.healthBarG
		local healthBarB = aloftData.healthBarB

		-- if (value) then
			-- local healthBarA = aloftData.healthBarA
			-- if (not healthBarR or not healthBarG or not healthBarB or healthBarA) then
				-- local healthBar = aloftData.healthBar

				-- Aloft:ProcessHealthBarColor(aloftData) -- TODO: see comments on this function in Aloft/Aloft.lua

				-- ChatFrame7:AddMessage("AloftAloftTag:HealthBarColor(): " .. aloftData.name)
				-- ChatFrame7:AddMessage("AloftAloftTag:HealthBarColor(): " .. ("|cff%02x%02x%02x%s|r"):format(aloftData.healthBarR*255, aloftData.healthBarG*255, aloftData.healthBarB*255, "health bar color"))
			-- end
		-- end
	
		if not value or not healthBarR or not healthBarG or not healthBarB
		   or type(healthBarR) ~= "number" or type(healthBarG) ~= "number" or type(healthBarB) ~= "number" then
			-- ChatFrame7:AddMessage("Aloft.TagData.HealthBarColor.method(): " .. tostring(aloftData.name) .. "/" .. tostring(value) .. "/" .. tostring(healthBarR) .. "/" .. tostring(healthBarG) .. "/" .. tostring(healthBarB))
			return "" -- stub out with an empty string, this cannot be properly formatted
		end
	
		return ("|cff%02x%02x%02x%s|r"):format(healthBarR*255, healthBarG*255, healthBarB*255, value)
	end,
	noGuaranteeChange = true
}

Aloft.TagData.OriginalHealthBarColor =
{
	events = "Aloft:OnSetHealthBarColor",
	method = function(aloftData, value)
		local healthBarR = aloftData.originalHealthBarR
		local healthBarG = aloftData.originalHealthBarG
		local healthBarB = aloftData.originalHealthBarB

		-- TODO: check RGB for nil, fetch if needed?
		-- if (value) then
			-- ChatFrame7:AddMessage("AloftAloftTag:OriginalHealthBarColor(): " .. aloftData.name)
			-- ChatFrame7:AddMessage("AloftAloftTag:OriginalHealthBarColor(): " .. ("|cff%02x%02x%02x%s|r"):format(healthBarR*255, aloftData.originalHealthBarG*255, aloftData.originalHealthBarB*255, "original health bar color"))
		-- end
	
		if not value or not healthBarR or not healthBarG or not healthBarB
		   or type(healthBarR) ~= "number" or type(healthBarG) ~= "number" or type(healthBarB) ~= "number" then
			-- ChatFrame7:AddMessage("Aloft.TagData.OriginalHealthBarColor.method(): " .. tostring(aloftData.name) .. "/" .. tostring(value) .. "/" .. tostring(healthBarR) .. "/" .. tostring(healthBarG) .. "/" .. tostring(healthBarB))
			return "" -- stub out with an empty string, this cannot be properly formatted
		end

		return ("|cff%02x%02x%02x%s|r"):format(healthBarR*255, healthBarG*255, healthBarB*255, value)
	end,
	noGuaranteeChange = true
}

Aloft.TagData.ClassColor =
{
	events = "Aloft:OnClassDataChanged",
	method = function(aloftData, value)
		local color = (aloftData.class and Aloft.db.profile.classColors[aloftData.class]) or white
		return (value and ("|cff%02x%02x%02x%s|r"):format(color[1]*255, color[2]*255, color[3]*255, value)) or ""
	end,
	noGuaranteeChange = true
}

Aloft.TagData.DifficultyColor =
{
	method = function(aloftData, value) return (value and ("|cff%02x%02x%02x%s|r"):format(aloftData.levelTextR*255, aloftData.levelTextG*255, aloftData.levelTextB*255, value)) or "" end,
	noGuaranteeChange = true
}

Aloft.TagData.Truncate =
{
	-- lifted more or less completely from LibDogTags-3.0-90203 text manipulation; thanks and all credit to CKKnight/Shefki
	method = function(data, value, number, ...)
		if not value or number <= 0 then return nil end -- truncating to zero or less effectively "deletes" value

		local ellipses = select(1, ...) -- pull out the one and only expected (optional) argument from varargs
		-- ChatFrame7:AddMessage("AloftTag:TagData.Truncate.method(): " .. tostring(value) .. "/" .. tostring(number) .. "/" .. tostring(ellipses))

		local len = 0
		for i = 1, number do
			local b = value:byte(len+1)
			if not b then
				shortened = false
				break
			elseif b <= 127 then
				len = len + 1
			elseif b <= 223 then
				len = len + 2
			elseif b <= 239 then
				len = len + 3
			else
				len = len + 4
			end
		end

		local val = value and value:sub(1, len)
		if ellipses and value and value:byte(len+1) then
			val = val .. ellipses
		end
		return val
	end,
	noGuaranteeChange = true,
	parameterTypes = { "number", "*string" }
}

-----------------------------------------------------------------------------

-- Initialise the compile cache with an empty tag, something which would otherwise need some extra special-cased code
local compileCache =
{
	[""] = { data = { }, events = { }, tag = "", method = function() return "" end },
}

function Aloft:InvalidateCompileCache()
	for tag, compile in pairs(compileCache) do
		if (tag ~= "") then
			compile.tag = nil
			compile.data = nil
			compile.events = nil
			compile.method = nil

			compileCache[tag] = nil
		end
	end
end

function Aloft:CreateTag(tag, clearCache)
	local parseTag = tag or ""

	if clearCache then
		compileCache[parseTag] = nil
	elseif compileCache[parseTag] then
		return compileCache[parseTag]
	end

	-- ChatFrame7:AddMessage("AloftAloftTag:CreateTag(): tag " .. tostring(tag))
	local result = TagCompiler:Compile(tag, self.TagData, "string")
	compileCache[tag] = result
	return result
end

function Aloft:FixTagCasing(tag)
	return TagCompiler:FixCasing(tag:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""), self.TagData, "string")
end

function Aloft:HighlightTagSyntax(tag)
	return TagCompiler:HighlightSyntax(tag, self.TagData, "string")
end

-----------------------------------------------------------------------------
