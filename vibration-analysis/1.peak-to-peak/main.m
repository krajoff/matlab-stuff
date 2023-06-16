close all
%clear all; clc; 
addpath(fullfile(pwd, 'util'));
%loadStruct('UsHpp2.mat');
%% Initial data of modes and signals
[modes, exfile, folder, nameTable, PairSignal] = ratedValues();

%% Structure for generator parameters and launch calculation of vibration 
generalFolder = fullfile(fileparts(pwd), '\2.data');
%nameTable = folderAndFileList(generalFolder);
%dataFiles = filesOrder(folderAndFileList(generalFolder, 'f'), ['n', 'U', 'MW']);
modes = filename2mode(exfile);

if messageButton(logical(exist('opt', 'var')))
    opt = struct('GeneralFolder', generalFolder, ...
        'StationHPP', 'UsHpp2', ...
        'NumberFiles', length(exfile), ...
        'NumberPoles', 60, ...
        'RatedFrequency', 0, ...
        'RelativeFrequency', ones(length(exfile), 1), ...
        'NumberTurns', 16, ...
        'Pairs', PairSignal, ...
        'PlotLimit', [100, 300, 50, 80, 40, 150, 200], ...
        'PlotNsquare', [50, 200, 60, 80, 50, 200, 200], ...
        'OutlierFilter', zeros(length(PairSignal),1)', ...
        'Channels', [], ...
        'exfile', {exfile}, 'modes', {modes}, ...
        'folder', {folder}, 'NameTable', {nameTable});    
    % Return NaN for structure 
    for i = 1:length(nameTable)
        opt.(nameTable{i}) = 0; 
    end
    % Filtering signal from outlets: 
    % more than 1 is value of medfilt1, 0 is no filtering
    opt.OutlierFilter = [20 100 0 0 0 0 20];                      
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
plotPair(opt, {{'ฮฯ','สา'}});