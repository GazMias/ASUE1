
--Объявление структуры, в которой левая часть до знака = это массив сигналов с SEPAM а правая часть - это массив переменных, передаваемых в SCADA систему
local objects = {
	["RAW_SEPAM_SHTN_"]="S_ZRU_P11_SHTN_"
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

--Сигналы и переменные
local signals = {
	-- Объявление переменных в виде структуры где левая часть до знака = это Suffix, правая часть это Descriptor. Descriptor в свою очередь представляет собой структуру
	-- в которой первый элемент это комментарий Comment, второй элемент это функция eval. В функциях происходит преобразование значений сигналов из регистров SEPAM, и присваивание этих
	-- преобразованных значений переменным, передаваемым в SCADA систему

	-- Дискретные сигналы и переменные
    ["3088_0_DP"]= {["Comment"]="Логический вход I101 ",["eval"]= function(Name) Core[Name[2].."3088_0_DP"]=Core[Name[1].."3088_0_DP"] end},
    ["3088_3_DP"]= {["Comment"]="Логический вход I104 ",["eval"]= function(Name) Core[Name[2].."3088_3_DP"]=Core[Name[1].."3088_3_DP"] end},
    ["3088_4_DP"]= {["Comment"]="Логический вход I105 ",["eval"]= function(Name) Core[Name[2].."3088_4_DP"]=Core[Name[1].."3088_4_DP"] end},
    ["3088_5_DP"]= {["Comment"]="Логический вход I106 ",["eval"]= function(Name) Core[Name[2].."3088_5_DP"]=Core[Name[1].."3088_5_DP"] end},
    ["3088_6_DP"]= {["Comment"]="Логический вход I107 ",["eval"]= function(Name) Core[Name[2].."3088_6_DP"]=Core[Name[1].."3088_6_DP"] end},
    ["3088_7_DP"]= {["Comment"]="Логический вход I108 ",["eval"]= function(Name) Core[Name[2].."3088_7_DP"]=Core[Name[1].."3088_7_DP"] end},
    ["3088_8_DP"]= {["Comment"]="Логический вход I109 ",["eval"]= function(Name) Core[Name[2].."3088_8_DP"]=Core[Name[1].."3088_8_DP"] end},
    ["3088_9_DP"]= {["Comment"]="Логический вход I110 ",["eval"]= function(Name) Core[Name[2].."3088_9_DP"]=Core[Name[1].."3088_9_DP"] end},
    ["3088_10_DP"]= {["Comment"]="Логический вход I111 ",["eval"]= function(Name) Core[Name[2].."3088_10_DP"]=Core[Name[1].."3088_10_DP"] end},
    ["3088_11_DP"]= {["Comment"]="Логический вход I112 ",["eval"]= function(Name) Core[Name[2].."3088_11_DP"]=Core[Name[1].."3088_11_DP"] end},
    ["3088_12_DP"]= {["Comment"]="Логический вход I113 ",["eval"]= function(Name) Core[Name[2].."3088_12_DP"]=Core[Name[1].."3088_12_DP"] end},
    ["3088_13_DP"]= {["Comment"]="Логический вход I114 ",["eval"]= function(Name) Core[Name[2].."3088_13_DP"]=Core[Name[1].."3088_13_DP"] end},

	["3216_4_DP"]= {["Comment"]="",["eval"]= function(Name) Core[Name[2].."3216_4_DP"]=Core[Name[1].."3216_4_DP"] end},
    
    ["3219_1_DP"]= {["Comment"]="Блокировка записи осцилограмм ",["eval"]= function(Name) Core[Name[2].."3219_1_DP"]=Core[Name[1].."3219_1_DP"] end},
	["3219_2_DP"]= {["Comment"]="Запрет телерегулировки ",["eval"]= function(Name) Core[Name[2].."3219_2_DP"]=Core[Name[1].."3219_2_DP"] end},
	["3219_3_DP"]= {["Comment"]="Обобщенный сигнал неисправности ",["eval"]= function(Name) Core[Name[2].."3219_3_DP"]=Core[Name[1].."3219_3_DP"] end},
	["3219_15_DP"]= {["Comment"]="Срабатывание клапанов дуговой защиты ",["eval"]= function(Name) Core[Name[2].."3219_15_DP"]=Core[Name[1].."3219_15_DP"] end},

    ["3221_12_DP"]= {["Comment"]="Земля в сети 10 кВ",["eval"]= function(Name) Core[Name[2].."3221_12_DP"]=Core[Name[1].."3221_12_DP"] end},

    ["3224_2_DP"]= {["Comment"]="Срабатывание АЧР 1 очередь",["eval"]= function(Name) Core[Name[2].."3224_2_DP"]=Core[Name[1].."3224_2_DP"] end},
    ["3224_3_DP"]= {["Comment"]="Срабатывание АЧР 2 очередь",["eval"]= function(Name) Core[Name[2].."3224_3_DP"]=Core[Name[1].."3224_3_DP"] end},

    ["3227_0_DP"]= {["Comment"]="Отключение от ДГЗ, УРОВ  ",["eval"]= function(Name) Core[Name[2].."3227_0_DP"]=Core[Name[1].."3227_0_DP"] end},
    ["3227_1_DP"]= {["Comment"]="Отключение от защит трансформатора ",["eval"]= function(Name) Core[Name[2].."3227_1_DP"]=Core[Name[1].."3227_1_DP"] end},
    ["3227_2_DP"]= {["Comment"]="Аварийное отключение ",["eval"]= function(Name) Core[Name[2].."3227_2_DP"]=Core[Name[1].."3227_2_DP"] end},
    ["3227_3_DP"]= {["Comment"]="Выключатель эл. мотора завода пружины привода отключен ",["eval"]= function(Name) Core[Name[2].."3227_3_DP"]=Core[Name[1].."3227_3_DP"] end},
 	["3227_4_DP"]= {["Comment"]="Внешнее отключение с запретом АВР ",["eval"]= function(Name) Core[Name[2].."3227_4_DP"]=Core[Name[1].."3227_4_DP"] end},
    ["3227_5_DP"]= {["Comment"]="Внешнее отключение без запрета АВР  ",["eval"]= function(Name) Core[Name[2].."3227_5_DP"]=Core[Name[1].."3227_5_DP"] end},
    ["3227_6_DP"]= {["Comment"]="Отключение от АВР  ",["eval"]= function(Name) Core[Name[2].."3227_6_DP"]=Core[Name[1].."3227_6_DP"] end},

    ["3228_15_DP"]= {["Comment"]="Неисправность цепи включения ",["eval"]= function(Name) Core[Name[2].."3228_15_DP"]=Core[Name[1].."3228_15_DP"] end},

    ["3229_1_DP"]= {["Comment"]="Неисправность трансформатора напряжения ",["eval"]= function(Name) Core[Name[2].."3229_1_DP"]=Core[Name[1].."3229_1_DP"] end},
	["3229_2_DP"]= {["Comment"]="Неисправность цепей напряжения нулевой последовательности",["eval"]= function(Name) Core[Name[2].."3229_2_DP"]=Core[Name[1].."3229_2_DP"] end},
    ["3229_5_DP"]= {["Comment"]="Срабатывание пускового органа АВР при обрыве фаз",["eval"]= function(Name) Core[Name[2].."3229_5_DP"]=Core[Name[1].."3229_5_DP"] end},
    ["3229_8_DP"]= {["Comment"]="Снижение напряжения питания Sepam",["eval"]= function(Name) Core[Name[2].."3229_8_DP"]=Core[Name[1].."3229_8_DP"] end},
    ["3229_9_DP"]= {["Comment"]="Повышение напряжения питания Sepam",["eval"]= function(Name) Core[Name[2].."3229_9_DP"]=Core[Name[1].."3229_9_DP"] end},
	["3229_10_DP"]= {["Comment"]="Батарея Sepam разряжена",["eval"]= function(Name) Core[Name[2].."3229_10_DP"]=Core[Name[1].."3229_10_DP"] end},
    ["3229_11_DP"]= {["Comment"]="Автоматический выключатель ТН отключен",["eval"]= function(Name) Core[Name[2].."3229_11_DP"]=Core[Name[1].."3229_11_DP"] end},
    ["3229_12_DP"]= {["Comment"]="Переключатель АЧР включен",["eval"]= function(Name) Core[Name[2].."3229_12_DP"]=Core[Name[1].."3229_12_DP"] end},

	--Аналоговые сигналы и переменные
    ["64006_AP"]= {["Comment"]="Линейное напряжение U21 ",["eval"]= function(Name) Core[Name[2].."64006_AP"]=Core[Name[1].."64006_AP"]*0.001 end},
    ["64007_AP"]= {["Comment"]="Линейное напряжение U32 ",["eval"]= function(Name) Core[Name[2].."64007_AP"]=Core[Name[1].."64007_AP"]*0.001 end},
    ["64008_AP"]= {["Comment"]="Линейное напряжение U13 ",["eval"]= function(Name) Core[Name[2].."64008_AP"]=Core[Name[1].."64008_AP"]*0.001 end},
	["64009_AP"]= {["Comment"]="Частота ",["eval"]= function(Name) Core[Name[2].."64009_AP"]=Core[Name[1].."64009_AP"]*0.01 end},

	--Дата и время в нужном формате дд.мм.гг чч:мм:сс
	--["Reg_Time_MS"] = {["Comment"]="Астрономическое время", ["eval"]=	function(Name) Core[Name[2].."Reg_Time"]=	tostring(Core[Name[1].."Reg_Time"][2]).."."..		--День
																												--tostring(Core[Name[1].."Reg_Time"][1]).."."..		--Месяц
																												--tostring(Core[Name[1].."Reg_Time"][0]).." "..		--Год
																												--tostring(Core[Name[1].."Reg_Time"][3])..":"..		--Час
																												--tostring(Core[Name[1].."Reg_Time"][4])..":"..		--Минута
																												--tostring(Core[Name[1].."Reg_Time_MS"]/1000)			--Секунда
																		--end},	
}

-- Инициализация сигналов в момент запуска
for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_SEPAM и S_ZRU_P11_VV1_
	for _, signals_Descriptor in pairs(signals) do	--Цикл по всем элементов в каждом из 2 массивов: RAW_SEPAM и S_ZRU_P11_VV1_
		signals_Descriptor.eval({raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals
	end
end

-- Отслеживание изменений значений в сигналах
for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_SEPAM и S_ZRU_P11_VV1_
	for signals_Suffix, signals_Descriptor in pairs(signals) do	--Цикл по всем переменным в каждом из 2 массивов: RAW_SEPAM и S_ZRU_P11_VV1_
		Core.onExtChange({raw_objectName..signals_Suffix},signals_Descriptor.eval,{raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals при изменении любой из переменных
	end
end

--Команды
local commands_operator = {
  --["Reg_Time_CO"] = {["comment"]="Установка текущего астрономического времени от оператора",["eval"]= 		function(Name)	SyncTime(Name,"Reg_Time_CO")end},
  --["Reg_Time_Set_AV"] = {["comment"]="Установка текущего астрономического времени автоматически",["eval"]=		function(Name)	SyncTime(Name,"Reg_Time_Set_AV")end},
	["3208_2_CO"] = {["comment"]="Квитирование аварийной и предупредительной сигнализации",["eval"]=	function(Name)	Command(Name,"3208_2_CO")end},
	["3209_1_CO"] = {["comment"]="Блокировка запуска осциллограмм аварийных режимов ",["eval"]=		function(Name)	Command(Name,"3209_1_CO")end},
	["3209_2_CO"] = {["comment"]="Разрешение запуска осциллограмм аварийных режимов ",["eval"]=		function(Name)	Command(Name,"3209_2_CO")end},
	["3209_3_CO"] = {["comment"]="Ручной запуск осциллограмм аварийных режимов ",["eval"]=		function(Name)	Command(Name,"3209_3_CO")end},
}

-- Инициализация команд сигналов в момент запуска
for _, objectName in  pairs(objects) do								--Цикл по 2ум массивам: RAW_SEPAM и S_ZRU_P11_VV1_
    for commands_operator_Suffix, _ in pairs(commands_operator) do	--Цикл по всем элементов в каждом из 2 массивов: RAW_SEPAM и S_ZRU_P11_VV1_
		Core[objectName..commands_operator_Suffix]=false			--Вызов функций у каждой из переменных, описанных в commands_operator
	end
end

-- Отслеживание изменений значений в командах
for raw_objectName, objectName in  pairs(objects) do																				--Цикл по 2ум массивам: RAW_SEPAM и S_ZRU_P11_VV1_
	for commands_operator_Suffix, commands_operator_Descriptor in pairs(commands_operator) do										--Цикл по всем переменным в каждом из 2 массивов: RAW_SEPAM и S_ZRU_P11_VV1_
		Core.onExtChange({objectName..commands_operator_Suffix},commands_operator_Descriptor["eval"],{raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals при изменении любой из переменных
	end
end

Core.waitEvents( )