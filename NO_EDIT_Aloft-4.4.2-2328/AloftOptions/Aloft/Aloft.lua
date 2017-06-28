local Aloft = Aloft
if not Aloft then return end
local AloftModules = AloftModules
if not AloftModules then return end

-----------------------------------------------------------------------------

-- global on purpose
AloftOptions = LibStub("AceAddon-3.0"):NewAddon("AloftOptions")

-----------------------------------------------------------------------------

local AloftOptions = AloftOptions

-----------------------------------------------------------------------------

function AloftOptions:OnInitialize()
	-- all files have been seen and all dynamic code is read, at this point, so make sure the dynamic code is loaded
	-- ChatFrame7:AddMessage("AloftOptions:OnInitialize(): enter")
	AloftModules:Initialize()
end

function AloftOptions:OnEnable()
	-- ChatFrame7:AddMessage("AloftOptions:OnEnable(): enter")
	AloftModules:Activate()
end

function AloftOptions:OnDisable()
end

-----------------------------------------------------------------------------

