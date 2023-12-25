function options = options_i100A()
    % Data-file
    name = 'VR_i100A.mat';
    % Frequency [Hz]
    f = 50;
    % Amplitude of the established line voltage [V]
    uSteady = 4236;
    % Temporal discretization [s]
    disTime = 1e-4;
    % RMS value of the stator winding phase current {A}
    ik = 1290*2^-0.5;
    % Basic resistance [Ohm]
    zn = 10500/(3^0.5*5077);
    % Start time [s]
    startTime = 16.446; 
    startNumber = int32(startTime/disTime);
    % Duration time [s]
    durationTime = 10;
    % End time [s]
    endTime = startTime + durationTime; 
    endNumber = int32(endTime/disTime);
    % Point interval 
    pointInt = (disTime*f)^-1;
    % Cutting first sub-transient process
    cutPoints = 25;
    % nth-order one-dimensional median filter
    iFilter = 10;
    % nth-order one-dimensional median filter
    nFilter = .02;
    % Spline discretization [s]
    splineTime = 1e-3;
    options = struct('name', name, ...
        'f', f, ...
        'uSteady', uSteady, ...
        'ik', ik, ...
        'zn', zn, ...
        'startTime', startTime, ...
        'startNumber', startNumber, ...
        'durationTime', durationTime, ...
        'disTime', disTime, ...
        'endTime', endTime, ...
        'endNumber', endNumber, ...
        'pointInt', pointInt, ...
        'iFilter', iFilter, ...
        'nFilter', nFilter, ...
        'cutPoints', cutPoints, ...
        'splineTime', splineTime);
end