function plotNsquare(channels, name, lim, NumberPoles, frequency)
numChannels = length(channels);
numSpeed = height(channels{1});
if mod(numChannels,2)==0
    figure('Name', name, 'Position', [50, 50, 1150, 700])
    plot((frequency(1:numSpeed)*6000/NumberPoles).^2, channels{1}.RsX1, 's',  'LineWidth' , 1.5, ...
        'MarkerFaceColor' , '#0072BD' , ...
        'DisplayName', legName(channels{1}.Properties.RowNames(1)));
    hold on
    plot((frequency(1:numSpeed)*6000/NumberPoles).^2, channels{2}.RsX1, 's',  'LineWidth' , 1.5, ...
       'MarkerFaceColor' , '#D95319', ...
       'DisplayName', legName(channels{2}.Properties.RowNames(1)));
    hold off
    xlabel('n^2, (Ó·/ÏËÌ)^2', 'Units', 'Pixels', 'Position', [830 35], 'FontSize', 12)
    ylabel('2A_{Ó·}, ÏÍÏ', 'Units', 'Pixels', 'Position', [30 570], 'FontSize', 12, 'Rotation', 0)
    set(gca,'FontSize', 12)
    ax = gca;
    grid on
    legend
    legend boxoff
%    xlim([1 numMode])
%    ax.XTick = 1:1:numMode;
    ylim([0 lim])
    if mod(lim, 6)==0
        ax.YTick = 0:lim/6:lim;
    elseif mod(lim, 7)==0
        ax.YTick = 0:lim/7:lim;
    else
        ax.YTick = 0:lim/5:lim;
    end
    if not(isfolder('pictures'))
        mkdir('pictures')
    end    
    saveas(gcf, ['pictures\' name 'Speed.png'])
end
end

function str = legName(x)
if contains(x, 'RB')
    str = 'œ¡';
elseif contains(x, 'LB')   
    str = 'À¡';
else
    if contains(x, 'TR')
        str = 'Õ¡';
    else
        str = '¬¡';
    end
end
end