while true do
	Core['Connect_check_PLC'] = Core['Connect_check_PLC']+1
	if Core['Connect_check_PLC'] == 200 then Core['Connect_check_PLC'] = 0 end
	os.sleep(0.1)
end