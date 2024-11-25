close all;        
        data = opt.data;       
        time = data.(opt.time);
        
        fs = 1/opt.disTime;
        
       
        R = -data.(opt.current(1));
        integral_currentA = cumtrapz(time,R)*2*pi*opt.f;
        
        linear = polyfit(time(1:opt.timeStart/opt.disTime+1), ...
            integral_currentA(1:opt.timeStart/opt.disTime+1), 1);
        
        function_fit = polyval(linear,time);
       
        rogowski = integral_currentA-function_fit;
        error = 0;
        delta = 1.7+1.898-1.913;
        
        figure('Name', "Stator current");
        plot(time,rogowski, ...
            SHUNT.Time+delta-error,SHUNT.CurrentA,...
             'Linewidth', 2);
        legend ('Rogowski', 'Shunt');
        xlim([1.9, 2.2]);
        grid on;
        
%         figure();
%         plot(T,-data.VoltageA,'-',SHUNT.Time+delta,...
%             -SHUNT.VoltageA,'-');
%         grid on;
        
        