function plotCurrent(data, opt, title)
    if (sum(strcmp('CurrentA', data.Properties.VariableNames)) > 0)
        figure('Name', "Stator current (" + title + ")");
        plot(data.Time, data.CurrentA, ...
            data.Time, data.CurrentB, ...
            data.Time, data.CurrentC,'Linewidth', 2);
        xlim([opt.startTime-0.5, opt.endTime]);
        legend ('Current A', 'Current B', 'Current C');
        grid on;
    end   
end