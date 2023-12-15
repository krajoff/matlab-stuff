close all
%clear all; clc; 


% Main path and data file
csvfilepath = fullfile(pwd, 'data', 'VR_i75A.csv');
mfilepath = fullfile(pwd, 'data', 'VR_i75A.mat');
%data = readCSV(csvfilepath);
load(mfilepath);


% Cutting duration and step
ts = mean(diff(data.Time)); 
tg = 10e-4;
step = int32(tg/ts);
data = data(1:step:end,:);  
interval = 20e-3/tg;


% Amplitude of the established line voltage [V]
Uest = 3300;
% Effective value of the stator winding phase current {A}
Ik = 995*2^-0.5;
% Basic resistance [Ohm]
Zn = 10500/(3^0.5*5077);
% Start time [s]
startTime = 13.17; startNumber = startTime/tg;
endTime = 20; endNumber = endTime/tg;


% Calculation line-voltage
data.VoltageAB = data.VoltageA-data.VoltageB;
data.VoltageBC = data.VoltageB-data.VoltageC;
data.VoltageCA = data.VoltageC-data.VoltageA;

% Plot
figure;
[yupper, ~] = envelope(data.VoltageAB, interval-2, 'peak');
plot(data.Time, data.VoltageAB, data.Time, yupper);
grid on;


time = data.Time(startNumber:endNumber)-data.Time(startNumber);
voltage = yupper(startNumber:endNumber);
yU = Uest - voltage;
figure
semilogy(time, yU)


logfun = @(beta) beta(1)./(1 + beta(2).*exp(-beta(3).*time));

beta0 = [Uest; 1; 0.1];
opts = optimset('fminsearch');
opts.MaxFunEvals = Inf;
opts.MaxIter = 10000;
betaHatML = fminsearch(logfun, beta0, opts);
%B = mnrfit(time, voltage);
grid on;


