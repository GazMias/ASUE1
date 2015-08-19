--Объявление структуры, в	 которой левая часть до знака = это массив сигналов из ПЛК M340 а правая часть - это массив переменных, передаваемых в SCADA систему
local objects = {
	["RAW_TVS_"]="S_TVS_"
	
}
local commands_operator = 
{
-- Управление шибером котла-утилизатора
	["KU_OTKRSHIB_CO"] = 
					   {["comment"]="Открыть шибер котла-утилизатора",["eval"]=
		function(Name)
		  if Core[Name[2].."KU_SHIBOTKR_DP"]==false then            -- отправка команды на открытие шибера произойдет только если он закрыт
				 Core[Name[1].."KU_OTKRSHIB_CO"]=false				-- обнуляем предыдущие команды, на всякий случай
				 Core[Name[1].."KU_ZAKRSHIB_CO"]=false
				if  Core[Name[2].."KU_OTKRSHIB_CO"]==true then		-- Проверка на то, послали ли команду
				 Core[Name[1].."KU_OTKRSHIB_CO"]=true					-- Записываем бит управления 
			 	 os.sleep(5) 									-- Таймаут после посылки команды 5 секунд (согласно алгоритма ПЛК)
			 	 Core[Name[1].."KU_OTKRSHIB_CO"]=false					-- Обнуляем бит управления во избежание ложных срабатываний
				-- os.sleep(4)
				 Core[Name[2].."KU_OTKRSHIB_CO"]=false			-- Сбрасываем переменную-флаг о посылке команды, если необходимо
			 	end
		  else 	 Core[Name[2].."KU_OTKRSHIB_CO"]=false	        -- если шибер уже был открыт сразу обнуляем управляющий бит
		  end	
		end

		   },
	["KU_ZAKRSHIB_CO"] = 
					   {["comment"]="Закрыть шибер котла-утилизатора",["eval"]=
		function(Name)
		  if Core[Name[2].."KU_SHIBOTKR_DP"]==true  then            -- отправка команды на закрытие шибера произойдет только если он открыт
				 Core[Name[1].."KU_OTKRSHIB_CO"]=false
				 Core[Name[1].."KU_ZAKRSHIB_CO"]=false
			 if  Core[Name[2].."KU_ZAKRSHIB_CO"]==true then
				 Core[Name[1].."KU_ZAKRSHIB_CO"]=true
			 	 os.sleep(5)
			 	 Core[Name[1].."KU_ZAKRSHIB_CO"]=false
			--	 os.sleep(4)
				 Core[Name[2].."KU_ZAKRSHIB_CO"]=false
			 end
		  else 	 Core[Name[2].."KU_ZAKRSHIB_CO"]=false	
		  end	
		end
					   }
	
}

-- Инициализация сигналов в момент запуска
	for _, objectName in  pairs(objects) do								--Цикл по 2ум массивам: RAW_TVS и S_TVS_
    	for commands_operator_Suffix, _ in pairs(commands_operator) do	--Цикл по всем элементов в каждом из 2 массивов: RAW_TVS и S_TVS
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