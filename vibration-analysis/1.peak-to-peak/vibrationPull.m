function opt = vibrationPull(opt)
    fprintf('Launch of vibration calculation\n');
    NameTable = opt.NameTable;
    folder = opt.folder;
    exfile = opt.exfile;
    PairSignal = opt.Pairs;
    sgn = 1;
    pathfile = @(x) char(fullfile(opt.GeneralFolder, folder(x)));
    for i = 1:length(NameTable)
        if contains(NameTable{i}, 'haft') 
           if PairSignal(i) == 2
               opt.Channels{sgn} = shAn(exfile, pathfile(sgn), opt, opt.OutlierFilter(i));    % return shaft vibration for 1st direction
               opt.Channels{sgn+1} = shAn(exfile, pathfile(sgn+1), opt, opt.OutlierFilter(i));% return shaft vibration for 2nd direction
               opt.(NameTable{i}) = join2table({opt.Channels{sgn}, opt.Channels{sgn+1}});                     
           else
               opt.Channels{sgn} = shAn(exfile, pathfile(sgn), opt, opt.OutlierFilter(i));
               opt.(NameTable{i}) = opt.Channels{sgn};
           end
           fprintf('Shaft vibration calculation is done (%s, %d-%d signals) \n', NameTable{i}, sgn, sgn+PairSignal(i)-1);
        elseif contains(NameTable{i}, 'ore')
           ref = sgn; 
           for res = 1:PairSignal(i)
               opt.Channels{ref} = scAn(exfile, pathfile(ref), opt);                         % return core vibration for 1st direction
               ref = ref+1;
           end   
           opt.(NameTable{i}) = join2table(opt.Channels(sgn:sgn+PairSignal(i)-1));
           fprintf('Stator core vibration calculation is done (%s, %d-%d signals) \n', NameTable{i}, sgn, sgn+PairSignal(i)-1);
        else
           if PairSignal(i) == 2
               opt.Channels{sgn} = vibrAn(exfile, pathfile(sgn), opt);                        % return bearing vibration for 1st direction
               opt.Channels{sgn+1} = vibrAn(exfile, pathfile(sgn+1), opt);                    % return bearing vibration for 2nd direction
               opt.(NameTable{i}) = join2table({opt.Channels{sgn}, opt.Channels{sgn+1}});
           else
               opt.(NameTable{i}) = vibrAn(exfile, pathfile(sgn), opt);
               opt.Channels{sgn} = vibrAn(exfile, pathfile(sgn), opt);
           end
           if PairSignal(i) == 1
                fprintf('Vibration calculation is done (%s, %d signal) \n', NameTable{i}, sgn);
           else
                fprintf('Vibration calculation is done (%s, %d-%d signals) \n', NameTable{i}, sgn, sgn+PairSignal(i)-1);
           end    
        end
    sgn = sgn + PairSignal(i);
    end
    save([opt.StationHPP,'.mat'], 'opt');