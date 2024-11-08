function data = readCSV(filepath)
    data = readtable(filepath);
    variableName = {'Time', 'VoltageA', 'VoltageB', 'VoltageC', ...
        'CurrentA', 'CurrentB', 'CurrentC'};
    data.Properties.VariableNames = variableName;
end