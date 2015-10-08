local DRFlag-- флаг достоверности данных
local DRFlag=Core["S_KTP_P05_DS_DP"] -- флаг наличия соединения с контроллером Data_Reliability_Flag
--local old_DRFlag -- предыдущее значение флага достоверности данных
local oldsignal = {} -- буферная таблица  предыдущего состояния входов
--local user=Core["USER_NAME_OUT"] -- текущее имя  пользователя
local Log=true
local user=""
local ScreenID="S_KTP_P05" -- идентификатор мнемосхемы технологического объекта
local ObjID="S_KTP_P05_" -- идентификатор технологического объекта
local sig_source="АСУ ЭС, КТП 10/0,4 кВ, Панель №5 " --описание технологического объекта
local time_source ="(Сервер)" -- место присвоения сигналу метки времени

local event ={  --таблица типов событий
		a=10000 , --аварии
		w=10100, --предупреждения
		s=101,  --телесигнализация
		c=100, --команды
		dr=30100, -- достоверность сигнала
		}


local TagList={ --список всех обрабытываемых в приложении тегов
              "VV1_VVKL",
              "VV1_VOTK",
              "VV1_VVIK",
              "VV1_OTKVVAVRSV",
              "VV1_VKLSVAVRSV",
              "VV1_OTKVVAVRAV1",
              "VV1_OTKVVAVRAV2",
              "VV1_AVOTKVV",
              "VV1_OTKSVVNRAVRSV",
              "VV1_VKLVVVNRAVRSV",
              "VV1_VKLVVVNRAVRAV1",
              "VV1_VKLVVVNRAVRAV2",
              "VV1_SRTZNPOTKSV",
              "VV1_SRTZNPOTKVV",
              "VV1_SRTZNPOTKTR",
              "VV1_PRTEMTROTK",
              "VV1_SRZASHVV",
              "VV1_OTKVVNTRZASH",
              "VV1_OTKVVDGZ",
              "VV1_PRTEMTRSIG",
              "VV1_AVTVIKCNOTK",
              "VV1_AVTVIKCUOTK",
              "VV1_NEISPCUV",
              "VV1_NEISPCOV",
              "VV1_NEISPCVV",
              "VV1_SRDGZSEC",
              "VV1_AVTVIKCUOLSECOTK",
              "VV1_AVOTKUVN",
              "VV1_AVOTKOLSEC",
              "VV1_RAZGRSEC",
              "VV1_NEISPCONTRV",
              "VV2_VVKL",
              "VV2_VOTK",
              "VV2_VVIK",
              "VV2_OTKVVAVRSV",
              "VV2_VKLSVAVRSV",
              "VV2_OTKVVAVRAV1",
              "VV2_OTKVVAVRAV2",
              "VV2_AVOTKVV",
              "VV2_OTKSVVNRAVRSV",
              "VV2_VKLVVVNRAVRSV",
              "VV2_VKLVVVNRAVRAV1",
              "VV2_VKLVVVNRAVRAV2",
              "VV2_SRTZNPOTKSV",
              "VV2_SRTZNPOTKVV",
              "VV2_SRTZNPOTKTR",
              "VV2_PRTEMTROTK",
              "VV2_SRZASHVV",
              "VV2_OTKVVNTRZASH",
              "VV2_OTKVVDGZ",
              "VV2_PRTEMTRSIG",
              "VV2_AVTVIKCNOTK",
              "VV2_AVTVIKCUOTK",
              "VV2_NEISPCUV",
              "VV2_NEISPCOV",
              "VV2_NEISPCVV",
              "VV2_SRDGZSEC",
              "VV2_AVTVIKCUOLSECOTK",
              "VV2_AVOTKUVN",
              "VV2_AVOTKOLSEC",
              "VV2_RAZGRSEC",
              "VV2_NEISPCONTRV",
              "SV_SVVKL",
              "SV_SVOTK",
              "SV_SVVIK",
              "SV_AVRSVVKL",
              "SV_AVRSVOTK",
              "SV_AVOTKSV",
              "SV_SRZASHSV",
              "SV_OTKSVTZNPVVDGZ",
              "SV_AVTVIKCUSVOTK",
              "SV_NEISPCUSV",
              "SV_NEISPCOV",
              "SV_NEISPCVV",
              "SV_NEISPCONTRSV",
              "AV1_VAVVKL",
              "AV1_VAVOTK",
              "AV1_VAVVIK",
              "AV1_VGVKL",
              "AV1_VGOTK",
              "AV1_AVRAVVKL",
              "AV1_AVRAVOTK",
              "AV1_OTKSVAVRAV",
              "AV1_VKLSVVNRAVRAV",
              "AV1_VKLSVAVRAV",
              "AV1_PADSAVRAV",
              "AV1_VKLVAVAVRAV",
              "AV1_OTKVAVVNR",
              "AV1_OTKSVVNRAVRAV",
              "AV1_OSTADSVNRAVRAV",
              "AV1_NPADS",
              "AV1_AVOTKVAV",
              "AV1_OTKVAVDGZ",
              "AV1_SRZASHVAV",
              "AV1_NEISPADS",
              "AV1_PEREGRADS",
              "AV1_AVTVIKCNAVOTK",
              "AV1_AVTVIKCUAVOTK",
              "AV1_NEISPCUVG",
              "AV1_NEISPCUVAV",
              "AV1_NEISPCOV",
              "AV1_NEISPCVV",
              "AV1_NEISPCONTRAV",
              "AV2_VAVVKL",
              "AV2_VAVOTK",
              "AV2_VAVVIK",
              "AV2_VGVKL",
              "AV2_VGOTK",
              "AV2_AVRAVOTK",
              "AV2_AVRAVVKL",
              "AV2_OTKSVAVRAV",
              "AV2_VKLSVVNRAVRAV",
              "AV2_VKLSVAVRAV",
              "AV2_PADSAVRAV",
              "AV2_VKLVAVAVRAV",
              "AV2_OTKVAVVNR",
              "AV2_OTKSVVNRAVRAV",
              "AV2_OSTADSVNRAVRAV",
              "AV2_NPADS",
              "AV2_AVOTKVAV",
              "AV2_OTKVAVDGZ",
              "AV2_SRZASHVAV",
              "AV2_NEISPADS",
              "AV2_PEREGRADS",
              "AV2_AVTVIKCNAVOTK",
              "AV2_AVTVIKCUAVOTK",
              "AV2_NEISPCUVG",
              "AV2_NEISPCUVAV",
              "AV2_NEISPCOV",
              "AV2_NEISPCVV",
              "AV2_NEISPCONTRAV",
              "PU_DURAZR",
              "PU_SRAVTKTP",
              "PU_NEISKTP",
              "PU_AVARKTP",
              "PU_NEISPDGZ",
              "PU_NEISPCONTRPU",
              "PU_AVTVIKCSIGOTK",
              "PU_AVTVIKCOBOTK",
}-- of Taglist

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
         VV1_NEISPCOV=event.w,
         VV1_NEISPCVV=event.w,
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
         VV2_NEISPCOV=event.w,
         VV2_NEISPCVV=event.w,
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
         SV_NEISPCOV=event.w,
         SV_NEISPCVV=event.w,
         SV_NEISPCONTRSV=event.w,
			--Ав. Ввод 1
         AV1_VAVVKL=event.s,
         AV1_VAVOTK=event.s,
         AV1_VAVVIK=event.s,
         AV1_VGVKL=event.s,
         AV1_VGOTK=event.s,
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
         AV1_NEISPCOV=event.w,
         AV1_NEISPCVV=event.w,
         AV1_NEISPCONTRAV=event.w,
			--Ав. Ввод 2
         AV2_VAVVKL=event.s,
         AV2_VAVOTK=event.s,
         AV2_VAVVIK=event.s,
         AV2_VGVKL=event.s,
         AV2_VGOTK=event.s,
         AV2_AVRAVOTK=event.s,
         AV2_AVRAVVKL=event.s,
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
         AV2_NEISPCOV=event.w,
         AV2_NEISPCVV=event.w,
         AV2_NEISPCONTRAV=event.w,
				--ПУ
         PU_DURAZR=event.s,
         PU_SRAVTKTP=event.w,
         PU_NEISKTP=event.w,
         PU_AVARKTP=event.a,
         PU_NEISPDGZ=event.w,
         PU_NEISPCONTRPU=event.w,
         PU_AVTVIKCSIGOTK=event.w,
         PU_AVTVIKCOBOTK=event.w,
} -- event_class

local msg= { --таблица системных сообщений
				--Ввод 1
         VV1_VVKL="Ввод 1.  Выключатель ввода 1 включен",
         VV1_VOTK="Ввод 1.  Выключатель ввода 1 отключен",
         VV1_VVIK="Ввод 1.  Выключатель ввода 1 выкачен",
         VV1_OTKVVAVRSV="Ввод 1.  Отключение ВВ1 по АВР СВ",
         VV1_VKLSVAVRSV="Ввод 1.  Включение СВ по АВР СВ",
         VV1_OTKVVAVRAV1="Ввод 1.  Отключение ВВ1 по АВР АВ1",
         VV1_OTKVVAVRAV2="Ввод 1.  Отключение ВВ1 по АВР АВ2",
         VV1_AVOTKVV="Ввод 1.  Аварийное отключение ВВ1",
         VV1_OTKSVVNRAVRSV="Ввод 1.  Отключение СВ при ВНР после АВР СВ",
         VV1_VKLVVVNRAVRSV="Ввод 1.  Включение ВВ1 при ВНР после АВР СВ",
         VV1_VKLVVVNRAVRAV1="Ввод 1.  Включение ВВ1 при ВНР после АВР АВ1",
         VV1_VKLVVVNRAVRAV2="Ввод 1.  Включение ВВ1 при ВНР после АВР АВ2",
         VV1_SRTZNPOTKSV="Ввод 1.  Срабатывание ТЗНП В1 на отключение СВ",
         VV1_SRTZNPOTKVV="Ввод 1.  Срабатывание ТЗНП на отключение ВВ1",
         VV1_SRTZNPOTKTR="Ввод 1.  Срабатывание ТЗНП В1 на отключение трансформатора 1",
         VV1_PRTEMTROTK="Ввод 1. Превышение температуры трансформатора 1 на отключение",
         VV1_SRZASHVV="Ввод 1.  Срабатывание защит ВВ1",
         VV1_OTKVVNTRZASH="Ввод 1.  Отключение выключателя ВН трансформатора 1 от защит",
         VV1_OTKVVDGZ="Ввод 1.  Отключение ВВ1 от дуговой защиты",
         VV1_PRTEMTRSIG="Ввод 1.  Превышение температуры трансформатора 1 на сигнал",
         VV1_AVTVIKCNOTK="Ввод 1.  Авт выключатели цепей напряжения В1 откл",
         VV1_AVTVIKCUOTK="Ввод 1.  Авт выключатели цепей управления В1 откл",
         VV1_NEISPCUV="Ввод 1.  Неисправность цепей управления В1",
         VV1_NEISPCOV="Ввод 1.  Неисправность цепей отключения В1",
         VV1_NEISPCVV="Ввод 1.  Неисправность цепей включения В1",
         VV1_SRDGZSEC="Ввод 1.  Срабатывание дуговой защиты секции 1",
         VV1_AVTVIKCUOLSECOTK="Ввод 1.  Автоматические выключатели ЦУ ОЛ секции 1 откл",
         VV1_AVOTKUVN="Ввод 1.  Аварийное отключение УВН1",
         VV1_AVOTKOLSEC="Ввод 1.  Аварийное отключение ОЛ секции 1",
         VV1_RAZGRSEC="Ввод 1.  Разгрузка секции 1",
         VV1_NEISPCONTRV="Ввод 1.  Отказ контроллера 1АК",
				--Ввод 2
         VV2_VVKL="Ввод 2. Выключатель ввода 2 включен",
         VV2_VOTK="Ввод 2. Выключатель ввода 2 отключен",
         VV2_VVIK="Ввод 2. Выключатель ввода 2 выкачен",
         VV2_OTKVVAVRSV="Ввод 2. Отключение ВВ2 по АВР СВ",
         VV2_VKLSVAVRSV="Ввод 2. Включение СВ по АВР СВ",
         VV2_OTKVVAVRAV1="Ввод 2. Отключение ВВ2 по АВР АВ1",
         VV2_OTKVVAVRAV2="Ввод 2. Отключение ВВ2 по АВР АВ2",
         VV2_AVOTKVV="Ввод 2. Аварийное отключение ВВ2",
         VV2_OTKSVVNRAVRSV="Ввод 2. Отключение СВ при ВНР после АВР СВ",
         VV2_VKLVVVNRAVRSV="Ввод 2. Включение ВВ2 при ВНР после АВР СВ",
         VV2_VKLVVVNRAVRAV1="Ввод 2. Включение ВВ2 при ВНР после АВР АВ1",
         VV2_VKLVVVNRAVRAV2="Ввод 2. Включение ВВ2 при ВНР после АВР АВ2",
         VV2_SRTZNPOTKSV="Ввод 2. Срабатывание ТЗНП ВВ2 на отключение СВ",
         VV2_SRTZNPOTKVV="Ввод 2. Срабатывание ТЗНП на отключение ВВ2",
         VV2_SRTZNPOTKTR="Ввод 2. Срабатывание ТЗНП В2 на отключение трансформатора 2",
         VV2_PRTEMTROTK="Ввод 2. Превышение температуры трансформатора 2 на отключение",
         VV2_SRZASHVV="Ввод 2. Срабатывание защит ВВ2",
         VV2_OTKVVNTRZASH="Ввод 2. Отключение выключателя ВН трансформатора 2 от защит",
         VV2_OTKVVDGZ="Ввод 2. Отключение ВВ2 от дуговой защиты",
         VV2_PRTEMTRSIG="Ввод 2. Превышение температуры трансформатора 2 на сигнал",
         VV2_AVTVIKCNOTK="Ввод 2. Авт выключатели цепей напряжения В2 откл",
         VV2_AVTVIKCUOTK="Ввод 2. Авт выключатели цепей управления В2 откл",
         VV2_NEISPCUV="Ввод 2. Неисправность цепей управления ВВ2",
         VV2_NEISPCOV="Ввод 2. Неисправность цепей отключения ВВ2",
         VV2_NEISPCVV="Ввод 2. Неисправность цепей включения ВВ2",
         VV2_SRDGZSEC="Ввод 2. Срабатывание дуговой защиты секции 2",
         VV2_AVTVIKCUOLSECOTK="Ввод 2. Автоматические выключатели ЦУ ОЛ секции 2 откл",
         VV2_AVOTKUVN="Ввод 2. Аварийное отключение УВН2",
         VV2_AVOTKOLSEC="Ввод 2. Аварийное отключение ОЛ секции 2",
         VV2_RAZGRSEC="Ввод 2. Разгрузка секции 2",
         VV2_NEISPCONTRV="Ввод 2. Отказ контроллера 2АК",
				--СВ
         SV_SVVKL="СВ. Секционный выключатель включен",
         SV_SVOTK="СВ. Секционный выключатель отключен",
         SV_SVVIK="СВ. Секционный выключатель выкачен",
         SV_AVRSVVKL="СВ. АВР СВ включен",
         SV_AVRSVOTK="СВ. АВР СВ отключен",
         SV_AVOTKSV="СВ. Аварийное отключение СВ",
         SV_SRZASHSV="СВ. Срабатывание защит СВ",
         SV_OTKSVTZNPVVDGZ="СВ. Отключение СВ от ТЗНП вводов, ДГЗ",
         SV_AVTVIKCUSVOTK="СВ. Авт выключатель цепей управления СВ откл",
         SV_NEISPCUSV="СВ. Неисправность цепей управления СВ",
         SV_NEISPCOV="СВ. Неисправность цепей отключения СВ",
         SV_NEISPCVV="СВ. Неисправность цепей включения СВ",
         SV_NEISPCONTRSV="СВ. Отказ контроллера 3АК",
				--Ав. Ввод 1
         AV1_VAVVKL="Аварийный ввод 1.  Выключатель аварийного ввода 1 включен",
         AV1_VAVOTK="Аварийный ввод 1.  Выключатель аварийного ввода 1 отключен",
         AV1_VAVVIK="Аварийный ввод 1.  Выключатель аварийного ввода 1 выкачен",
         AV1_VGVKL="Аварийный ввод 1.  ВГ1 включен",
         AV1_VGOTK="Аварийный ввод 1.  ВГ1 отключен",
         AV1_AVRAVVKL="Аварийный ввод 1.  АВР АВ1 включен",
         AV1_AVRAVOTK="Аварийный ввод 1.  АВР АВ1 отключен",
         AV1_OTKSVAVRAV="Аварийный ввод 1.  Отключение СВ от АВР АВ1",
         AV1_VKLSVVNRAVRAV="Аварийный ввод 1.  Включение СВ при ВНР после АВР АВ1",
         AV1_VKLSVAVRAV="Аварийный ввод 1.  Включение СВ от АВР АВ1",
         AV1_PADSAVRAV="Аварийный ввод 1.  Пуск АДЭС1 от АВР АВ1",
         AV1_VKLVAVAVRAV="Аварийный ввод 1.  Включение ВАВ1 от АВР АВ1",
         AV1_OTKVAVVNR="Аварийный ввод 1.  Отключение ВАВ1 при ВНР после АВР АВ1",
         AV1_OTKSVVNRAVRAV="Аварийный ввод 1.  Отключение СВ при ВНР после АВР АВ1",
         AV1_OSTADSVNRAVRAV="Аварийный ввод 1.  Останов АДЭС1 при ВНР после АВР АВ1",
         AV1_NPADS="Аварийный ввод 1.  Неуспешный пуск АДЭС1",
         AV1_AVOTKVAV="Аварийный ввод 1.  Аварийное отключение ВАВ1",
         AV1_OTKVAVDGZ="Аварийный ввод 1.  Отключение ВАВ1 от дуговой защиты",
         AV1_SRZASHVAV="Аварийный ввод 1.  Срабатывание защит ВАВ1",
         AV1_NEISPADS="Аварийный ввод 1.  Неисправность АДЭС1",
         AV1_PEREGRADS="Аварийный ввод 1.  Перегрузка АДЭС1",
         AV1_AVTVIKCNAVOTK="Аварийный ввод 1.  Авт выключатель цепей напряжения АВ1 откл",
         AV1_AVTVIKCUAVOTK="Аварийный ввод 1.  Авт выключатель цепей управления АВ1 откл",
         AV1_NEISPCUVG="Аварийный ввод 1.  Неисправность цепей управления ВГ1",
         AV1_NEISPCUVAV="Аварийный ввод 1.  Неисправность цепей управления ВАВ1",
         AV1_NEISPCOV="Аварийный ввод 1.  Неисправность цепей отключения АВ1",
         AV1_NEISPCVV="Аварийный ввод 1.  Неисправность цепей включения АВ1",
         AV1_NEISPCONTRAV="Аварийный ввод 1.  Отказ контроллера 4АК",
				--Ав. Ввод 2
         AV2_VAVVKL="Аварийный ввод 2. Выключатель аварийного ввода 2 включен",
         AV2_VAVOTK="Аварийный ввод 2. Выключатель аварийного ввода 2 отключен",
         AV2_VAVVIK="Аварийный ввод 2. Выключатель аварийного ввода 1 выкачен",
         AV2_VGVKL="Аварийный ввод 2. ВГ2 включен",
         AV2_VGOTK="Аварийный ввод 2. ВГ2 отключен",
         AV2_AVRAVOTK="Аварийный ввод 2. АВР АВ2 отключен",
         AV2_AVRAVVKL="Аварийный ввод 2. АВР АВ2 выведен",
         AV2_OTKSVAVRAV="Аварийный ввод 2. Отключение СВ от АВР АВ2",
         AV2_VKLSVVNRAVRAV="Аварийный ввод 2. Включение СВ при ВНР после АВР АВ2",
         AV2_VKLSVAVRAV="Аварийный ввод 2. Включение СВ от АВР АВ2",
         AV2_PADSAVRAV="Аварийный ввод 2. Пуск АДЭС2 от АВР АВ2",
         AV2_VKLVAVAVRAV="Аварийный ввод 2. Включение ВАВ2 от АВР АВ2",
         AV2_OTKVAVVNR="Аварийный ввод 2. Отключение ВАВ2 при ВНР после АВР АВ2",
         AV2_OTKSVVNRAVRAV="Аварийный ввод 2. Отключение СВ при ВНР после АВР АВ2",
         AV2_OSTADSVNRAVRAV="Аварийный ввод 2. Останов АДЭС2 при ВНР после АВР АВ2",
         AV2_NPADS="Аварийный ввод 2. Неуспешный пуск АДЭС2",
         AV2_AVOTKVAV="Аварийный ввод 2. Аварийное отключение ВАВ2",
         AV2_OTKVAVDGZ="Аварийный ввод 2. Отключение ВАВ2 от дуговой защиты",
         AV2_SRZASHVAV="Аварийный ввод 2. Срабатывание защит ВАВ2",
         AV2_NEISPADS="Аварийный ввод 2. Неисправность АДЭС2",
         AV2_PEREGRADS="Аварийный ввод 2. Перегрузка АДЭС2",
         AV2_AVTVIKCNAVOTK="Аварийный ввод 2. Авт выключатель цепей напряжения АВ2 откл",
         AV2_AVTVIKCUAVOTK="Аварийный ввод 2. Авт выключатель цепей управления АВ2 откл",
         AV2_NEISPCUVG="Аварийный ввод 2. Неисправность цепей управления ВГ2",
         AV2_NEISPCUVAV="Аварийный ввод 2. Неисправность цепей управления ВАВ2",
         AV2_NEISPCOV="Аварийный ввод 2. Неисправность цепей отключения АВ2",
         AV2_NEISPCVV="Аварийный ввод 2. Неисправность цепей включения АВ2",
         AV2_NEISPCONTRAV="Аварийный ввод 2. Отказ контроллера 5АК",
				--ПУ
         PU_DURAZR="ПУ. ДУ разрешено",
         PU_SRAVTKTP="ПУ. Срабатывание автоматики КТП",
         PU_NEISKTP="ПУ. Неисправность КТП",
         PU_AVARKTP="ПУ. Авария КТП",
         PU_NEISPDGZ="ПУ. Неисправность ДГЗ",
         PU_NEISPCONTRPU="ПУ. Отказ контроллера АК",
         PU_AVTVIKCSIGOTK="ПУ. Авт выключатель цепей сигнализации отключен",
         PU_AVTVIKCOBOTK="ПУ. Авт выключатель цепей обогрева отключен",
} --msg


local function Check_Data_Reliability ()-- функция проверки достоверности сигналов и выдачи соответствующих сообщений
	local time_source=" (Сервер)"
	local DRFlag=Core["S_KTP_P05_DS_DP"] -- флаг наличия соединения с контроллером Data_Reliability_Flag
	local DT=os.time()	
	if old_DRFlag==nil or old_DRFlag~=DRFlag then --если сигнал недостоверности изменился
		local i=1 -- счетчик цикла
		local Tag -- текущий тэг из списка 
		while TagList[i]~=nil do -- пока сигналы в списке не кончатся
			if TagList[i]~=nil then Tag=TagList[i] else break end -- очередной тэг	
			if 	msg[Tag]==nil then break end
		  	if DRFlag>0 then -- проверка появления сигнала недостоверности	
			    	Core.addEvent("НЕДОСТОВЕРНО: " .. msg[Tag], event.dr, 1, sig_source..time_source, user, "DRF_"..ObjID..Tag.."_DP_1", DT, ScreenID) --  добавляем событие (появление), текст берем в таблице msg, класс сообщения в таблице event_class
					Core.addLogMsg(os.date().." ".."(Появл) НЕДОСТОВЕРНО: " .. msg[Tag])
		  	end --проверки появления сигнала недостоверности	
		    if DRFlag==0 then -- проверка исчезновения сигнала-- недостоверности
				Core.addEvent("НЕДОСТОВЕРНО: " .. msg[Tag] , event.dr , 0, sig_source..time_source, user, "DRF_"..ObjID..Tag.."_DP_0", DT, ScreenID) --добавляем событие (исчезновение)
				if Log then Core.addLogMsg(os.date().." ".."(Исчезн) НЕДОСТОВЕРНО: " .. msg[Tag]) end
	  	    end --проверка исчезновения сигнала недостоверности
			i=i+1 -- следующий!!!
		  end --of while
		  old_DRFlag = DRFlag -- запоминаем текущее состояние сигнала
	end -- если сигнал недостоверности изменился	 	 						 
end -- of Check_Data_Reliability 





local function Add_Event (Tag, signal)-- функция добавления события по сигналу Tag со значением signal в журнал
     					local DT=os.time() -- время события (локальное)
						local e_type -- тип события (появление\исчезновение)
						local e_type -- тип события (появление\исчезновение)
						if signal then 
							e_type=1
							if Log then Core.addLogMsg(os.date().." ".."(Появл.) " .. msg[Tag]) end --добавление события в лог 
						else
							 e_type=0
							if Log then Core.addLogMsg(os.date().." ".."(Исчезн.) " .. msg[Tag]) end --добавление события в лог  						-- определение типа события (появление\ исчезновение)
						end
					    if oldsignal[Tag]==nil or oldsignal[Tag]~=signal then --если сигнал изменился
		 		  				 Core.addEvent(msg[Tag], event_class[Tag] , e_type, sig_source..time_source, user, ObjID..Tag.."_DP_"..e_type, DT, ScreenID) --  добавляем событие (типа e_type), текст берем в таблице msg, класс сообщения в таблице event_class
	   	 			    end -- если сигнал изменился  				 
end -- of Add_Event


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
--ВВОД1
        ["VV1_AVOTKOLSEC_DP"]=
		 {

			["Comment"]=sig_source..msg.VV1_AVOTKOLSEC,
			["eval"]= function(Name) 
				local Tag="VV1_AVOTKOLSEC"
				local signal= Core[Name[1]..Tag.."_DP"] -- получаем значение сигнала из драйвера
				Add_Event (Tag, signal) -- запись события в журнал
				Core[Name[2]..Tag.."_DP"]=signal -- передаем значение сигнала в проект
				oldsignal[Tag] = signal -- запоминаем текущее состояние сигнала в буферной таблице
			 end --of eval

		  },
				 ["VV1_VVKL_DP"]={ ["Comment"]=sig_source..msg.VV1_VVKL,["eval"]= function(Name)local Tag="VV1_VVKL" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_VOTK_DP"]={ ["Comment"]=sig_source..msg.VV1_VOTK,["eval"]= function(Name)local Tag="VV1_VOTK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_VVIK_DP"]={ ["Comment"]=sig_source..msg.VV1_VVIK,["eval"]= function(Name)local Tag="VV1_VVIK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_OTKVVAVRSV_DP"]={ ["Comment"]=sig_source..msg.VV1_OTKVVAVRSV,["eval"]= function(Name)local Tag="VV1_OTKVVAVRSV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_VKLSVAVRSV_DP"]={ ["Comment"]=sig_source..msg.VV1_VKLSVAVRSV,["eval"]= function(Name)local Tag="VV1_VKLSVAVRSV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_OTKVVAVRAV1_DP"]={ ["Comment"]=sig_source..msg.VV1_OTKVVAVRAV1,["eval"]= function(Name)local Tag="VV1_OTKVVAVRAV1" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_OTKVVAVRAV2_DP"]={ ["Comment"]=sig_source..msg.VV1_OTKVVAVRAV2,["eval"]= function(Name)local Tag="VV1_OTKVVAVRAV2" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_AVOTKVV_DP"]={ ["Comment"]=sig_source..msg.VV1_AVOTKVV,["eval"]= function(Name)local Tag="VV1_AVOTKVV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_OTKSVVNRAVRSV_DP"]={ ["Comment"]=sig_source..msg.VV1_OTKSVVNRAVRSV,["eval"]= function(Name)local Tag="VV1_OTKSVVNRAVRSV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_VKLVVVNRAVRSV_DP"]={ ["Comment"]=sig_source..msg.VV1_VKLVVVNRAVRSV,["eval"]= function(Name)local Tag="VV1_VKLVVVNRAVRSV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_VKLVVVNRAVRAV1_DP"]={ ["Comment"]=sig_source..msg.VV1_VKLVVVNRAVRAV1,["eval"]= function(Name)local Tag="VV1_VKLVVVNRAVRAV1" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_VKLVVVNRAVRAV2_DP"]={ ["Comment"]=sig_source..msg.VV1_VKLVVVNRAVRAV2,["eval"]= function(Name)local Tag="VV1_VKLVVVNRAVRAV2" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_SRTZNPOTKSV_DP"]={ ["Comment"]=sig_source..msg.VV1_SRTZNPOTKSV,["eval"]= function(Name)local Tag="VV1_SRTZNPOTKSV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_SRTZNPOTKVV_DP"]={ ["Comment"]=sig_source..msg.VV1_SRTZNPOTKVV,["eval"]= function(Name)local Tag="VV1_SRTZNPOTKVV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_SRTZNPOTKTR_DP"]={ ["Comment"]=sig_source..msg.VV1_SRTZNPOTKTR,["eval"]= function(Name)local Tag="VV1_SRTZNPOTKTR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_PRTEMTROTK_DP"]={ ["Comment"]=sig_source..msg.VV1_PRTEMTROTK,["eval"]= function(Name)local Tag="VV1_PRTEMTROTK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_SRZASHVV_DP"]={ ["Comment"]=sig_source..msg.VV1_SRZASHVV,["eval"]= function(Name)local Tag="VV1_SRZASHVV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_OTKVVNTRZASH_DP"]={ ["Comment"]=sig_source..msg.VV1_OTKVVNTRZASH,["eval"]= function(Name)local Tag="VV1_OTKVVNTRZASH" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_OTKVVDGZ_DP"]={ ["Comment"]=sig_source..msg.VV1_OTKVVDGZ,["eval"]= function(Name)local Tag="VV1_OTKVVDGZ" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_PRTEMTRSIG_DP"]={ ["Comment"]=sig_source..msg.VV1_PRTEMTRSIG,["eval"]= function(Name)local Tag="VV1_PRTEMTRSIG" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_AVTVIKCNOTK_DP"]={ ["Comment"]=sig_source..msg.VV1_AVTVIKCNOTK,["eval"]= function(Name)local Tag="VV1_AVTVIKCNOTK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_AVTVIKCUOTK_DP"]={ ["Comment"]=sig_source..msg.VV1_AVTVIKCUOTK,["eval"]= function(Name)local Tag="VV1_AVTVIKCUOTK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_NEISPCUV_DP"]={ ["Comment"]=sig_source..msg.VV1_NEISPCUV,["eval"]= function(Name)local Tag="VV1_NEISPCUV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_NEISPCOV_DP"]={ ["Comment"]=sig_source..msg.VV1_NEISPCOV,["eval"]= function(Name)local Tag="VV1_NEISPCOV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_NEISPCVV_DP"]={ ["Comment"]=sig_source..msg.VV1_NEISPCVV,["eval"]= function(Name)local Tag="VV1_NEISPCVV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_SRDGZSEC_DP"]={ ["Comment"]=sig_source..msg.VV1_SRDGZSEC,["eval"]= function(Name)local Tag="VV1_SRDGZSEC" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_AVTVIKCUOLSECOTK_DP"]={ ["Comment"]=sig_source..msg.VV1_AVTVIKCUOLSECOTK,["eval"]= function(Name)local Tag="VV1_AVTVIKCUOLSECOTK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_AVOTKUVN_DP"]={ ["Comment"]=sig_source..msg.VV1_AVOTKUVN,["eval"]= function(Name)local Tag="VV1_AVOTKUVN" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_RAZGRSEC_DP"]={ ["Comment"]=sig_source..msg.VV1_RAZGRSEC,["eval"]= function(Name)local Tag="VV1_RAZGRSEC" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},
                 ["VV1_NEISPCONTRV_DP"]={ ["Comment"]=sig_source..msg.VV1_NEISPCONTRV,["eval"]= function(Name)local Tag="VV1_NEISPCONTRV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end},

--ВВОД2
		 ["VV2_VVKL_DP"]= { ["Comment"]=sig_source..msg.VV2_VVKL, ["eval"]= function(Name)  local Tag="VV2_VVKL"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_VOTK_DP"]= { ["Comment"]=sig_source..msg.VV2_VOTK, ["eval"]= function(Name)  local Tag="VV2_VOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_VVIK_DP"]= { ["Comment"]=sig_source..msg.VV2_VVIK, ["eval"]= function(Name)  local Tag="VV2_VVIK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_OTKVVAVRSV_DP"]= { ["Comment"]=sig_source..msg.VV2_OTKVVAVRSV, ["eval"]= function(Name)  local Tag="VV2_OTKVVAVRSV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_VKLSVAVRSV_DP"]= { ["Comment"]=sig_source..msg.VV2_VKLSVAVRSV, ["eval"]= function(Name)  local Tag="VV2_VKLSVAVRSV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_OTKVVAVRAV1_DP"]= { ["Comment"]=sig_source..msg.VV2_OTKVVAVRAV1, ["eval"]= function(Name)  local Tag="VV2_OTKVVAVRAV1"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_OTKVVAVRAV2_DP"]= { ["Comment"]=sig_source..msg.VV2_OTKVVAVRAV2, ["eval"]= function(Name)  local Tag="VV2_OTKVVAVRAV2"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_AVOTKVV_DP"]= { ["Comment"]=sig_source..msg.VV2_AVOTKVV, ["eval"]= function(Name)  local Tag="VV2_AVOTKVV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_OTKSVVNRAVRSV_DP"]= { ["Comment"]=sig_source..msg.VV2_OTKSVVNRAVRSV, ["eval"]= function(Name)  local Tag="VV2_OTKSVVNRAVRSV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_VKLVVVNRAVRSV_DP"]= { ["Comment"]=sig_source..msg.VV2_VKLVVVNRAVRSV, ["eval"]= function(Name)  local Tag="VV2_VKLVVVNRAVRSV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_VKLVVVNRAVRAV1_DP"]= { ["Comment"]=sig_source..msg.VV2_VKLVVVNRAVRAV1, ["eval"]= function(Name)  local Tag="VV2_VKLVVVNRAVRAV1"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_VKLVVVNRAVRAV2_DP"]= { ["Comment"]=sig_source..msg.VV2_VKLVVVNRAVRAV2, ["eval"]= function(Name)  local Tag="VV2_VKLVVVNRAVRAV2"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_SRTZNPOTKSV_DP"]= { ["Comment"]=sig_source..msg.VV2_SRTZNPOTKSV, ["eval"]= function(Name)  local Tag="VV2_SRTZNPOTKSV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_SRTZNPOTKVV_DP"]= { ["Comment"]=sig_source..msg.VV2_SRTZNPOTKVV, ["eval"]= function(Name)  local Tag="VV2_SRTZNPOTKVV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_SRTZNPOTKTR_DP"]= { ["Comment"]=sig_source..msg.VV2_SRTZNPOTKTR, ["eval"]= function(Name)  local Tag="VV2_SRTZNPOTKTR"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_PRTEMTROTK_DP"]= { ["Comment"]=sig_source..msg.VV2_PRTEMTROTK, ["eval"]= function(Name)  local Tag="VV2_PRTEMTROTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_SRZASHVV_DP"]= { ["Comment"]=sig_source..msg.VV2_SRZASHVV, ["eval"]= function(Name)  local Tag="VV2_SRZASHVV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_OTKVVNTRZASH_DP"]= { ["Comment"]=sig_source..msg.VV2_OTKVVNTRZASH, ["eval"]= function(Name)  local Tag="VV2_OTKVVNTRZASH"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_OTKVVDGZ_DP"]= { ["Comment"]=sig_source..msg.VV2_OTKVVDGZ, ["eval"]= function(Name)  local Tag="VV2_OTKVVDGZ"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_PRTEMTRSIG_DP"]= { ["Comment"]=sig_source..msg.VV2_PRTEMTRSIG, ["eval"]= function(Name)  local Tag="VV2_PRTEMTRSIG"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_AVTVIKCNOTK_DP"]= { ["Comment"]=sig_source..msg.VV2_AVTVIKCNOTK, ["eval"]= function(Name)  local Tag="VV2_AVTVIKCNOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_AVTVIKCUOTK_DP"]= { ["Comment"]=sig_source..msg.VV2_AVTVIKCUOTK, ["eval"]= function(Name)  local Tag="VV2_AVTVIKCUOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_NEISPCUV_DP"]= { ["Comment"]=sig_source..msg.VV2_NEISPCUV, ["eval"]= function(Name)  local Tag="VV2_NEISPCUV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_NEISPCOV_DP"]= { ["Comment"]=sig_source..msg.VV2_NEISPCOV, ["eval"]= function(Name)  local Tag="VV2_NEISPCOV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_NEISPCVV_DP"]= { ["Comment"]=sig_source..msg.VV2_NEISPCVV, ["eval"]= function(Name)  local Tag="VV2_NEISPCVV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_SRDGZSEC_DP"]= { ["Comment"]=sig_source..msg.VV2_SRDGZSEC, ["eval"]= function(Name)  local Tag="VV2_SRDGZSEC"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_AVTVIKCUOLSECOTK_DP"]= { ["Comment"]=sig_source..msg.VV2_AVTVIKCUOLSECOTK, ["eval"]= function(Name)  local Tag="VV2_AVTVIKCUOLSECOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_AVOTKUVN_DP"]= { ["Comment"]=sig_source..msg.VV2_AVOTKUVN, ["eval"]= function(Name)  local Tag="VV2_AVOTKUVN"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_AVOTKOLSEC_DP"]= { ["Comment"]=sig_source..msg.VV2_AVOTKOLSEC, ["eval"]= function(Name)  local Tag="VV2_AVOTKOLSEC"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_RAZGRSEC_DP"]= { ["Comment"]=sig_source..msg.VV2_RAZGRSEC, ["eval"]= function(Name)  local Tag="VV2_RAZGRSEC"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["VV2_NEISPCONTRV_DP"]= { ["Comment"]=sig_source..msg.VV2_NEISPCONTRV, ["eval"]= function(Name)  local Tag="VV2_NEISPCONTRV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },


--СВ
         ["SV_SVVKL_DP"]= { ["Comment"]=sig_source..msg.SV_SVVKL, ["eval"]= function(Name)  local Tag="SV_SVVKL"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["SV_SVOTK_DP"]= { ["Comment"]=sig_source..msg.SV_SVOTK, ["eval"]= function(Name)  local Tag="SV_SVOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["SV_SVVIK_DP"]= { ["Comment"]=sig_source..msg.SV_SVVIK, ["eval"]= function(Name)  local Tag="SV_SVVIK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["SV_AVRSVVKL_DP"]= { ["Comment"]=sig_source..msg.SV_AVRSVVKL, ["eval"]= function(Name)  local Tag="SV_AVRSVVKL"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["SV_AVRSVOTK_DP"]= { ["Comment"]=sig_source..msg.SV_AVRSVOTK, ["eval"]= function(Name)  local Tag="SV_AVRSVOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["SV_AVOTKSV_DP"]= { ["Comment"]=sig_source..msg.SV_AVOTKSV, ["eval"]= function(Name)  local Tag="SV_AVOTKSV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["SV_SRZASHSV_DP"]= { ["Comment"]=sig_source..msg.SV_SRZASHSV, ["eval"]= function(Name)  local Tag="SV_SRZASHSV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["SV_OTKSVTZNPVVDGZ_DP"]= { ["Comment"]=sig_source..msg.SV_OTKSVTZNPVVDGZ, ["eval"]= function(Name)  local Tag="SV_OTKSVTZNPVVDGZ"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["SV_AVTVIKCUSVOTK_DP"]= { ["Comment"]=sig_source..msg.SV_AVTVIKCUSVOTK, ["eval"]= function(Name)  local Tag="SV_AVTVIKCUSVOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["SV_NEISPCUSV_DP"]= { ["Comment"]=sig_source..msg.SV_NEISPCUSV, ["eval"]= function(Name)  local Tag="SV_NEISPCUSV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["SV_NEISPCOV_DP"]= { ["Comment"]=sig_source..msg.SV_NEISPCOV, ["eval"]= function(Name)  local Tag="SV_NEISPCOV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["SV_NEISPCVV_DP"]= { ["Comment"]=sig_source..msg.SV_NEISPCVV, ["eval"]= function(Name)  local Tag="SV_NEISPCVV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["SV_NEISPCONTRSV_DP"]= { ["Comment"]=sig_source..msg.SV_NEISPCONTRSV, ["eval"]= function(Name)  local Tag="SV_NEISPCONTRSV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
    
    
--АВ1
         ["AV1_VAVVKL_DP"]= { ["Comment"]=sig_source..msg.AV1_VAVVKL, ["eval"]= function(Name)  local Tag="AV1_VAVVKL"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_VAVOTK_DP"]= { ["Comment"]=sig_source..msg.AV1_VAVOTK, ["eval"]= function(Name)  local Tag="AV1_VAVOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_VAVVIK_DP"]= { ["Comment"]=sig_source..msg.AV1_VAVVIK, ["eval"]= function(Name)  local Tag="AV1_VAVVIK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_VGVKL_DP"]= { ["Comment"]=sig_source..msg.AV1_VGVKL, ["eval"]= function(Name)  local Tag="AV1_VGVKL"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_VGOTK_DP"]= { ["Comment"]=sig_source..msg.AV1_VGOTK, ["eval"]= function(Name)  local Tag="AV1_VGOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_AVRAVVKL_DP"]= { ["Comment"]=sig_source..msg.AV1_AVRAVVKL, ["eval"]= function(Name)  local Tag="AV1_AVRAVVKL"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_AVRAVOTK_DP"]= { ["Comment"]=sig_source..msg.AV1_AVRAVOTK, ["eval"]= function(Name)  local Tag="AV1_AVRAVOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_OTKSVAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV1_OTKSVAVRAV, ["eval"]= function(Name)  local Tag="AV1_OTKSVAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_VKLSVVNRAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV1_VKLSVVNRAVRAV, ["eval"]= function(Name)  local Tag="AV1_VKLSVVNRAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_VKLSVAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV1_VKLSVAVRAV, ["eval"]= function(Name)  local Tag="AV1_VKLSVAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_PADSAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV1_PADSAVRAV, ["eval"]= function(Name)  local Tag="AV1_PADSAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_VKLVAVAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV1_VKLVAVAVRAV, ["eval"]= function(Name)  local Tag="AV1_VKLVAVAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_OTKVAVVNR_DP"]= { ["Comment"]=sig_source..msg.AV1_OTKVAVVNR, ["eval"]= function(Name)  local Tag="AV1_OTKVAVVNR"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_OTKSVVNRAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV1_OTKSVVNRAVRAV, ["eval"]= function(Name)  local Tag="AV1_OTKSVVNRAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_OSTADSVNRAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV1_OSTADSVNRAVRAV, ["eval"]= function(Name)  local Tag="AV1_OSTADSVNRAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_NPADS_DP"]= { ["Comment"]=sig_source..msg.AV1_NPADS, ["eval"]= function(Name)  local Tag="AV1_NPADS"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_AVOTKVAV_DP"]= { ["Comment"]=sig_source..msg.AV1_AVOTKVAV, ["eval"]= function(Name)  local Tag="AV1_AVOTKVAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_OTKVAVDGZ_DP"]= { ["Comment"]=sig_source..msg.AV1_OTKVAVDGZ, ["eval"]= function(Name)  local Tag="AV1_OTKVAVDGZ"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_SRZASHVAV_DP"]= { ["Comment"]=sig_source..msg.AV1_SRZASHVAV, ["eval"]= function(Name)  local Tag="AV1_SRZASHVAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_NEISPADS_DP"]= { ["Comment"]=sig_source..msg.AV1_NEISPADS, ["eval"]= function(Name)  local Tag="AV1_NEISPADS"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_PEREGRADS_DP"]= { ["Comment"]=sig_source..msg.AV1_PEREGRADS, ["eval"]= function(Name)  local Tag="AV1_PEREGRADS"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_AVTVIKCNAVOTK_DP"]= { ["Comment"]=sig_source..msg.AV1_AVTVIKCNAVOTK, ["eval"]= function(Name)  local Tag="AV1_AVTVIKCNAVOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_AVTVIKCUAVOTK_DP"]= { ["Comment"]=sig_source..msg.AV1_AVTVIKCUAVOTK, ["eval"]= function(Name)  local Tag="AV1_AVTVIKCUAVOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_NEISPCUVG_DP"]= { ["Comment"]=sig_source..msg.AV1_NEISPCUVG, ["eval"]= function(Name)  local Tag="AV1_NEISPCUVG"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_NEISPCUVAV_DP"]= { ["Comment"]=sig_source..msg.AV1_NEISPCUVAV, ["eval"]= function(Name)  local Tag="AV1_NEISPCUVAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_NEISPCOV_DP"]= { ["Comment"]=sig_source..msg.AV1_NEISPCOV, ["eval"]= function(Name)  local Tag="AV1_NEISPCOV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_NEISPCVV_DP"]= { ["Comment"]=sig_source..msg.AV1_NEISPCVV, ["eval"]= function(Name)  local Tag="AV1_NEISPCVV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV1_NEISPCONTRAV_DP"]= { ["Comment"]=sig_source..msg.AV1_NEISPCONTRAV, ["eval"]= function(Name)  local Tag="AV1_NEISPCONTRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
       
--АВ2
         ["AV2_VAVVKL_DP"]= { ["Comment"]=sig_source..msg.AV2_VAVVKL, ["eval"]= function(Name)  local Tag="AV2_VAVVKL"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_VAVOTK_DP"]= { ["Comment"]=sig_source..msg.AV2_VAVOTK, ["eval"]= function(Name)  local Tag="AV2_VAVOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_VAVVIK_DP"]= { ["Comment"]=sig_source..msg.AV2_VAVVIK, ["eval"]= function(Name)  local Tag="AV2_VAVVIK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_VGVKL_DP"]= { ["Comment"]=sig_source..msg.AV2_VGVKL, ["eval"]= function(Name)  local Tag="AV2_VGVKL"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_VGOTK_DP"]= { ["Comment"]=sig_source..msg.AV2_VGOTK, ["eval"]= function(Name)  local Tag="AV2_VGOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_AVRAVOTK_DP"]= { ["Comment"]=sig_source..msg.AV2_AVRAVOTK, ["eval"]= function(Name)  local Tag="AV2_AVRAVOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_AVRAVVKL_DP"]= { ["Comment"]=sig_source..msg.AV2_AVRAVVKL, ["eval"]= function(Name)  local Tag="AV2_AVRAVVKL"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_OTKSVAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV2_OTKSVAVRAV, ["eval"]= function(Name)  local Tag="AV2_OTKSVAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_VKLSVVNRAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV2_VKLSVVNRAVRAV, ["eval"]= function(Name)  local Tag="AV2_VKLSVVNRAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_VKLSVAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV2_VKLSVAVRAV, ["eval"]= function(Name)  local Tag="AV2_VKLSVAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_PADSAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV2_PADSAVRAV, ["eval"]= function(Name)  local Tag="AV2_PADSAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_VKLVAVAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV2_VKLVAVAVRAV, ["eval"]= function(Name)  local Tag="AV2_VKLVAVAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_OTKVAVVNR_DP"]= { ["Comment"]=sig_source..msg.AV2_OTKVAVVNR, ["eval"]= function(Name)  local Tag="AV2_OTKVAVVNR"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_OTKSVVNRAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV2_OTKSVVNRAVRAV, ["eval"]= function(Name)  local Tag="AV2_OTKSVVNRAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_OSTADSVNRAVRAV_DP"]= { ["Comment"]=sig_source..msg.AV2_OSTADSVNRAVRAV, ["eval"]= function(Name)  local Tag="AV2_OSTADSVNRAVRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_NPADS_DP"]= { ["Comment"]=sig_source..msg.AV2_NPADS, ["eval"]= function(Name)  local Tag="AV2_NPADS"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_AVOTKVAV_DP"]= { ["Comment"]=sig_source..msg.AV2_AVOTKVAV, ["eval"]= function(Name)  local Tag="AV2_AVOTKVAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_OTKVAVDGZ_DP"]= { ["Comment"]=sig_source..msg.AV2_OTKVAVDGZ, ["eval"]= function(Name)  local Tag="AV2_OTKVAVDGZ"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_SRZASHVAV_DP"]= { ["Comment"]=sig_source..msg.AV2_SRZASHVAV, ["eval"]= function(Name)  local Tag="AV2_SRZASHVAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_NEISPADS_DP"]= { ["Comment"]=sig_source..msg.AV2_NEISPADS, ["eval"]= function(Name)  local Tag="AV2_NEISPADS"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_PEREGRADS_DP"]= { ["Comment"]=sig_source..msg.AV2_PEREGRADS, ["eval"]= function(Name)  local Tag="AV2_PEREGRADS"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_AVTVIKCNAVOTK_DP"]= { ["Comment"]=sig_source..msg.AV2_AVTVIKCNAVOTK, ["eval"]= function(Name)  local Tag="AV2_AVTVIKCNAVOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_AVTVIKCUAVOTK_DP"]= { ["Comment"]=sig_source..msg.AV2_AVTVIKCUAVOTK, ["eval"]= function(Name)  local Tag="AV2_AVTVIKCUAVOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_NEISPCUVG_DP"]= { ["Comment"]=sig_source..msg.AV2_NEISPCUVG, ["eval"]= function(Name)  local Tag="AV2_NEISPCUVG"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_NEISPCUVAV_DP"]= { ["Comment"]=sig_source..msg.AV2_NEISPCUVAV, ["eval"]= function(Name)  local Tag="AV2_NEISPCUVAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_NEISPCOV_DP"]= { ["Comment"]=sig_source..msg.AV2_NEISPCOV, ["eval"]= function(Name)  local Tag="AV2_NEISPCOV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_NEISPCVV_DP"]= { ["Comment"]=sig_source..msg.AV2_NEISPCVV, ["eval"]= function(Name)  local Tag="AV2_NEISPCVV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["AV2_NEISPCONTRAV_DP"]= { ["Comment"]=sig_source..msg.AV2_NEISPCONTRAV, ["eval"]= function(Name)  local Tag="AV2_NEISPCONTRAV"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
        
-- ПУ
         ["PU_DURAZR_DP"]= { ["Comment"]=sig_source..msg.PU_DURAZR, ["eval"]= function(Name)  local Tag="PU_DURAZR"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["PU_SRAVTKTP_DP"]= { ["Comment"]=sig_source..msg.PU_SRAVTKTP, ["eval"]= function(Name)  local Tag="PU_SRAVTKTP"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["PU_NEISKTP_DP"]= { ["Comment"]=sig_source..msg.PU_NEISKTP, ["eval"]= function(Name)  local Tag="PU_NEISKTP"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["PU_AVARKTP_DP"]= { ["Comment"]=sig_source..msg.PU_AVARKTP, ["eval"]= function(Name)  local Tag="PU_AVARKTP"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["PU_NEISPDGZ_DP"]= { ["Comment"]=sig_source..msg.PU_NEISPDGZ, ["eval"]= function(Name)  local Tag="PU_NEISPDGZ"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["PU_NEISPCONTRPU_DP"]= { ["Comment"]=sig_source..msg.PU_NEISPCONTRPU, ["eval"]= function(Name)  local Tag="PU_NEISPCONTRPU"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["PU_AVTVIKCSIGOTK_DP"]= { ["Comment"]=sig_source..msg.PU_AVTVIKCSIGOTK, ["eval"]= function(Name)  local Tag="PU_AVTVIKCSIGOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         ["PU_AVTVIKCOBOTK_DP"]= { ["Comment"]=sig_source..msg.PU_AVTVIKCOBOTK, ["eval"]= function(Name)  local Tag="PU_AVTVIKCOBOTK"  local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end },
         
}
	


-- Инициализация сигналов в момент запуска
--Check_Data_Reliability() 
for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
	for _, signals_Descriptor in pairs(signals) do	--Цикл по всем элементов в каждом из 2 массивов: RAW_ и S_
		signals_Descriptor.eval({raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals
	end
end
--отслеживем наличие соединения с контроллером
Core.onExtChange({"S_KTP_P05_DS_DP"}, Check_Data_Reliability) 
-- Отслеживание изменений значений в сигналах
for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
	for signals_Suffix, signals_Descriptor in pairs(signals) do	--Цикл по всем переменным в каждом из 2 массивов: RAW_ и S_
		Core.onExtChange({raw_objectName..signals_Suffix},signals_Descriptor.eval,{raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals при изменении любой из переменных
	end
end



Core.waitEvents( )