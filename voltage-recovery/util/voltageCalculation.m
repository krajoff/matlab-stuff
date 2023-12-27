function voltageCalculation(data,VoltageAnalysis,opt,title)
    
    plotCurrent(data,opt,title);
    out = calculatePeaksSpline(data,VoltageAnalysis,opt,title);
   	out = overwriteVoltage(out,opt);
    plotVoltage(data,VoltageAnalysis,out,opt);
 
    % Cutting values for logistic function
    timeCutting = out.time(opt.cutPoints:end);
    yUCutting = out.deltaU(opt.cutPoints:end);
        
    % Create the objective function
%     logfun = @(beta, timeCutting)beta(1)./(1 + beta(2).*exp(-beta(3)...
%         .*timeCutting));
    logfun = @(beta,timeCutting)beta(1)+beta(2).*exp(-beta(3).*timeCutting);
    
    % Create an anonymous function    
    beta = lsqcurvefit(logfun, opt.beta0, ...
        timeCutting, yUCutting);
    %deltaUfun = @(time)beta(1)./(1+beta(2)*exp(-beta(3).*time));
    deltaUfun = @(time)beta(1)+beta(2).*exp(-beta(3).*time);
    beta
    deltaUsub = out.deltaU - deltaUfun(out.time); 

    % Plot results of calculation
    figure('Name',title)
    semilogy(out.time,out.deltaU,out.time,deltaUfun(out.time),'Linewidth',2);
    %hold on;
    xticks(0:1:fix(out.time(end)));
    xlim([0,fix(out.time(end))]);
    ylim([deltaUfun(out.time(end))*0.9,out.deltaU(1)*1.1])
    legend ('\DeltaU''+\DeltaU''''', '\DeltaU''');
    grid on; 
    %semilogy(out.time, deltaUsub, 'Linewidth', 2);


    % Ñalculation of inductive reactances 
    divider = 6^0.5*opt.ik*opt.zn;
    xTran = (opt.uSteady - deltaUfun(0))/divider;
    xSubTran = out.voltage(1)/divider;
    fprintf(title + ":\n");
    fprintf("Xd' = %.3f and Xd'' = %.3f;\n", xTran, xSubTran);

    % Ñalculation of time constants 
    tTran = -log((beta(1)-deltaUfun(0)/exp(1))/ ...
        (beta(2)*deltaUfun(0)/exp(1)))/beta(3);
    %inc = deltaUsub <= deltaUsub(1)/exp(1);
    [row, ~] = find(deltaUsub <= deltaUsub(1)/exp(1));
    tSubTran = out.time(row(1));
    fprintf("Td0' = %.1fs and Td0'' = %.3fs.\n", tTran, tSubTran);
end