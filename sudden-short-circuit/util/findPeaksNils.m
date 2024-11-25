function opt = findPeaksNils(opt)

    data = opt.data;
    time = opt.data.(opt.time);
    
    for i = 1:length(opt.current)
        current = data.(opt.current(i));
        nils = getNils(current);
        opt = getPeaks(nils,times,current,opt,opt.curent(i));      
    end
end

function result = getNils(data)
    data = detrend(data,1);
    result = [];
    for i = 1:length(data)-1
        if time(i)>opt.timeSpan(1) && time(i)<opt.timeSpan(2)
            if data(i)*data(i+1)<=0
                if data(i)>0; result(end+1,:) = [i,1]; end
                if data(i)<0; result(end+1,:) = [i,-1]; end
            end
        end
    end
end

function opt = getPeaks(nils,time,data,opt,name)
    maxPeaks = []; minPeaks = [];
    for i = 1:length(nils)
        startPoint = nils(i,1);
        endPoint = nils(i+1,1);
        dataSpan = data(startPoint:endPoint);
        timeSpan = time(startPoint:endPoint);
        switch nils(i,2)
            case 1                
                minPeaks(end+1,2) = min(dataSpan);
                c = find(dataSpan == minPeaks(end,2));
                minPeaks(end,1) = timeSpan(c(1));
            case -1
                maxPeaks(end+1,2) = max(dataSpan);
                c = find(dataSpan == maxPeaks(end,2));
                maxPeaks(end,1) = timeSpan(c(1));
        end
    end
    opt.peaks.name = table(maxPeaks);
end
