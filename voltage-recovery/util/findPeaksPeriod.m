function [timePeaks, valuePeaks] = findPeaksPeriod(time, data, opt)
    ts = mean(diff(time));
    ps = int32((ts*opt.f)^-1);
    np = fix(length(data)/ps)-2;
    timePeaks = [];
    valuePeaks = [];
    for i = 0:np
        v = data(i*ps+1:(i+1)*ps+1);
        t = time(i*ps+1:(i+1)*ps+1);
        peak = max(v);
        k = find(v == peak);
        if (t(k(1)) > opt.startTime && t(k(1)) < opt.endTime)
            timePeaks = [timePeaks; t(k(1))];
            valuePeaks = [valuePeaks; v(k(1))];
        end
    end
end