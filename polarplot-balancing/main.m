close all; clear; clc; setpath;
T = imdata('TupolangLower2_after.csv');
polarvibration(T)
speclimit(T.PhaseAmplitude)
%rlim([0.95*min(T.DoubleAmplitude) 1.05*max(T.DoubleAmplitude)])

polarweight(T)
speclimit(T.PhaseWeight)