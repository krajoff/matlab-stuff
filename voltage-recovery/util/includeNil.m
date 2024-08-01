function data = includeNil(data)
    data.s = data.VoltageA+data.VoltageB+data.VoltageC;
    data.VoltageA = data.VoltageA-data.s/3;
    data.VoltageB = data.VoltageB-data.s/3;
    data.VoltageC = data.VoltageC-data.s/3;
end