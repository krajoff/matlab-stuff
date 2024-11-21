function plotCurrent(opt)

    data = opt.data;
    if (sum(strcmp(opt.currentA, data.Properties.VariableNames)) > 0)
        figure('Name', "Stator current");
        
        plot(data.(opt.time), data.(opt.currentA), ...
             data.(opt.time), data.(opt.currentB), ...
             data.(opt.time), data.(opt.currentC), ...
             'Linewidth', 2);
        
        xlim([opt.plotTime(1), opt.plotTime(2)]);
        legend ('Current A', 'Current B', 'Current C');
        grid on;
    end     
    
end