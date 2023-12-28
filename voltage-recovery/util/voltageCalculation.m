function voltageCalculation(data,VoltageAnalysis,opt,title)
    plotCurrent(data,opt,title);
    out = calculatePeaksSpline(data,VoltageAnalysis,opt);
   	out = overwriteVoltage(out,opt);
    plotVoltage(data,VoltageAnalysis,out,opt,title);
    out = createLogFun(out,opt);
    plotSemilog(out,title);
    reactances(out,opt,title);
end