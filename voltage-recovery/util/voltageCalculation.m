function [time, deltaU, deltaUsub]  = voltageCalculation(data, VoltageAnalysis, opt, title)
    % Plot stator current
    figure('Name', "Stator current (" + title + ")");
    plot(data.Time, data.CurrentA, ...
        data.Time, data.CurrentB, ...
        data.Time, data.CurrentC,'Linewidth', 2);
    xlim([opt.startTime-0.5, opt.endTime]);
    legend ('Current A', 'Current B', 'Current C');
    grid on;
    
    
    % Calculate peaks, peaks spline of stator voltage
    figure('Name', "Stator voltage, envelope, peaks (" + title + ")");
    initialFiltered = medfilt1(VoltageAnalysis, opt.iFilter);
    [timePeaks, valuePeaks] = findPeaksPeriod(data.Time, initialFiltered, opt);
    timeSpline = (opt.startTime:opt.splineTime:opt.endTime)';   
    [~, ind] = unique(timePeaks);
    valueSpline = interp1(timePeaks(ind), ...
        valuePeaks(ind), timeSpline, 'pchip');
    valueFiltered = smooth(valueSpline, opt.nFilter, 'lowess');
    %valueFiltered = medfilt1(valueSpline, opt.nFilter);
    
    
    % Plot stator voltage
    subplot(2,1,1);
    plot(data.Time, VoltageAnalysis, 'Linewidth', 1); 
    hold on
    plot(data.Time, initialFiltered, ':', 'Linewidth', 2); 
    plot(timePeaks, valuePeaks, 'ko');
    plot(timeSpline, valueSpline, '-', 'Linewidth', 2);
    plot(timeSpline, valueFiltered, '--', 'Linewidth', 2);
    xlim([opt.startTime-0.5, opt.endTime]);
    legend ('Raw data', 'Initial filtration', 'Peaks', 'Spline (used)', ...
    'Filtered spline');
    grid on;
    subplot(2,1,2);
    plot(data.Time, VoltageAnalysis, 'Linewidth', 1); 
    hold on
    plot(data.Time, initialFiltered, ':', 'Linewidth', 2); 
    plot(timePeaks, valuePeaks, 'ko', 'MarkerFaceColor', 'b');
    plot(timeSpline, valueSpline, '-', 'Linewidth', 2);
    plot(timeSpline, valueFiltered, '--', 'Linewidth', 2);
    timelimit = .2;
    xlim([opt.startTime-.05, opt.startTime+timelimit]);
    maxvalue = max(valueSpline(1:fix(timelimit/opt.splineTime)));
    ylim([-fix(maxvalue/5) 1.1*maxvalue]);
    legend ('Raw data', 'Initial filtration', 'Peaks', 'Spline (used)', ...
        'Filtered spline');
    legend('Location','northwest');
    grid on;
    
    
    % Overload time and stator voltage
    time = timeSpline-timeSpline(1);
    voltage = valueSpline;
    deltaU = opt.uSteady - voltage;
    
    % Cutting values for logistic function
    timeCutting = time(opt.cutPoints:end);
    yUCutting = deltaU(opt.cutPoints:end);
    
    % Create the objective function
    logfun = @(beta, timeCutting, yUCutting) sum((yUCutting - ...
        (beta(1)./(1 + beta(2).*exp(-beta(3).*timeCutting)))).^2);

    % Create an anonymous function
    foo = @(beta) logfun(beta, timeCutting, yUCutting);
    beta0 = [opt.uSteady; 0; 0];
    options.MaxFunEvals = Inf;
    options.MaxIter = Inf;
    beta = fminsearch(foo, beta0, options);
    deltaUfun = @(time) beta(1)./(1 + beta(2).*exp(-beta(3).*time));
    deltaUsub = deltaU - deltaUfun(time); 

    % Plot results of calculation
    figure('Name', title)
    semilogy(time, deltaU, time, deltaUfun(time), 'Linewidth', 2);
    hold on;
    semilogy(time, deltaUsub, 'Linewidth', 2);
    xticks(0:1:fix(time(end)));
    xlim([0,fix(time(end))]);
    ylim([deltaUfun(time(end))-500,deltaU(1)+500])
    legend ('\DeltaU_{original}','\DeltaU_{logistic}');
    grid on; 

    % Ñalculation of inductive reactances 
    divider = 6^0.5*opt.ik*opt.zn;
    xTran = (opt.uSteady - deltaUfun(0))/divider;
    xSubTran = voltage(1)/divider;
    fprintf(title + ":\n");
    fprintf("X' = %.3f and X'' = %.3f;\n", xTran, xSubTran);

    % Ñalculation of time constants 
    tTran = -log((beta(1)-deltaUfun(0)/exp(1))/ ...
        (beta(2)*deltaUfun(0)/exp(1)))/beta(3);
    %inc = deltaUsub <= deltaUsub(1)/exp(1);
    [row, ~] = find(deltaUsub <= deltaUsub(1)/exp(1));
    tSubTran = time(row(1));
    fprintf("T' = %.1fs and T'' = %.3fs.\n", tTran, tSubTran);
end