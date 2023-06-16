clear all; close all
addpath(fullfile(pwd, '\util'));
poles = 16;
[time, counter, base, signal, fs] = ...
    importdata('data\100%U_coil_ПБ_верх.csv', poles);

flow = getflow(signal, 1/fs, 5);
figure('Name', 'Raw signal')
plot(time,counter*max(signal), time,abs(base),'LineWidth', 1);

fcnt = getcountertime(counter, time, poles);
mm = maxinpole(signal);
barwithmark(rescale(mm), fcnt, 'Max values by pole', [0.95 1]);

square = (abs(getsquare(signal)));
barwithmark(square, fcnt, 'Sum of signal by pole', [0 0]);

square = (abs(getsquare(base)));
barwithmark(square, fcnt, 'Sum of base by pole', [0 0]);
