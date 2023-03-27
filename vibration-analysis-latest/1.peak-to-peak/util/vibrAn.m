% ------------------------------------------------------------------------ 
% Vibration analys of generator bearings, 
% turbine bearings, bearing support, turbine cover. 
% Initial data cut off. Rows according to N turns  
% ------------------------------------------------------------------------ 
function T = vibrAn(exfile, folder, opt, tail)
    data = tailData(exfile, folder, opt, tail);
    goods = ones(opt.NumberFiles, 9); % number of parameters is 9
    for i = 1:opt.NumberFiles
        time = data{i}(:,1);
        value = data{i}(:,2);
        rT = rowsTurns(time, opt.RatedFrequency, opt.RelativeFrequency(i));
        goods(i, 1) = int32(peak2peak(value)); % max value peak-to-peak 
        goods(i, 2) = int32(2.828*rms(value)); % root-mean square level  
        goods(i, 3) = avrp2p(value, rT, opt.NumberTurns);
        % lowpass IIR filter with passband frequency 1Hz. fvtool(lpFilt)
        fs = 1/mean(diff(time));
        lpFilt = designfilt('lowpassiir', 'FilterOrder', 10, ...
            'PassbandFrequency', 1, 'PassbandRipple', 0.2, ...
            'SampleRate', fs);
        dataOut = filter(lpFilt, value);
        goods(i, 4) = avrp2p(dataOut, rT, opt.NumberTurns);      
        % bandpass IIR filter with passband frequency 1-30Hz. fvtool(bpFilt)    
        bpFilt = designfilt('bandpassiir', 'FilterOrder', 10, ...
            'HalfPowerFrequency1', 1, 'HalfPowerFrequency2', 30, ...
            'SampleRate', fs);
        dataOut = filter(bpFilt, value);
        goods(i, 5) = avrp2p(dataOut, rT, opt.NumberTurns);             
        % highpass IIR filter with passband frequency 30Hz. fvtool(hpFilt)
        hpFilt = designfilt('highpassiir', 'FilterOrder', 10, ...
            'PassbandFrequency', 30, 'PassbandRipple', 0.2, ...
            'SampleRate', fs);
        dataOut = filter(hpFilt, value);
        goods(i, 6) = avrp2p(dataOut, rT, opt.NumberTurns);
        [A, fv] = fftAmplitude(time, value);
        ratedFrqNum = int32(opt.RelativeFrequency(i)* ...
            opt.RatedFrequency/fv(2));
        goods(i, 7) = 2*int32(max(A(ratedFrqNum-3:ratedFrqNum+3)));
        goods(i, 8) = 2*int32(max(A(2*ratedFrqNum-3:2*ratedFrqNum+3)));
    	goods(i, 9) = 2*int32(max(A(5*ratedFrqNum-3:5*ratedFrqNum+3)));
        varName = {'Sp_p_max','DobleAcp','Sp_p','Less_1Hz', ...
            'Band_1_30Hz', 'More_30Hz', 'RsX1', 'RsX2', 'RsX5'};
    end
    namefile = strcat(exfile, '-', folder(end-2:end-1));
    T = array2table(goods, 'RowNames', namefile, 'VariableNames', varName);
end