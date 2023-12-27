function out = calculatePeaksSpline(data,VoltageAnalysis,opt,title)
    figure('Name', "Stator voltage, envelope, peaks (" + title + ")");
    initialFiltered = medfilt1(VoltageAnalysis,opt.iFilter);
    [timePeaks,valuePeaks] = findPeaksNils(data.Time,initialFiltered,opt);
    timeSpline = (opt.startTime:opt.splineTime:opt.endTime)';   
    [~,ind] = unique(timePeaks);
    valueSpline = interp1(timePeaks(ind), ...
        valuePeaks(ind),timeSpline,'pchip');
    valueFiltered = smooth(valueSpline,opt.nFilter,'lowess');
    %valueFiltered = medfilt1(valueSpline, opt.nFilter);
    out = struct('initialFiltered', initialFiltered, ...
        'timePeaks', timePeaks, ...
        'valuePeaks', valuePeaks, ...
        'timeSpline', timeSpline, ...
        'valueSpline', valueSpline, ...
        'valueFiltered', valueFiltered);   
end