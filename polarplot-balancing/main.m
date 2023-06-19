close all; clear; clc; setpath;
T = imdata('TupolangLower2_after.csv');


polarpull(T)
ax = gca;
%rlim([0.95*min(T.DoubleAmp) 1.05*max(T.DoubleAmp)])
%thetalim([120 210])
