while true do	
	if Core['Check_changes_Server2'] == Core['Connect_check_Server2'] then 
		Core['Break_Server2'] = true else 
		Core['Break_Server2'] = false end
	Core['Check_changes_Server2'] = Core['Connect_check_Server2']
	if Core['Check_changes_ARM1'] == Core['Connect_check_ARM1'] then 
		Core['Break_ARM1'] = true else 
		Core['Break_ARM1'] = false end
	Core['Check_changes_ARM1'] = Core['Connect_check_ARM1']
	if Core['Check_changes_ARM2'] == Core['Connect_check_ARM2'] then 
		Core['Break_ARM2'] = true else 
		Core['Break_ARM2'] = false end
	Core['Check_changes_ARM2'] = Core['Connect_check_ARM2']
	if Core['Check_changes_Server2'] == Core['Connect_check_Server2'] then 
		Core['Break_Server2'] = true else 
		Core['Break_Server2'] = false end
	Core['Check_changes_Server2'] = Core['Connect_check_Server2']
	if Core['Check_changes_PLC'] == Core['Connect_check_PLC'] then 
		Core['Break_PLC'] = true else 
		Core['Break_PLC'] = false end
	Core['Check_changes_PLC'] = Core['Connect_check_PLC']
	os.sleep(1)
end