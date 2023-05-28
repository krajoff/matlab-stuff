close all; clear; clc;
addpath(fullfile(pwd, '\util')); addpath(fullfile(pwd, '\data'));
T = imdata('TupolangLower2_after.csv');

T.Complex = T.DoubleAmp.*exp(1j*deg2rad(T.PhaseAmp));
%[T.x, T.y] = pol2cart(deg2rad(T.PhaseAmp),T.DoubleAmp);
Categories = unique(T.Rated);
list = regexprep(string(Categories),'[0-9+-/%.]','');

for i=1:length(Categories)
    var = T(T.Rated == Categories(i), :);
    polarfun(var.Complex);
    addtext(var, char(list(i)));
    for j = 1:height(T)
        if T.Rated(j) == Categories(i) && T.Mass(j) ~= 0      
            [T.CorrectMass(j), T.CorrectPhase(j)] = ...
                m_a(var.Complex(1), T.Complex(j), T.Mass(j));
        end
    end
end



ax = gca;
%rlim([0.95*min(T.DoubleAmp) 1.05*max(T.DoubleAmp)])
thetalim([120 210])