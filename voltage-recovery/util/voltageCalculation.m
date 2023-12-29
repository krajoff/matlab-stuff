function voltageCalculation(data,VoltageAnalysis,opt,title)
    plotCurrent(data,opt,title);
    out = calculatePeaksSpline(data,VoltageAnalysis,opt);
   	out = overwriteVoltage(out,opt);
    plotVoltage(data,VoltageAnalysis,out,opt,title);
    out = createLogFun(out,opt);
    out = createSubLogFun(out,opt);
    plotSemilog(out,opt,title);
    out = reactances(out,opt);
    printResults(out,title);
end