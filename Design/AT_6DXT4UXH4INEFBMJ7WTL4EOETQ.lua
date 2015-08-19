
local handlerHH = 0
local handlerDay = 0
local handlerWeek = 0
local RashodSrednie = 0
local RashodSum = 0
local RashodMin = 0
local RashodMax = 0
local MasTek = {}
local InitProg = 0
local handlerHH1 = 0
local g_MonthDay = {31,28,31,30,31,30,31,31,30,31,30,31}

local OldIntervalDay = 0
local NewIntervalDay = 0

local StartHour = 0
local StartDay = 0
local StartWeek = 0
local StartMonth = 0

local lc_TekMonthOld = 0
local lc_TekMonthNew = 0
local Rashod = 0


while true do
	local Tek = os.date("*t")

	if InitProg == 0 then		
		InitProg = 1

		StartHour = handlerHH	
		StartDay = math.floor ((Tek.hour*60+ Tek.min)/30)

		handlerDay = StartDay
		OldIntervalDay = StartDay

		StartWeek = Tek.wday - 1
		StartMonth = Tek.month - 1

		handlerMonth = StartMonth		
		handlerWeek = StartWeek

		Core['RashodWeekItog'][0] = 0
		Core['RashodWeekItog'][1] = 0				
		Core['RashodWeekItog'][2] = 0 
		Core['RashodWeekItog'][3] = 0


		Core['RashodDayItog'][0] = 0
		Core['RashodDayItog'][1] = 0				
		Core['RashodDayItog'][2] = 0 
		Core['RashodDayItog'][3] = 0

		Core['RashodMonthItog'][0] = 0
		Core['RashodMonthItog'][1] = 0				
		Core['RashodMonthItog'][2] = 0 
		Core['RashodMonthItog'][3] = 0
		local lenDay = 47
		for numMasDay = 0, lenDay do
			Core['RashodDay'][numMasDay]= 0
		end
	end
	
	NewIntervalDay = math.floor ((Tek.hour*60+ Tek.min)/30)
	Rashod = Rashod + Core['S_RM_A10503_AI']
	handlerMonth   = Tek.month - 1	
	handlerWeek	   = Tek.wday - 1
	
	handlerHH = handlerHH + 1
	
	if OldIntervalDay ~= NewIntervalDay then
		
		Core['RashodDay'][OldIntervalDay]= Rashod
		Rashod = 0
		for numMasHH = StartHour, handlerHH do 	
			Core['RashodHH'][numMasHH]= 0			
		end		
	
		-- Расчет среднего, максимума, минимума за текущий день
		local ValueOld = 0
		local FierstHandlerDay = 0
		for numMasHH = StartDay, OldIntervalDay do 

			RashodSum = RashodSum + Core['RashodDay'][numMasHH]

			if numMasHH == OldIntervalDay then 
				RashodSrednie = RashodSum/(OldIntervalDay-StartDay+1)
			end
			
			if FierstHandlerDay == 0 then 
				FierstHandlerDay = 1
				ValueOld = Core['RashodDay'][numMasHH]	
				RashodMin = Core['RashodDay'][numMasHH]		
				RashodMax = Core['RashodDay'][numMasHH]
			else
				if Core['RashodDay'][numMasHH] > ValueOld and Core['RashodDay'][numMasHH] > RashodMax then
					RashodMax = Core['RashodDay'][numMasHH]
				else
					if Core['RashodDay'][numMasHH] < ValueOld and Core['RashodDay'][numMasHH] < RashodMin then
						RashodMin = Core['RashodDay'][numMasHH]
				end
				ValueOld = Core['RashodDay'][numMasHH]
				end				
			end -- Конец блока поиска Max и Min			
		end		

		Core['RashodDayItog'][0] = RashodSum
		Core['RashodDayItog'][1] = RashodSrednie				
		Core['RashodDayItog'][2] = RashodMax 
		Core['RashodDayItog'][3] = RashodMin
		
		RashodSrednie = 0
		RashodSum = 0
		RashodMin = 0
		RashodMax = 0

		
		if OldIntervalDay == 47 then
		
			for numMasDay = StartDay, handlerDay do
				Core['RashodWeek'][handlerWeek]= Core['RashodWeek'][handlerWeek]+Core['RashodDay'][numMasDay]
				Core['RashodMonth'][handlerMonth]= Core['RashodMonth'][handlerMonth]+Core['RashodDay'][numMasDay]
				Core['RashodDay'][numMasDay]= 0
			end
			Core['RashodDayItog'][0] = 0
			Core['RashodDayItog'][1] = 0				
			Core['RashodDayItog'][2] = 0 
			Core['RashodDayItog'][3] = 0

	
		-- Расчет среднего, максимума, минимума за текущую неделю
			local ValueOld = 0
			local FirsthandlerWeek = 0
			for numMasHH = StartDay, handlerWeek do 
	
				RashodSum = RashodSum + Core['RashodWeek'][numMasHH]
	
				if numMasHH == handlerWeek then 
					RashodSrednie = RashodSum/(handlerWeek-StartWeek+1)
				end
				
				if FirsthandlerWeek == 0 then 
					FirsthandlerWeek = 1
					ValueOld = Core['RashodWeek'][numMasHH]	
					RashodMin = Core['RashodWeek'][numMasHH]		
					RashodMax = Core['RashodWeek'][numMasHH]
				else
					if Core['RashodWeek'][numMasHH] > ValueOld and Core['RashodWeek'][numMasHH] > RashodMax then
						RashodMax = Core['RashodWeek'][numMasHH]
					else
						if Core['RashodWeek'][numMasHH] < ValueOld and Core['RashodWeek'][numMasHH] < RashodMin then
							RashodMin = Core['RashodWeek'][numMasHH]
					end
					ValueOld = Core['RashodWeek'][numMasHH]
					end				
				end -- Конец блока поиска Max и Min			
			end		
	
			Core['RashodWeekItog'][0] = RashodSum
			Core['RashodWeekItog'][1] = RashodSrednie				
			Core['RashodWeekItog'][2] = RashodMax 
			Core['RashodWeekItog'][3] = RashodMin
			
			RashodSrednie = 0
			RashodSum = 0
			RashodMin = 0
			RashodMax = 0

			if handlerWeek == 6 then
				for numMasWeek = StartWeek, handlerWeek do
					Core['RashodWeek'][numMasWeek]= 0
					Core['RashodWeekItog'][0] = 0
					Core['RashodWeekItog'][1] = 0				
					Core['RashodWeekItog'][2] = 0 
					Core['RashodWeekItog'][3] = 0
				end		
				StartWeek = 0	
			end	--	handlerWeek
		
			-- Расчет среднего, максимума, минимума за текущую месяц
			local ValueOld = 0
			local FirsthandlerMonth = 0
			for numMasHH = StartMonth, handlerMonth do 
	
				RashodSum = RashodSum + Core['RashodMonth'][numMasHH]
				
				if numMasHH == handlerMonth then 
					RashodSrednie = RashodSum/(handlerMonth-StartMonth+1)
				end
				
				if FirsthandlerMonth == 0 then 
					FirsthandlerMonth = 1
					ValueOld = Core['RashodMonth'][numMasHH]	
					RashodMin = Core['RashodMonth'][numMasHH]		
					RashodMax = Core['RashodMonth'][numMasHH]
				else
					if Core['RashodMonth'][numMasHH] > ValueOld and Core['RashodMonth'][numMasHH] > RashodMax then
						RashodMax = Core['RashodMonth'][numMasHH]
					else
						if Core['RashodMonth'][numMasHH] < ValueOld and Core['RashodMonth'][numMasHH] < RashodMin then
							RashodMin = Core['RashodMonth'][numMasHH]
					end
					ValueOld = Core['RashodMonth'][numMasHH]
					end				
				end -- Конец блока поиска Max и Min			
			end		
	
			Core['RashodMonthItog'][0] = RashodSum
			Core['RashodMonthItog'][1] = RashodSrednie				
			Core['RashodMonthItog'][2] = RashodMax 
			Core['RashodMonthItog'][3] = RashodMin
			
			RashodSrednie = 0
			RashodSum = 0
			RashodMin = 0
			RashodMax = 0
			
			lc_TekMonthNew = Tek.month 

			if lc_TekMonthNew ~= lc_TekMonthOld then
				for numMasMonth = StarMonth, handlerMonth do
					Core['RashodMonth'][numMasMonth]= 0
				end		
				Core['RashodMonthItog'][0] = 0
				Core['RashodMonthItog'][1] = 0				
				Core['RashodMonthItog'][2] = 0 
				Core['RashodMonthItog'][3] = 0
				StarMonth = 0	
			end	--	handlerMonth
			
			--handlerWeek	= handlerWeek +1
			StartDay = 0
		end --handlerDay
	
			
		handlerHH = 0		
		StartHour = 0
	end	--handlerHH
	OldIntervalDay = NewIntervalDay
	lc_TekMonthOld = lc_TekMonthNew

os.sleep(1)
end


--[[
local start=os.time()-3600

	--Чтение из архива за определенный период
	local NumMasTek = 0
	Core['Utk1'] = Core['Utk1'] +1
	for DT=start,start-48,-1 do 
    	MasTek[NumMasTek] = Core(DT)['Utk1']
	--	MasOsn[DT+DTlast] = Core['Utk1']   
		NumMasTek = NumMasTek + 1
	end
]]

	--if handlerHH > 1799 then