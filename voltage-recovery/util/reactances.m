function out = reactances(out,opt)
    % Ñalculation of inductive reactances 
    divider = 6^0.5*opt.ik*opt.zn;
    out.xTran = (opt.uSteady-out.deltaUfun(0))/divider;
    out.xSubTran = out.voltage(1)/divider;

    % Ñalculation of time constants 
    out.tTran = -log((out.deltaUfun(0)/exp(1)-out.beta(1))...
        /out.beta(2))/out.beta(3);    
    [out.row, ~] = find(out.deltaUsub<=out.deltaUsub(1)/exp(1));
    out.tSubTran = out.time(out.row(1));
end