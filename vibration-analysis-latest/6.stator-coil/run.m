clear all; close all
addpath(fullfile(pwd, '\util'));
data = readmatrix(fullfile('100%n_coil_ΒΑ_νθη.csv'));
poles = 16;
data = reducebyrotate(data,poles,6);
time = data(:,1); fs = 1/mean(diff(time));
counter = bymax(data(:,2));
raw = data(:,3);
sgn = raw - mean(raw);
sgn = bymax(bpfilter(sgn, 8, 20, 100, fs));
mm = maxinpole(sgn);


flow = bymax(getflow(sgn));
mmflow = maxinpole(flow);
square = bymax(abs(getsquare(flow)));
%plot(time,counter,time,abs(sgn),time,abs(flow),'LineWidth', 1);
plot(time,counter,time,abs(sgn),time,abs(flow),'LineWidth', 1);
ylim([0.86 1]);

legend('counter', 'ABS(signal)', 'ABS(flow)');

fcnt = getcountertime(counter,time,.5,poles);


barwithmark(square,fcnt);
ylim([0.7 1]);
grid on

barwithmark(rescale(mm),fcnt);
ylim([0.93 1]);
grid on