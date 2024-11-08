function out = calculatePeaksSpline(data,opt)
    
    initialFiltered_1 = medfilt1(data.(opt.names{1}),opt.iFilter);
    initialFiltered_2 = medfilt1(data.(opt.names{2}),opt.iFilter);
    initialFiltered_3 = medfilt1(data.(opt.names{3}),opt.iFilter);

    [timePeaks,valuePeaks] = findPeaksNils(data.Time,initialFiltered,opt);
    
    timeSpline = (opt.startTime:opt.splineTime:opt.endTime)';   
    [~,ind] = unique(timePeaks);
    valueSpline = interp1(timePeaks(ind), ...
        valuePeaks(ind),timeSpline,'pchip');
    valueFiltered = smooth(valueSpline,opt.nFilter,'lowess');
    out = struct('initialFiltered', initialFiltered, ...
        'timePeaks', timePeaks, ...
        'valuePeaks', valuePeaks, ...
        'timeSpline', timeSpline, ...
        'valueSpline', valueSpline, ...
        'valueFiltered', valueFiltered);   
end