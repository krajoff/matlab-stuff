close all
clear;


% Main path and data file
paths;
mfilepath = fullfile(pwd, 'data\mat', 'VR_i170A.mat');
opt = options_i170A;
load(mfilepath);
%data = readCSV(csvfilepath);


ts = mean(diff(data.Time));
step = int32(opt.disTime/ts);
data = data(1:step:end,:);  


voltageCalculation(data, data.VoltageB-data.VoltageA, opt, "Voltage AB");
voltageCalculation(data, data.VoltageB-data.VoltageC, opt, "Voltage BC");
voltageCalculation(data, data.VoltageC-data.VoltageA, opt, "Voltage CA");
