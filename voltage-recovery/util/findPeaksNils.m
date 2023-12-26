function [timePeaks,valuePeaks] = findPeaksNils(time,data,opt)
    nils = [];
    ts = mean(diff(time));
    condition = .5/opt.f-2*ts;
    for i = 1:length(data)-1
        if data(i)*data(i+1) <= 0, nils(end+1) = i; end
    end
    timePeaks = [];
    valuePeaks = [];
    for i = 1:length(nils)-1
        deltaTime = time(nils(i+1))-time(nils(i));
        if deltaTime>condition
            if data(nils(i))>data(nils(i+1))
                valuePeaks(end+1) = max(data(nils(i):nils(i+1)));
                k = find(data == valuePeaks(end));
                timePeaks(end+1) = time(k(1));
            end
        end
    end
end
