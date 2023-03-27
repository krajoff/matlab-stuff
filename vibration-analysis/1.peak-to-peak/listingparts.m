%list = listing(fullfile(fileparts(pwd), '2.data'));
clear, clc
    path = fullfile(fileparts(pwd), '2.data'); 
    pathfile = @(x) char(fullfile(path, folder(x)));

% return list of folders
    if exist(path, 'dir') == 7
        rootfolders = {dir(path).name}; folders = folders(3:end);
        for i = 1:length(folders)
            
            for j = 1:length()
            folders{i,}
        end
    else
        error('There is no path with folders and data.') 
    end
    path1 = fullfile(path, folders{1}); 
    if exist(path1) == 7
        folders = {dir(path1).name}; folders = folders(3:end);
    else
        error('There is no path with folders and data.') 
    end
%}