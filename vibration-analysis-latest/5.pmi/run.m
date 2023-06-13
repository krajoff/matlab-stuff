clear all; close all
addpath(fullfile(pwd, '\util'));
data = readmatrix(fullfile('GA2_unom_time_cnt_pmi_after_repair.csv'));
poles = 16;
data = reducebyrotate(data,poles,2);
time = data(:,1); 
counter = bymax(data(:,2)); 
sgn = bymax(data(:,3));

flow = getflow(sgn);
square = bymax(abs(getsquare(flow)));
plot(time,counter,time,sgn,time,abs(flow));

fcnt = getcountertime(counter,time,.5,poles);

barwithmark(square,fcnt);
ylim([.98 1]);
%ylim([.98 1]);
grid on
