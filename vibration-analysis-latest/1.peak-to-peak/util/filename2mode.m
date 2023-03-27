function res = filename2mode(list)
    size = length(list);
    res = cell(1, size);
    for i = 1:size
        numexp = @(exp) regexp(list{i}, exp);
        if ~isempty(numexp('n'))
            res{i} = ['��� ', list{i}(1:numexp('n') - 1), 'n_�'];
        elseif ~isempty(numexp('U'))
            res{i} = ['��� ', list{i}(1:numexp('U') - 1), 'U_�']; 
        else  
            res{i} = [list{i}(1:numexp('M') - 1), ' ���']; 
        end
    end
end