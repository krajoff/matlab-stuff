function [amp, theta] = fromcomplex(z)
    amp = abs(z);
    theta = rad2deg(angle(z));
    fprintf('���������: %3.0f, ����: %3.0f', amp, theta);
end