local objects=					--Список объектов для входа и выхода
{
["RAW_BMRZ_"]="S_KTP_P07_BVV1_",
["RAW_BMRZ_2_"]="S_KTP_P07_BVV2_"
}

local commands_operator =--Список команд от оператора
{
["OTKV_CO"] = {["comment"]="Отключить выключатель",["eval"]= function(Name) --Инициализировать и выдать команду в окно управления выключателем																												
															 if Core[Name[2].."OTKV_CO"]==true then
															 Core[Name[1].."Reg_NetCtrl"]=(Core[Name[1].."Reg_Block_ID"][0]<<24)+(0x0D<<16)+(0x0<<8)+(0x0D) --ПРИСВОИТЬ инициализированные регистры														
															 os.sleep(2)
															 Core[Name[1].."Reg_NetCtrl"]=0
															 Core[Name[2].."OTKV_CO"]=false
															 end end},
["VKLV_CO"] = {["comment"]="Включить выключатель",["eval"]= function(Name)
															 if Core[Name[2].."VKLV_CO"]==true then
																Core[Name[1].."Reg_NetCtrl"]=(Core[Name[1].."Reg_Block_ID"][0]<<24)+(0x0E<<16)+(0x0<<8)+(0x0E) --ПРИСВОИТЬ инициализированные регистры														
															 os.sleep(2)
															 Core[Name[1].."Reg_NetCtrl"]=0
															 Core[Name[2].."VKLV_CO"]=false
															end end},
["SBROSINFAV_CO"] = {["comment"]="Сброс информации об авариях",["eval"]= function(Name) 
																		 if Core[Name[2].."SBROSINFAV_CO"]==true then
																			Core[Name[1].."Reg_NetCtrl1"]=(0x691C<<16)+(0x2C8F) --ПРИСВОИТЬ инициализированные регистры														
																		 		Core[Name[1].."Reg_NetCtrl1_UP"]=true
os.sleep(2)
																		 Core[Name[1].."Reg_NetCtrl1"]=0
															 			 Core[Name[2].."SBROSINFAV_CO"]=false
																		end end},
["SBROSINF_CO"] = {["comment"]="Сброс накопительной информации",["eval"]= function(Name)
																		   if Core[Name[2].."SBROSINF_CO"]==true then
																			Core[Name[1].."Reg_NetCtrl1"]=(0x6919<<16)+(0x2C8C) --ПРИСВОИТЬ инициализированные регистры														
																		   		Core[Name[1].."Reg_NetCtrl1_UP"]=true
os.sleep(2)
																		   Core[Name[1].."Reg_NetCtrl1"]=0
															 			   Core[Name[2].."SBROSINF_CO"]=false
																		 end end},
["SBROSOSC_CO"] = {["comment"]="Сброс осциллограммы",["eval"]= function(Name)
																if Core[Name[2].."SBROSOSC_CO"]==true then
																Core[Name[1].."Reg_NetCtrl1"]=(0x6920<<16)+(0x2C93) --ПРИСВОИТЬ инициализированные регистры														
																		Core[Name[1].."Reg_NetCtrl1_UP"]=true
os.sleep(2)
																Core[Name[1].."Reg_NetCtrl1"]=0
															 	Core[Name[2].."SBROSOSC_CO"]=false
															  end end},
["SBROSPM_CO"] = {["comment"]="Сброс показаний максиметра",["eval"]= function(Name)
																	  if Core[Name[2].."SBROSPM_CO"]==true then
																		Core[Name[1].."Reg_NetCtrl1"]=(0x691B<<16)+(0x2C8E) --ПРИСВОИТЬ инициализированные регистры														
																	  		Core[Name[1].."Reg_NetCtrl1_UP"]=true
os.sleep(2)
																	  Core[Name[1].."Reg_NetCtrl1"]=0
															 	      Core[Name[2].."SBROSPM_CO"]=false
																	end end},
["KVIT_CO"] = {["comment"]="Квитирование",["eval"]= function(Name) 
													 if Core[Name[2].."KVIT_CO"]==true then
														Core[Name[1].."Reg_NetCtrl1"]=(0x691A<<16)+(0x2C8D) --ПРИСВОИТЬ инициализированные регистры														
													 		Core[Name[1].."Reg_NetCtrl1_UP"]=true
os.sleep(2)
													 Core[Name[1].."Reg_NetCtrl1"]=0
													 Core[Name[2].."KVIT_CO"]=false
													end end},
["Cmd_Rd_Nak_CO"] = {["comment"]="Чтение  накопи-тельной  инфор-мации",["eval"]= function(Name) 
													 if Core[Name[2].."Cmd_Rd_Nak_CO"]==true then
														Core[Name[1].."Reg_Cmd_WinRd_Only"]=(0xC712<<16)+(0x9DDB) --ПРИСВОИТЬ инициализированные регистры														
													 os.sleep(2)
													 Core[Name[1].."Reg_Cmd_WinRd_Only"]=0
													 Core[Name[2].."Cmd_Rd_Nak_CO"]=false
													end end},
["Reg_Time_Set_CO"] = {["comment"]="Установка текущего астрономического времени",["eval"]= function(Name) 
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
Core[Name[1].."Reg_DataCtrl1"][2]=(tonumber(string.sub(second,1,1))<<4)+(tonumber(string.sub(second,2,2)))
Core[Name[1].."Reg_DataCtrl1"][1]=(8<<4)+0

		Core[Name[2].."Reg_Time_Set_UP"]=true
		os.sleep(0.1)
Core[Name[1].."Reg_NetCtrl1"]=(0x691F<<16)+(0x2C92) --ПРИСВОИТЬ инициализированные регистры														
		Core[Name[1].."Reg_NetCtrl1_UP"]=true
													 os.sleep(2)
													 Core[Name[1].."Reg_NetCtrl1"]=0
													 Core[Name[2].."Reg_Time_Set_CO"]=false
													end end},
["SysCmd_T_Cor_CO"] = {["comment"]="Коррекция астрономического времени",["eval"]= function(Name) 
													 if Core[Name[2].."SysCmd_T_Cor_CO"]==true then
														Core[Name[1].."Reg_NetCtrl1"]=(0x691E<<16)+(0x2C91) --ПРИСВОИТЬ инициализированные регистры														
		Core[Name[1].."Reg_NetCtrl1_UP"]=true
													 os.sleep(2)
													 Core[Name[1].."Reg_NetCtrl1"]=0
													 Core[Name[2].."SysCmd_T_Cor_CO"]=false
													end end},
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
Core[Name[1].."Reg_DataCtrl1"][2]=(tonumber(string.sub(second,1,1))<<4)+(tonumber(string.sub(second,2,2)))
Core[Name[1].."Reg_DataCtrl1"][1]=(8<<4)+0

		Core[Name[2].."Reg_Time_Set_UP"]=true
		os.sleep(0.1)
Core[Name[1].."Reg_NetCtrl1"]=(0x691F<<16)+(0x2C92) --ПРИСВОИТЬ инициализированные регистры														
		Core[Name[1].."Reg_NetCtrl1_UP"]=true

													 os.sleep(2)
													 Core[Name[1].."Reg_NetCtrl1"]=0
													 Core[Name[2].."Reg_Time_Set_AV"]=false
													end end},
["Cmd_Rd_Set_CO"]= {["Comment"]="Чтение уставок и конфигурации от оператора",["eval"]= 
		function(Name) 
			if Core[Name[2].."Cmd_Rd_Set_CO"]==true then
													 Core[Name[1].."Reg_Cmd_WinWrRd_DP"]=(0xC714<<16)+(0x9DDD) --ПРИСВОИТЬ инициализированные регистры														
													 os.sleep(1)
													 Core[Name[1].."Cmd_Rd_Set_CO_UP"]=true
													 Core[Name[1].."Reg_Cmd_WinWrRd_DP"]=0
													 Core[Name[2].."Cmd_Rd_Set_CO"]=false

													end end}, 

["Cmd_Wr_Set_CO"]= {["Comment"]="Запись уставок и конфигурации от оператора",["eval"]= 
		function(Name) 
			if Core[Name[2].."Cmd_Wr_Set_CO"]==true then
														Core[Name[1].."Cmd_Wr_Set_CO_UP"]=true
														os.sleep(0.5)
														Core[Name[1].."Reg_Cmd_WinWrRd_DP"]=(0x7E62<<16)+(0x2256) --ПРИСВОИТЬ инициализированные регистры																											 													 	
														os.sleep(0.5)
														Core[Name[1].."Reg_Cmd_WinWrRd_DP"]=0
													 	Core[Name[2].."Cmd_Wr_Set_CO"]=false

			end 
		end}, 		
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


