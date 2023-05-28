function data = imdata(csvfile)
    %% Setup the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 5);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ";";

    % Specify column names and types
    opts.VariableNames = ["Rated", "DoubleAmp", "PhaseAmp", "Mass", "PhaseMass", "Complex", "CorrectMass", "CorrectPhase"];
    opts.VariableTypes = ["categorical", "double", "double", "double", "int16", "double", "int16", "int16"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    
% Specify variable properties
    opts = setvaropts(opts, "Rated", "EmptyFieldRule", "auto");
    opts = setvaropts(opts, ["DoubleAmp", "PhaseAmp", "Mass", "PhaseMass"], "DecimalSeparator", ",");


    % Import the data
    data = readtable(csvfile, opts);
end