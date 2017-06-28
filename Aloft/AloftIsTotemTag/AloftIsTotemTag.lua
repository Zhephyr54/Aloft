local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

local L = Aloft.IsTotemLocale[GetLocale()] or Aloft.IsTotemLocale["default"]

-----------------------------------------------------------------------------

Aloft.TagData.IsTotem =
{
	method = function(aloftData, value) return aloftData and Aloft:IsTotem(aloftData) and value end
}

-----------------------------------------------------------------------------

function Aloft:IsTotem(aloftData)
	if aloftData and L --[[and not (aloftData.isPet or aloftData.petOwnersName)]] then
		local name = aloftData.name
		for i = 1, #L do
			if name:find(L[i]) then return true end
		end
	end
	return nil
end

-----------------------------------------------------------------------------
