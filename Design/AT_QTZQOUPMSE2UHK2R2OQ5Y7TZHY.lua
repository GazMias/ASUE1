


local MasTek = {}
local InitProg = 0

local handlerHH = 0
local handlerDay = 0

local g_MonthDay = {31,28,31,30,31,30,31,31,30,31,30,31}

local StartHour = 0
local StartDay = 0
local StartWeek = 0
local StartMonth = 0

local lc_TekMonthOld = 0
local lc_TekMonthNew = 0


local function Potreblenie(StrP, Delta)
	local RashodSum = 0
	local RashodMin = 0
	local RashodMax = 0
	
	Core['Potreb'..StrP][Delta]= Core['S_TVS_A1800_W'..StrP]
	-- Расчет среднего, максимума, минимума за текущий день
	local ValueOld = 0
	local FierstHandlerDay = 0
	for numMasHH = StartDay, Delta do 
		RashodSum = RashodSum + Core['Potreb'..StrP][numMasHH]

		if numMasHH == Delta then 
			RashodSrednie = RashodSum/(Delta-StartDay+1)
		end
			
		if FierstHandlerDay == 0 then 
			FierstHandlerDay = 1
			ValueOld = Core['Potreb'..StrP][numMasHH]	
			RashodMin = Core['Potreb'..StrP][numMasHH]		
			RashodMax = Core['Potreb'..StrP][numMasHH]
		else
			if Core['Potreb'..StrP][numMasHH] > ValueOld and Core['Potreb'..StrP][numMasHH] > RashodMax then
				RashodMax = Core['PotrebQ'][numMasHH]
			else
				if Core['Potreb'..StrP][numMasHH] < ValueOld and Core['Potreb'..StrP][numMasHH] < RashodMin then
					RashodMin = Core['Potreb'..StrP][numMasHH]
				end
				ValueOld = Core['Potreb'..StrP][numMasHH]
			end				
		end -- Конец блока поиска Max и Min			
	end		

	Core['Potreb'..StrP..'Itog'][0] = RashodSum
	Core['Potreb'..StrP..'Itog'][1] = RashodSrednie				
	Core['Potreb'..StrP..'Itog'][2] = RashodMax 
	Core['Potreb'..StrP..'Itog'][3] = RashodMin

	RashodSrednie = 0
	RashodSum = 0
	RashodMin = 0
	RashodMax = 0

	if Delta == 47 then
		-- Обнуление массива
		for numMasDay = StartDay, handlerDay do
			Core['Potreb'..StrP][numMasDay]= 0
		end
		Core['Potreb'..StrP..'Itog'][0] = 0
		Core['Potreb'..StrP..'Itog'][1] = 0				
		Core['Potreb'..StrP..'Itog'][2] = 0 
		Core['Potreb'..StrP..'Itog'][3] = 0
	end --handlerDay

end

while true do
	local Tek = os.date("*t")

	if InitProg == 0 then		
		InitProg = 1	

		StartHour = handlerHH	
		StartDay = math.floor ((Tek.hour*60+ Tek.min)/30)
		OldIntervalDay = StartDay
		handlerDay = StartDay

		StartWeek = Tek.wday - 1
		StartMonth = Tek.month - 1

		handlerMonth = StartMonth		
		handlerWeek = StartWeek
		-- инициализация при старте
		local lenmas = 47
		for numMasHH = 0, lenmas do 
			Core['PotrebP'][numMasHH]= 0
			Core['PotrebQ'][numMasHH]= 0
			Core['PotrebS'][numMasHH]= 0
		end

		Core['PotrebPItog'][0] = 0
		Core['PotrebPItog'][1] = 0				
		Core['PotrebPItog'][2] = 0 
		Core['PotrebPItog'][3] = 0

		Core['PotrebQItog'][0] = 0
		Core['PotrebQItog'][1] = 0				
		Core['PotrebQItog'][2] = 0 
		Core['PotrebQItog'][3] = 0

		Core['PotrebSItog'][0] = 0
		Core['PotrebSItog'][1] = 0				
		Core['PotrebSItog'][2] = 0 
		Core['PotrebSItog'][3] = 0
	end

	NewIntervalDay = math.floor ((Tek.hour*60+ Tek.min)/30)
	handlerHH = handlerHH + 1
	

	

	if OldIntervalDay ~= NewIntervalDay then

	--if OldIntervalDay >1 then
		Potreblenie('Q',OldIntervalDay)
		Potreblenie('P',OldIntervalDay)
		Potreblenie('S',OldIntervalDay)
	
		handlerDay = handlerDay + 1
	
		if handlerHH == 1799 then handlerHH = 0  StartHour = 0 end
		if handlerDay == 48 then handlerDay = 0 StartDay = 0 end					
		OldIntervalDay = NewIntervalDay
	
	end
os.sleep(1)
end