--Объявление структуры, в которой левая часть до знака = это массив сигналов а правая часть - это массив переменных, передаваемых в SCADA систему
local blocks
local objects = {
	["RAW_S7_P05_"]="S_KTP_P05_"
}

local signals = {
	-- Объявление переменных в виде структуры где левая часть до знака = это Suffix, правая часть это Descriptor. Descriptor в свою очередь представляет собой структуру
	-- в которой первый элемент это комментарий Comment, второй элемент это функция eval. В функциях происходит преобразование значений сигналов из регистров, и присваивание этих
	-- преобразованных значений переменным, передаваемым в SCADA систему

	-- Дискретные сигналы и переменные
        ["VV1_AVOTKOLSEC_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Аварийное отключение ОЛ секции ",["eval"]= function(Name) Core[Name[2].."VV1_AVOTKOLSEC_DP"]=Core[Name[1].."VV1_AVOTKOLSEC_DP"] end},
        ["VV1_AVOTKUVN_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Аварийное отключение УВН ",["eval"]= function(Name) Core[Name[2].."VV1_AVOTKUVN_DP"]=Core[Name[1].."VV1_AVOTKUVN_DP"] end},
        ["VV1_AVOTKVV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Аварийное отключение ВВ ",["eval"]= function(Name) Core[Name[2].."VV1_AVOTKVV_DP"]=Core[Name[1].."VV1_AVOTKVV_DP"] end},
        ["VV1_AVTVIKCNOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Авт  выключатели цепей напряжения В откл",["eval"]= function(Name) Core[Name[2].."VV1_AVTVIKCNOTK_DP"]=Core[Name[1].."VV1_AVTVIKCNOTK_DP"] end},
        ["VV1_AVTVIKCUOLSECOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Авт выкл  цепей управления ОЛ секции откл",["eval"]= function(Name) Core[Name[2].."VV1_AVTVIKCUOLSECOTK_DP"]=Core[Name[1].."VV1_AVTVIKCUOLSECOTK_DP"] end},
        ["VV1_AVTVIKCUOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Авт  выключатель цепей управления В откл",["eval"]= function(Name) Core[Name[2].."VV1_AVTVIKCUOTK_DP"]=Core[Name[1].."VV1_AVTVIKCUOTK_DP"] end},
        ["VV1_NEISPCOV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Неисправность цепей отключения В1",["eval"]= function(Name) Core[Name[2].."VV1_NEISPCOV_DP"]=Core[Name[1].."VV1_NEISPCOV_DP"] end},
        ["VV1_NEISPCVV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Неисправность цепей включения В1",["eval"]= function(Name) Core[Name[2].."VV1_NEISPCVV_DP"]=Core[Name[1].."VV1_NEISPCVV_DP"] end},
        ["VV1_NEISPCONTRV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Неисправность контроллера В ",["eval"]= function(Name) Core[Name[2].."VV1_NEISPCONTRV_DP"]=Core[Name[1].."VV1_NEISPCONTRV_DP"] end},
        ["VV1_NEISPCUV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Неисправность цепей управления B ",["eval"]= function(Name) Core[Name[2].."VV1_NEISPCUV_DP"]=Core[Name[1].."VV1_NEISPCUV_DP"] end},
        ["VV1_OTKSVVNRAVRSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Отключение СВ при ВНР после АВР СВ ",["eval"]= function(Name) Core[Name[2].."VV1_OTKSVVNRAVRSV_DP"]=Core[Name[1].."VV1_OTKSVVNRAVRSV_DP"] end},
        ["VV1_OTKVVAVRAV1_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Отключение ВВ по АВР АВ1 ",["eval"]= function(Name) Core[Name[2].."VV1_OTKVVAVRAV1_DP"]=Core[Name[1].."VV1_OTKVVAVRAV1_DP"] end},
        ["VV1_OTKVVAVRAV2_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Отключение ВВ по АВР АВ2 ",["eval"]= function(Name) Core[Name[2].."VV1_OTKVVAVRAV2_DP"]=Core[Name[1].."VV1_OTKVVAVRAV2_DP"] end},
        ["VV1_OTKVVAVRSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Отключение ВВ по АВР СВ ",["eval"]= function(Name) Core[Name[2].."VV1_OTKVVAVRSV_DP"]=Core[Name[1].."VV1_OTKVVAVRSV_DP"] end},
        ["VV1_OTKVVDGZ_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Отключение ВВ от дуговой защиты ",["eval"]= function(Name) Core[Name[2].."VV1_OTKVVDGZ_DP"]=Core[Name[1].."VV1_OTKVVDGZ_DP"] end},
        ["VV1_OTKVVNTRZASH_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Отключение выкл ВН тр-ра от защит ",["eval"]= function(Name) Core[Name[2].."VV1_OTKVVNTRZASH_DP"]=Core[Name[1].."VV1_OTKVVNTRZASH_DP"] end},
        ["VV1_PRTEMTROTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Превышение температуры тр-ра  на откл",["eval"]= function(Name) Core[Name[2].."VV1_PRTEMTROTK_DP"]=Core[Name[1].."VV1_PRTEMTROTK_DP"] end},
        ["VV1_PRTEMTRSIG_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Превышение температуры тр-ра на сигн",["eval"]= function(Name) Core[Name[2].."VV1_PRTEMTRSIG_DP"]=Core[Name[1].."VV1_PRTEMTRSIG_DP"] end},
        ["VV1_RAZGRSEC_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Разгрузка секции ",["eval"]= function(Name) Core[Name[2].."VV1_RAZGRSEC_DP"]=Core[Name[1].."VV1_RAZGRSEC_DP"] end},
        ["VV1_SRDGZSEC_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Срабатывание дуговой защиты секции ",["eval"]= function(Name) Core[Name[2].."VV1_SRDGZSEC_DP"]=Core[Name[1].."VV1_SRDGZSEC_DP"] end},
        ["VV1_SRTZNPOTKSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Срабатывание ТЗНП В на отключение СВ ",["eval"]= function(Name) Core[Name[2].."VV1_SRTZNPOTKSV_DP"]=Core[Name[1].."VV1_SRTZNPOTKSV_DP"] end},
        ["VV1_SRTZNPOTKTR_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Срабатывание ТЗНП В на отключение тр-ра  ",["eval"]= function(Name) Core[Name[2].."VV1_SRTZNPOTKTR_DP"]=Core[Name[1].."VV1_SRTZNPOTKTR_DP"] end},
        ["VV1_SRTZNPOTKVV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Срабатывание ТЗНП на отключение ВВ ",["eval"]= function(Name) Core[Name[2].."VV1_SRTZNPOTKVV_DP"]=Core[Name[1].."VV1_SRTZNPOTKVV_DP"] end},
        ["VV1_SRZASHVV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Срабатывание защит ВВ ",["eval"]= function(Name) Core[Name[2].."VV1_SRZASHVV_DP"]=Core[Name[1].."VV1_SRZASHVV_DP"] end},
        ["VV1_VKLSVAVRSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Включение СВ по АВР СВ ",["eval"]= function(Name) Core[Name[2].."VV1_VKLSVAVRSV_DP"]=Core[Name[1].."VV1_VKLSVAVRSV_DP"] end},
        ["VV1_VKLVVVNRAVRAV1_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Включение ВВ при ВНР после АВР АВ1 ",["eval"]= function(Name) Core[Name[2].."VV1_VKLVVVNRAVRAV1_DP"]=Core[Name[1].."VV1_VKLVVVNRAVRAV1_DP"] end},
        ["VV1_VKLVVVNRAVRAV2_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Включение ВВ при ВНР после АВР АВ2 ",["eval"]= function(Name) Core[Name[2].."VV1_VKLVVVNRAVRAV2_DP"]=Core[Name[1].."VV1_VKLVVVNRAVRAV2_DP"] end},
        ["VV1_VKLVVVNRAVRSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Включение ВВ при ВНР после АВР СВ ",["eval"]= function(Name) Core[Name[2].."VV1_VKLVVVNRAVRSV_DP"]=Core[Name[1].."VV1_VKLVVVNRAVRSV_DP"] end},
        ["VV1_VOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Выключатель ввода отключен ",["eval"]= function(Name) Core[Name[2].."VV1_VOTK_DP"]=Core[Name[1].."VV1_VOTK_DP"] end},
        ["VV1_VVIK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Выключатель ввода выкачен ",["eval"]= function(Name) Core[Name[2].."VV1_VVIK_DP"]=Core[Name[1].."VV1_VVIK_DP"] end},
        ["VV1_VVKL_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Выключатель ввода включен ",["eval"]= function(Name) Core[Name[2].."VV1_VVKL_DP"]=Core[Name[1].."VV1_VVKL_DP"] end},
        ["VV2_AVOTKOLSEC_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Аварийное отключение ОЛ секции ",["eval"]= function(Name) Core[Name[2].."VV2_AVOTKOLSEC_DP"]=Core[Name[1].."VV2_AVOTKOLSEC_DP"] end},
        ["VV2_AVOTKUVN_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Аварийное отключение УВН ",["eval"]= function(Name) Core[Name[2].."VV2_AVOTKUVN_DP"]=Core[Name[1].."VV2_AVOTKUVN_DP"] end},
        ["VV2_AVOTKVV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Аварийное отключение ВВ ",["eval"]= function(Name) Core[Name[2].."VV2_AVOTKVV_DP"]=Core[Name[1].."VV2_AVOTKVV_DP"] end},
        ["VV2_AVTVIKCNOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Авт. выключатели цепей напряжения В откл. ",["eval"]= function(Name) Core[Name[2].."VV2_AVTVIKCNOTK_DP"]=Core[Name[1].."VV2_AVTVIKCNOTK_DP"] end},
        ["VV2_AVTVIKCUOLSECOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Авт. выкл. цепей управления ОЛ секции откл. ",["eval"]= function(Name) Core[Name[2].."VV2_AVTVIKCUOLSECOTK_DP"]=Core[Name[1].."VV2_AVTVIKCUOLSECOTK_DP"] end},
        ["VV2_AVTVIKCUOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Авт. выключатель цепей управления В откл. ",["eval"]= function(Name) Core[Name[2].."VV2_AVTVIKCUOTK_DP"]=Core[Name[1].."VV2_AVTVIKCUOTK_DP"] end},
        ["VV2_NEISPCOV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Неисправность цепей включения В2",["eval"]= function(Name) Core[Name[2].."VV2_NEISPCOV_DP"]=Core[Name[1].."VV2_NEISPCOV_DP"] end},
        ["VV2_NEISPCVV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 1  Неисправность цепей отключения В2",["eval"]= function(Name) Core[Name[2].."VV2_NEISPCVV_DP"]=Core[Name[1].."VV2_NEISPCVV_DP"] end},
        ["VV2_NEISPCONTRV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Неисправность контроллера В ",["eval"]= function(Name) Core[Name[2].."VV2_NEISPCONTRV_DP"]=Core[Name[1].."VV2_NEISPCONTRV_DP"] end},
        ["VV2_NEISPCUV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Неисправность цепей управления B ",["eval"]= function(Name) Core[Name[2].."VV2_NEISPCUV_DP"]=Core[Name[1].."VV2_NEISPCUV_DP"] end},
        ["VV2_OTKSVVNRAVRSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Отключение СВ при ВНР после АВР СВ ",["eval"]= function(Name) Core[Name[2].."VV2_OTKSVVNRAVRSV_DP"]=Core[Name[1].."VV2_OTKSVVNRAVRSV_DP"] end},
        ["VV2_OTKVVAVRAV1_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Отключение ВВ по АВР АВ1 ",["eval"]= function(Name) Core[Name[2].."VV2_OTKVVAVRAV1_DP"]=Core[Name[1].."VV2_OTKVVAVRAV1_DP"] end},
        ["VV2_OTKVVAVRAV2_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Отключение ВВ по АВР АВ2 ",["eval"]= function(Name) Core[Name[2].."VV2_OTKVVAVRAV2_DP"]=Core[Name[1].."VV2_OTKVVAVRAV2_DP"] end},
        ["VV2_OTKVVAVRSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Отключение ВВ по АВР СВ ",["eval"]= function(Name) Core[Name[2].."VV2_OTKVVAVRSV_DP"]=Core[Name[1].."VV2_OTKVVAVRSV_DP"] end},
        ["VV2_OTKVVDGZ_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Отключение ВВ от дуговой защиты ",["eval"]= function(Name) Core[Name[2].."VV2_OTKVVDGZ_DP"]=Core[Name[1].."VV2_OTKVVDGZ_DP"] end},
        ["VV2_OTKVVNTRZASH_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Отключение выкл. ВН тр-ра от защит ",["eval"]= function(Name) Core[Name[2].."VV2_OTKVVNTRZASH_DP"]=Core[Name[1].."VV2_OTKVVNTRZASH_DP"] end},
        ["VV2_PRTEMTROTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Превышение температуры тр-ра  на откл. ",["eval"]= function(Name) Core[Name[2].."VV2_PRTEMTROTK_DP"]=Core[Name[1].."VV2_PRTEMTROTK_DP"] end},
        ["VV2_PRTEMTRSIG_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Превышение температуры тр-ра на сигн. ",["eval"]= function(Name) Core[Name[2].."VV2_PRTEMTRSIG_DP"]=Core[Name[1].."VV2_PRTEMTRSIG_DP"] end},
        ["VV2_RAZGRSEC_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Разгрузка секции ",["eval"]= function(Name) Core[Name[2].."VV2_RAZGRSEC_DP"]=Core[Name[1].."VV2_RAZGRSEC_DP"] end},
        ["VV2_SRDGZSEC_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Срабатывание дуговой защиты секции ",["eval"]= function(Name) Core[Name[2].."VV2_SRDGZSEC_DP"]=Core[Name[1].."VV2_SRDGZSEC_DP"] end},
        ["VV2_SRTZNPOTKSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Срабатывание ТЗНП В на отключение СВ ",["eval"]= function(Name) Core[Name[2].."VV2_SRTZNPOTKSV_DP"]=Core[Name[1].."VV2_SRTZNPOTKSV_DP"] end},
        ["VV2_SRTZNPOTKTR_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Срабатывание ТЗНП В на отключение тр-ра  ",["eval"]= function(Name) Core[Name[2].."VV2_SRTZNPOTKTR_DP"]=Core[Name[1].."VV2_SRTZNPOTKTR_DP"] end},
        ["VV2_SRTZNPOTKVV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Срабатывание ТЗНП на отключение ВВ ",["eval"]= function(Name) Core[Name[2].."VV2_SRTZNPOTKVV_DP"]=Core[Name[1].."VV2_SRTZNPOTKVV_DP"] end},
        ["VV2_SRZASHVV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Срабатывание защит ВВ ",["eval"]= function(Name) Core[Name[2].."VV2_SRZASHVV_DP"]=Core[Name[1].."VV2_SRZASHVV_DP"] end},
        ["VV2_VKLSVAVRSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Включение СВ по АВР СВ ",["eval"]= function(Name) Core[Name[2].."VV2_VKLSVAVRSV_DP"]=Core[Name[1].."VV2_VKLSVAVRSV_DP"] end},
        ["VV2_VKLVVVNRAVRAV1_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Включение ВВ при ВНР после АВР АВ1 ",["eval"]= function(Name) Core[Name[2].."VV2_VKLVVVNRAVRAV1_DP"]=Core[Name[1].."VV2_VKLVVVNRAVRAV1_DP"] end},
        ["VV2_VKLVVVNRAVRAV2_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Включение ВВ при ВНР после АВР АВ2 ",["eval"]= function(Name) Core[Name[2].."VV2_VKLVVVNRAVRAV2_DP"]=Core[Name[1].."VV2_VKLVVVNRAVRAV2_DP"] end},
        ["VV2_VKLVVVNRAVRSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Включение ВВ при ВНР после АВР СВ ",["eval"]= function(Name) Core[Name[2].."VV2_VKLVVVNRAVRSV_DP"]=Core[Name[1].."VV2_VKLVVVNRAVRSV_DP"] end},
        ["VV2_VOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Выключатель ввода отключен ",["eval"]= function(Name) Core[Name[2].."VV2_VOTK_DP"]=Core[Name[1].."VV2_VOTK_DP"] end},
        ["VV2_VVIK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Выключатель ввода выкачен ",["eval"]= function(Name) Core[Name[2].."VV2_VVIK_DP"]=Core[Name[1].."VV2_VVIK_DP"] end},
        ["VV2_VVKL_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ввод 2. Выключатель ввода включен ",["eval"]= function(Name) Core[Name[2].."VV2_VVKL_DP"]=Core[Name[1].."VV2_VVKL_DP"] end},
        ["SV_AVOTKSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Секционный выключатель. Аварийное отключение СВ ",["eval"]= function(Name) Core[Name[2].."SV_AVOTKSV_DP"]=Core[Name[1].."SV_AVOTKSV_DP"] end},
        ["SV_AVRSVOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Секционный выключатель. АВР СВ отключен ",["eval"]= function(Name) Core[Name[2].."SV_AVRSVOTK_DP"]=Core[Name[1].."SV_AVRSVOTK_DP"] end},
        ["SV_AVRSVVKL_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Секционный выключатель. АВР СВ включен ",["eval"]= function(Name) Core[Name[2].."SV_AVRSVVKL_DP"]=Core[Name[1].."SV_AVRSVVKL_DP"] end},
        ["SV_AVTVIKCUSVOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Секционный выключатель. Авт. выключатель цепей управления СВ откл. ",["eval"]= function(Name) Core[Name[2].."SV_AVTVIKCUSVOTK_DP"]=Core[Name[1].."SV_AVTVIKCUSVOTK_DP"] end},
        ["SV_NEISPCOV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_СВ_Неисправность цепей отключения СВ",["eval"]= function(Name) Core[Name[2].."SV_NEISPCOV_DP"]=Core[Name[1].."SV_NEISPCOV_DP"] end},
        ["SV_NEISPCVV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_СВ_Неисправность цепей включения СВ",["eval"]= function(Name) Core[Name[2].."SV_NEISPCVV_DP"]=Core[Name[1].."SV_NEISPCVV_DP"] end},
        ["SV_NEISPCONTRSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Секционный выключатель. Неисправность контроллера СВ ",["eval"]= function(Name) Core[Name[2].."SV_NEISPCONTRSV_DP"]=Core[Name[1].."SV_NEISPCONTRSV_DP"] end},
        ["SV_NEISPCUSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Секционный выключатель. Неисправность цепей управления СВ ",["eval"]= function(Name) Core[Name[2].."SV_NEISPCUSV_DP"]=Core[Name[1].."SV_NEISPCUSV_DP"] end},
        ["SV_OTKSVTZNPVVDGZ_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Секционный выключатель. Отключение СВ от ТЗНП вводов, ДГЗ ",["eval"]= function(Name) Core[Name[2].."SV_OTKSVTZNPVVDGZ_DP"]=Core[Name[1].."SV_OTKSVTZNPVVDGZ_DP"] end},
        ["SV_SRZASHSV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Секционный выключатель. Срабатывание защит СВ ",["eval"]= function(Name) Core[Name[2].."SV_SRZASHSV_DP"]=Core[Name[1].."SV_SRZASHSV_DP"] end},
        ["SV_SVOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Секционный выключатель. Секционный выключатель отключен ",["eval"]= function(Name) Core[Name[2].."SV_SVOTK_DP"]=Core[Name[1].."SV_SVOTK_DP"] end},
        ["SV_SVVIK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Секционный выключатель. Секционный выключатель выкачен ",["eval"]= function(Name) Core[Name[2].."SV_SVVIK_DP"]=Core[Name[1].."SV_SVVIK_DP"] end},
        ["SV_SVVKL_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Секционный выключатель. Секционный выключатель включен ",["eval"]= function(Name) Core[Name[2].."SV_SVVKL_DP"]=Core[Name[1].."SV_SVVKL_DP"] end},
        ["AV1_AVOTKVAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Аварийное отключение ВАВ ",["eval"]= function(Name) Core[Name[2].."AV1_AVOTKVAV_DP"]=Core[Name[1].."AV1_AVOTKVAV_DP"] end},
        ["AV1_AVRAVOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. АВР АВ отключен ",["eval"]= function(Name) Core[Name[2].."AV1_AVRAVOTK_DP"]=Core[Name[1].."AV1_AVRAVOTK_DP"] end},
        ["AV1_AVRAVVKL_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. АВР АВ включен ",["eval"]= function(Name) Core[Name[2].."AV1_AVRAVVKL_DP"]=Core[Name[1].."AV1_AVRAVVKL_DP"] end},
        ["AV1_AVTVIKCNAVOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Авт. выключатель цепей напряжения АВ откл. ",["eval"]= function(Name) Core[Name[2].."AV1_AVTVIKCNAVOTK_DP"]=Core[Name[1].."AV1_AVTVIKCNAVOTK_DP"] end},
        ["AV1_AVTVIKCUAVOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Авт. выключатель цепей управления АВ откл. ",["eval"]= function(Name) Core[Name[2].."AV1_AVTVIKCUAVOTK_DP"]=Core[Name[1].."AV1_AVTVIKCUAVOTK_DP"] end},
        ["AV1_NEISPADS_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Неисправность АДЭС ",["eval"]= function(Name) Core[Name[2].."AV1_NEISPADS_DP"]=Core[Name[1].."AV1_NEISPADS_DP"] end},
        ["AV1_NEISPCONTRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Неисправность контроллера АВ ",["eval"]= function(Name) Core[Name[2].."AV1_NEISPCONTRAV_DP"]=Core[Name[1].."AV1_NEISPCONTRAV_DP"] end},
        ["AV1_NEISPCUVAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Неисправность цепей управления ВАВ ",["eval"]= function(Name) Core[Name[2].."AV1_NEISPCUVAV_DP"]=Core[Name[1].."AV1_NEISPCUVAV_DP"] end},
        ["AV1_NEISPCUVG_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Неисправность цепей управления BГ ",["eval"]= function(Name) Core[Name[2].."AV1_NEISPCUVG_DP"]=Core[Name[1].."AV1_NEISPCUVG_DP"] end},
        ["AV1_NPADS_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Неуспешный пуск АДЭС ",["eval"]= function(Name) Core[Name[2].."AV1_NPADS_DP"]=Core[Name[1].."AV1_NPADS_DP"] end},
        ["AV1_OSTADSVNRAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Останов АДЭС при ВНР после АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV1_OSTADSVNRAVRAV_DP"]=Core[Name[1].."AV1_OSTADSVNRAVRAV_DP"] end},
        ["AV1_OTKSVAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Отключение СВ по АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV1_OTKSVAVRAV_DP"]=Core[Name[1].."AV1_OTKSVAVRAV_DP"] end},
        ["AV1_OTKSVVNRAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Отключение СВ при ВНР после АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV1_OTKSVVNRAVRAV_DP"]=Core[Name[1].."AV1_OTKSVVNRAVRAV_DP"] end},
        ["AV1_OTKVAVDGZ_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Отключение ВАВ от дуговой защиты ",["eval"]= function(Name) Core[Name[2].."AV1_OTKVAVDGZ_DP"]=Core[Name[1].."AV1_OTKVAVDGZ_DP"] end},
        ["AV1_OTKVAVVNR_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Отключение ВАВ при ВНР после АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV1_OTKVAVVNR_DP"]=Core[Name[1].."AV1_OTKVAVVNR_DP"] end},
        ["AV1_PADSAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Пуск АДЭС по АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV1_PADSAVRAV_DP"]=Core[Name[1].."AV1_PADSAVRAV_DP"] end},
        ["AV1_PEREGRADS_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Перегрузка АДЭС ",["eval"]= function(Name) Core[Name[2].."AV1_PEREGRADS_DP"]=Core[Name[1].."AV1_PEREGRADS_DP"] end},
        ["AV1_SRZASHVAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Срабатывание защит ВАВ ",["eval"]= function(Name) Core[Name[2].."AV1_SRZASHVAV_DP"]=Core[Name[1].."AV1_SRZASHVAV_DP"] end},
        ["AV1_VAVOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Выключатель аварийного ввода отключен ",["eval"]= function(Name) Core[Name[2].."AV1_VAVOTK_DP"]=Core[Name[1].."AV1_VAVOTK_DP"] end},
        ["AV1_VAVVIK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Выключатель аварийного ввода выкачен ",["eval"]= function(Name) Core[Name[2].."AV1_VAVVIK_DP"]=Core[Name[1].."AV1_VAVVIK_DP"] end},
        ["AV1_VAVVKL_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Выключатель аварийного ввода включен ",["eval"]= function(Name) Core[Name[2].."AV1_VAVVKL_DP"]=Core[Name[1].."AV1_VAVVKL_DP"] end},
        ["AV1_VGOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. ВГ отключен ",["eval"]= function(Name) Core[Name[2].."AV1_VGOTK_DP"]=Core[Name[1].."AV1_VGOTK_DP"] end},
        ["AV1_VGVKL_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. ВГ включен ",["eval"]= function(Name) Core[Name[2].."AV1_VGVKL_DP"]=Core[Name[1].."AV1_VGVKL_DP"] end},
        ["AV1_VKLSVAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Включение СВ по АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV1_VKLSVAVRAV_DP"]=Core[Name[1].."AV1_VKLSVAVRAV_DP"] end},
        ["AV1_VKLSVVNRAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Включение СВ при ВНР после АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV1_VKLSVVNRAVRAV_DP"]=Core[Name[1].."AV1_VKLSVVNRAVRAV_DP"] end},
        ["AV1_VKLVAVAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 1. Включение ВАВ по АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV1_VKLVAVAVRAV_DP"]=Core[Name[1].."AV1_VKLVAVAVRAV_DP"] end},
        ["AV1_NEISPCOV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ав. Ввод 1  Неисправность цепей отключения АВ1",["eval"]= function(Name) Core[Name[2].."AV1_NEISPCOV_DP"]=Core[Name[1].."AV1_NEISPCOV_DP"] end},
        ["AV1_NEISPCVV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ав. Ввод 1  Неисправность цепей включения АВ1",["eval"]= function(Name) Core[Name[2].."AV1_NEISPCVV_DP"]=Core[Name[1].."AV1_NEISPCVV_DP"] end},
        ["AV2_AVOTKVAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Аварийное отключение ВАВ ",["eval"]= function(Name) Core[Name[2].."AV2_AVOTKVAV_DP"]=Core[Name[1].."AV2_AVOTKVAV_DP"] end},
        ["AV2_AVRAVOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. АВР АВ отключен ",["eval"]= function(Name) Core[Name[2].."AV2_AVRAVOTK_DP"]=Core[Name[1].."AV2_AVRAVOTK_DP"] end},
        ["AV2_AVRAVVKL_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. АВР АВ включен ",["eval"]= function(Name) Core[Name[2].."AV2_AVRAVVKL_DP"]=Core[Name[1].."AV2_AVRAVVKL_DP"] end},
        ["AV2_AVTVIKCNAVOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Авт. выключатель цепей напряжения АВ откл. ",["eval"]= function(Name) Core[Name[2].."AV2_AVTVIKCNAVOTK_DP"]=Core[Name[1].."AV2_AVTVIKCNAVOTK_DP"] end},
        ["AV2_AVTVIKCUAVOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Авт. выключатель цепей управления АВ откл. ",["eval"]= function(Name) Core[Name[2].."AV2_AVTVIKCUAVOTK_DP"]=Core[Name[1].."AV2_AVTVIKCUAVOTK_DP"] end},
        ["AV2_NEISPADS_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Неисправность АДЭС ",["eval"]= function(Name) Core[Name[2].."AV2_NEISPADS_DP"]=Core[Name[1].."AV2_NEISPADS_DP"] end},
        ["AV2_NEISPCONTRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Неисправность контроллера АВ ",["eval"]= function(Name) Core[Name[2].."AV2_NEISPCONTRAV_DP"]=Core[Name[1].."AV2_NEISPCONTRAV_DP"] end},
        ["AV2_NEISPCUVAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Неисправность цепей управления ВАВ ",["eval"]= function(Name) Core[Name[2].."AV2_NEISPCUVAV_DP"]=Core[Name[1].."AV2_NEISPCUVAV_DP"] end},
        ["AV2_NEISPCUVG_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Неисправность цепей управления BГ ",["eval"]= function(Name) Core[Name[2].."AV2_NEISPCUVG_DP"]=Core[Name[1].."AV2_NEISPCUVG_DP"] end},
        ["AV2_NPADS_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Неуспешный пуск АДЭС ",["eval"]= function(Name) Core[Name[2].."AV2_NPADS_DP"]=Core[Name[1].."AV2_NPADS_DP"] end},
        ["AV2_OSTADSVNRAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Останов АДЭС при ВНР после АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV2_OSTADSVNRAVRAV_DP"]=Core[Name[1].."AV2_OSTADSVNRAVRAV_DP"] end},
        ["AV2_OTKSVAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Отключение СВ по АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV2_OTKSVAVRAV_DP"]=Core[Name[1].."AV2_OTKSVAVRAV_DP"] end},
        ["AV2_OTKSVVNRAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Отключение СВ при ВНР после АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV2_OTKSVVNRAVRAV_DP"]=Core[Name[1].."AV2_OTKSVVNRAVRAV_DP"] end},
        ["AV2_OTKVAVDGZ_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Отключение ВАВ от дуговой защиты ",["eval"]= function(Name) Core[Name[2].."AV2_OTKVAVDGZ_DP"]=Core[Name[1].."AV2_OTKVAVDGZ_DP"] end},
        ["AV2_OTKVAVVNR_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Отключение ВАВ при ВНР после АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV2_OTKVAVVNR_DP"]=Core[Name[1].."AV2_OTKVAVVNR_DP"] end},
        ["AV2_PADSAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Пуск АДЭС по АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV2_PADSAVRAV_DP"]=Core[Name[1].."AV2_PADSAVRAV_DP"] end},
        ["AV2_PEREGRADS_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Перегрузка АДЭС ",["eval"]= function(Name) Core[Name[2].."AV2_PEREGRADS_DP"]=Core[Name[1].."AV2_PEREGRADS_DP"] end},
        ["AV2_SRZASHVAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Срабатывание защит ВАВ ",["eval"]= function(Name) Core[Name[2].."AV2_SRZASHVAV_DP"]=Core[Name[1].."AV2_SRZASHVAV_DP"] end},
        ["AV2_VAVOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Выключатель аварийного ввода отключен ",["eval"]= function(Name) Core[Name[2].."AV2_VAVOTK_DP"]=Core[Name[1].."AV2_VAVOTK_DP"] end},
        ["AV2_VAVVIK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Выключатель аварийного ввода выкачен ",["eval"]= function(Name) Core[Name[2].."AV2_VAVVIK_DP"]=Core[Name[1].."AV2_VAVVIK_DP"] end},
        ["AV2_VAVVKL_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Выключатель аварийного ввода включен ",["eval"]= function(Name) Core[Name[2].."AV2_VAVVKL_DP"]=Core[Name[1].."AV2_VAVVKL_DP"] end},
        ["AV2_VGOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. ВГ отключен ",["eval"]= function(Name) Core[Name[2].."AV2_VGOTK_DP"]=Core[Name[1].."AV2_VGOTK_DP"] end},
        ["AV2_VGVKL_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. ВГ включен ",["eval"]= function(Name) Core[Name[2].."AV2_VGVKL_DP"]=Core[Name[1].."AV2_VGVKL_DP"] end},
        ["AV2_VKLSVAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Включение СВ по АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV2_VKLSVAVRAV_DP"]=Core[Name[1].."AV2_VKLSVAVRAV_DP"] end},
        ["AV2_VKLSVVNRAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Включение СВ при ВНР после АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV2_VKLSVVNRAVRAV_DP"]=Core[Name[1].."AV2_VKLSVVNRAVRAV_DP"] end},
        ["AV2_VKLVAVAVRAV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Аварийный ввод 2. Включение ВАВ по АВР АВ ",["eval"]= function(Name) Core[Name[2].."AV2_VKLVAVAVRAV_DP"]=Core[Name[1].."AV2_VKLVAVAVRAV_DP"] end},
        ["AV2_NEISPCOV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ав. Ввод 2  Неисправность цепей отключения АВ2",["eval"]= function(Name) Core[Name[2].."AV2_NEISPCOV_DP"]=Core[Name[1].."AV2_NEISPCOV_DP"] end},
        ["AV2_NEISPCVV_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Ав. Ввод 2  Неисправность цепей включения АВ2",["eval"]= function(Name) Core[Name[2].."AV2_NEISPCVV_DP"]=Core[Name[1].."AV2_NEISPCVV_DP"] end},
        ["PU_DURAZR_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_ ДУ Разрешено",["eval"]= function(Name) Core[Name[2].."PU_DURAZR_DP"]=Core[Name[1].."PU_DURAZR_DP"] end},
        ["PU_SRAVTKTP_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Срабатывание автоматики КТП ",["eval"]= function(Name) Core[Name[2].."PU_SRAVTKTP_DP"]=Core[Name[1].."PU_SRAVTKTP_DP"] end},
        ["PU_NEISKTP_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Неисправность КТП",["eval"]= function(Name) Core[Name[2].."PU_NEISKTP_DP"]=Core[Name[1].."PU_NEISKTP_DP"] end},
        ["PU_AVARKTP_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Авария КТП",["eval"]= function(Name) Core[Name[2].."PU_AVARKTP_DP"]=Core[Name[1].."PU_AVARKTP_DP"] end},
        ["PU_NEISPDGZ_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Неисправность ДГЗ",["eval"]= function(Name) Core[Name[2].."PU_NEISPDGZ_DP"]=Core[Name[1].."PU_NEISPDGZ_DP"] end},
        ["PU_NEISPCONTRPU_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Неисправность контроллера ПУ",["eval"]= function(Name) Core[Name[2].."PU_NEISPCONTRPU_DP"]=Core[Name[1].."PU_NEISPCONTRPU_DP"] end},
        ["PU_AVTVIKCSIGOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_Авт. Выключатель цепей сигнализации откл.",["eval"]= function(Name) Core[Name[2].."PU_AVTVIKCSIGOTK_DP"]=Core[Name[1].."PU_AVTVIKCSIGOTK_DP"] end},
        ["PU_AVTVIKCOBOTK_DP"]= {["Comment"]="АСУ ЭС_КТП 10/0,4 кВ_Панель №5_авт. Выключатель цепей обогрева откл.",["eval"]= function(Name) Core[Name[2].."PU_AVTVIKCOBOTK_DP"]=Core[Name[1].."PU_AVTVIKCOBOTK_DP"] end},
 
        

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