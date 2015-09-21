dofile("Lib_Sepam.lua")
--переменные и функции общие для программного модуля
-----------------------------------------------------
-----------------------------------------------------
Core["S_ZRU_P11_OSCIL_PATH"] = "D:/OSCILLOGRAMM/S_ZRU_P11_VV1/"
Core["S_ZRU_P11_SHTN_OSCIL_PATH"] = "D:/OSCILLOGRAMM/S_ZRU_P11_SHTN/"
Core["S_ZRU_P11_OLS80_OSCIL_PATH"] = "D:/OSCILLOGRAMM/S_ZRU_P11_OLS80/"
Core["S_ZRU_P11_SV_OSCIL_PATH"] = "D:/OSCILLOGRAMM/S_ZRU_P11_SV/"
--сепамы
local objects = {
	["RAW_SEPAM_VV1_OSCIL"]="S_ZRU_P11_VV1",
	["RAW_SEPAM_SHTN_OSCIL"]="S_ZRU_P11_SHTN",
	["RAW_SEPAM_OLS80_OSCIL"]="S_ZRU_P11_OLS80",
	["RAW_SEPAM_SV_OSCIL"]="S_ZRU_P11_SV"
}

local str_path_osc = "D:/OSCILLOGRAMM"
--задержка дебага
local iStop_debug_osc_sepam = 600
--признак дебага
local bDebug_osc_sepam = false
--прищнак первого чтения зоны записи
local bFirstReadingZapis = true
--debug
local str_path_test = "D:/"
--функция задания полного имени файла с путём по номеру записи и расширению файла
-----------------------------------------------------

-----------------------------------------------------
local str_full_name = function (N_zapis, str_rasshirenie)
	local str_file_descriptor_name = str_path_osc.."/"..name_obj[1]
	str_file_descriptor_name = str_file_descriptor_name.."/"..str_data(name_obj[1]..".OSCIL_DATE_ZAPIS_"..N_zapis..".CP")
	str_file_descriptor_name = str_file_descriptor_name..str_rasshirenie
	return str_file_descriptor_name
end
-----------------------------------------------------
--дескриптор текущего файла осцилограммы
local file_descriptor = {}
--инициализируем file_descriptor
for obj, pult_obj in pairs(objects) do
	file_descriptor[obj] = nil	
end

--имена переменных в зоне записи 
local str_var_zapis = {"OSCIL_DATE_ZAPIS_1_CP"};

--имена переменных в структуре TDataSepam
local str_var_date_sepam = {"year",  "month", "day",  "hour",  "minute", "msec", "type_zapisi"};


--нет связи с сепамом
local bSviazSepam = {}
--инициализируем bSviazSepam
for obj, pult_obj in pairs(objects) do
	bSviazSepam[pult_obj] = true	
end

--состояния сепамов
-----------------------------------------------------
-----------------------------------------------------

--возможные значения состояния (это константы!!! не менять их!!!)
local iNoSleep_Osc_const	= 0
local iWait_Osc_const 		= 1
local iVibor_Osc_const 		= 2
local iSchit_Osc_const		= 3

local iModeSepam ={}
for obj, pult_obj in pairs(objects) do
	iModeSepam[obj] = iNoSleep_Osc_const	
end
-----------------------------------------------------
-----------------------------------------------------

--времена установки на sleep сепамов 
-----------------------------------------------------
-----------------------------------------------------
--задержка после квитирования
local iSchit_Osc_delay = 1
local iVibor_Osc_delay = 1
local iWait_Osc_delay = 30

local sleep_time = {}
for obj, pult_obj in pairs(objects) do
	sleep_time[obj] = nil	
end
-----------------------------------------------------
-----------------------------------------------------

local start_time = os.time()

--время восстановления соединения
-----------------------------------------------------
-----------------------------------------------------
local connection_time = {};
--инициализируем connection_time
for obj, pult_obj in pairs(objects) do
	connection_time[pult_obj] = nil	
end
-----------------------------------------------------
-----------------------------------------------------

--задержка после восстановления соединения(чтобы связь просралась)
local iDelayConnection = 8
--инициализация переменных у name_obj
local Init = 	function(name_obj, bStart)
					--обновление остальных зон отменяем
					Core[name_obj[1]]["update_OSCIL_ZONA_Schiti_kvitir"] = false;
					Core[name_obj[1]..".update_OSCIL_ZONA_Schit"] = false;
					Core[name_obj[1]]["update_OSCIL_ZONA_VIBORA"] = false;
					Core[name_obj[1]]["update_OSCIL_ZONA_ZAPISI"] = false;
					Core[name_obj[1]]["N_cur_Read_Bytes"] = 0;
					Core[name_obj[1]]["N_posilka_cur_Read_Bytes"] = 0;
					Core[name_obj[1]]["iN_Bytes_Schit"] = 0;
					Core[name_obj[1]]["bDataFile"] = false;
					Core[name_obj[1]]["N_Obmen"] = 0;
					for i = 1, #str_var_date_sepam do								
						Core[name_obj[1]..".OSCIL_DATA_VIBOR_CP."..str_var_date_sepam[i] ] = 0
					end
					--если программа только запустилась
					if 	bStart == true then
						Core[name_obj[1]..".OSCIL_WORD_OBMEN_CP"] = 0
						--квитируем запись
						--Core[name_obj[1] ]["update_OSCIL_ZONA_Schiti_kvitir"] = true;
						--обновляем зону записи
						Core[name_obj[1]]["update_OSCIL_ZONA_ZAPISI"] = true;
						Core[name_obj[1].."[N_osc_no_write]"] = 0
						for i = 1, #str_var_date_sepam do								
							Core[name_obj[1]..".OSCIL_DATE_ZAPIS_LAST."..str_var_date_sepam[i] ] = 150  --точно неверное значение месяцев, минут...
						end
						for i = 1, #str_var_date_sepam do								
							Core[name_obj[1]..".OSCIL_NEW_ZAPIS_DATA_CP."..str_var_date_sepam[i] ] = 0
						end
						for i = 1, #str_var_date_sepam do								
							Core[name_obj[1].."[OSCIL_DATE_ZAPIS_1_CP_buf]."..str_var_date_sepam[i] ] = 0
						end
						--создаём папки
						-----------------------------------------------------
						-----------------------------------------------------
						local dir = str_path_osc.."/"..name_obj[2]
						fs.mkdir(dir);	
						-----------------------------------------------------
						-----------------------------------------------------								
					end			
				end

--функция перевода переменной с датой типа TDATA_Sepam в строку
local str_data = 	function(data)
						local res ="OPG_"..Core[data.."[day]"].."."..Core[data.."[month]"].."."..Core[data.."[year]"]
									.." ".. Core[data.."[hour]"]..".".. Core[data.."[minute]"].."."..Core[data.."[msec]"]
					 	--[[for i=1,#str_var_date_sepam do
							if data[i] ~= "type_zapisi" then
								local Var = data.."["..str_var_date_sepam[i].."]"
								if i~=0 then
									res = res..":"..Core[Var]
								else
									res = res..Core[Var]
								end
							end	
						end]]--
						return res
					end
-----------------------------------------------------
-----------------------------------------------------
--функция задания полного имени файла с путём по номеру записи и расширению файла
-----------------------------------------------------
-----------------------------------------------------
local str_full_name = function (name_obj, N_zapis, str_rasshirenie)
	local str_file_descriptor_name = str_path_osc.."/"..name_obj[2]
	str_file_descriptor_name = str_file_descriptor_name.."/"..str_data(name_obj[1]..".OSCIL_DATE_ZAPIS_"..N_zapis.."_CP")
	str_file_descriptor_name = str_file_descriptor_name..str_rasshirenie
	return str_file_descriptor_name
end
-----------------------------------------------------
-----------------------------------------------------
--debug
-----------------------------------------------------
-----------------------------------------------------
local debug_debujnii = function(name_obj, N_Zapis)				
				Core[name_obj[1]..".OSCIL_READING_CP"] = true
				os.sleep(iStop_debug_osc_sepam);
				local test_descriptor = io.open(str_path_test.."Projects/Sepam_oscilogramm/Design/Test.DAT", "rb")
				if file_descriptor[name_obj]~= nil then
					file_descriptor[name_obj]:close();
					file_descriptor[name_obj] = nil
				end
				test_descriptor:seek("set");
				local test_data = test_descriptor:read("*a");
				local str_file_descriptor_name = str_path_osc.."/"..name_obj[1]
				--[[str_file_descriptor_name = str_file_descriptor_name..str_data(name_obj[1]..".OSCIL_DATE_ZAPIS_"..N_Zapis.."_CP")]]
				--[[str_file_descriptor_name = str_file_descriptor_name.."/"..str_data(name_obj[1]..".OSCIL_DATE_ZAPIS_"..N_Zapis.."_CP")]]
				--[[str_file_descriptor_name = str_file_descriptor_name..".DAT"]]
				file_descriptor[name_obj] = io.open(str_full_name(name_obj, N_Zapis, ".DAT"), "w+b")
				file_descriptor[name_obj]:write(test_data);
				file_descriptor[name_obj]:flush()
				--Закрываем файл .DAT	
				test_descriptor:close()
				test_descriptor = io.open(str_path_test.."Projects/Sepam_oscilogramm/Design/Test.CFG", "r")
				file_descriptor[name_obj]:close();
				file_descriptor[name_obj] = nil
				test_descriptor:seek("set");
				test_data = test_descriptor:read("*a");
				local str_file_descriptor_name = str_path_osc.."/"..name_obj[1]
				--[[str_file_descriptor_name = str_file_descriptor_name..str_data(name_obj[1]..".OSCIL_DATE_ZAPIS_"..N_Zapis.."_CP")]]
				--[[str_file_descriptor_name = str_file_descriptor_name.."/"..str_data(name_obj[1]..".OSCIL_DATE_ZAPIS_"..N_Zapis.."_CP")]]
				--[[str_file_descriptor_name = str_file_descriptor_name..".CFG"]]
				file_descriptor[name_obj] = io.open(str_full_name(name_obj, N_Zapis, ".CFG"), "w+")
				file_descriptor[name_obj]:write(test_data);
				file_descriptor[name_obj]:flush()
				file_descriptor[name_obj]:close()
				file_descriptor[name_obj] = nil
				test_descriptor:close()
				for i = 1, #str_var_date_sepam do								
					Core[name_obj[1]..".OSCIL_NEW_ZAPIS_DATA_CP."..str_var_date_sepam[i] ] = Core[name_obj[1]..".OSCIL_DATE_ZAPIS_"..N_Zapis.."_CP."..str_var_date_sepam[i] ]
				end
				--меняем самую позднюю считанную запись
				-----------------------------------------------------
				-----------------------------------------------------
				if Core[name_obj[1].."[OSCIL_DATE_ZAPIS_LAST][month]"] <= 31 then
					if LibSepam.Data.compare(name_obj[1]..".OSCIL_DATE_ZAPIS_"..Core[name_obj[1].."[N_osc_no_write]"].."_CP", name_obj[1].."[OSCIL_DATE_ZAPIS_LAST]") > 0 then
						for i = 1, #str_var_date_sepam do								
							Core[name_obj[1].."[OSCIL_DATE_ZAPIS_LAST]."..str_var_date_sepam[i] ] = Core[name_obj[1]..".OSCIL_DATE_ZAPIS_"..Core[name_obj[1].."[N_osc_no_write]"].."_CP."..str_var_date_sepam[i] ]
						end		
					end
				else
					for i = 1, #str_var_date_sepam do								
						Core[name_obj[1].."[OSCIL_DATE_ZAPIS_LAST]."..str_var_date_sepam[i] ] = Core[name_obj[1]..".OSCIL_DATE_ZAPIS_"..Core[name_obj[1].."[N_osc_no_write]"].."_CP."..str_var_date_sepam[i] ]
					end	
				end
				-----------------------------------------------------
				-----------------------------------------------------
				Core[name_obj[1]..".OSCIL_READING_CP"] = false
end

-----------------------------------------------------
-----------------------------------------------------


--обработчики сигналов от модбасс
-----------------------------------------------------
-----------------------------------------------------
local timer_event = function(arg__)

						for obj, pult_obj in pairs(objects) do
							if pult_obj=="S_ZRU_P11_SHTN" then 
								pult_obj = "S_ZRU_P11_STN"
							end

							
							--прошла задержка после восстановления соединения(нужна - потому что соединение подглючивает,1,2,1,1,2)
							-----------------------------------------------------
							-----------------------------------------------------
							if connection_time[pult_obj] ~= nil	then
								if os.time() - connection_time[pult_obj] >= iDelayConnection then
									--обновляем зону записи
									Core[obj]["update_OSCIL_ZONA_ZAPISI"] = true;
									connection_time[pult_obj] = nil
								end
							end
							-----------------------------------------------------
							-----------------------------------------------------

							--связь с сепамом или с драйвером пропала - останавливаем работу
							if 	--[[(]]bSviazSepam[pult_obj] == true --[[and string.sub(Core["Driver_Sepam_Run"],1,3)== "RUN")]]
								and
								Core[pult_obj.."_DS_DP"] == 2 		
								then
								Init({obj, pult_obj}, false)								
								bSviazSepam[pult_obj]	= false
								iModeSepam[obj] = iNoSleep_Osc_const
								return	
							end	
							--связь с сепамом или с драйвером появилась - перезапускаем
							if 	--[[(]]bSviazSepam[pult_obj] == false --[[or string.sub(Core["Driver_Sepam_Run"],1,3)~= "RUN")]] 
								and
								Core[pult_obj.."_DS_DP"] ~= 2 then
								--время соединения
								connection_time[pult_obj] = os.time();
								bSviazSepam[pult_obj]	= true
								return	
							end									
							--запоминаем значение связи с сепамом
							if Core[pult_obj.."_DS_DP"] == 2 --[[or string.sub(Core["Driver_Sepam_Run"],1,3)~= "RUN"]] then
								bSviazSepam[pult_obj]	= false					
							else
								bSviazSepam[pult_obj]	= true		
							end
						end

					end

--функция в таймере имитирует все sleepы
local timer_sepam_schit_zapis = function(arg_)
									for obj, pult_obj in pairs(objects) do
										--ждём новые осциллограммы
										if iModeSepam[obj] == iWait_Osc_const then
											if os.time() - sleep_time[obj] >= iWait_Osc_delay then
												Core[obj]["update_OSCIL_ZONA_ZAPISI"]=true;
												iModeSepam[obj] = iNoSleep_Osc_const
												goto continue;
											end
										end
										--считываем новый блок осциллограммы
										if iModeSepam[obj] == iSchit_Osc_const then
											if os.time() - sleep_time[obj] >= iSchit_Osc_delay then
												Core[obj]["update_OSCIL_ZONA_Schit"]=true;
												iModeSepam[obj] = iNoSleep_Osc_const
												goto continue;
											end
										end
										--начинаем считывать после записи в зону выбора
										if iModeSepam[obj] == iVibor_Osc_const then
											if os.time() - sleep_time[obj] >= iVibor_Osc_delay then
												Core[obj]["update_OSCIL_ZONA_Schit"]=true;
												Core[obj]["update_OSCIL_ZONA_ZAPISI"]=true;
												iModeSepam[obj] = iNoSleep_Osc_const
												goto continue;
											end
										end
										::continue::
									end									
								end

local pult_operator =
{	["OSCIL_MANUAL_ZAPUSK_STC"] ={	["comment"] = "Ручной запуск осциллограмм",
									["func"] = 	function(name_obj)
													Core[name_obj[1]..".OSCIL_MANUAL_ZAPUSK_STC"] = true;
													Core[name_obj[1]..".OSCIL_MANUAL_ZAPUSK_TC"] = true;
													Core[name_obj[1]]["update_OSCIL_MANUAL_ZAPUSK_TC"] = true;		
												end},						
}



local commands_operator = 
{ 	
	["OSCIL_ZONA_ZAPISI"] = {["comment"] = "Зона записи осциллограмма",
						["func"] =function(name_obj)
							if Core[name_obj[1]..".update_OSCIL_ZONA_ZAPISI"]==false then
								--обрыв связи - ничо не делаем
								if bSviazSepam[name_obj[2]] == false then
									return
								end
						
								if bDebug_osc_sepam == true then
									--читаем все осциллограммы
									-----------------------------------------------------
									-----------------------------------------------------
									if bFirstReadingZapis then
										local N_Zapis_Osc_Sepam = Core[name_obj[1]..".OSCIL_N_CP"]
										for i=1, N_Zapis_Osc_Sepam do
											debug_debujnii(name_obj,i)									
										end  
									end
									-----------------------------------------------------
									-----------------------------------------------------
								end
								if LibSepam.Data.compare(name_obj[1]..".OSCIL_DATE_ZAPIS_1_CP", name_obj[1].."[OSCIL_DATE_ZAPIS_1_CP_buf]") ~= 0 
									and
									( Core[name_obj[1].."[N_osc_no_write]"] == 0 or bDebug_osc_sepam == true)									
									then
									Core[name_obj[1]..".OSCIL_READING_CP"] = true
									--кол-во необработанных осциллограмм
									-----------------------------------------------------
									-----------------------------------------------------

									--считаем кол-во необработанных записей
									-----------------------------------------------------
									-----------------------------------------------------
									if Core[name_obj[1].."[OSCIL_DATE_ZAPIS_LAST][month]"] <= 31 then
										for i_zap = 1, Core[name_obj[1]..".OSCIL_N_CP"] do
											if LibSepam.Data.compare(name_obj[1]..".OSCIL_DATE_ZAPIS_"..i_zap.."_CP", name_obj[1].."[OSCIL_DATE_ZAPIS_LAST]") == 0 then
												Core[name_obj[1].."[N_osc_no_write]"] = i_zap - 1
											end
										end
									--в первый раз считываем
									else
										Core[name_obj[1].."[N_osc_no_write]"] = Core[name_obj[1]..".OSCIL_N_CP"]
									end
									-----------------------------------------------------
									-----------------------------------------------------
									
									--считываем данные об осцилограммах
									-----------------------------------------------------
									-----------------------------------------------------	
									for i = 1, #str_var_date_sepam do								
										Core[name_obj[1]..".OSCIL_DATE_ZAPIS_1_CP_buf."..str_var_date_sepam[i] ] = Core[name_obj[1]..".OSCIL_DATE_ZAPIS_1_CP."..str_var_date_sepam[i] ]
									end
									Core[name_obj[1].."[OSCIL_DATE_ZAPIS_1_CP_buf].type_zapisi"] = 0
									-----------------------------------------------------
									-----------------------------------------------------
		
									--пишем в зону выбора и инициируем считывание
									-----------------------------------------------------
									-----------------------------------------------------
									for i = 1, #str_var_date_sepam do								
										Core[name_obj[1]..".OSCIL_DATA_VIBOR_CP."..str_var_date_sepam[i] ] = Core[name_obj[1]..".OSCIL_DATE_ZAPIS_"..Core[name_obj[1].."[N_osc_no_write]"].."_CP."..str_var_date_sepam[i] ]
									end
									Core[name_obj[1]..".OSCIL_DATA_VIBOR_CP.type_zapisi"] = 0
									if bDebug_osc_sepam == false then
										--обновляем зону выбора
										Core[name_obj[1]]["update_OSCIL_ZONA_VIBORA"] = true;
			 							--os.sleep(5);
										--инициируем считывание
										--Core[name_obj[1] ]["update_OSCIL_ZONA_Schit"] = true
									end		
									-----------------------------------------------------
									-----------------------------------------------------
	
									--debug
									-----------------------------------------------------
									-----------------------------------------------------
									if bDebug_osc_sepam == true then
										if Core[name_obj[1].."[N_osc_no_write]"]>0 then
											local NNNNNNNNN = Core[name_obj[1].."[N_osc_no_write]"] 
											for i=1, NNNNNNNNN do
												debug_debujnii(name_obj,i)
												Core[name_obj[1].."[N_osc_no_write]"] = Core[name_obj[1].."[N_osc_no_write]"] - 1
											end
										end
										os.sleep(5);
										--инициализируем объект
										Init(name_obj, false);
										--обновляем зону записи
										Core[name_obj[1]]["update_OSCIL_ZONA_ZAPISI"] = true;
									end							
									-----------------------------------------------------
									-----------------------------------------------------															
								else
									iModeSepam[name_obj[1]] = iWait_Osc_const;
									sleep_time[name_obj[1]]	= os.time();								
									--os.sleep(30);
									--if Core[name_obj[1].."[N_osc_no_write]"] == 0 then
										--Core[name_obj[1]]["update_OSCIL_ZONA_ZAPISI"]=true;
									--end							
								end
								if os.time() - start_time > 5 then	
									bFirstReadingZapis = false
								end
							end		
						end},

	["OSCIL_ZONA_VIBORA"] = {["comment"] = "Зона выбора записи",
							["func"] =function(name_obj)
								if Core[name_obj[1] ]["status_OSCIL_ZONA_VIBORA"] ~= 0 then
									--обновляем зону выбора
									Core[name_obj[1] ]["update_OSCIL_ZONA_VIBORA"] = true;								
								else
									iModeSepam[name_obj[1]] = iVibor_Osc_const;
									sleep_time[name_obj[1]]	= os.time();
									--os.sleep(2);
									--Core[name_obj[1] ]["update_OSCIL_ZONA_Schit"] = true;
								end						
							end 							
							},
	["OSCIL_ZONA_Schit"] = { ["comment"] = "Зона считывания данных",
							["func"] = function(name_obj)
								Core.addLogMsg("Sepam start -"..name_obj[1].."pro4itannich baitov - "..Core[name_obj[1] ]["N_cur_Read_Bytes"]);
								--обрыв связи - ничо не делаем
								if bSviazSepam[name_obj[2]] == false then
									Core.addLogMsg("Sepam obriv sviazi -"..name_obj[1]);
									return
								end
								if bDebug_osc_sepam then
									Core.addLogMsg("Sepam bDebug_osc_sepam -"..name_obj[1]);
									return
								end
								--прищнак что осциллограмма полностью выкачанная уже есть в папке
								local bOscExist = false;
								--формируем bOscExist
								-----------------------------------------------------
								-----------------------------------------------------
								--если только начали читать осциллограмму
								if Core[name_obj[1] ]["N_cur_Read_Bytes"] == 0 then
									local str_DAT = str_full_name(name_obj, Core[name_obj[1].."[N_osc_no_write]"], ".DAT")
									local Exist_DAT = os.rename(str_DAT, str_DAT)
									--проверяем существование файлов
									if os.rename(str_DAT, str_DAT) == true then
										--проверяем размер DAT
										local size_dat = fs.attributes(str_DAT, "size")
										if size_dat == Core[name_obj[1]..".OSCIL_SIZE_DATA_CP"] then
											bOscExist = true	
										end
									end
									if bOscExist == false then
										file_descriptor[name_obj[1] ] = io.open(str_full_name(name_obj, Core[name_obj[1].."[N_osc_no_write]"], ".CFG"), "w+b")
									end
								end
								-----------------------------------------------------
								-----------------------------------------------------
								--число прочтённых байтов в текущей посылке
								Core[name_obj[1] ]["N_posilka_cur_Read_Bytes"] = 0;
								--проверяем что все данные пришли
								if 	Core[name_obj[1]..".OSCIL_WORD_OBMEN_CP"] ~= 0
										and
									Core[name_obj[1]..".OSCIL_WORD_OBMEN_CP"] ~= 65535																	
										and
									bit32.extract(Core[name_obj[1]..".OSCIL_WORD_OBMEN_CP"], 0, 8) ~= 254
										and
									bOscExist == false
									then
									--
									Core[name_obj[1] ]["iN_Bytes_Schit"] = bit32.extract(Core[name_obj[1]..".OSCIL_WORD_OBMEN_CP"], 0, 8);
								
									--функция записи одного байта в нужный файл (DAT или CONF)
									-----------------------------------------------------
									-----------------------------------------------------
									local write_file_data = function( iAlignmentBits)

																--записали файл .CONF
																if  Core[name_obj[1] ]["N_cur_Read_Bytes"] == Core[name_obj[1]..".OSCIL_SIZE_CONF_CP"] 
																	and	
																	Core[name_obj[1] ]["bDataFile"] == false then

																	file_descriptor[name_obj[1] ]:flush()
																	--закрываем файл .CONF
																	file_descriptor[name_obj[1] ]:close();
																	file_descriptor[name_obj[1] ] = nil
																	--открываем на запись файл .DAT																	
																	file_descriptor[name_obj[1] ] = io.open(str_full_name(name_obj, Core[name_obj[1].."[N_osc_no_write]"], ".DAT"), "w+b")
																	Core[name_obj[1] ]["bDataFile"] = true;

																end	
																Core[name_obj[1] ]["N_cur_Read_Bytes"] = Core[name_obj[1] ]["N_cur_Read_Bytes"] + 1
																Core[name_obj[1] ]["N_posilka_cur_Read_Bytes"] = Core[name_obj[1] ]["N_posilka_cur_Read_Bytes"] + 1 
																if 	Core[name_obj[1] ]["N_posilka_cur_Read_Bytes"] <= Core[name_obj[1] ]["iN_Bytes_Schit"]
																then
																	local iN_cur_Read_Dwords = math.floor(Core[name_obj[1] ]["N_posilka_cur_Read_Bytes"] /4)
																	if math.fmod(Core[name_obj[1] ]["N_posilka_cur_Read_Bytes"], 4) == 0 then
																		iN_cur_Read_Dwords = iN_cur_Read_Dwords - 1
																	end
																	local cur_data = Core[name_obj[1]]["OSCIL_DATA_SCHIT_CP"][iN_cur_Read_Dwords];
																	local chto_pishem = bit32.extract(Core[name_obj[1]]["OSCIL_DATA_SCHIT_CP"][iN_cur_Read_Dwords], iAlignmentBits,8)
																	file_descriptor[name_obj[1] ]:write(string.char(chto_pishem));
																end			
															end
									-----------------------------------------------------
									-----------------------------------------------------

									--считываем данные
									-----------------------------------------------------
									-----------------------------------------------------

									--отступ от начала регистра			
									local AlignmentBit = 0
									if Core[name_obj[1] ]["iN_Bytes_Schit"]~= 0 then
										while true do
											write_file_data(AlignmentBit);
											if Core[name_obj[1] ]["N_posilka_cur_Read_Bytes"] >= 248 then
												local pizdes = 0
											end
											if Core[name_obj[1] ]["N_posilka_cur_Read_Bytes"] >= Core[name_obj[1] ]["iN_Bytes_Schit"] then
												break;
											end
											--формируем сдвиг
											AlignmentBit = AlignmentBit + 8
											if AlignmentBit >= 32 then
												AlignmentBit = 0
											end
		
										end
									end
									-----------------------------------------------------
									-----------------------------------------------------

									--проверяем - весь файл считали?
									-----------------------------------------------------
									-----------------------------------------------------
									
									--осциллограмма считана - ждём следующую
--[[
									if Core[name_obj[1] ]["N_cur_Read_Bytes"] >= Core[name_obj[1] ]["OSCIL_SIZE_CONF_CP"] + Core[name_obj[1] ]["OSCIL_SIZE_DATA_CP"] then
										file_descriptor:flush()										
										--Закрываем файл .DAT	
										file_descriptor:close();
 										file_descriptor = nil
									   	--инициализируем объект
										Init(name_obj[1], false);
										Core[name_obj[1]..".OSCIL_READING_CP"] = false
									end
]]									
									-----------------------------------------------------
									-----------------------------------------------------

									--переписываем слово обмена
									-----------------------------------------------------
									-----------------------------------------------------
									--кол-во переданных блоков данных
									Core[name_obj[1]..".OSCIL_WORD_OBMEN_CP"] = bit32.replace(	Core[name_obj[1]..".OSCIL_WORD_OBMEN_CP"],
																							0,
																							0,
																							8)												
									Core[name_obj[1]..".OSCIL_WORD_OBMEN_CP"] = bit32.replace( Core[name_obj[1]..".OSCIL_WORD_OBMEN_CP"],
																							Core[name_obj[1] ]["N_Obmen"],
																							8,
																							8)
 									Core[name_obj[1] ]["N_Obmen"] = Core[name_obj[1] ]["N_Obmen"]+1;

--									--debug
--									--квитируем запись
-- 									Core[name_obj[1] ]["update_OSCIL_ZONA_Schiti_kvitir"] = true;
--									os.sleep(1)	

									-----------------------------------------------------
									-----------------------------------------------------

									--квитируем запись
 									Core[name_obj[1] ]["update_OSCIL_ZONA_Schiti_kvitir"] = true;
									--os.sleep(iSchit_delay)										 
									--проводим считывание (считаем что осциллограмма считана не до конца если размер файла конфигурации не обнулён)
									if Core[name_obj[1] ]["N_cur_Read_Bytes"] < Core[name_obj[1]..".OSCIL_SIZE_CONF_CP"] + Core[name_obj[1]..".OSCIL_SIZE_DATA_CP"] then
 										file_descriptor[name_obj[1] ]:flush();	
										--Core[name_obj[1] ]["update_OSCIL_ZONA_Schit"] = true;
									else
										Core[name_obj[1]..".OSCIL_NEW_PRIZNAK_DATA_CP"] = true
										--выдаём сигнал записали осциллограмму
										for i = 1, #str_var_date_sepam do								
											Core[name_obj[1]..".OSCIL_NEW_ZAPIS_DATA_CP."..str_var_date_sepam[i] ] = Core[name_obj[1]..".OSCIL_DATE_ZAPIS_"..Core[name_obj[1].."[N_osc_no_write]"].."_CP."..str_var_date_sepam[i] ]
										end
										--меняем самую позднюю считанную запись
										-----------------------------------------------------
										-----------------------------------------------------
										if Core[name_obj[1].."[OSCIL_DATE_ZAPIS_LAST][month]"] <= 31 then
											if LibSepam.Data.compare(name_obj[1]..".OSCIL_DATE_ZAPIS_"..Core[name_obj[1].."[N_osc_no_write]"].."_CP", name_obj[1].."[OSCIL_DATE_ZAPIS_LAST]") > 0 then
												for i = 1, #str_var_date_sepam do								
													Core[name_obj[1].."[OSCIL_DATE_ZAPIS_LAST]."..str_var_date_sepam[i] ] = Core[name_obj[1]..".OSCIL_DATE_ZAPIS_"..Core[name_obj[1].."[N_osc_no_write]"].."_CP."..str_var_date_sepam[i] ]
												end		
											end
										else
											for i = 1, #str_var_date_sepam do								
												Core[name_obj[1].."[OSCIL_DATE_ZAPIS_LAST]."..str_var_date_sepam[i] ] = Core[name_obj[1]..".OSCIL_DATE_ZAPIS_"..Core[name_obj[1].."[N_osc_no_write]"].."_CP."..str_var_date_sepam[i] ]
											end	
										end
										-----------------------------------------------------
										-----------------------------------------------------
										Core[name_obj[1].."[N_osc_no_write]"] = Core[name_obj[1].."[N_osc_no_write]"] - 1
										file_descriptor[name_obj[1] ]:flush()										
										--Закрываем файл .DAT	
										file_descriptor[name_obj[1] ]:close();
		 								file_descriptor[name_obj[1] ] = nil
										--инициализируем объект
										Init(name_obj, false);
										Core[name_obj[1]..".OSCIL_READING_CP"] = false
										if Core[name_obj[1].."[N_osc_no_write]"] == 0 then
											Core[name_obj[1] ]["update_OSCIL_ZONA_ZAPISI"] = true
										else
											for i = 1, #str_var_date_sepam do								
												Core[name_obj[1]..".OSCIL_DATA_VIBOR_CP."..str_var_date_sepam[i] ] = Core[name_obj[1]..".OSCIL_DATE_ZAPIS_"..Core[name_obj[1].."[N_osc_no_write]"].."_CP."..str_var_date_sepam[i] ]
											end
												Core[name_obj[1]..".OSCIL_DATA_VIBOR_CP.type_zapisi"] = 0
												--обновляем зону выбора
												Core[name_obj[1] ]["update_OSCIL_ZONA_VIBORA"] = true;
												--os.sleep(5)
												--Core[name_obj[1] ]["update_OSCIL_ZONA_Schit"] = true;
												Core[name_obj[1]..".OSCIL_READING_CP"] = true
										end
									end
									Core.addLogMsg("Sepam end -"..name_obj[1].." pro4itannich baitov -  "..Core[name_obj[1] ]["N_cur_Read_Bytes"]);
									return																	
								end								
								
								Core.addLogMsg("Sepam end -"..name_obj[1].." pro4itannich baitov -  "..Core[name_obj[1] ]["N_cur_Read_Bytes"]);
								
								--передача отменена - ищем новую осциллограмму
								-----------------------------------------------------
								-----------------------------------------------------
								if bit32.extract(Core[name_obj[1]..".OSCIL_WORD_OBMEN_CP"], 0, 8) == 254 
										or
									bOscExist == true
									then
									--Закрываем файл .DAT
									if 	file_descriptor[name_obj[1] ] ~= nil then
										file_descriptor[name_obj[1] ]:close()
										file_descriptor[name_obj[1] ] = nil
									end
									--инициализируем объект
									Init(name_obj, false);
									Core[name_obj[1].."[N_osc_no_write]"] = Core[name_obj[1].."[N_osc_no_write]"] - 1
									Core[name_obj[1]..".OSCIL_READING_CP"] = false									
									if Core[name_obj[1].."[N_osc_no_write]"] == 0 then
										Core[name_obj[1] ]["update_OSCIL_ZONA_ZAPISI"] = true
									else
										for i = 1, #str_var_date_sepam do								
											Core[name_obj[1]..".OSCIL_DATA_VIBOR_CP."..str_var_date_sepam[i] ] = Core[name_obj[1]..".OSCIL_DATE_ZAPIS_"..Core[name_obj[1].."[N_osc_no_write]"].."_CP."..str_var_date_sepam[i] ]
										end
										Core[name_obj[1]..".OSCIL_DATA_VIBOR_CP.type_zapisi"] = 0
										--обновляем зону выбора
										Core[name_obj[1] ]["update_OSCIL_ZONA_VIBORA"] = true;
										--os.sleep(5)
										--Core[name_obj[1] ]["update_OSCIL_ZONA_Schit"] = true;
										Core[name_obj[1]..".OSCIL_READING_CP"] = true
									end
									os.sleep(1)	
--[[
									--снова выбираем запись
									if Core[name_obj[1].."[N_osc_no_write]"] == 0 then
										for i = 1, #str_var_date_sepam do								
											Core[name_obj[1]..".OSCIL_DATA_VIBOR_CP."..str_var_date_sepam[i] ] = Core[name_obj[1]..".OSCIL_DATE_ZAPIS_"..Core[name_obj[1].."[N_osc_no_write]"].."_CP."..str_var_date_sepam[i] ]
										end
										Core[name_obj[1]..".OSCIL_DATA_VIBOR_CP.type_zapisi"] = 0
										--обновляем зону выбора
										Core[name_obj[1] ]["update_OSCIL_ZONA_VIBORA"] = true;
										os.sleep(1)
										Core[name_obj[1] ]["update_OSCIL_ZONA_Schit"] = true;										
									end
]]
									return								
								end
								-----------------------------------------------------
								-----------------------------------------------------

								--повторяем попытку считывания
								-----------------------------------------------------
								-----------------------------------------------------
								if Core[name_obj[1]..".OSCIL_WORD_OBMEN_CP"] == 0			--никакой запрос считывания ещё не поступил 
										or
								   Core[name_obj[1]..".OSCIL_WORD_OBMEN_CP"] == 65535		--запрос считывания учтён но данные ещё не доступны в зоне считывания
										and
									bOscExist == false
								then
									iModeSepam[name_obj[1]] = iVibor_Osc_const;
									sleep_time[name_obj[1]]	= os.time();
									--os.sleep(iSchit_delay);
									--Core[name_obj[1]]["update_OSCIL_ZONA_Schit"] = true;
									return	
								end
								-----------------------------------------------------
								-----------------------------------------------------	
							end
								},
	["OSCIL_ZONA_Schiti_kvitir"] = {["comment"] = "Зона считывания данных - квитирование считывания",
									["func"] = 	function(name_obj)
													--os.sleep(iSchit_delay);
													if Core[name_obj[1].."[N_osc_no_write]"] ~= 0 then
														iModeSepam[name_obj[1]] = iSchit_Osc_const;
														sleep_time[name_obj[1]]	= os.time();
														--Core[name_obj[1] ]["update_OSCIL_ZONA_Schit"] = true;
													end
												end
								}
}

-----------------------------------------------------
-----------------------------------------------------

-----------------------------------------------------
-----------------------------------------------------
--[[while true do
	if string.sub(Core["Driver_Sepam_Run"],1,3) == "RUN" then
		local a =1
		break;
	end
end]]


fs.mkdir(str_path_osc);
os.sleep(30)
--debug_debujnii({"RAW_SEPAM_VV1", "S_ZRU_P11_VV1"},1)
--задаём обработчики
-----------------------------------------------------
-----------------------------------------------------

for obj, pult_obj in pairs(objects) do
	for key, value in pairs(commands_operator) do
		Core.onExtChange({obj..".update_"..key}, 
					     value["func"],
					     {obj, pult_obj});	
	end
end

--инициализируем начальные переменные
-----------------------------------------------------
-----------------------------------------------------
for obj, pult_obj in pairs(objects) do
	Init({obj,pult_obj} , true);	
end
-----------------------------------------------------
-----------------------------------------------------
Core.onTimer(1, 1, timer_event);
Core.onTimer(2, 0.1, timer_sepam_schit_zapis);
Core.onExtChange( {"S_ZRU_P11_VV1_OSCIL_MANUAL_ZAPUSK"}, 
				 pult_operator["OSCIL_MANUAL_ZAPUSK_STC"]["func"],
					     {"S_ZRU_P11_VV1"} );
Core.waitEvents( )