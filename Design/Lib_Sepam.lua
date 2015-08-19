--имена переменных в структуре TDataSepam
local str_var_date_sepam_lib_sepam = {"year",  "month", "day",  "hour",  "minute", "msec", "type_zapisi"};
LibSepam = { 
--FUNCTIONS FOR TDATA_SEPAM		
["Data"] = {
--funksia sravnenia (str_data_1>str_data_2 return 1, 
--str_data_1=str_data_2 return 0,	
--str_data_1<str_data_2 return -1)
["compare"] = function(str_data_1, 					    str_data_2)
local aaaaaaaaaa= 1
local year1 = Core[str_data_1..".year"]
local year2 = Core[str_data_2..".year"] 
if(Core[str_data_1.."[year]"]  > Core[str_data_2.."[year]"])
then
	return 1;
end
if(Core[str_data_1.."[year]"]  < Core[str_data_2.."[year]"])
then	
	return -1;
end
if(Core[str_data_1.."[month]"]  > Core[str_data_2.."[month]"])
then	
	return 1;
end
if(Core[str_data_1.."[month]"]  < Core[str_data_2.."[month]"])
then	
	return -1;
end		
if(Core[str_data_1.."[day]"]  > Core[str_data_2.."[day]"])
then	
	return 1;
end
if(Core[str_data_1.."[day]"]  < Core[str_data_2.."[day]"])
then	
	return -1;
end
if(Core[str_data_1.."[hour]"]  > Core[str_data_2.."[hour]"])
then	
	return 1;
end
if(Core[str_data_1.."[hour]"]  < Core[str_data_2.."[hour]"])
then	
	return -1;
end			
if(Core[str_data_1.."[minute]"]  > Core[str_data_2.."[minute]"])
then	
	return 1;
end
if(Core[str_data_1.."[minute]"]  < Core[str_data_2.."[minute]"])
then	
	return -1;
end		
if(Core[str_data_1.."[msec]"]  > Core[str_data_2.."[msec]"])
then	
	return 1;
end
if(Core[str_data_1.."[msec]"]  < Core[str_data_2.."[msec]"])
then	
	return -1;
end			
return 0;
end		
,		
["assign"] = function (str_data_1, str_data_2)
					for i = 1, #str_var_date_sepam_lib_sepam do								
						Core[str_data_1.."."..str_var_date_sepam_lib_sepam[i] ] = Core[str_data_2.."."..str_var_date_sepam_lib_sepam[i] ]
					end
		 end
	},
}