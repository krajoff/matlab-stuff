function plotVibration(channels, name, lim, modes, exc)
    MarkerColor = {'#0072BD';'#D95319';'#EDB120';'#7E2F8E';'#77AC30';'#4DBEEE';'#A2142F'};
    numChannels = length(channels);
    numMode = height(channels{1});
    figure('Name', name, 'Position', [50, 50, 1150, 700])
    if  ~contains(name, 'ore')
        plot(1:numMode, channels{1}.Sp_p, '-s',  'LineWidth' , 1.5, ...
            'MarkerFaceColor' , '#0072BD' , ...
            'DisplayName', legName(channels{1}.Properties.RowNames(1)));
        if mod(numChannels,2)==0
            hold on
            plot(1:numMode, channels{2}.Sp_p, '-s',  'LineWidth' , 1.5, ...
                'MarkerFaceColor' , '#D95319', ...
                'DisplayName', legName(channels{2}.Properties.RowNames(1)));
        end
        Yaxisname = 'S_{p-p},ìêì';
    else    
        plot(1:numMode, channels{1}.Band_05_30Hz, '-s',  'LineWidth' , 1.5, ...
            'MarkerFaceColor' , '#0072BD' , ...
            'DisplayName', legName(channels{1}.Properties.RowNames(1)));
        if numChannels >= 2
            for i=2:numChannels   
            hold on
            plot(1:numMode, channels{i}.Band_05_30Hz, '-s',  'LineWidth' , 1.5, ...
                'MarkerFaceColor' , MarkerColor{i}, ...
                'DisplayName', legName(channels{i}.Properties.RowNames(1)));
            end
        end   
        Yaxisname = 'S_{p-p 0.5-30Ãö},ìêì';
    end    
    if ~isempty(exc)
        legend(exc);
    end  
    hold off
    xlabel('Ðåæèìû ðàáîòû', 'Units', 'Pixels', 'Position', [820 35], 'FontSize', 12)
    ylabel(Yaxisname, 'Units', 'Pixels', 'Position', [30 560], 'FontSize', 12, 'Rotation', 0)
    set(gca, 'xtick', 1:numMode, 'xticklabel', modes, 'FontSize', 12)
    ax = gca; grid on; legend; legend boxoff
    ax.XTickLabelRotation = 45;
    xlim([1 numMode])
    ax.XTick = 1:1:numMode;
    ylim([0 lim])
    if mod(lim, 6)==0
        ax.YTick = 0:lim/6:lim;
    elseif mod(lim, 7)==0
        ax.YTick = 0:lim/7:lim;
    else
        if lim/10<10
            ax.YTick = 0:10:lim;
        else
            ax.YTick = 0:lim/5:lim;
        end  
    end
    if not(isfolder('pictures')); mkdir('pictures'); end   
    saveas(gcf, ['pictures\' name '.png'])
end


function str = legName(x)
    if contains(x, 'RB')
        str = 'ÏÁ';
    elseif contains(x, 'LB')   
        str = 'ËÁ';
    else
        if contains(x, 'TR')
            str = 'ÍÁ';
        else
            str = 'ÂÁ';
        end
    end
end