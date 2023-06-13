function [h1, h2] = barwithmark(data, num)
    sel = false(size(data));
    sel(num) = true;
    firstplot = data;
    firstplot(sel) = nan;
    secondplot = data;
    secondplot(~sel) = nan;
    figure
    h1 = bar(firstplot);
    hold on
    h2 = bar(secondplot);
    h2.FaceColor = 'red';
end