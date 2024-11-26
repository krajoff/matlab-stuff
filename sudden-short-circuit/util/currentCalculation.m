function opt = currentCalculation(opt)
    opt = checkOpt(opt);
    opt = increaseStep(opt);
    opt = currentIntegration(opt);
    opt = findPeaks(opt);
    plotCurrent(opt);

   % opt = calculatePeaksSpline(opt);
%    	out = overwriteVoltage(out,opt);
%     plotVoltage(data,VoltageAnalysis,out,opt,title);
%     out = createLogFun(out,opt);
%     out = createSubLogFun(out,opt);
%     plotSemilog(out,opt,title);
%     out = reactances(out,opt);
%     printResults(out,title);
end