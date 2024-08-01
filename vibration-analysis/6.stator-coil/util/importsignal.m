function [time, counter, signal, fs] = importsignal(filepath, poles)
    data = readmatrix(fullfile(filepath));
    data = reducebyrotate(data,poles,6);
    time = data(:,1);
    counter = rescale(data(:,2));
    signal = data(:,3) - mean(data(:,3));
    fs = 1/mean(diff(time));
end