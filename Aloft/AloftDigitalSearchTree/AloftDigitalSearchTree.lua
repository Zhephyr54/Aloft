local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

-- this actually returns a string; in 8-bit character sets, this string will contain a single character
local function getNextCharacter(value, start)
	local len = 0
	local b = value:byte(start)

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
		return len, value:sub(start, start+len-1)
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

local function delDST(tree, value, start)
	local len, char = getNextCharacter(value, start)
	if char and len > 0 then
		-- ChatFrame7:AddMessage("Aloft:delDST(): traverse " .. tostring(tree) .. "/" .. tostring(value) .. "/" .. tostring(char) .. "/" .. tostring(start + len - 1) .. "/" .. tostring(value:sub(1, start + len - 1)))
		delDST(tree[char], value, start + len)
		if isNodeEmpty(tree[char]) then
			-- ChatFrame7:AddMessage("Aloft:delDST(): prune leaf " .. tostring(tree) .. "/" .. tostring(value) .. "/" .. tostring(char) .. "/" .. tostring(start + len - 1) .. "/" .. tostring(value:sub(1, start + len - 1)))
			tree[char] = nil -- prune leaf node, nothing there any more
		end
	else
		-- ChatFrame7:AddMessage("Aloft:delDST(): prune EOS " .. tostring(tree) .. "/" .. tostring(tree[0]) .. "/" .. tostring(value))
		tree[0] = nil -- value terminated, flag as no longer an EOS
	end
end

-----------------------------------------------------------------------------

-- adds a string value to a digital search tree
function Aloft:AddDST(tree, value)
	local start = 1
	local finish = value:len()
	local lastTree = tree
	while start <= finish do
		local len, char = getNextCharacter(value, start)
		-- ChatFrame7:AddMessage("Aloft:BuildDST(): traverse " .. tostring(value) .. "/" .. tostring(start) .. "/" .. tostring(finish) .. "/" .. tostring(char) .. "/" .. tostring(value:sub(start)))
		if char and len > 0 then
			start = start + len
			if not lastTree[char] then
				lastTree[char] = { } -- add new sub-tree
			end

			lastTree = lastTree[char] -- traverse to new sub-tree
		else
			-- ChatFrame7:AddMessage("Aloft:BuildDST(): premature " .. tostring(value) .. "/" .. tostring(start) .. "/" .. tostring(finish))
			break
		end
	end

	lastTree[0] = true -- flag as an EOS; could also be used to hold an action to perform on this string
	-- ChatFrame7:AddMessage("Aloft:BuildDST(): terminate " .. tostring(value) .. "/" .. tostring(start) .. "/" .. tostring(finish))
end

-- delete a string value from a digital search tree
function Aloft:DelDST(tree, value)
	delDST(tree, value, 1)
end

function Aloft:IsDSTValue(tree, value)
	local found = true
	local start = 1
	local finish = value:len()
	local lastTree = tree
	while lastTree and start <= finish do
		local len, char = getNextCharacter(value, start)
		if char and len > 0 then
			start = start + len
			lastTree = lastTree[char]
		end
	end
	-- ChatFrame7:AddMessage("Aloft:IsDSTValue(): traverse " .. tostring(value) .. "/" .. tostring(finish) .. "/" .. tostring(lastTree) .. "/" .. tostring(lastTree and lastTree[0]))
	return lastTree and lastTree[0] -- is this node flagged as an EOS?
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
