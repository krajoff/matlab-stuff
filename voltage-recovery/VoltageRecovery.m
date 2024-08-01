close all
clear;


% Main path and data file
paths;
opt = options_rt;
mfilepath = fullfile(pwd, 'data\mat', opt.name);
load(mfilepath);
data = decreaseStep(data, opt); 
<<<<<<< HEAD

=======
data = includeNil(data);
voltageCalculation(data, -data.VoltageA+data.VoltageB, opt, "Voltage AB");
voltageCalculation(data, -data.VoltageC+data.VoltageB, opt, "Voltage BC");
voltageCalculation(data, data.VoltageC-data.VoltageA, opt, "Voltage CA");
>>>>>>> aac84038f26850e4746faf7dd1e66dd9faff383e

voltageCalculation(data, data.VoltageA+data.VoltageB, opt, "Voltage AB");
voltageCalculation(data, data.VoltageC+data.VoltageB, opt, "Voltage BC");
voltageCalculation(data, data.VoltageC-data.VoltageA, opt, "Voltage CA");
nil = data.VoltageA+data.VoltageB+data.VoltageC;
% voltageCalculation(data, data.VoltageA, opt, "Voltage AB");
% voltageCalculation(data, data.VoltageB, opt, "Voltage BC");
% voltageCalculation(data, data.VoltageC, opt, "Voltage CA");

    


