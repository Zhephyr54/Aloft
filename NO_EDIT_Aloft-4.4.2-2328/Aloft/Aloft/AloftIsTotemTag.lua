local Aloft = Aloft
if not Aloft then return end
local AloftLocale = AloftLocale
if not AloftLocale then return end

-----------------------------------------------------------------------------

local totemMap = Aloft.IsTotemMap
if not totemMap then return end

-----------------------------------------------------------------------------

Aloft.TagData.IsTotem =
{
	method = function(aloftData, value) return aloftData and Aloft:IsTotem(aloftData) and value end
}

-----------------------------------------------------------------------------

function Aloft:IsTotem(aloftData)
	name = aloftData and aloftData.name
	if name --[[and not (aloftData.isPet or aloftData.petOwnersName)]] then
		return totemMap[name]
	end
	return nil
end

-----------------------------------------------------------------------------
