
local handlerHH = 0
local tekRashod = 100
local handlerDay = 0
local handlerWeek = 0
local RashodSrednie = 0
local RashodSum = 0
local RashodMin = 0
local RashodMax = 0


while true do
	
	Core['RashodHH'][handlerHH] = Core['S_RM_A10503_AI']
	handlerHH = handlerHH + 1

	if handlerHH == 1799 then

		for numMasHH = 0, handlerHH do 			
			Core['RashodDay'][handlerDay]= Core['RashodDay'][handlerDay]+Core['RashodHH'][numMasHH]
			Core['RashodHH'][numMasHH]= 0			
		end		
	
		-- Расчет среднего, максимума, минимума за текущий день
		local ValueOld = 0
		for numMasHH = 0, handlerDay do 

			RashodSum = RashodSum + Core['RashodDay'][numMasHH]

			if numMasHH == handlerDay then 
				RashodSrednie = RashodSum/(handlerDay+1)
			end
			
			if numMasHH == 0 then 
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

		Core['RashodHHItog'][0] = RashodSum
		Core['RashodHHItog'][1] = RashodSrednie				
		Core['RashodHHItog'][2] = RashodMax 
		Core['RashodHHItog'][3] = RashodMin
		
		RashodSrednie = 0
		RashodSum = 0
		RashodMin = 0
		RashodMax = 0

		
		if handlerDay == 47 then
		--if handlerDay == 5 then
			for numMasDay = 0, handlerDay do
				Core['RashodWeek'][handlerWeek]= Core['RashodWeek'][handlerWeek]+Core['RashodDay'][numMasDay]
				Core['RashodDay'][numMasDay]= 0
			end

	
		-- Расчет среднего, максимума, минимума за текущий день
			local ValueOld = 0
			for numMasHH = 0, handlerDay do 
	
				RashodSum = RashodSum + Core['RashodWeek'][numMasHH]
	
				if numMasHH == handlerWeek then 
					RashodSrednie = RashodSum/(handlerWeek+1)
				end
				
				if numMasHH == 0 then 
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
	
			Core['RashodDayItog'][0] = RashodSum
			Core['RashodDayItog'][1] = RashodSrednie				
			Core['RashodDayItog'][2] = RashodMax 
			Core['RashodDayItog'][3] = RashodMin
			
			RashodSrednie = 0
			RashodSum = 0
			RashodMin = 0
			RashodMax = 0

			if handlerWeek == 6 then
				for numMasWeek = 0, handlerWeek do
					Core['RashodWeek'][handlerWeek]= 0
				end			
			end	--	handlerWeek
			handlerWeek	= handlerWeek +1
		end --handlerDay
	
		handlerDay = handlerDay + 1
	
		if handlerHH == 1799 then handlerHH = 0 end

		if handlerDay == 48 then handlerDay = 0 end	
		if handlerWeek == 7 then handlerWeek = 0 end
	end	--handlerHH
		
os.sleep(1)
end