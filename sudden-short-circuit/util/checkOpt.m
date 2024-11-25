function opt = checkOpt(opt)

    time = opt.data.(opt.time);
    if isempty(time)
        error('The time array is empty.');
    end

    % ��������, ��� ��������� �������� ����� ���������
    if opt.timeSpan(1) > opt.timeSpan(2)
        % ������ ������� ������ � ����� ���������
        opt.timeSpan = [opt.timeSpan(2), opt.timeSpan(1)];
    end

    % ������������ ������� ������� ��������� ������ ������� �������
    if opt.timeSpan(2) > time(end)
        opt.timeSpan(2) = time(end);
    end

    % ���������, ��� ������ ��������� ������ ����
    if opt.timeStart <= 0
        error('The start of the time span must be greater than zero.');
    end
    
end
