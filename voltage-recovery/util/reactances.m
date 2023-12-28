function out = reactances(out,opt,title)
    % Ñalculation of inductive reactances 
    divider = 6^0.5*opt.ik*opt.zn;
    out.xTran = (opt.uSteady - out.deltaUfun(0))/divider;
    out.xSubTran = out.voltage(1)/divider;
    fprintf(title + ":\n");
    fprintf("Xd' = %.3f and Xd'' = %.3f;\n", out.xTran, out.xSubTran);

    % Ñalculation of time constants 
    out.tTran = -log((out.deltaUfun(0)/exp(1)-out.beta(1))...
        /out.beta(2))/out.beta(3);    
    [out.row, ~] = find(out.deltaUsub<=out.deltaUsub(1)/exp(1));
    out.tSubTran = out.time(out.row(1));
    fprintf("Td0' = %.2fs and Td0'' = %.3fs.\n", out.tTran, out.tSubTran);
end