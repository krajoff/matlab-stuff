% ------------------------------------------------------------------------ 
% Stator core analys.
% Initial data with subtle cut off. Rows according to N turns
% ------------------------------------------------------------------------
function T = scAn(exfile, folder, opt, tail) 
    data = tailData(exfile, folder, opt, tail);
    goods = ones(opt.NumberFiles, 6); % number of parameters is 6
    for i = 1:opt.NumberFiles
        time = data{i}(:,1);
        value = data{i}(:,2); 
        rT = rowsTurns(time, opt.RatedFrequency, opt.RelativeFrequency(i));
        goods(i, 1) = avrp2p(value, rT, opt.NumberTurns); 
        fs = 1/mean(diff(time));
        rT = rowsTurns(time, opt.RatedFrequency, opt.RelativeFrequency(i));
        % Bandpass IIR filter with passband frequency .5-30Hz.fvtool(bpFilt)    
        bpFilt = designfilt('bandpassiir', 'FilterOrder', 10, ...
            'HalfPowerFrequency1', .5, 'HalfPowerFrequency2', 30, ...
            'SampleRate', fs);
        dataOut = filter(bpFilt, value);
        goods(i, 2) = avrp2p(dataOut, rT, opt.NumberTurns); 
        [A, fv] = fftAmplitude(time, value);
        ratedFrqNum = int32(opt.RelativeFrequency(i)* ...
            opt.RatedFrequency/fv(2));
        FreqNum100 = int32(100/fv(2));
        goods(i, 3) = 2*int32(max(A(ratedFrqNum-3:ratedFrqNum+3)));
    	goods(i, 4) = 2*int32(max(A(2*ratedFrqNum-3:2*ratedFrqNum+3)));
        goods(i, 5) = 2*int32(max(A(3*ratedFrqNum-3:3*ratedFrqNum+3)));
    	goods(i, 6) = 2*int32(max(A(FreqNum100-3:FreqNum100+3)));
        varName = {'Sp_p', 'Band_05_30Hz', 'RsX1', 'RsX2', 'RsX3', 'Hz100'};
    end
    namefile = strcat(exfile, '-', folder(end-2:end-1));
    T = array2table(goods, 'RowNames', namefile, 'VariableNames', varName);
end