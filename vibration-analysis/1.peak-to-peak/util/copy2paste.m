copyFolder = fullfile('D:\Station_Test\DEWESoft\Zagorskaya\Data_copypaste\');
pasteFolder = fullfile('D:\Station_Test\DEWESoft\Zagorskaya\Data_copypaste\new\');
% File DEWESoft name
nameDewe = {'��� ���� �� ��'; '��� ���� �� ��'; ...
           '��� ���� �� ��'; '��� ���� �� ��'; ...
           '������������� �� ��_s'; '������������� �� ��_s'; ...
           '������������� �� ��_s'; '������������� �� ��_s'; ...
           '������������� ������ �������_s'; ...
           '������������� ����� ����������_s'; ...
           '��������� ��_s'; '���������_s'
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
   error('���������� ����� DEWESoft � �� ������������ �� �����')
end    
nf = length(nameDewe);
if ~isequal(nf, length(nameMat))
   error('����� �������� ������ DEWESoft � ����� �� �����')
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