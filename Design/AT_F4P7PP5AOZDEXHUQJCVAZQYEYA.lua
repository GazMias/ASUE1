local SOUND_CRITICAL = "SOUND_CRITICAL"
local SOUND_WARNING = "SOUND_WARNING"
local GLOBAL_KVIT = "GLOBAL_KVIT"

--Аналоговые сигналы
local signals_analog = {
	["S_KTP_P07_BVV1_IATEK1_AP"]={Comment ="АСУ ЭС КТП БМРЗ-0,4 Выключатель ввода N1. Значение тока фазы А"},
}

--Звуковая сигнализация для аналоговых сигналов для предупредительных и аварийных уставок
local function Setting_Analog(args)
local local_name_AP=args[1]		-- имя аналогового сигнала
local local_comment=args[2]
local local_sound_critical=args[3]	-- переменная, отвечающая за аварийный сигнал
local local_sound_warning=args[4]	--переменная, отвечающая за предупредительный сигнал
	if Core[local_name_AP] <= Core[local_name_AP.."_LL"] then 															--Если значение аналогового параметра меньше уставки LL
		Core[local_sound_critical] = true
		Core.addEvent("Сигнал "..local_comment.." принял значение ниже аварийной уставки LL",2)
	elseif Core[local_name_AP] > Core[local_name_AP.."_LL"] and Core[local_name_AP] <= Core[local_name_AP.."_L"] then	--Если значение аналогового параметра больше уставки LL но меньше уставки L
		Core[local_sound_warning] = true
		Core.addEvent("Сигнал "..local_comment.." принял значение ниже предупредительной уставки L",1)
	elseif Core[local_name_AP] >= Core[local_name_AP.."_H"] and Core[local_name_AP] < Core[local_name_AP.."_HH"] then 	--Если значение аналогового параметра больше уставки H но меньше уставки HH
		Core[local_sound_warning] = true
		Core.addEvent("Сигнал "..local_comment.." принял значение выше предупредительной уставки H",1)
	elseif Core[local_name_AP] >= Core[local_name_AP.."_HH"] then														--Если значение аналогового параметра больше уставки HH
		Core[local_sound_critical] = true
		Core.addEvent("Сигнал "..local_comment.." принял значение выше аварийной уставки HH",2)
	end
end

-----Квитирование предупредительных и аналоговых сигналов
local function KVIT(args)
local local_kvit=args[1]					--Переменная, отвечающая за квитирование
local local_sound_critical=args[2]			--Переменная, отвечающая за alarm
local local_sound_warning=args[3]			--Переменная, отвечающая за warning
	if(Core[local_kvit]==true) then			--Если пришла команда "Квитировать"
		Core[local_sound_critical] = false	--Сбрасываем alarm в false
		Core[local_sound_warning] = false	--Сбрасываем warning в false
		Core[local_kvit]= false				--Сбрасываем переменную квитирования в false
	end
end

-- Цикл по всем аналоговым сигналам в signals_analog
for Arg1, Arg2 in pairs (signals_analog) do
	Core.onExtChange({Arg1},Setting_Analog,{Arg1,Arg2.Comment,SOUND_CRITICAL,SOUND_WARNING,})	--При изменении любого аналогового сигнала вызывается функция Setting_Analog
end

-- При изменении значения переменной GLOBAL_KVIT, вызывается функция KVIT
Core.onExtChange({GLOBAL_KVIT},KVIT,{GLOBAL_KVIT,SOUND_CRITICAL,SOUND_WARNING})


Core.waitEvents( )