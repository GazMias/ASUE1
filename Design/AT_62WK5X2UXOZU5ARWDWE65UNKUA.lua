local objects = {
	["RAW_USO_SNT_XT7_1A_"]="S_ZRU_P11_XT7_1A_",
	["RAW_USO_SNT_XT7_2A_"]="S_KTP_P07_XT7_2A_",
}

local KZ_OL= function(Name)
local KZ=62000
local OL=6000

		if Core[Name[1]]<OL then--определение обрыва
			Core[Name[2].."_OL"]=true 
		else
        	Core[Name[2].."_OL"]=false
		end
		if (Core[Name[1]]>OL+1 and Core[Name[1]]<KZ-1) then--нормальный режим
			Core[Name[2]]=Core[Name[1]] 
		else
        	Core[Name[2]]=Core[Name[1]]
		end
		if Core[Name[1]]>KZ then--определение короткого замыкания
			Core[Name[2].."_KZ"]=true 
		else
        	Core[Name[2].."_KZ"]=false
		end
end  


local signals = {
        ["AI"]= {["Comment"]="ЗРУ-10кВ. Температура в помещении ЗРУ. Необработанный",["eval"]= function(Name) KZ_OL(Name)  end},


}



-- Инициализация сигналов в момент запуска

for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
	for signals_Suffix, signals_Descriptor in pairs(signals) do	--Цикл по всем элементов в каждом из 2 массивов: RAW_ и S_
		signals_Descriptor.eval({raw_objectName..signals_Suffix,objectName..signals_Suffix})	--Вызов функций у каждой из переменных, описанных в signals
	end
end
-- Отслеживание изменений значений в сигналах
for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
	for signals_Suffix, signals_Descriptor in pairs(signals) do	--Цикл по всем переменным в каждом из 2 массивов: RAW_ и S_
		Core.onExtChange({raw_objectName..signals_Suffix},signals_Descriptor.eval,{raw_objectName..signals_Suffix,objectName..signals_Suffix})	--Вызов функций у каждой из переменных, описанных в signals при изменении любой из переменных
	end
end

Core.waitEvents( )