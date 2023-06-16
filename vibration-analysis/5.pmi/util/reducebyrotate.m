function data = reducebyrotate(data, poles, number)
    time = data(:,1);
    ts = mean(diff(time));
    period = number*poles/100/ts;
    data = data(1:int32(period),:);
end