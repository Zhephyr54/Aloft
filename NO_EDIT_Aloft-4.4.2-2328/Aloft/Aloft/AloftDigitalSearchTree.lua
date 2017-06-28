local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

-- this actually returns a string; in 8-bit character sets, this string will contain a single character
local function getNextCharacter(key, start)
	local len = 0
	local b = key:byte(start)

	if not b then
		-- no characters to extract
	elseif b <= 127 then
		len = len + 1
	elseif b <= 223 then
		len = len + 2
	elseif b <= 239 then
		len = len + 3
	else
		len = len + 4
	end

	if len > 0 then
		return len, key:sub(start, start+len-1)
	else
		return 0, nil
	end
end

local function isNodeEmpty(tree)
	-- TODO: don't quite know what to make of the LUA reference manual; looks like this is actually safer than #
	for k, _ in pairs(tree) do
		return nil
	end
	return true
end

local function delDST(tree, key, start)
	local len, char = getNextCharacter(key, start)
	if char and len > 0 then
		-- ChatFrame7:AddMessage("Aloft:delDST(): traverse " .. tostring(tree) .. "/" .. tostring(key) .. "/" .. tostring(char) .. "/" .. tostring(start + len - 1) .. "/" .. tostring(key:sub(1, start + len - 1)))
		delDST(tree[char], key, start + len)
		if isNodeEmpty(tree[char]) then
			-- ChatFrame7:AddMessage("Aloft:delDST(): prune leaf " .. tostring(tree) .. "/" .. tostring(key) .. "/" .. tostring(char) .. "/" .. tostring(start + len - 1) .. "/" .. tostring(key:sub(1, start + len - 1)))
			tree[char] = nil -- prune leaf node, nothing there any more
		end
	else
		-- ChatFrame7:AddMessage("Aloft:delDST(): prune EOK " .. tostring(tree) .. "/" .. tostring(tree[0]) .. "/" .. tostring(key))
		tree[0] = nil -- value terminated, flag as no longer an EOK
	end
end

-----------------------------------------------------------------------------

-- adds a string key/value to a digital search tree
function Aloft:AddDST(tree, key, value)
	local start = 1
	local finish = key:len()
	local lastTree = tree
	while start <= finish do
		local len, char = getNextCharacter(key, start)
		-- ChatFrame7:AddMessage("Aloft:BuildDST(): traverse " .. tostring(key) .. "/" .. tostring(start) .. "/" .. tostring(finish) .. "/" .. tostring(char) .. "/" .. tostring(key:sub(start)))
		if char and len > 0 then
			start = start + len
			if not lastTree[char] then
				lastTree[char] = { } -- add new sub-tree
			end

			lastTree = lastTree[char] -- traverse to new sub-tree
		else
			-- ChatFrame7:AddMessage("Aloft:BuildDST(): premature " .. tostring(key) .. "/" .. tostring(start) .. "/" .. tostring(finish))
			break
		end
	end

	lastTree[0] = value -- the presence of a value here flags this as an EOK
	-- ChatFrame7:AddMessage("Aloft:BuildDST(): terminate " .. tostring(key) .. "/" .. tostring(start) .. "/" .. tostring(finish))
end

-- delete a key from a digital search tree
function Aloft:DelDST(tree, key)
	delDST(tree, key, 1)
end

function Aloft:IsDSTValue(tree, key)
	local found = true
	local start = 1
	local finish = key:len()
	local lastTree = tree
	while lastTree and start <= finish do
		local len, char = getNextCharacter(key, start)
		if char and len > 0 then
			start = start + len
			lastTree = lastTree[char]
		end
	end
	-- ChatFrame7:AddMessage("Aloft:IsDSTValue(): traverse " .. tostring(value) .. "/" .. tostring(finish) .. "/" .. tostring(lastTree) .. "/" .. tostring(lastTree and lastTree[0]))
	return lastTree and lastTree[0] -- is this node flagged as an EOK?
end

-----------------------------------------------------------------------------

function Aloft:DumpDST(tree, str)
	for k, v in pairs(tree) do
		if k ~= 0 then
			self:DumpDST(v, str .. k)
		else
			ChatFrame7:AddMessage("Aloft:DumpDST(): " .. tostring(str))
		end
	end
end

-----------------------------------------------------------------------------
