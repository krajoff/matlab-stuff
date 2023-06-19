function polarweight(T)
    %% Depict polar plot of weights in according to mode
    categories = unique(T.Mode);
    list = regexprep(string(categories),'[0-9+-/%.]','');
    color = [];
    figure('Name', 'Weight');
    for i=1:length(categories)
        var = T(T.Mode == categories(i), :);
        color = [color; polarfun(var.ComplexWeight)];
        hold on
        addtext(var);
    end
    for i=1:length(categories)
        var = T(T.Mode == categories(i), :);
        arrowpolarplot(var.ComplexWeight, color(i,:));
    end
  
    legend(list);
    hold off
end