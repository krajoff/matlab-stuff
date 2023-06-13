function data = getflow(data)
    data = cumtrapz(data);
    data = data - mean(data);
    data = bymax(data);
end