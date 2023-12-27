function [timePeaks, valuePeaks] = findPeaksPeriod(time,data,opt)  
    ts = mean(diff(time));
    ps = int32((ts*opt.f)^-1);
    np = fix(length(data)/ps)-10;
    timePeaks = [];
    valuePeaks = [];
    startTime = 1;
    endTime = startTime+ps-1;
    for i = 0:np
        ps = fps(time(startTime:endTime+ps*2),opt);        
        endTime = startTime+ps-1;          
        v = data(startTime:endTime);
        t = time(startTime:endTime);
        [te, ve, k] = extractMax(t,v,timePeaks,opt);
        if (t(k(1))>opt.startTime && t(k(1))<opt.endTime)
            timePeaks = [timePeaks;te];
            valuePeaks = [valuePeaks;ve];
        end
        startTime = endTime+1;
    end
end

function [te, ve, k] = extractMax(t,v,tp,opt)
    peak = max(v);
    k = find(v == peak);
    if ~isempty(tp) && (t(k(1))-tp(end) < 1/opt.f/2)
        [te,ve,k] = extractMax(t(k(1)+1:end),v(k(1)+1:end),tp,opt);
    else
        te = t(k(1)); 
        ve = v(k(1));
    end
end

function ps = fps(time,opt)
    ts = mean(diff(time(1:end)));
    ps = int32((ts*opt.f)^-1);
    ts = mean(diff(time(1:ps)));
    ps = int32((ts*opt.f)^-1);
end