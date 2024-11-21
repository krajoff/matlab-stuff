function opt = increaseStep(opt)

    % Вычисляем средний шаг времени
    ts = mean(diff(opt.data.(opt.time)));
    % Рассчитываем интервал выборки
    step = int32(opt.disTime/ts);
    
    if step > 1
        % Уменьшаем количество данных
        opt.data = opt.data(1:step:end, :);
    end
    
    % Обновляем параметры
    opt.disTime = ts;
    opt.ppp = int32(1/(ts*opt.f));

end