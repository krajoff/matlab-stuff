copyFolder = fullfile('D:\Station_Test\DEWESoft\Zagorskaya\Data_copypaste\');
pasteFolder = fullfile('D:\Station_Test\DEWESoft\Zagorskaya\Data_copypaste\new\');
% File DEWESoft name
nameDewe = {'Бой вала ГП ВБ'; 'Бой вала ГП ПБ'; ...
           'Бой вала ТП ВБ'; 'Бой вала ТП ПБ'; ...
           'Виброскорость ГП ВБ_s'; 'Виброскорость ГП ПБ_s'; ...
           'Виброскорость ТП ВБ_s'; 'Виброскорость ТП ПБ_s'; ...
           'Виброскорость крышка турбина_s'; ...
           'Виброскорость опора подпятника_s'; ...
           'Сердечник ВБ_s'; 'Сердечник_s'
           };
% File MatLab folders
nameMat = {'Generator shaft HR'; 'Generator shaft RB'; ...
           'Turbine shaft HR'; 'Turbine shaft RB'; ...
           'GB-HR'; 'GB-RB'; 'TB-HR'; 'TB-RB'; ...
           'Turbine cover'; 'Bearing support'; ...
           'Stator core HR'; 'Stator core RB' ...
          };
naming = table(nameDewe, nameMat);      
% File DEWESoft folders      
ratedScld = {'80%n'; '90%n'; '100%n'; '110%n'; ...
             '100%U'; ...
             '0MW'; '12MW'; '20MW'; '30MW'; '40MW'; ... 
             '50MW'; '60MW'};
for i=1:length(nameMat)        
    if ~exist(fullfile(pasteFolder, nameMat{i}), 'dir')
        mkdir(fullfile(pasteFolder, nameMat{i}))
    end  
end

listFolder = dir(copyFolder);          
n = length(listFolder) - 2; 
if ~isequal(n, length(ratedScld))
   error('Количество папок DEWESoft и их соответствий не равно')
end    
nf = length(nameDewe);
if ~isequal(nf, length(nameMat))
   error('Длины массивов данных DEWESoft и папок не равны')
end      

for k = 3:n+2
    nextFolder = fullfile(copyFolder, listFolder(k).name);    
    sourceFiles = dir(nextFolder);
    % Return a new file name
    for i = 1:n
        if ~isempty(strfind(listFolder(k).name, ratedScld{i}))
            endName = [ratedScld{i}, '.csv'];
        end    
    end
    for j = 3:nf+2
        copyFile = fullfile(nextFolder, sourceFiles(j).name);
        [filepath, jname, ext] = fileparts(copyFile);
        tf = strcmp(nameDewe, jname);
        pasteMat = nameMat{tf};
        pastePath = fullfile(pasteFolder, pasteMat, endName);
        copyfile(copyFile, pastePath, 'f');
    end    
end