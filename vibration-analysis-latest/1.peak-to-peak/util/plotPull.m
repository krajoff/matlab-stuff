function plotPull(opt)
    NameTable = opt.NameTable;
    PairSignal = opt.Pairs;
    modes = opt.modes;
    sgn = 1; 
    for i = 1:length(NameTable)
        if contains(NameTable{i}, 'haft') 
           if PairSignal(i) == 2
               plotVibration(opt.Channels(sgn:sgn+1), ...
                   NameTable{i}, ...
                   opt.PlotLimit(i), ...
                   modes, ...
                   ''); 
               % opt.PlotLimit(i)/2 decreases maximum limit of 2A-plot
               plotNsquare({opt.Channels{sgn}(1:4,:), ...
                   opt.Channels{sgn+1}(1:4,:)},  ...
                   NameTable{i}, opt.PlotNsquare(i), ...
                   opt.NumberPoles, opt.RelativeFrequency);                                   
           else
               plotVibration(opt.Channels(sgn), ...
                   NameTable{i}, opt.PlotLimit(i), ...
                   modes, ''); 
               plotNsquare({opt.Channels{sng}(1:4,:)}, ...
                   NameTable{i}, opt.PlotNsquare(i), ...
                   opt.NumberPoles, opt.RelativeFrequency);
           end    
        elseif contains(NameTable{i}, 'ore')
               plotVibration(opt.Channels(sgn:sgn+PairSignal(i)-1),...
                   NameTable{i}, opt.PlotLimit(i), modes, '');
        else
           if PairSignal(i) == 2
               plotVibration(opt.Channels(sgn:sgn+1), ...
                   NameTable{i}, opt.PlotLimit(i), modes, '');
           end 
        end
    sgn = sgn + PairSignal(i);   
    end
end