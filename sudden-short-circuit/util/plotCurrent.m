function plotCurrent(data,opt)
    if (sum(strcmp(opt.currentA, data.Properties.VariableNames)) > 0)
        figure('Name', "Stator current");
        
        plot(data.Time, data.(opt.currentA), ...
            data.Time, data.(opt.currentB), ...
            data.Time, data.(opt.currentC),'Linewidth', 2);
        
        xlim([opt.startTime, opt.endTime]);
        legend ('Current A', 'Current B', 'Current C');
        grid on;
    end       
end