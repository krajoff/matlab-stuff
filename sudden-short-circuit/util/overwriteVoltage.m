function out = overwriteVoltage(out,opt)
    time = out.timeSpline-out.timeSpline(1);
    switch opt.noCurve
        case 1
            voltage = out.valueSpline;
            legendspline = 'Spline (used)';
            legendfilteredspline = 'Filtered spline';
        case 2
            voltage = out.valueFiltered;
            legendspline = 'Spline';
            legendfilteredspline = 'Filtered spline (used)';            
        otherwise
            voltage = out.valueSpline;
            legendspline = 'Spline (used)';
            legendfilteredspline = 'Filtered spline';
    end
    deltaU = opt.uSteady - voltage;
    out.legendspline = legendspline;
    out.legendfilteredspline = legendfilteredspline;
    out.voltage = voltage;
    out.time = time;
    out.deltaU = deltaU;
end