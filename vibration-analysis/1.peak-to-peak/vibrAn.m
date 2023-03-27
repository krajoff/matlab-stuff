function T = vibrAn(exfile, folder, opt) 
% Vibration analys of generator bearings, turbine bearings, bearing support, turbine cover. 
% Initial data cut off. Rows according to N turns  
data = cell(1,opt.NumberFiles);
for i = 1:opt.NumberFiles
    data{i} = readmatrix(fullfile(folder, [exfile{i} '.csv']));
    rT = rowsTurns(data{i}(:, 1), opt.RatedFrequency, opt.RelativeFrequency(i));
    data{i} = data{i}(end-rT*opt.NumberTurns-1:end, :);
end
%% Vibration analysis   
goods = ones(opt.NumberFiles, 9);                           % number of parameters
for i = 1:opt.NumberFiles
    l = size(data{i},1);
    time = data{i}(:,1);
    value = data{i}(:,2);                                   % data values
    ts = mean(diff(time));
    fs = 1/ts;
    rT = rowsTurns(time, opt.RatedFrequency, opt.RelativeFrequency(i));
    k = 1;
    goods(i,k) = int32(peak2peak(value));                   % max value peak-to-peak in 15 turn  
    k = k + 1;
    goods(i, k) = int32(2.828*rms(value));                  % root-mean square level  
    avrpeak2peak = 0;
    for j = 1:opt.NumberTurns
       avrpeak2peak = avrpeak2peak + ...
           peak2peak(value((j-1)*rT+1:j*rT));
    end    
    k = k + 1; goods(i, k) = int32(avrpeak2peak/opt.NumberTurns);     % average peak-to-peak during 16 turns
% lowpass IIR filter with passband frequency 1Hz. fvtool(lpFilt) 
    lpFilt = designfilt('lowpassiir', 'FilterOrder', 10, ...
        'PassbandFrequency', 1, 'PassbandRipple', 0.2, ...
        'SampleRate', fs);
    dataOut = filter(lpFilt, value);
    avrpeak2peak = 0;
    for j = 1:opt.NumberTurns
       avrpeak2peak = avrpeak2peak + ...
           peak2peak(dataOut((j-1)*rT+1:j*rT));
    end 
    k = k + 1; goods(i, k) = int32(avrpeak2peak/opt.NumberTurns);      
% bandpass IIR filter with passband frequency 1-30Hz. fvtool(bpFilt)    
    bpFilt = designfilt('bandpassiir', 'FilterOrder', 10, ...
        'HalfPowerFrequency1', 1, 'HalfPowerFrequency2', 30, ...
        'SampleRate', fs);
    dataOut = filter(bpFilt, value);
    avrpeak2peak = 0;
    for j = 1:opt.NumberTurns
       avrpeak2peak = avrpeak2peak + ...
           peak2peak(dataOut((j-1)*rT+1:j*rT));
    end 
    k = k + 1; goods(i, k) = int32(avrpeak2peak/opt.NumberTurns);         
% highpass IIR filter with passband frequency 30Hz. fvtool(hpFilt)
    hpFilt = designfilt('highpassiir', 'FilterOrder', 10, ...
        'PassbandFrequency', 30, 'PassbandRipple', 0.2, ...
        'SampleRate', fs);
    dataOut = filter(hpFilt, value);
    avrpeak2peak = 0;
    for j = 1:opt.NumberTurns
       avrpeak2peak = avrpeak2peak + ...
           peak2peak(dataOut((j-1)*rT+1:j*rT));
    end 
    k = k + 1; goods(i, k) = int32(avrpeak2peak/opt.NumberTurns);    
% FFT-signal
    fn = fs/2;
    fv = linspace(0, 1, fix(l/2)+1)*fn;
    Iv = 1:length(fv);
    A = zeros(l/2+1, 0);
    P = zeros(l/2+1, 0);
    value = value - mean(value);
    Y = fft(value)/l;
    A = [A 2*abs(Y(Iv))];
    opt.RatedFrequencyNum = int32(opt.RelativeFrequency(i)*opt.RatedFrequency/fv(2));
    k = k + 1; goods(i, k) = 2*int32(max(A(opt.RatedFrequencyNum-3:opt.RatedFrequencyNum+3)));
    k = k + 1; goods(i, k) = 2*int32(max(A(2*opt.RatedFrequencyNum-3:2*opt.RatedFrequencyNum+3)));
    k = k + 1; goods(i, k) = 2*int32(max(A(5*opt.RatedFrequencyNum-3:5*opt.RatedFrequencyNum+3)));
    varName = {'Sp_p_max','DobleAcp','Sp_p','Less_1Hz','Band_1_30Hz', ...
                'More_30Hz', 'RsX1', 'RsX2', 'RsX5'};
end
%namefile = cellfun(@(S) S(1:end-4), exfile, 'Uniform', 0);
namefile = strcat(exfile, '-', folder(end-2:end-1));
T = array2table(goods, 'RowNames', namefile, 'VariableNames', varName);