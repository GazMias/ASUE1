dofile("AT_BIP3WUMWFPGETLORIK7DY4CCVY.lua") 

--Объявление структуры, в которой левая часть до знака = это массив сигналов а правая часть - это массив переменных, передаваемых в SCADA систему

local objects = {
	["RAW_BMRZAV1_"]="S_KTP_P07_BAV1_",
	["RAW_BMRZAV2_"]="S_KTP_P07_BAV2_"
}

local signals = {
        ["40034_AP"]= {["Comment"]="Текущее значение тока фазы А",["eval"]= function(Name) Core[Name[2].."40034_AP"]=Core[Name[1].."40034_AP"]*Core[Name[1].."Reg_NET_KTr_1"] end},
        ["40035_AP"]= {["Comment"]="Текущее значение тока фазы В",["eval"]= function(Name) Core[Name[2].."40035_AP"]=Core[Name[1].."40035_AP"]*Core[Name[1].."Reg_NET_KTr_2"] end},
        ["40036_AP"]= {["Comment"]="Текущее значение тока фазы С",["eval"]= function(Name) Core[Name[2].."40036_AP"]=Core[Name[1].."40036_AP"]*Core[Name[1].."Reg_NET_KTr_3"] end},
        ["40037_AP"]= {["Comment"]="Текущее значение тока нулевой последовательности",["eval"]= function(Name) Core[Name[2].."40037_AP"]=Core[Name[1].."40037_AP"]*Core[Name[1].."Reg_NET_KTr_4"] end},
        ["40038_AP"]= {["Comment"]="Текущее значение напряжения фазы А ввода",["eval"]= function(Name) Core[Name[2].."40038_AP"]=Core[Name[1].."40038_AP"]*Core[Name[1].."Reg_NET_KTr_5"] end},
        ["40039_AP"]= {["Comment"]="Текущее значение напряжения фазы В ввода",["eval"]= function(Name) Core[Name[2].."40039_AP"]=Core[Name[1].."40039_AP"]*Core[Name[1].."Reg_NET_KTr_6"] end},
        ["40040_AP"]= {["Comment"]="Текущее значение напряжения фазы С ввода",["eval"]= function(Name) Core[Name[2].."40040_AP"]=Core[Name[1].."40040_AP"]*Core[Name[1].."Reg_NET_KTr_7"] end},
        ["40041_AP"]= {["Comment"]="Текущее значение напряжения фазы А секции",["eval"]= function(Name) Core[Name[2].."40041_AP"]=Core[Name[1].."40041_AP"]*Core[Name[1].."Reg_NET_KTr_8"] end},
        ["40042_AP"]= {["Comment"]="Текущее значение напряжения фазы В секции",["eval"]= function(Name) Core[Name[2].."40042_AP"]=Core[Name[1].."40042_AP"]*Core[Name[1].."Reg_NET_KTr_9"] end},
        ["40043_AP"]= {["Comment"]="Текущее значение напряжения фазы С секции",["eval"]= function(Name) Core[Name[2].."40043_AP"]=Core[Name[1].."40043_AP"]*Core[Name[1].."Reg_NET_KTr_10"] end},
        ["40044_AP"]= {["Comment"]="Текущее значение тока прямой последовательности",["eval"]= function(Name) Core[Name[2].."40044_AP"]=Core[Name[1].."40044_AP"]*Core[Name[1].."Reg_NET_KTr_11"] end},
        ["40045_AP"]= {["Comment"]="Текущее значение тока обратной последовательности",["eval"]= function(Name) Core[Name[2].."40045_AP"]=Core[Name[1].."40045_AP"]*Core[Name[1].."Reg_NET_KTr_12"] end},
        ["40046_AP"]= {["Comment"]="Текущее значение напряжения прямой последовательности.",["eval"]= function(Name) Core[Name[2].."40046_AP"]=Core[Name[1].."40046_AP"]*Core[Name[1].."Reg_NET_KTr_13"] end},
        ["40047_AP"]= {["Comment"]="Текущее значение напряжения обратной последовательности.",["eval"]= function(Name) Core[Name[2].."40047_AP"]=Core[Name[1].."40047_AP"]*Core[Name[1].."Reg_NET_KTr_14"] end},
        ["40048_AP"]= {["Comment"]="Текущее значение активной составляющей тока прямой последовательности",["eval"]= function(Name) Core[Name[2].."40048_AP"]=Core[Name[1].."40048_AP"]*Core[Name[1].."Reg_NET_KTr_15"] end},
        ["40049_AP"]= {["Comment"]="Текущее значение реактивной составляющей тока прямой последовательности",["eval"]= function(Name) Core[Name[2].."40049_AP"]=Core[Name[1].."40049_AP"]*Core[Name[1].."Reg_NET_KTr_16"] end},
        ["40050_AP"]= {["Comment"]="Текущее значение угла между 11и U1",["eval"]= function(Name) Core[Name[2].."40050_AP"]=Core[Name[1].."40050_AP"]*Core[Name[1].."Reg_NET_KTr_17"] end},
        ["40051_AP"]= {["Comment"]="Текущее значение активной составляющей мощности обратной последовательности",["eval"]= function(Name) Core[Name[2].."40051_AP"]=Core[Name[1].."40051_AP"]*Core[Name[1].."Reg_NET_KTr_18"] end},
        ["40052_AP"]= {["Comment"]="Текущее значение активной трехфазной мощности",["eval"]= function(Name) Core[Name[2].."40052_AP"]=Core[Name[1].."40052_AP"]*Core[Name[1].."Reg_NET_KTr_19"] end},
        ["40053_AP"]= {["Comment"]="Текущее значение реактивной фазной мощности",["eval"]= function(Name) Core[Name[2].."40053_AP"]=Core[Name[1].."40053_AP"]*Core[Name[1].."Reg_NET_KTr_20"] end},
        ["40054_AP"]= {["Comment"]="Текущее значение полной трехфазной мощности",["eval"]= function(Name) Core[Name[2].."40054_AP"]=Core[Name[1].."40054_AP"]*Core[Name[1].."Reg_NET_KTr_21"] end},
        ["40055_AP"]= {["Comment"]="Текущее значение cos Ф",["eval"]= function(Name) Core[Name[2].."40055_AP"]=Core[Name[1].."40055_AP"]*Core[Name[1].."Reg_NET_KTr_22"] end},
        ["40056_AP"]= {["Comment"]="Текущее значение напряжения обратной последовательности ввода.",["eval"]= function(Name) Core[Name[2].."40056_AP"]=Core[Name[1].."40056_AP"]*Core[Name[1].."Reg_NET_KTr_23"] end},
        ["40057_AP"]= {["Comment"]="Текущее значение частоты тока в сети",["eval"]= function(Name) Core[Name[2].."40057_AP"]=Core[Name[1].."40057_AP"]*Core[Name[1].."Reg_NET_KTr_24"] end},
        ["40140_AP"]= {["Comment"]="Максимальное значение тока фазы А",["eval"]= function(Name) Core[Name[2].."40140_AP"]=Core[Name[1].."40140_AP"]*Core[Name[1].."Reg_NET_KTr_1"] end},
        ["40141_AP"]= {["Comment"]="Максимальное значение тока фазы В",["eval"]= function(Name) Core[Name[2].."40141_AP"]=Core[Name[1].."40141_AP"]*Core[Name[1].."Reg_NET_KTr_2"] end},
        ["40142_AP"]= {["Comment"]="Максимальное значение тока фазы С",["eval"]= function(Name) Core[Name[2].."40142_AP"]=Core[Name[1].."40142_AP"]*Core[Name[1].."Reg_NET_KTr_3"] end},
        ["40143_AP"]= {["Comment"]="Максимальное значение тока нулевой последовательности",["eval"]= function(Name) Core[Name[2].."40143_AP"]=Core[Name[1].."40143_AP"]*Core[Name[1].."Reg_NET_KTr_4"] end},
        ["409238_DI"]= {["Comment"]="Сигнал от концевых выключателей тележки выключателя аварийного ввода",["eval"]= function(Name) Core[Name[2].."409238_DI"]=Core[Name[1].."409238_DI"] end},
        ["409239_DI"]= {["Comment"]="Напряжение на 2 секции меньше 0.25ин",["eval"]= function(Name) Core[Name[2].."409239_DI"]=Core[Name[1].."409239_DI"] end},
        ["4092310_DI"]= {["Comment"]="Напряжение обратной последовательности 1 ввода больше 0.8ин",["eval"]= function(Name) Core[Name[2].."4092310_DI"]=Core[Name[1].."4092310_DI"] end},
        ["4092311_DI"]= {["Comment"]="Напряжение обратной последовательности 2 ввода больше 0.8ин",["eval"]= function(Name) Core[Name[2].."4092311_DI"]=Core[Name[1].."4092311_DI"] end},
        ["4092312_DI"]= {["Comment"]="Нахождение выключателя генератора 2 в отключенном состоянии",["eval"]= function(Name) Core[Name[2].."4092312_DI"]=Core[Name[1].."4092312_DI"] end},
        ["4092313_DI"]= {["Comment"]="Нахождение выключателя аварийного ввода 2 в отключенном состоянии",["eval"]= function(Name) Core[Name[2].."4092313_DI"]=Core[Name[1].."4092313_DI"] end},
        ["4092314_DI"]= {["Comment"]="Сигнал от концевых выключателей тележки выключателя аварийного ввода 2",["eval"]= function(Name) Core[Name[2].."4092314_DI"]=Core[Name[1].."4092314_DI"] end},
        ["4092315_DI"]= {["Comment"]="Нахождение ВАВ в отключенном состоянии",["eval"]= function(Name) Core[Name[2].."4092315_DI"]=Core[Name[1].."4092315_DI"] end},
        ["409230_DI"]= {["Comment"]="Нахождение ВАВ в включенном состоянии",["eval"]= function(Name) Core[Name[2].."409230_DI"]=Core[Name[1].."409230_DI"] end},
        ["409231_DI"]= {["Comment"]="Реальное положение выключателя",["eval"]= function(Name) Core[Name[2].."409231_DI"]=Core[Name[1].."409231_DI"] end},
        ["409232_DI"]= {["Comment"]="Сигнал блокировки ДР и МТЗ",["eval"]= function(Name) Core[Name[2].."409232_DI"]=Core[Name[1].."409232_DI"] end},
        ["409233_DI"]= {["Comment"]="Нахождение выключателя ввода 1 в отключенном состоянии",["eval"]= function(Name) Core[Name[2].."409233_DI"]=Core[Name[1].."409233_DI"] end},
        ["409234_DI"]= {["Comment"]="Нахождение выключателя ввода 2 в отключенном состоянии",["eval"]= function(Name) Core[Name[2].."409234_DI"]=Core[Name[1].."409234_DI"] end},
        ["409235_DI"]= {["Comment"]="Нахождение выключателя генератора 1 в отключенном состоянии",["eval"]= function(Name) Core[Name[2].."409235_DI"]=Core[Name[1].."409235_DI"] end},
        ["409236_DI"]= {["Comment"]="Нахождение выключателя генератора 1 в включенном состоянии",["eval"]= function(Name) Core[Name[2].."409236_DI"]=Core[Name[1].."409236_DI"] end},
        ["409237_DI"]= {["Comment"]="Блокировка АВР АВ от БМРЗ-0,4ВВ",["eval"]= function(Name) Core[Name[2].."409237_DI"]=Core[Name[1].."409237_DI"] end},
        ["409248_DI"]= {["Comment"]="Переключение блока в режим дистанционного управления",["eval"]= function(Name) Core[Name[2].."409248_DI"]=Core[Name[1].."409248_DI"] end},
        ["409249_DI"]= {["Comment"]="Сигнал оперативного управления от кнопок (ключей)",["eval"]= function(Name) Core[Name[2].."409249_DI"]=Core[Name[1].."409249_DI"] end},
        ["4092410_DI"]= {["Comment"]="Сигнал оперативного управления от кнопок (ключей)",["eval"]= function(Name) Core[Name[2].."4092410_DI"]=Core[Name[1].."4092410_DI"] end},
        ["4092411_DI"]= {["Comment"]="Сигнал от концевых выключателей тележки выключателя ввода 1",["eval"]= function(Name) Core[Name[2].."4092411_DI"]=Core[Name[1].."4092411_DI"] end},
        ["4092412_DI"]= {["Comment"]="Сигнал отключения цепей ДУ, сигналов телеуправления, ключей управления и т.д.",["eval"]= function(Name) Core[Name[2].."4092412_DI"]=Core[Name[1].."4092412_DI"] end},
        ["4092413_DI"]= {["Comment"]="Сигнал подключения цепей ДУ, сигналов телеуправления, ключей управления и т.д.",["eval"]= function(Name) Core[Name[2].."4092413_DI"]=Core[Name[1].."4092413_DI"] end},
        ["4092414_DI"]= {["Comment"]="Сигнал от концевых выключателей тележки выключателя ввода 2",["eval"]= function(Name) Core[Name[2].."4092414_DI"]=Core[Name[1].."4092414_DI"] end},
        ["4092415_DI"]= {["Comment"]="Сигнал срабатывания дуговой защиты",["eval"]= function(Name) Core[Name[2].."4092415_DI"]=Core[Name[1].."4092415_DI"] end},
        ["409240_DI"]= {["Comment"]="Напряжение обратной последовательности 1 ввода меньше 0.25Цн",["eval"]= function(Name) Core[Name[2].."409240_DI"]=Core[Name[1].."409240_DI"] end},
        ["409241_DI"]= {["Comment"]="Напряжение обратной последовательности 2 ввода меньше 0.25Цн",["eval"]= function(Name) Core[Name[2].."409241_DI"]=Core[Name[1].."409241_DI"] end},
        ["409242_DI"]= {["Comment"]="Квитирование",["eval"]= function(Name) Core[Name[2].."409242_DI"]=Core[Name[1].."409242_DI"] end},
        ["409243_DI"]= {["Comment"]="Резерв",["eval"]= function(Name) Core[Name[2].."409243_DI"]=Core[Name[1].."409243_DI"] end},
        ["409244_DI"]= {["Comment"]="Резерв",["eval"]= function(Name) Core[Name[2].."409244_DI"]=Core[Name[1].."409244_DI"] end},
        ["409245_DI"]= {["Comment"]="Резерв",["eval"]= function(Name) Core[Name[2].."409245_DI"]=Core[Name[1].."409245_DI"] end},
        ["409246_DI"]= {["Comment"]="Резерв",["eval"]= function(Name) Core[Name[2].."409246_DI"]=Core[Name[1].."409246_DI"] end},
        ["409247_DI"]= {["Comment"]="Сигнал единого времени",["eval"]= function(Name) Core[Name[2].."409247_DI"]=Core[Name[1].."409247_DI"] end},

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