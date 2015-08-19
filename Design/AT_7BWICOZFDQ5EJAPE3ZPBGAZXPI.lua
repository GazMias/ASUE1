

local function Time_Now()
if Core["Time_request"]==true then
		Core["Local_Time"] = os.date("%d.%m.%Y %H:%M:%S.%3N")--запрос текущего времени на узле
	end end

Core.onExtChange({"Time_request"},Time_Now)--ожидание события прихода запроса текущего времени
Core.waitEvents()