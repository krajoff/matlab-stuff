clear all; close all; clc 
%% Main information of the data  
opt = struct('GeneralFolder', fileparts(pwd), ...
             'DataFile', '2.air_gap_upper_tail_race.txt', ...
             'NumberPoles', 60, ...
             'NumberTurns', 1, ...
             'RatedFrequency', 50, ...
             'DecreaseRatioByTime', 4, ...
             'CuttingPoles', 43, ...
             'NewFigure', true, ...
             'Color', '#0072BD');
[time, lock, pks] = getgap(opt);
%{
opt.DataFile = '1.air_gap_down_tail_race.txt';
opt.CuttingPoles =  26;
opt.NewFigure = false;
opt.Color = '#D95319';
[~, ~, ~] = getgap(opt);
%}
         
%[fv, A, phase, Y] = fftsignal(time(lock), pks, 1);

%Y = fft(data)/l;
%Y = fft(data)/l;
%{
A = [A 2*abs(Y(Iv))];
phase = angle(Y);
a = zeros(length(A), 1);
a(17) = A(17);
ifft(a);
%}