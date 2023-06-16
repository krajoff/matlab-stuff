% ------------------------------------------------------------------------ 
% FFT analys with ampliture output 
% ------------------------------------------------------------------------
function [A, fv] = fftAmplitude(time, value)
    l = length(time);
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
end