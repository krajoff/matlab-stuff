function [time, lock, pks] = getgap(opt)
%% Plot minimum of air gap
data = readmatrix(fullfile(opt.GeneralFolder, opt.DataFile));               % read txt-file
ts = mean(diff(data(:, 1)));                                                % sample rate 
data = data(1:opt.DecreaseRatioByTime:end, :);                              % reduced data
ts = mean(diff(data(:,1)));                                                 % sample rate of data reduced
splitpoles = round(opt.CuttingPoles/opt.RatedFrequency/ts/2);
time = data(1:end-splitpoles, 1); 
counter = data(splitpoles+1:end, 2); 
airgap = data(splitpoles+1:end, 3);                                         % data definition
% close all
%% Plot minimum of air gap
poleSample = 1/opt.RatedFrequency/ts;
[pks, lock] = findpeaks(max(airgap) - airgap, 'MinPeakDistance', poleSample/4);
pks = max(airgap) - pks;
if opt.NewFigure == true
    figure('Name', ['Minimum of air gap' opt.DataFile])
else
    hold on
end
%stairs(time, airgap); hold on; 
stairs(time(lock), pks, 'LineWidth' , 1.5, 'color', opt.Color); hold on; 
stairs(time, rescale(counter, min(airgap), max(airgap))); hold off;
poles = repmat(opt.NumberPoles:-1:1, 1, ...
    floor(length(airgap)*2/poleSample/opt.NumberPoles))';
timeTurns = opt.NumberPoles/(2*opt.RatedFrequency);                         % n-turns time
timestep = 0:time(poleSample+1):time(end);
set(gca, 'xtick', timestep, ...
    'xticklabel', poles(1:2:length(timestep)), 'FontSize', 10);
xlim([timeTurns timeTurns*(opt.NumberTurns+1)]);
ylim([floor(min(pks)) ceil(max(pks(poleSample:end-poleSample)))]);
grid on
end

