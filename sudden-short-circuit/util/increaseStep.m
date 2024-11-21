function opt = increaseStep(opt)

    % ��������� ������� ��� �������
    ts = mean(diff(opt.data.(opt.time)));
    % ������������ �������� �������
    step = int32(opt.disTime/ts);
    
    if step > 1
        % ��������� ���������� ������
        opt.data = opt.data(1:step:end, :);
    end
    
    % ��������� ���������
    opt.disTime = ts;
    opt.ppp = int32(1/(ts*opt.f));

end