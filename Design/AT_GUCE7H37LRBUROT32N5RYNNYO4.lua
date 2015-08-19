Core["Reserve"] = false
Core["Reserve_inv"] = true

while true do
	os.sleep(1)
--[[
	local latency1 = Core.getLatency("SERVER_1.EventLogger")
	os.sleep(1)	
	local latency2 = Core.getLatency("SERVER_1.EventLogger")
		
	local reserve = latency1<0 and latency2<0
	
	Core["Reserve"] = reserve
	Core["Reserve_inv"] = not reserve
	]]--

end

