local Critical=2 
local Warning=1 
local Normal=0

local Event_array={
	--["S_ZRU_P11_VV1_3216_09_DP"]={msg_0= Core.getSignalComment("S_ZRU_P11_VV1_3216_09_DP").." 0", msg_1= Core.getSignalComment("S_ZRU_P11_VV1_3216_09_DP").." 1", cat=Normal},
	["S_ZRU_P11_VV1_3216_09_DP"]={Comment = "Ком",Sw_0 = " исчезновение",Sw_1 = " появление", cat=Mormal}
}


Critical=Critical
Warning=Warning

local function Event_Proc(Event)
	if Core[Event[1]]==false then
		Core.addEvent(Event[2] , Event[4], Core["USER_NAME_OUT"])
		if Event[4]==Warning then
			Core["SOUND_WARNING"]=1
		end
		if Event[4]==Critical then
			Core.SOUND_CRITICAL=1
		end
	elseif Core[Event[1]]==true then
		Core.addEvent(Event[3] , Event[4], Core["USER_NAME_OUT"])	
	end
end


for EventName, EventDescriptor in pairs(Event_array) do  -- Перебираем все события
	Core.onExtChange({EventName},Event_Proc,{EventName,EventDescriptor.Comment..Sw_0,EventDescriptor.Comment..Sw_1,EventDescriptor.cat})
end
Core.waitEvents( )
	
уаваисам