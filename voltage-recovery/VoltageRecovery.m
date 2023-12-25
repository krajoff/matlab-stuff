close all
clear;


% Main path and data file
% data = readCSV(fullfile(pwd, 'data\csv', 'VR_i100A.csv'));
paths;
opt = options_i170A;
mfilepath = fullfile(pwd, 'data\mat', opt.name);
load(mfilepath);


ts = mean(diff(data.Time));
step = int32(opt.disTime/ts);
data = data(1:step:end,:);  


voltageCalculation(data, data.VoltageB-data.VoltageA, opt, "Voltage AB");
voltageCalculation(data, data.VoltageB-data.VoltageC, opt, "Voltage BC");
voltageCalculation(data, data.VoltageC-data.VoltageA, opt, "Voltage CA");

% VoltageAnalysis = data.VoltageB-data.VoltageA;
% title = "Voltage AB";


    


