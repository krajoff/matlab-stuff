function opt = currentCalculation(opt)
    opt = checkOpt(opt);
    opt = increaseStep(opt);
    opt = currentIntegration(opt);
    plotCurrent(opt);
    opt = findPeaks(opt);
   % opt = calculatePeaksSpline(opt);
%    	out = overwriteVoltage(out,opt);
%     plotVoltage(data,VoltageAnalysis,out,opt,title);
%     out = createLogFun(out,opt);
%     out = createSubLogFun(out,opt);
%     plotSemilog(out,opt,title);
%     out = reactances(out,opt);
%     printResults(out,title);
end