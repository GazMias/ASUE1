delay_time=0.5
--Объявление структуры, в	 которой левая часть до знака = это массив сигналов из ПЛК М340 а правая часть - это массив переменных, передаваемых в SCADA систему
local objects = {
	["RAW_M340_P06_"]="S_KTP_P06_"
	
}
local commands_operator = 
{
-- Управление выключателем ввода №1
	["VV1_OTKVV_CO"] = 
					   {["comment"]="Отключить ввод №1",["eval"]=
		function(Name)
		  	 if  Core[Name[2].."VV1_OTKVV_CO"]==true then		-- Проверка на то, послали ли команду
			     Core[Name[1].."40088_CO"]=1					-- Записываем слово управления (значение слова=2 в степени N, где N -номер бита команды в слове)
			 	 os.sleep(0.5) 									-- Таймаут после посылки команды 0.5 секунды
			 	 Core[Name[1].."40088_CO"]=0					-- Обнуляем слово управления во избежание ложных срабатываний
				 Core[Name[2].."VV1_OTKVV_CO"]=false			-- Сбрасываем переменную-флаг о посылке команды, если необходимо

			 end
		end
					   },
	["VV1_VKLVV_CO"] = 
					   {["comment"]="Включить ввод №1",["eval"]=
		function(Name)
			 if  Core[Name[2].."VV1_VKLVV_CO"]==true then
			     Core[Name[1].."40088_CO"]=2
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40088_CO"]=0
				 Core[Name[2].."VV1_VKLVV_CO"]=false
			 end
		end
					   },
-- Управление выключателем ввода №2
	["VV2_OTKVV_CO"] = 
					   {["comment"]="Отключить ввод №2",["eval"]=
		function(Name)
			 if  Core[Name[2].."VV2_OTKVV_CO"]==true then
			     Core[Name[1].."40088_CO"]=4
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40088_CO"]=0
				 Core[Name[2].."VV2_OTKVV_CO"]=false
			 end
		end
					   },
	["VV2_VKLVV_CO"] = 
					   {["comment"]="Включить ввод №2",["eval"]=
		function(Name)
			 if  Core[Name[2].."VV2_VKLVV_CO"]==true then
			     Core[Name[1].."40088_CO"]=8
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40088_CO"]=0
				 Core[Name[2].."VV2_VKLVV_CO"]=false
			 end
		end
					   },
-- Управление секционным выключателем
	["SV_OTKSV_CO"] = 
					   {["comment"]="Отключить секционный выключатель",["eval"]=
		function(Name)
			 if  Core[Name[2].."SV_OTKSV_CO"]==true then
			     Core[Name[1].."40088_CO"]=16
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40088_CO"]=0
				 Core[Name[2].."SV_OTKSV_CO"]=false
			 end
		end
					   },
	["SV_VKLSV_CO"] = 
					   {["comment"]="Включить секционный выключатель",["eval"]=
		function(Name)
			 if  Core[Name[2].."SV_VKLSV_CO"]==true then
			     Core[Name[1].."40088_CO"]=32
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40088_CO"]=0
				 Core[Name[2].."SV_VKLSV_CO"]=false
			 end
		end
					   },
-- Управление АВР СВ
	["SV_OTKAVRSV_CO"] = 
					   {["comment"]="Отключить АВР СВ",["eval"]=
		function(Name)
			 if  Core[Name[2].."SV_OTKAVRSV_CO"]==true then
			     Core[Name[1].."40088_CO"]=128
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40088_CO"]=0
				 Core[Name[2].."SV_OTKAVRSV_CO"]=false
			 end
		end
					   },
	["SV_VKLAVRSV_CO"] = 
					   {["comment"]="Включить АВР СВ",["eval"]=
		function(Name)
			 if  Core[Name[2].."SV_VKLAVRSV_CO"]==true then
			     Core[Name[1].."40088_CO"]=64
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40088_CO"]=0
				 Core[Name[2].."SV_VKLAVRSV_CO"]=false
			 end
		end
					   },
-- Управление выключателем аварийного ввода №1
	["AV1_OTKVAV_CO"] = 
					   {["comment"]="Отключить выключатель аварийного ввода №1",["eval"]=
		function(Name)
			 if  Core[Name[2].."AV1_OTKVAV_CO"]==true then
			     Core[Name[1].."40089_CO"]=1
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."AV1_OTKVAV_CO"]=false
			 end
		end
					   },
	["AV1_VKLVAV_CO"] = 
					   {["comment"]="Включить выключатель аварийного ввода №1",["eval"]=
		function(Name)
			 if  Core[Name[2].."AV1_VKLVAV_CO"]==true then
			     Core[Name[1].."40089_CO"]=2
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."AV1_VKLVAV_CO"]=false
			 end
		end
					   },
-- Управление АВР АВ1
	["AV1_OTKAVRAV_CO"] = 
					   {["comment"]="Отключить АВР АВ №1",["eval"]=
		function(Name)
			 if  Core[Name[2].."AV1_OTKAVRAV_CO"]==true then
			     Core[Name[1].."40089_CO"]=8
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."AV1_OTKAVRAV_CO"]=false
			 end
		end
					   },
	["AV1_VKLAVRAV_CO"] = 
					   {["comment"]="Включить АВР АВ №1",["eval"]=
		function(Name)
			 if  Core[Name[2].."AV1_VKLAVRAV_CO"]==true then
			     Core[Name[1].."40089_CO"]=4
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."AV1_VKLAVRAV_CO"]=false
			 end
		end
					   },
-- Управление АДЭС №1
	["AV1_OSTADS_CO"] = 
					   {["comment"]="Останов АДЭС №1",["eval"]=
		function(Name)
			 if  Core[Name[2].."AV1_OSTADS_CO"]==true then
			     Core[Name[1].."40089_CO"]=32
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."AV1_OSTADS_CO"]=false
			 end
		end
					   },
	["AV1_PADS_CO"] = 
					   {["comment"]="Пуск АДЭС №1",["eval"]=
		function(Name)
			 if  Core[Name[2].."AV1_PADS_CO"]==true then
			     Core[Name[1].."40089_CO"]=16
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."AV1_PADS_CO"]=false
			 end
		end
					   },
-- Управление выключателем аварийного ввода №2
	["AV2_OTKVAV_CO"] = 
					   {["comment"]="Отключить выключатель аварийного ввода №2",["eval"]=
		function(Name)
			 if  Core[Name[2].."AV2_OTKVAV_CO"]==true then
			     Core[Name[1].."40089_CO"]=64
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."AV2_OTKVAV_CO"]=false
			 end
		end
					   },
	["AV2_VKLVAV_CO"] = 
					   {["comment"]="Включить выключатель аварийного ввода №2",["eval"]=
		function(Name)
			 if  Core[Name[2].."AV2_VKLVAV_CO"]==true then
			     Core[Name[1].."40089_CO"]=128
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."AV2_VKLVAV_CO"]=false
			 end
		end
					   },
-- Управление АВР АВ2
	["AV2_OTKAVRAV_CO"] = 
					   {["comment"]="Отключить АВР АВ 21",["eval"]=
		function(Name)
			 if  Core[Name[2].."AV2_OTKAVRAV_CO"]==true then
			     Core[Name[1].."40089_CO"]=512
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."AV2_OTKAVRAV_CO"]=false
			 end
		end
					   },
	["AV2_VKLAVRAV_CO"] = 
					   {["comment"]="Включить АВР АВ №2",["eval"]=
		function(Name)
			 if  Core[Name[2].."AV2_VKLAVRAV_CO"]==true then
			     Core[Name[1].."40089_CO"]=256
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."AV2_VKLAVRAV_CO"]=false
			 end
		end
					   },
-- Управление АДЭС №2
	["AV2_OSTADS_CO"] = 
					   {["comment"]="Останов АДЭС №2",["eval"]=
		function(Name)
			 if  Core[Name[2].."AV2_OSTADS_CO"]==true then
			     Core[Name[1].."40089_CO"]=2048
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."AV2_OSTADS_CO"]=false
			 end
		end
					   },
	["AV2_PADS_CO"] = 
					   {["comment"]="Пуск АДЭС №2",["eval"]=
		function(Name)
			 if  Core[Name[2].."AV2_PADS_CO"]==true then
			     Core[Name[1].."40089_CO"]=1024
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."AV2_PADS_CO"]=false
			 end
		end
					   },
-- Управление ПУ КТП
	["PU_RESET_CO"] = 
					   {["comment"]="Квитировать",["eval"]=
		function(Name)
			 if  Core[Name[2].."PU_RESET_CO"]==true then
			     Core[Name[1].."40089_CO"]=4096
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."PU_RESET_CO"]=false
			 end
		end
					   },
	["PU_CLOCKSET_CO"] = 
					   {["comment"]="Установка часов",["eval"]=
		function(Name)
			 if  Core[Name[2].."PU_CLOCKSET_CO"]==true then
			     Core[Name[1].."40089_CO"]=8192
			 	 os.sleep(0.5)
			 	 Core[Name[1].."40089_CO"]=0
				 Core[Name[2].."PU_CLOCKSET_CO"]=false
			 end
		end
					   }
}

-- Инициализация сигналов в момент запуска
	for _, objectName in  pairs(objects) do								--Цикл по 2ум массивам: RAW_ и S_KTP_P06_VV1_
    	for commands_operator_Suffix, _ in pairs(commands_operator) do	--Цикл по всем элементов в каждом из 2 массивов: RAW_ и S_
			Core[objectName..commands_operator_Suffix]=false			--Вызов функций у каждой из переменных, описанных в signals
		end
	end

-- Отслеживание изменений значений в сигналах
	for raw_objectName, objectName in  pairs(objects) do																				--Цикл по 2ум массивам: RAW_ и S_
		for commands_operator_Suffix, commands_operator_Descriptor in pairs(commands_operator) do										--Цикл по всем переменным в каждом из 2 массивов: RAW_ и S_
			Core.onExtChange({objectName..commands_operator_Suffix},commands_operator_Descriptor["eval"],{raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals при изменении любой из переменных
		end
	end

Core.waitEvents( )