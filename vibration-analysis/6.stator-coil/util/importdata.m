function [time, counter, base, signal, fs] = importdata(filepath, poles)
    data = readmatrix(fullfile(filepath));
    data = reducebyrotate(data,poles,6);
    time = data(:,1);
    counter = rescale(data(:,2));
    base = data(:,3) - mean(data(:,3));
    signal = data(:,4) - mean(data(:,4));
    fs = 1/mean(diff(time));
end