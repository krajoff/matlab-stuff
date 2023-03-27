% ------------------------------------------------------------------------ 
% Shaft vibration analys of generator bearings, turbine bearings. 
% Initial data with subtle cut off. Rows according to N turns
% ------------------------------------------------------------------------
function T = shAn(exfile, folder, opt, outlier, name, tail) 
    data = tailData(exfile, folder, opt, tail);
    goods = ones(opt.NumberFiles, 4); % number of parameters                                    
    if logical(outlier)
        f = figure('Name', ['Remove outliers of shaft vibraiton. ', ...
            regexprep(name, '\W', ' ')], 'Position', [0, 0, 1000, 700]);
        movegui(f, 'center');
    end    
    for i = 1:opt.NumberFiles
        time = data{i}(:,1);
        value = data{i}(:,2);   
        rT = rowsTurns(time, opt.RatedFrequency, opt.RelativeFrequency(i));
        if logical(outlier)
            medfilterSignal(time, value, outlier, ...
                opt.NumberFiles, exfile{i}, rT, i);
        end    
        goods(i, 1) = int32(peak2peak(value));
        goods(i, 2) = avrp2p(value, rT, opt.NumberTurns); 
        [A, fv] = fftAmplitude(time, value);
        ratedFrqNum = int32(opt.RelativeFrequency(i)*opt.RatedFrequency/fv(2));
        goods(i, 3) = 2*int32(max(A(ratedFrqNum-3:ratedFrqNum+3)));
        goods(i, 4) = 2*int32(max(A(2*ratedFrqNum-3:2*ratedFrqNum+3)));
        varName = {'Sp_p_max', 'Sp_p', 'RsX1', 'RsX2'};
    end
    namefile = strcat(exfile, '-', folder(end-2:end-1));
    T = array2table(goods, 'RowNames', namefile, 'VariableNames', varName);
end