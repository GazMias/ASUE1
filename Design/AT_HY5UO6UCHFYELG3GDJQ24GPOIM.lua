dofile("AT_BIP3WUMWFPGETLORIK7DY4CCVY.lua") 

--Объявление структуры, в которой левая часть до знака = это массив сигналов а правая часть - это массив переменных, передаваемых в SCADA систему

local objects = {
	["RAW_BMPA_"]="S_KTP_P07_BMPA_"
}

local signals = {
	-- Объявление переменных в виде структуры где левая часть до знака = это Suffix, правая часть это Descriptor. Descriptor в свою очередь представляет собой структуру
	-- в которой первый элемент это комментарий Comment, второй элемент это функция eval. В функциях происходит преобразование значений сигналов из регистров, и присваивание этих
	-- преобразованных значений переменным, передаваемым в SCADA систему

	-- Дискретные сигналы и переменные
        ["M33C01_DI"]= {["Comment"]="Тележка СВ выкачена ",["eval"]= function(Name) Core[Name[2].."M33C01_DI"]=Core[Name[1].."M33C01_DI"] end},
        ["M34C09_DO"]= {["Comment"]="Отказ БМПА 1 ",["eval"]= function(Name) Core[Name[2].."M34C09_DO"]=Core[Name[1].."M34C09_DO"] end},
        ["M41C01_DI"]= {["Comment"]="СВ отключен ",["eval"]= function(Name) Core[Name[2].."M41C01_DI"]=Core[Name[1].."M41C01_DI"] end},
        ["M41C03_DI"]= {["Comment"]="СВ включен ",["eval"]= function(Name) Core[Name[2].."M41C03_DI"]=Core[Name[1].."M41C03_DI"] end},
        ["M41C05_DI"]= {["Comment"]="РПВ ",["eval"]= function(Name) Core[Name[2].."M41C05_DI"]=Core[Name[1].."M41C05_DI"] end},
        ["M41C07_DI"]= {["Comment"]="Вкл. СВ от АВР СВ ",["eval"]= function(Name) Core[Name[2].."M41C07_DI"]=Core[Name[1].."M41C07_DI"] end},
        ["M41C09_DI"]= {["Comment"]="Откл. По ВНР после АВР СВ ",["eval"]= function(Name) Core[Name[2].."M41C09_DI"]=Core[Name[1].."M41C09_DI"] end},
        ["M41C11_DI"]= {["Comment"]="Вкл. СВ от АВР АВ ",["eval"]= function(Name) Core[Name[2].."M41C11_DI"]=Core[Name[1].."M41C11_DI"] end},
        ["M41C13_DI"]= {["Comment"]="Откл. От защ. ВВ ",["eval"]= function(Name) Core[Name[2].."M41C13_DI"]=Core[Name[1].."M41C13_DI"] end},
        ["M41C15_DI"]= {["Comment"]="Откл. От защ. АВ ",["eval"]= function(Name) Core[Name[2].."M41C15_DI"]=Core[Name[1].."M41C15_DI"] end},
        ["M42C01_DI"]= {["Comment"]="Отключить СВ вых ",["eval"]= function(Name) Core[Name[2].."M42C01_DI"]=Core[Name[1].."M42C01_DI"] end},
        ["M42C03_DI"]= {["Comment"]="Включить СВ вых ",["eval"]= function(Name) Core[Name[2].."M42C03_DI"]=Core[Name[1].."M42C03_DI"] end},
        ["M42C05_DO"]= {["Comment"]="АВР СВ включен 1 ",["eval"]= function(Name) Core[Name[2].."M42C05_DO"]=Core[Name[1].."M42C05_DO"] end},
        ["M42C07_DO"]= {["Comment"]="АВР СВ включен 2 ",["eval"]= function(Name) Core[Name[2].."M42C07_DO"]=Core[Name[1].."M42C07_DO"] end},
        ["M42C09_DO"]= {["Comment"]="РПВ 1 ",["eval"]= function(Name) Core[Name[2].."M42C09_DO"]=Core[Name[1].."M42C09_DO"] end},
        ["M42C11_DO"]= {["Comment"]="РПО 1 ",["eval"]= function(Name) Core[Name[2].."M42C11_DO"]=Core[Name[1].."M42C11_DO"] end},
        ["M42C13_DO"]= {["Comment"]="РПО 2 ",["eval"]= function(Name) Core[Name[2].."M42C13_DO"]=Core[Name[1].."M42C13_DO"] end},
        ["M42C15_DO"]= {["Comment"]="РПВ 2 ",["eval"]= function(Name) Core[Name[2].."M42C15_DO"]=Core[Name[1].."M42C15_DO"] end},
        ["M43C01_DI"]= {["Comment"]="ДУ ",["eval"]= function(Name) Core[Name[2].."M43C01_DI"]=Core[Name[1].."M43C01_DI"] end},
        ["M43C03_DI"]= {["Comment"]="АВР СВ включить ",["eval"]= function(Name) Core[Name[2].."M43C03_DI"]=Core[Name[1].."M43C03_DI"] end},
        ["M43C05_DI"]= {["Comment"]="АВР СВ отключить ",["eval"]= function(Name) Core[Name[2].."M43C05_DI"]=Core[Name[1].."M43C05_DI"] end},
        ["M43C07_DI"]= {["Comment"]="Откл. СВ от АВР АВ ",["eval"]= function(Name) Core[Name[2].."M43C07_DI"]=Core[Name[1].."M43C07_DI"] end},
        ["M43C09_DI"]= {["Comment"]="Отключить СВ ",["eval"]= function(Name) Core[Name[2].."M43C09_DI"]=Core[Name[1].."M43C09_DI"] end},
        ["M43C11_DI"]= {["Comment"]="Включить СВ ",["eval"]= function(Name) Core[Name[2].."M43C11_DI"]=Core[Name[1].."M43C11_DI"] end},
        ["M43C13_DI"]= {["Comment"]="Квитирование ",["eval"]= function(Name) Core[Name[2].."M43C13_DI"]=Core[Name[1].."M43C13_DI"] end},
        ["M43C15_DI"]= {["Comment"]="СЕВ ",["eval"]= function(Name) Core[Name[2].."M43C15_DI"]=Core[Name[1].."M43C15_DI"] end},
        ["M44C01_DO"]= {["Comment"]="Неиспр. БМПА ",["eval"]= function(Name) Core[Name[2].."M44C01_DO"]=Core[Name[1].."M44C01_DO"] end},
        ["M44C03_DO"]= {["Comment"]="Авар. Откл. ",["eval"]= function(Name) Core[Name[2].."M44C03_DO"]=Core[Name[1].."M44C03_DO"] end},
        ["M44C05_DO"]= {["Comment"]="АВР СВ включен ",["eval"]= function(Name) Core[Name[2].."M44C05_DO"]=Core[Name[1].."M44C05_DO"] end},
        ["M44C07_DO"]= {["Comment"]="АВР СВ отключен ",["eval"]= function(Name) Core[Name[2].."M44C07_DO"]=Core[Name[1].."M44C07_DO"] end},
        ["M44C09_DO"]= {["Comment"]="Неисправность ЦУ ",["eval"]= function(Name) Core[Name[2].."M44C09_DO"]=Core[Name[1].."M44C09_DO"] end},
        ["M44C11_DO"]= {["Comment"]="Отказ БМПА 2 ",["eval"]= function(Name) Core[Name[2].."M44C11_DO"]=Core[Name[1].."M44C11_DO"] end},
        ["M44C13_DO"]= {["Comment"]="РФК ",["eval"]= function(Name) Core[Name[2].."M44C13_DO"]=Core[Name[1].."M44C13_DO"] end},
        ["SUMKOLOTKV_CP"]= {["Comment"]="Суммарное количество отключений выключателя ",["eval"]= function(Name) Core[Name[2].."SUMKOLOTKV_CP"]=Core[Name[1].."SUMKOLOTKV_CP"] end},
        ["VREMSBROSA_CP"]= {["Comment"]="Дата – время последнего сброса накопительной информации ",["eval"]= 
function(Name) 
	    if Core[Name[1].."VREMSBROSA_CP"][7]~=0 then
		Core[Name[2].."VREMSBROSA_CP"]=
			 tostring(BCD_to_dec((Core[Name[1].."VREMSBROSA_CP"])[5])).."."..
			 tostring(BCD_to_dec((Core[Name[1].."VREMSBROSA_CP"])[6])).."."..
			 tostring(BCD_to_dec((Core[Name[1].."VREMSBROSA_CP"])[7])).." "..
			 tostring(BCD_to_dec((Core[Name[1].."VREMSBROSA_CP"])[4]))..":"..
		 	 tostring(BCD_to_dec((Core[Name[1].."VREMSBROSA_CP"])[3]))..":"..
 			 tostring(BCD_to_dec((Core[Name[1].."VREMSBROSA_CP"])[2]))
end
end},
        ["Reg_Time"]= {["Comment"]="Астрономическое время встроенных часов- календаря ",["eval"]= 
function(Name) 
	    if Core[Name[1].."Reg_Time"][7]~=0 then
		Core[Name[2].."Reg_Time"]=
			 tostring(BCD_to_dec((Core[Name[1].."Reg_Time"])[5])).."."..
			 tostring(BCD_to_dec((Core[Name[1].."Reg_Time"])[6])).."."..
			 tostring(BCD_to_dec((Core[Name[1].."Reg_Time"])[7])).." "..
			 tostring(BCD_to_dec((Core[Name[1].."Reg_Time"])[4]))..":"..
		 	 tostring(BCD_to_dec((Core[Name[1].."Reg_Time"])[3]))..":"..
 			 tostring(BCD_to_dec((Core[Name[1].."Reg_Time"])[2]))
end
end},
        ["Reg_Slave_ID"]= {["Comment"]="Идентификатор ",["eval"]= 
function(Name)
local	j=0
local	str3=""		
	repeat 
		str3=str3..char_table[Core[Name[1].."Reg_Slave_ID"][j]]
		j=j+1
	until  (Core[Name[1].."Reg_Slave_ID"][j]==163)or(Core[Name[1].."Reg_Slave_ID"][j]==0 or j==31)
	Core[Name[2].."Reg_Slave_ID"]=str3																			--преобразование Reg_Slave_ID
end},
        ["40029_15_DP"]= {["Comment"]="Отключение СВ от АВР СВ ВЫЗОВ ",["eval"]= function(Name) Core[Name[2].."40029_15_DP"]=Core[Name[1].."40029_15_DP"] end},
        ["40029_14_DP"]= {["Comment"]="Отключение СВ от АВР АВ ВЫЗОВ ",["eval"]= function(Name) Core[Name[2].."40029_14_DP"]=Core[Name[1].."40029_14_DP"] end},
        ["40029_00_DP"]= {["Comment"]="Неисправность БМПА ВЫЗОВ ",["eval"]= function(Name) Core[Name[2].."40029_00_DP"]=Core[Name[1].."40029_00_DP"] end},
        ["40029_01_DP"]= {["Comment"]="Неисправность ЦУ ВЫЗОВ ",["eval"]= function(Name) Core[Name[2].."40029_01_DP"]=Core[Name[1].."40029_01_DP"] end},
        ["40029_07_DP"]= {["Comment"]="Аварийное отключение ",["eval"]= function(Name) Core[Name[2].."40029_07_DP"]=Core[Name[1].."40029_07_DP"] end},
        ["M34C15_DP"]= {["Comment"]="ВЫЗОВ ",["eval"]= function(Name) Core[Name[2].."M34C15_DP"]=Core[Name[1].."M34C15_DP"] end}


}


	


-- Инициализация сигналов в момент запуска

for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
	for _, signals_Descriptor in pairs(signals) do	--Цикл по всем элементов в каждом из 2 массивов: RAW_ и S_
		signals_Descriptor.eval({raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals
	end
end
-- Отслеживание изменений значений в сигналах
for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
	for signals_Suffix, signals_Descriptor in pairs(signals) do	--Цикл по всем переменным в каждом из 2 массивов: RAW_ и S_
		Core.onExtChange({raw_objectName..signals_Suffix},signals_Descriptor.eval,{raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals при изменении любой из переменных
	end
end

Core.waitEvents( )