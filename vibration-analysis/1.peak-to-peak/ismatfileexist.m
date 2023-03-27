function opt = ismatfileexist(filename)
    if exist(filename, 'file') == 2
         opt = load(filename);
         opt = opt.opt;
    else 
        fprintf('File with calculated vibration of the Unit doesn''t exist \n');
    end    
end