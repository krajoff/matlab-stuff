function polarpull(T)
    %% Depict data-table on polar plot in according to mode
    categories = unique(T.Mode);
    list = regexprep(string(categories),'[0-9+-/%.]','');
    color = [];
    
    for i=1:length(categories)
        var = T(T.Mode == categories(i), :);
        color = [color; polarfun(var.ComplexVibration)];
        addtext(var);
        for j = 1:height(T)
            if T.Mode(j) == categories(i) && T.Weight(j) ~= 0      
                [T.CorrectWeight(j), T.CorrectPhase(j)] = ...
                    m_a(var.ComplexVibration(1), ...
                    T.ComplexVibration(j), ...
                    T.Weight(j));
            end
        end
    end
    for i=1:length(categories)
        var = T(T.Mode == categories(i), :);
        arrowpolarplot(var.ComplexVibration, color(i,:));
    end
  
    legend(list);
end