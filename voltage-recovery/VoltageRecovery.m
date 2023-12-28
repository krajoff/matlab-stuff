close all
clear;


% Main path and data file
paths;
opt = options_rt;
mfilepath = fullfile(pwd, 'data\mat', opt.name);
load(mfilepath);
data = decreaseStep(data, opt); 

%voltageCalculation(data, -data.VoltageA+data.VoltageB, opt, "Voltage AB");
%voltageCalculation(data, data.VoltageC-data.VoltageB, opt, "Voltage BC");
voltageCalculation(data, -data.VoltageC+data.VoltageA, opt, "Voltage CA");

%voltageCalculation(data, data.VoltageA, opt, "Voltage AB");
%voltageCalculation(data, data.VoltageB, opt, "Voltage BC");
%voltageCalculation(data, data.VoltageC, opt, "Voltage CA");

    


