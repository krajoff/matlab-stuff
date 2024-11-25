function options = options_u_0_2()
    % Data-file
    name = 'SSC_u_0_2.mat';
    % Rogowski coil ratio at 50 Hz [A/V]
    coilRatio = 1;
    % Time column name
    time = 'Time';
    % Currents columns names. It is raw signal from coils [V]
    current = ["CurrentA"; "CurrentB"; "CurrentC"];
    % Stator current coefficient.
    currentRatio = [-1, -1, -1];    
    % Is integration of the raw signal necessary?
    isRogowski = true;
    % Rated frequency [Hz]
    f = 50;
    % Rated stator current [A]
    I = 8625;
    % Rated stator voltage [V]
    U = 15750; 
    % Amplitude of the established phase current [A]
    iSteady = 20;
    % Temporal discretization [s] (0 is no changes of discretization)
    disTime = 10^-4;
    % RMS value of the stator winding line voltage {V}
    u0 = 50*2^-0.5;
    % Basic resistance [Ohm]
    zn = U/(3^0.5*I);
    % Time interval for analysis [s]
    timeSpan = [1 5];
    % Sudden short circuit time start [s]
    timeStart = 0.5;
    % Filter for smoothness
    nFilter = .01;
    % Type curve for analysis: 1 - spline, 2 - filtered spline
    noCurve = 1;
    % beta nil
    beta0 = [-0.1; iSteady; 0.1];
    % Spline discretization [s]
    splineTime = 1e-3;
    % Points per period [-]
    ppp = int32(1/(disTime*f));
    % Cutting first sub-transient process
    cutPoints = int32(1/splineTime);        
    % Load data from file
    data = load(name); fieldNames = fieldnames(data); data = data.(fieldNames{1});
    options = struct('name', name, ...
        'coilRatio', coilRatio, ...
        'time', time, ...
        'current', current, ...
        'currentRatio', currentRatio, ...
        'isRogowski', isRogowski, ... 
        'f', f, 'iSteady', iSteady, ...
        'u0', u0, 'zn', zn, ...
        'timeSpan', timeSpan, ...
        'timeStart', timeStart, ...
        'disTime', disTime, ...
        'ppp', ppp, ...
        'nFilter', nFilter, ...
        'cutPoints', cutPoints, ...
        'splineTime', splineTime, ...
        'noCurve', noCurve, ...
        'beta0', beta0, ...
        'data', data);
end