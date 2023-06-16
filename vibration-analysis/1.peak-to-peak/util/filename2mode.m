function res = filename2mode(list)
    size = length(list);
    res = cell(1, size);
    for i = 1:size
        numexp = @(exp) regexp(list{i}, exp);
        if ~isempty(numexp('n'))
            res{i} = ['’’“ ', list{i}(1:numexp('n') - 1), 'n_Ì'];
        elseif ~isempty(numexp('U'))
            res{i} = ['’’√ ', list{i}(1:numexp('U') - 1), 'U_Ì']; 
        else  
            res{i} = [list{i}(1:numexp('M') - 1), ' Ã¬Ú']; 
        end
    end
end