function res = folderAndFileList(path, opt)
    if exist(opt, var) == false
        if exist(path, 'dir') == 7
            res = {dir(path).name};
            res = res(3:end);
        else
            error('Папки с данными не существует, необходимо проверить её наличие');
        end
    elseif opt == 'f'
        if exist(path, 'dir') == 7
            res = {dir(path).name};
            res = res(3:end);
            res = folderAndFileList(fullfile(path, res{1}), opt);
        else
            res = replace(path, dir(path).name, '');
        end 
    else
        error('Некорректно сформированный запрос по папкам и файлам');
    end
end