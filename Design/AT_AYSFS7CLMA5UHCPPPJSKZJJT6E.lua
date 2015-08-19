local objects=					--Список объектов для ФЛАГОВ состояния и строки сообщения
{
["D_USO_"]="D_USO_"
}
local message_strings =--Список суффиксов флагов состояний, коментариев и строк сообщений 
{
     ["NEISP_1_DP"]= {["Comment"]="Диагностика   УСО. Неисправность модуля 1",["message"]="0.1"},
     ["NEISP_2_DP"]= {["Comment"]="Диагностика   УСО. Неисправность модуля 2",["message"]="0.2"},
     ["NEISP_3_DP"]= {["Comment"]="Диагностика   УСО. Неисправность модуля 3",["message"]="0.3"},
     ["NEISP_4_DP"]= {["Comment"]="Диагностика   УСО. Неисправность модуля 4",["message"]="0.4"},
     ["NEISP_5_DP"]= {["Comment"]="Диагностика   УСО. Неисправность модуля 5",["message"]="0.5"},
     ["NEISP_6_DP"]= {["Comment"]="Диагностика   УСО. Неисправность модуля 6",["message"]="0.6"},
     ["NEISP_7_DP"]= {["Comment"]="Диагностика   УСО. Неисправность модуля 7",["message"]="0.7"},
     ["NEISP_8_DP"]= {["Comment"]="Диагностика   УСО. Неисправность модуля 8",["message"]="0.8"},
     ["NEISP_9_DP"]= {["Comment"]="Диагностика   УСО. Неисправность модуля 9",["message"]="0.9"},									 												 
}

local set_flag=function(Name) --функция для поиска нужной строки в строке сообщения из флагов неисправности
    for flag_Suffix, flag_Descriptor in pairs(message_strings) do -- Перебираем все флаги неисправности

		if string.find(Core[Name[2].."MESSAGE_ST"],flag_Descriptor.message)~=nil then
			Core[Name[1]..flag_Suffix]=true
		else
        	Core[Name[1]..flag_Suffix]=false
		end
	end  
	if	Core["D_USO_NEISP_5_DP"]==true then
		Core["D_USO_NEISP_5_CP"]=1
	else
		Core["D_USO_NEISP_5_CP"]=0
	end
end

--начало программы
for flag_objectName, string_objectName in  pairs(objects) do  -- Перебираем все объекты.
set_flag({flag_objectName,string_objectName}) --первичная инициализация флагов
Core.onExtChange({string_objectName.."MESSAGE_ST"},set_flag,{flag_objectName,string_objectName})--Установка обработчика на изменение группы сигналов
end
	Core.waitEvents( ) --Перевод программы в ожидание событий