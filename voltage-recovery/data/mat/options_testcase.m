function options = options_testcase()
    % Xd = 1.38; Xd' = 0.42; Xd'' = 0.28; 
    % Xq = 0.92; Xq' = 0.30; Xq'' = 0.18;
    % Td' = 3.0; Td'' = 0.1; Tq'' = 0.1;
    % Td0' = 9.86 ; Td0'' = 0.150;     
    % Data-file
    name = 'TestCase.mat';
    % Frequency [Hz]
    f = 50;
    % Amplitude of the established line voltage [V]
    uSteady = 11094;
    % Temporal discretization [s]
    disTime = 5e-4;
    % RMS value of the stator winding phase current {A}
    ik = 3964/sqrt(2);
    % Basic resistance [Ohm]
    zn = 15750/(sqrt(3)*7739);
    % Start time [s]
    startTime = 0.10; 
    startNumber = int32(startTime/disTime);
    % Duration time [s]
    durationTime = 10;
    % End time [s] End numbers [-]
    endTime = startTime + durationTime; 
    endNumber = int32(endTime/disTime);
    % Point interval 
    pointInt = (disTime*f)^-1;
    % Initial filter for raw signal "medfilt1"
    iFilter = 1;    
    % Filter for smoothness
    nFilter = 1;
    % Spline discretization [s]
    splineTime = 1e-3;
    % Cutting first sub-transient process
    cutPoints = int32(1/splineTime);
    % Type curve for analysis: 1 - spline, 2 - filtered spline
    noCurve = 1;
    % beta nil
    beta0 = [-0.1; uSteady; 0.1];
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
        'splineTime', splineTime, ...
        'noCurve', noCurve, ...
        'beta0', beta0);
end