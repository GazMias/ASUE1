local counter=0
local FR=90 -- адрес первого регистра данных DI
local LR=99 -- адрес последнего регистра данных DI
local oldsignal = {} -- буферная таблица  предыдущего значения входов
local oldstack = {} -- буферная таблица  предыдущего значения сигналов
local stack_error -- флаг ошибки стека
local old_stack_error -- предыдущее значение флага ошибки стека
--local user=Core["USER_NAME_OUT"] -- текущее имя  пользователя
local user=""
--local user="USER_:)" --текущий пользователь тестовый
local sig_source="АСУ ЭС, КТП 10/0,4 кВ, Панель №6 " --описание источника сигналов

event ={  --таблица типов событий
		a=10000 , --аварии
		w=10100, --предупреждения
		s=101,  --телесигнализация
		c=100, --команды
		}

local BitMap ={  -- таблица адресов переменных дискретных входов 
			--ввод1
					["90.0"]="VV1_VVKL",
					["90.1"]="VV1_VOTK",
					["90.2"]="VV1_VVIK",
					["90.3"]="VV1_OTKVVAVRSV",
					["90.4"]="VV1_VKLSVAVRSV",
					["90.5"]="VV1_OTKVVAVRAV1",
					["90.6"]="VV1_OTKVVAVRAV2",
					["90.7"]="VV1_AVOTKVV",
					["90.8"]="VV1_OTKSVVNRAVRSV",
					["90.9"]="VV1_VKLVVVNRAVRSV",
					["90.10"]="VV1_VKLVVVNRAVRAV1",
					["90.11"]="VV1_VKLVVVNRAVRAV2",
					["90.12"]="VV1_SRTZNPOTKSV",
					["90.13"]="VV1_SRTZNPOTKVV",
					["90.14"]="VV1_SRTZNPOTKTR",
					["90.15"]="VV1_PRTEMTROTK",
					["91.0"]="VV1_SRZASHVV",
					["91.1"]="VV1_OTKVVNTRZASH",
					["91.2"]="VV1_OTKVVDGZ",
					["91.3"]="VV1_PRTEMTRSIG",
					["91.4"]="VV1_AVTVIKCNOTK",
					["91.5"]="VV1_AVTVIKCUOTK",
					["91.6"]="VV1_NEISPCUV",
					["91.7"]="VV1_COMOTKVVPU",
					["91.8"]="VV1_COMVKLVVPU",
					["91.9"]="VV1_SRDGZSEC",
					["91.10"]="VV1_AVTVIKCUOLSECOTK",
					["91.11"]="VV1_AVOTKUVN",
					["91.12"]="VV1_AVOTKOLSEC",
					["91.13"]="VV1_RAZGRSEC",
		 			["91.14"]="VV1_NEISPCONTRV",
			 --ввод2
                    ["92.0"]="VV2_VVKL",
                    ["92.1"]="VV2_VOTK",
                    ["92.2"]="VV2_VVIK",
                    ["92.3"]="VV2_OTKVVAVRSV",
                    ["92.4"]="VV2_VKLSVAVRSV",
                    ["92.5"]="VV2_OTKVVAVRAV1",
                    ["92.6"]="VV2_OTKVVAVRAV2",
                    ["92.7"]="VV2_AVOTKVV",
                    ["92.8"]="VV2_OTKSVVNRAVRSV",
                    ["92.9"]="VV2_VKLVVVNRAVRSV",
                    ["92.10"]="VV2_VKLVVVNRAVRAV1",
                    ["92.11"]="VV2_VKLVVVNRAVRAV2",
                    ["92.12"]="VV2_SRTZNPOTKSV",
                    ["92.13"]="VV2_SRTZNPOTKVV",
                    ["92.14"]="VV2_SRTZNPOTKTR",
                    ["92.15"]="VV2_PRTEMTROTK",
                    ["93.0"]="VV2_SRZASHVV",
                    ["93.1"]="VV2_OTKVVNTRZASH",
                    ["93.2"]="VV2_OTKVVDGZ",
                    ["93.3"]="VV2_PRTEMTRSIG",
                    ["93.4"]="VV2_AVTVIKCNOTK",
                    ["93.5"]="VV2_AVTVIKCUOTK",
                    ["93.6"]="VV2_NEISPCUV",
                    ["93.7"]="VV2_COMOTKVVPU",
                    ["93.8"]="VV2_COMVKLVVPU",
                    ["93.9"]="VV2_SRDGZSEC",
                    ["93.10"]="VV2_AVTVIKCUOLSECOTK",
                    ["93.11"]="VV2_AVOTKUVN",
                    ["93.12"]="VV2_AVOTKOLSEC",
                    ["93.13"]="VV2_RAZGRSEC",
                    ["93.14"]="VV2_NEISPCONTRV",
			 --СВ
                    ["94.0"]="SV_SVVKL",
                    ["94.1"]="SV_SVOTK",
                    ["94.2"]="SV_SVVIK",
                    ["94.3"]="SV_AVRSVVKL",
                    ["94.4"]="SV_AVRSVOTK",
                    ["94.5"]="SV_AVOTKSV",
                    ["94.6"]="SV_SRZASHSV",
                    ["94.7"]="SV_OTKSVTZNPVVDGZ",
                    ["94.8"]="SV_AVTVIKCUSVOTK",
                    ["94.9"]="SV_NEISPCUSV",
                    ["94.10"]="SV_AVRSVVKLPU",
                    ["94.11"]="SV_AVRSVOTKPU",
                    ["94.12"]="SV_NEISPCONTRSV",
                    ["94.13"]="SV_COMOTKSVPU",
                    ["94.14"]="SV_COMVKLSVPU",
				--АВ1
                    ["96.0"]="AV1_VAVVKL",
                    ["96.1"]="AV1_VAVOTK",
                    ["96.2"]="AV1_VAVVIK",
                    ["96.3"]="AV1_VGVKL",
                    ["96.4"]="AV1_VGOTK",
                    ["96.5"]="AV1_AVRAVVKL",
                    ["96.6"]="AV1_AVRAVOTK",
                    ["96.7"]="AV1_OTKSVAVRAV",
                    ["96.8"]="AV1_VKLSVVNRAVRAV",
                    ["96.9"]="AV1_VKLSVAVRAV",
                    ["96.10"]="AV1_PADSAVRAV",
                    ["96.11"]="AV1_VKLVAVAVRAV",
                    ["96.12"]="AV1_OTKVAVVNR",
                    ["96.13"]="AV1_OTKSVVNRAVRAV",
                    ["96.14"]="AV1_OSTADSVNRAVRAV",
                    ["96.15"]="AV1_NPADS",
                    ["97.0"]="AV1_AVOTKVAV",
                    ["97.1"]="AV1_OTKVAVDGZ",
                    ["97.2"]="AV1_SRZASHVAV",
                    ["97.3"]="AV1_NEISPADS",
                    ["97.4"]="AV1_PEREGRADS",
                    ["97.5"]="AV1_AVTVIKCNAVOTK",
                    ["97.6"]="AV1_AVTVIKCUAVOTK",
                    ["97.7"]="AV1_NEISPCUVG",
                    ["97.8"]="AV1_NEISPCUVAV",
                    ["97.9"]="AV1_AVRAVVKLPU",
                    ["97.10"]="AV1_AVRAVOTKPU",
                    ["97.11"]="AV1_NEISPCONTRAV",
                    ["97.12"]="AV1_COMOTKVAVPU",
                    ["97.13"]="AV1_COMVKLVAVPU",
				--АВ2
                    ["98.0"]="AV2_VAVVKL",
                    ["98.1"]="AV2_VAVOTK",
                    ["98.2"]="AV2_VAVVIK",
                    ["98.3"]="AV2_VGVKL",
                    ["98.4"]="AV2_VGOTK",
                    ["98.5"]="AV2_AVRAVVKL",
                    ["98.6"]="AV2_AVRAVOTK",
                    ["98.7"]="AV2_OTKSVAVRAV",
                    ["98.8"]="AV2_VKLSVVNRAVRAV",
                    ["98.9"]="AV2_VKLSVAVRAV",
                    ["98.10"]="AV2_PADSAVRAV",
                    ["98.11"]="AV2_VKLVAVAVRAV",
                    ["98.12"]="AV2_OTKVAVVNR",
                    ["98.13"]="AV2_OTKSVVNRAVRAV",
                    ["98.14"]="AV2_OSTADSVNRAVRAV",
                    ["98.15"]="AV2_NPADS",
                    ["99.0"]="AV2_AVOTKVAV",
                    ["99.1"]="AV2_OTKVAVDGZ",
                    ["99.2"]="AV2_SRZASHVAV",
                    ["99.3"]="AV2_NEISPADS",
                    ["99.4"]="AV2_PEREGRADS",
                    ["99.5"]="AV2_AVTVIKCNAVOTK",
                    ["99.6"]="AV2_AVTVIKCUAVOTK",
                    ["99.7"]="AV2_NEISPCUVG",
                    ["99.8"]="AV2_NEISPCUVAV",
                    ["99.9"]="AV2_AVRAVVKLPU",
                    ["99.10"]="AV2_AVRAVOTKPU",
                    ["99.11"]="AV2_NEISPCONTRAV",
                    ["99.12"]="AV2_COMOTKVAVPU",
                    ["99.13"]="AV2_COMVKLVAVPU",
				--ПУ
					["95.0"]="PU_DURAZR",
                    ["95.1"]="PU_SRAVTKTP",
                    ["95.2"]="PU_NEISKTP",
                    ["95.3"]="PU_AVARKTP",
                    ["95.4"]="PU_NEISPDGZ",
                    ["95.5"]="PU_NEISPCONTRPU",
                    ["95.6"]="PU_AVTVIKCSIGOTK",
                    ["95.7"]="PU_AVTVIKCOBOTK",
                    ["95.8"]="PU_CLOCKERR",
                    ["95.9"]="PU_NTPERR",
                    ["95.10"]="PU_PURESET",
					 }	

local event_class= {  --таблица классов тревог для сигналов
				--Ввод 1
                  VV1_VVKL=event.s,
                  VV1_VOTK=event.s,
                  VV1_VVIK=event.s,
                  VV1_OTKVVAVRSV=event.w,
                  VV1_VKLSVAVRSV=event.w,
                  VV1_OTKVVAVRAV1=event.w,
                  VV1_OTKVVAVRAV2=event.w,
                  VV1_AVOTKVV=event.a,
                  VV1_OTKSVVNRAVRSV=event.w,
                  VV1_VKLVVVNRAVRSV=event.w,
                  VV1_VKLVVVNRAVRAV1=event.w,
                  VV1_VKLVVVNRAVRAV2=event.w,
                  VV1_SRTZNPOTKSV=event.a,
                  VV1_SRTZNPOTKVV=event.a,
                  VV1_SRTZNPOTKTR=event.a,
                  VV1_PRTEMTROTK=event.a,
                  VV1_SRZASHVV=event.a,
                  VV1_OTKVVNTRZASH=event.a,
                  VV1_OTKVVDGZ=event.a,
                  VV1_PRTEMTRSIG=event.w,
                  VV1_AVTVIKCNOTK=event.w,
                  VV1_AVTVIKCUOTK=event.w,
                  VV1_NEISPCUV=event.w,
                  VV1_COMOTKVVPU=event.s,
                  VV1_COMVKLVVPU=event.s,
                  VV1_SRDGZSEC=event.a,
                  VV1_AVTVIKCUOLSECOTK=event.w,
                  VV1_AVOTKUVN=event.a,
                  VV1_AVOTKOLSEC=event.a,
                  VV1_RAZGRSEC=event.a,
                  VV1_NEISPCONTRV=event.w,
				--Ввод 2
                  VV2_VVKL=event.s,
                  VV2_VOTK=event.s,
                  VV2_VVIK=event.s,
                  VV2_OTKVVAVRSV=event.w,
                  VV2_VKLSVAVRSV=event.w,
                  VV2_OTKVVAVRAV1=event.w,
                  VV2_OTKVVAVRAV2=event.w,
                  VV2_AVOTKVV=event.a,
                  VV2_OTKSVVNRAVRSV=event.w,
                  VV2_VKLVVVNRAVRSV=event.w,
                  VV2_VKLVVVNRAVRAV1=event.w,
                  VV2_VKLVVVNRAVRAV2=event.w,
                  VV2_SRTZNPOTKSV=event.a,
                  VV2_SRTZNPOTKVV=event.a,
                  VV2_SRTZNPOTKTR=event.a,
                  VV2_PRTEMTROTK=event.a,
                  VV2_SRZASHVV=event.a,
                  VV2_OTKVVNTRZASH=event.a,
                  VV2_OTKVVDGZ=event.a,
                  VV2_PRTEMTRSIG=event.w,
                  VV2_AVTVIKCNOTK=event.w,
                  VV2_AVTVIKCUOTK=event.w,
                  VV2_NEISPCUV=event.w,
                  VV2_COMOTKVVPU=event.s,
                  VV2_COMVKLVVPU=event.s,
                  VV2_SRDGZSEC=event.a,
                  VV2_AVTVIKCUOLSECOTK=event.w,
                  VV2_AVOTKUVN=event.a,
                  VV2_AVOTKOLSEC=event.a,
                  VV2_RAZGRSEC=event.a,
                  VV2_NEISPCONTRV=event.w,
				--СВ
                  SV_SVVKL=event.s,
                  SV_SVOTK=event.s,
                  SV_SVVIK=event.s,
                  SV_AVRSVVKL=event.s,
                  SV_AVRSVOTK=event.s,
                  SV_AVOTKSV=event.a,
                  SV_SRZASHSV=event.w,
                  SV_OTKSVTZNPVVDGZ=event.a,
                  SV_AVTVIKCUSVOTK=event.w,
                  SV_NEISPCUSV=event.w,
                  SV_AVRSVVKLPU=event.s,
                  SV_AVRSVOTKPU=event.s,
                  SV_NEISPCONTRSV=event.w,
                  SV_COMOTKSVPU=event.s,
                  SV_COMVKLSVPU=event.s,
				--АВ1
                  AV1_VAVVKL=event.s,
                  AV1_VAVOTK=event.s,
                  AV1_VAVVIK=event.s,
                  AV1_VGVKL=event.s,
                  AV1_VGOTK=event.a,
                  AV1_AVRAVVKL=event.s,
                  AV1_AVRAVOTK=event.s,
                  AV1_OTKSVAVRAV=event.w,
                  AV1_VKLSVVNRAVRAV=event.w,
                  AV1_VKLSVAVRAV=event.w,
                  AV1_PADSAVRAV=event.w,
                  AV1_VKLVAVAVRAV=event.w,
                  AV1_OTKVAVVNR=event.w,
                  AV1_OTKSVVNRAVRAV=event.w,
                  AV1_OSTADSVNRAVRAV=event.w,
                  AV1_NPADS=event.a,
                  AV1_AVOTKVAV=event.a,
                  AV1_OTKVAVDGZ=event.a,
                  AV1_SRZASHVAV=event.a,
                  AV1_NEISPADS=event.w,
                  AV1_PEREGRADS=event.w,
                  AV1_AVTVIKCNAVOTK=event.w,
                  AV1_AVTVIKCUAVOTK=event.w,
                  AV1_NEISPCUVG=event.w,
                  AV1_NEISPCUVAV=event.w,
                  AV1_AVRAVVKLPU=event.s,
                  AV1_AVRAVOTKPU=event.s,
                  AV1_NEISPCONTRAV=event.w,
                  AV1_COMOTKVAVPU=event.s,
                  AV1_COMVKLVAVPU=event.s,
				--АВ2
                  AV2_VAVVKL=event.s,
                  AV2_VAVOTK=event.s,
                  AV2_VAVVIK=event.s,
                  AV2_VGVKL=event.s,
                  AV2_VGOTK=event.a,
                  AV2_AVRAVVKL=event.s,
                  AV2_AVRAVOTK=event.s,
                  AV2_OTKSVAVRAV=event.w,
                  AV2_VKLSVVNRAVRAV=event.w,
                  AV2_VKLSVAVRAV=event.w,
                  AV2_PADSAVRAV=event.w,
                  AV2_VKLVAVAVRAV=event.w,
                  AV2_OTKVAVVNR=event.w,
                  AV2_OTKSVVNRAVRAV=event.w,
                  AV2_OSTADSVNRAVRAV=event.w,
                  AV2_NPADS=event.a,
                  AV2_AVOTKVAV=event.a,
                  AV2_OTKVAVDGZ=event.a,
                  AV2_SRZASHVAV=event.a,
                  AV2_NEISPADS=event.w,
                  AV2_PEREGRADS=event.w,
                  AV2_AVTVIKCNAVOTK=event.w,
                  AV2_AVTVIKCUAVOTK=event.w,
                  AV2_NEISPCUVG=event.w,
                  AV2_NEISPCUVAV=event.w,
                  AV2_AVRAVVKLPU=event.s,
                  AV2_AVRAVOTKPU=event.s,
                  AV2_NEISPCONTRAV=event.w,
                  AV2_COMOTKVAVPU=event.s,
                  AV2_COMVKLVAVPU=event.s,
				--ПУ
                  PU_DURAZR=event.s,
                  PU_SRAVTKTP=event.w,
                  PU_NEISKTP=event.w,
                  PU_AVARKTP=event.a,
                  PU_NEISPDGZ=event.w,
                  PU_NEISPCONTRPU=event.w,
                  PU_AVTVIKCSIGOTK=event.w,
                  PU_AVTVIKCOBOTK=event.w,
                  PU_CLOCKERR=event.w,
                  PU_NTPERR=event.w,
                  PU_PURESET=event.s,
				}


local msg= { --таблица системных сообщений
			--стек
			stack_err ="Ошибка стека событий ПЛК(переполнение) ",
			--ввод №1
			VV1_AVOTKOLSEC="Ввод 1. Аварийное отключение ОЛ секции ",
			VV1_AVOTKUVN="Ввод 1. Аварийное отключение УВН ",
			VV1_AVOTKVV="Ввод 1. Аварийное отключение ВВ ",
			VV1_AVTVIKCNOTK="Ввод 1. Авт. выключатели цепей напряжения В откл. ",
			VV1_AVTVIKCUOLSECOTK="Ввод 1. Авт. выкл. цепей управления ОЛ секции откл. ",
			VV1_AVTVIKCUOTK="Ввод 1. Авт. выключатель цепей управления В откл. ",
			VV1_COMOTKVVPU="Ввод 1. Команда на отключение ВВ поступила с ПУ ",
			VV1_COMVKLVVPU="Ввод 1. Команда на включение ВВ поступила с ПУ ",
			VV1_NEISPCONTRV="Ввод 1. Неисправность контроллера В ",
			VV1_NEISPCUV="Ввод 1. Неисправность цепей управления B ",
			VV1_OTKSVVNRAVRSV="Ввод 1. Отключение СВ при ВНР после АВР СВ ",
			VV1_OTKVVAVRAV1="Ввод 1. Отключение ВВ по АВР АВ1 ",
			VV1_OTKVVAVRAV2="Ввод 1. Отключение ВВ по АВР АВ2 ",
			VV1_OTKVVAVRSV="Ввод 1. Отключение ВВ по АВР СВ ",
			VV1_OTKVVDGZ="Ввод 1. Отключение ВВ от дуговой защиты ",
			VV1_OTKVVNTRZASH="Ввод 1. Отключение выкл. ВН тр-ра от защит ",
			VV1_PRTEMTROTK="Ввод 1. Превышение температуры тр-ра  на откл. ",
			VV1_PRTEMTRSIG="Ввод 1. Превышение температуры тр-ра на сигн. ",
			VV1_RAZGRSEC="Ввод 1. Разгрузка секции ",
			VV1_SRDGZSEC="Ввод 1. Срабатывание дуговой защиты секции ",
			VV1_SRTZNPOTKSV="Ввод 1. Срабатывание ТЗНП В на отключение СВ ",
			VV1_SRTZNPOTKTR="Ввод 1. Срабатывание ТЗНП В на отключение тр-ра  ",
			VV1_SRTZNPOTKVV="Ввод 1. Срабатывание ТЗНП на отключение ВВ ",
			VV1_SRZASHVV="Ввод 1. Срабатывание защит ВВ ",
			VV1_VKLSVAVRSV="Ввод 1. Включение СВ по АВР СВ ",
			VV1_VKLVVVNRAVRAV1="Ввод 1. Включение ВВ при ВНР после АВР АВ1 ",
			VV1_VKLVVVNRAVRAV2="Ввод 1. Включение ВВ при ВНР после АВР АВ2 ",
			VV1_VKLVVVNRAVRSV="Ввод 1. Включение ВВ при ВНР после АВР СВ ",
			VV1_VOTK="Ввод 1. Выключатель ввода отключен ",
			VV1_VVIK="Ввод 1. Выключатель ввода выкачен ",
			VV1_VVKL="Ввод 1. Выключатель ввода включен ",
			--ввод №2
			VV2_AVOTKOLSEC="Ввод 2. Аварийное отключение ОЛ секции ",
			VV2_AVOTKUVN="Ввод 2. Аварийное отключение УВН ",
			VV2_AVOTKVV="Ввод 2. Аварийное отключение ВВ ",
			VV2_AVTVIKCNOTK="Ввод 2. Авт. выключатели цепей напряжения В откл. ",
			VV2_AVTVIKCUOLSECOTK="Ввод 2. Авт. выкл. цепей управления ОЛ секции откл. ",
			VV2_AVTVIKCUOTK="Ввод 2. Авт. выключатель цепей управления В откл. ",
			VV2_COMOTKVVPU="Ввод 2. Команда на отключение ВВ поступила с ПУ ",
			VV2_COMVKLVVPU="Ввод 2. Команда на включение ВВ поступила с ПУ ",
			VV2_NEISPCONTRV="Ввод 2. Неисправность контроллера В ",
			VV2_NEISPCUV="Ввод 2. Неисправность цепей управления B ",
			VV2_OTKSVVNRAVRSV="Ввод 2. Отключение СВ при ВНР после АВР СВ ",
			VV2_OTKVVAVRAV1="Ввод 2. Отключение ВВ по АВР АВ1 ",
			VV2_OTKVVAVRAV2="Ввод 2. Отключение ВВ по АВР АВ2 ",
			VV2_OTKVVAVRSV="Ввод 2. Отключение ВВ по АВР СВ ",
			VV2_OTKVVDGZ="Ввод 2. Отключение ВВ от дуговой защиты ",
			VV2_OTKVVNTRZASH="Ввод 2. Отключение выкл. ВН тр-ра от защит ",
			VV2_PRTEMTROTK="Ввод 2. Превышение температуры тр-ра  на откл. ",
			VV2_PRTEMTRSIG="Ввод 2. Превышение температуры тр-ра на сигн. ",
			VV2_RAZGRSEC="Ввод 2. Разгрузка секции ",
			VV2_SRDGZSEC="Ввод 2. Срабатывание дуговой защиты секции ",
			VV2_SRTZNPOTKSV="Ввод 2. Срабатывание ТЗНП В на отключение СВ ",
			VV2_SRTZNPOTKTR="Ввод 2. Срабатывание ТЗНП В на отключение тр-ра  ",
			VV2_SRTZNPOTKVV="Ввод 2. Срабатывание ТЗНП на отключение ВВ ",
			VV2_SRZASHVV="Ввод 2. Срабатывание защит ВВ ",
			VV2_VKLSVAVRSV="Ввод 2. Включение СВ по АВР СВ ",
			VV2_VKLVVVNRAVRAV1="Ввод 2. Включение ВВ при ВНР после АВР АВ1 ",
			VV2_VKLVVVNRAVRAV2="Ввод 2. Включение ВВ при ВНР после АВР АВ2 ",
			VV2_VKLVVVNRAVRSV="Ввод 2. Включение ВВ при ВНР после АВР СВ ",
			VV2_VOTK="Ввод 2. Выключатель ввода отключен ",
			VV2_VVIK="Ввод 2. Выключатель ввода выкачен ",
			VV2_VVKL="Ввод 2. Выключатель ввода включен ",
			-- СВ
			SV_SVVKL="Секционный выключатель. Секционный выключатель включен ",
			SV_SVOTK="Секционный выключатель. Секционный выключатель отключен ",
			SV_SVVIK="Секционный выключатель. Секционный выключатель выкачен ",
			SV_AVRSVVKL="Секционный выключатель. АВР СВ включен ",
			SV_AVRSVOTK="Секционный выключатель. АВР СВ отключен ",
			SV_AVOTKSV="Секционный выключатель. Аварийное отключение СВ ",
			SV_SRZASHSV="Секционный выключатель. Срабатывание защит СВ ",
			SV_OTKSVTZNPVVDGZ="Секционный выключатель. Отключение СВ от ТЗНП вводов, ДГЗ ",
			SV_AVTVIKCUSVOTK="Секционный выключатель. Авт. выключатель цепей управления СВ откл. ",
			SV_NEISPCUSV="Секционный выключатель. Неисправность цепей управления СВ ",
			SV_AVRSVVKLPU="Секционный выключатель. АВР СВ включено с ПУ ",
			SV_AVRSVOTKPU="Секционный выключатель. АВР СВ отключено с ПУ ",
			SV_NEISPCONTRSV="Секционный выключатель. Неисправность контроллера СВ ",
			SV_COMOTKSVPU="Секционный выключатель. Команда отключить СВ поступила с ПУ ",
			SV_COMVKLSVPU="Секционный выключатель. Команда включить СВ поступила с ПУ ",
			--АВ1
			AV1_VAVVKL="Аварийный ввод 1. Выключатель аварийного ввода включен ",
			AV1_VAVOTK="Аварийный ввод 1. Выключатель аварийного ввода отключен ",
			AV1_VAVVIK="Аварийный ввод 1. Выключатель аварийного ввода выкачен ",
			AV1_VGVKL="Аварийный ввод 1. ВГ включен ",
			AV1_VGOTK="Аварийный ввод 1. ВГ отключен ",
			AV1_AVRAVVKL="Аварийный ввод 1. АВР АВ включен ",
			AV1_AVRAVOTK="Аварийный ввод 1. АВР АВ отключен ",
			AV1_OTKSVAVRAV="Аварийный ввод 1. Отключение СВ по АВР АВ ",
			AV1_VKLSVVNRAVRAV="Аварийный ввод 1. Включение СВ при ВНР после АВР АВ ",
			AV1_VKLSVAVRAV="Аварийный ввод 1. Включение СВ по АВР АВ ",
			AV1_PADSAVRAV="Аварийный ввод 1. Пуск АДЭС по АВР АВ ",
			AV1_VKLVAVAVRAV="Аварийный ввод 1. Включение ВАВ по АВР АВ ",
			AV1_OTKVAVVNR="Аварийный ввод 1. Отключение ВАВ при ВНР после АВР АВ ",
			AV1_OTKSVVNRAVRAV="Аварийный ввод 1. Отключение СВ при ВНР после АВР АВ ",
			AV1_OSTADSVNRAVRAV="Аварийный ввод 1. Останов АДЭС при ВНР после АВР АВ ",
			AV1_NPADS="Аварийный ввод 1. Неуспешный пуск АДЭС ",
			AV1_AVOTKVAV="Аварийный ввод 1. Аварийное отключение ВАВ ",
			AV1_OTKVAVDGZ="Аварийный ввод 1. Отключение ВАВ от дуговой защиты ",
			AV1_SRZASHVAV="Аварийный ввод 1. Срабатывание защит ВАВ ",
			AV1_NEISPADS="Аварийный ввод 1. Неисправность АДЭС ",
			AV1_PEREGRADS="Аварийный ввод 1. Перегрузка АДЭС ",
			AV1_AVTVIKCNAVOTK="Аварийный ввод 1. Авт. выключатель цепей напряжения АВ откл. ",
			AV1_AVTVIKCUAVOTK="Аварийный ввод 1. Авт. выключатель цепей управления АВ откл. ",
			AV1_NEISPCUVG="Аварийный ввод 1. Неисправность цепей управления BГ ",
			AV1_NEISPCUVAV="Аварийный ввод 1. Неисправность цепей управления ВАВ ",
			AV1_AVRAVVKLPU="Аварийный ввод 1. АВР АВ включено с ПУ ",
			AV1_AVRAVOTKPU="Аварийный ввод 1. АВР АВ отключено с ПУ ",
			AV1_NEISPCONTRAV="Аварийный ввод 1. Неисправность контроллера АВ ",
			AV1_COMOTKVAVPU="Аварийный ввод 1. Команда отключить ВАВ поступила с ПУ ",
			AV1_COMVKLVAVPU="Аварийный ввод 1. Команда включить ВАВ поступила с ПУ ",
			--АВ2
			AV2_VAVVKL="Аварийный ввод 2. Выключатель аварийного ввода включен ",
			AV2_VAVOTK="Аварийный ввод 2. Выключатель аварийного ввода отключен ",
			AV2_VAVVIK="Аварийный ввод 2. Выключатель аварийного ввода выкачен ",
			AV2_VGVKL="Аварийный ввод 2. ВГ включен ",
			AV2_VGOTK="Аварийный ввод 2. ВГ отключен ",
			AV2_AVRAVVKL="Аварийный ввод 2. АВР АВ включен ",
			AV2_AVRAVOTK="Аварийный ввод 2. АВР АВ отключен ",
			AV2_OTKSVAVRAV="Аварийный ввод 2. Отключение СВ по АВР АВ ",
			AV2_VKLSVVNRAVRAV="Аварийный ввод 2. Включение СВ при ВНР после АВР АВ ",
			AV2_VKLSVAVRAV="Аварийный ввод 2. Включение СВ по АВР АВ ",
			AV2_PADSAVRAV="Аварийный ввод 2. Пуск АДЭС по АВР АВ ",
			AV2_VKLVAVAVRAV="Аварийный ввод 2. Включение ВАВ по АВР АВ ",
			AV2_OTKVAVVNR="Аварийный ввод 2. Отключение ВАВ при ВНР после АВР АВ ",
			AV2_OTKSVVNRAVRAV="Аварийный ввод 2. Отключение СВ при ВНР после АВР АВ ",
			AV2_OSTADSVNRAVRAV="Аварийный ввод 2. Останов АДЭС при ВНР после АВР АВ ",
			AV2_NPADS="Аварийный ввод 2. Неуспешный пуск АДЭС ",
			AV2_AVOTKVAV="Аварийный ввод 2. Аварийное отключение ВАВ ",
			AV2_OTKVAVDGZ="Аварийный ввод 2. Отключение ВАВ от дуговой защиты ",
			AV2_SRZASHVAV="Аварийный ввод 2. Срабатывание защит ВАВ ",
			AV2_NEISPADS="Аварийный ввод 2. Неисправность АДЭС ",
			AV2_PEREGRADS="Аварийный ввод 2. Перегрузка АДЭС ",
			AV2_AVTVIKCNAVOTK="Аварийный ввод 2. Авт. выключатель цепей напряжения АВ откл. ",
			AV2_AVTVIKCUAVOTK="Аварийный ввод 2. Авт. выключатель цепей управления АВ откл. ",
			AV2_NEISPCUVG="Аварийный ввод 2. Неисправность цепей управления BГ ",
			AV2_NEISPCUVAV="Аварийный ввод 2. Неисправность цепей управления ВАВ ",
			AV2_AVRAVVKLPU="Аварийный ввод 2. АВР АВ включено с ПУ ",
			AV2_AVRAVOTKPU="Аварийный ввод 2. АВР АВ отключено с ПУ ",
			AV2_NEISPCONTRAV="Аварийный ввод 2. Неисправность контроллера АВ ",
			AV2_COMOTKVAVPU="Аварийный ввод 2. Команда отключить ВАВ поступила с ПУ ",
			AV2_COMVKLVAVPU="Аварийный ввод 2. Команда включить ВАВ поступила с ПУ ",
			--ПУ
			PU_DURAZR=" ДУ Разрешено",
			PU_SRAVTKTP="Срабатывание автоматики КТП ",
			PU_NEISKTP="Неисправность КТП",
			PU_AVARKTP="Авария КТП",
			PU_NEISPDGZ="Неисправность ДГЗ",
			PU_NEISPCONTRPU="Неисправность контроллера ПУ",
			PU_AVTVIKCSIGOTK="Авт. Выключатель цепей сигнализации откл.",
			PU_AVTVIKCOBOTK="авт. Выключатель цепей обогрева откл.",
			PU_CLOCKERR="Ошибка часов ЦПЛК",
			PU_NTPERR="Ошибка получения времени NTP",
			PU_PURESET="Сброс выполнен с ПУ",
			  }




local function ReadStack()
-- считываем содержимое стека событий
--	counter=counter+1	
		local timestamp={} -- метка времени
		local signal -- состояние считанного бита
		local stack_status = Core["RAW_M340_P06_STACK_STATUS"]
		local stack_num=bit32.extract (stack_status ,8,8) --вычисляем номер обмена
		stack_blocks=bit32.extract (stack_status ,0,8) --вычисляем количество готовых к чтению блоков
		local cell -- указатель ячейки
		local DT --метка времени в формате POSIX
		local time_source="(ПЛК)" --источник метки времени
		Core["S_KTP_P06_STACK_NUM"]=stack_num
		Core["S_KTP_P06_READY_BLOCKS"]=stack_blocks
		local stack_blocks=1 --временно подменяем количество готовых к чтению блоков
		local datablock1 -- регистр адреса 
		local datablock3  --регистр данных
		local datablock4  -- регистр год\день месяц
		local datablock5  --регистр часы\минуты
		local datablock6  --регистр милисекунд
		for i=1, stack_blocks do --считываем блоки по очереди
					datablock1=Core["RAW_M340_P06_DATABLOCK"..i]
					datablock3=Core["RAW_M340_P06_DATABLOCK"..i+2]
					--datablock3=math.random(0,8192)
					datablock4=Core["RAW_M340_P06_DATABLOCK"..i+3]
					datablock5=Core["RAW_M340_P06_DATABLOCK"..i+4]
					datablock6=Core["RAW_M340_P06_DATABLOCK"..i+5]
					cell=bit32.extract(datablock1,0,12) --считываем адрес слова данных --адрес ячейки данных о событии, считываемой из стека 
					--	cell=90
						-- получаем метку времени события
						timestamp.day=bit32.extract (datablock4 , 0,5) --вычисляем день события
						timestamp.month=bit32.extract (datablock4 ,5,4)--вычисляем месяц
						timestamp.year=bit32.extract (datablock4 ,9,7) + 1980 --вычисляем год
						timestamp.hour=bit32.extract (datablock5 , 0,8) --вычисляем час
						timestamp.min=bit32.extract (datablock5 , 8,8)--вычисляем минуты
						timestamp.sec=math.floor(datablock6/1000)--вычисляем секунды
						timestamp.usec=(datablock6-timestamp.sec*1000)*1000--вычисляем микросекунды
						local timestamp_str = timestamp.day .. " " .. timestamp.month .. " " .. timestamp.year .. " " .. timestamp.hour .. ":" .. timestamp.min .. ":" ..  timestamp.sec .. "." .. timestamp.usec -- формируем строку времени
						DT=os.time(timestamp)  + os.tz() -- преобразуем метку в формат POSIX c учетом временной зоны
						--раскладывем слово данных на биты
						for bit_num=0 ,15 do -- читаем все биты по очереди
							local addr=tostring(cell.."."..bit_num) --получаем адрес переменной в формате "РЕГИСТР.БИТ"
							if BitMap[addr]~=nil -- проверяем существование переменной в таблице по указанному адресу
							then -- переменная существует (описана в BitMap)
								local Tag= BitMap[addr]
								local  bit = bit32.extract (datablock3 , bit_num,1)  --считываем значение бита из слова
								if bit==1 then signal=true else signal=false end --преобразуем считанные 0\1 в false\true (значение в состояние)
								if oldsignal[Tag]==nil or oldsignal[Tag]~=signal then --если сигнал изменился
									if signal then -- проверка состояния сигнала
										Core["S_KTP_P06_"..Tag.."_DP"]=true	
		 		  						 Core.addEvent(msg[Tag], event_class[Tag] , 1, sig_source..time_source, user, "PLC_"..Tag.."_DP_1", DT, "S_KTP_P06") --  добавляем событие (появление), текст берем в таблице msg, класс сообщения в таблице event_class
		  		 					else	
										 Core["S_KTP_P06_"..Tag.."_DP"]=false
										 Core.addEvent(msg[Tag], event_class[Tag] , 0, sig_source..time_source, user, "PLC_"..Tag.."_DP_0", DT, "S_KTP_P06" ) --добавляем событие (исчезновение)
 		  	 		 				end --проверки изменения сигнала
									oldsignal[Tag] = signal -- запоминаем текущее состояние сигнала в буферной таблице
									
 		 			  			end -- если сигнал изменился
							else -- переменная не существует (описана в BitMap)
										break -- прерываем цикл	
							end --if
							bit_num=bit_num+1
						end --for					

			i=i+6 -- к следующему блоку
		end --for

		Core["RAW_M340_P06_STACK_STATUS"]=256  -- обнуляем номер обмена		и очищаем стек

end -- ReadStack()

local function InitializationDI()
--функция первоначального опроса входов без создания событий. наполняет таблицу oldsignal 
-- нужна для того, чтобы при первом запуске не лилось лишних событий исчезновения
--считываем по очереди дискретные входы
-- имена переменных присваиваются из таблицы BitMap по адресу резистра и номеру бита

		local cell -- номер регистра
		local bit -- номер бита
		for cell=FR,LR do  -- читаем от первого до посдеднего регистра
			for bit=0 ,15 do -- читаем все биты
				local addr=tostring(cell.."."..bit) --получаем адрес переменной в формате "РЕГИСТР.БИТ"
					if BitMap[addr]~=nil -- проверяем существование переменной в таблице по указанному адресу
					then -- переменная существует (описана в BitMap)
						local Tag= BitMap[addr]
						local signal = Core["RAW_M340_P06_"..Tag.."_DP"] --считываем сигнал из ядра
					    if oldsignal[Tag]==nil or oldsignal[Tag]~=signal then --если сигнал изменился
							oldsignal[Tag] = signal -- запоминаем текущее состояние сигнала в буферной таблице
							Core["S_KTP_P06_"..Tag.."_DP"]=signal -- присваиваем значение переменной ядра 	
 		 			  end -- если сигнал изменился
					else -- переменная не существует (не описана в BitMap)
							break -- прерываем цикл	
					end --if
				bit=bit+1
			end --bit
		cell=cell+1
		end --cell


end --InitializationDI()

local function ReadDI()
--считываем по очереди дискретные входы
-- имена переменных присваиваются из таблицы BitMap по адресу резистра и номеру бита

		local cell -- номер регистра
		local bit -- номер бита
		local time_source ="(Сервер)"  --источник метки времени (ПЛК\Сервер)
		for cell=FR,LR do  -- читаем от первого до посдеднего регистра
			for bit=0 ,15 do -- читаем все биты
				local addr=tostring(cell.."."..bit) --получаем адрес переменной в формате "РЕГИСТР.БИТ"
					if BitMap[addr]~=nil -- проверяем существование переменной в таблице по указанному адресу
					then -- переменная существует (описана в BitMap)
						local Tag= BitMap[addr]
						local signal = Core["RAW_M340_P06_"..Tag.."_DP"] --считываем сигнал из ядра
					    if oldsignal[Tag]==nil or oldsignal[Tag]~=signal then --если сигнал изменился
							if signal then -- проверка состояния сигнала
		 		  				 Core.addEvent(msg[Tag], event_class[Tag] , 1, sig_source..time_source, user, "Serv_"..Tag.."_DP_1",os.time(),"S_KTP_P06") --  добавляем событие (появление), текст берем в таблице msg, класс сообщения в таблице event_class
		  		 			else
								Core.addEvent(msg[Tag], event_class[Tag] , 0, sig_source..time_source, user, "Serv_"..Tag.."_DP_0", os.time(), "S_KTP_P06" ) --добавляем событие (исчезновение)
 		  	 		 		end --проверки изменения сигнала
							oldsignal[Tag] = signal -- запоминаем текущее состояние сигнала в буферной таблице
							Core["S_KTP_P06_"..Tag.."_DP"]=signal -- присваиваем значение переменной ядра 	
 		 			  end -- если сигнал изменился
					else -- переменная не существует (не описана в BitMap)
							break -- прерываем цикл	
					end --if
				bit=bit+1
			end --bit
		cell=cell+1
		end --cell


end --ReadDI()

local function CheckStack()
				local time_source="(Сервер) "-- источник присвоения метки времени
				--local cell_addr=bit32.extract(Core["RAW_M340_P06_DATABLOCK1"],0,12) --считываем адрес слова данных --адрес ячейки данных о событии, считываемой из стека 
				local cell_addr=90
					if cell_addr==100 then --проверяем стек на переполнение если переполнен
						Core["S_KTP_P06_STACK_ERR"] =true --устанавливаем флаг переполнения стека 
						stack_error=true --устанавливаем флаг переполнения стека для скрипта
						ReadDI() -- считываем значение напрямую со входов
					else --если стек не переполнен
						Core["S_KTP_P06_STACK_ERR"]=false
						stack_error=false
						ReadStack()

					end --if
					if old_stack_error==nil or old_stack_error~=stack_error then --если сигнал изменился
 							if stack_error then -- проверка состояния сигнала	
									Core.addEvent(msg.stack_err, event.w, 1, sig_source..time_source, user, "stack_error_1")	-- пишем событие в журнал
									Core["RAW_M340_P06_STACK_STATUS"]=256  -- обнуляем номер обмена		и очищаем стек
							else
									Core.addEvent(msg.stack_err, event.w, 0, sig_source..time_source, user, "stack_error_0") -- исчезновение события
							end
					end
					old_stack_error=stack_error --запоминаем значение флага ошибки стека
					
					
end  --CheckStack()

	InitializationDI()
	CheckStack() --первоначальная проверка стека
	Core.onExtChange({"RAW_M340_P06_STACK_STATUS"}, CheckStack) --отслеживем статус стека и вызываем проверку стека


Core.waitEvents( )