function currentCalculation(data,opt)
    data = currentIntegration(data,opt);
    plotCurrent(data,opt);
%     out = calculatePeaksSpline(data,opt);
%    	out = overwriteVoltage(out,opt);
%     plotVoltage(data,VoltageAnalysis,out,opt,title);
%     out = createLogFun(out,opt);
%     out = createSubLogFun(out,opt);
%     plotSemilog(out,opt,title);
%     out = reactances(out,opt);
%     printResults(out,title);
end