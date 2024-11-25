function plotCurrent(opt)

    data = opt.data;
    if (sum(strcmp(opt.current(1), data.Properties.VariableNames)) > 0)
        figure('Name', "Stator current");
        
        for i = 1:length(opt.current)
            plot(data.(opt.time), data.(opt.current(i)), 'Linewidth', 2);
            hold on
        end
        xlim([0, opt.timeSpan(2)-opt.timeSpan(1)]);
        legend(opt.current);
        grid on; hold off;
    end     
    
end