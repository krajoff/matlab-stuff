function opt = currentIntegration(opt)
    if(opt.isRogowski)
        
        startPoint = int32(opt.timeSpan(1)/opt.disTime+1);
        endPoint = int32(opt.timeSpan(2)/opt.disTime+1);
        data = opt.data(startPoint:endPoint,:);
        data.(opt.time) = data.(opt.time)-data.(opt.time)(1);
        time = data.(opt.time);
        
        for i = 1:length(opt.current)
            data.(opt.current(i)) = integralRogowski ...
                (opt,time,data.(opt.current(i)));
        end
        opt.data = data;
        
    end
end

function integral = integralRogowski(opt,time,raw)
	omega = 2*pi*opt.f;
    remove_constant = raw - mean(raw);
    detrended = @(x) detrend(x);
    cum = cumtrapz(time,raw)*omega;
    noize_time = int32(opt.timeStart/opt.disTime+1);
    pol_fit = polyfit(time(1:noize_time),cum(1:noize_time),1);
    fun_fit = polyval(pol_fit,time);
    
    integral = cum - fun_fit;
end