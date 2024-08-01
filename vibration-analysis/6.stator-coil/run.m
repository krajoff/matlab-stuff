clear all; close all
addpath(fullfile(pwd, '\util'));
poles = 88;


%[time, counter, base, signal, fs] = ...
%    importdata('data\Tupolang\100%U_coil_ПБ_верх.csv', poles);

[time, counter, signal, fs] = ...
    importsignal('data\Votkinsk\Cooler-7.csv', poles);
   

flow = getflow(signal, 1/fs, 5);
figure('Name', 'Raw signal')
plot(time,counter*max(signal), time,abs(signal),'LineWidth', 1);

fcnt = getcountertime(counter, time, poles);
mm = maxinpole(signal);
barwithmark(rescale(mm), fcnt, 'Max values by pole', [0.95 1]);

square = (abs(getsquare(signal)));
barwithmark(square, fcnt, 'Sum of signal by pole', [0 0]);