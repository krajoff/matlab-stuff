% ------------------------------------------------------------------------ 
% Plot intial data and median filter. It is usually used for generator 
% shaft with noise by the rotor winding outputs
% ------------------------------------------------------------------------
function value = medfilterSignal(time, value, out, nF, exF, rT, i)
    value = value - mean(value);
    switch true
        case ismember(nF, 1:3)
            rows = nF; columns = 1; 
        case ismember(nF, 4)
            rows = 2; columns = 2;
        case ismember(nF, 5:9)
            rows = ceil(nF/3); columns = 3;
        case ismember(nF, 10:12)
            rows = ceil(nF/4); columns = 4;
        case ismember(nF, 13:20)
            rows = ceil(nF/5); columns = 5;
        otherwise
            rows = ceil(nF/6); columns = 6;    
    end    
    subplot(rows, columns, i);
    krT = 2*rT; % by default turn number is two 
    plot(time(1:krT), value(1:krT), 'LineStyle', '-', ...
        'Color', '#4DBEEE', 'LineWidth', 3);
    title(exF)
    hold on
    value = medfilt1(value, out);
    plot(time(1:krT), value(1:krT), 'LineStyle', '-', ...
        'Color', '#A2142F', 'LineWidth', 1);
end