function T = scAn(exfile, folder, opt) 
% Stator core vibration analys. Initial data cut off. Rows according to N turns.  
data = cell(1, opt.NumberFiles);
for i = 1:opt.NumberFiles
    data{i} = readmatrix(fullfile(folder, [exfile{i} '.csv']));
    rT = rowsTurns(data{i}(:, 1), opt.RatedFrequency, opt.RelativeFrequency(i));
    data{i} = data{i}(end-rT*opt.NumberTurns-1:end, :);
end
%% Stator core analysis
goods = ones(opt.NumberFiles, 6);                            % number of parameters
for i = 1:opt.NumberFiles
    l = size(data{i},1);
    time = data{i}(:,1);
    value = data{i}(:,2);                                    % data values    
    ts = mean(diff(time));
    fs = 1/ts;
    rT = rowsTurns(time, opt.RatedFrequency, opt.RelativeFrequency(i));
    avrpeak2peak = 0;
    for j = 1:opt.NumberTurns
       avrpeak2peak = avrpeak2peak + ...
           peak2peak(value((j-1)*rT+1:j*rT));
    end 
    k = 1; goods(i, k) = int32(avrpeak2peak/opt.NumberTurns); % average peak-to-peak during 16 turns
% Bandpass IIR filter with passband frequency .5-30Hz. fvtool(bpFilt)    
    bpFilt = designfilt('bandpassiir', 'FilterOrder', 10, ...
        'HalfPowerFrequency1', .5, 'HalfPowerFrequency2', 30, ...
        'SampleRate', fs);
    dataOut = filter(bpFilt, value);
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
    FreqNum100 = int32(100/fv(2));
    k = k + 1; goods(i, k) = 2*int32(max(A(opt.RatedFrequencyNum-3:opt.RatedFrequencyNum+3)));
    k = k + 1; goods(i, k) = 2*int32(max(A(2*opt.RatedFrequencyNum-3:2*opt.RatedFrequencyNum+3)));
    k = k + 1; goods(i, k) = 2*int32(max(A(3*opt.RatedFrequencyNum-3:3*opt.RatedFrequencyNum+3)));
    k = k + 1; goods(i, k) = 2*int32(max(A(FreqNum100-3:FreqNum100+3)));
    varName = {'Sp_p', 'Band_05_30Hz', 'RsX1', 'RsX2', 'RsX3', 'Hz100'};
end
%namefile = cellfun(@(S) S(1:end-4), exfile, 'Uniform', 0);
namefile = strcat(exfile, '-', folder(end-2:end-1));
T = array2table(goods, 'RowNames', namefile, 'VariableNames', varName);