--Объявление структуры, в которой левая часть до знака = это массив сигналов а правая часть - это массив переменных, передаваемых в SCADA систему
local blocks
local objects = {
	["RAW_TVS_"]="S_TVS_"
}

local signals = {
	-- Объявление переменных в виде структуры где левая часть до знака = это Suffix, правая часть это Descriptor. Descriptor в свою очередь представляет собой структуру
	-- в которой первый элемент это комментарий Comment, второй элемент это функция eval. В функциях происходит преобразование значений сигналов из регистров, и присваивание этих
	-- преобразованных значений переменным, передаваемым в SCADA систему
        ["VOS_RESVREM_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_Резервуар в ремонте",["eval"]= function(Name) Core[Name[2].."VOS_RESVREM_DP"]=Core[Name[1].."VOS_RESVREM_DP"] end},
        ["VOS_M5AVAR_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_М5_Затвор М5 - АВАРИЯ",["eval"]= function(Name) Core[Name[2].."VOS_M5AVAR_DP"]=Core[Name[1].."VOS_M5AVAR_DP"] end},
        ["VOS_NASA1OSN_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А1_Насосный агрегат - РАБОЧИЙ",["eval"]= function(Name) Core[Name[2].."VOS_NASA1OSN_DP"]=Core[Name[1].."VOS_NASA1OSN_DP"] end},
        ["VOS_NASA1RES_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А1_Насосный агрегат - РЕЗЕРВНЫЙ",["eval"]= function(Name) Core[Name[2].."VOS_NASA1RES_DP"]=Core[Name[1].."VOS_NASA1RES_DP"] end},
        ["VOS_NASA2OSN_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А2_Насосный агрегат - РАБОЧИЙ",["eval"]= function(Name) Core[Name[2].."VOS_NASA2OSN_DP"]=Core[Name[1].."VOS_NASA2OSN_DP"] end},
        ["VOS_NASA2RES_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А2_Насосный агрегат - РЕЗЕРВНЫЙ",["eval"]= function(Name) Core[Name[2].."VOS_NASA2RES_DP"]=Core[Name[1].."VOS_NASA2RES_DP"] end},
        ["VOS_NASA1AVAR_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А1_Насосный агрегат - АВАРИЯ",["eval"]= function(Name) Core[Name[2].."VOS_NASA1AVAR_DP"]=Core[Name[1].."VOS_NASA1AVAR_DP"] end},
        ["VOS_NASA2AVAR_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А2_Насосный агрегат - АВАРИЯ",["eval"]= function(Name) Core[Name[2].."VOS_NASA2AVAR_DP"]=Core[Name[1].."VOS_NASA2AVAR_DP"] end},
        ["VOS_VAVARURRES_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_РЕЗ_Уровень воды ВЕРХНИЙ АВАРИЙНЫЙ",["eval"]= function(Name) Core[Name[2].."VOS_VAVARURRES_DP"]=Core[Name[1].."VOS_VAVARURRES_DP"] end},
        ["VOS_NSPVSHOD_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_НСПВ_Насосная станция противопожарного водоснабжения СУХОЙ ХОД",["eval"]= function(Name) Core[Name[2].."VOS_NSPVSHOD_DP"]=Core[Name[1].."VOS_NSPVSHOD_DP"] end},
        ["VOS_A1NASVKL_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А1_Насос артскважины 1 ВКЛЮЧЕН",["eval"]= function(Name) Core[Name[2].."VOS_A1NASVKL_DP"]=Core[Name[1].."VOS_A1NASVKL_DP"] end},
        ["VOS_A1TMIN_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А1_Т воздуха в помещении насосной артскважины 1 <+3C",["eval"]= function(Name) Core[Name[2].."VOS_A1TMIN_DP"]=Core[Name[1].."VOS_A1TMIN_DP"] end},
        ["VOS_A1DVOTK_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А1_Т дверь в помещении насосной артскважины 1открыта",["eval"]= function(Name) Core[Name[2].."VOS_A1DVOTK_DP"]=Core[Name[1].."VOS_A1DVOTK_DP"] end},
        ["VOS_A1NASOSN_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А1_Насосный агрегат - РАБОЧИЙ",["eval"]= function(Name) Core[Name[2].."VOS_A1NASOSN_DP"]=Core[Name[1].."VOS_A1NASOSN_DP"] end},
        ["VOS_A1NASRES_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А1_Насосный агрегат - РЕЗЕРВНЫЙ",["eval"]= function(Name) Core[Name[2].."VOS_A1NASRES_DP"]=Core[Name[1].."VOS_A1NASRES_DP"] end},
        ["VOS_A2NASVKL_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А2_Насос артскважины 2 ВКЛЮЧЕН",["eval"]= function(Name) Core[Name[2].."VOS_A2NASVKL_DP"]=Core[Name[1].."VOS_A2NASVKL_DP"] end},
        ["VOS_A2DVOTK_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А2_Т дверь в помещении насосной артскважины 2 открыта",["eval"]= function(Name) Core[Name[2].."VOS_A2DVOTK_DP"]=Core[Name[1].."VOS_A2DVOTK_DP"] end},
        ["VOS_A2NASOSN_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А2_Насосный агрегат - РАБОЧИЙ",["eval"]= function(Name) Core[Name[2].."VOS_A2NASOSN_DP"]=Core[Name[1].."VOS_A2NASOSN_DP"] end},
        ["VOS_A2NASRES_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_А2_Насосный агрегат - РЕЗЕРВНЫЙ",["eval"]= function(Name) Core[Name[2].."VOS_A2NASRES_DP"]=Core[Name[1].."VOS_A2NASRES_DP"] end},
        ["VOS_M5ZAKR_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_М5_Затвор М5 ЗАКРЫТ",["eval"]= function(Name) Core[Name[2].."VOS_M5ZAKR_DP"]=Core[Name[1].."VOS_M5ZAKR_DP"] end},
        ["VOS_M5OTKR_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_М5_Затвор М5 ОТКРЫТ",["eval"]= function(Name) Core[Name[2].."VOS_M5OTKR_DP"]=Core[Name[1].."VOS_M5OTKR_DP"] end},
        ["VOS_MOTKR_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_М_Затвор М ОТКРЫТ",["eval"]= function(Name) Core[Name[2].."VOS_MOTKR_DP"]=Core[Name[1].."VOS_MOTKR_DP"] end},
        ["VOS_MZAKR_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_М_Затвор М ЗАКРЫТ",["eval"]= function(Name) Core[Name[2].."VOS_MZAKR_DP"]=Core[Name[1].."VOS_MZAKR_DP"] end},
        ["VOS_NPPVHAVAR_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_НППВ_Насосная станция хозпитьевого водоснабжения АВАРИЯ",["eval"]= function(Name) Core[Name[2].."VOS_NPPVHAVAR_DP"]=Core[Name[1].."VOS_NPPVHAVAR_DP"] end},
        ["VOS_NPPVFIRE_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_НППВ_Насосная станция противопожарного водоснабжения ПОЖАР",["eval"]= function(Name) Core[Name[2].."VOS_NPPVFIRE_DP"]=Core[Name[1].."VOS_NPPVFIRE_DP"] end},
        ["VOS_NPPVPAVAR_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_НППВ_Насосная станция противопожарного водоснабжения АВАРИЯ",["eval"]= function(Name) Core[Name[2].."VOS_NPPVPAVAR_DP"]=Core[Name[1].."VOS_NPPVPAVAR_DP"] end},
        ["VOS_NPPVNASVKL_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_НППВ_Насосная станция противопожарного водоснабжения Пожарный Насос ВКЛЮЧЕН",["eval"]= function(Name) Core[Name[2].."VOS_NPPVNASVKL_DP"]=Core[Name[1].."VOS_NPPVNASVKL_DP"] end},
        ["VOS_PULT_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_Система водоснабжения с пульта оператора",["eval"]= function(Name) Core[Name[2].."VOS_PULT_DP"]=Core[Name[1].."VOS_PULT_DP"] end},
        ["VOS_SAU_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_ВОС_Система водоснабжения от САУ ВОС",["eval"]= function(Name) Core[Name[2].."VOS_SAU_DP"]=Core[Name[1].."VOS_SAU_DP"] end},
        ["VOS_RESUROV_AP"]= {["Comment"]="АСУ Э_САУ_ВОС_AP_РЕЗ_Уровень воды",["eval"]= function(Name) Core[Name[2].."VOS_RESUROV_AP"]=Core[Name[1].."VOS_RESUROV_AP"] end},
        ["VOS_A1PRESS_AP"]= {["Comment"]="АСУ Э_САУ_ВОС_AP_А1_Насосный агрегат - Давление воды",["eval"]= function(Name) Core[Name[2].."VOS_A1PRESS_AP"]=Core[Name[1].."VOS_A1PRESS_AP"] end},
        ["VOS_A2PRESS_AP"]= {["Comment"]="АСУ Э_САУ_ВОС_AP_А2_Насосный агрегат - Давление воды ",["eval"]= function(Name) Core[Name[2].."VOS_A2PRESS_AP"]=Core[Name[1].."VOS_A2PRESS_AP"] end},
        ["KOT_KOTELVKL_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_КОТ_Котел включен",["eval"]= function(Name) Core[Name[2].."KOT_KOTELVKL_DP"]=Core[Name[1].."KOT_KOTELVKL_DP"] end},
        ["KOT_SETNASVKL_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_КОТ_Сетевой насос включен",["eval"]= function(Name) Core[Name[2].."KOT_SETNASVKL_DP"]=Core[Name[1].."KOT_SETNASVKL_DP"] end},
        ["KOT_SETNASAVAR_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_КОТ_Авария сетевого насоса",["eval"]= function(Name) Core[Name[2].."KOT_SETNASAVAR_DP"]=Core[Name[1].."KOT_SETNASAVAR_DP"] end},
        ["KOT_RECNASVKL_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_КОТ_Рециркулярционный насос включен",["eval"]= function(Name) Core[Name[2].."KOT_RECNASVKL_DP"]=Core[Name[1].."KOT_RECNASVKL_DP"] end},
        ["KOT_OTKLOTKR_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_КОТ_Отсечной клапан открыт",["eval"]= function(Name) Core[Name[2].."KOT_OTKLOTKR_DP"]=Core[Name[1].."KOT_OTKLOTKR_DP"] end},
        ["KOT_P1PRESS_AP"]= {["Comment"]="АСУ Э_САУ_ТВС_AI_КОТ_Давление прямоточной воды",["eval"]= function(Name) Core[Name[2].."KOT_P1PRESS_AP"]=Core[Name[1].."KOT_P1PRESS_AP"] end},
        ["KOT_P2PRESS_AP"]= {["Comment"]="АСУ Э_САУ_ТВС_AI_КОТ_Давление обратной воды",["eval"]= function(Name) Core[Name[2].."KOT_P2PRESS_AP"]=Core[Name[1].."KOT_P2PRESS_AP"] end},
        ["KOT_P1TEMP_AP"]= {["Comment"]="АСУ Э_САУ_ТВС_AI_КОТ_Температура прямоточной воды",["eval"]= function(Name) Core[Name[2].."KOT_P1TEMP_AP"]=Core[Name[1].."KOT_P1TEMP_AP"] end},
        ["KOT_P2TEMP_AP"]= {["Comment"]="АСУ Э_САУ_ТВС_AI_КОТ_Температура обратной воды",["eval"]= function(Name) Core[Name[2].."KOT_P2TEMP_AP"]=Core[Name[1].."KOT_P2TEMP_AP"] end},    
        ["KU_SHIBOTKR_DP"]= {["Comment"]="АСУ Э_САУ_ТВС_КУ_Шибер открыт",["eval"]= function(Name) Core[Name[2].."KU_SHIBOTKR_DP"]=Core[Name[1].."KU_SHIBOTKR_DP"] end},
        ["KU_SHIBZAKR_DP"]= {["Comment"]="АСУ Э_САУ_Панель ТВС_КУ_Шибер закрыт",["eval"]= function(Name) Core[Name[2].."KU_SHIBZAKR_DP"]=Core[Name[1].."KU_SHIBZAKR_DP"] end},
        ["KU_P1PRESS_AP"]= {["Comment"]="АСУ Э_САУ_ТВС_AI_КУ_Давление прямоточной воды",["eval"]= function(Name) Core[Name[2].."KU_P1PRESS_AP"]=Core[Name[1].."KU_P1PRESS_AP"] end},
        ["KU_P2PRESS_AP"]= {["Comment"]="АСУ Э_САУ_ТВС_AI_КУ_Давление обратной воды ",["eval"]= function(Name) Core[Name[2].."KU_P2PRESS_AP"]=Core[Name[1].."KU_P2PRESS_AP"] end},
        ["KU_P1TEMP_AP"]= {["Comment"]="АСУ Э_САУ_Панель ТВС_AI_КU_Температура прямоточной воды",["eval"]= function(Name) Core[Name[2].."KU_P1TEMP_AP"]=Core[Name[1].."KU_P1TEMP_AP"] end},
        ["KU_P2TEMP_AP"]= {["Comment"]="АСУ Э_САУ_Панель ТВС_AI_КU_Температура обратной воды",["eval"]= function(Name) Core[Name[2].."KU_P2TEMP_AP"]=Core[Name[1].."KU_P2TEMP_AP"] end},
        ["KNS_SAUAVT_DP"]= {["Comment"]="АСУ Э_САУ_КНС_Автоматический режим работы САУ КНС включен",["eval"]= function(Name) Core[Name[2].."KNS_SAUAVT_DP"]=Core[Name[1].."KNS_SAUAVT_DP"] end},
        ["KNS_NASVKL_DP"]= {["Comment"]="АСУ Э_САУ_КНС_Насос КНС включен",["eval"]= function(Name) Core[Name[2].."KNS_NASVKL_DP"]=Core[Name[1].."KNS_NASVKL_DP"] end},
        ["KNS_NASAVAR_DP"]= {["Comment"]="АСУ Э_САУ_КНС_Авария насоса КНС",["eval"]= function(Name) Core[Name[2].."KNS_NASAVAR_DP"]=Core[Name[1].."KNS_NASAVAR_DP"] end},
        ["KNS_KOSVRAB_DP"]= {["Comment"]="АСУ Э_САУ_КОС_КОС в работе",["eval"]= function(Name) Core[Name[2].."KNS_KOSVRAB_DP"]=Core[Name[1].."KNS_KOSVRAB_DP"] end},
        ["KNS_KOSNEIS_DP"]= {["Comment"]="АСУ Э_САУ_КОС_Неисправность КОС",["eval"]= function(Name) Core[Name[2].."KNS_KOSNEIS_DP"]=Core[Name[1].."KNS_KOSNEIS_DP"] end},
        ["KNS_RESUROV_AP"]= {["Comment"]="АСУ Э_САУ_AI_КНС_Уровень стоков в приёмном резервуаре",["eval"]= function(Name) Core[Name[2].."KNS_RESUROV_AP"]=Core[Name[1].."KNS_RESUROV_AP"] end},
        ["A1800_WP"]= {["Comment"]="Р потребленная за 30 минут",["eval"]= function(Name) Core[Name[2].."A1800_WP"]=Core[Name[1].."A1800_WP"] end},
        ["A1800_WS"]= {["Comment"]="S потребленная за 30 минут",["eval"]= function(Name) Core[Name[2].."A1800_WS"]=Core[Name[1].."A1800_WS"] end},
        ["A1800_WQ"]= {["Comment"]="Q потребленная за 30 минут",["eval"]= function(Name) Core[Name[2].."A1800_WQ"]=Core[Name[1].."A1800_WQ"] end}


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