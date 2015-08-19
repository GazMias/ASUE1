local objects=					--Список объектов для входа и выхода
{
["RAW_BMPA_"]="S_KTP_P07_BMPA_"
}
local commands_operator =--Список команд от оператора
{
        ["Cmd_Rd_Nak_CO"]= {["Comment"]="Чтение  накопи-тельной  инфор-мации",["eval"]= 
													 function(Name) 
													 if Core[Name[2].."Cmd_Rd_Nak_CO"]==true then
													 Core[Name[1].."Reg_Cmd_WinRd_Only"]=(0xC712<<16)+(0x9DDB) --ПРИСВОИТЬ инициализированные регистры														
													 os.sleep(2)
													 Core[Name[1].."Reg_Cmd_WinRd_Only"]=0
													 Core[Name[2].."Cmd_Rd_Nak_CO"]=false
													 end 
end},

        ["KVIT_CO"]= {["Comment"]="Квитирование ",["eval"]= 
														function(Name) 
														if Core[Name[2].."KVIT_CO"]==true then
														Core[Name[1].."Reg_NetCtrl1"]=(0x691A<<16)+(0x2C8D) --ПРИСВОИТЬ инициализированные регистры														
													    os.sleep(2)
													    Core[Name[1].."Reg_NetCtrl1"]=0
													    Core[Name[2].."KVIT_CO"]=false
													end 
end},
        ["OTKV_CO"]= {["Comment"]="Отключить выключатель ",["eval"]= 
															function(Name) 
															if Core[Name[2].."OTKV_CO"]==true then
															 Core[Name[1].."Reg_NetCtrl"]=(Core[Name[1].."Reg_Block_ID"][0]<<24)+(0x0D<<16)+(0x0<<8)+(0x0D) --ПРИСВОИТЬ инициализированные регистры														
															 os.sleep(2)
															 Core[Name[1].."Reg_NetCtrl"]=0
															 Core[Name[2].."OTKV_CO"]=false
															 end 
end},
        
["Reg_Time_Set_CO"]= {["Comment"]="Установка текущего астрономического времени",["eval"]= 
function(Name) 
if Core[Name[2].."Reg_Time_Set_CO"]==true then
local two_digit_year,month,day_of_the_month,hour,minute,second,msec,second1,msec1,t_local,t_remote 														
two_digit_year=os.date("%y")
t_local=os.date("%3N")
t_remote=Core[Name[1].."Reg_DataCtrl1"][1]
month=os.date("%m")
day_of_the_month=os.date("%d")
hour=os.date("%H")
minute=os.date("%M")
second=os.date("%S")
msec=os.date("%3N")
Core[Name[1].."Reg_DataCtrl1"][7]=(tonumber(string.sub(two_digit_year,1,1))<<4)+tonumber(string.sub(two_digit_year,2,2))--заполнить регистр данных значением текущей даты
Core[Name[1].."Reg_DataCtrl1"][6]=(tonumber(string.sub(month,1,1))<<4)+tonumber(string.sub(month,2,2))
Core[Name[1].."Reg_DataCtrl1"][5]=(tonumber(string.sub(day_of_the_month,1,1))<<4)+tonumber(string.sub(day_of_the_month,2,2))
Core[Name[1].."Reg_DataCtrl1"][4]=(tonumber(string.sub(hour,1,1))<<4)+tonumber(string.sub(hour,2,2))
Core[Name[1].."Reg_DataCtrl1"][3]=(tonumber(string.sub(minute,1,1))<<4)+tonumber(string.sub(minute,2,2))
Core[Name[1].."Reg_DataCtrl1"][2]=(tonumber(string.sub(second,1,1))<<4)+(tonumber(string.sub(second,2,2))+4)
Core[Name[1].."Reg_DataCtrl1"][1]=(8<<4)+0
repeat  
second1=os.date("%S")
msec1=os.date("%3N")
until math.abs(second1-second)>3
Core[Name[1].."Reg_NetCtrl1"]=(0x691F<<16)+(0x2C92) --ПРИСВОИТЬ инициализированные регистры														
													 os.sleep(2)
													 Core[Name[1].."Reg_NetCtrl1"]=0
													 Core[Name[2].."Reg_Time_Set_CO"]=false
													end 

end},
        ["SBROSINFAV_CO"]= {["Comment"]="Сброс информации об авариях ",["eval"]= 
																			function(Name)  
 																			if Core[Name[2].."SBROSINFAV_CO"]==true then
																			Core[Name[1].."Reg_NetCtrl1"]=(0x691C<<16)+(0x2C8F) --ПРИСВОИТЬ инициализированные регистры														
																		 os.sleep(2)
																		 Core[Name[1].."Reg_NetCtrl1"]=0
															 			 Core[Name[2].."SBROSINFAV_CO"]=false
																		end 
end},
        ["SBROSINF_CO"]= {["Comment"]="Сброс накопительной информации ",["eval"]= 
																			function(Name) 
 																			if Core[Name[2].."SBROSINF_CO"]==true then
																			Core[Name[1].."Reg_NetCtrl1"]=(0x6919<<16)+(0x2C8C) --ПРИСВОИТЬ инициализированные регистры														
																		   os.sleep(2)
																		   Core[Name[1].."Reg_NetCtrl1"]=0
															 			   Core[Name[2].."SBROSINF_CO"]=false
																		 end 

end},
        ["SysCmd_T_Cor_CO"]= {["Comment"]="Коррекция астрономического времени",["eval"]= 
																						function(Name)  
														 if Core[Name[2].."SysCmd_T_Cor_CO"]==true then
														Core[Name[1].."Reg_NetCtrl1"]=(0x691E<<16)+(0x2C91) --ПРИСВОИТЬ инициализированные регистры														
													 os.sleep(2)
													 Core[Name[1].."Reg_NetCtrl1"]=0
													 Core[Name[2].."SysCmd_T_Cor_CO"]=false
													end 
end},
        ["VKLV_CO"]= {["Comment"]="Включить выключатель ",["eval"]= 
																		function(Name) 
																		if Core[Name[2].."VKLV_CO"]==true then
																		Core[Name[1].."Reg_NetCtrl"]=(Core[Name[1].."Reg_Block_ID"][0]<<24)+(0x0E<<16)+(0x0<<8)+(0x0E) --ПРИСВОИТЬ инициализированные регистры														
															 			os.sleep(2)
															 			Core[Name[1].."Reg_NetCtrl"]=0
															 			Core[Name[2].."VKLV_CO"]=false
															end 

end},
        ["VKLAVRSV_CO"]= {["Comment"]="Включить АВР СВ",["eval"]= 
																		function(Name) 
																		if Core[Name[2].."VKLAVRSV_CO"]==true then
																		Core[Name[1].."Reg_NetCtrl"]=(Core[Name[1].."Reg_Block_ID"][0]<<24)+(0x01<<16)+(0x0<<8)+(0x01) --ПРИСВОИТЬ инициализированные регистры														
															 			os.sleep(2)
															 			Core[Name[1].."Reg_NetCtrl"]=0
															 			Core[Name[2].."VKLAVRSV_CO"]=false 
end
end},
        ["OTKAVRSV_CO"]= {["Comment"]="Отключить АВР СВ",["eval"]= function(Name) 

																		if Core[Name[2].."OTKAVRSV_CO"]==true then
																		Core[Name[1].."Reg_NetCtrl"]=(Core[Name[1].."Reg_Block_ID"][0]<<24)+(0x02<<16)+(0x0<<8)+(0x02) --ПРИСВОИТЬ инициализированные регистры														
															 			os.sleep(2)
															 			Core[Name[1].."Reg_NetCtrl"]=0
															 			Core[Name[2].."OTKAVRSV_CO"]=false 
end
end},
["Reg_Time_Set_AV"] = {["comment"]="Установка текущего астрономического времени автоматически",["eval"]= function(Name) 
													 if Core[Name[2].."Reg_Time_Set_AV"]==true then
														
local two_digit_year,month,day_of_the_month,hour,minute,second,msec,second1,msec1,t_local,t_remote 														
two_digit_year=os.date("%y")
t_local=os.date("%3N")
t_remote=Core[Name[1].."Reg_DataCtrl1"][1]
month=os.date("%m")
day_of_the_month=os.date("%d")
hour=os.date("%H")
minute=os.date("%M")
second=os.date("%S")
msec=os.date("%3N")



Core[Name[1].."Reg_DataCtrl1"][7]=(tonumber(string.sub(two_digit_year,1,1))<<4)+tonumber(string.sub(two_digit_year,2,2))--заполнить регистр данных значением текущей даты
Core[Name[1].."Reg_DataCtrl1"][6]=(tonumber(string.sub(month,1,1))<<4)+tonumber(string.sub(month,2,2))
Core[Name[1].."Reg_DataCtrl1"][5]=(tonumber(string.sub(day_of_the_month,1,1))<<4)+tonumber(string.sub(day_of_the_month,2,2))
Core[Name[1].."Reg_DataCtrl1"][4]=(tonumber(string.sub(hour,1,1))<<4)+tonumber(string.sub(hour,2,2))
Core[Name[1].."Reg_DataCtrl1"][3]=(tonumber(string.sub(minute,1,1))<<4)+tonumber(string.sub(minute,2,2))
Core[Name[1].."Reg_DataCtrl1"][2]=(tonumber(string.sub(second,1,1))<<4)+(tonumber(string.sub(second,2,2))+4)

Core[Name[1].."Reg_DataCtrl1"][1]=(8<<4)+0

repeat  
second1=os.date("%S")
msec1=os.date("%3N")
until math.abs(second1-second)>3
Core[Name[1].."Reg_NetCtrl1"]=(0x691F<<16)+(0x2C92) --ПРИСВОИТЬ инициализированные регистры														
													 os.sleep(2)
													 Core[Name[1].."Reg_NetCtrl1"]=0
													 Core[Name[2].."Reg_Time_Set_AV"]=false
													end end}

}





  for raw_objectName, objectName in  pairs(objects) do  -- Перебираем все устройства.
   raw_objectName=raw_objectName
    for commands_operator_Suffix, commands_operator_Descriptor in pairs(commands_operator) do -- Перебираем все команды от оператора.
		commands_operator_Descriptor=commands_operator_Descriptor	
		Core[objectName..commands_operator_Suffix]=false --сбросить все команды в ноль
	end
  end


  for raw_objectName, objectName in  pairs(objects) do  -- Перебираем все устройства.
   
    for commands_operator_Suffix, commands_operator_Descriptor in pairs(commands_operator) do -- Перебираем все команды от оператора.
	Core.onExtChange({objectName..commands_operator_Suffix},commands_operator_Descriptor["eval"],{raw_objectName,objectName})
	

end
  end
    

	Core.waitEvents( )
