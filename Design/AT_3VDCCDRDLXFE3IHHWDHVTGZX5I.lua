while true do
	Core['Connect_check_Server2'] = Core['Connect_check_Server2']+1
	if Core['Connect_check_Server2'] == 200 then Core['Connect_check_Server2'] = 0 end
	os.sleep(0.1)
end