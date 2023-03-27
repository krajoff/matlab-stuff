function T = shAn(exfile, folder, opt, outlier) 
% Shaft vibration analys of generator bearings, turbine bearings. 
% Initial data cut off. Rows according to N turns.  
data = cell(1,opt.NumberFiles);
for i = 1:opt.NumberFiles
    data{i} = readmatrix(fullfile(folder, [exfile{i} '.csv']));    
    rT = rowsTurns(data{i}(:, 1), opt.RatedFrequency, opt.RelativeFrequency(i));
    data{i} = data{i}(end-rT*(opt.NumberTurns+22)-1:end-rT*22, :);
end 
%% Shaft Analysis
goods = ones(opt.NumberFiles, 4);                                     % number of parameters
if outlier == 1
    figure('Name', 'Remove outliers of shaft vibraiton', 'Position', [50, 50, 1150, 700])
end    
for i = 1:opt.NumberFiles
    l = size(data{i},1);
    time = data{i}(:,1);
    value = data{i}(:,2);                                             % data values    
    rT = rowsTurns(time, opt.RatedFrequency, opt.RelativeFrequency(i));
    if outlier == 1
        value = value - mean(value); 
        subplot(ceil(opt.NumberFiles/5), 5, i);
        plot(time(1:rT), value(1:rT), 'LineStyle', '-', 'Color', '#4DBEEE', 'LineWidth', 3);
        title(exfile{i})
        hold on
        value = medfilt1(value, 100);
        plot(time(1:rT), value(1:rT), 'LineStyle', '-', 'Color', '#A2142F', 'LineWidth', 1);
    end    
    k = 1;
    goods(i, k) = int32(peak2peak(value));                            % max value peak-to-peak in 15 turn  
    avrpeak2peak = 0;
    for j = 1:opt.NumberTurns
       avrpeak2peak = avrpeak2peak + ...
           peak2peak(value((j-1)*rT+1:j*rT));
    end    
    k = k + 1; goods(i, k) = int32(avrpeak2peak/opt.NumberTurns);     % average peak-to-peak during 15 turns
% FFT-signal
    ts = mean(diff(time));
    fs = 1/ts;
    fn = fs/2;
    fv = linspace(0, 1, fix(l/2)+1)*fn;
    Iv = 1:length(fv);
    A = zeros(l/2+1, 0);
    P = zeros(l/2+1, 0);
    value = value - mean(value);
    Y = fft(value)/l;
    A = [A 2*abs(Y(Iv))];
    RatedFrequencyNum = int32(opt.RelativeFrequency(i)*opt.RatedFrequency/fv(2));
    k = k + 1; goods(i, k) = 2*int32(max(A(RatedFrequencyNum-3:RatedFrequencyNum+3)));
    k = k + 1; goods(i, k) = 2*int32(max(A(2*RatedFrequencyNum-3:2*RatedFrequencyNum+3)));
    varName = {'Sp_p_max', 'Sp_p', 'RsX1', 'RsX2'};
end
%namefile = cellfun(@(S) S(1:end-4), exfile, 'Uniform', 0);
namefile = strcat(exfile, '-', folder(end-2:end-1));
T = array2table(goods, 'RowNames', namefile, 'VariableNames', varName);