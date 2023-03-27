clear all; clc; close all
%opt = ismatfileexist('UsHpp2.mat');


%% Initial data of modes and signals
list = listing(fullfile(fileparts(pwd), '2.data'));
%exfile = list{3};
[modes, exfile, folder, nametable, pairsignal] = ratedvalue(list);


%% Structure for generator parameters and launch calculation of vibration 
if exist('opt', 'var') == 0
    opt = struct('GeneralFolder', [fileparts(pwd) '\2.data'], ...
        'StationHPP', 'UsHpp2', ...
        'NumberFiles', length(exfile), ...
        'NumberPoles', 60, ...
        'RatedFrequency', 0, ...
        'RelativeFrequency', ones(length(exfile), 1), ...
        'NumberTurns', 16, ...
        'Pairs', pairsignal, ...
        'PlotLimit', [100, 300, 50, 80, 40, 150, 200], ...
        'PlotNsquare', [50, 200, 60, 80, 50, 200, 200], ...
        'OutlierFilter', zeros(length(pairsignal),1)', ...
        'Channels', [], ...
        'exfile', {exfile}, 'modes', {modes}, ...
        'folder', {folder}, 'NameTable', {nametable});    
    % Return NaN for structure 
    for i = 1:length(nametable)
        opt.(nametable{i}) = NaN; 
    end
    % Filtering signal from outlets: 1 is mode on, 0 is mode off
    opt.OutlierFilter = [1 1 0 0 0 0 1];                      
    % Rotational frequency
    opt.RatedFrequency = 100/opt.NumberPoles; 
    % Speed of rotation per unit for 1st, 2nd, 3rd and 4th
    opt.RelativeFrequency(1) = 0.80;
    opt.RelativeFrequency(2) = 0.90;
    opt.RelativeFrequency(3) = 1.00;
    opt.RelativeFrequency(4) = 1.10;
    % Launch calculation of vibration
    opt = vibrationPull(opt);
end


%% Plot pictures from opt-structure
% Function plotPull plot shaft vibration, bearing vibration and stator 
% core vibration from opt-structure. Exception: bearing support and turbine 
% cover, because pair signal = 1. Function plotPair plot such type of exception
plotPull(opt);     
plotPair(opt, {{'но','KT'}});