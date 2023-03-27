clear all
clc

copyFolder = fullfile('D:\Гидрогенераторы\Matlab.vibration analysis\GA10');
% File DEWESoft name 
nameDewe = {'Бой вала ГП НБ'; 'Бой вала ГП ПБ'; ...
           'Бой вала ТП НБ'; 'Бой вала ТП ПБ'; ...
           'Виброскорость ГП НБ_s'; 'Виброскорость ГП ПБ_s'; ...
           'Вибро ТП НБ_s'; 'Вибро ТП ПБ_s'; ...
           'Виброскорость КТ_s'; 'Вибро Опора ПП_s'; ...
           'Вибро Сердечник_s'};
dbl = 88; % Number of poles
rtFreq = 100/dbl; % Rated frequency
nRev = 30; % Number of revolutions for analysis
tRange = nRev/rtFreq; 
% File DEWESoft folders
ratedScld = {'10 МВт'; '20 МВт'; '30 МВт'; '40 МВт'; '50 МВт'; ...
            '60 МВт'; '70 МВт'; '80 МВт'; '90 МВт'; '100 МВт'; ...
            '115 МВт'; '120 МВт'; '125 МВт'; 'ХХГ 0,8'; 'ХХГ 0,9'; ...
            'ХХГ 1,0'; 'ХХГ 1,1';'ХХТ 0,8'; 'ХХТ 0,9';'ХХТ 1,0'; ...
            'ХХТ 1,1'};
n = length(dir(copyFolder)) - 2; 
if ~isequal(n, length(ratedScld))
   error('Количество анализируемых режимов не совпадает с количеством папок с данными')
end
for j = 1:size(ratedScld)
    n = length(dir(string(join([copyFolder '\' ratedScld(1)],"")))) - 2;
    if ~isequal(n, length(nameDewe))
        error(string(join(['В папке ' copyFolder '\' ratedScld(1) ' количество файлов с данными не совпадает с количеством анализируемых сигналов'], "")))
    end
    for i = 1:size(nameDewe)
        d = readmatrix(string(join([copyFolder '\' ratedScld(j) '\' nameDewe(i) '.csv'],"")));
        step = d(size(d,1),1)-d(size(d,1)-1,1);
        st_num = ceil(tRange/step);
        if st_num > size(d,1)
           error(string(join(['Длина файла записи ' copyFolder '\' ratedScld(j) '\' nameDewe(i) '.csv меньше интервала времени, требующегося для анализа'],"")))
        end  
        dn = d(size(d,1)-st_num:size(d,1),:); 
        writematrix(dn, string(join([copyFolder '\' ratedScld(j) '\' nameDewe(i) '.csv'],"")));
    end
end