local DRFlag-- флаг достоверности данных
--local DRFlag=Core["RAW_S7_P05_CONNECT"] -- флаг наличия соединения с контроллером Data_Reliability_Flag
local old_DRFlag -- предыдущее значение флага достоверности данных
local oldsignal = {} -- буферная таблица  предыдущего состояния входов
--local user=Core["USER_NAME_OUT"] -- текущее имя  пользователя
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

local function Check_Data_Reliability() 
	DRFlag= Core["S_KTP_P05_DS_DP"]
--	for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
		for _, signals_Descriptor in pairs(signals) do	--Цикл по всем элементов в каждом из 2 массивов: RAW_ и S_
			signals_Descriptor.cdr({raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals
		end
--	end
end --of Check_Data_Reliability

local function Get_DR_Type ()--функция определения появления\исчезновения недостоверности
	local DR_Type -- переменная :1 - параметр недостоверен, 0 - в норме
	DRFlag= Core["S_KTP_P05_DS_DP"]
	if DRFlag==2 then DR_Type=1 end --появление недостоверности
	if DRFlag==0 
		then DR_Type=0 --исчезновение недостоверности
		else DR_Type=nil -- нештатная ситуация
	end
	return DR_Type -- возвращаем в вызывающую функцию тип события недостоверности
end

local function Add_Event (Tag, signal)-- функция добавления события по сигналу Tag со значением signal в журнал
     					local DT=os.time() -- время события (локальное)
						local e_type -- тип события (появление\исчезновение)
						if signal then e_type=1 else e_type=0 end 						-- определение типа события (появление\ исчезновение)
					    if oldsignal[Tag]==nil or oldsignal[Tag]~=signal then --если сигнал изменился
		 		  				 Core.addEvent(msg[Tag], event_class[Tag] , e_type, sig_source..time_source, user, ObjID..Tag.."_DP_"..e_type, DT, ScreenID) --  добавляем событие (типа e_type), текст берем в таблице msg, класс сообщения в таблице event_class
	   	 			    end -- если сигнал изменился  				 
end -- of Add_Event

local function Add_DR_Event (Tag,DR_type)-- функция добавления события недостоверности сигналов
     					local DT=os.time() -- время события (локальное)
						-- тип события 
						-- определение типа события (появление\ исчезновение)
					    if old_DRFlag==nil or old_DRFlag~=DRFlag then --если сигнал изменился
		 		  				 Core.addEvent("Параметр недостоверен: "..msg[Tag], event.dr , DR_type, sig_source..time_source, user, "DR_"..ObjID..Tag.."_DP_"..DR_type, DT, ScreenID) --  добавляем событие (типа e_type), текст берем в таблице msg, класс сообщения в таблице event_class
	   	 			    end -- если сигнал изменился  				 
						old_DRFlag=DRFlag
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
			 end, --of eval
			["cdr"]=function(Name) 
					local Tag="VV1_AVOTKOLSEC"
					local DR_Type = Get_DR_Type ()
					if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end
			end
		  },
				 ["VV1_VVKL_DP"]={ ["Comment"]=sig_source..msg.VV1_VVKL,["eval"]= function(Name)local Tag="VV1_VVKL" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_VVKL" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_VOTK_DP"]={ ["Comment"]=sig_source..msg.VV1_VOTK,["eval"]= function(Name)local Tag="VV1_VOTK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_VOTK" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_VVIK_DP"]={ ["Comment"]=sig_source..msg.VV1_VVIK,["eval"]= function(Name)local Tag="VV1_VVIK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_VVIK" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_OTKVVAVRSV_DP"]={ ["Comment"]=sig_source..msg.VV1_OTKVVAVRSV,["eval"]= function(Name)local Tag="VV1_OTKVVAVRSV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_OTKVVAVRSV" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_VKLSVAVRSV_DP"]={ ["Comment"]=sig_source..msg.VV1_VKLSVAVRSV,["eval"]= function(Name)local Tag="VV1_VKLSVAVRSV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_VKLSVAVRSV" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_OTKVVAVRAV1_DP"]={ ["Comment"]=sig_source..msg.VV1_OTKVVAVRAV1,["eval"]= function(Name)local Tag="VV1_OTKVVAVRAV1" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_OTKVVAVRAV1" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_OTKVVAVRAV2_DP"]={ ["Comment"]=sig_source..msg.VV1_OTKVVAVRAV2,["eval"]= function(Name)local Tag="VV1_OTKVVAVRAV2" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_OTKVVAVRAV2" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_AVOTKVV_DP"]={ ["Comment"]=sig_source..msg.VV1_AVOTKVV,["eval"]= function(Name)local Tag="VV1_AVOTKVV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_AVOTKVV" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_OTKSVVNRAVRSV_DP"]={ ["Comment"]=sig_source..msg.VV1_OTKSVVNRAVRSV,["eval"]= function(Name)local Tag="VV1_OTKSVVNRAVRSV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_OTKSVVNRAVRSV" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_VKLVVVNRAVRSV_DP"]={ ["Comment"]=sig_source..msg.VV1_VKLVVVNRAVRSV,["eval"]= function(Name)local Tag="VV1_VKLVVVNRAVRSV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_VKLVVVNRAVRSV" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_VKLVVVNRAVRAV1_DP"]={ ["Comment"]=sig_source..msg.VV1_VKLVVVNRAVRAV1,["eval"]= function(Name)local Tag="VV1_VKLVVVNRAVRAV1" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_VKLVVVNRAVRAV1" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_VKLVVVNRAVRAV2_DP"]={ ["Comment"]=sig_source..msg.VV1_VKLVVVNRAVRAV2,["eval"]= function(Name)local Tag="VV1_VKLVVVNRAVRAV2" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_VKLVVVNRAVRAV2" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_SRTZNPOTKSV_DP"]={ ["Comment"]=sig_source..msg.VV1_SRTZNPOTKSV,["eval"]= function(Name)local Tag="VV1_SRTZNPOTKSV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_SRTZNPOTKSV" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_SRTZNPOTKVV_DP"]={ ["Comment"]=sig_source..msg.VV1_SRTZNPOTKVV,["eval"]= function(Name)local Tag="VV1_SRTZNPOTKVV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_SRTZNPOTKVV" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_SRTZNPOTKTR_DP"]={ ["Comment"]=sig_source..msg.VV1_SRTZNPOTKTR,["eval"]= function(Name)local Tag="VV1_SRTZNPOTKTR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_SRTZNPOTKTR" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_PRTEMTROTK_DP"]={ ["Comment"]=sig_source..msg.VV1_PRTEMTROTK,["eval"]= function(Name)local Tag="VV1_PRTEMTROTK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_PRTEMTROTK" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_SRZASHVV_DP"]={ ["Comment"]=sig_source..msg.VV1_SRZASHVV,["eval"]= function(Name)local Tag="VV1_SRZASHVV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_SRZASHVV" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_OTKVVNTRZASH_DP"]={ ["Comment"]=sig_source..msg.VV1_OTKVVNTRZASH,["eval"]= function(Name)local Tag="VV1_OTKVVNTRZASH" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_OTKVVNTRZASH" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_OTKVVDGZ_DP"]={ ["Comment"]=sig_source..msg.VV1_OTKVVDGZ,["eval"]= function(Name)local Tag="VV1_OTKVVDGZ" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_OTKVVDGZ" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_PRTEMTRSIG_DP"]={ ["Comment"]=sig_source..msg.VV1_PRTEMTRSIG,["eval"]= function(Name)local Tag="VV1_PRTEMTRSIG" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_PRTEMTRSIG" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_AVTVIKCNOTK_DP"]={ ["Comment"]=sig_source..msg.VV1_AVTVIKCNOTK,["eval"]= function(Name)local Tag="VV1_AVTVIKCNOTK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_AVTVIKCNOTK" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_AVTVIKCUOTK_DP"]={ ["Comment"]=sig_source..msg.VV1_AVTVIKCUOTK,["eval"]= function(Name)local Tag="VV1_AVTVIKCUOTK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_AVTVIKCUOTK" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_NEISPCUV_DP"]={ ["Comment"]=sig_source..msg.VV1_NEISPCUV,["eval"]= function(Name)local Tag="VV1_NEISPCUV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_NEISPCUV" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_NEISPCOV_DP"]={ ["Comment"]=sig_source..msg.VV1_NEISPCOV,["eval"]= function(Name)local Tag="VV1_NEISPCOV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_NEISPCOV" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_NEISPCVV_DP"]={ ["Comment"]=sig_source..msg.VV1_NEISPCVV,["eval"]= function(Name)local Tag="VV1_NEISPCVV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_NEISPCVV" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_SRDGZSEC_DP"]={ ["Comment"]=sig_source..msg.VV1_SRDGZSEC,["eval"]= function(Name)local Tag="VV1_SRDGZSEC" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_SRDGZSEC" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_AVTVIKCUOLSECOTK_DP"]={ ["Comment"]=sig_source..msg.VV1_AVTVIKCUOLSECOTK,["eval"]= function(Name)local Tag="VV1_AVTVIKCUOLSECOTK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_AVTVIKCUOLSECOTK" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_AVOTKUVN_DP"]={ ["Comment"]=sig_source..msg.VV1_AVOTKUVN,["eval"]= function(Name)local Tag="VV1_AVOTKUVN" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_AVOTKUVN" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_RAZGRSEC_DP"]={ ["Comment"]=sig_source..msg.VV1_RAZGRSEC,["eval"]= function(Name)local Tag="VV1_RAZGRSEC" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_RAZGRSEC" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},
                 ["VV1_NEISPCONTRV_DP"]={ ["Comment"]=sig_source..msg.VV1_NEISPCONTRV,["eval"]= function(Name)local Tag="VV1_NEISPCONTRV" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal) Core[Name[2]..Tag.."_DP"]=signal oldsignal[Tag] = signal end,  ["cdr"]=function(Name) local Tag="VV1_NEISPCONTRV" local DR_Type = Get_DR_Type () if DR_Type~=nil then Add_DR_Event (Tag,DR_Type) end    end},

--ВВОД2
        

--СВ
        
--АВ1
       
--АВ2
        
-- ПУ
         
}
	


-- Инициализация сигналов в момент запуска
--Check_Data_Reliability() 
for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
	for _, signals_Descriptor in pairs(signals) do	--Цикл по всем элементов в каждом из 2 массивов: RAW_ и S_
		signals_Descriptor.eval({raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals
		signals_Descriptor.cdr({raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals
	end
end
--отслеживем наличие соединения с контроллером
Core.onExtChange({"S_KTP_P05_DS_DP"}, Check_Data_Reliability) 
-- Отслеживание изменений значений в сигналах
for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
	for signals_Suffix, signals_Descriptor in pairs(signals) do	--Цикл по всем переменным в каждом из 2 массивов: RAW_ и S_
		Core.onExtChange({raw_objectName..signals_Suffix},signals_Descriptor.eval,{raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals при изменении любой из переменных
		Core.onExtChange({"S_KTP_P05_DS_DP"},signals_Descriptor.cdr,{raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals при изменении любой из переменных
	end
end



Core.waitEvents( )