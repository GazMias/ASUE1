dofile("Lib_Sepam.lua")
local TmpDirBuf = {}

--сепамы
local objects = {
	["RAW_SEPAM_VV1"]="S_ZRU_P11_VV1"
}

local function printDir(path, obj)
	
	local NumDir = 0

	for file in fs.dir(path) do
		if file ~= "." and file ~= ".." then
   
 		   	local f = file
        	local attr = fs.attributes (f)
			local oscilogramma = string.sub(file, -3)
			if oscilogramma == 'CFG' then
				--признак правильного размера DAT
				local bOscExist = false
				--формируем bOscExist
				--------------------------------------------
				--------------------------------------------
				local str_DAT = path.."/"..string.gsub(file, "CFG", "DAT");
				local Exist_DAT = os.rename(str_DAT, str_DAT)
				--проверяем существование файлов
				if os.rename(str_DAT, str_DAT) == true then
					--проверяем размер DAT
					local size_dat = fs.attributes(str_DAT, "size")
					if size_dat == Core[obj.."_OSCIL_SIZE_DATA_CP"] then
						bOscExist = true	
					end
				end					
				--------------------------------------------
				--------------------------------------------
				if bOscExist == true then 
					TmpDirBuf[NumDir] = file
					NumDir = NumDir +1
				end
			end	
		end
	end

	local StartMas = 0
--[[
	if NumDir > 19 then
		StartMas = NumDir - 19
	end
]]
	for i = StartMas,NumDir-1 do
		Core['NameFileDir'][i-StartMas]= TmpDirBuf[i] 
		local b = TmpDirBuf[i]
	end
end

 

	
local TmpTimeOsc = {}
local FistOpros = 0
local NumTimeOsc = 0

while true do
	for obj, pult_obj in pairs(objects) do
		NumTimeOsc = 0;
		if LibSepam.Data.compare(obj.."_OSCIL_DATE_ZAPIS_1_CP", obj.."_DATA_1_OSCIL_PREV") ~= 0 then
			--пишем осциллограммы на сепаме
			for i_zap = 1, Core[obj.."_OSCIL_N_CP"] do
				TmpTimeOsc[0] = Core[obj.."_OSCIL_DATE_ZAPIS_"..i_zap.."_CP"].year
				TmpTimeOsc[1] = Core[obj.."_OSCIL_DATE_ZAPIS_"..i_zap.."_CP"].month
				TmpTimeOsc[2] = Core[obj.."_OSCIL_DATE_ZAPIS_"..i_zap.."_CP"].day
				TmpTimeOsc[3] = Core[obj.."_OSCIL_DATE_ZAPIS_"..i_zap.."_CP"].hour
				TmpTimeOsc[4] = Core[obj.."_OSCIL_DATE_ZAPIS_"..i_zap.."_CP"].minute
				TmpTimeOsc[5] = Core[obj.."_OSCIL_DATE_ZAPIS_"..i_zap.."_CP"].msec
				NumTimeOsc = NumTimeOsc +1
				Core['TimeOsc'][NumTimeOsc-1] = NumTimeOsc..'.  '..TmpTimeOsc[2]..'.'..TmpTimeOsc[1]..'.'..TmpTimeOsc[0]..'  '..TmpTimeOsc[3]..'.'..TmpTimeOsc[4]..'.'..TmpTimeOsc[5]	
			end	
			--запоминаем самую старую осциллограмму
			LibSepam.Data.assign(obj.."_DATA_1_OSCIL_PREV", obj.."_OSCIL_DATE_ZAPIS_"..Core[obj.."_OSCIL_N_CP"].."_CP")
		end		
		printDir(Core['S_ZRU_P11_OSCIL_PATH'], obj)
		--printDir("c:/1")
		os.sleep(2)
	end
end