
dofile("AT_BIP3WUMWFPGETLORIK7DY4CCVY.lua") 

--Объявление структуры, в которой левая часть до знака = это массив сигналов а правая часть - это массив переменных, передаваемых в SCADA систему

local objects = {
	["RAW_BMRZ_"]="S_KTP_P07_BVV1_",
	["RAW_BMRZ_2_"]="S_KTP_P07_BVV2_"
}
--уставки для чтения из окна
local signals_R = {
	-- Объявление переменных в виде структуры где левая часть до знака = это Suffix, правая часть это Descriptor. Descriptor в свою очередь представляет собой структуру
	-- в которой первый элемент это комментарий Comment, второй элемент это функция eval. В функциях происходит преобразование значений сигналов из регистров, и присваивание этих
	-- преобразованных значений переменным, передаваемым в SCADA систему

        ["W40466_DP"]= {["Comment"]="Уставка по току для первого пускового органа МТЗ первой ступени с независимой время - токовой характеристикой. Действует постоянно",["eval"]= 
function(Name) 
Core[Name[2].."W40466_DP"]=BCD_to_dec(Core[Name[1].."W40466_DP"])/100 
end},
        ["W40467_DP"]= {["Comment"]="Уставка по току для второго пускового органа МТЗ первой ступени первой ступени с независимой время - токовой характеристикой. Используется функцией БМТЗ",["eval"]= 
function(Name) 
Core[Name[2].."W40467_DP"]=BCD_to_dec(Core[Name[1].."W40467_DP"])/100 
end},
        ["W40468_DP"]= {["Comment"]="Уставка по току для МТЗ второй ступени с независимой время - токовой характеристикой",["eval"]= 
function(Name) 
Core[Name[2].."W40468_DP"]=BCD_to_dec(Core[Name[1].."W40468_DP"])/100 
end},
        ["W40469_DP"]= {["Comment"]="Уставка по току для МТЗ второй ступени с обратнозависимой время - токовой характеристикой",["eval"]= 
function(Name) 
Core[Name[2].."W40469_DP"]=BCD_to_dec(Core[Name[1].."W40469_DP"])/100 
end},
        ["W40470_DP"]= {["Comment"]="Уставка по выдержке времени для пер-вого элемента МТЗ первой ступени (выда-ча БМРЗ выходного сигнала Откл. СВ). Обязательное условие Т1 < Т2",["eval"]= 
function(Name) 
Core[Name[2].."W40470_DP"]=BCD_to_dec(Core[Name[1].."W40470_DP"])/100 
end},
        ["W40471_DP"]= {["Comment"]="Уставка по выдержки времени для второго элемента МТЗ первой ступени (выдача БМРЗ выходного сигнала Откл)",["eval"]= 
function(Name) 
Core[Name[2].."W40471_DP"]=BCD_to_dec(Core[Name[1].."W40471_DP"])/100 
end},
        ["W40472_DP"]= {["Comment"]="Уставка по выдержке времени для МТЗ второй ступени с независимой время - токовой характеристикой",["eval"]= 
function(Name) 
Core[Name[2].."W40472_DP"]=BCD_to_dec(Core[Name[1].."W40472_DP"])/100 
end},
        ["W40473_DP"]= {["Comment"]="Уставка по выдержке времени для МТЗ второй ступени с обратнозависимой время - токовой характеристикой при величине тока, равной 10 I3",["eval"]= 
function(Name) 
Core[Name[2].."W40473_DP"]=BCD_to_dec(Core[Name[1].."W40473_DP"])/100 
end},
        ["W40474_DP"]= {["Comment"]="Уставка по току для ДР первой ступени с независимой время - токовой характерис­тикой",["eval"]= 
function(Name) 
Core[Name[2].."W40474_DP"]=BCD_to_dec(Core[Name[1].."W40474_DP"])/100 
end},
        ["W40475_DP"]= {["Comment"]="Уставка по току для ДР первой ступени с независимой время - токовой характерис­тикой при включении статической нагрузки",["eval"]= 
function(Name) 
Core[Name[2].."W40475_DP"]=BCD_to_dec(Core[Name[1].."W40475_DP"])/100 
end},
        ["W40476_DP"]= {["Comment"]="Уставка по току обратной последова­тельности для ДР первой ступени с неза­висимой время - токовой характеристикой",["eval"]= 
function(Name) 
Core[Name[2].."W40476_DP"]=BCD_to_dec(Core[Name[1].."W40476_DP"])/100 
end},
        ["W40477_DP"]= {["Comment"]="Уставка по току для ДР первой ступени с независимой время - токовой характерис­тикой, равная номинальному току источ­ника питания ввода 0,4 кВ (трансформа­тора или генератора)",["eval"]= 
function(Name) 
Core[Name[2].."W40477_DP"]=BCD_to_dec(Core[Name[1].."W40477_DP"])/100 
end},
        ["W40478_DP"]= {["Comment"]="Уставка по току для ДР второй ступени с обратнозависимой время - токовой характеристикой",["eval"]= 
function(Name) 
Core[Name[2].."W40478_DP"]=BCD_to_dec(Core[Name[1].."W40478_DP"])/100 
end},
        ["W40479_DP"]= {["Comment"]="Уставка по выдержке времени для ДР второй ступени с обратнозависимой время - токовой характеристикой при величине тока, равной 10 I3",["eval"]= 
function(Name) 
Core[Name[2].."W40479_DP"]=BCD_to_dec(Core[Name[1].."W40479_DP"])/100 
end},
        ["W40480_DP"]= {["Comment"]="Уставка по первому элементу выдержки времени для ДР первой ступени с выдачей блоком выходного сигнала Откл. СВ. Обязательное условие Тдр1 < Тдр2",["eval"]= 
function(Name) 
Core[Name[2].."W40480_DP"]=BCD_to_dec(Core[Name[1].."W40480_DP"])/100 
end},
        ["W40481_DP"]= {["Comment"]="Уставка по второму элементу выдержки времени для ДР первой ступени (выдача БМРЗ выходного сигнала Откл.)",["eval"]= 
function(Name) 
Core[Name[2].."W40481_DP"]=BCD_to_dec(Core[Name[1].."W40481_DP"])/100 
end},
        ["W40482_DP"]= {["Comment"]="Уставка по току обратной последова­тельности для ТЗНП с независимой время - токовой характеристикой",["eval"]= 
function(Name) 
Core[Name[2].."W40482_DP"]=BCD_to_dec(Core[Name[1].."W40482_DP"])/100 
end},
        ["W40483_DP"]= {["Comment"]="Уставка по выдержке времени для первого элемента ТЗНП (выдача БМРЗ выходного сигнала Откл. СВ). Обязательное условие То1 < То2",["eval"]= 
function(Name) 
Core[Name[2].."W40483_DP"]=BCD_to_dec(Core[Name[1].."W40483_DP"])/100 
end},
        ["W40484_DP"]= {["Comment"]="Уставка по выдержке времени для второго элемента ТЗНП (выдача БМРЗ выходного сигнала Откл)",["eval"]= 
function(Name) 
Core[Name[2].."W40484_DP"]=BCD_to_dec(Core[Name[1].."W40484_DP"])/100 
end},
        ["W40485_DP"]= {["Comment"]="Уставка по выдержке времени срабатывания АВР АВ",["eval"]= 
function(Name) 
Core[Name[2].."W40485_DP"]=BCD_to_dec(Core[Name[1].."W40485_DP"])/100 
end},
        ["W40486_DP"]= {["Comment"]="Уставка по выдержке времени срабатывания ВНР АВ",["eval"]= 
function(Name) 
Core[Name[2].."W40486_DP"]=BCD_to_dec(Core[Name[1].."W40486_DP"])/100 
end},

        ["W40487_DP"]= {["Comment"]="Уставка по напряжению обратной последовательности ввода для РАВР",["eval"]= 
function(Name) 
Core[Name[2].."W40487_DP"]=BCD_to_dec(Core[Name[1].."W40487_DP"]) 
end},
        ["W40488_DP"]= {["Comment"]="Уставка по напряжению обратной последовательности секции для РАВР",["eval"]= 
function(Name) 
Core[Name[2].."W40488_DP"]=BCD_to_dec(Core[Name[1].."W40488_DP"]) 
end},
        ["W40489_DP"]= {["Comment"]="Уставка назначения контрольного выхода",["eval"]= 
function(Name) 
Core[Name[2].."W40489_DP"]=BCD_to_dec(Core[Name[1].."W40489_DP"]) 
end},
}
--Уставки для записи в окно
local signals_W = {
	-- Объявление переменных в виде структуры где левая часть до знака = это Suffix, правая часть это Descriptor. Descriptor в свою очередь представляет собой структуру
	-- в которой первый элемент это комментарий Comment, второй элемент это функция eval. В функциях происходит преобразование значений сигналов из регистров, и присваивание этих
	-- преобразованных значений переменным, передаваемым в SCADA систему
        ["W40466_DP"]= {["Comment"]="Уставка по току для первого пускового органа МТЗ первой ступени с независимой время - токовой характеристикой. Действует постоянно",["eval"]= 
function(Name) 
Core[Name[1].."W40466_DP"]=DEC_to_BCD((Core[Name[2].."W40466_DP"]*100)+0.1) end},
        ["W40467_DP"]= {["Comment"]="Уставка по току для второго пускового органа МТЗ первой ступени первой ступени с независимой время - токовой характеристикой. Используется функцией БМТЗ",["eval"]= function(Name) Core[Name[1].."W40467_DP"]=DEC_to_BCD((Core[Name[2].."W40467_DP"]*100)+0.1) end},
        ["W40468_DP"]= {["Comment"]="Уставка по току для МТЗ второй ступени с независимой время - токовой характеристикой",["eval"]= function(Name) Core[Name[1].."W40468_DP"]=DEC_to_BCD((Core[Name[2].."W40468_DP"]*100)+0.1) end},
        ["W40469_DP"]= {["Comment"]="Уставка по току для МТЗ второй ступени с обратнозависимой время - токовой характеристикой",["eval"]= function(Name) Core[Name[1].."W40469_DP"]=DEC_to_BCD((Core[Name[2].."W40469_DP"]*100)+0.1) end},
        ["W40470_DP"]= {["Comment"]="Уставка по выдержке времени для пер-вого элемента МТЗ первой ступени (выда-ча БМРЗ выходного сигнала Откл. СВ). Обязательное условие Т1 < Т2",["eval"]= function(Name) Core[Name[1].."W40470_DP"]=DEC_to_BCD((Core[Name[2].."W40470_DP"]*100)+0.1) end},
        ["W40471_DP"]= {["Comment"]="Уставка по выдержки времени для второго элемента МТЗ первой ступени (выдача БМРЗ выходного сигнала Откл)",["eval"]= function(Name) Core[Name[1].."W40471_DP"]=DEC_to_BCD((Core[Name[2].."W40471_DP"]*100)+0.1) end},
        ["W40472_DP"]= {["Comment"]="Уставка по выдержке времени для МТЗ второй ступени с независимой время - токовой характеристикой",["eval"]= function(Name) Core[Name[1].."W40472_DP"]=DEC_to_BCD((Core[Name[2].."W40472_DP"]*100)+0.1) end},
        ["W40473_DP"]= {["Comment"]="Уставка по выдержке времени для МТЗ второй ступени с обратнозависимой время - токовой характеристикой при величине тока, равной 10 I3",["eval"]= function(Name) Core[Name[1].."W40473_DP"]=DEC_to_BCD((Core[Name[2].."W40473_DP"]*100)+0.1) end},
        ["W40474_DP"]= {["Comment"]="Уставка по току для ДР первой ступени с независимой время - токовой характерис­тикой",["eval"]= function(Name) Core[Name[1].."W40474_DP"]=DEC_to_BCD((Core[Name[2].."W40474_DP"]*100)+0.1) end},
        ["W40475_DP"]= {["Comment"]="Уставка по току для ДР первой ступени с независимой время - токовой характерис­тикой при включении статической нагрузки",["eval"]= function(Name) Core[Name[1].."W40475_DP"]=DEC_to_BCD((Core[Name[2].."W40475_DP"]*100)+0.1) end},
        ["W40476_DP"]= {["Comment"]="Уставка по току обратной последова­тельности для ДР первой ступени с неза­висимой время - токовой характеристикой",["eval"]= function(Name) Core[Name[1].."W40476_DP"]=DEC_to_BCD((Core[Name[2].."W40476_DP"]*100)+0.1) end},
        ["W40477_DP"]= {["Comment"]="Уставка по току для ДР первой ступени с независимой время - токовой характерис­тикой, равная номинальному току источ­ника питания ввода 0,4 кВ (трансформа­тора или генератора)",["eval"]= function(Name) Core[Name[1].."W40477_DP"]=DEC_to_BCD((Core[Name[2].."W40477_DP"]*100)+0.1) end},
        ["W40478_DP"]= {["Comment"]="Уставка по току для ДР второй ступени с обратнозависимой время - токовой характеристикой",["eval"]= function(Name) Core[Name[1].."W40478_DP"]=DEC_to_BCD((Core[Name[2].."W40478_DP"]*100)+0.1) end},
        ["W40479_DP"]= {["Comment"]="Уставка по выдержке времени для ДР второй ступени с обратнозависимой время - токовой характеристикой при величине тока, равной 10 I3",["eval"]= function(Name) Core[Name[1].."W40479_DP"]=DEC_to_BCD((Core[Name[2].."W40479_DP"]*100)+0.1) end},
        ["W40480_DP"]= {["Comment"]="Уставка по первому элементу выдержки времени для ДР первой ступени с выдачей блоком выходного сигнала Откл. СВ. Обязательное условие Тдр1 < Тдр2",["eval"]= function(Name) Core[Name[1].."W40480_DP"]=DEC_to_BCD((Core[Name[2].."W40480_DP"]*100)+0.1) end},
        ["W40481_DP"]= {["Comment"]="Уставка по второму элементу выдержки времени для ДР первой ступени (выдача БМРЗ выходного сигнала Откл.)",["eval"]= function(Name) Core[Name[1].."W40481_DP"]=DEC_to_BCD((Core[Name[2].."W40481_DP"]*100)+0.1) end},
        ["W40482_DP"]= {["Comment"]="Уставка по току обратной последова­тельности для ТЗНП с независимой время - токовой характеристикой",["eval"]= function(Name) Core[Name[1].."W40482_DP"]=DEC_to_BCD((Core[Name[2].."W40482_DP"]*100)+0.1) end},
        ["W40483_DP"]= {["Comment"]="Уставка по выдержке времени для первого элемента ТЗНП (выдача БМРЗ выходного сигнала Откл. СВ). Обязательное условие То1 < То2",["eval"]= function(Name) Core[Name[1].."W40483_DP"]=DEC_to_BCD((Core[Name[2].."W40483_DP"]*100)+0.1) end},
        ["W40484_DP"]= {["Comment"]="Уставка по выдержке времени для второго элемента ТЗНП (выдача БМРЗ выходного сигнала Откл)",["eval"]= function(Name) Core[Name[1].."W40484_DP"]=DEC_to_BCD((Core[Name[2].."W40484_DP"]*100)+0.1) end},
        ["W40485_DP"]= {["Comment"]="Уставка по выдержке времени срабатывания АВР АВ",["eval"]= function(Name) Core[Name[1].."W40485_DP"]=DEC_to_BCD((Core[Name[2].."W40485_DP"]*100)+0.1) end},
        ["W40486_DP"]= {["Comment"]="Уставка по выдержке времени срабатывания ВНР АВ",["eval"]= function(Name) Core[Name[1].."W40486_DP"]=DEC_to_BCD((Core[Name[2].."W40486_DP"]*100)+0.1) end},
        ["W40487_DP"]= {["Comment"]="Уставка по напряжению обратной последовательности ввода для РАВР",["eval"]= function(Name) Core[Name[1].."W40487_DP"]=DEC_to_BCD((Core[Name[2].."W40487_DP"])) end},
        ["W40488_DP"]= {["Comment"]="Уставка по напряжению обратной последовательности секции для РАВР",["eval"]= function(Name) Core[Name[1].."W40488_DP"]=DEC_to_BCD((Core[Name[2].."W40488_DP"])) end},
        ["W40489_DP"]= {["Comment"]="Уставка назначения контрольного выхода",["eval"]= function(Name) Core[Name[1].."W40489_DP"]=DEC_to_BCD((Core[Name[2].."W40489_DP"])) end},

}
-- Инициализация сигналов в момент запуска

for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
	for _, signals_R_Descriptor in pairs(signals_R) do	--Цикл по всем элементов в каждом из 2 массивов: RAW_ и S_
		signals_R_Descriptor.eval({raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals
	end
end
-- Отслеживание изменений значений в сигналах
for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
	for signals_Suffix, signals_R_Descriptor in pairs(signals_R) do	--Цикл по всем переменным в каждом из 2 массивов: RAW_ и S_
		Core.onExtChange({raw_objectName..signals_Suffix},signals_R_Descriptor.eval,{raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals при изменении любой из переменных
	end
end

-- Отслеживание изменений значений в сигналах
for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
	for signals_Suffix, signals_W_Descriptor in pairs(signals_W) do	--Цикл по всем переменным в каждом из 2 массивов: RAW_ и S_
		Core.onExtChange({objectName..signals_Suffix},signals_W_Descriptor.eval,{raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals при изменении любой из переменных
	end
end
Core.waitEvents( )