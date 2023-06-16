function [h1, h2] = barwithmark(data, num, name, ylimit)
    sel = false(size(data));
    sel(num) = true;
    firstplot = data;
    firstplot(sel) = nan;
    secondplot = data;
    secondplot(~sel) = nan;
    figure('Name', name)
    h1 = bar(firstplot);
    hold on
    h2 = bar(secondplot);
    h2.FaceColor = 'red';
    if ~ylimit == 0
        ylim(ylimit);
    end
    grid on
end