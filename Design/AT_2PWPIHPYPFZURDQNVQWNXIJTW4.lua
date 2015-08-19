while true do
	Core['Connect_check_ARM2'] = Core['Connect_check_ARM2']+1
	if Core['Connect_check_ARM2'] == 200 then Core['Connect_check_ARM2'] = 0 end
	os.sleep(0.1)
end