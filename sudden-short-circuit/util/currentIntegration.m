function opt = currentIntegration(opt)

    if(opt.needToIntegrate)
        
        startPoint = opt.analysisTime(1)/opt.disTime+1;
        endPoint = opt.analysisTime(2)/opt.disTime+1;
        data = opt.data(startPoint:endPoint,:);
    
        remove_constant = @(x) x - mean(x);
        integral = @(x) cumtrapz(remove_constant(x));
        %remove_constant_tail_points = @(x) x - mean(x(end-opt.ppp*3+1:end));
        %remove_constant_head_points = @(x) x - mean(x(1:opt.ppp*3+1));
       % y_detrended = detrend(y_integrated);
       % integral_tails = @(x) remove_constant_head_points(integral(x));

        data.(opt.currentA) = detrend(integral(data.(opt.currentA)),1);
        data.(opt.currentB) = detrend(integral(data.(opt.currentB)),1);
        data.(opt.currentC) = detrend(integral(data.(opt.currentC)),1);

        opt.data = data;
    end
    
end