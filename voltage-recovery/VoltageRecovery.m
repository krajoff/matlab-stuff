close all
clear;


% Main path and data file
% data = readCSV(fullfile(pwd, 'data\csv', 'VR_i100A.csv'));
paths;
mfilepath = fullfile(pwd, 'data\mat', 'VR_i170A.mat');
opt = options_i170A;
load(mfilepath);


ts = mean(diff(data.Time));
step = int32(opt.disTime/ts);
data = data(1:step:end,:);  


%voltageCalculation(data, data.VoltageB-data.VoltageA, opt, "Voltage AB");
%voltageCalculation(data, data.VoltageB-data.VoltageC, opt, "Voltage BC");
%voltageCalculation(data, data.VoltageC-data.VoltageA, opt, "Voltage CA");

VoltageAnalysis = data.VoltageB-data.VoltageA;
title = "Voltage AB";


    % Plot current stator
    figure('Name', 'Stator current');
    plot(data.Time, data.CurrentA, ...
        data.Time, data.CurrentB, ...
        data.Time, data.CurrentC,'Linewidth', 2);
    xlim([opt.startTime-0.5, opt.endTime]);
    legend ('Current A', 'Current B', 'Current C');
    grid on;
    
    
    % Plot voltage stator
    figure('Name', "Stator voltage, envelope, peaks (" + title + ")");
    [timePeaks, valuePeaks] = findPeaksPeriod(data.Time, VoltageAnalysis, opt);
    timeSpline = opt.startTime:opt.disTime:opt.endTime;   
    valueSpline = interp1(timePeaks, valuePeaks, timeSpline, 'pchip');
    valueFiltered = medfilt1(valueSpline, opt.nFilter);
    
    plot(data.Time, VoltageAnalysis, 'Linewidth', 1); hold on
    plot(timePeaks, valuePeaks, 'ko');
    plot(timeSpline, valueSpline, '-', 'Linewidth', 2);
    xlim([opt.startTime-0.5, opt.endTime]);
    legend ('raw data', 'peaks', 'spline');
    grid on;
    
    time = timeSpline-timeSpline(1);
    voltage = valueFiltered;
    yU = opt.uSteady - voltage;


    % Cutting values for logistic function
    timeCutting = time(opt.cutPoints:end);
    yUCutting = yU(opt.cutPoints:end);

    
    % Create the objective function
    logfun = @(beta, timeCutting, yUCutting) sum((yUCutting - ...
        (beta(1)./(1 + beta(2).*exp(-beta(3).*timeCutting)))).^2);


    % Create an anonymous function
    foo = @(beta) logfun(beta, timeCutting, yUCutting);
    beta0 = [opt.uSteady; 0; 0];
    options.MaxFunEvals = Inf;
    options.MaxIter = Inf;
    beta = fminsearch(foo, beta0, options);
    yUfun = @(time) beta(1)./(1 + beta(2).*exp(-beta(3).*time));
    dUsub = yU - yUfun(time);

    figure('Name', title)
    semilogy(time, yU, time, yUfun(time), 'Linewidth', 2);
    xticks(0:1:time(end));
    
    xlim([0, fix(time(end))]);
    ylim([yUfun(time(end))-500, yU(1)+500])
    grid on; hold on;
    semilogy(time, dUsub, 'Linewidth', 2);


    % Ñalculation of inductive reactances 
    divider = 6^0.5*opt.ik*opt.zn;
    xTran = (opt.uSteady - yUfun(0))/divider;
    xSubTran = voltage(1)/divider;
    fprintf(title + ":\n");
    fprintf("X' = %.3f and X'' = %.3f;\n", xTran, xSubTran);


    % Ñalculation of time constants 
    tTran = -log((beta(1)-yUfun(0)/exp(1))/(beta(2)*yUfun(0)/exp(1)))/beta(3);
    [row, ~] = find(dUsub < dUsub(1)/exp(1));
    tSubTran = time(row(1)-1);
    fprintf("T' = %.1f s and T'' = %.3f s.\n", tTran, tSubTran);
