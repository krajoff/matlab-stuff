function plotCurrent(opt)
    % Извлекаем данные и пики из параметра opt
    data = opt.data; 
    peaks = opt.peaks;
    
    % Проверяем, есть ли переменная, указанная в opt.current, в данных
    if (sum(strcmp(opt.current(1), data.Properties.VariableNames)) > 0)
        
        % Создаем новый график и максимизируем его окно
        fh = figure('Name', "Stator current, envelope, peaks");
        fh.WindowState = 'maximized'; % Максимизируем окно графика
        
        % Инициализируем массив для хранения обработанных объектов графика
        lineHandles = gobjects(length(opt.current), 1);
        
        % Создаем первый subplot для отображения данных с пиками
        subplot(2,1,1);
        for i = 1:length(opt.current)
            % Строим график для каждого тока из списка opt.current
            lineHandles(i) = plot(data.(opt.time), data.(opt.current(i)), ...
                'Linewidth', 2, 'DisplayName', opt.current(i)); % Плотим данные с заданной шириной линии и именем
            hold on; % Держим текущий график
            % Строим максимальные пики для текущего тока
            plot(peaks.(opt.current(i)).maxPeaks.Time, ...
                 peaks.(opt.current(i)).maxPeaks.Value, 'ko'); % Пики максимума в виде черных кругов
            % Строим минимальные пики для текущего тока
            plot(peaks.(opt.current(i)).minPeaks.Time, ...
                 peaks.(opt.current(i)).minPeaks.Value, 'ko'); % Пики минимума в виде черных кругов
        end
        % Настройка осей и легенды
        xlim([0, opt.timeSpan(2) - opt.timeSpan(1)]);
        legend(lineHandles);
        grid on;
        hold off;
        
        % Создаем второй subplot для отображения только пиков
        subplot(2,1,2);
        for i = 1:length(opt.current)
            % Строим только пики (максимальные и минимальные)
            plot(peaks.(opt.current(i)).maxPeaks.Time, ...
                 peaks.(opt.current(i)).maxPeaks.Value, 'ko'); % Пики максимума
            hold on; % Держим текущий график
            plot(peaks.(opt.current(i)).minPeaks.Time, ...
                 peaks.(opt.current(i)).minPeaks.Value, 'ko'); % Пики минимума
        end
        % Настройка осей и легенды
        xlim([0, opt.timeSpan(2) - opt.timeSpan(1)]);
        legend(lineHandles);
        grid on;
        hold off;
    end
end
