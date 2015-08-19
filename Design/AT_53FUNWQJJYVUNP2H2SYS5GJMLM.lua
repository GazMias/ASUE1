while true do
	Core['Connect_check_ARM1'] = Core['Connect_check_ARM1']+1
	if Core['Connect_check_ARM1'] == 200 then Core['Connect_check_ARM1'] = 0 end
	os.sleep(0.1)
end