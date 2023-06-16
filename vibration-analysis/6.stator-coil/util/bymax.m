function data = bymax(data)
    if abs(min(data)) > abs(max(data))
        data = data/abs(min(data));
    else
        data = data/abs(max(data));
    end
end