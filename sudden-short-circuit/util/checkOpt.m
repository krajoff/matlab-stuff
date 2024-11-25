function opt = checkOpt(opt)

    time = opt.data.(opt.time);
    if isempty(time)
        error('The time array is empty.');
    end

    % Убедимся, что временной интервал задан корректно
    if opt.timeSpan(1) > opt.timeSpan(2)
        % Меняем местами начало и конец интервала
        opt.timeSpan = [opt.timeSpan(2), opt.timeSpan(1)];
    end

    % Ограничиваем верхнюю границу интервала концом массива времени
    if opt.timeSpan(2) > time(end)
        opt.timeSpan(2) = time(end);
    end

    % Проверяем, что начало интервала больше нуля
    if opt.timeStart <= 0
        error('The start of the time span must be greater than zero.');
    end
    
end
