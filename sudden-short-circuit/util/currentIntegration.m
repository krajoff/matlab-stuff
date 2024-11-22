function opt = currentIntegration(opt)

    if(opt.isRogowski)
        
        startPoint = opt.timeSpan(1)/opt.disTime+1;
        endPoint = opt.timeSpan(2)/opt.disTime+1;
        [c,~] = size(opt.data);
        if c < endPoint; endPoint = c; end    
        data = opt.data(startPoint:endPoint,:);
        
        
        Rog =(AA-ff)*10^4/31;
        error = 0.002;
        delta = 1.7+1.898-1.913;
        
        R = data.(opt.currentA);
       
      
        %remove_constant = @(x) x - mean(x);
        %integral = @(x) cumtrapz(remove_constant(x));
        %remove_constant_tail_points = @(x) x - mean(x(end-opt.ppp*3+1:end));
        %remove_constant_head_points = @(x) x - mean(x(1:opt.ppp*3+1));
       % y_detrended = detrend(y_integrated);
       % integral_tails = @(x) remove_constant_head_points(integral(x));
        
        %data.(opt.currentA) = integral((data.(opt.currentA)));
     
       % T = data.(opt.time);
     %   S = simps(R);
        
     %   M = R - mean(R);
     
     
         R = -data.(opt.currentA)*10^-4;
        AA = cumtrapz(R);
        
        pp = polyfit(T(1:opt.timeStart/opt.disTime+1), ...
            AA(1:opt.timeStart/opt.disTime+1), 1);
        
        ff=polyval(pp,T);
     
     
     
     
        A = cumtrapz(R_filtered);
        B = detrend(A);
        C = A-B; 
        
        figure('Name', "Stator current");
       
        
        
        
        plot(data.(opt.time), A, ...
            data.(opt.time), B, ...
            data.(opt.time), C, ...
             'Linewidth', 2);
        
        xlim([opt.timeSpan(1), opt.timeSpan(2)]);
        %legend ('Current A', 'Current B', 'Current C');
        grid on;
        
        

    end
end