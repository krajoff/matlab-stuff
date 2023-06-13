function data = getflow(data)
    data = cumtrapz(data);
    data = data - mean(data);
    %data = rescale(data, -1, 1);
end