clear all
clc

copyFolder = fullfile('D:\���������������\Matlab.vibration analysis\GA10');
% File DEWESoft name 
nameDewe = {'��� ���� �� ��'; '��� ���� �� ��'; ...
           '��� ���� �� ��'; '��� ���� �� ��'; ...
           '������������� �� ��_s'; '������������� �� ��_s'; ...
           '����� �� ��_s'; '����� �� ��_s'; ...
           '������������� ��_s'; '����� ����� ��_s'; ...
           '����� ���������_s'};
dbl = 88; % Number of poles
rtFreq = 100/dbl; % Rated frequency
nRev = 30; % Number of revolutions for analysis
tRange = nRev/rtFreq; 
% File DEWESoft folders
ratedScld = {'10 ���'; '20 ���'; '30 ���'; '40 ���'; '50 ���'; ...
            '60 ���'; '70 ���'; '80 ���'; '90 ���'; '100 ���'; ...
            '115 ���'; '120 ���'; '125 ���'; '��� 0,8'; '��� 0,9'; ...
            '��� 1,0'; '��� 1,1';'��� 0,8'; '��� 0,9';'��� 1,0'; ...
            '��� 1,1'};
n = length(dir(copyFolder)) - 2; 
if ~isequal(n, length(ratedScld))
   error('���������� ������������� ������� �� ��������� � ����������� ����� � �������')
end
for j = 1:size(ratedScld)
    n = length(dir(string(join([copyFolder '\' ratedScld(1)],"")))) - 2;
    if ~isequal(n, length(nameDewe))
        error(string(join(['� ����� ' copyFolder '\' ratedScld(1) ' ���������� ������ � ������� �� ��������� � ����������� ������������� ��������'], "")))
    end
    for i = 1:size(nameDewe)
        d = readmatrix(string(join([copyFolder '\' ratedScld(j) '\' nameDewe(i) '.csv'],"")));
        step = d(size(d,1),1)-d(size(d,1)-1,1);
        st_num = ceil(tRange/step);
        if st_num > size(d,1)
           error(string(join(['����� ����� ������ ' copyFolder '\' ratedScld(j) '\' nameDewe(i) '.csv ������ ��������� �������, ������������ ��� �������'],"")))
        end  
        dn = d(size(d,1)-st_num:size(d,1),:); 
        writematrix(dn, string(join([copyFolder '\' ratedScld(j) '\' nameDewe(i) '.csv'],"")));
    end
end