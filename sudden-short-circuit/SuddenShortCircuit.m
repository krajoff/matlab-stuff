close all
clear;

% Main path and data file
paths;

opt = options_u_0_1;
load(fullfile(pwd, 'data\mat', opt.name));

data = decreaseStep(data,opt); 
data = includeNil(data);

currentCalculation(data,opt);