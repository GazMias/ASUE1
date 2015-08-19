--Объявление структуры, в которой левая часть до знака = это массив сигналов с SEPAM а правая часть - это массив переменных, передаваемых в SCADA систему
local objects = {
	["RAW_SEPAM_VV1_"]="S_ZRU_P11_VV1_"
}

--Функция синхронизации времени
function SyncTime(Name,Suff_Name)
	if Core[Name[2]..Suff_Name]==true then										--Проверка на то, послали ли команду
		Core[Name[1].."Reg_Time_Write"][0]=os.date("%y")						-- Записываем год
		Core[Name[1].."Reg_Time_Write"][1]=os.date("%m")						-- Записываем месяц
		Core[Name[1].."Reg_Time_Write"][2]=os.date("%d")						-- Записываем день
		Core[Name[1].."Reg_Time_Write"][3]=os.date("%H")						-- Записываем часы
		Core[Name[1].."Reg_Time_Write"][4]=os.date("%M")						-- Записываем минуты
		Core[Name[1].."Reg_Time_MS_Write"]=(os.date("%S"))*1000+os.date("%3N")	-- Записываем секунды + милисекунды
		Core[Name[2]..Suff_Name]=false											--Сбрасываем переменную-флаг о посылке команды
	end
end

--Функция для выполнения команды
function Command(Name,Suff_Name)	
	if Core[Name[2]..Suff_Name]==true then	--Проверка на то, послали ли команду
		Core[Name[1]..Suff_Name]=true 		-- Посылаем команду
		os.sleep(2)							--Делаем паузу, чтобы команда точно дошла
		Core[Name[2]..Suff_Name]=false		--Сбрасываем переменную-флаг о посылке команды, если необходимо
		Core[Name[1]..Suff_Name]=false		--Сбрасываем переменную-флаг о посылке команды, если необходимо
	end
end

--Команды
local commands_operator = {
	--["Reg_Time_CO"] = {["comment"]="Установка текущего астрономического времени от оператора",["eval"]= 
	--	function(Name)
	--		SyncTime(Name,"Reg_Time_CO")	-- Вызов функции синхронизации времени с нужным параметром (команда от оператора)
	--	end},
	--["Reg_Time_Set_AV"] = {["comment"]="Установка текущего астрономического времени автоматически",["eval"]=
	--	function(Name)
	--		SyncTime(Name,"Reg_Time_Set_AV")	-- Вызов функции синхронизации времени с нужным параметром (автоматическая синхронизация)
	--	end},
	["3208_0_CO"] = {["comment"]="Команда Отключить",["eval"]=
		function(Name)
			Command(Name,"3208_0_CO")
		end},
	["3208_1_CO"] = {["comment"]="Команда Включить",["eval"]=
		function(Name)
			Command(Name,"3208_1_CO")
		end},
	["3208_2_CO"] = {["comment"]="Квитирование аварийной и предупредительной сигнализации",["eval"]=
		function(Name)
			Command(Name,"3208_2_CO")
		end},
	["3208_3_CO"] = {["comment"]="Сброс максиметров фазного тока",["eval"]=
		function(Name)
			Command(Name,"3208_3_CO")
		end},
	["3208_4_CO"] = {["comment"]="Сброс максиметров мощности",["eval"]=
		function(Name)
			Command(Name,"3208_4_CO")
		end},
	["3209_1_CO"] = {["comment"]="Сброс максиметров мощности",["eval"]=
		function(Name)
			Command(Name,"3209_1_CO")
		end},
	["3209_2_CO"] = {["comment"]="Сброс максиметров мощности",["eval"]=
		function(Name)
			Command(Name,"3209_2_CO")
		end},
	["3209_3_CO"] = {["comment"]="Сброс максиметров мощности",["eval"]=
		function(Name)
			Command(Name,"3209_3_CO")
		end},
}
-- Инициализация сигналов в момент запуска
for _, objectName in  pairs(objects) do								--Цикл по 2ум массивам: RAW_SEPAM и S_ZRU_P11_VV1_
    for commands_operator_Suffix, _ in pairs(commands_operator) do	--Цикл по всем элементов в каждом из 2 массивов: RAW_SEPAM и S_ZRU_P11_VV1_
		Core[objectName..commands_operator_Suffix]=false			--Вызов функций у каждой из переменных, описанных в signals
	end
end

-- Отслеживание изменений значений в сигналах
for raw_objectName, objectName in  pairs(objects) do																				--Цикл по 2ум массивам: RAW_SEPAM и S_ZRU_P11_VV1_
	for commands_operator_Suffix, commands_operator_Descriptor in pairs(commands_operator) do										--Цикл по всем переменным в каждом из 2 массивов: RAW_SEPAM и S_ZRU_P11_VV1_
		Core.onExtChange({objectName..commands_operator_Suffix},commands_operator_Descriptor["eval"],{raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals при изменении любой из переменных
	end
end

Core.waitEvents( )