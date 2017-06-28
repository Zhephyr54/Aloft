local Aloft = Aloft
if not Aloft then return end

-----------------------------------------------------------------------------

-- if not AceLibrary:HasInstance("Deluge-1.0") then DEFAULT_CHAT_FRAME:AddMessage("Aloft/Extras/Debug.lua: could not find library instance of Deluge-1.0; disabling Debug trace") return end
local AloftDebug = Aloft:NewModule("AloftDebug") -- TODO: load module here and exit with a message
local Deluge = AceLibrary:HasInstance("Deluge-1.0") and AceLibrary("Deluge-1.0")

-----------------------------------------------------------------------------

if (Deluge) then Aloft.Options.args.debug = Deluge:GetOptions() end

-----------------------------------------------------------------------------

function AloftDebug:OnInitialize()
	if (not Deluge) then return nil end
	Deluge:Initialize(Aloft, "Aloft", "debug")
end

function Aloft:DebugRegister(sysname)
	if (not Deluge) then return end
	Deluge:Register(sysname)
end

function Aloft:DebugUnregisterSubsystem(sysname)
	if (not Deluge) then return end
	Deluge:Unregister(sysname)
end

function Aloft:Log(sysname, method, level, text)
	if (not Deluge) then return end
	Deluge:LogSysLvl(sysname, method, level, text)
end

function Aloft:IsLogEnbl(sysname, level)
	if (not Deluge) then return false end
	return Deluge:IsSysLvlEnbl(sysname, level)
end

-----------------------------------------------------------------------------

function Aloft:LogEvent(sysname, method, level)
	local desc = event

	desc = desc .. "\t" .. (arg1 or "")
	desc = desc .. "\t" .. (arg2 or "")
	desc = desc .. "\t" .. (arg3 or "")
	desc = desc .. "\t" .. (arg4 or "")
	desc = desc .. "\t" .. (arg5 or "")
	desc = desc .. "\t" .. (arg6 or "")
	desc = desc .. "\t" .. (arg7 or "")
	desc = desc .. "\t" .. (arg8 or "")
	desc = desc .. "\t" .. (arg9 or "")
	desc = desc .. "\t" .. (arg10 or "")
	desc = desc .. "\t" .. (arg12 or "")
	desc = desc .. "\t" .. (arg13 or "")
	desc = desc .. "\t" .. (arg14 or "")
	desc = desc .. "\t" .. (arg15 or "")
	desc = desc .. "\t" .. (arg16 or "")
	desc = desc .. "\t" .. (arg17 or "")
	desc = desc .. "\t" .. (arg18 or "")
	desc = desc .. "\t" .. (arg19 or "")
	desc = desc .. "\t" .. (arg20 or "")

	Aloft:Log(sysname, method, level, strtrim(desc))
end

-----------------------------------------------------------------------------
