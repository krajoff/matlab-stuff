function loadStruct(filename) 
    if isfile(filename)
        filename = load(filename);
        assignin('base', 'opt', filename.opt); 
    else 
        fprintf(['File with calculated vibration' ... 
            'of the Unit doesn''t exist \n']);
    end
end