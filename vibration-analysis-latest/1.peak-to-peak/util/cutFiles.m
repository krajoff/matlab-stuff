% ------------------------------------------------------------------------ 
% Method to reduce size of file. It is valid for text files:
% .txt, .dat, or .csv  
% .xls, .xlsb, .xlsm, .xlsx, .xltm, .xltx, or .od
% ------------------------------------------------------------------------
function cutFiles(oPath, nPath, lastTimeInSec, reduceTimeRes)
    list = dir(oPath);
    n = length(list);
    for i = 3:n
        A = fullfile(oPath, list(i).name);
        if isfolder(A)
            cutFiles(fullfile(oPath, list(i).name), ...
                fullfile(nPath, list(i).name), ...
                lastTimeInSec, ...
                reduceTimeRes)
        end
        if isfile(A)
            cutOneFileCVS(fullfile(oPath, list(i).name), ...
                 fullfile(nPath, list(i).name), ...
                 lastTimeInSec, ... 
                 reduceTimeRes)
        end
    end
end


function cutOneFileCVS(oPath, nPath, lastSecTime, decTime)
    [filepath, ~, ~] = fileparts(nPath);
    if ~exist(fullfile(filepath), 'dir')
        mkdir(fullfile(filepath))
    end 
    array = readmatrix(oPath);
    time = array(:,1);
    step = mean(diff(time));
    numRaws = ceil(lastSecTime/step);
    array = array(length(array) - numRaws:decTime:end,:);
    writematrix(array, fullfile(nPath));
end