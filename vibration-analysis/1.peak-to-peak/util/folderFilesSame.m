function res = folderFilesSame(path)
    fl = folderAndFileList(path);
    init = folderAndFileList(fullfile(path, fl{1}));
    for i = 2:length(fl)
        lst = folderAndFileList(fullfile(path, fl{i}));
        if ~isempty(setdiff(init, lst))
            warning(['Папки содержат различный массив файлов. ', ...
            'Ошибка вызвана сравнением файлов в папках: "%s" и "%s"'], fl{1}, fl{i});
        else
            res = init;
        end    
    end 
end    
