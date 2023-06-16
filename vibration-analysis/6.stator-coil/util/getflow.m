function data = getflow(data, ts, passbandfrequncy)
% Data integral (flux linkage integral - FLI) 
% with subtract the line from data
    data = cumtrapz(data);
    data = detrend(data, 1);
    if (passbandfrequncy > 0)
        lpfilter = designfilt('highpassiir', ...
            'FilterOrder', 4, ...
            'PassbandFrequency', passbandfrequncy, ...
            'PassbandRipple', 0.2, ...
            'SampleRate', 1/ts);
        data = filter(lpfilter, data);
    end
end