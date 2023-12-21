function voltageCalculation(data, VoltageAnalysis, opt, title)
    % Plot current stator and voltage stator
    figure('Name', 'Current');
    plot(data.Time, data.CurrentA, ...
        data.Time, data.CurrentB, ...
        data.Time, data.CurrentC,'Linewidth', 2);

    figure('Name', "Voltage and envelope of " + title);
    [yupper, ~] = envelope(VoltageAnalysis, opt.pointInt-2, 'peak');
    yupper = medfilt1(yupper, opt.nFilter);
    plot(data.Time, VoltageAnalysis, data.Time, yupper, 'Linewidth', 2);
    grid on;
    

    time = data.Time(opt.startNumber:opt.endNumber)-data.Time(opt.startNumber);
    voltage = yupper(opt.startNumber:opt.endNumber);
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
end