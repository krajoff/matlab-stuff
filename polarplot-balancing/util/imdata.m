function data = imdata(csvfile)
    %% Setup the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 5);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ";";

    % Specify column names and types
    opts.VariableNames = ["Mode", "DoubleAmplitude", "PhaseAmplitude", ...
        "Weight", "PhaseWeight", ...
        "ComplexVibration", "ComplexWeight", ...
        "CorrectWeight", "CorrectPhase", "ComplexCorrectWeight"];
    opts.VariableTypes = ["categorical", repelem("double", ...
        length(opts.VariableNames)-1)];
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % Specify variable properties
    opts = setvaropts(opts, "Mode", "EmptyFieldRule", "auto");
    opts = setvaropts(opts, ["DoubleAmplitude", "PhaseAmplitude", ...
        "Weight", "PhaseWeight"], "DecimalSeparator", ",");
    
    % Import the data
    data = readtable(csvfile, opts); 
    data = movevars(data, 'ComplexVibration', 'After', 'PhaseAmplitude');
    data = movevars(data, 'ComplexWeight', 'After', 'PhaseWeight');
    
    % Add complex values of vibration and weight
    data.ComplexVibration = getcomplex(data.DoubleAmplitude, ...
        data.PhaseAmplitude);
    data.ComplexWeight = getcomplex(data.Weight, data.PhaseWeight);
end