dofile("AT_BIP3WUMWFPGETLORIK7DY4CCVY.lua") 

local raw_object={"RAW_BMRZ_","RAW_BMRZ_2_"}--Объекты для входных переменных
local object={"S_KTP_P07_BVV1_","S_KTP_P07_BVV2_"}--объекты для выходных переменных
--перечнь переменных
local Reg_Block_ID = {"Номер конфигурации","Reg_Block_ID",0,0,"Reg_Block_ID",0}
local Reg_Slave_ID = {"Идентификатор","Reg_Slave_ID","","","Reg_Slave_ID",0}
local Reg_Version = {"Версия сетевого драйвера","Reg_Version",0,0,"Reg_Version",0}
local Reg_Time = {"Астрономическое время встроенных часов- календаря","Reg_Time",0,0,"Reg_Time",0}
local VREMSBROSA_CP = {"Астрономическое время последнего сброса накопительной информации","VREMSBROSA_CP",0,0,"VREMSBROSA_CP",0}
local ANGLE_AP = {"Текущее значение угла между I1 U1 ","ANGLE_AP",0,0,"ANGLE_AP",0}
local AVOTK_CP = {"Аварийное отключение ","VAVOTK_CP",0,0,"VAVOTK_CP",0}
local AVOTK_DP = {"Аварийное отключение ","AVOTK_DP",0,0,"AVOTK_DP",0}
local AVRSVVKL_DP = {"АВР СВ включено ","AVRSVVKL_DP",0,0,"AVRSVVKL_DP",0}
local BLDRBMTZ_DP = {"Блокировка функций ДР и БМТЗ при параллельной работе ВВ и АВ ","BLDRBMTZ_DP",0,0,"BLDRBMTZ_DP",0}
local BLOCKAVRAV_DP = {"Блокировка АВР АВ ","BLOCKAVRAV_DP",0,0,"BLOCKAVRAV_DP",0}
local BMTZ_DP = {"БМТЗ ","BMTZ_DP",0,0,"BMTZ_DP",0}
local COSFI_AP = {"Текущее значение cos φ ","COSFI_AP",0,0,"COSFI_AP",0}
local DUVKL_DP = {"ДУ включено ","DUVKL_DP",0,0,"DUVKL_DP",0}
local FREQ__AP = {"Текущее значение частоты тока в сети ","FREQ__AP",0,0,"FREQ__AP",0}
local I0MAX_CP = {"Максимальное значение тока нулевой последовательности ","I0MAX_CP",0,0,"I0MAX_CP",0}
local I0_AP = {"Текущее значение тока нулевой последовательности ","I0_AP",0,0,"I0_AP",0}
local IACPR_AP = {"Текущее значение активной составляющей тока прямой последовательности ","IACPR_AP",0,0,"IACPR_AP",0}
local IAMAXPO_CP = {"Максимальный ток при последнем отключении Фаза A ","IAMAXPO_CP",0,0,"IAMAXPO_CP",0}
local IAMAX_CP = {"Максимальное значение тока фазы А ","IAMAX_CP",0,0,"IAMAX_CP",0}
local IATEK_AP = {"Текущее значение тока фазы А ","IATEK_AP",0,0,"IATEK_AP",0}
local IBMAXPO_CP = {"Максимальный ток при последнем отключении Фаза B ","IBMAXPO_CP",0,0,"IBMAXPO_CP",0}
local IBMAX_CP = {"Максимальное значение тока фазы В ","IBMAX_CP",0,0,"IBMAX_CP",0}
local IBTEK_AP = {"Текущее значение тока фазы В ","IBTEK_AP",0,0,"IBTEK_AP",0}
local ICMAXPO_CP = {"Максимальный ток при последнем отключении Фаза C ","ICMAXPO_CP",0,0,"ICMAXPO_CP",0}
local ICMAX_CP = {"Максимальное значение тока фазы С ","ICMAX_CP",0,0,"ICMAX_CP",0}
local ICTEK_AP = {"Текущее значение тока фазы С ","ICTEK_AP",0,0,"ICTEK_AP",0}
local IOB_AP = {"Текущее значение тока обратной последовательности ","IOB_AP",0,0,"IOB_AP",0}
local IPR_AP = {"Текущее значение тока прямой последовательности ","IPR_AP",0,0,"IPR_AP",0}
local IREPR_AP = {"Текущее значение реактивной составляющей тока прямой последовательности ","IREPR_AP",0,0,"IREPR_AP",0}
local KOLPTZNP_CP = {"Количество пусков ТЗНП ","KOLPTZNP_CP",0,0,"KOLPTZNP_CP",0}
local KPAVR_CP = {"Количество пусков АВР ","KPAVR_CP",0,0,"KPAVR_CP",0}
local KPDR_CP = {"Количество пусков ДР ","KPDR_CP",0,0,"KPDR_CP",0}
local KPMTZI1ST_CP = {"Количество пусков МТЗ I>> ","KPMTZI1ST_CP",0,0,"KPMTZI1ST_CP",0}
local KPMTZI2ST_CP = {"Количество пусков МТЗ I> ","KPMTZI2ST_CP",0,0,"KPMTZI2ST_CP",0}
local KSAVRAV_CP = {"Количество срабатываний АВР AB ","KSAVRAV_CP",0,0,"KSAVRAV_CP",0}
local KSBMTZ_CP = {"Количество срабатываний БМТЗ ","KSBMTZ_CP",0,0,"KSBMTZ_CP",0}
local KSDROTKSV_CP = {"Количество срабатываний ДР на отключение СВ ","KSDROTKSV_CP",0,0,"KSDROTKSV_CP",0}
local KSDROTKVV_CP = {"Количество срабатываний ДР на отключение ВВ ","KSDROTKVV_CP",0,0,"KSDROTKVV_CP",0}
local KSMTZI1STSV_CP = {"Количество срабатываний МТЗ I>> на отключение СВ ","KSMTZI1STSV_CP",0,0,"KSMTZI1STSV_CP",0}
local KSMTZI1STVV_CP = {"Количество срабатываний МТЗ I>> на отключение ВВ ","KSMTZI1STVV_CP",0,0,"KSMTZI1STVV_CP",0}
local KSMTZI2STK13_CP = {"Количество срабатываний МТЗ I> на К 13 ","KSMTZI2STK13_CP",0,0,"KSMTZI2STK13_CP",0}
local KSMTZI2STVV_CP = {"Количество срабатываний МТЗ I> на отключение ВВ ","KSMTZI2STVV_CP",0,0,"KSMTZI2STVV_CP",0}
local KSTZNPSV_CP = {"Количество срабатываний ТЗНП на отключение СВ ","KSTZNPSV_CP",0,0,"KSTZNPSV_CP",0}
local KSTZNPVV_CP = {"Количество срабатываний ТЗНП на отключение ВВ ","KSTZNPVV_CP",0,0,"KSTZNPVV_CP",0}
local KVIT_DP = {"Квитирование ","KVIT_DP",0,0,"KVIT_DP",0}
local NBB1_2_DP = {"Неисправность цепей управления ВВ1(2) ","NBB1(2)_DP",0,0,"NBB12_DP",0}
local NBMRZ_CP = {"Неисправность БМРЗ ","VNBMRZ_CP",0,0,"VNBMRZ_CP",0}
local NBMRZ_DP = {"Неисправность БМРЗ ","NBMRZ_DP",0,0,"NBMRZ_DP",0}
local NEZVNR_CP = {"Незавершенное ВНР ","NEZVNR_CP",0,0,"NEZVNR_CP",0}
local NVV_CP = {"Неисправность ВВ ","NVV_CP",0,0,"NVV_CP",0}
local OTKAVRAV_DP = {"Отключение АВР АВ ","OTKAVRAV_DP",0,0,"OTKAVRAV_DP",0}
local OTKAVRSV_CP = {"Отключение от АВР СВ ","OTKAVRSV_CP",0,0,"OTKAVRSV_CP",0}
local OTKKL_DP = {"Команда «Отключить» от ключа ","OTKKL_DP",0,0,"OTKKL_DP",0}
local OTKLSVVNR_DP = {"Отключить СВ от ВНР ","OTKLSVVNR_DP",0,0,"OTKLSVVNR_DP",0}
local OTKLSVZASH_DP = {"Отключить СВ от защит ","OTKLSVZASH_DP",0,0,"OTKLSVZASH_DP",0}
local OTKLTRAN_DP = {"Отключить трансформатор ","OTKLTRAN_DP",0,0,"OTKLTRAN_DP",0}
local OTKTR_CP = {"Отключение ТР ","OTKTR_CP",0,0,"OTKTR_CP",0}
local OTKVVAVR_CP = {"Отключение ВВ по АВР ","OTKVVAVR_CP",0,0,"OTKVVAVR_CP",0}
local OTKVV_DP = {"Отключить ВВ ","OTKVV_DP",0,0,"OTKVV_DP",0}
local PAC3F_AP = {"Текущее значение активной трехфазной мощности ","PAC3F_AP",0,0,"PAC3F_AP",0}
local PACOB_AP = {"Текущее значение активной составляющей мощности обратной последовательности ","PACOB_AP",0,0,"PACOB_AP",0}
local PEREGR_DP = {"Перегрузка ","PEREGR_DP",0,0,"PEREGR_DP",0}
local PPL3F_AP = {"Текущее значение полной трехфазной мощности ","PPL3F_AP",0,0,"PPL3F_AP",0}
local PRE3F_AP = {"Текущее значение реактивной фазной мощности ","PRE3F_AP",0,0,"PRE3F_AP",0}
local RAZAVRBMRZ_DP = {"Разрешение АВР БМРЗ – 0,4ВВ соседней секции ","RAZAVRBMRZ_DP",0,0,"RAZAVRBMRZ_DP",0}
local RAZAVRSV2VV_DP = {"Разрешение АВР СВ второго ввода ","RAZAVRSV2VV_DP",0,0,"RAZAVRSV2VV_DP",0}
local RPOVOTK_DP = {"РПО «Выключатель отключен» ","RPOVOTK_DP",0,0,"RPOVOTK_DP",0}
local RPVVKLST_DP = {"РПВ во включенном состоянии ","RPVVKLST_DP",0,0,"RPVVKLST_DP",0}
local RPVVKL_DP = {"РПВ «Выключатель включен» ","RPVVKL_DP",0,0,"RPVVKL_DP",0}
local RPVVKL_DP_1 = {"РПВ «Выключатель включен» ","RPVVKL_DP_1",0,0,"RPVVKL_DP_1",0}
local SIGPDGZ_DP = {"Сигнал пуска ДгЗ ","SIGPDGZ_DP",0,0,"SIGPDGZ_DP",0}
local SIGSRDGZ_DP = {"Сигнал срабатывания дуговой защиты ","SIGSRDGZ_DP",0,0,"SIGSRDGZ_DP",0}
local SR1STMTZSV_CP = {"Срабатывание первой ступени МТЗ на отключение СВ (МТЗ>>) ","SR1STMTZSV_CP",0,0,"SR1STMTZSV_CP",0}
local SR1STMTZ_CP = {"Срабатывание первой ступени МТЗ на отключение (МТЗ>>) ","SR1STMTZ_CP",0,0,"SR1STMTZ_CP",0}
local SR2STMTZ_CP = {"Срабатывание второй ступени МТЗ на отключение (МТЗ>>) ","SR2STMTZ_CP",0,0,"SR2STMTZ_CP",0}
local SRAVTAVR_DP = {"Срабатывание автоматики АВР ","SRAVTAVR_DP",0,0,"SRAVTAVR_DP",0}
local SRCHSTMTZ_CP = {"Срабатывание чувствительной ступени МТЗ (Перегрузка) ","SRCHSTMTZ_CP",0,0,"SRCHSTMTZ_CP",0}
local SRDROTKSV_CP = {"Срабатывание ДР на отключение СВ ","SRDROTKSV_CP",0,0,"SRDROTKSV_CP",0}
local SRDROTK_CP = {"Срабатывание ДР на отключение ","SRDROTK_CP",0,0,"SRDROTK_CP",0}
local SRTZNPOTKSV_CP = {"Срабатывание ТЗНП на отключение СВ ","SRTZNPOTKSV_CP",0,0,"SRTZNPOTKSV_CP",0}
local SRTZNPOTK_CP = {"Срабатывание ТЗНП на отключение ","SRTZNPOTK_CP",0,0,"SRTZNPOTK_CP",0}
local SUMIOTKA_CP = {"Суммарный ток отключений Фаза А ","SUMIOTKA_CP",0,0,"SUMIOTKA_CP",0}
local SUMIOTKB_CP = {"Суммарный ток отключений Фаза B ","SUMIOTKB_CP",0,0,"SUMIOTKB_CP",0}
local SUMIOTKC_CP = {"Суммарный ток отключений Фаза C ","SUMIOTKC_CP",0,0,"SUMIOTKC_CP",0}
local SUMKOLOTK_CP = {"Суммарное количество отключений ","SUMKOLOTK_CP",0,0,"SUMKOLOTK_CP",0}
local SVOTK_DP = {"СВ отключен ","SVOTK_DP",0,0,"SVOTK_DP",0}
local SVVKL_DP = {"СВ включен ","SVVKL_DP",0,0,"SVVKL_DP",0}
local TELVVVIK_DP = {"Тележка ВВ выкачена ","TELVVVIK_DP",0,0,"TELVVVIK_DP",0}
local TTRPOV_DP = {"Температура трансформатора повышена (устанавливается в единицу при превышении порогового уровня температуры) ","TTRPOV_DP",0,0,"TTRPOV_DP",0}
local UAS_AP = {"Текущее значение напряжения фазы А (на секции) ","UAS_AP",0,0,"UAS_AP",0}
local UAVV_AP = {"Текущее значение напряжения фазы А ввода ","UAVV_AP",0,0,"UAVV_AP",0}
local UBS_AP = {"Текущее значение напряжения фазы В (на секции) ","UBS_AP",0,0,"UBS_AP",0}
local UBVV_AP = {"Текущее значение напряжения фазы В ввода ","UBVV_AP",0,0,"UBVV_AP",0}
local UCS_AP = {"Текущее значение напряжения фазы С (на секции) ","UCS_AP",0,0,"UCS_AP",0}
local UCVV_AP = {"Текущее значение напряжения фазы С ввода ","UCVV_AP",0,0,"UCVV_AP",0}
local UOBVV_AP = {"Текущее значение напряжения напряжения обратной последовательности ввода (до выключателя) ","UOBVV_AP",0,0,"UOBVV_AP",0}
local UOB_AP = {"Текущее значение напряжения обратной последовательности. ","UOB_AP",0,0,"UOB_AP",0}
local UPR_AP = {"Текущее значение напряжения прямой последовательности. ","UPR_AP",0,0,"UPR_AP",0}
local VIZKTP_DP = {"Вызов в КТП ","VIZKTP_DP",0,0,"VIZKTP_DP",0}
local VKLAVRAV_DP = {"Включение по АВР АВ ","VKLAVRAV_DP",0,0,"VKLAVRAV_DP",0}
local VKLKL_DP = {"Команда «Включить» от ключа ","VKLKL_DP",0,0,"VKLKL_DP",0}
local VKLSVAVRAV_DP = {"Включить СВ по АВР АВ ","VKLSVAVRAV_DP",0,0,"VKLSVAVRAV_DP",0}
local VKLVV_DP = {"Включить ВВ ","VKLVV_DP",0,0,"VKLVV_DP",0}
local VNR_CP = {"ВНР ","VNR_CP",0,0,"VNR_CP",0}
local VOTK_DP = {"Выключатель отключен ","VOTK_DP",0,0,"VOTK_DP",0}
local Reg_NET_KTr_1 = {"Коэф. для Текущее значение тока фазы А","Reg_NET_KTr_1",0,0,"",0}
local Reg_NET_KTr_2 = {"Коэф. для Текущее значение тока фазы В","Reg_NET_KTr_2",0,0,"",0}
local Reg_NET_KTr_3 = {"Коэф. для Текущее значение тока фазы С","Reg_NET_KTr_3",0,0,"",0}
local Reg_NET_KTr_4 = {"Коэф. для Текущее значение тока нулевой последовательности","Reg_NET_KTr_4",0,0,"",0}
local Reg_NET_KTr_5 = {"Коэф. для Текущее значение напряжения фазы А ввода","Reg_NET_KTr_5",0,0,"",0}
local Reg_NET_KTr_6 = {"Коэф. для Текущее значение напряжения фазы В ввода","Reg_NET_KTr_6",0,0,"",0}
local Reg_NET_KTr_7 = {"Коэф. для Текущее значение напряжения фазы С ввода","Reg_NET_KTr_7",0,0,"",0}
local Reg_NET_KTr_8 = {"Коэф. для Текущее значение напряжения фазы А секции","Reg_NET_KTr_8",0,0,"",0}
local Reg_NET_KTr_9 = {"Коэф. для Текущее значение напряжения фазы В секции","Reg_NET_KTr_9",0,0,"",0}
local Reg_NET_KTr_10 = {"Коэф. для Текущее значение напряжения фазы С секции","Reg_NET_KTr_10",0,0,"",0}
local Reg_NET_KTr_11 = {"Коэф. для Текущее значение тока прямой последовательности","Reg_NET_KTr_11",0,0,"",0}
local Reg_NET_KTr_12 = {"Коэф. для Текущее значение тока обратной последовательности","Reg_NET_KTr_12",0,0,"",0}
local Reg_NET_KTr_13 = {"Коэф. для Текущее значение напряжения прямой последовательности.","Reg_NET_KTr_13",0,0,"",0}
local Reg_NET_KTr_14 = {"Коэф. для Текущее значение напряжения обратной последовательности.","Reg_NET_KTr_14",0,0,"",0}
local Reg_NET_KTr_15 = {"Коэф. для Текущее значение активной составляющей тока прямой последовательности","Reg_NET_KTr_15",0,0,"",0}
local Reg_NET_KTr_16 = {"Коэф. для Текущее значение реактивной составляющей тока прямой последовательности","Reg_NET_KTr_16",0,0,"",0}
local Reg_NET_KTr_17 = {"Коэф. для Текущее значение угла между 11и U1","Reg_NET_KTr_17",0,0,"",0}
local Reg_NET_KTr_18 = {"Коэф. для Текущее значение активной составляющей мощности обратной последовательности","Reg_NET_KTr_18",0,0,"",0}
local Reg_NET_KTr_19 = {"Коэф. для Текущее значение активной трехфазной мощности","Reg_NET_KTr_19",0,0,"",0}
local Reg_NET_KTr_20 = {"Коэф. для Текущее значение реактивной фазной мощности","Reg_NET_KTr_20",0,0,"",0}
local Reg_NET_KTr_21 = {"Коэф. для Текущее значение полной трехфазной мощности","Reg_NET_KTr_21",0,0,"",0}
local Reg_NET_KTr_22 = {"Коэф. для Текущее значение cos Ф","Reg_NET_KTr_22",0,0,"",0}
local Reg_NET_KTr_23 = {"Коэф. для Текущее значение напряжения обратной последовательности ввода.","Reg_NET_KTr_23",0,0,"",0}
local Reg_NET_KTr_24 = {"Коэф. для Текущее значение частоты тока в сети","Reg_NET_KTr_24",0,0,"",0}
local VVKL_DP = {"Выключатель включен","VVKL_DP",0,0,"VVKL_DP",0}
local ZAPAVRVNZ_DP = {"Запрет АВР от внешних защит ","ZAPAVRVNZ_DP",0,0,"ZAPAVRVNZ_DP",0}







local str3=""
local j=0

local function BMRZ04VV(i1)	
	Core[(object[i1]..Reg_Block_ID[5])]=tostring(BCD_to_dec(Core[(raw_object[i1]..Reg_Block_ID[2])][0]))    --преобразование Reg_Block_ID
	j=0
	str3=""		
	repeat 
		str3=str3..char_table[Core[(raw_object[i1]..Reg_Slave_ID[2])][j]]
		j=j+1
	until  (Core[(raw_object[i1]..Reg_Slave_ID[2])][j]==163)or(Core[(raw_object[i1]..Reg_Slave_ID[2])][j]==0 or j==0)
	Core[(object[i1]..Reg_Slave_ID[5])]=str3																			--преобразование Reg_Slave_ID
	Core[(object[i1]..Reg_Version[5])]=tostring(BCD_to_dec(Core[(raw_object[i1]..Reg_Version[2])][0])) 		    --преобразование Reg_Version
	str3=""
	if Core[(raw_object[i1]..Reg_Time[2])][7]~=0 then		
		str3=tostring(BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][5])).."."..
			 tostring(BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][6])).."."..
			 tostring(BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][7])).." "..
			 tostring(BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][4]))..":"..
		 	 tostring(BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][3]))..":"..
 			 tostring(BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][2]))		
		local minute,second,msec,two_digit_year,month,day_of_the_month,hour--определение разницы времени
		two_digit_year=os.date("%y")
		month=os.date("%m")
		day_of_the_month=os.date("%d")
		hour=os.date("%H")
		minute=os.date("%M")
		second=os.date("%S")
		msec=os.date("%3N")
		Core[(raw_object[i1].."Diff_Time")]=((msec/1000)+second+(minute*60)+(hour*60*60)+
		(day_of_the_month*60*60*24)+(month*60*60*24*31)+(two_digit_year*60*60*24*31*12))-
		((BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][1])/1000)+
		BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][2])+
		(BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][3])*60)+
		(BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][4])*60*60)+
		(BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][5])*60*60*24)+
		(BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][6])*60*60*24*31)+
		(BCD_to_dec(Core[(raw_object[i1]..Reg_Time[2])][7])*60*60*24*31*12))	
		if math.abs(Core[(raw_object[i1].."Diff_Time")])>60 then 
			Core[(object[i1].."Reg_Time_Set_AV")]=true 
		end	
	end
	Core[(object[i1]..Reg_Time[5])]=str3																				--преобразование Reg_Time
	str3=""
	if Core[(raw_object[i1]..VREMSBROSA_CP[2])][7]~=0 then		
		str3=tostring(BCD_to_dec(Core[(raw_object[i1]..VREMSBROSA_CP[2])][5])).."."..
			 tostring(BCD_to_dec(Core[(raw_object[i1]..VREMSBROSA_CP[2])][6])).."."..
			 tostring(BCD_to_dec(Core[(raw_object[i1]..VREMSBROSA_CP[2])][7])).." "..
			 tostring(BCD_to_dec(Core[(raw_object[i1]..VREMSBROSA_CP[2])][4]))..":"..
		 	 tostring(BCD_to_dec(Core[(raw_object[i1]..VREMSBROSA_CP[2])][3]))..":"..
 			 tostring(BCD_to_dec(Core[(raw_object[i1]..VREMSBROSA_CP[2])][2]))	
	end
	Core[(object[i1]..VREMSBROSA_CP[5])]=str3																			--Астрономическое время последнего сброса накопительной информации
	Core[(object[i1]..ANGLE_AP[5])]=Core[(raw_object[i1]..ANGLE_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_17[2])]--Текущее значение угла между I1 U1 
	Core[(object[i1]..COSFI_AP[5])]=Core[(raw_object[i1]..COSFI_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_22[2])]--Текущее значение cos φ 
	Core[(object[i1]..FREQ__AP[5])]=Core[(raw_object[i1]..FREQ__AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_24[2])]--Текущее значение частоты тока в сети 
	Core[(object[i1]..I0MAX_CP[5])]=Core[(raw_object[i1]..I0MAX_CP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_4[2])]--Максимальное значение тока нулевой последовательности 
	Core[(object[i1]..I0_AP[5])]=Core[(raw_object[i1]..I0_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_4[2])]--Текущее значение тока нулевой последовательности 
	Core[(object[i1]..IACPR_AP[5])]=Core[(raw_object[i1]..IACPR_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_15[2])]--Текущее значение активной составляющей тока прямой последовательности 
	Core[(object[i1]..IAMAXPO_CP[5])]=Core[(raw_object[i1]..IAMAXPO_CP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_1[2])]--Максимальный ток при последнем отключении Фаза A 
	Core[(object[i1]..IAMAX_CP[5])]=Core[(raw_object[i1]..IAMAX_CP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_1[2])]--Максимальное значение тока фазы А 
	Core[(object[i1]..IATEK_AP[5])]=Core[(raw_object[i1]..IATEK_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_1[2])]--Текущее значение тока фазы А 
	Core[(object[i1]..IBMAXPO_CP[5])]=Core[(raw_object[i1]..IBMAXPO_CP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_2[2])]--Максимальный ток при последнем отключении Фаза B 
	Core[(object[i1]..IBMAX_CP[5])]=Core[(raw_object[i1]..IBMAX_CP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_2[2])]--Максимальное значение тока фазы В 
	Core[(object[i1]..IBTEK_AP[5])]=Core[(raw_object[i1]..IBTEK_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_2[2])]--Текущее значение тока фазы В 
	Core[(object[i1]..ICMAXPO_CP[5])]=Core[(raw_object[i1]..ICMAXPO_CP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_3[2])]--Максимальный ток при последнем отключении Фаза C 
	Core[(object[i1]..ICMAX_CP[5])]=Core[(raw_object[i1]..ICMAX_CP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_3[2])]--Максимальное значение тока фазы С 
	Core[(object[i1]..ICTEK_AP[5])]=Core[(raw_object[i1]..ICTEK_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_3[2])]--Текущее значение тока фазы С 
	Core[(object[i1]..IOB_AP[5])]=Core[(raw_object[i1]..IOB_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_12[2])]--Текущее значение тока обратной последовательности 
	Core[(object[i1]..IPR_AP[5])]=Core[(raw_object[i1]..IPR_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_11[2])]--Текущее значение тока прямой последовательности 
	Core[(object[i1]..IREPR_AP[5])]=Core[(raw_object[i1]..IREPR_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_16[2])]--Текущее значение реактивной составляющей тока прямой последовательности 
	Core[(object[i1]..KOLPTZNP_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KOLPTZNP_CP[2])])--Количество пусков ТЗНП 
	Core[(object[i1]..KPAVR_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KPAVR_CP[2])])--Количество пусков АВР 
	Core[(object[i1]..KPDR_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KPDR_CP[2])])--Количество пусков ДР 
	Core[(object[i1]..KPMTZI1ST_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KPMTZI1ST_CP[2])])--Количество пусков МТЗ I>> 
	Core[(object[i1]..KPMTZI2ST_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KPMTZI2ST_CP[2])])--Количество пусков МТЗ I> 
	Core[(object[i1]..KSAVRAV_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KSAVRAV_CP[2])])--Количество срабатываний АВР AB 
	Core[(object[i1]..KSBMTZ_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KSBMTZ_CP[2])])--Количество срабатываний БМТЗ 
	Core[(object[i1]..KSDROTKSV_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KSDROTKSV_CP[2])])--Количество срабатываний ДР на отключение СВ 
	Core[(object[i1]..KSDROTKVV_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KSDROTKVV_CP[2])])--Количество срабатываний ДР на отключение ВВ 
	Core[(object[i1]..KSMTZI1STSV_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KSMTZI1STSV_CP[2])])--Количество срабатываний МТЗ I>> на отключение СВ 
	Core[(object[i1]..KSMTZI1STVV_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KSMTZI1STVV_CP[2])])--Количество срабатываний МТЗ I>> на отключение ВВ 
	Core[(object[i1]..KSMTZI2STK13_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KSMTZI2STK13_CP[2])])--Количество срабатываний МТЗ I> на К 13 
	Core[(object[i1]..KSMTZI2STVV_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KSMTZI2STVV_CP[2])])--Количество срабатываний МТЗ I> на отключение ВВ 
	Core[(object[i1]..KSTZNPSV_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KSTZNPSV_CP[2])])--Количество срабатываний ТЗНП на отключение СВ 
	Core[(object[i1]..KSTZNPVV_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..KSTZNPVV_CP[2])])--Количество срабатываний ТЗНП на отключение ВВ 
	Core[(object[i1]..PAC3F_AP[5])]=Core[(raw_object[i1]..PAC3F_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_19[2])]--Текущее значение активной трехфазной мощности 
	Core[(object[i1]..PACOB_AP[5])]=Core[(raw_object[i1]..PACOB_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_18[2])]--Текущее значение активной составляющей мощности обратной последовательности 
	Core[(object[i1]..PPL3F_AP[5])]=Core[(raw_object[i1]..PPL3F_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_21[2])]--Текущее значение полной трехфазной мощности 
	Core[(object[i1]..PRE3F_AP[5])]=Core[(raw_object[i1]..PRE3F_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_20[2])]--Текущее значение реактивной фазной мощности 
	Core[(object[i1]..SUMIOTKA_CP[5])]=Core[(raw_object[i1]..SUMIOTKA_CP[2])]--Суммарный ток отключений Фаза А 
	Core[(object[i1]..SUMIOTKB_CP[5])]=Core[(raw_object[i1]..SUMIOTKB_CP[2])]--Суммарный ток отключений Фаза B 
	Core[(object[i1]..SUMIOTKC_CP[5])]=Core[(raw_object[i1]..SUMIOTKC_CP[2])]--Суммарный ток отключений Фаза C 
	Core[(object[i1]..SUMKOLOTK_CP[5])]=BCD_to_dec(Core[(raw_object[i1]..SUMKOLOTK_CP[2])])--Суммарное количество отключений 
	Core[(object[i1]..UAS_AP[5])]=Core[(raw_object[i1]..UAS_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_8[2])]--Текущее значение напряжения фазы А (на секции) 
	Core[(object[i1]..UAVV_AP[5])]=Core[(raw_object[i1]..UAVV_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_5[2])]--Текущее значение напряжения фазы А ввода 
	Core[(object[i1]..UBS_AP[5])]=Core[(raw_object[i1]..UBS_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_9[2])]--Текущее значение напряжения фазы В (на секции) 
	Core[(object[i1]..UBVV_AP[5])]=Core[(raw_object[i1]..UBVV_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_6[2])]--Текущее значение напряжения фазы В ввода 
	Core[(object[i1]..UCS_AP[5])]=Core[(raw_object[i1]..UCS_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_10[2])]--Текущее значение напряжения фазы С (на секции) 
	Core[(object[i1]..UCVV_AP[5])]=Core[(raw_object[i1]..UCVV_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_7[2])]--Текущее значение напряжения фазы С ввода 
	Core[(object[i1]..UOBVV_AP[5])]=Core[(raw_object[i1]..UOBVV_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_23[2])]--Текущее значение напряжения напряжения обратной последовательности ввода (до выключателя) 
	Core[(object[i1]..UOB_AP[5])]=Core[(raw_object[i1]..UOB_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_14[2])]--Текущее значение напряжения обратной последовательности. 
	Core[(object[i1]..UPR_AP[5])]=Core[(raw_object[i1]..UPR_AP[2])]*Core[(raw_object[i1]..Reg_NET_KTr_13[2])]--Текущее значение напряжения прямой последовательности. 
	Core[(object[i1]..AVOTK_CP[5])]=Core[(raw_object[i1]..AVOTK_CP[2])]--Аварийное отключение 
	Core[(object[i1]..AVOTK_DP[5])]=Core[(raw_object[i1]..AVOTK_DP[2])]--Аварийное отключение 
	Core[(object[i1]..AVRSVVKL_DP[5])]=Core[(raw_object[i1]..AVRSVVKL_DP[2])]--АВР СВ включено 
	Core[(object[i1]..BLDRBMTZ_DP[5])]=Core[(raw_object[i1]..BLDRBMTZ_DP[2])]--Блокировка функций ДР и БМТЗ при параллельной работе ВВ и АВ 
	Core[(object[i1]..BLOCKAVRAV_DP[5])]=Core[(raw_object[i1]..BLOCKAVRAV_DP[2])]--Блокировка АВР АВ 
	Core[(object[i1]..BMTZ_DP[5])]=Core[(raw_object[i1]..BMTZ_DP[2])]--БМТЗ 
	Core[(object[i1]..DUVKL_DP[5])]=Core[(raw_object[i1]..DUVKL_DP[2])]--ДУ включено 
	Core[(object[i1]..KVIT_DP[5])]=Core[(raw_object[i1]..KVIT_DP[2])]--Квитирование 
	Core[(object[i1]..NBB1_2_DP[5])]=Core[(raw_object[i1]..NBB1_2_DP[2])]--Неисправность цепей управления ВВ1(2) 
	Core[(object[i1]..NBMRZ_CP[5])]=Core[(raw_object[i1]..NBMRZ_CP[2])]--Неисправность БМРЗ 
	Core[(object[i1]..NBMRZ_DP[5])]=Core[(raw_object[i1]..NBMRZ_DP[2])]--Неисправность БМРЗ 
	Core[(object[i1]..NEZVNR_CP[5])]=Core[(raw_object[i1]..NEZVNR_CP[2])]--Незавершенное ВНР 
	Core[(object[i1]..NVV_CP[5])]=Core[(raw_object[i1]..NVV_CP[2])]--Неисправность ВВ 
	Core[(object[i1]..OTKAVRAV_DP[5])]=Core[(raw_object[i1]..OTKAVRAV_DP[2])]--Отключение АВР АВ 
	Core[(object[i1]..OTKAVRSV_CP[5])]=Core[(raw_object[i1]..OTKAVRSV_CP[2])]--Отключение от АВР СВ 
	Core[(object[i1]..OTKKL_DP[5])]=Core[(raw_object[i1]..OTKKL_DP[2])]--Команда «Отключить» от ключа 
	Core[(object[i1]..OTKLSVVNR_DP[5])]=Core[(raw_object[i1]..OTKLSVVNR_DP[2])]--Отключить СВ от ВНР 
	Core[(object[i1]..OTKLSVZASH_DP[5])]=Core[(raw_object[i1]..OTKLSVZASH_DP[2])]--Отключить СВ от защит 
	Core[(object[i1]..OTKLTRAN_DP[5])]=Core[(raw_object[i1]..OTKLTRAN_DP[2])]--Отключить трансформатор 
	Core[(object[i1]..OTKTR_CP[5])]=Core[(raw_object[i1]..OTKTR_CP[2])]--Отключение ТР 
	Core[(object[i1]..OTKVVAVR_CP[5])]=Core[(raw_object[i1]..OTKVVAVR_CP[2])]--Отключение ВВ по АВР 
	Core[(object[i1]..OTKVV_DP[5])]=Core[(raw_object[i1]..OTKVV_DP[2])]--Отключить ВВ 
	Core[(object[i1]..PEREGR_DP[5])]=Core[(raw_object[i1]..PEREGR_DP[2])]--Перегрузка 
	Core[(object[i1]..RAZAVRBMRZ_DP[5])]=Core[(raw_object[i1]..RAZAVRBMRZ_DP[2])]--Разрешение АВР БМРЗ – 0,4ВВ соседней секции 
	Core[(object[i1]..RAZAVRSV2VV_DP[5])]=Core[(raw_object[i1]..RAZAVRSV2VV_DP[2])]--Разрешение АВР СВ второго ввода 
	Core[(object[i1]..RPOVOTK_DP[5])]=Core[(raw_object[i1]..RPOVOTK_DP[2])]--РПО «Выключатель отключен» 
	Core[(object[i1]..RPVVKLST_DP[5])]=Core[(raw_object[i1]..RPVVKLST_DP[2])]--РПВ во включенном состоянии 
	Core[(object[i1]..RPVVKL_DP[5])]=Core[(raw_object[i1]..RPVVKL_DP[2])]--РПВ «Выключатель включен» 
	Core[(object[i1]..RPVVKL_DP_1[5])]=Core[(raw_object[i1]..RPVVKL_DP_1[2])]--РПВ «Выключатель включен» 
	Core[(object[i1]..SIGPDGZ_DP[5])]=Core[(raw_object[i1]..SIGPDGZ_DP[2])]--Сигнал пуска ДгЗ 
	Core[(object[i1]..SIGSRDGZ_DP[5])]=Core[(raw_object[i1]..SIGSRDGZ_DP[2])]--Сигнал срабатывания дуговой защиты 
	Core[(object[i1]..SR1STMTZSV_CP[5])]=Core[(raw_object[i1]..SR1STMTZSV_CP[2])]--Срабатывание первой ступени МТЗ на отключение СВ (МТЗ>>) 
	Core[(object[i1]..SR1STMTZ_CP[5])]=Core[(raw_object[i1]..SR1STMTZ_CP[2])]--Срабатывание первой ступени МТЗ на отключение (МТЗ>>) 
	Core[(object[i1]..SR2STMTZ_CP[5])]=Core[(raw_object[i1]..SR2STMTZ_CP[2])]--Срабатывание второй ступени МТЗ на отключение (МТЗ>>) 
	Core[(object[i1]..SRAVTAVR_DP[5])]=Core[(raw_object[i1]..SRAVTAVR_DP[2])]--Срабатывание автоматики АВР 
	Core[(object[i1]..SRCHSTMTZ_CP[5])]=Core[(raw_object[i1]..SRCHSTMTZ_CP[2])]--Срабатывание чувствительной ступени МТЗ (Перегрузка) 
	Core[(object[i1]..SRDROTKSV_CP[5])]=Core[(raw_object[i1]..SRDROTKSV_CP[2])]--Срабатывание ДР на отключение СВ 
	Core[(object[i1]..SRDROTK_CP[5])]=Core[(raw_object[i1]..SRDROTK_CP[2])]--Срабатывание ДР на отключение 
	Core[(object[i1]..SRTZNPOTKSV_CP[5])]=Core[(raw_object[i1]..SRTZNPOTKSV_CP[2])]--Срабатывание ТЗНП на отключение СВ 
	Core[(object[i1]..SRTZNPOTK_CP[5])]=Core[(raw_object[i1]..SRTZNPOTK_CP[2])]--Срабатывание ТЗНП на отключение 
	Core[(object[i1]..SVOTK_DP[5])]=Core[(raw_object[i1]..SVOTK_DP[2])]--СВ отключен 
	Core[(object[i1]..SVVKL_DP[5])]=Core[(raw_object[i1]..SVVKL_DP[2])]--СВ включен 
	Core[(object[i1]..TELVVVIK_DP[5])]=Core[(raw_object[i1]..TELVVVIK_DP[2])]--Тележка ВВ выкачена 
	Core[(object[i1]..TTRPOV_DP[5])]=Core[(raw_object[i1]..TTRPOV_DP[2])]--Температура трансформатора повышена (устанавливается в единицу при превышении порогового уровня температуры) 
	Core[(object[i1]..VIZKTP_DP[5])]=Core[(raw_object[i1]..VIZKTP_DP[2])]--Вызов в КТП 
	Core[(object[i1]..VKLAVRAV_DP[5])]=Core[(raw_object[i1]..VKLAVRAV_DP[2])]--Включение по АВР АВ 
	Core[(object[i1]..VKLKL_DP[5])]=Core[(raw_object[i1]..VKLKL_DP[2])]--Команда «Включить» от ключа 
	Core[(object[i1]..VKLSVAVRAV_DP[5])]=Core[(raw_object[i1]..VKLSVAVRAV_DP[2])]--Включить СВ по АВР АВ 
	Core[(object[i1]..VKLVV_DP[5])]=Core[(raw_object[i1]..VKLVV_DP[2])]--Включить ВВ 
	Core[(object[i1]..VNR_CP[5])]=Core[(raw_object[i1]..VNR_CP[2])]--ВНР 
	Core[(object[i1]..VOTK_DP[5])]=Core[(raw_object[i1]..VOTK_DP[2])]--Выключатель отключен 
	Core[(object[i1]..VVKL_DP[5])]=Core[(raw_object[i1]..VVKL_DP[2])]--Выключатель включен
	Core[(object[i1]..ZAPAVRVNZ_DP[5])]=Core[(raw_object[i1]..ZAPAVRVNZ_DP[2])]--Запрет АВР от внешних защит
	Core[(object[i1]..OTKKL_DP[5])]=Core[(raw_object[i1]..OTKKL_DP[2])]--Команда «Отключить» от ключа
	Core[(object[i1]..VKLKL_DP[5])]=Core[(raw_object[i1]..VKLKL_DP[2])]--Команда «Включить» от ключа  	
end




for i=1,(#raw_object) do --цикл для установки обработчика на изменение группы сигналов всех приборов
Core.onExtChange({
raw_object[i]..Reg_Block_ID[2],
raw_object[i]..Reg_Slave_ID[2],
raw_object[i]..Reg_Version[2],
raw_object[i]..Reg_Time[2],
raw_object[i]..VREMSBROSA_CP[2],
raw_object[i]..ANGLE_AP[2],
raw_object[i]..AVOTK_CP[2],
raw_object[i]..AVOTK_DP[2],
raw_object[i]..AVRSVVKL_DP[2],
raw_object[i]..BLDRBMTZ_DP[2],
raw_object[i]..BLOCKAVRAV_DP[2],
raw_object[i]..BMTZ_DP[2],
raw_object[i]..COSFI_AP[2],
raw_object[i]..DUVKL_DP[2],
raw_object[i]..FREQ__AP[2],
raw_object[i]..I0MAX_CP[2],
raw_object[i]..I0_AP[2],
raw_object[i]..IACPR_AP[2],
raw_object[i]..IAMAXPO_CP[2],
raw_object[i]..IAMAX_CP[2],
raw_object[i]..IATEK_AP[2],
raw_object[i]..IBMAXPO_CP[2],
raw_object[i]..IBMAX_CP[2],
raw_object[i]..IBTEK_AP[2],
raw_object[i]..ICMAXPO_CP[2],
raw_object[i]..ICMAX_CP[2],
raw_object[i]..ICTEK_AP[2],
raw_object[i]..IOB_AP[2],
raw_object[i]..IPR_AP[2],
raw_object[i]..IREPR_AP[2],
raw_object[i]..KOLPTZNP_CP[2],
raw_object[i]..KPAVR_CP[2],
raw_object[i]..KPDR_CP[2],
raw_object[i]..KPMTZI1ST_CP[2],
raw_object[i]..KPMTZI2ST_CP[2],
raw_object[i]..KSAVRAV_CP[2],
raw_object[i]..KSBMTZ_CP[2],
raw_object[i]..KSDROTKSV_CP[2],
raw_object[i]..KSDROTKVV_CP[2],
raw_object[i]..KSMTZI1STSV_CP[2],
raw_object[i]..KSMTZI1STVV_CP[2],
raw_object[i]..KSMTZI2STK13_CP[2],
raw_object[i]..KSMTZI2STVV_CP[2],
raw_object[i]..KSTZNPSV_CP[2],
raw_object[i]..KSTZNPVV_CP[2],
raw_object[i]..KVIT_DP[2],
raw_object[i]..NBB1_2_DP[2],
raw_object[i]..NBMRZ_CP[2],
raw_object[i]..NBMRZ_DP[2],
raw_object[i]..NEZVNR_CP[2],
raw_object[i]..NVV_CP[2],
raw_object[i]..OTKAVRAV_DP[2],
raw_object[i]..OTKAVRSV_CP[2],
raw_object[i]..OTKKL_DP[2],
raw_object[i]..OTKLSVVNR_DP[2],
raw_object[i]..OTKLSVZASH_DP[2],
raw_object[i]..OTKLTRAN_DP[2],
raw_object[i]..OTKTR_CP[2],
raw_object[i]..OTKVVAVR_CP[2],
raw_object[i]..OTKVV_DP[2],
raw_object[i]..PAC3F_AP[2],
raw_object[i]..PACOB_AP[2],
raw_object[i]..PEREGR_DP[2],
raw_object[i]..PPL3F_AP[2],
raw_object[i]..PRE3F_AP[2],
raw_object[i]..RAZAVRBMRZ_DP[2],
raw_object[i]..RAZAVRSV2VV_DP[2],
raw_object[i]..RPOVOTK_DP[2],
raw_object[i]..RPVVKLST_DP[2],
raw_object[i]..RPVVKL_DP[2],
raw_object[i]..RPVVKL_DP_1[2],
raw_object[i]..SIGPDGZ_DP[2],
raw_object[i]..SIGSRDGZ_DP[2],
raw_object[i]..SR1STMTZSV_CP[2],
raw_object[i]..SR1STMTZ_CP[2],
raw_object[i]..SR2STMTZ_CP[2],
raw_object[i]..SRAVTAVR_DP[2],
raw_object[i]..SRCHSTMTZ_CP[2],
raw_object[i]..SRDROTKSV_CP[2],
raw_object[i]..SRDROTK_CP[2],
raw_object[i]..SRTZNPOTKSV_CP[2],
raw_object[i]..SRTZNPOTK_CP[2],
raw_object[i]..SUMIOTKA_CP[2],
raw_object[i]..SUMIOTKB_CP[2],
raw_object[i]..SUMIOTKC_CP[2],
raw_object[i]..SUMKOLOTK_CP[2],
raw_object[i]..SVOTK_DP[2],
raw_object[i]..SVVKL_DP[2],
raw_object[i]..TELVVVIK_DP[2],
raw_object[i]..TTRPOV_DP[2],
raw_object[i]..UAS_AP[2],
raw_object[i]..UAVV_AP[2],
raw_object[i]..UBS_AP[2],
raw_object[i]..UBVV_AP[2],
raw_object[i]..UCS_AP[2],
raw_object[i]..UCVV_AP[2],
raw_object[i]..UOBVV_AP[2],
raw_object[i]..UOB_AP[2],
raw_object[i]..UPR_AP[2],
raw_object[i]..VIZKTP_DP[2],
raw_object[i]..VKLAVRAV_DP[2],
raw_object[i]..VKLKL_DP[2],
raw_object[i]..VKLSVAVRAV_DP[2],
raw_object[i]..VKLVV_DP[2],
raw_object[i]..VNR_CP[2],
raw_object[i]..VOTK_DP[2],
raw_object[i]..Reg_NET_KTr_1[2],
raw_object[i]..Reg_NET_KTr_2[2],
raw_object[i]..Reg_NET_KTr_3[2],
raw_object[i]..Reg_NET_KTr_4[2],
raw_object[i]..Reg_NET_KTr_5[2],
raw_object[i]..Reg_NET_KTr_6[2],
raw_object[i]..Reg_NET_KTr_7[2],
raw_object[i]..Reg_NET_KTr_8[2],
raw_object[i]..Reg_NET_KTr_9[2],
raw_object[i]..Reg_NET_KTr_10[2],
raw_object[i]..Reg_NET_KTr_11[2],
raw_object[i]..Reg_NET_KTr_12[2],
raw_object[i]..Reg_NET_KTr_13[2],
raw_object[i]..Reg_NET_KTr_14[2],
raw_object[i]..Reg_NET_KTr_15[2],
raw_object[i]..Reg_NET_KTr_16[2],
raw_object[i]..Reg_NET_KTr_17[2],
raw_object[i]..Reg_NET_KTr_18[2],
raw_object[i]..Reg_NET_KTr_19[2],
raw_object[i]..Reg_NET_KTr_20[2],
raw_object[i]..Reg_NET_KTr_21[2],
raw_object[i]..Reg_NET_KTr_22[2],
raw_object[i]..Reg_NET_KTr_23[2],
raw_object[i]..Reg_NET_KTr_24[2],
raw_object[i]..VVKL_DP[2],
raw_object[i]..ZAPAVRVNZ_DP[2]
},BMRZ04VV,i)
end
Core.waitEvents( )
