function plotPair(opt, exp)
    NameTable = opt.NameTable;
    PairSignal = opt.Pairs;
    modes = opt.modes;
    sgn = 1;
    n = length(NameTable);
    i = 1;
    Idxexp = 1;
    while i < n
        if (PairSignal(i) + PairSignal(i+1)) == 2
            plotVibration(opt.Channels(sgn:sgn+1), ...
                [NameTable{i}, ' and ' NameTable{i}], ...
                opt.PlotLimit(i), modes, exp{Idxexp});
            Idxexp = Idxexp + 1; i = i + 1; sgn = sgn + 1;   
        end
        sgn = sgn + PairSignal(i); i = i + 1;
    end