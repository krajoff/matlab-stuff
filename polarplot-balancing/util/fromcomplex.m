function [amp, theta] = fromcomplex(z)
    amp = abs(z);
    theta = rad2deg(angle(z));
    fprintf('Амплитуда: %3.0f, фаза: %3.0f', amp, theta);
end