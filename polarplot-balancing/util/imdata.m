function data = imdata(csvfile)
    %% Setup the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 5);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ";";

    % Specify column names and types
    opts.VariableNames = ["Mode", "DoubleAmplitude", "PhaseAmplitude", ...
        "Weight", "PhaseWeight"];
    opts.VariableTypes = ["categorical", "double", "double", ...
        "double", "double"];
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % Specify variable properties
    opts = setvaropts(opts, "Mode", "EmptyFieldRule", "auto");
    opts = setvaropts(opts, ["DoubleAmplitude", "PhaseAmplitude", ...
        "Weight", "PhaseWeight"], "DecimalSeparator", ",");
    
    % Import the data
    data = readtable(csvfile, opts); 
    
    % data = addvars(data(:,1:3), table(, 'VariableNames', {'VDate'}) ];
    
    %["ComplexVibration", "CorrectMass", "CorrectPhase"];
    % Specify file level properties
    
    




    
end