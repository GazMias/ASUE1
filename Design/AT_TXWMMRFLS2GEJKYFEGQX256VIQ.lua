local SOUND_CRITICAL = "SOUND_CRITICAL"
local SOUND_WARNING = "SOUND_WARNING"


function Blink(userArg)
	Core[userArg] = not Core[userArg]
end

function signaling (localarm,locwarning)
	if (localarm == true) then
--		Core.onTimer(1,0.5,Blink,SOUND)		
	elseif (localarm ==true) then
--		Core.onTimer(2,5,Blink,SOUND)
	elseif (locwarning == false) and (localarm == false) then
--		SOUND = false
	end	
end

--Core.onExtChange({SOUND_CRITICAL,SOUND_WARNING}, signaling, {SOUND_CRITICAL,SOUND_WARNING})
--Core.waitEvents( )

