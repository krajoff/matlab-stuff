function opt = currentIntegration(opt)
    % Проверяем, используется ли трансформатор Роговского
    if opt.isRogowski
        % Вычисляем индексы начала и конца временного диапазона
        [startPoint, endPoint] = calculateTimeRange(opt);

        % Извлекаем данные и нормализуем время
        data = extractAndNormalizeData(opt, startPoint, endPoint);
        time = data.(opt.time);

        % Интегрируем каждый сигнал тока
        for i = 1:length(opt.current)
            data.(opt.current(i)) = ...
            computeRogowskiIntegral(opt, time, data.(opt.current(i)));
        end

        % Сохраняем обновленные данные
        opt.data = data;
    end
end

function [startPoint, endPoint] = calculateTimeRange(opt)
    % Вычисление начального и конечного индексов временного диапазона
    startPoint = int32(opt.timeSpan(1) / opt.disTime + 1);
    endPoint = int32(opt.timeSpan(2) / opt.disTime + 1);
end

function data = extractAndNormalizeData(opt, startPoint, endPoint)
    % Извлечение данных из временного диапазона
    data = opt.data(startPoint:endPoint, :);
    
    % Нормализация времени (начало отсчета от 0)
    data.(opt.time) = data.(opt.time) - data.(opt.time)(1);
end

function integral = computeRogowskiIntegral(opt, time, signal)
    % Функция вычисляет интеграл сигнала с учетом Роговского трансформатора.

    % Постоянная угловая частота
    omega = 2 * pi * opt.f;

    % Удаляем постоянную составляющую
    signalNoDC = signal - mean(signal);

    % Выполняем численное интегрирование методом трапеций
    cumulativeIntegral = cumtrapz(time, signal) * omega;

    % Устраняем линейный тренд
    trendFreeIntegral = removeLinearTrend(opt, time, cumulativeIntegral);

    % Возвращаем скорректированный интеграл
    integral = trendFreeIntegral;
end

function correctedSignal = removeLinearTrend(opt, time, signal)
    % Устранение линейного тренда из сигнала
    noiseTimeIdx = int32(opt.timeStart / opt.disTime + 1);

    % Подбор линейного тренда по начальному сегменту данных
    polyCoeff = polyfit(time(1:noiseTimeIdx), signal(1:noiseTimeIdx), 1);

    % Вычисление значения тренда
    trend = polyval(polyCoeff, time);

    % Удаление тренда из сигнала
    correctedSignal = signal - trend;
end
