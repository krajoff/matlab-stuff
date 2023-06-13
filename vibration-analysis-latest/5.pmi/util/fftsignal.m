function [fv, A, phase, Y] = fftsignal(time, data, k)
[time, data] = modbytwo(time, data);
l = length(data);
ts = mean(diff(time));
fs = 1/ts;
fn = fs/2;
fv = linspace(0, 1, fix(l/2)+1)*fn;
Iv = 1:length(fv);
A = zeros(l/2+1, 0);
Y = fft(data)/l;
A = [A 2*abs(Y(Iv))];
phase = angle(Y);
if k == 1
    figure('Name', 'Single-Sided Amplitude Spectrum', ...
        'Position', [50, 50, 1150, 700])      
else
    hold on
end
plot(fv, A, '-', 'LineWidth' , 1.5) 
title('Single-Sided Amplitude Spectrum')
xlim([0 100])
xlabel('f (Hz)')
ylabel('A')
end