close all
clear;


% Main path and data file
paths;
opt = options_residual_t3f_210_1;

mfilepath = fullfile(pwd, 'data\mat', opt.name);
load(mfilepath);
data = decreaseStep(data, opt); 
data = includeNil(data);
voltageCalculation(data, -data.VoltageA+data.VoltageB, opt, "Voltage AB");
voltageCalculation(data, -data.VoltageC+data.VoltageB, opt, "Voltage BC");
voltageCalculation(data, data.VoltageC-data.VoltageA, opt, "Voltage CA");

    


