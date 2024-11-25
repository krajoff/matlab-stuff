function opt = currentIntegration(opt)
    % ���������, ������������ �� ������������� ����������
    if opt.isRogowski
        % ��������� ������� ������ � ����� ���������� ���������
        [startPoint, endPoint] = calculateTimeRange(opt);

        % ��������� ������ � ����������� �����
        data = extractAndNormalizeData(opt, startPoint, endPoint);
        time = data.(opt.time);

        % ����������� ������ ������ ����
        for i = 1:length(opt.current)
            data.(opt.current(i)) = ...
            computeRogowskiIntegral(opt, time, data.(opt.current(i)));
        end

        % ��������� ����������� ������
        opt.data = data;
    end
end

function [startPoint, endPoint] = calculateTimeRange(opt)
    % ���������� ���������� � ��������� �������� ���������� ���������
    startPoint = int32(opt.timeSpan(1) / opt.disTime + 1);
    endPoint = int32(opt.timeSpan(2) / opt.disTime + 1);
end

function data = extractAndNormalizeData(opt, startPoint, endPoint)
    % ���������� ������ �� ���������� ���������
    data = opt.data(startPoint:endPoint, :);
    
    % ������������ ������� (������ ������� �� 0)
    data.(opt.time) = data.(opt.time) - data.(opt.time)(1);
end

function integral = computeRogowskiIntegral(opt, time, signal)
    % ������� ��������� �������� ������� � ������ ���������� ��������������.

    % ���������� ������� �������
    omega = 2 * pi * opt.f;

    % ������� ���������� ������������
    signalNoDC = signal - mean(signal);

    % ��������� ��������� �������������� ������� ��������
    cumulativeIntegral = cumtrapz(time, signal) * omega;

    % ��������� �������� �����
    trendFreeIntegral = removeLinearTrend(opt, time, cumulativeIntegral);

    % ���������� ����������������� ��������
    integral = trendFreeIntegral;
end

function correctedSignal = removeLinearTrend(opt, time, signal)
    % ���������� ��������� ������ �� �������
    noiseTimeIdx = int32(opt.timeStart / opt.disTime + 1);

    % ������ ��������� ������ �� ���������� �������� ������
    polyCoeff = polyfit(time(1:noiseTimeIdx), signal(1:noiseTimeIdx), 1);

    % ���������� �������� ������
    trend = polyval(polyCoeff, time);

    % �������� ������ �� �������
    correctedSignal = signal - trend;
end
