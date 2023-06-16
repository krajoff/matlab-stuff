function opt = vibrationPull(opt)
    fprintf('Launch of vibration calculation\n');
    NameTable = opt.NameTable;
    folder = opt.folder;
    exfile = opt.exfile;
    PairSignal = opt.Pairs;
    sgn = 1;
    pathfile = @(x) char(fullfile(opt.GeneralFolder, folder(x)));
    tic
    for i = 1:length(NameTable)
        ref = sgn;
        for res = 1:PairSignal(i)
            % Return shaft vibration
            if contains(NameTable{i}, 'haft')
                opt.Channels{ref} = shAn(exfile, pathfile(ref), ...
                    opt, opt.OutlierFilter(i), char(folder(ref)), NaN);                      
                ref = ref+1;
            elseif contains(NameTable{i}, 'ore')
            % Return core vibration
               opt.Channels{ref} = scAn(exfile, pathfile(ref), opt, NaN);                         
               ref = ref+1;
            else
            % Return bearing vibration
                opt.Channels{ref} = vibrAn(exfile, pathfile(ref), opt, NaN);                      
                ref = ref+1;
            end
        end
        opt.(NameTable{i}) = join2table(opt.Channels(sgn:sgn+PairSignal(i)-1));  
        fprint(NameTable{i}, sgn, sgn+PairSignal(i)-1);
        sgn = sgn + PairSignal(i);
    end
    toc
    save([opt.StationHPP,'.mat'], 'opt');
end