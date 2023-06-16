% ------------------------------------------------------------------------ 
% Cutting tail of the data to analyze
% One turn is cutting be default
% ------------------------------------------------------------------------
function data = tailData(exfile, folder, opt, null)
    if isnan(null)
        null = 0;
    end
    data = cell(1, opt.NumberFiles);
    for i = 1:opt.NumberFiles
        data{i} = readmatrix(fullfile(folder, [exfile{i} '.csv']));    
        rT = rowsTurns(data{i}(:,1), ...
            opt.RatedFrequency, opt.RelativeFrequency(i));
        data{i} = data{i}(end-rT*(opt.NumberTurns+1+null)-1: ...
            end-rT*(1+null), :);
    end 
end