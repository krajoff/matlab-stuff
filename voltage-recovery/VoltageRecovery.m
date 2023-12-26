close all
clear;


% Main path and data file
% data = readCSV(fullfile(pwd, 'data\csv', 'VR_i100A.csv'));
paths;
opt = options_i170A;
mfilepath = fullfile(pwd, 'data\mat', opt.name);
load(mfilepath);
data = decreaseStep(data, opt); 

voltageCalculation(data, data.VoltageA-data.VoltageB, opt, "Voltage AB");
voltageCalculation(data, -data.VoltageC+data.VoltageB, opt, "Voltage BC");
voltageCalculation(data, data.VoltageC-data.VoltageA, opt, "Voltage CA");

% VoltageAnalysis = data.VoltageB-data.VoltageA;
% title = "Voltage AB";


    


