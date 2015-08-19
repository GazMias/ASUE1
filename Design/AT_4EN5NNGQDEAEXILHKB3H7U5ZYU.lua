local objects=					--Список объектов для входа и выхода
{
	["RAW_BMRZ_"]="S_KTP_P07_BVV1_",
	["RAW_BMRZ_2_"]="S_KTP_P07_BVV2_",
	["RAW_SEPAM_VV1_"]="S_ZRU_P11_VV1_",
	["RAW_BMPA_"]="S_KTP_P07_BMPA_"
}

local function TimeSync() --автоматическая синхронизация времени на всех устройствах
	for raw_objectName, objectName in  pairs(objects) do  -- Перебираем все устройства.
		raw_objectName=raw_objectName
		Core[objectName.."Reg_Time_Set_AV"]=true
	end
end

local function Time_request()--Запрос текущего времени на всех устройствах
	Core["Time_request"]=true
	os.sleep(0.5)
	Core["Time_request"]=false
end

Core.onTimer(1, 300, TimeSync) --вызвать таймер раз в 300 секунд
Core.onTimer(2, 60, Time_request)--вызвать таймер раз в 0,5 секунд
Core.waitEvents()