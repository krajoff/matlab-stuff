function data = readCSV(filepath)
    data = readtable(filepath);
    variableName = {'Time', 'VoltageA', 'VoltageB', 'VoltageC', ...
        'CurrentA', 'CurrentB', 'CurrentC', 'CurrentC-Fluke'};
    data.Properties.VariableNames = variableName;
end