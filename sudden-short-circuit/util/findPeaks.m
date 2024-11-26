function opt = findPeaks(opt)

    data = opt.data;
    time = opt.data.(opt.time);
    
    for i = 1:length(opt.current)
        current = data.(opt.current(i));
        nils = getNils(time,current,opt);
        opt = getPeaks(nils,time,current,opt,opt.current(i));      
    end
end

function result = getNils(time,data,opt)
    % Удаление тренда
    data = detrend(data,1);
    result = [];
    for i = 1:length(data)-1
        % Условие проверки временного диапазона
        if time(i)>opt.timeStart && time(i)<opt.timeSpan(2)
             % Поиск пересечения с осью
            if data(i)*data(i+1)<=0
                 % Разделение на верхние (1) и нижние (-1)
                if data(i)>0
                    result(end+1,:) = [i,1];
                elseif data(i)<0
                    result(end+1,:) = [i,-1];
                end
            end
        end
    end
end

function opt = getPeaks(nils,time,data,opt,name)
    maxPeaks = []; minPeaks = [];
    for i = 1:length(nils)-1
        
        % Определение диапазона
        startPoint = nils(i,1);
        endPoint = nils(i+1,1);
        dataSpan = data(startPoint:endPoint);
        timeSpan = time(startPoint:endPoint);
        
        % Поиск максимумов и минимумов
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
    
    % Сохранение пиков
    opt.peaks.(name).maxPeaks = array2table(maxPeaks, ...
        'VariableNames', {'Time', 'Value'});
    opt.peaks.(name).minPeaks = array2table(minPeaks, ...
        'VariableNames', {'Time', 'Value'});
end
