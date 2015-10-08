local RepareMode=false -- режим "в Ремонте"
local DRFlag -- флаг достоверности данных
local Log=true -- ведение логов сообщений
local old_DRFlag -- предыдущее значение флага достоверности данных
local oldsignal = {} -- буферная таблица  предыдущего состояния входов
local old_analog_signal_status = {} -- буферная таблица  предыдущего состояния сигнализации аналоговых входов
--local user=Core["USER_NAME_OUT"] -- текущее имя  пользователя
local user=""
local ScreenID_KOT="S_TVS_KOT" -- идентификатор мнемосхемы котельной
local ScreenID_UTO="S_TVS_UTO" -- идентификатор мнемосхемы котла-утилизатора
local ScreenID_VOD="S_TVS_VOD" -- идентификатор мнемосхемы водоснабжения
local ScreenID_KNS="S_TVS_KNS" -- идентификатор мнемосхемы водоотведения
local ObjID="S_TVS_P01_" -- идентификатор технологического объекта
local sig_source="АСУ Э,Панель №2 " --описание технологического объекта
local time_source ="(Сервер)" -- место присвоения сигналу метки времени
local DRFlag = Core["S_TVS_DS_DP"]--  флаг достоверности данных от контроллера ТВС
local old_DRFlag = DRFlag -- предыдущее значение флага достоверности данных
local TagList={ --перечень всех тегов приложения
       "VOS_RESVREM",
       "VOS_M5AVAR",
       "VOS_NASA1OSN",
       "VOS_NASA1RES",
       "VOS_NASA2OSN",
       "VOS_NASA2RES",
       "VOS_NASA1AVAR",
       "VOS_NASA2AVAR",
       "VOS_VAVARURRES",
       "VOS_NSPVSHOD",
       "VOS_A1NASVKL",
       "VOS_A1TMIN",
       "VOS_A1DVOTK",
       "VOS_A1NASOSN",
       "VOS_A1NASRES",
       "VOS_A2NASVKL",
       "VOS_A2DVOTK",
       "VOS_A2NASOSN",
       "VOS_A2NASRES",
       "VOS_M5ZAKR",
       "VOS_M5OTKR",
       "VOS_MOTKR",
       "VOS_MZAKR",
       "VOS_NPPVHAVAR",
       "VOS_NPPVFIRE",
       "VOS_NPPVPAVAR",
       "VOS_NPPVNASVKL",
       "VOS_PULT",
       "VOS_SAU",
       "VOS_RESUROV",
       "VOS_A1PRESS",
       "VOS_A2PRESS",
       "KOT_KOTELVKL",
       "KOT_SETNASVKL",
       "KOT_SETNASAVAR",
       "KOT_RECNASVKL",
       "KOT_OTKLOTKR",
       "KOT_P1PRESS",
       "KOT_P2PRESS",
       "KOT_P1TEMP",
       "KOT_P2TEMP",
       "KU_SHIBOTKR",
       "KU_SHIBZAKR",
       "KU_P1PRESS",
       "KU_P2PRESS",
       "KU_P1TEMP",
       "KU_P2TEMP",
       "KNS_SAUAVT",
       "KNS_NASVKL",
       "KNS_NASAVAR",
       "KNS_KOSVRAB",
       "KNS_KOSNEIS",
       "KNS_RESUROV",

} --of TagList
local AP_alarms={ -- наличие алармов аналоговых сигналов
-- 0 - нет тревог
-- 1 - нижний аварийный
-- 2- нижний предупредительный
-- 3 -верхний предупредительный
-- 4 - верхний аварийный
-- по умолчанию тревог нет
--		VOS_RESUROV =0,		
--		VOS_A1PRESS=0,
--		VOS_A2PRESS=0,
--		KOT_P1PRESS=0,
--		KOT_P1TEMP=0,
--		KOT_P2PRESS=0,	
--		KOT_P2TEMP=0,
--		KU_P1PRESS=0,
--		KU_P1TEMP=0,
--		KU_P2PRESS=0,
--		KU_P2TEMP=0,
--		KNS_RESUROV=0,
			} -- of AP_alarms
local old_AP_alarms={ -- предыдущие значения алармов аналоговых сигналов
	--	VOS_RESUROV =0,		
--		VOS_A1PRESS=0,
--		VOS_A2PRESS=0,
--		KOT_P1PRESS=0,
--		KOT_P1TEMP=0,
--		KOT_P2PRESS=0,	
--		KOT_P2TEMP=0,
--		KU_P1PRESS=0,
--		KU_P1TEMP=0,
--		KU_P2PRESS=0,
--		KU_P2TEMP=0,
--		KNS_RESUROV=0,
			} -- of old_AP_alarms
local AP_P= { --границы тревоги аналоговых сигналов
		["VOS_RESUROV"]={ --уровень в резервуаре 
				["WL"]=2,
				["WH"]=7,
				["AL"]=1,
				["AH"]=8,},		
		["VOS_A1PRESS"]={ --давление насос артскв 1
				["WL"]=nil, -- не определено
				["WH"]=800,
				["AL"]=nil,
				["AH"]=1000,},	
		["VOS_A2PRESS"]={ --давление насос артскв 2
				["WL"]=nil,
				["WH"]=800,
				["AL"]=nil,
				["AH"]=1000,},	
		["KOT_P1PRESS"]={ --ТДавление прямоточной воды
				["WL"]=nil,
				["WH"]=800,
				["AL"]=nil,
				["AH"]=1000,},	
		["KOT_P1TEMP"]={ --КОТ Температура прямоточной воды
				["WL"]=10,
				["WH"]=110,
				["AL"]=0,
				["AH"]=120,},
		["KOT_P2PRESS"]={ --КОТ Давление обратной воды
				["WL"]=nil,
				["WH"]=800,
				["AL"]=nil,
				["AH"]=1000,},	
		["KOT_P2TEMP"]={ --КОТ Температура обратной воды
				["WL"]=40,
				["WH"]=110,
				["AL"]=0,
				["AH"]=120,},
		["KU_P1PRESS"]={ -- КУ Давление прямоточной воды
				["WL"]=nil,
				["WH"]=800,
				["AL"]=nil,
				["AH"]=1000,},	
		["KU_P1TEMP"]={ --КУ Температура прямоточной воды
				["WL"]=40,
				["WH"]=110,
				["AL"]=0,
				["AH"]=120,},
		["KU_P2PRESS"]={ --КУ Давление обратной воды
				["WL"]=nil,
				["WH"]=800,
				["AL"]=nil,
				["AH"]=1000,},	
		["KU_P2TEMP"]={ --КУ Температура обратной воды
				["WL"]=40,
				["WH"]=110,
				["AL"]=0,
				["AH"]=120,},
		["KNS_RESUROV"]={ --КНС уровень
				["WL"]=nil,
				["WH"]=90,
				["AL"]=nil,
				["AH"]=100,},

		} -- of AP_P


local event ={  --таблица типов событий
		a=10000 , --аварии
		w=10100, --предупреждения
		s=101,  --телесигнализация
		c=100, --команды
		dr=30100, -- достоверность сигнала
		}

local event_class= {
--ВОС
         VOS_RESVREM=event.s,
         VOS_M5AVAR=event.a,
         VOS_NASA1OSN=event.s,
         VOS_NASA1RES=event.s,
         VOS_NASA2OSN=event.s,
         VOS_NASA2RES=event.a,
         VOS_NASA1AVAR=event.a,
         VOS_NASA2AVAR=event.a,
         VOS_VAVARURRES=event.a,
         VOS_NSPVSHOD=event.a,
         VOS_A1NASVKL=event.s,
         VOS_A1TMIN=event.a,
         VOS_A1DVOTK=event.w,
         VOS_A1NASOSN=event.s,
         VOS_A1NASRES=event.s,
         VOS_A2NASVKL=event.s,
         VOS_A2DVOTK=event.w,
         VOS_A2NASOSN=event.s,
         VOS_A2NASRES=event.s,
         VOS_M5ZAKR=event.s,
         VOS_M5OTKR=event.s,
         VOS_MOTKR=event.s,
         VOS_MZAKR=event.s,
         VOS_NPPVHAVAR=event.a,
         VOS_NPPVFIRE=event.a,
         VOS_NPPVPAVAR=event.a,
         VOS_NPPVNASVKL=event.s,
         VOS_PULT=event.s,
         VOS_SAU=event.s,
--Котельная
         KOT_KOTELVKL=event.s,
         KOT_SETNASVKL=event.s,
         KOT_SETNASAVAR=event.a,
         KOT_RECNASVKL=event.s,
         KOT_OTKLOTKR=event.s,
--котел-утилизатор
         KU_SHIBOTKR=event.s,
         KU_SHIBZAKR=event.s,
--КНС
         KNS_SAUAVT=event.s,
         KNS_NASVKL=event.s,
         KNS_NASAVAR=event.a,
         KNS_KOSVRAB=event.s,
         KNS_KOSNEIS=event.a,
} -- event_class

local msg= { -- выводимые в журнал сообщения
--ВОС     
	     VOS_RESVREM="ВОС_Резервуар в ремонте",
         VOS_M5AVAR="ВОС_М5_Затвор М5 - АВАРИЯ",
         VOS_NASA1OSN="ВОС_А1_Насосный агрегат - РАБОЧИЙ",
         VOS_NASA1RES="ВОС_А1_Насосный агрегат - РЕЗЕРВНЫЙ",
         VOS_NASA2OSN="ВОС_А2_Насосный агрегат - РАБОЧИЙ",
         VOS_NASA2RES="ВОС_А2_Насосный агрегат - РЕЗЕРВНЫЙ",
         VOS_NASA1AVAR="ВОС_А1_Насосный агрегат - АВАРИЯ",
         VOS_NASA2AVAR="ВОС_А2_Насосный агрегат - АВАРИЯ",
         VOS_VAVARURRES="ВОС_РЕЗ_Уровень воды ВЕРХНИЙ АВАРИЙНЫЙ",
         VOS_NSPVSHOD="ВОС_НСПВ_Насосная станция противопожарного водоснабжения СУХОЙ ХОД",
         VOS_A1NASVKL="ВОС_А1_Насос артскважины 1 ВКЛЮЧЕН",
         VOS_A1TMIN="ВОС_А1_Т воздуха в помещении насосной артскважины 1 <+3C",
         VOS_A1DVOTK="ВОС_А1_Т дверь в помещении насосной артскважины 1открыта",
         VOS_A1NASOSN="ВОС_А1_Насосный агрегат - РАБОЧИЙ",
         VOS_A1NASRES="ВОС_А1_Насосный агрегат - РЕЗЕРВНЫЙ",
         VOS_A2NASVKL="ВОС_А2_Насос артскважины 2 ВКЛЮЧЕН",
         VOS_A2DVOTK="ВОС_А2_Т дверь в помещении насосной артскважины 2 открыта",
         VOS_A2NASOSN="ВОС_А2_Насосный агрегат - РАБОЧИЙ",
         VOS_A2NASRES="ВОС_А2_Насосный агрегат - РЕЗЕРВНЫЙ",
         VOS_M5ZAKR="ВОС_М5_Затвор М5 ЗАКРЫТ",
         VOS_M5OTKR="ВОС_М5_Затвор М5 ОТКРЫТ",
         VOS_MOTKR="ВОС_М_Затвор М ОТКРЫТ",
         VOS_MZAKR="ВОС_М_Затвор М ЗАКРЫТ",
         VOS_NPPVHAVAR="ВОС_НППВ_Насосная станция хозпитьевого водоснабжения АВАРИЯ",
         VOS_NPPVFIRE="ВОС_НППВ_Насосная станция противопожарного водоснабжения ПОЖАР",
         VOS_NPPVPAVAR="ВОС_НППВ_Насосная станция противопожарного водоснабжения АВАРИЯ",
         VOS_NPPVNASVKL="ВОС_НППВ_Насосная станция противопожарного водоснабжения Пожарный Насос ВКЛЮЧЕН",
         VOS_PULT="ВОС_Система водоснабжения с пульта оператора",
         VOS_SAU="ВОС_Система водоснабжения от САУ ВОС",
         --аналоговые
         VOS_RESUROV="ВОС_AP_РЕЗ_Уровень воды",
         VOS_A1PRESS="ВОС_AP_А1_Насосный агрегат - Давление воды",
         VOS_A2PRESS="ВОС_AP_А2_Насосный агрегат - Давление воды ",

--Котельная
         KOT_KOTELVKL="КОТ_Котел включен",
         KOT_SETNASVKL="КОТ_Сетевой насос включен",
         KOT_SETNASAVAR="КОТ_Авария сетевого насоса",
         KOT_RECNASVKL="КОТ_Рециркулярционный насос включен",
         KOT_OTKLOTKR="КОТ_Отсечной клапан открыт",
		  --аналоговые	
		 KOT_P1PRESS="КОТ_Давление прямоточной воды",
         KOT_P2PRESS="КОТ_Давление обратной воды",
         KOT_P1TEMP="КОТ_Температура прямоточной воды",
         KOT_P2TEMP="КОТ_Температура обратной воды",

--котел-утилизатор
         KU_SHIBOTKR="КУ_Шибер открыт",
		 KU_SHIBZAKR="КУ_Шибер закрыт",
		 --аналоговые
		 KU_P1PRESS="AI_КУ_Давление прямоточной воды",
         KU_P2PRESS="AI_КУ_Давление обратной воды ",
         KU_P1TEMP="AI_КU_Температура прямоточной воды",
         KU_P2TEMP="AI_КU_Температура обратной воды",


--КНС
         KNS_SAUAVT="КНС_Автоматический режим работы САУ КНС включен",
         KNS_NASVKL="КНС_Насос КНС включен",
         KNS_NASAVAR="КНС_Авария насоса КНС",
         KNS_KOSVRAB="КОС_КОС в работе",
         KNS_KOSNEIS="КОС_Неисправность КОС",
		 --аналоговые
		 KNS_RESUROV="AI_КНС_Уровень стоков в приёмном резервуаре",

} -- of msg

local function Check_Repare_Mode()

		RepareMode=Core["S_TVS_P01_Repare_DP"] -- проверяем флаг


end -- of Check_Repare_Mode

local function Check_Data_Reliability ()-- функция проверки достоверности сигналов и выдачи соответствующих сообщений
	local time_source=" (Сервер)"
	local DRFlag=Core["S_TVS_DS_DP"] -- флаг наличия соединения с контроллером Data_Reliability_Flag
	local DT=os.time()	
	if old_DRFlag==nil or old_DRFlag~=DRFlag then --если сигнал недостоверности изменился
		local i=1 -- счетчик цикла
		local Tag -- текущий тэг из списка 
		while TagList[i]~=nil do -- пока сигналы в списке не кончатся
			if TagList[i]~=nil then Tag=TagList[i] else break end -- очередной тэг	
			if 	msg[Tag]==nil then break end
		  	if DRFlag>0 then -- проверка появления сигнала недостоверности	
			    	Core.addEvent("НЕДОСТОВЕРНО: " .. msg[Tag], event.dr, 1, sig_source..time_source, user, "DRF_"..ObjID..Tag.."_DP_1", DT, ScreenID) --  добавляем событие (появление), текст берем в таблице msg, класс сообщения в таблице event_class
					if Log then	Core.addLogMsg(os.date().." ".."(Появл) НЕДОСТОВЕРНО: " .. msg[Tag])end
		  	end --проверки появления сигнала недостоверности	
		    if DRFlag==0 then -- проверка исчезновения сигнала-- недостоверности
				Core.addEvent("НЕДОСТОВЕРНО: " .. msg[Tag] , event.dr , 0, sig_source..time_source, user, "DRF_"..ObjID..Tag.."_DP_0", DT, ScreenID) --добавляем событие (исчезновение)
				if Log then	Core.addLogMsg(os.date().." ".."(Исчезн) НЕДОСТОВЕРНО: " .. msg[Tag]) end
	  	    end --проверка исчезновения сигнала недостоверности
			i=i+1 -- следующий!!!
		  end --of while
		  old_DRFlag = DRFlag -- запоминаем текущее состояние сигнала
	end -- если сигнал недостоверности изменился	 	 						 
end -- of Check_Data_Reliability 

		

local function Check_Analog_Alarm(Tag,screen_id)-- функция проверки выхода аналоговых сигналов за границы алармов и добавления события по сигналу Tag со значением в журнал
						
-- при первом запуске обнуляем статусы
						local MsgBlock=false 
						local old_signal=Core["RAW_TVS_"..Tag.."_AP"] -- буферное значение сигнала
						os.sleep(0.8) -- ждем  чтобы исключить дребезг 
						local signal=Core["RAW_TVS_"..Tag.."_AP"] -- повторно считываем значение сигнала
						if AP_alarms[Tag]==nil then AP_alarms[Tag]=0 end
						
						if old_AP_alarms[Tag]==nil then old_AP_alarms[Tag]=0 end
						local AlarmLow
						if AP_P[Tag].AL==nil then AlarmLow=nil else AlarmLow=AP_P[Tag].AL end
						local AlarmHigh
						if AP_P[Tag].AH==nil then AlarmHigh=nil else AlarmHigh=AP_P[Tag].AH end
						local WarningLow
						if AP_P[Tag].WL==nil then WarningLow=nil else WarningLow=AP_P[Tag].WL end
						local WarningHigh
						if AP_P[Tag].WH==nil then WarningHigh=nil else WarningHigh=AP_P[Tag].WH end
						local text_prefix ={"Нижний аварийный уровень: ", "Нижний предупредительный уровень: ", "Верхний предупредительный уровень: ", "Верхний аварийный уровень: "}
						local old_text
						local text
						local event_class -- класс текущего события
						local old_event_class -- класс предыдущего события
						local DT=os.time() -- время события (локальное)
						local e_type -- тип события (появление\исчезновение)
			-- определяем тип события
-- 0 - нет тревог
-- 1 - нижний аварийный
-- 2- нижний предупредительный
-- 3 -верхний предупредительный
-- 4 - верхний аварийный
-- по умолчанию тревог нет
						local tmpWarningLow -- временная подмена границ (если не определены)
						local tmpWarningHigh
						if WarningLow~=nil then tmpWarningLow=WarningLow else tmpWarningLow=-1 end -- если не определено - обнулим временно
						if WarningHigh~=nil then tmpWarningHigh=WarningHigh else tmpWarningHigh=65534 end -- если не определено - max
-- определяем статус тревоги (текущий)
						if signal <=old_signal and signal > tmpWarningLow and signal < tmpWarningHigh then AP_alarms[Tag]=0 end -- сигнал изменился и не вышел за границы уставок
						if AlarmLow ~=nil then	-- ЕСЛИ ГРАНИЦА ОПРЕДЕЛЕНА
							if signal <=old_signal and signal <= AlarmLow then AP_alarms[Tag]=1 end -- сигнал изменился и меньше нижнего аварийного порога
						end -- AlarmLow
						if WarningLow ~=nil then	-- ЕСЛИ ГРАНИЦА ОПРЕДЕЛЕНА
							if signal <=old_signal and signal <= WarningLow and signal > AlarmLow then  AP_alarms[Tag]=2  end -- сигнал изменился, стал меньше нижнего предупредительного порога, но больше аварийного
						end
						if WarningHigh ~=nil then	-- ЕСЛИ ГРАНИЦА ОПРЕДЕЛЕНА	
							if signal >=old_signal and signal >= WarningHigh and  signal< AlarmHigh then AP_alarms[Tag]=3  end -- сигнал больше верхнего предупредительного порога
						end
						if AlarmHigh ~=nil then	-- ЕСЛИ ГРАНИЦА ОПРЕДЕЛЕНА
							if signal >=old_signal and signal >= AlarmHigh then AP_alarms[Tag]=4 end -- сигнал больше верхнего аварийного порога
						end

						-- -- выбираем подходящий текст для события
						local tmp		
						if AP_alarms[Tag]~=0 then 
								tmp=AP_alarms[Tag]
								text=text_prefix[tmp] 
						else	
								text="Значение в пределах нормы: "
						end		
						if 	old_AP_alarms[Tag]~=0 then 
							tmp=old_AP_alarms[Tag]
							old_text=text_prefix[tmp]
						else
							old_text="Значение в пределах нормы: "
						end 
						

			-- определяем класс текущего события
						if AP_alarms[Tag]==nil or AP_alarms[Tag]<=0 then 
									event_class=event.s --телесигнализация
						else 
									if AP_alarms[Tag]>0 and AP_alarms[Tag]<= 2 then 
										event_class=event.w -- предупреждение
									else 
										if 	AP_alarms[Tag]>=3  and AP_alarms[Tag]<=4 then 
											event_class=event.a -- авария
										else if AP_alarms[Tag] > 4 then event_class=event.dr end  -- всё что далее - недостоверно
										end							
									end 
						end   
	-- определяем класс предыдущего события
						if old_AP_alarms[Tag]==nil or old_AP_alarms[Tag]<=0 then 
									old_event_class=event.s --телесигнализация
						else 
									if old_AP_alarms[Tag]>0 and old_AP_alarms[Tag]<=2 then 
										old_event_class=event.w -- предупреждение
									else 
										if 	old_AP_alarms[Tag]>=3 and old_AP_alarms[Tag]<= 4 then 
											old_event_class=event.a -- авария
										else if old_AP_alarms[Tag]> 4 then old_event_class=event.dr end  -- всё что далее - недостоверно
										end							
									end 
						end   

		
			-- формируем строки события
						if AP_alarms[Tag]~=old_AP_alarms[Tag] then -- событие ещё не наступало
							if  old_AP_alarms[Tag]~=0  then -- прежде сигнал уже вышел за уставки, то делаем исчезновение предыдущего события
								Core.addEvent(old_text..msg[Tag], old_event_class , 0, sig_source..time_source, user, ObjID..Tag.."_AP_0", DT, screen_id) --  добавляем событие , текст берем в таблице msg, класс сообщения в таблице event_class
								if Log then	Core.addLogMsg(os.date().." ".."(Исчезн.) " .. old_text..msg[Tag].. " - " ..screen_id ) end--log
							end  -- прежде сигнал уже вышел за уставки, то делаем исчезновение предыдущего события
							-- новое событие
							if  AP_alarms[Tag]~=0  then -- если сигнал не вернулся в нормальные пределы
								Core.addEvent(text..msg[Tag], event_class , 1, sig_source..time_source, user, ObjID..Tag.."_AP_1", DT, screen_id) --  добавляем событие, текст берем в таблице msg, класс сообщения в таблице event_class
								if Log then	Core.addLogMsg(os.date().." ".."(Появл.) " .. text..msg[Tag].. " - " ..screen_id ) end--log
							end	 -- если сигнал не вернулся в нормальные пределы
						end --событие ещё не наступало
old_AP_alarms[Tag]=AP_alarms[Tag] --сохраняем статус сигнала
end -- Add_Analog_Alarm

local function Add_Event (Tag, signal, screen_id)-- функция добавления события по сигналу Tag со значением signal в журнал
     					local DT=os.time() -- время события (локальное)
						local e_type -- тип события (появление\исчезновение)
						if signal then 
							e_type=1
							if Log then Core.addLogMsg(os.date().." ".."(Появл.) " .. msg[Tag] .. " - " ..screen_id) end --добавление события в лог 
						else
							 e_type=0
							if Log then Core.addLogMsg(os.date().." ".."(Исчезн.) " .. msg[Tag].. " - " ..screen_id) end --добавление события в лог 
						end 						-- определение типа события (появление\ исчезновение)
					    if oldsignal[Tag]==nil or oldsignal[Tag]~=signal then --если сигнал изменился
		 		  				 Core.addEvent(msg[Tag], event_class[Tag] , e_type, sig_source..time_source, user, ObjID..Tag.."_DP_"..e_type, DT, screen_id) --  добавляем событие (типа e_type), текст берем в таблице msg, класс сообщения в таблице event_class
								 
	   	 			    end -- если сигнал изменился  				 
end -- of Add_Event



--Объявление структуры, в которой левая часть до знака = это массив сигналов а правая часть - это массив переменных, передаваемых в SCADA систему
local blocks
local objects = {
	["RAW_TVS_"]="S_TVS_"
}

local signals = {
	-- Объявление переменных в виде структуры где левая часть до знака = это Suffix, правая часть это Descriptor. Descriptor в свою очередь представляет собой структуру
	-- в которой первый элемент это комментарий Comment, второй элемент это функция eval. В функциях происходит преобразование значений сигналов из регистров, и присваивание этих
	-- преобразованных значений переменным, передаваемым в SCADA систему
-- //-----------------------------//--
--//      ДИСКРЕТНЫЕ СИГНАЛЫ      //--
--//------------------------------//--
--водоснабжение      
  ["VOS_RESVREM_DP"]= {	["Comment"]=sig_source..msg.VOS_RESVREM,
		["eval"]= 
			function(Name) 
				local Tag="VOS_RESVREM"
				local signal= Core[Name[1]..Tag.."_DP"] -- получаем значение сигнала из драйвера
				Add_Event (Tag, signal, "S_TVS_VOD") -- запись события в журнал
				Core[Name[2]..Tag.."_DP"]=signal -- передаем значение сигнала в проект
				oldsignal[Tag] = signal -- запоминаем текущее состояние сигнала в буферной таблице
			end }, --of eval
        ["VOS_M5AVAR_DP"]= {["Comment"]=sig_source..msg.VOS_M5AVAR,["eval"]= function(Name)  local Tag="VOS_M5AVAR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_NASA1OSN_DP"]= {["Comment"]=sig_source..msg.VOS_NASA1OSN,["eval"]= function(Name)  local Tag="VOS_NASA1OSN" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_NASA1RES_DP"]= {["Comment"]=sig_source..msg.VOS_NASA1RES,["eval"]= function(Name)  local Tag="VOS_NASA1RES" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_NASA2OSN_DP"]= {["Comment"]=sig_source..msg.VOS_NASA2OSN,["eval"]= function(Name)  local Tag="VOS_NASA2OSN" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_NASA2RES_DP"]= {["Comment"]=sig_source..msg.VOS_NASA2RES,["eval"]= function(Name)  local Tag="VOS_NASA2RES" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_NASA1AVAR_DP"]= {["Comment"]=sig_source..msg.VOS_NASA1AVAR,["eval"]= function(Name)  local Tag="VOS_NASA1AVAR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_NASA2AVAR_DP"]= {["Comment"]=sig_source..msg.VOS_NASA2AVAR,["eval"]= function(Name)  local Tag="VOS_NASA2AVAR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_VAVARURRES_DP"]= {["Comment"]=sig_source..msg.VOS_VAVARURRES,["eval"]= function(Name)  local Tag="VOS_VAVARURRES" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_NSPVSHOD_DP"]= {["Comment"]=sig_source..msg.VOS_NSPVSHOD,["eval"]= function(Name)  local Tag="VOS_NSPVSHOD" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_A1NASVKL_DP"]= {["Comment"]=sig_source..msg.VOS_A1NASVKL,["eval"]= function(Name)  local Tag="VOS_A1NASVKL" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_A1TMIN_DP"]= {["Comment"]=sig_source..msg.VOS_A1TMIN,["eval"]= function(Name)  local Tag="VOS_A1TMIN" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_A1DVOTK_DP"]= {["Comment"]=sig_source..msg.VOS_A1DVOTK,["eval"]= function(Name)  local Tag="VOS_A1DVOTK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_A1NASOSN_DP"]= {["Comment"]=sig_source..msg.VOS_A1NASOSN,["eval"]= function(Name)  local Tag="VOS_A1NASOSN" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_A1NASRES_DP"]= {["Comment"]=sig_source..msg.VOS_A1NASRES,["eval"]= function(Name)  local Tag="VOS_A1NASRES" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_A2NASVKL_DP"]= {["Comment"]=sig_source..msg.VOS_A2NASVKL,["eval"]= function(Name)  local Tag="VOS_A2NASVKL" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_A2DVOTK_DP"]= {["Comment"]=sig_source..msg.VOS_A2DVOTK,["eval"]= function(Name)  local Tag="VOS_A2DVOTK" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_A2NASOSN_DP"]= {["Comment"]=sig_source..msg.VOS_A2NASOSN,["eval"]= function(Name)  local Tag="VOS_A2NASOSN" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_A2NASRES_DP"]= {["Comment"]=sig_source..msg.VOS_A2NASRES,["eval"]= function(Name)  local Tag="VOS_A2NASRES" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_M5ZAKR_DP"]= {["Comment"]=sig_source..msg.VOS_M5ZAKR,["eval"]= function(Name)  local Tag="VOS_M5ZAKR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_M5OTKR_DP"]= {["Comment"]=sig_source..msg.VOS_M5OTKR,["eval"]= function(Name)  local Tag="VOS_M5OTKR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_MOTKR_DP"]= {["Comment"]=sig_source..msg.VOS_MOTKR,["eval"]= function(Name)  local Tag="VOS_MOTKR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_MZAKR_DP"]= {["Comment"]=sig_source..msg.VOS_MZAKR,["eval"]= function(Name)  local Tag="VOS_MZAKR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_NPPVHAVAR_DP"]= {["Comment"]=sig_source..msg.VOS_NPPVHAVAR,["eval"]= function(Name)  local Tag="VOS_NPPVHAVAR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_NPPVFIRE_DP"]= {["Comment"]=sig_source..msg.VOS_NPPVFIRE,["eval"]= function(Name)  local Tag="VOS_NPPVFIRE" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_NPPVPAVAR_DP"]= {["Comment"]=sig_source..msg.VOS_NPPVPAVAR,["eval"]= function(Name)  local Tag="VOS_NPPVPAVAR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_NPPVNASVKL_DP"]= {["Comment"]=sig_source..msg.VOS_NPPVNASVKL,["eval"]= function(Name)  local Tag="VOS_NPPVNASVKL" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_PULT_DP"]= {["Comment"]=sig_source..msg.VOS_PULT,["eval"]= function(Name)  local Tag="VOS_PULT" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["VOS_SAU_DP"]= {["Comment"]=sig_source..msg.VOS_SAU,["eval"]= function(Name)  local Tag="VOS_SAU" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_VOD") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },

 
--котельная
        ["KOT_KOTELVKL_DP"]= {["Comment"]=sig_source..msg.KOT_KOTELVKL,["eval"]= function(Name)  local Tag="KOT_KOTELVKL" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_KOT") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["KOT_SETNASVKL_DP"]= {["Comment"]=sig_source..msg.KOT_SETNASVKL,["eval"]= function(Name)  local Tag="KOT_SETNASVKL" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_KOT") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["KOT_SETNASAVAR_DP"]= {["Comment"]=sig_source..msg.KOT_SETNASAVAR,["eval"]= function(Name)  local Tag="KOT_SETNASAVAR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_KOT") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["KOT_RECNASVKL_DP"]= {["Comment"]=sig_source..msg.KOT_RECNASVKL,["eval"]= function(Name)  local Tag="KOT_RECNASVKL" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_KOT") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["KOT_OTKLOTKR_DP"]= {["Comment"]=sig_source..msg.KOT_OTKLOTKR,["eval"]= function(Name)  local Tag="KOT_OTKLOTKR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_KOT") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
-- котел-утилизатор
        ["KU_SHIBOTKR_DP"]= {["Comment"]=sig_source..msg.KU_SHIBOTKR,["eval"]= function(Name)  local Tag="KU_SHIBOTKR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_UTO") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end, ["cdr"]= function() Check_Data_Reliability("KU_SHIBOTKR" , "S_TVS_UTO")  end },
        ["KU_SHIBZAKR_DP"]= {["Comment"]=sig_source..msg.KU_SHIBZAKR,["eval"]= function(Name)  local Tag="KU_SHIBZAKR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_UTO") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end, ["cdr"]= function() Check_Data_Reliability("KU_SHIBZAKR" , "S_TVS_UTO")  end },     
--водоотведение
        ["KNS_SAUAVT_DP"]= {["Comment"]=sig_source..msg.KNS_SAUAVT,["eval"]= function(Name)  local Tag="KNS_SAUAVT" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_KNS") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["KNS_NASVKL_DP"]= {["Comment"]=sig_source..msg.KNS_NASVKL,["eval"]= function(Name)  local Tag="KNS_NASVKL" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_KNS") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["KNS_NASAVAR_DP"]= {["Comment"]=sig_source..msg.KNS_NASAVAR,["eval"]= function(Name)  local Tag="KNS_NASAVAR" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_KNS") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["KNS_KOSVRAB_DP"]= {["Comment"]=sig_source..msg.KNS_KOSVRAB,["eval"]= function(Name)  local Tag="KNS_KOSVRAB" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_KNS") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
        ["KNS_KOSNEIS_DP"]= {["Comment"]=sig_source..msg.KNS_KOSNEIS,["eval"]= function(Name)  local Tag="KNS_KOSNEIS" local signal= Core[Name[1]..Tag.."_DP"] Add_Event (Tag, signal, "S_TVS_KNS") Core[Name[2]..Tag.."_DP"]=signal  oldsignal[Tag] = signal end },
-- //-----------------------------//--
--//      АНАЛОГОВЫЕ СИГНАЛЫ      //--
--//------------------------------//--
--котельная

["KOT_P1PRESS_AP"]= {["Comment"]="",["eval"]= function(Name) Check_Analog_Alarm("KOT_P1PRESS", "S_TVS_KOT") end},
        ["KOT_P2PRESS_AP"]= {["Comment"]="",["eval"]= function(Name) Check_Analog_Alarm("KOT_P2PRESS", "S_TVS_KOT") end },
        ["KOT_P1TEMP_AP"]= {["Comment"]="",["eval"]= function(Name) Check_Analog_Alarm("KOT_P1TEMP", "S_TVS_KOT") end },
        ["KOT_P2TEMP_AP"]= {["Comment"]="",["eval"]= function(Name) Check_Analog_Alarm("KOT_P2TEMP", "S_TVS_KOT") end },

--водоснабжение  
	     ["VOS_RESUROV_AP"]= {["Comment"]="",["eval"]= function(Name) Check_Analog_Alarm("VOS_RESUROV", "S_TVS_VOD") end},
        ["VOS_A1PRESS_AP"]= {["Comment"]="",["eval"]= function(Name) Check_Analog_Alarm("VOS_A1PRESS", "S_TVS_VOD") end },
        ["VOS_A2PRESS_AP"]= {["Comment"]="",["eval"]= function(Name) Check_Analog_Alarm("VOS_A2PRESS", "S_TVS_VOD") end },

-- котел-утилизатор
        
        ["KU_P1PRESS_AP"]= {["Comment"]="",["eval"]= function(Name) Check_Analog_Alarm("KU_P1PRESS", "S_TVS_UTO") end },
        ["KU_P2PRESS_AP"]= {["Comment"]="",["eval"]= function(Name) Check_Analog_Alarm("KU_P2PRESS", "S_TVS_UTO") end },
        ["KU_P1TEMP_AP"]= {["Comment"]="",["eval"]= function(Name) Check_Analog_Alarm("KU_P1TEMP", "S_TVS_UTO") end },
        ["KU_P2TEMP_AP"]= {["Comment"]="",["eval"]= function(Name) Check_Analog_Alarm("KU_P2TEMP", "S_TVS_UTO") end},

--КНС
        ["KNS_RESUROV_AP"]= {["Comment"]="",["eval"]= function(Name) Check_Analog_Alarm("KNS_RESUROV", "S_TVS_KNS") end},

 
} --of signals


-- Инициализация сигналов в момент запуска
--if RepareMode then
	for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
		for _, signals_Descriptor in pairs(signals) do	--Цикл по всем элементов в каждом из 2 массивов: RAW_ и S_
			signals_Descriptor.eval({raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals
		end
	end
	-- Отслеживание изменений значений в сигналах

			Core.onExtChange({"S_TVS_DS_DP"},Check_Data_Reliability) -- проверка достоверности данных по флагу DRFlag
	for raw_objectName, objectName in pairs(objects) do	--Цикл по 2ум массивам: RAW_ и S_
		for signals_Suffix, signals_Descriptor in pairs(signals) do	--Цикл по всем переменным в каждом из 2 массивов: RAW_ и S_
		--Вызов функций у каждой из переменных для проверки их достоверности
			Core.onExtChange({raw_objectName..signals_Suffix},signals_Descriptor.eval,{raw_objectName,objectName})	--Вызов функций у каждой из переменных, описанных в signals при изменении любой из переменных
		end
	end
--end
	
--		Core.onExtChange({"S_TVS_P01_Repare_DP"},Check_Repare_Mode) -- проверка Ремонтного режима

Core.waitEvents( )