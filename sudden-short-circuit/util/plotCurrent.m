function plotCurrent(opt)
    % ��������� ������ � ���� �� ��������� opt
    data = opt.data; 
    peaks = opt.peaks;
    
    % ���������, ���� �� ����������, ��������� � opt.current, � ������
    if (sum(strcmp(opt.current(1), data.Properties.VariableNames)) > 0)
        
        % ������� ����� ������ � ������������� ��� ����
        fh = figure('Name', "Stator current, envelope, peaks");
        fh.WindowState = 'maximized'; % ������������� ���� �������
        
        % �������������� ������ ��� �������� ������������ �������� �������
        lineHandles = gobjects(length(opt.current), 1);
        
        % ������� ������ subplot ��� ����������� ������ � ������
        subplot(2,1,1);
        for i = 1:length(opt.current)
            % ������ ������ ��� ������� ���� �� ������ opt.current
            lineHandles(i) = plot(data.(opt.time), data.(opt.current(i)), ...
                'Linewidth', 2, 'DisplayName', opt.current(i)); % ������ ������ � �������� ������� ����� � ������
            hold on; % ������ ������� ������
            % ������ ������������ ���� ��� �������� ����
            plot(peaks.(opt.current(i)).maxPeaks.Time, ...
                 peaks.(opt.current(i)).maxPeaks.Value, 'ko'); % ���� ��������� � ���� ������ ������
            % ������ ����������� ���� ��� �������� ����
            plot(peaks.(opt.current(i)).minPeaks.Time, ...
                 peaks.(opt.current(i)).minPeaks.Value, 'ko'); % ���� �������� � ���� ������ ������
        end
        % ��������� ���� � �������
        xlim([0, opt.timeSpan(2) - opt.timeSpan(1)]);
        legend(lineHandles);
        grid on;
        hold off;
        
        % ������� ������ subplot ��� ����������� ������ �����
        subplot(2,1,2);
        for i = 1:length(opt.current)
            % ������ ������ ���� (������������ � �����������)
            plot(peaks.(opt.current(i)).maxPeaks.Time, ...
                 peaks.(opt.current(i)).maxPeaks.Value, 'ko'); % ���� ���������
            hold on; % ������ ������� ������
            plot(peaks.(opt.current(i)).minPeaks.Time, ...
                 peaks.(opt.current(i)).minPeaks.Value, 'ko'); % ���� ��������
        end
        % ��������� ���� � �������
        xlim([0, opt.timeSpan(2) - opt.timeSpan(1)]);
        legend(lineHandles);
        grid on;
        hold off;
    end
end
